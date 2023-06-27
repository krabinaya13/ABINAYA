create schema HR_Analyst
use hr_analyst;
desc hr_1;
desc hr_2;
show tables;
select * from hr_1;
select * from hr_2;

/* 1-- Average Attrition Rate for All Department -- */
select a.Department, concat(format(avg(a.attrition_y)*100,2),'%') as Attrition_Rate
from  
( select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr_1 ) as a
group by a.department;

/*  2-- Average Hourly Rate for Male Research Scientist --*/
select JobRole, format(avg(hourlyrate),2) as Average_HourlyRate,Gender
from hr_1
where upper(jobrole)= 'RESEARCH SCIENTIST' and upper(gender)='MALE'
group by jobrole,gender;
select employee_id from hr_2;

/* 3-- AttritionRate VS MonthlyIncomeStats against department-- */
select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_attrition,format(avg(b.monthlyincome),2) as Average_Monthly_Income
from ( select department,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.employee_id = a.employeenumber
group by a.department;

/* 4-- Average Working Years for Each Department -- */
select a.department, format(avg(b.TotalWorkingYears),1) as Average_Working_Year
from hr_1 as a
inner join hr_2 as b on b.employee_id=a.EmployeeNumber
group by a.department;

/* 5-- Job Role VS Work Life Balance -- */
select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr_1 as a
inner join hr_2 as b on b.employee_id = a.Employeenumber
group by a.jobrole;

/* 6-- Attrition Rate Vs Year Since Last Promotion Relation Against Job Role -- */

select a.JobRole,concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
format(avg(b.YearsSinceLastPromotion),2) as Average_YearsSinceLastPromotion
from ( select JobRole,attrition,employeenumber,
case when attrition = 'yes' then 1
else 0
end as attrition_rate from hr_1) as a
inner join hr_2 as b on b.employee_id = a.employeenumber
group by a.JobRole;

#-->exceution
select * from hr_2;
Select * from hr_1;

