


*******************************************;
*		total potato BMI			  *;
*******************************************;
data test;
reduced= 50175.909 ;
full= 50175.521  ;
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
reduced= 50159.636  ;
full= 50159.111  ;
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
reduced= 50160.886;
full= 50160.639;
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
reduced= 49962.006 ;
full= 49961.352 ;
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
reduced= 49946.838  ;
full= 49945.842  ;
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
reduced= 49948.233 ;
full= 49946.865 ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;
