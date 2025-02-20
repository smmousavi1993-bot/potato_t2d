/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   S.Table 7. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS, stratified by physical activity, BMI, hypertension, age, smoking and AHEI (Meta-analysis)

/*options mlogic symbolgen mprint;*/
%Macro inds(vbl=,study1=,beta1=,se1=,study2=,beta2=,se2=,study3=,beta3=,se3=,dat=);  
Data metaanal; 
    Length vbl $8 study $8;
   vbl="&vbl.";
  %do n=1 %to 3; 
   study="&&study&n.";
   beta=&&beta&n.;
   se=&&se&n.;
   Output;
  %end;  
Run;
title "Exposure variable &&vbl.";
Proc print;
Run;
%metaanal(data=metaanal,beta=beta,se_or_var=s,se=se,studylab=study,pooltype=fixed,explabel=potato,
outcomelabel=diab,wt=1,outdat=outrrc, noprint=F,loglinear=T,printcoeff=T);

data &vbl.es;
set outrrc_p;
ind_var=substr(shortname,1,2);
if ind_var='OR';
if shortname='OR/RR (F)';
varp="&vbl.";
drop ind_var shortname varlabel testing;
run;

data &vbl.q;
set outrrc_p;
if shortname='Q';
varp="&vbl.";
pq=pvalue;
keep varp pq;
run;

data &vbl;
merge &vbl.es &vbl.q;
by varp;
run;

%Mend inds;
%inds(vbl=bbmpotact0,study1=nhs,beta1=-0.024891,se1=0.031302,study2=nhs2,beta2=-0.005625,se2=0.037961,study3=hpfs,beta3=-0.015582,se3=0.045733);
%inds(vbl=bbmpotact1,study1=nhs,beta1=0.093341,se1=0.037435,study2=nhs2,beta2=0.018525,se2=0.055954,study3=hpfs,beta3=0.049739,se3=0.055884);
%inds(vbl=bbmpotbmi0,study1=nhs,beta1=0.015206,se1=0.06063,study2=nhs2,beta2=0.020275,se2=0.122174,study3=hpfs,beta3=-0.041214,se3=0.081398);
%inds(vbl=bbmpotbmi1,study1=nhs,beta1=-0.024937,se1=0.043062,study2=nhs2,beta2=-0.07475,se2=0.074522,study3=hpfs,beta3=-0.02875,se3=0.050762);
%inds(vbl=bbmpotbmi2,study1=nhs,beta1=0.019231,se1=0.033706,study2=nhs2,beta2=0.021974,se2=0.036124,study3=hpfs,beta3=0.064915,se3=0.063196);
%inds(vbl=bbmpothbp0,study1=nhs,beta1=0.016366,se1=0.030783,study2=nhs2,beta2=0.017274,se2=0.034897,study3=hpfs,beta3=-0.021963,se3=0.042854);
%inds(vbl=bbmpothbp1,study1=nhs,beta1=0.020973,se1=0.038938,study2=nhs2,beta2=-0.051432,se2=0.073755,study3=hpfs,beta3=0.073613,se3=0.063733);
%inds(vbl=bbmpotsmk0,study1=nhs,beta1=0.00769,se1=0.036133,study2=nhs2,beta2=0.007105,se2=0.039293,study3=hpfs,beta3=-0.015203,se3=0.052892);
%inds(vbl=bbmpotsmk1,study1=nhs,beta1=0.04641,se1=0.036991,study2=nhs2,beta2=-0.017794,se2=0.061282,study3=hpfs,beta3=0.029262,se3=0.051521);
%inds(vbl=bbmpotsmk2,study1=nhs,beta1=-0.057371,se1=0.069717,study2=nhs2,beta2=0.045837,se2=0.100634,study3=hpfs,beta3=0.003684,se3=0.135466);
%inds(vbl=bbmpotahe0,study1=nhs,beta1=0.04823,se1=0.028871,study2=nhs2,beta2=0.024362,se2=0.036852,study3=hpfs,beta3=-0.029687,se3=0.045374);
%inds(vbl=bbmpotahe1,study1=nhs,beta1=0.004173,se1=0.041048,study2=nhs2,beta2=0.048283,se2=0.053813,study3=hpfs,beta3=0.103307,se3=0.052788);
%inds(vbl=bbmpotage0,study1=nhs,beta1=0.038017,se1=0.032218,study2=nhs2,beta2=0.01538,se2=0.031955,study3=hpfs,beta3=0.049215,se3=0.052212);
%inds(vbl=bbmpotage1,study1=nhs,beta1=0.001722,se1=0.036052,study2=nhs2,beta2=0.083564,se2=0.148269,study3=hpfs,beta3=-0.01064,se3=0.048086);
%inds(vbl=fpotatact0,study1=nhs,beta1=0.143888,se1=0.086058,study2=nhs2,beta2=0.123144,se2=0.057466,study3=hpfs,beta3=0.137228,se3=0.08056);
%inds(vbl=fpotatact1,study1=nhs,beta1=0.477713,se1=0.112153,study2=nhs2,beta2=0.129567,se2=0.099674,study3=hpfs,beta3=0.361225,se3=0.099654);
%inds(vbl=fpotatbmi0,study1=nhs,beta1=0.078752,se1=0.21845,study2=nhs2,beta2=0.438069,se2=0.210016,study3=hpfs,beta3=0.40371,se3=0.156621);
%inds(vbl=fpotatbmi1,study1=nhs,beta1=0.441961,se1=0.127224,study2=nhs2,beta2=0.09384,se2=0.126378,study3=hpfs,beta3=0.244414,se3=0.091334);
%inds(vbl=fpotatbmi2,study1=nhs,beta1=0.231926,se1=0.087084,study2=nhs2,beta2=0.161665,se2=0.055135,study3=hpfs,beta3=0.095042,se3=0.103203);
%inds(vbl=fpotathbp0,study1=nhs,beta1=0.3389,se1=0.083615,study2=nhs2,beta2=0.130374,se2=0.055226,study3=hpfs,beta3=0.126556,se3=0.075997);
%inds(vbl=fpotathbp1,study1=nhs,beta1=0.075518,se1=0.119065,study2=nhs2,beta2=0.088362,se2=0.11495,study3=hpfs,beta3=0.439178,se3=0.114157);
%inds(vbl=fpotatsmk0,study1=nhs,beta1=0.37422,se1=0.101018,study2=nhs2,beta2=0.14107,se2=0.062518,study3=hpfs,beta3=0.298653,se3=0.086597);
%inds(vbl=fpotatsmk1,study1=nhs,beta1=0.266482,se1=0.104573,study2=nhs2,beta2=0.0787,se2=0.101947,study3=hpfs,beta3=0.113274,se3=0.102502);
%inds(vbl=fpotatsmk2,study1=nhs,beta1=-0.185727,se1=0.206459,study2=nhs2,beta2=0.160958,se2=0.144029,study3=hpfs,beta3=0.157491,se3=0.229659);
%inds(vbl=fpotatahe0,study1=nhs,beta1=0.252311,se1=0.075404,study2=nhs2,beta2=0.168806,se2=0.052978,study3=hpfs,beta3=0.18274,se3=0.07223);
%inds(vbl=fpotatahe1,study1=nhs,beta1=0.751592,se1=0.131686,study2=nhs2,beta2=0.208024,se2=0.107782,study3=hpfs,beta3=0.518884,se3=0.096154);
%inds(vbl=fpotatage0,study1=nhs,beta1=0.18565,se1=0.080757,study2=nhs2,beta2=0.052071,se2=0.050675,study3=hpfs,beta3=0.126349,se3=0.077277);
%inds(vbl=fpotatage1,study1=nhs,beta1=0.195766,se1=0.12257,study2=nhs2,beta2=0.320126,se2=0.264158,study3=hpfs,beta3=0.154727,se3=0.105493);
%inds(vbl=tpotatact0,study1=nhs,beta1=-0.006602,se1=0.029324,study2=nhs2,beta2=0.033726,se2=0.030431,study3=hpfs,beta3=0.019551,se3=0.038777);
%inds(vbl=tpotatact1,study1=nhs,beta1=0.128174,se1=0.034807,study2=nhs2,beta2=0.04328,se2=0.046917,study3=hpfs,beta3=0.116762,se3=0.047338);
%inds(vbl=tpotatbmi0,study1=nhs,beta1=0.0213,se1=0.058525,study2=nhs2,beta2=0.115895,se2=0.100377,study3=hpfs,beta3=0.043729,se3=0.069201);
%inds(vbl=tpotatbmi1,study1=nhs,beta1=0.016342,se1=0.040517,study2=nhs2,beta2=-0.027589,se2=0.061888,study3=hpfs,beta3=0.029028,se3=0.043062);
%inds(vbl=tpotatbmi2,study1=nhs,beta1=0.045747,se1=0.031193,study2=nhs2,beta2=0.064648,se2=0.02904,study3=hpfs,beta3=0.069796,se3=0.052517);
%inds(vbl=tpotathbp0,study1=nhs,beta1=0.052632,se1=0.028711,study2=nhs2,beta2=0.049034,se2=0.02844,study3=hpfs,beta3=0.010103,se3=0.036597);
%inds(vbl=tpotathbp1,study1=nhs,beta1=0.026287,se1=0.036918,study2=nhs2,beta2=-0.006746,se2=0.059126,study3=hpfs,beta3=0.153684,se3=0.052613);
%inds(vbl=tpotatsmk0,study1=nhs,beta1=0.045051,se1=0.033765,study2=nhs2,beta2=0.045844,se2=0.031983,study3=hpfs,beta3=0.063716,se3=0.04363);
%inds(vbl=tpotatsmk1,study1=nhs,beta1=0.06929,se1=0.034716,study2=nhs2,beta2=0.007225,se2=0.050346,study3=hpfs,beta3=0.043234,se3=0.045504);
%inds(vbl=tpotatsmk2,study1=nhs,beta1=-0.07131,se1=0.065912,study2=nhs2,beta2=0.074682,se2=0.080114,study3=hpfs,beta3=0.038592,se3=0.110474);
%inds(vbl=tpotatahe0,study1=nhs,beta1=0.072349,se1=0.026632,study2=nhs2,beta2=0.073443,se2=0.028769,study3=hpfs,beta3=0.027906,se3=0.037223);
%inds(vbl=tpotatahe1,study1=nhs,beta1=0.068918,se1=0.038367,study2=nhs2,beta2=0.079586,se2=0.04547,study3=hpfs,beta3=0.177256,se3=0.04457);
%inds(vbl=tpotatage0,study1=nhs,beta1=0.056204,se1=0.029592,study2=nhs2,beta2=0.024559,se2=0.02603,study3=hpfs,beta3=0.07023,se3=0.042319);
%inds(vbl=tpotatage1,study1=nhs,beta1=0.015968,se1=0.034714,study2=nhs2,beta2=0.148027,se2=0.122931,study3=hpfs,beta3=0.015896,se3=0.043106);

run;

data metantables;
set
bbmpotact0
bbmpotact1
bbmpotbmi0
bbmpotbmi1
bbmpotbmi2
bbmpothbp0
bbmpothbp1
bbmpotsmk0
bbmpotsmk1
bbmpotsmk2
bbmpotahe0
bbmpotahe1
bbmpotage0
bbmpotage1
fpotatact0
fpotatact1
fpotatbmi0
fpotatbmi1
fpotatbmi2
fpotathbp0
fpotathbp1
fpotatsmk0
fpotatsmk1
fpotatsmk2
fpotatahe0
fpotatahe1
fpotatage0
fpotatage1
tpotatact0
tpotatact1
tpotatbmi0
tpotatbmi1
tpotatbmi2
tpotathbp0
tpotathbp1
tpotatsmk0
tpotatsmk1
tpotatsmk2
tpotatahe0
tpotatahe1
tpotatage0
tpotatage1
;

target=substr(varp,7,4);
variable=substr(varp,1,6);
RR=varvalue;
ProbChisq=pvalue;
run;

proc sort data=metantables; by variable target ; run;



                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable7.rtf';
proc print data=metantables noobs;
    var variable target RR ProbChisq pq;
   run;
ods rtf close;


/*P-interaction*/
%inds(vbl=int_acttpotat, study1=nhs, beta1=0.10353, se1=0.03996, study2=nhs2, beta2=0.03685, se2=0.04687, study3=hpfs, beta3=0.07256, se3=0.05300);
%inds(vbl=int_hbptpotat, study1=nhs, beta1=-0.00479, se1=0.04087, study2=nhs2, beta2=-0.01474, se2=0.05538, study3=hpfs, beta3=0.11889, se3=0.05524);
%inds(vbl=int_ahetpotat, study1=nhs, beta1=0.00663, se1=0.04240, study2=nhs2, beta2=0.00744, se2=0.04858, study3=hpfs, beta3=0.11776, se3=0.05231);
%inds(vbl=int_agetpotat, study1=nhs, beta1=-0.04856, se1=0.04004, study2=nhs2, beta2=0.09755, se2=0.10286, study3=hpfs, beta3=0.01661, se3=0.05240);

%inds(vbl=int_actbbmpot, study1=nhs, beta1=0.10238, se1=0.04416, study2=nhs2, beta2=0.04780, se2=0.05940, study3=hpfs, beta3=0.08468, se3=0.06498);
%inds(vbl=int_hbpbbmpot, study1=nhs, beta1=0.01361, se1=0.04506, study2=nhs2, beta2=-0.02299, se2=0.07185, study3=hpfs, beta3=0.08252, se3=0.06837);
%inds(vbl=int_ahebbmpot, study1=nhs, beta1=-0.01330, se1=0.04585, study2=nhs2, beta2=0.02050, se2=0.05913, study3=hpfs, beta3=0.10913, se3=0.06308);
%inds(vbl=int_agebbmpot, study1=nhs, beta1=-0.02672, se1=0.04391, study2=nhs2, beta2=0.08988, se2=0.12913, study3=hpfs, beta3=0.02534, se3=0.06462);

%inds(vbl=int_actfpotat, study1=nhs, beta1=0.22594, se1=0.12517, study2=nhs2, beta2=0.05762, se2=0.10040, study3=hpfs, beta3=0.08112, se3=0.11087);
%inds(vbl=int_hbpfpotat, study1=nhs, beta1=-0.13426, se1=0.12778, study2=nhs2, beta2=-0.00641, se2=0.11211, study3=hpfs, beta3=0.30151, se3=0.11622);
%inds(vbl=int_ahefpotat, study1=nhs, beta1=0.39312, se1=0.14373, study2=nhs2, beta2=0.03119, se2=0.11391, study3=hpfs, beta3=0.23367, se3=0.10015);
%inds(vbl=int_agefpotat, study1=nhs, beta1=-0.22271, se1=0.13385, study2=nhs2, beta2=0.21943, se2=0.23406, study3=hpfs, beta3=0.07271, se3=0.11612);
run;

data metantables;
set
int_acttpotat
int_hbptpotat
int_ahetpotat
int_agetpotat
int_actbbmpot
int_hbpbbmpot
int_ahebbmpot
int_agebbmpot
int_actfpotat
int_hbpfpotat
int_ahefpotat
int_agefpotat
;

target=substr(varp,5,3);
variable=substr(varp,8,6);
RR=varvalue;
ProbChisq=pvalue;
run;

proc sort data=metantables; by variable target ; run;



                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable7_pint.rtf';
proc print data=metantables noobs;
    var variable target RR ProbChisq pq;
   run;
ods rtf close;





