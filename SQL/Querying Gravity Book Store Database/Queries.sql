-- 1. List of all the languages books are available in
SELECT 
  DISTINCT language_name 
FROM 
  book_language;
  
-- 2. Number of unique languages
SELECT 
  COUNT(DISTINCT language_id) AS num_language
FROM 
  book;
  
-- 3. List of different English languages
SELECT 
  DISTINCT language_name 
FROM 
  book_language 
WHERE 
  language_name LIKE '%english%';

-- 4. Top 20 authors with most books
SELECT 
  author_name, 
  COUNT(*) AS num_books 
FROM 
  author 
  JOIN book_author USING(author_id) 
  JOIN book USING(book_id) 
GROUP BY 
  author_name 
ORDER BY 
  num_books DESC, 
  author_name 
LIMIT 
  20;

-- 5. Author, name, number of pages of the longest book
SELECT 
  author_name, 
  title, 
  num_pages 
FROM 
  author 
  JOIN book_author USING(author_id) 
  JOIN book USING(book_id) 
WHERE 
  num_pages >= ALL(
    SELECT 
      DISTINCT num_pages 
    FROM 
      book
  );

-- Using Max() 
SELECT 
  author_name, 
  title, 
  num_pages 
FROM 
  author 
  JOIN book_author USING(author_id) 
  JOIN book USING(book_id) 
WHERE 
  num_pages = (
    SELECT 
      MAX(num_pages) 
    FROM 
      book
  );

-- Using ORDER BY
SELECT 
  author_name, 
  title, 
  num_pages 
FROM 
  author 
  JOIN book_author USING(author_id) 
  JOIN book USING(book_id) 
ORDER BY 
  num_pages DESC 
LIMIT 
  1;

-- 6. Longest book for every language
WITH rankedbooks AS (
  SELECT 
    language_name, 
    num_pages, 
    title, 
    RANK() OVER(
      PARTITION BY language_name 
      ORDER BY 
        num_pages DESC
    ) AS rnk 
  FROM 
    book 
    JOIN book_language USING(language_id)
) 
SELECT 
  language_name, 
  num_pages, 
  title 
FROM 
  rankedbooks 
WHERE 
  rnk = 1;

-- 7. List of books having 100-120 pages (inclusive), sorted in descending order by number of pages 
SELECT 
  title, 
  num_pages 
FROM 
  book 
WHERE 
  num_pages BETWEEN 100 
  AND 120 
ORDER BY 
  num_pages DESC;

-- 8. Number of books published by the top 10 Publishers (by total number of books)
SELECT 
  publisher_name, 
  count(*) AS num_books 
FROM 
  publisher 
  JOIN book USING(publisher_id) 
GROUP BY 
  publisher_name 
ORDER BY 
  num_books DESC 
LIMIT 
  10;

-- 9. Publisher name having the most books for English, Spanish, and Turkish languages 
WITH p_rank AS (
  SELECT 
    language_name, 
    publisher_name, 
    COUNT(*) AS num_books, 
    RANK() OVER (
      PARTITION BY language_name 
      ORDER BY 
        COUNT(*) DESC
    ) AS rnk 
  FROM 
    book 
    JOIN publisher USING (publisher_id) 
    JOIN book_language USING (language_id) 
  GROUP BY 
    language_name, 
    publisher_name
) 
SELECT 
  language_name, 
  publisher_name, 
  num_books 
FROM 
  p_rank 
WHERE 
  rnk = 1 
  AND language_name IN('English', 'Spanish', 'Turkish');

-- 10. Check if any author has written books in multiple languages
SELECT 
  a.author_name, 
  b.title, 
  GROUP_CONCAT(DISTINCT bl.language_name) AS languages 
FROM 
  book b 
  JOIN book_language bl ON b.language_id = bl.language_id 
  JOIN book_author ba ON ba.book_id = b.book_id 
  JOIN author a ON a.author_id = ba.author_id 
GROUP BY 
  a.author_name, 
  b.title 
HAVING 
  COUNT(DISTINCT bl.language_name) > 1;

-- 11. Return the book titles that were published on the same date
SELECT 
  x.title, 
  x.publication_date 
FROM 
  book x 
WHERE 
  publication_date in (
    SELECT 
      publication_date 
    FROM 
      book y 
    WHERE 
      x.title != y.title 
      AND x.publication_date = y.publication_date
  ) 
GROUP BY 
  x.title, 
  x.publication_date 
ORDER BY 
  x.publication_date;

-- USing self Join
SELECT 
  x.title, 
  x.publication_date 
FROM 
  book x 
  JOIN book y ON x.title != y.title 
  AND x.publication_date = y.publication_date 
GROUP BY 
  x.title, 
  x.publication_date 
ORDER BY 
  x.publication_date;

-- 12. Finding books with multiple orders
SELECT 
  book.book_id, 
  title, 
  count(*) AS num_orders 
FROM 
  order_line 
  LEFT JOIN book USING(book_id) 
GROUP BY 
  book.book_id, 
  title 
HAVING 
  num_orders > 1 
ORDER BY 
  num_orders DESC;

-- 13. Top 20 Customers who bought the most books
SELECT 
  c.customer_id, 
  concat(c.first_name, " ", c.last_name) AS cust_name, 
  count(*) AS num_orders 
FROM 
  cust_order co 
  LEFT JOIN customer c USING(customer_id) 
GROUP BY 
  c.customer_id, 
  cust_name 
HAVING 
  num_orders > 1 
ORDER BY 
  num_orders DESC 
LIMIT 
  20;

-- 14. Books that were not sold
SELECT 
  book_id, 
  title 
FROM 
  book 
WHERE 
  book_id NOT IN (
    SELECT 
      DISTINCT book_id 
    FROM 
      order_line
  );

-- 15. Number of unsold books
SELECT 
  COUNT(book_id) AS num_unsold 
FROM 
  book 
WHERE 
  book_id NOT IN (
    SELECT 
      DISTINCT book_id 
    FROM 
      order_line
  );

-- 16. Number of international orders
SELECT 
  COUNT(*) AS num_international 
FROM 
  cust_order co 
  LEFT JOIN shipping_method sm ON sm.method_id = co.shipping_method_id 
WHERE 
  method_name = 'International';

-- 17. Calculating average shipping cost and average price rounded off to two decimal places
SELECT 
  ROUND(
    AVG(price), 
    2
  ) as avg_price, 
  ROUND(
    AVG(cost), 
    2
  ) as avg_shipping_Cost 
FROM 
  order_line 
  JOIN cust_order USING(order_id) 
  JOIN shipping_method ON shipping_method.method_id = cust_order.shipping_method_id;

-- 18. Number of orders by city name and country in descending order
SELECT 
  country_name, 
  city, 
  COUNT(*) AS num_orders 
FROM 
  country 
  JOIN address USING(country_id) 
  JOIN cust_order ON cust_order.dest_address_id = address.address_id 
GROUP BY 
  country_name, 
  city 
ORDER BY 
  num_orders DESC;