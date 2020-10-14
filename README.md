# DBMS Application Development

Tasks for [DBMS Application Development course](slides/).

Below listed all tasks with links and descriptions.

## Homework 1. 
19.09.20

[Introduction slides](slides/01_Introduction.pdf)

[Oracle Application Express slides](slides/02_OracleApplicationExpress.pdf)

- [1.1](TablesObservation/ERD/ERD.pdf)

    - create `Oracle Apex` workspace
    - load `EMP / DEMP` tables
    - draw ER-diagram

- [1.2](TablesObservation/tables_observation.sql)

    Make data observation via `SQL`:
    - explore tables structure via `Object Browser`
    - show jobs of employees
    - number of employees per department
        - average salary per job
    - min and max salary per job
        - summary salary per department
    - form every possible manager pairs

## Homework 2. 
26.09.20

[Oracle objects slides](slides/03_OracleObjects_1.pdf)

- [2.1](ObjectViews/object_views_1.sql)

    - take a look at system views
    - detect number of available tables
    - print content of a table that exists in `ALL_TABLES`, but not exists in `USER_TABLES`

- [2.2](ObjectViews/object_views_1.sql)

    - take a look at system view integrity rules, count them
    - add integrity rule that limits salary; make sure it exists in system view; write query to show name of this rule
    - delete this integrity rule
    - add integrity rule with explicit naming; make sure it exists in system view

- [2.3](ObjectViews/object_views_1.sql)

    - take a look at content of views that are connected with indexes in their scheme
    - count number of indexes in scheme
    - create index-organized table `DEPT1` (same as `DEPT`); fill content with `DEPT` table

## Homework 3. 
03.10.20

[Oracle objects slides](slides/04_OracleObjects_2.pdf)

- [3.1](ObjectViews/object_views_2.sql)

    Create views:
    - numbers and names of workers who was applied at winter
    - name of workers that are managers of at least than 3 others

    Take a look at these views.

- [3.2](ObjectViews/object_views_2.sql)

    - create sequence for table `DEPT1` with `CASH=20`
    - generate 10 values with this sequence (fill table `DEPT1`)
    - make sure it fills as you expected
    - find this sequence in system views

 - [3.3](ObjectViews/object_views_2.sql)

    - create and execute stored procedure that calculates factorial 
    - create and execute procedure that accepts employee number and returns number of days he worked

 - [3.4](ObjectViews/object_views_2.sql)
    
    Create stored procedure that returns statistics about employees and departments
        - number of employees 
        - number of departments
        - number of various jobs
        - summary salary

    For outputing use package `dbms_output`

 - [3.5](ObjectViews/object_views_2.sql)

    - create table `debug_log` and appropriate sequence
    - create and execute procedure that returns hire date of worker that work more that others; hire date of worker that work least of all; result of procedure write to `debug_log` 
    - view entries of `debug_log` after procedure execution

 - [3.6](ObjectViews/object_views_2.sql)

    - create procedure to track dynamical errors
    - create function or procedure that may lead to dynamical error
    - execute appearence and track of 3 dynamical errors in `debug_log`

## Homework 4. 
10.10.20

[Triggers slides](slides/05_Triggers.pdf)

- [4.1](Triggers/triggers.sql)

    - create trigger that automatically generate values for table (use sequence)
    - create trigger that automatically generate values for table (without sequence)
    - create trigger that writes in journal events of creating, changing and deleting tables, views and sequences
        - type of event
        - object name
        - time
        - etc
    - show triggers using system views

- [4.2](Triggers/triggers.sql)

    - create and fill tables using triggers
    - create journal and write logs to journal

## Homework 5. 
17.10.20

[Apps creations slides](slides/06_AppsCreation.pdf)

- [5.1]()

    Create Oracle app that contains all patterns:
    - tables report
    - interactive grid
    - master detail
    - master detail by self-referenced integrity rules
    - charts
    - tree pages
    - procedure invoke
    Choose sample database (`SQL Workshop` -> `Utilities` -> `Sample Datasets`)
