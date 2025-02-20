/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: XXX
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
%inds(vbl=m1cbbmpotcav1,study1=nhs,beta1=-0.079585,se1=0.133925,study2=nhs2,beta2=0.025209,se2=0.073924,study3=hpfs,beta3=0.125368,se3=0.176277);
%inds(vbl=m1cbbmpotcav2,study1=nhs,beta1=-0.056521,se1=0.129976,study2=nhs2,beta2=0.195784,se2=0.073836,study3=hpfs,beta3=0.058165,se3=0.176162);
%inds(vbl=m1cbbmpotcav3,study1=nhs,beta1=0.081446,se1=0.167831,study2=nhs2,beta2=0.313628,se2=0.106727,study3=hpfs,beta3=-0.048903,se3=0.24997);
%inds(vbl=m1cbbmpotcavm,study1=nhs,beta1=0.206541,se1=0.285901,study2=nhs2,beta2=0.707335,se2=0.186005,study3=hpfs,beta3=-0.195117,se3=0.401351);
%inds(vbl=m2cbbmpotcav1,study1=nhs,beta1=-0.109007,se1=0.135252,study2=nhs2,beta2=-0.006467,se2=0.074455,study3=hpfs,beta3=0.139417,se3=0.176929);
%inds(vbl=m2cbbmpotcav2,study1=nhs,beta1=-0.126092,se1=0.131831,study2=nhs2,beta2=0.09999,se2=0.074948,study3=hpfs,beta3=0.042988,se3=0.176658);
%inds(vbl=m2cbbmpotcav3,study1=nhs,beta1=0.024318,se1=0.17,study2=nhs2,beta2=0.139579,se2=0.107914,study3=hpfs,beta3=-0.021109,se3=0.250866);
%inds(vbl=m2cbbmpotcavm,study1=nhs,beta1=0.099539,se1=0.291152,study2=nhs2,beta2=0.356338,se2=0.189273,study3=hpfs,beta3=-0.190144,se3=0.406043);
%inds(vbl=m3cbbmpotcav1,study1=nhs,beta1=-0.121645,se1=0.138231,study2=nhs2,beta2=-0.036146,se2=0.076348,study3=hpfs,beta3=0.101966,se3=0.179841);
%inds(vbl=m3cbbmpotcav2,study1=nhs,beta1=-0.152999,se1=0.135416,study2=nhs2,beta2=0.055957,se2=0.077533,study3=hpfs,beta3=0.008365,se3=0.180822);
%inds(vbl=m3cbbmpotcav3,study1=nhs,beta1=0.009356,se1=0.17308,study2=nhs2,beta2=0.092573,se2=0.109801,study3=hpfs,beta3=-0.030805,se3=0.25406);
%inds(vbl=m3cbbmpotcavm,study1=nhs,beta1=0.075525,se1=0.296102,study2=nhs2,beta2=0.275554,se2=0.193443,study3=hpfs,beta3=-0.192194,se3=0.414612);
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

ods rtf file='stable10b_3.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1bbmpotcav,study1=nhs,beta1=0.00055,se1=0.073202,study2=nhs2,beta2=0.146678,se2=0.04667,study3=hpfs,beta3=-0.060733,se3=0.111601);
%inds(vbl=m2bbmpotcav,study1=nhs,beta1=-0.027118,se1=0.074359,study2=nhs2,beta2=0.081498,se2=0.051239,study3=hpfs,beta3=-0.051443,se3=0.116475);
%inds(vbl=m3bbmpotcav,study1=nhs,beta1=-0.031131,se1=0.077071,study2=nhs2,beta2=0.060414,se2=0.052934,study3=hpfs,beta3=-0.048417,se3=0.12019);
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

ods rtf file='stable10b_3.pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;


