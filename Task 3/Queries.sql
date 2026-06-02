-- ====================================================================
-- TASK 3: SQL DATA ANALYSIS
-- Dataset: Superstore_Advanced_Story
-- ====================================================================


-- --------------------------------------------------------------------
-- SETUP: Creating a secondary table to demonstrate JOINS
-- --------------------------------------------------------------------
CREATE TABLE Region_Managers (
    Region TEXT,
    Manager_Name TEXT
);

INSERT INTO Region_Managers VALUES 
    ('East', 'Alice Smith'), 
    ('West', 'Bob Johnson'), 
    ('Central', 'Charlie Brown'), 
    ('South', 'Diana Prince');


-- --------------------------------------------------------------------
-- REQUIREMENT A & D: SELECT, WHERE, GROUP BY, ORDER BY & Aggregates
-- Goal: Calculate total revenue and average profit for non-returned 
-- items, grouped by product category.
-- --------------------------------------------------------------------
SELECT 
    Category, 
    SUM(Gross_Revenue) AS Total_Revenue, 
    AVG(Net_Profit) AS Avg_Profit
FROM Superstore_Advanced_Story
WHERE Returned = 'No'
GROUP BY Category
ORDER BY Total_Revenue DESC;


-- --------------------------------------------------------------------
-- REQUIREMENT B: JOINS (LEFT JOIN)
-- Goal: Combine the main dataset with the Manager table based on Region.
-- --------------------------------------------------------------------
SELECT 
    o.Order_ID, 
    o.Order_Date, 
    o.Region, 
    rm.Manager_Name, 
    o.Gross_Revenue
FROM Superstore_Advanced_Story o
LEFT JOIN Region_Managers rm 
    ON o.Region = rm.Region
LIMIT 15; 


-- --------------------------------------------------------------------
-- REQUIREMENT C: Subqueries
-- Goal: Filter orders to display individual transactions that generated 
-- higher gross revenue than the overall global average.
-- --------------------------------------------------------------------
SELECT 
    Order_ID, 
    Customer_Segment, 
    Gross_Revenue
FROM Superstore_Advanced_Story
WHERE Gross_Revenue > (
    SELECT AVG(Gross_Revenue) 
    FROM Superstore_Advanced_Story
)
ORDER BY Gross_Revenue DESC
LIMIT 10;


-- --------------------------------------------------------------------
-- REQUIREMENT E: Create Views for Analysis
-- Goal: Save a shortcut virtual table filtering high-profit tech orders.
-- --------------------------------------------------------------------
CREATE VIEW High_Profit_Tech AS
SELECT 
    Order_ID, 
    Region, 
    Gross_Revenue, 
    Net_Profit
FROM Superstore_Advanced_Story
WHERE Category = 'Technology' AND Net_Profit > 500;

-- Querying the newly created view:
SELECT * FROM High_Profit_Tech;


-- --------------------------------------------------------------------
-- REQUIREMENT F: Optimize queries with indexes
-- Goal: Optimize table speeds by indexing the highly-queried Region column.
-- --------------------------------------------------------------------
CREATE INDEX idx_region ON Superstore_Advanced_Story(Region);