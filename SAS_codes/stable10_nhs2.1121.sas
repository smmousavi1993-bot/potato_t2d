/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 10. Associations between potato intakes and risk of diabetes in the NHS II from 2011-2021

/*MI*/
data mi_read;
infile 'mi/mi8917.073120.cases' lrecl=117 recfm=d;

input
@1      id          6.
@7      cd      $   1.
@10     cohort          1.
@13     icda            5.1
@20     qyr         2.
@26     mdx1            2.
@28     ydx1            2.
@32     conf            2.
@36     nhsicda         5.1
@43     mdx         2.
@45     ydx         2.
@49     dxmonth         4.
@55     rc_record_id        6.
@63     recur           1.
@66     dth_subcode     1.
@69     misite          1.
@70     acang           1.
@71     acthromb        1.
@72     no_therapy      1.
@73     ekgavail        1.
@74     st          1.
@75     extent          1.
@76     enzavail        1.
@77     peakck          5.
@82     hck         4.
@86     peakmb          6.1
@92     hmb         2.
@94     peaktrpn        6.1
@100        htrpn           3.1
@103        creat           4.1
@107        creatna         1.
@108        lvef            2.
@110        lvefna          1.
@111        hrtfail         1.
@112        dismed          1.
@113        ace         1.
@114        betablk         1.
@115        antiplt         1.
@116        statin          1.
;

label
        id      = 'ID'
        cd      = 'Check Digit'
        cohort      = 'Cohort'
        icda        = 'Reported ICDA'
        qyr     = 'Questionnaire cycle year when reported'
        mdx1        = 'Reported month of diagnosis'
        ydx1        = 'Reported year of diagnosis'
        conf        = 'Confirmation Code'
        nhsicda     = 'NHS reviewed and confirmed ICDA code'
        mdx     = 'Confirmed Month of Diagnosis'
        ydx     = 'Confirmed Year of Diagnosis'
        dxmonth     = 'Date of dx months since 1900'
        rc_record_id    = 'REDCap Record ID'
        recur       = 'Possible recurrence'
        dth_subcode = 'Confirmation of mi/chd'
        misite      = 'MI Site'
        acang       = 'Acute Therapy: Angioplasty'
        acthromb    = 'Acute Therapy: Thrombolytics'
        no_therapy  = 'Acute Therapy: Neither'
        ekgavail    = 'EKG Available'
        st      = 'ST'
        extent      = 'Extent'
        enzavail    = 'Enzymes Available'
        peakck      = 'Peak CK'
        hck     = 'Hospital ULN CK'
        peakmb      = 'Peak MB'
        hmb     = 'Hospital ULN MB'
        peaktrpn    = 'Peak Troponin'
        htrpn       = 'Hospital ULN Troponin'
        creat       = 'Initial creatinine'
        creatna     = 'initial creatinine: not available'
        lvef        = 'Left Ventricular Ejection Fraction % (last)'
        lvefna      = 'Left Ventricular Ejection Fraction'
        hrtfail     = 'Heart Failure during hospitalization'
        dismed      = 'Discharge medications available'
        ace     = 'ACE Inhibitors'
        betablk     = 'Beta-Blockers'
        antiplt     = 'Antiplatelet agents'
        statin      = 'Statins'
;
proc sort;by id;run;

data mi_all0;
    set mi_read;

    if cohort = 2;

    micase=0;
    if 11<=conf<=19 then micase=1;
    dtdxmi=.;
    if dxmonth>0 and micase=1 then dtdxmi = dxmonth*1;
    if dtdxmi=. then dtdxmi=1187;

    dtdxmi=dxmonth*1;

    keep id micase dtdxmi dth_subcode;

proc sort;by id;run;

/** Read death files **/
%deadff(file='/proj/n2dats/n2_dat_cdx/deaths/deadff.current.nhs2');
   dtdth=.;
   if  deadmonth > 0 then dtdth= deadmonth;

    newicda=compress(nhsicda, 'E');
    dthicda=newicda*1.0;
    if dthicda<1000 then dthicda=dthicda*10;
    keep id dtdth newicda dthicda;
proc sort;by id;run;


data confcabg0;
infile 'cabg/cabg8913.060816.nodups' lrecl=86 recfm=d;

input
@1      id          6.
@7      cd      $   1.
@8      icda        $   5.
@15     mdx1            2.
@17     ydx1            2.
@28     qyr         2.
@31     batser      $   7.
@39     recdate         6.
@46     conf        $   2.
@49     mdx         2.
@51     ydx         2.
@54     nhsicda     $   4.
@82     dxmonth         4.
;

label
        id      = 'id number'
        cd      = 'Check digit'
        icda        = 'icda code'
        mdx1        = 'month of reported date'
        ydx1        = 'year  of reported date'
        qyr     = 'questionnaire year'
        batser      = 'batch and serial number of qq,'
        recdate     = 'record update date'
        conf        = 'confirmation code'
        mdx     = 'confirmed month of diagnosis'
        ydx     = 'confirmed year of diagnosis'
        nhsicda     = 'nhs review icda code'
        dxmonth     = 'Date of dx months (confirmed date) since 1900'
;
    dtdxcabg=.;
    if dxmonth>0 and 11<=conf<=19 then dtdxcabg = dxmonth;
    if .<dtdxcabg<1212 then cabg99=1;
    else cabg99=0;
    keep id cabg99 dtdxcabg;
run;
proc sort data=confcabg0; by id; run;

/*CABG THROUGH 1996*/
data confstr0;
infile 'stroke/str8919.031621.cases' lrecl=81 recfm=d;

input
@1      id          6.
@7      cd      $   1.
@10     cohort          1.
@13     icda            5.
@20     qyr         2.
@26     mdx1            2.
@28     ydx1            2.
@32     conf            2.
@36     nhsicda         5.
@43     mdx         2.
@45     ydx         2.
@49     dxmonth         4.
@55     rc_record_id        6.
@63     recur           1.
@66     death_record        1.
@69     str_type        1.
@70     lvl_conf        1.
@71     primorsec       1.
@72     thromb          1.
@73     embolic         1.
@74     vasc_abn        1.
@75     ct_perf         1.
@76     mri_perf        1.
@77     autopsy         1.
@78     lart_infr       1.
@79     intra_hem       1.
@80     iph_loc         1.
;

label
        id      = 'ID'
        cd      = 'Check Digit'
        cohort      = 'Cohort'
        icda        = 'Reported ICDA'
        qyr     = 'Questionnaire cycle year when reported'
        mdx1        = 'Reported month of diagnosis'
        ydx1        = 'Reported year of diagnosis'
        conf        = 'Confirmation Code'
        nhsicda     = 'NHS reviewed and confirmed ICDA code'
        mdx     = 'Confirmed Month of Diagnosis'
        ydx     = 'Confirmed Year of Diagnosis'
        dxmonth     = 'Date of dx months since 1900'
        rc_record_id    = 'REDCap Record ID'
        recur       = 'Possible recurrence'
        death_record    = 'From the death file?'
        str_type    = 'Stroke subtype'
        lvl_conf    = 'Level of confirmation'
        primorsec   = 'Primary or secondary'
        thromb      = 'Thrombotic distribution (thrombotic only)'
        embolic     = 'Embolic sources (embolic only)'
        vasc_abn    = 'Vascular abnormality (hemorrhagic only)'
        ct_perf     = 'CT performed (all stroke subtypes)'
        mri_perf    = 'MRI performed (all stroke subtypes)'
        autopsy     = 'Autopsy performed (all stroke subtypes)'
        lart_infr   = 'Large artery infarction territory (large artery infarction only)'
        intra_hem   = 'Intraventricular hemorrhage (IPH only)'
        iph_loc     = 'IPH location (IPH only)'
;
    dtdxstr=.;
    if dxmonth>0 and 11<=conf<=19 then dtdxstr = dxmonth;
    if .<dtdxstr<1212 then str99=1;
    else str99=0;
    keep id str99 dtdxstr;
run;
proc sort data=confstr0; by id; run;


data mi_all; set mi_all0; by id; if first.id; run;
data cabg;  set confcabg0;  by id; if first.id; run;
data deadff1;  set deadff;  by id; if first.id; run;
data stroke; set confstr0; by id; if first.id; run;

/*********diabetes*********/

data diab_case;
infile 'diabetes/db8921.080423.cases' lrecl=183 recfm=d;

input
@1		id		    6.
@7		cd		$   1.
@10		cohort		    1.
@13		icda		    5.1
@20		qyr		    2.
@26		mdx1		    2.
@28		ydx1		    2.
@32		conf		    2.
@36		nhsicda		    5.1
@43		mdx		    2.
@45		ydx		    2.
@49		dxmonth		    4.
@55		rc_record_id	    6.
@63		recur		    1.
@66		type		    1.
@67		probabil	    1.
@68		igt		    1.
@69		gestdm		    1.
@70		secdm		    1.
@73		dbweight	    3.
@76		screen		    1.
@77		keto		    1.
@78		coma		    1.
@79		wtloss		    1.
@80		hunger		    1.
@81		thirst		    1.
@82		urine		    1.
@83		pruritis	    1.
@84		symptot		    1.
@85		uriglu		    1.
@86		urigluv		    1.
@87		uriketo		    1.
@88		uriketov	    1.
@89		fastglu		    1.
@90		fastgluv	    1.
@91		randglu		    1.
@92		randgluv	    1.
@93		postmg		    1.
@94		postmgv		    1.
@95		testog1		    1.
@96		testog1v	    1.
@97		testoth		    1.
@98		testothv	    1.
@99		miss22		    1.
@100		monitor		    1.
@101		hb57		    1.
@102		hb65		    1.
@103		lowfast		    1.
@104		lownum		    1.
@105		db_fast		    1.
@106		fast2yr		    1.
@107		nonfast		    1.
@108		nonfas2y	    1.
@109		numogt		    1.
@110		ogtval1		    1.
@111		ogtval2		    1.
@112		ogtval3		    1.
@113		ogtq6		    1.
@114		urine2p		    1.
@115		ur2pnum		    1.
@116		ketones		    1.
@117		keto1s2y	    1.
@118		ketoacid	    1.
@119		ketoin2y	    1.
@120		ketohosp	    1.
@121		preg1dx		    1.
@122		dxperst		    1.
@123		notlast		    1.
@124		ltdx		    4.
@128		still		    1.
@129		insulin		    1.
@130		start		    1.
@131		many_yrs	    2.
@133		yearins1	    2.
@135		insulnow	    1.
@136		stopins		    1.
@137		oralmeds	    1.
@138		oralinyr	    2.
@140		yrstart		    2.
@142		causemed	    1.
@143		causedis	    1.
@144		retino		    1.
@145		retyr		    2.
@147		protein		    1.
@148		protyr		    2.
@150		kidney		    1.
@151		kidneyyr	    2.
@153		pvd		    1.
@154		pvdyr		    2.
@156		footulc		    1.
@157		footyr		    2.
@159		perloss		    1.
@160		perlosyr	    2.
@162		neuroth		    1.
@163		neurotyr	    2.
@165		cirro		    1.
@166		cirr1gen	    1.
@167		cirrsex1	    1.
@168		cirr2gen	    1.
@169		cirr2sex	    1.
@170		cirr3gen	    1.
@171		cirr3sex	    1.
@172		dosins		    3.
@175		wilsons		    1.
@176		wilsonmf	    1.
@177		wilson2		    1.
@178		wils2mf		    1.
@179		hemochro	    1.
@180		hemo1sex	    1.
@181		hemo2		    1.
@182		hemo2sex	    1.
;

label
		id		= 'ID'
		cd		= 'Check Digit'
		cohort		= 'Cohort'
		icda		= 'Reported ICDA'
		qyr		= 'Questionnaire cycle year when reported'
		mdx1		= 'Reported month of diagnosis'
		ydx1		= 'Reported year of diagnosis'
		conf		= 'Confirmation Code'
		nhsicda		= 'NHS reviewed and confirmed ICDA code'
		mdx		= 'Confirmed Month of Diagnosis'
		ydx		= 'Confirmed Year of Diagnosis'
		dxmonth		= 'Date of dx months since 1900'
		rc_record_id	= 'REDCap Record ID'
		recur		= 'Possible recurrence'
		type		= 'Type of DM'
		probabil	= 'Ranks certainty of diabetes type status'
		igt		= 'Impaired glucose tolerance'
		gestdm		= 'Gestational diabetes'
		secdm		= 'Secondary diabetes'
		dbweight	= 'Approximate weight at time of diagnosis'
		screen		= 'Screening vs. symptoms'
		keto		= 'Ketoacidosis?'
		coma		= 'Coma?'
		wtloss		= 'Unintended Weight Loss?'
		hunger		= 'Unusual Hunger?'
		thirst		= 'Unusual Thirst?'
		urine		= 'Unusual Frequency Of Urination?'
		pruritis	= 'Pruritis of Vulva or Vagina?'
		symptot		= 'Symptom Total'
		uriglu		= 'Urine glucose at 1st dx (1976-1984 qx)'
		urigluv		= 'Urine glucose value 1st dx (1976-1984 qx)'
		uriketo		= 'Urine ketones at 1st dx (1976-1984 qx)'
		uriketov	= 'Urine ketone value at 1st dx (1976-1984 qx)'
		fastglu		= 'Fasting bld glucose 1st dx (1976-1984 qx)'
		fastgluv	= 'Fasting bld glucose value 1st dx (1976-1984 qx)'
		randglu		= 'Random bld glucose measure (1976-1984 qx)'
		randgluv	= 'Random bld glu value 1st dx (1976-1984 qx)'
		postmg		= 'Post meal bld glu measure 1st dx (1976-1984 qx)'
		postmgv		= 'Post meal bld glu value (1976-1984 qx)'
		testog1		= 'Oral glucose tolerance test (1976-1984 qx)'
		testog1v	= 'OGTT value given (1976-1984 qx)'
		testoth		= 'OGTT other times (1976-1984 qx)'
		testothv	= 'OGTT other times value given (1976-1984 qx)'
		miss22		= 'Truly blank?'
		monitor		= 'Self-monitor'
		lowfast		= 'Elevated fasting of 126 or higher'
		lownum		= 'Number of fasting blood glucose measurements between 126-139 mg or higher'
		db_fast		= 'Number of fasting blood glucose measurements of 140/mg or higher'
		fast2yr		= '(1976-1984 qx)'
		nonfast		= 'Number of non-fasting blood glucose measurements of 200 mg/dl or higher'
		nonfas2y	= '(1976-1984 qx)'
		numogt		= '(1976-1984 qx)'
		ogtval1		= '(1976-1984 qx)'
		ogtval2		= '(1976-1984 qx)'
		ogtval3		= '(1976-1984 qx)'
		ogtq6		= 'Number of abnormal Oral Glucose Tolerance tests of 200 mg/dl or higher'
		urine2p		= 'Number of urine glucose measurements of 2+ or greater'
		ur2pnum		= '(1976-1984 qx)'
		ketones		= 'Number of times had ketones present (more than a trace) in urine'
		keto1s2y	= '(1976-1984 qx)'
		ketoacid	= 'Ever hospitalized for ketoacidosis'
		ketoin2y	= 'Hospitalized for ketoacidosis within first two years of diagnosis'
		ketohosp	= 'Year and hospital provided for most recent admission for ketoacidosis'
		preg1dx		= 'Pregnant at the time diabetes was first diagnosed'
		dxperst		= 'Did diabetes persist for more than one month after the pregnancy'
		notlast		= 'If diabetes did not persist for more than one month after the end'
		ltdx		= 'Date of later diagnosis'
		still		= 'If more than one month after the end of pregnancy, still have diabetes'
		insulin		= 'Ever treated with insulin injections'
		start		= 'when was insulin started'
		many_yrs	= 'how long insulin taken'
		yearins1	= 'Year insulin started'
		insulnow	= 'currently taking daily insulin'
		stopins		= 'Ever stopped insulin two weeks or more'
		oralmeds	= 'Oral medication'
		oralinyr	= 'Number of yrs oral medication'
		yrstart		= 'Year oral medication started'
		causemed	= '(1976-1984 qx)'
		causedis	= '(1976-1984 qx)'
		retino		= '(1976-1984 qx)'
		retyr		= '(1976-1984 qx)'
		protein		= '(1976-1984 qx)'
		protyr		= '(1976-1984 qx)'
		kidney		= '(1976-1984 qx)'
		kidneyyr	= '(1976-1984 qx)'
		pvd		= '(1976-1984 qx)'
		pvdyr		= '(1976-1984 qx)'
		footulc		= '(1976-1984 qx)'
		footyr		= '(1976-1984 qx)'
		perloss		= '(1976-1984 qx)'
		perlosyr	= '(1976-1984 qx)'
		neuroth		= '(1976-1984 qx)'
		neurotyr	= '(1976-1984 qx)'
		cirro		= '(1986 qx)'
		cirr1gen	= '(1986 qx)'
		cirrsex1	= '(1986 qx)'
		cirr2gen	= '(1986 qx)'
		cirr2sex	= '(1986 qx)'
		cirr3gen	= '(1986 qx)'
		cirr3sex	= '(1986 qx)'
		dosins		= '(1986 qx)'
		wilsons		= 'Blood relative diagnosed with Wilson''s Disease'
		wilsonmf	= 'Sex of Wilson''s disease person'
		wilson2		= 'Blood relative diagnosed with Wilson''s Disease 2'
		wils2mf		= 'Sex of Wilson''s disease person'
		hemochro	= 'Blood relative diagnosed with Hemochromatosis'
		hemo1sex	= 'Sex of Hemochromatosis relative'
		hemo2		= 'Blood relative diagnosed with Hemochromatosis -2'
		hemo2sex	= 'Sex of Hemochromatosis 2nd relative'
;

proc sort;by id;run;
proc freq data=diab_case;tables type cohort;run;
data diab_case;
    set diab_case;
    if cohort = 2 and type =2;

    dtdxdiab=dxmonth*1;
    if dtdxdiab=. then dtdxdiab=1187;

   symp=0;
   if symptot>0 or screen=2 then symp=1;
    label symp="Symptoms";

    keep id dtdxdiab probabil symp;

proc sort;by id;run;

/*proc univariate data=diab_case;var dtdxdiab;run;
proc freq data=diab_case;tables diab_case probabil diab_case*probabil;run;*/

%ahei2010_9115(keep= ahei2010_91 ahei2010_noETOH91 ahei2010_vegI91 ahei2010_frtI91 ahei2010_ssbI91 ahei2010_whgrnI91 ahei2010_nutI91 ahei2010_rmtI91 ahei2010_etohI91 ahei2010_ptranI91 ahei2010_omegaI91 ahei2010_polyI91 ahei2010_naI91
                     ahei2010_95 ahei2010_noETOH95 ahei2010_vegI95 ahei2010_frtI95 ahei2010_ssbI95 ahei2010_whgrnI95 ahei2010_nutI95 ahei2010_rmtI95 ahei2010_etohI95 ahei2010_ptranI95 ahei2010_omegaI95 ahei2010_polyI95 ahei2010_naI95
                     ahei2010_99 ahei2010_noETOH99 ahei2010_vegI99 ahei2010_frtI99 ahei2010_ssbI99 ahei2010_whgrnI99 ahei2010_nutI99 ahei2010_rmtI99 ahei2010_etohI99 ahei2010_ptranI99 ahei2010_omegaI99 ahei2010_polyI99 ahei2010_naI99
                     ahei2010_03 ahei2010_noETOH03 ahei2010_vegI03 ahei2010_frtI03 ahei2010_ssbI03 ahei2010_whgrnI03 ahei2010_nutI03 ahei2010_rmtI03 ahei2010_etohI03 ahei2010_ptranI03 ahei2010_omegaI03 ahei2010_polyI03 ahei2010_naI03 
                     ahei2010_07 ahei2010_noETOH07 ahei2010_vegI07 ahei2010_frtI07 ahei2010_ssbI07 ahei2010_whgrnI07 ahei2010_nutI07 ahei2010_rmtI07 ahei2010_etohI07 ahei2010_ptranI07 ahei2010_omegaI07 ahei2010_polyI07 ahei2010_naI07
                     ahei2010_11 ahei2010_noETOH11 ahei2010_vegI11 ahei2010_frtI11 ahei2010_ssbI11 ahei2010_whgrnI11 ahei2010_nutI11 ahei2010_rmtI11 ahei2010_etohI11 ahei2010_ptranI11 ahei2010_omegaI11 ahei2010_polyI11 ahei2010_naI11);
 
data aheinhs2;
    set ahei2010_9115;
run;

data aheinhs2;
    set aheinhs2;

    ahei91=ahei2010_91;
    aheinoal91=ahei2010_noETOH91;
    aheinopt91 = sum(ahei2010_vegI91, ahei2010_frtI91, ahei2010_ssbI91, ahei2010_etohI91, ahei2010_nutI91, ahei2010_rmtI91, ahei2010_omegaI91, ahei2010_whgrnI91, ahei2010_naI91);
    aheifisha91 = sum(ahei2010_nutI91, ahei2010_ssbI91, ahei2010_vegI91, ahei2010_frtI91, ahei2010_polyI91, ahei2010_ptranI91, ahei2010_etohI91, ahei2010_whgrnI91, ahei2010_naI91);
    aheidairy91 = sum(ahei2010_nutI91, ahei2010_ssbI91, ahei2010_vegI91, ahei2010_frtI91, ahei2010_polyI91, ahei2010_ptranI91, ahei2010_etohI91, ahei2010_omegaI91, ahei2010_whgrnI91, ahei2010_naI91);
    aheinutbl91 = sum(ahei2010_ssbI91, ahei2010_vegI91, ahei2010_frtI91, ahei2010_polyI91, ahei2010_ptranI91, ahei2010_etohI91, ahei2010_omegaI91, ahei2010_whgrnI91, ahei2010_naI91);
    aheipoult91 = sum(ahei2010_nutI91, ahei2010_ssbI91, ahei2010_vegI91, ahei2010_frtI91, ahei2010_polyI91, ahei2010_ptranI91, ahei2010_etohI91, ahei2010_omegaI91, ahei2010_whgrnI91, ahei2010_naI91);
    aheineggs91 = sum(ahei2010_nutI91, ahei2010_ssbI91, ahei2010_vegI91, ahei2010_frtI91, ahei2010_polyI91, ahei2010_ptranI91, ahei2010_etohI91, ahei2010_omegaI91, ahei2010_whgrnI91, ahei2010_naI91);

    ahei95=ahei2010_95;
    aheinoal95=ahei2010_noETOH95;
    aheinopt95 = sum(ahei2010_vegI95, ahei2010_frtI95, ahei2010_ssbI95, ahei2010_etohI95, ahei2010_nutI95, ahei2010_rmtI95, ahei2010_omegaI95, ahei2010_whgrnI95, ahei2010_naI95);
    aheifisha95 = sum(ahei2010_nutI95, ahei2010_ssbI95, ahei2010_vegI95, ahei2010_frtI95, ahei2010_polyI95, ahei2010_ptranI95, ahei2010_etohI95, ahei2010_whgrnI95, ahei2010_naI95);
    aheidairy95 = sum(ahei2010_nutI95, ahei2010_ssbI95, ahei2010_vegI95, ahei2010_frtI95, ahei2010_polyI95, ahei2010_ptranI95, ahei2010_etohI95, ahei2010_omegaI95, ahei2010_whgrnI95, ahei2010_naI95);
    aheinutbl95 = sum(ahei2010_ssbI95, ahei2010_vegI95, ahei2010_frtI95, ahei2010_polyI95, ahei2010_ptranI95, ahei2010_etohI95, ahei2010_omegaI95, ahei2010_whgrnI95, ahei2010_naI95);
    aheipoult95 = sum(ahei2010_nutI95, ahei2010_ssbI95, ahei2010_vegI95, ahei2010_frtI95, ahei2010_polyI95, ahei2010_ptranI95, ahei2010_etohI95, ahei2010_omegaI95, ahei2010_whgrnI95, ahei2010_naI95);
    aheineggs95 = sum(ahei2010_nutI95, ahei2010_ssbI95, ahei2010_vegI95, ahei2010_frtI95, ahei2010_polyI95, ahei2010_ptranI95, ahei2010_etohI95, ahei2010_omegaI95, ahei2010_whgrnI95, ahei2010_naI95);

    ahei99=ahei2010_99;
    aheinoal99=ahei2010_noETOH99;
    aheinopt99 = sum(ahei2010_vegI99, ahei2010_frtI99, ahei2010_ssbI99, ahei2010_etohI99, ahei2010_nutI99, ahei2010_rmtI99, ahei2010_omegaI99, ahei2010_whgrnI99, ahei2010_naI99);
    aheifisha99 = sum(ahei2010_nutI99, ahei2010_ssbI99, ahei2010_vegI99, ahei2010_frtI99, ahei2010_polyI99, ahei2010_ptranI99, ahei2010_etohI99, ahei2010_whgrnI99, ahei2010_naI99);
    aheidairy99 = sum(ahei2010_nutI99, ahei2010_ssbI99, ahei2010_vegI99, ahei2010_frtI99, ahei2010_polyI99, ahei2010_ptranI99, ahei2010_etohI99, ahei2010_omegaI99, ahei2010_whgrnI99, ahei2010_naI99);
    aheinutbl99 = sum(ahei2010_ssbI99, ahei2010_vegI99, ahei2010_frtI99, ahei2010_polyI99, ahei2010_ptranI99, ahei2010_etohI99, ahei2010_omegaI99, ahei2010_whgrnI99, ahei2010_naI99);
    aheipoult99 = sum(ahei2010_nutI99, ahei2010_ssbI99, ahei2010_vegI99, ahei2010_frtI99, ahei2010_polyI99, ahei2010_ptranI99, ahei2010_etohI99, ahei2010_omegaI99, ahei2010_whgrnI99, ahei2010_naI99);
    aheineggs99 = sum(ahei2010_nutI99, ahei2010_ssbI99, ahei2010_vegI99, ahei2010_frtI99, ahei2010_polyI99, ahei2010_ptranI99, ahei2010_etohI99, ahei2010_omegaI99, ahei2010_whgrnI99, ahei2010_naI99);

    ahei03=ahei2010_03;
    aheinoal03=ahei2010_noETOH03;
    aheinopt03 = sum(ahei2010_vegI03, ahei2010_frtI03, ahei2010_ssbI03, ahei2010_etohI03, ahei2010_nutI03, ahei2010_rmtI03, ahei2010_omegaI03, ahei2010_whgrnI03, ahei2010_naI03);
    aheifisha03 = sum(ahei2010_nutI03, ahei2010_ssbI03, ahei2010_vegI03, ahei2010_frtI03, ahei2010_polyI03, ahei2010_ptranI03, ahei2010_etohI03, ahei2010_whgrnI03, ahei2010_naI03);
    aheidairy03 = sum(ahei2010_nutI03, ahei2010_ssbI03, ahei2010_vegI03, ahei2010_frtI03, ahei2010_polyI03, ahei2010_ptranI03, ahei2010_etohI03, ahei2010_omegaI03, ahei2010_whgrnI03, ahei2010_naI03);
    aheinutbl03 = sum(ahei2010_ssbI03, ahei2010_vegI03, ahei2010_frtI03, ahei2010_polyI03, ahei2010_ptranI03, ahei2010_etohI03, ahei2010_omegaI03, ahei2010_whgrnI03, ahei2010_naI03);
    aheipoult03 = sum(ahei2010_nutI03, ahei2010_ssbI03, ahei2010_vegI03, ahei2010_frtI03, ahei2010_polyI03, ahei2010_ptranI03, ahei2010_etohI03, ahei2010_omegaI03, ahei2010_whgrnI03, ahei2010_naI03);
    aheineggs03 = sum(ahei2010_nutI03, ahei2010_ssbI03, ahei2010_vegI03, ahei2010_frtI03, ahei2010_polyI03, ahei2010_ptranI03, ahei2010_etohI03, ahei2010_omegaI03, ahei2010_whgrnI03, ahei2010_naI03);

    ahei07=ahei2010_07;
    aheinoal07=ahei2010_noETOH07;
    aheinopt07 = sum(ahei2010_vegI07, ahei2010_frtI07, ahei2010_ssbI07, ahei2010_etohI07, ahei2010_nutI07, ahei2010_rmtI07, ahei2010_omegaI07, ahei2010_whgrnI07, ahei2010_naI07);
    aheifisha07 = sum(ahei2010_nutI07, ahei2010_ssbI07, ahei2010_vegI07, ahei2010_frtI07, ahei2010_polyI07, ahei2010_ptranI07, ahei2010_etohI07, ahei2010_whgrnI07, ahei2010_naI07);
    aheidairy07 = sum(ahei2010_nutI07, ahei2010_ssbI07, ahei2010_vegI07, ahei2010_frtI07, ahei2010_polyI07, ahei2010_ptranI07, ahei2010_etohI07, ahei2010_omegaI07, ahei2010_whgrnI07, ahei2010_naI07);
    aheinutbl07 = sum(ahei2010_ssbI07, ahei2010_vegI07, ahei2010_frtI07, ahei2010_polyI07, ahei2010_ptranI07, ahei2010_etohI07, ahei2010_omegaI07, ahei2010_whgrnI07, ahei2010_naI07);
    aheipoult07 = sum(ahei2010_nutI07, ahei2010_ssbI07, ahei2010_vegI07, ahei2010_frtI07, ahei2010_polyI07, ahei2010_ptranI07, ahei2010_etohI07, ahei2010_omegaI07, ahei2010_whgrnI07, ahei2010_naI07);
    aheineggs07 = sum(ahei2010_nutI07, ahei2010_ssbI07, ahei2010_vegI07, ahei2010_frtI07, ahei2010_polyI07, ahei2010_ptranI07, ahei2010_etohI07, ahei2010_omegaI07, ahei2010_whgrnI07, ahei2010_naI07);

    ahei11=ahei2010_11;
    aheinoal11=ahei2010_noETOH11;
    aheinopt11 = sum(ahei2010_vegI11, ahei2010_frtI11, ahei2010_ssbI11, ahei2010_etohI11, ahei2010_nutI11, ahei2010_rmtI11, ahei2010_omegaI11, ahei2010_whgrnI11, ahei2010_naI11);
    aheifisha11 = sum(ahei2010_nutI11, ahei2010_ssbI11, ahei2010_vegI11, ahei2010_frtI11, ahei2010_polyI11, ahei2010_ptranI11, ahei2010_etohI11, ahei2010_whgrnI11, ahei2010_naI11);
    aheidairy11 = sum(ahei2010_nutI11, ahei2010_ssbI11, ahei2010_vegI11, ahei2010_frtI11, ahei2010_polyI11, ahei2010_ptranI11, ahei2010_etohI11, ahei2010_omegaI11, ahei2010_whgrnI11, ahei2010_naI11);
    aheinutbl11 = sum(ahei2010_ssbI11, ahei2010_vegI11, ahei2010_frtI11, ahei2010_polyI11, ahei2010_ptranI11, ahei2010_etohI11, ahei2010_omegaI11, ahei2010_whgrnI11, ahei2010_naI11);
    aheipoult11 = sum(ahei2010_nutI11, ahei2010_ssbI11, ahei2010_vegI11, ahei2010_frtI11, ahei2010_polyI11, ahei2010_ptranI11, ahei2010_etohI11, ahei2010_omegaI11, ahei2010_whgrnI11, ahei2010_naI11);
    aheineggs11 = sum(ahei2010_nutI11, ahei2010_ssbI11, ahei2010_vegI11, ahei2010_frtI11, ahei2010_polyI11, ahei2010_ptranI11, ahei2010_etohI11, ahei2010_omegaI11, ahei2010_whgrnI11, ahei2010_naI11);
run;

%act8917(keep=act91m act97m act01m act05m act09m act13m act17m actc05m actc09m actc13m actc17m);

    **************************************************
    *           Family history of diseases           *
    **************************************************;
    /*** read family history of diabetes, cancer, MI & Stroke***/
    %nur89(keep=mdb89 fdb89 bdb89 sdb89 dbfh89 ambrc89 asbrc89 amgbc89 apgbc89 mclc89 fclc89 bclc89 sclc89 cafh89 ammi89 afmi89 mifh89
        afric89 asian89 oanc89 hisp89 seuro89 scand89 ocauc89);
       if mdb89=1 or fdb89=1 or bdb89=1 or sdb89=1 then dbfh89=1;
       else dbfh89=0;
       cafh89=0;
       if ambrc89=1 or asbrc89=1 or amgbc89=1 or apgbc89=1 or mclc89=1 or fclc89=1 or bclc89=1 or sclc89=1 then cafh89=1;
       else cafh89=0;
       if ammi89 in (1,2,3,4,5) or afmi89 in (1,2,3,4,5) then mifh89=1;
       else mifh89=0;
       run;
       proc sort;  by id; run;

    %nur93(keep=msov93 mcanc93 fcanc93 cafh93 mmi93 fmi93 mifh93 marry93 alone93);
        if msov93=2 or mcanc93=1 or fcanc93=1 then cafh93=1;
        else cafh93=0;
        if mmi93=1 or fmi93=1 then mifh93=1;
        else mifh93=0;
    run;
    proc sort;by id;run;

    %nur97(keep=pdbd97 sbdb97 dbfh97 pclc97 sclc197 sclc297 cafh97 mmi97 fmi97 sbmi97 mstr97 fstr97 sbstr97 mifh97 strfh97);
        if pdbd97=1 or sbdb97=1 then dbfh97=1;
        else dbfh97=0;
        if pclc97=1 or sclc197=1 or sclc297=1 then cafh97=1;
        else cafh97=0;
        if mmi97=1 or fmi97=1 or sbmi97=1 then mifh97=1;
        else mifh97=0;
        if mstr97=1 or fstr97=1 or sbstr97=1 then strfh97=1;
        else strfh97=0;
    run;
    proc sort;by id;run;

    %nur01(keep=mdb01 fdb01 sdb01 dbfh01 hxclc01 mov01 sov01 mbrcn01 sbrc101 sbrc201 pclc01 sclc101 sclc201 fpro01 bpro01 mut01 smut01 ppan01 span01 cafh01 mmi01 fmi01 smi01 mifh01 mstr01 fstr01 sstr01 strfh01);
        if mdb01=1 or fdb01=1 or sdb01=1 then dbfh01=1;
        else dbfh01=0;
        if hxclc01=1 or mov01=1 or sov01=1 or mbrcn01=1 or sbrc101=1 or sbrc201=1 or pclc01=1 or sclc101=1 or sclc201=1 or fpro01=1 or bpro01=1 or mut01=1 or smut01=1 or ppan01=1 or span01=1 then cafh01=1;
        else cafh01=0;
        if mmi01=1 or fmi01=1 or smi01=1 then mifh01=1;
        else mifh01=0;
        if mstr01=1 or fstr01=1 or sstr01=1 or strfh01=1 then strfh01=1;
        else strfh01=0;
    run;
    proc sort;by id;run;

    %nur03(keep=hxclc03 cafh03);
        if hxclc03=1 then cafh03=1;
        else cafh03=0;
    run;
    proc sort;by id;run;

    %nur05(keep=fdb05 sdb05 mdb05 dbfh05 hxclc05 mov05 sov05 mbrcn05 sbrc105 sbrc205 pclc05 sclc105 sclc205 mdcan05 fdcan05 cafh05 mdchd05 fdchd05 mifh05 mdstr05 fdstr05 strfh05
                marry05 alone05
                mprof05 mexec05 msale05 mmech05 mmach05 mserv05
                                      mlabo05 mfarm05 mmili05 mhome05 mdk05
        /* dad occupation at birth */ fprof05 fexec05 fsale05 fmech05 fmach05 fserv05
                                      flabo05 ffarm05 fmili05 fhome05 fdk05);
       if fdb05=1 or sdb05=1 or mdb05=1 then dbfh05=1;
       else dbfh05=0;
       cafh05=0;
       if hxclc05=1 or mov05=1 or sov05=1 or mbrcn05=1 or sbrc105=1 or sbrc205=1 or pclc05=1 or sclc105=1 or sclc205=1 or mdcan05=1 or fdcan05=1 then cafh05=1;
       else cafh05=0;
       if mdchd05=1 or fdchd05=1 then mifh05=1;
       else mifh05=0;
       if mdstr05=1 or fdstr05=1 then strfh05=1;
       else strfh05=0;
       run;
       proc sort;  by id; run;

    %nur07(keep=hxclc07 cafh07);
        if hxclc07=1 then cafh07=1;
        else cafh07=0;
    run;
    proc sort;by id;run;

    %nur09(keep=pdb09 sdb09 dbfh09 hxclc09 mov09 sov09 mbrcn09 sbrcn09 pclc09 sclc109 sclc209 mdcan09 fdcan09 cafh09 mdchd09 fdchd09 mdstr09 fdstr09 mifh09 strfh09 alone09);
       if pdb09=1 or sdb09=1 then dbfh09=1;
       else dbfh09=0;
       if hxclc09=1 or mov09=1 or sov09=1 or mbrcn09=1 or sbrcn09=1 or pclc09=1 or sclc109=1 or sclc209=1 or mdcan09=1 or fdcan09=1 then cafh09=1;
       else cafh09=0;
       if mdchd09=1 or fdchd09=1 then mifh09=1;
       else mifh09=0;
       if mdstr09=1 or fdstr09=1 then strfh09=1;
       else strfh09=0;
       run;
       proc sort;  by id; run;

    %nur11(keep=hxclc11 cafh11);
        if hxclc11=1 then cafh11=1;
        else cafh11=0;
    run;
    proc sort;by id;run;

    %nur13(keep=hxdb13 dbfh13 hxclc13 hxov13 hxbc13 hxcol13 mdcan13 fdcan13 cafh13 hxmi13 mdchd13 fdchd13 mifh13 hxstr13 mdstr13 fdstr13 strfh13 alone13 marry13);
       if hxdb13=2 then dbfh13=1;
       else dbfh13=0;
       if hxclc13=1 or hxov13=2 or hxbc13=2 or hxcol13=2 or mdcan13=1 or fdcan13=1 then cafh13=1;
       else cafh13=0;
       if hxstr13=2 or mdstr13=1 or fdstr13=1 then strfh13=1;
       else strfh13=0;
       if hxmi13=2 or mdchd13=1 or fdchd13=1 then mifh13=1;
       else mifh13=0;
       proc sort;  by id; run;

    %nur17(keep=alone17 marry17);
    proc sort;  by id; run;

    %nur19(keep=alone19 marry19);
    proc sort;  by id; run;


   data familyhis;
      merge nur89 nur93 nur97 nur01 nur03 nur05 nur07 nur09 nur11 nur13;
      by id;
      if dbfh89=1 or dbfh97=1 or dbfh01=1 or dbfh05=1 or dbfh09=1 or dbfh13=1 then dbfh=1; else dbfh=0;
      if mifh89=1 or mifh93=1 or mifh97=1 or mifh01=1 or mifh05=1 or mifh09=1 or mifh13=1 then mifh=1; else mifh=0; /*** note: family history of MI before 60 years, ref: Fung T AJCN 2009paper***/
      if strfh97=1 or strfh01=1 or strfh05=1 or strfh09=1 or strfh13=1 then strfh=1; else strfh=0;
      if cafh89=1 or cafh93=1 or cafh97=1 or cafh01=1 or cafh03=1 or cafh05=1 or cafh07=1 or cafh09=1 or cafh11=1 or cafh13=1 then cafh=1;else cafh=0;
      keep id dbfh mifh strfh cafh;
      proc sort; by id; run;
      

    /*Potato in*/
    %include '/udd/nhsem/Potato.T2D/MousaviSeyed_potato_T2D_052024/food_nhs2.sas';

    %meds8917(keep=aspu91 aspu93 aspu95 aspu97 aspu99 aspu01 aspu03 aspu05 aspu07 aspu09 aspu11 aspu13 aspu15 aspu17
                   asp91 asp93 asp95 asp97 asp99 asp01 asp03 asp05 asp07 asp09 asp11 asp13 asp15 asp17);
    if aspu91 = 1 then asp91 = 1; else asp91 = 0;
    if aspu93 = 1 then asp93 = 1; else asp93 = 0;
    if aspu95 = 1 then asp95 = 1; else asp95 = 0;
    if aspu97 = 1 then asp97 = 1; else asp97 = 0;
    if aspu99 = 1 then asp99 = 1; else asp99 = 0;
    if aspu01 = 1 then asp01 = 1; else asp01 = 0;
    if aspu03 = 1 then asp03 = 1; else asp03 = 0;
    if aspu05 = 1 then asp05 = 1; else asp05 = 0;
    if aspu07 = 1 then asp07 = 1; else asp07 = 0;
    if aspu09 = 1 then asp09 = 1; else asp09 = 0;
    if aspu11 = 1 then asp11 = 1; else asp11 = 0;
    if aspu13 = 1 then asp13 = 1; else asp13 = 0;
    if aspu15 = 1 then asp15 = 1; else asp15 = 0;
    if aspu17 = 1 then asp17 = 1; else asp17 = 0;

/*** BMI, smoking, irt and height ***/
%der8917 (keep= id birthday height89  
                retmo89  retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15  retmo17
                age89    age91     age93    age95    age97    age99    age01    age03    age05     age07     age09    age11  age13  age15  age17
                smkdr89  smkdr91   smkdr93  smkdr95  smkdr97  smkdr99  smkdr01  smkdr03  smkdr05   smkdr07   smkdr09  smkdr11  smkdr13  smkdr15  smkdr17 
                bmi89    bmi91     bmi93    bmi95    bmi97    bmi99    bmi01    bmi03    bmi05     bmi07     bmi09    bmi11   bmi13  bmi15  bmi17
                mnpst89  mnpst91   mnpst93  mnpst95  mnpst97  mnpst99  mnpst01  mnpst03  mnpst05   mnpst07   mnpst09  mnpst11 mnpst13 mnpst15 mnpst17 
                n2rh89   n2rh91    n2rh93   n2rh95   n2rh97   n2rh99   n2rh01   n2rh03   n2rh05    n2rh07    n2rh09   n2rh11  n2rh13  n2rh15  n2rh17
                nhor89   nhor91    nhor93   nhor95   nhor97   nhor99   nhor01   nhor03   nhor05    nhor07    nhor09   nhor11  nhor13  nhor15  nhor17   
                race8905 mrace8905 eth8905 white strrace catrace catrace2);
                if race8905=1 then white=1;else white=0;
              if race8905=1 then strrace=1;
              else if race8905=2 then strrace=2;
              else if race8905 in (3,4,5) then strrace=3;
              else strrace=.;

            if mrace8905=1 and eth8905 ne 1 then catrace=0; /*non-hispanic white*/
            else if mrace8905=2 and eth8905 ne 1 then catrace=1; /*non-hispanic black*/
            else if eth8905=1 then catrace=2; /*Hispanic*/
            else if mrace8905=4 then catrace=3; /*Asian*/
            else catrace=.; /*Unknown/Other*/

            if catrace=0 then catrace2=0; /*non-hispanic white*/
            else if catrace in (1,2,3) then catrace2=1;
            else catrace2=.; /*Unknown*/

/*** physical activity ***9
%act8917 (keep=act89m actc89m act91m actc91m act97m actc97m act01m actc01m act05m actc05m act09m actc09m act13m actc13m act17m actc17m);
                if act89m>990 then act89m=.;
                if act91m>990 then act91m=.;
                if act97m>990 then act97m=.;
                if act01m>990 then act01m=.;
                if act05m>990 then act05m=.;
                if act09m>990 then act09m=.;
                if act13m>990 then act13m=.;
                if act17m>990 then act17m=.;
                run; 

/*** slef-reported chronic diseases. multi-vitamin and medications***/
%nur89(keep=wt89 mi89 db89 dbg89 hbp89 str89 chol89
            can89 brcn89 ocan89 bcc89     
            mar89  marry89
            pct589 pct1089 pct2089 /*bodyshape at ages 5, 10, 20 years*/
            thiaz89 lasx89 betab89 ald89 hbptx89);
            can89=0; 
            if brcn89=1 or ocan89=1 or bcc89=1 then can89=1;
            if mar89=2 then marry89=1; else marry89=0;
            if wt89 = 0 then wt89=.;
            if thiaz89=1 or lasx89=1 or betab89=1 or ald89=1 then hbptx89=1; else hbptx89=0;


%nur91(keep=wt91 sittv91 mi91 db91 dbg91 hbp91 str91   chol91            
            brcn91  bcc91   scc91   ocan91 can91 ang91
            cpreg91/*current pregant*/
            preg91 /*Pregnant Since 9/89 (L5 S5)*/);
            can91=0;
            if brcn91=1 or ocan91=1 or bcc91=1 or scc91=1 then can91=1;
            if wt91 = 0 then wt91=.;
            if ang91=1 then ang91=1;
            else ang91=0;
            run;


%nur93(keep=wt93 mi93 db93 dbg93 hbp93 str93 ang93 chol93    
            can93   brcn93  ocan93  bcc93  scc93
            marry93 div93 widow93 nvmar93 q37pt93
            alone93 husb93 ofam93 othlv93 q38pt93
            thiaz93 aht93 hbptx93 val93 thor93 tranq93 przc93 przcy93 antid93 ssri93
            waist93 hip93 marry93 cpreg93 preg93);
            can93=0; 
            if brcn93=1 or ocan93=1 or bcc93=1 or scc93=1 then can93=1;
            ssri93=0;  if przc93=1 then ssri93=1;
            antid93=0; if tcyc93=1 then antid93=1;
            if thiaz93=1 or aht93=1 then hbptx93=1; else hbptx93=0;
            if val93=1 or thor93=1 then tranq93=1; else tranq93=0;

%nur95(keep=wt95 mi95 db95 dbg95 hbp95 str95 ang95 chol95 cabg95 cabgd95 cabg93            
            can95 brcn95 ocan95 bcc95 scc95 
            thiaz95 bprx95 hbptx95 cpreg95 preg95); 
            can95=0;
            if brcn95=1 or ocan95=1 or bcc95=1 or scc95=1 then can95=1;
            if thiaz95=1 or  bprx95=1 then hbptx95=1; else hbptx95=0; 
            if wt95 = 0 then wt95=.;
            if cabg95=1 and cabgd95 in (1,2,3) then cabg93=1;
 
%nur97(keep=wt97 sittv97 mi97 db97 hbp97 str97 chol97 cabg97 ang97
            can97  brcn97  ocan97 bcc97   scc97  
            tcyc97 przc97  zol97  paxil97 antid97 ssri97
            thiaz97 aht97 hbptx97 val97 tranq97 cpreg97 preg97);
            can97=0;
            if brcn97=1 or ocan97=1 or bcc97=1 or scc97=1 then can97=1;
            ssri97=0; if przc97=1 or zol97=1 or paxil97=1 then ssri97=1;
            antid97=0;  if tcyc97=1 then antid97=1;
            if thiaz97=1 or aht97=1 then hbptx97=1; else hbptx97=0;
            if val97=1 then tranq97=1; else tranq97=0;
            if wt97 = 0 then wt97=.;

%nur99(keep=wt99 mi99 db99 hbp99 str99  ang99 chol99 cabg99 
            ocan99  brcn99   can99  bcc99    scc99 
            tcyc99  przc99   zol99  paxil99  antid99 ssri99
            thiaz99 aht99 hbptx99 val99 tranq99
            stati99 staty99 oclrx99 hchtx99 hchtx93 hchtx95 hchtx97 cpreg99 preg99 husbe99);
            can99=0; if brcn99=1 or ocan99=1 or bcc99=1 or scc99=1 then can99=1;
            ssri99=0; if przc99=1 or zol99=1 or paxil99=1 then ssri99=1;
            antid99=0;  if tcyc99=1 then antid99=1;  
            if thiaz99=1 or aht99=1 then hbptx99=1; else hbptx99=0;
            if val99=1 then tranq99=1; else tranq99=0;
            if stati99=1 or oclrx99=1 then hchtx99=1; else hchtx99=0;
            if staty99=1 then hchtx99=1; 
            else if staty99=2 then hchtx95=1;
            else if staty99=3 then hchtx93=1; 
            hchtx97=hchtx95;
            if wt99 = 0 then wt99=.;

%nur01(keep=wt01 sittv01 sleep01 mi01 db01 hbp01 str01 ang01 chol01 cabg01    
            ocan01  brcn01   can01   bcc01    scc01           
            prozc01 zol01    paxil01 celex01  antid01  ssri01
            thiaz01 lasix01  ccblo01  betab01 ace01 bprx01 hbptx01
            stat01 oclrx01 hchtx01
            val01   tranq01
            insul01 ohypo01  dbtx01   
            depre01 depdr01  mnp01  pmh01 
            marry01 divor01 widow01 nvmar01 separ01 q27pt01
            alone01 husb01 afam01 othlv01 mchld01 q28pt01
            sleep01 snore01 cpreg01 preg01 marry01 alone01 incom01); 
            can01=0;
            if brcn01=1 or ocan01=1 or bcc01=1 or scc01=1 then can01=1;
            ssri01=0; if prozc01=1 or zol01=1 or paxil01=1 or celex01=1 then ssri01=1;  
            if antid01 ne 1 then antid01=0;
            if thiaz01=1 or lasix01=1 or ccblo01=1 or betab01=1 or ace01=1 or bprx01=1 then hbptx01=1; else hbptx01=0;
            if stat01=1 or oclrx01=1 then hchtx01=1; else hchtx01=0;
            if insul01=1 or ohypo01=1 then dbtx01=1; else dbtx01=0;
            if val01=1 then tranq01=1; else tranq01=0;
            if wt01 = 0 then wt01=.;
            select(sleep01);
            when (1,2,3) sleep01c=4;
            when (4)     sleep01c=3;
            when (5)     sleep01c=2;
            when (6)     sleep01c=1;
            when (7)     sleep01c=5;
            otherwise    sleep01c=9;
            end;
            sleep01=sleep01c;
            select(snore01);
            when (1,2,3)  snore01c=1;
            when (4)  snore01c=2;
            when (5)  snore01c=3;
            otherwise snore01c=9;
            end;
            snore01=snore01c;
            run;

%nur03(keep=wt03 mi03 db03 hbp03 str03 ang03 chol03 cabg03
            ocan03  brcn03   can03   bcc03    scc03
            ssri03 prozc03 zol03 paxil03 celex03 antid03
            thiaz03 lasix03 k03 ccblo03 betab03 ace03 bprx03 hbptx03
            insul03 ohypo03 dbtx03 
            stat03  hchtx03 
            val03 tranq03
            mnp03 pmh03  depr03 deprd03 depre03 cpreg03 preg03); 
            can03=0;
            if brcn03=1 or ocan03=1 or bcc03=1 or scc03=1 then can03=1;
            ssri03=0; if prozc03=1 or zol03=1 or paxil03=1 or celex03=1 then ssri03=1;  
            if antid03 ne 1 then antid03=0;
            if thiaz03=1 or k03=1 or lasix03=1 or ccblo03=1 or betab03=1 or ace03=1 or bprx03=1 then hbptx03=1; else hbptx03=0;
            if stat03=1 then hchtx03=1; else hchtx03=0;
            if insul03=1 or ohypo03=1 then dbtx03=1; else dbtx03=0;
            if val03=1 then tranq03=1; else tranq03=0;
            if q14pt03=1 and nomed03 ne 1 then medpt03=1; else medpt03=0;
            if wt03 = 0 then wt03=.;

%nur05(keep=wt05 sittv05 mi05 db05 hbp05 str05 ang05 chol05 cabg05 
            ssri05  antid05   
            ocan05  brcn05   can05    bcc05    scc05 
            hbptx05 thiaz05  lasix05  k05      ccblo05  betab05 ace05 angio05 bprx05 
            hchtx05 mev05    zoc05    crest05  prav05   lip05   lesc05 ochol05  
            dbtx05  insul05  ohypo05 
            valiu05 tranq05  
            marry05 divor05 widow05 nvrmr05 separ05 dompa05 q23pt05
            alone05 husb05 ofam05 othlv05 mchld05 q24pt05
            depr05 deprd05  depre05 waist05 hip05  
            bus05 indrs05 space05 incur05 htsc05  panic05 worry05 out05 cpreg05 preg05
            mhome05 mprof05 mexec05 mdk05 fhome05 fprof05 fexec05 fdk05);/* anxiety score*/
            can05=0;
            if brcn05=1 or ocan05=1 or bcc05=1 or scc05=1 then can05=1;
            if ssri05 ne 1 then ssri05=0; if antid05 ne 1 then antid05=0; 
            if thiaz05=1 or k05=1 or lasix05=1 or ccblo05=1 or betab05=1 or ace05=1 or angio05=1 or bprx05=1 then hbptx05=1; else hbptx05=0;
            if mev05=1 or zoc05=1 or crest05=1 or prav05=1 or lip05=1 or lesc05=1 or ochol05=1 then hchtx05=1; else hchtx05=0;
            if  insul05=1 or ohypo05=1 then dbtx05=1; else dbtx05=0;
            if valiu05=1 then tranq05=1; else tranq05=0; 
            if wt05 = 0 then wt05=.;


%nur07(keep=wt07 mi07 db07 hbp07 str07 ang07 chol07 cabg07  
            can07    ocan07  brcn07   bcc07    scc07
            ssri07  antid07 
            hbptx07 thiaz07 lasix07 ccblo07 betab07 ace07 angio07 bprx07 
            hchtx07  mev07 zoc07 crest07 prav07 lip07 lesc07 ochol07 
            dbtx07  insul07 ohypo07
            valiu07 tranq07  
            depr07 deprd07 depre07 mnp07 cpreg07 preg07);
            can07=0;
            if brcn07=1 or ocan07=1 or bcc07=1 or scc07=1 then can07=1;
            if ssri07 ne 1 then ssri07=0; if antid07 ne 1 then antid07=0; 
            if thiaz07=1 or lasix07=1 or ccblo07=1 or betab07=1 or ace07=1 or angio07=1 or bprx07=1 then hbptx07=1; else hbptx07=0;
            if mev07=1 or zoc07=1 or crest07=1 or prav07=1 or lip07=1 or lesc07=1 or ochol07=1 then hchtx07=1; else hchtx07=0;
            if  insul07=1 or ohypo07=1 then dbtx07=1; else dbtx07=0;
            if valiu07=1 then tranq07=1; else tranq07=0;  
            if wt07 = 0 then wt07=.;       
            run;

%nur09(keep=wt09 mi09 db09 hbp09 str09 ang09 chol09 cabg09    
            can09    ocan09  brcn09   bcc09    scc09
            ssri09  antid09 
            hbptx09 thiaz09 lasix09 ccblo09 betab09 ace09 angio09 bprx09 
            hchtx09  mev09 zoc09 crest09 prav09 lip09 ostat09 ochol09 
            dbtx09  insul09 ohypo09
            valiu09 tranq09 
            marry09 divor09 widow09 nvrmr09 separ09 dompa09 
            alone09 husb09 ofam09 othlv09 mchld09 
            depr09 deprd09 depre09 mnp09 preg09 sittv09);
            can09=0;
            if brcn09=1 or ocan09=1 or bcc09=1 or scc09=1 then can09=1;
            if ssri09 ne 1 then ssri09=0; if antid09 ne 1 then antid09=0; 
            if thiaz09=1 or lasix09=1 or ccblo09=1 or betab09=1 or ace09=1 or angio09=1 or bprx09=1 then hbptx09=1; else hbptx09=0;
            if mev09=1 or zoc09=1 or crest09=1 or prav09=1 or lip09=1 or ostat09=1 or ochol09=1 then hchtx09=1; else hchtx09=0;
            if  insul09=1 or ohypo09=1 then dbtx09=1; else dbtx09=0;
            if valiu09=1 then tranq09=1; else tranq09=0;  
            if wt09 = 0 then wt09=.;       
            run;    

%nur11(keep=wt11 mi11 db11 hbp11 str11 ang11 chol11 cabg11  
            can11    ocan11  brcn11   bcc11    scc11
            ssri11  antid11 
            hbptx11 thiaz11 lasix11 ccblo11 betab11 ace11 angio11 bprx11 
            hchtx11  mev11 zoc11 crest11 prav11 lip11 ostat11 oclrx11
            dbtx11  insul11 ohypo11
            valiu11);
            can11=0;
            if brcn11=1 or ocan11=1 or bcc11=1 or scc11=1 then can11=1;
            if ssri11 ne 1 then ssri11=0; if antid11 ne 1 then antid11=0; 
            if thiaz11=1 or lasix11=1 or ccblo11=1 or betab11=1 or ace11=1 or angio11=1 or bprx11=1 then hbptx11=1; else hbptx11=0;
            if mev11=1 or zoc11=1 or crest11=1 or prav11=1 or lip11=1 or ostat11=1 or oclrx11=1 then hchtx11=1; else hchtx11=0;
            if  insul11=1 or ohypo11=1 then dbtx11=1; else dbtx11=0;
            if valiu11=1 then tranq11=1; else tranq11=0; 
            if wt11 = 0 then wt11=.;        
            run;

%nur13(keep=wt13 mi13 db13 hbp13 str13 ang13 chol13 cabg13     
            can13    ocan13  brcn13   bcc13    scc13
            ssri13  antid13 
            hbptx13 thiaz13 lasix13 ccblo13 betab13 ace13 angio13 bprx13 
            hchtx13  mev13 zoc13 crest13 prav13 lip13 ostat13 oclrx13
            dbtx13  insul13 ohypo13
            valiu13);
            can13=0;
            if brcn13=1 or ocan13=1 or bcc13=1 or scc13=1 then can13=1;
            if ssri13 ne 1 then ssri13=0; if antid13 ne 1 then antid13=0; 
            if thiaz13=1 or lasix13=1 or ccblo13=1 or betab13=1 or ace13=1 or angio13=1 or bprx13=1 then hbptx13=1; else hbptx13=0;
            if mev13=1 or zoc13=1 or crest13=1 or prav13=1 or lip13=1 or ostat13=1 or oclrx13=1 then hchtx13=1; else hchtx13=0;
            if  insul13=1 or ohypo13=1 then dbtx13=1; else dbtx13=0;
            if valiu13=1 then tranq13=1; else tranq13=0; 
            if wt13 = 0 then wt13=.;        
            run;

%nur15(keep=wt15 mi15 db15 hbp15 str15 ang15 chol15 cabg15  
            can15    ocan15  brcn15   bcc15    scc15
            ssri15  antid15 
            hbptx15 thiaz15 lasix15 ccblo15 betab15 ace15 angio15 bprx15 
            hchtx15  mev15 zoc15 crest15 prav15 lip15 ostat15 oclrx15
            dbtx15  insu15 ohypo15
            valiu15);
            can15=0;
            if brcn15=1 or ocan15=1 or bcc15=1 or scc15=1 then can15=1;
            if ssri15 ne 1 then ssri15=0; if antid15 ne 1 then antid15=0; 
            if thiaz15=1 or lasix15=1 or ccblo15=1 or betab15=1 or ace15=1 or angio15=1 or bprx15=1 then hbptx15=1; else hbptx15=0;
            if mev15=1 or zoc15=1 or crest15=1 or prav15=1 or lip15=1 or ostat15=1 or oclrx15=1 then hchtx15=1; else hchtx15=0;
            if  insu15=1 or ohypo15=1 then dbtx15=1; else dbtx15=0;
            if valiu15=1 then tranq15=1; else tranq15=0; 
            if wt15 = 0 then wt15=.;        
            run;

%nur17(keep=wt17 mi17 db17 hbp17 str17 ang17 chol17 cabg17  
            can17    ocan17  brcn17   bcc17    scc17
            ssri17  antid17 
            hbptx17 thiaz17 lasix17 ccblo17 betab17 ace17 angio17 bprx17
            hchtx17  mev17 zoc17 crest17 prav17 lip17 ostat17 oclrx17
            dbtx17  insul17 ohypo17
            valiu17);
            can17=0;
            if brcn17=1 or ocan17=1 or bcc17=1 or scc17=1 then can17=1;
            if ssri17 ne 1 then ssri17=0; if antid17 ne 1 then antid17=0; 
            if thiaz17=1 or lasix17=1 or ccblo17=1 or betab17=1 or ace17=1 or angio17=1 or bprx17=1 then hbptx17=1; else hbptx17=0;
            if mev17=1 or zoc17=1 or crest17=1 or prav17=1 or lip17=1 or ostat17=1 or oclrx17=1 then hchtx17=1; else hchtx17=0;
            if  insul17=1 or ohypo17=1 then dbtx17=1; else dbtx17=0;
            if valiu17=1 then tranq17=1; else tranq17=0; 
            if wt17 = 0 then wt17=.;        
            run;

%nur19(keep=wt19 mi19 db19 hbp19 str19 ang19 chol19 cabg19  
            can19    ocan19  brcn19   bcc19    scc19
            ssri19  antid19 
            hbptx19 thiaz19 ccblo19 betab19 ace19 angio19 bprx19
            hchtx19 stat19 oclrx19
            dbtx19  insul19 ohypo19
            valiu19);
            can19=0;
            if brcn19=1 or ocan19=1 or bcc19=1 or scc19=1 then can19=1;
            if ssri19 ne 1 then ssri19=0; if antid19 ne 1 then antid19=0; 
            if thiaz19=1 or ccblo19=1 or betab19=1 or ace19=1 or angio19=1 or bprx19=1 then hbptx19=1; else hbptx19=0;
            if stat19=1 or oclrx19=1 then hchtx19=1; else hchtx19=0;
            if insul19=1 or ohypo19=1 then dbtx19=1; else dbtx19=0;
            if valiu19=1 then tranq19=1; else tranq19=0; 
            if wt19 = 0 then wt19=.;        
            run;

/*** Diet***/

%n91_nts(keep=aofib91n ceraf91n alco91n calor91n trnss91n sat91n mon91n poly91n gid91n gl91n fol91n chol91n prot91n carbo91n carbden91n protden91n transden91n satden91n polyden91n monden91n);
            carbden91n = (carbo91n*4)/calor91n;
            protden91n = (prot91n*4)/calor91n;
            transden91n = (trnss91n*9)/calor91n;
            satden91n = (sat91n*9)/calor91n;
            polyden91n = (poly91n*9)/calor91n;
            monden91n = (mon91n*9)/calor91n;
            proc sort; by id; run;


%n95_nts(keep=aofib95n ceraf95n alco95n calor95n trnss95n sat95n mon95n poly95n gid95n gl95n fol95n chol95n prot95n carbo95n carbden95n protden95n transden95n satden95n polyden95n monden95n);
            carbden95n = (carbo95n*4)/calor95n;
            protden95n = (prot95n*4)/calor95n;
            transden95n = (trnss95n*9)/calor95n;
            satden95n = (sat95n*9)/calor95n;
            polyden95n = (poly95n*9)/calor95n;
            monden95n = (mon95n*9)/calor95n;
            proc sort; by id; run;

%n99_nts(keep=aofib99n ceraf99n alco99n calor99n trn0099n sat99n mon99n poly99n gid99n gl99n fol9899n chol99n prot99n carbo99n carbden99n protden99n transden99n satden99n polyden99n monden99n);
            carbden99n = (carbo99n*4)/calor99n;
            protden99n = (prot99n*4)/calor99n;
            transden99n = (trn0099n*9)/calor99n;
            satden99n = (sat99n*9)/calor99n;
            polyden99n = (poly99n*9)/calor99n;
            monden99n = (mon99n*9)/calor99n;
            proc sort; by id; run;

%n03_nts(keep=aofib03n ceraf03n alco03n calor03n trn0203n sat03n mon03n poly03n gid03n gl03n fol9803n chol03n prot03n carbo03n carbden03n protden03n transden03n satden03n polyden03n monden03n);
            carbden03n = (carbo03n*4)/calor03n;
            protden03n = (prot03n*4)/calor03n;
            transden03n = (trn0203n*9)/calor03n;
            satden03n = (sat03n*9)/calor03n;
            polyden03n = (poly03n*9)/calor03n;
            monden03n = (mon03n*9)/calor03n;
            proc sort; by id; run;

%n07_nts(keep=aofib07n ceraf07n alco07n calor07n trn0707n sat07n mon07n poly07n gid07n gl07n fol9807n chol07n prot07n carbo07n carbden07n protden07n transden07n satden07n polyden07n monden07n);
            carbden07n = (carbo07n*4)/calor07n;
            protden07n = (prot07n*4)/calor07n;
            transden07n = (trn0707n*9)/calor07n;
            satden07n = (sat07n*9)/calor07n;
            polyden07n = (poly07n*9)/calor07n;
            monden07n = (mon07n*9)/calor07n;
            proc sort; by id; run;

%n11_nts(keep=aofib11n ceraf11n alco11n calor11n trn1111n sat11n mon11n poly11n gid11n gl11n fol9811n chol11n prot11n carbo11n carbden11n protden11n transden11n satden11n polyden11n monden11n);
            carbden11n = (carbo11n*4)/calor11n;
            protden11n = (prot11n*4)/calor11n;
            transden11n = (trn1111n*9)/calor11n;
            satden11n = (sat11n*9)/calor11n;
            polyden11n = (poly11n*9)/calor11n;
            monden11n = (mon11n*9)/calor11n;
            proc sort; by id; run;

%n15_nts(keep=aofib15n ceraf15n alco15n calor15n trn1115n sat15n mon15n poly15n gid15n gl15n fol9815n chol15n prot15n carbo15n carbden15n protden15n transden15n satden15n polyden15n monden15n);
            carbden15n = (carbo15n*4)/calor15n;
            protden15n = (prot15n*4)/calor15n;
            transden15n = (trn1115n*9)/calor15n;
            satden15n = (sat15n*9)/calor15n;
            polyden15n = (poly15n*9)/calor15n;
            monden15n = (mon15n*9)/calor15n;
            proc sort; by id; run;

%n19_nts(keep=aofib19n ceraf19n alco19n calor19n sat19n mon19n poly19n gid19n gl19n fol9819n chol19n prot19n carbo19n carbden19n protden19n satden19n polyden19n monden19n);
            carbden19n = (carbo19n*4)/calor19n;
            protden19n = (prot19n*4)/calor19n;
            satden19n = (sat19n*9)/calor19n;
            polyden19n = (poly19n*9)/calor19n;
            monden19n = (mon19n*9)/calor19n;
            proc sort; by id; run;

%supp8915(keep=id mvitu89   mvitu91    mvitu93   mvitu95   mvitu97   mvitu99   mvitu01   mvitu03   mvitu05    mvitu07    mvitu09   mvitu11  mvitu13  mvitu15
                viteu91    viteu93   viteu95   viteu97   viteu99   viteu01   viteu03   viteu05    viteu07    viteu09   viteu11  viteu13  viteu15);
proc sort;by id;run;

/*******************************************************************

Main Exposures - nSES - pull in all Census years for all addresses

Note: Use %nses8917(keep= ); if you want to select date only on 
      certain exposures
      

********************************************************************/
%nses8917;
run;

data nses8917;
   set nses8917;
   keep id division: region: mdinc: mdvhs: pcolled: pfaminterest:
             pfwchbf: phs: pnohs: pkid: pold: pohse: popd: ppov: pwht: ;
run;
proc sort data=nses8917; by id; run;


**************************************************
*             baseline data                      *
**************************************************;

data baseline0;         
    merge mi_all cabg deadff1 stroke ahei2010_9115 act8917 familyhis meds8917 aheinhs2
          der8917 (in=mstr) act8917 nur89 nur91 nur93 nur95 nur97 nur99 nur01 nur03 nur05 nur07 nur09
          nur11 nur13 nur15 nur17 nur19 n91_nts n95_nts n99_nts n03_nts n07_nts supp8915
          n11_nts n15_nts diab_case foods nses8917 end=_end_
          ;
    by id;         
    exrec=1;
    if first.id and mstr then exrec=0;  

    /* make fewer categories for income */
    incomemiss=0;
    if incom01 in (1,2,3,4,5) then perinc=1;
    else if incom01 = 6 then perinc=2;
    else if incom01 = 7 then perinc=3;
    else if incom01 in (8,9) then perinc=4;
    else if incom01 =. or incom01 = 10 then do;
    perinc=9;
    incomemiss=1;
    end;
    
    %indic3(vbl=perinc, prefix=perinc, min=1, max=4, reflev=1, missing=9, usemiss=1, 
        label1='less than 50k', 
        label2='50-75k', 
        label3='75-100k',
        label4='more than 100k');
    
/* husband education */
    if husbe99 in (1,2)   then eduhus=1;
    else if husbe99 in (3,4,5) then eduhus=2;
    else                            eduhus=6;
    
    %indic3(vbl=eduhus, prefix=husbe, min=1, max=2, reflev=1, missing=6, usemiss=1,
            label1='high school',
            label2='college and grad school',
            label6='missing or not married');


/*parents occupation at birth*/
if mhome05=1 then momocc=1; *housewife;
   else if mprof05=1 or mexec05=1 then momocc=2; *professional or manager mom;
   else if mdk05^=1 then momocc=3; *other jobs;
   else if mdk05=1 then momocc=4; *missing;

    %indic3(vbl=momocc, prefix=momocc, min=2, max=3, reflev=1, missing=4, usemiss=1,
            label1='housewife mom',
            label2='professional or manager mom',
            label3='other job mom'
            label6='unk mom job');

if fhome05=1 then dadocc=1; *housedad;
   else if fprof05=1 or fexec05=1 then dadocc=2; *professional or manager dad;
   else if fdk05^=1 then dadocc=3; *other jobs;
   else if fdk05=1 then dadocc=4; *missing;

    %indic3(vbl=dadocc, prefix=dadocc, min=2, max=3, reflev=1, missing=4, usemiss=1,
            label1='househusband',
            label2='professional or manager dad',
            label3='other job dad'
            label6='unk dad job'); 

retmo19=retmo17+24;
age19=age17+24;
run;

proc univariate data=baseline0;var birthday;run;

proc freq data= baseline0;tables mrace8905*eth8905;run;
proc freq data= baseline0;tables catrace;run;

proc means data=baseline0 n mean median min max;
var bmi91 act91m;
run;

proc means data=baseline0 n mean std median; var bmi91;run;

proc freq data=baseline0;tables mi99 db99 ang99 str99;run;



data one;
   set baseline0 end=_end_;

if hbp89 = 1 or hbp91 = 1 or hbp93 = 1 or hbp95 = 1 or hbp97 = 1 or hbp99 = 1 or hbp01 = 1 or hbp03 = 1 or hbp05 = 1 or hbp07 = 1 or hbp09 = 1 or hbp11 = 1 then hxhbp=1; else hxhbp = 0;
if chol89 = 1 or chol91 = 1 or chol93 = 1 or chol95 = 1 or chol97 = 1 or chol99 = 1 or chol01 = 1 or chol03 = 1 or chol05 = 1 or chol07 = 1 or chol09 = 1 or chol11 = 1 then hxchol=1; else hxchol = 0;
if db89 = 1 or db91 = 1 or db93 = 1 or db95 = 1 or db97 = 1 or db99 = 1 or db01 = 1 or db03 = 1 or db05 = 1 or db07 = 1 or db09 = 1 or db11 = 1 then hxdb = 1; else hxdb = 0;
if mi89 = 1 or mi91 = 1 or mi93 = 1 or mi95 = 1 or mi97 = 1 or mi99 = 1 or mi01 = 1 or mi03 = 1 or mi05 = 1 or mi07 = 1 or mi09 = 1 or mi11 = 1 or 
ang91=1 or ang93=1 or ang95=1 or ang97=1 or ang99=1 or ang01=1 or ang03=1 or ang05=1 or ang07=1 or ang09=1 or ang11=1 or 
str89 = 1 or str91 = 1 or str93 = 1 or str95 = 1 or str97 = 1 or str99 = 1 or str01 = 1 or  str03 = 1 or  str05 = 1 or  str07 = 1 or  str09 = 1 or  str11 = 1 or 
cabg99=1 then hxcvd = 1; else hxcvd = 0;
if can89 = 1 or can91 = 1 or can93 = 1 or can95 = 1 or can97 = 1 or can99 = 1 or can01 = 1 or can03 = 1 or can05 = 1 or can07 = 1 or can09 = 1 or can11 = 1 then hxcan = 1; else hxcan = 0;
 
array nocum91 {*}  aofib91n ceraf91n alco91n calor91n trnss91n sat91n mon91n poly91n gid91n fol91n prot91n carbo91n carbden91n protden91n transden91n satden91n polyden91n monden91n tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d whgrn91n rfgrn91n whgrns91d rfgrns91d gl91n afat91d vfat91d ahei91 aheinoal91 aheinopt91 aheifisha91 aheidairy91 aheinutbl91 aheipoult91 aheineggs91;  
array nocum95 {*}  aofib95n ceraf95n alco95n calor95n trnss95n sat95n mon95n poly95n gid95n fol95n prot95n carbo95n carbden95n protden95n transden95n satden95n polyden95n monden95n tpotat95d bbmpot95d fpotat95d chipss95d prmeat95d urmeat95d trmeat95d poultr95d fishal95d regegg95d hdairy95d ldairy95d /*soypro95d*/ nutsal95d legume95d fruits95d vegeal95d nstveg95d staveg95d tdairy95d coffee95d nutleg95d bwrice95d wtrice95d SSB95d  whgrn95n rfgrn95n whgrns95d rfgrns95d gl95n afat95d vfat95d ahei95 aheinoal95 aheinopt95 aheifisha95 aheidairy95 aheinutbl95 aheipoult95 aheineggs95;  
array nocum99 {*}  aofib99n ceraf99n alco99n calor99n trn0099n sat99n mon99n poly99n gid99n fol9899n prot99n carbo99n carbden99n protden99n transden99n satden99n polyden99n monden99n tpotat99d bbmpot99d fpotat99d chipss99d prmeat99d urmeat99d trmeat99d poultr99d fishal99d regegg99d hdairy99d ldairy99d /*soypro99d*/ nutsal99d legume99d fruits99d vegeal99d nstveg99d staveg99d tdairy99d coffee99d nutleg99d bwrice99d wtrice99d SSB99d  whgrn99n rfgrn99n whgrns99d rfgrns99d gl99n afat99d vfat99d ahei99 aheinoal99 aheinopt99 aheifisha99 aheidairy99 aheinutbl99 aheipoult99 aheineggs99;  
array nocum03 {*}  aofib03n ceraf03n alco03n calor03n trn0203n sat03n mon03n poly03n gid03n fol9803n prot03n carbo03n carbden03n protden03n transden03n satden03n polyden03n monden03n tpotat03d bbmpot03d fpotat03d chipss03d prmeat03d urmeat03d trmeat03d poultr03d fishal03d regegg03d hdairy03d ldairy03d /*soypro03d*/ nutsal03d legume03d fruits03d vegeal03d nstveg03d staveg03d tdairy03d coffee03d nutleg03d bwrice03d wtrice03d SSB03d whgrn03n rfgrn03n whgrns03d rfgrns03d gl03n afat03d vfat03d ahei03 aheinoal03 aheinopt03 aheifisha03 aheidairy03 aheinutbl03 aheipoult03 aheineggs03;  
array nocum07 {*}  aofib07n ceraf07n alco07n calor07n trn0707n sat07n mon07n poly07n gid07n fol9807n prot07n carbo07n carbden07n protden07n transden07n satden07n polyden07n monden07n tpotat07d bbmpot07d fpotat07d chipss07d prmeat07d urmeat07d trmeat07d poultr07d fishal07d regegg07d hdairy07d ldairy07d /*soypro07d*/ nutsal07d legume07d fruits07d vegeal07d nstveg07d staveg07d tdairy07d coffee07d nutleg07d bwrice07d wtrice07d SSB07d whgrn07n rfgrn07n whgrns07d rfgrns07d gl07n afat07d vfat07d ahei07 aheinoal07 aheinopt07 aheifisha07 aheidairy07 aheinutbl07 aheipoult07 aheineggs07;  
array nocum11 {*}  aofib11n ceraf11n alco11n calor11n trn1111n sat11n mon11n poly11n gid11n fol9811n prot11n carbo11n carbden11n protden11n transden11n satden11n polyden11n monden11n tpotat11d bbmpot11d fpotat11d chipss11d prmeat11d urmeat11d trmeat11d poultr11d fishal11d regegg11d hdairy11d ldairy11d /*soypro11d*/ nutsal11d legume11d fruits11d vegeal11d nstveg11d staveg11d tdairy11d coffee11d nutleg11d bwrice11d wtrice11d SSB11d whgrn11n rfgrn11n whgrns11d rfgrns11d gl11n afat11d vfat11d ahei11 aheinoal11 aheinopt11 aheifisha11 aheidairy11 aheinutbl11 aheipoult11 aheineggs11;
array nocum15 {*}  aofib15n ceraf15n alco15n calor15n trn1115n sat15n mon15n poly15n gid15n fol9815n prot15n carbo15n carbden15n protden15n transden15n satden15n polyden15n monden15n tpotat15d bbmpot15d fpotat15d chipss15d prmeat15d urmeat15d trmeat15d poultr15d fishal15d regegg15d hdairy15d ldairy15d /*soypro15d*/ nutsal15d legume15d fruits15d vegeal15d nstveg15d staveg15d tdairy15d coffee15d nutleg15d bwrice15d wtrice15d SSB15d whgrn15n rfgrn15n whgrns15d rfgrns15d gl15n afat15d vfat15d ahei15 aheinoal15 aheinopt15 aheifisha15 aheidairy15 aheinutbl15 aheipoult15 aheineggs15;
array nocum19 {*}  aofib19n ceraf19n alco19n calor19n trn1115n sat19n mon19n poly19n gid19n fol9819n prot19n carbo19n carbden19n protden19n transden15n satden19n polyden19n monden19n tpotat19d bbmpot19d fpotat19d chipss19d prmeat19d urmeat19d trmeat19d poultr19d fishal19d regegg19d hdairy19d ldairy19d /*soypro19d*/ nutsal19d legume19d fruits19d vegeal19d nstveg19d staveg19d tdairy19d coffee19d nutleg19d bwrice19d wtrice19d SSB19d whgrn19n rfgrn19n whgrns19d rfgrns19d gl19n afat19d vfat19d ahei19 aheinoal19 aheinopt19 aheifisha19 aheidairy19 aheinutbl19 aheipoult19 aheineggs19;

array cumul91 {*}  aofib91ca ceraf91ca alco91ca calor91ca trnss91ca sat91ca mon91ca poly91ca gid91ca fol91ca prot91ca carbo91ca carbden91ca protden91ca transden91ca satden91ca polyden91ca monden91ca tpotat91ca bbmpot91ca fpotat91ca chipss91ca prmeat91ca urmeat91ca trmeat91ca poultr91ca fishal91ca regegg91ca hdairy91ca ldairy91ca /*soypro91ca*/ nutsal91ca legume91ca fruits91ca vegeal91ca nstveg91ca staveg91ca tdairy91ca coffee91ca nutleg91ca bwrice91ca wtrice91ca SSB91ca whgrn91ca rfgrn91ca whgrns91ca rfgrns91ca gl91ca afat91ca vfat91ca ahei91ca aheinoal91ca aheinopt91ca aheifisha91ca aheidairy91ca aheinutbl91ca aheipoult91ca aheineggs91ca; 
array cumul95 {*}  aofib95ca ceraf95ca alco95ca calor95ca trnss95ca sat95ca mon95ca poly95ca gid95ca fol95ca prot95ca carbo95ca carbden95ca protden95ca transden95ca satden95ca polyden95ca monden95ca tpotat95ca bbmpot95ca fpotat95ca chipss95ca prmeat95ca urmeat95ca trmeat95ca poultr95ca fishal95ca regegg95ca hdairy95ca ldairy95ca /*soypro95ca*/ nutsal95ca legume95ca fruits95ca vegeal95ca nstveg95ca staveg95ca tdairy95ca coffee95ca nutleg95ca bwrice95ca wtrice95ca SSB95ca whgrn95ca rfgrn95ca whgrns95ca rfgrns95ca gl95ca afat95ca vfat95ca ahei95ca aheinoal95ca aheinopt95ca aheifisha95ca aheidairy95ca aheinutbl95ca aheipoult95ca aheineggs95ca;  
array cumul99 {*}  aofib99ca ceraf99ca alco99ca calor99ca trn0099ca sat99ca mon99ca poly99ca gid99ca fol9899ca prot99ca carbo99ca carbden99ca protden99ca transden99ca satden99ca polyden99ca monden99ca tpotat99ca bbmpot99ca fpotat99ca chipss99ca prmeat99ca urmeat99ca trmeat99ca poultr99ca fishal99ca regegg99ca hdairy99ca ldairy99ca /*soypro99ca*/ nutsal99ca legume99ca fruits99ca vegeal99ca nstveg99ca staveg99ca tdairy99ca coffee99ca nutleg99ca bwrice99ca wtrice99ca SSB99ca whgrn99ca rfgrn99ca whgrns99ca rfgrns99ca gl99ca afat99ca vfat99ca ahei99ca aheinoal99ca aheinopt99ca aheifisha99ca aheidairy99ca aheinutbl99ca aheipoult99ca aheineggs99ca;   
array cumul03 {*}  aofib03ca ceraf03ca alco03ca calor03ca trn0203ca sat03ca mon03ca poly03ca gid03ca fol9803ca prot03ca carbo03ca carbden03ca protden03ca transden03ca satden03ca polyden03ca monden03ca tpotat03ca bbmpot03ca fpotat03ca chipss03ca prmeat03ca urmeat03ca trmeat03ca poultr03ca fishal03ca regegg03ca hdairy03ca ldairy03ca /*soypro03ca*/ nutsal03ca legume03ca fruits03ca vegeal03ca nstveg03ca staveg03ca tdairy03ca coffee03ca nutleg03ca bwrice03ca wtrice03ca SSB03ca whgrn03ca rfgrn03ca whgrns03ca rfgrns03ca gl03ca afat03ca vfat03ca ahei03ca aheinoal03ca aheinopt03ca aheifisha03ca aheidairy03ca aheinutbl03ca aheipoult03ca aheineggs03ca;  
array cumul07 {*}  aofib07ca ceraf07ca alco07ca calor07ca trn0707ca sat07ca mon07ca poly07ca gid07ca fol9807ca prot07ca carbo07ca carbden07ca protden07ca transden07ca satden07ca polyden07ca monden07ca tpotat07ca bbmpot07ca fpotat07ca chipss07ca prmeat07ca urmeat07ca trmeat07ca poultr07ca fishal07ca regegg07ca hdairy07ca ldairy07ca /*soypro07ca*/ nutsal07ca legume07ca fruits07ca vegeal07ca nstveg07ca staveg07ca tdairy07ca coffee07ca nutleg07ca bwrice07ca wtrice07ca SSB07ca whgrn07ca rfgrn07ca whgrns07ca rfgrns07ca gl07ca afat07ca vfat07ca ahei07ca aheinoal07ca aheinopt07ca aheifisha07ca aheidairy07ca aheinutbl07ca aheipoult07ca aheineggs07ca;  
array cumul11 {*}  aofib11ca ceraf11ca alco11ca calor11ca trn1111ca sat11ca mon11ca poly11ca gid11ca fol9811ca prot11ca carbo11ca carbden11ca protden11ca transden11ca satden11ca polyden11ca monden11ca tpotat11ca bbmpot11ca fpotat11ca chipss11ca prmeat11ca urmeat11ca trmeat11ca poultr11ca fishal11ca regegg11ca hdairy11ca ldairy11ca /*soypro11ca*/ nutsal11ca legume11ca fruits11ca vegeal11ca nstveg11ca staveg11ca tdairy11ca coffee11ca nutleg11ca bwrice11ca wtrice11ca SSB11ca whgrn11ca rfgrn11ca whgrns11ca rfgrns11ca gl11ca afat11ca vfat11ca ahei11ca aheinoal11ca aheinopt11ca aheifisha11ca aheidairy11ca aheinutbl11ca aheipoult11ca aheineggs11ca;
array cumul15 {*}  aofib15ca ceraf15ca alco15ca calor15ca trn1115ca sat15ca mon15ca poly15ca gid15ca fol9815ca prot15ca carbo15ca carbden15ca protden15ca transden15ca satden15ca polyden15ca monden15ca tpotat15ca bbmpot15ca fpotat15ca chipss15ca prmeat15ca urmeat15ca trmeat15ca poultr15ca fishal15ca regegg15ca hdairy15ca ldairy15ca /*soypro15ca*/ nutsal15ca legume15ca fruits15ca vegeal15ca nstveg15ca staveg15ca tdairy15ca coffee15ca nutleg15ca bwrice15ca wtrice15ca SSB15ca whgrn15ca rfgrn15ca whgrns15ca rfgrns15ca gl15ca afat15ca vfat15ca ahei13ca aheinoal15ca aheinopt15ca aheifisha15ca aheidairy15ca aheinutbl15ca aheipoult15ca aheineggs15ca;
array cumul19 {*}  aofib19ca ceraf19ca alco19ca calor19ca trn1115ca sat19ca mon19ca poly19ca gid19ca fol9819ca prot19ca carbo19ca carbden19ca protden19ca transden15ca satden19ca polyden19ca monden19ca tpotat19ca bbmpot19ca fpotat19ca chipss19ca prmeat19ca urmeat19ca trmeat19ca poultr19ca fishal19ca regegg19ca hdairy19ca ldairy19ca /*soypro19ca*/ nutsal19ca legume19ca fruits19ca vegeal19ca nstveg19ca staveg19ca tdairy19ca coffee19ca nutleg19ca bwrice19ca wtrice19ca SSB19ca whgrn19ca rfgrn19ca whgrns19ca rfgrns19ca gl19ca afat19ca vfat19ca ahei19ca aheinoal19ca aheinopt19ca aheifisha19ca aheidairy19ca aheinutbl19ca aheipoult19ca aheineggs19ca;


do i = 1 to DIM(cumul19);
        cumul91{i} = nocum91{i};
        cumul95{i} = mean(nocum91{i}, nocum95{i});
        cumul99{i} = mean(nocum91{i}, nocum95{i}, nocum99{i});
        cumul03{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i});
        cumul07{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i});
        cumul11{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i});
        cumul15{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i}, nocum15{i});
        cumul19{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i}, nocum15{i}, nocum19{i});
end;

run;

data two;
   set one end=_end_;   

array irt   {6}  retmo11  retmo13  retmo15  retmo17  retmo19 cutoff;
array perioda  {5}  period1  period2  period3  period4 period5 ;
array tvar  {5}  t11   t13   t15  t17   t19;
array age   {5}  age11  age13  age15 age17 age19;
array aspyn {5}  asp11 asp13 asp15 asp17 asp17;
array hbp   {5}  hbp11 hbp13 hbp15 hbp17 hbp19; 
array chol  {5}  chol11 chol13 chol15 chol17 chol19;
array db    {5}  db11 db13 db15 db17 db19;
array nsmk  {5}  smkdr11  smkdr13  smkdr15 smkdr17 smkdr17;
array bmi   {5}  bmi11   bmi13  bmi15 bmi17  bmi17;
array actm  {5}  act09m act13m act13m act17m act17m;
array horm  {5}  nhor11  nhor13  nhor15 nhor17 nhor17;
array mvit  {5}   mvitu11  mvitu13  mvitu15 mvitu15 mvitu15;
array antihp   {5}  hbptx11 hbptx13 hbptx15 hbptx17 hbptx19;
array antitc   {5}  hchtx11 hchtx13 hchtx15 hchtx17 hchtx19;


array calorca  {15}  calor91ca calor91ca calor95ca calor95ca calor99ca calor99ca calor03ca calor03ca calor07ca calor07ca calor11ca calor11ca calor15ca calor15ca calor19ca;
array aofibca  {15}  aofib91ca aofib91ca aofib95ca aofib95ca aofib99ca aofib99ca aofib03ca aofib03ca aofib07ca aofib07ca aofib11ca aofib11ca aofib15ca aofib15ca aofib19ca;
array cerafca  {15}  ceraf91ca ceraf91ca ceraf95ca ceraf95ca ceraf99ca ceraf99ca ceraf03ca ceraf03ca ceraf07ca ceraf07ca ceraf11ca ceraf11ca ceraf15ca ceraf15ca ceraf19ca;
array alcoca  {15}  alco91ca alco91ca alco95ca alco95ca alco99ca alco99ca alco03ca alco03ca alco07ca alco07ca alco11ca alco11ca alco15ca alco15ca alco19ca;
array satfca  {15}  sat91ca sat91ca sat95ca sat95ca sat99ca sat99ca sat03ca sat03ca sat07ca sat07ca sat11ca sat11ca sat15ca sat15ca sat19ca;
array satfdenca  {15}  satden91ca satden91ca satden95ca satden95ca satden99ca satden99ca satden03ca satden03ca satden07ca satden07ca satden11ca satden11ca satden15ca satden15ca satden19ca;
array monfca  {15}  mon91ca mon91ca mon95ca mon95ca mon99ca mon99ca mon03ca mon03ca mon07ca mon07ca mon11ca mon11ca mon15ca mon15ca mon19ca;
array monfdenca  {15}  monden91ca monden91ca monden95ca monden95ca monden99ca monden99ca monden03ca monden03ca monden07ca monden07ca monden11ca monden11ca monden15ca monden15ca monden19ca;
array polyfca  {15}  poly91ca poly91ca poly95ca poly95ca poly99ca poly99ca poly03ca poly03ca poly07ca poly07ca poly11ca poly11ca poly15ca poly15ca poly19ca;
array polyfdenca  {15}  polyden91ca polyden91ca polyden95ca polyden95ca polyden99ca polyden99ca polyden03ca polyden03ca polyden07ca polyden07ca polyden11ca polyden11ca polyden15ca polyden15ca polyden19ca;
array transfca  {15}  trnss91ca trnss91ca trnss95ca trnss95ca trn0099ca trn0099ca trn0203ca trn0203ca trn0707ca trn0707ca trn1111ca trn1111ca trn1115ca trn1115ca trn1115ca ;
array transfdenca  {15}  transden91ca transden91ca transden95ca transden95ca transden99ca transden99ca transden03ca transden03ca transden07ca transden07ca transden11ca transden11ca transden15ca transden15ca transden19ca;
array folca  {15}  fol91ca fol91ca fol95ca fol95ca fol9899ca fol9899ca fol9803ca fol9803ca fol9807ca fol9807ca fol9811ca fol9811ca fol9815ca fol9815ca fol9819ca;
array protca  {15}  prot91ca prot91ca prot95ca prot95ca prot99ca prot99ca prot03ca prot03ca prot07ca prot07ca prot11ca prot11ca prot15ca prot15ca prot19ca;
array protdenca  {15}  protden91ca protden91ca protden95ca protden95ca protden99ca protden99ca protden03ca protden03ca protden07ca protden07ca protden11ca protden11ca protden15ca protden15ca protden19ca;
array gidca  {15}  gid91ca gid91ca gid95ca gid95ca gid99ca gid99ca gid03ca gid03ca gid07ca gid07ca gid11ca gid11ca gid15ca gid15ca gid19ca;
array carboca  {15}  carbo91ca carbo91ca carbo95ca carbo95ca carbo99ca carbo99ca carbo03ca carbo03ca carbo07ca carbo07ca carbo11ca carbo11ca carbo15ca carbo15ca carbo19ca;
array carbdenca  {15}  carbden91ca carbden91ca carbden95ca carbden95ca carbden99ca carbden99ca carbden03ca carbden03ca carbden07ca carbden07ca carbden11ca carbden11ca carbden15ca carbden15ca carbden19ca;

array calor  {15}  calor91n calor91n calor95n calor95n calor99n calor99n calor03n calor03n calor07n calor07n calor11n calor11n calor15n calor15n calor19n;
array carbo  {15}  carbo91n carbo91n carbo95n carbo95n carbo99n carbo99n carbo03n carbo03n carbo07n carbo07n carbo11n carbo11n carbo15n carbo15n carbo19n;
array carbden  {15}  carbden91n carbden91n carbden95n carbden95n carbden99n carbden99n carbden03n carbden03n carbden07n carbden07n carbden11n carbden11n carbden15n carbden15n carbden19n;
array prot  {15}  prot91n prot91n prot95n prot95n prot99n prot99n prot03n prot03n prot07n prot07n prot11n prot11n prot15n prot15n prot19n;
array protden  {15}  protden91n protden91n protden95n protden95n protden99n protden99n protden03n protden03n protden07n protden07n protden11n protden11n protden15n protden15n protden19n;
array alco  {15}  alco91n alco91n alco95n alco95n alco99n alco99n alco03n alco03n alco07n alco07n alco11n alco11n alco15n alco15n alco19n;
array ceraf  {15}  ceraf91n ceraf91n ceraf95n ceraf95n ceraf99n ceraf99n ceraf03n ceraf03n ceraf07n ceraf07n ceraf11n ceraf11n ceraf15n ceraf15n ceraf19n;
array aofib  {15}  aofib91n aofib91n aofib95n aofib95n aofib99n aofib99n aofib03n aofib03n aofib07n aofib07n aofib11n aofib11n aofib15n aofib15n aofib19n;
array polyf  {15}  poly91n poly91n poly95n poly95n poly99n poly99n poly03n poly03n poly07n poly07n poly11n poly11n poly15n poly15n poly19n;
array polyfden  {15}  polyden91n polyden91n polyden95n polyden95n polyden99n polyden99n polyden03n polyden03n polyden07n polyden07n polyden11n polyden11n polyden15n polyden15n polyden19n;
array transf  {15}  trnss91n trnss91n trnss95n trnss95n trn0099n trn0099n trn0203n trn0203n trn0707n trn0707n trn1111n trn1111n trn1115n trn1115n trn1115n;
array transfden  {15}  transden91n transden91n transden95n transden95n transden99n transden99n transden03n transden03n transden07n transden07n transden11n transden11n transden15n transden15n transden15n;
array satf  {15}  sat91n sat91n sat95n sat95n sat99n sat99n sat03n sat03n sat07n sat07n sat11n sat11n sat15n sat15n sat19n;
array satfden  {15}  satden91n satden91n satden95n satden95n satden99n satden99n satden03n satden03n satden07n satden07n satden11n satden11n satden15n satden15n satden19n;
array monf  {15}  mon91n mon91n mon95n mon95n mon99n mon99n mon03n mon03n mon07n mon07n mon11n mon11n mon15n mon15n mon19n;
array monfden  {15}  monden91n monden91n monden95n monden95n monden99n monden99n monden03n monden03n monden07n monden07n monden11n monden11n monden15n monden15n monden19n;

array tpotat  {15}  tpotat91d tpotat91d tpotat95d tpotat95d tpotat99d tpotat99d tpotat03d tpotat03d tpotat07d tpotat07d tpotat11d tpotat11d tpotat15d tpotat15d tpotat19d;
array bbmpot  {15}  bbmpot91d bbmpot91d bbmpot95d bbmpot95d bbmpot99d bbmpot99d bbmpot03d bbmpot03d bbmpot07d bbmpot07d bbmpot11d bbmpot11d bbmpot15d bbmpot15d bbmpot19d;
array fpotat  {15}  fpotat91d fpotat91d fpotat95d fpotat95d fpotat99d fpotat99d fpotat03d fpotat03d fpotat07d fpotat07d fpotat11d fpotat11d fpotat15d fpotat15d fpotat19d;
array chipss  {15}  chipss91d chipss91d chipss95d chipss95d chipss99d chipss99d chipss03d chipss03d chipss07d chipss07d chipss11d chipss11d chipss15d chipss15d chipss19d;
array prmeat  {15}  prmeat91d prmeat91d prmeat95d prmeat95d prmeat99d prmeat99d prmeat03d prmeat03d prmeat07d prmeat07d prmeat11d prmeat11d prmeat15d prmeat15d prmeat19d;
array urmeat  {15}  urmeat91d urmeat91d urmeat95d urmeat95d urmeat99d urmeat99d urmeat03d urmeat03d urmeat07d urmeat07d urmeat11d urmeat11d urmeat15d urmeat15d urmeat19d;
array trmeat  {15}  trmeat91d trmeat91d trmeat95d trmeat95d trmeat99d trmeat99d trmeat03d trmeat03d trmeat07d trmeat07d trmeat11d trmeat11d trmeat15d trmeat15d trmeat19d;
array poultr  {15}  poultr91d poultr91d poultr95d poultr95d poultr99d poultr99d poultr03d poultr03d poultr07d poultr07d poultr11d poultr11d poultr15d poultr15d poultr19d;
array fishal  {15}  fishal91d fishal91d fishal95d fishal95d fishal99d fishal99d fishal03d fishal03d fishal07d fishal07d fishal11d fishal11d fishal15d fishal15d fishal19d;
array regegg  {15}  regegg91d regegg91d regegg95d regegg95d regegg99d regegg99d regegg03d regegg03d regegg07d regegg07d regegg11d regegg11d regegg15d regegg15d regegg19d;
array hdairy  {15}  hdairy91d hdairy91d hdairy95d hdairy95d hdairy99d hdairy99d hdairy03d hdairy03d hdairy07d hdairy07d hdairy11d hdairy11d hdairy15d hdairy15d hdairy19d;
array ldairy  {15}  ldairy91d ldairy91d ldairy95d ldairy95d ldairy99d ldairy99d ldairy03d ldairy03d ldairy07d ldairy07d ldairy11d ldairy11d ldairy15d ldairy15d ldairy19d;
array nutsal  {15}  nutsal91d nutsal91d nutsal95d nutsal95d nutsal99d nutsal99d nutsal03d nutsal03d nutsal07d nutsal07d nutsal11d nutsal11d nutsal15d nutsal15d nutsal19d;
array legume  {15}  legume91d legume91d legume95d legume95d legume99d legume99d legume03d legume03d legume07d legume07d legume11d legume11d legume15d legume15d legume19d;
array fruits  {15}  fruits91d fruits91d fruits95d fruits95d fruits99d fruits99d fruits03d fruits03d fruits07d fruits07d fruits11d fruits11d fruits15d fruits15d fruits19d;
array vegeal  {15}  vegeal91d vegeal91d vegeal95d vegeal95d vegeal99d vegeal99d vegeal03d vegeal03d vegeal07d vegeal07d vegeal11d vegeal11d vegeal15d vegeal15d vegeal19d;
array nstveg  {15}  nstveg91d nstveg91d nstveg95d nstveg95d nstveg99d nstveg99d nstveg03d nstveg03d nstveg07d nstveg07d nstveg11d nstveg11d nstveg15d nstveg15d nstveg19d;
array staveg  {15}  staveg91d staveg91d staveg95d staveg95d staveg99d staveg99d staveg03d staveg03d staveg07d staveg07d staveg11d staveg11d staveg15d staveg15d staveg19d;
array tdairy  {15}  tdairy91d tdairy91d tdairy95d tdairy95d tdairy99d tdairy99d tdairy03d tdairy03d tdairy07d tdairy07d tdairy11d tdairy11d tdairy15d tdairy15d tdairy19d;
array coffee  {15}  coffee91d coffee91d coffee95d coffee95d coffee99d coffee99d coffee03d coffee03d coffee07d coffee07d coffee11d coffee11d coffee15d coffee15d coffee19d;
array nutleg  {15}  nutleg91d nutleg91d nutleg95d nutleg95d nutleg99d nutleg99d nutleg03d nutleg03d nutleg07d nutleg07d nutleg11d nutleg11d nutleg15d nutleg15d nutleg19d;
array bwrice  {15}  bwrice91d bwrice91d bwrice95d bwrice95d bwrice99d bwrice99d bwrice03d bwrice03d bwrice07d bwrice07d bwrice11d bwrice11d bwrice15d bwrice15d bwrice19d;
array wtrice  {15}  wtrice91d wtrice91d wtrice95d wtrice95d wtrice99d wtrice99d wtrice03d wtrice03d wtrice07d wtrice07d wtrice11d wtrice11d wtrice15d wtrice15d wtrice19d;
array SSB     {15}  SSB91d SSB91d SSB95d SSB95d SSB99d SSB99d SSB03d SSB03d SSB07d SSB07d SSB11d SSB11d SSB15d SSB15d SSB19d;
array whgrns  {15}  whgrns91d whgrns91d whgrns95d whgrns95d whgrns99d whgrns99d whgrns03d whgrns03d whgrns07d whgrns07d whgrns11d whgrns11d whgrns15d whgrns15d whgrns19d;
array rfgrns  {15}  rfgrns91d rfgrns91d rfgrns95d rfgrns95d rfgrns99d rfgrns99d rfgrns03d rfgrns03d rfgrns07d rfgrns07d rfgrns11d rfgrns11d rfgrns15d rfgrns15d rfgrns19d;
array whgrn  {15}  whgrn91n whgrn91n whgrn95n whgrn95n whgrn99n whgrn99n whgrn03n whgrn03n whgrn07n whgrn07n whgrn11n whgrn11n whgrn15n whgrn15n whgrn19n;
array rfgrn  {15}  rfgrn91n rfgrn91n rfgrn95n rfgrn95n rfgrn99n rfgrn99n rfgrn03n rfgrn03n rfgrn07n rfgrn07n rfgrn11n rfgrn11n rfgrn15n rfgrn15n rfgrn19n;
array gl  {15}  gl91n gl91n gl95n gl95n gl99n gl99n gl03n gl03n gl07n gl07n gl11n gl11n gl15n gl15n gl19n;
array gid  {15}  gid91n gid91n gid95n gid95n gid99n gid99n gid03n gid03n gid07n gid07n gid11n gid11n gid15n gid15n gid19n;
array afat   {15}  afat91d afat91d afat95d afat95d afat99d afat99d afat03d afat03d afat07d afat07d afat11d afat11d afat15d afat15d afat19d;
array vfat   {15}  vfat91d vfat91d vfat95d vfat95d vfat99d vfat99d vfat03d vfat03d vfat07d vfat07d vfat11d vfat11d vfat15d vfat15d vfat19d;


array tpotatca  {15}  tpotat91ca tpotat91ca tpotat95ca tpotat95ca tpotat99ca tpotat99ca tpotat03ca tpotat03ca tpotat07ca tpotat07ca tpotat11ca tpotat11ca tpotat15ca tpotat15ca tpotat19ca;
array bbmpotca  {15}  bbmpot91ca bbmpot91ca bbmpot95ca bbmpot95ca bbmpot99ca bbmpot99ca bbmpot03ca bbmpot03ca bbmpot07ca bbmpot07ca bbmpot11ca bbmpot11ca bbmpot15ca bbmpot15ca bbmpot19ca;
array fpotatca  {15}  fpotat91ca fpotat91ca fpotat95ca fpotat95ca fpotat99ca fpotat99ca fpotat03ca fpotat03ca fpotat07ca fpotat07ca fpotat11ca fpotat11ca fpotat15ca fpotat15ca fpotat19ca;
array chipssca  {15}  chipss91ca chipss91ca chipss95ca chipss95ca chipss99ca chipss99ca chipss03ca chipss03ca chipss07ca chipss07ca chipss11ca chipss11ca chipss15ca chipss15ca chipss19ca;
array prmeatca  {15}  prmeat91ca prmeat91ca prmeat95ca prmeat95ca prmeat99ca prmeat99ca prmeat03ca prmeat03ca prmeat07ca prmeat07ca prmeat11ca prmeat11ca prmeat15ca prmeat15ca prmeat19ca;
array urmeatca  {15}  urmeat91ca urmeat91ca urmeat95ca urmeat95ca urmeat99ca urmeat99ca urmeat03ca urmeat03ca urmeat07ca urmeat07ca urmeat11ca urmeat11ca urmeat15ca urmeat15ca urmeat19ca;
array trmeatca  {15}  trmeat91ca trmeat91ca trmeat95ca trmeat95ca trmeat99ca trmeat99ca trmeat03ca trmeat03ca trmeat07ca trmeat07ca trmeat11ca trmeat11ca trmeat15ca trmeat15ca trmeat19ca;
array poultrca  {15}  poultr91ca poultr91ca poultr95ca poultr95ca poultr99ca poultr99ca poultr03ca poultr03ca poultr07ca poultr07ca poultr11ca poultr11ca poultr15ca poultr15ca poultr19ca;
array fishalca  {15}  fishal91ca fishal91ca fishal95ca fishal95ca fishal99ca fishal99ca fishal03ca fishal03ca fishal07ca fishal07ca fishal11ca fishal11ca fishal15ca fishal15ca fishal19ca;
array regeggca  {15}  regegg91ca regegg91ca regegg95ca regegg95ca regegg99ca regegg99ca regegg03ca regegg03ca regegg07ca regegg07ca regegg11ca regegg11ca regegg15ca regegg15ca regegg19ca;
array hdairyca  {15}  hdairy91ca hdairy91ca hdairy95ca hdairy95ca hdairy99ca hdairy99ca hdairy03ca hdairy03ca hdairy07ca hdairy07ca hdairy11ca hdairy11ca hdairy15ca hdairy15ca hdairy19ca;
array ldairyca  {15}  ldairy91ca ldairy91ca ldairy95ca ldairy95ca ldairy99ca ldairy99ca ldairy03ca ldairy03ca ldairy07ca ldairy07ca ldairy11ca ldairy11ca ldairy15ca ldairy15ca ldairy19ca;
array nutsalca  {15}  nutsal91ca nutsal91ca nutsal95ca nutsal95ca nutsal99ca nutsal99ca nutsal03ca nutsal03ca nutsal07ca nutsal07ca nutsal11ca nutsal11ca nutsal15ca nutsal15ca nutsal19ca;
array legumeca  {15}  legume91ca legume91ca legume95ca legume95ca legume99ca legume99ca legume03ca legume03ca legume07ca legume07ca legume11ca legume11ca legume15ca legume15ca legume19ca;
array fruitsca  {15}  fruits91ca fruits91ca fruits95ca fruits95ca fruits99ca fruits99ca fruits03ca fruits03ca fruits07ca fruits07ca fruits11ca fruits11ca fruits15ca fruits15ca fruits19ca;
array vegealca  {15}  vegeal91ca vegeal91ca vegeal95ca vegeal95ca vegeal99ca vegeal99ca vegeal03ca vegeal03ca vegeal07ca vegeal07ca vegeal11ca vegeal11ca vegeal15ca vegeal15ca vegeal19ca;
array nstvegca  {15}  nstveg91ca nstveg91ca nstveg95ca nstveg95ca nstveg99ca nstveg99ca nstveg03ca nstveg03ca nstveg07ca nstveg07ca nstveg11ca nstveg11ca nstveg15ca nstveg15ca nstveg19ca;
array stavegca  {15}  staveg91ca staveg91ca staveg95ca staveg95ca staveg99ca staveg99ca staveg03ca staveg03ca staveg07ca staveg07ca staveg11ca staveg11ca staveg15ca staveg15ca staveg19ca;
array tdairyca  {15}  tdairy91ca tdairy91ca tdairy95ca tdairy95ca tdairy99ca tdairy99ca tdairy03ca tdairy03ca tdairy07ca tdairy07ca tdairy11ca tdairy11ca tdairy15ca tdairy15ca tdairy19ca;
array coffeeca  {15}  coffee91ca coffee91ca coffee95ca coffee95ca coffee99ca coffee99ca coffee03ca coffee03ca coffee07ca coffee07ca coffee11ca coffee11ca coffee15ca coffee15ca coffee19ca;
array nutlegca  {15}  nutleg91ca nutleg91ca nutleg95ca nutleg95ca nutleg99ca nutleg99ca nutleg03ca nutleg03ca nutleg07ca nutleg07ca nutleg11ca nutleg11ca nutleg15ca nutleg15ca nutleg19ca;
array bwriceca  {15}  bwrice91ca bwrice91ca bwrice95ca bwrice95ca bwrice99ca bwrice99ca bwrice03ca bwrice03ca bwrice07ca bwrice07ca bwrice11ca bwrice11ca bwrice15ca bwrice15ca bwrice19ca;
array wtriceca  {15}  wtrice91ca wtrice91ca wtrice95ca wtrice95ca wtrice99ca wtrice99ca wtrice03ca wtrice03ca wtrice07ca wtrice07ca wtrice11ca wtrice11ca wtrice15ca wtrice15ca wtrice19ca;
array SSBca     {15}  SSB91ca SSB91ca SSB95ca SSB95ca SSB99ca SSB99ca SSB03ca SSB03ca SSB07ca SSB07ca SSB11ca SSB11ca SSB15ca SSB15ca SSB19ca;
array whgrnsca  {15}  whgrns91ca whgrns91ca whgrns95ca whgrns95ca whgrns99ca whgrns99ca whgrns03ca whgrns03ca whgrns07ca whgrns07ca whgrns11ca whgrns11ca whgrns15ca whgrns15ca whgrns19ca;
array rfgrnsca  {15}  rfgrns91ca rfgrns91ca rfgrns95ca rfgrns95ca rfgrns99ca rfgrns99ca rfgrns03ca rfgrns03ca rfgrns07ca rfgrns07ca rfgrns11ca rfgrns11ca rfgrns15ca rfgrns15ca rfgrns19ca;
array whgrnca  {15}  whgrn91ca whgrn91ca whgrn95ca whgrn95ca whgrn99ca whgrn99ca whgrn03ca whgrn03ca whgrn07ca whgrn07ca whgrn11ca whgrn11ca whgrn15ca whgrn15ca whgrn19ca;
array rfgrnca  {15}  rfgrn91ca rfgrn91ca rfgrn95ca rfgrn95ca rfgrn99ca rfgrn99ca rfgrn03ca rfgrn03ca rfgrn07ca rfgrn07ca rfgrn11ca rfgrn11ca rfgrn15ca rfgrn15ca rfgrn19ca;
array glca  {15}  gl91ca gl91ca gl95ca gl95ca gl99ca gl99ca gl03ca gl03ca gl07ca gl07ca gl11ca gl11ca gl15ca gl15ca gl19ca;
array afatca   {15}  afat91ca afat91ca afat95ca afat95ca afat99ca afat99ca afat03ca afat03ca afat07ca afat07ca afat11ca afat11ca afat15ca afat15ca afat19ca;
array vfatca   {15}  vfat91ca vfat91ca vfat95ca vfat95ca vfat99ca vfat99ca vfat03ca vfat03ca vfat07ca vfat07ca vfat11ca vfat11ca vfat15ca vfat15ca vfat19ca;

array ahei       {15}  ahei91 ahei91 ahei95 ahei95 ahei99 ahei99 ahei03 ahei03 ahei07 ahei07 ahei11 ahei11 ahei15 ahei15 ahei19; 
array aheinoal   {15}  aheinoal91 aheinoal91 aheinoal95 aheinoal95 aheinoal99 aheinoal99 aheinoal03 aheinoal03 aheinoal07 aheinoal07 aheinoal11 aheinoal11 aheinoal15 aheinoal15 aheinoal19; 
array aheinopt   {15}  aheinopt91 aheinopt91 aheinopt95 aheinopt95 aheinopt99 aheinopt99 aheinopt03 aheinopt03 aheinopt07 aheinopt07 aheinopt11 aheinopt11 aheinopt15 aheinopt15 aheinopt15; 
array aheifisha  {15}  aheifisha91 aheifisha91 aheifisha95 aheifisha95 aheifisha99 aheifisha99 aheifisha03 aheifisha03 aheifisha07 aheifisha07 aheifisha11 aheifisha11 aheifisha15 aheifisha15 aheifisha19;
array aheidairy  {15}  aheidairy91 aheidairy91 aheidairy95 aheidairy95 aheidairy99 aheidairy99 aheidairy03 aheidairy03 aheidairy07 aheidairy07 aheidairy11 aheidairy11 aheidairy15 aheidairy15 aheidairy19;
array aheinutbl  {15}  aheinutbl91 aheinutbl91 aheinutbl95 aheinutbl95 aheinutbl99 aheinutbl99 aheinutbl03 aheinutbl03 aheinutbl07 aheinutbl07 aheinutbl11 aheinutbl11 aheinutbl15 aheinutbl15 aheinutbl19;
array aheipoult  {15}  aheipoult91 aheipoult91 aheipoult95 aheipoult95 aheipoult99 aheipoult99 aheipoult03 aheipoult03 aheipoult07 aheipoult07 aheipoult11 aheipoult11 aheipoult15 aheipoult15 aheipoult19;
array aheineggs  {15}  aheineggs91 aheineggs91 aheineggs95 aheineggs95 aheineggs99 aheineggs99 aheineggs03 aheineggs03 aheineggs07 aheineggs07 aheineggs11 aheineggs11 aheineggs15 aheineggs15 aheineggs19;

array aheica       {15}  ahei91ca ahei91ca ahei95ca ahei95ca ahei99ca ahei99ca ahei03ca ahei03ca ahei07ca ahei07ca ahei11ca ahei11ca ahei15ca ahei15ca ahei19ca; 
array aheinoalca   {15}  aheinoal91ca aheinoal91ca aheinoal95ca aheinoal95ca aheinoal99ca aheinoal99ca aheinoal03ca aheinoal03ca aheinoal07ca aheinoal07ca aheinoal11ca aheinoal11ca aheinoal15ca aheinoal15ca aheinoal19ca; 
array aheinoptca   {15}  aheinopt91ca aheinopt91ca aheinopt95ca aheinopt95ca aheinopt99ca aheinopt99ca aheinopt03ca aheinopt03ca aheinopt07ca aheinopt07ca aheinopt11ca aheinopt11ca aheinopt15ca aheinopt15ca aheinopt19ca;
array aheifishaca  {15}  aheifisha91ca aheifisha91ca aheifisha95ca aheifisha95ca aheifisha99ca aheifisha99ca aheifisha03ca aheifisha03ca aheifisha07ca aheifisha07ca aheifisha11ca aheifisha11ca aheifisha15ca aheifisha15ca aheifisha19ca;
array aheidairyca  {15}  aheidairy91ca aheidairy91ca aheidairy95ca aheidairy95ca aheidairy99ca aheidairy99ca aheidairy03ca aheidairy03ca aheidairy07ca aheidairy07ca aheidairy11ca aheidairy11ca aheidairy15ca aheidairy15ca aheidairy19ca;
array aheinutblca  {15}  aheinutbl91ca aheinutbl91ca aheinutbl95ca aheinutbl95ca aheinutbl99ca aheinutbl99ca aheinutbl03ca aheinutbl03ca aheinutbl07ca aheinutbl07ca aheinutbl11ca aheinutbl11ca aheinutbl15ca aheinutbl15ca aheinutbl19ca;
array aheipoultca  {15}  aheipoult91ca aheipoult91ca aheipoult95ca aheipoult95ca aheipoult99ca aheipoult99ca aheipoult03ca aheipoult03ca aheipoult07ca aheipoult07ca aheipoult11ca aheipoult11ca aheipoult15ca aheipoult15ca aheipoult19ca;
array aheineggsca  {15}  aheineggs91ca aheineggs91ca aheineggs95ca aheineggs95ca aheineggs99ca aheineggs99ca aheineggs03ca aheineggs03ca aheineggs07ca aheineggs07ca aheineggs11ca aheineggs11ca aheineggs15ca aheineggs15ca aheineggs19ca;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {5}  alone09 alone13 alone13 alone17 alone19;
array married {5} marry09 marry13 marry13 marry17 marry19;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {5} mdinc10_11 mdinc10_13 mdinc10_15 mdinc10_17 mdinc10_17; 
   array vhs {5} mdvhs10_11 mdvhs10_13 mdvhs10_15 mdvhs10_17 mdvhs10_17; 
   array pcoll {5} pcolled10_11 pcolled10_13 pcolled10_15 pcolled10_17 pcolled10_17;
   array phs {5} phs10_11 phs10_13 phs10_15 phs10_17 phs10_17;
   array pnohs {5} pnohs10_11 pnohs10_13 pnohs10_15 pnohs10_17 pnohs10_17;
   array pfint {5} pfaminterest10_11 pfaminterest10_13 pfaminterest10_15 pfaminterest10_17 pfaminterest10_17;
   array sfemale {5} pfwchbf10_11 pfwchbf10_13 pfwchbf10_15 pfwchbf10_17 pfwchbf10_17;
   array pkid {5} pkid10_11 pkid10_13 pkid10_15 pkid10_17 pkid10_17;
   array pold {5} pold10_11 pold10_13 pold10_15 pold10_17 pold10_17;
   array pohse {5} pohse10_11 pohse10_13 pohse10_15 pohse10_17 pohse10_17;
   array ppov {5} ppov10_11 ppov10_13 ppov10_15 ppov10_17 ppov10_17;
   array pw {5}   pwht10_11 pwht10_13 pwht10_15 pwht10_17 pwht10_17;

   array popd {5} popd10_11 popd10_13 popd10_15 popd10_17 popd10_17; 
   array div {5} division10_11 division10_13 division10_15 division10_17 division10_17;
   array reg {5} region10_11 region10_13 region10_15 region10_17 region10_17;


   do i=1 to 5;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 5;
      if actm{b}=. then actm{b}=actm{b-1};  
       if bmi{b}=. then bmi{b}=bmi{b-1};
       if nsmk{b}=. then nsmk{b}=nsmk{b-1};
       if aspyn{b}=. then aspyn{b}=aspyn{b-1};
       if horm{b}=. then horm{b}=horm{b-1};
       if mvit{b}=. then mvit{b}=mvit{b-1};
       if alone{b}=. then alone{b}=alone{b-1};
       if married{b}=. then married{b}=married{b-1};
       if inc{b}=. then inc{b}=inc{b-1};
       if vhs{b}=. then vhs{b}=vhs{b-1};
       if pcoll{b}=. then pcoll{b}=pcoll{b-1};
       if phs{b}=. then phs{b}=phs{b-1};
       if pnohs{b}=. then pnohs{b}=pnohs{b-1};
       if pfint{b}=. then pfint{b}=pfint{b-1};
       if sfemale{b}=. then sfemale{b}=sfemale{b-1};
       if pkid{b}=. then pkid{b}=pkid{b-1};
       if pold{b}=. then pold{b}=pold{b-1};
       if pohse{b}=. then pohse{b}=pohse{b-1};
       if ppov{b}=. then ppov{b}=ppov{b-1};
       if pw{b}=. then pw{b}=pw{b-1};
       if popd{b}=. then popd{b}=popd{b-1};
       if div{b}=. then div{b}=div{b-1};
       if reg{b}=. then reg{b}=reg{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
       end;

     do b=2 to 15;
       if alco{b}=. then alco{b}=alco{b-1};
       if alcoca{b}=. then alcoca{b}=alcoca{b-1};
       if calor{b}=. then calor{b}=calor{b-1};
       if calorca{b}=. then calorca{b}=calorca{b-1};
       if cerafca{b}=. then cerafca{b}=cerafca{b-1};
       if satfca{b}=. then satfca{b}=satfca{b-1};
       if monfca{b}=. then monfca{b}=monfca{b-1};
       if monfdenca{b}=. then monfdenca{b}=monfdenca{b-1};    
       if polyfca{b}=. then polyfca{b}=polyfca{b-1};
       if transfca{b}=. then transfca{b}=transfca{b-1};
       if folca{b}=. then folca{b}=folca{b-1};
       if prot{b}=. then prot{b}=prot{b-1};
       if protden{b}=. then protden{b}=protden{b-1};
       if protca{b}=. then protca{b}=protca{b-1};
       if protdenca{b}=. then protdenca{b}=protdenca{b-1};
       if gidca{b}=. then gidca{b}=gidca{b-1};
       if ceraf{b}=. then ceraf{b}=ceraf{b-1};
       if aofib{b}=. then aofib{b}=aofib{b-1};
       if carbo{b}=. then carbo{b}=carbo{b-1};
       if carbden{b}=. then carbden{b}=carbden{b-1};
       if carboca{b}=. then carboca{b}=carboca{b-1};
       if carbdenca{b}=. then carbdenca{b}=carbdenca{b-1};
       if transfca{b}=. then transfca{b}=transfca{b-1};
       if transfdenca{b}=. then transfdenca{b}=transfdenca{b-1};
       if transf{b}=. then transf{b}=transf{b-1};
       if transfden{b}=. then transfden{b}=transfden{b-1};
       if satfca{b}=. then satfca{b}=satfca{b-1};
       if satfdenca{b}=. then satfdenca{b}=satfdenca{b-1};
       if satf{b}=. then satf{b}=satf{b-1};
       if satfden{b}=. then satfden{b}=satfden{b-1};
       if polyfca{b}=. then polyfca{b}=polyfca{b-1};
       if polyfdenca{b}=. then polyfdenca{b}=polyfdenca{b-1};
       if polyf{b}=. then polyf{b}=polyf{b-1};
       if polyfden{b}=. then polyfden{b}=polyfden{b-1};
       if monf{b}=. then monf{b}=monf{b-1};
       if monfden{b}=. then monfden{b}=monfden{b-1};
       if tpotat{b}=. then tpotat{b}=tpotat{b-1};
       if bbmpot{b}=. then bbmpot{b}=bbmpot{b-1};
       if fpotat{b}=. then fpotat{b}=fpotat{b-1};
       if chipss{b}=. then chipss{b}=chipss{b-1};
       if prmeat{b}=. then prmeat{b}=prmeat{b-1};
       if urmeat{b}=. then urmeat{b}=urmeat{b-1};
       if trmeat{b}=. then trmeat{b}=trmeat{b-1};
       if poultr{b}=. then poultr{b}=poultr{b-1};
       if fishal{b}=. then fishal{b}=fishal{b-1};
       if regegg{b}=. then regegg{b}=regegg{b-1};
       if hdairy{b}=. then hdairy{b}=hdairy{b-1};
       if ldairy{b}=. then ldairy{b}=ldairy{b-1};
       if nutsal{b}=. then nutsal{b}=nutsal{b-1};
       if legume{b}=. then legume{b}=legume{b-1};
       if fruits{b}=. then fruits{b}=fruits{b-1};
       if vegeal{b}=. then vegeal{b}=vegeal{b-1};
       if nstveg{b}=. then nstveg{b}=nstveg{b-1};
       if staveg{b}=. then staveg{b}=staveg{b-1};
       if whgrns{b}=. then whgrns{b}=whgrns{b-1};
       if rfgrns{b}=. then rfgrns{b}=rfgrns{b-1};
       if whgrn{b}=. then whgrn{b}=whgrn{b-1};
       if rfgrn{b}=. then rfgrn{b}=rfgrn{b-1};
       if gl{b}=. then gl{b}=gl{b-1};
       if gid{b}=. then gid{b}=gid{b-1};
       if afat{b}=. then afat{b}=afat{b-1};
       if vfat{b}=. then vfat{b}=vfat{b-1};
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};
       if aheifisha{b}=. then aheifisha{b}=aheifisha{b-1};
       if aheidairy{b}=. then aheidairy{b}=aheidairy{b-1};
       if aheinutbl{b}=. then aheinutbl{b}=aheinutbl{b-1};
       if aheipoult{b}=. then aheipoult{b}=aheipoult{b-1};
       if aheineggs{b}=. then aheineggs{b}=aheineggs{b-1};
       if tdairy{b}=. then tdairy{b}=tdairy{b-1};
       if coffee{b}=. then coffee{b}=coffee{b-1};
       if nutleg{b}=. then nutleg{b}=nutleg{b-1};
       if bwrice{b}=. then bwrice{b}=bwrice{b-1};
       if wtrice{b}=. then wtrice{b}=wtrice{b-1};
       if SSB{b}=. then SSB{b}=SSB{b-1};
       
       if calorca{b}=. then calorca{b}=calorca{b-1};
       if tpotatca{b}=. then tpotatca{b}=tpotatca{b-1};
       if bbmpotca{b}=. then bbmpotca{b}=bbmpotca{b-1};
       if fpotatca{b}=. then fpotatca{b}=fpotatca{b-1};
       if chipssca{b}=. then chipssca{b}=chipssca{b-1};
       if trmeatca{b}=. then trmeatca{b}=trmeatca{b-1};
       if prmeatca{b}=. then prmeatca{b}=prmeatca{b-1};
       if urmeatca{b}=. then urmeatca{b}=urmeatca{b-1};
       if gidca{b}=. then gidca{b}=gidca{b-1};
       if poultrca{b}=. then poultrca{b}=poultrca{b-1};
       if fishalca{b}=. then fishalca{b}=fishalca{b-1};
       if regeggca{b}=. then regeggca{b}=regeggca{b-1};
       if tdairyca{b}=. then tdairyca{b}=tdairyca{b-1};
       if coffeeca{b}=. then coffeeca{b}=coffeeca{b-1};
       if nutsalca{b}=. then nutsalca{b}=nutsalca{b-1};
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};
       if afatca{b}=. then afatca{b}=afatca{b-1};
       if vfatca{b}=. then vfatca{b}=vfatca{b-1};

    end;
    

do i=1 to DIM(irt)-1;
  if irt{i} >0 then lastq=irt{i};
  end;
  drop i;
  if lastq=irt{dim(irt)-1} then lastq=.;

/*** Set cutoff at 2011.5***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1458;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1338+24*i) | irt{i}>=(1362+24*i)) then irt{i}=1338+24*i;
   end;  

%beginex();

   *****************Do-Loop over time periods*****************************;
   
   do i=1 to DIM(irt)-1;     
    period=i;
    do j=1 to DIM(tvar);
    tvar{j}=0;
    perioda{j}=0;
    end;
   
   tvar{i}=1;
   perioda{i}=1;   

/*** outcomes ***/
 /*Define mortality case variables and time to follow for MPHREG model*/
dead=0;    
tdead=irt{i+1}-irt{i};   
if irt{i}<dtdth<=irt{i+1} then do; 
dead=1;tdead=dtdth-irt{i}; 
end;

diabcase=0;                                                                     /* case definition variable = diabcase */
tdiabcase=irt{i+1}-irt{i};                                                     /* time eq difference between return months */
if diabcase eq 1 then tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
if irt{i} lt dtdxdiab le irt{i+1} then do;
diabcase=1;tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
end;

/****** Define symptomatic T2D case sin the ith time period ******/

   dbsymp=0; 
        tdbsymp=irt{i+1}-irt{i};
        if dbsymp eq 1 then tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
        if irt{i} lt dtdxdiab le irt{i+1} and symp=1 then do;
        dbsymp=1;
        tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
        end;

/******main exposure******/ 
if hxhbp ne 1 then hxhbp=0;
if hxchol ne 1 then hxchol=0;
if hxdb ne 1 then hxdb=0;
if hxcvd ne 1 then hxcvd=0;
if hxcan ne 1 then hxcan=0;
calorcav =  calorca  {i}   ;
calorv =  calor  {i}   ;
gidcav = gidca  {i}   ;
alcov = alco  {i}  ;
alcocav = alcoca  {i}  ;
satfcav = satfca  {i}  ;
monfcav = monfca  {i}  ;
monfdencav = monfdenca  {i}  ;
polyfcav = polyfca  {i}  ;
transfcav = transfca  {i}  ;
folcav = folca  {i}  ;
protv = prot  {i}  ;
protdenv = protden  {i}  ;
protcav = protca  {i}  ;
protdencav = protdenca  {i}  ;
cerafcav = cerafca  {i}  ;
cerafv = ceraf  {i};
aofibcav = aofibca  {i};
aofibv = aofib  {i};
carbov = carbo  {i};
carbdenv = carbden  {i};
carbocav = carboca  {i};
carbdencav = carbdenca  {i};
transfv = transf  {i}  ;
transfdenv = transfden  {i}  ;
transfdencav = transfdenca  {i}  ;
satfv = satf  {i}  ;
satfdenv = satfden  {i}  ;
satfdencav = satfdenca  {i}  ;
polyfv = polyf  {i}  ;
polyfdenv = polyfden  {i}  ;
polyfdencav = polyfdenca  {i}  ;
monfv = monf  {i}  ;
monfdenv = monfden  {i}  ;

tpotatv = tpotat  {i};
bbmpotv = bbmpot  {i};
fpotatv = fpotat  {i};
chipssv = chipss  {i};
prmeatv = prmeat  {i};
urmeatv = urmeat  {i};
trmeatv = trmeat  {i};
poultrv = poultr  {i};
fishalv = fishal  {i};
regeggv = regegg  {i};
hdairyv = hdairy  {i};
ldairyv = ldairy  {i};
/*soyprov = soypro  {i};*/
nutsalv = nutsal  {i};
legumev = legume  {i};
fruitsv = fruits  {i};
vegealv = vegeal  {i};
nstvegv = nstveg  {i};
stavegv = staveg  {i};
tdairyv = tdairy  {i};
coffeev = coffee  {i};
nutlegv = nutleg  {i};
bwricev = bwrice  {i};
wtricev = wtrice  {i};
SSBv =    SSB     {i};
whgrnsv = whgrns  {i};
rfgrnsv = rfgrns  {i};
whgrnv = whgrn  {i};
rfgrnv = rfgrn  {i};
glv = gl  {i};
gidv = gid  {i};
afatv = afat  {i};
vfatv = vfat  {i};

tpotatcav = tpotatca  {i};
bbmpotcav = bbmpotca  {i};
fpotatcav = fpotatca  {i};
chipsscav = chipssca  {i};
prmeatcav = prmeatca  {i};
urmeatcav = urmeatca  {i};
trmeatcav = trmeatca  {i};
poultrcav = poultrca  {i};
fishalcav = fishalca  {i};
regeggcav = regeggca  {i};
hdairycav = hdairyca  {i};
ldairycav = ldairyca  {i};
/*soyprocav = soyproca  {i};*/
nutsalcav = nutsalca  {i};
legumecav = legumeca  {i};
fruitscav = fruitsca  {i};
vegealcav = vegealca  {i};
nstvegcav = nstvegca  {i};
stavegcav = stavegca  {i};
tdairycav = tdairyca  {i};
coffeecav = coffeeca  {i};
nutlegcav = nutlegca  {i};
bwricecav = bwriceca  {i};
wtricecav = wtriceca  {i};
SSBcav =    SSBca    {i};
whgrnscav = whgrnsca  {i};
rfgrnscav = rfgrnsca  {i};
whgrncav = whgrnca  {i};
rfgrncav = rfgrnca  {i};
glcav = glca  {i};
afatcav = afatca  {i};
vfatcav = vfatca  {i};

aheiv = ahei  {i};
aheinoalv = aheinoal  {i};
aheinoptv = aheinopt  {i};
aheifishav = aheifisha  {i};
aheidairyv = aheidairy  {i};
aheinutblv = aheinutbl  {i};
aheipoultv = aheipoult  {i};
aheineggsv = aheineggs  {i};

aheicav = aheica  {i};
aheinoalcav = aheinoalca  {i};
aheinoptcav = aheinoptca  {i};
aheifishacav = aheifishaca  {i};
aheidairycav = aheidairyca  {i};
aheinutblcav = aheinutblca  {i};
aheipoultcav = aheipoultca  {i};
aheineggscav = aheineggsca  {i};

   satfdencav5 = satfdencav/0.05;
   monfdencav5 = monfdencav/0.05;
   transfdencav5 = transfdencav/0.05;
   polyfdencav5 = polyfdencav/0.05;
   carbdencav20 = carbdencav/0.2;

   lgsatfdencav = log(satfdencav+0.0001);
   lgsatfdencav5 = log(satfdencav5+0.0001);
   lgsatfdenv = log(satfdenv+0.0001);
   lgcalorcav = log(calorcav+0.0001);
   lgprotdencav = log(protdencav+0.0001);
   lgpolyfdencav = log(polyfdencav+0.0001);
   lgmonfdencav = log(monfdencav+0.0001);
   lgtransfdencav = log(transfdencav+0.0001);  



tpotatwv = tpotatv*7/3; 
bbmpotwv = bbmpotv*7/3; 
fpotatowv = fpotatv*7/3;
chipsswv = chipssv*7/3;
whgrnswv = whgrnsv*7/3;
rfgrnswv = rfgrnsv*7/3;
nstvegwv = nstvegv*7/3;  
stavegwv = stavegv*7/3;  
legumewv = legumev*7/3;

tpotatw = tpotatcav*7/3; 
bbmpotw = bbmpotcav*7/3; 
fpotatow = fpotatcav*7/3;
chipssw = chipsscav*7/3;
whgrnsw = whgrnscav*7/3;
rfgrnsw = rfgrnscav*7/3;
nstvegw = nstvegcav*7/3;  
stavegw = stavegcav*7/3;  
legumew = legumecav*7/3;
bwricew = bwricecav*7/3;
wtricew = wtricecav*7/3; 
afatw =  afatcav*7/3; 
vfatw =  vfatcav*7/3; 

/******AGE GROUP******/
if age{i} =< 0 then age{i}=.;

if age{i}=. then do;
   age{i}=round((irt{i}-birthday)/12);
   end;

agecon=age{i};
      if age{i}<60 then agegp=0;     **** Define the agegp in the i-th period;
            else if age{i}<65 then agegp=1;
            else if age{i}<70 then agegp=2;
            else if age{i}<75 then agegp=3;
            else if age{i}<80 then agegp=4;
            else agegp=5;
            if age{i}=. then agegp=.;

     if agegp>1 then agedi=1;
     else agedi=0;

      %indic3(vbl=agegp, prefix=agegp, min=1, max=5, reflev=0,missing=., usemiss=0,
                   label1='age<60ys',
                   label2='age60-64ys',
                   label3='age65-69ys',
                   label4='age70-74ys',
                   label5='age75-79ys',
                   label6='age>=80ys');

   if age{i}=>65 then age65=1;            /*dichotomous age*/
        else age65=0;                                 
   
           /***smoking status***/
   smkk=nsmk{i};
   if smkk=1 or smkk=0 then smkdi=0;
   else smkdi=1;

   if smkk=1 or smkk=0 then smktr=0;
   else if smkk in (2,3,4,5,6,7,8) then smktr=1;
   else smktr=2;

        if smkk=1 then smkever=1;  *never;
        else if smkk in(2,3,4,5,6,7,8) then smkever=2; *past smoker;
        else if smkk in (9,10,15) then smkever=3; *current, 1-14 cigs ;
        else if smkk=11 then smkever=4; *current, 15-24 cigs ;
        else if smkk in(12,13,14) then smkever=5; *current, 25+ cigs ;
        else smkever=1; *missing;
        %indic3(vbl=smkever, prefix=smkc, min=2, max=5, reflev=1, missing=9, usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');
        if smkever in (3,4,5) then catsmkf=1;
        else catsmkf=0;

    
       /*** Indicator for BMI ***/ 
         bmicon=bmi{i};                                 /*continuous BMI*/
         if bmicon = . then bmicon = 25.0600;

         if bmicon < 25 then bmidi = 0;                /*dichotomous BMI*/
         else bmidi = 1;

         if bmicon < 25 then bmitr = 0;
         else if bmicon => 25 and bmicon < 30 then bmitr = 1;
         else bmitr = 2;
         
         if      0<   bmicon <21 then bmic=1;
         else if 21=< bmicon <25 then bmic=2;
         else if 25=< bmicon <30 then bmic=3;
         else if 30=< bmicon <32 then bmic=4;
         else if 32=< bmicon     then bmic=5;
         else if bmicon=. or bmicon=0 then bmic=.;
         %indic3(vbl=bmic, prefix=bmic, reflev=1, min=2, max=5, missing=., usemiss=0,
                    label1='bmi<20.9', 
                    label2='bmi 21-24.9',
                    label3='bmi 25-29.9', 
                    label4='bmi 30.0-31.9', 
                    label5='bmi 32.0+');

         if      0<   bmicon <21 then bmic9=1;
         else if 21=< bmicon <23 then bmic9=2;
         else if 23=< bmicon <25 then bmic9=3;
         else if 25=< bmicon <27 then bmic9=4;
         else if 27=< bmicon <30 then bmic9=5;
         else if 30=< bmicon <33 then bmic9=6;
         else if 33=< bmicon <35 then bmic9=7;
         else if 35=< bmicon <40 then bmic9=8;
         else if 40=< bmicon     then bmic9=9;
         else if bmicon=. or bmicon=0 then bmic9=.;
         %indic3(vbl=bmic9, prefix=bmic9, reflev=1, min=2, max=9, missing=., usemiss=0);


/***category of exercise***/
       actcon=actm{i};
       if actcon = . then actcon = 14.00000;
       if .<actcon<=3      then actcc=1;
       else if 3<actcon<=9       then actcc=2;
       else if 9<actcon<=18      then actcc=3;
       else if 18<actcon<=27     then actcc=4;
       else if 27<actcon<900      then actcc=5;
      else actcc=.;

      if actcon<14.0000 then actbi = 0;
      else if actcon>=14.0000 then actbi = 1;
      else actbi = 0;

       %indic3(vbl=actcc, prefix=catact, min=2, max=5, reflev=1, missing=., usemiss=0);

       /*** alcohol ***/
             alccon=alcoca{i};
         if alccon = . then alccat=3;     
         if alccon = 0 then alccat=1;     
         if alccon > 0 and alccon < 5 then alccat=2;     
         if alccon >= 5 and alccon <10 then alccat=3;    
         if alccon >= 10 and alccon <15 then alccat=4;  
         if alccon >= 15 and alccon <30 then alccat=5;     
         if alccon =>30 then alccat=6; 
             %indic3(vbl=alccat, prefix=alcc, reflev=1, usemiss=0, min=2, max=6,      
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY')  ;

          alcconsu=alco{i};
         if alcconsu = . then alccatsu=3;     
         if alcconsu = 0 then alccatsu=1;     
         if alcconsu > 0 and alcconsu < 5 then alccatsu=2;     
         if alcconsu >= 5 and alcconsu <10 then alccatsu=3;    
         if alcconsu >= 10 and alcconsu <15 then alccatsu=4;  
         if alcconsu >= 15 and alcconsu <30 then alccatsu=5;     
         if alcconsu =>30 then alccatsu=6; 
             %indic3(vbl=alccatsu, prefix=alccsu, reflev=1, usemiss=0, min=2, max=6,      
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY')  ;

  /*** Category of AHEI variables (<median vs. >median) ***/

      if aheinoptcav= . then aheinoptcav=39.0435;
      if aheinoptcav<39.0435 then aheinoptd = 0;
      else if aheinoptcav>=39.0435 then aheinoptd = 1;
      
     /*** aspirin ***/
            select(aspyn{i});
                when (1)     aspirin=1; 
                  otherwise    aspirin=0;
            end;

      
      /****** Indicator for History of antihypertensive user */
            select(antihp{i});
                when (1)     antihbp=1;
                  otherwise    antihbp=0;
            end;

      /****** Indicator for History of High Blood Pressure *******/
            select(hbp{i});
                when (1)     htn=1;
                  otherwise    htn=0;
            end;

            /*if hbp{i}=1 or antihp{i}=1 then highbp=1; else highbp=0;*/

      /****** Indicator for TC lowering */
            select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
            end;

          
      /****** Indicator for History of High TC 
            select(chol{i});
                when (1)     hchol=1;
                  otherwise    hchol=0;
            end;******/
   
      /****** Indicator for History of diabetes *******/
            select(db{i});
                when (1)     diabetes=1;
                  otherwise    diabetes=0;
            end;

/****** Indicator for multivitamin ******/
            select(mvit{i});
                when (1)     mlvit=1;
                  otherwise    mlvit=0;
            end;


/*hormone use*/
/*create missing hormone use for everyone who is not never/current/past*/

if horm{i} eq . or horm{i} lt 1 or horm{i} gt 4 then hormone = .;
else hormone = horm {i};
%indic3(vbl=hormone,prefix=hormone,min=2,max=4,reflev=1,missing=.,usemiss=1,
                        label1='premenopausal/missing menopause'
                        label2='no history of postmenopausal hormone use'
                        label3='current postmenopausal hormone use'
                        label4='past postmenopausal hormone use');

      /*** family history of MI***/
         IF mifh NE 1 THEN mifh=0;

      /*** family history of Diab***/
      IF dbfh NE 1 THEN dbfh=0;
      IF strfh NE 1 THEN strfh=0;
      IF cafh NE 1 THEN cafh=0;      

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxmi in (0,.)then dtdxmi=.;
       if dtdxmi eq 9999 then dtdxmi=.;


/**********************************************
          Individual SES
***********************************************/   
live_alone=alone{i};
if alone{i} ne 1 then live_alone=0; 
else live_alone=1;

cmarry=married{i};
if cmarry ne 1 then cmarry=0;
else cmarry=1; 
   
/************************************************
Census tract-level SES
************************************************/
income=inc{i}/1000; *divide by $1000 to make more interpretable;
homeval=vhs{i}/10000; *divide by $10000 to be more interpretable;
pcollege=pcoll{1};
phigh=phs{i};
pnohigh=pnohs{i};
pfamint=pfint{i};
singlefemale=sfemale{i};
pkids=pkid{i};
polds=pold{i};
pocchse=pohse{i};
perpov=ppov{i};
pwhite=pw{i};
   
popden=popd{i}; 
region=reg{i};
division=div{i};

      
     /****************  BASELINE EXCLUSIONS ********************************************/
      if i=1 then do;

   %exclude(exrec eq 1);                /*multiple records and not in master file*/
   %exclude(birthday lt 0);
   %exclude(lastq eq irt{1});          /*only returned baseline qq */

        %exclude(hxcvd   eq 1);        /* baseline history of CVD*/    
        %exclude(hxcan   eq 1);        /*baseline history of cancer*/
        %exclude(hxdb   eq 1);         /*baseline history of diabetes*/
        /*%exclude(hxchol   eq 1);*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le retmo11);          /* Death before baseline */
   %exclude(0 lt dtdxdiab le retmo11);      /* Diagnoses diabetes before 1991 */
   %exclude(calor91n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor91n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor91n eq .);                 /* missing energy intake */
   %exclude(tpotat91d eq .);               /* missing potato intake */
   %exclude(age11    eq .);               /* missing age at 1999 */ 
   %output();
  end;

/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/
  if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                   /*censor lost to follow up*/   
   %exclude(irt{i-1} le dtdth lt irt{i});            /* DEATHS */
   %exclude(irt{i-1} lt dtdxdiab le irt{i});         /* type2 diabetes CASES */
   %output();
   end;

        end;             /* END OF DO-LOOP OVER TIME PERIODs */
        %endex();        /* must do AFTER all exclusions */ 

/*** Variables kept for analysis ***/

keep id period agecon agegp agedi smkdi smkk chol91 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew bwricew wtricew afatw vfatw
     retmo11  retmo13  retmo15 retmo17 retmo19 cutoff
     t11   t13   t15 t17 t19  dtdth dtdxdiab
     tdead diabcase tdiabcase dbsymp tdbsymp
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib91n ceraf91n gid91n alco91n sat91n mon91n poly91n trnss91n fol91n prot91n
     white &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
    actcon bmic alccon
     htn diabetes /*hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db11 chol11 hbp11 str11 hxcvd hxcan antihbp antihtc /*cvd86*/
     age11 bmi11 alco91n calor91n act97m mifh cerafcav aofibcav smkever actcc asp11 mvitu11 hormone aofibv
     
     /*Stratification variables*/
     age65 bmitr hxhbp dbfh smktr catrace2 aheinoptd actbi 

     lgcalorcav hxchol hxdb cerafv bmicon carbov carbdenv carbocav carbdencav mlvit alcconsu &alccsu_ transfv transfdenv transfdencav satfv satfdenv satfdencav polyfv polyfdenv polyfdencav monfv monfdencav monfdenv
     satfdencav5 carbdencav20 lgsatfdencav5 lgcalorcav lgprotdencav lgpolyfdencav lgmonfdencav lgsatfdencav lgsatfdenv lgtransfdencav monfdencav5 transfdencav5 polyfdencav5
     tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d whgrn91n rfgrn91n whgrns91d rfgrns91d aheinopt91 gl91n tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d
     tpotatv bbmpotv fpotatv chipssv prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv coffeev nutlegv bwricev wtricev SSBv 
     tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav coffeecav nutlegcav bwricecav wtricecav SSBcav
     whgrnsv rfgrnsv whgrnv rfgrnv glv gidv whgrnscav rfgrnscav whgrncav rfgrncav glcav race8905 catsmkf
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
     mrace8905 eth8905 catrace actbi bmidi bmitr 
     tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
     income homeval pcollege phigh pnohigh pfamint singlefemale pkids polds pocchse perpov pwhite popden; 
run;

data two;
   set two;
   zperpov=1-perpov; *invert to make increases good;
   zsinglefemale=1-singlefemale; *invert to make increases good;
   zincome=income;
   zhomeval=homeval;
   zpcollege=pcollege;
   zphigh=phigh;
   zpnohigh=pnohigh;
   zpfamint=pfamint;
   zpkids=pkids;
   zpolds=polds;
   zpocchse=pocchse;
   zpwhite=pwhite;
run;

/*create a score from the various nSES variables*/
proc standard data=two mean=0 std=1 out=two;
     var zincome zhomeval zpcollege zpfamint zpocchse zpwhite zperpov zsinglefemale;
run; 

data two;
   set two;
   nSES=zincome+zhomeval+zpcollege+zpfamint+zpocchse+zpwhite+zperpov; 

   if nSES = . then nSES = 0.1349313;
run;

proc freq data=two;tables mrace8905 eth8905 catrace catrace2 actbi bmidi bmitr smktr &bmic9_;run;

proc univariate data=two;var agecon bmicon actcon agecon calorcav gidcav tpotatcav bbmpotcav fpotatcav chipsscav trmeatcav prmeatcav urmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav bwricecav wtricecav SSBcav coffeecav 
                           gidv tpotatv bbmpotv fpotatv chipssv trmeatv prmeatv urmeatv poultrv fishalv regeggv hdairyv ldairyv nutsalv legumev fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv
                           tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav nSES;run;
proc freq data=two;tables white &smkc_ &alcc_ &catact_ &hormone_ mlvit age65 actbi aheinoptd bmitr dbfh antihbp antihtc hxhbp diabcase dbsymp catsmkf;run;


%pctl9(
data=two,
varlist= calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv protdencav protdenv aofibv aofibcav cerafv cerafcav transfv transfdenv transfcav transfdencav satfv satfdenv satfcav satfdencav polyfv polyfdenv polyfcav polyfdencav monfcav monfv monfdencav monfdenv
         prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav gidcav whgrns91d rfgrns91d whgrnscav rfgrnscav SSBcav
         tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav gidv fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);


data five;
   set four end=_end_;
   
     if 0.000<=tpotatcav<=0.070 then ctpotatcav=0;        
      else if 0.070<tpotatcav<=0.143 then ctpotatcav=1;       
      else if 0.143<tpotatcav<=0.430 then ctpotatcav=2;         
      else if 0.430<tpotatcav<=0.790 then ctpotatcav=3;       
      else if 0.790<tpotatcav then ctpotatcav=4;                   
  %indic3(vbl=ctpotatcav, prefix=ctpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if ctpotatcav=0 then medctpotatcav=0.0700000;
   if ctpotatcav=1 then medctpotatcav=0.1300000;
   if ctpotatcav=2 then medctpotatcav=0.2800000;
   if ctpotatcav=3 then medctpotatcav=0.5350000;
   if ctpotatcav=4 then medctpotatcav=0.8600000;


      if chipsscav =0.000 then cchipsscav=0;                     /**Almost never**/
      else if 0.000<chipsscav <=0.070 then cchipsscav=1;          /**1-3 serving per month**/
      else if 0.070<chipsscav <=0.143 then cchipsscav=2;         /**1 serving per week**/
      else if 0.143<chipsscav <=0.430 then cchipsscav=3;         /**2-4 serving per week**/
      else if 0.430<chipsscav then cchipsscav=4;                 /** =>5 serving per week**/
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0525000;
   if cchipsscav=2 then medcchipsscav=0.1166667;
   if cchipsscav=3 then medcchipsscav=0.2500000;
   if cchipsscav=4 then medcchipsscav=0.6100000;

      if fpotatcav=0.000 then cfpotatcav=0;                       /**Almost never**/
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          /**1-3 serving per month**/
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;          /**1 serving per week**/
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;          /**2-4 serving per week**/
      else if 0.430<fpotatcav then cfpotatcav=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0525000;
   if cfpotatcav=2 then medcfpotatcav=0.1066667;
   if cfpotatcav=3 then medcfpotatcav=0.2420000;
   if cfpotatcav=4 then medcfpotatcav=0.5740000;

      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                         
  %indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);

   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1260000;
   if cbbmpotcav=2 then medcbbmpotcav=0.2850000;
   if cbbmpotcav=3 then medcbbmpotcav=0.5740000;



     if 0.000<=tpotatv<=0.070 then ctpotatv=0;        
      else if 0.070<tpotatv<=0.143 then ctpotatv=1;       
      else if 0.143<tpotatv<=0.430 then ctpotatv=2;         
      else if 0.430<tpotatv<=0.790 then ctpotatv=3;       
      else if 0.790<tpotatv then ctpotatv=4;                   
  %indic3(vbl=ctpotatv, prefix=ctpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if ctpotatv=0 then medctpotatv=0.00;
   if ctpotatv=1 then medctpotatv=0.1400000;
   if ctpotatv=2 then medctpotatv=0.2100000;
   if ctpotatv=3 then medctpotatv=0.5000000;
   if ctpotatv=4 then medctpotatv=0.8600000;

      if fpotatv=0.000 then cfpotatv=0;                       
      else if 0.000<fpotatv<=0.070 then cfpotatv=1;          
      else if 0.070<fpotatv<=0.143 then cfpotatv=2;         
      else if 0.143<fpotatv<=0.430 then cfpotatv=3;         
      else if 0.430<fpotatv then cfpotatv=4;                 
%indic3(vbl=cfpotatv, prefix=cfpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cfpotatv=0 then medcfpotatv=0.0;
   if cfpotatv=1 then medcfpotatv=0.0700000;
   if cfpotatv=2 then medcfpotatv=0.1400000;
   if cfpotatv=3 then medcfpotatv=0.4300000;
   if cfpotatv=4 then medcfpotatv=0.7900000;

      if chipssv =0.000 then cchipssv=0;                     
      else if 0.000<chipssv <=0.070 then cchipssv=1;          
      else if 0.070<chipssv <=0.143 then cchipssv=2;         
      else if 0.143<chipssv <=0.430 then cchipssv=3;         
      else if 0.430<chipssv then cchipssv=4;                 
%indic3(vbl=cchipssv, prefix=cchipssv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipssv=0 then medcchipssv=0.0;
   if cchipssv=1 then medcchipssv=0.0700000;
   if cchipssv=2 then medcchipssv=0.1400000;
   if cchipssv=3 then medcchipssv=0.4300000;
   if cchipssv=4 then medcchipssv=0.7900000;


      if 0.000<=bbmpotv<=0.070 then cbbmpotv=0;        
      else if 0.070<bbmpotv<=0.143 then cbbmpotv=1;       
      else if 0.143<bbmpotv<=0.430 then cbbmpotv=2;         
      else if 0.430<bbmpotv then cbbmpotv=3;                         
  %indic3(vbl=cbbmpotv, prefix=cbbmpotv, reflev=0, min=1, max=3, missing=., usemiss=0);

   if cbbmpotv=0 then medcbbmpotv=0.0;
   if cbbmpotv=1 then medcbbmpotv=0.1400000;
   if cbbmpotv=2 then medcbbmpotv=0.4300000;
   if cbbmpotv=3 then medcbbmpotv=0.7900000;

      if SSBv=0.000 then qSSBv=0;
      else if 0.000<SSBv<=0.070 then qSSBv=1;          
      else if 0.070<SSBv<=0.143 then qSSBv=2;        
      else if 0.143<SSBv<=0.430 then qSSBv=3;         
      else if 0.430<SSBv then qSSBv=4;                 
%indic3(vbl=qSSBv, prefix=qSSBv, reflev=0, min=1, max=4, missing=., usemiss=0);
run;


proc means median data=five;var tpotatcav;class ctpotatcav; run;
proc means median data=five;var chipsscav;class cchipsscav; run;
proc means median data=five;var fpotatcav;class cfpotatcav; run;
proc means median data=five;var bbmpotcav;class cbbmpotcav; run;
proc freq data=five;tables ctpotatcav cfpotatcav cchipsscav cbbmpotcav;run;


/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt= retmo11  retmo13  retmo15 retmo17 retmo19,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=ctpotatcav cchipsscav cfpotatcav);

%pm(
 data=outpm,
 case=diabcase,
 exposure=ctpotatcav cchipsscav cfpotatcav,
 ref=0 0 0
);

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar= t11   t13   t15 t17 t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo11  retmo13  retmo15 retmo17 retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &ctpotatcav_ &qcalorcav_ , 
         model2  = medctpotatcav &qcalorcav_,
         model3  = &ctpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medctpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &ctpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model6  = medctpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = &cchipsscav_ &qcalorcav_ , 
         model8  = medcchipsscav &qcalorcav_,
         model9  = &cchipsscav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model10  = medcchipsscav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model11  = &cchipsscav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model12  = medcchipsscav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model13  = &cfpotatcav_ &qcalorcav_ , 
         model14  = medcfpotatcav &qcalorcav_,
         model15  = &cfpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model16  = medcfpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model17  = &cfpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         model18  = medcfpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
         outdat=RR1);

data tpotat;
set RR1;

if modelno in (1,3,5) then ind_var=substr(variable,2,6);
if modelno in (2,4,6) then ind_var=substr(variable,5,6);

   if ind_var='tpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (1,2) then model='m1';
   if modelno in (3,4) then model='m2';
   if modelno in (5,6) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data chipss;
set RR1;

if modelno in (7,9,11) then ind_var=substr(variable,2,6);
if modelno in (8,10,12) then ind_var=substr(variable,5,6);

   if ind_var='chipss';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (7,8) then model='m1';
   if modelno in (9,10) then model='m2';
   if modelno in (11,12) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data fpotat;
set RR1;

if modelno in (13,15,17) then ind_var=substr(variable,2,6);
if modelno in (14,16,18) then ind_var=substr(variable,5,6);

   if ind_var='fpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (13,14) then model='m1';
   if modelno in (15,16) then model='m2';
   if modelno in (17,18) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data all;
set tpotat chipss fpotat
;
run;

data quin;
set all;
vb=compress(variable,,'kd');
if vb ne . then va=substr(variable,2,6);
if vb=. then va=substr(variable,5,6);
run;

data quin1;
set quin;
if vb="1";
RR1=RR;
keep model va RR1;
run;

data quin2;
set quin;
if vb="2";
RR2=RR;
keep model va RR2;
run;

data quin3;
set quin;
if vb="3";
RR3=RR;
keep model va RR3;
run;

data quin4;
set quin;
if vb="4";
RR4=RR;
keep model va RR4;
run;

data quin5;
set quin;
if vb=.;
keep model va ProbChisq;
run;

proc sort data=quin1; by va model; run;
proc sort data=quin2; by va model; run;
proc sort data=quin3; by va model; run;
proc sort data=quin4; by va model; run;
proc sort data=quin5; by va model; run;

data scr;
merge quin1 quin2 quin3 quin4 quin5; 
by va model;
run;

ods rtf file="stable10_nhs2.1121.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 RR4 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;

/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt= retmo11  retmo13  retmo15 retmo17 retmo19,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=cbbmpotcav);

%pm(
 data=outpm,
 case=diabcase,
 exposure=cbbmpotcav,
 ref=0
);

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar= t11 t13 t15 t17 t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo11  retmo13  retmo15 retmo17 retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &cbbmpotcav_ &qcalorcav_ , 
         model2  = medcbbmpotcav &qcalorcav_,
         model3  = &cbbmpotcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medcbbmpotcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &cbbmpotcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_, 
         model6  = medcbbmpotcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
         outdat=RR1);

data bbmpot;
set RR1;

if modelno in (1,3,5) then ind_var=substr(variable,2,6);
if modelno in (2,4,6) then ind_var=substr(variable,5,6);

   if ind_var='bbmpot';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (1,2) then model='m1';
   if modelno in (3,4) then model='m2';
   if modelno in (5,6) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data all;
set bbmpot
;
run;

data quin;
set all;
vb=compress(variable,,'kd');
if vb ne . then va=substr(variable,2,6);
if vb=. then va=substr(variable,5,6);
run;

data quin1;
set quin;
if vb="1";
RR1=RR;
keep model va RR1;
run;

data quin2;
set quin;
if vb="2";
RR2=RR;
keep model va RR2;
run;

data quin3;
set quin;
if vb="3";
RR3=RR;
keep model va RR3;
run;

data quin4;
set quin;
if vb=.;
keep model va ProbChisq;
run;

proc sort data=quin1; by va model; run;
proc sort data=quin2; by va model; run;
proc sort data=quin3; by va model; run;
proc sort data=quin4; by va model; run;

data scr;
merge quin1 quin2 quin3 quin4; 
by va model;
run;

ods rtf file="stable10_nhs2.bbm.1121.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;


/*Per serving*/
%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar= t11   t13   t15 t17 t19,
         id=id, tvar=period, modopt=%quote(maxiter=30),
         agevar=agecon, qret= retmo11  retmo13  retmo15 retmo17 retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = tpotatw &qcalorcav_, 
         model2  = tpotatw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model3  = tpotatw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model4  = chipssw &qcalorcav_ , 
         model5  = chipssw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model6  = chipssw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = fpotatow &qcalorcav_ , 
         model8  = fpotatow &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model9  = fpotatow &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
         
         model10  = bbmpotw &qcalorcav_ , 
         model11  = bbmpotw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model12  = bbmpotw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
         outdat=RR1);

data tpotat;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='tpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=1 then model='m1';
   if modelno=2 then model='m2';
   if modelno=3 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data chipss;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='chipss';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=4 then model='m1';
   if modelno=5 then model='m2';
   if modelno=6 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;


data fpotat;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='fpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=7 then model='m1';
   if modelno=8 then model='m2';
   if modelno=9 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data bbmpot;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='bbmpot';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=10 then model='m1';
   if modelno=11 then model='m2';
   if modelno=12 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

/*Merge macro outputs*/
data all;
set tpotat chipss fpotat bbmpot
;
run;

data scr_psd;
set all;
va=substr(variable,1,6);
keep model va RR ProbChisq;
run;

proc sort data=scr_psd; by va model; run;

ods rtf file="stable10_nhs2.1121.pserv.rtf";  
proc print data=scr_psd noobs;
   var  va model RR ProbChisq;   
run;

proc print data=all noobs;
   var  variable model beta see ProbChisq;
run;
ods rtf close;