# GlobalInsight: International Business Evaluation System

**Student Name:** Ivo Nkaka  
**Student ID:** 27904  
**Course:** PL/SQL Capstone Project  
**Date:** 7th December 2025

---

## 📌 Project Overview
GlobalInsight is a robust Management Information System (MIS) built on Oracle Database 21c. It is designed to ingest, validate, and analyze global economic indicators (such as GDP, Inflation, and Trade Tariffs) to calculate a "Market Attractiveness Score" for potential international investments.

### ❓ Problem Statement
Investment analysts currently rely on disjointed, manual spreadsheets to track global economic trends, leading to data redundancy, security risks, and slow decision-making. This system solves these issues by centralizing data into a secure relational database that automates risk scoring and enforces strict temporal access controls.

### 🎯 Key Objectives
* **Centralize Data:** Migrate flat files into a 3NF normalized Oracle Pluggable Database (PDB).
* **Automate Scoring:** Use PL/SQL Functions to calculate real-time risk scores (0-100) based on weighted economic indicators.
* **Enforce Security:** Implement a strict "Weekend-Only" work policy using Compound Triggers to prevent unauthorized data changes during business hours.
* **Business Intelligence:** Provide actionable strategic insights using advanced SQL Window Functions and aggregate reporting.

---

## 🚀 Quick Start Instructions

To deploy this project from scratch, follow these steps in **Oracle SQL Developer**:

### **Prerequisites**
* Oracle Database 19c or 21c (Multitenant Architecture enabled).
* User access to `SYS` (Root Container).

### **Deployment Order**
Run the provided SQL scripts in the following exact order:

1.  **Environment Setup** (Run as `SYS`):
    * `01_Pluggable_Database_Creation.sql`: Creates the Pluggable Database, Tablespaces, and Admin User (`USER`).

2.  **Schema Construction** (Run as `USER`):
    * `02_create_tables.sql`: Builds the table structure (Regions, Countries, Indicators, Market_Data, Logs).
    * `03_insert_data.sql`: Bulk loads 100 Real Countries and 100 Indicators.
    * `04_market_data.sql`: Generates ~50,000 rows of statistical market data.

3.  **Logic Implementation** (Run as `USER`):
    * `05_procedures.sql`: Deploys transactional stored procedures.
    * `06_functions.sql`: Deploys calculation and validation functions.
  
4.  **Security & Reporting** (Run as `USER`):
    * `07_triggers.sql`: Activates the "Weekend-Only" Compound Trigger and Audit system.
    * `01_analytics.sql`: Generates the data for Executives.

---

## 📚 Documentation Links

For detailed technical specifications, please refer to the documentation files included in this repository:

* **[System Architecture](architecture.md):** Overview of the PDB structure, technical stack, and schema layers.
* **[Design Decisions](design_decisions.md):** Justification for technical choices (e.g., Normalization, Compound Triggers, Autonomous Transactions).
* **[Business Intelligence](business_intelligence/bi_requirements.md):** Definition of KPIs, User Personas, and Dashboard requirements.
* **[Dashboard Mockups](business_intelligence/dashboards.md):** Wireframes for Executive, Security, and Performance views.
