-- ==========================================================
-- FILE: 06_functions.sql
-- DESCRIPTION:  Functions
-- ==========================================================

-- 1. CALCULATE SCORE
CREATE OR REPLACE FUNCTION FN_CALCULATE_MARKET_SCORE (
    p_country_id IN NUMBER, p_year IN NUMBER
) RETURN NUMBER IS
    v_total NUMBER := 0;
BEGIN
    SELECT SUM(m.data_value * i.weight) INTO v_total
    FROM market_data m JOIN indicators i ON m.ind_id = i.ind_id
    WHERE m.country_id = p_country_id AND m.data_year = p_year;
    RETURN ROUND(v_total, 2);
EXCEPTION WHEN OTHERS THEN RETURN 0;
END;
/

-- 2. VALIDATE SCORE
CREATE OR REPLACE FUNCTION FN_VALIDATE_SCORE (p_val IN NUMBER) RETURN VARCHAR2 IS
BEGIN
    IF p_val BETWEEN 0 AND 100 THEN RETURN 'VALID'; ELSE RETURN 'INVALID'; END IF;
END;
/

-- 3. GET RISK LABEL
CREATE OR REPLACE FUNCTION FN_GET_RISK_LABEL (p_score IN NUMBER) RETURN VARCHAR2 IS
BEGIN
    IF p_score >= 80 THEN RETURN 'LOW RISK';
    ELSIF p_score >= 50 THEN RETURN 'MEDIUM RISK';
    ELSE RETURN 'HIGH RISK'; END IF;
END;
/
