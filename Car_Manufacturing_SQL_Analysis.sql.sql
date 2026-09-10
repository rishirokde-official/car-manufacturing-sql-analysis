USE Manufacture;
SELECT*FROM CarSales;

--Cars Price under 20 (thousand)
Select Manufacturer,Model,Price_in_thousands
From Carsales
WHERE Price_in_thousands<20;

--Sort By Best Selling 
SELECT Manufacturer,Model,Sales_in_thousands
FROM CarSales
ORDER BY Sales_in_thousands DESC;

--Count Model per Manufacturer
SELECT Manufacturer,COUNT(*) AS Model_Count
FROM CarSales
GROUP BY Manufacturer
ORDER BY Model_count DESC;

---- Average price per manufacturer
SELECT Manufacturer, AVG(Price_in_thousands) AS Avg_Price
FROM CarSales
GROUP BY Manufacturer
ORDER BY Avg_Price DESC;

--All Toyota Models
SELECT*FROM CarSales
WHERE Manufacturer='Toyota';


---Aggregate Fnctions(COUNT,SUM,AVG,MIN,MAX)

--Total Number of Car Models
SELECT COUNT (*) AS Total_Models
FROM CarSales;

--Total sales across all models
SELECT SUM(Sales_in_thousands) AS Total_sales
FROM CarSales;

---- Average price of all cars
SELECT AVG(Price_in_thousands) AS Avg_Price
FROM CarSales;

-----Cheapest And Most Expensive Car
SELECT  MIN(Price_in_thousands)AS Min_Price,
Max(Price_in_thousands)As Max_Price
FROM CarSales;

-- For a specific manufacturer (e.g., Toyota)
SELECT Manufacturer, MIN(Price_in_thousands) AS Min_Price,
MAX(Price_in_thousands) AS Max_Price
FROM CarSales
WHERE Manufacturer = 'Toyota'
GROUP BY Manufacturer;

-- Average horsepower per vehicle type
SELECT Vehicle_type, AVG(Horsepower) AS Avg_Horsepower
FROM CarSales
GROUP BY Vehicle_type;

-- Min and max price per manufacturer
SELECT Manufacturer, MIN(Price_in_thousands) AS Min_Price,
MAX(Price_in_thousands) AS Max_Price
FROM CarSales
GROUP BY Manufacturer;

--Manufacturers ranked by total sales(hightest)
SELECT MAnufacturer,SUM(Sales_in_thousands)As Total_Sales
FROM CarSales
GROUP BY Manufacturer
ORDER BY Total_Sales Desc;

---- Manufacturers ranked by average price (lowest first)
SELECT Manufacturer,
AVG(Price_in_thousands) AS Avg_Price
FROM CarSales
GROUP BY Manufacturer
ORDER BY Avg_Price ASC;

--Manufacturers with total sales above 100(thousand unit)
SELECT Manufacturer,SUM(Sales_in_thousands) AS Total_Sales
FROM CarSales
GROUP BY Manufacturer
HAVING SUM(Sales_in_thousands)>100
ORDER BY Total_Sales DESC;

--Subqueries

-- 1. Models priced above the overall average price
-- (Business case: flag premium-tier models)
SELECT Manufacturer, Model, Price_in_thousands
FROM CarSales
WHERE Price_in_thousands > (SELECT AVG(Price_in_thousands) FROM CarSales)
ORDER BY Price_in_thousands DESC;

-- 2. Manufacturers whose average price is above the company-wide average
-- (Business case: identify premium brands vs. mass-market brands)
SELECT Manufacturer, AVG(Price_in_thousands) AS Avg_Price
FROM CarSales
GROUP BY Manufacturer
HAVING AVG(Price_in_thousands) > (SELECT AVG(Price_in_thousands) FROM CarSales)
ORDER BY Avg_Price DESC;

-- 3. The single best-selling model in the whole dataset
-- (Business case: "flagship" model callout)
SELECT Manufacturer, Model, Sales_in_thousands
FROM CarSales
WHERE Sales_in_thousands = (SELECT MAX(Sales_in_thousands) FROM CarSales);


-- 4. Models priced above their own manufacturer's average price
-- (Business case: which specific models push a brand's average up — correlated subquery)
SELECT s1.Manufacturer, s1.Model, s1.Price_in_thousands
FROM CarSales s1
WHERE s1.Price_in_thousands > (
    SELECT AVG(s2.Price_in_thousands)
    FROM CarSales s2
    WHERE s2.Manufacturer = s1.Manufacturer
)
ORDER BY s1.Manufacturer, s1.Price_in_thousands DESC;

--Window Functions
-- 1. Rank every model's sales within its own manufacturer
-- (Business case: "which model is the top seller for each brand")
SELECT
    Manufacturer,
    Model,
    Sales_in_thousands,
    RANK() OVER (PARTITION BY Manufacturer ORDER BY Sales_in_thousands DESC) AS Sales_Rank
FROM CarSales;

-- 2. Just the #1 selling model per manufacturer (flagship report)
-- (Business case: catalog/marketing team — one hero model per brand)
SELECT Manufacturer, Model, Sales_in_thousands
FROM (
    SELECT
        Manufacturer, Model, Sales_in_thousands,
        RANK() OVER (PARTITION BY Manufacturer ORDER BY Sales_in_thousands DESC) AS rank
    FROM CarSales
) ranked
WHERE rank = 1
ORDER BY Sales_in_thousands DESC;

-- 3. Running total of sales across all models (highest to lowest)
-- (Business case: cumulative sales chart — how many top-N models make up X% of total sales)
SELECT
    Manufacturer,
    Model,
    Sales_in_thousands,
    SUM(Sales_in_thousands) OVER (ORDER BY Sales_in_thousands DESC
                                   ROWS UNBOUNDED PRECEDING) AS Running_Total_Sales
FROM CarSales;

-- 4. Each model's price compared to its manufacturer's average
-- (Business case: pricing analysis — how far above/below brand average is this model)
SELECT
    Manufacturer,
    Model,
    Price_in_thousands,
    ROUND(AVG(Price_in_thousands) OVER (PARTITION BY Manufacturer), 2) AS Brand_Avg_Price,
    ROUND(Price_in_thousands - AVG(Price_in_thousands) OVER (PARTITION BY Manufacturer), 2) AS Diff_From_Brand_Avg
FROM CarSales
WHERE Price_in_thousands IS NOT NULL;
    

