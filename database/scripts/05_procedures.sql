-- ==========================================================
-- FILE: 05_procedures.sql
-- DESCRIPTION:  Stored Procedures
-- ==========================================================

-- 1. ADD ENTRY (INSERT)
CREATE OR REPLACE PROCEDURE PROC_ADD_MARKET_ENTRY (
    p_country_id IN NUMBER, p_ind_id IN NUMBER, p_year IN NUMBER, p_value IN NUMBER
) IS
BEGIN
    INSERT INTO market_data (country_id, ind_id, data_year, data_value)
    VALUES (p_country_id, p_ind_id, p_year, p_value);
    COMMIT;
EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Duplicate Data');
END;
/

-- 2. ADJUST WEIGHT (UPDATE + IN/OUT)
CREATE OR REPLACE PROCEDURE PROC_ADJUST_WEIGHT (
    p_ind_id IN NUMBER, p_adjustment IN OUT NUMBER
) IS
BEGIN
    UPDATE indicators SET weight = weight + p_adjustment WHERE ind_id = p_ind_id;
    COMMIT;
    SELECT weight INTO p_adjustment FROM indicators WHERE ind_id = p_ind_id;
END;
/

-- 3. PURGE DATA (DELETE)
CREATE OR REPLACE PROCEDURE PROC_PURGE_OLD_DATA (
    p_cutoff_year IN NUMBER, p_deleted_count OUT NUMBER
) IS
BEGIN
    DELETE FROM market_data WHERE data_year < p_cutoff_year;
    p_deleted_count := SQL%ROWCOUNT;
    COMMIT;
END;
/
