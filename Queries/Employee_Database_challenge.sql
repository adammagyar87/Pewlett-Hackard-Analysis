-- Deliverable 1 start

-- Create Retirement Titles table filtered by birthdate
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
-- INTO retirement_titles
FROM employees as e
LEFT JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no DESC;

-- Create Unique Titles table
-- use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
--INTO unique_titles
FROM retirement_titles AS rt
ORDER BY emp_no, to_date DESC;

-- Retreive the number of employees by most recent job title
-- who are about to retire
SELECT COUNT(ut.title), ut.title
--INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count DESC;

-- Deliverable 1 end

-- Deliverable 2 start

-- Create Mentorship Eligibility table
SELECT DISTINCT ON (emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ut.title
-- INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN titles AS ut
ON e.emp_no = ut.emp_no
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no;

-- Deliverable 2 end