-- default: hash join
select * from 
stores s join
(select c.customer_id, full_name, order_datetime, store_id from customers c join orders o on c.customer_id = o.customer_id order by customer_id) o_c on
s.store_id = o_c.store_id;

-- merge join
select /*+ use_merge(s o_c) */ * from 
stores s join
(select c.customer_id, full_name, order_datetime, store_id from customers c join orders o on c.customer_id = o.customer_id order by customer_id) o_c on
s.store_id = o_c.store_id;

------

select index_name from user_indexes where table_name='ORDERS';

-- default access method: by index rowid, scans by orders_pk
select * 
from orders 
where order_id between 600 and 1000;

-- scan by orders_customer_id_i
select /*+ index(orders orders_customer_id_i) */ * 
from orders 
where order_id between 600 and 1000;

-- access method: storage full
select /*+ full(orders) */ * 
from orders 
where order_id between 600 and 1000;

------

-- default optimization: storage full first rows
select * 
from orders 
where rownum <= 10;

-- storage full: higher cost
select /*+ all_rows */ * 
from orders 
where rownum <= 10;
