SELECT COUNT(DISTINCT utm_campaign)
AS 'Distinct Campaigns'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) 
AS 'Distinct Sources'
FROM page_visits;

SELECT 
DISTINCT utm_campaign AS 'Distinct Campaigns',
utm_source AS 'Sources'
FROM page_visits;

SELECT 
DISTINCT page_name 
FROM page_visits;

WITH first_touch AS (
 SELECT user_id,
        MIN(timestamp) as first_touch_at
 FROM page_visits
 GROUP BY user_id),
ft2 AS (
  SELECT ft.user_id,
         ft.first_touch_at,
         pv.utm_campaign
  FROM first_touch AS ft
  JOIN page_visits AS pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
)
SELECT ft2.utm_campaign AS 'Campaigns', 
COUNT(*) AS 'Number of first touches'
FROM ft2
GROUP BY 1
ORDER BY 2 DESC;

WITH last_touch AS (
 SELECT user_id,
        MAX(timestamp) as last_touch_at
 FROM page_visits
 GROUP BY user_id),
lt2 AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_campaign
  FROM last_touch AS lt
  JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt2.utm_campaign AS 'Campaigns', 
COUNT(*) AS 'Number of last touches'
FROM lt2
GROUP BY 1
ORDER BY 2 DESC;

SELECT COUNT(DISTINCT user_id) AS 'Number of buyers'
FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS (
 SELECT user_id,
        MAX(timestamp) as last_touch_at
 FROM page_visits
 WHERE page_name = '4 - purchase'
 GROUP BY user_id),
lt2 AS (
  SELECT lt.user_id,
         lt.last_touch_at,
         pv.utm_campaign
  FROM last_touch AS lt
  JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
)
SELECT lt2.utm_campaign AS 'Campaigns', 
COUNT(*) AS 'Last touches on purchase page'
FROM lt2
GROUP BY 1
ORDER BY 2 DESC;