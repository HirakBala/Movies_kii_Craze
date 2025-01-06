# Movies_kii_Craze

All steps listed below,

Data Collection
The dataset was sourced from Kaggle, containing information on movies such as titles, genres, release dates, revenue, budget, and user ratings.
You can find the dataset here- https://www.kaggle.com/datasets/asaniczka/tmdb-movies-dataset-2023-930k-movies/data

Data Preprocessing
Handling Missing Values: Identified and addressed missing values in critical columns like budget_in_$, revenue_in_$, and runtime_in_mins.
Datetime Conversion: Transformed the release_date column into a datetime format to extract insights based on release years and trends over time.
Profit Calculation: Created a new profit_in_$ column by subtracting budget_in_$ from revenue_in_$.
Genre Splitting: Parsed and normalized the genres column, allowing for multi-genre analysis.
Data Filtering: Removed movies with missing or zero values for both budget and revenue to ensure meaningful financial analysis.

Exploratory Data Analysis (EDA)
EDA was conducted to explore key questions:
Movie Release Trends: Analyzed the number of movies released per year to identify patterns or growth in film production.
Profitability: Identified the top 5 most profitable movies and analyzed profit trends over the years using bar plots and line graphs.
Runtime Distribution: Explored the average runtime of movies and how it changed over time.
Revenue, Budget, and Profit Relationships: Investigated correlations between revenue, budget, and profit using scatter plots and correlation matrices.
Genre Popularity and Profit: Analyzed the relationship between movie genres and profitability, as well as genre correlations with popularity and ratings.
Rating, Votes, and Popularity: Examined how these features interact to influence a movie's overall reception.

Data Visualization
Data visualizations were created using Matplotlib and Seaborn to enhance insights.

Tools and Libraries
Python: pandas, matplotlib, seaborn, SQL Connector
Jupyter Notebook for EDA and visualization
SQL Database for data cleaning and transformation.





