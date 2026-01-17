-- creating database
CREATE DATABASE zepto_SQL_project;
USE zepto_SQL_project;

-- data exploration
SELECT 
    COUNT(*)
FROM
    zepto;

-- check null values

SELECT 
    *
FROM
    zepto
WHERE
    product_name IS NULL OR category IS NULL
        OR mrp IS NULL
        OR availableQuantity IS NULL
        OR discountedSellingPrice IS NULL
        OR weightInGms IS NULL
        OR outOfStock IS NULL
        OR quantity IS NULL;


-- different product categories
SELECT DISTINCT
    category
FROM
    zepto
ORDER BY category;

-- product in stock vs out of stock
SELECT 
    outOFstock, COUNT(*)
FROM
    zepto
GROUP BY outOFstock;

-- product name present multiple times
SELECT 
    product_name, COUNT(*)
FROM
    zepto
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

-- product with price = 0
SELECT 
    *
FROM
    zepto
WHERE
    mrp = 0 OR discountedSellingPrice = 0;

SET SQL_SAFE_UPDATES = 0;

-- removing rows with, mrp = 0 OR discountedSellingPrice = 0;
DELETE FROM zepto 
WHERE
    mrp = 0;

-- convert paise to rupees
UPDATE zepto 
SET 
    mrp = mrp / 100,
    discountedSellingPrice = discountedSellingPrice / 100;

SELECT 
    mrp, discountedSellingPrice
FROM
    zepto;
    

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT DISTINCT
    product_name, mrp,discountPercent
FROM
    zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. What are the products with High MRP but Out of Stock
SELECT DISTINCT
    product_name, outOFstock, mrp
FROM
    zepto
WHERE
    outOFstock = 1 AND mrp > 300
ORDER BY mrp DESC;

-- Q3. Calculate Estimated Revenue for each category

SELECT 
    Category,
    SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM                                                                          
    zepto
GROUP BY Category
ORDER BY total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
SELECT DISTINCT
    product_name, mrp, discountPercent
FROM
    zepto
WHERE
    mrp > 500 AND discountPercent < 10
ORDER BY mrp DESC , discountPercent DESC;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
SELECT DISTINCT
    Category, AVG(discountPercent) AS avg_discount
FROM
    zepto
GROUP BY Category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
SELECT DISTINCT
    product_name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM
    zepto
WHERE
    weightInGms >= 100
ORDER BY price_per_gram;
-- Q7. Group the products into categories like Low, Medium, Bulk.
SELECT DISTINCT
    product_name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM
    zepto;
-- Q8. What is the Total Inventory Weight per Category
SELECT 
    Category, SUM(weightInGms) AS total_weight
FROM
    zepto
GROUP BY Category
ORDER BY total_weight;
						  

