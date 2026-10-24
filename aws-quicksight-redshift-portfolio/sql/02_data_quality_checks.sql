/*
ILLUSTRATIVE DATA-QUALITY CHECKS.
Adapt names and rules to the actual schema and agreed business definitions.
*/

-- 1. Check nulls in important fields
SELECT
    SUM(CASE WHEN receipt_date IS NULL THEN 1 ELSE 0 END) AS null_receipt_date,
    SUM(CASE WHEN item_identifier IS NULL THEN 1 ELSE 0 END) AS null_item_identifier,
    SUM(CASE WHEN received_quantity IS NULL THEN 1 ELSE 0 END) AS null_received_quantity
FROM analytics_schema.receipt_lines;

-- 2. Inspect duplicate candidates.
-- This assumes the combination below should be unique; verify the real business key.
SELECT
    receipt_id,
    item_identifier,
    COUNT(*) AS row_count
FROM analytics_schema.receipt_lines
GROUP BY receipt_id, item_identifier
HAVING COUNT(*) > 1
ORDER BY row_count DESC;

-- 3. Check suspicious negative quantities. Negative values may be valid corrections,
-- so investigate rather than automatically deleting them.
SELECT *
FROM analytics_schema.receipt_lines
WHERE received_quantity < 0
LIMIT 100;
