 /******************************************************************************************************************************************
Program name:
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   Read in and merge datasets as the preparation for the analysis of total and type of potato consumption and risk of type 2 diabetes in the HPFS

****************************************************************************************************************************************/



/*Death*/
%hp_dead (keep= mmdth yydth icda newicda dtdth );
   
   if 0<=yydth<50 then yydth=yydth+100;
   
   newicda=compress(icda, 'E');
   if newicda='V812' then newicda=812;

   newicda=newicda*10;
   
   if mmdth<0 and yydth>0 then mmdth=6;
   dtdth=(yydth*12)+mmdth;
   if dtdth=. then delete ;

   proc sort;
      by id;
      run;


/******Diab cases ******/      

%hp_diab8622;
 
    if dbcase = 1;

    dtdxdiab = dtdx*1;
    if dtdxdiab = . then dtdxdiab = 1031;

    symp=0;
    if symptoms>0 then symp=1;
    label symp="Symptoms";

    keep id dtdxdiab dbcase type prob symp;

run; 

proc freq data=hp_diab8622;tables dbcase type prob ;run;
proc univariate data=hp_diab8622;var dtdxdiab;run;


/******exposure and covariates******/
data ahei86; 
   set AHEIdat.hnahei86l; 
   ahei86=nAHEI86a; 
   aheinoal86=nAHEI86_noal; 
   aheinopt86 = sum (meataI86, nutI86, ssbI86, frtI86a, tvegI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinoveg86 = sum (meataI86, nutI86, ssbI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinofru86 = sum (meataI86, nutI86, ssbI86, tvegI86, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinowgr86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, omegI86);
   aheinossb86 = sum (meataI86, nutI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinonut86 = sum (meataI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinormt86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinotft86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinon3f86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86);
   aheinopuf86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinona86 = sum (meataI86, nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, wgI86, omegI86);

   aheifisha86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86);
   aheidairy86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheinutbl86 = sum (ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheipoult86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
   aheineggs86 = sum (nutI86, ssbI86, tvegI86, frtI86a, ppolyI86, tranI86, nETOHI86b, na86s, wgI86, omegI86);
proc sort; by id; run;

data ahei90; 
   set AHEIdat.hnahei90l; 
   ahei90=nAHEI90a; 
   aheinoal90=nAHEI90_noal; 
   aheinopt90 = sum (meataI90, nutI90, ssbI90, frtI90a, tvegI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinoveg90 = sum (meataI90, nutI90, ssbI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinofru90 = sum (meataI90, nutI90, ssbI90, tvegI90, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinowgr90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, omegI90);
   aheinossb90 = sum (meataI90, nutI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinonut90 = sum (meataI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinormt90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinotft90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinon3f90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, na90s, wgI90);
   aheinopuf90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, tranI90, nETOHI90b, na90s, wgI90, omegI90);
   aheinona90 = sum (meataI90, nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, wgI90, omegI90);

   aheifisha90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, wgI90, na90s);
   aheidairy90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheinutbl90 = sum (ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheipoult90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
   aheineggs90 = sum (nutI90, ssbI90, tvegI90, frtI90a, ppolyI90, tranI90, nETOHI90b, omegI90, wgI90, na90s);
proc sort; by id; run;

data ahei94; 
   set AHEIdat.hnahei94l; 
   ahei94=nAHEI94a; 
   aheinoal94=nAHEI94_noal; 
   aheinopt94 = sum (meataI94, nutI94, ssbI94, frtI94a, tvegI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinoveg94 = sum (meataI94, nutI94, ssbI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinofru94 = sum (meataI94, nutI94, ssbI94, tvegI94, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinowgr94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, omegI94);
   aheinossb94 = sum (meataI94, nutI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinonut94 = sum (meataI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinormt94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinotft94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinon3f94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, na94s, wgI94);
   aheinopuf94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, tranI94, nETOHI94b, na94s, wgI94, omegI94);
   aheinona94 = sum (meataI94, nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, wgI94, omegI94);

   aheifisha94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, wgI94, na94s);
   aheidairy94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheinutbl94 = sum (ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheipoult94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
   aheineggs94 = sum (nutI94, ssbI94, tvegI94, frtI94a, ppolyI94, tranI94, nETOHI94b, omegI94, wgI94, na94s);
proc sort; by id; run;

data ahei98; 
   set AHEIdat.hnahei98l; 
   ahei98=nAHEI98a; 
   aheinoal98=nAHEI98_noal; 
   aheinopt98 = sum (meataI98, nutI98, ssbI98, frtI98a, tvegI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinoveg98 = sum (meataI98, nutI98, ssbI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinofru98 = sum (meataI98, nutI98, ssbI98, tvegI98, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinowgr98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, omegI98);
   aheinossb98 = sum (meataI98, nutI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinonut98 = sum (meataI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinormt98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinotft98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinon3f98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, na98s, wgI98);
   aheinopuf98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, tranI98, nETOHI98b, na98s, wgI98, omegI98);
   aheinona98 = sum (meataI98, nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, wgI98, omegI98);

   aheifisha98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, wgI98, na98s);
   aheidairy98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheinutbl98 = sum (ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheipoult98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
   aheineggs98 = sum (nutI98, ssbI98, tvegI98, frtI98a, ppolyI98, tranI98, nETOHI98b, omegI98, wgI98, na98s);
proc sort; by id; run;

data ahei02; 
   set AHEIdat.hnahei02l; 
   ahei02=nAHEI02a; 
   aheinoal02=nAHEI02_noal; 
   aheinopt02 = sum (meataI02, nutI02, ssbI02, frtI02a, tvegI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinoveg02 = sum (meataI02, nutI02, ssbI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinofru02 = sum (meataI02, nutI02, ssbI02, tvegI02, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinowgr02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, omegI02);
   aheinossb02 = sum (meataI02, nutI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinonut02 = sum (meataI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinormt02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinotft02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinon3f02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, na02s, wgI02);
   aheinopuf02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, tranI02, nETOHI02b, na02s, wgI02, omegI02);
   aheinona02 = sum (meataI02, nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, wgI02, omegI02);

   aheifisha02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, wgI02, na02s);
   aheidairy02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheinutbl02 = sum (ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheipoult02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
   aheineggs02 = sum (nutI02, ssbI02, tvegI02, frtI02a, ppolyI02, tranI02, nETOHI02b, omegI02, wgI02, na02s);
proc sort; by id; run;

data ahei06; 
   set AHEI06.ahei06; 
   ahei06=nAHEI06a; 
   aheinoal06=nAHEI06_noal; 
   aheinopt06 = sum (meataI06, nutI06, ssbI06, frtI06a, tvegI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinoveg06 = sum (meataI06, nutI06, ssbI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinofru06 = sum (meataI06, nutI06, ssbI06, tvegI06, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinowgr06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, omegI06);
   aheinossb06 = sum (meataI06, nutI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinonut06 = sum (meataI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinormt06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinotft06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinon3f06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, na06s, wgI06);
   aheinopuf06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, tranI06, nETOHI06b, na06s, wgI06, omegI06);
   aheinona06 = sum (meataI06, nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, wgI06, omegI06);

   aheifisha06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, wgI06, na06s);
   aheidairy06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheinutbl06 = sum (ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheipoult06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
   aheineggs06 = sum (nutI06, ssbI06, tvegI06, frtI06a, ppolyI06, tranI06, nETOHI06b, omegI06, wgI06, na06s);
proc sort; by id; run;

data ahei10; 
   set AHEI06.ahei10; 
   ahei10=nAHEI10a; 
   aheinopt10 = sum (meataI10, nutI10, ssbI10, frtI10a, tvegI10, nETOHI10b, na10s, wgI10, omegI10);
   aheifisha10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, wgI10, na10s);
   aheidairy10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheinutbl10 = sum (ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheipoult10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
   aheineggs10 = sum (nutI10, ssbI10, tvegI10, frtI10a, ppolyI10, tranI10, nETOHI10b, omegI10, wgI10, na10s);
proc sort; by id; run;

/*** read physical activity data***/ 
%hmet8616(keep=act86 act88 act90 act92 act94 act96 act98 act00 act02 act04 act06 act08 act10 act12 act14 act16);
run;

data hp_mets;   
set hmet8616;   
array acts{18} act86 act88 act90 act92 act94 act96 act98 act00 act02 act04 act06 act08 act10 act12 act14 act16 act16 act16;
do i=1 to 18; if acts{i}>900 then acts{i}=.; end;
do i=2 to 18; if acts{i}=. then acts{i}=acts{i-1}; end;
proc sort; by id;
run;

/*potato intake*/
%include '/udd/nhsem/Potato.T2D/MousaviSeyed_potato_T2D_052024/food_hpfs.sas';


/****** alcohol ******/
%h86_nts (keep=alco86n calor86n na86n trnss86n prot86n carbo86n tfat86n carbden86n protden86n tfatden86n);
    carbden86n = (carbo86n*4)/calor86n;
    protden86n = (prot86n*4)/calor86n;
    tfatden86n= (tfat86n*9)/calor86n;
proc sort; by id; run; 

%h90_nts (keep=alco90n calor90n na90n trnss90n prot90n carbo90n tfat90n carbden90n protden90n tfatden90n);
    carbden90n = (carbo90n*4)/calor90n;
    protden90n = (prot90n*4)/calor90n;
    tfatden90n= (tfat90n*9)/calor90n;
proc sort; by id; run; 

%h94_nts (keep=alco94n calor94n na94n trnss94n prot94n carbo94n tfat94n carbden94n protden94n tfatden94n);
    carbden94n = (carbo94n*4)/calor94n;
    protden94n = (prot94n*4)/calor94n;
    tfatden94n= (tfat94n*9)/calor94n;
proc sort; by id; run; 

%h98_nts (keep=alco98n calor98n na98n ttrn098n prot98n carbo98n tfat98n carbden98n protden98n tfatden98n);
    carbden98n = (carbo98n*4)/calor98n;
    protden98n = (prot98n*4)/calor98n;
    tfatden98n= (tfat98n*9)/calor98n;
proc sort; by id; run; 

%h02_nts (keep=alco02n calor02n na02n trn0202n prot02n carbo02n tfat02n carbden02n protden02n tfatden02n);
    carbden02n = (carbo02n*4)/calor02n;
    protden02n = (prot02n*4)/calor02n;
    tfatden02n= (tfat02n*9)/calor02n;
proc sort; by id; run; 

%h06_nts (keep=alco06n calor06n na06n trn0706n prot06n carbo06n tfat06n carbden06n protden06n tfatden06n);
    carbden06n = (carbo06n*4)/calor06n;
    protden06n = (prot06n*4)/calor06n;
    tfatden06n= (tfat06n*9)/calor06n;
proc sort; by id; run; 

%h10_nts (keep=alco10n calor10n na10n trn1110n prot10n carbo10n tfat10n carbden10n protden10n tfatden10n);
    carbden10n = (carbo10n*4)/calor10n;
    protden10n = (prot10n*4)/calor10n;
    tfatden10n= (tfat10n*9)/calor10n;
proc sort; by id; run; 

%h14_nts (keep=alco14n calor14n na14n trn1114n prot14n carbo14n tfat14n carbden14n protden14n tfatden14n);
    carbden14n = (carbo14n*4)/calor14n;
    protden14n = (prot14n*4)/calor14n;
    tfatden14n= (tfat14n*9)/calor14n;
proc sort; by id; run; 

%h86_dt  (keep=mvt86d mvit86);if mvt86d=2 then mvit86=1;else mvit86=0;
%h90_dt  (keep=mvt90d mvit90);if mvt90d=2 then mvit90=1;else mvit90=0;
%h94_dt  (keep=mvt94d mvit94);if mvt94d=2 then mvit94=1;else mvit94=0;
%h98_dt  (keep=mvt98d mvit98);if mvt98d=2 then mvit98=1;else mvit98=0;

/****read in self-reported diabetes, cancer, CVD and hypertension data***/
%hp_der (keep= dbmy86 rtmnyr86 rtmnyr88 rtmnyr90 rtmnyr92 rtmnyr94 rtmnyr96 rtmnyr98 rtmnyr00 rtmnyr02 rtmnyr04 rtmnyr06 height 
            bmi2186 wt86 wt88 wt90 wt92 wt94 wt96 wt98 wt00 wt02 wt04 wt06 smoke86 smoke88 smoke90 smoke92 smoke94 smoke96 
            smoke98 smoke00 smoke02 smoke04 smoke06 cgnm86 cgnm88 cgnm90 cgnm92 cgnm94 cgnm96 cgnm98 cgnm00 cgnm02 cgnm04 cgnm06 dbmy09);

data hp_der;
   set hp_der;
   if dbmy09>0;
run;

%hp_der_2 (keep=rtmnyr08 rtmnyr10 rtmnyr12 rtmnyr14 rtmnyr16 rtmnyr18 rtmnyr20 wt08 wt10 wt12 wt14 wt16 wt18 wt20 smoke08 smoke10 smoke12 smoke14 smoke16 smoke18 smoke20 cgnm08 
                cgnm10 cgnm12 cgnm14 cgnm16 cgnm18 cgnm20); 

%hp86(keep=hbp86 db86 chol86 mi86 cabg86 ang86 str86 orhy86 renf86 asp86 seuro86 scand86 ocauc86 afric86 asian86 oanc86 
         mmi86 fmi86 colc86  pros86  lymp86  ocan86  mel86 antch86 betab86 lasix86 diur86 calcb86 ald86);      
if hbp86 ne 1 then hbp86=0;
if db86 ne 1 then db86=0;
if chol86 ne 1 then chol86=0;
if mi86 ne 1 then mi86=0; 
if cabg86 ne 1 then cabg86=0;
if ang86 ne 1 then ang86=0;
if str86 ne 1 then str86=0;
if orhy86 ne 1 then orhy86=0;
if renf86 ne 1 then renf86=0;
if asp86 ne 1 then asp86=0;
if mmi86 ne 1 then mmi86=0;
if fmi86 ne 1 then fmi86=0;
if colc86 ne 1 then colc86=0;
if pros86 ne 1 then pros86=0;
if lymp86 ne 1 then lymp86=0;
if ocan86 ne 1 then ocan86=0;
if mel86 ne 1 then mel86=0;

%hp88(keep=hbp88 db88 chol88 mi88 cabg88 ang88 str88 orhy88 renf88 asp88 colc88  pros88  lymp88  ocan88  mel88 chrx88 betab88 lasix88 diur88 ccblo88 ald88); 

%hp90(keep=hbp90 db90 chol90 mi90 cabg90 ang90 str90 orhy90 renf90 asp90 colc90  pros90  lymp90  ocan90  mel90 chrx90 betab90 lasix90 diur90 ccblo90 ald90 serum90
           mdb90 fdb90 sdb90 dbfh90); 
if mdb90=1 or fdb90=1 or sdb90=1 then dbfh90=1;
else dbfh90=0;
proc sort;by id;run;

%hp92(keep=hbp92 db92 chol92 mi92 cabg92 ang92 str92 orhy92 renf92 asp92 colc92  pros92  lymp92  ocan92  mel92 chrx92 betab92 lasix92 thiaz92 ccblo92 ald92
           mdb92 fdb92 sdb92 dbfh92);
if mdb92=1 or fdb92=1 or sdb92=1 then dbfh92=1;
else dbfh92=0;
proc sort;by id;run;

%hp94(keep=hbp94 db94 chol94 mi94 cabg94 ang94 str94 orhy94 asp94 colc94  pros94  lymp94  ocan94  mel94 chrx94 betab94 lasix94 thiaz94 ccblo94 ald94);

%hp96(keep=hbp96 db96 chol96 mi96 cabg96 ang96 str96 orhy96 renf96 aspd96 nasp96 asp96 colc96  pros96  lymp96  ocan96  mel96 chrx96 betab96 lasix96 thiaz96 ccblo96 ald96); 
if aspd96=1 or nasp96=1 then asp96=0;
if aspd96 in (2:5) or nasp96 in (2:7) then asp96=1;
else asp96=.;

%hp98(keep=hbp98 db98 chol98 mi98 cabg98 ang98 str98 orhy98 renf98 aspfr98 aspw98 asp98 colc98  pros98  lymp98  ocan98  mel98 chrx98 betab98 lasix98 thiaz98 ccblo98 ald98); 
if aspfr98=1 or aspw98=1 then asp98=0;
if aspfr98 in (2:6) or aspw98 in (2:5) then asp98=1;
else asp98=.;

%hp00(keep=hbp00 db00 chol00 mi00 cabg00 ang00 strk00 orhy00 renf00 asp00 colc00  pros00  lymp00  ocan00  mel00 chrx00 ochrx00 betab00 lasix00 thiaz00 ccblo00 oanth00 serum00);

%hp02(keep=hbp02 db02 chol02 mi02 cabg02 ang02 strk02 orhy02 renal02 asp02 colc02  pros02  lymp02  ocan02  mel02 stat02 ochrx02 betab02 lasix02 thiaz02 calcb02 anthp02 mvt02 mvit02);
if mvt02=2 then mvit02=1;else mvit02=0;

%hp04(keep=hbp04 db04 chol04 mi04 cabg04 ang04 strk04 orhy04 renal04 asp04 colc04  pros04  lymp04  ocan04  mel04 stat04 mev04 zoc04 crest04 prav04 lip04 ostat04 ochrx04 betab04 ace04 lasix04 thiaz04 calcb04 anthp04 tchol04);

%hp06(keep=hbp06 db06 chol06 mi06 cabg06 ang06 strk06 renal06 asp06 colc06  pros06  lymp06  ocan06  mel06 stat06 mev06 zoc06 crest06 prav06 lip06 ostat06 ochrx06 betab06 ace06 lasix06 thiaz06 calcb06 anthp06 mvt06 mvit06);
if mvt06=2 then mvit06=1;else mvit06=0;

%hp08(keep=hbp08 db08 chol08 mi08 cabg08 ang08 strk08 renal08 asp08 colc08  pros08  lymp08  ocan08  mel08 stat08 mev08 zoc08 crest08 prav08 lip08 ostat08 ochrx08 betab08 ace08 lasix08 thiaz08 calcb08 arb08 anthp08
           mdb08 fdb08 sdb08 dbfh08);
if mdb08=1 or fdb08=1 or sdb08=1 then dbfh08=1;
else dbfh08=0;
proc sort;by id;run;

%hp10(keep=hbp10 db10 chol10 mi10 cabg10 ang10 strk10 renal10 asp10 colc10  pros10  lymp10  ocan10  mel10 stat10 mev10 zoc10 crest10 prav10 lip10 ostat10 ochrx10 betab10 ace10 lasix10 thiaz10 calcb10 arb10 anthp10 mvt10 mvit10);
if mvt10=2 then mvit10=1;else mvit10=0;

%hp12(keep=hbp12 db12 chol12 mi12 cabg12 ang12 strk12 renal12 asp12 colc12  pros12  lymp12  ocan12  mel12 stat12 mev12 zoc12 crest12 prav12 lip12 ostat12 ochrx12 betab12 ace12 lasix12 thiaz12 calcb12 arb12 anthp12);

%hp14(keep=hbp14 db14 chol14 mi14 cabg14 ang14 strk14 asp14 colc14  pros14  lymp14  ocan14  mel14 stat14 mev14 zoc14 crest14 prav14 lip14 ostat14 ochrx14 betab14 ace14 lasix14 thiaz14 calcb14 arb14 anthp14 mvt14 mvit14 hisp14);
if mvt14=2 then mvit14=1;else mvit14=0;

%hp16(keep=hbp16 db16 chol16 mi16 cabg16 ang16 stk16 asp16 colc16  pros16  lymp16  ocan16  mel16 stat16 zocor16 crestor16 prava16 lipit16 othmed16 ochrx16 bblock16 aceinhb16 lasix16 thiaz16 cblock16 angio16 antihy16);





/*******************************************************************

Main Exposures - nSES - pull in all Census years for all addresses

Note: Use %nses7614(keep= ); if you want to select date only on 
      certain exposures
      

********************************************************************/
%nses8818 ;
run;


data base0;
merge hp_der(in=mst) hp_der_2 hp_dead hp_diab8622 hp86 hp88 hp90 hp92 hp94 hp96 hp98 hp00 hp02 hp04 hp06 hp08 hp10 hp12 hp14 hp16 hp_mets h86_dt h90_dt h94_dt h98_dt
                     h86_nts h90_nts h94_nts h98_nts h02_nts h06_nts h10_nts h14_nts ahei86 ahei90 ahei94 ahei98 ahei02 ahei06 ahei10 foods nses8818 end=_end_;
by id;
exrec=1;
if first.id and mst then exrec=0; 

birthday=dbmy86;

deadage=int((dtdth-birthday)/12);
   if dtdth in (0,.)then deadage=0;
   if dtdth eq 9999 then deadage=0;

can86=0;
   if pros86=1 or lymp86=1 or ocan86=1 or colc86=1 or mel86=1 then can86=1;
can88=0;
   if pros88=1 or lymp88=1 or ocan88=1 or colc88=1 or mel88=1 then can88=1;
can90=0;
   if pros90=1 or lymp90=1 or ocan90=1 or colc90=1 or mel90=1 then can90=1;
can92=0;
   if pros92=1 or lymp92=1 or ocan92=1 or colc92=1 or mel92=1 then can92=1;
can94=0;
   if pros94=1 or lymp94=1 or ocan94=1 or colc94=1 or mel94=1 then can94=1;
can96=0;
   if pros96=1 or lymp96=1 or ocan96=1 or colc96=1 or mel96=1 then can96=1;
can98=0;
   if pros98=1 or lymp98=1 or ocan98=1 or colc98=1 or mel98=1 then can98=1;
can00=0;
   if pros00=1 or lymp00=1 or ocan00=1 or colc00=1 or mel00=1 then can00=1;
can02=0;
   if pros02=1 or lymp02=1 or ocan02=1 or colc02=1 or mel02=1 then can02=1;
can04=0;
   if pros04=1 or lymp04=1 or ocan04=1 or colc04=1 or mel04=1 then can04=1;
can06=0;
   if pros06=1 or lymp06=1 or ocan06=1 or colc06=1 or mel06=1 then can06=1;
can08=0;
   if pros08=1 or lymp08=1 or ocan08=1 or colc08=1 or mel08=1 then can08=1;
can10=0;
   if pros10=1 or lymp10=1 or ocan10=1 or colc10=1 or mel10=1 then can10=1;
can12=0;
   if pros12=1 or lymp12=1 or ocan12=1 or colc12=1 or mel12=1 then can12=1;
can14=0;
   if pros14=1 or lymp14=1 or ocan14=1 or colc14=1 or mel14=1 then can14=1;
can16=0;
   if pros16=1 or lymp16=1 or ocan16=1 or colc16=1 or mel16=1 then can16=1;



/***ethnicity data****/
if seuro86=1 then ethnic =1;
else if scand86=1 then ethnic =1;
else if ocauc86=1 then ethnic =1;
else if afric86=1 then ethnic =2;
else if asian86=1 then ethnic =3;
else if oanc86=1  then ethnic =4;
else ethnic=.;

%indic3(vbl=ethnic, prefix=ethnic, reflev=1, min=2, max=4, missing=., usemiss=1,
 label1='causcasian',
 label2='african',
 label3='asian',
 label4='other');
if ethnic = 1 then eth3g=1;
else if ethnic=2 then eth3g=2;
else if ethnic in (3,4) then eth3g=3;
else eth3g=1;

%indic3(vbl=eth3g, prefix=eth3g, reflev=1, min=2, max=3, missing=., usemiss=1,
 label1='causcasian',
 label2='african',
 label3='asian & others');
if eth3g=1 then white=1;
else white=0;
if ethnic=. then white=.;

if white=1 then white2=1;
else white2=0;

if ethnic=1 and hisp14 ne 2 then catrace=0; /*non-hispanic white*/
else if ethnic=2 and hisp14 ne 2 then catrace=1; /*non-hispanic black*/
else if hisp14=2 then catrace=2; /*Hispanic*/
else if ethnic=3 then catrace=3; /*Asian*/
else catrace=.;

if catrace=0 then catrace2=0;
else if catrace in (1,2,3) then catrace2=1;
else catrace2=.;


/******************* cholesterol lowering drug ******************************/
if antch86=1 then hchtx86=1;else hchtx86=0;
if chrx88=1 then hchtx88=1;else hchtx88=0;
if chrx90=1 then hchtx90=1;else hchtx90=0;
if chrx92=1 then hchtx92=1;else hchtx92=0;
if chrx94=1 then hchtx94=1;else hchtx94=0;
if chrx96=1 then hchtx96=1;else hchtx96=0;
if chrx98=1 then hchtx98=1;else hchtx98=0;
if chrx00=1 then chrx00=1;else chrx00=0;
/*if chrx00=1 or ochrx00=1 then hchtx00=1;else hchtx00=0;*//*Other Chol lowering drug*/
if stat02=1 then chrx02=1;else chrx02=0;
/*if chrx02=1 or ochrx02=1 then hchtx02=1;else hchtx02=0;*/
if stat04=1 or mev04=1 or zoc04=1 or crest04=1 or prav04=1 or lip04=1 or ostat04=1 then chrx04=1; else chrx04=0;
if chrx04=1 or ochrx04=1 then hchtx04=1;else hchtx04=0;
if stat06=1 or mev06=1 or zoc06=1 or crest06=1 or prav06=1 or lip06=1 or ostat06=1 then chrx06=1; else chrx06=0;
if chrx06=1 or ochrx06=1 then hchtx06=1;else hchtx06=0;
if stat08=1 or mev08=1 or zoc08=1 or crest08=1 or prav08=1 or lip08=1 or ostat08=1 then chrx08=1; else chrx08=0;
if chrx08=1 or ochrx08=1 then hchtx08=1;else hchtx08=0;
if stat10=1 or mev10=1 or zoc10=1 or crest10=1 or prav10=1 or lip10=1 or ostat10=1 then chrx10=1; else chrx10=0;
if chrx10=1 or ochrx10=1 then hchtx10=1;else hchtx10=0;
if stat12=1 or mev12=1 or zoc12=1 or crest12=1 or prav12=1 or lip12=1 or ostat12=1 then chrx12=1; else chrx12=0;
if chrx12=1 or ochrx12=1 then hchtx12=1;else hchtx12=0;
if stat14=1 or mev14=1 or zoc14=1 or crest14=1 or prav14=1 or lip14=1 or ostat14=1 then chrx14=1; else chrx14=0;
if chrx14=1 or ochrx14=1 then hchtx14=1;else hchtx14=0;
if stat16=1 or zocor16=1 or crestor16=1 or prava16=1 or lipit16=1 or othmed16=1 then chrx16=1; else chrx16=0;
if chrx16=1 or ochrx16=1 then hchtx16=1;else hchtx16=0;


/***antihypertensive***/
   if (betab86 =1 or lasix86=1 or diur86 =1 or calcb86=1 or ald86=1) then htnrx86=1;
       else htnrx86=0;

   if (betab88 =1 or lasix88=1 or diur88 =1 or ccblo88=1 or ald88=1) then htnrx88=1;
       else htnrx88=0;

   if (betab90 =1 or lasix90=1 or diur90 =1 or ccblo90=1 or ald90=1) then htnrx90=1;
       else htnrx90=0;

   if (betab92 =1 or lasix92=1 or thiaz92=1 or ccblo92=1 or ald92=1) then htnrx92=1;
       else htnrx92=0;

   if (betab94 =1 or lasix94=1 or thiaz94=1 or ccblo94=1 or ald94=1) then htnrx94=1;
       else htnrx94=0;

   if (betab96 =1 or lasix96=1 or thiaz96=1 or ccblo96=1 or ald96=1) then htnrx96=1;
       else htnrx96=0;

   if (betab98 =1 or lasix98=1 or thiaz98=1 or ccblo98=1 or ald98=1) then htnrx98=1;
       else htnrx98=0;

   if (betab00 =1 or lasix00=1 or thiaz00=1 or ccblo00=1 or oanth00=1) then htnrx00=1;
       else htnrx00=0;

   if (betab02 =1 or lasix02=1 or thiaz02 =1 or calcb02=1 or anthp02=1) then htnrx02=1;
       else htnrx02=0;

   if (betab04 =1 or ace04=1 or lasix04=1 or thiaz04 =1 or calcb04=1 or anthp04=1) then htnrx04=1;
       else htnrx04=0; 

   if (betab06 =1 or ace06=1 or lasix06=1 or thiaz06 =1 or calcb06=1 or anthp06=1) then htnrx06=1;
       else htnrx06=0; 

   if (betab08 =1 or ace08=1 or lasix08=1 or thiaz08 =1 or calcb08=1 or arb08=1 or anthp08=1) then htnrx08=1;
       else htnrx08=0; 

   if (betab10 =1 or ace10=1 or lasix10=1 or thiaz10 =1 or calcb10=1 or arb10=1 or anthp10=1) then htnrx10=1;
       else htnrx10=0;

   if (betab12 =1 or ace12=1 or lasix12=1 or thiaz12 =1 or calcb12=1 or arb12=1 or anthp12=1) then htnrx12=1;
       else htnrx12=0;

   if (betab14 =1 or ace14=1 or lasix14=1 or thiaz14 =1 or calcb14=1 or arb14=1 or anthp14=1) then htnrx14=1;
       else htnrx14=0;
  
   if (bblock16=1 or aceinhb16=1 or lasix16=1 or thiaz16=1 or cblock16=1 or angio16=1 or antihy16=1) then htnrx16=1;
       else htnrx16=0;



/* Set up family hx of MI */
famhxmi=0;
if mmi86=1 or fmi86=1 then famhxmi=1;

if dbfh90=1 or dbfh92=1 or dbfh08=1 then dbfh=1; else dbfh=0;

array wt  {16}  wt86    wt88    wt90    wt92    wt94    wt96    wt98    wt00     wt02     wt04     wt06      wt08  wt10  wt12  wt14 wt16   ;
array bmi     {16}  bmi86   bmi88   bmi90   bmi92   bmi94   bmi96   bmi98   bmi00    bmi02    bmi04    bmi06     bmi08   bmi10   bmi12   bmi14 bmi16  ;
array smoke    {16}  smoke86 smoke88 smoke90 smoke92 smoke94 smoke96 smoke98 smoke00  smoke02  smoke04  smoke06   smoke08  smoke10  smoke12  smoke14 smoke16  ;
array cgnm   {16}  cgnm86  cgnm88  cgnm90  cgnm92  cgnm94  cgnm96  cgnm98  cgnm00   cgnm02   cgnm04   cgnm06    cgnm08  cgnm10   cgnm12    cgnm14 cgnm16  ;
array smm     {16}  smm86   smm88   smm90   smm92   smm94   smm96   smm98   smm00    smm02    smm04    smm06     smm08    smm10    smm12     smm14 smm16  ;

do m=1 to 16;
   if wt{m}=0 then wt{m}=.;      
      bmi{m}=.;   
    if height>0 and wt{m}>0 then bmi{m}=(wt{m}*0.45359237)/((height*25.4/1000)*(height*25.4/1000)); 
end;

do i=1 to 16;
    if smoke{i}=5 then smoke{i}=1;      
    if smoke{i} in (1,3) then smm{i}=1;      /*Never*/
    if smoke{i}=2 then smm{i}=2;      /*Past*/
    if smoke{i}=4 and cgnm{i} in (1,2) then smm{i}=3;  /*Current, 1-14*/
    if smoke{i}=4 and cgnm{i}=3 then smm{i}=4;  /*Current, 15-24*/
    if smoke{i}=4 and cgnm{i} in (4,5,6) then smm{i}=5;  /*Current, 25+*/
end;

do j=2 to 16;
   if bmi{j}=.      then bmi{j}=bmi{j-1};
   if smoke{j}=.     then smoke{j}=smoke{j-1};
   if cgnm{j}=.    then cgnm{j}=cgnm{j-1};
   if smm{j}=.    then smm{j}=smm{j-1};
end;

run;

/*proc datasets nolist;
delete hp_der hp_der_2 hp86 hp88 hp90 hp92 hp94 hp96 hp98 hp00 hp02 hp04 hp06 hp08 cvd10 h02_nts h06_nts h10_nts base0 
      hfcaseall ahei86 ahei90 ahei94 ahei98 ahei02 ahei06;
run;*/

proc freq data= base0;tables ethnic*hisp14;run;
proc freq data= base0;tables catrace;run;

proc means data=base0 n mean median min max;
var bmi86 act86;
run;

proc means data=base0 n mean std median; var bmi86;run;


data base0;
   set base0;

    /* Define arrays for the character state variables and their numeric counterparts */
    ARRAY state_char{16} $ state10_88 state10_88 state10_90 state10_92 state10_94 state10_96 
                         state10_98 state10_00 state10_02 state10_04 state10_06 state10_08 
                         state10_10 state10_12 state10_14 state10_16;

    ARRAY state_num{16} state10_88_num state10_88_num state10_90_num state10_92_num state10_94_num
                       state10_96_num state10_98_num state10_00_num state10_02_num state10_04_num 
                       state10_06_num state10_08_num state10_10_num state10_12_num state10_14_num 
                       state10_16_num;

    /* Define arrays for state names and numeric labels */
    ARRAY state_names{50} $ ('AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 
                            'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 
                            'KY', 'LA', 'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 
                            'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 
                            'NC', 'ND', 'OH', 'OK', 'OR', 'PA', 'RI', 'SC', 
                            'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 
                            'WI', 'WY');
    ARRAY state_labels{50} (1, 2, 3, 4, 5, 6, 7, 8, 
                            9, 10, 11, 12, 13, 14, 15, 16, 
                            17, 18, 19, 20, 21, 22, 23, 24, 
                            25, 26, 27, 28, 29, 30, 31, 32, 
                            33, 34, 35, 36, 37, 38, 39, 40, 
                            41, 42, 43, 44, 45, 46, 47, 48, 
                            49, 50);

    /* Loop through each state variable */
    DO i = 1 TO DIM(state_char);
        /* Default to missing if no match */
        state_num{i} = .;

        /* Loop through state names to find a match */
        DO j = 1 TO DIM(state_names);
            IF state_char{i} = state_names{j} THEN DO;
                state_num{i} = state_labels{j}; /* Assign the corresponding numeric label */
                LEAVE; /* Exit loop once a match is found */
            END;
        END;
    END;

    /* Optional: Drop the original character variables if no longer needed */
    DROP  state10_88 state10_90 state10_92 state10_94 state10_96 
         state10_98 state10_00 state10_02 state10_04 state10_06 state10_08 
         state10_10 state10_12 state10_14 state10_16;
RUN;