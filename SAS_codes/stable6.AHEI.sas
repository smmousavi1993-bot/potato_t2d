/******************************************************************************************************************************************
Program name: /udd/nhsem/Potato.T2D/NHS/atable6.AHEI.sas
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   Table 2. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis, adjusting for AHEI instead of food groups)


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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=0.113782,se1=0.065689,study2=nhs2,beta2=0.015464,se2=0.067151,study3=hpfs,beta3=-0.103177,se3=0.094376);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=0.116557,se1=0.060428,study2=nhs2,beta2=0.099674,se2=0.062093,study3=hpfs,beta3=-0.071517,se3=0.084928);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=0.110796,se1=0.063,study2=nhs2,beta2=0.135469,se2=0.06569,study3=hpfs,beta3=-0.074128,se3=0.088547);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.103116,se1=0.076918,study2=nhs2,beta2=0.297606,se2=0.081527,study3=hpfs,beta3=-0.014176,se3=0.103154);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.01414,se1=0.062176,study2=nhs2,beta2=0.2928,se2=0.070599,study3=hpfs,beta3=0.047786,se3=0.088171);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=0.070014,se1=0.065477,study2=nhs2,beta2=-0.036671,se2=0.066649,study3=hpfs,beta3=-0.111507,se3=0.094135);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=0.109254,se1=0.059606,study2=nhs2,beta2=0.033681,se2=0.060341,study3=hpfs,beta3=-0.031633,se3=0.083965);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=0.197104,se1=0.061799,study2=nhs2,beta2=0.088778,se2=0.063261,study3=hpfs,beta3=0.042103,se3=0.087198);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.235847,se1=0.07579,study2=nhs2,beta2=0.24684,se2=0.079292,study3=hpfs,beta3=0.172127,se3=0.101732);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.280136,se1=0.0602,study2=nhs2,beta2=0.304681,se2=0.067348,study3=hpfs,beta3=0.305514,se3=0.085817);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=0.059982,se1=0.0655,study2=nhs2,beta2=-0.049328,se2=0.066704,study3=hpfs,beta3=-0.115722,se3=0.094147);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=0.078215,se1=0.059775,study2=nhs2,beta2=0.002828,se2=0.060658,study3=hpfs,beta3=-0.045599,se3=0.084051);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=0.141049,se1=0.062231,study2=nhs2,beta2=0.039662,se2=0.063919,study3=hpfs,beta3=0.009326,se3=0.087479);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.16681,se1=0.076307,study2=nhs2,beta2=0.191958,se2=0.079988,study3=hpfs,beta3=0.128056,se3=0.102151);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.192296,se1=0.061401,study2=nhs2,beta2=0.236837,se2=0.068755,study3=hpfs,beta3=0.247571,se3=0.086747);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.113249,se1=0.032251,study2=nhs2,beta2=-0.110554,se2=0.044115,study3=hpfs,beta3=0.050346,se3=0.050052);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=0.129702,se1=0.037423,study2=nhs2,beta2=-0.099578,se2=0.046805,study3=hpfs,beta3=0.04726,se3=0.057458);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.091988,se1=0.038717,study2=nhs2,beta2=-0.114783,se2=0.047046,study3=hpfs,beta3=-0.041986,se3=0.058375);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.122712,se1=0.065907,study2=nhs2,beta2=-0.101526,se2=0.067382,study3=hpfs,beta3=-0.281895,se3=0.095986);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.065773,se1=0.0898,study2=nhs2,beta2=-0.058105,se2=0.088455,study3=hpfs,beta3=-0.478134,se3=0.128975);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.083819,se1=0.031765,study2=nhs2,beta2=-0.128706,se2=0.0437,study3=hpfs,beta3=0.043027,se3=0.049318);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=0.114872,se1=0.036356,study2=nhs2,beta2=-0.081191,se2=0.045727,study3=hpfs,beta3=0.090592,se3=0.055826);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=0.106351,se1=0.037357,study2=nhs2,beta2=-0.093365,se2=0.045522,study3=hpfs,beta3=0.06904,se3=0.056174);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.202693,se1=0.064799,study2=nhs2,beta2=0.006506,se2=0.065885,study3=hpfs,beta3=-0.081535,se3=0.094357);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.241477,se1=0.087493,study2=nhs2,beta2=0.127534,se2=0.085704,study3=hpfs,beta3=-0.06715,se3=0.124514);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=0.062153,se1=0.031896,study2=nhs2,beta2=-0.149964,se2=0.043841,study3=hpfs,beta3=0.024427,se3=0.049444);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=0.071213,se1=0.036783,study2=nhs2,beta2=-0.123641,se2=0.046235,study3=hpfs,beta3=0.049386,se3=0.056377);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=0.050367,se1=0.038005,study2=nhs2,beta2=-0.146419,se2=0.04631,study3=hpfs,beta3=0.013348,se3=0.057142);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=0.134243,se1=0.065359,study2=nhs2,beta2=-0.055405,se2=0.066673,study3=hpfs,beta3=-0.14958,se3=0.095192);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=0.110987,se1=0.089508,study2=nhs2,beta2=0.027806,se2=0.087906,study3=hpfs,beta3=-0.197594,se3=0.127411);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.188029,se1=0.02954,study2=nhs2,beta2=0.110277,se2=0.04492,study3=hpfs,beta3=0.119343,se3=0.051765);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.242764,se1=0.037638,study2=nhs2,beta2=0.197615,se2=0.048466,study3=hpfs,beta3=0.219968,se3=0.059422);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.360516,se1=0.049674,study2=nhs2,beta2=0.299294,se2=0.052108,study3=hpfs,beta3=0.279737,se3=0.064702);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=0.151241,se1=0.252769,study2=nhs2,beta2=0.514504,se2=0.114815,study3=hpfs,beta3=0.497308,se3=0.134225);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=1.10316,se1=0.179778,study2=nhs2,beta2=0.944671,se2=0.133191,study3=hpfs,beta3=0.802107,se3=0.167749);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.132853,se1=0.029123,study2=nhs2,beta2=0.032538,se2=0.044486,study3=hpfs,beta3=0.083521,se3=0.051031);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.167499,se1=0.03684,study2=nhs2,beta2=0.074489,se2=0.047707,study3=hpfs,beta3=0.204474,se3=0.058032);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.244445,se1=0.04889,study2=nhs2,beta2=0.087878,se2=0.051088,study3=hpfs,beta3=0.258822,se3=0.063095);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=-0.098119,se1=0.25269,study2=nhs2,beta2=0.187984,se2=0.113877,study3=hpfs,beta3=0.540647,se3=0.132702);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=0.681349,se1=0.177799,study2=nhs2,beta2=0.298726,se2=0.131848,study3=hpfs,beta3=0.871382,se3=0.164697);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.120753,se1=0.029799,study2=nhs2,beta2=0.030891,se2=0.045557,study3=hpfs,beta3=0.077173,se3=0.052755);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.144498,se1=0.038348,study2=nhs2,beta2=0.070916,se2=0.050362,study3=hpfs,beta3=0.191973,se3=0.061878);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.215127,se1=0.051069,study2=nhs2,beta2=0.09193,se2=0.055557,study3=hpfs,beta3=0.250345,se3=0.069285);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=-0.093354,se1=0.253412,study2=nhs2,beta2=0.18343,se2=0.116973,study3=hpfs,beta3=0.533212,se3=0.138121);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.563016,se1=0.187887,study2=nhs2,beta2=0.306754,se2=0.145692,study3=hpfs,beta3=0.845384,se3=0.182366);

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

ods rtf file='stable6.AHEI.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=-0.009792,se1=0.022869,study2=nhs2,beta2=0.089045,se2=0.025073,study3=hpfs,beta3=0.014297,se3=0.030117);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.091701,se1=0.021415,study2=nhs2,beta2=0.093694,se2=0.0238,study3=hpfs,beta3=0.095552,se3=0.028129);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=0.059317,se1=0.022076,study2=nhs2,beta2=0.068064,se2=0.024462,study3=hpfs,beta3=0.078321,se3=0.028684);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.030081,se1=0.031627,study2=nhs2,beta2=0.040161,se2=0.031005,study3=hpfs,beta3=-0.165191,se3=0.046456);
%inds(vbl=m2chipsscav,study1=nhs,beta1=0.092176,se1=0.030237,study2=nhs2,beta2=0.095291,se2=0.028906,study3=hpfs,beta3=-0.02563,se3=0.04279);
%inds(vbl=m3chipsscav,study1=nhs,beta1=0.049752,se1=0.031558,study2=nhs2,beta2=0.065323,se2=0.029992,study3=hpfs,beta3=-0.067183,se3=0.044348);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=0.485629,se1=0.066203,study2=nhs2,beta2=0.35085,se2=0.043225,study3=hpfs,beta3=0.2529,se3=0.060844);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.326252,se1=0.065771,study2=nhs2,beta2=0.161513,se2=0.047867,study3=hpfs,beta3=0.277814,se3=0.058224);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.285419,se1=0.070144,study2=nhs2,beta2=0.168943,se2=0.052946,study3=hpfs,beta3=0.257657,se3=0.064626);
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

ods rtf file='stable6.AHEI_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
