CREATE MATERIALIZED VIEW dw."daily_new_users" AS
SELECT registerdate::date AS "registerdate", COUNT(DISTINCT dw.user.id) AS "count"
FROM dw.user
GROUP BY registerdate::date