-- ==========================================================
-- FILE: 03_insert_data.sql
-- ==========================================================
SET DEFINE OFF;
SET SERVEROUTPUT ON;

BEGIN
    -- 2. INSERT REGIONS
    INSERT INTO regions VALUES (1, 'North America');
    INSERT INTO regions VALUES (2, 'Europe');
    INSERT INTO regions VALUES (3, 'Asia Pacific');
    INSERT INTO regions VALUES (4, 'Middle East & Africa');
    INSERT INTO regions VALUES (5, 'Latin America');

    -- 3. INSERT 100 REAL COUNTRIES
    DECLARE
        TYPE NameArray IS TABLE OF VARCHAR2(50);
        v_countries NameArray := NameArray(
            -- North America
            'United States', 'Canada', 'Mexico',
            -- South America
            'Brazil', 'Argentina', 'Chile', 'Colombia', 'Peru', 'Venezuela', 'Ecuador', 'Bolivia', 'Paraguay', 'Uruguay', 'Guyana', 'Suriname',
            -- Europe
            'United Kingdom', 'Germany', 'France', 'Italy', 'Spain', 'Netherlands', 'Belgium', 'Switzerland', 'Sweden', 'Norway', 
            'Denmark', 'Poland', 'Austria', 'Finland', 'Portugal', 'Greece', 'Ireland', 'Czech Republic', 'Hungary', 'Romania', 
            'Bulgaria', 'Slovakia', 'Croatia', 'Serbia', 'Slovenia', 'Lithuania', 'Latvia', 'Estonia', 'Iceland', 'Luxembourg',
            -- Asia
            'China', 'Japan', 'India', 'South Korea', 'Indonesia', 'Saudi Arabia', 'Turkey', 'Iran', 'Thailand', 'Vietnam', 
            'Malaysia', 'Philippines', 'Singapore', 'Pakistan', 'Bangladesh', 'Israel', 'UAE', 'Qatar', 'Kuwait', 'Iraq', 
            'Kazakhstan', 'Uzbekistan', 'Sri Lanka', 'Myanmar', 'Nepal',
            -- Africa
            'Nigeria', 'South Africa', 'Egypt', 'Algeria', 'Morocco', 'Kenya', 'Ethiopia', 'Ghana', 'Ivory Coast', 'Tanzania', 
            'Uganda', 'Rwanda', 'Senegal', 'Cameroon', 'Tunisia', 'Zimbabwe', 'Zambia', 'Angola', 'Mozambique', 'Botswana',
            -- Oceania/Other
            'Australia', 'New Zealand', 'Papua New Guinea', 'Fiji', 'Samoa', 'Russia', 'Ukraine', 'Belarus', 'Georgia', 'Azerbaijan'
        );
        v_region NUMBER;
    BEGIN
        FOR i IN 1..100 LOOP
            -- Assign Region roughly by list position
            IF i <= 3 THEN v_region := 1;
            ELSIF i <= 15 THEN v_region := 5;
            ELSIF i <= 45 THEN v_region := 2;
            ELSIF i <= 70 THEN v_region := 3;
            ELSIF i <= 90 THEN v_region := 4;
            ELSE v_region := 3; END IF;

            INSERT INTO countries VALUES (100 + i, v_region, v_countries(i), DBMS_RANDOM.STRING('U', 3));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('100 Real Countries Inserted.');
    END;

    -- 4. INSERT 100 REAL INDICATORS
    DECLARE
        TYPE IndList IS TABLE OF VARCHAR2(100);
        v_inds IndList := IndList(
            -- Economic
            'GDP Growth Rate', 'GDP Annual Growth Rate', 'GDP Constant Prices', 'GNP', 'GDP per Capita',
            'Gross Fixed Capital Formation', 'Industrial Production Mom', 'Industrial Production YoY', 'Manufacturing PMI', 'Services PMI',
            'Mining Production', 'Steel Production', 'Car Production', 'Cement Production', 'Construction Output',
            'Business Confidence', 'Capacity Utilization', 'Leading Economic Index', 'Competitiveness Rank', 'Economic Complexity Index',
            -- Inflation
            'Inflation Rate YoY', 'Inflation Rate MoM', 'Core Inflation Rate', 'Food Inflation', 'Energy Inflation',
            'Producer Prices (PPI)', 'Import Prices', 'Export Prices', 'Consumer Price Index (CPI)', 'Harmonized CPI',
            'GDP Deflator', 'Rent Inflation', 'Services Inflation', 'Wholesale Prices', 'Commodity Price Index',
            -- Labor
            'Unemployment Rate', 'Youth Unemployment Rate', 'Long Term Unemployment Rate', 'Employed Persons', 'Unemployed Persons',
            'Labor Force Participation Rate', 'Employment Rate', 'Part Time Employment', 'Full Time Employment', 'Job Vacancies',
            'Wage Growth', 'Minimum Wage', 'Labor Costs', 'Productivity', 'Retirement Age Men', 'Retirement Age Women',
            'Population', 'Population Growth', 'Net Migration', 'Urban Population',
            -- Trade
            'Balance of Trade', 'Current Account', 'Current Account to GDP', 'Exports', 'Imports', 'External Debt', 'Terms of Trade',
            'Foreign Direct Investment', 'Gold Reserves', 'Crude Oil Production', 'Terrorism Index', 'Tourism Revenues', 'Remittances',
            'Capital Flows', 'Crude Oil Imports', 'Weapons Exports', 'High Tech Exports', 'Tariff Rate', 'Trade Openness Index', 'Container Port Traffic',
            -- Money/Govt
            'Interest Rate', 'Interbank Rate', 'Money Supply M0', 'Money Supply M1', 'Money Supply M2', 'Central Bank Balance Sheet',
            'Foreign Exchange Reserves', 'Loan Growth', 'Private Sector Credit', 'Household Debt to GDP', 'Corporate Debt to GDP',
            'Government Budget', 'Government Debt', 'Government Debt to GDP', 'Government Spending', 'Credit Rating',
            'Military Expenditure', 'Corporate Tax Rate', 'Personal Income Tax Rate', 'Sales Tax Rate',
            -- Business/Risk
            'Consumer Confidence', 'Consumer Spending', 'Disposable Personal Income', 'Gasoline Prices', 'Households Debt to Income',
            'Retail Sales MoM', 'New Car Registrations', 'Bankruptcies', 'Business Optimism Index', 'Corruption Index',
            'Corruption Rank', 'Ease of Doing Business', 'Political Stability Index', 'Rule of Law Index', 'Regulatory Quality'
        );
        v_cat VARCHAR2(20); v_unit VARCHAR2(20); v_weight NUMBER;
    BEGIN
        FOR i IN 1..100 LOOP
            -- Determine Category
            IF v_inds(i) LIKE '%Trade%' OR v_inds(i) LIKE '%Export%' OR v_inds(i) LIKE '%Import%' THEN v_cat := 'TRADE'; v_weight := 0.15;
            ELSIF v_inds(i) LIKE '%Corruption%' OR v_inds(i) LIKE '%Stability%' OR v_inds(i) LIKE '%Index%' THEN v_cat := 'RISK'; v_weight := 0.35;
            ELSE v_cat := 'ECONOMIC'; v_weight := 0.50; END IF;

            -- Determine Unit
            IF v_inds(i) LIKE '%Index%' THEN v_unit := 'Index'; ELSE v_unit := '%'; END IF;

            INSERT INTO indicators VALUES (i, v_inds(i), v_cat, v_weight, v_unit);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('100 Real Indicators Inserted.');
    END;
    
    COMMIT;
END;
/
