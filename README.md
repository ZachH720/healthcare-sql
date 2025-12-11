# Healthcare-SQL
____
### Description
A repository containing a dataset with healthcare information imported from kaggle.com to MySQL to run queries.
* Original dataset: https://www.kaggle.com/datasets/prasad22/healthcare-dataset
* Cleaned dataset: ![Cleaned_Health_Data](/Dataset/modified_healthcare_dataset.csv)
    * This dataset was used for analysis.
* I first modified the name column with the PROPER formula using Google Sheets. The original data had several typos.
* I decreased the decimal point to two places for the billing amount.
* Created a table in MySQL for the dataset to be imported into with an additional column for an auto-incremented ID.

    ![CreateTable_SQL](/create_table.png)
* I performed several queries on the dataset to find information from the data.
    * ![SQL_Analysis](/Health_Data_Analysis.sql)
