-- Добавить в таблицу staging.user_order_log столбец status
ALTER TABLE staging.user_order_log ADD COLUMN status varchar(15) NOT NULL Default 'shipped';


-- Добавить в таблицу mart.f_sales столбцы status, date_time, first_day_of_week
ALTER TABLE mart.f_sales ADD COLUMN status varchar(15) NOT NULL;
ALTER TABLE mart.f_sales ADD COLUMN date_time timestamp NOT NULL;
ALTER TABLE mart.f_sales ADD COLUMN first_day_of_week date NOT NULL;


-- Создание таблицы customer_retention_test
CREATE TABLE IF NOT EXISTS mart.f_customer_retention (
new_customers_count int null, -- кол-во новых клиентов (тех, которые сделали только один заказ за рассматриваемый промежуток времени)
returning_customers_count int null, -- кол-во вернувшихся клиентов (тех, которые сделали только несколько заказов за рассматриваемый промежуток времени).
refunded_customer_count int null, -- кол-во клиентов, оформивших возврат за рассматриваемый промежуток времени
period_name varchar(20) DEFAULT 'weekly',
period_id date, -- идентификатор периода (номер недели или номер месяца)
item_id int, -- идентификатор категории товара
new_customers_revenue numeric(10,2), -- доход с новых клиентов
returning_customers_revenue numeric(10,2), -- доход с вернувшихся клиентов
customers_refunded numeric(10,2), -- количество возвратов клиентов
PRIMARY KEY (period_id, item_id));
