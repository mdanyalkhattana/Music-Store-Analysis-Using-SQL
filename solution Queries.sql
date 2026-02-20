------------------------------------Part 1-----------------------------

-- Q#1 = who is the senior most employee on job title?


select * from employee order by levels Desc limit 1;

--Q#2 = Which county has the most invoices?


select count(invoice_id) as total_invoices , billing_country 
from invoice group by billing_country 
order by total_invoices Desc LIMIT  1


--Q#3 waht are the Top 3 values of the total Invoices?
--select count(total) as total_invoices, billing_country from invoice group by billing_country order by total_invoices Desc LIMIT 3;

select total from invoice order by total desc limit 3;

--Q#4  Which city has the most total invoices amounts?

select sum(total) as total_invoices_per_city , billing_city
from invoice group by billing_city 
order by total_invoices_per_city  Desc LIMIT 1

-- Q#5 Who is the Best Customer?

select c.first_name ,sum(i.total) as totals
from customer c  
join invoice i on c.customer_id = i.customer_id 
group by c.first_name order by totals Desc LIMIT 2;



-------------------------------Part 2-----------------------------------------------


-- Q#1 = Write query to return the email, first name, last name, & Genre of all Rock Music listeners
-- . Return your list ordered alphabetically by email starting with A

select distinct c.email, c.first_name, c.last_name 
from customer c
left join invoice i  on c.customer_id = i.customer_id 
left join Invoice_line ii on i.invoice_id =  ii.invoice_id
left join Track t on ii.track_id = t.track_id 
left join Genre g on t.track_id = g.genre_id::int  order by email asc;


-- Q#2 = Let's invite the artists who have written the most rock music in our dataset. Write a 
--query that returns the Artist name and total track count of the top 10 rock bands



select a.name, count(t.track_id) as track_count from artist a 
left join album aa on a.artist_id = aa.artist_id 
left join track t on  aa.album_id = t.album_id 
left join genre g on t.genre_id = g.genre_id 
where g.name = 'Rock' group by a.name,a.artist_id  order by track_count desc limit 10;




--Q#3 = Return all the track names that have a song length longer than the average song length. 
--Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first

WITH avg_length AS (
    SELECT AVG(milliseconds) AS avg_ms 
    FROM track
)
SELECT t.name, t.milliseconds
FROM track t, avg_length a
WHERE t.milliseconds > a.avg_ms
ORDER BY t.milliseconds DESC;



-----------------------------------------------Part 3------------------------------------

--Find how much amount spent by each customer on artists? Write a query to return
--customer name, artist name and total spent


WITH best_selling_artist AS (
    SELECT 
        aa.artist_id, 
        aa.name AS artist_name, 
        SUM(il.unit_price * il.quantity) AS total_sales
    FROM artist aa
    JOIN album a ON aa.artist_id = a.artist_id 
    JOIN track t ON a.album_id = t.album_id 
    JOIN invoice_line il ON t.track_id = il.track_id
    GROUP BY aa.artist_id, aa.name
    ORDER BY total_sales DESC
    LIMIT 1  -- This picks the #1 artist (e.g., Queen)
)
SELECT 
    c.customer_id, 
    c.first_name, 
    bsa.artist_name, 
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id 
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id 
JOIN album a ON t.album_id = a.album_id 
JOIN best_selling_artist bsa ON a.artist_id = bsa.artist_id 
GROUP BY 1, 2, 3
ORDER BY amount_spent DESC;


--We want to find out the most popular music Genre for each country. We determine the 
--most popular genre as the genre with the highest amount of purchases. Write a query 
--that returns each country along with the top Genre. For countries where the maximum 
--number of purchases is shared return all Genres

WITH  top_genre AS (
    SELECT 
        i.billing_country, 
        g.name as genre_name, 
        COUNT(il.quantity) as purchases,
        RANK() OVER(PARTITION BY i.billing_country ORDER BY  COUNT(il.quantity) DESC) AS genre_rank
    FROM invoice_line il
    JOIN invoice i ON i.invoice_id = il.invoice_id
    JOIN track t ON t.track_id = il.track_id
    JOIN genre g ON g.genre_id = t.genre_id
    GROUP BY 1, 2
)
SELECT *
FROM top_genre
WHERE genre_rank = 1;


 --Write a query that determines the customer that has spent the most on music for each 
--country. Write a query that returns the country along with the top customer and how
--much they spent. For countries where the top amount spent is shared, provide all 
--customers who spent this amount
WITH customer_with_country AS (
    SELECT 
        c.country, 
        c.first_name, 
        c.last_name, 
        SUM(i.total) AS total_spending,
        RANK() OVER (      -- we can also use Row Number here instead of the Rank function
            PARTITION BY c.country 
            ORDER BY SUM(i.total) DESC
        ) AS spending_rank
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.country, c.customer_id, c.first_name, c.last_name
)
SELECT 
    country, 
    first_name || ' ' || last_name AS customer_name, 
    total_spending
FROM customer_with_country
WHERE spending_rank = 1
ORDER BY country ASC;





WITH customer_with_country AS (
    SELECT 
        c.country, 
        c.first_name, 
        c.last_name, 
        SUM(i.total) AS total_spending,
        ROW_NUMBER() OVER (
            PARTITION BY c.country 
            ORDER BY SUM(i.total) DESC
        ) AS spending_rank
    FROM customer c
    JOIN invoice i ON c.customer_id = i.customer_id
    GROUP BY c.country, c.customer_id, c.first_name, c.last_name
)
SELECT 
    country, 
    first_name || ' ' || last_name AS customer_name, 
    total_spending
FROM customer_with_country
WHERE spending_rank = 1
ORDER BY country ASC;









