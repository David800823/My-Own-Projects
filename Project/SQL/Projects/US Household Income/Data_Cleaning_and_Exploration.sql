-- Use the right Data Base
USE us_household_income;


-- Data Import --
-- I got two csv file which I will import into us_household_income database

-- Checking Both Tables to make sure import went well
SELECT * 
FROM ushouseholdincome;

Select *
FROM ushouseholdincome_statistics;

-- I do not like the record id for the us househol income statisitcs table 

-- Lets renmame the column
ALTER TABLE ushouseholdincome_statistics RENAME COLUMN ï»¿id to ushh_ID;

-- Checking to see if column is renamed
Select *
FROM ushouseholdincome_statistics;
-- It is renamed

-- Data Cleaning -- 
SELECT * 
FROM ushouseholdincome;

-- Lets check for duplicate values in the us household income table

Select id, COUNT(id) 
FROM ushouseholdincome
GROUP BY id
HAVING Count(id) > 1
;

-- It looks like there is id that repeats itself
-- Lets take a deeper look
Select *
FROM ushouseholdincome
Where id IN (
Select id
FROM ushouseholdincome
GROUP BY id
HAVING Count(id) > 1
)
ORDER BY id, row_id
;
-- The repeated id are definetly duplicates. 
-- I will identify the second id and remove them

DELETE FROM ushouseholdincome
Where row_id IN 
(Select row_id
FROM
(Select *,
	row_number() OVER(Partition BY id ORDER BY row_id) AS duplicate_row
FROM ushouseholdincome
Where id IN (
Select id
FROM ushouseholdincome
GROUP BY id
HAVING Count(id) > 1
)
ORDER BY id
) AS table_2
Where duplicate_row > 1)
;
-- Optimizing the query above
Select row_id
FROM (Select row_id, id, row_number() OVER(Partition BY id ORDER BY row_id) AS duplicate_row
FROM ushouseholdincome_original -- I used the staging because I already removed the previous rows
) as table1
Where duplicate_row > 1
;



-- Lets check the previous query tosee if it was deleted
Select id, COUNT(id) 
FROM ushouseholdincome
GROUP BY id
HAVING Count(id) > 1
;

-- It worked :)


-- Lets look for null
Select 
	SUM(CASE When row_id IS Null Then 1 END) AS Row_ID,
     SUM(CASE When id IS Null Then 1 END) AS ID,
     SUM(CASE When State_Code IS Null Then 1 END) AS State_Code,
     SUM(CASE When State_ab IS Null Then 1 END) AS State_ab,
     SUM(CASE When County IS Null Then 1 END) AS County,
     SUM(CASE When City IS Null Then 1 END) AS City,
     SUM(CASE When Place IS Null Then 1 END) AS Place,
     SUM(CASE When Type IS Null Then 1 END) AS Type,
     SUM(CASE When `Primary` IS Null Then 1 END) AS Primary_,
     SUM(CASE When Zip_Code IS Null Then 1 END) AS Zip_Code,
     SUM(CASE When Area_code IS Null Then 1 END) AS Area_code,
     SUM(CASE When ALand IS Null Then 1 END) AS ALand,
     SUM(CASE When AWater IS Null Then 1 END) AS AWater,
     SUM(CASE When Lat IS Null Then 1 END) AS Lat,
     SUM(CASE When Lon IS Null Then 1 END) AS Lon
FROM 
	ushouseholdincome
;
-- There are no Null values any where
-- Thats good

-- Lets look for any blanks

Select 
	SUM(CASE When row_id = "" Then 1 END) AS Row_ID,
     SUM(CASE When id = "" Then 1 END) AS ID,
     SUM(CASE When State_Code = "" Then 1 END) AS State_Code,
     SUM(CASE When State_ab = "" Then 1 END) AS State_ab,
     SUM(CASE When County = "" Then 1 END) AS County,
     SUM(CASE When City = "" Then 1 END) AS City,
     SUM(CASE When Place = "" Then 1 END) AS Place,
     SUM(CASE When Type = "" Then 1 END) AS Type,
     SUM(CASE When `Primary` = "" Then 1 END) AS Primary_,
     SUM(CASE When Zip_Code = "" Then 1 END) AS Zip_Code,
     SUM(CASE When Area_code = "" Then 1 END) AS Area_code,
     SUM(CASE When ALand = "" Then 1 END) AS ALand,
     SUM(CASE When AWater = "" Then 1 END) AS AWater,
     SUM(CASE When Lat = "" Then 1 END) AS Lat,
     SUM(CASE When Lon = "" Then 1 END) AS Lon
FROM 
	ushouseholdincome
;
-- From our query, we notice place has a blank value in Place
-- Lets take a look

Select *
FROM ushouseholdincome
Where Place = ""
;

-- The blank space is in Autauga Couty
-- I will view the rows in Autauga County, alter
Select *
FROM (Select row_ID, State_Name, County, City, Place, lag(Place) OVER(Order BY id) AS Prev_Place, lead(Place) OVER(Order BY id) AS Next_Place
FROM ushouseholdincome
ORDER BY id) AS dff
Where Place = ""
;

-- It Looks like it shoud be in Autaugville
-- Lets Update
UPDATE ushouseholdincome
SET Place = "Autaugaville"
Where row_ID = 32
;

-- The other columns ALand and AWater can be blank. Since some places may not have water or land. 
-- For calculation purposes, I will change them to NULL
UPDATE ushouseholdincome
SET ALand = NULL 
WHERE ALand = ""
;

UPDATE ushouseholdincome
SET AWater = NULL 
WHERE AWater = ""
;

-- Lets Look at our text columns
Select *
FROM ushouseholdincome
;

-- State_name has lower and upper case values
-- Lets change it to Upper
UPDATE ushouseholdincome
SET State_Name = UPPER(State_Name)
;

-- Lets check the distnct names
Select Distinct State_Name
FROM ushouseholdincome
;
-- It looks like someone misspelled Georgia
-- Lets Fix it
UPDATE ushouseholdincome
Set State_Name = "GEORGIA"
Where State_Name = "GEORIA"
;


-- Lets check 
Select Distinct State_Name
FROM ushouseholdincome
;
-- It was fixed

-- Lets Chech again
Select *
FROM ushouseholdincome
;


-- Let Check the distinct type
Select Distinct Type
FROM ushouseholdincome
ORDER BY 1
;
-- Two way of saying borough
-- Lets change them to borough

UPDATE ushouseholdincome
SET Type = "Borough"
Where Type = "Boroughs"
;

Select Distinct Type
FROM ushouseholdincome
ORDER BY 1
;
-- It looks good

-- Lets check for another column
-- Primary Column
Select Distinct `Primary`
FROM ushouseholdincome
ORDER BY 1
;

-- Lets just change it to one standardized Primary
UPDATE ushouseholdincome
SET `Primary` = UPPER(`Primary`)
;


-- I think this table looks good
-- We may still find some data quality issues when we start to analyse these numbers
-- Lets look at ushousehold income stats
Select *
FROM ushouseholdincome_statistics
;

-- Lets check for duplicate ID
Select *
FROM 
(Select ushh_ID, row_number() OVER(Partition BY ushh_ID ORDER BY ushh_ID) AS Dupe
FROM ushouseholdincome_statistics) AS Dupe_tab
Where Dupe > 1
;

# NO DUPLICATES
Select *
FROM ushouseholdincome_stattistics
;






-- Data Analysis
Select *
FROM ushouseholdincome
;


Select *
FROM ushouseholdincome_statistics
;

-- To better see the table lets join them together
Select *
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
;


-- Lets see which State has the highest Median Income
Select ushi.State_Name, ROUND(AVG(stat.Mean),1) AS AVG_Income
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
Where stat.Mean <> 0 
GROUP BY ushi.State_Name
ORDER BY AVG(stat.Mean) DESC
;

-- Results -- 
-- It seems The District of Columbia, Connecticut, and New Jersey have the highest average income. 


-- Lets look at the other STATS
Select ushi.State_Name, 
ROUND(AVG(stat.Mean),1) AS AVG_Income, 
ROUND(AVG(stat.Median),1) AS Median_Income
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
Where stat.Mean <> 0 or stat.Median <> 0
GROUP BY ushi.State_Name
ORDER BY AVG(stat.Median) DESC
;

-- When we compare Median to Average, we notice New Jersey has a higher median income than average.
-- Interesting

-- Lets See how much Water and land each state has
Select State_Name, SUM(ALand), SUM(AWater)
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY SUM(ALand) DESC
;

-- Makes sense Texas and California has the biggest land mass

Select State_Name, SUM(ALand), SUM(AWater)
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY SUM(AWater) DESC
;

-- Michigan has the great lakes and it makes sense why it is the highest.

-- Lets Find the Top 10 State by Land
Select State_Name, SUM(ALand)
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY SUM(ALand) DESC
LIMIT 10
;


-- Lets Find the top 10 States by Water
Select State_Name, SUM(AWater)
FROM ushouseholdincome
GROUP BY State_Name
ORDER BY SUM(AWater) DESC
LIMIT 10
;

-- Lets Look at both tables again
Select *
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
;

-- Lets Find the State that has a higher than average 
Select AVG(Mean)
FROM ushouseholdincome_statistics
;


-- I am using a CTE to query the table
-- I want to find the state that have a higher income than the national average
WITH State_Table AS (
    Select State_Name, AVG(Mean) AS avg_mean
    FROM ushouseholdincome_statistics
    GROUP BY State_Name
) 

Select 
	row_number() OVER(ORDER BY avg_mean DESC) AS Rank_,
	State_Name
From State_Table
Where avg_mean > (Select AVG(Mean)
			   FROM ushouseholdincome_statistics)
ORDER BY avg_mean DESC                  
;

-- Lets look at Type and income
Select ushi.Type, 
	COUNT(ushi.Type) AS Count_Type,
	ROUND(AVG(stat.Mean),1) AS AVG_Income, 
	ROUND(AVG(stat.Median),1) AS Median_Income
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
Where stat.Mean <> 0 or stat.Median <> 0
GROUP BY ushi.Type
HAVING Count_Type > 100
ORDER BY Count_Type DESC
;

-- Lets Look at city and state income
-- This may be interesting
Select CONCAT(ushi.City,", ", ushi.State_Name) AS City_State,
	ROUND(AVG(stat.Mean),1) AS AVG_Income, 
	ROUND(AVG(stat.Median),1) AS Median_Income
FROM ushouseholdincome ushi
	JOIN ushouseholdincome_statistics stat ON ushi.id = stat.ushh_ID
Where mean <> 0 or Median <> 0
GROUP BY City_State
ORDER BY AVG_Income DESC
Limit 10
;