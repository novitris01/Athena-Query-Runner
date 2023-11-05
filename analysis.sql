-- Drop tables if they exist
DROP TABLE IF EXISTS financial_data.income_statement_@table_name;

-- Create table for Income Statement
CREATE TABLE financial_data.income_statement_@table_name AS
WITH income_data AS (
    SELECT
        c.company_id,
        c.ticker_symbol,
        CASE
            WHEN "financials"."total_revenue" > 0 THEN "financials"."net_income" / "financials"."total_revenue"
            ELSE 0
        END AS profit_margin,
        "financials"."year",
        "financials"."total_revenue",
        "financials"."net_income"
    FROM
        "public"."companies" c
    LEFT JOIN
        "public"."financials" ON c.company_id = "financials"."company_id"
    WHERE
        "financials"."year" >= @date_range_start
        AND "financials"."year" <= @date_range_end
)
SELECT
    company_id,
    ticker_symbol,
    year,
    total_revenue,
    net_income,
    profit_margin
FROM
    income_data;

-- Drop tables if they exist
DROP TABLE IF EXISTS financial_data.balance_sheet_@table_name;

-- Create table for Balance Sheet
CREATE TABLE financial_data.balance_sheet_@table_name AS
WITH balance_data AS (
    SELECT
        c.company_id,
        c.ticker_symbol,
        "balance_sheet"."year",
        "balance_sheet"."total_assets",
        "balance_sheet"."total_liabilities",
        "balance_sheet"."total_equity"
    FROM
        "public"."companies" c
    LEFT JOIN
        "public"."balance_sheet" ON c.company_id = "balance_sheet"."company_id"
    WHERE
        "balance_sheet"."year" >= @date_range_start
        AND "balance_sheet"."year" <= @date_range_end
)
SELECT
    company_id,
    ticker_symbol,
    year,
    total_assets,
    total_liabilities,
    total_equity
FROM
    balance_data;

-- Drop tables if they exist
DROP TABLE IF EXISTS financial_data.cash_flow_statement_@table_name;

-- Create table for Cash Flow Statement
CREATE TABLE financial_data.cash_flow_statement_@table_name AS
WITH cash_flow_data AS (
    SELECT
        c.company_id,
        c.ticker_symbol,
        "cash_flow_statement"."year",
        "cash_flow_statement"."operating_cash_flow",
        "cash_flow_statement"."investing_cash_flow",
        "cash_flow_statement"."financing_cash_flow"
    FROM
        "public"."companies" c
    LEFT JOIN
        "public"."cash_flow_statement" ON c.company_id = "cash_flow_statement"."company_id"
    WHERE
        "cash_flow_statement"."year" >= @date_range_start
        AND "cash_flow_statement"."year" <= @date_range_end
)
SELECT
    company_id,
    ticker_symbol,
    year,
    operating_cash_flow,
    investing_cash_flow,
    financing_cash_flow
FROM
    cash_flow_data;
