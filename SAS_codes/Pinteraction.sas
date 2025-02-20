*****************************************************************************************;
*						Aim: to calculate p for interaction (for categorical variables with > 2 categories (meta-analysis))								*;
*****************************************************************************************;
filename nhstools '/proj/nhsass/nhsas00/nhstools/sasautos/'; 
filename hpstools '/proj/hpsass/hpsas00/hpstools/sasautos/';
/*filename local '/usr/local/channing/sasautos/';*/
filename channing '/usr/local/channing/sasautos';
filename ehmac '/udd/stleh/ehmac/';
libname library '/proj/nhsass/nhsas00/formats/';
libname readfmt '/proj/hpsass/hpsas00/formats/';
options mautosource sasautos=(channing nhstools hpstools);
/*options mautosource sasautos=(local nhstools);*/         *** path to macros  ***;
/*options mautosource sasautos=(channing hpstools)*/;
options fmtsearch=(readfmt) nofmterr;                            *** path to formats ***;
options nocenter;
options linesize=125 pagesize=78 ;


*******************************************;
*		total potato BMI			  *;
*******************************************;
data test;
reduced= 321708.26 ;
full= 321701.53 ; /* with BMI interactis*/
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
reduced= 321723.42 ;
full= 321718.75 ;
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
reduced= 321684.10 ;
full= 321665.66 ;
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
reduced= 319829.32  ;
full= 319824.38  ;
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
reduced= 319842.74 ;
full=  319839.54  ;
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
reduced= 319817.58  ;
full= 319812.56   ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		total potato race	(4 categories) 		  *;
*******************************************;
data test6;
reduced= 319691.71  ;
full= 319688.08   ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		bbm potato race	 (4 categories) 		  *;
*******************************************;
data test7;
reduced= 319707.30 ;
full= 319700.19   ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;

*******************************************;
*		fried potato race (4 categories) *;
*******************************************;
data test8;
reduced=  319683.12  ;
full= 319681.81   ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;
