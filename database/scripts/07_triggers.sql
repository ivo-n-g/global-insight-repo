-- ==========================================================
-- FILE: 07_triggers.sql
-- DESCRIPTION: Phase VII - Security & Auditing
-- ==========================================================

-- 1. HOLIDAY DATA
INSERT INTO public_holidays VALUES (TO_DATE('2025-12-25','YYYY-MM-DD'), 'Christmas');
INSERT INTO public_holidays VALUES (TRUNC(SYSDATE), 'Testing Holiday'); -- BLOCK TODAY
COMMIT;

-- 2. AUDIT PROC (Autonomous)
CREATE OR REPLACE PROCEDURE PROC_LOG_AUDIT (
    p_act IN VARCHAR2, p_tbl IN VARCHAR2, p_cmt IN VARCHAR2
) IS
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO audit_log (db_user, action_type, table_affected, comments)
    VALUES (USER, p_act, p_tbl, p_cmt);
    COMMIT;
END;
/

-- 3. RESTRICTION FUNCTION
CREATE OR REPLACE FUNCTION FN_IS_RESTRICTED RETURN NUMBER IS
    v_day VARCHAR2(10); v_hol NUMBER;
BEGIN
    SELECT TO_CHAR(SYSDATE, 'DY', 'NLS_DATE_LANGUAGE=ENGLISH') INTO v_day FROM DUAL;
    SELECT COUNT(*) INTO v_hol FROM public_holidays WHERE holiday_date = TRUNC(SYSDATE);
    
    IF (v_day NOT IN ('SAT','SUN')) OR (v_hol > 0) THEN RETURN 1; ELSE RETURN 0; END IF;
END;
/

-- 4. COMPOUND SECURITY TRIGGER
CREATE OR REPLACE TRIGGER trg_strict_security
FOR INSERT OR UPDATE OR DELETE ON market_data
COMPOUND TRIGGER
    v_restricted NUMBER;
    BEFORE STATEMENT IS BEGIN
        v_restricted := FN_IS_RESTRICTED();
        IF v_restricted = 1 THEN
            PROC_LOG_AUDIT('ACCESS_DENIED', 'MARKET_DATA', 'Blocked Restricted Day');
            RAISE_APPLICATION_ERROR(-20005, 'SECURITY ALERT: Weekend Access Only.');
        END IF;
    END BEFORE STATEMENT;
END;
/
