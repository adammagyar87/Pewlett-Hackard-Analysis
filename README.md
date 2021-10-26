# Pewlett Hackard Analysis

## Overview of the analysis:
Facing a wave of pending retirements, management wanted a list of the positions that will likely need to be taken over by other employees or new hires. A few managers requested lists specific to their departments. A mentorship program was also discussed and a list of candidates was requested for this program. The data was in excel files, and it was decided that a SQL database would be the best tool to manage the employee data and generate the lists we need. 

## Results:
- We first decided to compile a list of current employees born from 1952 to 1955 which are the most likely to retire in the short term. Our initial list of employees had repeat data that included previous job titles held by these employees. We then filtered the data to only include each employees most recent role. These results are stored in the "unique_titles.csv" file. There are over 90,000 results. 
 - Since the previous file is so large, we wanted to group by each job title to understand what positions would be filled. A table was generated and name "retiring_titles" and the results can be seen below:
 
 ![image](https://user-images.githubusercontent.com/87042597/138809485-462e73f8-7f9a-47de-9f4d-9c3e928cb595.png)

- The next step was to generate a list of employees for a mentorship program. This was done by finding current employees born in 1965. The table is titled "mentorship_eligibility" and the queury is shown below:

```
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
```
- The mentorship list has 1549 employees. A pivot table was generated in Excel from the "mentorship_eligibility" file and a breakdown of the titles can be seen below. Note that there is a very large discrepency in the mentorship program numbers vs the number of potential retirees/job openings:

![image](https://user-images.githubusercontent.com/87042597/138810368-d17c8e7c-7a67-42c8-83c6-71026ff1aca4.png)
 

## Summary:
This is definitely a problem the company needs to get ahead of. There is a large amount of potentially retiring employees and the jobs will need to be filled with either promotions or new hires. The original list of retirees listed above failed to filter out employees who left the company. The original value of over 90,000 should be filtered by looking for "to.date" that is equal to '9999-01-01' as that is how current employees are denoted. This can be achieved by adding:
```
AND ti.to_date = '9999-01-01'
```
to the query which generated the 'retirement_titles' table for deliverable 1. From there, we can generate a new 'retiring_titles' table with current information. The comparison is seen below:

![image](https://user-images.githubusercontent.com/87042597/138812753-8ba274a8-9cee-4d50-b220-348a6d9b5915.png)

We decreased from 90k to 72k, although these are still staggering numbers. From this, we can generate a ratio of potential mentors for each position. This is seen below:

![image](https://user-images.githubusercontent.com/87042597/138812887-98e3baa9-9d7d-4d6d-88e9-ec6e77f11eee.png)

The best route may be to expand the criteria for mentorships to get a larger number of qualified candidates.
