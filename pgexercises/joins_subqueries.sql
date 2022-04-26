-- 1. Retrieve the start times of members' bookings
SELECT starttime
  FROM cd.bookings b
  JOIN cd.members m
    ON b.memid = m.memid
 WHERE m.firstname = 'David'
   AND m.surname = 'Farrell'
;
-- Subquery approach
SELECT starttime
  FROM cd.bookings
 WHERE memid = (SELECT memid
                  FROM cd.members
                 WHERE firstname = 'David'
                   AND surname = 'Farrell'
               );
               
-- 2. Work out the start times of bookings for tennis courts
SELECT b.starttime AS start,
       f.name AS name
  FROM cd.bookings b
  JOIN cd.facilities f
    ON b.facid = f.facid
 WHERE date_trunc('day', b.starttime) = '2012-09-21'
   AND f.name LIKE 'Tennis Court%'
 ORDER BY start, f.name;
 
-- 3. Produce a list of all members who have recommended another member (self join)
-- rec is recommenders; m is recommendees
SELECT DISTINCT rec.firstname,
                rec.surname
  FROM cd.members rec
  JOIN cd.members m
    ON m.recommendedby = rec.memid
 ORDER BY rec.surname,
          rec.firstname;
          
-- 4. Produce a list of all members, along with their recommender
SELECT m.firstname   AS memfname,
       m.surname     AS memsname,
       rec.firstname AS recfname,
       rec.surname   AS recsname
  FROM cd.members m
  LEFT JOIN cd.members rec
    ON m.recommendedby = rec.memid
 ORDER BY m.surname,
          m.firstname;
  
-- 5. Produce a list of all members who have used a tennis court
SELECT DISTINCT
       m.firstname || ' ' || m.surname AS member,
       f.name AS facility
  FROM cd.members m
  JOIN cd.bookings b
    ON m.memid = b.memid
  JOIN cd.facilities f
    ON b.facid = f.facid
 WHERE f.name LIKE 'Tennis Court%'
 ORDER BY member, facility;
 
-- 6. Produce a list of costly bookings
SELECT m.firstname || ' ' || m.surname AS member,
       f.name AS facility,
       CASE m.firstname || ' ' || m.surname
       WHEN 'GUEST GUEST' THEN f.guestcost
       ELSE f.membercost
       END * b.slots AS cost
  FROM cd.members m
  JOIN cd.bookings b
    ON m.memid = b.memid
  JOIN cd.facilities f
    ON b.facid = f.facid
 WHERE CASE m.firstname || ' ' || m.surname
       WHEN 'GUEST GUEST' THEN f.guestcost
       ELSE f.membercost
       END * b.slots > 30
   AND date_trunc('day', b.starttime) = '2012-09-14'
 ORDER BY cost DESC;