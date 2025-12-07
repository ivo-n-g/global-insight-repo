# Project Documentation: GlobalInsight

# System Creation Log

Project Title: GlobalInsight: International Business Evaluation System
Database Name: tue_27904_ivo_globalinsight_db
Developer: Ivo Nkaka (Student ID: 27904)
Date: 7th December 2025

## 1. Executive Summary

The **GlobalInsight System** was developed to solve the problem of manual, disorganized
economic data analysis. By migrating from "flat" spreadsheets to a relational Oracle
Database, the system standardizes how investment risks are calculated. The system features
a 3NF normalized schema, automated risk scoring via PL/SQL, and a strict security layer that
restricts data entry to weekends only.

## 2. System Development Lifecycle (SDLC)

### Requirement Analysis

```
● Goal: Define the scope and identifying user roles.
● Outcome: Identified three key actors:
○ Data Analyst: Inputs raw economic indicators (GDP, Inflation).
○ System (MIS): Validates data and restricts access based on time.
○ Strategy Manager: Consumes BI reports for decision-making.
```
### Business Process Modeling (BPMN)

```
● Goal: Visualize the workflow and decision gateways.
● Implementation: Created a BPMN 2.0 Diagram featuring:
○ Swimlanes for Analyst, System, and Manager.
○ A critical "Time Check" gateway that rejects transactions on Weekdays/Holidays.
```

```
○ A feedback loop for data validation errors.
```
### Logical Database Design

```
● Goal: Design a robust, redundancy-free data structure.
● Normalization:
○ 1NF: Eliminated repeating groups (e.g., 2023_GDP, 2024_GDP) by creating a vertical
MARKET_DATA table.
○ 2NF: Removed partial dependencies by separating CURRENCY_CODE into the
COUNTRIES table.
○ 3NF: Removed transitive dependencies by isolating REGION_NAME into a lookup
table (REGIONS).
● Artifacts: Entity Relationship Diagram (ERD) and Data Dictionary.
```
### Physical Database Setup

```
● Goal: Configure the Oracle Pluggable Database (PDB).
● Technical Specs:
○ PDB Name: tue_27904_ivo_globalinsight_db
○ Admin User: IVONKAKA (Granted DBA privileges).
○ Storage: Created tbs_globalinsight_data with AUTOEXTEND ON (100MB Init).
○ Config: Enabled ARCHIVELOG mode for disaster recovery.
```
### Schema Implementation & Data Population

```
● Goal: Create tables and inject realistic datasets.
● Schema: Implemented 5 core tables (REGIONS, COUNTRIES, INDICATORS,
MARKET_DATA, AUDIT_LOG) with Primary/Foreign Key constraints.
● Data Generation:
○ Imported 100 Real-World Countries (United States, Rwanda, China, etc.).
○ Defined 100 Economic Indicators (GDP Growth, Inflation, Trade Tariffs).
○ Used PL/SQL loops (DBMS_RANDOM) to generate ~50,000 rows of market data.
○ injected Edge Cases (Nulls and Boundary Values) for robust testing.
```
### Advanced PL/SQL Development

```
● Goal: Automate business logic using server-side code.
● Procedures: Created transactional procedures (e.g., PROC_SAFE_MARKET_INSERT) with
SAVEPOINT and ROLLBACK for safe data entry.
● Functions:
○ FN_CALCULATE_MARKET_SCORE: Computes weighted risk scores (0-100).
○ FN_GET_RISK_LABEL: Categorizes scores into "High/Medium/Low Risk".
● Packages: Encapsulated logic into PKG_GLOBAL_INSIGHT for modularity.
● Analytics: Utilized Window Functions (RANK, LAG, OVER) to generate reports comparing
countries against regional averages.
```

### Security & Auditing

```
● Goal: Enforce the "Weekend-Only" business rule.
● Security Implementation:
○ Holiday Management: Created PUBLIC_HOLIDAYS table to track restricted dates.
○ Compound Trigger: TRG_STRICT_SECURITY fires before any
INSERT/UPDATE/DELETE on MARKET_DATA. It checks SYSDATE and blocks
transactions on Weekdays (Mon-Fri) or Holidays.
○ Auditing: Implemented PRAGMA AUTONOMOUS_TRANSACTION to log all failed
attempts (ACCESS_DENIED) to the AUDIT_LOG table, even if the main transaction
rolls back.
```
## 3. File Artifacts & Script Inventory

The system was built using the following ordered SQL scripts:
**Script Name Description**
01_PDB_Creation.sql PDB creation, User setup, Tablespace config.
02_create_tables.sql DDL for Tables, Constraints, and Sequences.
03_insert_data.sql Bulk loading of Regions, Countries, and Indicators.
04_market_data.sql PL/SQL loops to generate statistical market data.
05_procedures.sql Transactional stored procedures with exception handling.
06_functions.sql Calculation and Validation functions.
07_triggers.sql Security triggers and Audit logging logic.
08_analytics.sql Window function queries for BI reporting.


## 4. Conclusion

The GlobalInsight system successfully meets all functional requirements. It provides a secure,
scalable, and automated environment for international market evaluation, transforming raw
data into actionable strategic intelligence.
