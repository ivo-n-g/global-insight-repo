# System Architecture: GlobalInsight

## 1. System Overview
**GlobalInsight** is a PL/SQL-driven **International Business Evaluation System**. It is designed as a centralized data repository that ingests raw economic indicators, validates them against strict business rules, and computes strategic risk scores to support investment decisions.

The system is built on **Oracle Database 21c** using a **Pluggable Database (PDB)** architecture to ensure isolation and portability.

---

## 2. Technical Stack
* **Database Engine:** Oracle Database 21c (Multitenant Architecture).
* **Container:** `tue_27904_ivo_globalinsight_db` (PDB).
* **Language:** SQL and PL/SQL (Procedural Language extensions to SQL).
* **Client Tools:** Oracle SQL Developer, Oracle Enterprise Manager (OEM) Express.
* **Storage:** Custom Managed Tablespace (`TBS_GLOBALINSIGHT_DATA`) with Auto-extend enabled.

---

## 3. Architecture Layers

### **A. Data Layer (Schema)**
The database schema follows **3rd Normal Form (3NF)** to ensure data integrity and reduce redundancy.
* **Reference Tables:** `REGIONS`, `COUNTRIES`, `INDICATORS`.
* **Fact Table:** `MARKET_DATA` (Stores historical time-series data).
* **Security Tables:** `AUDIT_LOG` (Tracks activity), `PUBLIC_HOLIDAYS` (Defines restriction periods).

### **B. Logic Layer (PL/SQL)**
Business logic is encapsulated entirely within the database using stored program units:
* **Transactional Procedures:** Handle data manipulation (INSERT/UPDATE/DELETE) with exception handling (`PROC_ADD_MARKET_ENTRY`).
* **Calculation Engine:** Stored functions that compute derived metrics on the fly (`FN_CALCULATE_MARKET_SCORE`).
* **Packages:** `PKG_GLOBAL_INSIGHT` groups related logic, providing a modular public interface.

### **C. Security Layer**
Access control is enforced at the database kernel level:
* **Temporal Restrictions:** A **Compound Trigger** (`TRG_STRICT_SECURITY`) blocks modification attempts during Weekdays (Mon-Fri) and Holidays.
* **Auditing:** An **Autonomous Transaction** mechanism records all access attempts (Granted or Denied) to an immutable log table.

### **D. Presentation / BI Layer**
While the backend is headless, it exposes data via:
* **Analytical Views:** SQL queries using Window Functions (`RANK`, `LAG`, `LEAD`) for trend analysis.
* **Dashboards:** Conceptual wireframes for Executive Strategy, Security Auditing, and System Performance.

---

## 4. Entity Relationship Diagram (ERD) Overview

* **Regions (1) ↔ (M) Countries:** Hierarchical lookup.
* **Countries (1) ↔ (M) Market_Data:** Parent-Child relationship.
* **Indicators (1) ↔ (M) Market_Data:** Defines the type of data (GDP, Inflation, etc.).
