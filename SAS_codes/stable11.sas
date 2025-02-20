/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/08/2024
Purpose of the program: 
   S.Table 11. Associations between substituting 3-serving of other foods for potato intakes and the risk of type 2 diabetes in the NHS, NHS II, and HPFS (Meta-analysis)
=
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
%inds(vbl=m3tpotatwhgrnscav, study1=nhs, beta1=-0.09121, se1=0.02539, study2=nhs2, beta2=-0.06012, se2=0.02807, study3=hpfs, beta3=-0.08735, se3=0.03276);
%inds(vbl=m3tpotatrfgrnscav, study1=nhs, beta1=-0.02989, se1=0.02391, study2=nhs2, beta2=-0.01840, se2=0.02704, study3=hpfs, beta3=-0.02776, se3=0.03133);
%inds(vbl=m3tpotatnstvegcav, study1=nhs, beta1=-0.05569, se1=0.02329, study2=nhs2, beta2=-0.03000, se2=0.02632, study3=hpfs, beta3=-0.05138, se3=0.03035);
%inds(vbl=m3tpotatstavegcav, study1=nhs, beta1=-0.02849, se1=0.04421, study2=nhs2, beta2=0.03144, se2=0.04675, study3=hpfs, beta3=0.03670, se3=0.05599);
%inds(vbl=m3tpotatlegumecav, study1=nhs, beta1=-0.03513, se1=0.06345, study2=nhs2, beta2=-0.04706, se2=0.06021, study3=hpfs, beta3=-0.1317, se3=0.07445);

%inds(vbl=m3tpotatwtricecav, study1=nhs, beta1=0.1894, se1=0.03752, study2=nhs2, beta2=0.1497, se2=0.03407, study3=hpfs, beta3=0.06134, se3=0.04194);
%inds(vbl=m3tpotatbwricecav, study1=nhs, beta1=-0.01230, se1=0.07234, study2=nhs2, beta2=0.000252, se2=0.06856, study3=hpfs, beta3=-0.05761, se3=0.07921);

%inds(vbl=m3bbmpotwhgrnscav, study1=nhs, beta1=-0.06257, se1=0.02703, study2=nhs2, beta2=-0.02377, se2=0.03394, study3=hpfs, beta3=-0.03163, se3=0.03833);
%inds(vbl=m3bbmpotrfgrnscav, study1=nhs, beta1= 0.00494, se1=0.02530, study2=nhs2, beta2=0.01723, se2=0.03289, study3=hpfs, beta3=0.02393, se3=0.03647);
%inds(vbl=m3bbmpotnstvegcav, study1=nhs, beta1=-0.03016, se1=0.02476, study2=nhs2, beta2=0.005878, se2=0.03236, study3=hpfs, beta3=-0.00059, se3=0.03552);
%inds(vbl=m3bbmpotstavegcav, study1=nhs, beta1=-0.00391, se1=0.04499, study2=nhs2, beta2=0.07017, se2=0.05095, study3=hpfs, beta3=0.08964, se3=0.05915);
%inds(vbl=m3bbmpotlegumecav, study1=nhs, beta1=-0.00981, se1=0.06396, study2=nhs2, beta2=-0.01380, se2=0.06268, study3=hpfs, beta3=-0.08433, se3=0.07630);

%inds(vbl=m3bbmpotwtricecav, study1=nhs, beta1=0.2176, se1=0.03850, study2=nhs2, beta2=0.1830, se2=0.03873, study3=hpfs, beta3=0.1080, se3=0.04554);
%inds(vbl=m3bbmpotbwricecav, study1=nhs, beta1=0.01852, se1=0.07274, study2=nhs2, beta2=0.03529, se2=0.07104, study3=hpfs, beta3=-0.00089, se3=0.08167);

%inds(vbl=m3fpotatwhgrnscav, study1=nhs, beta1=-0.3063, se1=0.06807, study2=nhs2, beta2=-0.1425, se2=0.05039, study3=hpfs, beta3=-0.2526, se3=0.06148);
%inds(vbl=m3fpotatrfgrnscav, study1=nhs, beta1=-0.2487, se1=0.06856, study2=nhs2, beta2=-0.1015, se2=0.05013, study3=hpfs, beta3=-0.1971, se3=0.06190);
%inds(vbl=m3fpotatnstvegcav, study1=nhs, beta1=-0.2739, se1=0.06820, study2=nhs2, beta2=-0.1128, se2=0.04964, study3=hpfs, beta3=-0.2216, se3=0.06167);
%inds(vbl=m3fpotatstavegcav, study1=nhs, beta1=-0.2476, se1=0.07808, study2=nhs2, beta2=-0.04854, se2=0.06186, study3=hpfs, beta3=-0.1313, se3=0.07699);
%inds(vbl=m3fpotatlegumecav, study1=nhs, beta1=-0.2535, se1=0.09022, study2=nhs2, beta2=-0.1325, se2=0.07427, study3=hpfs, beta3=-0.3053, se3=0.09236);

%inds(vbl=m3fpotatwtricecav, study1=nhs, beta1=-0.03647, se1=0.07371, study2=nhs2, beta2=0.07113, se2=0.05417, study3=hpfs, beta3=-0.1002, se3=0.06838);
%inds(vbl=m3fpotatbwricecav, study1=nhs, beta1=-0.2452, se1=0.09564, study2=nhs2, beta2=-0.08205 , se2=0.08047, study3=hpfs, beta3=-0.2339, se3=0.09488);
run;

data metantables;
set
m3tpotatwhgrnscav
m3tpotatrfgrnscav
m3tpotatnstvegcav
m3tpotatstavegcav
m3tpotatlegumecav
m3tpotatwtricecav
m3tpotatbwricecav
m3bbmpotwhgrnscav
m3bbmpotrfgrnscav
m3bbmpotnstvegcav
m3bbmpotstavegcav
m3bbmpotlegumecav
m3bbmpotwtricecav
m3bbmpotbwricecav
m3fpotatwhgrnscav
m3fpotatrfgrnscav
m3fpotatnstvegcav
m3fpotatstavegcav
m3fpotatlegumecav
m3fpotatwtricecav
m3fpotatbwricecav
;

target=substr(varp,9,6);
model=substr(varp,1,2);
variable=substr(varp,3,6);
RR=varvalue;
ProbChisq=pvalue;
run;

proc sort data=metantables; by model variable target ; run;



                            ***
                        ***     ***
                    ***            ***
                ***    metan-output    ***
                    ***            ***
                        ***     ***
                            ***;

ods rtf file='stable11.rtf';
proc print data=metantables noobs;
    var model variable target RR ProbChisq pq;
   run;
ods rtf close;




