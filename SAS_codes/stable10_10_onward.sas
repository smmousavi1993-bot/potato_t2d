/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: XXX
Purpose of the program: 
   Table 2. Associations between potato intakes and risk of diabetes in the NHS, NHS II, and HPFS (Meta-analysis)


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
%inds(vbl=m1ctpotatcav1,study1=nhs,beta1=-0.196112,se1=0.175177,study2=nhs2,beta2=0.158727,se2=0.119793,study3=hpfs,beta3=0.260118,se3=0.321144);
%inds(vbl=m1ctpotatcav2,study1=nhs,beta1=-0.123003,se1=0.15785,study2=nhs2,beta2=0.311521,se2=0.109479,study3=hpfs,beta3=0.379979,se3=0.297076);
%inds(vbl=m1ctpotatcav3,study1=nhs,beta1=-0.004878,se1=0.164029,study2=nhs2,beta2=0.460518,se2=0.113575,study3=hpfs,beta3=0.539989,se3=0.302732);
%inds(vbl=m1ctpotatcav4,study1=nhs,beta1=0.217351,se1=0.193658,study2=nhs2,beta2=0.660162,se2=0.130724,study3=hpfs,beta3=0.707544,se3=0.327022);
%inds(vbl=m1ctpotatcavm,study1=nhs,beta1=0.421418,se1=0.192332,study2=nhs2,beta2=0.712458,se2=0.118109,study3=hpfs,beta3=0.641759,se3=0.249934);
%inds(vbl=m2ctpotatcav1,study1=nhs,beta1=-0.230792,se1=0.176117,study2=nhs2,beta2=0.071834,se2=0.119886,study3=hpfs,beta3=0.191054,se3=0.322078);
%inds(vbl=m2ctpotatcav2,study1=nhs,beta1=-0.205972,se1=0.16001,study2=nhs2,beta2=0.127284,se2=0.109954,study3=hpfs,beta3=0.284724,se3=0.298474);
%inds(vbl=m2ctpotatcav3,study1=nhs,beta1=-0.161871,se1=0.166631,study2=nhs2,beta2=0.190255,se2=0.114414,study3=hpfs,beta3=0.392981,se3=0.305031);
%inds(vbl=m2ctpotatcav4,study1=nhs,beta1=0.068512,se1=0.196569,study2=nhs2,beta2=0.239822,se2=0.131748,study3=hpfs,beta3=0.498396,se3=0.32988);
%inds(vbl=m2ctpotatcavm,study1=nhs,beta1=0.237403,se1=0.196936,study2=nhs2,beta2=0.255434,se2=0.120295,study3=hpfs,beta3=0.43757,se3=0.253578);
%inds(vbl=m3ctpotatcav1,study1=nhs,beta1=-0.234918,se1=0.177629,study2=nhs2,beta2=0.03768,se2=0.120705,study3=hpfs,beta3=0.163455,se3=0.323591);
%inds(vbl=m3ctpotatcav2,study1=nhs,beta1=-0.225609,se1=0.16441,study2=nhs2,beta2=0.06498,se2=0.112603,study3=hpfs,beta3=0.238848,se3=0.302528);
%inds(vbl=m3ctpotatcav3,study1=nhs,beta1=-0.199477,se1=0.173126,study2=nhs2,beta2=0.104349,se2=0.118033,study3=hpfs,beta3=0.319854,se3=0.310165);
%inds(vbl=m3ctpotatcav4,study1=nhs,beta1=0.017713,se1=0.202936,study2=nhs2,beta2=0.132289,se2=0.136074,study3=hpfs,beta3=0.376567,se3=0.336542);
%inds(vbl=m3ctpotatcavm,study1=nhs,beta1=0.185333,se1=0.204081,study2=nhs2,beta2=0.144712,se2=0.125984,study3=hpfs,beta3=0.309313,se3=0.26258);
%inds(vbl=m1cchipsscav1,study1=nhs,beta1=0.077328,se1=0.113582,study2=nhs2,beta2=0.162953,se2=0.074635,study3=hpfs,beta3=0.298036,se3=0.178406);
%inds(vbl=m1cchipsscav2,study1=nhs,beta1=-0.025227,se1=0.128266,study2=nhs2,beta2=0.269102,se2=0.077831,study3=hpfs,beta3=0.439163,se3=0.183542);
%inds(vbl=m1cchipsscav3,study1=nhs,beta1=0.050282,se1=0.145375,study2=nhs2,beta2=0.238325,se2=0.085638,study3=hpfs,beta3=0.378187,se3=0.195611);
%inds(vbl=m1cchipsscav4,study1=nhs,beta1=0.315573,se1=0.216894,study2=nhs2,beta2=0.360623,se2=0.128781,study3=hpfs,beta3=0.275281,se3=0.28035);
%inds(vbl=m1cchipsscavm,study1=nhs,beta1=0.383042,se1=0.330921,study2=nhs2,beta2=0.505901,se2=0.180225,study3=hpfs,beta3=0.292936,se3=0.374899);
%inds(vbl=m2cchipsscav1,study1=nhs,beta1=0.010505,se1=0.11426,study2=nhs2,beta2=0.058538,se2=0.074869,study3=hpfs,beta3=0.187681,se3=0.179345);
%inds(vbl=m2cchipsscav2,study1=nhs,beta1=-0.12847,se1=0.129136,study2=nhs2,beta2=0.107931,se2=0.078308,study3=hpfs,beta3=0.257294,se3=0.185415);
%inds(vbl=m2cchipsscav3,study1=nhs,beta1=-0.043878,se1=0.147109,study2=nhs2,beta2=0.059146,se2=0.086356,study3=hpfs,beta3=0.229876,se3=0.198206);
%inds(vbl=m2cchipsscav4,study1=nhs,beta1=0.317708,se1=0.217819,study2=nhs2,beta2=0.187981,se2=0.129359,study3=hpfs,beta3=0.159436,se3=0.28218);
%inds(vbl=m2cchipsscavm,study1=nhs,beta1=0.353372,se1=0.341578,study2=nhs2,beta2=0.222724,se2=0.186676,study3=hpfs,beta3=0.154629,se3=0.387745);
%inds(vbl=m3cchipsscav1,study1=nhs,beta1=-0.016294,se1=0.116098,study2=nhs2,beta2=0.025712,se2=0.076136,study3=hpfs,beta3=0.15987,se3=0.183391);
%inds(vbl=m3cchipsscav2,study1=nhs,beta1=-0.169678,se1=0.133537,study2=nhs2,beta2=0.041977,se2=0.081196,study3=hpfs,beta3=0.178051,se3=0.193427);
%inds(vbl=m3cchipsscav3,study1=nhs,beta1=-0.098815,se1=0.152454,study2=nhs2,beta2=-0.022752,se2=0.09016,study3=hpfs,beta3=0.132011,se3=0.206924);
%inds(vbl=m3cchipsscav4,study1=nhs,beta1=0.280882,se1=0.222916,study2=nhs2,beta2=0.115797,se2=0.132821,study3=hpfs,beta3=0.066463,se3=0.289946);
%inds(vbl=m3cchipsscavm,study1=nhs,beta1=0.298237,se1=0.354311,study2=nhs2,beta2=0.084977,se2=0.196138,study3=hpfs,beta3=-0.032937,se3=0.406042);
%inds(vbl=m1cfpotatcav1,study1=nhs,beta1=0.250742,se1=0.103022,study2=nhs2,beta2=0.278889,se2=0.072306,study3=hpfs,beta3=0.503418,se3=0.181908);
%inds(vbl=m1cfpotatcav2,study1=nhs,beta1=0.326963,se1=0.127817,study2=nhs2,beta2=0.417018,se2=0.078021,study3=hpfs,beta3=0.765709,se3=0.188082);
%inds(vbl=m1cfpotatcav3,study1=nhs,beta1=0.64556,se1=0.205551,study2=nhs2,beta2=0.737768,se2=0.093783,study3=hpfs,beta3=0.859655,se3=0.209193);
%inds(vbl=m1cfpotatcav4,study1=nhs,beta1=-10.91783,se1=233.73245,study2=nhs2,beta2=0.787712,se2=0.239937,study3=hpfs,beta3=0.701312,se3=0.444076);
%inds(vbl=m1cfpotatcavm,study1=nhs,beta1=1.717483,se1=0.67168,study2=nhs2,beta2=2.029639,se2=0.26295,study3=hpfs,beta3=1.477033,se3=0.473127);
%inds(vbl=m2cfpotatcav1,study1=nhs,beta1=0.136844,se1=0.103611,study2=nhs2,beta2=0.109998,se2=0.072552,study3=hpfs,beta3=0.389643,se3=0.182742);
%inds(vbl=m2cfpotatcav2,study1=nhs,beta1=0.164559,se1=0.128833,study2=nhs2,beta2=0.12686,se2=0.078589,study3=hpfs,beta3=0.595252,se3=0.190053);
%inds(vbl=m2cfpotatcav3,study1=nhs,beta1=0.418008,se1=0.206966,study2=nhs2,beta2=0.237595,se2=0.094767,study3=hpfs,beta3=0.604914,se3=0.211599);
%inds(vbl=m2cfpotatcav4,study1=nhs,beta1=-10.9127,se1=212.63892,study2=nhs2,beta2=0.275274,se2=0.241469,study3=hpfs,beta3=0.363121,se3=0.44709);
%inds(vbl=m2cfpotatcavm,study1=nhs,beta1=0.89655,se1=0.716713,study2=nhs2,beta2=0.655653,se2=0.287449,study3=hpfs,beta3=0.847185,se3=0.495727);
%inds(vbl=m3cfpotatcav1,study1=nhs,beta1=0.111859,se1=0.108215,study2=nhs2,beta2=0.065638,se2=0.075083,study3=hpfs,beta3=0.33911,se3=0.189776);
%inds(vbl=m3cfpotatcav2,study1=nhs,beta1=0.146694,se1=0.137259,study2=nhs2,beta2=0.036714,se2=0.084267,study3=hpfs,beta3=0.505867,se3=0.203548);
%inds(vbl=m3cfpotatcav3,study1=nhs,beta1=0.373595,se1=0.213604,study2=nhs2,beta2=0.126721,se2=0.101344,study3=hpfs,beta3=0.488702,se3=0.227263);
%inds(vbl=m3cfpotatcav4,study1=nhs,beta1=-10.94559,se1=217.46478,study2=nhs2,beta2=0.17689,se2=0.246393,study3=hpfs,beta3=0.204803,se3=0.460241);
%inds(vbl=m3cfpotatcavm,study1=nhs,beta1=0.74481,se1=0.760526,study2=nhs2,beta2=0.347836,se2=0.312307,study3=hpfs,beta3=0.466134,se3=0.539893);

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

ods rtf file='stable10.3.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=m1tpotatcav,study1=nhs,beta1=0.053052,se1=0.064575,study2=nhs2,beta2=0.225121,se2=0.035497,study3=hpfs,beta3=0.08077,se3=0.083275);
%inds(vbl=m2tpotatcav,study1=nhs,beta1=0.004001,se1=0.067421,study2=nhs2,beta2=0.097953,se2=0.040673,study3=hpfs,beta3=0.033447,se3=0.090154);
%inds(vbl=m3tpotatcav,study1=nhs,beta1=-0.006667,se1=0.070687,study2=nhs2,beta2=0.06665,se2=0.043163,study3=hpfs,beta3=-0.007522,se3=0.094662);
%inds(vbl=m1chipsscav,study1=nhs,beta1=0.005278,se1=0.080162,study2=nhs2,beta2=0.094033,se2=0.047872,study3=hpfs,beta3=0.024461,se3=0.097355);
%inds(vbl=m2chipsscav,study1=nhs,beta1=-0.000041,se1=0.082936,study2=nhs2,beta2=0.034429,se2=0.051329,study3=hpfs,beta3=0.002558,se3=0.107176);
%inds(vbl=m3chipsscav,study1=nhs,beta1=-0.011788,se1=0.08788,study2=nhs2,beta2=-0.000355,se2=0.055201,study3=hpfs,beta3=-0.049174,se3=0.116205);
%inds(vbl=m1fpotatcav,study1=nhs,beta1=0.445359,se1=0.17374,study2=nhs2,beta2=0.427132,se2=0.052173,study3=hpfs,beta3=0.365316,se3=0.134228);
%inds(vbl=m2fpotatcav,study1=nhs,beta1=0.226862,se1=0.184977,study2=nhs2,beta2=0.15208,se2=0.070949,study3=hpfs,beta3=0.182433,se3=0.14385);
%inds(vbl=m3fpotatcav,study1=nhs,beta1=0.190084,se1=0.199023,study2=nhs2,beta2=0.082784,se2=0.080697,study3=hpfs,beta3=0.062822,se3=0.158976);


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

ods rtf file='stable10.3_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;
