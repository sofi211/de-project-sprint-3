update staging.user_order_log
set payment_amount = -payment_amount
where staging.user_order_log.status = 'refunded'
and date_time::Date = '{{ds}}';