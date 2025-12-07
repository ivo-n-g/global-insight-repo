-- ==========================================================
-- FILE: audit_queries.sql
-- DESCRIPTION: Security & Compliance Logs
-- ==========================================================
SET PAGESIZE 100;
SET LINESIZE 200;

-- 1. VIEW ALL SECURITY INCIDENTS (Most Recent First)
-- Shows both "ACCESS_GRANTED" and "ACCESS_DENIED"
SELECT 
    log_id,
    log_time,
    db_user,
    action_type,
    table_affected,
    comments
FROM audit_log
ORDER BY log_time DESC;

-- 2. VIEW ONLY DENIED ACCESS ATTEMPTS (Violations)
-- This proves your Trigger correctly blocked Weekday/Holiday inserts
SELECT 
    log_time,
    db_user,
    comments
FROM audit_log
WHERE action_type = 'ACCESS_DENIED'
ORDER BY log_time DESC;

-- 3. AUDIT SUMMARY BY USER
-- Shows who is trying to access the system most often
SELECT 
    db_user,
    action_type,
    COUNT(*) AS attempt_count
FROM audit_log
GROUP BY db_user, action_type
ORDER BY db_user, attempt_count DESC;
