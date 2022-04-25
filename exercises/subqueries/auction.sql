-- Auction

-- Setup

DROP DATABASE IF EXISTS auction;
CREATE DATABASE auction;

\c auction

CREATE TABLE bidders (
    id   serial PRIMARY KEY,
    name text   NOT NULL
);

CREATE TABLE items (
    id            serial        PRIMARY KEY,
    name          text          NOT NULL,
    initial_price numeric(6, 2) NOT NULL
                                CHECK (initial_price BETWEEN 0.01 AND 1000.00),
    sales_price   numeric(6, 2) CHECK (sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
    id        serial        PRIMARY KEY,
    bidder_id integer       NOT NULL
                            REFERENCES bidders (id)
                            ON DELETE CASCADE,
    item_id   integer       NOT NULL
                            REFERENCES items (id)
                            ON DELETE CASCADE,
    amount    numeric(6, 2) NOT NULL
                            CHECK (amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

-- \d bidders
-- \d items
-- \d bids

\copy bidders FROM 'bidders.csv' WITH HEADER CSV
\copy items   FROM 'items.csv'   WITH HEADER CSV
\copy bids    FROM 'bids.csv'    WITH HEADER CSV

TABLE bidders;
TABLE items;
TABLE bids;


-- Subquery IN
-- DISTINCT has a greater impact on larger data sets, since we have less to search through.
SELECT name AS "Bid on Items"
  FROM items
 WHERE id IN (
           SELECT DISTINCT item_id
             FROM bids
       )
;


-- Subquery NOT IN
SELECT name AS "Not Bid On"
  FROM items
 WHERE id NOT IN (
           SELECT DISTINCT item_id
             FROM bids 
       )
;


-- Subquery EXISTS
SELECT name
  FROM bidders
 WHERE EXISTS (
           SELECT 1
             FROM bids
            WHERE bids.bidder_id = bidders.id
       )
;

SELECT DISTINCT name
  FROM bidders
  JOIN bids
    ON bidders.id = bids.bidder_id;


-- Query From a Virtual Table
SELECT max(bid_counts.count)
  FROM (SELECT count(bidder_id)
          FROM bids
         GROUP BY bids.bidder_id
       ) AS bid_counts
;


-- Scalar Subqueries
SELECT name,
       (SELECT count(item_id)
          FROM bids
         WHERE items.id = item_id
       )
  FROM items;

SELECT i.name,
       count(b.id)
  FROM items i
  LEFT JOIN bids b
    ON i.id = b.item_id
 GROUP BY i.id
 ORDER BY i.id;


-- Row Comparison
-- EXPLAIN ANALYZE
SELECT * 
  FROM (
       SELECT *
         FROM (
              SELECT *
                FROM items
               WHERE sales_price = 250.00
              ) AS match_sales_price
        WHERE initial_price = 100.00
       ) AS match_initial_price
 WHERE name = 'Painting'
;

-- EXPLAIN ANALYZE
SELECT *
  FROM items
 WHERE ROW ('Painting', 100.00, 250.00) = 
       ROW (name, initial_price, sales_price);


-- EXPLAIN
-- EXPLAIN
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- EXPLAIN ANALYZE
SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

-- Comparing SQL Statements
/*
Subquery has higher startup and total cost and higher planning and execution times.
*/

EXPLAIN ANALYZE
SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

EXPLAIN ANALYZE
SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

