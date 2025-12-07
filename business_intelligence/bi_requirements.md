# Business Intelligence Requirements

## 1. Overview
The GlobalInsight BI module is designed to transform raw economic data into actionable strategic intelligence. The system serves Strategy Managers by visualizing market risks, economic trends, and investment opportunities.

## 2. Stakeholders
* **Primary User:** Strategy Managers (Strategic decision-making).
* **Secondary User:** Data Analysts (Data entry validation and error checking).
* **Technical User:** Database Administrators (System health and security auditing).

## 3. Decision Support Needs
The BI solution must answer the following critical business questions:
* Which markets show sustained growth despite global downturns?
* What is the correlation between political instability and currency devaluation in target regions?
* Are there data anomalies (e.g., negative inflation or GDP > 20%) that require auditing?
* Who is attempting to modify critical data outside of authorized hours?

## 4. Reporting Frequency
* **Real-Time:** Security Audit Logs (Immediate visibility of violations).
* **Weekly:** Market Data Refresh (Post-weekend entry window).
* **Quarterly:** Executive Strategy Review (Long-term trend analysis).

## 5. Technical Requirements
* **Data Source:** Oracle Pluggable Database (`tue_27904_ivo_globalinsight_db`).
* **Integration:** Views should be optimized using Window Functions to prevent performance lag.
* **Access Control:** Read-only access for Strategy Managers; Admin access for DBAs.
