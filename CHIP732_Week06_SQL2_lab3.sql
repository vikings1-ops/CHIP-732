-- the following SQL statements are for JOIN / NESTED SQL
-- 
-- 7. list patient id and their encounters
SELECT a.random_pat_id,a.gender,b.random_pat_enc_csn_id
FROM patient a
LEFT JOIN patientEnc b
ON a.random_pat_id=b.random_pat_id

-- 8. list patient id, gender, and their encounters as well as dx codes
-- Use LEFT JOIN or JOIN?
SELECT a.random_pat_id,a.gender,b.random_pat_enc_csn_id,b.code
FROM patient a
JOIN diagnosis b
ON a.random_pat_id=b.random_pat_id

-- 9. find patient and their total number of encounters
-- Use HAVING to filter
-- We may use the patientEnc table without joining the patient table
SELECT 	a.random_pat_id,COUNT(*),COUNT(DISTINCT b.random_pat_enc_csn_id),
		COUNT(DISTINCT age),COUNT(DISTINCT a.gender)
FROM patient a
LEFT JOIN patientEnc b
ON a.random_pat_id=b.random_pat_id
GROUP BY a.random_pat_id
HAVING COUNT(*)<>COUNT(DISTINCT b.random_pat_enc_csn_id)
-- HAVING COUNT(DISTINCT a.gender)>1

-- 10. Nested SQL: FROM
-- patients with gender and completed encounter
SELECT DISTINCT a.random_pat_id, a.gender
FROM patient a
JOIN patientEnc b
ON a.random_pat_id=b.random_pat_id
WHERE b.appt_status='Completed'
;

SELECT DISTINCT a.random_pat_id, a.gender
FROM patient a
JOIN (
	SELECT random_pat_id, random_pat_enc_csn_id 
	FROM patientEnc 
	WHERE appt_status='Completed'
) b
ON a.random_pat_id=b.random_pat_id;
;

-- 11. Nested SQL: WHERE
SELECT random_pat_id, gender
FROM patient
WHERE random_pat_id IN (
	SELECT DISTINCT random_pat_id 
	FROM patientEnc 
	WHERE appt_status='Completed'
);

SELECT DISTINCT a.random_pat_id,a.gender
FROM patient a
LEFT JOIN patientEnc b
ON a.random_pat_id=b.random_pat_id
WHERE b.appt_status='Completed';

-- 12. Nested SQL: SELECT 
-- percentage of gender group
SELECT gender, ROUND(cnt*1.0/tot,4) pct
FROM (
	SELECT gender, count(*) cnt, (SELECT count(*) FROM patient) tot
	FROM patient
	GROUP BY gender
)
;
--
DROP VIEW IF EXISTS patient_cnt;

CREATE VIEW patient_cnt AS
SELECT gender, count(*) cnt, (SELECT count(*) FROM patient) tot
FROM patient
GROUP BY gender
;

SELECT gender, ROUND(cnt*1.0/tot,4) pct
FROM patient_cnt
;

-- 13. Nested SQL: list patient with completed cnconters by gender
SELECT gender,subtotal,
            CAST(ROUND(subtotal*100.0/tot,2) AS varchar)||'%' pct,
			ROUND(subtotal*1.0/tot2,4) pct2
FROM (
	SELECT a.gender,COUNT(*) subtotal, 
	            (SELECT COUNT(*) FROM patientEnc WHERE appt_status='Completed') tot,
				(SELECT COUNT(*) FROM patientEnc) tot2
	FROM patient a
	LEFT JOIN patientEnc b
	ON a.random_pat_id=b.random_pat_id
	WHERE appt_status='Completed'
	GROUP BY a.gender
);

-- 14. create a view
DROP VIEW IF EXISTS patEncSum;

CREATE VIEW patEncSum AS
SELECT a.gender,COUNT(*) subtotal, 
        (SELECT COUNT(*) FROM patientEnc WHERE appt_status='Completed') tot,
		(SELECT COUNT(*) FROM patientEnc) tot2
FROM patient a
LEFT JOIN patientEnc b
ON a.random_pat_id=b.random_pat_id
WHERE appt_status='Completed'
GROUP BY a.gender
;

-- 15. create another view
DROP VIEW IF EXISTS tmp;

CREATE VIEW tmp AS
SELECT random_order_proc_id,result_line_number,component_name
FROM orderResults
WHERE random_order_proc_id='0x00048E1E048DE12C';

