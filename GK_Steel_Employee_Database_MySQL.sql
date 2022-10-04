USE employees;

select * from departments;
select count(*) from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;


# Find out full names of the employees in sales department 
select concat(employees.first_name, " ",employees.last_name) as Full_Name, 
departments.dept_name as Department_Name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no 
where departments.dept_name = "Sales";

# Find out employees' names who work as a Technique Leader
select concat(employees.first_name, " ", employees.last_name) as Full_Name, 
titles.title as Job_Title
from employees
join titles
on employees.emp_no = titles.emp_no
where titles.title = "Technique Leader";

# Find out full names of the employees in research department who are males
select concat(employees.first_name, " ",employees.last_name) as Full_Name, 
departments.dept_name as Department_Name,
employees.gender as Gender
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no 
where departments.dept_name = "Research" and employees.gender = "M";

# Find out the each department manager's name
select concat(employees.first_name, " ", employees.last_name) as Manager_Full_Name, 
departments.dept_name as Department_Name
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
join dept_manager
on employees.emp_no = dept_manager.emp_no
order by Manager_Full_Name;

# Find out all the salaries given to Human Resources department manager Karsten each year
select concat(employees.first_name, " ",employees.last_name) as Manager_Full_Name, 
departments.dept_name as Department_Name, 
(salaries.salary) as Salary,
year(salaries.from_date) as Year
from employees
join dept_emp
on employees.emp_no = dept_emp.emp_no
join departments
on dept_emp.dept_no = departments.dept_no
join dept_manager
on employees.emp_no = dept_manager.emp_no
join salaries
on employees.emp_no = salaries.emp_no
where employees.first_name = "Karsten"
group by salaries.salary
order by Manager_Full_Name;

# Find out the mean, max, and min salary from 2001 to 2002 by gender
SELECT e.gender, avg(salary) as Mean, max(salary) as Maximum, min(salary) as Minimum
FROM salaries s
join employees e
on s.emp_no = e.emp_no
where from_date between '2001-01-01' and '2001-12-31' and to_date between
'2002-01-01' and '2002-12-31'
group by e.gender;

# Find out top 10 employees by salary from 2001 to 2002
SELECT e.emp_no, e.first_name, e.last_name, sum(s.salary) as salary 
FROM employees.salaries s 
inner join employees.employees e 
on s.emp_no = e.emp_no 
where from_date between '2001-01-01' and '2001-12-31' and to_date between '2002-01-01' and '2002-12-31' 
group by e.emp_no 
order by salary desc 
limit 10;

# Find out the gender ratio of managers
select t.*
, concat(t.male / t.total * 100, '%') as `proportion of male`
, concat(t.female / t.total * 100, '%') as `proportion of female`
from (
SELECT sum(case when gender = 'M' then 1 else 0 end) as male,
sum(case when gender = 'F' then 1 else 0 end) as female,
count(*) as total FROM employees.employees e
inner join (select * from dept_manager where to_date = '9999-01-01') m on e.emp_no =
m.emp_no) t;
