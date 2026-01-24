---Exercise 1 View first 5 rows
SELECT * FROM companyemployees
LIMIT 5;

--- Exercise Retrieve employees with first name Robert or Benjamin 
SELECT 
    firstname,
    lastname,
    email
FROM companyemployees
WHERE
    firstname in ('Robert', 'Benjamin');
    
--- Retrieve total number of employees who have worked for at least 5 years
SELECT 
    count(*) AS total_employees_5years_or_more
FROM companyemployees
WHERE yearsworked >= 5;

--- Retrieve employee Grace Hughes
SELECT 
    firstname,
    lastname,
    yearsworked,
    flaggedforlayoff
FROM companyemployees
WHERE
    firstname = ('Grace') and lastname = ('Hughes');
 
-- to find employees who have worked at the company for over 10 years and not been flagged for layoff
SELECT 
    firstname,
    lastname,
    yearsworked,
    flaggedforlayoff
FROM companyemployees
WHERE
    yearsworked > 10 AND flaggedforlayoff = 'No';

--- Retrieve employees taht have been working the longest
   
SELECT 
    firstname,
    lastname,
    email,
    yearsworked
FROM companyemployees
ORDER BY yearsworked DESC
LIMIT 2;

SELECT 
    firstname,
    lastname,
    email,
    yearsworked
FROM companyemployees
WHERE yearsworked = (SELECT MAX(yearsworked) FROM companyemployees);
    
