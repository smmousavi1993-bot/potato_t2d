/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 8. Associations between baked, boiled, mashed potato intakes and risk of diabetes in the NHS, NHS II, and HPFS using different types of dietary assessments (Meta-analysis)


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
%inds(vbl=basebbmpotcav1,study1=nhs,beta1=-0.02013,se1=0.031322,study2=nhs2,beta2=0.012111,se2=0.031228,study3=hpfs,beta3=0.015819,se3=0.046510);
%inds(vbl=basebbmpotcav2,study1=nhs,beta1=-0.000526,se1=0.03102,study2=nhs2,beta2=0.018948,se2=0.032503,study3=hpfs,beta3=-0.007107,se3=0.046358);
%inds(vbl=basebbmpotcav3,study1=nhs,beta1=0.090489,se1=0.040832,study2=nhs2,beta2=0.081244,se2=0.048699,study3=hpfs,beta3=0.004568,se3=0.068102);
%inds(vbl=basebbmpotcavm,study1=nhs,beta1=0.12103,se1=0.049466,study2=nhs2,beta2=0.082008,se2=0.05647,study3=hpfs,beta3=-0.020481,se3=0.080356);

%inds(vbl=norebbmpotcav1,study1=nhs,beta1=-0.075802,se1=0.043962,study2=nhs2,beta2=-0.008596,se2=0.040537,study3=hpfs,beta3=0.007828,se3=0.058382);
%inds(vbl=norebbmpotcav2,study1=nhs,beta1=-0.084222,se1=0.041107,study2=nhs2,beta2=-0.003802,se2=0.039097,study3=hpfs,beta3=-0.059872,se3=0.055490);
%inds(vbl=norebbmpotcav3,study1=nhs,beta1=-0.032058,se1=0.04656,study2=nhs2,beta2=0.027752,se2=0.050513,study3=hpfs,beta3=0.032908,se3=0.067416);
%inds(vbl=norebbmpotcavm,study1=nhs,beta1=0.041173,se1=0.070186,study2=nhs2,beta2=0.05885,se2=0.08123,study3=hpfs,beta3=0.013326,se3=0.101985);

%inds(vbl=rectbbmpotcav1,study1=nhs,beta1=-0.089352,se1=0.039752,study2=nhs2,beta2=0.041054,se2=0.036379,study3=hpfs,beta3=-0.038591,se3=0.056201);
%inds(vbl=rectbbmpotcav2,study1=nhs,beta1=-0.110315,se1=0.03594,study2=nhs2,beta2=0.037956,se2=0.034058,study3=hpfs,beta3=-0.073147,se3=0.052302);
%inds(vbl=rectbbmpotcav3,study1=nhs,beta1=-0.093235,se1=0.043071,study2=nhs2,beta2=0.006941,se2=0.050483,study3=hpfs,beta3=-0.036947,se3=0.065223);
%inds(vbl=rectbbmpotcavm,study1=nhs,beta1=-0.086596,se1=0.06617,study2=nhs2,beta2=-0.001865,se2=0.083362,study3=hpfs,beta3=0.054363,se3=0.105846);

%inds(vbl=simpbbmpotcav1,study1=nhs,beta1=0.007144,se1=0.030299,study2=nhs2,beta2=0.019873,se2=0.030284,study3=hpfs,beta3=-0.055475,se3=0.045605);
%inds(vbl=simpbbmpotcav2,study1=nhs,beta1=-0.020923,se1=0.029673,study2=nhs2,beta2=0.041919,se2=0.032726,study3=hpfs,beta3=-0.087624,se3=0.046079);
%inds(vbl=simpbbmpotcav3,study1=nhs,beta1=0.026655,se1=0.042712,study2=nhs2,beta2=-0.041248,se2=0.059729,study3=hpfs,beta3=0.022782,se3=0.065058);
%inds(vbl=simpbbmpotcavm,study1=nhs,beta1=0.005000,se1=0.073067,study2=nhs2,beta2=0.016845,se2=0.059062,study3=hpfs,beta3=-0.007090,se3=0.080321);
run;

data metantables;
set
basebbmpotcav1
basebbmpotcav2
basebbmpotcav3
basebbmpotcavm
norebbmpotcav1
norebbmpotcav2
norebbmpotcav3
norebbmpotcavm
rectbbmpotcav1
rectbbmpotcav2
rectbbmpotcav3
rectbbmpotcavm
simpbbmpotcav1
simpbbmpotcav2
simpbbmpotcav3
simpbbmpotcavm
;

model=substr(varp,1,4);
variable=substr(varp,5,10);
va=substr(variable,1,6);
vb=compress(variable,,'kd');
RR=varvalue;
ProbChisq=pvalue;
run;

data metantables1;
set metantables;
if vb="1";
RR1=RR;
keep model va RR1;
run;

data metantables2;
set metantables;
if vb="2";
RR2=RR;
keep model va RR2;
run;

data metantables3;
set metantables;
if vb="3";
RR3=RR;
keep model va RR3;
run;

data metantables4;
set metantables;
if vb=.;
keep model va ProbChisq pq;
run;

proc sort data=metantables1; by va model; run;
proc sort data=metantables2; by va model; run;
proc sort data=metantables3; by va model; run;
proc sort data=metantables4; by va model; run;


data metantabless;
merge metantables1 metantables2 metantables3 metantables4;
by va model;
proc print;
run;




                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable8b.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=basebbmpotcav, study1=nhs, beta1=0.037453, se1=0.017077, study2=nhs2, beta2=0.031692, se2=0.021839, study3=hpfs, beta3=0.001891, se3=0.028185);

%inds(vbl=norebbmpotcav, study1=nhs, beta1=0.025096, se1=0.022331, study2=nhs2, beta2=0.002505, se2=0.028546, study3=hpfs, beta3=0.014556, se3=0.032741);

%inds(vbl=rectbbmpotcav, study1=nhs, beta1=-0.003595, se1=0.022579, study2=nhs2, beta2=-0.003710, se2=0.029783, study3=hpfs, beta3=-0.002612, se3=0.033160);

%inds(vbl=simpbbmpotcav, study1=nhs, beta1=0.014154, se1=0.018442, study2=nhs2, beta2=0.006350, se2=0.024002, study3=hpfs, beta3=-0.007090, se3=0.080321);

run;

data metantables;
set
basebbmpotcav
norebbmpotcav
rectbbmpotcav
simpbbmpotcav
;

model=substr(varp,1,4);
variable=substr(varp,5,6);
RR=varvalue;
ProbChisq=pvalue;
run;

proc sort data=metantables; by variable model; run;




                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable8b_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;



