--                                        DATA EXPLORATION WITH SQL


-- SELECT DATA THAT WE ARE GOING TO BE USING
SELECT location,
date, 
total_cases, 
new_cases, total_deaths, 
population 
FROM coviddeaths$ 
ORDER BY 3,4


-- LOOKING AT THE TOTAL CASES VS TOTAL DEATHS
-- Shows likelihood of dying if you contract covid in India
SELECT location, 
date, 
total_cases, 
total_deaths,
(total_deaths/total_cases)*100 AS  DeathPercentage
FROM CovidDeaths$ 
WHERE location = 'India' 
ORDER BY 1,2


-- TOTAL CASES VS POPULATION
-- Shows what percentage of popuolation infected with Covid
SELECT location, 
date, 
total_cases, 
population,
(total_cases/population)*100 AS  PercentPopulationInfected
FROM CovidDeaths$ 
WHERE location = 'India' 
ORDER BY 1,2


-- COUNTRIES WITH HIGHEST INFECTION RATE COMPARED TO POPULATION

SELECT 
location, 
population,
MAX(total_cases) as HighestInfectionCount, 
MAX((total_cases/population))*100 as PercentPopulationInfected
FROM CovidDeaths$ 
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC


-- COUNTRIES WITH HIGHEST DEATH COUNT PER POPULATION

SELECT 
Location, 
MAX(CAST(Total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null 
GROUP BY Location
ORDER BY TotalDeathCount DESC


-- BREAKING THINGS DOWN BY CONTINENT
--Showing continents with the highest death count per popupation

SELECT continent,
MAX(CAST(Total_deaths AS int)) AS TotalDeathCount
FROM CovidDeaths$
WHERE continent is not null 
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- GLOBAL NUMBERS

SELECT SUM(new_cases) AS total_cases,
SUM(CAST(new_deaths AS INT)) AS total_deaths,
SUM(CAST(new_deaths AS INT))/SUM(New_Cases)*100 AS DeathPercentage
FROM CovidDeaths$
WHERE continent is not null
ORDER BY 1,2


-- TOTAL POPULATION VS VACCINATIONS
-- Shows percentage of population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM CovidDeaths$ dea
Join CovidVaccinations$ vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null 
ORDER BY 2,3


-- USING CTE TO PERFORM CALCULATION ON PARTITION BY IN PREVIOUS QUERY

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM CovidDeaths$ dea
Join CovidVaccinations$ vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null)

SELECT *, (RollingPeopleVaccinated/population)*100
FROM PopvsVac


-- USING TEMP TABLE TO PERFORM CALCULATIONS ON PARTITION BY IN PREVIOUS QUERY

DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM CovidDeaths$ dea
Join CovidVaccinations$ vac
ON dea.location = vac.location
and dea.date = vac.date

SELECT *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated


-- CREATING VIEW TO STORE DATA FOR LATER VISUALIZATION

CREATE VIEW  PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) as RollingPeopleVaccinated
FROM CovidDeaths$ dea
Join CovidVaccinations$ vac
ON dea.location = vac.location
and dea.date = vac.date
WHERE dea.continent is not null