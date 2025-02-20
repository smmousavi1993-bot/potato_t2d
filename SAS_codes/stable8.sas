/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 8. Associations between Potato intakes and risk of diabetes in the NHS, NHS II, and HPFS using different types of dietary assessments (Meta-analysis)


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
%metaanal(data=metaanal,beta=beta,se_or_var=s,se=se,studylab=study,pooltype=fixed,explabel=potato,
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
%inds(vbl=basetpotatcav1,study1=nhs,beta1=0.085355,se1=0.041087,study2=nhs2,beta2=-0.088989,se2=0.046841,study3=hpfs,beta3=-0.057877,se3=0.066734);
%inds(vbl=basetpotatcav2,study1=nhs,beta1=0.078774,se1=0.039186,study2=nhs2,beta2=-0.036213,se2=0.04351,study3=hpfs,beta3=-0.009838,se3=0.061447);
%inds(vbl=basetpotatcav3,study1=nhs,beta1=0.124812,se1=0.041334,study2=nhs2,beta2=-0.027473,se2=0.045726,study3=hpfs,beta3=0.05839,se3=0.064028);
%inds(vbl=basetpotatcav4,study1=nhs,beta1=0.18421,se1=0.048062,study2=nhs2,beta2=0.041857,se2=0.05254,study3=hpfs,beta3=0.066012,se3=0.073034);
%inds(vbl=basetpotatcavm,study1=nhs,beta1=0.167306,se1=0.045833,study2=nhs2,beta2=0.106858,se2=0.050728,study3=hpfs,beta3=0.154954,se3=0.07136);
%inds(vbl=basechipsscav1,study1=nhs,beta1=0.026194,se1=0.026353,study2=nhs2,beta2=-0.106417,se2=0.030646,study3=hpfs,beta3=-0.027917,se3=0.0424);
%inds(vbl=basechipsscav2,study1=nhs,beta1=0.023712,se1=0.030499,study2=nhs2,beta2=-0.102749,se2=0.032674,study3=hpfs,beta3=-0.028232,se3=0.048276);
%inds(vbl=basechipsscav3,study1=nhs,beta1=-0.040485,se1=0.038181,study2=nhs2,beta2=-0.092508,se2=0.037365,study3=hpfs,beta3=-0.020415,se3=0.055088);
%inds(vbl=basechipsscav4,study1=nhs,beta1=0.005369,se1=0.066975,study2=nhs2,beta2=-0.10723,se2=0.061319,study3=hpfs,beta3=-0.277808,se3=0.10252);
%inds(vbl=basechipsscavm,study1=nhs,beta1=-0.06379,se1=0.065864,study2=nhs2,beta2=-0.074472,se2=0.061647,study3=hpfs,beta3=-0.183472,se3=0.095809);
%inds(vbl=basefpotatcav1,study1=nhs,beta1=0.081827,se1=0.025109,study2=nhs2,beta2=-0.011195,se2=0.030372,study3=hpfs,beta3=0.077964,se3=0.042569);
%inds(vbl=basefpotatcav2,study1=nhs,beta1=0.069389,se1=0.032329,study2=nhs2,beta2=0.033674,se2=0.034008,study3=hpfs,beta3=0.112708,se3=0.049556);
%inds(vbl=basefpotatcav3,study1=nhs,beta1=0.148657,se1=0.053574,study2=nhs2,beta2=0.035501,se2=0.044362,study3=hpfs,beta3=0.186665,se3=0.060478);
%inds(vbl=basefpotatcav4,study1=nhs,beta1=0.119399,se1=0.211408,study2=nhs2,beta2=0.32116,se2=0.097279,study3=hpfs,beta3=0.35889,se3=0.13126);
%inds(vbl=basefpotatcavm,study1=nhs,beta1=0.301982,se1=0.111094,study2=nhs2,beta2=0.211757,se2=0.084185,study3=hpfs,beta3=0.39609,se3=0.113424);
%inds(vbl=noretpotatcav1,study1=nhs,beta1=0.015531,se1=0.059385,study2=nhs2,beta2=-0.078986,se2=0.063845,study3=hpfs,beta3=-0.177342,se3=0.085095);
%inds(vbl=noretpotatcav2,study1=nhs,beta1=0.038597,se1=0.054489,study2=nhs2,beta2=-0.041931,se2=0.058668,study3=hpfs,beta3=-0.087505,se3=0.076017);
%inds(vbl=noretpotatcav3,study1=nhs,beta1=0.104638,se1=0.056922,study2=nhs2,beta2=-0.012119,se2=0.061687,study3=hpfs,beta3=-0.100148,se3=0.079597);
%inds(vbl=noretpotatcav4,study1=nhs,beta1=0.088488,se1=0.069253,study2=nhs2,beta2=0.050298,se2=0.074518,study3=hpfs,beta3=0.067701,se3=0.091964);
%inds(vbl=noretpotatcavm,study1=nhs,beta1=0.148401,se1=0.058922,study2=nhs2,beta2=0.130985,se2=0.066207,study3=hpfs,beta3=0.16149,se3=0.083855);
%inds(vbl=norechipsscav1,study1=nhs,beta1=0.036095,se1=0.030572,study2=nhs2,beta2=-0.133706,se2=0.039913,study3=hpfs,beta3=-0.020677,se3=0.047562);
%inds(vbl=norechipsscav2,study1=nhs,beta1=0.020524,se1=0.035898,study2=nhs2,beta2=-0.119617,se2=0.042693,study3=hpfs,beta3=0.008228,se3=0.054801);
%inds(vbl=norechipsscav3,study1=nhs,beta1=-0.002563,se1=0.037567,study2=nhs2,beta2=-0.147389,se2=0.043286,study3=hpfs,beta3=-0.011999,se3=0.056369);
%inds(vbl=norechipsscav4,study1=nhs,beta1=0.080049,se1=0.063758,study2=nhs2,beta2=-0.067956,se2=0.063917,study3=hpfs,beta3=-0.175448,se3=0.094083);
%inds(vbl=norechipsscavm,study1=nhs,beta1=0.022191,se1=0.086967,study2=nhs2,beta2=-0.041826,se2=0.082883,study3=hpfs,beta3=-0.184684,se3=0.118583);
%inds(vbl=norefpotatcav1,study1=nhs,beta1=0.104541,se1=0.028425,study2=nhs2,beta2=-0.02551,se2=0.040192,study3=hpfs,beta3=0.063835,se3=0.04886);
%inds(vbl=norefpotatcav2,study1=nhs,beta1=0.131026,se1=0.036257,study2=nhs2,beta2=0.007475,se2=0.04378,study3=hpfs,beta3=0.149389,se3=0.056502);
%inds(vbl=norefpotatcav3,study1=nhs,beta1=0.164689,se1=0.049054,study2=nhs2,beta2=0.0311,se2=0.047935,study3=hpfs,beta3=0.217933,se3=0.062361);
%inds(vbl=norefpotatcav4,study1=nhs,beta1=0.115047,se1=0.211721,study2=nhs2,beta2=0.109238,se2=0.106515,study3=hpfs,beta3=0.353542,se3=0.133511);
%inds(vbl=norefpotatcavm,study1=nhs,beta1=0.478059,se1=0.164032,study2=nhs2,beta2=0.219285,se2=0.124603,study3=hpfs,beta3=0.61905,se3=0.155932);
%inds(vbl=recttpotatcav1,study1=nhs,beta1=-0.056502,se1=0.048626,study2=nhs2,beta2=-0.039591,se2=0.047334,study3=hpfs,beta3=-0.024804,se3=0.077059);
%inds(vbl=recttpotatcav2,study1=nhs,beta1=-0.065669,se1=0.043424,study2=nhs2,beta2=-0.02191,se2=0.043245,study3=hpfs,beta3=-0.015406,se3=0.069138);
%inds(vbl=recttpotatcav3,study1=nhs,beta1=-0.026078,se1=0.047021,study2=nhs2,beta2=-0.01245,se2=0.048877,study3=hpfs,beta3=-0.011119,se3=0.073929);
%inds(vbl=recttpotatcav4,study1=nhs,beta1=0.019739,se1=0.063575,study2=nhs2,beta2=0.076319,se2=0.068579,study3=hpfs,beta3=0.098853,se3=0.089704);
%inds(vbl=recttpotatcavm,study1=nhs,beta1=0.079727,se1=0.058814,study2=nhs2,beta2=0.083688,se2=0.067268,study3=hpfs,beta3=0.10666,se3=0.083967);
%inds(vbl=rectchipsscav1,study1=nhs,beta1=0.049612,se1=0.027631,study2=nhs2,beta2=-0.112769,se2=0.035865,study3=hpfs,beta3=-0.060193,se3=0.045263);
%inds(vbl=rectchipsscav2,study1=nhs,beta1=0.051541,se1=0.03564,study2=nhs2,beta2=-0.1334,se2=0.041291,study3=hpfs,beta3=-0.009667,se3=0.054509);
%inds(vbl=rectchipsscav3,study1=nhs,beta1=0.053356,se1=0.034952,study2=nhs2,beta2=-0.090894,se2=0.03949,study3=hpfs,beta3=-0.124154,se3=0.054902);
%inds(vbl=rectchipsscav4,study1=nhs,beta1=0.137859,se1=0.064326,study2=nhs2,beta2=-0.049183,se2=0.062536,study3=hpfs,beta3=-0.165099,se3=0.092215);
%inds(vbl=rectchipsscavm,study1=nhs,beta1=0.164097,se1=0.08842,study2=nhs2,beta2=0.029468,se2=0.080992,study3=hpfs,beta3=-0.294057,se3=0.124299);
%inds(vbl=rectfpotatcav1,study1=nhs,beta1=0.075859,se1=0.025078,study2=nhs2,beta2=0.016705,se2=0.033988,study3=hpfs,beta3=0.05267,se3=0.045426);
%inds(vbl=rectfpotatcav2,study1=nhs,beta1=0.112168,se1=0.036021,study2=nhs2,beta2=0.030285,se2=0.040165,study3=hpfs,beta3=0.125002,se3=0.055146);
%inds(vbl=rectfpotatcav3,study1=nhs,beta1=0.16905,se1=0.050006,study2=nhs2,beta2=0.052317,se2=0.044024,study3=hpfs,beta3=0.164522,se3=0.061386);
%inds(vbl=rectfpotatcav4,study1=nhs,beta1=0.067925,se1=0.23792,study2=nhs2,beta2=0.254355,se2=0.107047,study3=hpfs,beta3=0.327588,se3=0.141042);
%inds(vbl=rectfpotatcavm,study1=nhs,beta1=0.585606,se1=0.17389,study2=nhs2,beta2=0.282718,se2=0.126484,study3=hpfs,beta3=0.531245,se3=0.167629);
%inds(vbl=simptpotatcav1,study1=nhs,beta1=0.012781,se1=0.035335,study2=nhs2,beta2=-0.040453,se2=0.038682,study3=hpfs,beta3=-0.001558,se3=0.058195);
%inds(vbl=simptpotatcav2,study1=nhs,beta1=0.014726,se1=0.033412,study2=nhs2,beta2=0.035823,se2=0.036982,study3=hpfs,beta3=-0.042789,se3=0.054931);
%inds(vbl=simptpotatcav3,study1=nhs,beta1=0.060333,se1=0.037188,study2=nhs2,beta2=0.02363,se2=0.040847,study3=hpfs,beta3=-0.022042,se3=0.058856);
%inds(vbl=simptpotatcav4,study1=nhs,beta1=0.113138,se1=0.04857,study2=nhs2,beta2=0.039854,se2=0.052767,study3=hpfs,beta3=0.072186,se3=0.069286);
%inds(vbl=simptpotatcavm,study1=nhs,beta1=0.135659,se1=0.050093,study2=nhs2,beta2=0.050075,se2=0.054021,study3=hpfs,beta3=0.089858,se3=0.076797);
%inds(vbl=simpchipsscav1,study1=nhs,beta1=0.030355,se1=0.025737,study2=nhs2,beta2=-0.0407,se2=0.030493,study3=hpfs,beta3=-0.015532,se3=0.041377);
%inds(vbl=simpchipsscav2,study1=nhs,beta1=0.068182,se1=0.031777,study2=nhs2,beta2=-0.092367,se2=0.034196,study3=hpfs,beta3=0.046473,se3=0.048166);
%inds(vbl=simpchipsscav3,study1=nhs,beta1=0.07759,se1=0.039317,study2=nhs2,beta2=-0.025289,se2=0.038772,study3=hpfs,beta3=-0.164532,se3=0.060337);
%inds(vbl=simpchipsscav4,study1=nhs,beta1=0.155736,se1=0.072389,study2=nhs2,beta2=0.136551,se2=0.065127,study3=hpfs,beta3=0.01037,se3=0.097997);
%inds(vbl=simpchipsscavm,study1=nhs,beta1=0.277176,se1=0.100043,study2=nhs2,beta2=0.108532,se2=0.065714,study3=hpfs,beta3=-0.173187,se3=0.100776);
%inds(vbl=simpfpotatcav1,study1=nhs,beta1=0.091695,se1=0.024344,study2=nhs2,beta2=0.017716,se2=0.028933,study3=hpfs,beta3=0.00554,se3=0.040209);
%inds(vbl=simpfpotatcav2,study1=nhs,beta1=0.11094,se1=0.036237,study2=nhs2,beta2=0.090676,se2=0.03467,study3=hpfs,beta3=0.121176,se3=0.04943);
%inds(vbl=simpfpotatcav3,study1=nhs,beta1=0.223561,se1=0.067875,study2=nhs2,beta2=0.063443,se2=0.049517,study3=hpfs,beta3=0.075196,se3=0.069389);
%inds(vbl=simpfpotatcav4,study1=nhs,beta1=-0.012928,se1=0.290333,study2=nhs2,beta2=0.13275,se2=0.137958,study3=hpfs,beta3=0.374803,se3=0.159598);
%inds(vbl=simpfpotatcavm,study1=nhs,beta1=0.813853,se1=0.213886,study2=nhs2,beta2=0.166768,se2=0.098824,study3=hpfs,beta3=0.30551,se3=0.133364);
run;

data metantables;
set
basetpotatcav1
basetpotatcav2
basetpotatcav3
basetpotatcav4
basetpotatcavm
basechipsscav1
basechipsscav2
basechipsscav3
basechipsscav4
basechipsscavm
basefpotatcav1
basefpotatcav2
basefpotatcav3
basefpotatcav4
basefpotatcavm
noretpotatcav1
noretpotatcav2
noretpotatcav3
noretpotatcav4
noretpotatcavm
norechipsscav1
norechipsscav2
norechipsscav3
norechipsscav4
norechipsscavm
norefpotatcav1
norefpotatcav2
norefpotatcav3
norefpotatcav4
norefpotatcavm
recttpotatcav1
recttpotatcav2
recttpotatcav3
recttpotatcav4
recttpotatcavm
rectchipsscav1
rectchipsscav2
rectchipsscav3
rectchipsscav4
rectchipsscavm
rectfpotatcav1
rectfpotatcav2
rectfpotatcav3
rectfpotatcav4
rectfpotatcavm
simptpotatcav1
simptpotatcav2
simptpotatcav3
simptpotatcav4
simptpotatcavm
simpchipsscav1
simpchipsscav2
simpchipsscav3
simpchipsscav4
simpchipsscavm
simpfpotatcav1
simpfpotatcav2
simpfpotatcav3
simpfpotatcav4
simpfpotatcavm
;

model=substr(varp,1,4);
variable=substr(varp,5,10);
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

ods rtf file='stable8.rtf';
proc print data=metantabless noobs;
   run;
ods rtf close;


/*Pserv*/
%inds(vbl=basetpotatcav,study1=nhs,beta1=0.04709,se1=0.015928,study2=nhs2,beta2=0.046102,se2=0.017767,study3=hpfs,beta3=0.039139,se3=0.022989);
%inds(vbl=basechipsscav,study1=nhs,beta1=-0.023424,se1=0.023755,study2=nhs2,beta2=-0.01654,se2=0.022622,study3=hpfs,beta3=-0.046687,se3=0.034169);
%inds(vbl=basefpotatcav,study1=nhs,beta1=0.127492,se1=0.046843,study2=nhs2,beta2=0.075504,se2=0.032628,study3=hpfs,beta3=0.129389,se3=0.041518);
%inds(vbl=noretpotatcav,study1=nhs,beta1=0.044303,se1=0.020901,study2=nhs2,beta2=0.036261,se2=0.023164,study3=hpfs,beta3=0.05652,se3=0.027527);
%inds(vbl=norechipsscav,study1=nhs,beta1=0.007342,se1=0.030553,study2=nhs2,beta2=0.033377,se2=0.028735,study3=hpfs,beta3=-0.06368,se3=0.04213);
%inds(vbl=norefpotatcav,study1=nhs,beta1=0.208796,se1=0.062362,study2=nhs2,beta2=0.120078,se2=0.044134,study3=hpfs,beta3=0.194603,se3=0.055842);
%inds(vbl=recttpotatcav,study1=nhs,beta1=0.019773,se1=0.021061,study2=nhs2,beta2=0.032474,se2=0.02399,study3=hpfs,beta3=0.036232,se3=0.028059);
%inds(vbl=rectchipsscav,study1=nhs,beta1=0.051178,se1=0.030356,study2=nhs2,beta2=0.069647,se2=0.027941,study3=hpfs,beta3=-0.100798,se3=0.044167);
%inds(vbl=rectfpotatcav,study1=nhs,beta1=0.23148,se1=0.065318,study2=nhs2,beta2=0.119203,se2=0.047955,study3=hpfs,beta3=0.172706,se3=0.0598);
%inds(vbl=simptpotatcav,study1=nhs,beta1=0.033697,se1=0.01719,study2=nhs2,beta2=0.026328,se2=0.019468,study3=hpfs,beta3=0.022256,se3=0.023045);
%inds(vbl=simpchipsscav,study1=nhs,beta1=0.059021,se1=0.023341,study2=nhs2,beta2=0.068358,se2=0.020864,study3=hpfs,beta3=-0.076144,se3=0.037409);
%inds(vbl=simpfpotatcav,study1=nhs,beta1=0.213736,se1=0.054544,study2=nhs2,beta2=0.067557,se2=0.040594,study3=hpfs,beta3=0.114397,se3=0.04987);
run;

data metantables;
set
basetpotatcav
basechipsscav
basefpotatcav
noretpotatcav
norechipsscav
norefpotatcav
recttpotatcav
rectchipsscav
rectfpotatcav
simptpotatcav
simpchipsscav
simpfpotatcav
;

model=substr(varp,1,4);
variable=substr(varp,5,6);
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

ods rtf file='stable8_pserv.rtf';
proc print data=metantables noobs;
    var model variable RR ProbChisq pq;
   run;
ods rtf close;



