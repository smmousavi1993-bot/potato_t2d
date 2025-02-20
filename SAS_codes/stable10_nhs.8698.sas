/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 10. Associations between potato intakes and risk of diabetes in the NHS from 1986-1998

/*MI*/
data mi_read;
    infile 'mi/mi7620.073120.cases' lrecl=117 recfm=d;

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
    if dtdxmi=. then dtdxmi=1031;

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
infile 'cabg/cabg7610.050913.nodups' lrecl=86 recfm=d;

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
    if .<dtdxcabg<1057 then cabg86=1;
    else cabg84=0;
    keep id cabg84 dtdxcabg;
run;
proc sort data=confcabg0; by id; run;

/*** read stroke data ***/
data confstr0;
infile 'stroke/str7620.031621.cases' lrecl=81 recfm=d;

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
    if .<dtdxstr<1057 then str86=1;
    else str84=0;
    keep id str84 dtdxstr;
run;
proc sort data=confstr0; by id; run;


data mi_all; set mi_all0; by id; if first.id; run;
data cabg;  set confcabg0;  by id; if first.id; run;
data deadff1;  set deadff;  by id; if first.id; run;
data stroke; set confstr0; by id; if first.id; run;


/******exposure and covariates******/
  
%ahei2010_8410(keep= ahei2010_86 ahei2010_noETOH86 ahei2010_vegI86 ahei2010_frtI86 ahei2010_ssbI86 ahei2010_whgrnI86 ahei2010_nutI86 ahei2010_rmtI86 ahei2010_etohI86 ahei2010_ptranI86 ahei2010_omegaI86 ahei2010_polyI86 ahei2010_naI86 
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


%include '/udd/nhsem/Potato.T2D/MousaviSeyed_potato_T2D_052024/act_nhs.sas'; 

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

    %der7616(keep=id curh80 hor12 bmi80 bmi82 bmi84 bmi86 bmi88 bmi90 bmi92 
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
  
    %meds8016(keep= aspu84 aspu86 aspu88 aspu90 aspu92 aspu94 aspu96 aspu98 aspu00 aspu02 aspu04 aspu06 aspu08 aspu10 aspu12 aspu14 aspu16
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


    %n84_nts(keep=aofib84n ceraf84n alco84n calor84n trans84n sat84n mon84n poly84n gid84n gl84n fol_84n chol84n prot84n carbo84n carbden84n protden84n);
    carbden84n = (carbo84n*4)/calor84n;
    protden84n = (prot84n*4)/calor84n;
    proc sort; by id; run; 

    %n86_nts(keep=aofib86n ceraf86n alco86n calor86n trnss86n sat86n mon86n poly86n gid86n gl86n fol_86n chol86n prot86n carbo86n carbden86n protden86n);
    carbden86n = (carbo86n*4)/calor86n;
    protden86n = (prot86n*4)/calor86n;
    proc sort; by id; run;

    %n90_nts(keep=aofib90n ceraf90n alco90n calor90n trnss90n sat90n mon90n poly90n gid90n gl90n fol_90n chol90n prot90n carbo90n carbden90n protden90n);
    carbden90n = (carbo90n*4)/calor90n;
    protden90n = (prot90n*4)/calor90n;
    proc sort; by id; run;

    %n94_nts(keep=aofib94n ceraf94n alco94n calor94n trnss94n sat94n mon94n poly94n gid94n gl94n fol_94n chol94n prot94n carbo94n carbden94n protden94n);
    carbden94n = (carbo94n*4)/calor94n;
    protden94n = (prot94n*4)/calor94n;
    proc sort; by id; run;

    %n98_nts(keep=aofib98n ceraf98n alco98n calor98n trn0098n sat98n mon98n poly98n gid98n gl98n fol9898n chol98n prot98n carbo98n carbden98n protden98n);
    carbden98n = (carbo98n*4)/calor98n;
    protden98n = (prot98n*4)/calor98n;
    proc sort; by id; run;

    %n02_nts(keep=aofib02n ceraf02n alco02n calor02n trn0202n sat02n mon02n poly02n gid02n gl02n fol9802n chol02n prot02n carbo02n carbden02n protden02n);
    carbden02n = (carbo02n*4)/calor02n;
    protden02n = (prot02n*4)/calor02n;
    proc sort; by id; run;

    %n06_nts(keep=aofib06n ceraf06n alco06n calor06n trn0706n sat06n mon06n poly06n gid06n gl06n fol9806n chol06n prot06n carbo06n carbden06n protden06n);
    carbden06n = (carbo06n*4)/calor06n;
    protden06n = (prot06n*4)/calor06n;
    proc sort; by id; run;

    %n10_nts(keep=aofib10n ceraf10n alco10n calor10n trn1110n sat10n mon10n poly10n gid10n gl10n fol9810n chol10n prot10n carbo10n carbden10n protden10n);
    carbden10n = (carbo10n*4)/calor10n;
    protden10n = (prot10n*4)/calor10n;
    proc sort; by id; run;
            
    %nur82(keep=id str82 ra82 mvit82  vite82 hbp82 wt82 chol82 hbp82 db82);

    %nur84(keep=id hbp84 wt84 chol84 hbp84 db84 cabg84 str84 ang84);

    %nur86(keep=id str86 ra86 cabg86 vite86 brcn86 curh86 wt86 hbp86 wt86 chol86 db86);

    %nur88(keep=id physx88 str88 ra88 cabg88 thiaz88 ccblo88 betab88 ace88 bprx88 clrx88 pct588 pct1088 
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

%supp8016(keep= vitau84 vitau86 vitau88 vitau90 vitau92 vitau94 vitau96 vitau98 vitau00 vitau02 vitau04 vitau06 vitau08 vitau10 vitau12 vitau14 vitau16
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
   keep id division: region: mdinc: mdvhs: pcolled: pfaminterest:
             pfwchbf: phs: pnohs: pkid: pold: pohse: popd: ppov: pwht: ;
run;
proc sort data=nses7616; by id; run;


/*********diabetes*********/
data diab_case;
infile 'diabetes/db7624.110123.cases' lrecl=183 recfm=d;

input
@1    id        6.
@7    cd    $   1.
@10      cohort          1.
@13      icda         5.1
@20      qyr          2.
@26      mdx1         2.
@28      ydx1         2.
@32      conf         2.
@36      nhsicda         5.1
@43      mdx          2.
@45      ydx          2.
@49      dxmonth         4.
@55      rc_record_id       6.
@63      recur        1.
@66      type         1.
@67      probabil     1.
@68      igt          1.
@69      gestdm          1.
@70      secdm        1.
@73      dbweight     3.
@76      screen          1.
@77      keto         1.
@78      coma         1.
@79      wtloss          1.
@80      hunger          1.
@81      thirst          1.
@82      urine        1.
@83      pruritis     1.
@84      symptot         1.
@85      uriglu          1.
@86      urigluv         1.
@87      uriketo         1.
@88      uriketov     1.
@89      fastglu         1.
@90      fastgluv     1.
@91      randglu         1.
@92      randgluv     1.
@93      postmg          1.
@94      postmgv         1.
@95      testog1         1.
@96      testog1v     1.
@97      testoth         1.
@98      testothv     1.
@99      miss22          1.
@100     monitor         1.
@101     hb57         1.
@102     hb65         1.
@103     lowfast         1.
@104     lownum          1.
@105     db_fast         1.
@106     fast2yr         1.
@107     nonfast         1.
@108     nonfas2y     1.
@109     numogt          1.
@110     ogtval1         1.
@111     ogtval2         1.
@112     ogtval3         1.
@113     ogtq6        1.
@114     urine2p         1.
@115     ur2pnum         1.
@116     ketones         1.
@117     keto1s2y     1.
@118     ketoacid     1.
@119     ketoin2y     1.
@120     ketohosp     1.
@121     preg1dx         1.
@122     dxperst         1.
@123     notlast         1.
@124     ltdx         4.
@128     still        1.
@129     insulin         1.
@130     start        1.
@131     many_yrs     2.
@133     yearins1     2.
@135     insulnow     1.
@136     stopins         1.
@137     oralmeds     1.
@138     oralinyr     2.
@140     yrstart         2.
@142     causemed     1.
@143     causedis     1.
@144     retino          1.
@145     retyr        2.
@147     protein         1.
@148     protyr          2.
@150     kidney          1.
@151     kidneyyr     2.
@153     pvd          1.
@154     pvdyr        2.
@156     footulc         1.
@157     footyr          2.
@159     perloss         1.
@160     perlosyr     2.
@162     neuroth         1.
@163     neurotyr     2.
@165     cirro        1.
@166     cirr1gen     1.
@167     cirrsex1     1.
@168     cirr2gen     1.
@169     cirr2sex     1.
@170     cirr3gen     1.
@171     cirr3sex     1.
@172     dosins          3.
@175     wilsons         1.
@176     wilsonmf     1.
@177     wilson2         1.
@178     wils2mf         1.
@179     hemochro     1.
@180     hemo1sex     1.
@181     hemo2        1.
@182     hemo2sex     1.
;

label
      id    = 'ID'
      cd    = 'Check Digit'
      cohort      = 'Cohort'
      icda     = 'Reported ICDA'
      qyr      = 'Questionnaire cycle year when reported'
      mdx1     = 'Reported month of diagnosis'
      ydx1     = 'Reported year of diagnosis'
      conf     = 'Confirmation Code'
      nhsicda     = 'NHS reviewed and confirmed ICDA code'
      mdx      = 'Confirmed Month of Diagnosis'
      ydx      = 'Confirmed Year of Diagnosis'
      dxmonth     = 'Date of dx months since 1900'
      rc_record_id   = 'REDCap Record ID'
      recur    = 'Possible recurrence'
      type     = 'Type of DM'
      probabil = 'Ranks certainty of diabetes type status'
      igt      = 'Impaired glucose tolerance'
      gestdm      = 'Gestational diabetes'
      secdm    = 'Secondary diabetes'
      dbweight = 'Approximate weight at time of diagnosis'
      screen      = 'Screening vs. symptoms'
      keto     = 'Ketoacidosis?'
      coma     = 'Coma?'
      wtloss      = 'Unintended Weight Loss?'
      hunger      = 'Unusual Hunger?'
      thirst      = 'Unusual Thirst?'
      urine    = 'Unusual Frequency Of Urination?'
      pruritis = 'Pruritis of Vulva or Vagina?'
      symptot     = 'Symptom Total'
      uriglu      = 'Urine glucose at 1st dx (1976-1984 qx)'
      urigluv     = 'Urine glucose value 1st dx (1976-1984 qx)'
      uriketo     = 'Urine ketones at 1st dx (1976-1984 qx)'
      uriketov = 'Urine ketone value at 1st dx (1976-1984 qx)'
      fastglu     = 'Fasting bld glucose 1st dx (1976-1984 qx)'
      fastgluv = 'Fasting bld glucose value 1st dx (1976-1984 qx)'
      randglu     = 'Random bld glucose measure (1976-1984 qx)'
      randgluv = 'Random bld glu value 1st dx (1976-1984 qx)'
      postmg      = 'Post meal bld glu measure 1st dx (1976-1984 qx)'
      postmgv     = 'Post meal bld glu value (1976-1984 qx)'
      testog1     = 'Oral glucose tolerance test (1976-1984 qx)'
      testog1v = 'OGTT value given (1976-1984 qx)'
      testoth     = 'OGTT other times (1976-1984 qx)'
      testothv = 'OGTT other times value given (1976-1984 qx)'
      miss22      = 'Truly blank?'
      monitor     = 'Self-monitor'
      lowfast     = 'Elevated fasting of 126 or higher'
      lownum      = 'Number of fasting blood glucose measurements between 126-139 mg or higher'
      db_fast     = 'Number of fasting blood glucose measurements of 140/mg or higher'
      fast2yr     = '(1976-1984 qx)'
      nonfast     = 'Number of non-fasting blood glucose measurements of 200 mg/dl or higher'
      nonfas2y = '(1976-1984 qx)'
      numogt      = '(1976-1984 qx)'
      ogtval1     = '(1976-1984 qx)'
      ogtval2     = '(1976-1984 qx)'
      ogtval3     = '(1976-1984 qx)'
      ogtq6    = 'Number of abnormal Oral Glucose Tolerance tests of 200 mg/dl or higher'
      urine2p     = 'Number of urine glucose measurements of 2+ or greater'
      ur2pnum     = '(1976-1984 qx)'
      ketones     = 'Number of times had ketones present (more than a trace) in urine'
      keto1s2y = '(1976-1984 qx)'
      ketoacid = 'Ever hospitalized for ketoacidosis'
      ketoin2y = 'Hospitalized for ketoacidosis within first two years of diagnosis'
      ketohosp = 'Year and hospital provided for most recent admission for ketoacidosis'
      preg1dx     = 'Pregnant at the time diabetes was first diagnosed'
      dxperst     = 'Did diabetes persist for more than one month after the pregnancy'
      notlast     = 'If diabetes did not persist for more than one month after the end'
      ltdx     = 'Date of later diagnosis'
      still    = 'If more than one month after the end of pregnancy, still have diabetes'
      insulin     = 'Ever treated with insulin injections'
      start    = 'when was insulin started'
      many_yrs = 'how long insulin taken'
      yearins1 = 'Year insulin started'
      insulnow = 'currently taking daily insulin'
      stopins     = 'Ever stopped insulin two weeks or more'
      oralmeds = 'Oral medication'
      oralinyr = 'Number of yrs oral medication'
      yrstart     = 'Year oral medication started'
      causemed = '(1976-1984 qx)'
      causedis = '(1976-1984 qx)'
      retino      = '(1976-1984 qx)'
      retyr    = '(1976-1984 qx)'
      protein     = '(1976-1984 qx)'
      protyr      = '(1976-1984 qx)'
      kidney      = '(1976-1984 qx)'
      kidneyyr = '(1976-1984 qx)'
      pvd      = '(1976-1984 qx)'
      pvdyr    = '(1976-1984 qx)'
      footulc     = '(1976-1984 qx)'
      footyr      = '(1976-1984 qx)'
      perloss     = '(1976-1984 qx)'
      perlosyr = '(1976-1984 qx)'
      neuroth     = '(1976-1984 qx)'
      neurotyr = '(1976-1984 qx)'
      cirro    = '(1986 qx)'
      cirr1gen = '(1986 qx)'
      cirrsex1 = '(1986 qx)'
      cirr2gen = '(1986 qx)'
      cirr2sex = '(1986 qx)'
      cirr3gen = '(1986 qx)'
      cirr3sex = '(1986 qx)'
      dosins      = '(1986 qx)'
      wilsons     = 'Blood relative diagnosed with Wilson''s Disease'
      wilsonmf = 'Sex of Wilson''s disease person'
      wilson2     = 'Blood relative diagnosed with Wilson''s Disease 2'
      wils2mf     = 'Sex of Wilson''s disease person'
      hemochro = 'Blood relative diagnosed with Hemochromatosis'
      hemo1sex = 'Sex of Hemochromatosis relative'
      hemo2    = 'Blood relative diagnosed with Hemochromatosis -2'
      hemo2sex = 'Sex of Hemochromatosis 2nd relative'
;
proc sort;by id;run;
proc freq data=diab_case;tables type;run;
data diab_case;
    set diab_case;
    if cohort = 1 and type =2;

    dtdxdiab=dxmonth*1;
    if dtdxdiab=. then dtdxdiab=1031;

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
          familyhis n767880 der7616 (in=dog) nur82 nur84 nur86 nur88 nur90 nur92 nur94 nur96 nur98 nur00 nur02 nur04 nur06 nur08 nur10 nur12 nur14 nur16 nur20
          aheinhs ahei2010_8410 deadff1 exernhs act8614 mi_all cabg stroke supp8016 diab_case foods nses7616 end=_end_;
 
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
proc freq data=all;tables catrace;run;


data one;
   set all end=_end_;

if hbp76=1 or hbp78=1 or hbp80=1 or hbp82=1 or hbp84=2 or hbp86=1 then hxhbp=1; else hxhbp = 0;
if chol76 = 1 or chol78= 1 or  chol80 = 1 or chol82 = 1 or  chol84 = 2 or chol86 = 1 then hxchol=1; else hxchol = 0;
if db76 = 1 or db78 = 1 or db80 = 1 or db82 = 1 or db84 = 2 or db86 = 1 then hxdb = 1; else hxdb = 0;
if hrt76 in (1,2) or hrt78 in (1,2) or hrt80 in (1,2) or hrt82 in (1,2) or hrt84 in (1,2) or hrt86 in (1,2) or cabg86=1 or str86=1 then hxcvd = 1; else hxcvd = 0;
if can76 = 1 or can78 = 1 or can80 = 1 or can82=1 or can84=2 or can86=1 then hxcan = 1; else hxcan = 0;

array nocum86 {*}  aofib86n ceraf86n alco86n calor86n trnss86n sat86n mon86n poly86n gid86n fol_86n prot86n carbo86n carbden86n protden86n tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d /*soypro86d*/ nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d whgrn86n rfgrn86n whgrns86d rfgrns86d gl86n afat86d vfat86d ahei86 aheinoal86 aheinopt86 aheifisha86 aheidairy86 aheinutbl86 aheipoult86 aheineggs86;  
array nocum90 {*}  aofib90n ceraf90n alco90n calor90n trnss90n sat90n mon90n poly90n gid90n fol_90n prot90n carbo90n carbden90n protden90n tpotat90d bbmpot90d fpotat90d chipss90d prmeat90d urmeat90d trmeat90d poultr90d fishal90d regegg90d hdairy90d ldairy90d /*soypro90d*/ nutsal90d legume90d fruits90d vegeal90d nstveg90d staveg90d tdairy90d coffee90d nutleg90d bwrice90d wtrice90d SSB90d whgrn90n rfgrn90n whgrns90d rfgrns90d gl90n afat90d vfat90d ahei90 aheinoal90 aheinopt90 aheifisha90 aheidairy90 aheinutbl90 aheipoult90 aheineggs90;
array nocum94 {*}  aofib94n ceraf94n alco94n calor94n trnss94n sat94n mon94n poly94n gid94n fol_94n prot94n carbo94n carbden94n protden94n tpotat94d bbmpot94d fpotat94d chipss94d prmeat94d urmeat94d trmeat94d poultr94d fishal94d regegg94d hdairy94d ldairy94d /*soypro94d*/ nutsal94d legume94d fruits94d vegeal94d nstveg94d staveg94d tdairy94d coffee94d nutleg94d bwrice94d wtrice94d SSB94d whgrn94n rfgrn94n whgrns94d rfgrns94d gl94n afat94d vfat94d ahei94 aheinoal94 aheinopt94 aheifisha94 aheidairy94 aheinutbl94 aheipoult94 aheineggs94;
array nocum98 {*}  aofib98n ceraf98n alco98n calor98n trn0098n sat98n mon98n poly98n gid98n fol9898n prot98n carbo98n carbden98n protden98n tpotat98d bbmpot98d fpotat98d chipss98d prmeat98d urmeat98d trmeat98d poultr98d fishal98d regegg98d hdairy98d ldairy98d /*soypro98d*/ nutsal98d legume98d fruits98d vegeal98d nstveg98d staveg98d tdairy98d coffee98d nutleg98d bwrice98d wtrice98d SSB98d whgrn98n rfgrn98n whgrns98d rfgrns98d gl98n afat98d vfat98d ahei98 aheinoal98 aheinopt98 aheifisha98 aheidairy98 aheinutbl98 aheipoult98 aheineggs98;

array cumul86 {*}  aofib86ca ceraf86ca alco86ca calor86ca trnss86ca sat86ca mon86ca poly86ca gid86ca fol_86ca prot86ca carbo86ca carbden86ca protden86ca tpotat86ca bbmpot86ca fpotat86ca chipss86ca prmeat86ca urmeat86ca trmeat86ca poultr86ca fishal86ca regegg86ca hdairy86ca ldairy86ca /*soypro86ca*/ nutsal86ca legume86ca fruits86ca vegeal86ca nstveg86ca staveg86ca tdairy86ca coffee86ca nutleg86ca bwrice86ca wtrice86ca SSB86ca whgrn86ca rfgrn86ca whgrns86ca rfgrns86ca gl86ca afat86ca vfat86ca ahei86ca aheinoal86ca aheinopt86ca aheifisha86ca aheidairy86ca aheinutbl86ca aheipoult86ca aheineggs86ca;  
array cumul90 {*}  aofib90ca ceraf90ca alco90ca calor90ca trnss90ca sat90ca mon90ca poly90ca gid90ca fol_90ca prot90ca carbo90ca carbden90ca protden90ca tpotat90ca bbmpot90ca fpotat90ca chipss90ca prmeat90ca urmeat90ca trmeat90ca poultr90ca fishal90ca regegg90ca hdairy90ca ldairy90ca /*soypro90ca*/ nutsal90ca legume90ca fruits90ca vegeal90ca nstveg90ca staveg90ca tdairy90ca coffee90ca nutleg90ca bwrice90ca wtrice90ca SSB90ca whgrn90ca rfgrn90ca whgrns90ca rfgrns90ca gl90ca afat90ca vfat90ca ahei90ca aheinoal90ca aheinopt90ca aheifisha90ca aheidairy90ca aheinutbl90ca aheipoult90ca aheineggs90ca;
array cumul94 {*}  aofib94ca ceraf94ca alco94ca calor94ca trnss94ca sat94ca mon94ca poly94ca gid94ca fol_94ca prot94ca carbo94ca carbden94ca protden94ca tpotat94ca bbmpot94ca fpotat94ca chipss94ca prmeat94ca urmeat94ca trmeat94ca poultr94ca fishal94ca regegg94ca hdairy94ca ldairy94ca /*soypro94ca*/ nutsal94ca legume94ca fruits94ca vegeal94ca nstveg94ca staveg94ca tdairy94ca coffee94ca nutleg94ca bwrice94ca wtrice94ca SSB94ca whgrn94ca rfgrn94ca whgrns94ca rfgrns94ca gl94ca afat94ca vfat94ca ahei94ca aheinoal94ca aheinopt94ca aheifisha94ca aheidairy94ca aheinutbl94ca aheipoult94ca aheineggs94ca;
array cumul98 {*}  aofib98ca ceraf98ca alco98ca calor98ca trn0098ca sat98ca mon98ca poly98ca gid98ca fol9898ca prot98ca carbo98ca carbden98ca protden98ca tpotat98ca bbmpot98ca fpotat98ca chipss98ca prmeat98ca urmeat98ca trmeat98ca poultr98ca fishal98ca regegg98ca hdairy98ca ldairy98ca /*soypro98ca*/ nutsal98ca legume98ca fruits98ca vegeal98ca nstveg98ca staveg98ca tdairy98ca coffee98ca nutleg98ca bwrice98ca wtrice98ca SSB98ca whgrn98ca rfgrn98ca whgrns98ca rfgrns98ca gl98ca afat98ca vfat98ca ahei98ca aheinoal98ca aheinopt98ca aheifisha98ca aheidairy98ca aheinutbl98ca aheipoult98ca aheineggs98ca;


do i = 1 to DIM(cumul98);
        cumul86{i} = nocum86{i};
        cumul90{i} = mean(nocum86{i}, nocum90{i});
        cumul94{i} = mean(nocum86{i}, nocum90{i}, nocum94{i});
        cumul98{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
end;

run;

data two;
   set one end=_end_;
 
  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1); 
   if white=1 then white2=1;
   else white2=0;

array irt   {7}   irt86 irt88 irt90 irt92 irt94 irt96 cutoff;
array perioda  {6}  period1  period2  period3  period4  period5  period6 ;
array tvar  {6}    t86   t88   t90   t92   t94   t96;
array age   {6}   age86 age88 age90 age92 age94 age96;
array aspyn {6}   aspyn86 aspyn88   aspyn90  aspyn92  aspyn94  aspyn96 ;
array hbp   {6}   hbp86   hbp88   hbp90   hbp92   hbp94   hbp96; 
array nsmk  {6}   smkdr86  smkdr88  smkdr90  smkdr92  smkdr94  smkdr96 ;
array bmi   {6}   bmi86 bmi88 bmi90 bmi92 bmi94 bmi96;
array actm  {6}   act86m act88m act88m act92m act94m act96m ;
array pam   {6}   act86m act88m act88m act92m act94m act96m ;
array horm  {6}   nhor86 nhor88 nhor90 nhor92 nhor94 nhor96 ;
array mvit  {6}   mvitu86 mvitu88 mvitu90 mvitu92 mvitu94 mvitu96 ;
array supp  {6}   suppu86 suppu88 suppu90 suppu92 suppu94 suppu96 ;
array antihp   {6}    htnrx88  htnrx88  htnrx88  htnrx88  htnrx94  htnrx96; 
array antitc   {6}    hchtx88  hchtx88  hchtx88  hchtx88  hchtx94  hchSmmtx96;

array calorca  {6}   calor86ca calor86ca calor90ca calor90ca calor94ca calor94ca ;
array aofibca  {6}   aofib86ca aofib86ca aofib90ca aofib90ca aofib94ca aofib94ca ;
array cerafca  {6}   ceraf86ca ceraf86ca ceraf90ca ceraf90ca ceraf94ca ceraf94ca ;
array alcoca  {6}   alco86ca alco86ca alco90ca alco90ca alco94ca alco94ca ;
array satfca  {6}   sat86ca sat86ca sat90ca sat90ca sat94ca sat94ca ;
array monfca  {6}   mon86ca mon86ca mon90ca mon90ca mon94ca mon94ca ;
array polyfca  {6}   poly86ca poly86ca poly90ca poly90ca poly94ca poly94ca ;
array transfca  {6}   trnss86ca trnss86ca trnss90ca trnss90ca trnss94ca trnss94ca ;
array folca  {6}   fol_86ca fol_86ca fol_90ca fol_90ca fol_94ca fol_94ca ;
array protca  {6}   prot86ca prot86ca prot90ca prot90ca prot94ca prot94ca ;
array protdenca  {6}   protden86ca protden86ca protden90ca protden90ca protden94ca protden94ca ;
array gidca  {6}    gid86ca gid86ca gid90ca gid90ca gid94ca gid94ca ;
array carboca  {6}    carbo86ca carbo86ca carbo90ca carbo90ca carbo94ca carbo94ca ;
array carbdenca  {6}   carbden86ca carbden86ca carbden90ca carbden90ca carbden94ca carbden94ca;

array calor  {6}    calor86n calor86n calor90n calor90n calor94n calor94n ;
array carbo  {6}    carbo86n carbo86n carbo90n carbo90n carbo94n carbo94n ;
array carbden  {6}   carbden86n carbden86n carbden90n carbden90n carbden94n carbden94n;
array prot  {6}    prot86n prot86n prot90n prot90n prot94n prot94n ;
array protden  {6}  protden86n protden86n protden90n protden90n protden94n protden94n ;
array alco  {6}    alco86n alco86n alco90n alco90n alco94n alco94n ;
array ceraf  {6}   ceraf86n ceraf86n ceraf90n ceraf90n ceraf94n ceraf94n ;
array aofib  {6}   aofib86n aofib86n aofib90n aofib90n aofib94n aofib94n ;

array tpotat  {6}   tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d tpotat94d ;
array bbmpot  {6}   bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d bbmpot94d ;
array fpotat  {6}   fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d fpotat94d ; 
array chipss  {6}   chipss86d chipss86d chipss90d chipss90d chipss94d chipss94d ;
array prmeat  {6}   prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d prmeat94d ;
array urmeat  {6}   urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d urmeat94d ;
array trmeat  {6}   trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d trmeat94d ;
array poultr  {6}   poultr86d poultr86d poultr90d poultr90d poultr94d poultr94d ;
array fishal  {6}   fishal86d fishal86d fishal90d fishal90d fishal94d fishal94d ;
array regegg  {6}   regegg86d regegg86d regegg90d regegg90d regegg94d regegg94d ;
array hdairy  {6}   hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d hdairy94d ;
array ldairy  {6}   ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ldairy94d ;
array nutsal  {6}   nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d nutsal94d ;
array legume  {6}   legume86d legume86d legume90d legume90d legume94d legume94d ;
array fruits  {6}   fruits86d fruits86d fruits90d fruits90d fruits94d fruits94d ;
array vegeal  {6}   vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d vegeal94d ;
array nstveg  {6}   nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d nstveg94d ;
array staveg  {6}   staveg86d staveg86d staveg90d staveg90d staveg94d staveg94d ;
array tdairy  {6}   tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d tdairy94d ;
array coffee  {6}   coffee86d coffee86d coffee90d coffee90d coffee94d coffee94d ;
array nutleg  {6}   nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d nutleg94d ;
array bwrice  {6}   bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d bwrice94d ;
array wtrice  {6}   wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d wtrice94d ;
array SSB     {6}   SSB86d SSB86d SSB90d SSB90d SSB94d SSB94d ;
array whgrns  {6}   whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d whgrns94d ;
array rfgrns  {6}   rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d rfgrns94d ;
array whgrn  {6}   whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n whgrn94n ;
array rfgrn  {6}   rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n rfgrn94n ;
array gl     {6}     gl86n gl86n gl90n gl90n gl94n gl94n ;
array gid    {6}   gid86n gid86n gid90n gid90n gid94n gid94n;
array afat   {6}   afat86d afat86d afat90d afat90d afat94d afat94d ;
array vfat   {6}   vfat86d vfat86d vfat90d vfat90d vfat94d vfat94d ;

array tpotatca  {6}   tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca tpotat94ca ;
array bbmpotca  {6}   bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca bbmpot94ca ;
array fpotatca  {6}   fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca fpotat94ca ;
array chipssca  {6}   chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca chipss94ca ;
array prmeatca  {6}   prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca prmeat94ca ;
array urmeatca  {6}   urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca urmeat94ca ;
array trmeatca  {6}   trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca trmeat94ca ;
array poultrca  {6}   poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca poultr94ca ;
array fishalca  {6}   fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca fishal94ca ;
array regeggca  {6}   regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca regegg94ca ;
array hdairyca  {6}   hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca hdairy94ca ;
array ldairyca  {6}   ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca ldairy94ca ;
array nutsalca  {6}   nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca nutsal94ca ;
array legumeca  {6}   legume86ca legume86ca legume90ca legume90ca legume94ca legume94ca ;
array fruitsca  {6}   fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca fruits94ca ;
array vegealca  {6}   vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca vegeal94ca ;
array nstvegca  {6}   nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca nstveg94ca ;
array stavegca  {6}   staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca staveg94ca ;
array tdairyca  {6}   tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca tdairy94ca ; 
array coffeeca  {6}   coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca coffee94ca ;
array nutlegca  {6}   nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca nutleg94ca ;
array bwriceca  {6}   bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca bwrice94ca ;
array wtriceca  {6}   wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca wtrice94ca ;
array SSBca     {6}   SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca SSB94ca ;
array whgrnsca  {6}   whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca whgrns94ca ;
array rfgrnsca  {6}   rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca rfgrns94ca ;
array whgrnca  {6}    whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca whgrn94ca ;
array rfgrnca  {6}    rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca rfgrn94ca ;
array glca  {6}   gl86ca gl86ca gl90ca gl90ca gl94ca gl94ca ;
array afatca   {6}   afat86ca afat86ca afat90ca afat90ca afat94ca afat94ca ;
array vfatca   {6}   vfat86ca vfat86ca vfat90ca vfat90ca vfat94ca vfat94ca ;

array ahei  {6}   ahei86 ahei86 ahei90 ahei90 ahei94 ahei94 ;
array aheinoal  {6}   aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 aheinoal94 ;
array aheinopt  {6}   aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 aheinopt94 ;
array aheifisha  {6}   aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 aheifisha94 ;
array aheidairy  {6}   aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 aheidairy94 ;
array aheinutbl  {6}   aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 aheinutbl94 ;
array aheipoult  {6}   aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 aheipoult94 ;
array aheineggs  {6}   aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 aheineggs94 ;

array aheica  {6}  ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca ahei94ca ;
array aheinoalca  {6}    aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca aheinoal94ca ;
array aheinoptca  {6}    aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca aheinopt94ca ;
array aheifishaca  {6}   aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca aheifisha94ca ;
array aheidairyca  {6}   aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca aheidairy94ca ;
array aheinutblca  {6}   aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca aheinutbl94ca ;
array aheipoultca  {6}   aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca aheipoult94ca ;
array aheineggsca  {6}   aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca aheineggs94ca ;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {6} alone92 alone92 alone92 alone92 alone92 alone96;
array married {6} marry92 marry92 marry92 marry92 marry92 marry96;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year         /
* Alternative would be to use a single Census year for all address years  /
*****************************************************************************/

   array inc {6}  mdinc90_86 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94 mdinc00_96; 
   array vhs {6}  mdvhs90_86 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94 mdvhs00_96; 
   array pcoll {6}  pcolled90_86 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94 pcolled00_96;
   array phs {6}  phs90_86 phs90_88 phs90_90 phs90_92 phs90_94 phs00_96;
   array pnohs {6}  pnohs90_86 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94 pnohs00_96;
   array pfint {6}  pfaminterest90_86 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94
          pfaminterest00_96;
   array sfemale {6}  pfwchbf90_86 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94 pfwchbf00_96;
   array pkid {6}  pkid90_86 pkid90_88 pkid90_90 pkid90_92 pkid90_94 pkid00_96;
   array pold {6}  pold90_86 pold90_88 pold90_90 pold90_92 pold90_94 pold00_96;
   array pohse {6}  pohse90_86 pohse90_88 pohse90_90 pohse90_92 pohse90_94 pohse00_96;
   array ppov {6}  ppov90_86 ppov90_88 ppov90_90 ppov90_92 ppov90_94 ppov00_96;
   array pw {6}    pwht90_86 pwht90_88 pwht90_90 pwht90_92 pwht90_94 pwht00_96;

   array popd {6}   popd90_86 popd90_88 popd90_90 popd90_92 popd90_94 popd00_96; 
   array div {6}  division10_86 division10_88 division10_90 division10_92 division10_94 division10_96;
   array reg {6} region10_86 region10_88 region10_90 region10_92 region10_94 region10_96;

   do i=1 to 6;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 6;
       /*if actc{b}=. then actc{b}=actc{b-1};*/
      if actm{b}=. then actm{b}=actm{b-1};
      if pam{b}=. then pam{b}=pam{b-1};      
       if bmi{b}=. then bmi{b}=bmi{b-1};
       if alco{b}=. then alco{b}=alco{b-1};
       if alcoca{b}=. then alcoca{b}=alcoca{b-1};
       if nsmk{b}=. then nsmk{b}=nsmk{b-1};
       if aspyn{b}=. then aspyn{b}=aspyn{b-1};
       if horm{b}=. then horm{b}=horm{b-1};
       if mvit{b}=. then mvit{b}=mvit{b-1};
       if calor{b}=. then calor{b}=calor{b-1};
       if calorca{b}=. then calorca{b}=calorca{b-1};
       if cerafca{b}=. then cerafca{b}=cerafca{b-1};
       if satfca{b}=. then satfca{b}=satfca{b-1};
       if monfca{b}=. then monfca{b}=monfca{b-1};
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
       if supp{b}=. then supp{b}=supp{b-1};
       if carbo{b}=. then carbo{b}=carbo{b-1};
       if carbden{b}=. then carbden{b}=carbden{b-1};
       if carboca{b}=. then carboca{b}=carboca{b-1};
       if carbdenca{b}=. then carbdenca{b}=carbdenca{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
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
       /*if soypro{b}=. then soypro{b}=soypro{b-1};*/
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
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};

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
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};
       if aheinoptca{b}=. then aheinoptca{b}=aheinoptca{b-1};
       if afatca{b}=. then afatca{b}=afatca{b-1};
       if vfatca{b}=. then vfatca{b}=vfatca{b-1};

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

    end;


do i=1 to DIM(irt)-1;
  if irt{i} >0 then lastq=irt{i};
  end;
  drop i;
  if lastq=irt{dim(irt)-1} then lastq=.;


/*** Set cutoff at 1998.5 ***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1182;   
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1014+24*i) | irt{i}>=(1038+24*i)) then irt{i}=1014+24*i;
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

diabcase=0; 
tdiabcase=irt{i+1}-irt{i};
if diabcase eq 1 then tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
if irt{i} lt dtdxdiab le irt{i+1} then do;
diabcase=1;tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
end;

ageyr = round((irt{i}-bdt)/12);

/****** Define symptomatic T2D case sin the ith time period ******/

   dbsymp=0; 
        tdbsymp=irt{i+1}-irt{i};
        if dbsymp eq 1 then tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
        if irt{i} lt dtdxdiab le irt{i+1} and symp=1 then do;
        dbsymp=1;
        tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
        end;

        /****** DEFINE AGE ******/   
         age{i}=int((irt{i}-bdt)/12);      
            if age{i} =< 0 then age{i}=.;

            agecon=age{i};
            agegp=int((age{i}-30)/5);     **** Define the agegp in the i-th period;
            if agegp<=0 then agegp=1;
            if agegp>8 then agegp=8;
           %indic3(vbl=agegp, prefix=agegp, reflev=1, min=1, max=8, usemiss=0,
                     label1='age<40',
                     label2='age40-44',
                     label3='age45-49',
                     label4='age50-54',
                     label5='age55-59',
                     label6='age60-64',
                     label7='age65-69',
                     label8='age >= 70');

/******main exposure******/ 
if chol84 ne 2 then chol84=0;
if hbp84 ne 2 then hbp84=0;
if db84 ne 2 then db84=0;
if cabg84 ne 2 then cabg84=0;
if str84 ne 2  then str84=0;
calorcav =  calorca  {i};
calorv =  calor  {i};
gidcav = gidca  {i};
alcov = alco  {i};
alcocav = alcoca  {i};
satfcav = satfca  {i};
monfcav = monfca  {i};
polyfcav = polyfca  {i};
transfcav = transfca  {i};
folcav = folca  {i};
protv = prot  {i};
protdenv = protden  {i};
protcav = protca  {i};
protdencav = protdenca  {i};
cerafcav = cerafca  {i};
cerafv = ceraf  {i};
aofibcav = aofibca  {i};
aofibv = aofib  {i};
carbov = carbo  {i};
carbdenv = carbden  {i};
carbocav = carboca  {i};
carbdencav = carbdenca  {i};

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
SSBv = SSB        {i};
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
SSBcav = SSBca        {i};
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

lgcerafcav = log(cerafcav+0.0001);
lgcalorcav = log(calorcav);
lgaofibcav = log(aofibcav+0.0001);

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

   if agecon<65 then age65=0;
   else if agecon>=65 then age65=1;

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
        else smkever=9; *missing;
        %indic3(vbl=smkever, prefix=smkc, min=2, max=5, reflev=1, missing=9, usemiss=1,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');
        if smkever in (3,4,5) then catsmkf=1;
        else catsmkf=0;

    
       /*** Indicator for BMI ***/ 
         bmicon=bmi{i};
        if bmicon = . then bmicon = 24.96000;
         bmia=bmi{i};
         if bmia = . then bmia = 24.96000;        
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

         if bmicon < 25 then bmidi = 0;
         else bmidi = 1;

         if bmicon < 25 then bmitr = 0;
         else if bmicon >= 25 and bmicon < 30 then bmitr = 1;
         else bmitr = 2;

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
       if actcon = . then actcon = 10.60000;
       actmcon=pam{i};
       if .<actcon<=3      then actcc=1;
       else if 3<actcon<=9       then actcc=2;
       else if 9<actcon<=18      then actcc=3;
       else if 18<actcon<=27     then actcc=4;
       else if 27<actcon<900      then actcc=5;
      else actcc=.;
       %indic3(vbl=actcc, prefix=catact, min=2, max=5, reflev=1, missing=., usemiss=0);

       if actcon<10.6000 then actbi = 0;
      else if actcon>=10.6000 then actbi = 1;
      else actbi = 0;

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
                     label6= 'GREATER THAN 30 gm ALC/DAY');

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
   
      if aheinoptcav= . then aheinoptcav=39.2191;
      if aheinoptcav<39.2191 then aheinoptd = 0;
      else if aheinoptcav>=39.2191 then aheinoptd = 1;
  
     /*** aspirin ***/
            select(aspyn{i});
                when (1)     aspirin=1; 
                  otherwise    aspirin=0;
            end;

     /*** Supplement ***/
            select(supp{i});
                when (1)     suppu=1; 
                  otherwise    suppu=0;
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

      /****** Indicator for TC lowering */
            select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
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
      IF dbfh82 NE 1 THEN dbfh82=0;

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxdiab in (0,.)then dtdxdiab=.;
       if dtdxdiab eq 9999 then dtdxdiab=.;


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

/**********************************************
          Individual SES
***********************************************/   
live_alone=alone{i};
if alone{i} ne 1 then live_alone=0; 
else live_alone=1;

cmarry=married{i};
if cmarry ne 1 then cmarry=0;
else cmarry=1; 

      
     /****************  BASELINE EXCLUSIONS ********************************************/
      if i=1 then do;

   %exclude(exrec eq 1);                 *multiple records and not in master file;
   %exclude(yobf lt 0);
   %exclude(lastq eq irt{1});          /*only returned baseline qq */  

        %exclude(hxcvd   eq 1);       /* baseline history of CVD*/  
        %exclude(hxcan   eq 1);       /*baseline history of cancer*/
        %exclude(hxdb   eq 1);        /*baseline history of diabetes*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le irt86);            /* Death before baseline*/
   %exclude(0 lt dtdxdiab le irt86);         /* Diagnoses diabetes before 1984 */
   %exclude(calor86n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor86n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor86n eq .);                 /* missing energy intake */
   %exclude(tpotat86d eq .);               /* missing potato intake */
   /*%exclude(ngdqscav eq .);
   %exclude(nhgdqscav eq .);
   %exclude(nugdqscav eq .);*/
   %exclude(age86    eq .);           /* missing age at 1984 */ 
   %output(); 
  end;
/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/

  else if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                   /*censor lost to follow up */    
   %exclude(irt{i-1} le dtdth lt irt{i});
   %exclude(irt{i-1} le dtdxdiab lt irt{i});
   %output();
  end;

   end;        /* END OF DO-LOOP OVER TIME PERIODs */
   %endex();   /* must do AFTER all exclusions */ 

/*** Variables kept for analysis ***/

keep id period agecon agegp agedi smkdi smkk chol86 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew bwricew wtricew afatw vfatw
     tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
      irt86 irt88 irt90 irt92 irt94 irt96 cutoff
      t86 t88 t90 t92 t94 t96 dtdth dtdxdiab
     tdead diabcase tdiabcase dbsymp tdbsymp
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib84n ceraf84n gid84n alco84n sat84n mon84n poly84n trans84n fol_84n prot84n
     white white2 &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
     actcon bmic alccon hxcvd hxcan antihbp antihtc
     htn /*diabetes hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db84 chol84 hbp84 str84  /*cvd86*/ cabg84
     age84 bmi84 alco84n calor84n /*actc84m*/ mifh cerafcav aofibcav smkever actcc th86 aspyn86 hormone aofibv
     
     /*Stratification variables*/
     age65 bmitr hxhbp dbfh82 smktr catrace2 actbi aheinoptd 

     lgaofibcav lgcerafcav lgcalorcav act86m hxchol hxdb ageyr cerafv bmia bmicon suppu carbov carbdenv carbocav carbdencav /*&catrace_*/ mlvit alcconsu &alccsu_ 
     tpotatv bbmpotv fpotatv chipssv prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv nutlegv bwricev wtricev SSBv coffeev 
     tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav nutlegcav coffeecav bwricecav wtricecav SSBcav 
     whgrnsv rfgrnsv whgrnv rfgrnv glv gidv whgrnscav rfgrnscav whgrncav rfgrncav glcav whgrns84d rfgrns84d coffee84d race9204 catsmkf
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav
     mrace9204 eth9204 catrace bmidi 
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

   if nSES = . then nSES = 0.0422921;
run;

proc freq data=two;tables catrace catrace2 mrace9204 age65 eth9204 actbi bmidi bmitr smktr &bmic9_ aheinoptd ;run;

proc freq data=two;tables hxdb hxhbp diabcase dbsymp suppu smkc2 smkc3 smkc4 smkc5 white2 hormone2 hormone3 hormone4 catact2 catact3 catact4 catact5 dbfh82 antihbp antihtc alcc2 alcc3 alcc4 alcc5 alcc6 catsmkf;run;
proc univariate data=two; var agecon actcon bmicon calorcav calorv alcov alcocav prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev
                              tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav whgrncav rfgrncav glcav gidcav
                              bwricecav wtricecav SSBcav coffeecav
                              aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav
                              income homeval pcollege phigh pnohigh pfamint singlefemale pkids polds pocchse perpov pwhite popden nSES;run;


%pctl9(
data=two,
varlist=aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav aheiv aheicav aheinoalv aheinoalcav,
numquant=5,
mscore=T,
quantname=q,
outdat=three,
indic=T,
cutdat=cuts,
usemiss=1,
pcut=T,
prnt=F);

%pctl9(
data=three,
varlist=calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv protdencav protdenv aofibv aofibcav cerafv cerafcav prmeatv urmeatv trmeatv poultrv 
      fishalv regeggv hdairyv ldairyv /*soyprov*/ prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav fruitsv
      vegealcav vegealv nstvegcav stavegcav gidcav rfgrnscav SSBcav rfgrnsv whgrnsv whgrnscav  tdairyv nutlegv tdairycav nutlegcav gidv transfcav aheinoptcav nSES,
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
   if ctpotatcav=1 then medctpotatcav=0.1260000;
   if ctpotatcav=2 then medctpotatcav=0.2857143;
   if ctpotatcav=3 then medctpotatcav=0.5350000;
   if ctpotatcav=4 then medctpotatcav=0.8971429;


      if fpotatcav=0.000 then cfpotatcav=0;                     /**Almost never**/
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          /**1-3 serving per month**/
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         /**1 serving per week**/
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         /**2-4 serving per week**/
      else if 0.430<fpotatcav then cfpotatcav=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);
 

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0420000;
   if cfpotatcav=2 then medcfpotatcav=0.1050000;
   if cfpotatcav=3 then medcfpotatcav=0.2250000;
   if cfpotatcav=4 then medcfpotatcav=0.5733333;

      if chipsscav =0.000 then cchipsscav=0;                     /**Almost never**/
      else if 0.000<chipsscav <=0.070 then cchipsscav=1;          /**1-3 serving per month**/
      else if 0.070<chipsscav <=0.143 then cchipsscav=2;         /**1 serving per week**/
      else if 0.143<chipsscav <=0.430 then cchipsscav=3;         /**2-4 serving per week**/
      else if 0.430<chipsscav then cchipsscav=4;                 /** =>5 serving per week**/
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0437500;
   if cchipsscav=2 then medcchipsscav=0.1062500;
   if cchipsscav=3 then medcchipsscav=0.2500000;
   if cchipsscav=4 then medcchipsscav=0.6000000;


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                         
  %indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);


   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1225000;
   if cbbmpotcav=2 then medcbbmpotcav=0.3100000;
   if cbbmpotcav=3 then medcbbmpotcav=0.5928571;


     if 0.000<=tpotatv<=0.070 then ctpotatv=0;        
      else if 0.070<tpotatv<=0.143 then ctpotatv=1;       
      else if 0.143<tpotatv<=0.430 then ctpotatv=2;         
      else if 0.430<tpotatv<=0.790 then ctpotatv=3;       
      else if 0.790<tpotatv then ctpotatv=4;                   
  %indic3(vbl=ctpotatv, prefix=ctpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if ctpotatv=0 then medctpotatv=0.0700000;
   if ctpotatv=1 then medctpotatv=0.1260000;
   if ctpotatv=2 then medctpotatv=0.2857143;
   if ctpotatv=3 then medctpotatv=0.5350000;
   if ctpotatv=4 then medctpotatv=0.8971429;

      if fpotatv=0.000 then cfpotatv=0;                       
      else if 0.000<fpotatv<=0.070 then cfpotatv=1;          
      else if 0.070<fpotatv<=0.143 then cfpotatv=2;         
      else if 0.143<fpotatv<=0.430 then cfpotatv=3;         
      else if 0.430<fpotatv then cfpotatv=4;                 
%indic3(vbl=cfpotatv, prefix=cfpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cfpotatv=0 then medcfpotatv=0.0;
   if cfpotatv=1 then medcfpotatv=0.0420000;
   if cfpotatv=2 then medcfpotatv=0.1050000;
   if cfpotatv=3 then medcfpotatv=0.2250000;
   if cfpotatv=4 then medcfpotatv=0.5733333;

      if chipssv =0.000 then cchipssv=0;                     
      else if 0.000<chipssv <=0.070 then cchipssv=1;          
      else if 0.070<chipssv <=0.143 then cchipssv=2;         
      else if 0.143<chipssv <=0.430 then cchipssv=3;         
      else if 0.430<chipssv then cchipssv=4;                 
%indic3(vbl=cchipssv, prefix=cchipssv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipssv=0 then medcchipssv=0.0;
   if cchipssv=1 then medcchipssv=0.0437500;
   if cchipssv=2 then medcchipssv=0.1062500;
   if cchipssv=3 then medcchipssv=0.2500000;
   if cchipssv=4 then medcchipssv=0.6000000;


      if 0.000<=bbmpotv<=0.070 then cbbmpotv=0;        
      else if 0.070<bbmpotv<=0.143 then cbbmpotv=1;       
      else if 0.143<bbmpotv<=0.430 then cbbmpotv=2;         
      else if 0.430<bbmpotv then cbbmpotv=3;                         
  %indic3(vbl=cbbmpotv, prefix=cbbmpotv, reflev=0, min=1, max=3, missing=., usemiss=0);

   if cbbmpotv=0 then medcbbmpotv=0.0700000;
   if cbbmpotv=1 then medcbbmpotv=0.1225000;
   if cbbmpotv=2 then medcbbmpotv=0.3100000;
   if cbbmpotv=3 then medcbbmpotv=0.5928571;

      if SSBv=0.000 then qSSBv=0;
      else if 0.000<SSBv<=0.070 then qSSBv=1;          
      else if 0.070<SSBv<=0.143 then qSSBv=2;        
      else if 0.143<SSBv<=0.430 then qSSBv=3;         
      else if 0.430<SSBv then qSSBv=4;                 
%indic3(vbl=qSSBv, prefix=qSSBv, reflev=0, min=1, max=4, missing=., usemiss=0);
run;


proc means median data=five;var tpotatcav;class ctpotatcav; run;
proc means median data=five;var fpotatcav;class cfpotatcav; run;
proc means median data=five;var chipsscav;class cchipsscav; run;
proc means median data=five;var bbmpotcav;class cbbmpotcav; run;
proc freq data=five;tables ctpotatcav cfpotatcav cchipsscav cbbmpotcav;run;



/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=irt86 irt88 irt90 irt92 irt94 irt96,
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
         timevar= t86   t88   t90   t92   t94   t96,
         id=id, tvar=period, 
         agevar=agecon, qret= irt86 irt88 irt90 irt92 irt94 irt96, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &ctpotatcav_ &qcalorcav_ , 
         model2  = medctpotatcav &qcalorcav_,
         model3  = &ctpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model4  = medctpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model5  = &ctpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model6  = medctpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = &cchipsscav_ &qcalorcav_ , 
         model8  = medcchipsscav &qcalorcav_,
         model9  = &cchipsscav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model10  = medcchipsscav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model11  = &cchipsscav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model12  = medcchipsscav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model13  = &cfpotatcav_ &qcalorcav_ , 
         model14  = medcfpotatcav &qcalorcav_,
         model15  = &cfpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model16  = medcfpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model17  = &cfpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         model18  = medcfpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
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

ods rtf file="stable10_nhs.8698.rtf";  
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
 irt= irt86 irt88 irt90 irt92 irt94 irt96,
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
         timevar= t86   t88   t90   t92   t94   t96 ,
         id=id, tvar=period,
         agevar=agecon, qret=  irt86 irt88 irt90 irt92 irt94 irt96, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &cbbmpotcav_ &qcalorcav_ , 
         model2  = medcbbmpotcav &qcalorcav_,
         model3  = &cbbmpotcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model4  = medcbbmpotcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model5  = &cbbmpotcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_, 
         model6  = medcbbmpotcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable10_nhs.bbm.8698.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;

/*Per serving*/
%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar= t86   t88   t90   t92   t94   t96,
         id=id, tvar=period,
         agevar=agecon, qret=irt84 irt86 irt88 irt90 irt92 irt94 irt96, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = tpotatw &qcalorcav_ , 
         model2  = tpotatw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,  
         model3  = tpotatw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 

         model4  = chipssw &qcalorcav_ , 
         model5  = chipssw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model6  = chipssw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 

         model7  = fpotatow &qcalorcav_ , 
         model8  = fpotatow &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model9  = fpotatow &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         
         model10  = bbmpotw &qcalorcav_ , 
         model11  = bbmpotw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model12  = bbmpotw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable10_nhs.8698.pserv.rtf";  
proc print data=scr_psd noobs;
   var  va model RR ProbChisq;   
run;

proc print data=all noobs;
   var  variable model beta see ProbChisq;
run;
ods rtf close;
