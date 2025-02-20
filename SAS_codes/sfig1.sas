/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Figure 1. Dose-response relations between total potato (A), baked, boiled, mashed (B), and French fries (C) with risk of T2D in the NHS, NHS II, and HPFS  (serving/week)
Study design: prospective cohort

/*NHS*/
/*MI*/
data mi_read;
    infile '/mi7620.073120.cases' lrecl=117 recfm=d;

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
    if .<dtdxcabg<1033 then cabg84=1;
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
            
    %nur82(keep=id str82 ra82 mvit82  vite82 hbp82 wt82 chol82 hbp82 db82 );

    %nur84(keep=id hbp84 wt84 chol84 hbp84 db84);

    %nur86(keep=id str86 ra86 cabg86 vite86 brcn86 curh86 wt86 hbp86 wt86 chol86 db86);

    %nur88(keep=id physx88 str88 ra88 cabg88 thiaz88 ccblo88 betab88 ace88 bprx88 clrx88 pct588 pct1088 
                           size5 size10 mvt88 vite88 curh88 serum88 wt88 hbp88 chol88 db88);
    /* age 5 shape */   if 1 <= pct588 <= 9 then size5=pct588;  else size5=.;
    /* age 10 shape */  if 1 <= pct1088 <= 9 then size10=pct1088;     else size10=.;

    %nur90(keep=id physx90 str90 ra90 cabg90 curh90 serum90 wt90 hbp90 chol90 db90);
  
    %nur92(keep=id physx92 str92 ra92 cabg92 alone92 mvt92 vite92 curh92 wt92 hbp92
        stbrn92 st1592 st3092 seuro92 scand92 ocauc92 afric92 hisp92 asian92 nativ92 oanc92 marry92 husbe92 alone92 rn92 ba92 ma92 dr92 chol92 db92); 

    %nur94(keep=id physx94 str94 cabg94 thiaz94 lasix94 ccblo94 betab94 bprx94 couma94  digox94 clrx94 curh94 serum94 wt94 hbp94 chol94 db94);

    %nur96(keep=id physc96 physy96 str96 ra96  thiaz96   lasix96    ccblo96    betab96    ace96   bprx96    couma96   digox96   antia96 
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
   keep id division: region: mdinc: mdvhs: pcolled: pfaminterest:
             pfwchbf: phs: pnohs: pkid: pold: pohse: popd: ppov: pwht: ;
run;
proc sort data=nses7616; by id; run;


/*********diabetes*********/
data diab_case;
infile 'diabetes/db7624.110123.cases' lrecl=183 recfm=d;

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

    keep id dtdxdiab probabil;

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
  
      run; 

proc univariate data=all;var dtdth;run;
proc univariate data=deadff;var dtdth;run;

proc sort data=all; by id; run;


data one;
   set all end=_end_;

if hbp76=1 or hbp78=1 or hbp80=1 or hbp82=1 or hbp84=2 then hxhbp=1; else hxhbp = 0;
if chol76 = 1 or chol78= 1 or  chol80 = 1 or chol82 = 1 or  chol84 = 2 then hxchol=1; else hxchol = 0;
if db76 = 1 or db78 = 1 or db80 = 1 or db82 = 1 or db84 = 2 then hxdb = 1; else hxdb = 0;
if hrt76 in (1,2) or hrt78 in (1,2) or hrt80 in (1,2) or hrt82 in (1,2) or hrt84 in (1,2) or cabg84=2 or str84=2 then hxcvd = 1; else hxcvd = 0;
if can76 = 1 or can78 = 1 or can80 = 1 or can82=1 or can84=2 then hxcan = 1; else hxcan = 0;


array nocum84 {*}  aofib84n ceraf84n alco84n calor84n trans84n sat84n mon84n poly84n gid84n fol_84n prot84n carbo84n carbden84n protden84n tpotat84d bbmpot84d fpotat84d chipss84d prmeat84d urmeat84d trmeat84d poultr84d fishal84d regegg84d hdairy84d ldairy84d /*soypro84d*/ nutsal84d legume84d fruits84d vegeal84d nstveg84d staveg84d tdairy84d coffee84d nutleg84d bwrice84d wtrice84d SSB84d whgrn84n rfgrn84n whgrns84d rfgrns84d gl84n ahei84 aheinoal84 aheinopt84 aheifisha84 aheidairy84 aheinutbl84 aheipoult84 aheineggs84;  
array nocum86 {*}  aofib86n ceraf86n alco86n calor86n trnss86n sat86n mon86n poly86n gid86n fol_86n prot86n carbo86n carbden86n protden86n tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d /*soypro86d*/ nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d whgrn86n rfgrn86n whgrns86d rfgrns86d gl86n ahei86 aheinoal86 aheinopt86 aheifisha86 aheidairy86 aheinutbl86 aheipoult86 aheineggs86;  
array nocum90 {*}  aofib90n ceraf90n alco90n calor90n trnss90n sat90n mon90n poly90n gid90n fol_90n prot90n carbo90n carbden90n protden90n tpotat90d bbmpot90d fpotat90d chipss90d prmeat90d urmeat90d trmeat90d poultr90d fishal90d regegg90d hdairy90d ldairy90d /*soypro90d*/ nutsal90d legume90d fruits90d vegeal90d nstveg90d staveg90d tdairy90d coffee90d nutleg90d bwrice90d wtrice90d SSB90d whgrn90n rfgrn90n whgrns90d rfgrns90d gl90n ahei90 aheinoal90 aheinopt90 aheifisha90 aheidairy90 aheinutbl90 aheipoult90 aheineggs90;
array nocum94 {*}  aofib94n ceraf94n alco94n calor94n trnss94n sat94n mon94n poly94n gid94n fol_94n prot94n carbo94n carbden94n protden94n tpotat94d bbmpot94d fpotat94d chipss94d prmeat94d urmeat94d trmeat94d poultr94d fishal94d regegg94d hdairy94d ldairy94d /*soypro94d*/ nutsal94d legume94d fruits94d vegeal94d nstveg94d staveg94d tdairy94d coffee94d nutleg94d bwrice94d wtrice94d SSB94d whgrn94n rfgrn94n whgrns94d rfgrns94d gl94n ahei94 aheinoal94 aheinopt94 aheifisha94 aheidairy94 aheinutbl94 aheipoult94 aheineggs94;
array nocum98 {*}  aofib98n ceraf98n alco98n calor98n trn0098n sat98n mon98n poly98n gid98n fol9898n prot98n carbo98n carbden98n protden98n tpotat98d bbmpot98d fpotat98d chipss98d prmeat98d urmeat98d trmeat98d poultr98d fishal98d regegg98d hdairy98d ldairy98d /*soypro98d*/ nutsal98d legume98d fruits98d vegeal98d nstveg98d staveg98d tdairy98d coffee98d nutleg98d bwrice98d wtrice98d SSB98d whgrn98n rfgrn98n whgrns98d rfgrns98d gl98n ahei98 aheinoal98 aheinopt98 aheifisha98 aheidairy98 aheinutbl98 aheipoult98 aheineggs98;
array nocum02 {*}  aofib02n ceraf02n alco02n calor02n trn0202n sat02n mon02n poly02n gid02n fol9802n prot02n carbo02n carbden02n protden02n tpotat02d bbmpot02d fpotat02d chipss02d prmeat02d urmeat02d trmeat02d poultr02d fishal02d regegg02d hdairy02d ldairy02d /*soypro02d*/ nutsal02d legume02d fruits02d vegeal02d nstveg02d staveg02d tdairy02d coffee02d nutleg02d bwrice02d wtrice02d SSB02d whgrn02n rfgrn02n whgrns02d rfgrns02d gl02n ahei02 aheinoal02 aheinopt02 aheifisha02 aheidairy02 aheinutbl02 aheipoult02 aheineggs02;
array nocum06 {*}  aofib06n ceraf06n alco06n calor06n trn0706n sat06n mon06n poly06n gid06n fol9806n prot06n carbo06n carbden06n protden06n tpotat06d bbmpot06d fpotat06d chipss06d prmeat06d urmeat06d trmeat06d poultr06d fishal06d regegg06d hdairy06d ldairy06d /*soypro06d*/ nutsal06d legume06d fruits06d vegeal06d nstveg06d staveg06d tdairy06d coffee06d nutleg06d bwrice06d wtrice06d SSB06d whgrn06n rfgrn06n whgrns06d rfgrns06d gl06n ahei06 aheinoal06 aheinopt06 aheifisha06 aheidairy06 aheinutbl06 aheipoult06 aheineggs06;
array nocum10 {*}  aofib10n ceraf10n alco10n calor10n trn1110n sat10n mon10n poly10n gid10n fol9810n prot10n carbo10n carbden10n protden10n tpotat10d bbmpot10d fpotat10d chipss10d prmeat10d urmeat10d trmeat10d poultr10d fishal10d regegg10d hdairy10d ldairy10d /*soypro10d*/ nutsal10d legume10d fruits10d vegeal10d nstveg10d staveg10d tdairy10d coffee10d nutleg10d bwrice10d wtrice10d SSB10d whgrn10n rfgrn10n whgrns10d rfgrns10d gl10n ahei10 aheinoal10 aheinopt10 aheifisha10 aheidairy10 aheinutbl10 aheipoult10 aheineggs10;

array cumul84 {*}  aofib84ca ceraf84ca alco84ca calor84ca trans84ca sat84ca mon84ca poly84ca gid84ca fol_84ca prot84ca carbo84ca carbden84ca protden84ca tpotat84ca bbmpot84ca fpotat84ca chipss84ca prmeat84ca urmeat84ca trmeat84ca poultr84ca fishal84ca regegg84ca hdairy84ca ldairy84ca /*soypro84ca*/ nutsal84ca legume84ca fruits84ca vegeal84ca nstveg84ca staveg84ca tdairy84ca coffee84ca nutleg84ca bwrice84ca wtrice84ca SSB84ca whgrn84ca rfgrn84ca whgrns84ca rfgrns84ca gl84ca ahei84ca aheinoal84ca aheinopt84ca aheifisha84ca aheidairy84ca aheinutbl84ca aheipoult84ca aheineggs84ca;  
array cumul86 {*}  aofib86ca ceraf86ca alco86ca calor86ca trnss86ca sat86ca mon86ca poly86ca gid86ca fol_86ca prot86ca carbo86ca carbden86ca protden86ca tpotat86ca bbmpot86ca fpotat86ca chipss86ca prmeat86ca urmeat86ca trmeat86ca poultr86ca fishal86ca regegg86ca hdairy86ca ldairy86ca /*soypro86ca*/ nutsal86ca legume86ca fruits86ca vegeal86ca nstveg86ca staveg86ca tdairy86ca coffee86ca nutleg86ca bwrice86ca wtrice86ca SSB86ca whgrn86ca rfgrn86ca whgrns86ca rfgrns86ca gl86ca ahei86ca aheinoal86ca aheinopt86ca aheifisha86ca aheidairy86ca aheinutbl86ca aheipoult86ca aheineggs86ca;  
array cumul90 {*}  aofib90ca ceraf90ca alco90ca calor90ca trnss90ca sat90ca mon90ca poly90ca gid90ca fol_90ca prot90ca carbo90ca carbden90ca protden90ca tpotat90ca bbmpot90ca fpotat90ca chipss90ca prmeat90ca urmeat90ca trmeat90ca poultr90ca fishal90ca regegg90ca hdairy90ca ldairy90ca /*soypro90ca*/ nutsal90ca legume90ca fruits90ca vegeal90ca nstveg90ca staveg90ca tdairy90ca coffee90ca nutleg90ca bwrice90ca wtrice90ca SSB90ca whgrn90ca rfgrn90ca whgrns90ca rfgrns90ca gl90ca ahei90ca aheinoal90ca aheinopt90ca aheifisha90ca aheidairy90ca aheinutbl90ca aheipoult90ca aheineggs90ca;
array cumul94 {*}  aofib94ca ceraf94ca alco94ca calor94ca trnss94ca sat94ca mon94ca poly94ca gid94ca fol_94ca prot94ca carbo94ca carbden94ca protden94ca tpotat94ca bbmpot94ca fpotat94ca chipss94ca prmeat94ca urmeat94ca trmeat94ca poultr94ca fishal94ca regegg94ca hdairy94ca ldairy94ca /*soypro94ca*/ nutsal94ca legume94ca fruits94ca vegeal94ca nstveg94ca staveg94ca tdairy94ca coffee94ca nutleg94ca bwrice94ca wtrice94ca SSB94ca whgrn94ca rfgrn94ca whgrns94ca rfgrns94ca gl94ca ahei94ca aheinoal94ca aheinopt94ca aheifisha94ca aheidairy94ca aheinutbl94ca aheipoult94ca aheineggs94ca;
array cumul98 {*}  aofib98ca ceraf98ca alco98ca calor98ca trn0098ca sat98ca mon98ca poly98ca gid98ca fol9898ca prot98ca carbo98ca carbden98ca protden98ca tpotat98ca bbmpot98ca fpotat98ca chipss98ca prmeat98ca urmeat98ca trmeat98ca poultr98ca fishal98ca regegg98ca hdairy98ca ldairy98ca /*soypro98ca*/ nutsal98ca legume98ca fruits98ca vegeal98ca nstveg98ca staveg98ca tdairy98ca coffee98ca nutleg98ca bwrice98ca wtrice98ca SSB98ca whgrn98ca rfgrn98ca whgrns98ca rfgrns98ca gl98ca ahei98ca aheinoal98ca aheinopt98ca aheifisha98ca aheidairy98ca aheinutbl98ca aheipoult98ca aheineggs98ca;
array cumul02 {*}  aofib02ca ceraf02ca alco02ca calor02ca trn0202ca sat02ca mon02ca poly02ca gid02ca fol9802ca prot02ca carbo02ca carbden02ca protden02ca tpotat02ca bbmpot02ca fpotat02ca chipss02ca prmeat02ca urmeat02ca trmeat02ca poultr02ca fishal02ca regegg02ca hdairy02ca ldairy02ca /*soypro02ca*/ nutsal02ca legume02ca fruits02ca vegeal02ca nstveg02ca staveg02ca tdairy02ca coffee02ca nutleg02ca bwrice02ca wtrice02ca SSB02ca whgrn02ca rfgrn02ca whgrns02ca rfgrns02ca gl02ca ahei02ca aheinoal02ca aheinopt02ca aheifisha02ca aheidairy02ca aheinutbl02ca aheipoult02ca aheineggs02ca;
array cumul06 {*}  aofib06ca ceraf06ca alco06ca calor06ca trn0706ca sat06ca mon06ca poly06ca gid06ca fol9806ca prot06ca carbo06ca carbden06ca protden06ca tpotat06ca bbmpot06ca fpotat06ca chipss06ca prmeat06ca urmeat06ca trmeat06ca poultr06ca fishal06ca regegg06ca hdairy06ca ldairy06ca /*soypro06ca*/ nutsal06ca legume06ca fruits06ca vegeal06ca nstveg06ca staveg06ca tdairy06ca coffee06ca nutleg06ca bwrice06ca wtrice06ca SSB06ca whgrn06ca rfgrn06ca whgrns06ca rfgrns06ca gl06ca ahei06ca aheinoal06ca aheinopt06ca aheifisha06ca aheidairy06ca aheinutbl06ca aheipoult06ca aheineggs06ca;
array cumul10 {*}  aofib10ca ceraf10ca alco10ca calor10ca trn1110ca sat10ca mon10ca poly10ca gid10ca fol9810ca prot10ca carbo10ca carbden10ca protden10ca tpotat10ca bbmpot10ca fpotat10ca chipss10ca prmeat10ca urmeat10ca trmeat10ca poultr10ca fishal10ca regegg10ca hdairy10ca ldairy10ca /*soypro10ca*/ nutsal10ca legume10ca fruits10ca vegeal10ca nstveg10ca staveg10ca tdairy10ca coffee10ca nutleg10ca bwrice10ca wtrice10ca SSB10ca whgrn10ca rfgrn10ca whgrns10ca rfgrns10ca gl10ca ahei10ca aheinoal10ca aheinopt10ca aheifisha10ca aheidairy10ca aheinutbl10ca aheipoult10ca aheineggs10ca;


do i = 1 to DIM(cumul10);
        cumul84{i} = nocum84{i};
        cumul86{i} = mean(nocum84{i}, nocum86{i});
        cumul90{i} = mean(nocum84{i}, nocum86{i}, nocum90{i});
        cumul94{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i});
        cumul98{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
        cumul02{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i});
        cumul06{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i});
        cumul10{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i});
end;

run;

data two;
   set one end=_end_;
 
  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1); 
   if white=1 then white2=1;
   else white2=0;

  /*%indic3(vbl=race9204, prefix=catrace, min=2,max=5, reflev=1, missing=., usemiss=1); */

   
array irt   {19}  irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12  irt14  irt16 irt18 cutoff;
array perioda  {18}  period1  period2  period3  period4  period5  period6  period7  period8  period9  period10 period11 period12 period13 period14 period15 period16 period17 period18;
array tvar  {18}  t84  t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06   t08 t10 t12 t14 t16 t18;
array age   {18}  age84 age86 age88 age90 age92 age94 age96 age98 age00 age02 age04 age06 age08 age10 age12  age14 age16 age18;
array aspyn {18}  aspyn84 aspyn86 aspyn88   aspyn90  aspyn92  aspyn94  aspyn96  aspyn98  aspyn00  aspyn02  aspyn04  aspyn06  aspyn08  aspyn10  aspyn12 aspyn14 aspyn16 aspyn16;
array hbp   {18}  hbp84 hbp86   hbp88   hbp90   hbp92   hbp94   hbp96   hbp98   hbp00    hbp02    hbp04    hbp06     hbp08 hbp10 hbp12 hbp14 hbp16 hbp16 ; 
array nsmk  {18}  smkdr84 smkdr86  smkdr88  smkdr90  smkdr92  smkdr94  smkdr96  smkdr98  smkdr00  smkdr02  smkdr04  smkdr06  smkdr08  smkdr10  smkdr12  smkdr14 smkdr16 smkdr16;
array bmi   {18}  bmi84 bmi86 bmi88 bmi90 bmi92 bmi94 bmi96 bmi98 bmi00 bmi02 bmi04 bmi06 bmi08 bmi10 bmi12 bmi14 bmi16 bmi16;
array actm  {18}  act86m act86m act88m act88m act92m act94m act96m act98m act00m act00m act04m act04m act08m act08m act12m act14m act14m act14m;
array pam   {18}  act86m act86m act88m act88m act92m act94m act96m act98m act00m act00m act04m act04m act08m act08m act12m act14m act14m act14m;
array horm  {18}  nhor84 nhor86 nhor88 nhor90 nhor92 nhor94 nhor96 nhor98 nhor00 nhor02 nhor04 nhor06 nhor08 nhor10 nhor12 nhor14 nhor16 nhor16;
array mvit  {18}  mvitu84 mvitu86 mvitu88 mvitu90 mvitu92 mvitu94 mvitu96 mvitu98 mvitu00 mvitu02 mvitu04 mvitu06 mvitu08 mvitu10 mvitu12 mvitu14 mvitu16 mvitu16;
array supp  {18}  suppu84 suppu86 suppu88 suppu90 suppu92 suppu94 suppu96 suppu98 suppu00 suppu02 suppu04 suppu06 suppu08 suppu10 suppu12 suppu14 suppu16 suppu16;
array antihp   {18}  htnrx88  htnrx88  htnrx88  htnrx88  htnrx88  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08 htnrx10 htnrx12 htnrx14 htnrx16 htnrx16; 
array antitc   {18}  hchtx88  hchtx88  hchtx88  hchtx88  hchtx88  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08 hchtx10 hchtx12 hchtx14 hchtx16 hchtx16;

array calorca  {18}  calor84ca calor86ca calor86ca calor90ca calor90ca calor94ca calor94ca calor98ca calor98ca calor02ca calor02ca calor06ca calor06ca calor10ca calor10ca calor10ca calor10ca calor10ca;
array aofibca  {18}  aofib84ca aofib86ca aofib86ca aofib90ca aofib90ca aofib94ca aofib94ca aofib98ca aofib98ca aofib02ca aofib02ca aofib06ca aofib06ca aofib10ca aofib10ca aofib10ca aofib10ca aofib10ca;
array cerafca  {18}  ceraf84ca ceraf86ca ceraf86ca ceraf90ca ceraf90ca ceraf94ca ceraf94ca ceraf98ca ceraf98ca ceraf02ca ceraf02ca ceraf06ca ceraf06ca ceraf10ca ceraf10ca ceraf10ca ceraf10ca ceraf10ca;
array alcoca  {18}  alco84ca alco86ca alco86ca alco90ca alco90ca alco94ca alco94ca alco98ca alco98ca alco02ca alco02ca alco06ca alco06ca alco10ca alco10ca alco10ca alco10ca alco10ca;
array satfca  {18}  sat84ca sat86ca sat86ca sat90ca sat90ca sat94ca sat94ca sat98ca sat98ca sat02ca sat02ca sat06ca sat06ca sat10ca sat10ca sat10ca sat10ca sat10ca;
array monfca  {18}  mon84ca mon86ca mon86ca mon90ca mon90ca mon94ca mon94ca mon98ca mon98ca mon02ca mon02ca mon06ca mon06ca mon10ca mon10ca mon10ca mon10ca mon10ca;
array polyfca  {18}  poly84ca poly86ca poly86ca poly90ca poly90ca poly94ca poly94ca poly98ca poly98ca poly02ca poly02ca poly06ca poly06ca poly10ca poly10ca poly10ca poly10ca poly10ca;
array transfca  {18}  trans84ca trnss86ca trnss86ca trnss90ca trnss90ca trnss94ca trnss94ca trn0098ca trn0098ca trn0202ca trn0202ca trn0706ca trn0706ca trn1110ca trn1110ca trn1110ca trn1110ca trn1110ca;
array folca  {18}  fol_84ca fol_86ca fol_86ca fol_90ca fol_90ca fol_94ca fol_94ca fol9898ca fol9898ca fol9802ca fol9802ca fol9806ca fol9806ca fol9810ca fol9810ca fol9810ca fol9810ca fol9810ca;
array protca  {18}  prot84ca prot86ca prot86ca prot90ca prot90ca prot94ca prot94ca prot98ca prot98ca prot02ca prot02ca prot06ca prot06ca prot10ca prot10ca prot10ca prot10ca prot10ca;
array protdenca  {18}  protden84ca protden86ca protden86ca protden90ca protden90ca protden94ca protden94ca protden98ca protden98ca protden02ca protden02ca protden06ca protden06ca protden10ca protden10ca protden10ca protden10ca protden10ca;
array gidca  {18}   gid84ca gid86ca gid86ca gid90ca gid90ca gid94ca gid94ca gid98ca gid98ca gid02ca gid02ca gid06ca gid06ca gid10ca gid10ca gid10ca gid10ca gid10ca;
array carboca  {18}   carbo84ca carbo86ca carbo86ca carbo90ca carbo90ca carbo94ca carbo94ca carbo98ca carbo98ca carbo02ca carbo02ca carbo06ca carbo06ca carbo10ca carbo10ca carbo10ca carbo10ca carbo10ca;
array carbdenca  {18}   carbden84ca carbden86ca carbden86ca carbden90ca carbden90ca carbden94ca carbden94ca carbden98ca carbden98ca carbden02ca carbden02ca carbden06ca carbden06ca carbden10ca carbden10ca carbden10ca carbden10ca carbden10ca;

array calor  {18}   calor84n calor86n calor86n calor90n calor90n calor94n calor94n calor98n calor98n calor02n calor02n calor06n calor06n calor10n calor10n calor10n calor10n calor10n;
array carbo  {18}   carbo84n carbo86n carbo86n carbo90n carbo90n carbo94n carbo94n carbo98n carbo98n carbo02n carbo02n carbo06n carbo06n carbo10n carbo10n carbo10n carbo10n carbo10n;
array carbden  {18}  carbden84n carbden86n carbden86n carbden90n carbden90n carbden94n carbden94n carbden98n carbden98n carbden02n carbden02n carbden06n carbden06n carbden10n carbden10n carbden10n carbden10n carbden10n;
array prot  {18}   prot84n prot86n prot86n prot90n prot90n prot94n prot94n prot98n prot98n prot02n prot02n prot06n prot06n prot10n prot10n prot10n prot10n prot10n;
array protden  {18} protden84n protden86n protden86n protden90n protden90n protden94n protden94n protden98n protden98n protden02n protden02n protden06n protden06n protden10n protden10n protden10n protden10n protden10n;
array alco  {18}   alco84n alco86n alco86n alco90n alco90n alco94n alco94n alco98n alco98n alco02n alco02n alco06n alco06n alco10n alco10n alco10n alco10n alco10n;
array ceraf  {18}  ceraf84n ceraf86n ceraf86n ceraf90n ceraf90n ceraf94n ceraf94n ceraf98n ceraf98n ceraf02n ceraf02n ceraf06n ceraf06n ceraf10n ceraf10n ceraf10n ceraf10n ceraf10n;
array aofib  {18}  aofib84n aofib86n aofib86n aofib90n aofib90n aofib94n aofib94n aofib98n aofib98n aofib02n aofib02n aofib06n aofib06n aofib10n aofib10n aofib10n aofib10n aofib10n;

array tpotat  {18}  tpotat84d tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d tpotat94d tpotat98d tpotat98d tpotat02d tpotat02d tpotat06d tpotat06d tpotat10d tpotat10d tpotat10d tpotat10d tpotat10d;
array bbmpot  {18}  bbmpot84d bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d bbmpot94d bbmpot98d bbmpot98d bbmpot02d bbmpot02d bbmpot06d bbmpot06d bbmpot10d bbmpot10d bbmpot10d bbmpot10d bbmpot10d;
array fpotat  {18}  fpotat84d fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d fpotat94d fpotat98d fpotat98d fpotat02d fpotat02d fpotat06d fpotat06d fpotat10d fpotat10d fpotat10d fpotat10d fpotat10d; 
array chipss  {18}  chipss84d chipss86d chipss86d chipss90d chipss90d chipss94d chipss94d chipss98d chipss98d chipss02d chipss02d chipss06d chipss06d chipss10d chipss10d chipss10d chipss10d chipss10d;
array prmeat  {18}  prmeat84d prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d prmeat94d prmeat98d prmeat98d prmeat02d prmeat02d prmeat06d prmeat06d prmeat10d prmeat10d prmeat10d prmeat10d prmeat10d;
array urmeat  {18}  urmeat84d urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d urmeat94d urmeat98d urmeat98d urmeat02d urmeat02d urmeat06d urmeat06d urmeat10d urmeat10d urmeat10d urmeat10d urmeat10d;
array trmeat  {18}  trmeat84d trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d trmeat94d trmeat98d trmeat98d trmeat02d trmeat02d trmeat06d trmeat06d trmeat10d trmeat10d trmeat10d trmeat10d trmeat10d;
array poultr  {18}  poultr84d poultr86d poultr86d poultr90d poultr90d poultr94d poultr94d poultr98d poultr98d poultr02d poultr02d poultr06d poultr06d poultr10d poultr10d poultr10d poultr10d poultr10d;
array fishal  {18}  fishal84d fishal86d fishal86d fishal90d fishal90d fishal94d fishal94d fishal98d fishal98d fishal02d fishal02d fishal06d fishal06d fishal10d fishal10d fishal10d fishal10d fishal10d;
array regegg  {18}  regegg84d regegg86d regegg86d regegg90d regegg90d regegg94d regegg94d regegg98d regegg98d regegg02d regegg02d regegg06d regegg06d regegg10d regegg10d regegg10d regegg10d regegg10d;
array hdairy  {18}  hdairy84d hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d hdairy94d hdairy98d hdairy98d hdairy02d hdairy02d hdairy06d hdairy06d hdairy10d hdairy10d hdairy10d hdairy10d hdairy10d;
array ldairy  {18}  ldairy84d ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ldairy94d ldairy98d ldairy98d ldairy02d ldairy02d ldairy06d ldairy06d ldairy10d ldairy10d ldairy10d ldairy10d ldairy10d;
/*array soypro  {18}  soypro84d soypro86d soypro86d soypro90d soypro90d soypro94d soypro94d soypro98d soypro98d soypro02d soypro02d soypro06d soypro06d soypro10d soypro10d soypro10d soypro10d soypro10d;*/
array nutsal  {18}  nutsal84d nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d nutsal94d nutsal98d nutsal98d nutsal02d nutsal02d nutsal06d nutsal06d nutsal10d nutsal10d nutsal10d nutsal10d nutsal10d;
array legume  {18}  legume84d legume86d legume86d legume90d legume90d legume94d legume94d legume98d legume98d legume02d legume02d legume06d legume06d legume10d legume10d legume10d legume10d legume10d;
array fruits  {18}  fruits84d fruits86d fruits86d fruits90d fruits90d fruits94d fruits94d fruits98d fruits98d fruits02d fruits02d fruits06d fruits06d fruits10d fruits10d fruits10d fruits10d fruits10d;
array vegeal  {18}  vegeal84d vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d vegeal94d vegeal98d vegeal98d vegeal02d vegeal02d vegeal06d vegeal06d vegeal10d vegeal10d vegeal10d vegeal10d vegeal10d;
array nstveg  {18}  nstveg84d nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d nstveg94d nstveg98d nstveg98d nstveg02d nstveg02d nstveg06d nstveg06d nstveg10d nstveg10d nstveg10d nstveg10d nstveg10d;
array staveg  {18}  staveg84d staveg86d staveg86d staveg90d staveg90d staveg94d staveg94d staveg98d staveg98d staveg02d staveg02d staveg06d staveg06d staveg10d staveg10d staveg10d staveg10d staveg10d;
array tdairy  {18}  tdairy84d tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d tdairy94d tdairy98d tdairy98d tdairy02d tdairy02d tdairy06d tdairy06d tdairy10d tdairy10d tdairy10d tdairy10d tdairy10d;
array coffee  {18}  coffee84d coffee86d coffee86d coffee90d coffee90d coffee94d coffee94d coffee98d coffee98d coffee02d coffee02d coffee06d coffee06d coffee10d coffee10d coffee10d coffee10d coffee10d;
array nutleg  {18}  nutleg84d nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d nutleg94d nutleg98d nutleg98d nutleg02d nutleg02d nutleg06d nutleg06d nutleg10d nutleg10d nutleg10d nutleg10d nutleg10d;
array bwrice  {18}  bwrice84d bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d bwrice94d bwrice98d bwrice98d bwrice02d bwrice02d bwrice06d bwrice06d bwrice10d bwrice10d bwrice10d bwrice10d bwrice10d;
array wtrice  {18}  wtrice84d wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d wtrice94d wtrice98d wtrice98d wtrice02d wtrice02d wtrice06d wtrice06d wtrice10d wtrice10d wtrice10d wtrice10d wtrice10d;
array SSB     {18}  SSB84d SSB86d SSB86d SSB90d SSB90d SSB94d SSB94d SSB98d SSB98d SSB02d SSB02d SSB06d SSB06d SSB10d SSB10d SSB10d SSB10d SSB10d;
array whgrns  {18}  whgrns84d whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d whgrns94d whgrns98d whgrns98d whgrns02d whgrns02d whgrns06d whgrns06d whgrns10d whgrns10d whgrns10d whgrns10d whgrns10d;
array rfgrns  {18}  rfgrns84d rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d rfgrns94d rfgrns98d rfgrns98d rfgrns02d rfgrns02d rfgrns06d rfgrns06d rfgrns10d rfgrns10d rfgrns10d rfgrns10d rfgrns10d;
array whgrn  {18}  whgrn84n whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n whgrn94n whgrn98n whgrn98n whgrn02n whgrn02n whgrn06n whgrn06n whgrn10n whgrn10n whgrn10n whgrn10n whgrn10n;
array rfgrn  {18}  rfgrn84n rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n rfgrn94n rfgrn98n rfgrn98n rfgrn02n rfgrn02n rfgrn06n rfgrn06n rfgrn10n rfgrn10n rfgrn10n rfgrn10n rfgrn10n;
array gl     {18}     gl84n gl86n gl86n gl90n gl90n gl94n gl94n gl98n gl98n gl02n gl02n gl06n gl06n gl10n gl10n gl10n gl10n gl10n;
array gid    {18}  gid84n gid86n gid86n gid90n gid90n gid94n gid94n gid98n gid98n gid02n gid02n gid06n gid06n gid10n gid10n gid10n gid10n gid10n;

array tpotatca  {18}  tpotat84ca tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca tpotat94ca tpotat98ca tpotat98ca tpotat02ca tpotat02ca tpotat06ca tpotat06ca tpotat10ca tpotat10ca tpotat10ca tpotat10ca tpotat10ca;
array bbmpotca  {18}  bbmpot84ca bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca bbmpot94ca bbmpot98ca bbmpot98ca bbmpot02ca bbmpot02ca bbmpot06ca bbmpot06ca bbmpot10ca bbmpot10ca bbmpot10ca bbmpot10ca bbmpot10ca ;
array fpotatca  {18}  fpotat84ca fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca fpotat94ca fpotat98ca fpotat98ca fpotat02ca fpotat02ca fpotat06ca fpotat06ca fpotat10ca fpotat10ca fpotat10ca fpotat10ca fpotat10ca;
array chipssca  {18}  chipss84ca chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca chipss94ca chipss98ca chipss98ca chipss02ca chipss02ca chipss06ca chipss06ca chipss10ca chipss10ca chipss10ca chipss10ca chipss10ca;
array prmeatca  {18}  prmeat84ca prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca prmeat94ca prmeat98ca prmeat98ca prmeat02ca prmeat02ca prmeat06ca prmeat06ca prmeat10ca prmeat10ca prmeat10ca prmeat10ca prmeat10ca;
array urmeatca  {18}  urmeat84ca urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca urmeat94ca urmeat98ca urmeat98ca urmeat02ca urmeat02ca urmeat06ca urmeat06ca urmeat10ca urmeat10ca urmeat10ca urmeat10ca urmeat10ca;
array trmeatca  {18}  trmeat84ca trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca trmeat94ca trmeat98ca trmeat98ca trmeat02ca trmeat02ca trmeat06ca trmeat06ca trmeat10ca trmeat10ca trmeat10ca trmeat10ca trmeat10ca;
array poultrca  {18}  poultr84ca poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca poultr94ca poultr98ca poultr98ca poultr02ca poultr02ca poultr06ca poultr06ca poultr10ca poultr10ca poultr10ca poultr10ca poultr10ca;
array fishalca  {18}  fishal84ca fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca fishal94ca fishal98ca fishal98ca fishal02ca fishal02ca fishal06ca fishal06ca fishal10ca fishal10ca fishal10ca fishal10ca fishal10ca;
array regeggca  {18}  regegg84ca regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca regegg94ca regegg98ca regegg98ca regegg02ca regegg02ca regegg06ca regegg06ca regegg10ca regegg10ca regegg10ca regegg10ca regegg10ca;
array hdairyca  {18}  hdairy84ca hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca hdairy94ca hdairy98ca hdairy98ca hdairy02ca hdairy02ca hdairy06ca hdairy06ca hdairy10ca hdairy10ca hdairy10ca hdairy10ca hdairy10ca;
array ldairyca  {18}  ldairy84ca ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca ldairy94ca ldairy98ca ldairy98ca ldairy02ca ldairy02ca ldairy06ca ldairy06ca ldairy10ca ldairy10ca ldairy10ca ldairy10ca ldairy10ca;
/*array soyproca  {18} soypro84ca soypro86ca soypro86ca soypro90ca soypro90ca soypro94ca soypro94ca soypro98ca soypro98ca soypro02ca soypro02ca soypro06ca soypro06ca soypro10ca soypro10ca soypro10ca soypro10ca soypro10ca;*/
array nutsalca  {18}  nutsal84ca nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca nutsal94ca nutsal98ca nutsal98ca nutsal02ca nutsal02ca nutsal06ca nutsal06ca nutsal10ca nutsal10ca nutsal10ca nutsal10ca nutsal10ca;
array legumeca  {18}  legume84ca legume86ca legume86ca legume90ca legume90ca legume94ca legume94ca legume98ca legume98ca legume02ca legume02ca legume06ca legume06ca legume10ca legume10ca legume10ca legume10ca legume10ca;
array fruitsca  {18}  fruits84ca fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca fruits94ca fruits98ca fruits98ca fruits02ca fruits02ca fruits06ca fruits06ca fruits10ca fruits10ca fruits10ca fruits10ca fruits10ca;
array vegealca  {18}  vegeal84ca vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca vegeal94ca vegeal98ca vegeal98ca vegeal02ca vegeal02ca vegeal06ca vegeal06ca vegeal10ca vegeal10ca vegeal10ca vegeal10ca vegeal10ca;
array nstvegca  {18}  nstveg84ca nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca nstveg94ca nstveg98ca nstveg98ca nstveg02ca nstveg02ca nstveg06ca nstveg06ca nstveg10ca nstveg10ca nstveg10ca nstveg10ca nstveg10ca;
array stavegca  {18}  staveg84ca staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca staveg94ca staveg98ca staveg98ca staveg02ca staveg02ca staveg06ca staveg06ca staveg10ca staveg10ca staveg10ca staveg10ca staveg10ca;
array tdairyca  {18}  tdairy84ca tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca tdairy94ca tdairy98ca tdairy98ca tdairy02ca tdairy02ca tdairy06ca tdairy06ca tdairy10ca tdairy10ca tdairy10ca tdairy10ca tdairy10ca; 
array coffeeca  {18}  coffee84ca coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca coffee94ca coffee98ca coffee98ca coffee02ca coffee02ca coffee06ca coffee06ca coffee10ca coffee10ca coffee10ca coffee10ca coffee10ca;
array nutlegca  {18}  nutleg84ca nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca nutleg94ca nutleg98ca nutleg98ca nutleg02ca nutleg02ca nutleg06ca nutleg06ca nutleg10ca nutleg10ca nutleg10ca nutleg10ca nutleg10ca;
array bwriceca  {18}  bwrice84ca bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca bwrice94ca bwrice98ca bwrice98ca bwrice02ca bwrice02ca bwrice06ca bwrice06ca bwrice10ca bwrice10ca bwrice10ca bwrice10ca bwrice10ca;
array wtriceca  {18}  wtrice84ca wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca wtrice94ca wtrice98ca wtrice98ca wtrice02ca wtrice02ca wtrice06ca wtrice06ca wtrice10ca wtrice10ca wtrice10ca wtrice10ca wtrice10ca;
array SSBca     {18}  SSB84ca SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca SSB94ca SSB98ca SSB98ca SSB02ca SSB02ca SSB06ca SSB06ca SSB10ca SSB10ca SSB10ca SSB10ca SSB10ca;
array whgrnsca  {18}  whgrns84ca whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca whgrns94ca whgrns98ca whgrns98ca whgrns02ca whgrns02ca whgrns06ca whgrns06ca whgrns10ca whgrns10ca whgrns10ca whgrns10ca whgrns10ca;
array rfgrnsca  {18}  rfgrns84ca rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca rfgrns94ca rfgrns98ca rfgrns98ca rfgrns02ca rfgrns02ca rfgrns06ca rfgrns06ca rfgrns10ca rfgrns10ca rfgrns10ca rfgrns10ca rfgrns10ca;
array whgrnca  {18}   whgrn84ca whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca whgrn94ca whgrn98ca whgrn98ca whgrn02ca whgrn02ca whgrn06ca whgrn06ca whgrn10ca whgrn10ca whgrn10ca whgrn10ca whgrn10ca;
array rfgrnca  {18}   rfgrn84ca rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca rfgrn94ca rfgrn98ca rfgrn98ca rfgrn02ca rfgrn02ca rfgrn06ca rfgrn06ca rfgrn10ca rfgrn10ca rfgrn10ca rfgrn10ca rfgrn10ca;
array glca  {18}  gl84ca gl86ca gl86ca gl90ca gl90ca gl94ca gl94ca gl98ca gl98ca gl02ca gl02ca gl06ca gl06ca gl10ca gl10ca gl10ca gl10ca gl10ca;

array ahei  {18}  ahei84 ahei86 ahei86 ahei90 ahei90 ahei94 ahei94 ahei98 ahei98 ahei02 ahei02 ahei06 ahei06 ahei10 ahei10 ahei10 ahei10 ahei10;
array aheinoal  {18}  aheinoal84 aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 aheinoal94 aheinoal98 aheinoal98 aheinoal02 aheinoal02 aheinoal06 aheinoal06 aheinoal10 aheinoal10 aheinoal10 aheinoal10 aheinoal10;
array aheinopt  {18}  aheinopt84 aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 aheinopt94 aheinopt98 aheinopt98 aheinopt02 aheinopt02 aheinopt06 aheinopt06 aheinopt10 aheinopt10 aheinopt10 aheinopt10 aheinopt10;
array aheifisha  {18}  aheifisha84 aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 aheifisha94 aheifisha98 aheifisha98 aheifisha02 aheifisha02 aheifisha06 aheifisha06 aheifisha10 aheifisha10 aheifisha10 aheifisha10 aheifisha10;
array aheidairy  {18}  aheidairy84 aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 aheidairy94 aheidairy98 aheidairy98 aheidairy02 aheidairy02 aheidairy06 aheidairy06 aheidairy10 aheidairy10 aheidairy10 aheidairy10 aheidairy10;
array aheinutbl  {18}  aheinutbl84 aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 aheinutbl94 aheinutbl98 aheinutbl98 aheinutbl02 aheinutbl02 aheinutbl06 aheinutbl06 aheinutbl10 aheinutbl10 aheinutbl10 aheinutbl10 aheinutbl10;
array aheipoult  {18}  aheipoult84 aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 aheipoult94 aheipoult98 aheipoult98 aheipoult02 aheipoult02 aheipoult06 aheipoult06 aheipoult10 aheipoult10 aheipoult10 aheipoult10 aheipoult10;
array aheineggs  {18}  aheineggs84 aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 aheineggs94 aheineggs98 aheineggs98 aheineggs02 aheineggs02 aheineggs06 aheineggs06 aheineggs10 aheineggs10 aheineggs10 aheineggs10 aheineggs10;

array aheica  {18}  ahei84ca ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca ahei94ca ahei98ca ahei98ca ahei02ca ahei02ca ahei06ca ahei06ca ahei10ca ahei10ca ahei10ca ahei10ca ahei10ca;
array aheinoalca  {18}   aheinoal84ca aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca aheinoal94ca aheinoal98ca aheinoal98ca aheinoal02ca aheinoal02ca aheinoal06ca aheinoal06ca aheinoal10ca aheinoal10ca aheinoal10ca aheinoal10ca aheinoal10ca;
array aheinoptca  {18}   aheinopt84ca aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca aheinopt94ca aheinopt98ca aheinopt98ca aheinopt02ca aheinopt02ca aheinopt06ca aheinopt06ca aheinopt10ca aheinopt10ca aheinopt10ca aheinopt10ca aheinopt10ca;
array aheifishaca  {18}  aheifisha84ca aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca aheifisha94ca aheifisha98ca aheifisha98ca aheifisha02ca aheifisha02ca aheifisha06ca aheifisha06ca aheifisha10ca aheifisha10ca aheifisha10ca aheifisha10ca aheifisha10ca;
array aheidairyca  {18}  aheidairy84ca aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca aheidairy94ca aheidairy98ca aheidairy98ca aheidairy02ca aheidairy02ca aheidairy06ca aheidairy06ca aheidairy10ca aheidairy10ca aheidairy10ca aheidairy10ca aheidairy10ca;
array aheinutblca  {18}  aheinutbl84ca aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca aheinutbl94ca aheinutbl98ca aheinutbl98ca aheinutbl02ca aheinutbl02ca aheinutbl06ca aheinutbl06ca aheinutbl10ca aheinutbl10ca aheinutbl10ca aheinutbl10ca aheinutbl10ca;
array aheipoultca  {18}  aheipoult84ca aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca aheipoult94ca aheipoult98ca aheipoult98ca aheipoult02ca aheipoult02ca aheipoult06ca aheipoult06ca aheipoult10ca aheipoult10ca aheipoult10ca aheipoult10ca aheipoult10ca;
array aheineggsca  {18}  aheineggs84ca aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca aheineggs94ca aheineggs98ca aheineggs98ca aheineggs02ca aheineggs02ca aheineggs06ca aheineggs06ca aheineggs10ca aheineggs10ca aheineggs10ca aheineggs10ca aheineggs10ca;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {18} alone92 alone92 alone92 alone92 alone92 alone92 alone96 alone96 alone00 alone00 alone04
                 alone04 alone08 alone08 alone12 alone12 alone16 alone16;
array married {18} marry92 marry92 marry92 marry92 marry92 marry92 marry96 marry96 marry00 marry00 marry04
                 marry04 marry08 marry08 marry12 marry12 marry16 marry16;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {18} mdinc90_86 mdinc90_86 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94 mdinc00_96 mdinc00_98 mdinc00_00
        mdinc00_02 mdinc00_04 mdinc10_06 mdinc10_08 mdinc10_10 mdinc10_12 mdinc10_14 mdinc10_16 mdinc10_16; 
   array vhs {18} mdvhs90_86 mdvhs90_86 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94 mdvhs00_96 mdvhs00_98 mdvhs00_00
        mdvhs00_02 mdvhs00_04 mdvhs10_06 mdvhs10_08 mdvhs10_10 mdvhs10_12 mdvhs10_14 mdvhs10_16 mdvhs10_16; 
   array pcoll {18} pcolled80_86 pcolled90_86 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94 pcolled00_96
          pcolled00_98 pcolled00_00 pcolled00_02 pcolled00_04 pcolled10_06 pcolled10_08
          pcolled10_10 pcolled10_12 pcolled10_14 pcolled10_16 pcolled10_16;
   array phs {18} phs80_86 phs90_86 phs90_88 phs90_90 phs90_92 phs90_94 phs00_96 phs00_98 phs00_00 phs00_02 phs00_04
        phs10_06 phs10_08 phs10_10 phs10_12 phs10_14 phs10_16 phs10_16;
   array pnohs {18} pnohs80_86 pnohs90_86 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94 pnohs00_96 pnohs00_98 pnohs00_00 pnohs00_02 pnohs00_04
        pnohs10_06 pnohs10_08 pnohs10_10 pnohs10_12 pnohs10_14 pnohs10_16 pnohs10_16;
   array pfint {18} pfaminterest80_86 pfaminterest90_86 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94
          pfaminterest00_96 pfaminterest00_98 pfaminterest00_00 pfaminterest00_02 pfaminterest00_04
          pfaminterest10_06 pfaminterest10_08 pfaminterest10_10 pfaminterest10_12 pfaminterest10_14 pfaminterest10_16 pfaminterest10_16;
   array sfemale {18} pfwchbf80_86 pfwchbf90_86 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94 pfwchbf00_96 pfwchbf00_98
            pfwchbf00_00 pfwchbf00_02 pfwchbf00_04 pfwchbf10_06 pfwchbf10_08 pfwchbf10_10 pfwchbf10_12 pfwchbf10_14 pfwchbf10_16 pfwchbf10_16;
   array pkid {18} pkid80_86 pkid90_86 pkid90_88 pkid90_90 pkid90_92 pkid90_94 pkid00_96 pkid00_98 pkid00_00 pkid00_02 pkid00_04
         pkid10_06 pkid10_08 pkid10_10 pkid10_12 pkid10_14 pkid10_16 pkid10_16;
   array pold {18} pold80_86 pold90_86 pold90_88 pold90_90 pold90_92 pold90_94 pold00_96 pold00_98 pold00_00 pold00_02 pold00_04
         pold10_06 pold10_08 pold10_10 pold10_12 pold10_14 pold10_16 pold10_16;
   array pohse {18} pohse80_86 pohse90_86 pohse90_88 pohse90_90 pohse90_92 pohse90_94 pohse00_96 pohse00_98 pohse00_00 pohse00_02
          pohse00_04 pohse10_06 pohse10_08 pohse10_10 pohse10_12 pohse10_14 pohse10_16 pohse10_16;
   array ppov {18} ppov80_86 ppov90_86 ppov90_88 ppov90_90 ppov90_92 ppov90_94 ppov00_96 ppov00_98 ppov00_00 ppov00_02
         ppov00_04 ppov10_06 ppov10_08 ppov10_10 ppov10_12 ppov10_14 ppov10_16 ppov10_16;
   array pw {18}   pwht80_86 pwht90_86 pwht90_88 pwht90_90 pwht90_92 pwht90_94 pwht00_96 pwht00_98 pwht00_00 pwht00_02
         pwht00_04 pwht10_06 pwht10_08 pwht10_10 pwht10_12 pwht10_14 pwht10_16 pwht10_16;

   array popd {18}  popd80_86 popd90_86 popd90_88 popd90_90 popd90_92 popd90_94 popd00_96 popd00_98 popd00_00 popd00_02
              popd00_04 popd10_06 popd10_08 popd10_10 popd10_12 popd10_14 popd10_16 popd10_16; 
   array div {18} division10_86 division10_86 division10_88 division10_90 division10_92 division10_94 division10_96
        division10_98 division10_00 division10_02 division10_04 division10_06 division10_08
        division10_10 division10_12 division10_14 division10_16 division10_16;
   array reg {18} region10_86 region10_86 region10_88 region10_90 region10_92 region10_94 region10_96 region10_98
        region10_00 region10_02 region10_04 region10_06 region10_08 region10_10 region10_12
        region10_14 region10_16 region10_16;


/*array  alco  {15}  alco86n  alco86n  alco90n  alco90n  alco94n  alco94n  alco98n  alco98n  alco02n  alco02n  alco06n  alco06n alco10n alco10n alco14n;
array alcc  {15}  alcc86   alcc88   alcc90   alcc92   alcc94   alcc96   alcc98   alcc00   alcc02   alcc04   alcc06   alcc08   alcc10   alcc10   alcc14;
array pam   {15}  th86c th88c th90c th92c th94c th96c th98c th00c th02c th04c th06c th08c th10c th12c th14c;
array aheim {15}  ahei86   ahei86   ahei90   ahei90   ahei94   ahei94   ahei98   ahei98   ahei02   ahei02   ahei06   ahei06 ahei10 ahei10 ahei10;
array antitc   {15}  hchtx86  hchtx88  hchtx90  hchtx92  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08  hchtx10  hchtx12  hchtx14;
array wt {15}  wt86  wt88  wt90  wt92  wt94  wt96  wt98  wt00  wt02  wt04  wt06  wt08  wt10  wt12  wt14;
array   renf   {15}  renf86  renf88  renf90  renf92  renf92  renf96  renf98  renf00   renal02   renal04   renal06 renf08   renal10   renal12   renal14; 
array   orhy   {15}  orhy86  orhy88  orhy90  orhy92  orhy94  orhy96  orhy98  orhy00   orhy02   orhy04   orhy04 ; 
array   repcabg   {15}  cabg86  cabg88  cabg90  cabg92  cabg94  cabg96  cabg98  cabg00   cabg02   cabg04   cabg06    cabg08 cabg10 cabg12 cabg14; 
array   ang   {15}  ang86  ang88  ang90  ang92  ang94  ang96  ang98  ang00   ang02   ang04   ang06 ang08 ang10 ang12 ang14; 
array antihp   {15}  htnrx86  htnrx88  htnrx90  htnrx92  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08  htnrx10  htnrx12  htnrx14;*/

/*Statin & chol*/
/*array   chollv {15}    serum88 serum88 serum90 serum90 serum94 serum94 serum94 serum94 serum04 serum04 serum04 serum08 serum08 serum08 serum08;
                                       
array calorqt  {15}  calor86nv   calor86nv   calor90nv   calor90nv   calor94nv   calor94nv   calor98nv   calor98nv   calor02nv   calor02nv   calor06nv   calor06nv  calor10nv  calor10nv  calor10nv;
array naheica  {15}  nAHEI86ca   nAHEI86ca   nAHEI90ca   nAHEI90ca   nAHEI94ca   nAHEI94ca   nAHEI98ca   nAHEI98ca   nAHEI02ca   nAHEI02ca   nAHEI06ca   nAHEI06ca  nAHEI10ca  nAHEI10ca  nAHEI10ca;
array naheinoalca {15}  nAHEI86_noalca nAHEI86_noalca nAHEI90_noalca nAHEI90_noalca nAHEI94_noalca nAHEI94_noalca nAHEI98_noalca nAHEI98_noalca nAHEI02_noalca nAHEI02_noalca nAHEI06_noalca nAHEI06_noalca nAHEI10_noalca nAHEI10_noalca nAHEI10_noalca;
array npdqsca  {15}  test386ca   test386ca   test390ca   test390ca   test394ca   test394ca   test398ca   test398ca   test302ca   test302ca   test306ca   test306ca  test310ca  test310ca  test310ca;

array tveggca  {15}  tveg86ca tveg86ca tveg90ca tveg90ca tveg94ca tveg94ca tveg98ca tveg98ca tveg02ca tveg02ca tveg06ca tveg06ca tveg10ca tveg10ca tveg10ca;
array fruitca  {15}  fruit86ca fruit86ca fruit90ca fruit90ca fruit94ca fruit94ca fruit98ca fruit98ca fruit02ca fruit02ca fruit06ca fruit06ca fruit10ca fruit10ca fruit10ca;
array whgrnca  {15}  whgrn86aca whgrn86aca whgrn90aca whgrn90aca whgrn94aca whgrn94aca whgrn98aca whgrn98aca whgrn02aca whgrn02aca whgrn06aca whgrn06aca whgrn10aca whgrn10aca whgrn10aca;
array ssbbbca  {15}  ssb86ca ssb86ca ssb90ca ssb90ca ssb94ca ssb94ca ssb98ca ssb98ca ssb02ca ssb02ca ssb06ca ssb06ca ssb10ca ssb10ca ssb10ca;
array nutttca  {15}  nut86ca nut86ca nut90ca nut90ca nut94ca nut94ca nut98ca nut98ca nut02ca nut02ca nut06ca nut06ca nut10ca nut10ca nut10ca;
array rmeatca  {15}  rmea86tca rmea86tca rmea90tca rmea90tca rmea94tca rmea94tca rmea98tca rmea98tca rmea02tca rmea02tca rmea06tca rmea06tca rmea10tca rmea10tca rmea10tca;
array transca  {15}  ptran86ca ptran86ca ptran90ca ptran90ca ptran94ca ptran94ca ptran98ca ptran98ca ptran02ca ptran02ca ptran06ca ptran06ca ptran10ca ptran10ca ptran10ca;
array omegaca  {15}  mgomg86ca mgomg86ca mgomg90ca mgomg90ca mgomg94ca mgomg94ca mgomg98ca mgomg98ca mgomg02ca mgomg02ca mgomg06ca mgomg06ca mgomg10ca mgomg10ca mgomg10ca;
array ppolyca  {15}  ppoly86ca ppoly86ca ppoly90ca ppoly90ca ppoly94ca ppoly94ca ppoly98ca ppoly98ca ppoly02ca ppoly02ca ppoly06ca ppoly06ca ppoly10ca ppoly10ca ppoly10ca;
array   naaaaca {15}    na86nca na86nca na90nca na90nca na94nca na94nca na98nca na98nca na02nca na02nca na06nca na06nca na10nca na10nca na10nca;
array   drinkca {15}    drinks86ca drinks86ca drinks90ca drinks90ca drinks94ca drinks94ca drinks98ca drinks98ca drinks02ca drinks02ca drinks06ca drinks06ca drinks10ca drinks10ca drinks10ca;
array   alconca {15}    alco86nca alco86nca alco90nca alco90nca alco94nca alco94nca alco98nca alco98nca alco02nca alco02nca alco06nca alco06nca alco10nca alco10nca alco10nca;

array   cruveca {15}    cru86ca cru86ca cru90ca cru90ca cru94ca cru94ca cru98ca cru98ca cru02ca cru02ca cru06ca cru06ca cru10ca cru10ca cru10ca;
array   lfvegca {15}    lfveg86ca lfveg86ca lfveg90ca lfveg90ca lfveg94ca lfveg94ca lfveg98ca lfveg98ca lfveg02ca lfveg02ca lfveg06ca lfveg06ca lfveg10ca lfveg10ca lfveg10ca;*/

   do i=1 to 18;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 18;
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

/*** Set cutoff at 2020.5 ***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1446;    /* nmw - cutoff 2016.5 */
   do i=1 to DIM(irt)-1;
      if (irt{i}<(990+24*i) | irt{i}>=(1014+24*i)) then irt{i}=990+24*i;
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

tpotatw = tpotatcav*7; 
bbmpotw = bbmpotcav*7; 
fpotatow = fpotatcav*7;
chipssw = chipsscav*7;
whgrnsw = whgrnscav*7/3;
rfgrnsw = rfgrnscav*7/3;
nstvegw = nstvegcav*7/3;  
stavegw = stavegcav*7/3;  
legumew = legumecav*7/3; 


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
	
      if aheinoptcav= . then aheinoptcav=39.3024;
      if aheinoptcav<39.3024 then aheinoptd = 0;
      else if aheinoptcav>=39.3024 then aheinoptd = 1;
      else aheinoptd = 0;
	

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



/*Chol level
      catchol=chollv{i};

      if catchol in (2,3) then catchol2=1;
      else if catchol in (4,5) then catchol2=2;
      else if catchol in (6,7) then catchol2=3;
      else if catchol in (8,9,10,11) then catchol2=4;
      else catchol2=9;

      if catchol2 in (2,3,4,5) then catchol3=0;
      else if catchol2 in (6,7,8,9,10,11) then catchol3=1;
      else catchol3=2;

      %indic3(vbl=catchol2, prefix=cholv, min=2, max=4, reflev=1, missing=9, usemiss=1,
                label1='<160',
                label2='160-200',
                label3='200-240',
                label4='>240');

      %indic3(vbl=catchol3, prefix=cholvdi, min=1, max=2, reflev=0, usemiss=0,
                label1='<200',
                label2='>200',
                label3='Missing');*/

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
   %exclude(0 lt dtdth le irt84);            /* Death before baseline*/
   %exclude(0 lt dtdxdiab le irt84);         /* Diagnoses diabetes before 1984 */
   %exclude(calor84n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor84n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor84n eq .);                 /* missing energy intake */
   %exclude(tpotat84d eq .);               /* missing potato intake */
   /*%exclude(ngdqscav eq .);
   %exclude(nhgdqscav eq .);
   %exclude(nugdqscav eq .);*/
   %exclude(age84    eq .);           /* missing age at 1984 */ 
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

keep id period agecon agegp agedi smkdi smkk chol84 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
 
     irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16 irt18 cutoff
     t84 t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16 t18 dtdth dtdxdiab
     tdead diabcase tdiabcase 
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib84n ceraf84n gid84n alco84n sat84n mon84n poly84n trans84n fol_84n prot84n
     white white2 &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
     actcon bmic alccon
     htn /*diabetes hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db84 chol84 hbp84 str84 hxcvd hxcan antihbp antihtc /*cvd86*/ cabg84
     age84 bmi84 alco84n calor84n /*actc84m*/ mifh cerafcav aofibcav smkever actcc th84 aspyn84 hormone aofibv
     
     /*Stratification variables*/
     age65 bmitr hxhbp dbfh82 smktr catrace2 actbi aheinoptd 

     lgaofibcav lgcerafcav lgcalorcav act86m hxchol hxdb ageyr cerafv bmia bmicon suppu carbov carbdenv carbocav carbdencav /*&catrace_*/ mlvit alcconsu &alccsu_ 
     tpotat84d bbmpot84d fpotat84d chipss84d prmeat84d urmeat84d trmeat84d poultr84d fishal84d hdairy84d ldairy84d /*soypro84d*/ nutsal84d legume84d fruits84d vegeal84d nstveg84d staveg84d tdairy84d nutleg84d bwrice84d wtrice84d SSB84d coffee84d 
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

proc freq data=two;tables hxdb hxhbp diabcase suppu smkc2 smkc3 smkc4 smkc5 white2 hormone2 hormone3 hormone4 catact2 catact3 catact4 catact5 dbfh82 antihbp antihtc alcc2 alcc3 alcc4 alcc5 alcc6 catsmkf;run;
proc univariate data=two; var actcon bmicon calorcav calorv alcov alcocav prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev
                              tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav whgrncav rfgrncav glcav gidcav
                              bwricecav wtricecav SSBcav coffeecav
                              aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav
                              income homeval pcollege phigh pnohigh pfamint singlefemale pkids polds pocchse perpov pwhite popden nSES;run;



%pctl9(
data=two,
varlist=whgrnsv whgrnscav aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav aheiv aheicav aheinoalv aheinoalcav,
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
      vegealcav vegealv nstvegcav stavegcav gidcav rfgrnscav SSBcav rfgrnsv tdairyv nutlegv tdairycav nutlegcav gidv aheinoptcav nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);

proc freq data=four;tables qnSES &qnSES_;run;


data five;
   set four end=_end_;

    if 0.000<=tpotatcav<=0.070 then ctpotatcav=0;        
      else if 0.070<tpotatcav<=0.143 then ctpotatcav=1;       
      else if 0.143<tpotatcav<=0.430 then ctpotatcav=2;         
      else if 0.430<tpotatcav<=0.790 then ctpotatcav=3;       
      else if 0.790<tpotatcav then ctpotatcav=4;                   
  %indic3(vbl=ctpotatcav, prefix=ctpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);  

      if fpotatcav=0.000 then cfpotatcav=0;                     
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         
      else if 0.430<fpotatcav then cfpotatcav=4;                
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                        
%indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);
run;


data pool_nhs;
	set five end=_end_;

	%indic3(vbl=bmitr,prefix=bmitr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=smktr,prefix=smktr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=catrace,prefix=indrace,min=1,max=3,reflev=0,missing=.,usemiss=1);

	keep id period diabcase tdiabcase t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18
			agecon irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18  cutoff
			dtdxdiab dtdth tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv catrace catrace2 &qcalorcav_ &smkc_ &alcc_ &catact_ &bmic9_ hormone mlvit dbfh82 antihbp antihtc hxhbp 
			&qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &ctpotatcav_ &cfpotatcav_ &cbbmpotcav_ &bmitr_ &smktr_ &indrace_ bmitr smktr white2 &qnSES_;
run;


data nhs;
	set pool_nhs;

	cohort = 1;
	gender = 0;
	id = 100000000+id;

	array orgt[*] t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18;
	array oirt[*] irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18;
	array time[*] time1	time2	time3	time4	time5	time6	time7	time8	time9	time10	time11	time12	time13	time14 time15 time16 time17 time18;
	array irtp[*] irtp1	irtp2	irtp3	irtp4	irtp5	irtp6	irtp7	irtp8	irtp9	irtp10	irtp11	irtp12	irtp13	irtp14 irtp15 irtp16 irtp17 irtp18;
	
	do i=1 to dim(orgt);
		time[i]=orgt[i];
		irtp[i]=oirt[i];
	end;


	keep id period diabcase tdiabcase time1	time2	time3	time4	time5	time6	time7	time8	time9	time10	time11	time12	time13	time14 time15 time16 time17 time18 cohort  gender
			agecon irtp1	irtp2	irtp3	irtp4	irtp5	irtp6	irtp7	irtp8	irtp9	irtp10	irtp11	irtp12	irtp13	irtp14 irtp15 irtp16 irtp17 irtp18 cutoff
			dtdxdiab dtdth tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv catrace catrace2 qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
			catact2 catact3 catact4 catact5 hormone mlvit dbfh82 antihbp antihtc hxhbp 
			qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4
			qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4 ctpotatcav1 ctpotatcav2 ctpotatcav3 ctpotatcav4 cfpotatcav1 cfpotatcav2 cfpotatcav3 cfpotatcav4 cbbmpotcav1 cbbmpotcav2 cbbmpotcav3
			qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qwhgrnscavm qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 bmitr1 bmitr2 smktr1 smktr2 bmitr smktr white2 indrace1 indrace2 indrace3 indracem qnSES1 qnSES2 qnSES3 qnSES4;
run;


/*NHS2*/
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
    if dtdxmi=. then dtdxmi=1091;

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
    if .<dtdxcabg<1116 then cabg91=1;
    else cabg91=0;
    keep id cabg91 dtdxcabg;
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
    if .<dtdxstr<1116 then str91=1;
    else str91=0;
    keep id str91 dtdxstr;
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
    if dtdxdiab=. then dtdxdiab=1091;

    keep id dtdxdiab probabil;

proc sort;by id;run;

/*proc univariate data=diab_case;var dtdxdiab;run;
proc freq data=diab_case;tables diabcase probabil diabcase*probabil;run;*/



/******exposure and covariates******/
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
%der8919 (keep= id birthday height89  
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

/*** physical activity ***/
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

%nur95(keep=wt95 mi95 db95 dbg95 hbp95 str95 ang95 chol95 cabg95              
            can95 brcn95 ocan95 bcc95 scc95 
            thiaz95 bprx95 hbptx95 cpreg95 preg95); 
            can95=0;
            if brcn95=1 or ocan95=1 or bcc95=1 or scc95=1 then can95=1;
            if thiaz95=1 or  bprx95=1 then hbptx95=1; else hbptx95=0; 
            if wt95 = 0 then wt95=.;
 
%nur97(keep=wt97 sittv97 mi97 db97 hbp97 str97 chol97
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

%supp8915(keep=id mvitu89   mvitu91    mvitu93   mvitu95   mvitu97   mvitu99   mvitu01   mvitu03   mvitu05    mvitu07    mvitu09   mvitu11  mvitu13  mvitu15
                viteu91    viteu93   viteu95   viteu97   viteu99   viteu01   viteu03   viteu05    viteu07    viteu09   viteu11  viteu13  viteu15);
proc sort;by id;run;

/*******************************************************************

Main Exposures - nSES - pull in all Census years for all addresses

Note: Use %nses8913(keep= ); if you want to select date only on 
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
          der8919 (in=mstr) act8917 nur89 nur91 nur93 nur95 nur97 nur99 nur01 nur03 nur05 nur07 nur09
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

proc sort data=baseline0; by id; run;


data one;
   set baseline0 end=_end_;

if hbp89 = 1 or hbp91 = 1 then hxhbp=1; else hxhbp = 0;
if chol89 = 1 or chol91 = 1 then hxchol=1; else hxchol = 0;
if db89 = 1 or db91 = 1 then hxdb = 1; else hxdb = 0;
if mi89 = 1 or mi91 = 1 or ang91=1 or str89 = 1 or str91 = 1 or cabg91=1 then hxcvd = 1; else hxcvd = 0;
if can89 = 1 or can91 = 1 then hxcan = 1; else hxcan = 0;
 
array nocum91 {*}  aofib91n ceraf91n alco91n calor91n trnss91n sat91n mon91n poly91n gid91n fol91n prot91n carbo91n carbden91n protden91n transden91n satden91n polyden91n monden91n tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d whgrn91n rfgrn91n whgrns91d rfgrns91d gl91n ahei91 aheinoal91 aheinopt91 aheifisha91 aheidairy91 aheinutbl91 aheipoult91 aheineggs91;  
array nocum95 {*}  aofib95n ceraf95n alco95n calor95n trnss95n sat95n mon95n poly95n gid95n fol95n prot95n carbo95n carbden95n protden95n transden95n satden95n polyden95n monden95n tpotat95d bbmpot95d fpotat95d chipss95d prmeat95d urmeat95d trmeat95d poultr95d fishal95d regegg95d hdairy95d ldairy95d /*soypro95d*/ nutsal95d legume95d fruits95d vegeal95d nstveg95d staveg95d tdairy95d coffee95d nutleg95d bwrice95d wtrice95d SSB95d  whgrn95n rfgrn95n whgrns95d rfgrns95d gl95n ahei95 aheinoal95 aheinopt95 aheifisha95 aheidairy95 aheinutbl95 aheipoult95 aheineggs95;  
array nocum99 {*}  aofib99n ceraf99n alco99n calor99n trn0099n sat99n mon99n poly99n gid99n fol9899n prot99n carbo99n carbden99n protden99n transden99n satden99n polyden99n monden99n tpotat99d bbmpot99d fpotat99d chipss99d prmeat99d urmeat99d trmeat99d poultr99d fishal99d regegg99d hdairy99d ldairy99d /*soypro99d*/ nutsal99d legume99d fruits99d vegeal99d nstveg99d staveg99d tdairy99d coffee99d nutleg99d bwrice99d wtrice99d SSB99d  whgrn99n rfgrn99n whgrns99d rfgrns99d gl99n ahei99 aheinoal99 aheinopt99 aheifisha99 aheidairy99 aheinutbl99 aheipoult99 aheineggs99;  
array nocum03 {*}  aofib03n ceraf03n alco03n calor03n trn0203n sat03n mon03n poly03n gid03n fol9803n prot03n carbo03n carbden03n protden03n transden03n satden03n polyden03n monden03n tpotat03d bbmpot03d fpotat03d chipss03d prmeat03d urmeat03d trmeat03d poultr03d fishal03d regegg03d hdairy03d ldairy03d /*soypro03d*/ nutsal03d legume03d fruits03d vegeal03d nstveg03d staveg03d tdairy03d coffee03d nutleg03d bwrice03d wtrice03d SSB03d whgrn03n rfgrn03n whgrns03d rfgrns03d gl03n ahei03 aheinoal03 aheinopt03 aheifisha03 aheidairy03 aheinutbl03 aheipoult03 aheineggs03;  
array nocum07 {*}  aofib07n ceraf07n alco07n calor07n trn0707n sat07n mon07n poly07n gid07n fol9807n prot07n carbo07n carbden07n protden07n transden07n satden07n polyden07n monden07n tpotat07d bbmpot07d fpotat07d chipss07d prmeat07d urmeat07d trmeat07d poultr07d fishal07d regegg07d hdairy07d ldairy07d /*soypro07d*/ nutsal07d legume07d fruits07d vegeal07d nstveg07d staveg07d tdairy07d coffee07d nutleg07d bwrice07d wtrice07d SSB07d whgrn07n rfgrn07n whgrns07d rfgrns07d gl07n ahei07 aheinoal07 aheinopt07 aheifisha07 aheidairy07 aheinutbl07 aheipoult07 aheineggs07;  
array nocum11 {*}  aofib11n ceraf11n alco11n calor11n trn1111n sat11n mon11n poly11n gid11n fol9811n prot11n carbo11n carbden11n protden11n transden11n satden11n polyden11n monden11n tpotat11d bbmpot11d fpotat11d chipss11d prmeat11d urmeat11d trmeat11d poultr11d fishal11d regegg11d hdairy11d ldairy11d /*soypro11d*/ nutsal11d legume11d fruits11d vegeal11d nstveg11d staveg11d tdairy11d coffee11d nutleg11d bwrice11d wtrice11d SSB11d whgrn11n rfgrn11n whgrns11d rfgrns11d gl11n ahei11 aheinoal11 aheinopt11 aheifisha11 aheidairy11 aheinutbl11 aheipoult11 aheineggs11;
array nocum15 {*}  aofib15n ceraf15n alco15n calor15n trn1115n sat15n mon15n poly15n gid15n fol9815n prot15n carbo15n carbden15n protden15n transden15n satden15n polyden15n monden15n tpotat15d bbmpot15d fpotat15d chipss15d prmeat15d urmeat15d trmeat15d poultr15d fishal15d regegg15d hdairy15d ldairy15d /*soypro15d*/ nutsal15d legume15d fruits15d vegeal15d nstveg15d staveg15d tdairy15d coffee15d nutleg15d bwrice15d wtrice15d SSB15d whgrn15n rfgrn15n whgrns15d rfgrns15d gl15n ahei15 aheinoal15 aheinopt15 aheifisha15 aheidairy15 aheinutbl15 aheipoult15 aheineggs15;
array nocum19 {*}  aofib19n ceraf19n alco19n calor19n trn1119n sat19n mon19n poly19n gid19n fol9819n prot19n carbo19n carbden19n protden19n transden19n satden19n polyden19n monden19n tpotat19d bbmpot19d fpotat19d chipss19d prmeat19d urmeat19d trmeat19d poultr19d fishal19d regegg19d hdairy19d ldairy19d /*soypro19d*/ nutsal19d legume19d fruits19d vegeal19d nstveg19d staveg19d tdairy19d coffee19d nutleg19d bwrice19d wtrice19d SSB19d whgrn19n rfgrn19n whgrns19d rfgrns19d gl19n ahei19 aheinoal19 aheinopt19 aheifisha19 aheidairy19 aheinutbl19 aheipoult19 aheineggs19;

array cumul91 {*}  aofib91ca ceraf91ca alco91ca calor91ca trnss91ca sat91ca mon91ca poly91ca gid91ca fol91ca prot91ca carbo91ca carbden91ca protden91ca transden91ca satden91ca polyden91ca monden91ca tpotat91ca bbmpot91ca fpotat91ca chipss91ca prmeat91ca urmeat91ca trmeat91ca poultr91ca fishal91ca regegg91ca hdairy91ca ldairy91ca /*soypro91ca*/ nutsal91ca legume91ca fruits91ca vegeal91ca nstveg91ca staveg91ca tdairy91ca coffee91ca nutleg91ca bwrice91ca wtrice91ca SSB91ca whgrn91ca rfgrn91ca whgrns91ca rfgrns91ca gl91ca ahei91ca aheinoal91ca aheinopt91ca aheifisha91ca aheidairy91ca aheinutbl91ca aheipoult91ca aheineggs91ca; 
array cumul95 {*}  aofib95ca ceraf95ca alco95ca calor95ca trnss95ca sat95ca mon95ca poly95ca gid95ca fol95ca prot95ca carbo95ca carbden95ca protden95ca transden95ca satden95ca polyden95ca monden95ca tpotat95ca bbmpot95ca fpotat95ca chipss95ca prmeat95ca urmeat95ca trmeat95ca poultr95ca fishal95ca regegg95ca hdairy95ca ldairy95ca /*soypro95ca*/ nutsal95ca legume95ca fruits95ca vegeal95ca nstveg95ca staveg95ca tdairy95ca coffee95ca nutleg95ca bwrice95ca wtrice95ca SSB95ca whgrn95ca rfgrn95ca whgrns95ca rfgrns95ca gl95ca ahei95ca aheinoal95ca aheinopt95ca aheifisha95ca aheidairy95ca aheinutbl95ca aheipoult95ca aheineggs95ca;  
array cumul99 {*}  aofib99ca ceraf99ca alco99ca calor99ca trn0099ca sat99ca mon99ca poly99ca gid99ca fol9899ca prot99ca carbo99ca carbden99ca protden99ca transden99ca satden99ca polyden99ca monden99ca tpotat99ca bbmpot99ca fpotat99ca chipss99ca prmeat99ca urmeat99ca trmeat99ca poultr99ca fishal99ca regegg99ca hdairy99ca ldairy99ca /*soypro99ca*/ nutsal99ca legume99ca fruits99ca vegeal99ca nstveg99ca staveg99ca tdairy99ca coffee99ca nutleg99ca bwrice99ca wtrice99ca SSB99ca whgrn99ca rfgrn99ca whgrns99ca rfgrns99ca gl99ca ahei99ca aheinoal99ca aheinopt99ca aheifisha99ca aheidairy99ca aheinutbl99ca aheipoult99ca aheineggs99ca;   
array cumul03 {*}  aofib03ca ceraf03ca alco03ca calor03ca trn0203ca sat03ca mon03ca poly03ca gid03ca fol9803ca prot03ca carbo03ca carbden03ca protden03ca transden03ca satden03ca polyden03ca monden03ca tpotat03ca bbmpot03ca fpotat03ca chipss03ca prmeat03ca urmeat03ca trmeat03ca poultr03ca fishal03ca regegg03ca hdairy03ca ldairy03ca /*soypro03ca*/ nutsal03ca legume03ca fruits03ca vegeal03ca nstveg03ca staveg03ca tdairy03ca coffee03ca nutleg03ca bwrice03ca wtrice03ca SSB03ca whgrn03ca rfgrn03ca whgrns03ca rfgrns03ca gl03ca ahei03ca aheinoal03ca aheinopt03ca aheifisha03ca aheidairy03ca aheinutbl03ca aheipoult03ca aheineggs03ca;  
array cumul07 {*}  aofib07ca ceraf07ca alco07ca calor07ca trn0707ca sat07ca mon07ca poly07ca gid07ca fol9807ca prot07ca carbo07ca carbden07ca protden07ca transden07ca satden07ca polyden07ca monden07ca tpotat07ca bbmpot07ca fpotat07ca chipss07ca prmeat07ca urmeat07ca trmeat07ca poultr07ca fishal07ca regegg07ca hdairy07ca ldairy07ca /*soypro07ca*/ nutsal07ca legume07ca fruits07ca vegeal07ca nstveg07ca staveg07ca tdairy07ca coffee07ca nutleg07ca bwrice07ca wtrice07ca SSB07ca whgrn07ca rfgrn07ca whgrns07ca rfgrns07ca gl07ca ahei07ca aheinoal07ca aheinopt07ca aheifisha07ca aheidairy07ca aheinutbl07ca aheipoult07ca aheineggs07ca;  
array cumul11 {*}  aofib11ca ceraf11ca alco11ca calor11ca trn1111ca sat11ca mon11ca poly11ca gid11ca fol9811ca prot11ca carbo11ca carbden11ca protden11ca transden11ca satden11ca polyden11ca monden11ca tpotat11ca bbmpot11ca fpotat11ca chipss11ca prmeat11ca urmeat11ca trmeat11ca poultr11ca fishal11ca regegg11ca hdairy11ca ldairy11ca /*soypro11ca*/ nutsal11ca legume11ca fruits11ca vegeal11ca nstveg11ca staveg11ca tdairy11ca coffee11ca nutleg11ca bwrice11ca wtrice11ca SSB11ca whgrn11ca rfgrn11ca whgrns11ca rfgrns11ca gl11ca ahei11ca aheinoal11ca aheinopt11ca aheifisha11ca aheidairy11ca aheinutbl11ca aheipoult11ca aheineggs11ca;
array cumul15 {*}  aofib15ca ceraf15ca alco15ca calor15ca trn1115ca sat15ca mon15ca poly15ca gid15ca fol9815ca prot15ca carbo15ca carbden15ca protden15ca transden15ca satden15ca polyden15ca monden15ca tpotat15ca bbmpot15ca fpotat15ca chipss15ca prmeat15ca urmeat15ca trmeat15ca poultr15ca fishal15ca regegg15ca hdairy15ca ldairy15ca /*soypro15ca*/ nutsal15ca legume15ca fruits15ca vegeal15ca nstveg15ca staveg15ca tdairy15ca coffee15ca nutleg15ca bwrice15ca wtrice15ca SSB15ca whgrn15ca rfgrn15ca whgrns15ca rfgrns15ca gl15ca ahei13ca aheinoal15ca aheinopt15ca aheifisha15ca aheidairy15ca aheinutbl15ca aheipoult15ca aheineggs15ca;
array cumul19 {*}  aofib19ca ceraf19ca alco19ca calor19ca trn1119ca sat19ca mon19ca poly19ca gid19ca fol9819ca prot19ca carbo19ca carbden19ca protden19ca transden19ca satden19ca polyden19ca monden19ca tpotat19ca bbmpot19ca fpotat19ca chipss19ca prmeat19ca urmeat19ca trmeat19ca poultr19ca fishal19ca regegg19ca hdairy19ca ldairy19ca /*soypro19ca*/ nutsal19ca legume19ca fruits19ca vegeal19ca nstveg19ca staveg19ca tdairy19ca coffee19ca nutleg19ca bwrice19ca wtrice19ca SSB19ca whgrn19ca rfgrn19ca whgrns19ca rfgrns19ca gl19ca ahei19ca aheinoal19ca aheinopt19ca aheifisha19ca aheidairy19ca aheinutbl19ca aheipoult19ca aheineggs19ca;


do i = 1 to DIM(nocum91);
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

array irt   {16}  retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15  retmo17  retmo19  cutoff;
array perioda  {15}  period1  period2  period3  period4  period5  period6  period7  period8  period9  period10  period11  period12  period13 period14 period15;
array tvar  {15}  t91  t93  t95  t97  t99  t01  t03  t05   t07   t09   t11   t13   t15  t17   t19;
array age   {15}  age91     age93    age95    age97    age99    age01   age03    age05     age07     age09    age11  age13  age15 age17 age19;
array aspyn {15}  asp91 asp93 asp95 asp97 asp99 asp01 asp03 asp05 asp07 asp09 asp11 asp13 asp15 asp17 asp17;
array hbp   {15}  hbp91  hbp93   hbp95   hbp97  hbp99  hbp01 hbp03 hbp05 hbp07 hbp09 hbp11 hbp13 hbp15 hbp17 hbp19; 
array chol  {15}  chol91  chol93   chol95   chol97  chol99  chol01  chol03 chol05 chol07 chol09 chol11 chol13 chol15 chol17 chol19;
array db    {15}  db91  db93   db95   db97  db99  db01  db03 db05 db07 db09 db11 db13 db15 db17 db19;
array nsmk  {15}  smkdr91   smkdr93  smkdr95  smkdr97  smkdr99  smkdr01  smkdr03  smkdr05   smkdr07   smkdr09  smkdr11  smkdr13  smkdr15 smkdr17 smkdr17;
array bmi   {15}  bmi91     bmi93    bmi95    bmi97    bmi99    bmi01  bmi03    bmi05     bmi07     bmi09    bmi11   bmi13  bmi15 bmi17  bmi17;
array actm  {15}  act91m act91m act91m act97m act97m act01m act01m act05m act05m act09m act09m act13m act13m act17m act17m;
array horm  {15}  nhor91    nhor93   nhor95   nhor97   nhor99   nhor01  nhor03   nhor05    nhor07    nhor09   nhor11  nhor13  nhor15 nhor17 nhor17;
array mvit  {15}  mvitu91    mvitu93   mvitu95   mvitu97   mvitu99   mvitu01  mvitu03   mvitu05    mvitu07    mvitu09   mvitu11  mvitu13  mvitu15 mvitu15 mvitu15;
array antihp   {15}  hbptx89 hbptx93 hbptx95 hbptx97 hbptx99 hbptx01 hbptx03 hbptx05 hbptx07 hbptx09 hbptx11 hbptx13 hbptx15 hbptx17 hbptx19;
array antitc   {15}  hchtx93 hchtx93 hchtx95 hchtx97 hchtx99 hchtx01 hchtx03 hchtx05 hchtx07 hchtx09 hchtx11 hchtx13 hchtx15 hchtx17 hchtx19;

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
array transfca  {15}  trnss91ca trnss91ca trnss95ca trnss95ca trn0099ca trn0099ca trn0203ca trn0203ca trn0707ca trn0707ca trn1111ca trn1111ca trn1115ca trn1115ca trn1119ca;
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
array transf  {15}  trnss91n trnss91n trnss95n trnss95n trn0099n trn0099n trn0203n trn0203n trn0707n trn0707n trn1111n trn1111n trn1115n trn1115n trn1119n;
array transfden  {15}  transden91n transden91n transden95n transden95n transden99n transden99n transden03n transden03n transden07n transden07n transden11n transden11n transden15n transden15n transden19n;
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
array alone {15} alone93 alone93 alone93 alone93 alone93 alone01 alone01 alone05
                  alone05 alone09 alone09 alone13 alone13 alone17 alone19;
array married {15} mar89 marry93 marry93 marry93 marry93 marry01 marry01 marry05
                    marry05 marry09 marry09 marry13 marry13 marry17 marry19;


/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/


   array inc {15} mdinc90_91 mdinc90_93 mdinc00_95 mdinc00_97 mdinc00_99 mdinc00_01
        mdinc00_03 mdinc10_05 mdinc10_07 mdinc10_09 mdinc10_11 mdinc10_13 mdinc10_15 mdinc10_17 mdinc10_17; 
   array vhs {15} mdvhs90_91 mdvhs90_93 mdvhs00_95 mdvhs00_97 mdvhs00_99 mdvhs00_01
        mdvhs00_03 mdvhs10_05 mdvhs10_07 mdvhs10_09 mdvhs10_11 mdvhs10_13 mdvhs10_15 mdvhs10_17 mdvhs10_17; 
   array pcoll {15} pcolled90_91 pcolled90_93 pcolled00_95 pcolled00_97
          pcolled00_99 pcolled00_01 pcolled00_03 pcolled10_05 pcolled10_07 pcolled10_09
          pcolled10_11 pcolled10_13 pcolled10_15 pcolled10_17 pcolled10_17;
   array phs {15} phs90_91 phs90_93 phs00_95 phs00_97 phs00_99 phs00_01 phs00_03 phs10_05
        phs10_07 phs10_09 phs10_11 phs10_13 phs10_15 phs10_17 phs10_17;
   array pnohs {15} pnohs90_91 pnohs90_93 pnohs00_95 pnohs00_97 pnohs00_99 pnohs00_01 pnohs00_03 pnohs10_05
        pnohs10_07 pnohs10_09 pnohs10_11 pnohs10_13 pnohs10_15 pnohs10_17 pnohs10_17;
   array pfint {15} pfaminterest90_91 pfaminterest90_93 pfaminterest00_95
          pfaminterest00_97 pfaminterest00_99 pfaminterest00_01 pfaminterest00_03 pfaminterest10_05
          pfaminterest10_07 pfaminterest10_09 pfaminterest10_11 pfaminterest10_13 pfaminterest10_15 pfaminterest10_17 pfaminterest10_19;
   array sfemale {15} pfwchbf90_91 pfwchbf90_93 pfwchbf00_95 pfwchbf00_97 pfwchbf00_99
            pfwchbf00_01 pfwchbf00_03 pfwchbf10_05 pfwchbf10_07 pfwchbf10_09 pfwchbf10_11 pfwchbf10_13 pfwchbf10_15 pfwchbf10_17 pfwchbf10_17;
   array pkid {15} pkid90_91 pkid90_93 pkid00_95 pkid00_97 pkid00_99 pkid00_01 pkid00_03 pkid10_05
         pkid10_07 pkid10_09 pkid10_11 pkid10_13 pkid10_15 pkid10_17 pkid10_17;
   array pold {15} pold90_91 pold90_93 pold00_95 pold00_97 pold00_99 pold00_01 pold00_03 pold10_05
         pold10_07 pold10_09 pold10_11 pold10_13 pold10_15 pold10_17 pold10_17;
   array pohse {15} pohse90_91 pohse90_93 pohse00_95 pohse00_97 pohse00_99 pohse00_01 pohse00_03
          pohse10_05 pohse10_07 pohse10_09 pohse10_11 pohse10_13 pohse10_15 pohse10_17 pohse10_17;
   array ppov {15} ppov90_91 ppov90_93 ppov00_95 ppov00_97 ppov00_99 ppov00_01 ppov00_03
         ppov10_05 ppov10_07 ppov10_09 ppov10_11 ppov10_13 ppov10_15 ppov10_17 ppov10_17;
   array pw {15}   pwht90_91 pwht90_93 pwht00_95 pwht00_97 pwht00_99 pwht00_01 pwht00_03
         pwht10_05 pwht10_07 pwht10_09 pwht10_11 pwht10_13 pwht10_15 pwht10_17 pwht10_17;

   array popd {15} popd90_91 popd90_93 popd00_95 popd00_97 popd00_99 popd00_01 popd00_03
              popd10_05 popd10_07 popd10_09 popd10_11 popd10_13 popd10_15 popd10_17 popd10_17; 
   array div {15} division10_91 division10_93 division10_95 division10_97
        division10_99 division10_01 division10_03 division10_05 division10_07 division10_09
        division10_11 division10_13 division10_15 division10_17 division10_17;
   array reg {15} region10_91 region10_93 region10_95 region10_97 region10_99
        region10_01 region10_03 region10_05 region10_07 region10_09 region10_11 region10_13 region10_15 region10_17 region10_17;


/*array  alco  {15}  alco86n  alco86n  alco90n  alco90n  alco94n  alco94n  alco98n  alco98n  alco02n  alco02n  alco06n  alco06n alco10n alco10n alco14n;
array alcc  {15}  alcc86   alcc88   alcc90   alcc92   alcc94   alcc96   alcc98   alcc00   alcc02   alcc04   alcc06   alcc08   alcc10   alcc10   alcc14;
array pam   {15}  th86c th88c th90c th92c th94c th96c th98c th00c th02c th04c th06c th08c th10c th12c th14c;
array aheim {15}  ahei86   ahei86   ahei90   ahei90   ahei94   ahei94   ahei98   ahei98   ahei02   ahei02   ahei06   ahei06 ahei10 ahei10 ahei10;
array antitc   {15}  hchtx86  hchtx88  hchtx90  hchtx92  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08  hchtx10  hchtx12  hchtx14;
array wt {15}  wt86  wt88  wt90  wt92  wt94  wt96  wt98  wt00  wt02  wt04  wt06  wt08  wt10  wt12  wt14;
array   renf   {15}  renf86  renf88  renf90  renf92  renf92  renf96  renf98  renf00   renal02   renal04   renal06 renf08   renal10   renal12   renal14; 
array   orhy   {15}  orhy86  orhy88  orhy90  orhy92  orhy94  orhy96  orhy98  orhy00   orhy02   orhy04   orhy04 ; 
array   repcabg   {15}  cabg86  cabg88  cabg90  cabg92  cabg94  cabg96  cabg98  cabg00   cabg02   cabg04   cabg06    cabg08 cabg10 cabg12 cabg14; 
array   ang   {15}  ang86  ang88  ang90  ang92  ang94  ang96  ang98  ang00   ang02   ang04   ang06 ang08 ang10 ang12 ang14; 
array antihp   {15}  htnrx86  htnrx88  htnrx90  htnrx92  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08  htnrx10  htnrx12  htnrx14;*/

/*Statin & chol*/
/*array   chollv {15}    serum88 serum88 serum90 serum90 serum94 serum94 serum94 serum94 serum04 serum04 serum04 serum08 serum08 serum08 serum08;
                                       
array calorqt  {15}  calor86nv   calor86nv   calor90nv   calor90nv   calor94nv   calor94nv   calor98nv   calor98nv   calor02nv   calor02nv   calor06nv   calor06nv  calor10nv  calor10nv  calor10nv;
array naheica  {15}  nAHEI86ca   nAHEI86ca   nAHEI90ca   nAHEI90ca   nAHEI94ca   nAHEI94ca   nAHEI98ca   nAHEI98ca   nAHEI02ca   nAHEI02ca   nAHEI06ca   nAHEI06ca  nAHEI10ca  nAHEI10ca  nAHEI10ca;
array naheinoalca {15}  nAHEI86_noalca nAHEI86_noalca nAHEI90_noalca nAHEI90_noalca nAHEI94_noalca nAHEI94_noalca nAHEI98_noalca nAHEI98_noalca nAHEI02_noalca nAHEI02_noalca nAHEI06_noalca nAHEI06_noalca nAHEI10_noalca nAHEI10_noalca nAHEI10_noalca;
array npdqsca  {15}  test386ca   test386ca   test390ca   test390ca   test394ca   test394ca   test398ca   test398ca   test302ca   test302ca   test306ca   test306ca  test310ca  test310ca  test310ca;

array tveggca  {15}  tveg86ca tveg86ca tveg90ca tveg90ca tveg94ca tveg94ca tveg98ca tveg98ca tveg02ca tveg02ca tveg06ca tveg06ca tveg10ca tveg10ca tveg10ca;
array fruitca  {15}  fruit86ca fruit86ca fruit90ca fruit90ca fruit94ca fruit94ca fruit98ca fruit98ca fruit02ca fruit02ca fruit06ca fruit06ca fruit10ca fruit10ca fruit10ca;
array whgrnca  {15}  whgrn86aca whgrn86aca whgrn90aca whgrn90aca whgrn94aca whgrn94aca whgrn98aca whgrn98aca whgrn02aca whgrn02aca whgrn06aca whgrn06aca whgrn10aca whgrn10aca whgrn10aca;
array ssbbbca  {15}  ssb86ca ssb86ca ssb90ca ssb90ca ssb94ca ssb94ca ssb98ca ssb98ca ssb02ca ssb02ca ssb06ca ssb06ca ssb10ca ssb10ca ssb10ca;
array nutttca  {15}  nut86ca nut86ca nut90ca nut90ca nut94ca nut94ca nut98ca nut98ca nut02ca nut02ca nut06ca nut06ca nut10ca nut10ca nut10ca;
array rmeatca  {15}  rmea86tca rmea86tca rmea90tca rmea90tca rmea94tca rmea94tca rmea98tca rmea98tca rmea02tca rmea02tca rmea06tca rmea06tca rmea10tca rmea10tca rmea10tca;
array transca  {15}  ptran86ca ptran86ca ptran90ca ptran90ca ptran94ca ptran94ca ptran98ca ptran98ca ptran02ca ptran02ca ptran06ca ptran06ca ptran10ca ptran10ca ptran10ca;
array omegaca  {15}  mgomg86ca mgomg86ca mgomg90ca mgomg90ca mgomg94ca mgomg94ca mgomg98ca mgomg98ca mgomg02ca mgomg02ca mgomg06ca mgomg06ca mgomg10ca mgomg10ca mgomg10ca;
array ppolyca  {15}  ppoly86ca ppoly86ca ppoly90ca ppoly90ca ppoly94ca ppoly94ca ppoly98ca ppoly98ca ppoly02ca ppoly02ca ppoly06ca ppoly06ca ppoly10ca ppoly10ca ppoly10ca;
array   naaaaca {15}    na86nca na86nca na90nca na90nca na94nca na94nca na98nca na98nca na02nca na02nca na06nca na06nca na10nca na10nca na10nca;
array   drinkca {15}    drinks86ca drinks86ca drinks90ca drinks90ca drinks94ca drinks94ca drinks98ca drinks98ca drinks02ca drinks02ca drinks06ca drinks06ca drinks10ca drinks10ca drinks10ca;
array   alconca {15}    alco86nca alco86nca alco90nca alco90nca alco94nca alco94nca alco98nca alco98nca alco02nca alco02nca alco06nca alco06nca alco10nca alco10nca alco10nca;

array   cruveca {15}    cru86ca cru86ca cru90ca cru90ca cru94ca cru94ca cru98ca cru98ca cru02ca cru02ca cru06ca cru06ca cru10ca cru10ca cru10ca;
array   lfvegca {15}    lfveg86ca lfveg86ca lfveg90ca lfveg90ca lfveg94ca lfveg94ca lfveg98ca lfveg98ca lfveg02ca lfveg02ca lfveg06ca lfveg06ca lfveg10ca lfveg10ca lfveg10ca;*/

   do i=1 to 15;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 15;
      if actm{b}=. then actm{b}=actm{b-1};  
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
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
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

/*** Set cutoff at 2021.5***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1458;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1074+24*i) | irt{i}>=(1098+24*i)) then irt{i}=1074+24*i;
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

tpotatw = tpotatcav*7; 
bbmpotw = bbmpotcav*7; 
fpotatow = fpotatcav*7;
chipssw = chipsscav*7;
whgrnsw = whgrnscav*7/3;
rfgrnsw = rfgrnscav*7/3;
nstvegw = nstvegcav*7/3;  
stavegw = stavegcav*7/3;  
legumew = legumecav*7/3;


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

      if aheinoptcav= . then aheinoptcav=39.0070;
      if aheinoptcav<39.0070 then aheinoptd = 0;
      else if aheinoptcav>=39.0070 then aheinoptd = 1;
      else aheinoptd = 0;
	
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


/*Chol level
      catchol=chollv{i};

      if catchol in (2,3) then catchol2=1;
      else if catchol in (4,5) then catchol2=2;
      else if catchol in (6,7) then catchol2=3;
      else if catchol in (8,9,10,11) then catchol2=4;
      else catchol2=9;

      if catchol2 in (2,3,4,5) then catchol3=0;
      else if catchol2 in (6,7,8,9,10,11) then catchol3=1;
      else catchol3=2;

      %indic3(vbl=catchol2, prefix=cholv, min=2, max=4, reflev=1, missing=9, usemiss=1,
                label1='<160',
                label2='160-200',
                label3='200-240',
                label4='>240');

      %indic3(vbl=catchol3, prefix=cholvdi, min=1, max=2, reflev=0, usemiss=0,
                label1='<200',
                label2='>200',
                label3='Missing');*/

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
   %exclude(0 lt dtdth le retmo91);          /* Death before baseline */
   %exclude(0 lt dtdxdiab le retmo91);      /* Diagnoses diabetes before 1991 */
   %exclude(calor91n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor91n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor91n eq .);                 /* missing energy intake */
   %exclude(tpotat91d eq .);               /* missing potato intake */
   %exclude(age91    eq .);               /* missing age at 1991 */ 
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

keep id period agecon agegp agedi smkdi smkk chol91 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew 
     retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17 retmo19 cutoff
     t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17 t19  dtdth dtdxdiab
     tdead diabcase tdiabcase 
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib91n ceraf91n gid91n alco91n sat91n mon91n poly91n trnss91n fol91n prot91n
     white &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
    actcon bmic alccon
     htn diabetes /*hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db91 chol91 hbp91 str91 hxcvd hxcan antihbp antihtc /*cvd86*/
     age91 bmi91 alco91n calor91n act91m mifh cerafcav aofibcav smkever actcc act91m asp91 mvitu91 hormone aofibv
     
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

proc univariate data=two;var bmicon actcon agecon calorcav gidcav tpotatcav bbmpotcav fpotatcav chipsscav trmeatcav prmeatcav urmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav bwricecav wtricecav SSBcav coffeecav 
                           gidv tpotatv bbmpotv fpotatv chipssv trmeatv prmeatv urmeatv poultrv fishalv regeggv hdairyv ldairyv nutsalv legumev fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev 
                           tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav nSES;run;
proc freq data=two;tables white &smkc_ &alcc_ &catact_ &hormone_ mlvit age65 actbi aheinoptd bmitr dbfh antihbp antihtc hxhbp catsmkf;run;


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


      if fpotatcav=0.000 then cfpotatcav=0;                     
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         
      else if 0.430<fpotatcav then cfpotatcav=4;                
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                        
%indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);
run;



data pool_nhs2;
	set five end=_end_;

	%indic3(vbl=bmitr,prefix=bmitr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=smktr,prefix=smktr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=catrace,prefix=indrace,min=1,max=3,reflev=0,missing=.,usemiss=1);

	keep id period agecon catrace catrace2 diabcase tdiabcase t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17 t19 
			retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19
			cutoff dtdxdiab dtdth tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv &qcalorcav_ &smkc_ &alcc_ &catact_ &bmic9_ hormone mlvit dbfh antihbp antihtc hxhbp 
			&qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &ctpotatcav_ &cfpotatcav_ &cbbmpotcav_ &bmitr_ &smktr_ &indrace_ bmitr smktr white &qnSES_;
run;


data nhs2;
	set pool_nhs2;
	length qwhgrnscavm 3 ;

	cohort = 2;
	gender = 0;
	id = 100000000+id;

	array orgt[*] t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17 t19;
	array oirt[*] retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19;
	array time[*] time1	time2	time3	time4	time5	time6	time7	time8	time9	time10	time11	time12	time13 time14 time15;
	array irtp[*] irtp1	irtp2	irtp3	irtp4	irtp5	irtp6	irtp7	irtp8	irtp9	irtp10	irtp11	irtp12	irtp13 irtp14 irtp15;

	do i=1 to dim(orgt);
		time[i]=orgt[i];
		irtp[i]=oirt[i];
	end;

	dbfh82 = dbfh;
	qwhgrnscavm = 0;
	white2 = white;

	keep id period agecon catrace catrace2 diabcase tdiabcase time1	time2	time3	time4	time5	time6	time7	time8	time9	time10	time11	time12	time13 time14 time15 cohort  gender
			irtp1	irtp2	irtp3	irtp4	irtp5	irtp6	irtp7	irtp8	irtp9	irtp10	irtp11	irtp12	irtp13 irtp14 irtp15
			cutoff dtdxdiab dtdth tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
			catact2 catact3 catact4 catact5 hormone mlvit dbfh82 antihbp antihtc hxhbp qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4
			qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4 ctpotatcav1 ctpotatcav2 ctpotatcav3 ctpotatcav4 cfpotatcav1 cfpotatcav2 cfpotatcav3 cfpotatcav4 cbbmpotcav1 cbbmpotcav2 cbbmpotcav3
			qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qwhgrnscavm qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 bmitr1 bmitr2 smktr1 smktr2 bmitr smktr white2 indrace1 indrace2 indrace3 indracem qnSES1 qnSES2 qnSES3 qnSES4;
run;



/*HPFS*/

/*Death*/
%hp_dead (keep= mmdth yydth icda newicda dtdth );
   
   if 0<=yydth<50 then yydth=yydth+100;
   
   newicda=compress(icda, 'E');
   if newicda='V812' then newicda=812;

   newicda=newicda*10;
   
   if mmdth<0 and yydth>0 then mmdth=6;
   dtdth=(yydth*12)+mmdth;
   if dtdth=. then delete ;

   proc sort;
      by id;
      run;


/******Diab cases ******/      

%hp_diab8622;
 
    if dbcase = 1;

    dtdxdiab = dtdx*1;
    if dtdxdiab = . then dtdxdiab = 1031;

    keep id dtdxdiab dbcase type prob ;

run; 

proc freq data=hp_diab8622;tables dbcase type prob ;run;
proc univariate data=hp_diab8622;var dtdxdiab;run;


/******exposure and covariates******/
data ahei86; 
   set AHEIdat3.hnahei86l; 
   ahei86=nAHEI86a; 
   aheinoal86=nAHEI86_noal; 
   aheinopt86 = sum (meataI86, nutI86, ssbI86, frtI86a, tvegI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinoveg86 = sum (meataI86, nutI86, ssbI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinofru86 = sum (meataI86, nutI86, ssbI86, tvegI86, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinowgr86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, omegI86);
   aheinossb86 = sum (meataI86, nutI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinonut86 = sum (meataI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinormt86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinotft86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinon3f86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86);
   aheinopuf86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinona86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, wgI86, omegI86);

   aheifisha86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86);
   aheidairy86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinutbl86 = sum (ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheipoult86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheineggs86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
proc sort; by id; run;

data ahei90; 
   set AHEIdat3.hnahei90l; 
   ahei90=nAHEI90a; 
   aheinoal90=nAHEI90_noal; 
   aheinopt90 = sum (meataI90, nutI90, ssbI90, frtI90a, tvegI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinoveg90 = sum (meataI90, nutI90, ssbI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinofru90 = sum (meataI90, nutI90, ssbI90, tvegI90, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinowgr90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, omegI90);
   aheinossb90 = sum (meataI90, nutI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinonut90 = sum (meataI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinormt90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinotft90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinon3f90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90);
   aheinopuf90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinona90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, wgI90, omegI90);

   aheifisha90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, wgI90, na90s);
   aheidairy90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheinutbl90 = sum (ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheipoult90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheineggs90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
proc sort; by id; run;

data ahei94; 
   set AHEIdat3.hnahei94l; 
   ahei94=nAHEI94a; 
   aheinoal94=nAHEI94_noal; 
   aheinopt94 = sum (meataI94, nutI94, ssbI94, frtI94a, tvegI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinoveg94 = sum (meataI94, nutI94, ssbI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinofru94 = sum (meataI94, nutI94, ssbI94, tvegI94, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinowgr94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, omegI94);
   aheinossb94 = sum (meataI94, nutI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinonut94 = sum (meataI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinormt94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinotft94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinon3f94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94);
   aheinopuf94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinona94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, wgI94, omegI94);

   aheifisha94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, wgI94, na94s);
   aheidairy94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheinutbl94 = sum (ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheipoult94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheineggs94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
proc sort; by id; run;

data ahei98; 
   set AHEIdat3.hnahei98l; 
   ahei98=nAHEI98a; 
   aheinoal98=nAHEI98_noal; 
   aheinopt98 = sum (meataI98, nutI98, ssbI98, frtI98a, tvegI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinoveg98 = sum (meataI98, nutI98, ssbI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinofru98 = sum (meataI98, nutI98, ssbI98, tvegI98, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinowgr98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, omegI98);
   aheinossb98 = sum (meataI98, nutI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinonut98 = sum (meataI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinormt98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinotft98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinon3f98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98);
   aheinopuf98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinona98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, wgI98, omegI98);

   aheifisha98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, wgI98, na98s);
   aheidairy98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheinutbl98 = sum (ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheipoult98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheineggs98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
proc sort; by id; run;

data ahei02; 
   set AHEIdat3.hnahei02l; 
   ahei02=nAHEI02a; 
   aheinoal02=nAHEI02_noal; 
   aheinopt02 = sum (meataI02, nutI02, ssbI02, frtI02a, tvegI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinoveg02 = sum (meataI02, nutI02, ssbI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinofru02 = sum (meataI02, nutI02, ssbI02, tvegI02, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinowgr02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, omegI02);
   aheinossb02 = sum (meataI02, nutI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinonut02 = sum (meataI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinormt02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinotft02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinon3f02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02);
   aheinopuf02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinona02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, wgI02, omegI02);

   aheifisha02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, wgI02, na02s);
   aheidairy02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheinutbl02 = sum (ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheipoult02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheineggs02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
proc sort; by id; run;

data ahei06; 
   set AHEI06.ahei06; 
   ahei06=nAHEI06a; 
   aheinoal06=nAHEI06_noal; 
   aheinopt06 = sum (meataI06, nutI06, ssbI06, frtI06a, tvegI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinoveg06 = sum (meataI06, nutI06, ssbI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinofru06 = sum (meataI06, nutI06, ssbI06, tvegI06, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinowgr06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, omegI06);
   aheinossb06 = sum (meataI06, nutI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinonut06 = sum (meataI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinormt06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinotft06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinon3f06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06);
   aheinopuf06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinona06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, wgI06, omegI06);

   aheifisha06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, wgI06, na06s);
   aheidairy06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheinutbl06 = sum (ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheipoult06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheineggs06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
proc sort; by id; run;

data ahei10; 
   set AHEI06.ahei10; 
   ahei10=nAHEI10a; 
   aheinopt10 = sum (meataI10, nutI10, ssbI10, frtI10a, tvegI10, nETOHI10b, na10s, wgI10, omegI10);
   aheifisha10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, wgI10, na10s);
   aheidairy10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheinutbl10 = sum (ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheipoult10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheineggs10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
proc sort; by id; run;

/*** read physical activity data***/ 
%hmet8616(keep=act86 act88 act90 act92 act94 act96 act98 act00 act02 act04 act06 act08 act10 act12 act14 act16);
run;

data hp_mets;   
set hmet8616;   
array acts{18} act86 act88 act90 act92 act94 act96 act98 act00 act02 act04 act06 act08 act10 act12 act14 act16 act16 act16;
do i=1 to 18; if acts{i}>900 then acts{i}=.; end;
do i=2 to 18; if acts{i}=. then acts{i}=acts{i-1}; end;
proc sort; by id;
run;

/*potato intake*/
%include '/udd/nhsem/Potato.T2D/MousaviSeyed_potato_T2D_052024/food_hpfs.sas';

/****** alcohol ******/
%h86_nts (keep=alco86n calor86n na86n);
%h90_nts (keep=alco90n calor90n na90n);
%h94_nts (keep=alco94n calor94n na94n);
%h98_nts (keep=alco98n calor98n na98n);
%h02_nts (keep=alco02n calor02n na02n);
%h06_nts (keep=alco06n calor06n na06n);
%h10_nts (keep=alco10n calor10n na10n);
%h14_nts (keep=alco14n calor14n na14n);
%h18_nts (keep=alco18n calor18n na18n);
%h86_dt  (keep=mvt86d mvit86);if mvt86d=2 then mvit86=1;else mvit86=0;
%h90_dt  (keep=mvt90d mvit90);if mvt90d=2 then mvit90=1;else mvit90=0;
%h94_dt  (keep=mvt94d mvit94);if mvt94d=2 then mvit94=1;else mvit94=0;
%h98_dt  (keep=mvt98d mvit98);if mvt98d=2 then mvit98=1;else mvit98=0;

/****read in self-reported diabetes, cancer, CVD and hypertension data***/
%hp_der (keep= dbmy86 rtmnyr86 rtmnyr88 rtmnyr90 rtmnyr92 rtmnyr94 rtmnyr96 rtmnyr98 rtmnyr00 rtmnyr02 rtmnyr04 rtmnyr06 height 
            bmi2186 wt86 wt88 wt90 wt92 wt94 wt96 wt98 wt00 wt02 wt04 wt06 smoke86 smoke88 smoke90 smoke92 smoke94 smoke96 
            smoke98 smoke00 smoke02 smoke04 smoke06 cgnm86 cgnm88 cgnm90 cgnm92 cgnm94 cgnm96 cgnm98 cgnm00 cgnm02 cgnm04 cgnm06 dbmy09);

data hp_der;
   set hp_der;
   if dbmy09>0;
run;


%hp_der_2 (keep=rtmnyr08 rtmnyr10 rtmnyr12 rtmnyr14 rtmnyr16 rtmnyr18 rtmnyr20 wt08 wt10 wt12 wt14 wt16 wt18 wt20 smoke08 smoke10 smoke12 smoke14 smoke16 smoke18 smoke20 cgnm08 
                cgnm10 cgnm12 cgnm14 cgnm16 cgnm18 cgnm20); 

%hp86(keep=hbp86 db86 chol86 mi86 cabg86 ang86 str86 orhy86 renf86 asp86 seuro86 scand86 ocauc86 afric86 asian86 oanc86 
         mmi86 fmi86 colc86  pros86  lymp86  ocan86  mel86 antch86 betab86 lasix86 diur86 calcb86 ald86);      
if hbp86 ne 1 then hbp86=0;
if db86 ne 1 then db86=0;
if chol86 ne 1 then chol86=0;
if mi86 ne 1 then mi86=0; 
if cabg86 ne 1 then cabg86=0;
if ang86 ne 1 then ang86=0;
if str86 ne 1 then str86=0;
if orhy86 ne 1 then orhy86=0;
if renf86 ne 1 then renf86=0;
if asp86 ne 1 then asp86=0;
if mmi86 ne 1 then mmi86=0;
if fmi86 ne 1 then fmi86=0;
if colc86 ne 1 then colc86=0;
if pros86 ne 1 then pros86=0;
if lymp86 ne 1 then lymp86=0;
if ocan86 ne 1 then ocan86=0;
if mel86 ne 1 then mel86=0;

%hp88(keep=hbp88 db88 chol88 mi88 cabg88 ang88 str88 orhy88 renf88 asp88 colc88  pros88  lymp88  ocan88  mel88 chrx88 betab88 lasix88 diur88 ccblo88 ald88); 

%hp90(keep=hbp90 db90 chol90 mi90 cabg90 ang90 str90 orhy90 renf90 asp90 colc90  pros90  lymp90  ocan90  mel90 chrx90 betab90 lasix90 diur90 ccblo90 ald90 serum90
           mdb90 fdb90 sdb90 dbfh90); 
if mdb90=1 or fdb90=1 or sdb90=1 then dbfh90=1;
else dbfh90=0;
proc sort;by id;run;

%hp92(keep=hbp92 db92 chol92 mi92 cabg92 ang92 str92 orhy92 renf92 asp92 colc92  pros92  lymp92  ocan92  mel92 chrx92 betab92 lasix92 thiaz92 ccblo92 ald92
           mdb92 fdb92 sdb92 dbfh92);
if mdb92=1 or fdb92=1 or sdb92=1 then dbfh92=1;
else dbfh92=0;
proc sort;by id;run;

%hp94(keep=hbp94 db94 chol94 mi94 cabg94 ang94 str94 orhy94 asp94 colc94  pros94  lymp94  ocan94  mel94 chrx94 betab94 lasix94 thiaz94 ccblo94 ald94);

%hp96(keep=hbp96 db96 chol96 mi96 cabg96 ang96 str96 orhy96 renf96 aspd96 nasp96 asp96 colc96  pros96  lymp96  ocan96  mel96 chrx96 betab96 lasix96 thiaz96 ccblo96 ald96); 
if aspd96=1 or nasp96=1 then asp96=0;
if aspd96 in (2:5) or nasp96 in (2:7) then asp96=1;
else asp96=.;

%hp98(keep=hbp98 db98 chol98 mi98 cabg98 ang98 str98 orhy98 renf98 aspfr98 aspw98 asp98 colc98  pros98  lymp98  ocan98  mel98 chrx98 betab98 lasix98 thiaz98 ccblo98 ald98); 
if aspfr98=1 or aspw98=1 then asp98=0;
if aspfr98 in (2:6) or aspw98 in (2:5) then asp98=1;
else asp98=.;

%hp00(keep=hbp00 db00 chol00 mi00 cabg00 ang00 strk00 orhy00 renf00 asp00 colc00  pros00  lymp00  ocan00  mel00 chrx00 ochrx00 betab00 lasix00 thiaz00 ccblo00 oanth00 serum00);

%hp02(keep=hbp02 db02 chol02 mi02 cabg02 ang02 strk02 orhy02 renal02 asp02 colc02  pros02  lymp02  ocan02  mel02 stat02 ochrx02 betab02 lasix02 thiaz02 calcb02 anthp02 mvt02 mvit02);
if mvt02=2 then mvit02=1;else mvit02=0;

%hp04(keep=hbp04 db04 chol04 mi04 cabg04 ang04 strk04 orhy04 renal04 asp04 colc04  pros04  lymp04  ocan04  mel04 stat04 mev04 zoc04 crest04 prav04 lip04 ostat04 ochrx04 betab04 ace04 lasix04 thiaz04 calcb04 anthp04 tchol04);

%hp06(keep=hbp06 db06 chol06 mi06 cabg06 ang06 strk06 renal06 asp06 colc06  pros06  lymp06  ocan06  mel06 stat06 mev06 zoc06 crest06 prav06 lip06 ostat06 ochrx06 betab06 ace06 lasix06 thiaz06 calcb06 anthp06 mvt06 mvit06);
if mvt06=2 then mvit06=1;else mvit06=0;

%hp08(keep=hbp08 db08 chol08 mi08 cabg08 ang08 strk08 renal08 asp08 colc08  pros08  lymp08  ocan08  mel08 stat08 mev08 zoc08 crest08 prav08 lip08 ostat08 ochrx08 betab08 ace08 lasix08 thiaz08 calcb08 arb08 anthp08
           mdb08 fdb08 sdb08 dbfh08);
if mdb08=1 or fdb08=1 or sdb08=1 then dbfh08=1;
else dbfh08=0;
proc sort;by id;run;

%hp10(keep=hbp10 db10 chol10 mi10 cabg10 ang10 strk10 renal10 asp10 colc10  pros10  lymp10  ocan10  mel10 stat10 mev10 zoc10 crest10 prav10 lip10 ostat10 ochrx10 betab10 ace10 lasix10 thiaz10 calcb10 arb10 anthp10 mvt10 mvit10);
if mvt10=2 then mvit10=1;else mvit10=0;

%hp12(keep=hbp12 db12 chol12 mi12 cabg12 ang12 strk12 renal12 asp12 colc12  pros12  lymp12  ocan12  mel12 stat12 mev12 zoc12 crest12 prav12 lip12 ostat12 ochrx12 betab12 ace12 lasix12 thiaz12 calcb12 arb12 anthp12);

%hp14(keep=hbp14 db14 chol14 mi14 cabg14 ang14 strk14 asp14 colc14  pros14  lymp14  ocan14  mel14 stat14 mev14 zoc14 crest14 prav14 lip14 ostat14 ochrx14 betab14 ace14 lasix14 thiaz14 calcb14 arb14 anthp14 mvt14 mvit14 hisp14);
if mvt14=2 then mvit14=1;else mvit14=0;

%hp16(keep=hbp16 db16 chol16 mi16 cabg16 ang16 stk16 asp16 colc16  pros16  lymp16  ocan16  mel16 stat16 zocor16 crestor16 prava16 lipit16 othmed16 ochrx16 bblock16 aceinhb16 lasix16 thiaz16 cblock16 angio16 antihy16);


/*******************************************************************

Main Exposures - nSES - pull in all Census years for all addresses

Note: Use %nses7614(keep= ); if you want to select date only on 
      certain exposures
      

********************************************************************/
%nses8818 ;
run;


data base0;
merge hp_der(in=mst) hp_der_2 hp_dead hp_diab8622 hp86 hp88 hp90 hp92 hp94 hp96 hp98 hp00 hp02 hp04 hp06 hp08 hp10 hp12 hp14 hp16 hp_mets h86_dt h90_dt h94_dt h98_dt
                     h86_nts h90_nts h94_nts h98_nts h02_nts h06_nts h10_nts h14_nts h18_nts ahei86 ahei90 ahei94 ahei98 ahei02 ahei06 ahei10 foods nses8818 end=_end_;
by id;
exrec=1;
if first.id and mst then exrec=0; 

birthday=dbmy86;

deadage=int((dtdth-birthday)/12);
   if dtdth in (0,.)then deadage=0;
   if dtdth eq 9999 then deadage=0;

can86=0;
   if pros86=1 or lymp86=1 or ocan86=1 or colc86=1 or mel86=1 then can86=1;
can88=0;
   if pros88=1 or lymp88=1 or ocan88=1 or colc88=1 or mel88=1 then can88=1;
can90=0;
   if pros90=1 or lymp90=1 or ocan90=1 or colc90=1 or mel90=1 then can90=1;
can92=0;
   if pros92=1 or lymp92=1 or ocan92=1 or colc92=1 or mel92=1 then can92=1;
can94=0;
   if pros94=1 or lymp94=1 or ocan94=1 or colc94=1 or mel94=1 then can94=1;
can96=0;
   if pros96=1 or lymp96=1 or ocan96=1 or colc96=1 or mel96=1 then can96=1;
can98=0;
   if pros98=1 or lymp98=1 or ocan98=1 or colc98=1 or mel98=1 then can98=1;
can00=0;
   if pros00=1 or lymp00=1 or ocan00=1 or colc00=1 or mel00=1 then can00=1;
can02=0;
   if pros02=1 or lymp02=1 or ocan02=1 or colc02=1 or mel02=1 then can02=1;
can04=0;
   if pros04=1 or lymp04=1 or ocan04=1 or colc04=1 or mel04=1 then can04=1;
can06=0;
   if pros06=1 or lymp06=1 or ocan06=1 or colc06=1 or mel06=1 then can06=1;
can08=0;
   if pros08=1 or lymp08=1 or ocan08=1 or colc08=1 or mel08=1 then can08=1;
can10=0;
   if pros10=1 or lymp10=1 or ocan10=1 or colc10=1 or mel10=1 then can10=1;
can12=0;
   if pros12=1 or lymp12=1 or ocan12=1 or colc12=1 or mel12=1 then can12=1;
can14=0;
   if pros14=1 or lymp14=1 or ocan14=1 or colc14=1 or mel14=1 then can14=1;
can16=0;
   if pros16=1 or lymp16=1 or ocan16=1 or colc16=1 or mel16=1 then can16=1;


/***ethnicity data****/
if seuro86=1 then ethnic =1;
else if scand86=1 then ethnic =1;
else if ocauc86=1 then ethnic =1;
else if afric86=1 then ethnic =2;
else if asian86=1 then ethnic =3;
else if oanc86=1  then ethnic =4;
else ethnic=.;

%indic3(vbl=ethnic, prefix=ethnic, reflev=1, min=2, max=4, missing=., usemiss=1,
 label1='causcasian',
 label2='african',
 label3='asian',
 label4='other');
if ethnic = 1 then eth3g=1;
else if ethnic=2 then eth3g=2;
else if ethnic in (3,4) then eth3g=3;
else eth3g=1;

%indic3(vbl=eth3g, prefix=eth3g, reflev=1, min=2, max=3, missing=., usemiss=1,
 label1='causcasian',
 label2='african',
 label3='asian & others');
if eth3g=1 then white=1;
else white=0;
if ethnic=. then white=.;

if white=1 then white2=1;
else white2=0;

if ethnic=1 and hisp14 ne 2 then catrace=0; /*non-hispanic white*/
else if ethnic=2 and hisp14 ne 2 then catrace=1; /*non-hispanic black*/
else if hisp14=2 then catrace=2; /*Hispanic*/
else if ethnic=3 then catrace=3; /*Asian*/
else catrace=.;

if catrace=0 then catrace2=0;
else if catrace in (1,2,3) then catrace2=1;
else catrace2=.;

/******************* cholesterol lowering drug ******************************/
if antch86=1 then hchtx86=1;else hchtx86=0;
if chrx88=1 then hchtx88=1;else hchtx88=0;
if chrx90=1 then hchtx90=1;else hchtx90=0;
if chrx92=1 then hchtx92=1;else hchtx92=0;
if chrx94=1 then hchtx94=1;else hchtx94=0;
if chrx96=1 then hchtx96=1;else hchtx96=0;
if chrx98=1 then hchtx98=1;else hchtx98=0;
if chrx00=1 then chrx00=1;else chrx00=0;
/*if chrx00=1 or ochrx00=1 then hchtx00=1;else hchtx00=0;*//*Other Chol lowering drug*/
if stat02=1 then chrx02=1;else chrx02=0;
/*if chrx02=1 or ochrx02=1 then hchtx02=1;else hchtx02=0;*/
if stat04=1 or mev04=1 or zoc04=1 or crest04=1 or prav04=1 or lip04=1 or ostat04=1 then chrx04=1; else chrx04=0;
if chrx04=1 or ochrx04=1 then hchtx04=1;else hchtx04=0;
if stat06=1 or mev06=1 or zoc06=1 or crest06=1 or prav06=1 or lip06=1 or ostat06=1 then chrx06=1; else chrx06=0;
if chrx06=1 or ochrx06=1 then hchtx06=1;else hchtx06=0;
if stat08=1 or mev08=1 or zoc08=1 or crest08=1 or prav08=1 or lip08=1 or ostat08=1 then chrx08=1; else chrx08=0;
if chrx08=1 or ochrx08=1 then hchtx08=1;else hchtx08=0;
if stat10=1 or mev10=1 or zoc10=1 or crest10=1 or prav10=1 or lip10=1 or ostat10=1 then chrx10=1; else chrx10=0;
if chrx10=1 or ochrx10=1 then hchtx10=1;else hchtx10=0;
if stat12=1 or mev12=1 or zoc12=1 or crest12=1 or prav12=1 or lip12=1 or ostat12=1 then chrx12=1; else chrx12=0;
if chrx12=1 or ochrx12=1 then hchtx12=1;else hchtx12=0;
if stat14=1 or mev14=1 or zoc14=1 or crest14=1 or prav14=1 or lip14=1 or ostat14=1 then chrx14=1; else chrx14=0;
if chrx14=1 or ochrx14=1 then hchtx14=1;else hchtx14=0;
if stat16=1 or zocor16=1 or crestor16=1 or prava16=1 or lipit16=1 or othmed16=1 then chrx16=1; else chrx16=0;
if chrx16=1 or ochrx16=1 then hchtx16=1;else hchtx16=0;


/*Cholesterol level*/
cholv90=9;
if serum90=2 or serum90=3 then cholv90=1;
if serum90=4 or serum90=5 then cholv90=2;
if serum90=6 or serum90=7 then cholv90=3;
if serum90=8 or serum90=9 then cholv90=4;
if serum90=10 or serum90=11 then cholv90=5;

cholv00=9;
if serum00=2 or serum00=3 then cholv00=1;
if serum00=4 or serum00=5 then cholv00=2;
if serum00=6 or serum00=7 then cholv00=3;
if serum00=8 or serum00=9 then cholv00=4;
if serum00=10 or serum00=11 then cholv00=5;

cholv04=9;
if tchol04=2 or tchol04=3 then cholv04=1;
if tchol04=4 or tchol04=5 then cholv04=2;
if tchol04=6 or tchol04=7 then cholv04=3;
if tchol04=8 or tchol04=9 then cholv04=4;
if tchol04=10 or tchol04=11 then cholv04=5;


/***antihypertensive***/
   if (betab86 =1 or lasix86=1 or diur86 =1 or calcb86=1 or ald86=1) then htnrx86=1;
       else htnrx86=0;

   if (betab88 =1 or lasix88=1 or diur88 =1 or ccblo88=1 or ald88=1) then htnrx88=1;
       else htnrx88=0;

   if (betab90 =1 or lasix90=1 or diur90 =1 or ccblo90=1 or ald90=1) then htnrx90=1;
       else htnrx90=0;

   if (betab92 =1 or lasix92=1 or thiaz92=1 or ccblo92=1 or ald92=1) then htnrx92=1;
       else htnrx92=0;

   if (betab94 =1 or lasix94=1 or thiaz94=1 or ccblo94=1 or ald94=1) then htnrx94=1;
       else htnrx94=0;

   if (betab96 =1 or lasix96=1 or thiaz96=1 or ccblo96=1 or ald96=1) then htnrx96=1;
       else htnrx96=0;

   if (betab98 =1 or lasix98=1 or thiaz98=1 or ccblo98=1 or ald98=1) then htnrx98=1;
       else htnrx98=0;

   if (betab00 =1 or lasix00=1 or thiaz00=1 or ccblo00=1 or oanth00=1) then htnrx00=1;
       else htnrx00=0;

   if (betab02 =1 or lasix02=1 or thiaz02 =1 or calcb02=1 or anthp02=1) then htnrx02=1;
       else htnrx02=0;

   if (betab04 =1 or ace04=1 or lasix04=1 or thiaz04 =1 or calcb04=1 or anthp04=1) then htnrx04=1;
       else htnrx04=0; 

   if (betab06 =1 or ace06=1 or lasix06=1 or thiaz06 =1 or calcb06=1 or anthp06=1) then htnrx06=1;
       else htnrx06=0; 

   if (betab08 =1 or ace08=1 or lasix08=1 or thiaz08 =1 or calcb08=1 or arb08=1 or anthp08=1) then htnrx08=1;
       else htnrx08=0; 

   if (betab10 =1 or ace10=1 or lasix10=1 or thiaz10 =1 or calcb10=1 or arb10=1 or anthp10=1) then htnrx10=1;
       else htnrx10=0;

   if (betab12 =1 or ace12=1 or lasix12=1 or thiaz12 =1 or calcb12=1 or arb12=1 or anthp12=1) then htnrx12=1;
       else htnrx12=0;

   if (betab14 =1 or ace14=1 or lasix14=1 or thiaz14 =1 or calcb14=1 or arb14=1 or anthp14=1) then htnrx14=1;
       else htnrx14=0;
  
   if (bblock16=1 or aceinhb16=1 or lasix16=1 or thiaz16=1 or cblock16=1 or angio16=1 or antihy16=1) then htnrx16=1;
       else htnrx16=0;


/* Set up family hx of MI */
famhxmi=0;
if mmi86=1 or fmi86=1 then famhxmi=1;

if dbfh90=1 or dbfh92=1 or dbfh08=1 then dbfh=1; else dbfh=0;

array wt  {16}  wt86    wt88    wt90    wt92    wt94    wt96    wt98    wt00     wt02     wt04     wt06      wt08  wt10  wt12  wt14 wt16   ;
array bmi     {16}  bmi86   bmi88   bmi90   bmi92   bmi94   bmi96   bmi98   bmi00    bmi02    bmi04    bmi06     bmi08   bmi10   bmi12   bmi14 bmi16  ;
array smoke    {16}  smoke86 smoke88 smoke90 smoke92 smoke94 smoke96 smoke98 smoke00  smoke02  smoke04  smoke06   smoke08  smoke10  smoke12  smoke14 smoke16  ;
array cgnm   {16}  cgnm86  cgnm88  cgnm90  cgnm92  cgnm94  cgnm96  cgnm98  cgnm00   cgnm02   cgnm04   cgnm06    cgnm08  cgnm10   cgnm12    cgnm14 cgnm16  ;
array smm     {16}  smm86   smm88   smm90   smm92   smm94   smm96   smm98   smm00    smm02    smm04    smm06     smm08    smm10    smm12     smm14 smm16  ;

do m=1 to 16;
   if wt{m}=0 then wt{m}=.;      
      bmi{m}=.;   
    if height>0 and wt{m}>0 then bmi{m}=(wt{m}*0.45359237)/((height*25.4/1000)*(height*25.4/1000)); 
end;

do i=1 to 16;
    if smoke{i}=5 then smoke{i}=1;      
    if smoke{i} in (1,3) then smm{i}=1;      /*Never*/
    if smoke{i}=2 then smm{i}=2;      /*Past*/
    if smoke{i}=4 and cgnm{i} in (1,2) then smm{i}=3;  /*Current, 1-14*/
    if smoke{i}=4 and cgnm{i}=3 then smm{i}=4;  /*Current, 15-24*/
    if smoke{i}=4 and cgnm{i} in (4,5,6) then smm{i}=5;  /*Current, 25+*/
end;

do j=2 to 16;
   if bmi{j}=.      then bmi{j}=bmi{j-1};
   if smoke{j}=.     then smoke{j}=smoke{j-1};
   if cgnm{j}=.    then cgnm{j}=cgnm{j-1};
   if smm{j}=.    then smm{j}=smm{j-1};
end;

run;

proc sort data=base0; by id; run;


data one;
set base0 end=_end_;

array nocum86 {*}  calor86n alco86n gid86n tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d soypro86d nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d whgrn86n rfgrn86n whgrns86d rfgrns86d gl86n ahei86 aheinoal86 aheinopt86 aheifisha86 aheidairy86 aheinutbl86 aheipoult86 aheineggs86;  
array nocum90 {*}  calor90n alco90n gid90n tpotat90d bbmpot90d fpotat90d chipss90d prmeat90d urmeat90d trmeat90d poultr90d fishal90d regegg90d hdairy90d ldairy90d soypro90d nutsal90d legume90d fruits90d vegeal90d nstveg90d staveg90d tdairy90d coffee90d nutleg90d bwrice90d wtrice90d SSB90d whgrn90n rfgrn90n whgrns90d rfgrns90d gl90n ahei90 aheinoal90 aheinopt90 aheifisha90 aheidairy90 aheinutbl90 aheipoult90 aheineggs90;
array nocum94 {*}  calor94n alco94n gid94n tpotat94d bbmpot94d fpotat94d chipss94d prmeat94d urmeat94d trmeat94d poultr94d fishal94d regegg94d hdairy94d ldairy94d soypro94d nutsal94d legume94d fruits94d vegeal94d nstveg94d staveg94d tdairy94d coffee94d nutleg94d bwrice94d wtrice94d SSB94d whgrn94n rfgrn94n whgrns94d rfgrns94d gl94n ahei94 aheinoal94 aheinopt94 aheifisha94 aheidairy94 aheinutbl94 aheipoult94 aheineggs94;
array nocum98 {*}  calor98n alco98n gid98n tpotat98d bbmpot98d fpotat98d chipss98d prmeat98d urmeat98d trmeat98d poultr98d fishal98d regegg98d hdairy98d ldairy98d soypro98d nutsal98d legume98d fruits98d vegeal98d nstveg98d staveg98d tdairy98d coffee98d nutleg98d bwrice98d wtrice98d SSB98d whgrn98n rfgrn98n whgrns98d rfgrns98d gl98n ahei98 aheinoal98 aheinopt98 aheifisha98 aheidairy98 aheinutbl98 aheipoult98 aheineggs98;
array nocum02 {*}  calor02n alco02n gid02n tpotat02d bbmpot02d fpotat02d chipss02d prmeat02d urmeat02d trmeat02d poultr02d fishal02d regegg02d hdairy02d ldairy02d soypro02d nutsal02d legume02d fruits02d vegeal02d nstveg02d staveg02d tdairy02d coffee02d nutleg02d bwrice02d wtrice02d SSB02d whgrn02n rfgrn02n whgrns02d rfgrns02d gl02n ahei02 aheinoal02 aheinopt02 aheifisha02 aheidairy02 aheinutbl02 aheipoult02 aheineggs02;
array nocum06 {*}  calor06n alco06n gid06n tpotat06d bbmpot06d fpotat06d chipss06d prmeat06d urmeat06d trmeat06d poultr06d fishal06d regegg06d hdairy06d ldairy06d soypro06d nutsal06d legume06d fruits06d vegeal06d nstveg06d staveg06d tdairy06d coffee06d nutleg06d bwrice06d wtrice06d SSB06d whgrn06n rfgrn06n whgrns06d rfgrns06d gl06n ahei06 aheinoal06 aheinopt06 aheifisha06 aheidairy06 aheinutbl06 aheipoult06 aheineggs06;
array nocum10 {*}  calor10n alco10n gid10n tpotat10d bbmpot10d fpotat10d chipss10d prmeat10d urmeat10d trmeat10d poultr10d fishal10d regegg10d hdairy10d ldairy10d soypro10d nutsal10d legume10d fruits10d vegeal10d nstveg10d staveg10d tdairy10d coffee10d nutleg10d bwrice10d wtrice10d SSB10d whgrn10n rfgrn10n whgrns10d rfgrns10d gl10n ahei10 aheinoal10 aheinopt10 aheifisha10 aheidairy10 aheinutbl10 aheipoult10 aheineggs10;
array nocum14 {*}  calor14n alco14n gid14n tpotat14d bbmpot14d fpotat14d chipss14d prmeat14d urmeat14d trmeat14d poultr14d fishal14d regegg14d hdairy14d ldairy14d soypro14d nutsal14d legume14d fruits14d vegeal14d nstveg14d staveg14d tdairy14d coffee14d nutleg14d bwrice14d wtrice14d SSB14d whgrn14n rfgrn14n whgrns14d rfgrns14d gl14n ahei14 aheinoal14 aheinopt14 aheifisha14 aheidairy14 aheinutbl14 aheipoult14 aheineggs14;

array cumul86 {*}  calor86ca alco86ca gid86ca tpotat86ca bbmpot86ca fpotat86ca chipss86ca prmeat86ca urmeat86ca trmeat86ca poultr86ca fishal86ca regegg86ca hdairy86ca ldairy86ca soypro86ca nutsal86ca legume86ca fruits86ca vegeal86ca nstveg86ca staveg86ca tdairy86ca coffee86ca nutleg86ca bwrice86ca wtrice86ca SSB86ca whgrn86ca rfgrn86ca whgrns86ca rfgrns86ca gl86ca ahei86ca aheinoal86ca aheinopt86ca aheifisha86ca aheidairy86ca aheinutbl86ca aheipoult86ca aheineggs86ca;  
array cumul90 {*}  calor90ca alco90ca gid90ca tpotat90ca bbmpot90ca fpotat90ca chipss90ca prmeat90ca urmeat90ca trmeat90ca poultr90ca fishal90ca regegg90ca hdairy90ca ldairy90ca soypro90ca nutsal90ca legume90ca fruits90ca vegeal90ca nstveg90ca staveg90ca tdairy90ca coffee90ca nutleg90ca bwrice90ca wtrice90ca SSB90ca whgrn90ca rfgrn90ca whgrns90ca rfgrns90ca gl90ca ahei90ca aheinoal90ca aheinopt90ca aheifisha90ca aheidairy90ca aheinutbl90ca aheipoult90ca aheineggs90ca; 
array cumul94 {*}  calor94ca alco94ca gid94ca tpotat94ca bbmpot94ca fpotat94ca chipss94ca prmeat94ca urmeat94ca trmeat94ca poultr94ca fishal94ca regegg94ca hdairy94ca ldairy94ca soypro94ca nutsal94ca legume94ca fruits94ca vegeal94ca nstveg94ca staveg94ca tdairy94ca coffee94ca nutleg94ca bwrice94ca wtrice94ca SSB94ca whgrn94ca rfgrn94ca whgrns94ca rfgrns94ca gl94ca ahei94ca aheinoal94ca aheinopt94ca aheifisha94ca aheidairy94ca aheinutbl94ca aheipoult94ca aheineggs94ca; 
array cumul98 {*}  calor98ca alco98ca gid98ca tpotat98ca bbmpot98ca fpotat98ca chipss98ca prmeat98ca urmeat98ca trmeat98ca poultr98ca fishal98ca regegg98ca hdairy98ca ldairy98ca soypro98ca nutsal98ca legume98ca fruits98ca vegeal98ca nstveg98ca staveg98ca tdairy98ca coffee98ca nutleg98ca bwrice98ca wtrice98ca SSB98ca whgrn98ca rfgrn98ca whgrns98ca rfgrns98ca gl98ca ahei98ca aheinoal98ca aheinopt98ca aheifisha98ca aheidairy98ca aheinutbl98ca aheipoult98ca aheineggs98ca; 
array cumul02 {*}  calor02ca alco02ca gid02ca tpotat02ca bbmpot02ca fpotat02ca chipss02ca prmeat02ca urmeat02ca trmeat02ca poultr02ca fishal02ca regegg02ca hdairy02ca ldairy02ca soypro02ca nutsal02ca legume02ca fruits02ca vegeal02ca nstveg02ca staveg02ca tdairy02ca coffee02ca nutleg02ca bwrice02ca wtrice02ca SSB02ca whgrn02ca rfgrn02ca whgrns02ca rfgrns02ca gl02ca ahei02ca aheinoal02ca aheinopt02ca aheifisha02ca aheidairy02ca aheinutbl02ca aheipoult02ca aheineggs02ca; 
array cumul06 {*}  calor06ca alco06ca gid06ca tpotat06ca bbmpot06ca fpotat06ca chipss06ca prmeat06ca urmeat06ca trmeat06ca poultr06ca fishal06ca regegg06ca hdairy06ca ldairy06ca soypro06ca nutsal06ca legume06ca fruits06ca vegeal06ca nstveg06ca staveg06ca tdairy06ca coffee06ca nutleg06ca bwrice06ca wtrice06ca SSB06ca whgrn06ca rfgrn06ca whgrns06ca rfgrns06ca gl06ca ahei06ca aheinoal06ca aheinopt06ca aheifisha06ca aheidairy06ca aheinutbl06ca aheipoult06ca aheineggs06ca; 
array cumul10 {*}  calor10ca alco10ca gid10ca tpotat10ca bbmpot10ca fpotat10ca chipss10ca prmeat10ca urmeat10ca trmeat10ca poultr10ca fishal10ca regegg10ca hdairy10ca ldairy10ca soypro10ca nutsal10ca legume10ca fruits10ca vegeal10ca nstveg10ca staveg10ca tdairy10ca coffee10ca nutleg10ca bwrice10ca wtrice10ca SSB10ca whgrn10ca rfgrn10ca whgrns10ca rfgrns10ca gl10ca ahei10ca aheinoal10ca aheinopt10ca aheifisha10ca aheidairy10ca aheinutbl10ca aheipoult10ca aheineggs10ca;  
array cumul14 {*}  calor14ca alco14ca gid14ca tpotat14ca bbmpot14ca fpotat14ca chipss14ca prmeat14ca urmeat14ca trmeat14ca poultr14ca fishal14ca regegg14ca hdairy14ca ldairy14ca soypro14ca nutsal14ca legume14ca fruits14ca vegeal14ca nstveg14ca staveg14ca tdairy14ca coffee14ca nutleg14ca bwrice14ca wtrice14ca SSB14ca whgrn14ca rfgrn14ca whgrns14ca rfgrns14ca gl14ca ahei14ca aheinoal14ca aheinopt14ca aheifisha14ca aheidairy14ca aheinutbl14ca aheipoult14ca aheineggs14ca;  

do i = 1 to DIM(cumul14);
        cumul86{i} = nocum86{i};
        cumul90{i} = mean(nocum86{i}, nocum90{i});
        cumul94{i} = mean(nocum86{i}, nocum90{i}, nocum94{i});
        cumul98{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
        cumul02{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i});
        cumul06{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i});
        cumul10{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i});
        cumul14{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i}, nocum14{i});

end;

run;


data two;
set one end=_end_;
 
  %indic3(vbl=eth3g, prefix=strrace, reflev=1, min=2, max=3, missing=., usemiss=1,
           label1='causcasian',
           label2='african',
           label3='asian & others');

  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1);

array rtmnyr   {17} rtmnyr86 rtmnyr88 rtmnyr90 rtmnyr92 rtmnyr94 rtmnyr96 rtmnyr98 rtmnyr00 rtmnyr02 rtmnyr04 rtmnyr06 rtmnyr08 rtmnyr10 rtmnyr12 rtmnyr14 rtmnyr16 cutoff;
array irt   {17} irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16 cutoff;
array perioda  {16}  period1  period2  period3  period4  period5  period6  period7  period8  period9  period10 period11 period12  period13  period14 period15 period16 ;
array tvar  {16}  t86 t88 t90   t92   t94   t96   t98   t00   t02   t04   t06   t08   t10   t12   t14 t16  ;
array age   {16}  age86 age88 age90 age92 age94 age96 age98 age00 age02 age04 age06 age08 age10 age12 age14 age16 ;
array aspi  {16}  asp86 asp88 asp90 asp92 asp94 asp96 asp96 asp00 asp02 asp04 asp06 asp08 asp10 asp12 asp14 asp16 ;
array hbp   {16}  hbp86 hbp88 hbp90 hbp92 hbp94 hbp96 hbp98 hbp00 hbp02 hbp04 hbp06 hbp08 hbp10 hbp12 hbp14 hbp16 ;
array chol  {16}  chol86   chol88   chol90   chol92   chol94   chol96   chol98   chol00   chol02   chol04   chol06  chol08  chol10   chol12   chol14 chol16 ;
array db {16}  db86  db88  db90  db92  db94  db96  db98  db00  db02  db04  db06  db08  db10  db12  db14 db16 ;

array smoke {16}  smoke86  smoke88  smoke90  smoke92  smoke94  smoke96  smoke98  smoke00  smoke02  smoke04  smoke06  smoke08  smoke10  smoke12  smoke14 smoke16 ;
array cgnm  {16}  cgnm86   cgnm88   cgnm90   cgnm92   cgnm94   cgnm96   cgnm98   cgnm00   cgnm02   cgnm04   cgnm06   cgnm08   cgnm10   cgnm12   cgnm14 cgnm16 ;
array smm   {16}  smm86 smm88 smm90 smm92 smm94 smm96 smm98 smm00 smm02 smm04 smm06 smm08 smm10 smm12 smm14 smm16 ;
array bmi   {16}  bmi86   bmi88   bmi90   bmi92   bmi94   bmi96   bmi98   bmi00    bmi02    bmi04    bmi06     bmi08   bmi10   bmi12   bmi14 bmi16;
array bmicq {16}  bmic86   bmic88   bmic90   bmic92   bmic94   bmic96   bmic98   bmic00   bmic02   bmic04   bmic06  bmic08   bmic10   bmic12   bmic14 bmic16 ;
array alco  {16}  alco86n  alco86n  alco90n  alco90n  alco94n  alco94n  alco98n  alco98n  alco02n  alco02n  alco06n  alco06n  alco10n  alco10n  alco14n alco14n ;
array alcoca  {16}  alco86ca alco86ca alco90ca alco90ca alco94ca alco94ca alco98ca alco98ca alco02ca alco02ca alco06ca alco06ca alco10ca alco10ca alco14ca alco14ca  ;
array alcq  {16}  alc86 alc88 alc90 alc92 alc94 alc96 alc98 alc00 alc02 alc04 alc06 alc08 alc10 alc12 alc14 alc14  ;
array actm  {16}  act86 act88 act90 act92 act94 act96 act98 act00 act02 act04 act06 act08 act10 act12 act14 act16  ;
array antitc   {16}  hchtx86  hchtx88  hchtx90  hchtx92  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08  hchtx10  hchtx12  hchtx14 hchtx16 ; 
array repcabg   {16}  cabg86  cabg88  cabg90  cabg92 cabg94  cabg96  cabg98  cabg00   cabg02   cabg04   cabg06 cabg08   cabg10   cabg12   cabg14 cabg16 ; 
array ang   {16}  ang86  ang88  ang90  ang92  ang94  ang96  ang98  ang00   ang02   ang04   ang06 ang08   ang10   ang12   ang14 ang16 ; 
array antihp   {16}  htnrx86  htnrx88  htnrx90  htnrx92  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08  htnrx10  htnrx12  htnrx14 htnrx16 ;
array mvit    {16}   mvit86 mvit86 mvit90 mvit90 mvit94 mvit94 mvit98 mvit98 mvit02 mvit02 mvit06 mvit06 mvit10 mvit10 mvit14 mvit14 ;

/*Statin*/
array statin {16}    hchtx86 hchtx88 hchtx90 hchtx92 hchtx94 hchtx96 hchtx98 chrx00 chrx02 chrx04 chrx06 chrx08 chrx10 chrx12 chrx14 chrx16;
                                       
array calor   {16}  calor86n calor86n calor90n calor90n calor94n calor94n calor98n calor98n calor02n calor02n calor06n calor06n calor10n calor10n calor14n calor14n;
array gl      {16}  gl86n gl86n gl90n gl90n gl94n gl94n gl98n gl98n gl02n gl02n gl06n gl06n gl10n gl10n gl14n gl14n ;
array gid     {16}  gid86n gid86n gid90n gid90n gid94n gid94n gid98n gid98n gid02n gid02n gid06n gid06n gid10n gid10n gid14n gid14n ;
array whgrns  {16}  whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d whgrns94d whgrns98d whgrns98d whgrns02d whgrns02d whgrns06d whgrns06d whgrns10d whgrns10d whgrns14d whgrns14d ;
array rfgrns  {16}  rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d rfgrns94d rfgrns98d rfgrns98d rfgrns02d rfgrns02d rfgrns06d rfgrns06d rfgrns10d rfgrns10d rfgrns14d rfgrns14d ;
array whgrn   {16}  whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n whgrn94n whgrn98n whgrn98n whgrn02n whgrn02n whgrn06n whgrn06n whgrn10n whgrn10n whgrn14n whgrn14n ;
array rfgrn   {16}  rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n rfgrn94n rfgrn98n rfgrn98n rfgrn02n rfgrn02n rfgrn06n rfgrn06n rfgrn10n rfgrn10n rfgrn14n rfgrn14n;

array tpotat  {16}  tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d tpotat94d tpotat98d tpotat98d tpotat02d tpotat02d tpotat06d tpotat06d tpotat10d tpotat10d tpotat14d tpotat14d ;
array bbmpot  {16}  bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d bbmpot94d bbmpot98d bbmpot98d bbmpot02d bbmpot02d bbmpot06d bbmpot06d bbmpot10d bbmpot10d bbmpot14d bbmpot14d ;
array fpotat  {16}  fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d fpotat94d fpotat98d fpotat98d fpotat02d fpotat02d fpotat06d fpotat06d fpotat10d fpotat10d fpotat14d fpotat14d ;
array chipss  {16}  chipss86d chipss86d chipss90d chipss90d chipss94d chipss94d chipss98d chipss98d chipss02d chipss02d chipss06d chipss06d chipss10d chipss10d chipss14d chipss14d ;
array prmeat  {16}  prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d prmeat94d prmeat98d prmeat98d prmeat02d prmeat02d prmeat06d prmeat06d prmeat10d prmeat10d prmeat14d prmeat14d ;
array urmeat  {16}  urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d urmeat94d urmeat98d urmeat98d urmeat02d urmeat02d urmeat06d urmeat06d urmeat10d urmeat10d urmeat14d urmeat14d ;
array trmeat  {16}  trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d trmeat94d trmeat98d trmeat98d trmeat02d trmeat02d trmeat06d trmeat06d trmeat10d trmeat10d trmeat14d trmeat14d ;
array poultr  {16}  poultr86d poultr86d poultr90d poultr90d poultr94d poultr94d poultr98d poultr98d poultr02d poultr02d poultr06d poultr06d poultr10d poultr10d poultr14d poultr14d ;
array fishal  {16}  fishal86d fishal86d fishal90d fishal90d fishal94d fishal94d fishal98d fishal98d fishal02d fishal02d fishal06d fishal06d fishal10d fishal10d fishal14d fishal14d ;
array regegg  {16}  regegg86d regegg86d regegg90d regegg90d regegg94d regegg94d regegg98d regegg98d regegg02d regegg02d regegg06d regegg06d regegg10d regegg10d regegg14d regegg14d ;
array hdairy  {16}  hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d hdairy94d hdairy98d hdairy98d hdairy02d hdairy02d hdairy06d hdairy06d hdairy10d hdairy10d hdairy14d hdairy14d ;
array ldairy  {16}  ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ldairy94d ldairy98d ldairy98d ldairy02d ldairy02d ldairy06d ldairy06d ldairy10d ldairy10d ldairy14d ldairy14d ;
array soypro  {16}  soypro86d soypro86d soypro90d soypro90d soypro94d soypro94d soypro98d soypro98d soypro02d soypro02d soypro06d soypro06d soypro10d soypro10d soypro14d soypro14d ;
array nutsal  {16}  nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d nutsal94d nutsal98d nutsal98d nutsal02d nutsal02d nutsal06d nutsal06d nutsal10d nutsal10d nutsal14d nutsal14d ; 
array legume  {16}  legume86d legume86d legume90d legume90d legume94d legume94d legume98d legume98d legume02d legume02d legume06d legume06d legume10d legume10d legume14d legume14d ;
array fruits  {16}  fruits86d fruits86d fruits90d fruits90d fruits94d fruits94d fruits98d fruits98d fruits02d fruits02d fruits06d fruits06d fruits10d fruits10d fruits14d fruits14d ;
array vegeal  {16}  vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d vegeal94d vegeal98d vegeal98d vegeal02d vegeal02d vegeal06d vegeal06d vegeal10d vegeal10d vegeal14d vegeal14d ;
array nstveg  {16}  nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d nstveg94d nstveg98d nstveg98d nstveg02d nstveg02d nstveg06d nstveg06d nstveg10d nstveg10d nstveg14d nstveg14d ;
array staveg  {16}  staveg86d staveg86d staveg90d staveg90d staveg94d staveg94d staveg98d staveg98d staveg02d staveg02d staveg06d staveg06d staveg10d staveg10d staveg14d staveg14d ;
array tdairy  {16}  tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d tdairy94d tdairy98d tdairy98d tdairy02d tdairy02d tdairy06d tdairy06d tdairy10d tdairy10d tdairy14d tdairy14d ;
array coffee  {16}  coffee86d coffee86d coffee90d coffee90d coffee94d coffee94d coffee98d coffee98d coffee02d coffee02d coffee06d coffee06d coffee10d coffee10d coffee14d coffee14d ;
array nutleg  {16}  nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d nutleg94d nutleg98d nutleg98d nutleg02d nutleg02d nutleg06d nutleg06d nutleg10d nutleg10d nutleg14d nutleg14d ;
array bwrice  {16}  bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d bwrice94d bwrice98d bwrice98d bwrice02d bwrice02d bwrice06d bwrice06d bwrice10d bwrice10d bwrice14d bwrice14d ;
array wtrice  {16}  wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d wtrice94d wtrice98d wtrice98d wtrice02d wtrice02d wtrice06d wtrice06d wtrice10d wtrice10d wtrice14d wtrice14d ;
array SSB     {16}  SSB86d SSB86d SSB90d SSB90d SSB94d SSB94d SSB98d SSB98d SSB02d SSB02d SSB06d SSB06d SSB10d SSB10d SSB14d SSB14d;
array afat   {16}   afat86d afat86d afat90d afat90d afat94d afat94d afat98d afat98d afat02d afat02d afat06d afat06d afat10d afat10d afat14d afat14d ;
array vfat   {16}   vfat86d vfat86d vfat90d vfat90d vfat94d vfat94d vfat98d vfat98d vfat02d vfat02d vfat06d vfat06d vfat10d vfat10d vfat14d vfat14d ;

array calorca   {16}  calor86ca calor86ca calor90ca calor90ca calor94ca calor94ca calor98ca calor98ca calor02ca calor02ca calor06ca calor06ca calor10ca calor10ca calor14ca calor14ca;
array glca      {16}  gl86ca gl86ca gl90ca gl90ca gl94ca gl94ca gl98ca gl98ca gl02ca gl02ca gl06ca gl06ca gl10ca gl10ca gl14ca gl14ca;
array gidca     {16}  gid86ca gid86ca gid90ca gid90ca gid94ca gid94ca gid98ca gid98ca gid02ca gid02ca gid06ca gid06ca gid10ca gid10ca gid14ca gid14ca;
array whgrnsca  {16}  whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca whgrns94ca whgrns98ca whgrns98ca whgrns02ca whgrns02ca whgrns06ca whgrns06ca whgrns10ca whgrns10ca whgrns14ca whgrns14ca;
array rfgrnsca  {16}  rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca rfgrns94ca rfgrns98ca rfgrns98ca rfgrns02ca rfgrns02ca rfgrns06ca rfgrns06ca rfgrns10ca rfgrns10ca rfgrns14ca rfgrns14ca;
array whgrnca   {16}  whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca whgrn94ca whgrn98ca whgrn98ca whgrn02ca whgrn02ca whgrn06ca whgrn06ca whgrn10ca whgrn10ca whgrn14ca whgrn14ca;
array rfgrnca   {16}  rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca rfgrn94ca rfgrn98ca rfgrn98ca rfgrn02ca rfgrn02ca rfgrn06ca rfgrn06ca rfgrn10ca rfgrn10ca rfgrn14ca rfgrn14ca;
array transfca  {16}  trnss86ca trnss86ca trnss90ca trnss90ca trnss94ca trnss94ca ttrn098ca ttrn098ca trn0202ca trn0202ca trn0706ca trn0706ca trn1110ca trn1110ca trn1114ca trn1114ca;
array tpotatca  {16}  tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca tpotat94ca tpotat98ca tpotat98ca tpotat02ca tpotat02ca tpotat06ca tpotat06ca tpotat10ca tpotat10ca tpotat14ca tpotat14ca  ;
array bbmpotca  {16}  bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca bbmpot94ca bbmpot98ca bbmpot98ca bbmpot02ca bbmpot02ca bbmpot06ca bbmpot06ca bbmpot10ca bbmpot10ca bbmpot14ca bbmpot14ca  ;
array fpotatca  {16}  fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca fpotat94ca fpotat98ca fpotat98ca fpotat02ca fpotat02ca fpotat06ca fpotat06ca fpotat10ca fpotat10ca fpotat14ca fpotat14ca ;
array chipssca  {16}  chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca chipss94ca chipss98ca chipss98ca chipss02ca chipss02ca chipss06ca chipss06ca chipss10ca chipss10ca chipss14ca chipss14ca ;
array prmeatca  {16}  prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca prmeat94ca prmeat98ca prmeat98ca prmeat02ca prmeat02ca prmeat06ca prmeat06ca prmeat10ca prmeat10ca prmeat14ca prmeat14ca ;
array urmeatca  {16}  urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca urmeat94ca urmeat98ca urmeat98ca urmeat02ca urmeat02ca urmeat06ca urmeat06ca urmeat10ca urmeat10ca urmeat14ca urmeat14ca ;
array trmeatca  {16}  trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca trmeat94ca trmeat98ca trmeat98ca trmeat02ca trmeat02ca trmeat06ca trmeat06ca trmeat10ca trmeat10ca trmeat14ca trmeat14ca;
array poultrca  {16}  poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca poultr94ca poultr98ca poultr98ca poultr02ca poultr02ca poultr06ca poultr06ca poultr10ca poultr10ca poultr14ca poultr14ca ;
array fishalca  {16}  fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca fishal94ca fishal98ca fishal98ca fishal02ca fishal02ca fishal06ca fishal06ca fishal10ca fishal10ca fishal14ca fishal14ca ;
array regeggca  {16}  regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca regegg94ca regegg98ca regegg98ca regegg02ca regegg02ca regegg06ca regegg06ca regegg10ca regegg10ca regegg14ca regegg14ca ;
array hdairyca  {16}  hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca hdairy94ca hdairy98ca hdairy98ca hdairy02ca hdairy02ca hdairy06ca hdairy06ca hdairy10ca hdairy10ca hdairy14ca hdairy14ca ;
array ldairyca  {16}  ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca ldairy94ca ldairy98ca ldairy98ca ldairy02ca ldairy02ca ldairy06ca ldairy06ca ldairy10ca ldairy10ca ldairy14ca ldairy14ca ;
array soyproca  {16}  soypro86ca soypro86ca soypro90ca soypro90ca soypro94ca soypro94ca soypro98ca soypro98ca soypro02ca soypro02ca soypro06ca soypro06ca soypro10ca soypro10ca soypro14ca soypro14ca ;
array nutsalca  {16}  nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca nutsal94ca nutsal98ca nutsal98ca nutsal02ca nutsal02ca nutsal06ca nutsal06ca nutsal10ca nutsal10ca nutsal14ca nutsal14ca ;
array legumeca  {16}  legume86ca legume86ca legume90ca legume90ca legume94ca legume94ca legume98ca legume98ca legume02ca legume02ca legume06ca legume06ca legume10ca legume10ca legume14ca legume14ca ;
array fruitsca  {16}  fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca fruits94ca fruits98ca fruits98ca fruits02ca fruits02ca fruits06ca fruits06ca fruits10ca fruits10ca fruits14ca fruits14ca ;
array vegealca  {16}  vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca vegeal94ca vegeal98ca vegeal98ca vegeal02ca vegeal02ca vegeal06ca vegeal06ca vegeal10ca vegeal10ca vegeal14ca vegeal14ca ;
array nstvegca  {16}  nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca nstveg94ca nstveg98ca nstveg98ca nstveg02ca nstveg02ca nstveg06ca nstveg06ca nstveg10ca nstveg10ca nstveg14ca nstveg14ca ;
array stavegca  {16}  staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca staveg94ca staveg98ca staveg98ca staveg02ca staveg02ca staveg06ca staveg06ca staveg10ca staveg10ca staveg14ca staveg14ca ;
array tdairyca  {16}  tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca tdairy94ca tdairy98ca tdairy98ca tdairy02ca tdairy02ca tdairy06ca tdairy06ca tdairy10ca tdairy10ca tdairy14ca tdairy14ca ;
array coffeeca  {16}  coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca coffee94ca coffee98ca coffee98ca coffee02ca coffee02ca coffee06ca coffee06ca coffee10ca coffee10ca coffee14ca coffee14ca ;
array nutlegca  {16}  nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca nutleg94ca nutleg98ca nutleg98ca nutleg02ca nutleg02ca nutleg06ca nutleg06ca nutleg10ca nutleg10ca nutleg14ca nutleg14ca ;
array bwriceca  {16}  bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca bwrice94ca bwrice98ca bwrice98ca bwrice02ca bwrice02ca bwrice06ca bwrice06ca bwrice10ca bwrice10ca bwrice14ca bwrice14ca ;
array wtriceca  {16}  wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca wtrice94ca wtrice98ca wtrice98ca wtrice02ca wtrice02ca wtrice06ca wtrice06ca wtrice10ca wtrice10ca wtrice14ca wtrice14ca ;
array SSBca     {16}  SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca SSB94ca SSB98ca SSB98ca SSB02ca SSB02ca SSB06ca SSB06ca SSB10ca SSB10ca SSB14ca SSB14ca ;
array afatca   {16}   afat86ca afat86ca afat90ca afat90ca afat94ca afat94ca afat98ca afat98ca afat02ca afat02ca afat06ca afat06ca afat10ca afat10ca afat14ca afat14ca;
array vfatca   {16}   vfat86ca vfat86ca vfat90ca vfat90ca vfat94ca vfat94ca vfat98ca vfat98ca vfat02ca vfat02ca vfat06ca vfat06ca vfat10ca vfat10ca vfat14ca vfat14ca;

array ahei       {16}  ahei86 ahei86 ahei90 ahei90 ahei94 ahei94 ahei98 ahei98 ahei02 ahei02 ahei06 ahei06 ahei10 ahei10 ahei14 ahei14;
array aheinoal   {16}  aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 aheinoal94 aheinoal98 aheinoal98 aheinoal02 aheinoal02 aheinoal06 aheinoal06 aheinoal10 aheinoal10 aheinoal14 aheinoal14 ;
array aheinopt   {16}  aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 aheinopt94 aheinopt98 aheinopt98 aheinopt02 aheinopt02 aheinopt06 aheinopt06 aheinopt10 aheinopt10 aheinopt14 aheinopt14 ;
array aheifisha  {16}  aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 aheifisha94 aheifisha98 aheifisha98 aheifisha02 aheifisha02 aheifisha06 aheifisha06 aheifisha10 aheifisha10 aheifisha14 aheifisha14 ;
array aheidairy  {16}  aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 aheidairy94 aheidairy98 aheidairy98 aheidairy02 aheidairy02 aheidairy06 aheidairy06 aheidairy10 aheidairy10 aheidairy14 aheidairy14 ;
array aheinutbl  {16}  aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 aheinutbl94 aheinutbl98 aheinutbl98 aheinutbl02 aheinutbl02 aheinutbl06 aheinutbl06 aheinutbl10 aheinutbl10 aheinutbl14 aheinutbl14 ;
array aheipoult  {16}  aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 aheipoult94 aheipoult98 aheipoult98 aheipoult02 aheipoult02 aheipoult06 aheipoult06 aheipoult10 aheipoult10 aheipoult14 aheipoult14 ;
array aheineggs  {16}  aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 aheineggs94 aheineggs98 aheineggs98 aheineggs02 aheineggs02 aheineggs06 aheineggs06 aheineggs10 aheineggs10 aheineggs14 aheineggs14;

array aheica       {16}  ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca ahei94ca ahei98ca ahei98ca ahei02ca ahei02ca ahei06ca ahei06ca ahei10ca ahei10ca ahei14ca ahei14ca; 
array aheinoalca   {16}  aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca aheinoal94ca aheinoal98ca aheinoal98ca aheinoal02ca aheinoal02ca aheinoal06ca aheinoal06ca aheinoal10ca aheinoal10ca aheinoal14ca aheinoal14ca;
array aheinoptca   {16}  aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca aheinopt94ca aheinopt98ca aheinopt98ca aheinopt02ca aheinopt02ca aheinopt06ca aheinopt06ca aheinopt10ca aheinopt10ca aheinopt14ca aheinopt14ca ;
array aheifishaca  {16}  aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca aheifisha94ca aheifisha98ca aheifisha98ca aheifisha02ca aheifisha02ca aheifisha06ca aheifisha06ca aheifisha10ca aheifisha10ca aheifisha14ca aheifisha14ca ;
array aheidairyca  {16}  aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca aheidairy94ca aheidairy98ca aheidairy98ca aheidairy02ca aheidairy02ca aheidairy06ca aheidairy06ca aheidairy10ca aheidairy10ca aheidairy14ca aheidairy14ca ;
array aheinutblca  {16}  aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca aheinutbl94ca aheinutbl98ca aheinutbl98ca aheinutbl02ca aheinutbl02ca aheinutbl06ca aheinutbl06ca aheinutbl10ca aheinutbl10ca aheinutbl14ca aheinutbl14ca ;
array aheipoultca  {16}  aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca aheipoult94ca aheipoult98ca aheipoult98ca aheipoult02ca aheipoult02ca aheipoult06ca aheipoult06ca aheipoult10ca aheipoult10ca aheipoult14ca aheipoult14ca ;
array aheineggsca  {16}  aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca aheineggs94ca aheineggs98ca aheineggs98ca aheineggs02ca aheineggs02ca aheineggs06ca aheineggs06ca aheineggs10ca aheineggs10ca aheineggs14ca aheineggs14ca ;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {16} mdinc90_88 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94 mdinc00_96 mdinc00_98 mdinc00_00
                  mdinc00_02 mdinc00_04 mdinc10_06 mdinc10_08 mdinc10_10 mdinc10_12 mdinc10_14 mdinc10_16; 
   array vhs {16} mdvhs90_88 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94 mdvhs00_96 mdvhs00_98 mdvhs00_00
      mdvhs00_02 mdvhs00_04 mdvhs10_06 mdvhs10_08 mdvhs10_10 mdvhs10_12 mdvhs10_14 mdvhs10_16; 
   array pcoll {16} pcolled90_88 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94 pcolled00_96
        pcolled00_98 pcolled00_00 pcolled00_02 pcolled00_04 pcolled10_06 pcolled10_08
        pcolled10_10 pcolled10_12 pcolled10_14 pcolled10_16 ;
   array phs {16} phs90_88 phs90_88 phs90_90 phs90_92 phs90_94 phs00_96 phs00_98 phs00_00 phs00_02 phs00_04
      phs10_06 phs10_08 phs10_10 phs10_12 phs10_14 phs10_16  ;
   array pnohs {16} pnohs90_88 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94 pnohs00_96 pnohs00_98 pnohs00_00 pnohs00_02 pnohs00_04
      pnohs10_06 pnohs10_08 pnohs10_10 pnohs10_12 pnohs10_14 pnohs10_16  ;
   array pfint {16} pfaminterest90_88 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94
          pfaminterest00_96 pfaminterest00_98 pfaminterest00_00 pfaminterest00_02 pfaminterest00_04
        pfaminterest10_06 pfaminterest10_08 pfaminterest10_10 pfaminterest10_12 pfaminterest10_14 pfaminterest10_16  ;
   array sfemale {16} pfwchbf90_88 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94 pfwchbf00_96 pfwchbf00_98
          pfwchbf00_00 pfwchbf00_02 pfwchbf00_04 pfwchbf10_06 pfwchbf10_08 pfwchbf10_10 pfwchbf10_12 pfwchbf10_14 pfwchbf10_16  ;
   array pkid {16} pkid90_88 pkid90_88 pkid90_90 pkid90_92 pkid90_94 pkid00_96 pkid00_98 pkid00_00 pkid00_02 pkid00_04
       pkid10_06 pkid10_08 pkid10_10 pkid10_12 pkid10_14 pkid10_16  ;
   array pold {16} pold90_88 pold90_88 pold90_90 pold90_92 pold90_94 pold00_96 pold00_98 pold00_00 pold00_02 pold00_04
       pold10_06 pold10_08 pold10_10 pold10_12 pold10_14 pold10_16  ;
   array pohse {16} pohse90_88 pohse90_88 pohse90_90 pohse90_92 pohse90_94 pohse00_96 pohse00_98 pohse00_00 pohse00_02
        pohse00_04 pohse10_06 pohse10_08 pohse10_10 pohse10_12 pohse10_14 pohse10_16  ;
   array ppov {16} ppov90_88 ppov90_88 ppov90_90 ppov90_92 ppov90_94 ppov00_96 ppov00_98 ppov00_00 ppov00_02
       ppov00_04 ppov10_06 ppov10_08 ppov10_10 ppov10_12 ppov10_14 ppov10_16  ;
   array pw {16}   pwht90_88 pwht90_88 pwht90_90 pwht90_92 pwht90_94 pwht00_96 pwht00_98 pwht00_00 pwht00_02
       pwht00_04 pwht10_06 pwht10_08 pwht10_10 pwht10_12 pwht10_14 pwht10_16  ;

   array popd {16} popd90_88 popd90_88 popd90_90 popd90_92 popd90_94 popd00_96 popd00_98 popd00_00 popd00_02
             popd00_04 popd10_06 popd10_08 popd10_10 popd10_12 popd10_14 popd10_16 ; 
   array div {16} division10_88 division10_88 division10_90 division10_92 division10_94 division10_96
      division10_98 division10_00 division10_02 division10_04 division10_06 division10_08
      division10_10 division10_12 division10_14 division10_16 ;
   array reg {16} region10_88 region10_88 region10_90 region10_92 region10_94 region10_96 region10_98
      region10_00 region10_02 region10_04 region10_06 region10_08 region10_10 region10_12
      region10_14 region10_16;

/****** missing replace ******/
    do b=2 to 16;
       if rtmnyr{b}=. then rtmnyr{b}=rtmnyr{b-1}+24;
       if actm{b}=. then actm{b}=actm{b-1};
       if bmi{b}=. then bmi{b}=bmi{b-1};
       if alco{b}=. then alco{b}=alco{b-1};
       if smm{b}=. then smm{b}=smm{b-1};
       if statin{b}=. then statin{b}=statin{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
       if aspi{b}=. then aspi{b}=aspi{b-1};
       if calor{b}=. then calor{b}=calor{b-1};
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
       if soypro{b}=. then soypro{b}=soypro{b-1};
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
       if mvit{b}=. then mvit{b}=mvit{b-1};
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};
       if aheifisha{b}=. then aheifisha{b}=aheifisha{b-1};
       if aheidairy{b}=. then aheidairy{b}=aheidairy{b-1};
       if aheinutbl{b}=. then aheinutbl{b}=aheinutbl{b-1};
       if aheipoult{b}=. then aheipoult{b}=aheipoult{b-1};
       if aheineggs{b}=. then aheineggs{b}=aheineggs{b-1};
       if tdairy{b}=. then tdairy{b}=tdairy{b-1};
       if nutleg{b}=. then nutleg{b}=nutleg{b-1};
       if bwrice{b}=. then bwrice{b}=bwrice{b-1};
       if wtrice{b}=. then wtrice{b}=wtrice{b-1};
       if coffee{b}=. then coffee{b}=coffee{b-1};
       if SSB{b}=. then SSB{b}=SSB{b-1};

       if alcoca{b}=. then alcoca{b}=alcoca{b-1};
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
       if nutsalca{b}=. then nutsalca{b}=nutsalca{b-1};
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if coffeeca{b}=. then coffeeca{b}=coffeeca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};

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
    
    /****** DEFINE AGE ******/
    do c=1 to 16;
     irt{c}=rtmnyr{c};
     age{c}=int((irt{c}-birthday)/12);
     if age{c} =< 0 then age{c}=.;   
    end;
    do d=2 to 16;
       if age{d}=. then age{d}=age{d-1}+2;
    end;


do i=1 to DIM(irt)-1;
  if irt{i} >0 then lastq=irt{i};
  end;
  drop i;
  if lastq=irt{dim(irt)-1} then lastq=.;

/*** Set cutoff at 2018 Jan 31 ***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1417;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1009+24*i) | irt{i}>=(1033+24*i)) then irt{i}=1009+24*i;
   end;  

%beginex();

   *****************Do-Loop over time periods*****************************;
   
   do i=1 to dim(irt)-1;
      period=i;
      do j=1 to dim(tvar);
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

/******main exposure******/ 
if chol86 ne 1 then chol86=0;
if hbp86 ne 1 then hbp86=0;
if mi86 ne 1 then mi86=0;
if db86 ne 1 then db86=0;
if cabg86 ne 1 then cabg86=0;
if ang86 ne 1 then ang86=0;
if str86 ne 1 then str86=0;
if mi86=1 or cabg86=1 or ang86=1 or str86=1 then cvd86=1;else cvd86=0;
if can86 ne 1 then can86=0;
calorv   =  calor    {i};
calorcav =  calorca  {i};
glv      =  gl  {i};
glcav    =  glca  {i};
gidv     =  gid  {i};
gidcav   =  gidca  {i};
alcov    =  alco  {i};
alcocav  =  alcoca  {i};
transfcav = transfca  {i}  ;

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
soyprov = soypro  {i};
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
soyprocav = soyproca  {i};
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
SSBcav =    SSBca     {i};
whgrnscav = whgrnsca  {i};
rfgrnscav = rfgrnsca  {i};
whgrncav = whgrnca  {i};
rfgrncav = rfgrnca  {i};

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

tpotatwv = tpotatv*7/3; 
bbmpotwv = bbmpotv*7/3; 
fpotatowv = fpotatv*7/3;
chipsswv = chipssv*7/3;
whgrnswv = whgrnsv*7/3;
rfgrnswv = rfgrnsv*7/3;
nstvegwv = nstvegv*7/3;  
stavegwv = stavegv*7/3;  
legumewv = legumev*7/3;

tpotatw = tpotatcav*7; 
bbmpotw = bbmpotcav*7; 
fpotatow = fpotatcav*7;
chipssw = chipsscav*7;
whgrnsw = whgrnscav*7/3;
rfgrnsw = rfgrnscav*7/3;
nstvegw = nstvegcav*7/3;  
stavegw = stavegcav*7/3;  
legumew = legumecav*7/3;


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


      /****** Indicator for Smoking ******/ 
     catsmk=smm{i};
     if catsmk=. then catsmk=1;
     %indic3(vbl=catsmk, prefix=catsmkc,min=2,max=5, reflev=1, missing=., usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');

     if catsmk=1 then smkdi=0;
     else smkdi=1;

     if catsmk=1 then smktr=0;
     else if catsmk=2 then smktr=1;
     else smktr=2;

     if smm{i} in (1,2) then catsmkf=0;
     else if smm{i} in (3,4,5) then catsmkf=1;
     else catsmkf=0;
     /*%indic3(vbl=catsmkf, prefix=catsmkfc,min=2,max=4, reflev=1, missing=., usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker >=15 cigs');*/

       /****** Indicator for BMI ******/
      bmicon=bmi{i};if bmi{i}=0 then bmicon=.;
      if bmicon=. then bmicon=25.3996992;

      if bmicon < 25 then bmidi = 0;
         else bmidi = 1;

      if bmicon < 25 then bmitr = 0;
      else if bmicon >= 25 and bmicon < 30 then bmitr = 1;
      else bmitr = 2;

      if 0<bmicon<21 then bmicq{i}=1;
         else if bmicon>=21 and bmicon<25 then bmicq{i}=2;
         else if bmicon>=25 and bmicon<30 then bmicq{i}=3;
         else if bmicon>=30 and bmicon<32 then bmicq{i}=4;
         else if bmicon>=32 then bmicq{i}=5;
         else bmicq{i}=.;
 
       bmic=bmicq{i};    
       if bmic=. then bmic=3;  
      %indic3(vbl=bmic, prefix=bmic, min=1, max=5, reflev=2, missing=., usemiss=0,
                label1='bmi<21', 
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
 
      /****** Indicator Physical Activity ******/
       actcon=actm{i}; 
       if actcon=. then actcon=23.00000;
              if 0<=actcon<3 then actcc=1;
      else if actcon>=3 and actcon<9 then actcc=2;
      else if actcon>=9 and actcon<18 then actcc=3;
      else if actcon>=18 and actcon<27 then actcc=4;
      else if actcon>=27 then actcc=5;
      else actcc=.;/*very few missing use median*/

      if actcon<23.00000 then actbi = 0;
      else if actcon>=23.00000 then actbi = 1;
      else actbi = 0;
      
%indic3(vbl=actcc, prefix=actc, min=2, max=5, reflev=1, missing=., usemiss=0);


      
      /****** Indicator Alcohol consumption ******/
       alcocon=alcoca{i}; /***continuous variable, g/day***/ 
            if alcoca{i}=0.0                     then alcq{i}=1;
            if alcoca{i}>0.0  and alcoca{i}<5.0   then alcq{i}=2;
            if alcoca{i}>=5.0 and alcoca{i}<10.0  then alcq{i}=3;
            if alcoca{i}>=10.0 and alcoca{i}<15.0 then alcq{i}=4;
            if alcoca{i}>=15.0 and alcoca{i}<30.0 then alcq{i}=5;
            if alcoca{i}>=30.0                   then alcq{i}=6;
      
        alc=alcq{i};
       %indic3(vbl=alc, prefix=alcc, min=2, max=6, reflev=1, usemiss=0,
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY');
   
  /*** Category of AHEI variables (<median vs. >median) ***/
	
      if aheinoptcav= . then aheinoptcav=41.7388889;
      if aheinoptcav<41.7388889 then aheinoptd = 0;
      else if aheinoptcav>=41.7388889 then aheinoptd = 1;
    
     /*** aspirin ***/
             asp=aspi{i};
             if asp ne 1 then asp=0;  
             %indic3(vbl=asp, prefix=aspirin, reflev=0, usemiss=0, min=1, max=1);

     /***family history of MI***/
       if famhxmi ne 1 then famhxmi=0;

      
      /****** Indicator for History of antihypertensive user *******/
            select(antihp{i});
                when (1)     antihbp=1;
                  otherwise    antihbp=0;
            end;

      /****** Indicator for History of High Blood Pressure *******/
            select(hbp{i});
                when (1)     htn=1;
                  otherwise    htn=0;
            end;

            if hbp{i}=1 or antihp{i}=1 then highbp=1; else highbp=0;

      /****** Indicator for TC lowering *******/
        
   
	if chol86=1 then hbcbase=1; else hbcbase=0;					/*baseline hypercholesterolemia*/

                select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
            end;

          
      /****** Indicator for History of High TC ******/
            select(chol{i});
                when (1)     hchol=1;
                  otherwise    hchol=0;
            end;
   
      /****** Indicator for History of diabetes *******/
            select(db{i});
                when (1)     diabetes=1;
                  otherwise    diabetes=0;
            end;

      /****** Indicator for multivitamin use *******/
            select(mvit{i});
                when (1)     mlvit=1;
                  otherwise    mlvit=0;
            end;

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxdiab in (0,.)then dtdxdiab=.;
       if dtdxdiab eq 9999 then dtdxdiab=.;

/*Statin*/
      statindi=statin{i};


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

   %exclude(exrec eq 1);                      *multiple records and not in master file;
   %exclude(dbmy09 lt 0);
   %exclude(lastq eq irt{1});                 *only returned baseline qq ;    

        %exclude(cvd86   eq 1);               /* baseline history of CVD*/ 
        %exclude(can86   eq 1);               /*baseline history of cancer*/
        %exclude(db86   eq 1)                 /*baseline history of diabetes*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le irt86);             /* Death before baseline */
   %exclude(0 lt dtdxdiab le irt86);          /* Diagnoses diabetes before 1991 */
   %exclude(calor86n lt 800);                 /* caloric intake <800 kcal/d */
   %exclude(calor86n gt 4200);                /* caloric intake >4200 kcal/d */
   %exclude(calor86n eq .);                   /* missing energy intake */
   %exclude(tpotat86d eq .);                  /* missing potato intake */ 
   %exclude(age86    eq .);                   /* missing age at 1991 */
   %output();
  end;

/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/
  else if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                      /*censor lost to follow up*/    
   %exclude(irt{i-1} le dtdth lt irt{i});               /* DEATHS */
   %exclude(irt{i-1} lt dtdxdiab le irt{i});            /* type2 diabetes CASES */
   %output();
  end;


      end;            /* END OF DO-LOOP OVER TIME PERIODs */
      %endex();       /* must do AFTER all exclusions */

/*** Variables kept for analysis ***/

keep id period dtdth agecon agegp bmidi agedi 
     irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16   cutoff
     t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16   newicda tdiabcase diabcase dtdxdiab
    dead tdead 


     /*Potato variables*/
     tpotatcav bbmpotcav fpotatcav chipsscav tpotatv bbmpotv fpotatv chipssv tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew 
     tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv

     /*Covariates*/
     prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv soyprov nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv coffeev nutlegv bwricev wtricev SSBv
     prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav soyprocav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav coffeecav nutlegcav bwricecav wtricecav SSBcav 
     whgrnsv rfgrnsv whgrnv rfgrnv whgrnscav rfgrnscav whgrncav rfgrncav 
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
     catrace ethnic hisp14 smkdi hbcbase
     calorv calorcav alcov alcocav gidv gidcav glv glcav
     white2 &white_ &bmic_ &alcc_ &actc_ asp famhxmi mlvit bmicon actcon &bmic9_
     actcon bmic alc actcc alcocon
     highbp hchol 
     catsmk &catsmkc_ catsmkf /*&catsmkfc_*/ 

     /*Stratification variables*/
     age65 bmitr aheinoptd dbfh smktr actbi catrace2 hbp86 

     /*Table 1 variables*/
     tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d soypro86d nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d aheinopt86 ahei86
     db86 chol86 str86 mi86 can86 antihbp antihtc cvd86 whgrns86d rfgrns86d
     age86 bmi86 alco86n calor86n act86 statindi eth3g &strrace_

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

   if nSES = . then nSES = 0.0729500; 
run;

proc freq data=two;tables catrace catrace2 ethnic hisp14 actbi smkdi smktr bmitr &bmic9_;run;

%pctl9(
data=two,
varlist=calorcav calorv alcov alcocav prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv tdairyv nutlegv legumev fruitsv soyprov nstvegv stavegv bwricev wtricev SSBv
        tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav soyprocav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav gidcav SSBcav tdairycav nutlegcav bwricecav wtricecav
        whgrnscav rfgrnscav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
        gidv whgrnsv rfgrnsv nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);

proc freq data=four;tables white2 catsmk &catsmkc_ &bmic_ &alcc_ &actc_ mlvit age65 aheinoptd dbfh antihbp antihtc hbp86 hbcbase eth3g &strrace_;run;
proc univariate data=four;var calorcav calorv alcov alcocav bmicon actcon tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav tdairycav soyprocav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav gidcav SSBcav bwricecav wtricecav
                            prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv tdairyv soyprov nutsalv legumev fruitsv vegealv nstvegv stavegv gidv whgrnsv rfgrnsv bwricev wtricev SSBv 
                            aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav nutlegv nutlegcav nSES;run;


data five;
   set four end=_end_;

        if 0.000<=tpotatcav<=0.070 then ctpotatcav=0;        
      else if 0.070<tpotatcav<=0.143 then ctpotatcav=1;       
      else if 0.143<tpotatcav<=0.430 then ctpotatcav=2;         
      else if 0.430<tpotatcav<=0.790 then ctpotatcav=3;       
      else if 0.790<tpotatcav then ctpotatcav=4;                   
  %indic3(vbl=ctpotatcav, prefix=ctpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

      if fpotatcav=0.000 then cfpotatcav=0;                     
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         
      else if 0.430<fpotatcav then cfpotatcav=4;                
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                        
%indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);
run;

data pool_hpfs;
	set five end=_end_;

	%indic3(vbl=catsmk, prefix=smkc,min=2,max=5, reflev=1, missing=., usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');

	%indic3(vbl=actcc, prefix=catact, min=2, max=5, reflev=1, missing=., usemiss=0);

	%indic3(vbl=bmitr,prefix=bmitr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=smktr,prefix=smktr,min=1,max=2,reflev=0,missing=.,usemiss=0);
	%indic3(vbl=catrace,prefix=indrace,min=1,max=3,reflev=0,missing=.,usemiss=1);

	keep id period agecon catrace catrace2 tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv diabcase tdiabcase t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16   
			irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16   cutoff dtdxdiab dtdth &qcalorcav_ &smkc_ &alcc_ &catact_ &bmic9_
			mlvit dbfh antihbp antihtc hbp86 &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &ctpotatcav_ &cfpotatcav_ &cbbmpotcav_ &bmitr_ &smktr_ &indrace_ bmitr smktr white2 &qnSES_;
run;


data hpfs;
	set pool_hpfs;
	length qwhgrnscavm 3 ;

	cohort = 3;
	gender = 1;
	id = 100000000+id;

	array orgt[*] t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16  ;
	array oirt[*] irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16  ;
	array time[*] time1	time2	time3	time4	time5	time6	time7	time8	time9	time10	time11	time12	time13	time14 time15 time16  ;
	array irtp[*] irtp1	irtp2	irtp3	irtp4	irtp5	irtp6	irtp7	irtp8	irtp9	irtp10	irtp11	irtp12	irtp13	irtp14 irtp15 irtp16  ;

	do i=1 to dim(orgt);
		time[i]=orgt[i];
		irtp[i]=oirt[i];
	end;

	dbfh82 = dbfh;
	hxhbp = hbp86;
	hormone = .;
	qwhgrnscavm = 0;

	keep id period agecon catrace catrace2 tpotatw fpotatow chipssw bbmpotw tpotatcav bbmpotcav fpotatcav tpotatv bbmpotv fpotatv diabcase tdiabcase t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16 cohort  gender
			irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16 cutoff dtdxdiab dtdth hormone qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
			catact2 catact3 catact4 catact5 mlvit dbfh82 antihbp antihtc hxhbp qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4
			qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4 cfpotatcav1 cfpotatcav2 cfpotatcav3 cfpotatcav4 cbbmpotcav1 cbbmpotcav2 cbbmpotcav3 ctpotatcav1 ctpotatcav2 ctpotatcav3 ctpotatcav4
			qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qwhgrnscavm qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 bmitr1 bmitr2 smktr1 smktr2 bmitr smktr white2 indrace1 indrace2 indrace3 indracem qnSES1 qnSES2 qnSES3 qnSES4;
run;



/*Pool all*/
data poolall;
	set nhs nhs2 hpfs end=_end_;

	%indic3(vbl=hormone,prefix=hormone,min=2,max=4,reflev=1,missing=.,usemiss=1,
			label1='premenopausal/missing menopause'
            label2='no history of postmenopausal hormone use'
            label3='current postmenopausal hormone use'
            label4='past postmenopausal hormone use');
run;

proc means median data=poolall;var ctpotatcav1 cfpotatcav1 cbbmpotcav1; 
run;

/*Spline*/
%LGTPHCURV9 (   
        data=poolall, 
        exposure=tpotatw,
        case=diabcase,
        model=cox,
        time=tdiabcase,
        strata=agecon period,
        adj=qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 white2 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 catact2 catact3 catact4 catact5 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
                &hormone_ mlvit dbfh82 antihbp antihtc hxhbp qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 
                qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4 qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 
                qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4
            qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 qnSES1 qnSES2 qnSES3 qnSES4,
        refval=0.0,  
        hpct=95,
        /*lpct=5,*/
        nk=4,
        select=3,              
        outplot=ps,
        pictname=spline.tpotat.ps,
        pwhich=SPLINE,      
        footer=NONE,
        GRAPHTIT=NONE,
        plot=4,
        HLABEL= Total potato (servings/week),                
        VLABEL= Hazard ratio (95% Confidence interval) of T2D,
        e=T,            
        ci=1,           
        displayx=T,
        BWM = 1,
        DISTMETH=OS,        
        klines=F,       
        axordv=0.9 to 1.3 by .1,
        plotdata=sptpotat.txt);
run;


%LGTPHCURV9 (   
        data=poolall, 
        exposure=bbmpotw,
        case=diabcase,
        model=cox,
        time=tdiabcase,
        strata=agecon period cohort,
        adj=qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 white2 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 catact2 catact3 catact4 catact5 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
                &hormone_ mlvit dbfh82 antihbp antihtc hxhbp qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 
                qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4 qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 
                qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4 cfpotatcav1 cfpotatcav2 cfpotatcav3 cfpotatcav4 
            qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 qnSES1 qnSES2 qnSES3 qnSES4,
        refval=0.0,  
        hpct=95,
        /*lpct=5,*/
        nk=4,
        select=3,
        outplot=ps,
        pictname=spline.bbmpot.ps,              
        pwhich=SPLINE,      
        footer=NONE,
        GRAPHTIT=NONE,
        plot=4,
        HLABEL= BBM potato (servings/week),                
        VLABEL= Hazard ratio (95% Confidence interval) of T2D,
        e=T,            
        ci=1,           
        displayx=T,
        BWM = 1,
        DISTMETH=OS,        
        klines=F,       
        axordv=0.9 to 1.3 by .1,
        plotdata=sbbmpott.txt);
run;


%LGTPHCURV9 (   
        data=poolall, 
        exposure=fpotatow,
        case=diabcase,
        model=cox,
        time=tdiabcase,
        strata=agecon period cohort cohort,
        adj=qcalorcav1 qcalorcav2 qcalorcav3 qcalorcav4 white2 smkc2 smkc3 smkc4 smkc5 alcc2 alcc3 alcc4 alcc5 alcc6 catact2 catact3 catact4 catact5 bmic92 bmic93 bmic94 bmic95 bmic96 bmic97 bmic98 bmic99
                &hormone_ mlvit dbfh82 antihbp antihtc hxhbp qtrmeatcav1 qtrmeatcav2 qtrmeatcav3 qtrmeatcav4 qpoultrcav1 qpoultrcav2 qpoultrcav3 qpoultrcav4 qfishalcav1 
                qfishalcav2 qfishalcav3 qfishalcav4 qregeggcav1 qregeggcav2 qregeggcav3 qregeggcav4 qtdairycav1 qtdairycav2 qtdairycav3 qtdairycav4 qnutlegcav1 
                qnutlegcav2 qnutlegcav3 qnutlegcav4 qfruitscav1 qfruitscav2 qfruitscav3 qfruitscav4 qvegealcav1 qvegealcav2 qvegealcav3 qvegealcav4 cbbmpotcav1 cbbmpotcav2 cbbmpotcav3
                qSSBcav1 qSSBcav2 qSSBcav3 qSSBcav4 qwhgrnscav1 qwhgrnscav2 qwhgrnscav3 qwhgrnscav4 qrfgrnscav1 qrfgrnscav2 qrfgrnscav3 qrfgrnscav4 qnSES1 qnSES2 qnSES3 qnSES4,
        refval=0.0,  
        hpct=95,
        /*lpct=5,*/
        nk=4,
        select=3,
        outplot=ps,
        pictname=spline.fpotat.ps,              
        pwhich=SPLINE,      
        footer=NONE,
        GRAPHTIT=NONE,
        plot=4,
        HLABEL= French fries (servings/week),                
        VLABEL= Hazard ratio (95% Confidence interval) of T2D,
        e=T,            
        ci=1,           
        displayx=T,
        BWM = 1,
        DISTMETH=OS,        
        klines=F,       
        axordv=0.9 to 1.3 by .1,
        plotdata=sfpotat.txt);
run;







