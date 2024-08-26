CREATE DATABASE Netflix;

USE Netflix;
SELECT * FROM netflix_userbase;

-- User ID :This is unique ID of Netflix users.

-- Subscription Types: It's have a 3 subscription type like Basic,Standard And premium.

-- Monthly revenue: Revenue is the total amount of money a  business generates from it's primary operations.

-- Join Date: It's represent a join date i.e which date you took a subscription.

-- Last Payment Date: It's represent the pay of amount of subscription type.

-- Country: This is represented by which country are user from to took a subscription.

-- Age: Represent the age of users.

-- Gender: Represent Gender i.e Male & Female.

-- Device: Have 3 Device contains like- Smartphone,Tablet,Smart TV.

-- Plan Duration: It's represent the duration of subscription.


#(1) How many users have each type of subscription (Basic, Standard, Premium)?
SELECT subscription_type, COUNT(*) AS Total_Users
FROM netflix_userbase GROUP BY subscription_type;


#(2) What is the total monthly revenue generated from each subscription type?
SELECT subscription_type, SUM(Monthly_Revenue) AS Total_Revenue
FROM netflix_userbase GROUP BY Subscription_Type;

#(3) How many users are from each country?
SELECT Country, COUNT(*) AS Total_Users
FROM netflix_userbase GROUP BY Country;

#(4) What is the total monthly revenue generated from users in each country?
SELECT Country, SUM(Monthly_Revenue) AS Total_Revenue
FROM netflix_userbase GROUP BY Country;

#(5) What is the average age of users for each subscription type?
SELECT Subscription_Type, AVG(Age) AS Average_Age
FROM netflix_userbase GROUP BY Subscription_Type;

#(6) How does the gender distribution vary across different device types?
SELECT Device, Gender, COUNT(*) AS Total_User
FROM netflix_userbase GROUP BY Device, Gender;

#(7) Which device type is most commonly used by users?
SELECT Device, COUNT(*) AS Total_Users
FROM netflix_userbase GROUP BY Device
ORDER BY Total_Users DESC LIMIT 5;

#(8) What is the distribution of users by device type in each country?
SELECT Country, Device, COUNT(*) AS Total_users
FROM netflix_userbase GROUP BY Country, Device ORDER BY Country, Device LIMIT 10;

#(9) How many users joined in each year (e.g., 2021, 2022, 2023)?
SELECT YEAR(Join_Date) AS Join_Year, COUNT(*) AS user_count
FROM netflix_userbase GROUP BY YEAR(Join_Date) ORDER BY Join_Year DESC;


#(10) What is the average time gap between the join date and the last payment date for each user?
SELECT AVG(TIMEDIFF(LastPayment_Date, Join_Date)) AS AvgTime_Gap FROM netflix_userbase;

#(11) What is the average monthly revenue per user across different age groups?
SELECT
    CASE
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    AVG(Monthly_Revenue) AS Avg_Monthly_Rev FROM netflix_userbase GROUP BY Age_Group
ORDER BY Age_Group;


#(12) Which subscription type generates the highest average monthly revenue per user?
SELECT Subscription_Type, AVG(Monthly_Revenue) AS Avg_Monthly_Rev
FROM netflix_userbase GROUP BY Subscription_Type ORDER BY Avg_Monthly_Rev DESC;

#(13) Are there any users with a plan duration other than "1 Month"? (This might require a check if the dataset has more information on plan durations.)
SELECT DISTINCT(Plan_Duration) FROM netflix_userbase WHERE Plan_Duration <> '1 Month';

#(14) How many users have made their last payment within the last month?
SELECT COUNT(*) AS Total_Users FROM netflix_userbase
WHERE LastPayment_Date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

#(15) Which subscription type has the highest percentage of active users (users with recent payment)?
#(16) What is the distribution of subscription types among male and female users?
SELECT Gender,Subscription_Type, COUNT(*) AS user_count FROM netflix_userbase 
GROUP BY Gender, Subscription_Type ORDER BY Gender, Subscription_Type;


#(17) How does the average monthly revenue differ between male and female users for each subscription type?
SELECT Subscription_Type, Gender, AVG(Monthly_Revenue) AS Avg_Monthly_Rev FROM netflix_userbase
GROUP BY Subscription_Type, Gender ORDER BY Subscription_Type, Gender;

#(18) Which country has the highest number of Premium subscribers?
SELECT Country, COUNT(*) AS Total_PremiumCount FROM netflix_userbase WHERE Subscription_Type = 'Premium'
GROUP BY Country ORDER BY Total_PremiumCount DESC LIMIT 5;

#(19) What is the average monthly revenue per user in each country for different device types?
SELECT Country, Device, AVG(Monthly_Revenue) AS Avg_Monthly_Revenue
FROM netflix_userbase GROUP BY Country, Device ORDER BY Country, Device;


#(20) What is the most common age group for each subscription type?
#(21) How does the subscription type preference change with age?
SELECT
    CASE
        WHEN age BETWEEN 18 AND 24 THEN '18-24'
        WHEN age BETWEEN 25 AND 34 THEN '25-34'
        WHEN age BETWEEN 35 AND 44 THEN '35-44'
        WHEN age BETWEEN 45 AND 54 THEN '45-54'
        WHEN age BETWEEN 55 AND 64 THEN '55-64'
        ELSE '65+'
    END AS Age_Group,
    Subscription_Type, COUNT(*) AS Total_Users FROM netflix_userbase GROUP BY Age_Group, Subscription_Type
ORDER BY Age_Group, Subscription_Type;

#(22) Retrieve all user records from the United States.
SELECT * FROM netflix_userbase WHERE Country = 'United States';

#(23) Select users who are subscribed to the Premium plan.
SELECT * FROM netflix_userbase WHERE Subscription_Type = 'Premium';

#(24) Find all users whose age is above 30 and are using a Smart TV.
SELECT * FROM netflix_userbase WHERE Age > 30 AND Device = 'Smart TV';

#(25) Select users who joined Netflix in the year 2023.
SELECT * FROM netflix_userbase WHERE YEAR(Join_Date) = '2023';
SELECT * FROM netflix_userbase WHERE Join_Date >= '2023-01-01' AND Join_Date < '2024-01-01';


#(26) Retrieve users whose last payment date was in June 2023.
SELECT * FROM netflix_userbase WHERE DATE(STR_TO_DATE(LastPayment_Date, '%Y-%m-%d')) BETWEEN '2023-06-01' AND '2023-06-30';


#(27) Calculate the total monthly revenue generated by each subscription type.
SELECT Subscription_Type, SUM(Monthly_Revenue) AS Total_monthly_Rev
FROM netflix_userbase GROUP BY Subscription_Type;

#(28) Find the average age of users based on their subscription type.
SELECT Subscription_Type, AVG(Age) AS Ave_Age FROM netflix_userbase GROUP BY Subscription_Type;

#(29) Determine the number of users from each country.
SELECT Country, COUNT(*) AS TotalCountry_Users FROM netflix_userbase GROUP BY Country;

#(30) Calculate the number of days between the join date and the last payment date for each user.
SELECT User_ID, DATEDIFF(LastPayment_Date, Join_Date) AS days_between FROM netflix_userbase;

SELECT User_ID, DATEDIFF( STR_TO_DATE(LastPayment_Date, '%Y-%m-%d'), STR_TO_DATE(Join_Date, '%Y-%m-%d')) 
AS Days_Between FROM netflix_userbase;

#(31) Find users who have been subscribed for more than 6 months.
SELECT User_ID, Join_Date FROM netflix_userbase WHERE DATEDIFF(CURDATE(), Join_Date) > 180;

#(32) List the top 10 users with the highest monthly revenue.
SELECT User_ID,  Monthly_Revenue FROM netflix_userbase
ORDER BY Monthly_Revenue DESC LIMIT 10;

#(33) Retrieve users sorted by their join date in ascending order.
SELECT * FROM netflix_userbase ORDER BY Join_Date ASC;


#(34) Select users who are either using a Smartphone or a Tablet and are from Canada.
SELECT * FROM netflix_userbase WHERE (Device = 'Smartphone' OR Device = 'Tablet') AND Country = 'Canada';

#(35) Find users who have never made a payment (assuming Last Payment Date could be NULL).
SELECT * FROM netflix_userbase WHERE LastPayment_Date IS NULL;

#(36) Find the total number of male and female users who have subscribed to the Standard plan.
SELECT Gender,COUNT(*) AS Total_Users FROM netflix_userbase
WHERE Subscription_Type = 'Standard' GROUP BY Gender;

#(37) Calculate the minimum, maximum, and average revenue generated from users aged between 25 and 40.
SELECT 
    MIN(Monthly_Revenue) AS Min_Revenue,
    MAX(Monthly_Revenue) AS Max_Revenue,
    AVG(Monthly_Revenue) AS Avg_Revenue
FROM netflix_userbase WHERE Age BETWEEN 25 AND 40;


