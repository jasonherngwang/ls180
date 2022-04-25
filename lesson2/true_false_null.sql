DROP TABLE IF EXISTS test1;

/* make the table and values*/
CREATE TABLE test1 (
    a boolean,
    b text
);

INSERT INTO test1
VALUES (TRUE, 'I am true'),
       (FALSE, 'I am false'),
       (NULL, 'I am null');

TABLE test1;

-- True
SELECT * 
FROM test1
WHERE a = 'true'; 

-- Not True
SELECT *
  FROM test1
 WHERE a != 'true';