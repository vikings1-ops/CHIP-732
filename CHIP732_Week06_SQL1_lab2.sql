-- 0.1 RECAP: differnce between counts
SELECT random_pat_id,COUNT(*),COUNT(),COUNT(random_pat_enc_csn_id) 
FROM patientEnc 
GROUP BY random_pat_id
ORDER BY COUNT(*) DESC
;

-- 0.2 list all encounter type for a particular patient
SELECT random_pat_id,GROUP_CONCAT(disp_enc_type)
FROM patientEnc
WHERE random_pat_id='0x01C4ADB0E7AF'
GROUP BY random_pat_id
;

-- 0.3 list all male patients
SELECT *
FROM patient
WHERE gender='Male'
;

-- 0.4 list patient counts by race
-- order by count, only get counts > 5
SELECT patient_race,COUNT(*)
FROM patient
GROUP BY patient_race
HAVING COUNT(*)>5
ORDER BY COUNT(*) DESC
;

-- 1. number of diagnostic codes in each encouner ID
SELECT random_pat_enc_csn_id,COUNT(*),COUNT(distinct code)
FROM allDiagnosis
GROUP BY random_pat_enc_csn_id
ORDER BY count(*) DESC
;

-- 2. add patient ID and generate a list of diagnostic codes
-- filter patients and list only those with 5 codes
SELECT random_pat_id,random_pat_enc_csn_id,
       COUNT(*),COUNT(distinct code),
       GROUP_CONCAT(code)
FROM allDiagnosis
GROUP BY random_pat_id,random_pat_enc_csn_id
HAVING count(distinct code)=5 
ORDER BY count(*) DESC
;

-- 3. list the number of chief complaints in each encounter and the number of distinct reasons
-- order by the reasons in a decending way
SELECT random_pat_enc_csn_id,COUNT(*),COUNT(distinct enc_reason_name)
FROM chiefComplaint
GROUP BY random_pat_enc_csn_id
ORDER BY count(*) DESC
;

-- 4. exclude a specific encounter 0x6F7CB098E6C2A35D in chief complaints and encounters with all different reasons
SELECT random_pat_enc_csn_id csn_id,COUNT(*),COUNT(distinct enc_reason_name)
FROM chiefComplaint
WHERE csn_id<>'0x6F7CB098E6C2A35D'
GROUP BY random_pat_enc_csn_id
HAVING COUNT(*) <> COUNT(distinct enc_reason_name)
ORDER BY COUNT(*) DESC
;

-- 5. same as above but rename the columns (cnt_all, cnt_uniq)
SELECT random_pat_enc_csn_id csn_id,COUNT(*) AS cnt_all,COUNT(distinct enc_reason_name) cnt_uniq
FROM chiefComplaint
WHERE csn_id<>'0x6F7CB098E6C2A35D'
GROUP BY random_pat_enc_csn_id
HAVING cnt_all <> cnt_uniq
ORDER BY cnt_all DESC
;

-- 6. list all ECHO procedures in orderProc table, the number of patients and min/max/average age per procedure 
SELECT proc_id,proc_name,
       count(distinct random_pat_id),
       round(avg(age),2),
       min(age),max(age)
FROM orderProc
WHERE proc_name LIKE 'ECHO%'
GROUP BY proc_id,proc_name
ORDER BY proc_id,proc_name
;

