-- Question 1. Count the number of facilities
SELECT count(*)
  FROM cd.facilities;

-- Question 2. Count the number of expensive facilities
SELECT count(*)
  FROM cd.facilities
 WHERE guestcost >= 10;

-- Question 3. Count the number of recommendations each member makes.
SELECT r.memid, count(r.memid)
  FROM cd.members r
  JOIN cd.members m
    ON r.memid = m.recommendedby
 GROUP BY r.memid
 ORDER BY r.memid;

-- Without JOIN
 SELECT recommendedby, count(*)
  FROM cd.members
 WHERE recommendedby IS NOT NULL
 GROUP BY recommendedby
 ORDER BY recommendedby;

-- Question 4. List the total slots booked per facility
SELECT facid,
       sum(slots) AS "Total Slots"
  FROM cd.bookings
 GROUP BY facid
 ORDER BY facid;

-- Question 5. List the total slots booked per facility in a given month
SELECT facid,
       sum(slots) as "Total Slots"
  FROM cd.bookings
 WHERE date_trunc('month', starttime) = '2012-09-01'
 GROUP BY facid
 ORDER BY "Total Slots";

-- Question 6. List the total slots booked per facility per month
SELECT facid,
       date_part('month', starttime) AS month,
       sum(slots) as "Total Slots"
  FROM cd.bookings
 WHERE starttime >= '2012-01-01'
   AND starttime <  '2013-01-01'
 GROUP BY facid, month
 ORDER BY facid, month;

-- Question 7. Find the count of members who have made at least one booking
SELECT count(DISTINCT memid)
  FROM cd.bookings;

-- Question 8. List facilities with more than 1000 slots booked
SELECT facid, "Total Slots"
  FROM (SELECT facid,
		       sum(slots) AS "Total Slots"
		  FROM cd.bookings
		 GROUP BY facid
	   ) AS total_slots
 WHERE "Total Slots" > 1000
 ORDER BY facid

 SELECT facid,
       sum(slots) AS "Total Slots"		       
  FROM cd.bookings
 GROUP BY facid
HAVING sum(slots) > 1000
 ORDER BY facid;

-- Question 9. Find the total revenue of each facility
SELECT f.name,
       sum(CASE WHEN b.memid = 0
	            THEN f.guestcost * b.slots
		 	        ELSE f.membercost * b.slots
	         END) AS revenue
  FROM cd.facilities f
  JOIN cd.bookings b
    ON b.facid = f.facid
 GROUP BY f.name
 ORDER BY revenue;

-- Question 10. Find facilities with a total revenue less than 1000
-- Question 11. Output the facility id that has the highest number of slots booked
-- Question 12. List the total slots booked per facility per month, part 2
-- Question 13. List the total hours booked per named facility
-- Question 14. List each member's first booking after September 1st 2012
-- Question 15. Produce a list of member names, with each row containing the total member count
-- Question 16. Produce a numbered list of members
-- Question 17. Output the facility id that has the highest number of slots booked, again
-- Question 18. Rank members by (rounded) hours used
-- Question 19. Find the top three revenue generating facilities
-- Question 20. Classify facilities by value
-- Question 21. Calculate the payback time for each facility
-- Question 22. Calculate a rolling average of total revenue