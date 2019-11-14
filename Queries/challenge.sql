SELECT ce.emp_no, ce.first_name, ce.last_name,
	t.title, s.from_date, s.salary
INTO retiring_pos_salary
FROM current_emp as ce
LEFT JOIN titles as t
ON (ce.emp_no = t.emp_no)
LEFT JOIN salaries as s
ON (ce.emp_no = s.emp_no);

SELECT * FROM retiring_pos_salary;

SELECT emp_no, first_name, last_name, title, from_date, salary
INTO retiring_no_dup
FROM (SELECT emp_no, first_name, last_name, title,
	from_date, salary, ROW_NUMBER() OVER (PARTITION BY (emp_no)) rn
	 FROM retiring_pos_salary)
	 tmp WHERE rn = 1;

     Create a new table that contains the following information:
Employee number
First and last name
Title
from_date and to_date
Note: The hire date needs to be between January 1, 1965 and December 31, 1965. Also, make sure only current employees are included in this list.