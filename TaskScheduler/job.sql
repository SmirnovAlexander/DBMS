drop trigger "debug_log_trigger";
drop trigger "debug_log_trigger_dml";
drop sequence DEBUG_LOG_SEQ;
drop table DEBUG_LOG;



drop table points;


create table DEBUG_LOG (
    ID           number(4,0) not null enable, 
    LOG_TIME     timestamp, 
    Event      varchar2(50),
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
    








begin
DBMS_SCHEDULER.DROP_program( 'simple_program', TRUE );
DBMS_SCHEDULER.DROP_SCHEDULE( 'simple_schedule', TRUE );
end;
/

create table points
(
    x number,
    y number
);

create or replace procedure insertnew as
begin
    insert into points values ( (select dbms_random.VALUE(0,100) from dual) , (select dbms_random.VALUE(0,100) from dual));
    insert into DEBUG_LOG values( DEBUG_LOG_SEQ.nextval , SYSTIMESTAMP , 'new point into table inserted');
end;
/

BEGIN
DBMS_SCHEDULER.CREATE_PROGRAM
( program_name  => 'simple_program',
  program_type  => 'STORED_PROCEDURE' , 
  program_action => 'insertnew',
  enabled       => TRUE
);
END;
/
BEGIN
  DBMS_SCHEDULER.CREATE_SCHEDULE
     ( schedule_name   => 'simple_schedule',
       start_date      => SYSTIMESTAMP,
       repeat_interval => 'FREQ=SECONDLY; INTERVAL=3',
       end_date        => SYSTIMESTAMP + INTERVAL '1' minute 
     ) ;
END;
/

create or replace procedure clearpoints as
begin
    EXECUTE IMMEDIATE 'TRUNCATE TABLE points';
    insert into DEBUG_LOG values( DEBUG_LOG_SEQ.nextval , SYSTIMESTAMP , 'table cleared');
end;
/
begin
clearpoints;
end;
/
BEGIN 
DBMS_SCHEDULER.create_job (
    job_name      => 'simple_job',
    program_name  => 'simple_program',
    start_date => SYSTIMESTAMP,
    end_date => SYSTIMESTAMP + INTERVAL '1' minute,
    repeat_interval => 'FREQ=SECONDLY; INTERVAL=3',

    enabled       => TRUE
);
end;
