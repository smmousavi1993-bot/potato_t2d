/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   Table 2. Associations between Baked, boiled, mashed potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis)


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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=0.003333,se1=0.046182,study2=nhs2,beta2=0.086329,se2=0.041047,study3=hpfs,beta3=-0.002401,se3=0.059988);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=0.04236,se1=0.042081,study2=nhs2,beta2=0.272198,se2=0.038084,study3=hpfs,beta3=-0.029502,se3=0.055512);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=0.068146,se1=0.047158,study2=nhs2,beta2=0.440708,se2=0.049798,study3=hpfs,beta3=0.044058,se3=0.066566);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=0.130967,se1=0.068852,study2=nhs2,beta2=0.873745,se2=0.082912,study3=hpfs,beta3=0.084816,se3=0.106741);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.00967,se1=0.046388,study2=nhs2,beta2=0.028926,se2=0.041373,study3=hpfs,beta3=-0.012912,se3=0.060264);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.016785,se1=0.042614,study2=nhs2,beta2=0.066943,se2=0.038805,study3=hpfs,beta3=-0.039155,se3=0.055894);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=0.02381,se1=0.047772,study2=nhs2,beta2=0.091547,se2=0.050581,study3=hpfs,beta3=0.078747,se3=0.066949);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=0.070264,se1=0.070282,study2=nhs2,beta2=0.17037,se2=0.08543,study3=hpfs,beta3=0.164161,se3=0.107743);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.039701,se1=0.046926,study2=nhs2,beta2=-0.002619,se2=0.04245,study3=hpfs,beta3=-0.044294,se3=0.061084);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.065096,se1=0.043597,study2=nhs2,beta2=0.0096,se2=0.040668,study3=hpfs,beta3=-0.081147,se3=0.057292);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=-0.041357,se1=0.048761,study2=nhs2,beta2=0.015853,se2=0.052485,study3=hpfs,beta3=0.034457,se3=0.068041);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=-0.017315,se1=0.071486,study2=nhs2,beta2=0.040186,se2=0.088562,study3=hpfs,beta3=0.114691,se3=0.109505);
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

ods rtf file='stable6.stop.bbm.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=0.060581,se1=0.022501,study2=nhs2,beta2=0.280642,se2=0.02624,study3=hpfs,beta3=0.015365,se3=0.032786);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=0.041929,se1=0.022997,study2=nhs2,beta2=0.0596,se2=0.029394,study3=hpfs,beta3=0.033064,se3=0.032455);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=0.009389,se1=0.023749,study2=nhs2,beta2=0.009336,se2=0.030928,study3=hpfs,beta3=0.021419,se3=0.03362);
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

ods rtf file='stable6.stop.bbm_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


