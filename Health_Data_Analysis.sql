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
SELECT COUNT(*) AS Total_Patients FROM health_data;
/* Findings: 
            Total_Patients
            --------------
            55500
*/

-- 2. Find maximum, minimum and avergae age of patients.
SELECT MAX(age) AS Maximum_Age, MIN(age) AS Minimum_Age, ROUND(AVG(age), 2) AS Average_Age 
FROM health_data;
/* Findings:

      Maximum_Age	 | Minimum_Age | Average_Age
      ----------------------------------------
      89	         | 13          | 51.54
*/

-- 3. Find the top ten doctors taking care of the most patients and the amount of patients in their care
SELECT doctor AS Doctor, COUNT(doctor) as Number_of_Patients FROM health_data
GROUP BY doctor
ORDER BY Number_of_Patients DESC
LIMIT 10;
/* Findings: A table with the top ten doctor's who have the most patients in descending order.
 
        Doctor            |	  Number_of_Patients
        ----------------------------------------
        Michael Smith	  |   27
        John Smith	      |   22
        Robert Smith	  |   22
        James Smith	      |   20
        Michael Johnson   |   20
        David Smith	      |   19
        Robert Johnson    |   19
        Michael Williams  |	  18
        Matthew Smith	  |   17
        Christopher Smith |   17
*/

-- 4. Calculate the total number of patients in each age range by decades.
SELECT 
	CASE
    WHEN age < 10 THEN '0-9'
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
ORDER BY MIN(age);
/* Findings: A list of age ranges and total patients within those age ranges. The list begins with youngest patients and end with eldest.

        Age_Group	  | Patient_Count
        ---------------------------
        10-19	      | 1693
        20-29	      | 8000
        30-39	      | 8179
        40-49         | 8130
        50-59	      | 8350
        60-69	      | 8177
        70-79	      | 8072
        80-89	      | 4899
*/

-- 5. Find the longest and shortest patient admissions.
SELECT MIN(DATEDIFF(discharge_date, admission_date)) AS Min_Days_Admitted,
       MAX(DATEDIFF(discharge_date, admission_date)) AS Max_Days_Admitted 
FROM health_data;
/* Findings:

        Min_Days_Admitted	  | Max_Days_Admitted
        ---------------------------------------
        1	                  | 30
*/


-- 6. Find the average billing cost grouped by length of admission, and include amount of patients in category.
SELECT DATEDIFF(discharge_date, admission_date) AS Length_of_Admission,
   ROUND(AVG(billing_amount), 2) AS Average_Billing_Amount,
   COUNT(DATEDIFF(discharge_date, admission_date)) AS Total_Patients
FROM health_data
GROUP BY Length_of_Admission
ORDER BY Length_of_Admission;
/* Findings: A table ordered by duration of admissions with average billing cost associated to length of stay. The total amount of patients is also listed for each admission duration.

      Length_of_Admission |	Average_Billing_Amount	| Total_Patients
      --------------------------------------------------------------
      1	                  | 25310.91                | 1817
      2	                  | 25288.46	            | 1844
      3	                  | 25963.83	            | 1841
      4	                  | 26005.48                | 1863
      5	                  | 25472.86	            | 1832
      6	                  | 25939.12	            | 1903
      7	                  | 25729.11                | 1886
      8	                  | 26123.39	            | 1828
      9                   |	25558.2                 | 1868
      10	              | 25434.42	            | 1802
      11	              | 25118.4	                | 1895
      12	              | 25499.9	                | 1843
      13	              | 24943.19                | 1864
      14	              | 26286.29	            | 1909
      15	              | 25701.13	            | 1785
      16	              | 25735.81                | 1757
      17	              | 25386.88                | 1818
      18	              | 24795.85                | 1819
      19	              | 25125.44                | 1890
      20	              | 25881.44                | 1907
      21                  | 25435.7	                | 1959
      22	              | 25394.88	            | 1784
      23	              | 25909.97	            | 1866
      24	              | 25823.47                | 1759
      25                  |	25277.98	            | 1864
      26	              | 25558.6                 | 1819
      27	              | 25489.47                | 1884
      28	              | 25795.11	            | 1853
      29	              | 24803.92	            | 1867
      30                  | 25385.38	            | 1874
*/

-- 7. Find how many patients each insurance company covers.
SELECT insurance_provider, COUNT(*) AS Total_Patients_Covered FROM health_data
GROUP BY insurance_provider
ORDER BY insurance_provider;
/* Findings: A table with each insurance company and all associated patients that they cover.

     insurance_provider	| Total_Patients_Covered
     --------------------------------------------
     Aetna	            | 10913
     Blue Cross	        | 11059
     Cigna	            | 11249
     Medicare	        | 11154
     UnitedHealthcare	| 11125
*/


-- 8. Find each category of test results and how many patients are included in each.
SELECT test_results, COUNT(test_results) AS Total_Patients FROM health_data
GROUP BY test_results
ORDER BY test_results; 
/* Findings:

          test_results | Total_Patients
          -----------------------------
          Abnormal     | 18627
          Inconclusive | 18356
          Normal       | 18517
*/  

-- 9. What is the number of patients for each blood type and the percentage of patients with abnormal results.
SELECT 
  blood_type,
  COUNT(CASE WHEN test_results = 'Abnormal' THEN 1 ELSE NULL END) AS Abnormal_Count,
  COUNT(*) AS Total_Count,
  ROUND(CAST(COUNT(CASE WHEN test_results = 'Abnormal'THEN 1 ELSE NULL END) AS FLOAT) / COUNT(*), 2) AS Abnormal_Percentage
FROM health_data
GROUP BY blood_type
ORDER BY blood_type;
/* Findings: A table with four columns and rows seperated by blood type. The table indicated total patients by blood type, how many were abnormal and then the percentage of abnormal test results by blood type.

   blood_type | Abnormal_Count | Total_Count | Abnormal_Percentage
   ---------------------------------------------------------------
   A-         | 2336           | 6969        | 0.34
   A+         | 2333           | 6956        | 0.34
   AB-        | 2333           | 6945        | 0.34
   AB+        | 2308           | 6947        | 0.33
   B-         | 2348           | 6944        | 0.34
   B+         | 2303           | 6945        | 0.33
   O-         | 2319           | 6877        | 0.34
   O+         | 2347           | 6917        | 0.34
*/

-- 10. Find the hospitals that only have elderly patients with abnormal test results. Only include hospitals with more than 2 cases. 
WITH non_normal_results AS (
	SELECT hospital, COUNT(*) AS Total,
    COUNT(CASE WHEN age > 65 AND test_results = 'Abnormal' THEN 1 ELSE NULL END) AS Elderly_Abnormal_Count
    FROM health_data
    GROUP BY hospital
    ORDER BY hospital
)
SELECT hospital, Total, Elderly_Abnormal_Count
FROM non_normal_results
WHERE Total - Elderly_Abnormal_Count = 0 AND Total > 2;

/* Findings

        hospital	        | Total 	 |  Elderly_Abnormal_Count
        ------------------------------------------------------
        Davis-Simpson	    | 3	         |  3
        Gallegos Ltd	    | 3	         |  3
        Group Mullins       | 3          |	3
        LLC Hahn	        | 3          |	3
        Montoya Inc	        | 3          |	3
        Singleton Group     | 3          |	3
*/
