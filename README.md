# DBMS Application Development

Tasks for [DBMS Application Development course](slides/).

Useful links:
- [slides sources](https://drive.google.com/drive/folders/1QRcHpSgb1nvePGEDfoD9RmxYP03UMBRE)
- [completed tasks](https://docs.google.com/spreadsheets/d/1_HDblhT8c0wPTkMDAE8hG0gVNkPNG8oYE1J0k0_NETE/edit#gid=0)

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
    - execute appearance and track of 3 dynamical errors in `debug_log`

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

- [5.1](https://apex.oracle.com/pls/apex/furiousteabag/r/customer-orders/)

    Create Oracle app that contains all patterns:
    - tables report
    - interactive grid
    - master detail
    - master detail by self-referenced integrity rules
    - charts
    - tree pages
    - procedure invoke
    Choose sample database (`SQL Workshop` -> `Utilities` -> `Sample Datasets`)

    Supporting script provided [here](AppsBuilding/support_objects.sql)

## Homework 6. 
31.10.20

[Authorization slides](slides/07_AuthorizationAuthentication.pdf)

[App creation stages slides](slides/08_AppCreationStages.pdf)

[Sample app demands](AppCreationFromScratch/Documents/AppDemands.pdf)

[Sample terms of reference](AppCreationFromScratch/Documents/ToR.pdf)

- [6.1](AppCreationFromScratch/AppDemands/)

    - read [library database description](AppCreationFromScratch/Documents/ProjectsDescriptions.pdf)
    - write demands to application
    - write terms of reference to application

## Homework 7. 
07.11.20

[App demands](AppCreationFromScratch/AppDemands/)

[Terms of reference](AppCreationFromScratch/AppDemands/)

- [7.1](AppCreationFromScratch/App/)

    - create app according to documents from previous hw
    - app should be oriented on several users' groups

## Homework 8. 
07.11.20

[Effective queries building slides](slides/09_EffectiveQueriesBuilding.pdf)

- [8.1](AnalyticalQueries/Quotes/)

    Use [quotes data](./AnalyticalQueries/Quotes/SPFB.RTS-12.16_161007_161007.txt) to build app that shows:

    - price of RTS index
    - exponential moving average of price via plot

    One one plot consists of 2 lines and legend, price = (OPEN + HIGH + LOW + CLOSE) / 4

## Homework 9. 
14.11.20

[Effective queries building slides](slides/09_EffectiveQueriesBuilding.pdf)

- [9.1](./AnalyticalQueries/EnergyConsumption/)

    Use [energy consumption data](./AnalyticalQueries/EnergyConsumption/electric_power.xml) to build app that shows
    summary of consumption with usage of temporary tables for given periods:

    |                   | Утро [6-12) | День[12-18) | Вечер[18-24) | Ночь [0-6) | Итого |
    |-------------------|:-----------:|:-----------:|:------------:|:----------:|:-----:|
    | 1 квартал         |             |             |              |            |       |
    | 2 квартал         |             |             |              |            |       |
    | 3 квартал         |             |             |              |            |       |
    | 4 квартал         |             |             |              |            |       |
    | Итого за 2009 год |             |             |              |            |       |
    | 1 квартал         |             |             |              |            |       |
    | 2 квартал         |             |             |              |            |       |
    | 3 квартал         |             |             |              |            |       |
    | 4 квартал         |             |             |              |            |       |
    | Итого за 2010 год |             |             |              |            |       |
    | Итого             |             |             |              |            |       |

## Homework 10. 
21.11.20

[Optimizer hints slides](slides/10_OptimizerHints.pdf)

[Oracle analytical functions slides](slides/11_OracleAnalyticalFunctions.pdf)

- [10.1](./OptimizerHints/)

    Write any query and show that you are able to give hints to optimizer of execution plan (write first hint and make sure that it is used by optimizer, write second hint and make sure that optimizer use it)

## Homework 11. 
28.11.20

[Task scheduler slides](slides/12_TaskScheduler.pdf)

- [11.1](./TaskScheduler/)

    Create app that allows:

    - perform task execution (start button)
    - execute task no more than 20-30 times (write to `debug_log` every execution)
    - task should create in support table dot with 2D coordinates
    - app should show dynamic of creation new dots as dots on plot (scatter plot or radar)
    - button for cleaning support table and plot

    Additions:

    - generate random values in range `dbms_random.VALUE(min_val, max_val)`
    - fix plot scale from the start using dots with min and max values
