SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as ce
INNER JOIN titles AS t
        ON (ce.emp_no = t.emp_no)
WHERE (ce.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) 
	rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY emp_no, to_date DESC;

--Get the number of employees by their most recent job title who are about to retire
SELECT COUNT(title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;

--Employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (ce.emp_no)
	ce.emp_no,
	ce.first_name,
	ce.last_name,
	ce.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (ce.emp_no = t.emp_no)
WHERE (ce.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;