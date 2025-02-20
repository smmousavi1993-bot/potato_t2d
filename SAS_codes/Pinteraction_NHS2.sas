
*******************************************;
*		total potato BMI			  *;
*******************************************;
data test;
reduced= 126034.06 ;
full= 126025.64  ;
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
reduced= 126030.55  ;
full= 126024.93  ;
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
reduced= 126025.53  ;
full= 126020.32  ;
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
reduced= 125088.63  ;
full= 125082.79  ;
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
reduced= 125087.90  ;
full= 125084.38  ;
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
reduced= 125084.29  ;
full= 125079.97   ;
df=2; 
p_value=1-probchi(reduced-full,df); 
run;

proc print;
var p_value;
run;
