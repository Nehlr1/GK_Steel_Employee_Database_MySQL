USE employees;

select * from departments;
select * from dept_emp;
select * from dept_manager;
select * from employees;
select * from salaries;
select * from titles;

select * from salaries where from_date = '1990-06-25';

select first_name, last_name, gender from employees where gender = "F";

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
select concat(employees.first_name, " ",employees.last_name) as Full_Name, 
titles.title as Job_Title
from employees
join titles
on employees.emp_no = titles.emp_no
where titles.title = "Technique Leader";

# Find out the each department manager's name
select concat(employees.first_name, " ",employees.last_name) as Manager_Full_Name, 
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
