/*
QUERY REVIEW NOTES (Redshift):
1. Run EXPLAIN on the candidate query and review joins, scans, and redistribution.
2. Compare runtime and rows scanned before/after a change using the team's approved
   monitoring tools and a representative data window.
3. Check join cardinality and aggregate grain to avoid inflated totals.
4. Select only required columns; filter early when semantically correct.
5. Do not add distribution/sort-key changes without workload evidence and review.

The statement below is a harmless template for inspecting table metadata. Replace the
schema/table name. Catalog access can vary by permission.
*/

SELECT
    schemaname,
    tablename
FROM pg_table_def
WHERE schemaname = 'analytics_schema'
  AND tablename = 'receipt_lines'
ORDER BY ordinal_position;
