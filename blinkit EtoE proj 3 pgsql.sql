CREATE TABLE blinkit (
    item_fat_content VARCHAR(50),
    item_identifier VARCHAR(20),
    item_type VARCHAR(100),
    outlet_establishment_year INT,
    outlet_identifier VARCHAR(20),
    outlet_location_type VARCHAR(50),
    outlet_size VARCHAR(50),
    outlet_type VARCHAR(100),
    item_visibility NUMERIC(10,6),
    item_weight NUMERIC(10,2),
    total_sales NUMERIC(12,4),
    rating NUMERIC(3,1)
);

select * from blinkit;

select count(*) from blinkit;

update blinkit
set Item_Fat_Content =
    case
        when Item_Fat_Content in ('LF', 'low fat') then 'Low Fat'
        when Item_Fat_Content = 'reg' then 'Regular'
        else Item_Fat_Content
    end;

select * from blinkit;

select distinct Item_Fat_Content from blinkit;

-- KPI's
-- 1)Total Sales

select round(sum(Total_Sales) / 1000000.0,2) as Total_Sales_Million
from blinkit;

-- 2)Average Sales

select round(avg(Total_Sales),1) as Avg_Sales
from blinkit;

-- 3)Number of Items

select count(*) as No_of_Orders
from blinkit;

-- 4)Avg Rating

select round(avg(Rating),2) as Avg_Rating
from blinkit;

--Total Sales By Fat Content

select Item_Fat_Content,
       round(sum(Total_Sales), 2) as Total_Sales
from blinkit
group by Item_Fat_Content;

--Total Sales By Item Type

select Item_Type,
       round(sum(Total_Sales), 2) as Total_Sales
from blinkit
group by Item_Type
order by Total_Sales desc;

--Fat Content By Outlet For Total Sales

select outlet_location_type,item_fat_content,sum(total_sales) as "Total Sales"
from blinkit
group by 1,2
order by 1 ;

--Total Sales By Outlet Establishment

select outlet_establishment_year,round(sum(total_sales),2) as Total_sales
from blinkit
group by 1
order by 1;

--Percentage Of Sales By Outlet Size

select Outlet_Size,
       round(sum(Total_Sales), 2) as "Total Sales",
       round(sum(Total_Sales) * 100.0 / sum(sum(Total_Sales))over(), 2) as "Sales Percentage"
from blinkit
group by 1
order by 2 desc;

--Sales By Outlet Location

select Outlet_Location_Type,
       round(sum(Total_Sales), 2) as "Total Sales"
from blinkit
group by 1
order by 2 desc;

--All Metrics By Outlet Type

select Outlet_Type,
       round(sum(Total_Sales), 2) as "Total Sales",
       round(avg(Total_Sales), 2) as "Avg Sales",
       count(*) as "No Of Items",
       round(avg(Rating), 2) as "Avg Rating",
       round(avg(Item_Visibility), 2) as "Item Visibility"
from blinkit
group by 1
order by 2 desc;












































































































