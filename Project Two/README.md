# Data 3402: Project 2: Databases

For this project, you will begin to build a database to store the MLB data you acquired in Project 1.
In Part 1, you will create a SQLite version of the Lahman Database, which you downloaded in CSV format previously.  In Part 2, you will write several SQL queries to extract some information from the database.



## 1. The Lahman Database: Creating the schema and loading the data. (65% of the project grade) 
In Project 1, you should have created a directory called `Lahman`.  Inside this directory, you should have a directory called `core` which contains 27 csv files.


### Step 1:
Create a SQLite database called `Baseball.db`.  
### Step 2:
Inside `Baseball.db`, create one table for each csv file.
1. Each table should be named `Lahman_<table>` where `<table>.csv` is the corresponding csv file.


2. Use appropriate datatypes for each column.  **Do not simply give each column the TEXT datatype.** Columns that hold integers should have INTEGER type and so forth


3. Appropriately define primary and foreign keys on the tables.  The tables `Lahman_Parks`, `Lahman_People`, `Lahman_Schools`, `Lahman_Teams`, and `Lahman_TeamsFranchises` should be the only tables that need primary keys defined, but most (if not all) of the others should have foreign keys defined that reference these primary keys.
    - Keep in mind that primary keys can consist of multiple columns. Several of the tables listed above will require composite primary keys.
    - Composite foreign keys are also allowed. You can reference a composite primary key with a composite foreign key.

You should have a single `.sql` file that can be executed to create all of the tables.

### Step 3:
Load the data.  Keep in mind that if a table has a foreign key, the table that the foreign key references must be loaded first.




# 2. Querying the Lahman Database. (35% of the project grade)
For this part, write your SQL queries that answer each question in the code cell provided.  Do not try to run them though, since I have not found an easy way to execute SQL queries in Jupyter.  Do not put your solution queries in a .sql file.

Descriptions of the tables and columns can be found [here](http://www.seanlahman.com/files/database/readme2017.txt)