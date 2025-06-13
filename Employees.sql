
# Employees Data Project

use employees;
 
select * from employees;   

#--> 1. Retrieve all employee details.

select * from employees;


#--> 2. Select only first_name and last_name of all employees.

select first_name, last_name from employees;


#--> 3. Find employees hired after January 1, 1990.

select * from employees
where hire_date > "1990-01-01"
order by hire_date;


#--> 4. Retrieve all male employees.

select * from employees
where gender = "m";


#--> 5. Find all employees whose first name starts with 'A'.

select * from employees
where first_name like "A%";


#--> 6. Count the total number of employees.

select count(emp_no) as total_emp from employees;


#--> 7. Find the oldest employee (minimum birth date).

select first_name,last_name,birth_date from employees
where birth_date = (select min(birth_date) from employees);


#--> 8. Find the number of employees hired per year.

select year(hire_date) as hire_year, count(emp_no) as employees_hired  
from employees  
group by year(hire_date);


#--> 9. Find the total number of male and female employees.

select gender, count(emp_no) from employees
group by gender;


#--> 10. Get the average age of all employees.

select avg(timestampdiff(year, birth_date, curdate())) as avg_age from employees;


#--> 11. List employees in descending order of hire_date.

select * from employees
order by hire_date desc;


#--> 12. Show the top 5 youngest employees.

select * from employees
where birth_date = (select max(birth_date) from employees)
order by birth_date desc
limit 5;


#--> 13. Find employees whose last name contains 'son'.

select * from employees
where last_name like "%son";


#--> 14. Find employees born between 1950-01-01 and 1960-12-31.

select * from employees
where birth_date between '1950-01-01' and '1960-12-31'
order by birth_date;


#--> 15. List employees hired in the last 5 years.

select * from employees
where hire_date >= curdate() - interval 5 year;


#--> 16. Find duplicate first names in the company.

select first_name, count(*) as count_name from employees
group by first_name
having count(*) > 1 ;


#--> 17. Retrieve employees whose first and last names are the same.

select * from employees
where first_name = last_name;


#--> 18. Find employees whose birth date is on February 29 (leap year birthdays).

select * from employees
where month(birth_date) = 02 and day(birth_date) = 29;


#--> 19. Get the most common last name in the company.

select last_name, count(*) as name_count from employees
group by last_name 
order by name_count desc
limit 1;


#--> 20. Find employees who were hired on their birthday.

select * from employees
where hire_date = birth_date;


select * from employees;           #emp_no,birth_date,first_name,last_name,gender,hire_date
select * from dept_emp;			   #emp_no,dept_no,from_date,to_date	
select * from departments;		   #dept_no,dept_name
select * from dept_manager;		   #emp_no,dept_no,from_date,to_date
select * from salaries;			   #emp_no,salary,from_date,to_date
select * from titles;			   #emp_no,title,from_date,to_date


#--> 21. Get employee details with their department name

select e.emp_no,e.first_name,e.last_name,d.dept_name from employees as e
inner join dept_emp as de on e.emp_no = de.emp_no
inner join departments as d on de.dept_no = d.dept_no;


#--> 22. Find employees who are managers

select e.emp_no,e.first_name,e.last_name,d.dept_name,dm.from_date,dm.to_date from employees as e
inner join dept_manager as dm on e.emp_no = dm.emp_no
inner join departments as d on dm.dept_no = d.dept_no;


#--> 23. List all employees with their job titles

select e.emp_no,e.first_name,e.last_name,t.title,t.from_date,t.to_date from employees as e
inner join titles as t on e.emp_no = t.emp_no;


#--> 24. Find salary details of each employee

select e.emp_no,e.first_name,e.last_name,s.salary,s.from_date,s.to_date from employees as e
inner join salaries as s on e.emp_no = s.emp_no;


#--> 25. Find the current department of each employee Only show employees whose to_date is '9999-01-01' in dept_emp.

select e.emp_no,e.first_name,e.last_name,d.dept_name,de.from_date,de.to_date
from employees as e
inner join dept_emp as de on e.emp_no = de.emp_no
inner join departments as d on de.dept_no = d.dept_no
where de.to_date = "9999-01-01";


#--> 26. Get the highest-paid employees along with their department

select e.emp_no, e.first_name, e.last_name, s.salary, d.dept_name 
from employees as e 
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
join salaries as s on e.emp_no = s.emp_no
order by s.salary desc;


#--> 27. Find the total number of employees in each department

select count(emp_no) as total_emp, d.dept_name from dept_emp as de
join departments as d on de.dept_no = d.dept_no
group by dept_name;


#--> 28. List all employees who have changed departments at least once

select e.emp_no, e.first_name, e.last_name from employees as e 
join (select emp_no from dept_emp 
      group by emp_no
      having count(distinct dept_no > 1) 
      ) as changed_dept
on e.emp_no = changed_dept.emp_no;


#--> 29. Get the top 5 highest-paid employees with their job titles and department

select e.emp_no, e.first_name, e.last_name, s.salary, t.title, d.dept_name 
from employees as e 
join dept_emp as de on e.emp_no = de.emp_no
join departments as d on de.dept_no = d.dept_no
join salaries as s on e.emp_no = s.emp_no
join titles as t on e.emp_no = t.emp_no
order by s.salary desc
limit 5;


#--> 30. Find the average salary for each department

select d.dept_name, avg(s.salary) as avg_salary from departments as d
join dept_emp as de on de.dept_no = d.dept_no
join employees as e on e.emp_no = de.emp_no
join salaries as s on e.emp_no = s.emp_no
group by d.dept_name;


#--> 31. Find employees who are both managers and employees in the same department.

select e.emp_no, e.first_name, e.last_name, de.dept_no from employees as e
inner join dept_emp as de on e.emp_no = de.emp_no
inner join dept_manager as dm on de.emp_no = dm.emp_no and de.dept_no = dm.dept_no;


#--> 32. Find employees who have worked in multiple departments

select e.emp_no, e.first_name, e.last_name from employees e
join (select emp_no from dept_emp 
      group by emp_no
      having count(distinct dept_no) > 1
      ) as multi_dept
on e.emp_no = multi_dept.emp_no;


#--> 33. Get the most recent title of each employee

select e.emp_no, e.first_name, e.last_name, t.title from employees e
inner join titles as t on e.emp_no = t.emp_no
where (t.emp_no, t.from_date) 
in (select emp_no, max(from_date) from titles 
	group by emp_no
    );


#--> 34. Find the gender distribution in each department

select d.dept_name, e.gender, count(e.emp_no) as total_emp from employees e 
inner join dept_emp as de on e.emp_no = de.emp_no
inner join departments as d on d.dept_no = de.dept_no
group by d.dept_name, e.gender;


#--> 35. Find employees who have been with the company the longest

select * from employees
order by hire_date 
limit 1;


