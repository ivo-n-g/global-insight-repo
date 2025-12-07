-- ==========================================================
-- DATABASE CREATION SCRIPT
-- Project: GlobalInsight International Business System
-- 1. CONNECT TO ROOT (Ensure you are in the main container)
CONN sys/oracle AS SYSDBA;
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- 2. CREATE PLUGGABLE DATABASE (PDB)
-- Uses the exact path from your error logs
-- Creates the admin user 'IVONKAKA' automatically here
CREATE PLUGGABLE DATABASE tue_27904_ivo_globalinsight_db
    ADMIN USER ivonkaka IDENTIFIED BY ivo
    FILE_NAME_CONVERT = (
        'C:\ORACLE21C\ORADATA\ORCL\PDBSEED\',
        'C:\ORACLE21C\ORADATA\ORCL\tue_27904_ivo_globalinsight_db\'
    );

-- 3. OPEN THE DATABASE & SAVE STATE
-- This ensures the DB creates the files and auto-starts on reboot
ALTER PLUGGABLE DATABASE tue_27904_ivo_globalinsight_db OPEN;
ALTER PLUGGABLE DATABASE tue_27904_ivo_globalinsight_db SAVE STATE;

-- 4. SWITCH CONTEXT (Enter your new database)
ALTER SESSION SET CONTAINER = tue_27904_ivo_globalinsight_db;

-- ==========================================================
-- CONFIGURE TABLESPACES & USER
-- ==========================================================

-- 5. CREATE PERMANENT TABLESPACE (Data)
[cite_start]-- Requirement: "Autoextend parameters set" [cite: 122]
CREATE TABLESPACE tbs_globalinsight_data 
    DATAFILE 'globalinsight_data01.dbf' 
    SIZE 100M 
    AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- 6. CREATE TEMPORARY TABLESPACE (Temp)
[cite_start]-- Requirement: "Temporary tablespace" [cite: 119]
CREATE TEMPORARY TABLESPACE tbs_globalinsight_temp 
    TEMPFILE 'globalinsight_temp01.dbf' 
    SIZE 50M 
    AUTOEXTEND ON NEXT 5M MAXSIZE UNLIMITED;

-- 7. CONFIGURE ADMIN USER
-- Note: User 'ivonkaka' already exists from Step 2.
-- We ALTERS the user to point to the new tablespaces.
ALTER USER ivonkaka 
    DEFAULT TABLESPACE tbs_globalinsight_data
    TEMPORARY TABLESPACE tbs_globalinsight_temp
    QUOTA UNLIMITED ON tbs_globalinsight_data;

-- 8. GRANT PRIVILEGES
[cite_start]-- Requirement: "Privileges: Super admin" [cite: 116]
GRANT CONNECT, RESOURCE, DBA TO ivonkaka;
GRANT CREATE VIEW, CREATE PROCEDURE, CREATE TRIGGER TO ivonkaka;

-- ==========================================================
-- VERIFICATION
-- ==========================================================
SELECT CON_NAME FROM V$CONTAINER; -- Should be your project DB
SELECT username, default_tablespace FROM dba_users WHERE username = 'IVONKAKA';
