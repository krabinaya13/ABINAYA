use finance_data;
select * from finance1;
select * from finance_2;

-- Year wise loan amount Stats
SELECT  year as year_of_issue, sum(loan_amnt)
FROM finance1
group by year
order by year;

-- Grade and sub grade wise revol_bal(kpi2)

select grade, sub_grade,sum(revol_bal) as total_revol_bal
from finance_1 inner join Finance_2 
on(finance_1.id = Finance_2.id) 
group by grade,sub_grade
order by grade; 

-- Total Payment for Verified Status Vs Total Payment for Non Verified Status(kpi 3)
select verification_status,round(sum(total_pymnt),2) as total_payment from finance_1 inner join finance_2 
on finance_1.id = finance_2.id where verification_status in ('verified','not verified') group by verification_status;

SELECT @@sql_mode;
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- State wise and last_credit_pull_d wise loan status
 select  finance_1.addr_state,
   count(finance_1.loan_status),
   finance_2.last_credit_pull_d
   from finance_2
    inner join   finance_1 on finance_1.id =finance_2.id
group by finance_1.addr_state, finance_2.last_credit_pull_d -- with rollup
order by   finance_1.addr_state   asc;

-- Homeownership Vs lastpayment date_stats

select finance_1.home_ownership,finance_2.last_pymnt_d ,count(finance_2.last_pymnt_d) from finance_2 inner join finance_1 on 
finance_1.id = finance_2.id group by finance_1.home_ownership,finance_2.last_pymnt_d;
