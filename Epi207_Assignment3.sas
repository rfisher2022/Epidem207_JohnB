/*******************************************************
	filename: Epi207_Assignment3
	author(s): Catherine Cortez, Rebecca Fischer, John Waggoner
	created on: 2/13/2022
	purpose: 
********************************************************/

/**********Data read-in **********************/

title 'Epi207_Assignment3';

/* 	CHANGE FILE NAME TO WHEREVER LOCAL FILE IS SAVED
	the download link to the actual data on PLOS is broken so 
	until that is fixed, will have to use local files */

libname asgn3 'C:\Users\John\Desktop\EPIDEM207-2022-winter\Assignment3';
filename johnetal 'C:\Users\John\Desktop\EPIDEM207-2022-winter\Assignment3\johnetal.xls';

proc import out=asgn3.johnetalunclean datafile= johnetal
			dbms = xls replace;
			getnames=no; /*no column headers in original dataset*/
run;

/*********** Proc Contents *********************/

proc contents data=asgn3.johnetalunclean;
run;	

/************ Data Cleaning ********************/
options fmtsearch=(asgn3);


/* 	Formats for all variables of interest. I figured since
	we might want to use other variables that I'd keep this 
	from Assignment 1, even though there might be extra var-
	-iables. We don't have to keep it like this though, and
	would be grateful for suggestions on better format labels
	or values - JOHN.   */

proc format library = asgn3;
	value 	sexbin		0	=	"Female"
						1	=	"Male";

	value	educat		1	=	"<=9 years"
						2	=	"10-11 years"
						3	=	">=12 years";

	value	yesno		0	=	"No"
						1	=	"Yes";

	value	hltcat		1	=	"Poor/Fair"
						2	=	"Good"
						3	=	"Excellent/Very Good";

	value	codcat		1	=	"Cardiovascular Disease"
						2	=	"Cancer"
						3	=	"Aerodigestive (?)"
						4	=	"Acute (?)"
						5	=	"Psychiatric (?)"
						6	=	"Other or Unknown"
						7	=	"No Cause Listed (?)";

	value	auditc		0	=	"Abstinent"
						1	=	"1-3"
						2	=	"4"
						3	=	"5"
						4	=	"6-7"
						5	=	"8-12";

	value	smkcat		0	=	"Never Smoker"
						1	=	"Ever Smoker Less than daily"
						2	=	"Former Smoker daily"
						3	=	"Current Smoker <=19 cig/day"
						4	=	"Current Smoker >19 cig/day";

	value	agecat		1	=	"17-39 years old"
						2	=	"40-49 years old"
						3	=	"50-64 years old";

	value	rskgrptwo	1	=	"Low to Moderate Alcohol (AUDIT-C 1-3)"
						2	=	"Moderate to high Alcohol (AUDIT-C 4)"
						3	=	"High Alcohol (AUDIT-C 5)"
						4	=	"Very High Alcohol (AUDIT-C 6-7)"
						5	=	"Extremely High Alcohol (AUDIT-C 8-12)"
						6	=	"Abstinent At Baseline, Good Health"
						7	=	"Abstinent At Baseline, History of Alcohol/Drug Dependence"
						8	=	"Abstinent At Baseline, History of Risk Drinking"
						9	=	"Abstinent At Baseline, Tried to Cut Down or Stop"
						10	=	"Abstinent At Baseline, Current Daily Smoker (>19 cig/day)"
						11	=	"Abstinent At Baseline, Current Daily Smoker (<=19 cig/day)"
						12	=	"Abstinent At Baseline, Former Smoker"
						13	=	"Abstinent At Baseline, Poor Health";

	value	rskgrpthr	1	=	"Low to Moderate Alcohol, Never Smoker"
						2	=	"Low to Moderate Alcohol, Former Daily Smoker"
						3	=	"Low to Moderate Alcohol, Current Smoker (<=19 cig/day)"
						4	=	"Low to Moderate Alcohol, Current SMoker (?19 cig/day)"
						5	=	"Moderate to High Alcohol, Never Smoker"
						6	=	"Moderate to High Alcohol, Former Daily Smoker"
						7	=	"Moderate to High Alcohol, Current Smoker (<=19 cig/day)"
						8	=	"Moderate to High Alcohol, Current Smoker (>19 cig/day)"
						9	=	"Very High Alcohol, Not Current Smoker"
						10	=	"Very High Alcohol, Current Smoker (<=19 cig/day)"
						11	=	"Very High Alcohol, Current Smoker (>19 cig/day)"
						12	=	"Extremely High Alcohol, Not Current Smoker"
						13	=	"Extremely High Alcohol, Current Smoker"
						14	=	"Absitnent at Baseline, Good Health"
						15	=	"Absitnent at Baseline, History of Alcohol/Drug Dependence"
						16	=	"Abstinent At Baseline, History of Risk Drinking"
						17	=	"Abstinent At Baseline, Tried to Cut Down or Stop"
						18	=	"Abstinent At Baseline, Current Daily Smoker (>19 cig/day)"
						19	=	"Abstinent At Baseline, Current Daily Smoker (<=19 cig/day)"
						20	=	"Abstinent At Baseline, Former Smoker"
						21	=	"Abstinent At Baseline, Poor Health";


	value	rskgrpfour	0	=	"Moderate to Heavy Drinking"
						1	=	"Low to Moderate Alcohol, Good Health, Never Smoker"
						2	=	"No Alcohol, Good Health, Never Smoker"
						3	=	"Low to Moderate Alcohol, Poor Health, Never Smoker"
						4	=	"No Alcohol, Poor Health, Never Smoker"
						5	=	"Low to Moderate Alcohol, Ever Smoker Less than daily"
						6	=	"No Alcohol, Ever Smoker Less than daily"
						7	=	"Low to Moderate Alcohol, Former Smoker daily"
						8	=	"No Alcohol, Former Smoker daily"
						9	=	"Low to Moderate Alcohol, Current Smoker <=19 cig/day"
						10	=	"No Alcohol, Current Smoker <=19 cig/day"
						11	=	"Low to Moderate Alcohol, Current Smoker >19 cig/day"
						12	=	"No Alcohol, Current Smoker >19 cig/day"
						13	=	"Low to Moderate Alcohol, Previous Substance Abuse"
						14	=	"No Alcohol, Previous Substance Abuse"
						15	=	"Low to Moderate Alcohol, Previous Risk Drinking"
						16	=	"No Alcohol, Previous Risk Drinking"
						17	=	"Low to Moderate Alcohol, Tried to Decrease Alcohol"
						18	=	"No Alcohol, Tried to Decrease Alcohol"
						19	=	"Low to Moderate Alcohol, AUDIT-C600 > 18 (?)"
						20	=	"No Alcohol, AUDIT-C600 > 18 (?)";

data asgn3.johnclean;
	set		asgn3.johnetalunclean;

	/* 	Made arrays for faster conversion of categorical to numeric values
		The lettered variables in 'raw[*]'are the original variables from 
		the original dataset. The variables in 'cln[*]' are their trans-
		-formed counterparts. If they contain a '0' at the end, they are 
		not the final form of the variable and will undergo further trans-
		-formation within the data step   */

	array 	raw[*]	B E M N O P Q R;
	array	cln[*]	life_abst_bin_0 
					age_cat_0
					cod_cat 
					auditc_cat_0 
					rsk_grp_tab2 
					rsk_grp_tab3
					rsk_grp_tab4_0 
					smk_cat;

	/*	This do-loop takes the array input from 'raw[*]' in the substr() fx.
		and strips all but the first two characters from the variable. For 
		the variables in the array, the first two characters are either two 
		numbers or a number followed by a period. The compress() fx. takes 
		the output of substr() and removes the period character. The input()
		fx. takes the string output of compress() and reformats as numerical
		with the 8. format. Missing values coded as '.' in new variables.  */

	do z=1 to 8;
		cln[z] = input(compress(substr(raw[z], 1, 2), "."), 8.);
		if missing(raw[z]) then cln[z]=.;
	end;

	/*	Numerical age, Subject ID, person time, and death status do not need
		transformation. They are renamed in the final data set. */

	age_num=A;
	deceased_bin=I;
	id_num=S;
	prsn_time=J;

	/* 	lifelong abstinence was coded in the original dataset as either 
		'1. Ja 1.' or '5. Nein 5.' This codes the new variable as either
		1  or 0, where 1 means yes and 0 means no (see 'yesno.' format) */

	life_abst_bin=.;
	if (life_abst_bin_0=1) then life_abst_bin=1;
	if (life_abst_bin_0=5) then life_abst_bin=0;

	/* Recodes sex from character to numeric, see 'sexbin. format. */ 
	sex_bin=1;
	if find(C, "female")>0 then sex_bin=0;
	
	/* 	For the edu_cat, age_cat, and hlt_cat, find() fx. to identifies 
		character strings for recoding into numeric values in new var. 
		For hlt_cat, there was not a unique character identifier for the 
		middle category 'good'. Because of this, it is coded first, so 
		that the following line will only identify those that are 'very 
		good' and overwrite their value from 2 to 3. */

	edu_cat=.;
	if find(D, "less")>0 then edu_cat=1;
	if find(D, "10-11")>0 then edu_cat=2;
	if find(D, "more")>0 then edu_cat=3;

	age_cat=.;
	if (age_cat_0=39) then age_cat=1;
	if (age_cat_0=40) then age_cat=2;
	if (age_cat_0=50) then age_cat=3;

	hlt_cat=.;
	if find(L, "poor") then hlt_cat=1;
	if find(L, "good") then hlt_cat=2;
	if find(L, "very") then hlt_cat=3;

	/* 	Fixes weird coding of 'abstient' AUDIT-C category. Was originally '5'
		and is now coded as '0', while extreme drinking is now coded as '5' 
		in new variable */

	auditc_cat=auditc_cat_0;
	if (auditc_cat_0=5) then auditc_cat=0;
	if (auditc_cat_0=6) then auditc_cat=5;

	/* 	Recodes missing values from the Risk Groups in Table 4 to indicate
		that they are those with moderate to heavy drinking. */

	rsk_grp_tab4=rsk_grp_tab4_0;
	if missing(rsk_grp_tab4_0) then rsk_grp_tab4=0;

	label 	age_num			=	"Age (Continuous)"
			life_abst_bin	=	"Lifelong Abstainer (Y/N)"
			sex_bin			=	"Sex"
			edu_cat			=	"Educational Attainment (years)"
			age_cat			=	"Age (Categorical)"
			deceased_bin	=	"Deceased (Y/N)"
			cod_cat			=	"Cause of Death"
			prsn_time		=	"Person-Time (Continuous)"
			hlt_cat			=	"Self-Reported Health"
			auditc_cat		=	"AUDIT-C Score Sum (Categorical)"
			smk_cat			=	"Smoking History"
			rsk_grp_tab2	=	"Risk Group II"
			rsk_grp_tab3	=	"Risk Group III"
			rsk_grp_tab4	=	"Risk Group IV"
			id_num			=	"Subject ID";

	format	life_abst_bin		
			deceased_bin		yesno.
			age_num
			prsn_time
			id_num				8.
			sex_bin				sexbin.
			edu_cat				educat.
			age_cat				agecat.
			cod_cat				codcat.
			hlt_cat				hltcat.
			auditc_cat			auditc.
			smk_cat				smkcat.
			rsk_grp_tab2		rskgrptwo.
			rsk_grp_tab3		rskgrpthr.
			rsk_grp_tab4		rskgrpfour.;

	/*	Drops all original variables from dataset - all variables of 
		interest are renamed. Also drops all intermediaries, variables
		that end in '0' */
		

	drop 	A B C D E F G J H I J K L M N O P Q R S
			life_abst_bin_0 
			age_cat_0 auditc_cat_0
			rsk_grp_tab4_0 
			z;

run;

proc contents data=asgn3.johnclean;
run;

/*check distribution of variables of interest to confirm if coded correctly */

proc freq data=asgn3.johnclean;
	tables auditc_cat /missing;
	tables sex_bin / missing;
	tables smk_cat / missing;
	tables deceased_bin / missing;
	tables edu_cat / missing;
	tables hlt_cat / missing;
	run;

/* 	Compared with table 1 in John et al., frequencies of new dataset match
	those from the article. */

/******************** END OF SCRIPT *********************/

