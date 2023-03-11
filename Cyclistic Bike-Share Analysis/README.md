
# Cyclistic Bike-Share Analysis

![download](https://user-images.githubusercontent.com/115058343/224495382-840c2852-f411-463c-b779-86c56d58242f.png)



<br>

Designing marketing strategies to convert casual riders into Cyclistic members in Chicago using Marketing Data Analytics.

## Business Problem

What is the problem?

* How do annual members and casual riders use Cyclistic bikes differently?
* Why would casual riders buy Cyclistic annual memberships?
* How can Cyclists use digital media to influence casual riders to become members?
* How can your insights drive business decisions?

If we know how casual riders differ from annual members, we can develop a strategy to target casual riders and convert them into annual members.

## Methodology

1. DATA COLLECTION

* The dataset contains 5,754,248 rows of records and 13 columns of attributes. The data types of the attributes consist of 9 object data types and 4 float data types, The memory space usage is at least 614.6 megabytes(MB).

* The next step is data cleaning to remove null values, data reduction to remove redundant attributes and duplicate values. This wil ensure that data is of high quality and would produce quality analysis.

<br>

2. DATA CLEANING 

* The dataset has a total of 3,504,158 null values across six columns. That is a lot of null values! To remove them, we will use the function dropna() from the Pandas library.

<br>

3. DATA TRANSFORMATION

* There were inconsistent values in the trip_duration variable, i.e., some had their start time later than or equal to the end time. For example, it occurred when Quality Control took the bikes out of circulation. Other values were longer than 4 hours.

<br>

4. DATA EXPLORATION AND VISUALIZATION

The process of data exploration to identify patterns and trends between Cyclistic members and casual riders splits across the following variables:

* Total Trips Taken
* Types of Bicycles Used
* Trips Taken in a Year
* Trips Taken in a Week
* Trips Taken in a Day
* Mean Trip Duration & Distance Across the Year
* Mean Trip Duration & Distance Across the Week

<br>

## Dashboard:
![Dashboard](https://user-images.githubusercontent.com/115058343/224495037-eca17565-03dc-489b-84e3-58af3bbe6f4a.png)


