/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   sTable 6. Associations between Baked, boiled, mashed potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis, symptomatic diabetes cases)


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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=0.017971,se1=0.090068,study2=nhs2,beta2=0.113094,se2=0.063842,study3=hpfs,beta3=0.044626,se3=0.08977);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=0.067138,se1=0.081775,study2=nhs2,beta2=0.282564,se2=0.059648,study3=hpfs,beta3=-0.014186,se3=0.083848);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=0.06619,se1=0.089557,study2=nhs2,beta2=0.414606,se2=0.076972,study3=hpfs,beta3=0.016385,se3=0.100443);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=0.092486,se1=0.121496,study2=nhs2,beta2=0.784295,se2=0.127009,study3=hpfs,beta3=-0.027971,se3=0.159646);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.019525,se1=0.090607,study2=nhs2,beta2=0.094049,se2=0.06445,study3=hpfs,beta3=0.06363,se3=0.090204);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.034825,se1=0.083086,study2=nhs2,beta2=0.118156,se2=0.060872,study3=hpfs,beta3=-0.001644,se3=0.084546);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=-0.031531,se1=0.091102,study2=nhs2,beta2=0.11609,se2=0.078307,study3=hpfs,beta3=0.072017,se3=0.10139);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=-0.028539,se1=0.124699,study2=nhs2,beta2=0.143737,se2=0.130645,study3=hpfs,beta3=0.057314,se3=0.161734);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.070035,se1=0.091511,study2=nhs2,beta2=0.083613,se2=0.066096,study3=hpfs,beta3=0.024915,se3=0.091399);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.108437,se1=0.084722,study2=nhs2,beta2=0.088895,se2=0.063577,study3=hpfs,beta3=-0.058576,se3=0.086518);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=-0.120398,se1=0.092835,study2=nhs2,beta2=0.076053,se2=0.081085,study3=hpfs,beta3=0.010983,se3=0.10317);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=-0.127334,se1=0.127071,study2=nhs2,beta2=0.059465,se2=0.134919,study3=hpfs,beta3=-0.021163,se3=0.165166);
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

ods rtf file='stable6.symp.bbm.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=0.062968,se1=0.041115,study2=nhs2,beta2=0.216259,se2=0.040118,study3=hpfs,beta3=-0.019034,se3=0.04898);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=0.038645,se1=0.042367,study2=nhs2,beta2=0.029329,se2=0.044077,study3=hpfs,beta3=0.023616,se3=0.048423);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=0.005838,se1=0.043785,study2=nhs2,beta2=-0.001886,se2=0.045974,study3=hpfs,beta3=0.011438,se3=0.050704);
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

ods rtf file='stable6.symp.bbm_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


