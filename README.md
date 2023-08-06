# Text-Mining-of-Electronic-Health-Records
 Stata codes of diabetes and relevant complications

Diabetes Mellitus Diagnosis and Screening in Australian General Practice: A National Study
https://www.hindawi.com/journals/jdr/2022/1566408/

Abstract
Aims. To investigate the epidemiology of diabetes diagnosis and screening in Australian general practice. Methods. Cross-sectional study using electronic health records of 1,522,622 patients aged 18+ years attending 544 Australian general practices (MedicineInsight database). The prevalence of diagnosed diabetes and diabetes screening was explored using all recorded diagnoses, laboratory results, and prescriptions between 2016 and 2018. Their relationship with patient sociodemographic and clinical characteristics was also investigated. Results. Overall, 7.5% (95% CI 7.3, 7.8) of adults had diabetes diagnosis, 0.7% (95% CI 0.6, 0.7) prediabetes, and 0.3% (95% CI 0.3, 0.3) unrecorded diabetes/prediabetes (elevated glucose levels without a recorded diagnosis). Patients with unrecorded diabetes/prediabetes had clinical characteristics similar to those with recorded diabetes, except for a lower prevalence of overweight/obesity (55.5% and 69.9%, respectively). Dyslipidaemia was 1.8 times higher (36.2% vs. 19.7%), and hypertension was 15% more likely (38.6% vs. 33.8%) among patients with prediabetes than with diabetes. Diabetes screening (last three years) among people at high risk of diabetes was 55.2% (95% CI 52.7, 57.7), with lower rates among young or elderly males. Conclusions. Unrecorded diabetes/prediabetes is infrequent in Australian general practice, but prediabetes diagnosis was also lower than expected. Diabetes screening among high-risk individuals can be improved, especially in men, to enhance earlier diabetes diagnosis and management.


/*
1. PREPARE DATASETS FOR FURTHER ANALYSIS****
2. IDENTIFY PATIENTS WITH DIABETES, GDM, PREDIABETES, PCOS****FROM DIAGNOSIS, REASON FOR ENCOUNTER AND REASON FOR PRESCRIPTION DATASETS 
3. IDENTIFY PATIENTS WERE PRESCRIBED ANTI-DIABETIC MEDICATIONS (ADM) VIA SCRIPT_ITEM DATASET****
4. IDENTIFY PATIENTS WITH AN ELEVATED BG READING FOR DIABETES OR PREDIABETES VIA PATHOLOGY DATASET****
5. MERGE FIVE DATASETS, CREATE A DATASET TO IDENTIFY TARGETED DIABETES PATIENTS***
save "diabetes_full_patients_2016_2018.dta", replace
6. MERGE WITH COMOBIDITIES DO FILE**
save "diabetes_full_patients_mergecomo_2016_2018.dta", replace
7. FIND HIGH RISK GROUP***
save "diabetes_full_patients_mergecomo_audrisk_2016_2018.dta", replace  
8. ANALYSES FOR PAPER1***
cd"Y:/MINGYUE"
use "diabetes_full_patients_mergecomo_audrisk_2016_2018.dta", clear  

***Note***
*1. THIS PROJECT USED THE CLEAN DATASETS PROVIDED BY DGP, THE PROCESS OF PREPARE DATASETS ONLY DELETED OBSERVATIONS FOR ADMINISTRATIVE REASONS 
*2. THIS PROJECT USED 'REGULAR' PATIENTS DEFINED AS HAVING AT LEAST 3 CONSULTATIONS IN 2 CONSECUTIVE YEARS AND AT LEAST 1 CONSULTATION IN EACH YEAR, USING COMMON DATASET ALREADY CREATED BY DGP
*/

