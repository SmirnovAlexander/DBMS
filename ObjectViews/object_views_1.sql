-- take a look at system views
select * 
from   all_tables
where  rownum <= 10

-- detect number of available tables (freezes)
select count(*)
from   all_tables

-- print content of a table that exists in `ALL_TABLES`, but not exists in `USER_TABLES`
select * 
from   table_privilege_map
where  rownum <= 10


-- take a look at system view integrity rules, count them
select *
from   user_constraints

-- count integrity rules
select count(*) as count
from   user_constraints

-- add integrity rule that limits salary
alter table emp
add   check (5000>=sal and sal>=500)

-- make sure it exists in system view
select *
from   user_constraints

-- write query to show name of this rule (freezes)
select constraint_name
from   user_constraints
where  search_condition_vc='5000>=SAL AND SAL>=500'

-- delete this integrity rule
alter table emp
drop  constraint SYS_C0098748699

-- add integrity rule with explicit naming
alter table emp
add   constraint sal_limit check (5000>=sal and sal>=500)

-- make sure it exists in system view
select *
from   user_constraints

-- delete this integrity rule
alter table emp
drop  constraint sal_limit


-- take a look at content of views that are connected with indexes in their scheme
select *
from   user_indexes

-- count number of indexes in scheme
select count(*) as count
from   user_indexes

-- create index-organized table `DEPT1` (same as `DEPT`)
create table DEPT1 (
    DEPTNO number(2,0) not null enable, 
    DNAME  varchar2(50), 
    LOC    varchar2(50), 
    constraint DEPT1_PK primary key (DEPTNO) 
    using index enable 
) 
organization index 

-- fill content with `DEPT` table
insert   into dept1
select * from dept

-- make sure it filled
select *
from   dept1

-- drop table
drop table dept1
