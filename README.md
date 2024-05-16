# COVID-19-Data-Analysis-with-SQL
## Introduction:
The SQL project focused on analyzing COVID-19 data related to deaths, vaccinations, and population statistics. Various SQL queries were used to extract, manipulate, and analyze data from the "PortfolioProject" database. ( I was using SQL Server Management Studio) . I got the data set from google, you can also get data from kaggle .

Queries and Analysis:

### CovidDeaths Table Analysis:
- Query 1: Selecting all columns from the CovidDeaths table.
- Query 2: Joining tables and selecting data from the CovidDeaths table in the PortfolioProject database.
- Query 3: Ordering data from the CovidVaccinations table by columns 3 and 4.
-  Query 4: Analyzing total cases, new cases, total deaths, and population from CovidDeaths, ordered by location and date.

### Infection and Death Rates Analysis:
- Query 5: Calculating the death percentage based on total cases versus total deaths for a specific location (e.g., Uganda).
- Query 6: Calculating the death percentage based on total cases versus total deaths globally.
- Query 7: Analyzing total cases versus population percentage for a specific location (e.g., Uganda).
- Query 8: Identifying countries with the highest infection rates compared to population.
- Query 9: Identifying countries with the highest death counts per population.

### Continents and Global Analysis:
- Query 10: Analyzing continents with the highest death counts per population.
- Query 11: Analyzing global COVID-19 numbers, including total cases, total deaths, and death percentage.
- Query 12: Calculating the death percentage globally using the total cases and total deaths.

### Vaccination Data Analysis:
- Query 13: Selecting all columns from the CovidVaccinations table.
- Query 14: Joining CovidDeaths and CovidVaccinations tables on location and date.
- Query 15: Analyzing total population versus vaccinations for specific locations.
- Query 16: Using CTE to calculate rolling people vaccinated percentages.
- Query 17: Using temporary tables to calculate the percentage of population vaccinated.

### Conclusion:
The SQL project demonstrated the use of SQL queries to analyze COVID-19 data effectively. Insights were gained regarding infection rates, death rates, vaccination progress, and global trends, contributing to informed decision-making in public health strategies.
