/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 12. Associations between substituting 3-serving of other foods for potato intakes and the risk of type 2 diabetes in the NHS, NHS II, and HPFS, 
   limiting the analysis to whites only (Meta-analysis)


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

%inds(vbl=m3tpotatwtricecav, study1=nhs, beta1=0.09466, se1=0.05316, study2=nhs2, beta2=0.1331, se2=0.05190, study3=hpfs, beta3=0.03913, se3=0.05933);

%inds(vbl=m3bbmpotwtricecav, study1=nhs, beta1=0.1219, se1=0.05389, study2=nhs2, beta2=0.1646, se2=0.05513, study3=hpfs, beta3=0.08292, se3=0.06170);

%inds(vbl=m3fpotatwtricecav, study1=nhs, beta1=-0.1235, se1=0.08386, study2=nhs2, beta2=0.05663, se2=0.06794, study3=hpfs, beta3=-0.1270, se3=0.08162);
run;

data metantables;
set
m3tpotatwtricecav
m3bbmpotwtricecav
m3fpotatwtricecav
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

ods rtf file='stable12.rtf';
proc print data=metantables noobs;
    var model variable target RR ProbChisq pq;
   run;
ods rtf close;




