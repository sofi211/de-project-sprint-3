delete from mart.f_customer_retention where period_id = (select first_day_of_week
							 from mart.d_calendar
							 where date_actual='{{ds}}'::date);

with tabl_status as (select first_day_of_week AS period_id,
			    item_id,
			    customer_id,
			    payment_amount,
			    quantity,
			    case 
			        when (count(*) over (partition by date_id, item_id, customer_id)=1) and (status!='refunded') then 'new' else status
			    end status
		     from mart.f_sales
		     where first_day_of_week = (select first_day_of_week
					  	from mart.d_calendar
						where date_actual='{{ds}}'::date))

insert into mart.f_customer_retention (period_id,
				       item_id,
				       new_customers_revenue,
				       returning_customers_revenue,
				       customers_refunded,
				       new_customers_count,
				       returning_customers_count,
				       refunded_customer_count)
select period_id,
       item_id,
       sum(case when status = 'new' then payment_amount end) new_customers_revenue,
       sum(case when status = 'shipped' then payment_amount end) returning_customers_revenue,
       sum(case when status = 'refunded' then payment_amount end) customers_refunded,
       count(case when status = 'new' then customer_id end) new_customers_count,
       count(case when status = 'shipped' then customer_id end) returning_customers_count,
       count(case when status = 'refunded' then customer_id end) refunded_customer_count
from tabl_status
group by period_id, item_id;
