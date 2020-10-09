-- create view of numbers and names of workers who was applied at winter
create view EMP_WINTER as
select empno, ename
from   emp
where  extract(month from hiredate) in ('01', '02', '12');

-- create view of name of workers that are managers of at least than 3 others
create view TOP_MANAGERS as
select emp.ename
from (
    select   mgr, count(mgr) as num
    from     emp
    group by mgr
    having   count(mgr) >= 3) mgr_ids
join emp on emp.empno = mgr_ids.mgr;

-- take a look at these views
select * from emp_winter;
select * from top_managers;

-- drop these views
drop view emp_winter;
drop view top_managers;


-- create sequence for table `DEPT1` with `CASH=20`
-- use nocache for sequence
create sequence DEPT1_SEQ
    start with 10
    increment by 10
    maxvalue 9000
    minvalue 1
    cache 20
    nocycle;

-- generate 10 values with this sequence (fill table `DEPT1`)
create table DEPT1 (
    DEPTNO number(3,0) not null enable, 
    DNAME  varchar2(50), 
    LOC    varchar2(50), 
    constraint DEPT1_PK primary key (DEPTNO) 
    using index enable 
) 
organization index;

insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'ACCOUNTING', 'NEW YORK');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'RESEARCH',   'DALLAS');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'SALES',      'CHICAGO');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'OPERATIONS', 'BOSTON');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'FINANCE',    'LOS ANGELES');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'HR',         'HOUSTON');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'PURCHASE',   'PHOENIX');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'SUPPLY',     'PHILADELPHIA');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'IT',         'SAN ANTONIO');
insert into dept1(deptno, dname, loc) values(dept1_seq.nextval, 'ANALYSIS',   'SAN DIEGO');

-- make sure it fills as you expected
select * from dept1;

-- find this sequence in system views
select * from user_sequences;

-- drop this sequence
drop table dept1;
drop sequence dept1_seq;


-- create and execute stored procedure that calculates factorial 
create or replace function fac(a in number)
    return number
    is
        result number;
    begin
        if a <= 1 then
            result := 1;
        else
            result := a * fac(a - 1);
        end if;
        return result;
    end fac;
/

-- demostrate it works
select fac(5) from dual;

-- create and execute procedure that accepts employee number and returns number of days he worked
create or replace function get_work_days(id number)
    return number
    is
        result number;
    begin
        select round(((select sysdate from dual) - hiredate), 0) as WORK_DAYS
        into result
        from emp
        where empno = id;
        
        return result;
    end get_work_days;
/

-- demostrate it works
select get_work_days(7839) from dual;


-- create stored procedure that returns statistics about employees and departments
    -- number of employees 
    -- number of departments
    -- number of various jobs
    -- summary salary
-- for outputing use package `dbms_output`
create or replace procedure get_statistics
    (num_emps  out number,
     num_depts out number,
     num_jobs  out number,
     sum_sal   out number
    )
is
begin

    select count(*)
    into num_emps
    from emp;
    
    select count(*)
    into num_depts
    from dept;

    select count(distinct job)
    into num_jobs
    from emp;
    
    select sum(sal)
    into sum_sal
    from emp;

end get_statistics;
/

-- demostrate it works
declare
    num_emps  number;
    num_depts number;
    num_jobs  number;
    sum_sal   number;
begin
    get_statistics(num_emps, num_depts, num_jobs, sum_sal);
    
    dbms_output.put_line('Total number of employees: '   || num_emps);
    dbms_output.put_line('Total number of departments: ' || num_depts);
    dbms_output.put_line('Number of various jobs: '      || num_jobs);
    dbms_output.put_line('Summary salary: '              || sum_sal);
end;
/

-- create table `debug_log`
create table DEBUG_LOG (
    ID           number(4,0) not null enable, 
    LOG_TIME     date, 
    MESSAGE      varchar2(50),
    IN_SOURCE    varchar2(50),
    constraint DEBUG_LOG_PK primary key (ID) 
    using index enable 
) 
organization index;

-- create appropriate sequence
create sequence DEBUG_LOG_SEQ
    start with 1
    increment by 1
    maxvalue 9999
    minvalue 1
    cache 20
    nocycle;

-- create procedure that returns hire date of worker that work more that others; hire date of worker that work least of all
create or replace procedure get_date_bounds
    (oldest_date out date,
     newest_date out date
    )
is
begin
    select min(hiredate)
    into   oldest_date
    from   emp;

    select max(hiredate)
    into   newest_date
    from   emp;

end get_date_bounds;
/

-- demostrate it works; result of procedure write to `debug_log` 
declare
    oldest_date date;
    newest_date date;
begin
    get_date_bounds(oldest_date, newest_date);
    
    insert into debug_log(id, log_time, message, in_source)
    values(debug_log_seq.nextval, sysdate, 'Oldest date: ' || oldest_date || ' ' || 'Newest date: ' || newest_date, 'get_date_bounds');
    
    --dbms_output.put_line('Hire date of employee that works most: '  || oldest_date);
    --dbms_output.put_line('Hire date of employee that works least: ' || newest_date);
end;
/

declare
    oldest_date date;
    newest_date date;
begin
    get_date_bounds(oldest_date, newest_date);
    
    insert into debug_log(id, log_time, message, in_source)
    values(debug_log_seq.nextval, sysdate, 'Oldest date: ' || oldest_date || ' ' || 'Newest date: ' || newest_date, 'get_date_bounds');
    
    --dbms_output.put_line('Hire date of employee that works most: '  || oldest_date);
    --dbms_output.put_line('Hire date of employee that works least: ' || newest_date);
end;
/

-- view entries of `debug_log` after procedure execution
select * from debug_log;


-- create procedure to track dynamical errors
create or replace procedure log_info
    (in_info_msg in varchar2,
     in_source in varchar2
    )
    is
        PRAGMA AUTONOMOUS_TRANSACTION;
    begin
        insert into debug_log(id, log_time, message, in_source)
        values(debug_log_seq.nextval, sysdate, in_info_msg, in_source);
        commit;
    exception
        when others then
            return;
    end log_info;
/

-- create function or procedure that may lead to dynamical error
create or replace function division(a in number, b in number)
    return number
    is
        result number;
    begin

        result := a / b;
        log_info(a || ' / ' || b || ' = ' || result, 'division');

        return result;
    exception
        when others then
            log_info(substr(sqlerrm, 1, 100) || ' (' || a || ' / ' || b || ')', 'division');
        
    end division;
/

-- execute appearence and track of 3 dynamical errors in `debug_log`
select division(10, 5) from dual;
select division(25, 5) from dual;
select division(25, 0) from dual;
select division(0, 0) from dual;
select division(-1, 0) from dual;
select * from debug_log;

-- drop table and sequence
drop table debug_log;
drop sequence debug_log_seq;
