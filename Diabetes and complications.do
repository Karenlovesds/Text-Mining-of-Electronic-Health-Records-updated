                                                            **********************************************************
                                                            ***DO FILES OF Text-Mining-of-Electronic-Health-Records***
                                                            **********************************************************
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


************************************************
************************************************
****1. PREPARE DATASETS FOR FURTHER ANALYSIS****
************************************************
************************************************
***PREPARE WHOLE DIAGNOSIS, ENCOUNTER_REASON, PRESCRIPTION_REASON DATASETS***USE WHOLE DATASETS HERE.
***SCRIPT_ITEM DATASET, OBSERVATION DATASET, PATHOLOGY RESULT DATASET ARE CLEAN DATASETS PROVIDED BY DGP*** 
***IN THIS PART, WE ONLY NEED TO DELETE OBSERVATIONS FOR ADMINSTRATIVE REASONS TO HAVE CLEAN DEP DATASETS***


*************************
****DIAGNOSIS DATASET**** 
*************************
use "Y:\MINGYUE\three diagnosis datasets original\Diagnosis_2016_2018.dta", clear 
**Delete observations for administrative reasons**
gen exclude=1 if strpos(reason,"NO CONSULT") | strpos(reason,"DID NOT ATTEND") | strpos(reason,"NOT SEEN") | strpos(reason,"CLERK") | ///
strpos(reason,"FAX") | strpos(reason,"EMAIL") | strpos(reason,"PHONE") | strpos(reason,"PH CALL") | strpos(reason,"CALL FROM") | strpos(reason,"CALL TO") | strpos(reason,"LETTER") |  strpos(reason,"INVITE") | ///
strpos(reason," SMS ") | strpos(reason,"MESSAGE") | strpos(reason,"REMINDER") |  strpos(reason,"RECALL") | strpos(reason,"RECEPTIONIST") |  strpos(reason,"CORRESPONDENCE") | ///
strpos(reason,"HOTDOC") | strpos(reason,"APPOINTUIT") | strpos(reason,"APPT")  | strpos(reason,"APPOINTMENT") |  ///
strpos(reason,"PRACTICE MANAGER") | strpos(reason,"FORMS") | strpos(reason,"PATH FORM") | strpos(reason,"PATHOLOGY FORM") | strpos(reason,"REQUEST FORM") | strpos(reason,"CENTRELINK FORM") | ///
strpos(reason,"SCANNED FORM") | strpos(reason,"FORM PRINT") | strpos(reason,"PATH REQ FORM") | strpos(reason,"TEST FORM ") | ///
strpos(reason,"MEDICAL RECORD") | strpos(reason,"PREPARATION") |  strpos(reason,"MEDICAL CERTIFICATE") &  strpos(reason,"LINK")  |  strpos(reason,"TEAM CARE ARRANGEMENT - COORDINATION OF") | ///
strpos(reason,"PAPER WORK") | strpos(reason,"FORM FILL") 

recode exclude 1=0 if strpos(reason,"TELEPHONE CONSULTATION")  //(exclude: 1114 changes made)

drop if exclude==1 //(86,213 observations deleted)
drop exclude

label data "Clean Diagnosis dataset 2016_2018"
save "Y:\MINGYUE\DIAB\emi_diab_diagnosis_clean.dta", replace

********************************
****ENCOUNTER_REASON DATASET****
********************************
use "Y:\MINGYUE\three diagnosis datasets original\Encounter_reason_2016_2018.dta" , clear 
 
**Delete observations for administrative reasons**
gen exclude=1 if strpos(reason,"NO CONSULT") | strpos(reason,"DID NOT ATTEND") | strpos(reason,"NOT SEEN") | strpos(reason,"CLERK") | ///
strpos(reason,"FAX") | strpos(reason,"EMAIL") | strpos(reason,"PHONE") | strpos(reason,"PH CALL") | strpos(reason,"CALL FROM") | strpos(reason,"CALL TO") | strpos(reason,"LETTER") |  strpos(reason,"INVITE") | ///
strpos(reason," SMS ") | strpos(reason,"MESSAGE") | strpos(reason,"REMINDER") |  strpos(reason,"RECALL") | strpos(reason,"RECEPTIONIST") |  strpos(reason,"CORRESPONDENCE") | ///
strpos(reason,"HOTDOC") | strpos(reason,"APPOINTUIT") | strpos(reason,"APPT")  | strpos(reason,"APPOINTMENT") |  ///
strpos(reason,"PRACTICE MANAGER") | strpos(reason,"FORMS") | strpos(reason,"PATH FORM") | strpos(reason,"PATHOLOGY FORM") | strpos(reason,"REQUEST FORM") | strpos(reason,"CENTRELINK FORM") | ///
strpos(reason,"SCANNED FORM") | strpos(reason,"FORM PRINT") | strpos(reason,"PATH REQ FORM") | strpos(reason,"TEST FORM ") | ///
strpos(reason,"MEDICAL RECORD") | strpos(reason,"PREPARATION") |  strpos(reason,"MEDICAL CERTIFICATE") &  strpos(reason,"LINK")  |  strpos(reason,"TEAM CARE ARRANGEMENT - COORDINATION OF") | ///
strpos(reason,"PAPER WORK") | strpos(reason,"FORM FILL") 

recode exclude 1=0 if strpos(reason,"TELEPHONE CONSULTATION") // (exclude: 18036 changes made)
drop if exclude==1 //(697,891 observations deleted)
drop exclude

label data "Clean Encounter_Reason dataset 2016_2018"
save "Y:\MINGYUE\DIAB\emi_diab_encounter_clean.dta", replace

***********************************
****PRESCRIPTION REASON DATASET****
***********************************
use "Y:\MINGYUE\Reason_prescription_2016_2018.dta", clear 
 
**Delete observations for administrative reasons**
gen exclude=1 if strpos(reason,"NO CONSULT") | strpos(reason,"DID NOT ATTEND") | strpos(reason,"NOT SEEN") | strpos(reason,"CLERK") | ///
strpos(reason,"FAX") | strpos(reason,"EMAIL") | strpos(reason,"PHONE") | strpos(reason,"PH CALL") | strpos(reason,"CALL FROM") | strpos(reason,"CALL TO") | strpos(reason,"LETTER") |  strpos(reason,"INVITE") | ///
strpos(reason," SMS ") | strpos(reason,"MESSAGE") | strpos(reason,"REMINDER") |  strpos(reason,"RECALL") | strpos(reason,"RECEPTIONIST") |  strpos(reason,"CORRESPONDENCE") | ///
strpos(reason,"HOTDOC") | strpos(reason,"APPOINTUIT") | strpos(reason,"APPT")  | strpos(reason,"APPOINTMENT") |  ///
strpos(reason,"PRACTICE MANAGER") | strpos(reason,"FORMS") | strpos(reason,"PATH FORM") | strpos(reason,"PATHOLOGY FORM") | strpos(reason,"REQUEST FORM") | strpos(reason,"CENTRELINK FORM") | ///
strpos(reason,"SCANNED FORM") | strpos(reason,"FORM PRINT") | strpos(reason,"PATH REQ FORM") | strpos(reason,"TEST FORM ") | ///
strpos(reason,"MEDICAL RECORD") | strpos(reason,"PREPARATION") |  strpos(reason,"MEDICAL CERTIFICATE") &  strpos(reason,"LINK")  |  strpos(reason,"TEAM CARE ARRANGEMENT - COORDINATION OF") | ///
strpos(reason,"PAPER WORK") | strpos(reason,"FORM FILL") 

recode exclude 1=0 if strpos(reason,"TELEPHONE CONSULTATION") //(exclude: 15 changes made)
drop if exclude==1 //(3,447 observations deleted)
drop exclude

label data "Clean Prescription_Reason dataset 2016_2018"
save "Y:\MINGYUE\DIAB\emi_diab_prescrip_reason_clean.dta", replace 



******************************************************************
******************************************************************
****2. IDENTIFY PATIENTS WITH DIABETES, GDM, PREDIABETES, PCOS****FROM DIAGNOSIS, REASON FOR ENCOUNTER AND REASON FOR PRESCRIPTION DATASETS 
******************************************************************
******************************************************************

*******************************************************************************************************************************************
*Have a diagnosis of ‘DIABETES, GDM, PREDIABETES, PCOS’ either in the diagnosis, reason for encounter, or reason for prescription datasets*
*******************************************************************************************************************************************
* ALWAYS CHANGE THE DIRECTORY TO FACILITATE OPENING AND SAVING FILES, AS THE ROOTS ARE DIFFERENT
* The name with "_day" reflects that dataset was collapsed per patient per day
cd "Y:\MINGYUE"

*************************
****DIAGNOSIS DATASET**** 
*************************

use "DIAB\emi_diab_diagnosis_clean.dta", clear

***** ALL SUBSET CODES CHANGED TO GENERATE VARIABLES RELATED TO GESTATIONAL DIABETES AND PREDIABETES AND PCOS 


gen byte como_diabD=1 if strpos(reason,"DIABETE") | strpos(reason,"DIABETIC") |  (strpos(reason,"DM") & (strpos(reason,"T2")))  ///
| (strpos(reason,"DM") & (strpos(reason,"T1"))) | strpos(reason,"T2D") | strpos(reason,"T1D") | strpos(reason,"TIID") | strpos(reason,"NIDD") ///
| strpos(reason,"IDDM") | reason=="DM" | strpos(reason,"DIAGNOSED DM") | reason=="LADA" | reason=="MODY" | strpos(reason,"INSULIN PUMP")| strpos(reason,"NPDR")
* Latent autoimmune diabetes in adults (LADA), Maturity Onset Diabetes of the Young (MODY)

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_diabD 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_diabD 1=0 if strpos(reason,"?DIABET") | strpos(reason,"? DIABET") | strpos(reason,"DIABETES ?") | strpos(reason,"DIABETES?")  ///
|strpos(reason,"CONCERN ABOUT DIABET")| strpos(reason,"DIABETES CONCERNS") | strpos(reason,"CONCERNS DIABET") |strpos(reason,"FEAR") | strpos(reason,"POSSIBL") ///
| strpos(reason,"RISK ASSESSMENT") | strpos(reason,"RULE OUT") | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPECT") | strpos(reason,"NOT DIABET") ///
| strpos(reason,"NO DIABETES") |strpos(reason,"POTENTIAL DIABETES") |strpos(reason,"LIKELY DIABET") | strpos(reason,"DIABETES LIKELY") ///
| strpos(reason,"PROBABLE DIABETES")  | strpos(reason,"NON DIABET") | reason=="NON-DIABETIC"


***Recode the variable from 1 to 0 if the variable (reason) contains specifies INSIPIDUS***
recode como_diabD 1=0 if strpos(reason,"INSIPIDUS") 

*** Recode 0 to 1 if there is risk or screening of diabetes-related complications
recode como_diabD 0=1 if (strpos(reason,"DIABET") & (strpos(reason,"RETINOPATHY"))) | (strpos(reason,"DIABET") & (strpos(reason,"EYE"))) | ///
 (strpos(reason,"DIABET") & (strpos(reason,"FOOT"))) | (strpos(reason,"DIABET") & (strpos(reason,"FEET"))) | (strpos(reason,"DIABET") & (strpos(reason,"PODIATRY")))


recode como_diabD .=0 //
lab var como_diabD "Diagnosis of diabetes in clean diagnosis dataset"
lab def como_diabD 0"No" 1"Yes", replace
lab val como_diabD como_diabD 
 
 
 
***** GENERATE GESTATIONAL DIABETES 
gen byte gest_diabD=1 if ((strpos(reason,"GEST") | strpos(reason, "PREG")) & strpos(reason, "DIAB")) | strpos(reason,"GDM") 
recode gest_diabD .=0
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode gest_diabD 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode gest_diabD 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

lab def noyes 0"No" 1"Yes", replace



*** GENERATE PREDIABETES
gen byte prediabD =1 if strpos(reason,"PRE-DIAB") | strpos(reason,"PRE DIAB") | strpos(reason,"PREDIAB") | strpos(reason,"PRE DM")  ///
| (strpos(reason,"IMPAIR") & strpos(reason,"GLUC")) | strpos(reason,"IFG") | strpos(reason,"IGT ") ///
| (strpos(reason,"BORDERL") & (strpos(reason,"GLUC") | strpos(reason,"HBA1C")  | strpos(reason,"DIAB")))
recode prediabD .=0

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode prediabD 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode prediabD 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")



*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OR GESTATIONAL DIABETES
recode como_diabD 1=0 if gest_diabD==1 | prediabD==1 //(como_diabD: 9850 changes made)


*** GENERATE PCOS
gen byte como_pcosD=1 if (strpos(reason,"POLYCYS") & strpos(reason,"OVAR")) | strpos(reason,"PCOS") |  strpos(reason,"PCOD") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_pcosD 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FH ") | strpos(reason,"FA HISTORY") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_pcosD 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

recode como_pcosD .=0
lab var como_pcosD "Comorbidity-PCOS"


lab def noyes 0"No" 1"Yes", replace
lab val gest_diabD prediabD como_pcosD noyes



**Collapse by patientid and visit_date to have only one observation per day**
sort patientid visit_date
collapse (first) practiceid (max) como_diabD gest_diabD prediabD como_pcosD, by(patientid visit_date)
*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OS GESTATIONAL DIABETES
recode como_diabD 1=0 if gest_diabD==1 | prediabD==1


label data "Patients with a diagnosis of diabetes, prediabetes or gestational diabetes via diagnosis dataset collapsed by per day"
save "DIAB\emi(diab)_diagnosis_diab_patients_day.dta", replace



********************************
****ENCOUNTER_REASON DATASET**** 
********************************

use "DIAB\emi_diab_encounter_clean.dta", clear

gen byte como_diabE=1 if strpos(reason,"DIABETE") | strpos(reason,"DIABETIC") |  (strpos(reason,"DM") & (strpos(reason,"T2")))  ///
| (strpos(reason,"DM") & (strpos(reason,"T1"))) | strpos(reason,"T2D") | strpos(reason,"T1D") | strpos(reason,"TIID") | strpos(reason,"NIDD") ///
| strpos(reason,"IDDM") | reason=="DM" | strpos(reason,"DIAGNOSED DM") | reason=="LADA" | reason=="MODY" | strpos(reason,"INSULIN PUMP")| strpos(reason,"NPDR")
* Latent autoimmune diabetes in adults (LADA), Maturity Onset Diabetes of the Young (MODY)

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_diabE 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_diabE 1=0 if strpos(reason,"?DIABET") | strpos(reason,"? DIABET") | strpos(reason,"DIABETES ?") | strpos(reason,"DIABETES?")  ///
|strpos(reason,"CONCERN ABOUT DIABET")| strpos(reason,"DIABETES CONCERNS") | strpos(reason,"CONCERNS DIABET") |strpos(reason,"FEAR") | strpos(reason,"POSSIBL") ///
| strpos(reason,"RISK ASSESSMENT") | strpos(reason,"RULE OUT") | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPECT") | strpos(reason,"NOT DIABET") ///
| strpos(reason,"NO DIABETES") |strpos(reason,"POTENTIAL DIABETES") |strpos(reason,"LIKELY DIABET") | strpos(reason,"DIABETES LIKELY") ///
| strpos(reason,"PROBABLE DIABETES")  | strpos(reason,"NON DIABET") | reason=="NON-DIABETIC"


***Recode the variable from 1 to 0 if the variable (reason) contains specifies INSIPIDUS***
recode como_diabE 1=0 if strpos(reason,"INSIPIDUS") 

*** Recode 0 to 1 if there is risk or screening of diabetes-related complications
recode como_diabE 0=1 if (strpos(reason,"DIABET") & (strpos(reason,"RETINOPATHY"))) | (strpos(reason,"DIABET") & (strpos(reason,"EYE"))) | ///
 (strpos(reason,"DIABET") & (strpos(reason,"FOOT"))) | (strpos(reason,"DIABET") & (strpos(reason,"FEET"))) | (strpos(reason,"DIABET") & (strpos(reason,"PODIATRY")))


recode como_diabE .=0 //
lab var como_diabE "Diagnosis of diabetes in clean encounter dataset"
lab def como_diabE 0"No" 1"Yes", replace
lab val como_diabE como_diabE 
   
 
***** GENERATE GESTATIONAL DIABETES 
gen byte gest_diabE=1 if ((strpos(reason,"GEST") | strpos(reason, "PREG")) & strpos(reason, "DIAB")) | strpos(reason,"GDM") 
recode gest_diabE .=0
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode gest_diabE 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode gest_diabE 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

lab def noyes 0"no" 1"yes", replace


*** GENERATE PREDIABETES
gen byte prediabE =1 if strpos(reason,"PRE-DIAB") | strpos(reason,"PRE DIAB") | strpos(reason,"PREDIAB") | strpos(reason,"PRE DM")  ///
| (strpos(reason,"IMPAIR") & strpos(reason,"GLUC")) | strpos(reason,"IFG") | strpos(reason,"IGT ") ///
| (strpos(reason,"BORDERL") & (strpos(reason,"GLUC") | strpos(reason,"HBA1C")  | strpos(reason,"DIAB")))
recode prediabE .=0

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode prediabE 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode prediabE 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")



*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OS GESTATIONAL DIABETES
recode como_diabE 1=0 if gest_diabE==1 | prediabE==1


*** GENERATE PCOS
gen byte como_pcosE=1 if (strpos(reason,"POLYCYS") & strpos(reason,"OVAR")) | strpos(reason,"PCOS") |  strpos(reason,"PCOD") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_pcosE 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FH ") | strpos(reason,"FA HISTORY") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_pcosE 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

recode como_pcosE .=0
lab var como_pcosE "Comorbidity-PCOS"


lab def noyes 0"no" 1"yes", replace
lab val gest_diabE prediabE como_pcosE noyes



**Collapse by patientid and visit_date to have only one observation per day**
sort patientid visit_date
collapse (first) practiceid (max) como_diabE gest_diabE prediabE como_pcosE, by(patientid visit_date)

*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OR GESTATIONAL DIABETES
recode como_diabE 1=0 if gest_diabE==1 | prediabE==1


label data "Patients with a diagnosis of diabetes, prediabetes or gestational diabetes via diagnosis dataset collapsed by per day"
save "DIAB\emi(diab)_encounter_diab_patients_day.dta", replace



***********************************
****PRESCRIPTION_REASON DATASET**** 
***********************************

use "DIAB\emi_diab_prescrip_reason_clean.dta", clear 
drop como_ihd como_heart como_fibril como_stroke como_copd como_lung como_pcos como_dyslip como_ckd como_hpt como_diab como_osa como_anx como_dep como_prediab

gen byte como_diabP=1 if strpos(reason,"DIABETE") | strpos(reason,"DIABETIC") |  (strpos(reason,"DM") & (strpos(reason,"T2")))  ///
| (strpos(reason,"DM") & (strpos(reason,"T1"))) | strpos(reason,"T2D") | strpos(reason,"T1D") | strpos(reason,"TIID") | strpos(reason,"NIDD") ///
| strpos(reason,"IDDM") | reason=="DM" | strpos(reason,"DIAGNOSED DM") | reason=="LADA" | reason=="MODY" | strpos(reason,"INSULIN PUMP")| strpos(reason,"NPDR")
* Latent autoimmune diabetes in adults (LADA), Maturity Onset Diabetes of the Young (MODY)

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_diabP 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_diabP 1=0 if strpos(reason,"?diabPT") | strpos(reason,"? diabPT") | strpos(reason,"diabPTES ?") | strpos(reason,"diabPTES?")  ///
|strpos(reason,"CONCERN ABOUT diabPT")| strpos(reason,"diabPTES CONCERNS") | strpos(reason,"CONCERNS diabPT") |strpos(reason,"FEAR") | strpos(reason,"POSSIBL") ///
| strpos(reason,"RISK ASSESSMENT") | strpos(reason,"RULE OUT") | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPECT") | strpos(reason,"NOT diabPT") ///
| strpos(reason,"NO diabPTES") |strpos(reason,"POTENTIAL diabPTES") |strpos(reason,"LIKELY diabPT") | strpos(reason,"diabPTES LIKELY") ///
| strpos(reason,"PROBABLE diabPTES")  | strpos(reason,"NON diabPT") | reason=="NON-diabPTIC"


***Recode the variable from 1 to 0 if the variable (reason) contains specifies INSIPIDUS***
recode como_diabP 1=0 if strpos(reason,"INSIPIDUS") 

*** Recode 0 to 1 if there is risk or screening of diabPtes-related complications
recode como_diabP 0=1 if (strpos(reason,"diabPT") & (strpos(reason,"RETINOPATHY"))) | (strpos(reason,"diabPT") & (strpos(reason,"EYE"))) | ///
 (strpos(reason,"diabPT") & (strpos(reason,"FOOT"))) | (strpos(reason,"diabPT") & (strpos(reason,"FEET"))) | (strpos(reason,"diabPT") & (strpos(reason,"PODIATRY")))


recode como_diabP .=0 //
lab var como_diabP "Diagnosis of diabPtes in clean encounter dataset"
lab def como_diabP 0"No" 1"Yes", replace
lab val como_diabP como_diabP 
 
  
 
***** GENERATE GESTATIONAL DIABETES 
gen byte gest_diabP=1 if ((strpos(reason,"GEST") | strpos(reason, "PREG")) & strpos(reason, "DIAB")) | strpos(reason,"GDM") 
recode gest_diabP .=0
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode gest_diabP 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ") | strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode gest_diabP 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

lab def noyes 0"no" 1"yes", replace


*** GENERATE PREDIABETES
gen byte prediabP =1 if strpos(reason,"PRE-DIAB") | strpos(reason,"PRE DIAB") | strpos(reason,"PREDIAB") | strpos(reason,"PRE DM")  ///
| (strpos(reason,"IMPAIR") & strpos(reason,"GLUC")) | strpos(reason,"IFG") | strpos(reason,"IGT ") ///
| (strpos(reason,"BORDERL") & (strpos(reason,"GLUC") | strpos(reason,"HBA1C")  | strpos(reason,"DIAB")))
recode prediabP .=0

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode prediabP 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX")| strpos(reason,"PARENT") ///
| strpos(reason,"MOTHER") | strpos(reason,"MUM")|strpos(reason,"MATERNAL")| strpos(reason,"FATHER") |strpos(reason,"DAD") |strpos(reason,"PATERNAL") ///
| strpos(reason,"HUSBAND") |strpos(reason,"WIFE") | strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode prediabP 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")


*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OS GESTATIONAL DIABETES
recode como_diabP 1=0 if gest_diabP==1 | prediabP==1


*** GENERATE PCOS
gen byte como_pcosP=1 if (strpos(reason,"POLYCYS") & strpos(reason,"OVAR")) | strpos(reason,"PCOS") | strpos(reason,"PCOD") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***
recode como_pcosP 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FH ") | strpos(reason,"FA HISTORY") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_pcosP 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR") | strpos(reason,"POSSIBL") | strpos(reason,"RISK") ///
| (strpos(reason,"RULE") &  strpos(reason,"OUT")) | strpos(reason,"EXCLUDE") |strpos(reason,"SUSPEC") | strpos(reason,"POTENTIAL") |strpos(reason,"LIKELY") ///
| strpos(reason,"PROBAB")  | strpos(reason,"NOT") | strpos(reason,"NON")

recode como_pcosP .=0
lab var como_pcosP "Comorbidity-PCOS"


lab def noyes 0"no" 1"yes", replace
lab val gest_diabP prediabP como_pcosP noyes


**Collapse by patientid and visit_date to have only one observation per day**
sort patientid visit_date
collapse (first) practiceid (max) como_diabP gest_diabP prediabP como_pcosP, by(patientid visit_date)

*** RECODE DIABETES TO 0 IF IT WAS PREDIABETES OR GESTATIONAL DIABETES
recode como_diabP 1=0 if gest_diabP==1 | prediabP==1


label data "Patients with a prescription reason of diabetes collapsed by per day"
save "DIAB/emi(diab)_prescrip_reason_diab_patients_day.dta", replace 




****************************************************************************************************
****************************************************************************************************
****3. IDENTIFY PATIENTS WERE PRESCRIBED ANTI-DIABETIC MEDICATIONS (ADM) VIA SCRIPT_ITEM DATASET****
****************************************************************************************************
****************************************************************************************************
*Patients were prescribed insulin and/or an oral antidiabetic medication (ATC codes A10A and A10B)

use "Script_item_2016_2018.dta", clear 

/*DRUG NAME OF DIABETES (based on PBS ATC code A10A AND A10B) found in medicine_active_ingredient 
gen byte script_diab=1 if strpos(medicine_active_ingredient,"INSULIN") | strpos(medicine_active_ingredient,"METFORMIN") | strpos(medicine_active_ingredient,"GLIBENCLAMIDE") | ///
strpos(medicine_active_ingredient,"GLICLAZIDE") | strpos(medicine_active_ingredient, "GLIMEPIRIDE") | strpos(medicine_active_ingredient,"GLIPIZIDE") | ///
strpos(medicine_active_ingredient,"ACARBOSE") | strpos(medicine_active_ingredient, "PIOGLITAZONE") | strpos(medicine_active_ingredient,"ALOGLIPTIN") | ///
strpos(medicine_active_ingredient,"LINAGLIPTIN") | strpos(medicine_active_ingredient,"SAXAGLIPTIN") | strpos(medicine_active_ingredient,"SITAGLIPTIN") | ///
strpos(medicine_active_ingredient,"VILDAGLIPTIN") | strpos(medicine_active_ingredient,"DULAGLUTIDE") | strpos(medicine_active_ingredient,"EXENATIDE") | ///
strpos(medicine_active_ingredient,"DAPAGLIFLOZIN") | strpos(medicine_active_ingredient,"EMPAGLIFLOZIN") | strpos(medicine_active_ingredient,"ERTUGLIFLOZIN") */

***** GENERATE MEDICATION LIST RATHER THAT IF TAKING ANY MEDICATION (based on PBS ATC code A10A AND A10B) 
gen byte script_INSULIN=1 if strpos(medicine_active_ingredient,"INSULIN") 
gen byte script_METFORMIN=1 if strpos(medicine_active_ingredient,"METFORMIN") 
gen byte script_GLIBENCLAMIDE=1 if strpos(medicine_active_ingredient,"GLIBENCLAMIDE") 
gen byte script_GLICLAZIDE=1 if strpos(medicine_active_ingredient,"GLICLAZIDE") 
gen byte script_GLIMEPIRIDE=1 if strpos(medicine_active_ingredient,"GLIMEPIRIDE") 
gen byte script_GLIPIZIDE=1 if strpos(medicine_active_ingredient,"GLIPIZIDE") 
gen byte script_ACARBOSE=1 if strpos(medicine_active_ingredient,"ACARBOSE") 
gen byte script_PIOGLITAZONE=1 if strpos(medicine_active_ingredient,"PIOGLITAZONE") 
gen byte script_ALOGLIPTIN=1 if strpos(medicine_active_ingredient,"ALOGLIPTIN") 
gen byte script_LINAGLIPTIN=1 if strpos(medicine_active_ingredient,"LINAGLIPTIN") 
gen byte script_SAXAGLIPTIN=1 if strpos(medicine_active_ingredient,"SAXAGLIPTIN") 
gen byte script_SITAGLIPTIN=1 if strpos(medicine_active_ingredient,"SITAGLIPTIN") 
gen byte script_VILDAGLIPTIN=1 if strpos(medicine_active_ingredient,"VILDAGLIPTIN") 
gen byte script_DULAGLUTIDE=1 if strpos(medicine_active_ingredient,"DULAGLUTIDE") 
gen byte script_EXENATIDE=1 if strpos(medicine_active_ingredient,"EXENATIDE") 
gen byte script_DAPAGLIFLOZIN=1 if strpos(medicine_active_ingredient,"DAPAGLIFLOZIN") 
gen byte script_EMPAGLIFLOZIN=1 if strpos(medicine_active_ingredient,"EMPAGLIFLOZIN") 
gen byte script_ERTUGLIFLOZIN=1 if strpos(medicine_active_ingredient,"ERTUGLIFLOZIN") 

lab def script_diab 0"No" 1"Yes", replace
foreach var of varlist script_INSULIN script_METFORMIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN{
	recode `var' .=0
	lab val `var' script_diab
}


**Collapse by patientid and visit_date to have only one observation per day**

sort patientid script_date
collapse (first) practiceid (max) script_INSULIN script_METFORMIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN, by(patientid script_date)

egen byte script_diab = rowmax(script_INSULIN script_METFORMIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN)

lab val script_diab script_diab
lab var script_diab "received Script for antiabetic drug"


rename script_date visit_date

label data "Patients with a script for ADM"
save "DIAB\emi(diab)_script_item_for_ADM_day.dta", replace 




**********************************************************************************************************
**********************************************************************************************************
****4. IDENTIFY PATIENTS WITH AN ELEVATED BG READING FOR DIABETES OR PREDIABETES VIA PATHOLOGY DATASET****
**********************************************************************************************************
**********************************************************************************************************

use "Pathology_corrected_2016_2018.dta", clear 
** For clinical variables: 0 No 1  Tested-no valid results 2 Tested-valid results 
/*
THE CATEGORIES OF GLUCOSE LEVEL
• 0 indicates normal levels 
• 1 indicates prediabetes levels
• 2 indicates diabetes levels 
*/

/*PREDIABETES
Please refer to: https://diabetessociety.com.au/downloads/covid-19-articles/20200615%20ADS_Summary_Prediabetes_Position_Statement.pdf
Diagnosis of prediabetes is by a 75g oral glucose tolerance test (OGTT), fasting blood glucose (FBG) or HbA1c:
• IFG is defined as FBG of 6.1-6.9 mmol/L.
• IGT is defined as 2-hour blood glucose 7.8-11.1 mmol/L in an OGTT.
• HbA1c of 6.0-6.4% is recommended as the definition of prediabetes.
*/

/*DIABETES
Please refer to: https://diabetessociety.com.au/position-statements.asp
The criteria for the diagnosis of diabetes are now:
• HbA1c ≥6.5% (48 mmol/mol)
• Fasting glucose ≥7.0 mmol/L
• Random glucose ≥11.1 mmol/L
• On a 75 g oral glucose tolerance test: fasting glucose ≥7.0 mmol/L or 2 hr glucose ≥11.1 mmol/L
Note: In an asymptomatic patient the test should be repeated for confirmation of the result and diagnosis. 
An abnormal result on 2 different diagnostic tests is also acceptable.
*/

*********
***FBG***
*********
**Generate a new variable to indicate prediabetes if fasting plasma glucose is elevated
gen byte bg_fast = 0 
recode bg_fast 0=1 if glucose==2 & (gluc_fast_mmol_l>=6.1) & (gluc_fast_mmol_l<=6.9) 

* DAG: ALWAYS INCLUDE THE UPPER LIMIT AS <.  OTHERWISE ANY MISSING DATA IS CONVERTED TO DIABETES
recode  bg_fast 0=2 if glucose==2 & (gluc_fast_mmol_l>=7.0 & gluc_fast_mmol_l<.)
recode bg_fast 0=. if gluc_fast_mmol_l==.

lab var bg_fast "Elevated Fasting Plasma Glucose"
lab def bg_fast 0"Normal FBG" 1"FBG for Prediabetes" 2"FBG for Diabetes", replace
lab val bg_fast  bg_fast
tab bg_fast 


**********
***OGTT***
**********
**Generate a new variable to indicate prediabetes if 2-h plasma glucose via OGTT is elevated
gen byte bg_ogtt = 0 
recode bg_ogtt 0=1 if glucose==2 & (gluc_ogtt_mmol_l>=7.8) & (gluc_ogtt_mmol_l<11.1)

* DAG: ALWAYS INCLUDE THE UPPER LIMIT AS <.  OTHERWISE ANY MISSING DATA IS CONVERTED TO DIABETES
recode bg_ogtt 0=2 if glucose==2 & (gluc_ogtt_mmol_l>=11.1 & gluc_ogtt_mmol_l<.)
recode bg_ogtt 0=. if gluc_ogtt_mmol_l==.

lab var bg_ogtt "Elevated 2-h Plasma Glucose via OGTT"
lab def bg_ogtt 0"Normal OGTT" 1"OGTT for Prediabetes" 2"OGTT for Diabetes", replace
lab val bg_ogtt bg_ogtt
tab bg_ogtt


***********
***HBA1C***
***********
**Generate a new variable to indicate prediabets if hba1c is elevated
gen byte bg_hba1c  = 0 
recode bg_hba1c 0=1 if (hba1c==2 & (hba1c_percent>=6.0 & hba1c_percent<=6.4)) | (hba1c==2 & (hba1c_mmol_mol>=42 & hba1c_mmol_mol<=47))

* DAG: ALWAYS INCLUDE THE UPPER LIMIT AS <.  OTHERWISE ANY MISSING DATA IS CONVERTED TO DIABETES
recode bg_hba1c 0=2 if (hba1c==2 & (hba1c_percent>=6.5 & hba1c_percent<.))  | (hba1c==2 & (hba1c_mmol_mol>=48 & hba1c_mmol_mol<.))
recode bg_hba1c 0=. if hba1c_percent==. & hba1c_mmol_mol==.

lab var bg_hba1c "Elevated HbA1c"
lab def bg_hba1c 0"Normal HbA1c" 1"HbA1c for Prediabetes" 2"HbA1c for Diabetes", replace
lab val bg_hba1c bg_hba1c
tab bg_hba1c


***************
***RANDOM BG***
***************
**Generate a new variable to indicate if random glucose (also known as random or casual plasma glucose test) is elevated
gen byte bg_random  = 0 

* DAG: ALWAYS INCLUDE THE UPPER LIMIT AS <.  OTHERWISE ANY MISSING DATA IS CONVERTED TO DIABETES
recode bg_random 0=2 if glucose==2 & (gluc_random_mmol_l>=11.1 & gluc_random_mmol_l<.)
recode bg_random 0=. if gluc_random_mmol_l==.

lab var bg_random "Elevated Random Glucose"
lab def bg_random 0"Normal Random Glucose" 2"Random Glucose for Diabetes", replace
lab val bg_random bg_random
tab bg_random


******************
**FOR PREDIABETES: Generate a new variable indicating elevated BG 
* DAG: The definition OF PREDIABETES or DIABETES considering at least two positive results will come later, as you need to combine results in different dates
gen byte prediabPATH =1 if bg_fast==1 | bg_ogtt==1 | bg_hba1c==1 
recode prediabPATH .=0

lab var prediabPATH "Elevated PREDIABETES levels BG - fasting, OGTT, HbA1c"
lab def prediabPATH 0"No" 1"pre-diabetes" , replace
lab val prediabPATH prediabPATH

gen byte diabPATH =1 if bg_fast==2 | bg_ogtt==2 | bg_hba1c==2 | bg_random==2
recode diabPATH .=0

lab var diabPATH "Elevated DIABETES levels BG - fasting, OGTT, HbA1c, random"
lab def diabPATH 0"No" 1"diabetes" , replace
lab val diabPATH diabPATH

* THERE ARE 10,225 INDIVIDUALS WITH RESULTS ON THE SAME DATE INDICATING BOTH, PREDIABETES AND DIABETES LEVELS. THEY WERE CORRECTED AND ASSUMED AS DIABETES.
recode prediabPATH 1=0 if diabPATH==1


* GENERATING A VARIABLE THAT INDICATES WHETHER A PATIENT HAD OR NOT THEIR GLUCOSE LEVELS TESTED ON THAT DATE - USED TO IDENTIFY HOW MANY 'DIFFERENT' TIMES THEY WERE TESTED
* USEFUL FOR COLLAPSING PER PATIENT. NON-VALID RESULTS CONSIDERED AS NO TESTED - 8,725 OUT OF 1014963 for glucose and 340 out of 377,882 for HbA1C. Only 56 results invalid both 
* For the same patient on the same date 
gen byte glucose_checked = 1 if hba1c==2 | glucose==2
recode  glucose_checked .=0
lab var glucose_checked "Either glucose test or HbA1C tested on that date"

**Collapse so that there is only one observation per patient per date**
* DAG: NO NEED TO COLLAPSE PER DAY. DATASET ONLY HAS ONE LINE PER PATIENT PER DAY. KEEPING ALL LAB RESULTS FOR FURTHER ANALYSES OF OTHER PAPERS.


label data "All BG measurements for elevated BG readings of diabetes and prediabetes"
save "DIAB\emi(diab)_path_elevated_BG_day.dta", replace



**************************************************************************************
**************************************************************************************
****5. MERGE FIVE DATASETS, CREATE A DATASET TO IDENTIFY TARGETED DIABETES PATIENTS***
**************************************************************************************
**************************************************************************************

/*
NOTE: USE FINAL CLEAN DATASET WITH _diab_patients.dta 
TWO STEPS:
(1)Counting in each dataset the number of visits and number of times the diagnosis of diabetes was identified
(2)Merge five sources of diabetes diagnosis (diagnosis, encounter_reason, prescription_reason, script_item, pathology datasets) to identify targeted diabetes patients***  
*/

*****************************************************************************************************************
**(1)Counting in each dataset the number of visits and number of times the diagnosis of diabetes was identified**

*************************
****DIAGNOSIS DATASET**** 
*************************

use "DIAB\emi(diab)_diagnosis_diab_patients_day.dta", clear

collapse (first) practiceid (count) diab_searchedD = como_diabD gestdiab_searchedD = gest_diabD prediab_searchedD = prediabD pcos_sarchedD = como_pcosD (sum) diab_foundD = como_diabD gestdiab_foundD = gest_diabD prediab_foundD = prediabD pcos_foundD = como_pcosD (max) diab_diagD = como_diabD gestdiab_diagD = gest_diabD prediab_diagD = prediabD pcos_diagD = como_pcosD, by(patientid)
. tab1 diab_diagD gestdiab_diagD prediab_diagD pcos_diagD
/*
-> tabulation of diab_diagD  

      (max) |
 como_diabD |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,485,000       99.94       99.94
          1 |      1,449        0.06      100.00
------------+-----------------------------------
      Total |  2,486,449      100.00

-> tabulation of gestdiab_diagD  

      (max) |
 gest_diabD |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,480,542       99.76       99.76
          1 |      5,907        0.24      100.00
------------+-----------------------------------
      Total |  2,486,449      100.00

-> tabulation of prediab_diagD  

      (max) |
   prediabD |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,468,046       99.26       99.26
          1 |     18,403        0.74      100.00
------------+-----------------------------------
      Total |  2,486,449      100.00

-> tabulation of pcos_diagD  

      (max) |
 como_pcosD |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,477,665       99.65       99.65
          1 |      8,784        0.35      100.00
------------+-----------------------------------
      Total |  2,486,449      100.00
*/
save "DIAB\emi(diab)_diagnosis_diab_patients.dta", replace



********************************
****ENCOUNTER_REASON DATASET**** 
********************************
use "DIAB\emi(diab)_encounter_diab_patients_day.dta", clear

collapse (first) practiceid (count) diab_searchedE = como_diabE gestdiab_searchedE = gest_diabE prediab_searchedE = prediabE pcos_sarchedE = como_pcosE (sum) diab_foundE = como_diabE gestdiab_foundE = gest_diabE prediab_foundE = prediabE pcos_foundE = como_pcosE (max) diab_diagE = como_diabE gestdiab_diagE = gest_diabE prediab_diagE = prediabE pcos_diagE = como_pcosE, by(patientid)
tab1 diab_diagE gestdiab_diagE prediab_diagE pcos_diagE
/*

-> tabulation of diab_diagE  

      (max) |
 como_diabE |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,038,191       95.32       95.32
          1 |    149,187        4.68      100.00
------------+-----------------------------------
      Total |  3,187,378      100.00

-> tabulation of gestdiab_diagE  

      (max) |
 gest_diabE |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,181,586       99.82       99.82
          1 |      5,792        0.18      100.00
------------+-----------------------------------
      Total |  3,187,378      100.00

-> tabulation of prediab_diagE  

      (max) |
   prediabE |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,162,501       99.22       99.22
          1 |     24,877        0.78      100.00
------------+-----------------------------------
      Total |  3,187,378      100.00

-> tabulation of pcos_diagE  

      (max) |
 como_pcosE |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,174,091       99.58       99.58
          1 |     13,287        0.42      100.00
------------+-----------------------------------
      Total |  3,187,378      100.00

*/
save "DIAB\emi(diab)_encounter_diab_patients.dta", replace


************************************
****PRESCRIPTION_REASON DATASET***** 
************************************
use "DIAB\emi(diab)_prescrip_reason_diab_patients_day.dta", clear
(Patients with a prescription reason of diabetes collapsed by per day)

collapse (first) practiceid (count) diab_searchedP = como_diabP gestdiab_searchedP = gest_diabP prediab_searchedP = prediabP ///
pcos_sarchedP = como_pcosP (sum) diab_foundP = como_diabP gestdiab_foundP = gest_diabP prediab_foundP = prediabP pcos_foundP ///
= como_pcosP (max) diab_diagP = como_diabP gestdiab_diagP = gest_diabP prediab_diagP = prediabP pcos_diagP = como_pcosP, by(patientid)


tab1 diab_diagP gestdiab_diagP prediab_diagP pcos_diagP
/*
-> tabulation of diab_diagP  

      (max) |
 como_diabP |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,566,809       98.22       98.22
          1 |     46,541        1.78      100.00
------------+-----------------------------------
      Total |  2,613,350      100.00

-> tabulation of gestdiab_diagP  

      (max) |
 gest_diabP |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,613,061       99.99       99.99
          1 |        289        0.01      100.00
------------+-----------------------------------
      Total |  2,613,350      100.00

-> tabulation of prediab_diagP  

      (max) |
   prediabP |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,612,362       99.96       99.96
          1 |        988        0.04      100.00
------------+-----------------------------------
      Total |  2,613,350      100.00

-> tabulation of pcos_diagP  

      (max) |
 como_pcosP |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,610,194       99.88       99.88
          1 |      3,156        0.12      100.00
------------+-----------------------------------
      Total |  2,613,350      100.00

*/
save "DIAB\emi(diab)_prescrip_reason_diab_patients.dta", replace


**************************
****PRESCRIPTION_ITEMS**** 
**************************
use "DIAB\emi(diab)_script_item_for_ADM_day.dta", clear

collapse (first) practiceid (sum) script_diab (max) script_INSULIN script_METFORMIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN antidiab_script = script_diab, by(patientid)

order script_diab, before(antidiab_script)

egen byte antidiab_types = rowtotal(script_INSULIN script_METFORMIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN)
lab var script_diab "total antidiabetic prescriptions"
lab var antidiab_script "if patient received antidiabetic medication at any moment"
lab var antidiab_types "number of different antidiabetic medications received over time"

save "DIAB\emi(diab)_script_item_for_ADM_patients.dta", replace


*************************
****PATHOLOGY_RESULTS**** 
*************************
use "DIAB\emi(diab)_path_elevated_BG_day.dta", clear
**** DAG: Counting in each dataset the number of visits and number of times a positive test result was found
collapse (first) practiceid (count) searchedfast = bg_fast searched_ogtt = bg_ogtt searched_hba1c = bg_hba1c searched_random = bg_random (sum) glucose_checked diab_foundPATH = diabPATH prediab_foundPATH = prediabPATH, by(patientid) 
gen byte como_diabPATH_day = diab_foundPATH
recode como_diabPATH_day 1=0 2/max=1
gen byte como_prediabPATH_day = prediab_foundPATH
recode como_prediabPATH_day 1=0 2/max=1

*** There are 4,915 cases that according to lab results had at least two positives results for pre-diabetes and at least two positive results for diabetes.
*** RECODING THESE CASES TO DIABETES***
recode como_prediabPATH_day 1=0 if como_diabPATH_day==1

lab var como_diabPATH_day "two or more results of elevated BG for diabetes on different dates"
lab var como_prediabPATH_day "two or more results of elevated BG for prediabetes on different dates"
lab var glucose_checked "times that either glucose test or HbA1C was tested on the same patient"

save "DIAB\emi(diab)_path_elevated_BG_patients.dta", replace




***********************************************
**(2)Merge five sources of diabetes diagnosis**

use "DIAB\emi(diab)_diagnosis_diab_patients.dta", clear
merge 1:1 patientid using "DIAB\emi(diab)_encounter_diab_patients.dta", generate(merge_DE)
/*        Result                           # of obs.
    -----------------------------------------
    not matched                       746,883
        from master                    22,977  (merge_DE==1)
        from using                    723,906  (merge_DE==2)

    matched                         2,463,472  (merge_DE==3)
    -----------------------------------------
*/

**Explanation of different merge numbers:
**_merge 1 - are patients that have a diagnsis from diagnosis dataset but from encounter_reason dataset // 22,977
**_merge 2 - are patients that have a diagnsis from encounter_reason dataset but from diagnosis dataset// 723,906
**_merge 3 - are patients that have a diagnsis from diagnosis dataset AND encounter_reason dataset // 2,463,472

merge 1:1 patientid using "DIAB\emi(diab)_prescrip_reason_diab_patients.dta", generate(merge_DEP)
/*   Result                           # of obs.
    -----------------------------------------
    not matched                       744,295
        from master                   670,650  (merge_DEP==1)
        from using                     73,645  (merge_DEP==2)

    matched                         2,539,705  (merge_DEP==3)
    -----------------------------------------
*/
**Explanation of different merge numbers:
**_merge 1 - are patients that have a diagnsis from diagnosis/encounter_reason dataset but from  dataset //670,650  
**_merge 2 - are patients that have a diagnsis from prescription_reason dataset but from diagnosis/encounter_reason dataset// 73,645
**_merge 3 - are patients that have a diagnsis from diagnosis/encounter_reason dataset AND prescription_reason dataset dataset //  2,539,705 

merge 1:1 patientid using "DIAB\emi(diab)_script_item_for_ADM_patients.dta", generate(merge_DEPM) 

**Explanation of different merge numbers:
**_merge 1 - are patients that have a diagnsis from DEP BUT NOT in MEDICATION dataset //  568,262 
**_merge 2 - are patients that have a diagnsis from MEDICATION dataset but NOT in DEP dataset// 8530 
**_merge 3 - are patients that have a diagnsis from DEP AND MEDICATION dataset // 2,715,738 

merge 1:1 patientid using "DIAB\emi(diab)_path_elevated_BG_patients.dta", generate(merge_DEPMpath) 

**Explanation of different merge numbers:
**_merge 1 - are patients that have a diagnsis from DEP BUT NOT in PATHOLOGY dataset //   2,694,094  
**_merge 2 - are patients that have a diagnsis from MEDICATION dataset but NOT in DEP dataset// 4795 
**_merge 3 - are patients that have a diagnsis from DEP AND MEDICATION dataset // 598,436

* DAG: THIS MAY BE A PROBLEM FOR ANALYSIS. WE HAVE PATHOLOGY RESULTS ONLY FROM 600,000 PATIENTS
* THAT INCLUDE ALL AGES. NEED TO CHECK FOR OUR TARGET SAMPLE, AS UNDIAGNOSED DIABETES REQUIRES TWO POSITIVE GLUCOSE TESTS
* NO TEST IN OUR TARGET GROUP MEAN THERE IS STILL UNDIAGNOSED DIABETES BECAUSE UNTESTED, DIFFERENT FROM UNDIAGNOSED BECAUSE NOT NOTICED BY GP 

order merge_DE merge_DEP merge_DEPM, before(merge_DEPMpath)

* GENERATING VARIABLE THAT INDICATES NUMBER OF FIELDS SEARCHED IN EITHER DIAGNOSIS, ENCOUNTER OR REASON FOR PRESCRIPTION DATASET. THE NUMBER OF FIELDS (DIFFERENT DATES AND DATASETS) IS THE SAME FOR ANY CONDITION
egen byte searched_all = rowtotal (diab_searchedD diab_searchedE diab_searchedP)
lab var searched_all "# of fields searched - different dates and datasets diagnosis, encounter, prescreason"
tab searched_all
***13,325 individuals are "0" as they have either script data and/or pathology results data but not diagnosis, encounter or reason for prescription data*

* GENERATING VARIABLE THAT INDICATES NUMBER OF TIMES A PARTICULAR CONDITION WAS 'POSITIVE' IN EITHER DIAGNOSIS, ENCOUNTER OR REASON FOR PRESCRIPTION DATASET. 
egen byte diab_found_all = rowtotal (diab_foundD diab_foundE diab_foundP)
egen byte prediab_found_all = rowtotal (prediab_foundD prediab_foundE prediab_foundP)
egen byte gestdiab_found_all = rowtotal (gestdiab_foundD gestdiab_foundE gestdiab_foundP)
egen byte pcos_found_all = rowtotal (pcos_foundD pcos_foundE pcos_foundP)

lab var diab_found_all "times diabetes diagnosis was found in diagnosis, encounter or prescreason datasets"
lab var prediab_found_all "times prediabetes diagnosis was found in diagnosis, encounter or prescreason datasets"
lab var gestdiab_found_all "times gestational diabetes diagnosis was found in diagnosis, encounter or prescreason datasets"
lab var pcos_found_all "times PCOS diagnosis was found in diagnosis, encounter or prescreason datasets"


* * GENERATING VARIABLE THAT INDICATES NUMBER OF DATASETS THAT A PARTICULAR CONDITION WAS 'POSITIVE' IN EITHER DIAGNOSIS, ENCOUNTER OR REASON FOR PRESCRIPTION DATASET. 
egen byte diab_dataset_all = rowtotal (diab_diagD diab_diagE diab_diagP)
egen byte prediab_dataset_all = rowtotal (prediab_diagD prediab_diagE prediab_diagP)
egen byte gestdiab_dataset_all = rowtotal (gestdiab_diagD gestdiab_diagE gestdiab_diagP)
egen byte pcos_dataset_all = rowtotal (pcos_diagD pcos_diagE pcos_diagP)

lab var diab_dataset_all "# of datasets diabetes was found in diagnosis, encounter or prescreason datasets"
lab var prediab_dataset_all "# of datasets prediabetes was found in diagnosis, encounter or prescreason datasets"
lab var gestdiab_dataset_all "# of datasets gestdiabetes was found in diagnosis, encounter or prescreason datasets"
lab var pcos_dataset_all "# of datasets PCOS was found in diagnosis, encounter or prescreason datasets"

compress 


****** COMBINING DATASET WITH PATIENT VARIABLES - ALREADY CREATED FOR USE WITH ANY PROJECT
merge 1:1 patientid using "patient_variables_2016_2018.dta", generate(merge_patientvariables)

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                        58,877
        from master                     3,092  (merge_patientvariables==1)
        from using                     55,785  (merge_patientvariables==2)

    matched                         3,294,233  (merge_patientvariables==3)
    -----------------------------------------
*/

*** keepin only those with common data i both datasets**
drop if merge_patientvariables!=3
*58,877 observations deleted
drop merge_patientvariables
compress


******************************************************************************
** GENERATING VARIABLE OF DIABETES DIAGNOSIS - INCLUDING ALL POSSIBILITIES ***
******************************************************************************
* FOR PCOS AND GESTATIONAL DIABETES, POSITIVE IF AT LEAST TWO FIELDS IN ANY DATASET HAD THAT DIAGNOSIS
gen byte pcos_diag_all = pcos_found_all
recode pcos_diag_all 1=0 2/max=1
recode pcos_diag_all 1=0 if gender2==0
*(pcos_diag_all: 12 changes made) 12 males with misrecords of pcos
lab var pcos_diag_all "PCOS diagnosis >=2 fields in diagnosis, encounter or prescreason datasets"

gen byte gestdiab_diag_all = gestdiab_found_all
recode gestdiab_diag_all 1=0 2/max=1
recode gestdiab_diag_all 1=0 if gender2==0
*(gestdiab_diag_all: 5 changes made) 5 males with misrecords of pcos
lab var gestdiab_diag_all "gestat diab diagnosis >=2 fields in diagnosis, encounter or prescreason datasets"


* FOR PREDIABETES AND DIABETES THE CRITERIA IS A BIT DIFFERENT
gen byte diab_diag_all = diab_found_all
recode diab_diag_all 2/max=2
foreach var of varlist script_INSULIN script_GLIBENCLAMIDE script_GLICLAZIDE script_GLIMEPIRIDE script_GLIPIZIDE script_ACARBOSE script_PIOGLITAZONE script_ALOGLIPTIN script_LINAGLIPTIN script_SAXAGLIPTIN script_SITAGLIPTIN script_VILDAGLIPTIN script_DULAGLUTIDE script_EXENATIDE script_DAPAGLIFLOZIN script_EMPAGLIFLOZIN script_ERTUGLIFLOZIN{
	recode diab_diag_all 0/1=2 if `var'==1
}
recode diab_diag_all 0/1=2 if script_METFORMIN==1 & pcos_diag_all==0 
recode diab_diag_all 1=2 if diab_foundPATH>=1 & diab_foundPATH<.
lab var diab_diag_all "diabetes diagnosis >=2 fields | ADM | 1 field + (metformin no PCOS | path result diab)"


gen byte prediab_diag_all = prediab_dataset_all
recode prediab_diag_all 2/max=2
recode prediab_diag_all 0/1=2 if script_METFORMIN==1 & pcos_diag_all==0
recode prediab_diag_all 1=2 if prediab_foundPATH>=1 & prediab_foundPATH<.
lab var prediab_diag_all "prediabets diagnosis >=2 fields | 1 field + (metformin no PCOS | path result prediab)"

/*. tab prediab_diag_all diab_diag_all 

HERE IS DAG'S NUMBER BEFORE I REMOVED MALES WITH PCOS OR MALES WITH GDM

prediabets |
 diagnosis |
>=2 fields |
 | 1 field |
         + |
(metformin |
 no PCOS | |
      path |          diab_diag_all
result pre |         0          1          2 |     Total
-----------+---------------------------------+----------
         0 | 3,120,071     16,776    130,855 | 3,267,702 
         1 |    10,968        363        480 |    11,811 
         2 |    15,023        380      2,405 |    17,808 
-----------+---------------------------------+----------
     Total | 3,146,062     17,519    133,740 | 3,297,321
	 

NEW NUMBER	 
	 
prediabets |
 diagnosis |
>=2 fields |
 | 1 field |
         + |
(metformin | diabetes diagn >=2 fields | ADM
 no PCOS | | | 1 field + (metformin no PCOS |
      path |         path result dia
result pre |         0          1          2 |     Total
-----------+---------------------------------+----------
         0 | 3,082,113     16,776     40,365 | 3,139,254 
         1 |    10,960        363        488 |    11,811 
         2 |    13,053        380    129,731 |   143,164 
-----------+---------------------------------+----------
     Total | 3,106,126     17,519    170,584 | 3,294,229 
*/


*** ASSUMING THE EVOLUTION IS FROM PREDIABETES TO DIABETES OVER TIME, RECODING ANY PREDIABETES=1/2 TO "0" IF THEY HAVE DIABETES=2
recode prediab_diag_all 1/2=0 if diab_diag_all==2
*(prediab_diag_all: 130219 changes made)


*** ANYBODY WITH ONLY ONE FIELD FOR DIABETES, BUT ONE OR TWO FIELDS FOR PREDIABETES, ASSUMED TO BE PREDIABETES*
recode prediab_diag_all 1=2 if diab_diag_all==1
*363 changes made
recode diab_diag_all 1=0 if prediab_diag_all==2
*743-363 = 380 changes made

recode prediab_diag_all 1=0 2=1
recode diab_diag_all 1=0 2=1

* recoding prediabetes and diabetes to "0" if they have gestational diabetes
recode prediab_diag_all 1=0 if gestdiab_diag_all==1
* (prediab_diag_all: 88 changes made)
recode diab_diag_all 1=0 if gestdiab_diag_all==1
* (diab_diag_all: 513 changes made)


*****I have limited the definition of GDM in females aged <=60 years 
***** COMBINING PREDIABETES AND DIABETES IN ONE VARIABLE - ANOTHER CATEGORY FOR GESTATIONAL DIABETES
***** codes are
* 0 = no diabetes (tested glucose at least once and was negative), 1=diabetes, 2=prediabetes, 3=gestational diabetes, 4=undiagnosed diabetes - two positive results but no diabetes diagnosis, 5=undiagnosed prediabetes - two positive results but no prediabetes diagnosis, 6 = no tested in 3 years 7 = only one test, positive but no second test or diagnosis
gen byte diab_alltypes = diab_diag_all
recode diab_alltypes 0=2 if prediab_diag_all==1
recode diab_alltypes 0=3 if gestdiab_diag_all==1
recode diab_alltypes 0=4 if como_diabPATH_day==1
recode diab_alltypes 0=5 if como_prediabPATH_day==1
recode diab_alltypes 0=6 if glucose_checked==0 | glucose_checked==.
recode diab_alltypes 0=7 if glucose_checked==1 & (diab_foundPATH==1 | prediab_foundPATH==1)

lab def diab_alltypes 0"tested at least once, no diab" 1"diabetes" 2"prediabetes" 3"gest diab" 4"undiagnosed diabetes" 5"undiagnosed prediabetes" 6"no tested in 3 years" 7"1 test positive, no second test", replace 
lab val diab_alltypes diab_alltypes
lab var diab_alltypes "diabetes all types considering all possibilities and datasets"

tab diab_alltypes

/*
 diabetes all types considering |
 all possibilities and datasets |      Freq.     Percent        Cum.
--------------------------------+-----------------------------------
  tested at least once, no diab |    396,367       12.03       12.03
                       diabetes |    170,071        5.16       17.19
                    prediabetes |     13,708        0.42       17.61
                      gest diab |      3,689        0.11       17.72
           undiagnosed diabetes |      1,446        0.04       17.77
        undiagnosed prediabetes |      4,133        0.13       17.89
           no tested in 3 years |  2,699,726       81.95       99.85
1 test positive, no second test |      5,089        0.15      100.00
--------------------------------+-----------------------------------
                          Total |  3,294,229      100.00
*/

save "diabetes_full_patients_2016_2018.dta", replace


*The above code has been checked by David*


***************************************
***************************************
***6. MERGE WITH COMOBIDITIES DO FILE**
***************************************
***************************************

use "Y:\MINGYUE\Full_for_analysis_2010_2018_long_patientyear.dta", clear
keep if year==2016 | year==2017 | year==2018
*(7,681,281 observations deleted)

*I should use the como_ever OR I should collapse before I exclude the year of 2016-2018. HOWEVER, I did use como_xx_ever because I don't have access to the year before 2015. 
*The reason we did not use como_xx-ever: I can only access the dataset during 2016-2018, and can not know the history of diabetes and its comorbidities*
*como_xx_ever means the patient has a diagnosis of a como from 2011 to 2018. If I want to do a cohort study, I need to consider the year of como diagnosis.

collapse (first) practiceid (max) cons_year consulted como_ihd como_heart como_fibril como_stroke como_copd como_lung como_pcos como_dyslip como_ckd como_hpt como_diab como_osa como_anx como_dep como_cancer como_osteoporosis como_arthritis como_ihd_ever como_heart_ever como_fibril_ever como_stroke_ever como_copd_ever como_lung_ever como_pcos_ever como_dyslip_ever como_ckd_ever como_hpt_ever como_diab_ever como_osa_ever como_anx_ever como_dep_ever como_cancer_ever como_osteoporosis_ever como_arthritis_ever, by(patientid)

lab variable cons_year "Times of consultaions in that year"
lab variable cons_year cons_year


*Record # of comorbidities for cross-check before analysis using DGP comorbidity do file 
tab como_fibril //  40,527
tab como_heart //   21,583 
tab como_ihd //   56,716 
tab como_stroke //    23,795 
tab como_copd //   48,111
tab como_arthritis //     227,959
tab como_dep //    289,669  
tab como_anx //    274,507
tab como_osa //    33,371 
tab como_cancer //      103,445 
tab como_dyslip //    201,435
tab como_hpt //   323,741  
tab como_ckd //      23,238  


*Record # of comorbidities_ever for cross-check before analysis using DGP comorbidity do file 
tab como_fibril_ever //  58,820 
tab como_heart_ever //   30,238 
tab como_ihd_ever //   93,520  
tab como_stroke_ever //   43,683 
tab como_copd_ever //   66,213 
tab como_arthritis_ever //  359,620  
tab como_dep_ever //   421,515
tab como_anx_ever //   380,448 
tab como_osa_ever //    59,208 
tab como_cancer_ever //     173,378    
tab como_dyslip_ever //  330,567  
tab como_hpt_ever //    455,754
tab como_ckd_ever //     34,436  


merge m:1 patientid using "Y:\MINGYUE\diabetes_full_patients_2016_2018.dta"
 /*
    Result                           # of obs.
    -----------------------------------------
    not matched                         4,938
        from master                     3,307  (_merge==1)
        from using                      1,631  (_merge==2)

    matched                         3,292,602  (_merge==3)
    -----------------------------------------
*/

drop if _merge==1
*(3,307 observations deleted)
drop _merge

label data "merged diabetes_full_patients with 13 comobidities (2016-18)"  

*****************************************
**generate/group some variables for analysis**
*****************************************

**Generate a new variable to only have 3 categories for patient remoteness area**
gen byte remote3g = .
replace remote3g =0 if remote==0
replace remote3g =1 if remote==1
replace remote3g =2 if remote==2 | remote==3 | remote==4

lab var remote3g "Remoteness area (3 groups)"
lab def remote3g 0"Major Cities" 1"Inner regional" 2"Outer regional/Remote", replace
lab val remote3g remote3g

******************
*Patients age>=18*
******************

**Generate a new variable to categorise age into 8 age groups among people>=18** 
gen age_cat18 = .
replace age_cat18 = 1 if age2018>=18 & age2018<=29
replace age_cat18 = 2 if age2018>=30 & age2018<=39
replace age_cat18 = 3 if age2018>=40 & age2018<=49
replace age_cat18 = 4 if age2018>=50 & age2018<=59
replace age_cat18 = 5 if age2018>=60 & age2018<=69
replace age_cat18 = 6 if age2018>=70 & age2018<=79
replace age_cat18 = 7 if age2018>=80 & age2018<=89
replace age_cat18 = 8 if age2018>90  & age2018<.
label var age_cat18 "Age categories (age>=18, 8 age groups)"
label define age_cat18 1 "18-29" 2 "30-39" 3 "40-49" 4 "50-59" 5 "60-69" 6 "70-79" 7 "80-89" 8 "90+", replace
label value age_cat18 age_cat18

/*
**Generate a new variable to categorise age into 5 year bands among people >=40** 
gen age_cat18_5yrs = .
replace age_cat18_5yrs = 1 if age2018 >=18 & age2018<=24
replace age_cat18_5yrs = 2 if age2018 >=25 & age2018<=29
replace age_cat18_5yrs = 3 if age2018 >=30 & age2018<=34
replace age_cat18_5yrs = 4 if age2018 >=35 & age2018<=39
replace age_cat18_5yrs = 5 if age2018 >=40 & age2018<=44
replace age_cat18_5yrs = 6 if age2018 >=45 & age2018<=49
replace age_cat18_5yrs = 7 if age2018 >=50 & age2018<=54
replace age_cat18_5yrs = 8 if age2018 >=55 & age2018<=59
replace age_cat18_5yrs = 9 if age2018 >=60 & age2018<=64
replace age_cat18_5yrs = 10 if age2018 >=65 & age2018<=69
replace age_cat18_5yrs = 11 if age2018 >=70 & age2018<=74
replace age_cat18_5yrs = 12 if age2018 >=75 & age2018<=79
replace age_cat18_5yrs = 13 if age2018 >=80 & age2018<=84
replace age_cat18_5yrs = 14 if age2018 >=85 & age2018<=89
replace age_cat18_5yrs = 15 if age2018 >=90 & age2018<=94
replace age_cat18_5yrs = 16 if age2018 >=95 & age2018<=99
replace age_cat18_5yrs = 17 if age2018 >=100

label var age_cat18_5yrs "Age categories (5yrs) for age>=40"
label define age_cat18_5yrs 1 "18-24" 2 "25-29" 3 "30-34" 4 "35-39" ///
5 "40-44" 6 "45-49" 7 "50-54" 8 "55-59" 9 "60-64" ///
10 "65-69" 11 "70-74" 12 "75-79" 13 "80-84" 14 "85-89" 15 "90-94" 16 "95-99" 17 ">=100", replace
label value age_cat18_5yrs age_cat18_5yrs
*/

******************
*Patients age>=40*
******************
**Generate a new variable to categorise age into 6 age groups among people >=40** 
gen age_cat40 = .
replace age_cat40 = 1 if age2018>=40 & age2018<=49
replace age_cat40 = 2 if age2018>=50 & age2018<=59
replace age_cat40 = 3 if age2018>=60 & age2018<=69
replace age_cat40 = 4 if age2018>=70 & age2018<=79
replace age_cat40 = 5 if age2018>=80 & age2018<=89
replace age_cat40 = 6 if age2018>90  & age2018<.
label var age_cat40 "Age categories (age>=40, 6 age groups)"
label define age_cat40 1 "40-49" 2 "50-59" 3 "60-69" 4 "70-79" 5 "80-89" 6 "90+", replace
label value age_cat40 age_cat40

**Generate a new variable to categorise age into 5 year bands among people >=40** 
gen age_cat40_5yrs = .
replace age_cat40_5yrs = 1 if age2018 >=40 & age2018<=44
replace age_cat40_5yrs = 2 if age2018 >=45 & age2018<=49
replace age_cat40_5yrs = 3 if age2018 >=50 & age2018<=54
replace age_cat40_5yrs = 4 if age2018 >=55 & age2018<=59
replace age_cat40_5yrs = 5 if age2018 >=60 & age2018<=64
replace age_cat40_5yrs = 6 if age2018 >=65 & age2018<=69
replace age_cat40_5yrs = 7 if age2018 >=70 & age2018<=74
replace age_cat40_5yrs = 8 if age2018 >=75 & age2018<=79
replace age_cat40_5yrs = 9 if age2018 >=80 & age2018<=84
replace age_cat40_5yrs = 10 if age2018 >=85 & age2018<=89
replace age_cat40_5yrs = 11 if age2018 >=90 & age2018<=94
replace age_cat40_5yrs = 12 if age2018 >=95 & age2018<=99
replace age_cat40_5yrs = 13 if age2018 >=100

label var age_cat40_5yrs "Age categories (5yrs) for age>=40"
label define age_cat40_5yrs 1 "40-44" 2 "45-49" 3 "50-54" 4 "55-59" 5 "60-64" ///
6 "65-69" 7 "70-74" 8 "75-79" 9 "80-84" 10 "85-89" 11 "90-94" 12 "95-99" 13 ">=100"
label value age_cat40_5yrs age_cat40_5yrs

save "diabetes_full_patients_mergecomo_2016_2018.dta", replace 




*****************************
*****************************
***7. FIND HIGH RISK GROUP***
*****************************
*****************************
*SECONDARY OUTCOME OF PAPER1 IS THE % OF SCREENNING, SAMPLE: THOSE WITH NO DIABETES


/*
*For HIGH RISK people, they should test fasting glucose or HBA1C every three year*
1. >=40 years of age and being overweight or obese 
2. AUSDRISK score of 12 or more X

3. Consider SCREENING the following groups (because they may be at increased risk for diabetes at an earlier age or lower BMI)
-first-degreee relative with diabetes X 
-high-risk race/ethnicity (Indian subcontient or Pacific islanders) (using aborig)
-all people with previous cardiovascular event (eg acute myocardial infarction or stroke) (2016-2018)
-females with a history with GDM (2016-2018)
-females with PCOS (2016-2018)
-patients on antipsychotic drugs (2018 only)

4. Those with IGT or IFG (not limited by age) should test their FGB or HBA1C every 12 months
*/

*NOTE: Can I use the ischemic heart disease code instead of acute myocardial infarction?
*Acute myocardial infarction: the first manifestation of ischemic heart disease and relation to risk factors

*************
*************
***AUDRISK***
*************
*************

**********************************************************************
**CALCULATE AUDRISK SCORE BASED ON AVALIABLE DATA IN MEDICINEINSIGHT**
**********************************************************************
*reference: The Australian Type 2 Diabetes Risk Assessment Tool (AUSDRISK)


*********************
**OBESE/OVERWEIGHT*** Diagnosis, Reason for Encounter and Reason for Prescription datasets
*********************
*In 2017–18, an estimated 2 in 3 (67%) Australians aged 18 and over were overweight or obese (36% were overweight but not obese, and 31% were obese).
*https://www.aihw.gov.au/reports/australias-health/overweight-and-obesity

*******************
*Diagnosis dataset*
use "Y:\MINGYUE\DIAB\emi_diab_diagnosis_clean.dta", clear

gen byte como_obese=1 if (strpos(reason,"OBES") | strpos(reason,"ADIPOSITY") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"CLINIC"))) | (strpos(reason,"WEIGHT") & (strpos(reason,"MANAGE"))) | strpos(reason,"WT MANAGE") ///
| (strpos(reason,"INCREAS") & (strpos(reason,"BMI"))) | (strpos(reason,"HIGH") & (strpos(reason,"BMI"))) | strpos(reason, "RAISED BMI") ///
| strpos(reason, "ELEVATED BMI") | (strpos(reason,"MORBID") & (strpos(reason,"BMI")))  ///
| strpos(reason,"OVERWEIGHT") | strpos(reason,"OVER WEIGHT") | strpos(reason,"OVER WT") | strpos(reason,"OVERWT") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"EXCESS")))  ///
| strpos(reason,"WEIGHT LOSS PROGRAM") | strpos(reason,"WEIGHT REDUCTION PROGRAM") | strpos(reason,"WEIGHT LOSS PLAN") /// 
| strpos(reason,"WEIGHT LOSS SURGERY") | strpos(reason,"WEIGHT LOSS PRESCRIPTION") | strpos(reason,"WEIGHT REDUCING AGENTS") ///
| strpos(reason,"BARIATRIC SURGERY") | strpos(reason,"SLEEVE GASTRECTOMY")) 

 
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***(Mother has a space after the word because there is the option chemotherapy)
recode como_obese 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX") ///
| strpos(reason,"GRANDPA ") | strpos(reason,"PARENT") | strpos(reason,"MOTHER ") | strpos(reason,"MUM")|strpos(reason,"MATERNAL") ///
| strpos(reason,"FATHER") |strpos(reason,"DAD") | strpos(reason,"PATERNAL")| strpos(reason,"HUSBAND") | strpos(reason,"WIFE") ///
| strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") | strpos(reason,"PARTNER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_obese 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR")| ///
 strpos(reason,"POSSIBL")| strpos(reason,"PREVENT")| strpos(reason,"PROPHYL")| strpos(reason,"RISK")| strpos(reason,"RULED OUT")| strpos(reason,"RULE OUT")| ///
strpos(reason,"SUSPECT")| strpos(reason,"SCREEN")| strpos(reason,"TEST") | strpos(reason,"WANT")| strpos(reason,"WORR")

recode como_obese .=0
lab var como_obese "Comorbidity-Obese/Overweight"
lab def como_obese 0"No" 1"Yes", replace
lab val como_obese  como_obese  

tab como_obese // 63,324
collapse (first) practiceid (max) como_obese, by(patientid)
tab como_obese // 45,333      

save "Y:\MINGYUE\DIAB\emi_obses_diagnosis.dta", replace


******************************
*Reason for Encounter dataser*
use "Y:\MINGYUE\DIAB\emi_diab_encounter_clean.dta", clear

gen byte como_obese=1 if (strpos(reason,"OBES") | strpos(reason,"ADIPOSITY") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"CLINIC"))) | (strpos(reason,"WEIGHT") & (strpos(reason,"MANAGE"))) | strpos(reason,"WT MANAGE") ///
| (strpos(reason,"INCREAS") & (strpos(reason,"BMI"))) | (strpos(reason,"HIGH") & (strpos(reason,"BMI"))) | strpos(reason, "RAISED BMI") ///
| strpos(reason, "ELEVATED BMI") | (strpos(reason,"MORBID") & (strpos(reason,"BMI")))  ///
| strpos(reason,"OVERWEIGHT") | strpos(reason,"OVER WEIGHT") | strpos(reason,"OVER WT") | strpos(reason,"OVERWT") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"EXCESS")))  ///
| strpos(reason,"WEIGHT LOSS PROGRAM") | strpos(reason,"WEIGHT REDUCTION PROGRAM") | strpos(reason,"WEIGHT LOSS PLAN") /// 
| strpos(reason,"WEIGHT LOSS SURGERY") | strpos(reason,"WEIGHT LOSS PRESCRIPTION") | strpos(reason,"WEIGHT REDUCING AGENTS") ///
| strpos(reason,"BARIATRIC SURGERY") | strpos(reason,"SLEEVE GASTRECTOMY")) 

 
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***(Mother has a space after the word because there is the option chemotherapy)
recode como_obese 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX") ///
| strpos(reason,"GRANDPA ") | strpos(reason,"PARENT") | strpos(reason,"MOTHER ") | strpos(reason,"MUM")|strpos(reason,"MATERNAL") ///
| strpos(reason,"FATHER") |strpos(reason,"DAD") | strpos(reason,"PATERNAL")| strpos(reason,"HUSBAND") | strpos(reason,"WIFE") ///
| strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") | strpos(reason,"PARTNER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_obese 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR")| ///
 strpos(reason,"POSSIBL")| strpos(reason,"PREVENT")| strpos(reason,"PROPHYL")| strpos(reason,"RISK")| strpos(reason,"RULED OUT")| strpos(reason,"RULE OUT")| ///
strpos(reason,"SUSPECT")| strpos(reason,"SCREEN")| strpos(reason,"TEST") | strpos(reason,"WANT")| strpos(reason,"WORR")

recode como_obese .=0
lab var como_obese "Comorbidity-Obese/Overweight"
lab def como_obese 0"No" 1"Yes", replace
lab val como_obese  como_obese  

tab como_obese // 125,073 
collapse (first) practiceid (max) como_obese, by(patientid)
tab como_obese //   71,262  

save "Y:\MINGYUE\DIAB\emi_obses_encounter.dta", replace

******************
*prescription_reason dataset*
use "Y:\MINGYUE\DIAB\emi_diab_prescrip_reason_clean.dta", clear  

gen byte como_obese=1 if (strpos(reason,"OBES") | strpos(reason,"ADIPOSITY") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"CLINIC"))) | (strpos(reason,"WEIGHT") & (strpos(reason,"MANAGE"))) | strpos(reason,"WT MANAGE") ///
| (strpos(reason,"INCREAS") & (strpos(reason,"BMI"))) | (strpos(reason,"HIGH") & (strpos(reason,"BMI"))) | strpos(reason, "RAISED BMI") ///
| strpos(reason, "ELEVATED BMI") | (strpos(reason,"MORBID") & (strpos(reason,"BMI")))  ///
| strpos(reason,"OVERWEIGHT") | strpos(reason,"OVER WEIGHT") | strpos(reason,"OVER WT") | strpos(reason,"OVERWT") ///
| (strpos(reason,"WEIGHT") & (strpos(reason,"EXCESS")))  ///
| strpos(reason,"WEIGHT LOSS PROGRAM") | strpos(reason,"WEIGHT REDUCTION PROGRAM") | strpos(reason,"WEIGHT LOSS PLAN") /// 
| strpos(reason,"WEIGHT LOSS SURGERY") | strpos(reason,"WEIGHT LOSS PRESCRIPTION") | strpos(reason,"WEIGHT REDUCING AGENTS") ///
| strpos(reason,"BARIATRIC SURGERY") | strpos(reason,"SLEEVE GASTRECTOMY")) 

 
***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC FAMILY HISTORY exclusion terms***(Mother has a space after the word because there is the option chemotherapy)
recode como_obese 1=0 if strpos(reason,"FAMIL") | strpos(reason,"FAM HIST")| strpos(reason,"FH ")| strpos(reason,"FHX") ///
| strpos(reason,"GRANDPA ") | strpos(reason,"PARENT") | strpos(reason,"MOTHER ") | strpos(reason,"MUM")|strpos(reason,"MATERNAL") ///
| strpos(reason,"FATHER") |strpos(reason,"DAD") | strpos(reason,"PATERNAL")| strpos(reason,"HUSBAND") | strpos(reason,"WIFE") ///
| strpos(reason,"SON ")| strpos(reason,"DAUGHTER") |strpos(reason,"BROTHER")| strpos(reason,"SISTER") | strpos(reason,"PARTNER") 

***Recode the variable from 1 to 0 if the variable (reason) contains one of the following GENERIC exclusion terms***
recode como_obese 1=0 if strpos(reason,"?") | strpos(reason,"CONCERN")| strpos(reason,"FEAR")| ///
 strpos(reason,"POSSIBL")| strpos(reason,"PREVENT")| strpos(reason,"PROPHYL")| strpos(reason,"RISK")| strpos(reason,"RULED OUT")| strpos(reason,"RULE OUT")| ///
strpos(reason,"SUSPECT")| strpos(reason,"SCREEN")| strpos(reason,"TEST") | strpos(reason,"WANT")| strpos(reason,"WORR")

recode como_obese .=0
lab var como_obese "Comorbidity-Obese/Overweight"
lab def como_obese 0"No" 1"Yes", replace
lab val como_obese  como_obese  

tab como_obese // 15,690
collapse (first) practiceid (max) como_obese, by(patientid)
tab como_obese //   11,762


save "Y:\MINGYUE\DIAB\emi_obses_prescrip_reason.dta", replace 




********************************
*merge_DEP for obese/overweight*

use "Y:\MINGYUE\DIAB\emi_obses_diagnosis.dta", clear
merge m:1 patientid using "Y:\MINGYUE\DIAB\emi_obses_encounter.dta"
drop _merge
merge m:1 patientid using "Y:\MINGYUE\DIAB\emi_obses_prescrip_reason.dta"
drop _merge
tab como_obese //   50,451

save "Y:\MINGYUE\DIAB\emi(diab)como_obese_patients_rsn.dta", replace 


****************************
**PBS N05A: ANTIPSYCHOTICS**
****************************
***IDENTIFY PATIENTS WERE PRESCRIBED ANTIPSYCHOTIC MEDICATIONS (ATC CODES N05A) VIA SCRIPT_ITEM DATASET****
***https://www.pbs.gov.au/browse/body-system?depth=3&codes=n05a#n05a

use "Script_item_2016_2018.dta", clear 

***** GENERATE MEDICATION LIST RATHER THAT IF TAKING ANY ANTIPSYCHOTIC EDICATION (based on PBS ATC code N05A) 
gen byte script_CHLORPROMAZINE=1 if strpos(medicine_active_ingredient,"CHLORPROMAZINE") 
gen byte script_PERICIAZINE=1 if strpos(medicine_active_ingredient,"PERICIAZINE") 
gen byte script_HALOPERIDOL=1 if strpos(medicine_active_ingredient,"HALOPERIDOL") 
gen byte script_LURASIDONE=1 if strpos(medicine_active_ingredient,"LURASIDONE") 
gen byte script_ZIPRASIDONE=1 if strpos(medicine_active_ingredient,"ZIPRASIDONE") 
gen byte script_FLUPENTIXOL=1 if strpos(medicine_active_ingredient,"FLUPENTIXOL") 
gen byte script_ZUCLOPENTHIXOL=1 if strpos(medicine_active_ingredient,"ZUCLOPENTHIXOL") 
gen byte script_ASENAPINE=1 if strpos(medicine_active_ingredient,"ASENAPINE") 
gen byte script_CLOZAPINE=1 if strpos(medicine_active_ingredient,"CLOZAPINE") 
gen byte script_OLANZAPINE=1 if strpos(medicine_active_ingredient,"OLANZAPINE") 
gen byte script_QUETIAPINE=1 if strpos(medicine_active_ingredient,"QUETIAPINE") 
gen byte script_AMISULPRIDE=1 if strpos(medicine_active_ingredient,"AMISULPRIDE") 
gen byte script_ARIPIPRAZOLE=1 if strpos(medicine_active_ingredient,"ARIPIPRAZOLE") 
gen byte script_BREXPIPRAZOLE=1 if strpos(medicine_active_ingredient,"BREXPIPRAZOLE") 
gen byte script_PALIPERIDONE=1 if strpos(medicine_active_ingredient,"PALIPERIDONE") 
gen byte script_RISPERIDONE=1 if strpos(medicine_active_ingredient,"RISPERIDONE") 


lab def script_psychotics 0"No" 1"Yes", replace
foreach var of varlist script_CHLORPROMAZINE script_PERICIAZINE script_HALOPERIDOL script_LURASIDONE script_ZIPRASIDONE script_FLUPENTIXOL script_ZUCLOPENTHIXOL script_ASENAPINE script_CLOZAPINE script_OLANZAPINE script_QUETIAPINE script_AMISULPRIDE script_ARIPIPRAZOLE script_BREXPIPRAZOLE script_PALIPERIDONE script_RISPERIDONE{
	recode `var' .=0
	lab val `var' script_psychotics
}

**Collapse by patientid and visit_date to have only one observation per day**
sort patientid script_date
collapse (first) practiceid (max) script_CHLORPROMAZINE script_PERICIAZINE script_HALOPERIDOL script_LURASIDONE script_ZIPRASIDONE script_FLUPENTIXOL script_ZUCLOPENTHIXOL script_ASENAPINE script_CLOZAPINE script_OLANZAPINE script_QUETIAPINE script_AMISULPRIDE script_ARIPIPRAZOLE script_BREXPIPRAZOLE script_PALIPERIDONE script_RISPERIDONE, by(patientid script_date)

egen byte script_psychotics = rowmax(script_CHLORPROMAZINE script_PERICIAZINE script_HALOPERIDOL script_LURASIDONE script_ZIPRASIDONE script_FLUPENTIXOL script_ZUCLOPENTHIXOL script_ASENAPINE script_CLOZAPINE script_OLANZAPINE script_QUETIAPINE script_AMISULPRIDE script_ARIPIPRAZOLE script_BREXPIPRAZOLE script_PALIPERIDONE script_RISPERIDONE)

lab val script_psychotics script_psychotics
lab var script_psychotics "received Script for antipsychotics"

rename script_date visit_date

label data "Patients with a script for antipsychotics"
save "DIAB\emi(diab)_script_item_for_antipsychotics_day.dta", replace 

********
use "DIAB\emi(diab)_script_item_for_antipsychotics_day.dta", clear

format %9.0g visit_date //need to explan the reason 
*tab visit_date if visit_date==21185 // 01 Jan 18 
recode script_psychotics 1=0 if visit_date<21185 //only consider prescription in 2018 (by 01 Jan 18)
tab script_psychotics //111,518

collapse (first) practiceid (max) script_CHLORPROMAZINE script_PERICIAZINE script_HALOPERIDOL script_LURASIDONE script_ZIPRASIDONE script_FLUPENTIXOL script_ZUCLOPENTHIXOL script_ASENAPINE script_CLOZAPINE script_OLANZAPINE script_QUETIAPINE script_AMISULPRIDE script_ARIPIPRAZOLE script_BREXPIPRAZOLE script_PALIPERIDONE script_RISPERIDONE script_psychotics, by (patientid)

label data "Patients with a script for antipsychotics in 2018 per patient"
save "DIAB\emi(diab)_script_item_for_antipsychotics_patients.dta", replace


*****************************
**PBS C02 ANTIHYPERTENSIVES**
*****************************
***IDENTIFY PATIENTS WERE PRESCRIBED ANTIHYPERTENSIVES (ATC CODES C01) VIA SCRIPT_ITEM DATASET****
***https://www.pbs.gov.au/browse/body-system?depth=2&codes=c02#c02

use "Script_item_2016_2018.dta", clear 

***Generate a new variable called diag_hpt and enter value 1 if the following terms appear in the reason variable (all medicines for HPT)*** 
gen byte hpt_script=1 if strpos(medicine_active_ingredient, "METHYLDOPA") | strpos(medicine_active_ingredient, "CLONIDINE") | ///
strpos(medicine_active_ingredient, "GUANFACINE") | strpos(medicine_active_ingredient, "MOXONIDINE") | strpos(medicine_active_ingredient, "PRAZOSIN") | ///
strpos(medicine_active_ingredient, "HYDRALAZINE") | strpos(medicine_active_ingredient, "MINOXIDIL") | strpos(medicine_active_ingredient, "AMBRISENTAN") | ///
strpos(medicine_active_ingredient, "BOSENTAN") | strpos(medicine_active_ingredient, "EPOPROSTENOL") | strpos(medicine_active_ingredient, "ILOPROST") | ///
strpos(medicine_active_ingredient, "MACITENTAN") | strpos(medicine_active_ingredient, "RIOCIGUAT") | strpos(medicine_active_ingredient, "SILDENAFIL") | ///
strpos(medicine_active_ingredient, "TADALAFIL") | strpos(medicine_active_ingredient, "HYDROCHLOROTHIAZIDE") | strpos(medicine_active_ingredient, "CHLORTALIDONE") | ///
strpos(medicine_active_ingredient, "INDAPAMIDE") | strpos(medicine_active_ingredient, "FUROSEMIDE") | strpos(medicine_active_ingredient, "FRUSEMIDE") | ///
strpos(medicine_active_ingredient, "ETACRYNIC ACID") | strpos(medicine_active_ingredient, "EPLERENONE") | strpos(medicine_active_ingredient, "SPIRONOLACTONE") | ///
strpos(medicine_active_ingredient, "TOLVAPTAN") | strpos(medicine_active_ingredient, "PHENOXYBENZAMINE") | strpos(medicine_active_ingredient, "OXPRENOLOL") | ///
strpos(medicine_active_ingredient, "PINDOLOL") | strpos(medicine_active_ingredient, "PROPRANOLOL") | strpos(medicine_active_ingredient, "ATENOLOL") | ///
strpos(medicine_active_ingredient, "BISOPROLOL") | strpos(medicine_active_ingredient, "METOPROLOL") | strpos(medicine_active_ingredient, "NEBIVOLOL") | /// 
strpos(medicine_active_ingredient, "CARVEDILOL") | strpos(medicine_active_ingredient, "LABETALOL") | strpos(medicine_active_ingredient, "AMLODIPINE") | ///
strpos(medicine_active_ingredient, "FELODIPINE") | strpos(medicine_active_ingredient, "LERCANIDIPINE") | strpos(medicine_active_ingredient, "NIFEDIPINE") | ///
strpos(medicine_active_ingredient, "VERAPAMIL") | strpos(medicine_active_ingredient, "DILTIAZEM") | strpos(medicine_active_ingredient, "CAPTOPRIL") |  ///
strpos(medicine_active_ingredient, "ENALAPRIL") | strpos(medicine_active_ingredient, "FOSINOPRIL") | strpos(medicine_active_ingredient, "LISINOPRIL") | ///
strpos(medicine_active_ingredient, "PERINDOPRIL") | strpos(medicine_active_ingredient, "QUINAPRIL") | strpos(medicine_active_ingredient, "RAMIPRIL") | /// 
strpos(medicine_active_ingredient, "TRANDOLAPRIL") | strpos(medicine_active_ingredient, "CANDESARTAN") | strpos(medicine_active_ingredient, "EPROSARTAN") | ///
strpos(medicine_active_ingredient, "IRBESARTAN") | strpos(medicine_active_ingredient, "LOSARTAN") | strpos(medicine_active_ingredient, "OLMESARTAN") | ///
strpos(medicine_active_ingredient, "TELMISARTAN") | strpos(medicine_active_ingredient, "VALSARTAN") 

recode hpt_script .=0
lab var hpt_script  "Script for AHT"
lab def hpt_script 0"No" 1"Yes", replace
lab val hpt_script hpt_script

**Collapse by patientid and visit_date to have only one observation per day**
order patientid script_date practiceid hpt_script
sort patientid script_date
collapse (first) practiceid (max) hpt_script, by(patientid script_date)
rename script_date visit_date

**Collapse by patientid and visit_date to have only one observation per patients**
collapse (first) practiceid (max) hpt_script, by(patientid)

tab hpt_script //633,334  

label data "Patients with a script for antihypertensives per patient"
save "DIAB\emi(diab)_script_item_for_antihpt_patients.dta", replace



*********************
****Calculate BMI****
*********************
**Due to weight and height being recorded in the incorrect fields, only BMI will be used**

use "Y:\MINGYUE\observation_bmi data.dta",clear

*reduce the size of dataset*
drop if year <=2015
drop if year >=2019
ta observation_name
/*

   Observation |
          name |      Freq.     Percent        Cum.
---------------+-----------------------------------
           BMI |  2,406,069       79.98       79.98
         WAIST |    538,775       17.91       97.89
           WHR |     38,802        1.29       99.18
       WHRATIO |     24,807        0.82      100.00
---------------+-----------------------------------
         Total |  3,008,453      100.00

*/
gen bmi=1 if strpos(observation_name,"BMI")
drop if bmi!=1
* 602,384 excluded
drop observation_name

**Generate a new variable to convert string to numbers**
gen bmi_value = real(observation_value)

**Note for the paper: BMI wrong data - 5124 cases
drop if bmi_value==.

**Collapse to get last BMI recording** 
collapse (first) practiceid (last) bmi_value observation_date , by(patientid)

**Delete people with extreme BMI, not compatible with adult life: 2,966 
drop if bmi_value<13 | bmi_value>91.999

rename observation_date bmi_date
lab var bmi_date "BMI Date"

gen year_bmi = year(bmi_date)
lab var year_bmi "Year of last BMI measure"
tab year_bmi

label data "Last BMI measurement"
save "Y:\MINGYUE\DIAB\emi(diab)_BMI.dta", replace


***************************************************************************
**IDENTIFY PATIENTS WITH A RECORD OF FBG OR HBA1C VIA PATHOLOGY DATASET****
***************************************************************************
cd"Y:/MINGYUE"
use "Pathology_corrected_2016_2018.dta", clear 
** For clinical variables: 0 No 1  Tested-no valid results 2 Tested-valid results 

*********
***FBG***fasting plasma glucose
*********
**Generate a new variable to indicate the number of fasting plasma glucose is tested**
gen byte fbgtested = glucose  
recode fbgtested 2=1 //combine tested-valid result with tested-invalid results and then consider they are tested glucose no matter if they are tested-invalid  
*(fbgtested: 1006238 changes made)
recode fbgtested 1=0 if gluc_fast_mmol_l ==.  //they are tested random glucose or ogtt, not recorded as fast glucose

lab var fbgtested "Have at least one test for FBG"
lab def fbgtested 0"NO" 1"YES", replace
lab val fbgtested fbgtested
tab fbgtested year

/*
 Tested at |
least once |               year
   for FBG |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
        NO |   652,023    765,818    794,823 | 2,212,664 
       YES |   104,188    118,292    127,810 |   350,290 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


***********
***HBA1C***
***********
**Generate a new variable to indicate prediabets if hba1c is elevated
gen byte hba1ctested = hba1c
recode hba1ctested 2=1 //combine tested-valid result with tested-invalid results = tested HBA1C 
*(hba1ctested: 377542 changes made)

lab var hba1ctested "Have at least one test for HBA1C"
lab def hba1ctested 0"NO" 1"YES", replace
lab val hba1ctested hba1ctested
tab hba1ctested year

/*
 Tested at |
least once |               year
 for HBA1C |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
        NO |   656,799    755,220    773,053 | 2,185,072 
       YES |    99,412    128,890    149,580 |   377,882 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


**********
***OGTT***
**********
**Generate a new variable to indicate the number of ogtt is tested**
gen byte ogtttested = glucose  
recode ogtttested 2=1 //combine tested-valid result with tested-invalid results = tested glucose 
*(fbgtested: 1006238 changes made)
recode ogtttested 1=0 if gluc_ogtt_mmol_l ==.  //they are tested random glucose or fasting glucose, not for ogtt
*(ogtttested: 963998 changes made)

lab var ogtttested "Have at least one test for OGTT"
lab def ogtttested 0"NO" 1"YES", replace
lab val ogtttested ogtttested
tab ogtttested year

/*

 Tested at |
least once |               year
  for OGTT |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
        NO |   738,029    865,153    908,807 | 2,511,989 
       YES |    18,182     18,957     13,826 |    50,965 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


***************
***RANDOM BG***
***************
**Generate a new variable to indicate the number of fasting plasma glucose is tested**
gen byte rbgtested = glucose  
recode rbgtested 2=1 //combine tested-valid result with tested-invalid results = tested glucose 
*(fbgtested: 1006238 changes made)
recode rbgtested 1=0 if gluc_random_mmol_l ==.  //they are tested fasting glucose or ogtt, not for random glucose
*(rbgtested: 378038 changes made)

lab var rbgtested "Have at least one test for RBG"
lab def rbgtested 0"NO" 1"YES", replace
lab val rbgtested rbgtested
tab rbgtested year

/*
 Tested at |
least once |               year
   for RBG |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
        NO |   577,766    666,575    681,688 | 1,926,029 
       YES |   178,445    217,535    240,945 |   636,925 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


**************************************
***FBG OR HBA1C TESTED IN 2016-2018***
**************************************
gen byte fbgorhba1c_tested =0
recode fbgorhba1c_tested 0=1 if (fbgtested==1 | hba1ctested==1) //have one record in 2016-2018
tab fbgorhba1c_tested year

/*
fbgorhba1c |               year
   _tested |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
         0 |   578,269    670,237    685,773 | 1,934,279 
         1 |   177,942    213,873    236,860 |   628,675 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


gen byte fbgorhba1c_tested2018 =0
recode fbgorhba1c_tested2018 0=1 if (fbgtested==1 | hba1ctested==1) & year==2018 //have at least one record of fbg or hba1c in 2018
tab fbgorhba1c_tested2018

gen byte fbgorhba1c_tested2017 =0
recode fbgorhba1c_tested2017 0=1 if (fbgtested==1 | hba1ctested==1) & year==2017 //have at least one record of fbg or hba1c in 2017
tab fbgorhba1c_tested2017 

gen byte fbgorhba1c_tested2016 =0
recode fbgorhba1c_tested2016 0=1 if (fbgtested==1 | hba1ctested==1) & year==2016 //have at least one record of fbg or hba1c in 2016
tab fbgorhba1c_tested2016 year

gen byte fbgorhba1c_tested3yrs =0
recode fbgorhba1c_tested3yrs 0=1 if fbgorhba1c_tested2016==1| fbgorhba1c_tested2017==1 | fbgorhba1c_tested2018==1 //have one record in 2016-2018
tab fbgorhba1c_tested3yrs year

/*
fbgorhba1c |
_tested3yr |               year
         s |      2016       2017       2018 |     Total
-----------+---------------------------------+----------
         0 |   578,269    670,237    685,773 | 1,934,279 
         1 |   177,942    213,873    236,860 |   628,675 
-----------+---------------------------------+----------
     Total |   756,211    884,110    922,633 | 2,562,954 
*/


**** Counting in each variables for the number of visits and number of times a bg test result was found

collapse (first) practiceid (sum) tested_fbg = fbgtested tested_hba1c = hba1ctested tested_fbgorhba1c = fbgorhba1c_tested tested_fbgorhba1c2018 = fbgorhba1c_tested2018 tested_fbgorhba1c2017 = fbgorhba1c_tested2017 tested_fbgorhba1c2016 = fbgorhba1c_tested2016 tested_ogtt = ogtttested tested_rbg = rbgtested  (max) year, by(patientid) 
rename year bgtested_year


lab var tested_fbg "times of tested fasting blood glucose in 2016-18"
lab var tested_hba1c "times of tested hba1c in 2016-18"
lab var tested_ogtt "times of tested ogtt in 2016-18"
lab var tested_rbg "times of tested random blood glucose in 2016-18"
lab var tested_fbgorhba1c "times of either tested fasting blood glucose or hba1c in 2016-18"
lab var tested_fbgorhba1c2018 "times of either tested fasting blood glucose or hba1c in 2018"
lab var tested_fbgorhba1c2017 "times of either tested fasting blood glucose or hba1c in 2017"
lab var tested_fbgorhba1c2016 "times of either tested fasting blood glucose or hba1c in 2016"
lab var bgtested_year "blood glucose checked in that year"


save "DIAB\emi(diab)_path_checked_BG_patients.dta", replace



***************************************************************************
**merge obese, antipsychotics, antihpt datasets with full patient dataset**
***************************************************************************
cd "Y:\MINGYUE"
use "diabetes_full_patients_mergecomo_2016_2018.dta", clear 
merge m:1 patientid using "Y:\MINGYUE\DIAB\emi(diab)_script_item_for_antipsychotics_patients.dta"
   
/*
   -----------------------------------------
    not matched                       569,965
        from master                   569,965  (_merge==1)
        from using                          0  (_merge==2)

    matched                         2,724,268  (_merge==3)
    -----------------------------------------
*/
drop _merge 

merge m:1 patientid using "Y:\MINGYUE\DIAB\emi(diab)_script_item_for_antihpt_patients.dta"
/*
    -----------------------------------------
    not matched                       569,965
        from master                   569,965  (_merge==1)
        from using                          0  (_merge==2)

    matched                         2,724,268  (_merge==3)
    -----------------------------------------
*/
drop _merge 

merge m:1 patientid using "Y:\MINGYUE\DIAB\emi(diab)como_obese_patients_rsn.dta"
/*
    Result                           # of obs.
    -----------------------------------------
    not matched                        10,233
        from master                    10,233  (_merge==1)
        from using                          0  (_merge==2)

    matched                         3,284,000  (_merge==3)
    -----------------------------------------
*/
drop _merge 


merge m:1 patientid using "Y:\MINGYUE\DIAB\emi(diab)_BMI.dta"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                     2,240,936
        from master                 2,232,639  (_merge==1)
        from using                      8,297  (_merge==2)

    matched                         1,061,594  (_merge==3)
    -----------------------------------------
*/

drop if _merge==2 //(8,297 observations deleted)
drop _merge

**********************************
**Identify and plus OBESE by BMI**

recode como_obese 0=1 if (BMI>=25.0 & BMI <=92)
*The possible maximum BIM: 165cm (average height), <200kg, BMI 91.8

*In 2017–18, an estimated 2 in 3 (67%) Australians aged 18 and over were overweight or obese (36% were overweight but not obese, and 31% were obese).
*https://www.aihw.gov.au/reports/australias-health/overweight-and-obesity

tab como_obese
/*

      (max) |
 como_obese |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  2,649,438       80.68       80.68
          1 |    634,562       19.32      100.00
------------+-----------------------------------
      Total |  3,284,000      100.00
*/


merge m:1 patientid using "DIAB\emi(diab)_path_checked_BG_patients.dta"

/*
    Result                           # of obs.
    -----------------------------------------
    not matched                     2,697,186
        from master                 2,694,094  (_merge==1)
        from using                      3,092  (_merge==2)

    matched                           600,139  (_merge==3)
    -----------------------------------------
*/
drop if _merge==2 //(3,092 observations deleted)
drop _merge


save "diabetes_full_patients_mergecomo_2016_2018.dta", replace 




************************
***CALCULATE AUSDRISK***  
************************
*************
*AUSDRISKAGE*
/*
1. Your age group
Under 35 years  0 points
35 – 44 years  2 points
45 – 54 years  4 points
55 – 64 years  6 points
65 years or over  8 points
*/

cd"Y:/MINGYUE"
use "diabetes_full_patients_mergecomo_2016_2018.dta", clear
drop ausdrisk_age ausdrisk_gender ausdrisk_aborig ausdrisk_hbg ausdrisk_hptmed ausdrisk_smoke ausdrisk_points ausdrisk_points_6cat

**Generate a new variable to categorise age into 5 year bands** 
gen ausdrisk_age = .
replace ausdrisk_age = 0 if age2018 >=0 & age2018<=34 //0 points
replace ausdrisk_age = 2 if age2018 >=35 & age2018<=44 //2 points
replace ausdrisk_age = 4 if age2018 >=45 & age2018<=54 //4 points
replace ausdrisk_age = 6 if age2018 >=55 & age2018<=64 //6 points
replace ausdrisk_age = 8 if age2018 >=65 & age2018<=109 //8 points
label var ausdrisk_age "Age categories for AUSDRISK" 
tab ausdrisk_age, m

****************
*AUSDRISKGENDER*
/*
Your gender
Female  0 points
Male  3 points
*/
gen ausdrisk_gender = gender2 //0 male, 1 female 
recode ausdrisk_gender 0=3 //male gets 3 points 
recode ausdrisk_gender 1=0 //female gets 0 points
tab ausdrisk_gender, m


*******************
*AUSDRISKETHNICITY*
/*
3a. Are you of Aboriginal, Torres Strait Islander,
No  0 points
Yes  2 points
*/
gen ausdrisk_aborig = aborig
recode ausdrisk_aborig 2=0 //non aborig gets 0 points 
recode ausdrisk_aborig 1=2 //aborig gets 2 points
tab ausdrisk_aborig, m


*************
*AUSDRISKHBG*
/*
5. Have you ever been found to have high blood glucose (sugar) (for example, in a health examination, during an illness, during pregnancy)?
No  0 points
Yes  6 points
*/
gen ausdrisk_hbg =.
replace ausdrisk_hbg =0 if (diab_foundPATH==0) | (prediab_foundPATH==0)  //No pathology record with hbg in 2016-2018
replace ausdrisk_hbg =6 if (diab_foundPATH>=1 & diab_foundPATH<.) | (prediab_foundPATH >=1 & prediab_foundPATH <.)  //At least one record with hbg
tab ausdrisk_hbg, m


****************
*AUSDRISKHPTMED*
/*
6. Are you currently taking medication for high blood pressure?
No  0 points
Yes  2 points
*/
gen ausdrisk_hptmed = hpt_script
recode ausdrisk_hptmed 0=0 //no prescription for hpt gets 0 points 
recode ausdrisk_hptmed 1=2 //prescription for hpt gets 2 points
tab ausdrisk_hptmed, m


***************
*AUSDRISKSMOKE*
/*
Do you currently smoke cigarettes or any other
tobacco products on a daily basis?
No  0 points
Yes  2 points
*/
* 0  Non smoker 1  Smoker 2  Ex smoker 3  Not stated/not recorded
gen ausdrisk_smoke = smoke
recode ausdrisk_smoke 2=0 //not daily smoker get 0 points 
recode ausdrisk_smoke 3=0 //not daily smoker get 0 points 
recode ausdrisk_smoke 1=2 //consider as daily smoker so get 2 points 
tab ausdrisk_smoke, m


**************************
*CALCULATE AUDRISK POINTS* 
drop total_points 
egen total_points = rowtotal(ausdrisk_age ausdrisk_gender ausdrisk_aborig ausdrisk_hbg ausdrisk_hptmed ausdrisk_smoke)
*rowtotal(varlist) [, missing] may not be combined with by.  
*It creates the (row) sum of the variables in varlist, treating missing as 0.  
*If missing is specified and all values in varlist are missing for an observation, newvar is set to missing.

gen ausdrisk_points = .
replace ausdrisk_points = 1 if total_points <=5
replace ausdrisk_points = 2 if total_points >=6 & total_points<=11
replace ausdrisk_points = 3 if total_points >=12 & total_points<.

label var ausdrisk_points "AUDRISK TOTAL POINTS"
label define ausdrisk_points 1 "Low risk" 2 "Intermediate risk" 3 "High risk", replace
label value ausdrisk_points ausdrisk_points

tab ausdrisk_points
/*
    AUDRISK TOTAL |
           POINTS |      Freq.     Percent        Cum.
------------------+-----------------------------------
         Low risk |  1,966,793       59.70       59.70
Intermediate risk |  1,079,895       32.78       92.49
        High risk |    247,545        7.51      100.00
------------------+-----------------------------------
            Total |  3,294,233      100.00
*/


***************************
gen ausdrisk_points_6cat = .
replace ausdrisk_points_6cat = 1 if total_points <=5
replace ausdrisk_points_6cat = 2 if total_points >=6 & total_points<=8
replace ausdrisk_points_6cat = 3 if total_points >=9 & total_points<=11
replace ausdrisk_points_6cat = 4 if total_points >=12 & total_points<=15
replace ausdrisk_points_6cat = 5 if total_points >=16 & total_points<=19
replace ausdrisk_points_6cat = 6 if total_points >=20 & total_points<.

label var ausdrisk_points_6cat "AUDRISK TOTAL POINTS BY SIX CATEGORIES"
label define ausdrisk_points_6cat 1 "1/100 will develop diab within 5yrs" ///
2 "1/50 will develop diab within 5yrs" 3 "1/30 will develop diab within 5yrs" ///
4 "1/14 will develop diab within 5yrs" 5 "1/7 will develop diab within 5yrs" 6 "1/3 will develop diab within 5yrs" , replace 
label value ausdrisk_points_6cat ausdrisk_points_6cat

tab ausdrisk_points_6cat
/*
        AUDRISK TOTAL POINTS BY SIX |
                         CATEGORIES |      Freq.     Percent        Cum.
------------------------------------+-----------------------------------
1/100 will develop diab within 5yrs |  1,966,793       59.70       59.70
 1/50 will develop diab within 5yrs |    572,964       17.39       77.10
 1/30 will develop diab within 5yrs |    506,931       15.39       92.49
 1/14 will develop diab within 5yrs |    200,772        6.09       98.58
  1/7 will develop diab within 5yrs |     45,256        1.37       99.95
  1/3 will develop diab within 5yrs |      1,517        0.05      100.00
------------------------------------+-----------------------------------
                              Total |  3,294,233      100.00
*/



*********************
***HIGH RISK GROUP***SHOULD CHECK FBG OR HBA1C EVERY THREE YEARS
*********************
/*
3. Consider SCREENING FBG OR HBA1C EVERY THREE YEARS in the following groups (because they may be at increased risk for diabetes at an earlier age or lower BMI)
-high-risk race/ethnicity (Indian subcontient or Pacific islanders) (using aborig) 0=NO, 1=YES, 2=Ignored 
-all people with previous cardiovascular event (eg acute myocardial infarction or stroke) (2016-2018)  
-females with a history with GDM (2016-2018)
-females with PCOS (2016-2018)
-patients on antipsychotic drugs (2018 only)
*/

drop risk_aborig risk_cvd risk_gdm risk_pcos risk_psychotics risk_obese40 risk_prediab
**************************
*high-risk race/ethnicity*
gen byte risk_aborig = aborig
recode risk_aborig 2=0
tab risk_aborig

/*
risk_aborig |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,212,287       97.51       97.51
          1 |     81,946        2.49      100.00
------------+-----------------------------------
      Total |  3,294,233      100.00
	
	1 = Aboriginal and Torres Strait Islander people   
*/


**************************************************************************************************
*People with previous cardiovascular event (eg acute myocardial infarction or stroke) (2016-2018)*
gen byte risk_cvd =0
recode risk_cvd 0=1 if como_stroke==1 | como_ihd==1 //patients with CVD previous
tab risk_cvd
*What CVD events need to be included? I only included stroke and ischemic heart disease 

/*
gen byte como_ihd=1 if strpos(reason,"ANGINA") | (strpos(reason,"HEART") & (strpos(reason,"ATTAC"))) ///
| (strpos(reason,"ISCH") & (strpos(reason,"HEART"))) | (strpos(reason,"CORON") & (strpos(reason,"DISEASE"))) ///
| (strpos(reason,"CORON")  & (strpos(reason,"SYNDROME"))) | (strpos(reason,"COR") & (strpos(reason,"ART") & (strpos(reason,"DISEASE")))) ///
| (strpos(reason,"CORON") & (strpos(reason,"INSUF"))) | (strpos(reason,"COR") & (strpos(reason,"OCCLUSI"))) ///
| (strpos(reason,"COR") & (strpos(reason,"FAIL"))) | (strpos(reason,"ISCH") & (strpos(reason,"CARDIOMYOPATHY"))) ///
| (strpos(reason,"MYOCARD") & (strpos(reason,"INFARC"))) | (strpos(reason,"SUBENDOCARD")  & (strpos(reason,"INFARCT")))  ///
| (strpos(reason,"PREINFARCT")  & (strpos(reason,"SYNDROME"))) | (strpos(reason,"ISCH") & (strpos(reason,"CHEST") & (strpos(reason,"PAIN")))) ///
| (strpos(reason,"STENT")  & (strpos(reason,"CORON"))) | strpos(reason,"ANGIOPLASTY") | strpos(reason,"BYPASS")  | strpos(reason,"ENDARTERECTOMY") ///
| strpos(reason,"/IHD/")| reason=="ACS" | reason=="CABG"| reason=="CAD" |  reason=="AMI" |   reason=="MI" | reason=="IHD" | reason=="CHD"
*/

*********************************************
*females with a history with GDM (2016-2018)*
gen byte risk_gdm = gestdiab_diag_all
recode risk_gdm 1=0 if gestdiab_diag_all==1 & gender2==0 //misclassfication: males with gestational diabetes
*(risk_gdm: 5 changes made)
tab risk_gdm 
/*
   risk_gdm |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,290,544       99.89       99.89
          1 |      3,689        0.11      100.00
------------+-----------------------------------
      Total |  3,294,233      100.00
*/


*******************************
*females with PCOS (2016-2018)*
gen byte risk_pcos = pcos_diag_all
recode risk_pcos 1=0 if pcos_diag_all==1 & gender2==0 //misclassfication: males with PCOS
*(risk_pcos: 12 changes made)
tab risk_pcos
/*
  risk_pcos |      Freq.     Percent        Cum.
------------+-----------------------------------
          0 |  3,285,448       99.73       99.73
          1 |      8,785        0.27      100.00
------------+-----------------------------------
      Total |  3,294,233      100.00
*/


*********************************************
*patients on antipsychotic drugs (2018 only)*
gen byte risk_psychotics = script_psychotics //patients on antipsychotic drugs in 2018


********************
*Nutritional status* >=40 & obese/overweight
gen risk_obese40 =como_obese 
recode risk_obese40 1=0 if age2018<40
*(risk_obese40: 164108 changes made)



**************************
*4. Those with IGT or IFG* (not limited by age) should test their FGB or HBA1C every 12 months
*************************
gen byte risk_prediab = prediab_diag_all

lab val risk_aborig risk_gdm risk_cvd risk_pcos risk_psychotics risk_obese40 risk_prediab noyes


***************************************************************
***% of high-risk patients who screened fbg or hba1c in 2018***Study population: Adults & non-diabetes
***************************************************************

gen byte screened2018 =0
recode screened2018 0=1 if tested_fbgorhba1c2018>=1 & tested_fbgorhba1c2018<.

lab var screened2018 "FBG OR HBA1C CHECKED IN 2018"
lab def screened2018 0"NO" 1"YES", replace
lab val screened2018 screened2018
tab screened2018 

************
gen byte screened2017 =0
recode screened2017 0=1 if tested_fbgorhba1c2017>=1 & tested_fbgorhba1c2017<.

lab var screened2017 "FBG OR HBA1C CHECKED IN 2017"
lab def screened2017 0"NO" 1"YES", replace
lab val screened2017 screened2017
tab screened2017 

***********
gen byte screened2016 =0
recode screened2016 0=1 if tested_fbgorhba1c2016>=1 & tested_fbgorhba1c2016<.

lab var screened2016 "FBG OR HBA1C CHECKED IN 2017"
lab def screened2016 0"NO" 1"YES", replace
lab val screened2016 screened2016
tab screened2016 

************
gen byte screened2016_18 =0
recode screened2016_18 0=1 if tested_fbgorhba1c>=1 & tested_fbgorhba1c<.

lab var screened2016_18 "FBG OR HBA1C CHECKED IN 2016-2018"
lab def screened2016_18 0"NO" 1"YES", replace
lab val screened2016_18 screened2016_18
tab screened2016_18 

/*
     FBG OR |
      HBA1C |
 CHECKED IN |
  2016-2018 |      Freq.     Percent        Cum.
------------+-----------------------------------
         NO |  2,995,262       90.92       90.92
        YES |    298,971        9.08      100.00
------------+-----------------------------------
      Total |  3,294,233      100.00
*/

/*
*For HIGH RISK people, they should test fasting glucose or HBA1C every three year*
1. >=40 years of age and being overweight or obese 
2. AUSDRISK score of 12 or more 

3. Consider SCREENING the following groups (because they may be at increased risk for diabetes at an earlier age or lower BMI)
-first-degreee relative with diabetes X 
-high-risk race/ethnicity (Indian subcontient or Pacific islanders) (using aborig)
-all people with previous cardiovascular event (eg acute myocardial infarction or stroke) (2016-2018)
-females with a history with GDM (2016-2018)
-females with PCOS (2016-2018)
-patients on antipsychotic drugs (2018 only)

4. Those with IGT or IFG (not limited by age) should test their FGB or HBA1C every 12 months
*/
*note: here high risk group are those without a diagnosed diabetes 

save "diabetes_full_patients_mergecomo_audrisk_2016_2018.dta", replace  




