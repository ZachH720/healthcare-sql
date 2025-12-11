-- Data analysis using MySQL on Health data
  -- The dataset used is synthetic. The data does not represent real patient information.

--Create a Database named healthcare_db
CREATE DATABASE healthcare_db;

--Select database
USE healthcare_db;

-- Create table for imported data
CREATE TABLE health_data (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(40),
  age INT,
  gender VARCHAR(10),
  blood_type VARCHAR(3),
  medical_condition VARCHAR(25),
  admission_date DATE,
  doctor VARCHAR(40),
  hospital VARCHAR(50),
  insurance_provider VARCHAR(30),
  billing_amount DOUBLE,
  room_number VARCHAR(10),
  admission_type VARCHAR(20),
  discharge_date DATE,
  medication VARCHAR(30),
  test_results VARCHAR(20)
);

-- Use import wizard to import the dataset

-- View health_data
SELECT * FROM health_data;

-- 1. Count Total patients in health_data table.
SELECT COUNT(*) FROM health_data;
-- Findings: 55500

-- 2. Find maximum and minimum age of patients.
SELECT MAX(age) AS Max_Age, MIN(age) AS MIN_Age FROM health_data;
--Findings: Max_Age = 89  Min_Age = 13

-- 3. Find the average age of patients with two decimal places.
SELECT ROUND(AVG(age), 2) AS Avg_Age FROM health_data;
-- Findings: 51.54

-- 4. Find the total amount of patients each doctor takes care of.
SELECT doctor, COUNT(doctor) as Number_of_Patients FROM health_data
GROUP BY doctor
ORDER BY Number_of_Patients DESC;
-- Findings: A list of each doctor's name and how many patients they're seeing. The list starts with highest volume and ends with least.

-- 5. Calculate the total number of patients in each age range by decades.
SELECT 
	CASE
		WHEN age < 10 THEN 'Less than 10'
		WHEN age BETWEEN 10 AND 19 THEN '10-19'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age BETWEEN 50 AND 59 THEN '50-59'
        WHEN age BETWEEN 60 AND 69 THEN '60-69'
        WHEN age BETWEEN 70 AND 79 THEN '70-79'
        WHEN age BETWEEN 80 AND 89 THEN '80-89'
        WHEN age BETWEEN 90 AND 99 THEN '90-99'
        WHEN age > 99 THEN '100 or above'
	END AS Age_Group,
    COUNT(*) AS Patient_Count
FROM health_data
GROUP BY Age_Group
ORDER BY MIN(age); -- Sort ranges logically
-- Findings: A list of age ranges and total patients within those age ranges. The list begins with youngest patients and end with eldest.

-- 6. Find the longest and shortest patient admissions.
SELECT MIN(DATEDIFF(discharge_date, admission_date)) AS Min_Days_Admitted,
       MAX(DATEDIFF(discharge_date, admission_date)) AS Max_Days_Admitted 
FROM health_data;
-- Findings: Min_Days_Admitted = 1  Max_Days_Admitted = 30

-- 7.