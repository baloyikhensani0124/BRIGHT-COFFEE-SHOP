---Creating KPI'S
SELECT SUM(unit_price*transaction_qty)  AS total_revenue
FROM workspace.default.brightcoffee_analysis;

SELECT SUM(transaction_qty)
FROM workspace.default.brightcoffee_analysis;
 
 SELECT COUNT(transaction_id)
 FROM workspace.default.brightcoffee_analysis;

 SELECT AVG(unit_price)
  FROM workspace.default.brightcoffee_analysis;

----Creating Time Intervals 
 SELECT store_location,COUNT(transaction_id),
         CASE
         WHEN HOUR(transaction_time) >=7 AND HOUR(transaction_time) <10 THEN 'MORNING RUSH'
         WHEN HOUR(transaction_time)  >=10 AND HOUR(transaction_time) <12 THEN 'BRUNCH'
         WHEN HOUR(transaction_time)  >=12 AND HOUR(transaction_time) <15 THEN 'DAYTIME'
         WHEN HOUR(transaction_time)  >=15 AND HOUR(transaction_time) <18 THEN 'AFTERNOON'
         ELSE 'EVENING'
         END AS time_intervals
    FROM workspace.default.brightcoffee_analysis
    GROUP BY store_location,time_intervals;

  --- GRAPHICS 
  ----Calculating the total quantity sold per product category
  SELECT DISTINCT product_category , SUM(transaction_qty) AS total_qty
  FROM workspace.default.brightcoffee_analysis
  GROUP BY product_category ;

  ----Calculating the total quantity sold per location
  SELECT DISTINCT store_location , SUM(transaction_qty) AS total_sales
  FROM workspace.default.brightcoffee_analysis
  GROUP BY store_location;


---BREAKDOWN OF SALES PER LOCATION 
  SELECT product_category, store_location , SUM(transaction_qty)
  FROM workspace.default.brightcoffee_analysis
  WHERE store_location = 'Lower Manhattan'
  GROUP BY product_category, store_location;

  SELECT product_category, store_location , SUM(transaction_qty)
  FROM workspace.default.brightcoffee_analysis
  WHERE store_location = 'Astoria'
  GROUP BY product_category, store_location;

  SELECT product_category, store_location , SUM(transaction_qty)
  FROM workspace.default.brightcoffee_analysis
  WHERE store_location = "Hell's Kitchen"
  GROUP BY product_category, store_location;
--- COFFEE SHOP ANALYSIS DURATION

SELECT MIN(transaction_date)
FROM workspace.default.brightcoffee_analysis;

SELECT MAX(transaction_date)
FROM workspace.default.brightcoffee_analysis;

---WEEKDAY TRENDS AND MONTHLY TRENDS 
SELECT store_location, COUNT(transaction_qty) AS total_qty,
    Dayname(transaction_date) AS weekday
FROM workspace.default.brightcoffee_analysis
GROUP BY store_location, weekday;

SELECT COUNT(transaction_qty) AS total_qty, store_location,
    Monthname(transaction_date) AS Month_
FROM workspace.default.brightcoffee_analysis
GROUP BY Month_ , store_location;


---Product performance per store
SELECT store_location , product_category, COUNT(transaction_qty) as total_qty
FROM workspace.default.brightcoffee_analysis
GROUP BY store_location , product_category;
