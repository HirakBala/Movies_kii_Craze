import pandas as pd
import mysql.connector

# Read the CSV file
df = pd.read_csv('C:/Users/HP/Documents/EDA/TMDB_movie_dataset_v11.csv')

# Connect to MySQL
conn = mysql.connector.connect(
    host='127.0.0.1',
    user='root',
    password='legend@07',
    database='movie_analysis'
)
cursor = conn.cursor()

# Insert data into the table
for index, row in df.iterrows():
    cursor.execute("""
        INSERT INTO all_movies (id, title, vote_average, vote_count, status, release_date, revenue, runtime, adult, backdrop_path, budget, homepage, original_language, original_title, overview, popularity, poster_path, tagline, genres, production_companies, production_countries, spoken_languages, keywords)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        row['id'], row['title'], row['vote_average'], row['vote_count'], row['status'], row['release_date'], row['revenue'], row['runtime'], row['adult'], row['backdrop_path'], row['budget'], row['homepage'], row['original_language'], row['original_title'], row['overview'], row['popularity'], row['poster_path'], row['tagline'], row['genres'], row['production_companies'], row['production_countries'], row['spoken_languages'], row['keywords']
    ))

conn.commit()
cursor.close()
conn.close()
