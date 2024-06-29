-- Data Cleaning

-- Use the right database
USE world_life_expectancy;

-- Created another Table called worldlifeexpectancy_staging
-- That will be the original data.
-- It will not be touched

-- Inspecting Data Table
Select *
FROM worldlifeexpectancy
;

-- I will clean the data by checking each row individually

-- First Country
Select Country
From worldlifeexpectancy
Group BY Country
ORDER BY Country ASC
;
-- Looks Like all countries are spelled the same

-- Lets see if there is any duplicate
-- I will make sure there is only 1 Country for every Year
Select Country, Year, Count(Row_ID) AS Duplicate 
FROM worldlifeexpectancy
Group BY Country, YEAR
HAVING Count(Row_ID) > 1
;

-- In order to get the row number I wil make another query
Select *
FROM 
(Select 
	Row_ID,
     CONCAT(Country, Year) AS Duplicate_Name,
     row_number() OVER(Partition BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Dupe_Check
FROM worldlifeexpectancy
) AS Dupe_Table
Where Dupe_Check > 1
;

-- The inner query creates new values from the Country and Year column.
-- With that, we can count whether or not that unique name is repeated multiple times
-- I use a subquery to filter the Dupe_Check for values over 1.alter



-- Now I alter the table and remove the rows
DELETE FROM worldlifeexpectancy
WHERE Row_ID IN (Select Row_ID
FROM 
(Select 
	Row_ID,
     CONCAT(Country, Year) AS Duplicate_Name,
     row_number() OVER(Partition BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Dupe_Check
FROM worldlifeexpectancy
) AS Dupe_Table
Where Dupe_Check > 1
)
;
-- The query above I can use to remove duplicates any time i add new data to the table.
-- Very Handy


-- Inspecting Data Table
Select *
FROM worldlifeexpectancy
;

-- Looking at Status
Select Status
FROM worldlifeexpectancy
GROUP BY Status
;

-- FROM the above query i noticed there are some black values for Status
-- Lets look at them
Select Row_ID, Country, Year, Status
FROM worldlifeexpectancy
Where Status = ""
;

-- I am thinking of giving them a status from the previous year. 
-- But to make sure I do not add a status from the wrong country, I will looka at their previous values.
Select w.Row_ID, w.Country, w.Year, w.Status,  wl.Row_ID, wl.Country, wl.Year, wl.Status
FROM worldlifeexpectancy w JOIN worldlifeexpectancy wl
	ON w.Row_ID = wl.Row_ID - 1
Where w.Status = ""
;


-- This query confirms that each country has the same country the previous year.
-- Thus Lets update the status
Select *
FROM 
(Select Row_ID, 
Country, 
LAG(Country) OVER(ORDER BY Country,Year) AS Prev_Country, 
Year, 
LAG(Year) OVER(ORDER BY Country,Year) AS Prev_Year, 
Status, 
LAG(Status) OVER(ORDER BY Country, Year) AS Prev_Status
FROM worldlifeexpectancy
) AS Tab
Where Status = ""
;
-- 
-- '9', 'Afghanistan', '2014', '', '10', 'Afghanistan', '2013', 'Developing'
-- '18', 'Albania', '2021', '', '19', 'Albania', '2020', 'Developing'
-- '989', 'Georgia', '2012', '', '990', 'Georgia', '2011', 'Developing'
-- '991', 'Georgia', '2010', '', '992', 'Georgia', '2009', 'Developing'
-- '2798', 'United States of America', '2021', '', '2799', 'United States of America', '2020', 'Developed'
-- '2847', 'Vanuatu', '2020', '', '2848', 'Vanuatu', '2019', 'Developing'
-- '2915', 'Zambia', '2016', '', '2916', 'Zambia', '2015', 'Developing'
-- '2919', 'Zambia', '2012', '', '2920', 'Zambia', '2011', 'Developing'
-- 
Select Row_ID
FROM (
Select Row_ID, Country, Year,
	Status,
	LAG(Status) OVER(ORDER BY Country, Year) AS Prev_Status
FROM worldlifeexpectancy
ORDER BY Country, Year) AS Tab_Row_ID
Where Status = "" and Prev_Status = "Developing"
;

-- Set Developing to the right countries
UPDATE worldlifeexpectancy
SET Status = "Developing"
Where Row_ID IN 
(Select Row_ID
FROM (
Select Row_ID, Country, Year,
	Status,
	LAG(Status) OVER(ORDER BY Country, Year) AS Prev_Status
FROM worldlifeexpectancy
ORDER BY Country, Year) AS Tab_Row_ID
Where Status = "" and Prev_Status = "Developing")
;

-- Set Developed to the right countries
UPDATE worldlifeexpectancy
SET Status = "Developing"
Where Row_ID IN 
(Select Row_ID
FROM (
Select Row_ID, Country, Year,
	Status,
	LAG(Status) OVER(ORDER BY Country, Year) AS Prev_Status
FROM worldlifeexpectancy
ORDER BY Country, Year) AS Tab_Row_ID
Where Status = "" and Prev_Status = "Developed")
;

-- Double Check
Select DISTINCT(Status)
From worldlifeexpectancy
;

-- Check again
Select *
From worldlifeexpectancy
;

-- Everything Looks good
-- Since the rest of the columns are numbers, I will make a querie that will count the NULL values for each column. 
-- This will help focus on the columns that have null values or ""

Select Row_ID, Country, Year, `Life expectancy`
FROM worldlifeexpectancy
#Where `Life expectancy` = ""
;

-- Both values are empty and they have a year of 2018. 
-- So i will replace the empty values to the previous year

Select t1.Row_ID, t1.Country, t1.Year, t1.`Life expectancy`,
	  t2.Row_ID, t2.Country, t2.Year, t2.`Life expectancy`,  
       t3.Row_ID, t3.Country, t3.Year, t3.`Life expectancy`,
       Round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1) AS Average
FROM worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
     AND t1.Year = t2.Year -1
JOIN worldlifeexpectancy t3
	ON t1.Country = t3.Country
     AND t1.Year = t3.Year +1
Where t1.`Life expectancy` = ""
;


UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.Country = t2.Country
     AND t1.Year = t2.Year -1
JOIN worldlifeexpectancy t3
	ON t1.Country = t3.Country
     AND t1.Year = t3.Year +1
SET t1.`Life expectancy` =  Round((t2.`Life expectancy` + t3.`Life expectancy`) / 2,1)
WHERE t1.`Life expectancy` = ""
;


-- 

Select *
From worldlifeexpectancy
;

-- Checking other Null Values
Select Measles
FROM worldlifeexpectancy
Where Measles IS NULL;
-- Measles there are No null values
-- OR empty
Select Measles
FROM worldlifeexpectancy
Where Measles = "";

-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------



-- Data Exploration
Select *
FROM worldlifeexpectancy_staging;

-- Lets see the country Life Expectancy (LE)
-- Minimum LE
-- Maximum LE
-- Change FROM LE
Select Country, MIN(`Life expectancy`) AS MIN_LE, MAX(`Life expectancy`) AS MAX_LE,  ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Change_LE
FROM worldlifeexpectancy
GROUP BY Country
HAVING MIN_LE <> 0 AND MAX_LE <> 0
ORDER BY Change_LE ASC #DESC
;

-- RESULTS
-- Haiti, Zimbabwe, Eritrea, Uganda all made changes in Life expectancy over 20.
-- While Guyana, Seychellas, Kuwait, Phillipines made little changes to life expectancy.


-- Lets find the average worlds life expectancy From the begining
-- Also Percent Change From prior year
Select *,
	ROUND(((average_le - LAG(average_le) OVER(ORDER BY YEAR ASC)) / LAG(average_le) OVER(ORDER BY YEAR ASC)) *100 ,4) AS Percent_Change
FROM
(Select Year, ROUND(AVG(`Life expectancy`),2) AS average_le
FROM worldlifeexpectancy
WHERE `life expectancy` <> 0
GROUP BY YEAR
ORDER BY Year ASC) AS Table_1
;
-- The highest percent change happened in 2012


-- Correlation for Life Expectancy and the other columns
Select Country, ROUND(AVG(`Life expectancy`),1) AS Average_Lifeexpectancy, ROUND(AVG(GDP),1) AS Average_GDP
FROM worldlifeexpectancy
Group BY Country
HAVING Average_Lifeexpectancy <> 0 and Average_GDP <> 0
ORDER BY Average_GDP ASC
;
-- It seems higher GDP is correlated to Average Life Expectancy

-- Lets See the count of Developed Countries as well as Developing Countries
-- Lets also show the percent
Select Status, Count(Distinct(Country)) AS Count,  Round((Count(Distinct(Country)) / (Select Count(Distinct(Country)) FROM worldlifeexpectancy) * 100 ),2) As Percent
FROM worldlifeexpectancy
GROUP BY Status
;


-- Status with Life Expectancy, GDP, schooling
Select 
	Status, 
     Count(Distinct(Country)) AS Count, 
     ROUND(AVG(`Life expectancy`),2) AS AVG_life_expectancy,
     ROUND(AVG(GDP),2) AS AVG_GDP,
     ROUND(AVG(Schooling),2) AS AVG_Schooling_Score
FROM worldlifeexpectancy
GROUP BY Status
;

-- Results --
-- From this query, we can see that in developed countries the average life expectancy is about 13 years higher than Developing countries
-- People in Developed countries typically have better school score


-- Adult Mortality Rolling Total
-- 

Select 
	Country,
     Year,
     `Life expectancy`,
     `Adult Mortality`,
     SUM(`Adult Mortality`) OVER(partition BY Country ORDER BY Year) AS Running_Total
FROM 
	worldlifeexpectancy
;
	
