-- ig clone sample scirpts

-- Finding bots -users who have liked every single photo
SELECT username,
        COUNT(*) AS total
FROM users
INNER JOIN likes
		ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING total = (SELECT count(*) FROM photos);

-- Five most popular hashtags
SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

-- Calculate the number of photos per user 
SELECT (SELECT Count(*) 
	FROM   photos) / (SELECT Count(*) 
	FROM   users) AS avg; 

-- Identify the most popular photo (and user who created it)
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- Looking for inactive users (users with no photos)
SELECT username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;

-- Most popular Registration Date
SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;


-- Finding 5 oldest users
SELECT * FROM users
ORDER BY created_at
LIMIT 5;

