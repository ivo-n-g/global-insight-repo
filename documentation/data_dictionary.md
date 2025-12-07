### Data Dictionary

| Table | Column | Type | Constraints | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **REGIONS** | REGION_ID | NUMBER(5) | PK | Unique identifier for the region. |
| | REGION_NAME | VARCHAR2(50) | NOT NULL, UNIQUE | Name of the geographical region (e.g., 'Europe'). |
| **COUNTRIES** | COUNTRY_ID | NUMBER(5) | PK | Unique identifier for the country. |
| | REGION_ID | NUMBER(5) | FK (Ref REGIONS) | Link to the region the country belongs to. |
| | COUNTRY_NAME | VARCHAR2(50) | NOT NULL, UNIQUE | Name of the country. |
| | CURRENCY_CODE | CHAR(3) | None | 3-letter currency code (e.g., 'USD'). |
| **INDICATORS** | IND_ID | NUMBER(5) | PK | Unique identifier for the economic indicator. |
| | IND_NAME | VARCHAR2(100) | NOT NULL | Name of the indicator (e.g., 'GDP Growth'). |
| | CATEGORY | VARCHAR2(20) | CHECK ('ECONOMIC', 'RISK', 'TRADE') | Classification of the indicator type. |
| | WEIGHT | NUMBER(3,2) | CHECK (0-1) | Weight used for risk score calculation. |
| | MEASURE_UNIT | VARCHAR2(20) | None | Unit of measurement (e.g., '%', 'Index'). |
| **MARKET_DATA** | DATA_ID | NUMBER(10) | PK, IDENTITY | Unique identifier for each data record. |
| | COUNTRY_ID | NUMBER(5) | FK (Ref COUNTRIES), NOT NULL | The country this data belongs to. |
| | IND_ID | NUMBER(5) | FK (Ref INDICATORS), NOT NULL | The specific indicator being measured. |
| | DATA_YEAR | NUMBER(4) | CHECK (>1900) | The year the data represents. |
| | DATA_VALUE | NUMBER(15,2) | NOT NULL | The actual statistical value. |
| **AUDIT_LOG** | LOG_ID | NUMBER(10) | PK, IDENTITY | Unique ID for the audit entry. |
| | DB_USER | VARCHAR2(30) | None | The database user who performed the action. |
| | ACTION_TYPE | VARCHAR2(20) | None | Type of action (e.g., 'INSERT', 'ACCESS_DENIED'). |
| | TABLE_AFFECTED| VARCHAR2(30) | None | The table where the action occurred. |
| | LOG_TIME | TIMESTAMP | DEFAULT SYSTIMESTAMP | Timestamp of when the action occurred. |
| | COMMENTS | VARCHAR2(255) | None | Description or reason for the log entry. |
| **PUBLIC_HOLIDAYS**| HOLIDAY_DATE | DATE | PK | The date of the restricted public holiday. |
| | DESCRIPTION | VARCHAR2(50) | None | Name or description of the holiday. |
