-- ==========================================================
-- FILE: 04_market_data.sql
-- ==========================================================
SET SERVEROUTPUT ON;

BEGIN
    DECLARE
        v_val NUMBER;
    BEGIN
        -- 1. Loop through ALL 100 Real Countries
        FOR c IN (SELECT country_id FROM countries) LOOP
            
            -- 2. Loop through first 15 Indicators (To keep row count ~7,500)
            -- (Change "15" to "100" if you want full data, but it takes longer)
            FOR i IN (SELECT ind_id FROM indicators WHERE ind_id <= 15) LOOP
                
                -- 3. Loop through Years 2020-2024
                FOR y IN 2020..2024 LOOP
                    
                    -- Generate realistic data (-10 to 100 range)
                    v_val := ROUND(DBMS_RANDOM.VALUE(-10, 100), 2);
                    
                    INSERT INTO market_data (country_id, ind_id, data_year, data_value)
                    VALUES (c.country_id, i.ind_id, y, v_val);
                    
                END LOOP;
            END LOOP;
        END LOOP;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Market Data successfully generated for Real Countries.');
    END;
END;
/
