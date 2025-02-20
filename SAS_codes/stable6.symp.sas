/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   sTable 6. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis, symptomatic diabetes cases)


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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=0.060274,se1=0.126086,study2=nhs2,beta2=0.104111,se2=0.104626,study3=hpfs,beta3=-0.003633,se3=0.139373);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=0.240157,se1=0.113588,study2=nhs2,beta2=0.350513,se2=0.094762,study3=hpfs,beta3=0.128563,se3=0.124138);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=0.367287,se1=0.11689,study2=nhs2,beta2=0.621072,se2=0.098448,study3=hpfs,beta3=0.201411,se3=0.128563);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.459547,se1=0.140363,study2=nhs2,beta2=1.024461,se2=0.116736,study3=hpfs,beta3=0.455806,se3=0.144879);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.525465,se1=0.104129,study2=nhs2,beta2=1.207405,se2=0.096247,study3=hpfs,beta3=0.507028,se3=0.120846);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=0.024056,se1=0.126475,study2=nhs2,beta2=0.058864,se2=0.104903,study3=hpfs,beta3=-0.043313,se3=0.139813);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=0.091312,se1=0.11469,study2=nhs2,beta2=0.09345,se2=0.095561,study3=hpfs,beta3=0.073942,se3=0.124946);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=0.167407,se1=0.118367,study2=nhs2,beta2=0.121472,se2=0.099535,study3=hpfs,beta3=0.093444,se3=0.129679);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.224579,se1=0.142083,study2=nhs2,beta2=0.316993,se2=0.117897,study3=hpfs,beta3=0.349984,se3=0.146124);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.27891,se1=0.107627,study2=nhs2,beta2=0.278051,se2=0.099419,study3=hpfs,beta3=0.382405,se3=0.123052);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=-0.00347,se1=0.126945,study2=nhs2,beta2=0.035617,se2=0.105708,study3=hpfs,beta3=-0.063871,se3=0.140342);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=0.020573,se1=0.116208,study2=nhs2,beta2=0.027606,se2=0.098089,study3=hpfs,beta3=0.028065,se3=0.126416);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=0.06072,se1=0.120444,study2=nhs2,beta2=0.02253,se2=0.102967,study3=hpfs,beta3=-0.001553,se3=0.131678);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.100142,se1=0.144132,study2=nhs2,beta2=0.19725,se2=0.121124,study3=hpfs,beta3=0.232933,se3=0.148405);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.141675,se1=0.111609,study2=nhs2,beta2=0.14441,se2=0.10437,study3=hpfs,beta3=0.239638,se3=0.127013);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.124058,se1=0.057163,study2=nhs2,beta2=-0.080391,se2=0.062327,study3=hpfs,beta3=0.05135,se3=0.071065);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=0.209658,se1=0.064682,study2=nhs2,beta2=0.03446,se2=0.06534,study3=hpfs,beta3=0.174294,se3=0.079681);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.229826,se1=0.064901,study2=nhs2,beta2=0.087222,se2=0.064991,study3=hpfs,beta3=0.107799,se3=0.080531);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.182839,se1=0.114213,study2=nhs2,beta2=0.194036,se2=0.094363,study3=hpfs,beta3=-0.081394,se3=0.134195);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.348159,se1=0.146127,study2=nhs2,beta2=0.491075,se2=0.123968,study3=hpfs,beta3=-0.042208,se3=0.177544);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.04951,se1=0.05745,study2=nhs2,beta2=-0.233202,se2=0.06267,study3=hpfs,beta3=-0.02097,se3=0.071705);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=0.099106,se1=0.065277,study2=nhs2,beta2=-0.18158,se2=0.065882,study3=hpfs,beta3=0.088749,se3=0.080747);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=0.110559,se1=0.065799,study2=nhs2,beta2=-0.211645,se2=0.065755,study3=hpfs,beta3=0.047485,se3=0.081941);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.091,se1=0.115197,study2=nhs2,beta2=-0.055278,se2=0.095073,study3=hpfs,beta3=-0.083481,se3=0.135637);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.18806,se1=0.150956,study2=nhs2,beta2=0.085299,se2=0.130456,study3=hpfs,beta3=-0.018752,se3=0.182761);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=-0.001694,se1=0.058384,study2=nhs2,beta2=-0.278424,se2=0.063331,study3=hpfs,beta3=-0.062872,se3=0.073108);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=0.005136,se1=0.067291,study2=nhs2,beta2=-0.26756,se2=0.067666,study3=hpfs,beta3=-0.001686,se3=0.083637);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=0.004882,se1=0.068415,study2=nhs2,beta2=-0.307975,se2=0.068009,study3=hpfs,beta3=-0.078799,se3=0.085785);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=-0.033725,se1=0.1175,study2=nhs2,beta2=-0.165032,se2=0.097279,study3=hpfs,beta3=-0.205941,se3=0.138798);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=-0.026222,se1=0.157846,study2=nhs2,beta2=-0.066014,se2=0.135892,study3=hpfs,beta3=-0.270366,se3=0.192216);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.367913,se1=0.051262,study2=nhs2,beta2=0.377507,se2=0.065756,study3=hpfs,beta3=0.294454,se3=0.074425);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.559913,se1=0.062952,study2=nhs2,beta2=0.607133,se2=0.069058,study3=hpfs,beta3=0.508741,se3=0.082193);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.819882,se1=0.080113,study2=nhs2,beta2=1.006087,se2=0.072523,study3=hpfs,beta3=0.750716,se3=0.087137);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=0.410195,se1=0.502964,study2=nhs2,beta2=1.462167,se2=0.154165,study3=hpfs,beta3=1.25777,se3=0.165824);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=2.734532,se1=0.272193,study2=nhs2,beta2=2.933148,se2=0.167859,study3=hpfs,beta3=2.134443,se3=0.205638);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.175247,se1=0.051659,study2=nhs2,beta2=0.093704,se2=0.066182,study3=hpfs,beta3=0.144873,se3=0.075101);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.219048,se1=0.063805,study2=nhs2,beta2=0.079959,se2=0.069836,study3=hpfs,beta3=0.287984,se3=0.083315);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.333206,se1=0.081418,study2=nhs2,beta2=0.182702,se2=0.0738,study3=hpfs,beta3=0.396256,se3=0.089247);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=-0.36211,se1=0.503914,study2=nhs2,beta2=0.304617,se2=0.155753,study3=hpfs,beta3=0.852076,se3=0.168183);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=0.881143,se1=0.293329,study2=nhs2,beta2=0.513945,se2=0.186526,study3=hpfs,beta3=1.329413,se3=0.22015);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.119724,se1=0.053441,study2=nhs2,beta2=0.021261,se2=0.067702,study3=hpfs,beta3=0.092183,se3=0.077256);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.11319,se1=0.067499,study2=nhs2,beta2=-0.047382,se2=0.073329,study3=hpfs,beta3=0.185837,se3=0.088375);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.211891,se1=0.085262,study2=nhs2,beta2=0.031568,se2=0.078192,study3=hpfs,beta3=0.253547,se3=0.095644);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=-0.447042,se1=0.504704,study2=nhs2,beta2=0.145749,se2=0.159043,study3=hpfs,beta3=0.680123,se3=0.173455);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.410234,se1=0.314499,study2=nhs2,beta2=0.177855,se2=0.200839,study3=hpfs,beta3=0.975856,se3=0.237621);
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

ods rtf file='stable6.symp.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=0.176629,se1=0.035938,study2=nhs2,beta2=0.375157,se2=0.028213,study3=hpfs,beta3=0.151533,se3=0.03675);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.084686,se1=0.038883,study2=nhs2,beta2=0.07289,se2=0.034825,study3=hpfs,beta3=0.118419,se3=0.03861);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=0.034128,se1=0.041006,study2=nhs2,beta2=0.022451,se2=0.037082,study3=hpfs,beta3=0.083838,se3=0.041448);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.1472,se1=0.05034,study2=nhs2,beta2=0.185698,se2=0.038832,study3=hpfs,beta3=-0.050035,se3=0.060233);
%inds(vbl=m2chipsscav,study1=nhs,beta1=0.10627,se1=0.053921,study2=nhs2,beta2=0.067293,se2=0.042677,study3=hpfs,beta3=-0.039017,se3=0.060813);
%inds(vbl=m3chipsscav,study1=nhs,beta1=0.034787,se1=0.057835,study2=nhs2,beta2=0.020254,se2=0.045309,study3=hpfs,beta3=-0.111477,se3=0.066313);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=1.169541,se1=0.100715,study2=nhs2,beta2=0.728454,se2=0.035965,study3=hpfs,beta3=0.583756,se3=0.055494);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.459184,se1=0.112375,study2=nhs2,beta2=0.1953,se2=0.063717,study3=hpfs,beta3=0.387521,se3=0.06663);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.271339,se1=0.122022,study2=nhs2,beta2=0.077363,se2=0.070726,study3=hpfs,beta3=0.292338,se3=0.078585);
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

ods rtf file='stable6.symp_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
