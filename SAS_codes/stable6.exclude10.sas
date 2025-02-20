/******************************************************************************************************************************************
Program name: 
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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=0.092614,se1=0.083295,study2=nhs2,beta2=0.110342,se2=0.078118,study3=hpfs,beta3=-0.062658,se3=0.127571);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=0.24322,se1=0.075512,study2=nhs2,beta2=0.420037,se2=0.070893,study3=hpfs,beta3=0.100307,se3=0.113678);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=0.368092,se1=0.077887,study2=nhs2,beta2=0.759337,se2=0.074251,study3=hpfs,beta3=0.236798,se3=0.117594);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.373142,se1=0.098141,study2=nhs2,beta2=1.112163,se2=0.098883,study3=hpfs,beta3=0.370881,se3=0.137038);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.457765,se1=0.071412,study2=nhs2,beta2=1.396861,se2=0.076962,study3=hpfs,beta3=0.520332,se3=0.106634);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=0.047572,se1=0.083602,study2=nhs2,beta2=0.025868,se2=0.078353,study3=hpfs,beta3=-0.157522,se3=0.127926);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=0.08051,se1=0.076318,study2=nhs2,beta2=0.079706,se2=0.071534,study3=hpfs,beta3=-0.07908,se3=0.114336);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=0.154365,se1=0.07897,study2=nhs2,beta2=0.150922,se2=0.075162,study3=hpfs,beta3=-0.002175,se3=0.118389);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.136769,se1=0.099298,study2=nhs2,beta2=0.336083,se2=0.099899,study3=hpfs,beta3=0.137113,se3=0.138027);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.204492,se1=0.073987,study2=nhs2,beta2=0.349632,se2=0.080819,study3=hpfs,beta3=0.31147,se3=0.109504);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=0.033877,se1=0.083939,study2=nhs2,beta2=0.002396,se2=0.079093,study3=hpfs,beta3=-0.18398,se3=0.128595);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=0.032083,se1=0.077417,study2=nhs2,beta2=0.015534,se2=0.073764,study3=hpfs,beta3=-0.139301,se3=0.116125);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=0.066422,se1=0.080458,study2=nhs2,beta2=0.04706,se2=0.078191,study3=hpfs,beta3=-0.095165,se3=0.120684);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.029564,se1=0.100683,study2=nhs2,beta2=0.216179,se2=0.102622,study3=hpfs,beta3=0.03672,se3=0.140463);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.062562,se1=0.076709,study2=nhs2,beta2=0.197293,se2=0.085733,study3=hpfs,beta3=0.203727,se3=0.113606);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.201062,se1=0.039575,study2=nhs2,beta2=0.094431,se2=0.054849,study3=hpfs,beta3=0.161469,se3=0.065496);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=0.282158,se1=0.044178,study2=nhs2,beta2=0.219153,se2=0.056942,study3=hpfs,beta3=0.245323,se3=0.072053);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.280022,se1=0.044705,study2=nhs2,beta2=0.250977,se2=0.056401,study3=hpfs,beta3=0.190328,se3=0.071281);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.371535,se1=0.075474,study2=nhs2,beta2=0.273418,se2=0.080508,study3=hpfs,beta3=-0.024621,se3=0.114515);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.467113,se1=0.096194,study2=nhs2,beta2=0.47302,se2=0.094677,study3=hpfs,beta3=-0.060759,se3=0.1434);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.125434,se1=0.03975,study2=nhs2,beta2=-0.100223,se2=0.055028,study3=hpfs,beta3=0.0627,se3=0.065846);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=0.161143,se1=0.04456,study2=nhs2,beta2=-0.058852,se2=0.057274,study3=hpfs,beta3=0.106194,se3=0.072747);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=0.158268,se1=0.045282,study2=nhs2,beta2=-0.095991,se2=0.056834,study3=hpfs,beta3=0.063183,se3=0.07229);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.283274,se1=0.076123,study2=nhs2,beta2=-0.01417,se2=0.080975,study3=hpfs,beta3=-0.0921,se3=0.115555);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.315687,se1=0.099535,study2=nhs2,beta2=0.038511,se2=0.100169,study3=hpfs,beta3=-0.139926,se3=0.148506);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=0.093462,se1=0.040359,study2=nhs2,beta2=-0.134414,se2=0.055504,study3=hpfs,beta3=0.029858,se3=0.067119);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=0.097703,se1=0.045921,study2=nhs2,beta2=-0.12535,se2=0.058507,study3=hpfs,beta3=0.029163,se3=0.075303);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=0.078417,se1=0.047069,study2=nhs2,beta2=-0.173265,se2=0.058493,study3=hpfs,beta3=-0.032289,se3=0.075679);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=0.180277,se1=0.077733,study2=nhs2,beta2=-0.098342,se2=0.08263,study3=hpfs,beta3=-0.195472,se3=0.118433);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=0.129565,se1=0.103948,study2=nhs2,beta2=-0.091173,se2=0.104571,study3=hpfs,beta3=-0.339958,se3=0.155984);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.331492,se1=0.033791,study2=nhs2,beta2=0.41829,se2=0.053711,study3=hpfs,beta3=0.306457,se3=0.06677);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.519901,se1=0.041764,study2=nhs2,beta2=0.763874,se2=0.055914,study3=hpfs,beta3=0.539679,se3=0.07252);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.732118,se1=0.054574,study2=nhs2,beta2=1.026108,se2=0.058615,study3=hpfs,beta3=0.699543,se3=0.075922);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=0.843387,se1=0.291027,study2=nhs2,beta2=1.500476,se2=0.139735,study3=hpfs,beta3=0.883964,se3=0.167249);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=2.617318,se1=0.186423,study2=nhs2,beta2=3.047389,se2=0.134495,study3=hpfs,beta3=1.71431,se3=0.178418);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.143149,se1=0.034057,study2=nhs2,beta2=0.065653,se2=0.053928,study3=hpfs,beta3=0.111796,se3=0.067208);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.188001,se1=0.042379,study2=nhs2,beta2=0.150558,se2=0.056414,study3=hpfs,beta3=0.260025,se3=0.073358);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.274974,se1=0.055453,study2=nhs2,beta2=0.15766,se2=0.05946,study3=hpfs,beta3=0.317348,se3=0.077424);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=0.137439,se1=0.291765,study2=nhs2,beta2=0.285142,se2=0.140983,study3=hpfs,beta3=0.536564,se3=0.168813);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=0.865956,se1=0.200221,study2=nhs2,beta2=0.500446,se2=0.15003,study3=hpfs,beta3=0.948685,se3=0.192438);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.096786,se1=0.03526,study2=nhs2,beta2=0.018451,se2=0.055125,study3=hpfs,beta3=0.067431,se3=0.06917);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.098537,se1=0.044854,study2=nhs2,beta2=0.06297,se2=0.05911,study3=hpfs,beta3=0.184373,se3=0.077786);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.162235,se1=0.058093,study2=nhs2,beta2=0.052096,se2=0.062873,study3=hpfs,beta3=0.226907,se3=0.083187);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=0.035388,se1=0.292485,study2=nhs2,beta2=0.170503,se2=0.143354,study3=hpfs,beta3=0.426434,se3=0.173047);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.417605,se1=0.213819,study2=nhs2,beta2=0.211798,se2=0.161467,study3=hpfs,beta3=0.719288,se3=0.208181);
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

ods rtf file='stable6.exclude10.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=0.171732,se1=0.025556,study2=nhs2,beta2=0.501706,se2=0.025928,study3=hpfs,beta3=0.1787,se3=0.035209);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.072465,se1=0.027243,study2=nhs2,beta2=0.111794,se2=0.029309,study3=hpfs,beta3=0.112128,se3=0.037272);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=0.015826,se1=0.028636,study2=nhs2,beta2=0.049075,se2=0.031635,study3=hpfs,beta3=0.077931,se3=0.039289);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.170436,se1=0.03489,study2=nhs2,beta2=0.209253,se2=0.03431,study3=hpfs,beta3=-0.032242,se3=0.052394);
%inds(vbl=m2chipsscav,study1=nhs,beta1=0.12953,se1=0.037493,study2=nhs2,beta2=0.056977,se2=0.037106,study3=hpfs,beta3=-0.03953,se3=0.054366);
%inds(vbl=m3chipsscav,study1=nhs,beta1=0.060664,se1=0.039786,study2=nhs2,beta2=0.011181,se2=0.03905,study3=hpfs,beta3=-0.105958,se3=0.058176);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=1.15225,se1=0.072927,study2=nhs2,beta2=1.146281,se2=0.045185,study3=hpfs,beta3=0.606963,se3=0.065945);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.437435,se1=0.081045,study2=nhs2,beta2=0.239643,se2=0.057956,study3=hpfs,beta3=0.339678,se3=0.075362);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.24311,se1=0.087742,study2=nhs2,beta2=0.126935,se2=0.063261,study3=hpfs,beta3=0.243553,se3=0.082573);

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

ods rtf file='stable6.exclude10_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
