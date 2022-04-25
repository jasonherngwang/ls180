# Question 1
SQL consists of 3 different sublanguages. For example, one of these sublanguages is called the Data Control Language (DCL) component of SQL. It is used to control access to a database; it is responsible for defining the rights and roles granted to individual users. Common SQL DCL statements include:

```sql
GRANT
REVOKE
```

Name and define the remaining 2 sublanguages, and give at least 2 examples of each.

**Data Definition Language (DDL):** Used to define the structure of a database (its schema), including its tables, columns, data types, and constraints.

- Creating (`CREATE`), renaming, altering (`ALTER`), and dropping (`DROP`) tables and columns.

**Data Manipulation Language (DML):** Used to retrieve or modify data stored in a database.

- Performing **CRUD** operations on data:
    - Create: `INSERT` rows into a table.
    - Read: `SELECT` data from a table.
    - Update: `UPDATE` values in specific rows and columns.
    - Delete: `DELETE` rows from a table.

# Question 2
Does the following statement use the Data Definition Language (DDL) or the Data Manipulation Language (DML) component of SQL?
```sql
SELECT column_name FROM my_table;
```

DML. The `SELECT` statement is used to retrieve data from a database.

# Question 3
Does the following statement use the DDL or DML component of SQL?
```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```

DDL. This statement is involved with defining the structure of a database.

# Question 4
Does the following statement use the DDL or DML component of SQL?
```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```

DDL. This statement modifies a constraint, which is part of the database structure.

# Question 5
Does the following statement use the DDL or DML component of SQL?
```sql
INSERT INTO things VALUES (3, 'Scissors', 'Metal');
```

DML. This statement adds data by inserting it into a tables. Data manipulation is the purpose of DML.

# Question 6
Does the following statement use the DDL or DML component of SQL?
```sql
UPDATE things
SET material = 'plastic'
WHERE item = 'Cup';
```

DML. This statement is modifying specific data in a table, based on a conditional expression. Data manipulation is performed with the DML sublanguage.

# Question 7
Does the following statement use the DDL, DML, or DCL component of SQL?
```bash
\d things
```

None. This is a `psql` meta-command, not a SQL statement. It is used to print a description of a table.

# Question 8
Does the following statement use the DDL or DML component of SQL?
```sql
DELETE FROM things WHERE item = 'Cup';
```

DML. This statement is deleting rows of data from a table, based on a conditional expression. Data manipulation is performed with the DML sublanguage.

# Question 9
Does the following statement use the DDL or DML component of SQL?
```sql
DROP DATABASE xyzzy;
```

DDL. This statement modifies data structure by deleting an entire database. This operation primarily manipulates data structure.

# Question 10
Does the following statement use the DDL or DML component of SQL?
```sql
CREATE SEQUENCE part_number_sequence;
```

DDL. A sequence is a way of defining data.