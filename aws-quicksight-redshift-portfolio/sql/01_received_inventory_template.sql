/*
ILLUSTRATIVE TEMPLATE ONLY.
Replace placeholder schema/table/column names with verified project schema.
Do not treat this as the original production query.
Assumed grain: one row per receipt line. Confirm this assumption first.
*/

SELECT
    CAST(receipt_date AS DATE) AS receipt_date,
    item_category,
    item_identifier,
    SUM(received_quantity) AS received_quantity
FROM analytics_schema.receipt_lines
WHERE receipt_date >= :start_date
  AND receipt_date <  :end_date
GROUP BY
    CAST(receipt_date AS DATE),
    item_category,
    item_identifier
ORDER BY
    receipt_date,
    item_category,
    item_identifier;
