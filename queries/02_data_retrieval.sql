-- ==========================================================
-- FILE: data_retrieval.sql
-- DESCRIPTION: Data Verification & Reporting
-- ==========================================================
SET PAGESIZE 100;
SET LINESIZE 200;

-- 1. MASTER REPORT: View All Data for a Specific Country (e.g., United States)
-- Joins Market Data with Countries and Indicators
SELECT 
    c.country_name,
    i.ind_name AS indicator,
    i.category,
    m.data_year,
    m.data_value,
    i.measure_unit
FROM market_data m
JOIN countries c ON m.country_id = c.country_id
JOIN indicators i ON m.ind_id = i.ind_id
WHERE c.country_name = 'United States'
ORDER BY i.category, m.data_year DESC;

-- 2. REGIONAL SUMMARY: Average GDP Growth by Region (2023)
-- Demonstrates aggregation and grouping
SELECT 
    r.region_name,
    COUNT(c.country_id) AS num_countries,
    ROUND(AVG(m.data_value), 2) AS avg_gdp_growth
FROM market_data m
JOIN countries c ON m.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE m.ind_id = 1 -- Assuming Ind ID 1 is 'GDP Growth'
  AND m.data_year = 2023
GROUP BY r.region_name
ORDER BY avg_gdp_growth DESC;

-- 3. DATA VOLUME CHECK: Count rows in all tables
SELECT 'Regions' AS Table_Name, COUNT(*) AS Row_Count FROM regions
UNION ALL
SELECT 'Countries', COUNT(*) FROM countries
UNION ALL
SELECT 'Indicators', COUNT(*) FROM indicators
UNION ALL
SELECT 'Market Data', COUNT(*) FROM market_data;
