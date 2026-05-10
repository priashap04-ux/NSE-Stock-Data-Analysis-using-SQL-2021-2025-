-- This study analyzes five years of Indian equity market data (2021–2025) for six large‑cap stocks—Bajaj Auto, Eicher Motors, 
-- Hero MotoCorp, TVS Motor, Infosys, and TCS—representing the Auto and IT sectors. The objective is to evaluate price 
-- performance, liquidity, volatility, delivery behavior, and sector-level dynamics to derive actionable investment insights and 
-- comparative risk–return profiles.
-- The raw data was sourced from daily NSE trading records and initially contained structural and formatting inconsistencies, 
-- including Excel serial dates, text‑encoded numerical fields, Indian comma separators, and missing or non‑numeric values. A 
-- comprehensive data‑cleaning pipeline was implemented using SQL: dates were standardized, numeric fields converted to 
-- appropriate data types, invalid entries normalized to NULL, and safe‑update constraints managed to enable consistent 
-- transformations. The cleaned dataset was organized into six stock specific tables totaling over 7,500 trading records, 
-- ensuring analytical accuracy and reliability.
-- Subsequent analysis reveals a clear sectoral divergence over the period. Auto stocks delivered superior returns—led by TVS 
-- Motor and Hero MotoCorp—driven by cyclical recovery, EV momentum, and earnings expansion, albeit with significantly higher 
-- volatility. In contrast, Infosys and TCS emerged as stability anchors, characterized by high liquidity, strong delivery 
-- percentages, and lower price variability, reflecting their defensive, institutionally driven nature. Overall, the findings 
-- support a balanced portfolio approach, combining selective high‑beta auto exposure for growth with IT stocks for risk control 
-- and capital preservation as the auto cycle matures.

CREATE DATABASE Stock;

USE Stock;

CREATE TABLE Infosys (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Infosys.csv'
INTO TABLE Infosys
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT COUNT(*) FROM Infosys;

CREATE TABLE Bajaj_Auto (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bajaj_Auto.csv'
INTO TABLE Bajaj_Auto
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Eicher_Motors (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Eicher_Motors.csv'
INTO TABLE Eicher_Motors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE Hero_MotoCorp (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Hero_MotoCorp.csv'
INTO TABLE Hero_MotoCorp
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE TCS (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TCS.csv'
INTO TABLE TCS
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

CREATE TABLE TVS_Motor (
Symbol TEXT,
Series TEXT,
Date TEXT,
Prev_Close TEXT,
Open_Price TEXT,
High_Price TEXT,
Low_Price TEXT,
Last_Price TEXT,
Close_Price TEXT,
Average_Price TEXT,
Total_Traded_Quantity TEXT,
Turnover TEXT,
No_of_Trades TEXT,
Deliverable_Qty TEXT,
Percent_Dly_Qt_to_Traded_Qty TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TVS_Motor.csv'
INTO TABLE TVS_Motor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Add new date column to each table
ALTER TABLE Eicher_Motors ADD COLUMN trade_date DATE;
ALTER TABLE Bajaj_Auto ADD COLUMN trade_date DATE;
ALTER TABLE Hero_MotoCorp ADD COLUMN trade_date DATE;
ALTER TABLE Infosys ADD COLUMN trade_date DATE;
ALTER TABLE TCS ADD COLUMN trade_date DATE;
ALTER TABLE TVS_Motor ADD COLUMN trade_date DATE;

-- Convert Excel serial 
UPDATE Eicher_Motors SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);
UPDATE Bajaj_Auto SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);
UPDATE Hero_MotoCorp SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);
UPDATE Infosys SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);
UPDATE TCS SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);
UPDATE TVS_Motor SET trade_date = DATE_ADD('1899-12-30', INTERVAL CAST(Date AS UNSIGNED) DAY);

-- Clean commas from all numeric columns for Eicher_Motors
UPDATE Eicher_Motors SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');

UPDATE Bajaj_Auto SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');

UPDATE Hero_MotoCorp SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');

UPDATE Infosys SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');

UPDATE TCS SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');

UPDATE TVS_Motor SET 
    Prev_Close = REPLACE(Prev_Close, ',', ''),
    Open_Price = REPLACE(Open_Price, ',', ''),
    High_Price = REPLACE(High_Price, ',', ''),
    Low_Price = REPLACE(Low_Price, ',', ''),
    Last_Price = REPLACE(Last_Price, ',', ''),
    Close_Price = REPLACE(Close_Price, ',', ''),
    Average_Price = REPLACE(Average_Price, ',', ''),
    Total_Traded_Quantity = REPLACE(Total_Traded_Quantity, ',', ''),
    Turnover = REPLACE(Turnover, ',', ''),
    No_of_Trades = REPLACE(No_of_Trades, ',', ''),
    Deliverable_Qty = REPLACE(Deliverable_Qty, ',', '');
    
    -- Check date conversion
SELECT Date, trade_date FROM Eicher_Motors LIMIT 5;

-- Check number cleaning (should have no commas)
SELECT Total_Traded_Quantity, Turnover FROM Eicher_Motors LIMIT 5;

-- Price Performance Summary 
SELECT 
    Symbol,
    MIN(CAST(Close_Price AS DECIMAL(12,2))) AS min_close,
    MAX(CAST(Close_Price AS DECIMAL(12,2))) AS max_close,
    AVG(CAST(Close_Price AS DECIMAL(12,2))) AS avg_close
FROM Eicher_Motors
WHERE Series = 'EQ'
GROUP BY Symbol;
-- 'EICHERMOT', '2256.05', '7324.00', '3902.127016'

-- Volume Analysis
SELECT 
    Symbol,
    AVG(CAST(Total_Traded_Quantity AS UNSIGNED)) AS avg_daily_volume,
    SUM(CAST(Turnover AS DECIMAL(18,2))) AS total_turnover
FROM Eicher_Motors
WHERE Series = 'EQ'
GROUP BY Symbol;
-- EICHERMOT	709230.0863	3222976623140.85

-- Null/Empty value replacement
-- Bajaj_Auto
UPDATE Bajaj_Auto SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE Bajaj_Auto SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- Eicher_Motors
UPDATE Eicher_Motors SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE Eicher_Motors SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- Hero_MotoCorp
UPDATE Hero_MotoCorp SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE Hero_MotoCorp SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- Infosys
UPDATE Infosys SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE Infosys SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- TCS
UPDATE TCS SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE TCS SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- TVS_Motor
UPDATE TVS_Motor SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '-' OR Deliverable_Qty = '';
UPDATE TVS_Motor SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = '';

-- Clean empty/invalid values
-- Bajaj_Auto
UPDATE Bajaj_Auto SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE Bajaj_Auto SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE Bajaj_Auto SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE Bajaj_Auto SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE Bajaj_Auto SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE Bajaj_Auto SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE Bajaj_Auto SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE Bajaj_Auto SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE Bajaj_Auto SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE Bajaj_Auto SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE Bajaj_Auto SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE Bajaj_Auto SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- Eicher_Motors
UPDATE Eicher_Motors SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE Eicher_Motors SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE Eicher_Motors SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE Eicher_Motors SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE Eicher_Motors SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE Eicher_Motors SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE Eicher_Motors SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE Eicher_Motors SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE Eicher_Motors SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE Eicher_Motors SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE Eicher_Motors SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE Eicher_Motors SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- Hero_MotoCorp
UPDATE Hero_MotoCorp SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE Hero_MotoCorp SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE Hero_MotoCorp SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE Hero_MotoCorp SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE Hero_MotoCorp SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE Hero_MotoCorp SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE Hero_MotoCorp SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE Hero_MotoCorp SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE Hero_MotoCorp SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE Hero_MotoCorp SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE Hero_MotoCorp SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE Hero_MotoCorp SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- Infosys
UPDATE Infosys SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE Infosys SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE Infosys SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE Infosys SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE Infosys SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE Infosys SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE Infosys SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE Infosys SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE Infosys SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE Infosys SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE Infosys SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE Infosys SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- TCS
UPDATE TCS SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE TCS SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE TCS SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE TCS SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE TCS SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE TCS SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE TCS SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE TCS SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE TCS SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE TCS SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE TCS SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE TCS SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- TVS_Motor
UPDATE TVS_Motor SET Prev_Close = NULL WHERE Prev_Close = '' OR Prev_Close = '-';
UPDATE TVS_Motor SET Open_Price = NULL WHERE Open_Price = '' OR Open_Price = '-';
UPDATE TVS_Motor SET High_Price = NULL WHERE High_Price = '' OR High_Price = '-';
UPDATE TVS_Motor SET Low_Price = NULL WHERE Low_Price = '' OR Low_Price = '-';
UPDATE TVS_Motor SET Last_Price = NULL WHERE Last_Price = '' OR Last_Price = '-';
UPDATE TVS_Motor SET Close_Price = NULL WHERE Close_Price = '' OR Close_Price = '-';
UPDATE TVS_Motor SET Average_Price = NULL WHERE Average_Price = '' OR Average_Price = '-';
UPDATE TVS_Motor SET Total_Traded_Quantity = NULL WHERE Total_Traded_Quantity = '' OR Total_Traded_Quantity = '-';
UPDATE TVS_Motor SET Turnover = NULL WHERE Turnover = '' OR Turnover = '-';
UPDATE TVS_Motor SET No_of_Trades = NULL WHERE No_of_Trades = '' OR No_of_Trades = '-';
UPDATE TVS_Motor SET Deliverable_Qty = NULL WHERE Deliverable_Qty = '' OR Deliverable_Qty = '-';
UPDATE TVS_Motor SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE Percent_Dly_Qt_to_Traded_Qty = '' OR Percent_Dly_Qt_to_Traded_Qty = '-';

-- Convert TEXT to numeric types 
ALTER TABLE Bajaj_Auto 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

-- Handle ALL non-numeric values (empty, dash, spaces, nulls)
UPDATE Bajaj_Auto SET Prev_Close = NULL WHERE TRIM(Prev_Close) = '' OR Prev_Close = '-' OR Prev_Close = ' ' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Open_Price = NULL WHERE TRIM(Open_Price) = '' OR Open_Price = '-' OR Open_Price = ' ' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET High_Price = NULL WHERE TRIM(High_Price) = '' OR High_Price = '-' OR High_Price = ' ' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Low_Price = NULL WHERE TRIM(Low_Price) = '' OR Low_Price = '-' OR Low_Price = ' ' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Last_Price = NULL WHERE TRIM(Last_Price) = '' OR Last_Price = '-' OR Last_Price = ' ' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Close_Price = NULL WHERE TRIM(Close_Price) = '' OR Close_Price = '-' OR Close_Price = ' ' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Average_Price = NULL WHERE TRIM(Average_Price) = '' OR Average_Price = '-' OR Average_Price = ' ' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET Total_Traded_Quantity = NULL WHERE TRIM(Total_Traded_Quantity) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity = ' ' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE Bajaj_Auto SET Turnover = NULL WHERE TRIM(Turnover) = '' OR Turnover = '-' OR Turnover = ' ' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Bajaj_Auto SET No_of_Trades = NULL WHERE TRIM(No_of_Trades) = '' OR No_of_Trades = '-' OR No_of_Trades = ' ' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE Bajaj_Auto SET Deliverable_Qty = NULL WHERE TRIM(Deliverable_Qty) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty = ' ' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE Bajaj_Auto SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(Percent_Dly_Qt_to_Traded_Qty) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty = ' ' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

-- Now try ALTER TABLE
ALTER TABLE Bajaj_Auto 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

UPDATE Eicher_Motors SET Prev_Close = NULL WHERE TRIM(COALESCE(Prev_Close, '')) = '' OR Prev_Close = '-' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Open_Price = NULL WHERE TRIM(COALESCE(Open_Price, '')) = '' OR Open_Price = '-' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET High_Price = NULL WHERE TRIM(COALESCE(High_Price, '')) = '' OR High_Price = '-' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Low_Price = NULL WHERE TRIM(COALESCE(Low_Price, '')) = '' OR Low_Price = '-' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Last_Price = NULL WHERE TRIM(COALESCE(Last_Price, '')) = '' OR Last_Price = '-' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Close_Price = NULL WHERE TRIM(COALESCE(Close_Price, '')) = '' OR Close_Price = '-' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Average_Price = NULL WHERE TRIM(COALESCE(Average_Price, '')) = '' OR Average_Price = '-' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET Total_Traded_Quantity = NULL WHERE TRIM(COALESCE(Total_Traded_Quantity, '')) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE Eicher_Motors SET Turnover = NULL WHERE TRIM(COALESCE(Turnover, '')) = '' OR Turnover = '-' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Eicher_Motors SET No_of_Trades = NULL WHERE TRIM(COALESCE(No_of_Trades, '')) = '' OR No_of_Trades = '-' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE Eicher_Motors SET Deliverable_Qty = NULL WHERE TRIM(COALESCE(Deliverable_Qty, '')) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE Eicher_Motors SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(COALESCE(Percent_Dly_Qt_to_Traded_Qty, '')) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

ALTER TABLE Eicher_Motors 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

UPDATE Hero_MotoCorp SET Prev_Close = NULL WHERE TRIM(COALESCE(Prev_Close, '')) = '' OR Prev_Close = '-' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Open_Price = NULL WHERE TRIM(COALESCE(Open_Price, '')) = '' OR Open_Price = '-' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET High_Price = NULL WHERE TRIM(COALESCE(High_Price, '')) = '' OR High_Price = '-' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Low_Price = NULL WHERE TRIM(COALESCE(Low_Price, '')) = '' OR Low_Price = '-' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Last_Price = NULL WHERE TRIM(COALESCE(Last_Price, '')) = '' OR Last_Price = '-' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Close_Price = NULL WHERE TRIM(COALESCE(Close_Price, '')) = '' OR Close_Price = '-' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Average_Price = NULL WHERE TRIM(COALESCE(Average_Price, '')) = '' OR Average_Price = '-' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET Total_Traded_Quantity = NULL WHERE TRIM(COALESCE(Total_Traded_Quantity, '')) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE Hero_MotoCorp SET Turnover = NULL WHERE TRIM(COALESCE(Turnover, '')) = '' OR Turnover = '-' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Hero_MotoCorp SET No_of_Trades = NULL WHERE TRIM(COALESCE(No_of_Trades, '')) = '' OR No_of_Trades = '-' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE Hero_MotoCorp SET Deliverable_Qty = NULL WHERE TRIM(COALESCE(Deliverable_Qty, '')) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE Hero_MotoCorp SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(COALESCE(Percent_Dly_Qt_to_Traded_Qty, '')) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

ALTER TABLE Hero_MotoCorp 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

UPDATE Infosys SET Prev_Close = NULL WHERE TRIM(COALESCE(Prev_Close, '')) = '' OR Prev_Close = '-' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Open_Price = NULL WHERE TRIM(COALESCE(Open_Price, '')) = '' OR Open_Price = '-' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET High_Price = NULL WHERE TRIM(COALESCE(High_Price, '')) = '' OR High_Price = '-' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Low_Price = NULL WHERE TRIM(COALESCE(Low_Price, '')) = '' OR Low_Price = '-' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Last_Price = NULL WHERE TRIM(COALESCE(Last_Price, '')) = '' OR Last_Price = '-' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Close_Price = NULL WHERE TRIM(COALESCE(Close_Price, '')) = '' OR Close_Price = '-' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Average_Price = NULL WHERE TRIM(COALESCE(Average_Price, '')) = '' OR Average_Price = '-' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET Total_Traded_Quantity = NULL WHERE TRIM(COALESCE(Total_Traded_Quantity, '')) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE Infosys SET Turnover = NULL WHERE TRIM(COALESCE(Turnover, '')) = '' OR Turnover = '-' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE Infosys SET No_of_Trades = NULL WHERE TRIM(COALESCE(No_of_Trades, '')) = '' OR No_of_Trades = '-' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE Infosys SET Deliverable_Qty = NULL WHERE TRIM(COALESCE(Deliverable_Qty, '')) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE Infosys SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(COALESCE(Percent_Dly_Qt_to_Traded_Qty, '')) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

ALTER TABLE Infosys 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

UPDATE TCS SET Prev_Close = NULL WHERE TRIM(COALESCE(Prev_Close, '')) = '' OR Prev_Close = '-' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Open_Price = NULL WHERE TRIM(COALESCE(Open_Price, '')) = '' OR Open_Price = '-' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET High_Price = NULL WHERE TRIM(COALESCE(High_Price, '')) = '' OR High_Price = '-' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Low_Price = NULL WHERE TRIM(COALESCE(Low_Price, '')) = '' OR Low_Price = '-' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Last_Price = NULL WHERE TRIM(COALESCE(Last_Price, '')) = '' OR Last_Price = '-' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Close_Price = NULL WHERE TRIM(COALESCE(Close_Price, '')) = '' OR Close_Price = '-' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Average_Price = NULL WHERE TRIM(COALESCE(Average_Price, '')) = '' OR Average_Price = '-' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET Total_Traded_Quantity = NULL WHERE TRIM(COALESCE(Total_Traded_Quantity, '')) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE TCS SET Turnover = NULL WHERE TRIM(COALESCE(Turnover, '')) = '' OR Turnover = '-' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TCS SET No_of_Trades = NULL WHERE TRIM(COALESCE(No_of_Trades, '')) = '' OR No_of_Trades = '-' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE TCS SET Deliverable_Qty = NULL WHERE TRIM(COALESCE(Deliverable_Qty, '')) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE TCS SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(COALESCE(Percent_Dly_Qt_to_Traded_Qty, '')) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

ALTER TABLE TCS 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

UPDATE TVS_Motor SET Prev_Close = NULL WHERE TRIM(COALESCE(Prev_Close, '')) = '' OR Prev_Close = '-' OR Prev_Close NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Open_Price = NULL WHERE TRIM(COALESCE(Open_Price, '')) = '' OR Open_Price = '-' OR Open_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET High_Price = NULL WHERE TRIM(COALESCE(High_Price, '')) = '' OR High_Price = '-' OR High_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Low_Price = NULL WHERE TRIM(COALESCE(Low_Price, '')) = '' OR Low_Price = '-' OR Low_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Last_Price = NULL WHERE TRIM(COALESCE(Last_Price, '')) = '' OR Last_Price = '-' OR Last_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Close_Price = NULL WHERE TRIM(COALESCE(Close_Price, '')) = '' OR Close_Price = '-' OR Close_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Average_Price = NULL WHERE TRIM(COALESCE(Average_Price, '')) = '' OR Average_Price = '-' OR Average_Price NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET Total_Traded_Quantity = NULL WHERE TRIM(COALESCE(Total_Traded_Quantity, '')) = '' OR Total_Traded_Quantity = '-' OR Total_Traded_Quantity NOT REGEXP '^[0-9]+$';
UPDATE TVS_Motor SET Turnover = NULL WHERE TRIM(COALESCE(Turnover, '')) = '' OR Turnover = '-' OR Turnover NOT REGEXP '^[0-9]+\.?[0-9]*$';
UPDATE TVS_Motor SET No_of_Trades = NULL WHERE TRIM(COALESCE(No_of_Trades, '')) = '' OR No_of_Trades = '-' OR No_of_Trades NOT REGEXP '^[0-9]+$';
UPDATE TVS_Motor SET Deliverable_Qty = NULL WHERE TRIM(COALESCE(Deliverable_Qty, '')) = '' OR Deliverable_Qty = '-' OR Deliverable_Qty NOT REGEXP '^[0-9]+$';
UPDATE TVS_Motor SET Percent_Dly_Qt_to_Traded_Qty = NULL WHERE TRIM(COALESCE(Percent_Dly_Qt_to_Traded_Qty, '')) = '' OR Percent_Dly_Qt_to_Traded_Qty = '-' OR Percent_Dly_Qt_to_Traded_Qty NOT REGEXP '^[0-9]+\.?[0-9]*$';

ALTER TABLE TVS_Motor 
    MODIFY COLUMN Prev_Close DECIMAL(12,2),
    MODIFY COLUMN Open_Price DECIMAL(12,2),
    MODIFY COLUMN High_Price DECIMAL(12,2),
    MODIFY COLUMN Low_Price DECIMAL(12,2),
    MODIFY COLUMN Last_Price DECIMAL(12,2),
    MODIFY COLUMN Close_Price DECIMAL(12,2),
    MODIFY COLUMN Average_Price DECIMAL(12,2),
    MODIFY COLUMN Total_Traded_Quantity BIGINT,
    MODIFY COLUMN Turnover DECIMAL(18,2),
    MODIFY COLUMN No_of_Trades INT,
    MODIFY COLUMN Deliverable_Qty BIGINT,
    MODIFY COLUMN Percent_Dly_Qt_to_Traded_Qty DECIMAL(6,2);

SET SQL_SAFE_UPDATES = 1;
-- Enables Safe Update Mode (blocks UPDATE/DELETE without WHERE using a KEY)

-- Check final structure
DESCRIBE Bajaj_Auto;

-- Sample data check
SELECT Symbol, trade_date, Close_Price, Total_Traded_Quantity, Turnover 
FROM Bajaj_Auto 
LIMIT 5;

-- 1. Price Performance Summary
SELECT 
    Symbol,
    MIN(Close_Price) AS Min_Close,
    MAX(Close_Price) AS Max_Close,
    AVG(Close_Price) AS Avg_Close,
    (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 AS Price_Range_Pct
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM TCS WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol;
-- Symbol Min_Close Max_Close Avg_Close Price_Range_Pct
-- BAJAJ-AUTO	3105.20	12666.40	6020.100161	307.909313
-- EICHERMOT	2256.05	7324.00	3902.127016	224.638195
-- HEROMOTOCO	2198.70	6350.50	3623.149476	188.829763
-- INFY	1223.40	1999.70	1569.796210	63.454308
-- TCS	2888.40	4553.75	3524.477903	57.656488
-- TVSMOTOR	488.15	3719.80	1622.633024	662.019871
-- TVS Motor is the top performer with an extraordinary 662% price range growth (from ₹488 to ₹3,720), indicating massive 
-- appreciation over the data period. Bajaj Auto and Eicher Motors show strong performance with price ranges of 308% and 225% 
-- respectively. Both are in the premium two-wheeler/auto segment with average closing prices above ₹3,900, indicating stable 
-- high-value stocks with solid growth. IT stocks (Infosys & TCS) are the most stable but with modest growth — Infosys (63%) and 
-- TCS (58%) have the lowest price range percentages, reflecting their nature as mature, large-cap defensive stocks with lower 
-- volatility compared to the auto sector stocks.

-- 2. Latest Prices (Most Recent Trading Date)
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM Bajaj_Auto WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t1
UNION ALL
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM Eicher_Motors WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t2
UNION ALL
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM Hero_MotoCorp WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t3
UNION ALL
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM Infosys WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t4
UNION ALL
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM TCS WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t5
UNION ALL
SELECT * FROM (
    SELECT Symbol, trade_date, Close_Price FROM TVS_Motor WHERE Series = 'EQ' ORDER BY trade_date DESC LIMIT 1
) AS t6;
-- Symbol trade_date Close_Price
-- BAJAJ-AUTO	2025-12-31	9343.00
-- EICHERMOT	2025-12-31	7312.50
-- HEROMOTOCO	2025-12-31	5771.00
-- INFY	2025-12-31	1615.40
-- TCS	2025-12-31	3206.20
-- TVSMOTOR	2025-12-31	3719.80
-- Bajaj Auto leads at ₹9,343, followed by Eicher Motors at ₹7,312.50 and Hero MotoCorp at ₹5,771. These premium valuations 
-- reflect the strong market positioning of India's leading two-wheeler manufacturers. Infosys (₹1,615.40) and TCS (₹3,206.20) 
-- have lower per-share prices, but this reflects their higher share counts; both remain trillion-dollar market cap companies 
-- with massive institutional holdings. TVS Motor shows remarkable growth momentum — At ₹3,719.80, TVS has the highest price in 
-- its history (recall its 52-week low was just ₹488), indicating exceptional investor confidence and strong business performance 
-- in the two-wheeler segment.

-- 3. Volume & Turnover Analysis
SELECT 
    Symbol,
    AVG(Total_Traded_Quantity) AS Avg_Daily_Volume,
    SUM(Turnover) AS Total_Turnover,
    AVG(No_of_Trades) AS Avg_Daily_Trades
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Total_Traded_Quantity), SUM(Turnover), AVG(No_of_Trades) FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Total_Traded_Quantity), SUM(Turnover), AVG(No_of_Trades) FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Total_Traded_Quantity), SUM(Turnover), AVG(No_of_Trades) FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Total_Traded_Quantity), SUM(Turnover), AVG(No_of_Trades) FROM TCS WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Total_Traded_Quantity), SUM(Turnover), AVG(No_of_Trades) FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol
ORDER BY Avg_Daily_Volume DESC;
# Symbol, Avg_Daily_Volume, Total_Turnover, Avg_Daily_Trades
#'INFY', '6879732.1968', '13261555878126.95', '209709.9347'
#'TCS', '2422485.1815', '10550940063905.55', '146097.7532'
#'TVSMOTOR', '1509662.9210', '2330280982056.95', '49598.4879'
#'HEROMOTOCO', '711922.2274', '3263206115239.55', '56220.8685'
#'EICHERMOT', '709230.0863', '3222976623140.85', '55756.3766'
#'BAJAJ-AUTO', '463548.9331', '3439436130208.15', '47031.1024'
-- Infosys leads with an average daily volume of 68.8 lakh shares and total turnover of ₹13,261 trillion, followed by TCS with 24.2 lakh 
-- shares daily. This reflects the massive retail and institutional participation in India's largest IT companies due to their 
-- high weightage in benchmark indices. Bajaj Auto has the lowest average daily volume (4.6 lakh shares) among all stocks, while 
-- TVS Motor, Hero MotoCorp, and Eicher Motors trade between 7-15 lakh shares daily. Despite lower volumes, auto stocks maintain 
-- healthy turnover due to their higher per-share prices. Infosys and TCS have the highest number of daily trades (2.1 lakh and 
-- 1.5 lakh respectively) because their lower share prices (₹1,600 and ₹3,200) make them more accessible to retail investors 
-- compared to premium-priced auto stocks like Bajaj Auto (₹9,343) and Eicher Motors (₹7,312).

-- 4. Volatility Analysis
SELECT 
    Symbol,
    AVG((High_Price - Low_Price) / Close_Price * 100) AS Avg_Daily_Range_Pct,
    STDDEV(Close_Price) AS Price_Std_Dev,
    STDDEV(Close_Price) / AVG(Close_Price) * 100 AS Coeff_of_Variation
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG((High_Price - Low_Price) / Close_Price * 100), STDDEV(Close_Price), STDDEV(Close_Price) / AVG(Close_Price) * 100 FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG((High_Price - Low_Price) / Close_Price * 100), STDDEV(Close_Price), STDDEV(Close_Price) / AVG(Close_Price) * 100 FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG((High_Price - Low_Price) / Close_Price * 100), STDDEV(Close_Price), STDDEV(Close_Price) / AVG(Close_Price) * 100 FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG((High_Price - Low_Price) / Close_Price * 100), STDDEV(Close_Price), STDDEV(Close_Price) / AVG(Close_Price) * 100 FROM TCS WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG((High_Price - Low_Price) / Close_Price * 100), STDDEV(Close_Price), STDDEV(Close_Price) / AVG(Close_Price) * 100 FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol
ORDER BY Avg_Daily_Range_Pct DESC;
# Symbol, Avg_Daily_Range_Pct, Price_Std_Dev, Coeff_of_Variation
#'TVSMOTOR', '2.6801766315', '944.988592630483', '58.237973623177275'
#'EICHERMOT', '2.4112507403', '1282.7418998100093', '32.87288943973225'
#'HEROMOTOCO', '2.3549144718', '1098.2804000742378', '30.312864744006074'
#'BAJAJ-AUTO', '2.1501883758', '2530.4167450140626', '42.03280140229161'
#'INFY', '1.8620867000', '181.3061493721317', '11.549661558262848'
#'TCS', '1.7748206411', '383.39217248533197', '10.877984853714558'
-- TVS Motor is the most volatile stock with the highest average daily range of 2.68% and an extremely high coefficient of variation (CV)
-- of 58.24%, indicating significant price swings and unpredictability. This aligns with its massive 662% price growth — high 
-- returns come with high risk. All four auto stocks (TVS, Eicher, Hero, Bajaj) have daily ranges above 2.1%, while IT giants 
-- Infosys (1.86%) and TCS (1.77%) show much calmer daily price movements. This reflects the defensive nature of large-cap IT 
-- stocks versus the cyclical auto sector. TCS and Infosys have the lowest coefficient of variation at 10.88% and 11.55% 
-- respectively, meaning their prices deviate minimally from the average. These are ideal for risk-averse investors seeking 
-- steady, predictable returns with minimal price fluctuation.

-- 5. Delivery Percentage Analysis
SELECT 
    Symbol,
    AVG(Percent_Dly_Qt_to_Traded_Qty) AS Avg_Delivery_Pct,
    MIN(Percent_Dly_Qt_to_Traded_Qty) AS Min_Delivery_Pct,
    MAX(Percent_Dly_Qt_to_Traded_Qty) AS Max_Delivery_Pct
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Percent_Dly_Qt_to_Traded_Qty), MIN(Percent_Dly_Qt_to_Traded_Qty), MAX(Percent_Dly_Qt_to_Traded_Qty) FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Percent_Dly_Qt_to_Traded_Qty), MIN(Percent_Dly_Qt_to_Traded_Qty), MAX(Percent_Dly_Qt_to_Traded_Qty) FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Percent_Dly_Qt_to_Traded_Qty), MIN(Percent_Dly_Qt_to_Traded_Qty), MAX(Percent_Dly_Qt_to_Traded_Qty) FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Percent_Dly_Qt_to_Traded_Qty), MIN(Percent_Dly_Qt_to_Traded_Qty), MAX(Percent_Dly_Qt_to_Traded_Qty) FROM TCS WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, AVG(Percent_Dly_Qt_to_Traded_Qty), MIN(Percent_Dly_Qt_to_Traded_Qty), MAX(Percent_Dly_Qt_to_Traded_Qty) FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol;
# Symbol, Avg_Delivery_Pct, Min_Delivery_Pct, Max_Delivery_Pct
#'BAJAJ-AUTO', '47.220661', '7.30', '80.45'
#'EICHERMOT', '46.920895', '9.75', '80.86'
#'HEROMOTOCO', '46.115774', '12.03', '80.29'
#'INFY', '62.053718', '20.16', '81.51'
#'TCS', '59.722548', '18.80', '81.24'
#'TVSMOTOR', '43.604161', '6.43', '81.70'
-- Infosys leads with 62.05% average delivery, followed by TCS at 59.72%, indicating stronger institutional and long-term investor 
-- participation. Higher delivery percentage suggests investors are taking actual delivery of shares rather than squaring off 
-- positions intraday, reflecting genuine buying interest. TVS Motor has the lowest average delivery at 43.60% with a minimum of 
-- just 6.43%, while Bajaj Auto and Eicher Motors hover around 47%. This indicates more speculative/intraday trading activity in 
-- auto stocks, consistent with their higher price volatility. The max delivery percentage across all 6 stocks ranges from 80.29% 
-- to 81.70%, suggesting that on certain high-conviction trading days (likely around earnings or major announcements), investors 
-- across all sectors show similar strong commitment to holding positions.

-- 6. Monthly Performance (Last 12 Months)
SELECT 
    Symbol,
    YEAR(trade_date) AS Year,
    MONTH(trade_date) AS Month,
    MIN(Low_Price) AS Monthly_Low,
    MAX(High_Price) AS Monthly_High,
    AVG(Close_Price) AS Avg_Close
FROM Bajaj_Auto 
WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY Symbol, YEAR(trade_date), MONTH(trade_date)
ORDER BY Year DESC, Month DESC;
# Symbol, Year, Month, Monthly_Low, Monthly_High, Avg_Close
#'BAJAJ-AUTO', '2025', '12', '8735.00', '9398.00', '9059.454545'
#'BAJAJ-AUTO', '2025', '11', '8605.00', '9254.50', '8910.473684'
#'BAJAJ-AUTO', '2025', '10', '8491.50', '9236.50', '8970.833333'
#'BAJAJ-AUTO', '2025', '9', '8640.00', '9490.00', '9022.227273'
#'BAJAJ-AUTO', '2025', '8', '7858.50', '8872.50', '8440.315789'
#'BAJAJ-AUTO', '2025', '7', '7930.50', '8484.00', '8270.804348'
#'BAJAJ-AUTO', '2025', '6', '8250.00', '8770.00', '8500.380952'
#'BAJAJ-AUTO', '2025', '5', '7612.00', '9007.00', '8371.523810'
#'BAJAJ-AUTO', '2025', '4', '7977.50', '8169.50', '8054.250000'
-- Bajaj Auto showed consistent price appreciation from July 2025 (avg ₹8,270) to December 2025 (avg ₹9,059), representing a 
-- ~9.5% gain over 6 months. The stock hit its peak monthly high of ₹9,490 in September 2025, indicating strong bullish momentum 
-- during Q3-Q4. With a monthly range from ₹7,612 to ₹9,007 (a spread of ₹1,395 or ~18%), May experienced the widest price swings,
-- likely due to significant market events, earnings announcements, or sector-wide movements affecting investor sentiment.

-- 7. Top 10 Highest Volume Days (All Stocks)
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM Bajaj_Auto WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
UNION ALL
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM Eicher_Motors WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
UNION ALL
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM Hero_MotoCorp WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
UNION ALL
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM Infosys WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
UNION ALL
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM TCS WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
UNION ALL
(SELECT Symbol, trade_date, Total_Traded_Quantity, Turnover FROM TVS_Motor WHERE Series = 'EQ' ORDER BY Total_Traded_Quantity DESC LIMIT 10)
ORDER BY Total_Traded_Quantity DESC
LIMIT 20;
# Symbol, trade_date, Total_Traded_Quantity, Turnover
#'INFY', '2023-04-17', '53171705', '65931104710.55'
#'INFY', '2023-07-21', '45548305', '60726622128.55'
#'TVSMOTOR', '2021-04-28', '39663387', '25450647659.90'
#'INFY', '2024-05-31', '37113815', '52491266228.35'
#'TVSMOTOR', '2021-01-29', '33901681', '19566319691.20'
#'INFY', '2022-04-18', '30523965', '49630097106.35'
#'INFY', '2024-07-19', '29819116', '53988794114.70'
#'INFY', '2021-01-14', '27521697', '37411219055.40'
#'TVSMOTOR', '2022-11-30', '27363975', '28675243796.60'
#'INFY', '2024-01-12', '26754401', '42748463414.70'
#'TVSMOTOR', '2021-11-09', '25844281', '19684179046.00'
#'INFY', '2021-04-15', '25342491', '34145935655.55'
#'INFY', '2024-06-07', '24075302', '36673507939.55'
#'INFY', '2025-12-22', '23098923', '38872218965.50'
#'TVSMOTOR', '2021-10-22', '18455677', '11402533252.15'
#'TVSMOTOR', '2021-12-15', '14240307', '9801469443.45'
#'TCS', '2024-07-12', '13509164', '55617454764.65'
#'TVSMOTOR', '2021-02-02', '13069121', '7972975868.90'
#'TCS', '2021-10-11', '11845402', '43859658074.25'
#'TCS', '2024-05-31', '10956800', '40368844653.20'
-- The dataset highlights peak liquidity days across INFY, TVSMOTOR, and TCS, showing how volume surges translate (or don’t always
-- translate proportionally) into turnover. These days usually align with results announcements, index rebalancing, macro events,
-- or sector-wide momentum. INFY dominates the top daily volumes, especially post‑2021; TCS shows lower volume but very high 
-- turnover, confirming higher average prices; TVSMOTOR volumes spike strongly, but turnover is comparatively lower, reflecting 
-- its price band

-- 8. Year-over-Year Returns
SELECT 
    Symbol,
    YEAR(trade_date) AS Year,
    (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 AS Annual_Return_Pct
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
UNION ALL
SELECT Symbol, YEAR(trade_date), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
UNION ALL
SELECT Symbol, YEAR(trade_date), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
UNION ALL
SELECT Symbol, YEAR(trade_date), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
UNION ALL
SELECT Symbol, YEAR(trade_date), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM TCS WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
UNION ALL
SELECT Symbol, YEAR(trade_date), (MAX(Close_Price) - MIN(Close_Price)) / MIN(Close_Price) * 100 FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol, YEAR(trade_date)
ORDER BY Year DESC, Symbol;
# Symbol, Year, Annual_Return_Pct
#'BAJAJ-AUTO', '2025', '29.105764'
#'EICHERMOT', '2025', '55.718796'
#'HEROMOTOCO', '2025', '81.801265'
#'INFY', '2025', '40.823340'
#'TCS', '2025', '48.563218'
#'TVSMOTOR', '2025', '70.899568'
#'BAJAJ-AUTO', '2024', '90.042085'
#'EICHERMOT', '2024', '39.988110'
#'HEROMOTOCO', '2024', '56.843892'
#'INFY', '2024', '43.486528'
#'TCS', '2024', '24.188666'
#'TVSMOTOR', '2024', '55.325031'
#'BAJAJ-AUTO', '2023', '92.118540'
#'EICHERMOT', '2023', '46.555532'
#'HEROMOTOCO', '2023', '85.519004'
#'INFY', '2023', '32.172634'
#'TCS', '2023', '24.967633'
#'TVSMOTOR', '2023', '111.233117'
#'BAJAJ-AUTO', '2022', '26.478908'
#'EICHERMOT', '2022', '70.672193'
#'HEROMOTOCO', '2022', '32.507846'
#'INFY', '2022', '42.041085'
#'TCS', '2022', '34.778089'
#'TVSMOTOR', '2022', '120.986606'
#'BAJAJ-AUTO', '2021', '38.317983'
#'EICHERMOT', '2021', '28.278600'
#'HEROMOTOCO', '2021', '52.679560'
#'INFY', '2021', '52.766232'
#'TCS', '2021', '36.632346'
#'TVSMOTOR', '2021', '54.358292'
-- 2021 – Broad-based Recovery Year
-- Top performers: INFY (52.77%), HEROMOTOCO (52.68%), TVSMOTOR (54.36%)
-- Lagging but solid: EICHERMOT (28.28%), BAJAJ‑AUTO (38.32%), TCS (36.63%)
-- 2022 – Auto Takes the Lead
-- Clear winners: TVSMOTOR (120.99%) & EICHERMOT (70.67%)
-- Moderate performers: INFY (42.04%), TCS (34.78%)
-- Laggard: BAJAJ‑AUTO (26.48%)
-- 2023 – Momentum Expansion
-- Exceptional returns: TVSMOTOR (111.23%), BAJAJ‑AUTO (92.12%), HEROMOTOCO (85.52%)
-- IT underperforms autos: INFY (32.17%), TCS (24.97%)
-- 2024 – Rotation, Not Reversal
-- Strong but normalized: BAJAJ‑AUTO (90.04%), TVSMOTOR (55.33%), HEROMOTOCO (56.84%)
-- IT divergence: INFY (43.49%) outperforms TCS (24.19%)
-- 2025 – Moderation & Mean Reversion
-- Top returns: HEROMOTOCO (81.80%), TVSMOTOR (70.90%), EICHERMOT (55.72%)
-- IT remains steady, not explosive: INFY (40.82%), TCS (48.56%)
-- Weakest: BAJAJ‑AUTO (29.11%), 
-- Investment Insights
-- Momentum strategy → TVSMOTOR, HEROMOTOCO (watch entry timing)
-- Core long‑term portfolio → INFY + selective autos
-- Late-cycle caution → BAJAJ‑AUTO exposure should be monitored closely
-- Risk balancing → Pair high‑beta autos with IT exposure

-- 9. 52-Week High/Low
SELECT 
    Symbol,
    MIN(Low_Price) AS 52_Week_Low,
    MAX(High_Price) AS 52_Week_High,
    (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 AS 52_Week_Range_Pct
FROM Bajaj_Auto WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Low_Price), MAX(High_Price), (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 FROM Eicher_Motors WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Low_Price), MAX(High_Price), (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 FROM Hero_MotoCorp WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Low_Price), MAX(High_Price), (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 FROM Infosys WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Low_Price), MAX(High_Price), (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 FROM TCS WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol
UNION ALL
SELECT Symbol, MIN(Low_Price), MAX(High_Price), (MAX(High_Price) - MIN(Low_Price)) / MIN(Low_Price) * 100 FROM TVS_Motor WHERE Series = 'EQ' AND trade_date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK) GROUP BY Symbol;
# Symbol, 52_Week_Low, 52_Week_High, 52_Week_Range_Pct
#'BAJAJ-AUTO', '7612.00', '9490.00', '24.671571'
#'EICHERMOT', '5219.50', '7374.50', '41.287480'
#'HEROMOTOCO', '3725.00', '6388.50', '71.503356'
#'INFY', '1414.00', '1693.20', '19.745403'
#'TCS', '2866.60', '3630.50', '26.648294'
#'TVSMOTOR', '2640.00', '3734.90', '41.473485'
-- Highest Volatility
-- HEROMOTOCO (71.5%) → Widest range; strong momentum with high risk–reward.
-- TVSMOTOR (41.5%) and EICHERMOT (41.3%) → High beta autos, suitable for momentum trades.
-- Moderate Volatility
-- TCS (26.6%) and BAJAJ‑AUTO (24.7%) → Balanced moves; trend followers with controlled risk.
-- Lowest Volatility
-- INFY (19.7%) → Most stable; defensive behavior and lower drawdown risk.
-- Takeaway: Autos dominate volatility (especially Hero and TVS), while IT—particularly INFY—offers stability. Ideal pairing: 
-- high-beta autos for upside + INFY/TCS for risk balance.

-- 10. Combined Dashboard Query
SELECT 
    Symbol,
    COUNT(*) AS Trading_Days,
    MIN(trade_date) AS First_Date,
    MAX(trade_date) AS Last_Date,
    MIN(Close_Price) AS Min_Close,
    MAX(Close_Price) AS Max_Close,
    AVG(Close_Price) AS Avg_Close,
    AVG(Total_Traded_Quantity) AS Avg_Volume,
    SUM(Turnover) AS Total_Turnover,
    AVG(Percent_Dly_Qt_to_Traded_Qty) AS Avg_Delivery_Pct
FROM Bajaj_Auto WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, COUNT(*), MIN(trade_date), MAX(trade_date), MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), AVG(Total_Traded_Quantity), SUM(Turnover), AVG(Percent_Dly_Qt_to_Traded_Qty) FROM Eicher_Motors WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, COUNT(*), MIN(trade_date), MAX(trade_date), MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), AVG(Total_Traded_Quantity), SUM(Turnover), AVG(Percent_Dly_Qt_to_Traded_Qty) FROM Hero_MotoCorp WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, COUNT(*), MIN(trade_date), MAX(trade_date), MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), AVG(Total_Traded_Quantity), SUM(Turnover), AVG(Percent_Dly_Qt_to_Traded_Qty) FROM Infosys WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, COUNT(*), MIN(trade_date), MAX(trade_date), MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), AVG(Total_Traded_Quantity), SUM(Turnover), AVG(Percent_Dly_Qt_to_Traded_Qty) FROM TCS WHERE Series = 'EQ' GROUP BY Symbol
UNION ALL
SELECT Symbol, COUNT(*), MIN(trade_date), MAX(trade_date), MIN(Close_Price), MAX(Close_Price), AVG(Close_Price), AVG(Total_Traded_Quantity), SUM(Turnover), AVG(Percent_Dly_Qt_to_Traded_Qty) FROM TVS_Motor WHERE Series = 'EQ' GROUP BY Symbol;
# Symbol, Trading_Days, First_Date, Last_Date, Min_Close, Max_Close, Avg_Close, Avg_Volume, Total_Turnover, Avg_Delivery_Pct
#'BAJAJ-AUTO', '1240', '2021-01-01', '2025-12-31', '3105.20', '12666.40', '6020.100161', '463548.9331', '3439436130208.15', '47.220661'
#'EICHERMOT', '1240', '2021-01-01', '2025-12-31', '2256.05', '7324.00', '3902.127016', '709230.0863', '3222976623140.85', '46.920895'
#'HEROMOTOCO', '1240', '2021-01-01', '2025-12-31', '2198.70', '6350.50', '3623.149476', '711922.2274', '3263206115239.55', '46.115774'
#'INFY', '1240', '2021-01-01', '2025-12-31', '1223.40', '1999.70', '1569.796210', '6879732.1968', '13261555878126.95', '62.053718'
#'TCS', '1240', '2021-01-01', '2025-12-31', '2888.40', '4553.75', '3524.477903', '2422485.1815', '10550940063905.55', '59.722548'
#'TVSMOTOR', '1240', '2021-01-01', '2025-12-31', '488.15', '3719.80', '1622.633024', '1509662.9210', '2330280982056.95', '43.604161'
-- Core/Defensive: INFY, TCS (liquidity + delivery strength).
-- Growth/Momentum: TVSMOTOR, HEROMOTOCO (structural and cyclical upside, higher volatility).
-- Balanced Cyclical: BAJAJ‑AUTO, EICHERMOT (re‑rating with moderation).