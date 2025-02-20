/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   stable 6. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis) (Stop updating of diet after an intermediate outcome)


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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=0.107778,se1=0.063331,study2=nhs2,beta2=0.0093,se2=0.065958,study3=hpfs,beta3=-0.093061,se3=0.090492);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=0.218093,se1=0.057168,study2=nhs2,beta2=0.314765,se2=0.059204,study3=hpfs,beta3=0.029502,se3=0.080045);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=0.353829,se1=0.059186,study2=nhs2,beta2=0.63303,se2=0.061894,study3=hpfs,beta3=0.175124,se3=0.083065);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.409225,se1=0.072666,study2=nhs2,beta2=0.995461,se2=0.07712,study3=hpfs,beta3=0.289718,se3=0.097133);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.474234,se1=0.057595,study2=nhs2,beta2=1.314057,se2=0.064099,study3=hpfs,beta3=0.473571,se3=0.082283);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=0.081197,se1=0.063448,study2=nhs2,beta2=-0.068558,se2=0.066136,study3=hpfs,beta3=-0.123057,se3=0.090729);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=0.110912,se1=0.05757,study2=nhs2,beta2=0.013175,se2=0.05975,study3=hpfs,beta3=-0.032266,se3=0.08046);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=0.199304,se1=0.059751,study2=nhs2,beta2=0.073457,se2=0.062632,study3=hpfs,beta3=0.058029,se3=0.083649);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.207413,se1=0.073354,study2=nhs2,beta2=0.229818,se2=0.077888,study3=hpfs,beta3=0.174531,se3=0.097708);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.249652,se1=0.059073,study2=nhs2,beta2=0.318518,se2=0.066554,study3=hpfs,beta3=0.330438,se3=0.083539);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=0.068493,se1=0.063725,study2=nhs2,beta2=-0.09185,se2=0.066694,study3=hpfs,beta3=-0.137175,se3=0.091102);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=0.07033,se1=0.058494,study2=nhs2,beta2=-0.050635,se2=0.061526,study3=hpfs,beta3=-0.067131,se3=0.081571);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=0.11992,se1=0.060988,study2=nhs2,beta2=-0.029001,se2=0.065025,study3=hpfs,beta3=-0.016438,se3=0.085035);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.1043,se1=0.074535,study2=nhs2,beta2=0.110057,se2=0.080069,study3=hpfs,beta3=0.079142,se3=0.099196);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.115723,se1=0.061098,study2=nhs2,beta2=0.173039,se2=0.07011,study3=hpfs,beta3=0.210107,se3=0.08596);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.131659,se1=0.031115,study2=nhs2,beta2=0.030238,se2=0.04309,study3=hpfs,beta3=0.093385,se3=0.047821);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=0.20782,se1=0.035526,study2=nhs2,beta2=0.151733,se2=0.044981,study3=hpfs,beta3=0.15256,se3=0.054123);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.195992,se1=0.036475,study2=nhs2,beta2=0.211395,se2=0.044687,study3=hpfs,beta3=0.126313,se3=0.054242);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.277824,se1=0.063197,study2=nhs2,beta2=0.253625,se2=0.065134,study3=hpfs,beta3=-0.111691,se3=0.09306);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.389593,se1=0.084287,study2=nhs2,beta2=0.527078,se2=0.081202,study3=hpfs,beta3=-0.094004,se3=0.12145);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.082243,se1=0.031274,study2=nhs2,beta2=-0.124857,se2=0.043285,study3=hpfs,beta3=0.047173,se3=0.048164);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=0.119017,se1=0.035854,study2=nhs2,beta2=-0.078901,se2=0.045298,study3=hpfs,beta3=0.077213,se3=0.054752);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=0.10341,se1=0.036937,study2=nhs2,beta2=-0.08532,se2=0.045121,study3=hpfs,beta3=0.070269,se3=0.055096);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.202851,se1=0.063691,study2=nhs2,beta2=0.001775,se2=0.065558,study3=hpfs,beta3=-0.107382,se3=0.09389);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.241531,se1=0.086688,study2=nhs2,beta2=0.125882,se2=0.085435,study3=hpfs,beta3=-0.096171,se3=0.124943);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=0.051812,se1=0.031823,study2=nhs2,beta2=-0.15795,se2=0.043706,study3=hpfs,beta3=0.020108,se3=0.049188);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=0.053769,se1=0.036997,study2=nhs2,beta2=-0.145356,se2=0.046399,study3=hpfs,beta3=0.00669,se3=0.056668);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=0.023691,se1=0.038397,study2=nhs2,beta2=-0.161613,se2=0.04658,study3=hpfs,beta3=-0.020587,se3=0.057683);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=0.106441,se1=0.064872,study2=nhs2,beta2=-0.080995,se2=0.06697,study3=hpfs,beta3=-0.20485,se3=0.095898);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=0.057056,se1=0.090236,study2=nhs2,beta2=-0.000659,se2=0.089045,study3=hpfs,beta3=-0.299524,se3=0.130793);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.308127,se1=0.027915,study2=nhs2,beta2=0.360657,se2=0.043219,study3=hpfs,beta3=0.239362,se3=0.048841);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.507239,se1=0.03466,study2=nhs2,beta2=0.679573,se2=0.045156,study3=hpfs,beta3=0.44186,se3=0.054239);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.729203,se1=0.046588,study2=nhs2,beta2=0.973758,se2=0.047914,study3=hpfs,beta3=0.613011,se3=0.058389);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=0.608416,se1=0.251736,study2=nhs2,beta2=1.436392,se2=0.10824,study3=hpfs,beta3=0.898478,se3=0.128776);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=2.619987,se1=0.158582,study2=nhs2,beta2=2.912469,se2=0.112465,study3=hpfs,beta3=1.702587,se3=0.148659);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.150907,se1=0.028105,study2=nhs2,beta2=0.075309,se2=0.043467,study3=hpfs,beta3=0.119976,se3=0.049185);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.20832,se1=0.035117,study2=nhs2,beta2=0.14129,se2=0.045633,study3=hpfs,beta3=0.239764,se3=0.054885);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.293712,se1=0.047251,study2=nhs2,beta2=0.164804,se2=0.048697,study3=hpfs,beta3=0.311321,se3=0.059567);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=-0.033347,se1=0.252262,study2=nhs2,beta2=0.295971,se2=0.109243,study3=hpfs,beta3=0.596222,se3=0.129906);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=0.920922,se1=0.170597,study2=nhs2,beta2=0.493916,se2=0.124786,study3=hpfs,beta3=0.993835,se3=0.158678);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.107189,se1=0.029116,study2=nhs2,beta2=0.031973,se2=0.044425,study3=hpfs,beta3=0.084448,se3=0.050786);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.122613,se1=0.037119,study2=nhs2,beta2=0.055432,se2=0.047891,study3=hpfs,beta3=0.168491,se3=0.058352);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.183178,se1=0.049272,study2=nhs2,beta2=0.06158,se2=0.051523,study3=hpfs,beta3=0.212541,se3=0.063917);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=-0.149956,se1=0.252782,study2=nhs2,beta2=0.18443,se2=0.111268,study3=hpfs,beta3=0.461095,se3=0.132988);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.460118,se1=0.181657,study2=nhs2,beta2=0.220527,se2=0.133985,study3=hpfs,beta3=0.70458,se3=0.170377);
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

ods rtf file='stable6.stop.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=0.161094,se1=0.019854,study2=nhs2,beta2=0.422552,se2=0.01866,study3=hpfs,beta3=0.138894,se3=0.025256);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.080472,se1=0.021081,study2=nhs2,beta2=0.098156,se2=0.02336,study3=hpfs,beta3=0.093223,se3=0.026279);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=0.032983,se1=0.022169,study2=nhs2,beta2=0.044056,se2=0.025024,study3=hpfs,beta3=0.062796,se3=0.027942);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.123376,se1=0.02654,study2=nhs2,beta2=0.223382,se2=0.02594,study3=hpfs,beta3=-0.034735,se3=0.041077);
%inds(vbl=m2chipsscav,study1=nhs,beta1=0.078848,se1=0.028269,study2=nhs2,beta2=0.098614,se2=0.028534,study3=hpfs,beta3=-0.035364,se3=0.04222);
%inds(vbl=m3chipsscav,study1=nhs,beta1=0.019149,se1=0.031128,study2=nhs2,beta2=0.060852,se2=0.030229,study3=hpfs,beta3=-0.100299,se3=0.045218);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=1.014286,se1=0.053247,study2=nhs2,beta2=0.805616,se2=0.026575,study3=hpfs,beta3=0.409954,se3=0.033599);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.402674,se1=0.06123,study2=nhs2,beta2=0.226773,se2=0.044096,study3=hpfs,beta3=0.238098,se3=0.041149);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.224413,se1=0.066206,study2=nhs2,beta2=0.132013,se2=0.048411,study3=hpfs,beta3=0.173302,se3=0.049737);
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

ods rtf file='stable6.stop_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
