/******************************************************************************************************************************************
Program name: XXX
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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=0.005492,se1=0.060221,study2=nhs2,beta2=0.073952,se2=0.04793,study3=hpfs,beta3=0.077773,se3=0.082343);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=0.075809,se1=0.054482,study2=nhs2,beta2=0.294507,se2=0.043874,study3=hpfs,beta3=0.083842,se3=0.075383);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=0.114075,se1=0.059665,study2=nhs2,beta2=0.484987,se2=0.057696,study3=hpfs,beta3=0.185941,se3=0.086882);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=0.206845,se1=0.079222,study2=nhs2,beta2=0.992172,se2=0.095625,study3=hpfs,beta3=0.279115,se3=0.129782);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.044364,se1=0.060587,study2=nhs2,beta2=0.000205,se2=0.048335,study3=hpfs,beta3=0.017426,se3=0.082831);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.047537,se1=0.055387,study2=nhs2,beta2=0.060459,se2=0.044745,study3=hpfs,beta3=-0.020213,se3=0.076125);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=-0.004977,se1=0.060712,study2=nhs2,beta2=0.107746,se2=0.058646,study3=hpfs,beta3=0.10508,se3=0.087739);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=0.070936,se1=0.081423,study2=nhs2,beta2=0.24249,se2=0.099,study3=hpfs,beta3=0.19712,se3=0.132498);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.073409,se1=0.061197,study2=nhs2,beta2=-0.03303,se2=0.049651,study3=hpfs,beta3=-0.025499,se3=0.083995);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.101496,se1=0.056567,study2=nhs2,beta2=-0.000692,se2=0.047135,study3=hpfs,beta3=-0.083302,se3=0.078159);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=-0.080002,se1=0.061979,study2=nhs2,beta2=0.024649,se2=0.061225,study3=hpfs,beta3=0.039853,se3=0.089661);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=-0.029995,se1=0.082991,study2=nhs2,beta2=0.100935,se2=0.103248,study3=hpfs,beta3=0.126806,se3=0.135411);

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

ods rtf file='stable6.exclude10.bbm.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=0.063467,se1=0.028502,study2=nhs2,beta2=0.342061,se2=0.033664,study3=hpfs,beta3=0.046436,se3=0.043655);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=0.03002,se1=0.029495,study2=nhs2,beta2=0.081274,se2=0.036601,study3=hpfs,beta3=0.046793,se3=0.044652);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=-0.01009,se1=0.030423,study2=nhs2,beta2=0.019396,se2=0.038772,study3=hpfs,beta3=0.029755,se3=0.046349);

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

ods rtf file='stable6.exclude10.bbm_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


