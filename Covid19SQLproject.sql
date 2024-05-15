--use [portfolio project];

Select * 
From dbo.CovidDeaths$;

DROP DATABASE [portfolio project];
use PortfolioProject;
Select * 
From PortfolioProject.dbo.CovidDeaths$;

Select * 
From PortfolioProject..CovidVaccinations$
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths$
order by 1,2

--looking at Total Cases VS Total Deaths

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where location like '%ug%'
order by 1,2

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$

--total cases vs population

select location, date, population, total_cases , (total_cases/population)*100 as CovidPercentage
From PortfolioProject..CovidDeaths$
Where location like '%ugan%'
order by 1,2

--looking at countries with highest infection rate compared to population

select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulation
From PortfolioProject..CovidDeaths$
GROUP BY location, population
order by 1,2

select location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulation
From PortfolioProject..CovidDeaths$
GROUP BY location, population
order by PercentagePopulation DESC


-- SHOWING COUNTRIES WITH THE HIGHEST DEATH COUNT PER POPULATION

select location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..CovidDeaths$
GROUP BY location
order by TotalDeathCount DESC


select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
GROUP BY location
order by TotalDeathCount DESC

--lets break things down by contient

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is  null
GROUP BY location
order by TotalDeathCount DESC

-- showing the continents with the highest death count per population

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
GROUP BY continent
order by TotalDeathCount DESC

--GLOBAL NUMBERS

select location, date, total_cases , total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 1,2


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int ))/SUM(new_cases)*100 as Deathpercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
order by 1,2

Select *
From PortfolioProject..CovidVaccinations$


Select *
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
    On dea.location = vac.location
	and dea.date = vac.date

	--looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
    On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 1,2


	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
    On dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	order by 2,3

	--USING CTE

With PopvsVac(continent, Location, Date, Population, New_vaccination, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
    On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3
)
select*,(RollingPeopleVaccinated/Population)*100
From PopvsVac

--TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated;

CREATE TABLE #PercentPopulationVaccinated
(
    Continent NVARCHAR(255),
    Location NVARCHAR(255),
    Date DATETIME,
    Population NUMERIC,
    New_vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO #PercentPopulationVaccinated
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(CONVERT(INT, vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
FROM
    PortfolioProject..CovidDeaths$ dea
JOIN
    PortfolioProject..CovidVaccinations$ vac ON dea.location = vac.location
                                               AND dea.date = vac.date
WHERE
    dea.continent IS NOT NULL;

SELECT
    *,
    (RollingPeopleVaccinated / Population) * 100 AS PercentPopulationVaccinated
FROM
    #PercentPopulationVaccinated;


	--creating view to store data for later visualisation

	Create View PercentPopulationVaccinated as
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(INT,vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths$ dea
Join PortfolioProject..CovidVaccinations$ vac
    On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select * 
from PercentPopulationVaccinated