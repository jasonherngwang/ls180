-- Question 1. Insert some data into a table
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (9, 'Spa', 20, 30, 100000, 800);


-- Question 2. Insert multiple rows of data into a table
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES (9, 'Spa', 20, 30, 100000, 800),
       (10, 'Squash Court 2', 3.5, 17.5, 5000, 80);

-- Using SELECT instead of VALUES
-- UNION ALL doesn't remove duplicates, which is what we want.
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
SELECT 9, 'Spa', 20, 30, 100000, 800
 UNION ALL
SELECT 10, 'Squash Court 2', 3.5, 17.5, 5000, 80;


-- Question 3. Insert calculated data into a table (facid is NOT a serial data type)
INSERT INTO cd.facilities (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
VALUES ((SELECT max(facid) FROM cd.facilities) + 1, 'Spa', 20, 30, 100000, 800);

-- Question 4. Update some existing data
UPDATE cd.facilities
   SET initialoutlay = 10000
 WHERE name = 'Tennis Court 2';

-- Question 5. Update multiple rows and columns at the same time
-- We can set multiple columns in the same statement. Only use SET once.
UPDATE cd.facilities
   SET membercost = 6,
       guestcost = 30
 WHERE name LIKE 'Tennis Court%';

-- Question 6. Update a row based on the contents of another row
UPDATE cd.facilities
   SET membercost = (SELECT membercost * 1.1
					   FROM cd.facilities
					  WHERE facid = 0
					),
       guestcost = (SELECT guestcost * 1.1
					  FROM cd.facilities
					 WHERE facid = 0
				   )
WHERE facid = 1;

UPDATE cd.facilities f
   SET membercost = f_updated.membercost * 1.1,
       guestcost = f_updated.guestcost * 1.1
  FROM (SELECT * FROM cd.facilities WHERE facid = 0) f_updated
 WHERE f.facid = 1;

-- Question 7. Delete all bookings
DELETE FROM cd.bookings;

-- Question 8. Delete a member from the cd.members table
DELETE FROM cd.members
 WHERE memid = 37;

-- Question 9. Delete based on a subquery
DELETE FROM cd.members
 WHERE memid IN (
           SELECT m.memid
		     FROM cd.members m
             LEFT JOIN cd.bookings b
               ON m.memid = b.memid
            WHERE b.memid IS NULL
       );

DELETE FROM cd.members
 WHERE memid NOT IN (SELECT memid
		               FROM cd.bookings
                    );