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

-- We're running a new contest to see who can get the most likes on a single photo. Who won??
SELECT users.id, users.username
FROM users
WHERE users.id = (
                    SELECT photos.user_id
                    FROM photos
                    INNER JOIN likes on likes.photo_id = photos.id
                    GROUP BY photos.id
                    ORDER BY COUNT(*) DESC
                    LIMIT 1
                  );

-- How many times does the average user post?
SELECT (
        SELECT COUNT(*)
        FROM photos
      )/(
          SELECT COUNT(*)
          FROM users
        ) AS "average";

-- What are th top 5 most commonly used hashtags?
SELECT tags.tag_name, temp.total
FROM tags
INNER JOIN (
            SELECT tag_id, COUNT(*) as 'total'
            FROM photo_tags
            GROUP BY photo_tags.tag_id
            ORDER BY COUNT(*) DESC
            LIMIT 5
          ) AS temp ON temp.tag_id = tags.id;

-- Find users who have liked every single photo on the site
SELECT users.id, users.username
FROM users
WHERE users.id IN (
                    SELECT likes.user_id
                    FROM likes
                    GROUP BY likes.user_id
                    HAVING COUNT(*) = ( SELECT COUNT(*) AS 'number of photos'
                                        FROM photos
                                      )
)
ORDER BY users.id;