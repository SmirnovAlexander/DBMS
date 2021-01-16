drop type power_consumption_stats_t
/
create or replace type power_consumption_info as object(id integer,
    meaning varchar2(40),
    morning_res integer,
    daytime_res integer,
    evening_res integer,
    night_res integer,
    overall_res integer)
/
create or replace type power_consumption_stats_t is table of power_consumption_info
/
select * from power_consumption order by date_, id
/
drop table power_consumption_true
/
create table power_consumption_true (
    id_ integer,
    value_ integer,
    date_ date,
    hour_ integer
)
/
insert into power_consumption_true select id, value, to_date(substr(date_, 0, 10), 'dd.mm.yyyy'), to_number(hour) from power_consumption;
/
select * from power_consumption_true order by date_, hour_
/
drop table power_consumption_res
/
create global temporary table power_consumption_res (
    id integer,
    meaning varchar2(40),
    morning_res integer,
    daytime_res integer,
    evening_res integer,
    night_res integer,
    overall_res integer
)
/
/* select unique to_char(date_, 'yyyy') from power_consumption_true */ 
/* / */
/* select unique to_number(to_char(date_, 'yyyy')) from power_consumption_true; */
/* / */
/* select unique trunc(to_number(to_char(date_, 'yyyy'))) from power_consumption_true; */
/* / */
/* create or replace type t_years is table of integer */
/* / */
/* select sum(value_) from power_consumption_true */ 
/* where to_number(to_char(date_, 'yyyy')) = 2009 */ 
/* and (to_number(to_char(date_, 'mm')) between 1 and 3) */
/* / */
create or replace function calc_electricity return power_consumption_stats_t pipelined
is
    pragma autonomous_transaction;
    curr_period integer;
    temp_table_id integer;
    j integer;
    possible_years t_years;
    curr_month integer;
    curr_year integer;
    curr_year_i integer;
begin
    execute immediate('truncate table power_consumption_res');
    -- which years are present in the table?
    select unique trunc(to_number(to_char(date_, 'yyyy'))) bulk collect into possible_years from power_consumption_true;

    for curr_year_i in possible_years.first..possible_years.last loop    
        curr_year := possible_years(curr_year_i);  
        for curr_period in 1..4 loop
        temp_table_id := curr_year * 10 + curr_period;
        insert into power_consumption_res(id, meaning, morning_res, daytime_res, evening_res, night_res, overall_res)
        values(temp_table_id, concat(to_char(curr_period), ' квартал'), 0, 0, 0, 0, 0);
        end loop;
        insert into power_consumption_res(id, meaning, morning_res, daytime_res, evening_res, night_res, overall_res)
        values(curr_year * 10 + 5, concat(concat('итого за ', to_char(curr_year)), ' год'), 0, 0, 0, 0, 0);
    end loop;

    insert into power_consumption_res(id, meaning, morning_res, daytime_res, evening_res, night_res, overall_res)
    values(possible_years(possible_years.last) * 10 + 6, 'итого', 0, 0, 0, 0, 0);

    for rec in (select * from power_consumption_true order by date_, hour_) loop
        curr_month := to_number(to_char(rec.date_, 'mm'));
        curr_year := to_number(to_char(rec.date_, 'yyyy'));
        if curr_month between 1 and 3 then
            curr_period := 1;
        elsif curr_month between 4 and 6 then
            curr_period := 2;
        elsif curr_month between 7 and 9 then
            curr_period := 3;
        elsif curr_month between 10 and 12 then
            curr_period := 4;
        end if;

        if rec.hour_ between 6 and 11 then
            update power_consumption_res
                set morning_res = morning_res + rec.value_
                where id = curr_year * 10 + curr_period;
        elsif rec.hour_ between 12 and 17 then
            update power_consumption_res
                set daytime_res = daytime_res + rec.value_
                where id = curr_year * 10 + curr_period;
        elsif rec.hour_ between 18 and 23 then
            update power_consumption_res
                set evening_res = evening_res + rec.value_
                where id = curr_year * 10 + curr_period;
        elsif (rec.hour_ between 1 and 5) or (rec.hour_ = 24) then
            update power_consumption_res
                set night_res = night_res + rec.value_
                where id = curr_year * 10 + curr_period;                
        end if;
    end loop;

    -- update annual statistics
    for curr_year_i in possible_years.first..possible_years.last loop    
        curr_year := possible_years(curr_year_i);  
        for curr_period in 1..4 loop
        temp_table_id := curr_year * 10 + curr_period;
        update power_consumption_res
            set morning_res = morning_res + (select morning_res from power_consumption_res where id = temp_table_id),
                daytime_res = daytime_res + (select daytime_res from power_consumption_res where id = temp_table_id),
                evening_res = evening_res + (select evening_res from power_consumption_res where id = temp_table_id),
                night_res = night_res + (select night_res from power_consumption_res where id = temp_table_id)
            where id = curr_year * 10 + 5;
        end loop;
    end loop;

    -- update statistics for the whole time
    for curr_year_i in possible_years.first..possible_years.last loop    
        curr_year := possible_years(curr_year_i);  
        temp_table_id := curr_year * 10 + 5;
        update power_consumption_res
            set morning_res = morning_res + (select morning_res from power_consumption_res where id = temp_table_id),
                daytime_res = daytime_res + (select daytime_res from power_consumption_res where id = temp_table_id),
                evening_res = evening_res + (select evening_res from power_consumption_res where id = temp_table_id),
                night_res = night_res + (select night_res from power_consumption_res where id = temp_table_id)
            where id = possible_years(possible_years.last) * 10 + 6;
    end loop;

    for rec in (select * from power_consumption_res) loop
        update power_consumption_res
            set overall_res = rec.morning_res + rec.daytime_res + rec.evening_res + rec.night_res
            where id = rec.id; 
    end loop;

    dbms_stats.gather_table_stats('furiousteabag', 'power_consumption_res');

    for rec in (select * from power_consumption_res) loop
        commit;
        pipe row(power_consumption_info(rec.id, rec.meaning, rec.morning_res, rec.daytime_res, rec.evening_res, rec.night_res, rec.overall_res));
    end loop;
end;
/
drop view total_electricity
/
create view total_electricity as
select id, meaning, round(morning_res / 1000000, 1) "morning", round(daytime_res / 1000000, 1) "day",
    round(evening_res / 1000000, 1) "evening", round(night_res / 1000000, 1) "night", round(overall_res / 1000000, 1) "overall"
from calc_electricity()
/
select * from total_electricity;
