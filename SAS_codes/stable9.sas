/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the NHS, NHS II, and HPFS by latency period (Meta-analysis)


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
proc print data=outrrc_p;run;
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
%inds(vbl=tpotatv00, study1=nhs, beta1=0.03370, se1=0.01719, study2=nhs2, beta2=0.02633, se2=0.01947, study3=hpfs, beta3=0.02226, se3=0.02305);
%inds(vbl=bbmpotv00, study1=nhs, beta1=0.01387, se1=0.01845, study2=nhs2, beta2=0.00635, se2=0.02400, study3=hpfs, beta3=-0.00289, se3=0.02711);
%inds(vbl=fpotatv00, study1=nhs, beta1=0.21374, se1=0.05454, study2=nhs2, beta2=0.06756, se2=0.04059, study3=hpfs, beta3=0.11440, se3=0.04987);

%inds(vbl=tpotatv04, study1=nhs, beta1=0.01311, se1=0.01768, study2=nhs2, beta2=0.03473, se2=0.01953, study3=hpfs, beta3=0.01165, se3=0.02528);
%inds(vbl=bbmpotv04, study1=nhs, beta1=-0.0000662, se1=0.01884, study2=nhs2, beta2=-0.00432, se2=0.02408, study3=hpfs, beta3=-0.02570, se3=0.02997);
%inds(vbl=fpotatv04, study1=nhs, beta1=0.13466, se1=0.05645, study2=nhs2, beta2=0.13339, se2=0.03947, study3=hpfs, beta3=0.14289, se3=0.05322);

%inds(vbl=tpotatv08, study1=nhs, beta1=0.01041, se1=0.01814, study2=nhs2, beta2=0.05046, se2=0.01940, study3=hpfs, beta3=0.06191, se3=0.02534);
%inds(vbl=bbmpotv08, study1=nhs, beta1=-0.00596, se1=0.01941, study2=nhs2, beta2=0.03292, se2=0.02353, study3=hpfs, beta3=0.04741, se3=0.02966);
%inds(vbl=fpotatv08, study1=nhs, beta1=0.16610, se1=0.05634, study2=nhs2, beta2=0.10225, se2=0.03882, study3=hpfs, beta3=0.11491, se3=0.05581);

%inds(vbl=tpotatv12, study1=nhs, beta1=0.04808, se1=0.01873, study2=nhs2, beta2=0.05606, se2=0.02115, study3=hpfs, beta3=0.05175, se3=0.02885);
%inds(vbl=bbmpotv12, study1=nhs, beta1=0.03720, se1=0.01991, study2=nhs2, beta2=0.05330, se2=0.02535, study3=hpfs, beta3=0.02006, se3=0.03472);
%inds(vbl=fpotatv12, study1=nhs, beta1=0.15962, se1=0.06039, study2=nhs2, beta2=0.05982, se2=0.04323, study3=hpfs, beta3=0.15294, se3=0.05975);

%inds(vbl=tpotatv16, study1=nhs, beta1=0.04053, se1=0.02139, study2=nhs2, beta2=0.06314, se2=0.02447, study3=hpfs, beta3=0.01114, se3=0.03755);
%inds(vbl=bbmpotv16, study1=nhs, beta1=0.02668, se1=0.02289, study2=nhs2, beta2=0.05089, se2=0.02951, study3=hpfs, beta3=-0.00830, se3=0.04463);
%inds(vbl=fpotatv16, study1=nhs, beta1=0.17206, se1=0.06651, study2=nhs2, beta2=0.09397, se2=0.04883, study3=hpfs, beta3=0.06632, se3=0.07563);

%inds(vbl=tpotatv20, study1=nhs, beta1=0.01721, se1=0.02767, study2=nhs2, beta2=0.08748, se2=0.03171, study3=hpfs, beta3=0.00274, se3=0.04934);
%inds(vbl=bbmpotv20, study1=nhs, beta1=0.00180, se1=0.02977, study2=nhs2, beta2=0.07178, se2=0.03852, study3=hpfs, beta3=-0.02378, se3=0.06016);
%inds(vbl=fpotatv20, study1=nhs, beta1=0.14808, se1=0.08255, study2=nhs2, beta2=0.13019, se2=0.06047, study3=hpfs, beta3=0.07996, se3=0.09140);

%inds(vbl=tpotatv24, study1=nhs, beta1=-0.03709, se1=0.04197, study2=nhs2, beta2=0.09834, se2=0.04754, study3=hpfs, beta3=-0.01024, se3=0.07517);
%inds(vbl=bbmpotv24, study1=nhs, beta1=-0.06222, se1=0.04584, study2=nhs2, beta2=0.08640, se2=0.05710, study3=hpfs, beta3=-0.06942, se3=0.09496);
%inds(vbl=fpotatv24, study1=nhs, beta1=0.13944, se1=0.11666, study2=nhs2, beta2=0.11941, se2=0.09377, study3=hpfs, beta3=0.10609, se3=0.13079);
run;

data metantables;
set
tpotatv00
bbmpotv00
fpotatv00
tpotatv04
bbmpotv04
fpotatv04
tpotatv08
bbmpotv08
fpotatv08
tpotatv12
bbmpotv12
fpotatv12
tpotatv16
bbmpotv16
fpotatv16
tpotatv20
bbmpotv20
fpotatv20
tpotatv24
bbmpotv24
fpotatv24
;

variable=substr(varp,1,6);
lag=substr(varp,8,2);
RR=varvalue;
ProbChisq=pvalue;
run;

proc sort data=metantables; by variable lag; run;




                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable9.rtf';
proc print data=metantables noobs;
    var variable lag RR ProbChisq pq;
   run;
ods rtf close;



