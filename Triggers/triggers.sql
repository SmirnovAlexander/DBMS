-- create trigger that automatically generate values for table (use sequence)
create table DEPT1 (
    DEPTNO number(3,0) not null enable, 
    DNAME  varchar2(50), 
    LOC    varchar2(50), 
    constraint DEPT1_PK primary key (DEPTNO) 
    using index enable 
) 
organization index;
/

create sequence DEPT1_SEQ
    start with 10
    increment by 10
    maxvalue 9000
    minvalue 1
    cache 20
    nocycle;
/

create or replace trigger DEPT1_TRG1
    before insert on dept1
    for each row
    begin
        if :new.deptno is null then 
            select dept1_seq.nextval
            into :new.deptno
            from sys.dual;
        end if;
    end;
/

insert into dept1(dname, loc) values('RESEARCH',   'DALLAS');
insert into dept1(dname, loc) values('SALES',      'CHICAGO');
insert into dept1(dname, loc) values('OPERATIONS', 'BOSTON');

select * from dept1;

drop table dept1;
drop sequence dept1_seq;


-- create trigger that automatically generate values for table (without sequence)
create table DEPT1 (
    DEPTNO number(3,0) not null enable, 
    DNAME  varchar2(50), 
    LOC    varchar2(50), 
    constraint DEPT1_PK primary key (DEPTNO) 
    using index enable 
) 
organization index;
/

create or replace trigger DEPT1_TRG1
    before insert on dept1
    for each row
    declare 
        cnt     number;
        max_num number;
    begin
        select count(*) into cnt from dept1;
        if cnt = 0 then
            :new.deptno := 10;
        else
            select max(deptno) into max_num from dept1;
            :new.deptno := max_num + 10;
        end if;
    end;
/

insert into dept1(dname, loc) values('RESEARCH',   'DALLAS');
insert into dept1(dname, loc) values('SALES',      'CHICAGO');
insert into dept1(dname, loc) values('OPERATIONS', 'BOSTON');

select * from dept1;

drop table dept1;

-- create trigger that writes in journal events of creating, changing and deleting tables, views and sequences
    -- time
    -- type of event
    -- object name
-- show triggers using system views
create table DEBUG_LOG (
    ID           number(4,0) not null enable, 
    LOG_TIME     date, 
    MESSAGE      varchar2(50),
    IN_SOURCE    varchar2(50),
    constraint DEBUG_LOG_PK primary key (ID) 
    using index enable 
) 
organization index;

create sequence DEBUG_LOG_SEQ
    start with 1
    increment by 1
    maxvalue 9999
    minvalue 1
    cache 20
    nocycle;

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


create or replace trigger CREATE_TRG1
    before create on furiousteabag.schema
    begin
        log_info(ora_dict_obj_type || ' ' || ora_dict_obj_name, 'CREATE_TRG1');
    end;
/

create or replace trigger DROP_TRG1
    before drop on furiousteabag.schema
    begin
        log_info(ora_dict_obj_type || ' ' || ora_dict_obj_name, 'DROP_TRG1');
    end;
/

create or replace trigger ALTER_TRG1
    before alter on furiousteabag.schema
    begin
        log_info(ora_dict_obj_type || ' ' || ora_dict_obj_name, 'ALTER_TRG1');
    end;
/

-------------------------------------------
create table DEPT1 (
    DEPTNO number(3,0) not null enable, 
    DNAME  varchar2(50), 
    LOC    varchar2(50), 
    constraint DEPT1_PK primary key (DEPTNO) 
    using index enable 
) 
organization index;
/

create sequence DEPT1_SEQ
    start with 10
    increment by 10
    maxvalue 9000
    minvalue 1
    cache 20
    nocycle;
/

create or replace trigger DEPT1_TRG1
    before insert on dept1
    for each row
    begin
        if :new.deptno is null then 
            select dept1_seq.nextval
            into :new.deptno
            from sys.dual;
        end if;
    end;
/

--insert into dept1(dname, loc) values('RESEARCH',   'DALLAS');
--insert into dept1(dname, loc) values('SALES',      'CHICAGO');
--insert into dept1(dname, loc) values('OPERATIONS', 'BOSTON');


drop table dept1;
drop sequence dept1_seq;
-------------------------------------------

select * from debug_log;
select * from user_triggers;

drop trigger create_trg1;
drop trigger drop_trg1;
drop trigger alter_trg1;

drop sequence debug_log_seq;
drop table debug_log;
