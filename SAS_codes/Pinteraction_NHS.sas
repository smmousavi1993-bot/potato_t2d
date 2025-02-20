*****************************************************************************************;
*						Aim: to calculate p for interaction								*;
*****************************************************************************************;
filename nhstools '/proj/nhsass/nhsas00/nhstools/sasautos/';
filename local '/usr/local/channing/sasautos/';
libname library '/proj/nhsass/nhsas00/formats/';
options mautosource sasautos=(local nhstools);   *** path to macros  ***;
options fmtsearch=(readfmt);                     *** path to formats ***;
options nocenter;
options linesize=125 pagesize=78 ;


*******************************************;
*		total potato BMI			  *;
*******************************************;
data test;
reduced= 134965.24  ;  /* the model (-2 LOG L) without BMI interactions, with covariates*/
full= 134960.82  ; /* the model (-2 LOG L) with BMI interactions, with covariates*/
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		bbm potato BMI			  *;
*******************************************;
data test1;
reduced= 134943.21  ;
full= 134941.06  ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		fried potato BMI			  *;
*******************************************;
data test2;
reduced= 134948.32  ;
full= 134934.47  ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		total potato smoke			  *;
*******************************************;
data test3;
reduced= 134322.27  ;
full= 134319.90  ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		bbm potato smoke			  *;
*******************************************;
data test4;
reduced= 134304.46  ;
full= 134303.12  ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		fried potato smoke			  *;
*******************************************;
data test5;
reduced= 134309.95  ;
full= 134305.18  ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;
