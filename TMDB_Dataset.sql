#Getting things done.
create database movie_analysis;

use movie_analysis;

CREATE TABLE all_movies (
    id BIGINT,
    title VARCHAR(500),
    vote_average FLOAT,
    vote_count BIGINT,
    status VARCHAR(1000),
    release_date VARCHAR(1000),
    revenue BIGINT,
    runtime BIGINT,
    adult BOOL,
    backdrop_path VARCHAR(1000),
    budget BIGINT,
    homepage VARCHAR(1000),
    original_language VARCHAR(1000),
    original_title VARCHAR(1000),
    overview VARCHAR(1000),
    popularity FLOAT,
    poster_path VARCHAR(1000),
    tagline VARCHAR(1000),
    genres VARCHAR(1000),
    production_companies VARCHAR(1000),
    production_countries VARCHAR(1000),
    spoken_languages VARCHAR(1000),
    keywords BLOB(1000)
);

SELECT 
    *
FROM
    all_movies;
/*Here, I have created the above table so that I can get my dataset here through sql and python connection which I have shared in my 
repository.*/
													#1- Data Cleaning
                                                    
#1- Removing unwanted columns which are not necessary.
ALTER TABLE all_movies
DROP COLUMN backdrop_path,
DROP COLUMN homepage,
drop column original_title,
DROP COLUMN overview,
drop column poster_path,
drop column tagline,
drop column production_countries,
drop column production_companies,
drop column spoken_languages,
drop column keywords;

SELECT 
    *
FROM
    all_movies;
    
#2- Rename columns for better understanding.
alter table all_movies
rename column vote_average to average_rating,
rename column vote_count to total_votes,
rename column revenue to revenue_in_$,
rename column runtime to runtime_in_mins,
rename column budget to budget_in_$;

SELECT 
    *
FROM
    all_movies;

#3- Check missing values.
SELECT 
    *
FROM
    all_movies
WHERE
    title IS NULL OR average_rating IS NULL;

/*Here, we are getting some null values. Also when rating is 0 or null the other columns are also null or 0. 
Simply put not suitable for our dataset. Lets delete these rows.*/

#To allow us to update or delete.
SET SQL_SAFE_UPDATES = 0;

DELETE FROM all_movies 
WHERE
    title IS NULL OR average_rating IS NULL;

SELECT 
    SUM(CASE
        WHEN revenue_in_$ IS NULL THEN 1
        ELSE 0
    END) AS missing_revenue,
    SUM(CASE
        WHEN budget_in_$ IS NULL THEN 1
        ELSE 0
    END) AS missing_budget,
    SUM(CASE
        WHEN runtime_in_mins IS NULL THEN 1
        ELSE 0
    END) AS missing_runtime,
    SUM(CASE
        WHEN release_date IS NULL THEN 1
        ELSE 0
    END) AS missing_release_date
FROM
    all_movies;

DELETE FROM all_movies 
WHERE
    release_date IS NULL;

select count(*) from all_movies;

#Now, we have mostly handled our missing vlaues , rest of it we will solve(if any) using EDA.

													#2- Data Transformation

#1- Add profit column.
alter table all_movies
add column profit bigint;

UPDATE all_movies 
SET 
    profit = revenue_in_$ - budget_in_$;

SELECT 
    *
FROM
    all_movies;

alter table all_movies
rename column profit to profit_in_$;

#2- Convert the adult column to give more meaning.
alter table all_movies
modify column adult varchar(50); 

UPDATE all_movies 
SET 
    adult = CASE
        WHEN adult = 0 THEN 'No'
        WHEN adult = 1 THEN 'Yes'
    END; 
        
SELECT 
    *
FROM
    all_movies;
    
SELECT 
    COUNT(*)
FROM
    all_movies;

													#3- Data Extraction

SELECT 
    *
FROM
    all_movies;

#1- How many movies were released in each year?
alter table all_movies
add column year varchar(4);

SET SQL_SAFE_UPDATES = 0;

DELETE FROM all_movies 
WHERE
    release_date LIKE '____-%';

UPDATE all_movies 
SET 
    release_date = DATE_FORMAT(STR_TO_DATE(release_date, '%d-%m-%Y'),
            '%Y-%m-%d');

UPDATE all_movies 
SET 
    year = SUBSTR(release_date, 1, 4);

SELECT 
    *
FROM
    all_movies;

SELECT 
    COUNT(title) AS total_movies_released, year
FROM
    all_movies
GROUP BY year;

#2- Top 10 movies with highest popularity.
select title, popularity, year, dense_rank()over(partition by year order by popularity desc) as ranked_popularity from all_movies
order by popularity desc
limit 10;

#3- Movies with low vote count but high vote average.
SELECT 
    id, title, total_votes, average_rating
FROM
    all_movies
WHERE
    total_votes < 100 AND average_rating > 8
ORDER BY average_rating DESC;

#4- Highest and lowest profit.
SELECT 
    title, 
    profit_in_$ AS profit, 
    'Highest' AS profit_type
FROM 
    all_movies
WHERE 
    profit_in_$ = (SELECT MAX(profit_in_$) FROM all_movies)

UNION ALL

SELECT 
    title, 
    profit_in_$ AS profit, 
    'Lowest' AS profit_type
FROM 
    all_movies
WHERE 
    profit_in_$ = (SELECT MIN(profit_in_$) FROM all_movies);

#5- Has the average movie runtime changed over the years?
SELECT 
    year, AVG(runtime_in_mins) AS average_runtime
FROM
    all_movies
GROUP BY year
ORDER BY year;
    
#6- Total profit by each genres.
SELECT 
    genres, SUM(profit_in_$) AS total_profit
FROM
    all_movies
GROUP BY genres
ORDER BY total_profit DESC;

#7- What movies are profitable (revenue > budget)?
SELECT 
    title, revenue_in_$, budget_in_$
FROM
    all_movies
WHERE
    revenue_in_$ > budget_in_$
ORDER BY revenue_in_$ DESC
LIMIT 10;

select * from all_movies;

#Now, so far most of the sql analysis has been done. It is time to export this schema to perform some more analysis using EDA.
