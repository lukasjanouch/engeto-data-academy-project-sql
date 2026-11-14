[🇬🇧 English](README.md) | 🇨🇿 Čeština

---

# SQL Project

## Objective 

The goal of the project was to answer questions concerning the affordability of 
basic food items for the general public, simulating the role of an organization 
focused on citizens' living standards. The main task consisted of comparing 
food affordability based on average incomes over a specific period.

Additionally, the project includes data on other European countries for the 
same period as a primary overview compared to the Czech Republic.

## Main Tables
This section describes the tables used to obtain answers to the research questions.

1. t_lukas_janouch_project_SQL_primary_final

> This table contains payroll and food price data for the Czech Republic unified 
to an identical comparable period—shared years. It was created from the original 
database tables: czechia_payroll, czechia_price, czechia_payroll_value_type, 
czechia_payroll_unit, czechia_payroll_calculation, czechia_payroll_industry_branch, 
czechia_price_category, and czechia_region. The first two tables from this list 
(the payroll table and the selected food prices table) are joined using the year 
for which the wage or price applies. To make the values comparable, they had to 
be averaged, creating the columns yearly_payroll and yearly_price, representing 
the annual wage and annual price respectively. Wages were originally given per 
quarter and food prices for several days, such as November 13th to 17th. 
Therefore, the year is extracted from the food price date using the date_part() 
function.

> In the original payroll table, values are listed for two calculation 
methods—both physical and recalculated (full-time equivalent). In the WHERE 
clause of the query creating this table, the recalculated method is selected 
because it accounts for employees working part-time. Furthermore, the data 
here is restricted only to wages regarding czechia_payroll_value_type, as the 
second type represents the number of employed persons in an industry, which 
is not relevant to the research questions.

2. t_lukas_janouch_project_SQL_secondary_final

## Research Questions 

1. Do wages grow across all industries over the years, or do they drop in some?

> The base of the SELECT statements providing answers to this question is formed 
by the view v_payroll_diference_data. Compared to a Common Table Expression (CTE), 
a view has the advantage of writing the query only once. It shows how wages changed 
year-over-year in individual industries and, thanks to window functions, also displays 
the wage difference in a given year compared to the previous year.

> The first independent select then returns only those rows from the previous 
result where a wage drop occurred compared to the previous year. In some cases, 
a drop occurred multiple times, for instance, four times in mining and quarrying. 
Another select also uses the v_payroll_difference_data view and displays only 
those industries where a drop compared to the previous year never occurred: human 
health and social work activities, manufacturing, and other service activities. 
Thanks to the final select, it can be ascertained that wages in the last comparable 
period are always higher compared to the first comparable period across all 
industries, meaning that overall wages always grew and dropped only locally.

2. How many liters of milk and kilograms of bread can be bought for the first 
and the last comparable period in the available price and wage data?

> The query result shows how many liters of milk and kilograms of bread can be 
purchased with the wage in a given industry—first individually for each industry 
in the first comparable period of available data (the year 2006) and then for 
each industry in the last comparable period (the year 2018). 

3. Which food category has the slowest price growth (showing the lowest 
percentage year-over-year increase)?

> The query first calculates the percentage change in food price from year to 
year by dividing the difference between the current and last year's price by 
the current price and multiplying the fraction by 100. Another select determines 
the average of these price changes for each food category. Finally, it returns 
the category whose average price change is the smallest among those greater 
than zero. Values greater than zero are sought because we are interested in 
price increases (inflation), and the smallest among them represents the 
slowest-changing price.

4. Is there a year in which the year-over-year food price increase was 
significantly higher than wage growth (greater than 10%)?

> Here, the average salary across all sectors in the database (wage categories) 
and the average food price across all food types (price categories) are 
calculated for each year. After determining the percentage differences in 
prices and wages compared to the previous year, the difference between these 
two values is calculated. The largest difference between percentage price and 
wage growth is 6.65. This means that price growth was at most 6.65% higher and 
never exceeded 10%.  

5. Does the level of GDP have an impact on changes in wages and food prices? 
In other words, if GDP grows more significantly in one year, does it manifest 
as a more significant growth in food prices or wages in the same or the following 
year?

> It is evident from the data that GDP may influence changes in wages and prices, 
but these variables do not always behave entirely identically to GDP because 
they are also affected by other factors. For example, in 2009, although GDP and 
food prices dropped, wages grew despite this. Conversely, in 2014, both GDP and 
wages grew, while food prices grew only very slightly, followed by a drop in 2015 
and 2016, after which they grew again alongside the GDP recovery in 2017.

