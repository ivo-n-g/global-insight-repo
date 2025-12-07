-- ==========================================================
-- FILE: 01_analytics.sql
-- DESCRIPTION: Window Functions & Analytics
-- ==========================================================

-- 1. RANKING REPORT
SELECT region_name, country_name, data_value,
    RANK() OVER (PARTITION BY region_name ORDER BY data_value DESC) as rnk
FROM market_data m 
JOIN countries c ON m.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE ind_id = 1 AND data_year = 2023;

-- 2. TREND REPORT (LAG/LEAD)
SELECT country_name, data_year, data_value,
    LAG(data_value, 1, 0) OVER (PARTITION BY country_name ORDER BY data_year) as prev_year
FROM market_data m JOIN countries c ON m.country_id = c.country_id
WHERE ind_id = 1 AND country_name = 'United States';

-- 3. AGGREGATE OVER PARTITION
SELECT region_name, country_name, data_value,
    ROUND(AVG(data_value) OVER (PARTITION BY region_name), 2) as region_avg
FROM market_data m 
JOIN countries c ON m.country_id = c.country_id
JOIN regions r ON c.region_id = r.region_id
WHERE ind_id = 1 AND data_year = 2023;
