CREATE TABLE appstore_description (id BIGINT PRIMARY KEY,
								   track_name VARCHAR(500),
								   size_bytes BIGINT,
								   app_desc VARCHAR(12000))
CREATE TABLE AppleStore	(id BIGINT,
						 track_name VARCHAR(500),
						 size_bytes BIGINT,
						 currency VARCHAR(20),
						 price DECIMAL(5,2),
						 rating_count_tot INT,
						 rating_count_ver INT,
						 user_rating DECIMAL(2,1),
						 user_rating_ver DECIMAL(2,1),
						 ver VARCHAR(20),
						 cont_rating VARCHAR(20),
						 prime_genre VARCHAR(30),
						 sup_devices_num INT,
						 ipadSc_urls_num INT,
						 lang_num INT,
						 vpp_lic INT)							   
								   
-- \COPY appstore_description FROM 'Path to CSV - appstore_description' DELIMITER ',' CSV HEADER ENCODING 'utf8'
-- \COPY AppleStore FROM 'Path to CSV - AppleStore' DELIMITER ',' CSV HEADER ENCODING 'utf8'

SELECT * FROM appstore_description;
SELECT * FROM AppleStore;

**Exploratory Data Analysis (EDA)**  

--Checking the number of unique apps in both tablesAppleStoreapplestore
SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM applestore;

SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appstore_description;

--Checking for any missing values in key fields:

SELECT COUNT(*) AS MissingValues
FROM applestore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL;

SELECT COUNT(*) AS MissingValues
FROM appstore_description
WHERE track_name IS NULL;

--Finding out the number of apps per genre

SELECT prime_genre, COUNT(*) AS AppsByGenre
FROM applestore
GROUP BY prime_genre
ORDER BY AppsByGenre DESC;

--Getting an overview of the apps ratings

SELECT MIN(user_rating) AS MinRating,
       MAX(user_rating) AS MaxRating,
       ROUND(Avg(user_rating), 2) AS AvgRating, 
       prime_genre
FROM applestore
GROUP BY prime_genre
ORDER BY AvgRating DESC;

-- Determining if paid apps have higner ratings than free apps

SELECT CASE
            WHEN price > 0 THEN 'Paid'
            ELSE 'Free'
            END AS AppType,
            AVG(user_rating) AS Avg_Rating
FROM applestore
GROUP BY AppType
ORDER BY AppType;

-- Getting minimum, maximum, and average price of Paid apps
SELECT
	MIN(price) AS Min_price,
	MAX(price) AS Max_price,
	AVG(price) AS Avg_Price
FROM applestore
WHERE price > 0;

-- Understanding Price distribution of paid apps
SELECT
	CASE WHEN price BETWEEN 0.99 AND 2.5 THEN '$0.99 - $2.5'
	WHEN price BETWEEN 2.51 AND 5 THEN '$2.51 - $5'
	WHEN price BETWEEN 5.01 AND 10 THEN '$5.01 - $10'
	WHEN price BETWEEN 10.01 AND 20 THEN '$10.01 - $20'
	ELSE '> $20'
	END AS Price_bins,
	COUNT(*) AS Num_apps
FROM applestore
WHERE price > 0
GROUP BY Price_bins; 
	
-- Average price of apps across different genres
-- Including Free Apps:
SELECT 
	prime_genre,
	AVG(price) AS Avg_price
FROM applestore
GROUP BY prime_genre
ORDER BY Avg_price DESC;

-- Excluding Free Apps:
SELECT 
	prime_genre,
	AVG(price) AS Avg_price
FROM applestore
WHERE price > 0
GROUP BY prime_genre
ORDER BY Avg_price DESC;

-- Which app categories tend to receive higher user ratings?

SELECT
	prime_genre,
	ROUND(AVG(user_rating), 2) AS Avg_Rating
FROM applestore
GROUP BY prime_genre
ORDER BY Avg_Rating DESC
LIMIT 10;

--Checking genres with low ratings

SELECT 
	prime_genre, 
	ROUND(AVG(user_rating), 2) AS Avg_Rating
FROM applestore
GROUP BY prime_genre
ORDER BY Avg_Rating;

-- Checking if apps that support more languages have better user rating

SELECT CASE
       WHEN lang_num < 10 THEN '<10 Languages'
       WHEN lang_num BETWEEN 10 and 30 THEn '10-30 Languages'
       ELSE '>30 Languages'
       End AS language_count,
       AVG(user_rating) AS Avg_Rating
FROM applestore
GROUP BY Language_count
ORDER BY Avg_Rating DESC;

-- Checking if there is correlation between the length of app description and user review

SELECT CASE
           WHEN length(a_d.app_desc) < 300 THEN 'Short'
           WHEN length(a_d.app_desc) BETWEEN 300 AND 500 THEN 'Medium'
           ELSE 'Long' 
           END AS descreption_length_bucket,
           AVG(user_rating) AS Avg_Rating

FROM applestore AS a_s
JOIN appstore_description AS a_d
ON a_s.id = a_d.id
GROUP BY descreption_length_bucket
ORDER BY Avg_Rating DESC;

-- Getting min, max and average app size
SELECT 
	MAX(size_bytes) AS Max_size,
	MIN(size_bytes) AS Min_size,
	AVG(size_bytes) AS Avg_size
FROM applestore;

-- Finding app size distribution
SELECT
	CASE WHEN size_bytes < 50000000 THEN '< 50 MB'
	     WHEN size_bytes BETWEEN 50000000 AND 200000000 THEN '50-200 MB'
		 WHEN size_bytes BETWEEN 200000001 AND 500000000 THEN '200 -500 MB'
		 ELSE '> 500 MB'
		 END AS Size_bins,
		 COUNT(*) AS Num_apps
FROM applestore
GROUP BY Size_bins;

-- App size by Genres

SELECT 
	prime_genre,
	ROUND(AVG(size_bytes)/1000000, 2) AS Avg_size
FROM applestore
GROUP BY prime_genre
ORDER BY Avg_size DESC;

-- Exploring Combinations of Price and User Satisfaction
SELECT
    prime_genre,
    price,
    AVG(user_rating) AS avg_rating
FROM applestore
WHERE price IS NOT NULL
GROUP BY prime_genre, price
ORDER BY prime_genre, avg_rating DESC;
