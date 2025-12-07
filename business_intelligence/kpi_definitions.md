# Key Performance Indicators (KPIs)

These metrics serve as the core drivers for the Executive Dashboard.

| KPI Name | Definition | Target / Benchmark | Logic Source |
| :--- | :--- | :--- | :--- |
| **Market Attractiveness Score (MAS)** | A weighted composite score (0-100) derived from Economic (50%), Risk (35%), and Trade (15%) indicators. | **> 75** (Safe Investment)<br>**< 50** (High Risk) | `FN_CALCULATE_MARKET_SCORE` |
| **Regional Stability Index** | The average Political Stability score aggregated by Region. Used to identify safe zones vs. conflict zones. | **> 60** (Stable Region) | SQL Aggregation (AVG) |
| **Inflation Volatility** | The standard deviation or Year-over-Year variance in inflation rates. Lower volatility indicates a predictable economy. | **< 2% Variance** | Window Function (`LAG/LEAD`) |
| **GDP Growth Consistency** | The number of consecutive years a country has maintained positive GDP growth. | **5+ Years** | Window Function (`ROW_NUMBER`) |
| **Data Freshness** | Percentage of tracked countries that have data entries for the current fiscal year. | **100%** by Q2 | Audit Queries |
