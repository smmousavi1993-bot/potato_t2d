/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/06/2024
Purpose of the program: 
   S.Table 8. Associations between simple updated potato intakes and risk of diabetes in the NHS II using different types of dietary assessments


proc means median data=five;var tpotatv;class ctpotatv; run;
proc means median data=five;var fpotatv;class cfpotatv; run;
proc means median data=five;var chipssv ;class cchipssv; run;
proc means median data=five;var bbmpotv;class cbbmpotv; run;
/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=ctpotatv cchipssv cfpotatv);

%pm(
 data=outpm,
 case=diabcase,
 exposure=ctpotatv cchipssv cfpotatv,
 ref=0 0 0
);

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17  t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &ctpotatv_ &qcalorv_ , 
         model2  = medctpotatv &qcalorv_,
         model3  = &ctpotatv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medctpotatv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &ctpotatv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_, 
         model6  = medctpotatv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_,

         model7  = &cchipssv_ &qcalorv_ , 
         model8  = medcchipssv &qcalorv_,
         model9  = &cchipssv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model10  = medcchipssv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model11  = &cchipssv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_, 
         model12  = medcchipssv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_,

         model13  = &cfpotatv_ &qcalorv_ , 
         model14  = medcfpotatv &qcalorv_,
         model15  = &cfpotatv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model16  = medcfpotatv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model17  = &cfpotatv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_, 
         model18  = medcfpotatv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_,
         outdat=RR1);

data tpotat;
set RR1;

if modelno in (1,3,5) then ind_var=substr(variable,2,6);
if modelno in (2,4,6) then ind_var=substr(variable,5,6);

   if ind_var='tpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (1,2) then model='m1';
   if modelno in (3,4) then model='m2';
   if modelno in (5,6) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data chipss;
set RR1;

if modelno in (7,9,11) then ind_var=substr(variable,2,6);
if modelno in (8,10,12) then ind_var=substr(variable,5,6);

   if ind_var='chipss';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (7,8) then model='m1';
   if modelno in (9,10) then model='m2';
   if modelno in (11,12) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data fpotat;
set RR1;

if modelno in (13,15,17) then ind_var=substr(variable,2,6);
if modelno in (14,16,18) then ind_var=substr(variable,5,6);

   if ind_var='fpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (13,14) then model='m1';
   if modelno in (15,16) then model='m2';
   if modelno in (17,18) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data all;
set tpotat chipss fpotat
;
run;

data quin;
set all;
vb=compress(variable,,'kd');
if vb ne . then va=substr(variable,2,6);
if vb=. then va=substr(variable,5,6);
run;

data quin1;
set quin;
if vb="1";
RR1=RR;
keep model va RR1;
run;

data quin2;
set quin;
if vb="2";
RR2=RR;
keep model va RR2;
run;

data quin3;
set quin;
if vb="3";
RR3=RR;
keep model va RR3;
run;

data quin4;
set quin;
if vb="4";
RR4=RR;
keep model va RR4;
run;

data quin5;
set quin;
if vb=.;
keep model va ProbChisq;
run;

proc sort data=quin1; by va model; run;
proc sort data=quin2; by va model; run;
proc sort data=quin3; by va model; run;
proc sort data=quin4; by va model; run;
proc sort data=quin5; by va model; run;

data scr;
merge quin1 quin2 quin3 quin4 quin5; 
by va model;
run;

ods rtf file="stable8.simp_nhs2.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 RR4 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;



/*Per serving*/
%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17   t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = tpotatwv &qcalorv_, 
         model2  = tpotatwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model3  = tpotatwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_,

         model4  = chipsswv &qcalorv_ , 
         model5  = chipsswv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model6  = chipsswv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_,

         model7  = fpotatowv &qcalorv_ , 
         model8  = fpotatowv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model9  = fpotatowv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_,
         
         model10  = bbmpotwv &qcalorv_ , 
         model11  = bbmpotwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model12  = bbmpotwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_,
         outdat=RR1);

data tpotat;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='tpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=1 then model='m1';
   if modelno=2 then model='m2';
   if modelno=3 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data chipss;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='chipss';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=4 then model='m1';
   if modelno=5 then model='m2';
   if modelno=6 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;


data fpotat;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='fpotat';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=7 then model='m1';
   if modelno=8 then model='m2';
   if modelno=9 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data bbmpot;
set RR1;

ind_var=substr(variable,1,6);

   if ind_var='bbmpot';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno=10 then model='m1';
   if modelno=11 then model='m2';
   if modelno=12 then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

/*Merge macro outputs*/
data all;
set tpotat chipss fpotat bbmpot
;
run;

data scr_psd;
set all;
va=substr(variable,1,6);
keep model va RR ProbChisq;
run;

proc sort data=scr_psd; by va model; run;


ods rtf file="stable8.simp_pserv_nhs2.rtf";  
proc print data=scr_psd noobs;
   var  va model RR ProbChisq;   
run;

proc print data=all noobs;
   var  variable model beta see ProbChisq;
run;
ods rtf close;


/*Baked, Boiled, mashed potato Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19 ,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=cbbmpotv);

%pm(
 data=outpm,
 case=diabcase,
 exposure=cbbmpotv,
 ref=0
);

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15  t17  t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17  retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &cbbmpotv_ &qcalorv_ , 
         model2  = medcbbmpotv &qcalorv_,
         model3  = &cbbmpotv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medcbbmpotv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &cbbmpotv_ &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model6  = medcbbmpotv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_,
         outdat=RR1);

data bbmpot;
set RR1;

if modelno in (1,3,5) then ind_var=substr(variable,2,6);
if modelno in (2,4,6) then ind_var=substr(variable,5,6);

   if ind_var='bbmpot';
   RR=put(HazardRatio,4.2)|| ' (' ||put(LCL,4.2)|| ', ' ||put(UCL,4.2)|| ')';
   beta=put(Estimate,9.6);
   see =put(StdErr,9.6);
   
   if modelno in (1,2) then model='m1';
   if modelno in (3,4) then model='m2';
   if modelno in (5,6) then model='m3';

   keep variable RR model ProbChisq beta see;
   
   run;

data all;
set bbmpot
;
run;

data quin;
set all;
vb=compress(variable,,'kd');
if vb ne . then va=substr(variable,2,6);
if vb=. then va=substr(variable,5,6);
run;

data quin1;
set quin;
if vb="1";
RR1=RR;
keep model va RR1;
run;

data quin2;
set quin;
if vb="2";
RR2=RR;
keep model va RR2;
run;

data quin3;
set quin;
if vb="3";
RR3=RR;
keep model va RR3;
run;

data quin4;
set quin;
if vb=.;
keep model va ProbChisq;
run;

proc sort data=quin1; by va model; run;
proc sort data=quin2; by va model; run;
proc sort data=quin3; by va model; run;
proc sort data=quin4; by va model; run;

data scr;
merge quin1 quin2 quin3 quin4; 
by va model;
run;

ods rtf file="stable8.simp.bbm_nhs2.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;

