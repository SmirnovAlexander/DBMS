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

[Oracle objects slides](slides/03_OracleObjects.pdf)

- [2.1]()

    - take a look at system views
    - detect number of available tables
    - print content of a table that exists in `ALL_TABLES`, but not exists in `USER_TABLES`

- [2.2]()

    - take a look at system view integrity rules, count them
    - add integrity rule that limits salary; make sure it exists in system view; write query to show name of this rule
    - delete this integrity rule
    - add integrity rule with explicit naming; make sure it exists in system view

- [2.3]()

    - take a look at content of views that are connected with indexes in their scheme
    - count number of indexes in scheme
    - create index-organized table `DEPT1` (same as `DEPT`); fill content with `DEPT` table
