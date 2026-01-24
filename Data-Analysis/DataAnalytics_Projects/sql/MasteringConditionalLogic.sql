
--- METHOD 1) Assign grades based on the score: 90 and over is 'A', 80-89 'B', 70-79 'C', 60-69 'D' and below 60 is 'F'
SELECT 
    student_id,
    subject,
    score,
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score BETWEEN 80 AND 89 THEN 'B'
        WHEN score BETWEEN 70 AND 79 THEN 'C'
        WHEN score BETWEEN 60 AND 69 THEN 'D'
        ELSE 'F'
    END AS grade
FROM studentgrades;

--- METHOD 2 by adding a column to student grades table
--- Add column score_grading
ALTER TABLE studentgrades
ADD COLUMN score_grading TEXT;

--- Adding a column for grades
UPDATE studentgrades
SET score_grading =  CASE
                        WHEN score >= 90 THEN 'A'
                        WHEN score BETWEEN 80 AND 89 THEN 'B'
                        WHEN score BETWEEN 70 AND 79 THEN 'C'
                        WHEN score BETWEEN 60 AND 69 THEN 'D'
                        ELSE 'F'
                     END;
                     
--- Adding a flag for high perormance
ALTER TABLE studentgrades
ADD COLUMN flags TEXT;

UPDATE studentgrades
SET flags            =  CASE
                        WHEN score >= 75 THEN 'High performer'
                        ELSE 'Not a high perormer'
                     END;

 ---- Count number of high performers
SELECT 
    COUNT(*) AS highperformers
FROM studentgrades
WHERE flags = 'High performer';

--- Find average for in Maths for High performers
SELECT AVG(score) AS avg_high_performance
FROM studentgrades
WHERE flags = 'High performer' and subject = 'Math';

--- Select students grading as 'Excellent' > 85 , 'Good' between 70 and 84  and 'Poor' less than 70

SELECT COUNT(*) excellent_count
FROM 
    (SELECT 
    score,
    CASE 
        WHEN score >= 85 THEN 'Excellent'
        WHEN score BETWEEN 70 AND 84 THEN  'Good'
        WHEN score < 70 THEN  'Poor'
    END AS student_standing
    FROM studentgrades) AS subquery
    WHERE student_standing = 'Poor';
    
        
    

select * from studentgrades;
