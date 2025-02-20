/******************************************************************************************************************************************
Program name: /udd/nhsem/Potato.T2D/NHS/stable6.AHEI.bbm.sas
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   sTable 6. Associations between Baked, boiled, mashed potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis, adjusting for AHEI instead of food groups)


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
%metaanal(data=metaanal,beta=beta,se_or_var=s,se=se,studylab=study,pooltype=fixed,explabel=meat,
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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=-0.030957,se1=0.048152,study2=nhs2,beta2=0.021363,se2=0.042638,study3=hpfs,beta3=-0.051723,se3=0.062952);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=-0.086553,se1=0.044741,study2=nhs2,beta2=0.04017,se2=0.040913,study3=hpfs,beta3=-0.138338,se3=0.059016);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=-0.128787,se1=0.049832,study2=nhs2,beta2=-0.00113,se2=0.05288,study3=hpfs,beta3=-0.109053,se3=0.0697);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=-0.211413,se1=0.071773,study2=nhs2,beta2=-0.014298,se2=0.0886,study3=hpfs,beta3=-0.16305,se3=0.110748);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.028412,se1=0.047652,study2=nhs2,beta2=0.03161,se2=0.041566,study3=hpfs,beta3=-0.008457,se3=0.062125);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.022318,se1=0.043814,study2=nhs2,beta2=0.069286,se2=0.038946,study3=hpfs,beta3=-0.046953,se3=0.057576);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=0.028466,se1=0.048825,study2=nhs2,beta2=0.092649,se2=0.050841,study3=hpfs,beta3=0.054489,se3=0.068465);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=0.107723,se1=0.070709,study2=nhs2,beta2=0.169919,se2=0.08581,study3=hpfs,beta3=0.110241,se3=0.108965);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.055175,se1=0.047833,study2=nhs2,beta2=-0.002177,se2=0.042639,study3=hpfs,beta3=-0.031649,se3=0.062415);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.066494,se1=0.044095,study2=nhs2,beta2=0.009672,se2=0.040811,study3=hpfs,beta3=-0.07783,se3=0.057995);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=-0.029554,se1=0.049175,study2=nhs2,beta2=0.015482,se2=0.052763,study3=hpfs,beta3=0.024517,se3=0.068742);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=0.03049,se1=0.071323,study2=nhs2,beta2=0.038843,se2=0.089013,study3=hpfs,beta3=0.07735,se3=0.109584);
run;

data metantables;
set
m1cbbmpotcav1
m1cbbmpotcav2
m1cbbmpotcav3
m1cbbmpotcavm
m2cbbmpotcav1
m2cbbmpotcav2
m2cbbmpotcav3
m2cbbmpotcavm
m3cbbmpotcav1
m3cbbmpotcav2
m3cbbmpotcav3
m3cbbmpotcavm;

model=substr(varp,1,2);
variable=substr(varp,4,10);
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

ods rtf file='stable6.AHEI.bbm.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=-0.068625,se1=0.024614,study2=nhs2,beta2=-0.030734,se2=0.031524,study3=hpfs,beta3=-0.058113,se3=0.035947);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=0.052582,se1=0.023302,study2=nhs2,beta2=0.054654,se2=0.029862,study3=hpfs,beta3=0.027294,se3=0.033918);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=0.026697,se1=0.023744,study2=nhs2,beta2=0.029733,se2=0.030363,study3=hpfs,beta3=0.019169,se3=0.034326);
run;

data metantables;
set
m1bbmpotcav
m2bbmpotcav
m3bbmpotcav;

model=substr(varp,1,2);
variable=substr(varp,3,6);
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

ods rtf file='stable6.AHEI.bbm_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


