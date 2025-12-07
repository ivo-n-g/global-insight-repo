# Architectural Design Decisions

## 1. Pluggable Database (PDB) vs. Traditional Schema
* **Decision:** Implemented the project inside a dedicated PDB (`tue_27904_ivo_globalinsight_db`) rather than a simple schema in the Root container.
* **Justification:** This aligns with modern Oracle Multitenant standards. It allows the entire project to be unplugged and moved to a cloud environment or another server without affecting other users, mimicking real-world "Database-as-a-Service" isolation.

## 2. Normalization Strategy (3NF)
* **Decision:** Separated `REGIONS` and `INDICATORS` into their own lookup tables rather than storing strings in the main table.
* **Justification:**
    * **Data Integrity:** Prevents typos (e.g., "Asia" vs "Aisa").
    * **Storage Efficiency:** Stores integer IDs instead of repeated text strings in the massive `MARKET_DATA` table.
    * **Flexibility:** Allows renaming a region or indicator in one place without updating millions of rows.

## 3. Compound Triggers for Security
* **Decision:** Used a `COMPOUND TRIGGER` for the Weekend-Only restriction rule instead of a simple `BEFORE INSERT` trigger.
* **Justification:** Compound triggers allow us to initialize variables in the `BEFORE STATEMENT` section once per batch, rather than executing logic for every single row. This is more efficient for bulk data loads and avoids common "Mutating Table" errors when querying the table being updated.

## 4. Autonomous Transactions for Auditing
* **Decision:** Defined the `PROC_LOG_AUDIT` procedure with `PRAGMA AUTONOMOUS_TRANSACTION`.
* **Justification:** When a security violation occurs, the main transaction is rolled back (rejected). Without autonomous transactions, the "Access Denied" log entry would *also* be rolled back, leaving no trace of the attempted breach. This feature allows the audit log to be committed independently of the main transaction's failure.

## 5. Window Functions for Analytics
* **Decision:** Used `RANK()`, `LAG()`, and `AVG() OVER()` for reports instead of self-joins or subqueries.
* **Justification:** Window functions process data in memory without collapsing the result set (unlike `GROUP BY`). This allows us to compare a specific country's performance against the regional average on the *same row*, providing superior performance and cleaner code for trend analysis.

## 6. Package Encapsulation
* **Decision:** Grouped core procedures and functions into `PKG_GLOBAL_INSIGHT`.
* **Justification:**
    * **Modularity:** Keeps the global namespace clean.
    * **Performance:** The entire package is loaded into memory at once, reducing I/O for subsequent calls.
    * **Maintenance:** Allows changing the internal body logic without breaking the public specification used by applications.
