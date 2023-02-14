--select *
--from womentechers..CovidVaccinations

--select *
--from womentechers..CovidVaccinations
--order by 3,4

--select *
--from womentechers..CovidDeaths
--order by 3, 4

--select *
--from womentechers..CovidDeaths
--where continent is NOT NULL
--order by 3, 4

-- select data that i'll be using


--select continent, location, date, total_cases, new_cases, total_deaths, total_tests, population
--from womentechers..CovidDeaths
--where continent is NOT NULL
--order by 1,2

--looking at the relationship between total_cases and total_deaths

--select location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Deathpercentage
--from womentechers..CovidDeaths

--select location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Deathpercentage
--from womentechers..CovidDeaths
--where location like '%Nigeria%' and continent is NOT NULL
--order by date desc


--looking at the relationship between population and total_cases so as to know how it has affected the entire populace
-- IPP means infected population percentage

--select location, date, total_cases, population, (total_cases/ population)*100 as IPP
--from womentechers..CovidDeaths
--order by 1, 2

--looking at the country with the highest value of infected persons where PPI is the percentage population infected

--select location, population, MAX(total_cases) as HighestInfectionCount,  MAX((total_cases/ population))*100 as PPI
--from womentechers..CovidDeaths
--Group by location, population
--order by PPI desc

--showing countries with highest death rate per population where TDP Total Death Percentage

--select location, population, MAX(total_deaths) as TotalDeathCount, MAX((total_deaths/population)) as TDP
--from womentechers..covidDeaths
--Group by location, population
--order by TDP desc

--select location, population, MAX(cast(total_deaths as int)) as TotalDeathCount, MAX((total_deaths/population)) as TDP
--from womentechers..covidDeaths
--where continent is NOT NULL
--Group by location, population
--order by TOTALDeathCount desc


----breaking things down by continents

--select location, MAX(cast(total_deaths as int)) as TotalDeathCount2
--from womentechers..covidDeaths
--where continent is  null
--Group by location
--order by TOTALDeathCount2 desc

--select continent, MAX(cast(total_deaths as int)) as TotalDeathCount2
--from womentechers..covidDeaths
--where continent is not null
--Group by continent
--order by TOTALDeathCount2 desc


----showing countries in Africa with highest death rate

--select continent, location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Deathpercentage
--from womentechers..CovidDeaths
--where continent like '%africa%'
--order by date desc


--select continent, location, population, MAX(cast(total_deaths as int)) as TotalDeathCount2, MAX((total_deaths/population)) as TDP2
--from womentechers..covidDeaths
--where continent like '%Africa%'
--Group by location, continent, population
--order by TOTALDeathCount2 desc


--select *
--from womentechers..CovidDeaths dea
--join womentechers..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date

------looking at Total Population and Vaccinations

--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--from womentechers..CovidDeaths dea
--join womentechers..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
--order by 1,2


--USING CTE

--WITH PopvsVac (continent, location, date, population, new_vaccinations, TotallPeopleVaccinated)as
--(
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as TotallPeopleVaccinated
----, (TotallPeopleVaccinated/population)*100
--from womentechers..CovidDeaths dea
--join womentechers..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 1,2
--)
--select *, (TotallPeopleVaccinated/population)*100 as TPVP
--from PopvsVac



--USING TEMP TABLE

--Drop Table if exists #PercentagePopulationVaccinated
--Create Table #PercentagePopulationVaccinated
--(
--Continent nvarchar(255),
--Location nvarchar (255),
--Date datetime,
--Population numeric,
--New_vaccinations numeric,
--TotallPeopleVaccinated numeric
--)

--insert into #PercentagePopulationVaccinated
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as TotallPeopleVaccinated
----, (TotallPeopleVaccinated/population)*100
--from womentechers..CovidDeaths dea
--join womentechers..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 1,2
--select *, (TotallPeopleVaccinated/population)*100 as TPVP
--from #PercentagePopulationVaccinated




----creating views to store data for data visualization

--create view PercentagePopulationVaccinated as
--select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
--, SUM(CONVERT(int,vac.new_vaccinations)) over (Partition by dea.location order by dea.location, dea.date) as TotallPeopleVaccinated
----, (TotallPeopleVaccinated/population)*100
--from womentechers..CovidDeaths dea
--join womentechers..CovidVaccinations vac
--	on dea.location = vac.location
--	and dea.date = vac.date
--where dea.continent is not null
----order by 1, 2

--create view CovidDeathAfrica as
--select continent, location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Deathpercentage
--from womentechers..CovidDeaths
--where continent like '%africa%'
----order by date desc

--create view CovidDeathNigeria as
--select location, date, total_cases, total_deaths, (total_deaths/ total_cases)*100 as Deathpercentage
--from womentechers..CovidDeaths
--where location like '%Nigeria%' and continent is NOT NULL
----order by date desc

select *
from PercentagePopulationVaccinated 
