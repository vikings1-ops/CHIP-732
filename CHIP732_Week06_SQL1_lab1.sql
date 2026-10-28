-- List all patients and ordered the records by id
SELECT *
FROM PATIENT
ORDER BY RANDOM_PAT_ID DESC
;

-- List all female patients and ordered the records by id
SELECT *
FROM PATIENT
WHERE gender='Female'
ORDER BY RANDOM_PAT_ID DESC
;

-- List the id and race of all patients and ordered the records by id
SELECT RANDOM_PAT_ID,patient_race
FROM PATIENT
WHERE gender='Female'
ORDER BY RANDOM_PAT_ID DESC
;

-- Why adding WHERE 1=1
SELECT RANDOM_PAT_ID,patient_race
FROM PATIENT
WHERE 1=1
AND gender='Female'
ORDER BY RANDOM_PAT_ID DESC
;

-- unique patient race values
SELECT DISTINCT patient_race
FROM PATIENT
ORDER BY patient_race DESC
;

-- patient race distribution
-- unique patient race values
SELECT  patient_race,COUNT(*)
FROM PATIENT
GROUP BY patient_race
ORDER BY COUNT(*) DESC
;

SELECT patient_race, COUNT(RANDOM_PAT_ID) AS CNT
FROM patient
GROUP BY patient_race
ORDER BY cnt DESC
;

--
SELECT gender,COUNT(*)
FROM patient
WHERE 1=1
GROUP BY gender

-- patient race + gender distribution
SELECT  gender,patient_race,COUNT(*)
FROM PATIENT
GROUP BY gender,patient_race
ORDER BY gender DESC,COUNT(*) DESC
;

-- distinct race in each gender group 
SELECT gender,COUNT(DISTINCT patient_race),COUNT(patient_race),COUNT(*)
FROM PATIENT
GROUP BY gender
ORDER BY gender DESC
;

-- all records in the patient enconter table
SELECT *
FROM PatientEnc
ORDER BY RANDOM_PAT_ID,RANDOM_PAT_ENC_CSN_ID
;

-- # of patient encounters by location and department name
SELECT primary_loc,department_name,COUNT(*),COUNT(DISTINCT random_pat_enc_csn_id),COUNT(DISTINCT random_pat_id)
FROM PatientEnc
GROUP BY primary_loc,department_name
ORDER BY primary_loc DESC,count(*) DESC
;

-- deal with primary_loc is an empty string
SELECT CASE WHEN primary_loc='' THEN 'UNKNOWN' ELSE primary_loc END AS loc, 
            department_name,COUNT(*),COUNT(DISTINCT random_pat_enc_csn_id)
FROM PatientEnc
GROUP BY loc,department_name
ORDER BY loc,count(*) DESC
;

-- count by patient id and encounter id
SELECT RANDOM_PAT_ID,RANDOM_PAT_ENC_CSN_ID,count(*)
FROM alldiagnosis
GROUP BY RANDOM_PAT_ID,RANDOM_PAT_ENC_CSN_ID
;

-- patient id 
SELECT RANDOM_PAT_ID,count(*)
FROM patient
GROUP BY RANDOM_PAT_ID
HAVING count(*)>1
ORDER BY count(*) DESC
;

-- identify primary key
SELECT RANDOM_PAT_ID,RANDOM_PAT_ENC_CSN_ID,code,count(*)
FROM alldiagnosis
GROUP BY RANDOM_PAT_ID,RANDOM_PAT_ENC_CSN_ID,code
HAVING count(*)>1
ORDER BY count(*) DESC
;