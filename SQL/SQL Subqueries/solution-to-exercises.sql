#######################################################################
#######################################################################
-- Guided Project: Mastering SQL Subqueries - Solution to all Exercises
#######################################################################
#######################################################################

-- Exercise 2.1: Write a JOIN statement to get the result of 2.3
SELECT e.emp_no, e.first_name, e.last_name
FROM employees e
JOIN dept_manager dm
ON e.emp_no = dm.emp_no;
    
-- Exercise 2.2: Retrieve a list of all managers that were 
-- employed between 1st January, 1990 and 1st January, 1995
SELECT * FROM dept_manager
WHERE emp_no IN (SELECT emp_no FROM employees 
				 WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');

-- Exercise 3.1: Retrieve a list of managers, their first, last, and their department names

-- Returns data from the employees table
SELECT * FROM employees;

-- Solution to 3.1
SELECT dm.*,  e.first_name, e.last_name, d.dept_name
FROM dept_manager dm, employees e, (SELECT dept_no, dept_name FROM departments) d
WHERE dm.dept_no = d.dept_no AND e.emp_no = dm.emp_no;

-- Exercise 4.1: Retrieve a list of customer_id, product_id, order_line and the name of the customer

-- Returns data from the sales and customers tables
SELECT * FROM sales
ORDER BY customer_id;

SELECT * FROM customers;

-- Solution
SELECT customer_id, product_id, order_line, (SELECT customer_name FROM customers c 
											 WHERE s.customer_id = c.customer_id)
FROM sales s
ORDER BY customer_id;

-- Exercise 5.1: Return a list of all employees who are in Customer Service department

-- Returns data from the dept_emp and departments tables
SELECT * FROM dept_emp;
SELECT * FROM departments;

-- Solution
SELECT * FROM dept_emp
WHERE dept_no IN (SELECT dept_no FROM departments 
				  WHERE dept_name = 'Customer Service');

-- Exercise 5.2: Include the employee number, first and last names
SELECT a.emp_no, b.dept_no, a.first_name, a.last_name
FROM employees a
JOIN (SELECT * FROM dept_emp
	  WHERE dept_no IN (SELECT dept_no FROM departments 
						WHERE dept_name = 'Customer Service')) b
ON a.emp_no = b.emp_no
ORDER BY emp_no;

-- Exercise 5.3: Retrieve a list of all managers who became managers after 
-- the 1st of January, 1985 and are in the Finance or HR department

-- Returns data from the departments and dept_manager tables
SELECT * FROM departments;
SELECT * FROM dept_manager
WHERE from_date > '1985-01-01';

-- Solution
SELECT * FROM dept_manager
WHERE from_date > '1985-01-01'
AND dept_no IN (SELECT dept_no FROM departments 
				WHERE dept_name = 'Finance' OR dept_name = 'Human Resources');

-- Exercise 5.4: Retrieve a list of all employees that earn above 120,000
-- and are in the Finance or HR departments

-- Retrieve a list of all employees that earn above 120,000
SELECT emp_no, salary FROM salaries
WHERE salary > 120000;

-- Solution
SELECT emp_no, salary FROM salaries
WHERE salary > 120000
AND emp_no IN (SELECT emp_no FROM dept_emp
				WHERE dept_no = 'd002' OR dept_no = 'd003');

-- Alternative Solution
SELECT emp_no, salary FROM salaries
WHERE salary > 120000
AND emp_no IN (SELECT emp_no FROM dept_emp
				WHERE dept_no IN ('d002','d003'));

-- Exercise 5.5: Retrieve the average salary of these employees
SELECT emp_no, ROUND(AVG(salary), 2) AS avg_salary
FROM salaries
WHERE salary > 120000
AND emp_no IN (SELECT emp_no FROM dept_emp
				WHERE dept_no = 'd002' OR dept_no = 'd003')
GROUP BY emp_no
ORDER BY avg_salary DESC;

-- Exercise 6.1: Return a list of all employees number, first and last name.
-- Also, return the average salary of all the employees and average salary
-- of each employee

-- Retrieve all the records in the salaries table
SELECT * FROM salaries;

-- Return the employee number, first and last names and average
-- salary of all employees
SELECT e.emp_no, e.first_name, e.last_name, 
(SELECT ROUND(AVG(salary), 2) FROM salaries) avg_salary
FROM employees e
JOIN salaries s
ON e.emp_no = s.emp_no
ORDER BY e.emp_no;

-- Returns the employee number and average salary of each employee
SELECT emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
FROM salaries
GROUP BY emp_no
ORDER BY emp_no;

-- Solution
SELECT e.emp_no, e.first_name, e.last_name, a.emp_avg_salary,
(SELECT ROUND(AVG(salary), 2) avg_salary FROM salaries)
FROM employees e
JOIN (SELECT s.emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
				   FROM salaries s
				   GROUP BY s.emp_no
				   ORDER BY s.emp_no) a
ON e.emp_no = a.emp_no
ORDER BY emp_no;

-- Exercise 6.2: Find the difference between an employee's average salary
-- and the average salary of all employees
SELECT e.emp_no, e.first_name, e.last_name, a.emp_avg_salary,
(SELECT ROUND(AVG(salary), 2) avg_salary FROM salaries), 
a.emp_avg_salary - (SELECT ROUND(AVG(salary), 2) avg_salary FROM salaries) AS salary_diff
FROM employees e
JOIN (SELECT s.emp_no, ROUND(AVG(salary), 2) AS emp_avg_salary
				   FROM salaries s
				   GROUP BY s.emp_no
				   ORDER BY s.emp_no) a
ON e.emp_no = a.emp_no
ORDER BY emp_no;

-- Exercise 6.3: Find the difference between the maximum salary of employees
-- in the Finance or HR department and the maximum salary of all employees

SELECT e.emp_no, e.first_name, e.last_name, a.emp_max_salary,
(SELECT MAX(salary) max_salary FROM salaries), 
(SELECT MAX(salary) max_salary FROM salaries) - a.emp_max_salary salary_diff
FROM employees e
JOIN (SELECT s.emp_no, MAX(salary) AS emp_max_salary
				   FROM salaries s
				   GROUP BY s.emp_no
				   ORDER BY s.emp_no) a
ON e.emp_no = a.emp_no
WHERE e.emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no IN ('d002', 'd003'))
ORDER BY emp_no;

-- Exercise 7.1: Retrieve the salary that occurred the most

-- Returns a list of the count of salaries
SELECT salary, COUNT(*)
FROM salaries
GROUP BY salary;

SELECT salary, COUNT(*)
FROM salaries
GROUP BY salary
ORDER BY COUNT(*) DESC, salary DESC
LIMIT 1;

-- Solution
SELECT a.salary 
FROM (
	SELECT salary, COUNT(*)
	FROM salaries
	GROUP BY salary
	ORDER BY COUNT(*) DESC, salary DESC
	LIMIT 1) a;

-- Exercise 7.2: Find the average salary excluding the highest and
-- the lowest salaries

-- Returns the average salary of all employees
SELECT ROUND(AVG(salary), 2) avg_salary
FROM salaries

-- Solution
SELECT ROUND(AVG(salary), 2) avg_salary
FROM salaries
WHERE salary NOT IN (
	(SELECT MIN(salary) FROM salaries),
	(SELECT MAX(salary) FROM salaries)
);

-- Exercise 7.3: Retrieve a list of customers id, name that has
-- bought the most from the store

-- Returns a list of customer counts
SELECT customer_id, COUNT(*) AS cust_count
FROM sales
GROUP BY customer_id
ORDER BY cust_count DESC;
	 
-- Solution
SELECT c.customer_id, c.customer_name, a.cust_count
FROM customers c,
  	(SELECT customer_id, COUNT(*) AS cust_count
  	 FROM sales
     GROUP BY customer_id
	 ORDER BY cust_count DESC) AS a
  WHERE c.customer_id = a.customer_id
ORDER BY a.cust_count DESC;

-- Exercise 7.4: Retrieve a list of the customer name and segment
-- of those customers that bought the most from the store and
-- had the highest total sales

-- Returns a list of customer counts and total sales
SELECT customer_id, COUNT(*) AS cust_count, SUM(sales) total_sales
FROM sales
GROUP BY customer_id
ORDER BY total_sales DESC, cust_count DESC;

-- Solution
SELECT c.customer_id, c.customer_name, c.segment, a.cust_count, a.total_sales
FROM customers c,
  	(SELECT customer_id, COUNT(*) AS cust_count, SUM(sales) total_sales
  	 FROM sales
     GROUP BY customer_id
	 ORDER BY total_sales DESC, cust_count DESC) AS a
  WHERE c.customer_id = a.customer_id
ORDER BY a.total_sales DESC, a.cust_count DESC;



