-- Find the 5 oldest users
SELECT * 
FROM  users
ORDER BY created_at ASC
LIMIT 5;

-- What day of the week do most users register on?
SELECT COUNT(*), DAYNAME(created_at) AS 'day'
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(*) DESC;

-- Find the users who have never posted a photo
SELECT *
FROM users
WHERE users.id NOT IN ( SELECT users.id
                        FROM users
                        INNER JOIN photos ON photos.user_id =  users.id);

SELECT *
FROM users
LEFT JOIN photos ON photos.user_id =  users.id
WHERE photos.id is NULL;
