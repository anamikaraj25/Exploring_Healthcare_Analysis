
use healthcare;
select * from healthcare;

-- 1.  Counting Total Record in Database

select count(*) from healthcare;

-- 2.Finding maximum age of patient admitted.

select max(age) as Maximum_Age from Healthcare;


-- 3. Calculating Maximum Count of patients on basis of total patients hospitalized with respect to age.

select Age, count(Age) as Total From healthcare
group by Age
order by Total Desc , Age Desc;

-- 4. Most preffered Insurance Provide  by Patients Hospatilized.

SELECT "Insurance_Provider", COUNT("Insurance_Provider") AS Patient_count 
from healthcare
group by "Insurance_Provider"
order by Patient_count Desc;


-- 5. Finding out most preffered Hospital 

select "Hostpital", count("Hospital") As Total from healthcare
group by "Hostpital"
order by Total Desc;


-- 6. Ranking Age on the number of patients Hospitalized 

SELECT AGE, COUNT(AGE) As Total, 
dense_RANK() OVER(ORDER BY COUNT(AGE) DESC, age DESC) as Ranking_Admitted 
from Healthcare
group by age
HAVING Total > Avg(age);



SELECT age, COUNT(*) AS Total, RANK() 
OVER (ORDER BY COUNT(*) DESC) AS Ranking_Admitted
FROM healthcare
WHERE healthcare = true
GROUP BY age
HAVING Total > Avg(age);

--- 7.Finding Rank, Maximum number of medicines recommended to patients based on Medical Condition pertaining to them.    

SELECT "Medical_Condition", Medication, 
COUNT(medication) as Total_Medications_to_Patients, 
RANK() OVER(PARTITION BY "Medical_Condition" ORDER BY COUNT(medication) DESC) as Rank_Medicine
FROM Healthcare
GROUP BY 1,2
ORDER BY 1; 

-- 8. Calculate number of blood types of patients which lies betwwen age 20 to 45

SELECT Age,  'Blood_type', COUNT(distinct'Blood_Type') as Count_Blood_Type
FROM healthcare
WHERE AGE BETWEEN 20 AND 45
GROUP BY 1,2
ORDER BY 'Blood_Type' DESC;

-- 9. Find how many of patient are Universal Blood Donor and Universal Blood reciever.

SELECT DISTINCT (SELECT Count('Blood_Type') FROM healthcare 
WHERE 'Blood_Type' IN ('O-')) AS Universal_Blood_Donor, 
(SELECT Count('Blood_Type') FROM healthcare 
WHERE 'Blood_Type'  IN ('AB+')) as Universal_Blood_reciever
FROM healthcare;

-- 10. Finding Billing Amount of patients admitted and number of days spent in respective hospital.
	
SELECT 'Medical_Condition', Name, Hospital,
DATEDIFF('Discharge_date','Date_of_Admission') as Number_of_Days, 
SUM(ROUND('Billing_Amoun',2)) OVER(Partition by Hospital ORDER BY Hospital DESC) AS Total_Amount
FROM healthcare
ORDER BY 'Medical_Condition'Desc;
 



