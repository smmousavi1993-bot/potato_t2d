/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   Table 5. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis), adjusted for baseline BMI


options linesize=130 pagesize=78;
filename nhstools '/proj/nhsass/nhsas00/nhstools/sasautos/';
filename channing '/usr/local/channing/sasautos/';
libname readfmt '/proj/nhsass/nhsas00/formats';
options mautosource sasautos=(channing nhstools);
options fmtsearch=(readfmt);

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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=0.118535,se1=0.06531,study2=nhs2,beta2=0.033086,se2=0.066463,study3=hpfs,beta3=-0.049267,se3=0.093848);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=0.252722,se1=0.059063,study2=nhs2,beta2=0.338421,se2=0.059802,study3=hpfs,beta3=0.079115,se3=0.083377);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=0.384569,se1=0.061054,study2=nhs2,beta2=0.644961,se2=0.06252,study3=hpfs,beta3=0.198442,se3=0.086467);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.437705,se1=0.074965,study2=nhs2,beta2=0.986353,se2=0.078529,study3=hpfs,beta3=0.318687,se3=0.100981);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.490736,se1=0.058293,study2=nhs2,beta2=1.281523,se2=0.064711,study3=hpfs,beta3=0.447088,se3=0.08403);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=0.077459,se1=0.065477,study2=nhs2,beta2=-0.014998,se2=0.066665,study3=hpfs,beta3=-0.106266,se3=0.09412);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=0.113177,se1=0.059629,study2=nhs2,beta2=0.082906,se2=0.060419,study3=hpfs,beta3=-0.032706,se3=0.083985);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=0.1824,se1=0.06182,study2=nhs2,beta2=0.14789,se2=0.063413,study3=hpfs,beta3=0.042327,se3=0.08717);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.209906,se1=0.075815,study2=nhs2,beta2=0.336391,se2=0.079448,study3=hpfs,beta3=0.164574,se3=0.101745);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.22891,se1=0.060202,study2=nhs2,beta2=0.384462,se2=0.067378,study3=hpfs,beta3=0.297084,se3=0.085667);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=0.062641,se1=0.065727,study2=nhs2,beta2=-0.043695,se2=0.067188,study3=hpfs,beta3=-0.12374,se3=0.094475);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=0.062603,se1=0.060476,study2=nhs2,beta2=0.004609,se2=0.062132,study3=hpfs,beta3=-0.082269,se3=0.085007);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=0.08937,se1=0.063003,study2=nhs2,beta2=0.022495,se2=0.065729,study3=hpfs,beta3=-0.056984,se3=0.088535);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.102696,se1=0.076961,study2=nhs2,beta2=0.189274,se2=0.081523,study3=hpfs,beta3=0.04767,se3=0.103181);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.086695,se1=0.062366,study2=nhs2,beta2=0.203379,se2=0.070979,study3=hpfs,beta3=0.148235,se3=0.088332);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.15536,se1=0.031585,study2=nhs2,beta2=0.03904,se2=0.043486,study3=hpfs,beta3=0.11863,se3=0.048905);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=0.222367,se1=0.036,study2=nhs2,beta2=0.157691,se2=0.045383,study3=hpfs,beta3=0.193799,se3=0.055116);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.220736,se1=0.036863,study2=nhs2,beta2=0.22042,se2=0.045063,study3=hpfs,beta3=0.153947,se3=0.055213);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.282513,se1=0.064262,study2=nhs2,beta2=0.265487,se2=0.065455,study3=hpfs,beta3=-0.05691,se3=0.093463);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.392797,se1=0.084714,study2=nhs2,beta2=0.537801,se2=0.081279,study3=hpfs,beta3=-0.037667,se3=0.120635);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.091669,se1=0.031775,study2=nhs2,beta2=-0.122115,se2=0.043677,study3=hpfs,beta3=0.065632,se3=0.049259);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=0.131374,se1=0.036349,study2=nhs2,beta2=-0.07214,se2=0.045706,study3=hpfs,beta3=0.111382,se3=0.055807);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=0.12749,se1=0.037331,study2=nhs2,beta2=-0.082031,se2=0.045523,study3=hpfs,beta3=0.088617,se3=0.056085);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.214787,se1=0.064779,study2=nhs2,beta2=0.009555,se2=0.065883,study3=hpfs,beta3=-0.06583,se3=0.094314);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.27578,se1=0.087081,study2=nhs2,beta2=0.133804,se2=0.085563,study3=hpfs,beta3=-0.056903,se3=0.124121);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=0.057762,se1=0.032297,study2=nhs2,beta2=-0.159048,se2=0.044101,study3=hpfs,beta3=0.030233,se3=0.050151);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=0.065029,se1=0.037466,study2=nhs2,beta2=-0.147024,se2=0.046792,study3=hpfs,beta3=0.027377,se3=0.057672);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=0.044998,se1=0.038762,study2=nhs2,beta2=-0.168736,se2=0.046968,study3=hpfs,beta3=-0.019628,se3=0.058635);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=0.113581,se1=0.06603,study2=nhs2,beta2=-0.087151,se2=0.067281,study3=hpfs,beta3=-0.185286,se3=0.096398);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=0.086058,se1=0.090729,study2=nhs2,beta2=-0.015898,se2=0.089257,study3=hpfs,beta3=-0.296222,se3=0.130307);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.344032,se1=0.028316,study2=nhs2,beta2=0.371547,se2=0.043623,study3=hpfs,beta3=0.262998,se3=0.049907);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.540146,se1=0.035098,study2=nhs2,beta2=0.689155,se2=0.045565,study3=hpfs,beta3=0.473178,se3=0.055322);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.760929,se1=0.047009,study2=nhs2,beta2=0.989285,se2=0.048245,study3=hpfs,beta3=0.648353,se3=0.059256);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=0.673804,se1=0.251801,study2=nhs2,beta2=1.404761,se2=0.111764,study3=hpfs,beta3=0.943496,se3=0.130009);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=2.695767,se1=0.158822,study2=nhs2,beta2=2.918476,se2=0.113105,study3=hpfs,beta3=1.76192,se3=0.147881);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.179998,se1=0.028556,study2=nhs2,beta2=0.086871,se2=0.043878,study3=hpfs,beta3=0.121877,se3=0.05031);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.256452,se1=0.035586,study2=nhs2,beta2=0.18121,se2=0.046101,study3=hpfs,beta3=0.268668,se3=0.056031);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.355556,se1=0.047715,study2=nhs2,beta2=0.244482,se2=0.049136,study3=hpfs,beta3=0.337518,se3=0.060501);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=0.091365,se1=0.252382,study2=nhs2,beta2=0.38272,se2=0.112878,study3=hpfs,beta3=0.642673,se3=0.131191);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=1.158955,se1=0.170734,study2=nhs2,beta2=0.767721,se2=0.125175,study3=hpfs,beta3=1.076251,se3=0.15766);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.13525,se1=0.02955,study2=nhs2,beta2=0.032552,se2=0.044889,study3=hpfs,beta3=0.075419,se3=0.051733);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.171891,se1=0.037599,study2=nhs2,beta2=0.080137,se2=0.04843,study3=hpfs,beta3=0.179953,se3=0.059383);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.244712,se1=0.049752,study2=nhs2,beta2=0.124423,se2=0.052057,study3=hpfs,beta3=0.219061,se3=0.064764);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=-0.006958,se1=0.252954,study2=nhs2,beta2=0.245537,se2=0.114975,study3=hpfs,beta3=0.493341,se3=0.134261);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.706876,se1=0.182022,study2=nhs2,beta2=0.453489,se2=0.134655,study3=hpfs,beta3=0.753171,se3=0.169874);
run;

data metantables;
set
m1ctpotatcav1
m1ctpotatcav2
m1ctpotatcav3
m1ctpotatcav4
m1ctpotatcavm
m2ctpotatcav1
m2ctpotatcav2
m2ctpotatcav3
m2ctpotatcav4
m2ctpotatcavm
m3ctpotatcav1
m3ctpotatcav2
m3ctpotatcav3
m3ctpotatcav4
m3ctpotatcavm
m1cchipsscav1
m1cchipsscav2
m1cchipsscav3
m1cchipsscav4
m1cchipsscavm
m2cchipsscav1
m2cchipsscav2
m2cchipsscav3
m2cchipsscav4
m2cchipsscavm
m3cchipsscav1
m3cchipsscav2
m3cchipsscav3
m3cchipsscav4
m3cchipsscavm
m1cfpotatcav1
m1cfpotatcav2
m1cfpotatcav3
m1cfpotatcav4
m1cfpotatcavm
m2cfpotatcav1
m2cfpotatcav2
m2cfpotatcav3
m2cfpotatcav4
m2cfpotatcavm
m3cfpotatcav1
m3cfpotatcav2
m3cfpotatcav3
m3cfpotatcav4
m3cfpotatcavm
;

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
if vb="4";
RR4=RR;
keep model va RR4;
run;


data metantables5;
set metantables;
if vb=.;
keep model va ProbChisq pq;
run;

proc sort data=metantables1; by va model; run;
proc sort data=metantables2; by va model; run;
proc sort data=metantables3; by va model; run;
proc sort data=metantables4; by va model; run;
proc sort data=metantables5; by va model; run;


data metantabless;
merge metantables1 metantables2 metantables3 metantables4 metantables5;
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

ods rtf file='stable5.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=0.166951,se1=0.02007,study2=nhs2,beta2=0.416749,se2=0.019102,study3=hpfs,beta3=0.137218,se3=0.026712);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.071888,se1=0.021579,study2=nhs2,beta2=0.121561,se2=0.023629,study3=hpfs,beta3=0.090752,se3=0.028049);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=0.020795,se1=0.022741,study2=nhs2,beta2=0.053467,se2=0.025399,study3=hpfs,beta3=0.048272,se3=0.029815);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.130155,se1=0.028294,study2=nhs2,beta2=0.219119,se2=0.026243,study3=hpfs,beta3=-0.030957,se3=0.041716);
%inds(vbl=m2chipsscav,study1=nhs,beta1=0.096887,se1=0.029704,study2=nhs2,beta2=0.096839,se2=0.02894,study3=hpfs,beta3=-0.025619,se3=0.042494);
%inds(vbl=m3chipsscav,study1=nhs,beta1=0.036035,se1=0.032048,study2=nhs2,beta2=0.050415,se2=0.030705,study3=hpfs,beta3=-0.100873,se3=0.045859);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=1.037414,se1=0.054577,study2=nhs2,beta2=0.800615,se2=0.026789,study3=hpfs,beta3=0.538795,se3=0.046206);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.497008,se1=0.062256,study2=nhs2,beta2=0.310919,se2=0.042313,study3=hpfs,beta3=0.342576,se3=0.054105);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.327612,se1=0.067448,study2=nhs2,beta2=0.208278,se2=0.047758,study3=hpfs,beta3=0.228151,se3=0.061013);
run;

data metantables;
set
m1tpotatcav
m2tpotatcav
m3tpotatcav
m1chipsscav
m2chipsscav
m3chipsscav
m1fpotatcav
m2fpotatcav
m3fpotatcav

;

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

ods rtf file='stable5_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
