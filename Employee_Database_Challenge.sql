-------------------------------------------------------------
--Deliverable 1: The Number of Retiring Employees By Title

--Steps 1-7. Retrieve info into new table and export into CSV
SELECT 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

SELECT * FROM retirement_titles;

--Steps 8-14 Refeactor data by employee number to take out name duplication and export CSV.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
	rt.first_name,
	rt.last_name,
	rt.title
INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

SELECT * FROM unique_titles

--Steps 15-20. Retrieve the number of employees, by most recent job title (previously refatored data), who are about to retire.
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT (ut.emp_no) DESC;

SELECT * From retiring_titles

------------------------------------------------------------------------------------

--Deliverable 2. Discover what employees are eligible for the mentorship program. 
--Steps 1-11. Multi-step Query and CSV Export
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees as e
    INNER JOIN dept_emp as de
    ON (e.emp_no = de.emp_no)
    INNER JOIN titles as t
    ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no;

SELECT * FROM mentorship_eligibility
