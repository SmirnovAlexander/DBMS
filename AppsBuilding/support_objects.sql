create view ORDERS_STORES as
    select    orders.*, stores.store_name
    from      orders 
    left join stores
    on        orders.store_id = stores.store_id;
/

create or replace trigger CUSTOMERS_TRG1
    before insert on customers
    for each row
    declare 
        cnt     number;
        max_num number;
    begin
        select count(*) into cnt from customers;
        if cnt = 0 then
            :new.customer_id := 0;
        else
            select max(customer_id) into max_num from customers;
            :new.customer_id := max_num + 1;
        end if;
    end;
/

create or replace procedure add_customer
    (full_name in varchar2,
     email_address in varchar2
    )
    is
    begin
        insert into customers(full_name, email_address)
        values(full_name, email_address);
    end add_customer;
/
