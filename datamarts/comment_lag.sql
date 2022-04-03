CREATE MATERIALIZED VIEW dw."comment_lag" AS
with first_comment AS
(
SELECT dw.comment.owner, MIN(publishdate::timestamp) AS "date_of_comment"
FROM dw.comment
GROUP BY dw.comment.owner
)
SELECT dw.user.id AS comment_owner, 
	DATE_PART('day', first_comment.date_of_comment - registerdate::timestamp) * 24 + 
              DATE_PART('hour', first_comment.date_of_comment - registerdate::timestamp) AS duration
FROM dw.user
INNER JOIN first_comment
	ON first_comment.owner = dw.user.id

