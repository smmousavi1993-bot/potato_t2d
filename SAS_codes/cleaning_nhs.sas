/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad mousavi
Dates: 05/06/2024
Purpose of the program: 
   Read in and merge datasets as the preparation for the analysis of the associations between total and type of potato consumption and risk of type 2 diabetes in the NHS

/*MI*/
data mi_read;
    infile  lrecl=117 recfm=d;

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

    if cohort = 1;

    micase=0;
    if 11<=conf<=19 then micase=1;
    dtdxmi=.;
    if dxmonth>0 and micase=1 then dtdxmi = dxmonth*1;
    if dtdxmi=. then dtdxmi=1007;

    keep id micase dtdxmi dth_subcode;

proc sort;by id;run;


/** Read death files **/
%deadff(file='/proj/nhdats/nh_dat_cdx/deaths/deadff.current.nhs1');
   dtdth=.;
   if  deadmonth > 0 then dtdth= deadmonth;

    newicda=compress(nhsicda, 'E');
    dthicda=newicda*1.0;
    if dthicda<1000 then dthicda=dthicda*10;
    keep id dtdth newicda dthicda;
proc sort;by id;run;

/***  read CABG data  ***/
data confcabg0;
infile  lrecl=86 recfm=d;

input
@1      id          6.
@7      cd      $   1.
@8      icda        $    5.
@15     mdx1            2.
@17     ydx1            2.
@28     qyr         2.
@31     batser      $   7.
@39     recdate         6.
@46     conf            2.
@49     mdx         2.
@51     ydx         2.
@54     nhsicda     $   4.
@82     dxmonth         4.
;

label
        dxmonth     = 'Date of dx months since 1900'
;
    dtdxcabg=.;
    if dxmonth>0 and 11<=conf<=19 then dtdxcabg = dxmonth;
    if .<dtdxcabg<1033 then cabg84=1;
    else cabg84=0;
    keep id cabg84 dtdxcabg;
run;
proc sort data=confcabg0; by id; run;

/*** read stroke data ***/
data confstr0;
infile  lrecl=81 recfm=d;

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
    if .<dtdxstr<1033 then str84=1;
    else str84=0;
    keep id str84 dtdxstr;
run;
proc sort data=confstr0; by id; run;


data mi_all; set mi_all0; by id; if first.id; run;
data cabg;  set confcabg0;  by id; if first.id; run;
data deadff1;  set deadff;  by id; if first.id; run;
data stroke; set confstr0; by id; if first.id; run;


/******exposure and covariates******/
%ahei2010_8410(keep= ahei2010_84 ahei2010_noETOH84 ahei2010_vegI84 ahei2010_frtI84 ahei2010_ssbI84 ahei2010_whgrnI84 ahei2010_nutI84 ahei2010_rmtI84 ahei2010_etohI84 ahei2010_ptranI84 ahei2010_omegaI84 ahei2010_polyI84 ahei2010_naI84 
                    ahei2010_86 ahei2010_noETOH86 ahei2010_vegI86 ahei2010_frtI86 ahei2010_ssbI86 ahei2010_whgrnI86 ahei2010_nutI86 ahei2010_rmtI86 ahei2010_etohI86 ahei2010_ptranI86 ahei2010_omegaI86 ahei2010_polyI86 ahei2010_naI86 
                    ahei2010_90 ahei2010_noETOH90 ahei2010_vegI90 ahei2010_frtI90 ahei2010_ssbI90 ahei2010_whgrnI90 ahei2010_nutI90 ahei2010_rmtI90 ahei2010_etohI90 ahei2010_ptranI90 ahei2010_omegaI90 ahei2010_polyI90 ahei2010_naI90 
                    ahei2010_94 ahei2010_noETOH94 ahei2010_vegI94 ahei2010_frtI94 ahei2010_ssbI94 ahei2010_whgrnI94 ahei2010_nutI94 ahei2010_rmtI94 ahei2010_etohI94 ahei2010_ptranI94 ahei2010_omegaI94 ahei2010_polyI94 ahei2010_naI94 
                    ahei2010_98 ahei2010_noETOH98 ahei2010_vegI98 ahei2010_frtI98 ahei2010_ssbI98 ahei2010_whgrnI98 ahei2010_nutI98 ahei2010_rmtI98 ahei2010_etohI98 ahei2010_ptranI98 ahei2010_omegaI98 ahei2010_polyI98 ahei2010_naI98 
                    ahei2010_02 ahei2010_noETOH02 ahei2010_vegI02 ahei2010_frtI02 ahei2010_ssbI02 ahei2010_whgrnI02 ahei2010_nutI02 ahei2010_rmtI02 ahei2010_etohI02 ahei2010_ptranI02 ahei2010_omegaI02 ahei2010_polyI02 ahei2010_naI02 
                    ahei2010_06 ahei2010_noETOH06 ahei2010_vegI06 ahei2010_frtI06 ahei2010_ssbI06 ahei2010_whgrnI06 ahei2010_nutI06 ahei2010_rmtI06 ahei2010_etohI06 ahei2010_ptranI06 ahei2010_omegaI06 ahei2010_polyI06 ahei2010_naI06 
                    ahei2010_10 ahei2010_noETOH10 ahei2010_vegI10 ahei2010_frtI10 ahei2010_ssbI10 ahei2010_whgrnI10 ahei2010_nutI10 ahei2010_rmtI10 ahei2010_etohI10 ahei2010_ptranI10 ahei2010_omegaI10 ahei2010_polyI10 ahei2010_naI10);
    
data aheinhs;
    set ahei2010_8410;
run;

data aheinhs;
    set aheinhs;

    ahei84=ahei2010_84;
    aheinoal84=ahei2010_noETOH84;
    aheinopt84  = sum(ahei2010_vegI84, ahei2010_frtI84, ahei2010_ssbI84, ahei2010_whgrnI84, ahei2010_nutI84, ahei2010_rmtI84, ahei2010_etohI84, ahei2010_omegaI84, ahei2010_naI84);
    aheifisha84 = sum(ahei2010_nutI84, ahei2010_ssbI84, ahei2010_vegI84, ahei2010_frtI84, ahei2010_polyI84, ahei2010_ptranI84, ahei2010_etohI84, ahei2010_whgrnI84, ahei2010_naI84);
    aheidairy84 = sum(ahei2010_nutI84, ahei2010_ssbI84, ahei2010_vegI84, ahei2010_frtI84, ahei2010_polyI84, ahei2010_ptranI84, ahei2010_etohI84, ahei2010_omegaI84, ahei2010_whgrnI84, ahei2010_naI84);
    aheinutbl84 = sum(ahei2010_ssbI84, ahei2010_vegI84, ahei2010_frtI84, ahei2010_polyI84, ahei2010_ptranI84, ahei2010_etohI84, ahei2010_omegaI84, ahei2010_whgrnI84, ahei2010_naI84);
    aheipoult84 = sum(ahei2010_nutI84, ahei2010_ssbI84, ahei2010_vegI84, ahei2010_frtI84, ahei2010_polyI84, ahei2010_ptranI84, ahei2010_etohI84, ahei2010_omegaI84, ahei2010_whgrnI84, ahei2010_naI84);
    aheineggs84 = sum(ahei2010_nutI84, ahei2010_ssbI84, ahei2010_vegI84, ahei2010_frtI84, ahei2010_polyI84, ahei2010_ptranI84, ahei2010_etohI84, ahei2010_omegaI84, ahei2010_whgrnI84, ahei2010_naI84);

    ahei86=ahei2010_86;
    aheinoal86=ahei2010_noETOH86;
    aheinopt86  = sum(ahei2010_vegI86, ahei2010_frtI86, ahei2010_ssbI86, ahei2010_whgrnI86, ahei2010_nutI86, ahei2010_rmtI86, ahei2010_etohI86, ahei2010_omegaI86, ahei2010_naI86);
    aheifisha86 = sum(ahei2010_nutI86, ahei2010_ssbI86, ahei2010_vegI86, ahei2010_frtI86, ahei2010_polyI86, ahei2010_ptranI86, ahei2010_etohI86, ahei2010_whgrnI86, ahei2010_naI86);
    aheidairy86 = sum(ahei2010_nutI86, ahei2010_ssbI86, ahei2010_vegI86, ahei2010_frtI86, ahei2010_polyI86, ahei2010_ptranI86, ahei2010_etohI86, ahei2010_omegaI86, ahei2010_whgrnI86, ahei2010_naI86);
    aheinutbl86 = sum(ahei2010_ssbI86, ahei2010_vegI86, ahei2010_frtI86, ahei2010_polyI86, ahei2010_ptranI86, ahei2010_etohI86, ahei2010_omegaI86, ahei2010_whgrnI86, ahei2010_naI86);
    aheipoult86 = sum(ahei2010_nutI86, ahei2010_ssbI86, ahei2010_vegI86, ahei2010_frtI86, ahei2010_polyI86, ahei2010_ptranI86, ahei2010_etohI86, ahei2010_omegaI86, ahei2010_whgrnI86, ahei2010_naI86);
    aheineggs86 = sum(ahei2010_nutI86, ahei2010_ssbI86, ahei2010_vegI86, ahei2010_frtI86, ahei2010_polyI86, ahei2010_ptranI86, ahei2010_etohI86, ahei2010_omegaI86, ahei2010_whgrnI86, ahei2010_naI86);

    ahei90=ahei2010_90;
    aheinoal90=ahei2010_noETOH90;
    aheinopt90  = sum(ahei2010_vegI90, ahei2010_frtI90, ahei2010_ssbI90, ahei2010_whgrnI90, ahei2010_nutI90, ahei2010_rmtI90, ahei2010_etohI90, ahei2010_omegaI90, ahei2010_naI90);
    aheifisha90 = sum(ahei2010_nutI90, ahei2010_ssbI90, ahei2010_vegI90, ahei2010_frtI90, ahei2010_polyI90, ahei2010_ptranI90, ahei2010_etohI90, ahei2010_whgrnI90, ahei2010_naI90);
    aheidairy90 = sum(ahei2010_nutI90, ahei2010_ssbI90, ahei2010_vegI90, ahei2010_frtI90, ahei2010_polyI90, ahei2010_ptranI90, ahei2010_etohI90, ahei2010_omegaI90, ahei2010_whgrnI90, ahei2010_naI90);
    aheinutbl90 = sum(ahei2010_ssbI90, ahei2010_vegI90, ahei2010_frtI90, ahei2010_polyI90, ahei2010_ptranI90, ahei2010_etohI90, ahei2010_omegaI90, ahei2010_whgrnI90, ahei2010_naI90);
    aheipoult90 = sum(ahei2010_nutI90, ahei2010_ssbI90, ahei2010_vegI90, ahei2010_frtI90, ahei2010_polyI90, ahei2010_ptranI90, ahei2010_etohI90, ahei2010_omegaI90, ahei2010_whgrnI90, ahei2010_naI90);
    aheineggs90 = sum(ahei2010_nutI90, ahei2010_ssbI90, ahei2010_vegI90, ahei2010_frtI90, ahei2010_polyI90, ahei2010_ptranI90, ahei2010_etohI90, ahei2010_omegaI90, ahei2010_whgrnI90, ahei2010_naI90);

    ahei94=ahei2010_94;
    aheinoal94=ahei2010_noETOH94;
    aheinopt94 =  sum(ahei2010_vegI94, ahei2010_frtI94, ahei2010_ssbI94, ahei2010_whgrnI94, ahei2010_nutI94, ahei2010_rmtI94, ahei2010_etohI94, ahei2010_omegaI94, ahei2010_naI94);
    aheifisha94 = sum(ahei2010_nutI94, ahei2010_ssbI94, ahei2010_vegI94, ahei2010_frtI94, ahei2010_polyI94, ahei2010_ptranI94, ahei2010_etohI94, ahei2010_whgrnI94, ahei2010_naI94);
    aheidairy94 = sum(ahei2010_nutI94, ahei2010_ssbI94, ahei2010_vegI94, ahei2010_frtI94, ahei2010_polyI94, ahei2010_ptranI94, ahei2010_etohI94, ahei2010_omegaI94, ahei2010_whgrnI94, ahei2010_naI94);
    aheinutbl94 = sum(ahei2010_ssbI94, ahei2010_vegI94, ahei2010_frtI94, ahei2010_polyI94, ahei2010_ptranI94, ahei2010_etohI94, ahei2010_omegaI94, ahei2010_whgrnI94, ahei2010_naI94);
    aheipoult94 = sum(ahei2010_nutI94, ahei2010_ssbI94, ahei2010_vegI94, ahei2010_frtI94, ahei2010_polyI94, ahei2010_ptranI94, ahei2010_etohI94, ahei2010_omegaI94, ahei2010_whgrnI94, ahei2010_naI94);
    aheineggs94 = sum(ahei2010_nutI94, ahei2010_ssbI94, ahei2010_vegI94, ahei2010_frtI94, ahei2010_polyI94, ahei2010_ptranI94, ahei2010_etohI94, ahei2010_omegaI94, ahei2010_whgrnI94, ahei2010_naI94);

    ahei98=ahei2010_98;
    aheinoal98=ahei2010_noETOH98;
    aheinopt98 =  sum(ahei2010_vegI98, ahei2010_frtI98, ahei2010_ssbI98, ahei2010_whgrnI98, ahei2010_nutI98, ahei2010_rmtI98, ahei2010_etohI98, ahei2010_omegaI98, ahei2010_naI98);
    aheifisha98 = sum(ahei2010_nutI98, ahei2010_ssbI98, ahei2010_vegI98, ahei2010_frtI98, ahei2010_polyI98, ahei2010_ptranI98, ahei2010_etohI98, ahei2010_whgrnI98, ahei2010_naI98);
    aheidairy98 = sum(ahei2010_nutI98, ahei2010_ssbI98, ahei2010_vegI98, ahei2010_frtI98, ahei2010_polyI98, ahei2010_ptranI98, ahei2010_etohI98, ahei2010_omegaI98, ahei2010_whgrnI98, ahei2010_naI98);
    aheinutbl98 = sum(ahei2010_ssbI98, ahei2010_vegI98, ahei2010_frtI98, ahei2010_polyI98, ahei2010_ptranI98, ahei2010_etohI98, ahei2010_omegaI98, ahei2010_whgrnI98, ahei2010_naI98);
    aheipoult98 = sum(ahei2010_nutI98, ahei2010_ssbI98, ahei2010_vegI98, ahei2010_frtI98, ahei2010_polyI98, ahei2010_ptranI98, ahei2010_etohI98, ahei2010_omegaI98, ahei2010_whgrnI98, ahei2010_naI98);
    aheineggs98 = sum(ahei2010_nutI98, ahei2010_ssbI98, ahei2010_vegI98, ahei2010_frtI98, ahei2010_polyI98, ahei2010_ptranI98, ahei2010_etohI98, ahei2010_omegaI98, ahei2010_whgrnI98, ahei2010_naI98);

    ahei02=ahei2010_02;
    aheinoal02=ahei2010_noETOH02;
    aheinopt02  = sum(ahei2010_vegI02, ahei2010_frtI02, ahei2010_ssbI02, ahei2010_whgrnI02, ahei2010_nutI02, ahei2010_rmtI02, ahei2010_etohI02, ahei2010_omegaI02, ahei2010_naI02);
    aheifisha02 = sum(ahei2010_nutI02, ahei2010_ssbI02, ahei2010_vegI02, ahei2010_frtI02, ahei2010_polyI02, ahei2010_ptranI02, ahei2010_etohI02, ahei2010_whgrnI02, ahei2010_naI02);
    aheidairy02 = sum(ahei2010_nutI02, ahei2010_ssbI02, ahei2010_vegI02, ahei2010_frtI02, ahei2010_polyI02, ahei2010_ptranI02, ahei2010_etohI02, ahei2010_omegaI02, ahei2010_whgrnI02, ahei2010_naI02);
    aheinutbl02 = sum(ahei2010_ssbI02, ahei2010_vegI02, ahei2010_frtI02, ahei2010_polyI02, ahei2010_ptranI02, ahei2010_etohI02, ahei2010_omegaI02, ahei2010_whgrnI02, ahei2010_naI02);
    aheipoult02 = sum(ahei2010_nutI02, ahei2010_ssbI02, ahei2010_vegI02, ahei2010_frtI02, ahei2010_polyI02, ahei2010_ptranI02, ahei2010_etohI02, ahei2010_omegaI02, ahei2010_whgrnI02, ahei2010_naI02);
    aheineggs02 = sum(ahei2010_nutI02, ahei2010_ssbI02, ahei2010_vegI02, ahei2010_frtI02, ahei2010_polyI02, ahei2010_ptranI02, ahei2010_etohI02, ahei2010_omegaI02, ahei2010_whgrnI02, ahei2010_naI02);

    ahei06=ahei2010_06;
    aheinoal06=ahei2010_noETOH06;
    aheinopt06  = sum(ahei2010_vegI06, ahei2010_frtI06, ahei2010_ssbI06, ahei2010_whgrnI06, ahei2010_nutI06, ahei2010_rmtI06, ahei2010_etohI06, ahei2010_omegaI06, ahei2010_naI06);
    aheifisha06 = sum(ahei2010_nutI06, ahei2010_ssbI06, ahei2010_vegI06, ahei2010_frtI06, ahei2010_polyI06, ahei2010_ptranI06, ahei2010_etohI06, ahei2010_whgrnI06, ahei2010_naI06);
    aheidairy06 = sum(ahei2010_nutI06, ahei2010_ssbI06, ahei2010_vegI06, ahei2010_frtI06, ahei2010_polyI06, ahei2010_ptranI06, ahei2010_etohI06, ahei2010_omegaI06, ahei2010_whgrnI06, ahei2010_naI06);
    aheinutbl06 = sum(ahei2010_ssbI06, ahei2010_vegI06, ahei2010_frtI06, ahei2010_polyI06, ahei2010_ptranI06, ahei2010_etohI06, ahei2010_omegaI06, ahei2010_whgrnI06, ahei2010_naI06);
    aheipoult06 = sum(ahei2010_nutI06, ahei2010_ssbI06, ahei2010_vegI06, ahei2010_frtI06, ahei2010_polyI06, ahei2010_ptranI06, ahei2010_etohI06, ahei2010_omegaI06, ahei2010_whgrnI06, ahei2010_naI06);
    aheineggs06 = sum(ahei2010_nutI06, ahei2010_ssbI06, ahei2010_vegI06, ahei2010_frtI06, ahei2010_polyI06, ahei2010_ptranI06, ahei2010_etohI06, ahei2010_omegaI06, ahei2010_whgrnI06, ahei2010_naI06);

    ahei10=ahei2010_10;
    aheinoal10=ahei2010_noETOH10;
    aheinopt10  = sum(ahei2010_vegI10, ahei2010_frtI10, ahei2010_ssbI10, ahei2010_whgrnI10, ahei2010_nutI10, ahei2010_rmtI10, ahei2010_etohI10, ahei2010_omegaI10, ahei2010_naI10);
    aheifisha10 = sum(ahei2010_nutI10, ahei2010_ssbI10, ahei2010_vegI10, ahei2010_frtI10, ahei2010_polyI10, ahei2010_ptranI10, ahei2010_etohI10, ahei2010_whgrnI10, ahei2010_naI10);
    aheidairy10 = sum(ahei2010_nutI10, ahei2010_ssbI10, ahei2010_vegI10, ahei2010_frtI10, ahei2010_polyI10, ahei2010_ptranI10, ahei2010_etohI10, ahei2010_omegaI10, ahei2010_whgrnI10, ahei2010_naI10);
    aheinutbl10 = sum(ahei2010_ssbI10, ahei2010_vegI10, ahei2010_frtI10, ahei2010_polyI10, ahei2010_ptranI10, ahei2010_etohI10, ahei2010_omegaI10, ahei2010_whgrnI10, ahei2010_naI10);
    aheipoult10 = sum(ahei2010_nutI10, ahei2010_ssbI10, ahei2010_vegI10, ahei2010_frtI10, ahei2010_polyI10, ahei2010_ptranI10, ahei2010_etohI10, ahei2010_omegaI10, ahei2010_whgrnI10, ahei2010_naI10);
    aheineggs10 = sum(ahei2010_nutI10, ahei2010_ssbI10, ahei2010_vegI10, ahei2010_frtI10, ahei2010_polyI10, ahei2010_ptranI10, ahei2010_etohI10, ahei2010_omegaI10, ahei2010_whgrnI10, ahei2010_naI10);
run;


%include '/udd/nhsem/Potato.T2D/NHS/act_nhs.sas'; 

%act8614(keep=act86m act88m  act92m act94m act96m act98m act00m  act04m  act08m  act12m act14m 
            actc86m actc88m  actc92m actc94m actc96m actc98m actc00m  actc04m  actc08m  actc12m actc14m);


    **************************************************
    *           Family hostory of diseases           *
    **************************************************;
    /*** read family history of diabetes ***/
    %nur82(keep=fdb82 sdb82 mdb82 bdb82 dbfh82 mclc82 fclc82 sclc82 bclc82 mbrcn82 sbrcn82 cafh);
       if fdb82=1 or mdb82=1 or sdb82=1 or bdb82=1 then dbfh82=1;
       else dbfh82=0;
       cafh=0;
       if mclc82=1 or fclc82=1 or sclc82=1 or bclc82=1 or mbrcn82=1 or sbrcn82=1 then cafh=1;
       run;
       proc sort;  by id; run;

    /*** read family history of diabetes ***/
    %nur88(keep=fdb88 sdb88 mdb88 bdb88 dbfh88);
       if fdb88=1 or mdb88=1 or sdb88=1 or bdb88=1 then dbfh88=1;
       else dbfh88=0;
       run;
       proc sort;  by id; run;

    /*** read family history of diabetes * hypertension ***/ 
    %nur92(keep=fdb92 sdb92 mdb92 dbfh92 fhbp92 shbp92 mhbp92 hbpfh92);
       if fdb92=1 or mdb92=1 or sdb92=1 then dbfh92=1;
       if fhbp92=1 or mhbp92=1 or shbp92=1 then hbpfh92=1;
       else hbpfh92=0;
       proc sort;  by id; run;

    /*** read family history of MI (parents)***/
   %n767880(keep=   mmi76 fmi76 ammi76 afmi76 mothmi fathmi mifh76);
      
      if mmi76=1 and ammi76<=60 then mothmi=1;
      if fmi76=1 and afmi76<=60 then fathmi=1;
      mifh76=0;
      if mothmi=1 or fathmi=1 then mifh76=1;
      run;

    /*** read family history of MI & stroke (brother/sister)***/
   %nur96(keep=brmi96 brmid96 smi96 smid96 mifh96 bstr96 bstrd96 sstr96 sstrd96 strfh96);
      if (brmi96=1 and brmid96 in (1,2)) or (smi96=1 and smid96 in (1,2)) then mifh96=1; else mifh96=0;
      if (bstr96=1 and bstrd96 in (1,2)) or (sstr96=1 and sstrd96 in (1,2)) then strfh96=1; else strfh96=0;

    /*** read family history of MI & stroke (brother/sister/offspring-MI///parents/sibling for stroke)***/
   %nur08(keep=brmi08 brmid08 smi08 smid08 omi08 omid08 mifh08 mstr08 mstrd08 fstr08 fstrd08 sstr08 sstrd08 strfh08);
      if (brmi08=1 and brmid08 in (1,2)) or (smi08=1 and smid08 in (1,2)) or (omi08=1 and omid08 in (1,2)) then mifh08=1; else mifh08=0;
      if (mstr08=1 and mstrd08 in (1,2)) or (fstr08=1 and fstrd08 in (1,2)) or (sstr08=1 and sstrd08 in (1,2)) then strfh08=1; else strfh08=0;

   data familyhis;
      merge nur82  nur88  nur92 n767880 nur96 nur08;
      by id;
      if dbfh82=1 or dbfh88=1 or dbfh92=1 then dbfh=1; else dbfh=0;
      if hbpfh92=1 then hbpfh=1; else hbpfh=0;
      if mifh76=1 or mifh96 or mifh08=1 then mifh=1; else mifh=0; /*** note: family history of MI before 60 years, ref: Fung T AJCN 2009paper***/
      if strfh96=1 or strfh08=1 then strfh=1; else strfh=0;
      if fdb82=1 or mdb82=1 or fdb88=1 or mdb88=1 or fdb92=1 or mdb92=1 then parentaldm=1; else parentaldm=0;
      if mdb82=1 or mdb88=1 or mdb92=1 then mdm=1; else  mdm=0;
      if fdb82=1 or fdb88=1 or fdb92=1 then fdm=1; else fdm=0;
      keep id dbfh mifh hbpfh strfh dbfh82 parentaldm mdm fdm cafh;
      proc sort; by id; run;
      
    PROC DATASETS;
    delete nur82  nur88  nur92 n767880 nur96 nur08;
    RUN;
      
    **************************************************
    *         database of BMI   & covariables        *
    **************************************************;

    /*Potato read in*/
    %include '/udd/nhsem/Potato.T2D/MousaviSeyed_potato_T2D_052024/food_nhs.sas';

    %n767880(keep=dadoc momoc ses16 vite80 vite80d mar80
                    ht76 wt18 wt76 wt78 wt80 chol76 chol78 chol80 hbp76  hbp78  hbp80 db76   db78   db80 alstsmk);
            if dadoc=1 or dadoc=2 then ses16=1; else ses16=0;
             if vite80=1 then vite80d=1;
             else if vite80=2 then vite80d=0;
             else vite80d=.;

    %der7620(keep=id curh80 hor12 bmi80 bmi82 bmi84 bmi86 bmi88 bmi90 bmi92 
            bmi94 bmi96 bmi98 bmi00 bmi02 bmi04 bmi06 bmi08 bmi10 bmi12 bmi14 bmi16 bmiage18 nhor76 nhor78 nhor80 nhor82 nhor84 nhor86 nhor88 nhor90 nhor92 nhor94
            nhor96 nhor98 nhor00 nhor02 nhor04 nhor06 nhor08 nhor10 nhor12 nhor14 nhor16 mrace9204 eth9204 catrace catrace2
            mobf yobf race9204 white
                 irt76 irt78   irt80   irt82   irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16 
                 age76 age78 age80 age82 age84 age86 age88 age90 age92 age94 age96 age98 age00 age02 age04 age06 age08 age10 age12 age14 age16 
                 smkdr76 smkdr78 smkdr80 smkdr82 smkdr84 smkdr86 smkdr88 smkdr90 smkdr92 smkdr94 smkdr96 smkdr98 smkdr00 smkdr02 smkdr04 smkdr06 smkdr08 smkdr10 smkdr12 smkdr14 smkdr16 
                 can76   can78   can80   can82   can84 can86 can88 can90 can92 can94 can96 can98 can00 can02 can04 can06 can08 can10 can12 can14 can16 
                 hrt76   hrt78   hrt80   hrt82   hrt84 hrt86 hrt88 hrt90 hrt92 hrt94 hrt96 hrt98 hrt00 hrt02 hrt04 hrt06 hrt08 hrt10 hrt12 hrt14 hrt16 
                 strrace);
            hor12=nhor12;
            irt18=1422;
            age18=age16+24;
            if nhor80=3 then curh80=1;
            if nhor80 in (1,2,4) then curh80=2;
            else curh80=.;

            if mrace9204=1 and eth9204 ne 1 then catrace=0; /*non-hispanic white*/
            else if mrace9204=2 and eth9204 ne 1 then catrace=1; /*non-hispanic black*/
            else if eth9204=1 then catrace=2; /*Hispanic*/
            else if mrace9204=4 then catrace=3; /*Asian*/
            else catrace=.; /*Unknown/Other*/

            if catrace=0 then catrace2=0; /*non-hispanic white*/
            else if catrace in (1,2,3) then catrace2=1;
            else catrace2=.; /*Unknown*/

              /***race9204 i1 race $label 1.white;\2.black;\ 3.amerind;\ 4.asian;\ 5.hawaiian ***/
              if race9204=1 then white=1; else white=0;
              if race9204=. then white=.;

              if race9204=1 then strrace=1;
              else if race9204=2 then strrace=2;
              else if race9204 in (3,4,5) then strrace=3;
              else strrace=.;
            proc sort; by id; run;
  
    %meds8020(keep= aspu84 aspu86 aspu88 aspu90 aspu92 aspu94 aspu96 aspu98 aspu00 aspu02 aspu04 aspu06 aspu08 aspu10 aspu12 aspu14 aspu16
                    aspyn84 aspyn84 aspyn88   aspyn90  aspyn92  aspyn94  aspyn96  aspyn98  aspyn00  aspyn02  aspyn04  aspyn06  aspyn08  aspyn10  aspyn12 aspyn14 aspyn16);
    if aspu84 = 1 then aspyn84 = 1; else aspyn84 = 0;
    if aspu86 = 1 then aspyn86 = 1; else aspyn86 = 0;
    if aspu88 = 1 then aspyn88 = 1; else aspyn88 = 0;
    if aspu90 = 1 then aspyn90 = 1; else aspyn90 = 0;
    if aspu92 = 1 then aspyn92 = 1; else aspyn92 = 0;
    if aspu94 = 1 then aspyn94 = 1; else aspyn94 = 0;
    if aspu96 = 1 then aspyn96 = 1; else aspyn96 = 0;
    if aspu98 = 1 then aspyn98 = 1; else aspyn98 = 0;
    if aspu00 = 1 then aspyn00 = 1; else aspyn00 = 0;
    if aspu02 = 1 then aspyn02 = 1; else aspyn02 = 0;
    if aspu04 = 1 then aspyn04 = 1; else aspyn04 = 0;
    if aspu06 = 1 then aspyn06 = 1; else aspyn06 = 0;
    if aspu08 = 1 then aspyn08 = 1; else aspyn08 = 0;
    if aspu10 = 1 then aspyn10 = 1; else aspyn10 = 0;
    if aspu12 = 1 then aspyn12 = 1; else aspyn12 = 0;
    if aspu14 = 1 then aspyn14 = 1; else aspyn14 = 0;
    if aspu16 = 1 then aspyn16 = 1; else aspyn16 = 0;


    %n84_nts(keep=aofib84n ceraf84n alco84n calor84n trans84n sat84n mon84n poly84n gid84n gl84n fol_84n chol84n prot84n carbo84n tfat84n carbden84n protden84n tfatden84n);
    carbden84n = (carbo84n*4)/calor84n;
    protden84n = (prot84n*4)/calor84n;
    tfatden84n= (tfat84n*9)/calor84n;

    proc sort; by id; run; 

    %n86_nts(keep=aofib86n ceraf86n alco86n calor86n trnss86n sat86n mon86n poly86n gid86n gl86n fol_86n chol86n prot86n carbo86n tfat86n carbden86n protden86n tfatden86n);
    carbden86n = (carbo86n*4)/calor86n;
    protden86n = (prot86n*4)/calor86n;
    tfatden86n= (tfat86n*9)/calor86n;
    proc sort; by id; run;

    %n90_nts(keep=aofib90n ceraf90n alco90n calor90n trnss90n sat90n mon90n poly90n gid90n gl90n fol_90n chol90n prot90n carbo90n tfat90n carbden90n protden90n tfatden90n);
    carbden90n = (carbo90n*4)/calor90n;
    protden90n = (prot90n*4)/calor90n;
    tfatden90n= (tfat90n*9)/calor90n;
    proc sort; by id; run;

    %n94_nts(keep=aofib94n ceraf94n alco94n calor94n trnss94n sat94n mon94n poly94n gid94n gl94n fol_94n chol94n prot94n carbo94n tfat94n carbden94n protden94n tfatden94n);
    carbden94n = (carbo94n*4)/calor94n;
    protden94n = (prot94n*4)/calor94n;
    tfatden94n= (tfat94n*9)/calor94n;
    proc sort; by id; run;

    %n98_nts(keep=aofib98n ceraf98n alco98n calor98n trn0098n sat98n mon98n poly98n gid98n gl98n fol9898n chol98n prot98n carbo98n tfat98n carbden98n protden98n tfatden98n);
    carbden98n = (carbo98n*4)/calor98n;
    protden98n = (prot98n*4)/calor98n;
    tfatden98n= (tfat98n*9)/calor98n;
    proc sort; by id; run;

    %n02_nts(keep=aofib02n ceraf02n alco02n calor02n trn0202n sat02n mon02n poly02n gid02n gl02n fol9802n chol02n prot02n carbo02n tfat02n carbden02n protden02n tfatden02n);
    carbden02n = (carbo02n*4)/calor02n;
    protden02n = (prot02n*4)/calor02n;
    tfatden02n= (tfat02n*9)/calor02n;
    proc sort; by id; run;

    %n06_nts(keep=aofib06n ceraf06n alco06n calor06n trn0706n sat06n mon06n poly06n gid06n gl06n fol9806n chol06n prot06n carbo06n tfat06n carbden06n protden06n tfatden06n);
    carbden06n = (carbo06n*4)/calor06n;
    protden06n = (prot06n*4)/calor06n;
    tfatden06n= (tfat06n*9)/calor06n;
    proc sort; by id; run;

    %n10_nts(keep=aofib10n ceraf10n alco10n calor10n trn1110n sat10n mon10n poly10n gid10n gl10n fol9810n chol10n prot10n carbo10n tfat10n carbden10n protden10n tfatden10n);
    carbden10n = (carbo10n*4)/calor10n;
    protden10n = (prot10n*4)/calor10n;
    tfatden10n= (tfat10n*9)/calor10n;
    proc sort; by id; run;
            
    %nur82(keep=id str82 ra82 mvit82  vite82 hbp82 wt82 chol82 hbp82 db82);

    %nur84(keep=id hbp84 wt84 chol84 hbp84 db84 cabg84 str84 ang84);

    %nur86(keep=id str86 ra86 cabg86 vite86 brcn86 curh86 wt86 hbp86 wt86 chol86 db86);

    %nur88(keep=id physx88 str88 ra88 cabg88 thiaz88 ccblo88 betab88 ace88 bprx88 clrx88 pct588 pct1088 shift88
                           size5 size10 mvt88 vite88 curh88 serum88 wt88 hbp88 chol88 db88);
    /* age 5 shape */   if 1 <= pct588 <= 9 then size5=pct588;  else size5=.;
    /* age 10 shape */  if 1 <= pct1088 <= 9 then size10=pct1088;     else size10=.;

    %nur90(keep=id physx90 str90 ra90 cabg90 curh90 serum90 wt90 hbp90 chol90 db90);
  
    %nur92(keep=id physx92 str92 ra92 cabg92 alone92 mvt92 vite92 curh92 wt92 hbp92
        stbrn92 st1592 st3092 seuro92 scand92 ocauc92 afric92 hisp92 asian92 nativ92 oanc92 marry92 husbe92 alone92 rn92 ba92 ma92 dr92 chol92 db92); 

    %nur94(keep=id physx94 str94 cabg94 thiaz94 lasix94 ccblo94 betab94 bprx94 couma94  digox94 clrx94 curh94 serum94 wt94 hbp94 chol94 db94);

    %nur96(keep=id physc96 physy96 str96 cabg96 ra96  thiaz96   lasix96    ccblo96    betab96    ace96   bprx96    couma96   digox96   antia96 
                   antid96 marry96 alone96  chrx96 mvt96 vite96 curh96 wt96 hbp96
                   marry96 divor96 separ96 widow96 nvrmr96 alone96 chol96 db96);/*mvt96: 1=no;2=yes;3=pass*/

    %nur98(keep=id physc98 physy98 str98 cabg98 thiaz98   lasix98    ccblo98    betab98    ace98   bprx98 couma98   digox98   antia98
                   antid98 chrx98 chrx98 curh98 wt98 chf98 hbp98 chol98 db98);
    if chf98=1 then chf98=0;
    else if chf98=2 or chf98=3 then chf98=1;
    else chf98=2;run;

    %nur00(keep=id physc00 physy00 str00 ra00 cabg00 thiaz00   lasix00    ccblo00    betab00    ace00   bprx00   couma00   digox00   antia00
                   marry00 alone00 oclrx00 chrx00 chrxd00 przc00 zol00 paxil00 celex00 antid00 
                   mvit00 vite00 curh00 wt00 chf00 chfd00 hbp00
                   marry00 divor00 separ00 widow00 nvmar00 alone00 chol00 db00);  /** mvit00: 1=yes 2=no 3=pass**/

    %nur02(keep=id physc02 physy02 ra02 sleep02 sleep02c snore02 snore02c str02 renf02  renfd02 iron02d 
                cabg02 przc02 zol02 paxil02 celex02 antid02 
                bprx02 lasix02 thiaz02 ace02 ccblo02 betab02 
                 couma02   digox02   antia02 chrx02 oclrx02 curh02 wt02 chf02 chfd02 hbp02 mvit02d vite02d chol02 db02);    
                                                         /*** mvit02d Q22: Multi-vitamin (L22) $label 1.no; 2.yes; 3.pt ***/
                                                         /*renfd02 Chronic Renal Failure Dt Dx (L18) $label 1.96 or before; 2.97-99; 3.2000; 4.2001;*/
            if iron02d ne 1 then iron02d=0;
            if sleep02 in (1,2) then sleep02c=5;
               else if sleep02=3 then sleep02c=6;            
               else if sleep02=4 then sleep02c=7;  
               else if sleep02=5 then sleep02c=8;   
               else if sleep02 in (6,7) then sleep02c=9;
               else sleep02c=.;
             if snore02 in (1,2,3,4,5) then snore02c=5-snore02; else snore02c=.;

    %nur04(keep=id physc04 physy04 mvit04 str04 strd04 ra04 rad04 renf04 renfd04 ang04 angd04
                cabg04 cabgd04 antid04 ssri04 bprex04 lasix04 thiaz04 ace04 ccblo04 betab04 k04 iron04 antia04
                marry04 alone04 mev04 zoc04 crest04 prav04 lip04 lesc04 oclrx04 vite04 curh04 serum04 wt04 chol04 hbp04 db04 chf04 chfd04
                marry04 divor04 separ04 widow04 nvrmr04 dompa04 alone04 db04);/*mvit04(L31)$label 1.yes; 2.no; 3.pt*/
                                                           /*renfd04 Chronic Renal Failure dtdx (L17)$label 1.96 or before; 2.97-01; 3.2002; 4.2003;\5.2004; 6.pt***/

    %nur06(keep=id physc06 physy06 mvit06d str06 strd06 ra06 rad06 ang06 angd06 cabg06 
                cabgd06  antid06 ssri06 bprx06 lasix06 thiaz06 ace06 ccblo06 betab06 k06 iron06d antia06
                mev06 zoc06 crest06 prav06 lip06 ostat06 oclrx06 vite06d curh06 wt06 chf06 chfd06 hbp06 chol06 db06);    /*mvit06d  $alias multvit $label 1.no; 2.yes; 3.pt*/

    %nur08(keep=mvit08 physc08 physy08 str08 strd08 ra08 rad08 yr08 mo08 irt08 wt08
                db08 dbd08 chol08 chold08 hbp08 hbpd08 mi08 mid08 ang08 angd08 str08 strd08 alone08 marry08
                cabg08 cabgd08 antid08 ssri08 bprx08 lasix08 thiaz08 ace08 ccblo08 betab08 k08 
                stat08 mev08 zoc08 crest08 prav08 lip08 ostat08 oclrx08 curh08 serum08 chf08 chfd08
                marry08 divor08 separ08 widow08 nvmr08 dompa08 alone08 db08);  /*mvit08(L58) $label 1.yes; 2.no; 3.pt*/
    if mo08=. then mo08=6;
    if yr08 in (2008,2009,2010) then irt08=(yr08-1900)*12+mo08-6;else irt08=.;

    %nur10(keep=mvit10d wt10 ra10 rad10 chol10 chold10 hbp10 hbpd10 db10 dbd10 mi10 mid10   mih10
            ang10   angd10  angc10  cabg10  cabgd10 chf10   chfd10  str10   strd10 antid10 ssri10
                nasp10  ibu10   ibud10  nibu10  celeb10 celed10 ibut10  thiaz10 lasix10 
                k10 ccblo10 betab10 ace10   angio10 bprx10  couma10 plavi10 digox10 
                antia10 stat10  mev10   prav10  zoc10   lip10   crest10 ostat10 statinpt10  oclrx10
                physx10 physc10 physy10 physpt10 mo10 yr10  vite10d vited10d  curh10 chf10 chfd10); /*mvit10d $label 1.no; 2.yes; 3.pt*/

    %nur12(keep=wt12 ra12 rad12 chol12 chold12 hbp12 hbpd12 db12 dbd12 mi12 mid12   mih12
            ang12   angd12  angc12  cabg12  cabgd12 chf12   chfd12  str12   strd12 antid12 ssri12
                nasp12  ibu12   ibud12  nibu12  celeb12 celed12 ibut12  thiaz12 lasix12 
                k12 ccblo12 betab12 ace12   angio12 bprx12  couma12 plavi12 digox12 
                antia12 mev12   prav12  zoc12   lip12   crest12 ostat12 oclrx12
                physx12 physc12 physy12 physpt12 mo12 yr12 curh12 chf12 chfd12
                marry12 divor12 separ12 widow12 nvrmr12 dompa12 alone12); /*mvit12d $label 1.no; 2.yes; 3.pt*/
     run;

    %nur14(keep=wt14 ra14 rad14 chol14 chold14 hbp14 hbpd14 db14 dbd14 mi14 mid14   mih14
            ang14   angd14  angc14  cabg14  cabgd14 chf14   chfd14  str14   strd14 antid14 ssri14
                nasp14  ibu14   ibud14  nibu14  celeb14 celed14 ibut14  thiaz14 lasix14 
                k14 ccblo14 betab14 ace14   angio14 bprx14  couma14 plavi14 digox14 
                antia14 mev14   prav14  zoc14   lip14   crest14 ostat14 oclrx14
                physx14 physc14 physy14 physpt14 mo14 yr14 curh14 chf14 chfd14 mvit14d ); /*mvit14d $label 1.no; 2.yes; 3.pt*/

    %nur16(keep=wt16 /*ra14 rad14*/ chol16 chold16 hbp16 hbpd16 db16 dbd16 mi16 mid16   mih16
            ang16   angd16  angc16  cabg16  cabgd16 chf16   chfd16  str16   strd16 antid16 ssri16
                nasp16  ibu16   ibud16  nibu16  celeb16 celed16 ibut16  thiaz16 lasix16 
                k16 ccblo16 betab16 ace16   angio16 bprx16  couma16 plavi16 digox16 
                antia16 mev16   prav16  zoc16   lip16   crest16 ostat16 oclrx16
                physx16 physc16 physy16 physpt16 mo16 yr16 curh16 chf16 chfd16 mvit16d alone16 marry16); /*mvit16d $label 1.no; 2.yes; 3.pt*/

    %nur20(keep=wt20 /*ra14 rad14*/ chol20 chold20 hbp20 hbpd20 db20 dbd20 mi20 mid20 mih20
            ang20   angd20  angc20  cabg20  cabgd20 chf20   chfd20  str20  strd20 antida20 
                nasp20  ibu20   ibud20  nibu20 ibut20 ibutd20 thiaz20
                ccblo20 betab20 ace20   angio20 bprx20  couma20 plavi20 digox20 antia20 
                stat20 oclrx20 
                physx20 physc20 physy20 physpt20 mo20 yr20 curh20 chf20 chfd20 mvit20d alone20 marry20); /*mvit16d $label 1.no; 2.yes; 3.pt*/

%supp8020(keep= vitau84 vitau86 vitau88 vitau90 vitau92 vitau94 vitau96 vitau98 vitau00 vitau02 vitau04 vitau06 vitau08 vitau10 vitau12 vitau14 vitau16
            vitcu84 vitcu86 vitcu88 vitcu90 vitcu92 vitcu94 vitcu96 vitcu98 vitcu00 vitcu02 vitcu04 vitcu06 vitcu08 vitcu10 vitcu12 vitcu14 vitcu16
            viteu84 viteu86 viteu88 viteu90 viteu92 viteu94 viteu96 viteu98 viteu00 viteu02 viteu04 viteu06 viteu08 viteu10 viteu12 viteu14 viteu16
            vitdu84 vitdu86 vitdu88 vitdu90 vitdu92 vitdu94 vitdu96 vitdu98 vitdu00 vitdu02 vitdu04 vitdu06 vitdu08 vitdu10 vitdu12 vitdu14 vitdu16
            mvitu84 mvitu86 mvitu88 mvitu90 mvitu92 mvitu94 mvitu96 mvitu98 mvitu00 mvitu02 mvitu04 mvitu06 mvitu08 mvitu10 mvitu12 mvitu14 mvitu16
            calcu84 calcu86 calcu88 calcu90 calcu92 calcu94 calcu96 calcu98 calcu00 calcu02 calcu04 calcu06 calcu08 calcu10 calcu12 calcu14 calcu16
            seleu84 seleu86 seleu88 seleu90 seleu92 seleu94 seleu96 seleu98 seleu00 seleu02 seleu04 seleu06 seleu08 seleu10 seleu12 seleu14 seleu16
            zincu84 zincu86 zincu88 zincu90 zincu92 zincu94 zincu96 zincu98 zincu00 zincu02 zincu04 zincu06 zincu08 zincu10 zincu12 zincu14 zincu16
            suppu84 suppu86 suppu88 suppu90 suppu92 suppu94 suppu96 suppu98 suppu00 suppu02 suppu04 suppu06 suppu08 suppu10 suppu12 suppu14 suppu16);
if mvitu84 ne 1 then mvitu84 = 0;
if mvitu86 ne 1 then mvitu86 = 0;
if mvitu88 ne 1 then mvitu88 = 0;
if mvitu90 ne 1 then mvitu90 = 0;
if mvitu92 ne 1 then mvitu92 = 0;
if mvitu94 ne 1 then mvitu94 = 0;
if mvitu96 ne 1 then mvitu96 = 0;
if mvitu98 ne 1 then mvitu98 = 0;
if mvitu00 ne 1 then mvitu00 = 0;
if mvitu02 ne 1 then mvitu02 = 0;
if mvitu04 ne 1 then mvitu04 = 0;
if mvitu06 ne 1 then mvitu06 = 0;
if mvitu08 ne 1 then mvitu08 = 0;
if mvitu10 ne 1 then mvitu10 = 0;
if mvitu12 ne 1 then mvitu12 = 0;
if mvitu14 ne 1 then mvitu14 = 0;
if mvitu16 ne 1 then mvitu16 = 0;

if vitau84 in (1,2,3) or vitcu84 in (1,2,3) or viteu84=1 or vitdu84=1 or mvitu84=1 or calcu84=1 or seleu84=1 or zincu84=1 then suppu84=1; else suppu84=0;
if vitau86 in (1,2,3) or vitcu86 in (1,2,3) or viteu86=1 or vitdu86=1 or mvitu86=1 or calcu86=1 or seleu86=1 or zincu86=1 then suppu86=1; else suppu86=0;
if vitau88 in (1,2,3) or vitcu88 in (1,2,3) or viteu88=1 or vitdu88=1 or mvitu88=1 or calcu88=1 or seleu88=1 or zincu88=1 then suppu88=1; else suppu88=0;
if vitau90 in (1,2,3) or vitcu90 in (1,2,3) or viteu90=1 or vitdu90=1 or mvitu90=1 or calcu90=1 or seleu90=1 or zincu90=1 then suppu90=1; else suppu90=0;
if vitau92 in (1,2,3) or vitcu92 in (1,2,3) or viteu92=1 or vitdu92=1 or mvitu92=1 or calcu92=1 or seleu92=1 or zincu92=1 then suppu92=1; else suppu92=0;
if vitau94 in (1,2,3) or vitcu94 in (1,2,3) or viteu94=1 or vitdu94=1 or mvitu94=1 or calcu94=1 or seleu94=1 or zincu94=1 then suppu94=1; else suppu94=0;
if vitau96 in (1,2,3) or vitcu96 in (1,2,3) or viteu96=1 or vitdu96=1 or mvitu96=1 or calcu96=1 or seleu96=1 or zincu96=1 then suppu96=1; else suppu96=0;
if vitau98 in (1,2,3) or vitcu98 in (1,2,3) or viteu98=1 or vitdu98=1 or mvitu98=1 or calcu98=1 or seleu98=1 or zincu98=1 then suppu98=1; else suppu98=0;
if vitau00 in (1,2,3) or vitcu00 in (1,2,3) or viteu00=1 or vitdu00=1 or mvitu00=1 or calcu00=1 or seleu00=1 or zincu00=1 then suppu00=1; else suppu00=0;
if vitau02 in (1,2,3) or vitcu02 in (1,2,3) or viteu02=1 or vitdu02=1 or mvitu02=1 or calcu02=1 or seleu02=1 or zincu02=1 then suppu02=1; else suppu02=0;
if vitau04 in (1,2,3) or vitcu04 in (1,2,3) or viteu04=1 or vitdu04=1 or mvitu04=1 or calcu04=1 or seleu04=1 or zincu04=1 then suppu04=1; else suppu04=0;
if vitau06 in (1,2,3) or vitcu06 in (1,2,3) or viteu06=1 or vitdu06=1 or mvitu06=1 or calcu06=1 or seleu06=1 or zincu06=1 then suppu06=1; else suppu06=0;
if vitau08 in (1,2,3) or vitcu08 in (1,2,3) or viteu08=1 or vitdu08=1 or mvitu08=1 or calcu08=1 or seleu08=1 or zincu08=1 then suppu08=1; else suppu08=0;
if vitau10 in (1,2,3) or vitcu10 in (1,2,3) or viteu10=1 or vitdu10=1 or mvitu10=1 or calcu10=1 or seleu10=1 or zincu10=1 then suppu10=1; else suppu10=0;
if vitau12 in (1,2,3) or vitcu12 in (1,2,3) or viteu12=1 or vitdu12=1 or mvitu12=1 or calcu12=1 or seleu12=1 or zincu12=1 then suppu12=1; else suppu12=0;
if vitau14 in (1,2,3) or vitcu14 in (1,2,3) or viteu14=1 or vitdu14=1 or mvitu14=1 or calcu14=1 or seleu14=1 or zincu14=1 then suppu14=1; else suppu14=0;
if vitau16 in (1,2,3) or vitcu16 in (1,2,3) or viteu16=1 or vitdu16=1 or mvitu16=1 or calcu16=1 or seleu16=1 or zincu16=1 then suppu16=1; else suppu16=0;run;

%nses7616 ;
run;

data nses7616;
   set nses7616;
   keep id division: region: state: mdinc: mdvhs: pcolled: pfaminterest:
             pfwchbf: phs: pnohs: pkid: pold: pohse: popd: ppov: pwht: ;
run;
proc sort data=nses7616; by id; run;


/*********diabetes*********/
data diab_case;
infile lrecl=183 recfm=d;

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
proc freq data=diab_case;tables type;run;
data diab_case;
    set diab_case;
    if cohort = 1 and type =2;

    dtdxdiab=dxmonth*1;
    if dtdxdiab=. then dtdxdiab=1007;

    symp=0;
    if symptot>0 or screen=2 then symp=1;
    label symp="Symptoms";

    keep id dtdxdiab probabil symp;

proc sort;by id;run;

/*proc univariate data=diab_case;var dtdxdiab;run;endsas;
proc freq data=diab_case;tables diabcase probabil diabcase*probabil;run;*/


                              /********************
                              *      database    *
                              ********************/

 data all;
    merge n84_nts n86_nts n90_nts n94_nts  n98_nts  n02_nts  n06_nts n10_nts
          familyhis n767880 der7620 (in=dog) nur82 nur84 nur86 nur88 nur90 nur92 nur94 nur96 nur98 nur00 nur02 nur04 nur06 nur08 nur10 nur12 nur14 nur16 nur20
          aheinhs ahei2010_8410 deadff1 exernhs act8614 mi_all cabg stroke supp8020 diab_case foods nses7616 end=_end_;
 
     by id;
     exrec=1;
     if first.id and dog then exrec=0; 

          if 913<=dtdxdiab<937 then diab76=1;
          else diab76=0;
          if 937<=dtdxdiab<961 then diab78=1;
          else diab78=0;
          if 961<=dtdxdiab<985 then diab80=1;
          else diab80=0;
          if 985<=dtdxdiab<1009 then diab82=1;
          else diab82=0;
          if 1009<=dtdxdiab<1033 then diab84=1;
          else diab84=0;
          if 1033<=dtdxdiab<1057 then diab86=1;
          else diab86=0;
          if 1057<=dtdxdiab<1081 then diab88=1;
          else diab88=0;
          if 1081<=dtdxdiab<1105 then diab90=1;
          else diab90=0;
          if 1105<=dtdxdiab<1129 then diab92=1;
          else diab92=0;
          if 1129<=dtdxdiab<1153 then diab94=1;
          else diab94=0;
          if 1153<=dtdxdiab<1177 then diab96=1;
          else diab96=0;
          if 1177<=dtdxdiab<1201 then diab98=1;
          else diab98=0;
          if 1201<=dtdxdiab<1225 then diab00=1;
          else diab00=0;
          if 1225<=dtdxdiab<1249 then diab02=1;
          else diab02=0;
          if 1249<=dtdxdiab<1273 then diab04=1;
          else diab04=0;
          if 1273<=dtdxdiab<1297 then diab06=1;
          else diab06=0;
          if 1297<=dtdxdiab<1321 then diab08=1;
          else diab08=0;
          if 1321<=dtdxdiab<1345 then diab10=1;
          else diab10=0;
          if 1345<=dtdxdiab<1369 then diab12=1;
          else diab12=0;
          if 1369<=dtdxdiab<1393 then diab14=1;
          else diab14=0;
          if 1393<=dtdxdiab<1417 then diab16=1;
          else diab16=0;
          if 1417<=dtdxdiab<1441 then diab18=1;
          else diab18=0;
          if 1441<=dtdxdiab<1465 then diab20=1;
          else diab20=0;

          /*** antidepressant medication ***/
           antidep76=0; 
           if antid96=1 then antidep96=1; else antidep96=0;
           if antid98=1 then antidep98=1; else antidep98=0;
           antidep00=0;if przc00=1 or zol00=1 or paxil00=1 or celex00=1 or antid00=1 then antidep00=1;
           antidep02=0; if przc02=1 or zol02=1 or paxil02=1 or celex02=1 or antid02=1 then antidep02=1;
           antidep04=0; if antid04=1 or ssri04=1 then antidep04=1;
           antidep06=0; if antid06=1 or ssri06=1 then antidep06=1;
           antidep08=0; if antid08=1 or ssri08=1 then antidep08=1;
           antidep10=0; if antid10=1 or ssri10=1 then antidep10=1;

          /***antihypertensive***/
           htnrx76=0; 
           if thiaz88=1 or ccblo88=1 or betab88=1 or ace88=1 or bprx88=1 then htnrx88=1;   else htnrx88=0;
           if thiaz94=1 or lasix94 =1 or ccblo94 =1 or betab94 =1 or bprx94=1 then htnrx94=1;   else htnrx94=0; 
           if thiaz96=1 or lasix96 =1 or ccblo96 =1 or betab96 =1 or ace96=1 or bprx96=1 then htnrx96=1;   else htnrx96=0; 
           if thiaz98=1 or lasix98 =1 or ccblo98 =1 or betab98 =1 or ace98=1 or bprx98=1 then htnrx98=1;   else htnrx98=0; 
           if thiaz00=1 or lasix00 =1 or ccblo00 =1 or betab00 =1 or ace00=1 or bprx00=1 then htnrx00=1;   else htnrx00=0; 
           if thiaz02=1 or lasix02 =1 or ccblo02 =1 or betab02 =1 or ace02=1 or bprx02=1 then htnrx02=1;   else htnrx02=0; 
           if bprex04=1 or lasix04=1 or  thiaz04=1 or ace04=1 or ccblo04=1 or  betab04=1 or k04=1 then htnrx04=1;   else htnrx04=0; 
           if bprx06=1 or lasix06=1 or thiaz06=1 or ace06=1 or ccblo06=1 or betab06=1 or k06=1 then htnrx06=1;   else htnrx06=0; 
           if bprx08=1 or lasix08=1 or thiaz08=1 or ace08=1 or ccblo08=1 or betab08=1 or k08=1 then htnrx08=1;   else htnrx08=0; 
           if bprx10=1 or lasix10=1 or thiaz10=1 or ace10=1 or ccblo10=1 or betab10=1 or k10=1 then htnrx10=1;   else htnrx10=0; 
           if bprx12=1 or lasix12=1 or thiaz12=1 or ace12=1 or ccblo12=1 or betab12=1 or k12=1 then htnrx12=1;   else htnrx12=0;
           if bprx14=1 or lasix14=1 or thiaz14=1 or ace14=1 or ccblo14=1 or betab14=1 or k14=1 then htnrx14=1;   else htnrx14=0;
           if bprx16=1 or lasix16=1 or thiaz16=1 or ace16=1 or ccblo16=1 or betab16=1 or k16=1 then htnrx16=1;   else htnrx16=0;

          /***heart diseases medications ***/
           if (couma94=1 or digox94=1 or betab94 =1 or ccblo94 =1) then chdrx94=1; else chdrx94=0;/***digox94 inclde digoxin or antiarrhythmic***/
           if (couma96=1 or digox96=1 or antia96=1 or betab96 =1 or ccblo96 =1) then chdrx96=1; else chdrx96=0;   
           if (couma98=1 or digox98=1 or antia98=1 or betab98 =1 or ccblo98 =1) then chdrx98=1; else chdrx98=0;           
           if (couma00=1 or digox00=1 or antia00=1 or betab00 =1 or ccblo00 =1) then chdrx00=1; else chdrx00=0;
           if (couma02=1 or digox02=1 or antia02=1 or betab02 =1 or ccblo02 =1) then chdrx02=1; else chdrx02=0;

          /***antihtc***/  
           hchtx76=0;
           if clrx88=1 then hchtx88=1; else hchtx88=0;
           if clrx94=1 then hchtx94=1; else hchtx94=0;
           if chrx96=1 then hchtx96=1; else hchtx96=0;
           if chrx98=1 then hchtx98=1; else hchtx98=0;
           if chrx00=1 or oclrx00=1 then hchtx00=1; else hchtx00=0;
           if chrx02=1 or oclrx02=1 then hchtx02=1; else hchtx02=0;
           if  mev04=1 or zoc04=1 or crest04=1 or prav04=1 or lip04=1 or lesc04=1 or oclrx04=1 then hchtx04=1; else hchtx04=0;
           if  mev06=1 or zoc06=1 or crest06=1 or prav06=1 or lip06=1 or ostat06=1 or oclrx06=1 then hchtx06=1; else hchtx06=0;
           if  mev08=1 or zoc08=1 or crest08=1 or prav08=1 or lip08=1 or ostat08=1 or oclrx08=1 then hchtx08=1; else hchtx08=0;
           if  mev10=1 or zoc10=1 or crest10=1 or prav10=1 or lip10=1 or ostat10=1 or oclrx10=1 then hchtx10=1; else hchtx10=0;
           if  mev14=1 or zoc14=1 or crest14=1 or prav14=1 or lip14=1 or ostat14=1 or oclrx14=1 then hchtx14=1; else hchtx14=0;
           if  mev16=1 or zoc16=1 or crest16=1 or prav16=1 or lip16=1 or ostat16=1 or oclrx16=1 then hchtx16=1; else hchtx16=0;


           /***marry and living alone***/ 
            if alone92 ne 1 then alone92=0;
            if alone96 ne 1 then alone96=0;
            if alone00 ne 1 then alone00=0; 
            if alone04 ne 1 then alone04=0; 
            if alone08 ne 1 then alone08=0;
            if alone12 ne 1 then alone12=0;
            if alone16 ne 1 then alone16=0;


            if marry92=1 then mar92=1; else mar92=0;
            if marry96=1 then mar96=1; else mar96=0;
            if marry00=1 then mar00=1; else mar00=0;
            if marry04=1 then mar04=1; else mar04=0;
            if marry08=1 then mar08=1; else mar08=0;
            if marry12=1 then mar12=1; else mar12=0;
            if marry16=1 then mar16=1; else mar16=0;

            /** physical exam **/
 
            pexam88=0; if physx88=2 or physx88=3 then pexam88=1;
            pexam90=0; if physx90=2 or physx90=3 then pexam90=1;
            pexam92=0; if physx92=2 or physx92=3 then pexam92=1;
            pexam94=0; if physx94=2 then pexam94=1;
            pexam96=0; if physc96=1 or physy96=1 then pexam96=1;
            pexam98=0; if physc98=1 or physy98=1 then pexam98=1;
            pexam00=0; if physc00=1 or physy00=1 then pexam00=1;
            pexam02=0; if physc02=1 or physy02=1 then pexam02=1;
            pexam04=0; if physc04=1 or physy04=1 then pexam04=1; 
            pexam06=0; if physc06=1 or physy06=1 then pexam06=1; 
            pexam08=0; if physc08=1 or physy08=1 then pexam08=1; 
            pexam10=0; if physc10=1 or physy10=1 then pexam10=1; 

            /** physical exam for screening purposes **/
            psexam88=0; if physx88=3 then psexam88=1;
            psexam90=0; if physx90=2 then psexam90=1;
            psexam92=0; if physx92=2 then psexam92=1;
            psexam96=0; if physc96=1 then psexam96=1;
            psexam98=0; if physc98=1 then psexam98=1;
            psexam00=0; if physc00=1 then psexam00=1;
            psexam02=0; if physc02=1 then psexam02=1;
            psexam04=0; if physc04=1 then psexam04=1; 
            psexam06=0; if physc06=1 then psexam06=1; 
            psexam08=0; if physc08=1 then psexam08=1; 
            psexam10=0; if physc10=1 then psexam10=1; 

/* husband education */
   if husbe92 in(1,2) then huseduc=1; /*husband less than hs grad*/
   else if husbe92=3 then huseduc=2; /*hs educ*/
   else if husbe92 in(4,5) then huseduc=3; /*more than hs*/
   else if husbe92=. or husbe92=6 then huseduc=4; /*missing or skipped*/

   %indic3(vbl=huseduc, prefix=hused, min=2, max=3, reflev=1, missing=4,
        usemiss=1,  label1='less than hs', label2='hs grad', label3='more
        than hs', label4='missing educ');

   /*Create var similar to shift88 cat */
   if shift88=1 then shift88c=1; 
   else if shift88=2 then shift88c=2;
   else if shift88 in (3,4) then shift88c=3;
   else if shift88 in (5,6) then shift88c=4;
   else if shift88 in (7,8) then shift88c=5;
   else shift88c=.;

   label shift88c='Years of shift work 88, categorical';

      %indic3(vbl=shift88c, prefix=shift88c, min=2, max=5, reflev=1, usemiss=0,
      label1='Never',
      label2='1-2 years shift work',
      label3='3-9 years shift work',
      label4='10-19 years shift work',
      label5='20+ years shift work');

   /*if shift88c=1 then shift88cont=0; 
   else if shift88c=2 then shift88cont=1.5; 
   else if shift88c=3 then shift88cont=4;
   else if shift88c=4 then shift88cont=7.5;
   else if shift88c=5 then shift88cont=12;
   else if shift88c=6 then shift88cont=17;
   else if shift88c=7 then shift88cont=24.5;
   else if shift88c=8 then shift88cont=30;
   else shift88cont=.;

   label shift88cont='Years of SW, cont from midpoints of shift88 cats';/
*/
/* parents occupation*/
   if momoc=9 then momocc=1; /*housewife*/
   else if momoc in(0,1,2,3,4,5,6,7,8) then momocc=2; /*outside job*/
   else momocc=3; /*missing*/

   if momocc=1 then momwr=1; else momwr=0;
   if momocc=2 then momw2=1; else momw2=0;
   if momocc=3 then momwm=1; else momwm=0;

   label momwr="Housewife mom"
      momw2="Outside job mom"
      momwm="Mom occup missing";

   if dadoc in(1,2) then dadocc=1;/*professional or manager*/
   else if dadoc in(0,3,4,5,6,7,8,9) then dadocc=2; /*non prof-manager*/
   else dadocc=3; /*missing*/

   if dadocc=1 then dadwr=1; else dadwr=0;
   if dadocc=2 then dadw2=1; else dadw2=0;
   if dadocc=3 then dadwm=1; else dadwm=0;

   label dadwr="Professional or manager dad"
      dadw2="Other job dad"
      dadwm="Dad job missing";

   /* for education: base on rn92 create rn yes or no variable */
   if rn92=. and ba92=. and ma92=. and dr92=. then educm=1; else educm=0;
   if rn92=1 then rn=1; else rn=0;

   label educm="education info missing" rn="rn degree yes or no";

    
      if mobf<=0 or mobf>12 then mobf=6;   
       ** birthday in months;   
       bdt=12*yobf+mobf;
  

                 if alstsmk ^=0 and smkdr76 in (2,3,4,5,6,7,8) then quityr76=int((irt76-(12*yobf+mobf))/12)-alstsmk; 
                 if smkdr76 >8 and smkdr78 in (2,3,4,5,6,7,8) then quityr78=2; 
                 if smkdr78 >8 and smkdr80 in (2,3,4,5,6,7,8) then quityr80=2; 
                 if smkdr80 >8 and smkdr82 in (2,3,4,5,6,7,8) then quityr82=2; 
                 if smkdr82 >8 and smkdr84 in (2,3,4,5,6,7,8) then quityr84=2;
                 if quityr76>. then quityr=quityr76+8;
                 else quityr=sum(quityr78, quityr80, quityr82, quityr84); 
                 if quityr<0 then quityr=.;    
      run; 

proc univariate data=all;var dtdth;run;
proc univariate data=deadff;var dtdth;run;

proc freq data=all;tables mrace9204*eth9204;run;
proc freq data=all;tables catrace shift88c;run;

proc means data=all n mean std median; var bmi84;run;

data all;
   set all;

    /* Define arrays for the character state variables and their numeric counterparts */
    ARRAY state_char{16} $ state10_86 state10_88 state10_90 state10_92 state10_94 state10_96 
                         state10_98 state10_00 state10_02 state10_04 state10_06 state10_08 
                         state10_10 state10_12 state10_14 state10_16;

    ARRAY state_num{16} state10_86_num state10_88_num state10_90_num state10_92_num state10_94_num
                       state10_96_num state10_98_num state10_00_num state10_02_num state10_04_num 
                       state10_06_num state10_08_num state10_10_num state10_12_num state10_14_num 
                       state10_16_num;

    /* Define arrays for state names and numeric labels */
    ARRAY state_names{50} $ ('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 
                            'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 
                            'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 
                            'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 
                            'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 
                            'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 
                            'WI', 'WY');
    ARRAY state_labels{50} (1, 2, 3, 4, 5, 6, 7, 8, 
                            9, 10, 11, 12, 13, 14, 15, 16, 
                            17, 18, 19, 20, 21, 22, 23, 24, 
                            25, 26, 27, 28, 29, 30, 31, 32, 
                            33, 34, 35, 36, 37, 38, 39, 40, 
                            41, 42, 43, 44, 45, 46, 47, 48, 
                            49, 50);

    /* Loop through each state variable */
    DO i = 1 TO DIM(state_char);
        /* Default to missing if no match */
        state_num{i} = .;

        /* Loop through state names to find a match */
        DO j = 1 TO DIM(state_names);
            IF state_char{i} = state_names{j} THEN DO;
                state_num{i} = state_labels{j}; /* Assign the corresponding numeric label */
                LEAVE; /* Exit loop once a match is found */
            END;
        END;
    END;

    /* Optional: Drop the original character variables if no longer needed */
    DROP state10_86 state10_88 state10_90 state10_92 state10_94 state10_96 
         state10_98 state10_00 state10_02 state10_04 state10_06 state10_08 
         state10_10 state10_12 state10_14 state10_16;
RUN;


/*
proc corr data=all spearman ;
  var shift88cont tpotat86d bbmpot86d fpotat86d
;
run;*/