insert into mart.f_sales (date_id, date_time, first_day_of_week, item_id, customer_id, city_id, quantity, payment_amount, status)
select dc.date_id, date_time, first_day_of_week, item_id, customer_id, city_id, quantity, payment_amount, status
from staging.user_order_log uol
left join mart.d_calendar as dc on uol.date_time::Date = dc.date_actual
where uol.date_time::Date = '{{ds}}';


update mart.f_sales
set payment_amount = -payment_amount
where mart.f_sales.status = 'refunded'
      and date_time::Date = '{{ds}}';