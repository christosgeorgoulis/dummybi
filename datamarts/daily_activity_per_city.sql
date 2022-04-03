CREATE MATERIALIZED VIEW dw."daily_activity_per_city" AS
SELECT dw.user.city, dw.post.publishdate::date, COUNT(*) AS "count"
FROM dw.post
LEFT JOIN dw.user
	ON dw.user.id = dw.post.owner
GROUP BY dw.user.city, dw.post.publishdate::date