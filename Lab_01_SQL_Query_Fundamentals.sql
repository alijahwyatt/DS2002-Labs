-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table?
-- ------------------------------------------------------------------
select count(*) as row_count
from products;
-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
select product_name, products.quantity_per_unit
from products;

-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
select id as product_id, product_name
from products
where discontinued != 1;
-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
select id as product_id, product_name
from products
where discontinued != 0;

-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
select product_name, list_price
from products
where list_price > (select min(list_price) from products) or list_price > (select max(list_price) from products)
order by list_price desc;

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
select id, product_name, list_price
from products
where list_price < 20;

-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------
select id, product_name, list_price
from products
where list_price < 20 and list_price > 15;


-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
select product_name, list_price
from products
where list_price > (select avg(list_price) from products);


-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
select product_name, list_price
from products 
order by list_price desc
limit 10;
-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
select case when discontinued = 1 then 'discontinued'
else 'current' end as discontinued, count(*) as row_count
from products
group by discontinued;

-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
select product_name, reorder_level, (target_level - reorder_level) as units_in_stock
from products
where reorder_level < (target_level - reorder_level)
order by reorder_level desc;


-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
select products.id, product_name, supplier_ids, suppliers.company, 
suppliers.address, suppliers.city, suppliers.state_province, 
suppliers.zip_postal_code, suppliers.country_region
from products
join suppliers
on suppliers.id = products.supplier_ids;


-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
select category
, COUNT(*) as units
From products
Group By category
Having units < 5
Order By units DESC;

-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
select category
, COUNT(*) as units
From products
Where list_price < 20.00
Group By category