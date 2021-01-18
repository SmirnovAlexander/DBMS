alter table quotes
drop column price;
/
alter table quotes
drop column ema;
/
alter table quotes
add price number;
/
select * from quotes
fetch first 10 rows only;
/
create or replace procedure price_builder as
   counter number;
   iterator number;
   begin
    iterator := 1;
    select count(id) into counter from quotes;
    while iterator <= counter
    loop
        update quotes set price=(c_open_ + c_high_ + c_low_ + c_close_)/4 where id = iterator;
        iterator:=iterator+1;
    end loop;
   end;
/
begin
price_builder;
end;
/
alter table quotes
add ema number;
/
create or replace procedure ema_builder as
   counter number;
   iterator number;
   emat number;
   begin
   update quotes set ema = price where id = 1 ;
    iterator := 2;
    select count(id) into counter from quotes;
    while iterator <= counter
    loop
        select ema into emat from quotes where id = iterator - 1;
        update quotes set ema = price * 0.2  + (0.8) * emat where id = iterator;
        iterator := iterator + 1;
    end loop;
   end;
/
begin
ema_builder;
end;
/
select * from quotes
fetch first 10 rows only;
