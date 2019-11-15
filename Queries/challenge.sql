--creating data table of current employees born in 1965 with titles and salaries
SELECT ce.emp_no, ce.first_name, ce.last_name, t.title, t.from_date, s.salary
INTO retirees_titles
FROM salaries AS s
RIGHT JOIN titles as t
ON (s.emp_no = t.emp_no)
RIGHT JOIN current_emp AS ce
ON (ce.emp_no = s.emp_no)
ORDER BY emp_no;

SELECT * FROM retirees_titles;

--retirees list no duplicates
SELECT emp_no, first_name, last_name, title, from_date, salary
INTO retirees_titles_unique
FROM (SELECT emp_no, first_name, last_name, title,
	from_date, salary, ROW_NUMBER() OVER (PARTITION BY (emp_no) ORDER BY from_date DESC) rn
	 FROM retirees_titles) AS rt
	 WHERE rn = 1;
	 
--or alternatively
SELECT emp_no, first_name, last_name, title, from_date, salary
--INTO retirees_titles_unique
FROM (SELECT emp_no, first_name, last_name, title,
	from_date, salary, ROW_NUMBER() OVER (PARTITION BY (first_name, last_name) ORDER BY from_date DESC) rn
	 FROM retirees_titles) AS rt
	 WHERE rn = 1;
	 
SELECT * FROM retirees_titles_unique;

--counting number of current employees eligible for retirement
SELECT COUNT(current_emp)
FROM current_emp;

--creating mentors list
SELECT e.emp_no, e.first_name, e.last_name, t.title, de.from_date, de.to_date
INTO mentors_list
FROM employees as e
RIGHT JOIN titles as t
ON (e.emp_no = t.emp_no)
RIGHT JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

--creating unique mentors list
SELECT emp_no, first_name, last_name, title, from_date, to_date
INTO mentors_list_unique
FROM (SELECT emp_no, first_name, last_name, title,
	from_date, to_date, ROW_NUMBER() OVER (PARTITION BY (emp_no) ORDER BY from_date DESC) AS rn
	 FROM mentors_list) AS ml
	 WHERE rn = 1;
SELECT * FROM mentors_list;