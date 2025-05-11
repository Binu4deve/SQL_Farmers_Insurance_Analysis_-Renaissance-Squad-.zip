
-- Group Name: Renaissance Squad
-- Topic: Farmers Insurance Analysis


use ndap;


-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName 
FROM data
order by srcStateName;
-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>


###

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, 
       SUM(TotalFarmersCovered) AS total_farmers, 
       SUM(SumInsured) AS total_insured
FROM data
GROUP BY srcStateName
ORDER BY total_farmers DESC;


-- ###

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select * 
from data
where srcYear = 2020;


-- ###

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select *
from data
where totalpopulationrural > 1000000 and srcstatename = 'HIMACHAL PRADESH';



-- ###

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, 
       srcDistrictName, 
       SUM(FarmersPremiumAmount) AS premium_amount
FROM data
WHERE srcyear = 2018  -- Filtering for the year 2018
GROUP BY srcStateName, srcDistrictName  -- Grouping by both state and district
ORDER BY premium_amount ASC;  -- Sorting in ascending order


-- ###

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcstatename,
	   sum(TotalFarmersCovered) as farmer_covered,
       sum(GrossPremiumAmountToBePaid) as gross_premium
from data
where InsuredLandArea > 5.0 and srcYear = 2018
group by srcstatename
order by farmer_covered desc
;
	  


	  
-- ###
-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]

-- 	Q7. 	Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcyear,
	   avg(insuredlandarea) as Insured_land_area
from data
group by srcyear;



-- ###

-- 	Q8. 	Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcDistrictName,
       sum(TotalFarmersCovered) as Farmers_covered
from data
where `Insurance units` > 0 
group by srcDistrictName
Order by Farmers_covered DESC;



-- ###

-- 	Q9.	For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 		and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       SUM(TotalFarmersCovered) AS farmers_covered,
       SUM(FarmersPremiumAmount + StatePremiumAmount + GOVPremiumAmount) AS Total_premium_amounts
FROM data
GROUP BY srcStateName
HAVING SUM(suminsured) > 500000.00;




-- ###

-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.	Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcDistrictName,
       sum(TotalPopulation) as TotalPopulation
from data
where srcYear = 2020
group by srcDistrictName
order by TotalPopulation desc
limit 5;




-- ###

-- 	Q11.	Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcDistrictName,
       SUM(suminsured) AS insured_sum
FROM data
WHERE farmerspremiumamount > 0
GROUP BY srcStateName, srcDistrictName
ORDER BY insured_sum ASC, SUM(farmerspremiumamount) ASC
LIMIT 10;



###

-- 	Q12. 	Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,
	   srcYear,
       sum(TotalFarmersCovered)/sum(TotalPopulation) as ratio_insured_farmers
from data
group by srcStateName, srcYear
order by ratio_insured_farmers desc
limit 3;



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. 	Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
Select distinct srcStateName,  
Left(srcStateName, 3) as StateShortName 
From data -- We can use order by to get result in A-Z order 
Order By srcStateName;



-- ###

-- 	Q14. 	Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcDistrictName
FROM data
WHERE srcDistrictName LIKE 'B%';



-- ###

-- 	Q15. 	Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
select srcStateName,
       srcDistrictName
from data
WHERE srcDistrictName LIKE '%pur';


-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]

-- 	Q16. 	Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT a.srcStateName, a.srcDistrictName, a.srcYear, SUM(a.FarmersPremiumAmount) AS TotalFarmersPremiumAmount
FROM data a
INNER JOIN data b
  ON a.srcStateName = b.srcStateName
  AND a.srcDistrictName = b.srcDistrictName
  AND a.srcYear = b.srcYear
WHERE b.`Insurance units` > 10
GROUP BY a.srcStateName, a.srcDistrictName, a.srcYear;



-- ###

-- 	Q17.	Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and the the highest recorded FarmersPremiumAmount for that district over all available years
-- 		Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName, srcDistrictName, srcYear, TotalPopulation, MAX(FarmersPremiumAmount) AS MaxFarmersPremiumAmount
FROM data
GROUP BY srcStateName, srcDistrictName
HAVING MaxFarmersPremiumAmount > 2000;  

SELECT d.srcStateName, d.srcDistrictName, d.srcYear, d.TotalPopulation, d.FarmersPremiumAmount
FROM data d
JOIN (
    SELECT srcStateName, srcDistrictName, MAX(FarmersPremiumAmount) AS MaxPremium
    FROM data
    GROUP BY srcStateName, srcDistrictName
) m
  ON d.srcStateName = m.srcStateName
  AND d.srcDistrictName = m.srcDistrictName
  AND d.FarmersPremiumAmount = m.MaxPremium
WHERE m.MaxPremium > 2000;


-- ###

-- 	Q18.	Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) for each district and state. 
-- 		Return the total premium amount (FarmersPremiumAmount) and the average population count for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT
  srcStateName,
  srcDistrictName,
  SUM(FarmersPremiumAmount) AS TotalFarmersPremiumAmount,
  AVG(TotalPopulation) AS AvgPopulation,
  SUM(TotalFarmersCovered) AS TotalFarmersCovered,
  SUM(SumInsured) AS TotalSumInsured
FROM data
GROUP BY srcStateName, srcDistrictName
HAVING TotalFarmersPremiumAmount > 10000  
ORDER BY TotalFarmersPremiumAmount DESC;




-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.	Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcDistrictName
FROM data
WHERE TotalFarmersCovered > (SELECT AVG(TotalFarmersCovered) FROM data);



-- ###

-- 	Q20.	Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT DISTINCT srcStateName
FROM data
WHERE SumInsured > (
    SELECT SumInsured
    FROM data
    WHERE FarmersPremiumAmount = (SELECT MAX(FarmersPremiumAmount) FROM data)
    LIMIT 1
);



-- ###

-- 	Q21.	Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- Find the state with highest total population
  WITH StatePop AS (
  SELECT srcStateName, SUM(TotalPopulation) AS TotalPop
  FROM data
  GROUP BY srcStateName
  ORDER BY TotalPop DESC
  LIMIT 1
),
StateAvgPremium AS (
  SELECT AVG(FarmersPremiumAmount) AS AvgPremium
  FROM data
  WHERE srcStateName = (SELECT srcStateName FROM StatePop)
)
SELECT srcDistrictName
FROM data
WHERE srcStateName = (SELECT srcStateName FROM StatePop)
  AND FarmersPremiumAmount > (SELECT AvgPremium FROM StateAvgPremium);




-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.	Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *,
  ROW_NUMBER() OVER (ORDER BY TotalFarmersCovered DESC) AS rn
FROM data;




-- ###

-- 	Q23.	Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *,
  RANK() OVER (PARTITION BY srcStateName ORDER BY SumInsured DESC) AS district_rank
FROM data;



-- ###

-- 	Q24.	Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT *,
  SUM(FarmersPremiumAmount) OVER (
    PARTITION BY srcStateName, srcDistrictName
    ORDER BY srcYear ASC
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS CumulativeFarmersPremium
FROM data;




-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25.	Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
CREATE TABLE states (
  StateCode INT PRIMARY KEY,
  StateName VARCHAR(100)
);

CREATE TABLE districts (
  DistrictCode INT PRIMARY KEY,
  DistrictName VARCHAR(100),
  StateCode INT
);



-- ###

-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
ALTER TABLE districts
ADD CONSTRAINT fk_statecode
FOREIGN KEY (StateCode) REFERENCES states(StateCode);



-- ###

-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27.	Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
UPDATE data
SET FarmersPremiumAmount = 500.0
WHERE rowID = 1;



-- ###

-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
UPDATE data
SET srcYear = 2021
WHERE srcStateName = 'HIMACHAL PRADESH';
-- ###

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
DELETE FROM data
WHERE TotalFarmersCovered < 10000 AND srcYear = 2020;
-- ###

