use project;

---read entire data

select * from [linkedin ];

---No of jobs by designation 

select top 10 Designation , COUNT(Designation) as 'No of jobs' from [linkedin ]
group by Designation
order by [No of jobs] desc;

---No of jobs by industry name

select top 10 Industry_Name , COUNT(Industry_Name) as 'No of jobs' from [linkedin ]
group by Industry_Name
order by [No of jobs] desc;

---No of jobs by city

select top 10 City , COUNT(City) as 'No of jobs' from [linkedin ]
group by City
order by [No of jobs] desc;

---No of employee by Comapany Name

select top 10 Comapany_Name , avg(No_of_employee) as 'No_of_employee' from [linkedin ]
group by Comapany_Name
order by No_of_employee desc;

---No of followers by company name

select top 10 Comapany_Name , avg(No_of_followers) as 'No_of_followers' from [linkedin ]
group by Comapany_Name
order by No_of_followers desc;

---Job Type Distribution

with cte as(
select Level as 'Job Type' , COUNT(Level) as 'No of jobs'  from [linkedin ]
group by Level
),
cte1 as (
select [Job Type],[No of jobs], sum([No of jobs]) OVER() as 'Total jobs' from cte
group by [Job Type],[No of jobs]
)
select [Job Type],convert(decimal(10,2),(([No of jobs]*100/[Total jobs]))) as 'Percentage Distribution' from cte1
order by [No of jobs] desc;

--- create stored procedures
--- using this we can find out insight from each state

---1

create procedure No_of_jobs_by_Designation_by_state
@state varchar(30)

AS

select top 10 Designation , COUNT(Designation) as 'No of jobs' from [linkedin ]
where State like @state
group by Designation
order by [No of jobs] desc;

execute No_of_jobs_by_Designation_by_state 'Karnataka';

---2

create procedure No_of_jobs_by_industry_name_by_state
@state varchar(30)

AS

select top 10 Industry_Name , COUNT(Industry_Name) as 'No of jobs' from [linkedin ]
where State like @state
group by Industry_Name
order by [No of jobs] desc;

execute No_of_jobs_by_industry_name_by_state 'Karnataka';

---3

create procedure No_of_jobs_by_city_by_state
@state varchar(30)

AS

select top 10 City , COUNT(City) as 'No of jobs' from [linkedin ]
where State like @state
group by City
order by [No of jobs] desc;

execute No_of_jobs_by_city_by_state 'Karnataka';

---4

create procedure No_of_employee_by_Comapany_Name_by_state
@state varchar(30)

AS

select top 10 Comapany_Name , avg(No_of_employee) as 'No_of_employee' from [linkedin ]
where State like @state
group by Comapany_Name
order by No_of_employee desc;

execute No_of_employee_by_Comapany_Name_by_state 'Karnataka';

---5

create procedure No_of_followers_by_Comapany_Name_by_state
@state varchar(30)

AS

select top 10 Comapany_Name , avg(No_of_followers) as 'No_of_followers' from [linkedin ]
where State like @state
group by Comapany_Name
order by No_of_followers desc;

execute No_of_followers_by_Comapany_Name_by_state 'Karnataka';

---6

---Job Type Distribution
create procedure Job_Type_Distribution
@state varchar(30)

AS

with cte as(
select Level as 'Job Type' ,state, COUNT(Level) as 'No of jobs'  from [linkedin ]
group by Level, State
),
cte1 as (
select [Job Type],[No of jobs],state, sum([No of jobs]) OVER() as 'Total jobs' from cte
group by [Job Type],[No of jobs],State
)
select [Job Type],convert(decimal(10,2),(([No of jobs]*100/[Total jobs]))) as 'Percentage Distribution' from cte1
where State like @state
order by [No of jobs] desc;

execute Job_Type_Distribution 'Karnataka';

---7 designation by state,city

create procedure Designation_by_state_and_city
@state varchar(30)

AS
select state , city , Designation from [linkedin ]
where State like @state
order by state ,City

execute Designation_by_state_and_city 'Karnataka';
