CREATE DATABASE wamart;
Use wamart;
#  find No Of rows
SELECT COUNT(*) AS total_rows
FROM walmart_clean ;

Select * from walmart_clean;

# Only cash Method is seen
Select * from walmart_clean
Where Payment_Method ="Cash";

#Cash method apply in catogory
Select CATEGORY from walmart_clean
where Payment_Method ="Cash";


Select INVOICE_ID, Payment_Method, category  from walmart_clean
where Payment_Method ="Cash" and CATEGORY ="Food and beverages"

Select SUM(QUANTITY), PAYMENT_METHOD from walmart_clean
group by PAYMENT_METHOD;

# Find total profit  gain by all Payment Type
Select Payment_Method As Payment_type, SUM(PROFIT_MARGIN) As Profit from walmart_clean
group by Payment_Method;

# Count total profit  gain by all Payment Type
Select Payment_Method As Payment_type, Count(PROFIT_MARGIN) As Profit from walmart_clean
group by Payment_Method;

# Max Profit in Credit card
Select max(PROFIT_MARGIN) as highest_profit from walmart_clean
where Payment_Method = "Credit card";

-- 1 What are the different payment methods, and how many transactions and
-- items were sold with each method?
Select PAYMENT_METHOD, count(PAYMENT_METHOD) as Total_Transaction, count(Quantity) as Total_items_sold  from  walmart_clean
group by PAYMENT_METHOD;

# 2 Which category received the highest average rating in each branch?
SELECT BRANCH, CATEGORY, ROUND(AVG(RATING), 2) AS avg_rating
FROM walmart_clean
GROUP BY BRANCH, CATEGORY
ORDER BY BRANCH, avg_rating DESC;

# 3 What is the busiest day of the week for each branch based on transaction volume?
SELECT BRANCH, DAYNAME(Date) AS Day_Name,
    COUNT(*) AS Transaction_Volume
FROM walmart_clean
GROUP BY BRANCH, DAYNAME(Date)
ORDER BY BRANCH, Transaction_Volume DESC;

-- 4 Calculate the total quantity of items sold per payment method. List payment_method and total_quantity.
Select PAYMENT_METHOD, SUM(QUANTITY) from walmart_clean
group by PAYMENT_METHOD;

-- 5 Determine the average, minimum, and maximum rating of category for each city. 
-- List the city, average_rating, min_rating, and max_rating.
SELECT CITY, ROUND(AVG(RATING), 2) AS average_rating,
    MIN(RATING) AS min_rating,
    MAX(RATING) AS max_rating
FROM walmart_clean
GROUP BY CITY;

-- 6 Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). 
-- List category and total_profit, ordered from highest to lowest profit.


SELECT CATEGORY, SUM((Selling_Price - Cost_Price) * QUANTITY) AS Total_Profit
FROM walmart_clean
GROUP BY CATEGORY
ORDER BY Total_Profit DESC;

-- 7 Determine the Most Common Payment Method per Branch
SELECT BRANCH, Payment_Method, COUNT(*) AS total_transactions FROM walmart_clean
GROUP BY BRANCH, PAYMENT_METHOD
ORDER BY BRANCH, PAYMENT_METHOD DESC;

SELECT CASE WHEN HOUR(Time) < 12 THEN 'Morning'
            WHEN HOUR(Time) < 18 THEN 'Afternoon'
        ELSE 'Evening'
    END AS Time_of_Day,
    COUNT(*) AS Total_Transactions,
    SUM(Total) AS Total_Sales,
    AVG(Total) AS Average_Sale
FROM walmart_clean
GROUP BY Time_of_Day
ORDER BY Total_Sales DESC;

-- 9 Identify Branches with Highest Revenue Decline Year-Over-Year
SELECT
    Branch,
    YEAR(Date) AS Year,
    SUM(Total) AS Revenue
FROM walmart_clean
GROUP BY Branch, YEAR(Date)
ORDER BY Branch, Year;