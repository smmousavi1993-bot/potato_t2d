/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: XXX
Purpose of the program: 
   Table 2. Associations between Baked, boiled, mashed potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis), adjustment for baseline BMI


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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=0.003649,se1=0.047392,study2=nhs2,beta2=0.087058,se2=0.041222,study3=hpfs,beta3=0.0169,se3=0.061799);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=0.068191,se1=0.043132,study2=nhs2,beta2=0.280162,se2=0.038208,study3=hpfs,beta3=0.003132,se3=0.057011);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=0.106494,se1=0.048039,study2=nhs2,beta2=0.437908,se2=0.050047,study3=hpfs,beta3=0.070608,se3=0.067801);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=0.20429,se1=0.068981,study2=nhs2,beta2=0.873534,se2=0.083087,study3=hpfs,beta3=0.116918,se3=0.107099);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.022951,se1=0.047674,study2=nhs2,beta2=0.051099,se2=0.041615,study3=hpfs,beta3=-0.016082,se3=0.062103);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.029933,se1=0.043839,study2=nhs2,beta2=0.091607,se2=0.039023,study3=hpfs,beta3=-0.056021,se3=0.057555);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=-0.006254,se1=0.048851,study2=nhs2,beta2=0.107876,se2=0.050961,study3=hpfs,beta3=0.028027,se3=0.068394);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=0.026873,se1=0.070626,study2=nhs2,beta2=0.182207,se2=0.085734,study3=hpfs,beta3=0.066957,se3=0.108725);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.059738,se1=0.048152,study2=nhs2,beta2=0.007002,se2=0.04266,study3=hpfs,beta3=-0.055526,se3=0.062878);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.094854,se1=0.044717,study2=nhs2,beta2=0.013429,se2=0.040871,study3=hpfs,beta3=-0.115643,se3=0.058877);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=-0.087764,se1=0.049781,study2=nhs2,beta2=0.003886,se2=0.052826,study3=hpfs,beta3=-0.038577,se3=0.069537);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=-0.080325,se1=0.07196,study2=nhs2,beta2=0.00378,se2=0.088993,study3=hpfs,beta3=-0.018271,se3=0.110769);

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

ods rtf file='stable5b.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=0.067563,se1=0.022721,study2=nhs2,beta2=0.270314,se2=0.026796,study3=hpfs,beta3=0.006083,se3=0.033741);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=0.020609,se1=0.023534,study2=nhs2,beta2=0.057871,se2=0.029829,study3=hpfs,beta3=0.014768,se3=0.033939);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=-0.015442,se1=0.024368,study2=nhs2,beta2=-0.011727,se2=0.031491,study3=hpfs,beta3=-0.005459,se3=0.035353);

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

ods rtf file='stable5b_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


