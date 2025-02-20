/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/06/2024
Purpose of the program: 
   S.Table 8. Associations between cumulative average without most recent potato intakes and risk of diabetes in the NHS using different types of dietary assessments



data one;
   set all end=_end_;

if hbp76=1 or hbp78=1 or hbp80=1 or hbp82=1 or hbp84=2 then hxhbp=1; else hxhbp = 0;
if chol76 = 1 or chol78= 1 or  chol80 = 1 or chol82 = 1 or  chol84 = 2 then hxchol=1; else hxchol = 0;
if db76 = 1 or db78 = 1 or db80 = 1 or db82 = 1 or db84 = 2 then hxdb = 1; else hxdb = 0;
if hrt76 in (1,2) or hrt78 in (1,2) or hrt80 in (1,2) or hrt82 in (1,2) or hrt84 in (1,2) or cabg84=2 or str84=2 then hxcvd = 1; else hxcvd = 0;
if can76 = 1 or can78 = 1 or can80 = 1 or can82=1 or can84=2 then hxcan = 1; else hxcan = 0;


array nocum84 {*}  aofib84n ceraf84n alco84n calor84n trans84n sat84n mon84n poly84n gid84n fol_84n prot84n carbo84n carbden84n protden84n tpotat84d bbmpot84d fpotat84d chipss84d prmeat84d urmeat84d trmeat84d poultr84d fishal84d regegg84d hdairy84d ldairy84d /*soypro84d*/ nutsal84d legume84d fruits84d vegeal84d nstveg84d staveg84d tdairy84d coffee84d nutleg84d bwrice84d wtrice84d SSB84d whgrn84n rfgrn84n whgrns84d rfgrns84d gl84n ahei84 aheinoal84 aheinopt84 aheifisha84 aheidairy84 aheinutbl84 aheipoult84 aheineggs84;  
array nocum86 {*}  aofib86n ceraf86n alco86n calor86n trnss86n sat86n mon86n poly86n gid86n fol_86n prot86n carbo86n carbden86n protden86n tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d /*soypro86d*/ nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d whgrn86n rfgrn86n whgrns86d rfgrns86d gl86n ahei86 aheinoal86 aheinopt86 aheifisha86 aheidairy86 aheinutbl86 aheipoult86 aheineggs86;  
array nocum90 {*}  aofib90n ceraf90n alco90n calor90n trnss90n sat90n mon90n poly90n gid90n fol_90n prot90n carbo90n carbden90n protden90n tpotat90d bbmpot90d fpotat90d chipss90d prmeat90d urmeat90d trmeat90d poultr90d fishal90d regegg90d hdairy90d ldairy90d /*soypro90d*/ nutsal90d legume90d fruits90d vegeal90d nstveg90d staveg90d tdairy90d coffee90d nutleg90d bwrice90d wtrice90d SSB90d whgrn90n rfgrn90n whgrns90d rfgrns90d gl90n ahei90 aheinoal90 aheinopt90 aheifisha90 aheidairy90 aheinutbl90 aheipoult90 aheineggs90;
array nocum94 {*}  aofib94n ceraf94n alco94n calor94n trnss94n sat94n mon94n poly94n gid94n fol_94n prot94n carbo94n carbden94n protden94n tpotat94d bbmpot94d fpotat94d chipss94d prmeat94d urmeat94d trmeat94d poultr94d fishal94d regegg94d hdairy94d ldairy94d /*soypro94d*/ nutsal94d legume94d fruits94d vegeal94d nstveg94d staveg94d tdairy94d coffee94d nutleg94d bwrice94d wtrice94d SSB94d whgrn94n rfgrn94n whgrns94d rfgrns94d gl94n ahei94 aheinoal94 aheinopt94 aheifisha94 aheidairy94 aheinutbl94 aheipoult94 aheineggs94;
array nocum98 {*}  aofib98n ceraf98n alco98n calor98n trn0098n sat98n mon98n poly98n gid98n fol9898n prot98n carbo98n carbden98n protden98n tpotat98d bbmpot98d fpotat98d chipss98d prmeat98d urmeat98d trmeat98d poultr98d fishal98d regegg98d hdairy98d ldairy98d /*soypro98d*/ nutsal98d legume98d fruits98d vegeal98d nstveg98d staveg98d tdairy98d coffee98d nutleg98d bwrice98d wtrice98d SSB98d whgrn98n rfgrn98n whgrns98d rfgrns98d gl98n ahei98 aheinoal98 aheinopt98 aheifisha98 aheidairy98 aheinutbl98 aheipoult98 aheineggs98;
array nocum02 {*}  aofib02n ceraf02n alco02n calor02n trn0202n sat02n mon02n poly02n gid02n fol9802n prot02n carbo02n carbden02n protden02n tpotat02d bbmpot02d fpotat02d chipss02d prmeat02d urmeat02d trmeat02d poultr02d fishal02d regegg02d hdairy02d ldairy02d /*soypro02d*/ nutsal02d legume02d fruits02d vegeal02d nstveg02d staveg02d tdairy02d coffee02d nutleg02d bwrice02d wtrice02d SSB02d whgrn02n rfgrn02n whgrns02d rfgrns02d gl02n ahei02 aheinoal02 aheinopt02 aheifisha02 aheidairy02 aheinutbl02 aheipoult02 aheineggs02;
array nocum06 {*}  aofib06n ceraf06n alco06n calor06n trn0706n sat06n mon06n poly06n gid06n fol9806n prot06n carbo06n carbden06n protden06n tpotat06d bbmpot06d fpotat06d chipss06d prmeat06d urmeat06d trmeat06d poultr06d fishal06d regegg06d hdairy06d ldairy06d /*soypro06d*/ nutsal06d legume06d fruits06d vegeal06d nstveg06d staveg06d tdairy06d coffee06d nutleg06d bwrice06d wtrice06d SSB06d whgrn06n rfgrn06n whgrns06d rfgrns06d gl06n ahei06 aheinoal06 aheinopt06 aheifisha06 aheidairy06 aheinutbl06 aheipoult06 aheineggs06;
array nocum10 {*}  aofib10n ceraf10n alco10n calor10n trn1110n sat10n mon10n poly10n gid10n fol9810n prot10n carbo10n carbden10n protden10n tpotat10d bbmpot10d fpotat10d chipss10d prmeat10d urmeat10d trmeat10d poultr10d fishal10d regegg10d hdairy10d ldairy10d /*soypro10d*/ nutsal10d legume10d fruits10d vegeal10d nstveg10d staveg10d tdairy10d coffee10d nutleg10d bwrice10d wtrice10d SSB10d whgrn10n rfgrn10n whgrns10d rfgrns10d gl10n ahei10 aheinoal10 aheinopt10 aheifisha10 aheidairy10 aheinutbl10 aheipoult10 aheineggs10;

array cumul84 {*}  aofib84ca ceraf84ca alco84ca calor84ca trans84ca sat84ca mon84ca poly84ca gid84ca fol_84ca prot84ca carbo84ca carbden84ca protden84ca tpotat84ca bbmpot84ca fpotat84ca chipss84ca prmeat84ca urmeat84ca trmeat84ca poultr84ca fishal84ca regegg84ca hdairy84ca ldairy84ca /*soypro84ca*/ nutsal84ca legume84ca fruits84ca vegeal84ca nstveg84ca staveg84ca tdairy84ca coffee84ca nutleg84ca bwrice84ca wtrice84ca SSB84ca whgrn84ca rfgrn84ca whgrns84ca rfgrns84ca gl84ca ahei84ca aheinoal84ca aheinopt84ca aheifisha84ca aheidairy84ca aheinutbl84ca aheipoult84ca aheineggs84ca;  
array cumul86 {*}  aofib86ca ceraf86ca alco86ca calor86ca trnss86ca sat86ca mon86ca poly86ca gid86ca fol_86ca prot86ca carbo86ca carbden86ca protden86ca tpotat86ca bbmpot86ca fpotat86ca chipss86ca prmeat86ca urmeat86ca trmeat86ca poultr86ca fishal86ca regegg86ca hdairy86ca ldairy86ca /*soypro86ca*/ nutsal86ca legume86ca fruits86ca vegeal86ca nstveg86ca staveg86ca tdairy86ca coffee86ca nutleg86ca bwrice86ca wtrice86ca SSB86ca whgrn86ca rfgrn86ca whgrns86ca rfgrns86ca gl86ca ahei86ca aheinoal86ca aheinopt86ca aheifisha86ca aheidairy86ca aheinutbl86ca aheipoult86ca aheineggs86ca;  
array cumul90 {*}  aofib90ca ceraf90ca alco90ca calor90ca trnss90ca sat90ca mon90ca poly90ca gid90ca fol_90ca prot90ca carbo90ca carbden90ca protden90ca tpotat90ca bbmpot90ca fpotat90ca chipss90ca prmeat90ca urmeat90ca trmeat90ca poultr90ca fishal90ca regegg90ca hdairy90ca ldairy90ca /*soypro90ca*/ nutsal90ca legume90ca fruits90ca vegeal90ca nstveg90ca staveg90ca tdairy90ca coffee90ca nutleg90ca bwrice90ca wtrice90ca SSB90ca whgrn90ca rfgrn90ca whgrns90ca rfgrns90ca gl90ca ahei90ca aheinoal90ca aheinopt90ca aheifisha90ca aheidairy90ca aheinutbl90ca aheipoult90ca aheineggs90ca;
array cumul94 {*}  aofib94ca ceraf94ca alco94ca calor94ca trnss94ca sat94ca mon94ca poly94ca gid94ca fol_94ca prot94ca carbo94ca carbden94ca protden94ca tpotat94ca bbmpot94ca fpotat94ca chipss94ca prmeat94ca urmeat94ca trmeat94ca poultr94ca fishal94ca regegg94ca hdairy94ca ldairy94ca /*soypro94ca*/ nutsal94ca legume94ca fruits94ca vegeal94ca nstveg94ca staveg94ca tdairy94ca coffee94ca nutleg94ca bwrice94ca wtrice94ca SSB94ca whgrn94ca rfgrn94ca whgrns94ca rfgrns94ca gl94ca ahei94ca aheinoal94ca aheinopt94ca aheifisha94ca aheidairy94ca aheinutbl94ca aheipoult94ca aheineggs94ca;
array cumul98 {*}  aofib98ca ceraf98ca alco98ca calor98ca trn0098ca sat98ca mon98ca poly98ca gid98ca fol9898ca prot98ca carbo98ca carbden98ca protden98ca tpotat98ca bbmpot98ca fpotat98ca chipss98ca prmeat98ca urmeat98ca trmeat98ca poultr98ca fishal98ca regegg98ca hdairy98ca ldairy98ca /*soypro98ca*/ nutsal98ca legume98ca fruits98ca vegeal98ca nstveg98ca staveg98ca tdairy98ca coffee98ca nutleg98ca bwrice98ca wtrice98ca SSB98ca whgrn98ca rfgrn98ca whgrns98ca rfgrns98ca gl98ca ahei98ca aheinoal98ca aheinopt98ca aheifisha98ca aheidairy98ca aheinutbl98ca aheipoult98ca aheineggs98ca;
array cumul02 {*}  aofib02ca ceraf02ca alco02ca calor02ca trn0202ca sat02ca mon02ca poly02ca gid02ca fol9802ca prot02ca carbo02ca carbden02ca protden02ca tpotat02ca bbmpot02ca fpotat02ca chipss02ca prmeat02ca urmeat02ca trmeat02ca poultr02ca fishal02ca regegg02ca hdairy02ca ldairy02ca /*soypro02ca*/ nutsal02ca legume02ca fruits02ca vegeal02ca nstveg02ca staveg02ca tdairy02ca coffee02ca nutleg02ca bwrice02ca wtrice02ca SSB02ca whgrn02ca rfgrn02ca whgrns02ca rfgrns02ca gl02ca ahei02ca aheinoal02ca aheinopt02ca aheifisha02ca aheidairy02ca aheinutbl02ca aheipoult02ca aheineggs02ca;
array cumul06 {*}  aofib06ca ceraf06ca alco06ca calor06ca trn0706ca sat06ca mon06ca poly06ca gid06ca fol9806ca prot06ca carbo06ca carbden06ca protden06ca tpotat06ca bbmpot06ca fpotat06ca chipss06ca prmeat06ca urmeat06ca trmeat06ca poultr06ca fishal06ca regegg06ca hdairy06ca ldairy06ca /*soypro06ca*/ nutsal06ca legume06ca fruits06ca vegeal06ca nstveg06ca staveg06ca tdairy06ca coffee06ca nutleg06ca bwrice06ca wtrice06ca SSB06ca whgrn06ca rfgrn06ca whgrns06ca rfgrns06ca gl06ca ahei06ca aheinoal06ca aheinopt06ca aheifisha06ca aheidairy06ca aheinutbl06ca aheipoult06ca aheineggs06ca;
array cumul10 {*}  aofib10ca ceraf10ca alco10ca calor10ca trn1110ca sat10ca mon10ca poly10ca gid10ca fol9810ca prot10ca carbo10ca carbden10ca protden10ca tpotat10ca bbmpot10ca fpotat10ca chipss10ca prmeat10ca urmeat10ca trmeat10ca poultr10ca fishal10ca regegg10ca hdairy10ca ldairy10ca /*soypro10ca*/ nutsal10ca legume10ca fruits10ca vegeal10ca nstveg10ca staveg10ca tdairy10ca coffee10ca nutleg10ca bwrice10ca wtrice10ca SSB10ca whgrn10ca rfgrn10ca whgrns10ca rfgrns10ca gl10ca ahei10ca aheinoal10ca aheinopt10ca aheifisha10ca aheidairy10ca aheinutbl10ca aheipoult10ca aheineggs10ca;


do i = 1 to DIM(cumul10);
        cumul84{i} = nocum84{i};
        cumul86{i} = nocum84{i};
        cumul90{i} = mean(nocum84{i}, nocum86{i});
        cumul94{i} = mean(nocum84{i}, nocum86{i}, nocum90{i});
        cumul98{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i});
        cumul02{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
        cumul06{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i});
        cumul10{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i});
end;

run;

data two;
   set one end=_end_;
 
  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1); 
   if white=1 then white2=1;
   else white2=0;

  /*%indic3(vbl=race9204, prefix=catrace, min=2,max=5, reflev=1, missing=., usemiss=1); */

   
array irt   {19}  irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12  irt14  irt16 irt18 cutoff;
array perioda  {18}  period1  period2  period3  period4  period5  period6  period7  period8  period9  period10 period11 period12 period13 period14 period15 period16 period17 period18;
array tvar  {18}  t84  t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06   t08 t10 t12 t14 t16 t18;
array age   {18}  age84 age86 age88 age90 age92 age94 age96 age98 age00 age02 age04 age06 age08 age10 age12  age14 age16 age18;
array aspyn {18}  aspyn84 aspyn86 aspyn88   aspyn90  aspyn92  aspyn94  aspyn96  aspyn98  aspyn00  aspyn02  aspyn04  aspyn06  aspyn08  aspyn10  aspyn12 aspyn14 aspyn16 aspyn16;
array hbp   {18}  hbp84 hbp86   hbp88   hbp90   hbp92   hbp94   hbp96   hbp98   hbp00    hbp02    hbp04    hbp06     hbp08 hbp10 hbp12 hbp14 hbp16 hbp16 ; 
array nsmk  {18}  smkdr84 smkdr86  smkdr88  smkdr90  smkdr92  smkdr94  smkdr96  smkdr98  smkdr00  smkdr02  smkdr04  smkdr06  smkdr08  smkdr10  smkdr12  smkdr14 smkdr16 smkdr16;
array bmi   {18}  bmi84 bmi86 bmi88 bmi90 bmi92 bmi94 bmi96 bmi98 bmi00 bmi02 bmi04 bmi06 bmi08 bmi10 bmi12 bmi14 bmi16 bmi16;
array actm  {18}  act86m act86m act88m act88m act92m act94m act96m act98m act00m act00m act04m act04m act08m act08m act12m act14m act14m act14m;
array pam   {18}  act86m act86m act88m act88m act92m act94m act96m act98m act00m act00m act04m act04m act08m act08m act12m act14m act14m act14m;
array horm  {18}  nhor84 nhor86 nhor88 nhor90 nhor92 nhor94 nhor96 nhor98 nhor00 nhor02 nhor04 nhor06 nhor08 nhor10 nhor12 nhor14 nhor16 nhor16;
array mvit  {18}  mvitu84 mvitu86 mvitu88 mvitu90 mvitu92 mvitu94 mvitu96 mvitu98 mvitu00 mvitu02 mvitu04 mvitu06 mvitu08 mvitu10 mvitu12 mvitu14 mvitu16 mvitu16;
array supp  {18}  suppu84 suppu86 suppu88 suppu90 suppu92 suppu94 suppu96 suppu98 suppu00 suppu02 suppu04 suppu06 suppu08 suppu10 suppu12 suppu14 suppu16 suppu16;
array antihp   {18}  htnrx88  htnrx88  htnrx88  htnrx88  htnrx88  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08 htnrx10 htnrx12 htnrx14 htnrx16 htnrx16; 
array antitc   {18}  hchtx88  hchtx88  hchtx88  hchtx88  hchtx88  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08 hchtx10 hchtx12 hchtx14 hchtx16 hchtx16;

array calorca  {18}  calor84ca calor86ca calor86ca calor90ca calor90ca calor94ca calor94ca calor98ca calor98ca calor02ca calor02ca calor06ca calor06ca calor10ca calor10ca calor10ca calor10ca calor10ca;
array aofibca  {18}  aofib84ca aofib86ca aofib86ca aofib90ca aofib90ca aofib94ca aofib94ca aofib98ca aofib98ca aofib02ca aofib02ca aofib06ca aofib06ca aofib10ca aofib10ca aofib10ca aofib10ca aofib10ca;
array cerafca  {18}  ceraf84ca ceraf86ca ceraf86ca ceraf90ca ceraf90ca ceraf94ca ceraf94ca ceraf98ca ceraf98ca ceraf02ca ceraf02ca ceraf06ca ceraf06ca ceraf10ca ceraf10ca ceraf10ca ceraf10ca ceraf10ca;
array alcoca  {18}  alco84ca alco86ca alco86ca alco90ca alco90ca alco94ca alco94ca alco98ca alco98ca alco02ca alco02ca alco06ca alco06ca alco10ca alco10ca alco10ca alco10ca alco10ca;
array satfca  {18}  sat84ca sat86ca sat86ca sat90ca sat90ca sat94ca sat94ca sat98ca sat98ca sat02ca sat02ca sat06ca sat06ca sat10ca sat10ca sat10ca sat10ca sat10ca;
array monfca  {18}  mon84ca mon86ca mon86ca mon90ca mon90ca mon94ca mon94ca mon98ca mon98ca mon02ca mon02ca mon06ca mon06ca mon10ca mon10ca mon10ca mon10ca mon10ca;
array polyfca  {18}  poly84ca poly86ca poly86ca poly90ca poly90ca poly94ca poly94ca poly98ca poly98ca poly02ca poly02ca poly06ca poly06ca poly10ca poly10ca poly10ca poly10ca poly10ca;
array transfca  {18}  trans84ca trnss86ca trnss86ca trnss90ca trnss90ca trnss94ca trnss94ca trn0098ca trn0098ca trn0202ca trn0202ca trn0706ca trn0706ca trn1110ca trn1110ca trn1110ca trn1110ca trn1110ca;
array folca  {18}  fol_84ca fol_86ca fol_86ca fol_90ca fol_90ca fol_94ca fol_94ca fol9898ca fol9898ca fol9802ca fol9802ca fol9806ca fol9806ca fol9810ca fol9810ca fol9810ca fol9810ca fol9810ca;
array protca  {18}  prot84ca prot86ca prot86ca prot90ca prot90ca prot94ca prot94ca prot98ca prot98ca prot02ca prot02ca prot06ca prot06ca prot10ca prot10ca prot10ca prot10ca prot10ca;
array protdenca  {18}  protden84ca protden86ca protden86ca protden90ca protden90ca protden94ca protden94ca protden98ca protden98ca protden02ca protden02ca protden06ca protden06ca protden10ca protden10ca protden10ca protden10ca protden10ca;
array gidca  {18}   gid84ca gid86ca gid86ca gid90ca gid90ca gid94ca gid94ca gid98ca gid98ca gid02ca gid02ca gid06ca gid06ca gid10ca gid10ca gid10ca gid10ca gid10ca;
array carboca  {18}   carbo84ca carbo86ca carbo86ca carbo90ca carbo90ca carbo94ca carbo94ca carbo98ca carbo98ca carbo02ca carbo02ca carbo06ca carbo06ca carbo10ca carbo10ca carbo10ca carbo10ca carbo10ca;
array carbdenca  {18}   carbden84ca carbden86ca carbden86ca carbden90ca carbden90ca carbden94ca carbden94ca carbden98ca carbden98ca carbden02ca carbden02ca carbden06ca carbden06ca carbden10ca carbden10ca carbden10ca carbden10ca carbden10ca;

array calor  {18}   calor84n calor86n calor86n calor90n calor90n calor94n calor94n calor98n calor98n calor02n calor02n calor06n calor06n calor10n calor10n calor10n calor10n calor10n;
array carbo  {18}   carbo84n carbo86n carbo86n carbo90n carbo90n carbo94n carbo94n carbo98n carbo98n carbo02n carbo02n carbo06n carbo06n carbo10n carbo10n carbo10n carbo10n carbo10n;
array carbden  {18}  carbden84n carbden86n carbden86n carbden90n carbden90n carbden94n carbden94n carbden98n carbden98n carbden02n carbden02n carbden06n carbden06n carbden10n carbden10n carbden10n carbden10n carbden10n;
array prot  {18}   prot84n prot86n prot86n prot90n prot90n prot94n prot94n prot98n prot98n prot02n prot02n prot06n prot06n prot10n prot10n prot10n prot10n prot10n;
array protden  {18} protden84n protden86n protden86n protden90n protden90n protden94n protden94n protden98n protden98n protden02n protden02n protden06n protden06n protden10n protden10n protden10n protden10n protden10n;
array alco  {18}   alco84n alco86n alco86n alco90n alco90n alco94n alco94n alco98n alco98n alco02n alco02n alco06n alco06n alco10n alco10n alco10n alco10n alco10n;
array ceraf  {18}  ceraf84n ceraf86n ceraf86n ceraf90n ceraf90n ceraf94n ceraf94n ceraf98n ceraf98n ceraf02n ceraf02n ceraf06n ceraf06n ceraf10n ceraf10n ceraf10n ceraf10n ceraf10n;
array aofib  {18}  aofib84n aofib86n aofib86n aofib90n aofib90n aofib94n aofib94n aofib98n aofib98n aofib02n aofib02n aofib06n aofib06n aofib10n aofib10n aofib10n aofib10n aofib10n;

array tpotat  {18}  tpotat84d tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d tpotat94d tpotat98d tpotat98d tpotat02d tpotat02d tpotat06d tpotat06d tpotat10d tpotat10d tpotat10d tpotat10d tpotat10d;
array bbmpot  {18}  bbmpot84d bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d bbmpot94d bbmpot98d bbmpot98d bbmpot02d bbmpot02d bbmpot06d bbmpot06d bbmpot10d bbmpot10d bbmpot10d bbmpot10d bbmpot10d;
array fpotat  {18}  fpotat84d fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d fpotat94d fpotat98d fpotat98d fpotat02d fpotat02d fpotat06d fpotat06d fpotat10d fpotat10d fpotat10d fpotat10d fpotat10d; 
array chipss  {18}  chipss84d chipss86d chipss86d chipss90d chipss90d chipss94d chipss94d chipss98d chipss98d chipss02d chipss02d chipss06d chipss06d chipss10d chipss10d chipss10d chipss10d chipss10d;
array prmeat  {18}  prmeat84d prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d prmeat94d prmeat98d prmeat98d prmeat02d prmeat02d prmeat06d prmeat06d prmeat10d prmeat10d prmeat10d prmeat10d prmeat10d;
array urmeat  {18}  urmeat84d urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d urmeat94d urmeat98d urmeat98d urmeat02d urmeat02d urmeat06d urmeat06d urmeat10d urmeat10d urmeat10d urmeat10d urmeat10d;
array trmeat  {18}  trmeat84d trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d trmeat94d trmeat98d trmeat98d trmeat02d trmeat02d trmeat06d trmeat06d trmeat10d trmeat10d trmeat10d trmeat10d trmeat10d;
array poultr  {18}  poultr84d poultr86d poultr86d poultr90d poultr90d poultr94d poultr94d poultr98d poultr98d poultr02d poultr02d poultr06d poultr06d poultr10d poultr10d poultr10d poultr10d poultr10d;
array fishal  {18}  fishal84d fishal86d fishal86d fishal90d fishal90d fishal94d fishal94d fishal98d fishal98d fishal02d fishal02d fishal06d fishal06d fishal10d fishal10d fishal10d fishal10d fishal10d;
array regegg  {18}  regegg84d regegg86d regegg86d regegg90d regegg90d regegg94d regegg94d regegg98d regegg98d regegg02d regegg02d regegg06d regegg06d regegg10d regegg10d regegg10d regegg10d regegg10d;
array hdairy  {18}  hdairy84d hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d hdairy94d hdairy98d hdairy98d hdairy02d hdairy02d hdairy06d hdairy06d hdairy10d hdairy10d hdairy10d hdairy10d hdairy10d;
array ldairy  {18}  ldairy84d ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ldairy94d ldairy98d ldairy98d ldairy02d ldairy02d ldairy06d ldairy06d ldairy10d ldairy10d ldairy10d ldairy10d ldairy10d;
/*array soypro  {18}  soypro84d soypro86d soypro86d soypro90d soypro90d soypro94d soypro94d soypro98d soypro98d soypro02d soypro02d soypro06d soypro06d soypro10d soypro10d soypro10d soypro10d soypro10d;*/
array nutsal  {18}  nutsal84d nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d nutsal94d nutsal98d nutsal98d nutsal02d nutsal02d nutsal06d nutsal06d nutsal10d nutsal10d nutsal10d nutsal10d nutsal10d;
array legume  {18}  legume84d legume86d legume86d legume90d legume90d legume94d legume94d legume98d legume98d legume02d legume02d legume06d legume06d legume10d legume10d legume10d legume10d legume10d;
array fruits  {18}  fruits84d fruits86d fruits86d fruits90d fruits90d fruits94d fruits94d fruits98d fruits98d fruits02d fruits02d fruits06d fruits06d fruits10d fruits10d fruits10d fruits10d fruits10d;
array vegeal  {18}  vegeal84d vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d vegeal94d vegeal98d vegeal98d vegeal02d vegeal02d vegeal06d vegeal06d vegeal10d vegeal10d vegeal10d vegeal10d vegeal10d;
array nstveg  {18}  nstveg84d nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d nstveg94d nstveg98d nstveg98d nstveg02d nstveg02d nstveg06d nstveg06d nstveg10d nstveg10d nstveg10d nstveg10d nstveg10d;
array staveg  {18}  staveg84d staveg86d staveg86d staveg90d staveg90d staveg94d staveg94d staveg98d staveg98d staveg02d staveg02d staveg06d staveg06d staveg10d staveg10d staveg10d staveg10d staveg10d;
array tdairy  {18}  tdairy84d tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d tdairy94d tdairy98d tdairy98d tdairy02d tdairy02d tdairy06d tdairy06d tdairy10d tdairy10d tdairy10d tdairy10d tdairy10d;
array coffee  {18}  coffee84d coffee86d coffee86d coffee90d coffee90d coffee94d coffee94d coffee98d coffee98d coffee02d coffee02d coffee06d coffee06d coffee10d coffee10d coffee10d coffee10d coffee10d;
array nutleg  {18}  nutleg84d nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d nutleg94d nutleg98d nutleg98d nutleg02d nutleg02d nutleg06d nutleg06d nutleg10d nutleg10d nutleg10d nutleg10d nutleg10d;
array bwrice  {18}  bwrice84d bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d bwrice94d bwrice98d bwrice98d bwrice02d bwrice02d bwrice06d bwrice06d bwrice10d bwrice10d bwrice10d bwrice10d bwrice10d;
array wtrice  {18}  wtrice84d wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d wtrice94d wtrice98d wtrice98d wtrice02d wtrice02d wtrice06d wtrice06d wtrice10d wtrice10d wtrice10d wtrice10d wtrice10d;
array SSB     {18}  SSB84d SSB86d SSB86d SSB90d SSB90d SSB94d SSB94d SSB98d SSB98d SSB02d SSB02d SSB06d SSB06d SSB10d SSB10d SSB10d SSB10d SSB10d;
array whgrns  {18}  whgrns84d whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d whgrns94d whgrns98d whgrns98d whgrns02d whgrns02d whgrns06d whgrns06d whgrns10d whgrns10d whgrns10d whgrns10d whgrns10d;
array rfgrns  {18}  rfgrns84d rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d rfgrns94d rfgrns98d rfgrns98d rfgrns02d rfgrns02d rfgrns06d rfgrns06d rfgrns10d rfgrns10d rfgrns10d rfgrns10d rfgrns10d;
array whgrn  {18}  whgrn84n whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n whgrn94n whgrn98n whgrn98n whgrn02n whgrn02n whgrn06n whgrn06n whgrn10n whgrn10n whgrn10n whgrn10n whgrn10n;
array rfgrn  {18}  rfgrn84n rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n rfgrn94n rfgrn98n rfgrn98n rfgrn02n rfgrn02n rfgrn06n rfgrn06n rfgrn10n rfgrn10n rfgrn10n rfgrn10n rfgrn10n;
array gl     {18}     gl84n gl86n gl86n gl90n gl90n gl94n gl94n gl98n gl98n gl02n gl02n gl06n gl06n gl10n gl10n gl10n gl10n gl10n;
array gid    {18}  gid84n gid86n gid86n gid90n gid90n gid94n gid94n gid98n gid98n gid02n gid02n gid06n gid06n gid10n gid10n gid10n gid10n gid10n;

array tpotatca  {18}  tpotat84ca tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca tpotat94ca tpotat98ca tpotat98ca tpotat02ca tpotat02ca tpotat06ca tpotat06ca tpotat10ca tpotat10ca tpotat10ca tpotat10ca tpotat10ca;
array bbmpotca  {18}  bbmpot84ca bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca bbmpot94ca bbmpot98ca bbmpot98ca bbmpot02ca bbmpot02ca bbmpot06ca bbmpot06ca bbmpot10ca bbmpot10ca bbmpot10ca bbmpot10ca bbmpot10ca ;
array fpotatca  {18}  fpotat84ca fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca fpotat94ca fpotat98ca fpotat98ca fpotat02ca fpotat02ca fpotat06ca fpotat06ca fpotat10ca fpotat10ca fpotat10ca fpotat10ca fpotat10ca;
array chipssca  {18}  chipss84ca chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca chipss94ca chipss98ca chipss98ca chipss02ca chipss02ca chipss06ca chipss06ca chipss10ca chipss10ca chipss10ca chipss10ca chipss10ca;
array prmeatca  {18}  prmeat84ca prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca prmeat94ca prmeat98ca prmeat98ca prmeat02ca prmeat02ca prmeat06ca prmeat06ca prmeat10ca prmeat10ca prmeat10ca prmeat10ca prmeat10ca;
array urmeatca  {18}  urmeat84ca urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca urmeat94ca urmeat98ca urmeat98ca urmeat02ca urmeat02ca urmeat06ca urmeat06ca urmeat10ca urmeat10ca urmeat10ca urmeat10ca urmeat10ca;
array trmeatca  {18}  trmeat84ca trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca trmeat94ca trmeat98ca trmeat98ca trmeat02ca trmeat02ca trmeat06ca trmeat06ca trmeat10ca trmeat10ca trmeat10ca trmeat10ca trmeat10ca;
array poultrca  {18}  poultr84ca poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca poultr94ca poultr98ca poultr98ca poultr02ca poultr02ca poultr06ca poultr06ca poultr10ca poultr10ca poultr10ca poultr10ca poultr10ca;
array fishalca  {18}  fishal84ca fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca fishal94ca fishal98ca fishal98ca fishal02ca fishal02ca fishal06ca fishal06ca fishal10ca fishal10ca fishal10ca fishal10ca fishal10ca;
array regeggca  {18}  regegg84ca regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca regegg94ca regegg98ca regegg98ca regegg02ca regegg02ca regegg06ca regegg06ca regegg10ca regegg10ca regegg10ca regegg10ca regegg10ca;
array hdairyca  {18}  hdairy84ca hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca hdairy94ca hdairy98ca hdairy98ca hdairy02ca hdairy02ca hdairy06ca hdairy06ca hdairy10ca hdairy10ca hdairy10ca hdairy10ca hdairy10ca;
array ldairyca  {18}  ldairy84ca ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca ldairy94ca ldairy98ca ldairy98ca ldairy02ca ldairy02ca ldairy06ca ldairy06ca ldairy10ca ldairy10ca ldairy10ca ldairy10ca ldairy10ca;
/*array soyproca  {18} soypro84ca soypro86ca soypro86ca soypro90ca soypro90ca soypro94ca soypro94ca soypro98ca soypro98ca soypro02ca soypro02ca soypro06ca soypro06ca soypro10ca soypro10ca soypro10ca soypro10ca soypro10ca;*/
array nutsalca  {18}  nutsal84ca nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca nutsal94ca nutsal98ca nutsal98ca nutsal02ca nutsal02ca nutsal06ca nutsal06ca nutsal10ca nutsal10ca nutsal10ca nutsal10ca nutsal10ca;
array legumeca  {18}  legume84ca legume86ca legume86ca legume90ca legume90ca legume94ca legume94ca legume98ca legume98ca legume02ca legume02ca legume06ca legume06ca legume10ca legume10ca legume10ca legume10ca legume10ca;
array fruitsca  {18}  fruits84ca fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca fruits94ca fruits98ca fruits98ca fruits02ca fruits02ca fruits06ca fruits06ca fruits10ca fruits10ca fruits10ca fruits10ca fruits10ca;
array vegealca  {18}  vegeal84ca vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca vegeal94ca vegeal98ca vegeal98ca vegeal02ca vegeal02ca vegeal06ca vegeal06ca vegeal10ca vegeal10ca vegeal10ca vegeal10ca vegeal10ca;
array nstvegca  {18}  nstveg84ca nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca nstveg94ca nstveg98ca nstveg98ca nstveg02ca nstveg02ca nstveg06ca nstveg06ca nstveg10ca nstveg10ca nstveg10ca nstveg10ca nstveg10ca;
array stavegca  {18}  staveg84ca staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca staveg94ca staveg98ca staveg98ca staveg02ca staveg02ca staveg06ca staveg06ca staveg10ca staveg10ca staveg10ca staveg10ca staveg10ca;
array tdairyca  {18}  tdairy84ca tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca tdairy94ca tdairy98ca tdairy98ca tdairy02ca tdairy02ca tdairy06ca tdairy06ca tdairy10ca tdairy10ca tdairy10ca tdairy10ca tdairy10ca; 
array coffeeca  {18}  coffee84ca coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca coffee94ca coffee98ca coffee98ca coffee02ca coffee02ca coffee06ca coffee06ca coffee10ca coffee10ca coffee10ca coffee10ca coffee10ca;
array nutlegca  {18}  nutleg84ca nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca nutleg94ca nutleg98ca nutleg98ca nutleg02ca nutleg02ca nutleg06ca nutleg06ca nutleg10ca nutleg10ca nutleg10ca nutleg10ca nutleg10ca;
array bwriceca  {18}  bwrice84ca bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca bwrice94ca bwrice98ca bwrice98ca bwrice02ca bwrice02ca bwrice06ca bwrice06ca bwrice10ca bwrice10ca bwrice10ca bwrice10ca bwrice10ca;
array wtriceca  {18}  wtrice84ca wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca wtrice94ca wtrice98ca wtrice98ca wtrice02ca wtrice02ca wtrice06ca wtrice06ca wtrice10ca wtrice10ca wtrice10ca wtrice10ca wtrice10ca;
array SSBca     {18}  SSB84ca SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca SSB94ca SSB98ca SSB98ca SSB02ca SSB02ca SSB06ca SSB06ca SSB10ca SSB10ca SSB10ca SSB10ca SSB10ca;
array whgrnsca  {18}  whgrns84ca whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca whgrns94ca whgrns98ca whgrns98ca whgrns02ca whgrns02ca whgrns06ca whgrns06ca whgrns10ca whgrns10ca whgrns10ca whgrns10ca whgrns10ca;
array rfgrnsca  {18}  rfgrns84ca rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca rfgrns94ca rfgrns98ca rfgrns98ca rfgrns02ca rfgrns02ca rfgrns06ca rfgrns06ca rfgrns10ca rfgrns10ca rfgrns10ca rfgrns10ca rfgrns10ca;
array whgrnca  {18}   whgrn84ca whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca whgrn94ca whgrn98ca whgrn98ca whgrn02ca whgrn02ca whgrn06ca whgrn06ca whgrn10ca whgrn10ca whgrn10ca whgrn10ca whgrn10ca;
array rfgrnca  {18}   rfgrn84ca rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca rfgrn94ca rfgrn98ca rfgrn98ca rfgrn02ca rfgrn02ca rfgrn06ca rfgrn06ca rfgrn10ca rfgrn10ca rfgrn10ca rfgrn10ca rfgrn10ca;
array glca  {18}  gl84ca gl86ca gl86ca gl90ca gl90ca gl94ca gl94ca gl98ca gl98ca gl02ca gl02ca gl06ca gl06ca gl10ca gl10ca gl10ca gl10ca gl10ca;

array ahei  {18}  ahei84 ahei86 ahei86 ahei90 ahei90 ahei94 ahei94 ahei98 ahei98 ahei02 ahei02 ahei06 ahei06 ahei10 ahei10 ahei10 ahei10 ahei10;
array aheinoal  {18}  aheinoal84 aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 aheinoal94 aheinoal98 aheinoal98 aheinoal02 aheinoal02 aheinoal06 aheinoal06 aheinoal10 aheinoal10 aheinoal10 aheinoal10 aheinoal10;
array aheinopt  {18}  aheinopt84 aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 aheinopt94 aheinopt98 aheinopt98 aheinopt02 aheinopt02 aheinopt06 aheinopt06 aheinopt10 aheinopt10 aheinopt10 aheinopt10 aheinopt10;
array aheifisha  {18}  aheifisha84 aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 aheifisha94 aheifisha98 aheifisha98 aheifisha02 aheifisha02 aheifisha06 aheifisha06 aheifisha10 aheifisha10 aheifisha10 aheifisha10 aheifisha10;
array aheidairy  {18}  aheidairy84 aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 aheidairy94 aheidairy98 aheidairy98 aheidairy02 aheidairy02 aheidairy06 aheidairy06 aheidairy10 aheidairy10 aheidairy10 aheidairy10 aheidairy10;
array aheinutbl  {18}  aheinutbl84 aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 aheinutbl94 aheinutbl98 aheinutbl98 aheinutbl02 aheinutbl02 aheinutbl06 aheinutbl06 aheinutbl10 aheinutbl10 aheinutbl10 aheinutbl10 aheinutbl10;
array aheipoult  {18}  aheipoult84 aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 aheipoult94 aheipoult98 aheipoult98 aheipoult02 aheipoult02 aheipoult06 aheipoult06 aheipoult10 aheipoult10 aheipoult10 aheipoult10 aheipoult10;
array aheineggs  {18}  aheineggs84 aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 aheineggs94 aheineggs98 aheineggs98 aheineggs02 aheineggs02 aheineggs06 aheineggs06 aheineggs10 aheineggs10 aheineggs10 aheineggs10 aheineggs10;

array aheica  {18}  ahei84ca ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca ahei94ca ahei98ca ahei98ca ahei02ca ahei02ca ahei06ca ahei06ca ahei10ca ahei10ca ahei10ca ahei10ca ahei10ca;
array aheinoalca  {18}   aheinoal84ca aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca aheinoal94ca aheinoal98ca aheinoal98ca aheinoal02ca aheinoal02ca aheinoal06ca aheinoal06ca aheinoal10ca aheinoal10ca aheinoal10ca aheinoal10ca aheinoal10ca;
array aheinoptca  {18}   aheinopt84ca aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca aheinopt94ca aheinopt98ca aheinopt98ca aheinopt02ca aheinopt02ca aheinopt06ca aheinopt06ca aheinopt10ca aheinopt10ca aheinopt10ca aheinopt10ca aheinopt10ca;
array aheifishaca  {18}  aheifisha84ca aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca aheifisha94ca aheifisha98ca aheifisha98ca aheifisha02ca aheifisha02ca aheifisha06ca aheifisha06ca aheifisha10ca aheifisha10ca aheifisha10ca aheifisha10ca aheifisha10ca;
array aheidairyca  {18}  aheidairy84ca aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca aheidairy94ca aheidairy98ca aheidairy98ca aheidairy02ca aheidairy02ca aheidairy06ca aheidairy06ca aheidairy10ca aheidairy10ca aheidairy10ca aheidairy10ca aheidairy10ca;
array aheinutblca  {18}  aheinutbl84ca aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca aheinutbl94ca aheinutbl98ca aheinutbl98ca aheinutbl02ca aheinutbl02ca aheinutbl06ca aheinutbl06ca aheinutbl10ca aheinutbl10ca aheinutbl10ca aheinutbl10ca aheinutbl10ca;
array aheipoultca  {18}  aheipoult84ca aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca aheipoult94ca aheipoult98ca aheipoult98ca aheipoult02ca aheipoult02ca aheipoult06ca aheipoult06ca aheipoult10ca aheipoult10ca aheipoult10ca aheipoult10ca aheipoult10ca;
array aheineggsca  {18}  aheineggs84ca aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca aheineggs94ca aheineggs98ca aheineggs98ca aheineggs02ca aheineggs02ca aheineggs06ca aheineggs06ca aheineggs10ca aheineggs10ca aheineggs10ca aheineggs10ca aheineggs10ca;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {18} alone92 alone92 alone92 alone92 alone92 alone92 alone96 alone96 alone00 alone00 alone04
                 alone04 alone08 alone08 alone12 alone12 alone16 alone16;
array married {18} marry92 marry92 marry92 marry92 marry92 marry92 marry96 marry96 marry00 marry00 marry04
                 marry04 marry08 marry08 marry12 marry12 marry16 marry16;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {18} mdinc90_86 mdinc90_86 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94 mdinc00_96 mdinc00_98 mdinc00_00
        mdinc00_02 mdinc00_04 mdinc10_06 mdinc10_08 mdinc10_10 mdinc10_12 mdinc10_14 mdinc10_16 mdinc10_16; 
   array vhs {18} mdvhs90_86 mdvhs90_86 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94 mdvhs00_96 mdvhs00_98 mdvhs00_00
        mdvhs00_02 mdvhs00_04 mdvhs10_06 mdvhs10_08 mdvhs10_10 mdvhs10_12 mdvhs10_14 mdvhs10_16 mdvhs10_16; 
   array pcoll {18} pcolled80_86 pcolled90_86 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94 pcolled00_96
          pcolled00_98 pcolled00_00 pcolled00_02 pcolled00_04 pcolled10_06 pcolled10_08
          pcolled10_10 pcolled10_12 pcolled10_14 pcolled10_16 pcolled10_16;
   array phs {18} phs80_86 phs90_86 phs90_88 phs90_90 phs90_92 phs90_94 phs00_96 phs00_98 phs00_00 phs00_02 phs00_04
        phs10_06 phs10_08 phs10_10 phs10_12 phs10_14 phs10_16 phs10_16;
   array pnohs {18} pnohs80_86 pnohs90_86 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94 pnohs00_96 pnohs00_98 pnohs00_00 pnohs00_02 pnohs00_04
        pnohs10_06 pnohs10_08 pnohs10_10 pnohs10_12 pnohs10_14 pnohs10_16 pnohs10_16;
   array pfint {18} pfaminterest80_86 pfaminterest90_86 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94
          pfaminterest00_96 pfaminterest00_98 pfaminterest00_00 pfaminterest00_02 pfaminterest00_04
          pfaminterest10_06 pfaminterest10_08 pfaminterest10_10 pfaminterest10_12 pfaminterest10_14 pfaminterest10_16 pfaminterest10_16;
   array sfemale {18} pfwchbf80_86 pfwchbf90_86 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94 pfwchbf00_96 pfwchbf00_98
            pfwchbf00_00 pfwchbf00_02 pfwchbf00_04 pfwchbf10_06 pfwchbf10_08 pfwchbf10_10 pfwchbf10_12 pfwchbf10_14 pfwchbf10_16 pfwchbf10_16;
   array pkid {18} pkid80_86 pkid90_86 pkid90_88 pkid90_90 pkid90_92 pkid90_94 pkid00_96 pkid00_98 pkid00_00 pkid00_02 pkid00_04
         pkid10_06 pkid10_08 pkid10_10 pkid10_12 pkid10_14 pkid10_16 pkid10_16;
   array pold {18} pold80_86 pold90_86 pold90_88 pold90_90 pold90_92 pold90_94 pold00_96 pold00_98 pold00_00 pold00_02 pold00_04
         pold10_06 pold10_08 pold10_10 pold10_12 pold10_14 pold10_16 pold10_16;
   array pohse {18} pohse80_86 pohse90_86 pohse90_88 pohse90_90 pohse90_92 pohse90_94 pohse00_96 pohse00_98 pohse00_00 pohse00_02
          pohse00_04 pohse10_06 pohse10_08 pohse10_10 pohse10_12 pohse10_14 pohse10_16 pohse10_16;
   array ppov {18} ppov80_86 ppov90_86 ppov90_88 ppov90_90 ppov90_92 ppov90_94 ppov00_96 ppov00_98 ppov00_00 ppov00_02
         ppov00_04 ppov10_06 ppov10_08 ppov10_10 ppov10_12 ppov10_14 ppov10_16 ppov10_16;
   array pw {18}   pwht80_86 pwht90_86 pwht90_88 pwht90_90 pwht90_92 pwht90_94 pwht00_96 pwht00_98 pwht00_00 pwht00_02
         pwht00_04 pwht10_06 pwht10_08 pwht10_10 pwht10_12 pwht10_14 pwht10_16 pwht10_16;

   array popd {18}  popd80_86 popd90_86 popd90_88 popd90_90 popd90_92 popd90_94 popd00_96 popd00_98 popd00_00 popd00_02
              popd00_04 popd10_06 popd10_08 popd10_10 popd10_12 popd10_14 popd10_16 popd10_16; 
   array div {18} division10_86 division10_86 division10_88 division10_90 division10_92 division10_94 division10_96
        division10_98 division10_00 division10_02 division10_04 division10_06 division10_08
        division10_10 division10_12 division10_14 division10_16 division10_16;
   array reg {18} region10_86 region10_86 region10_88 region10_90 region10_92 region10_94 region10_96 region10_98
        region10_00 region10_02 region10_04 region10_06 region10_08 region10_10 region10_12
        region10_14 region10_16 region10_16;


/*array  alco  {15}  alco86n  alco86n  alco90n  alco90n  alco94n  alco94n  alco98n  alco98n  alco02n  alco02n  alco06n  alco06n alco10n alco10n alco14n;
array alcc  {15}  alcc86   alcc88   alcc90   alcc92   alcc94   alcc96   alcc98   alcc00   alcc02   alcc04   alcc06   alcc08   alcc10   alcc10   alcc14;
array pam   {15}  th86c th88c th90c th92c th94c th96c th98c th00c th02c th04c th06c th08c th10c th12c th14c;
array aheim {15}  ahei86   ahei86   ahei90   ahei90   ahei94   ahei94   ahei98   ahei98   ahei02   ahei02   ahei06   ahei06 ahei10 ahei10 ahei10;
array antitc   {15}  hchtx86  hchtx88  hchtx90  hchtx92  hchtx94  hchtx96  hchtx98  hchtx00  hchtx02  hchtx04  hchtx06  hchtx08  hchtx10  hchtx12  hchtx14;
array wt {15}  wt86  wt88  wt90  wt92  wt94  wt96  wt98  wt00  wt02  wt04  wt06  wt08  wt10  wt12  wt14;
array   renf   {15}  renf86  renf88  renf90  renf92  renf92  renf96  renf98  renf00   renal02   renal04   renal06 renf08   renal10   renal12   renal14; 
array   orhy   {15}  orhy86  orhy88  orhy90  orhy92  orhy94  orhy96  orhy98  orhy00   orhy02   orhy04   orhy04 ; 
array   repcabg   {15}  cabg86  cabg88  cabg90  cabg92  cabg94  cabg96  cabg98  cabg00   cabg02   cabg04   cabg06    cabg08 cabg10 cabg12 cabg14; 
array   ang   {15}  ang86  ang88  ang90  ang92  ang94  ang96  ang98  ang00   ang02   ang04   ang06 ang08 ang10 ang12 ang14; 
array antihp   {15}  htnrx86  htnrx88  htnrx90  htnrx92  htnrx94  htnrx96  htnrx98  htnrx00  htnrx02  htnrx04  htnrx06  htnrx08  htnrx10  htnrx12  htnrx14;*/

/*Statin & chol*/
/*array   chollv {15}    serum88 serum88 serum90 serum90 serum94 serum94 serum94 serum94 serum04 serum04 serum04 serum08 serum08 serum08 serum08;
                                       
array calorqt  {15}  calor86nv   calor86nv   calor90nv   calor90nv   calor94nv   calor94nv   calor98nv   calor98nv   calor02nv   calor02nv   calor06nv   calor06nv  calor10nv  calor10nv  calor10nv;
array naheica  {15}  nAHEI86ca   nAHEI86ca   nAHEI90ca   nAHEI90ca   nAHEI94ca   nAHEI94ca   nAHEI98ca   nAHEI98ca   nAHEI02ca   nAHEI02ca   nAHEI06ca   nAHEI06ca  nAHEI10ca  nAHEI10ca  nAHEI10ca;
array naheinoalca {15}  nAHEI86_noalca nAHEI86_noalca nAHEI90_noalca nAHEI90_noalca nAHEI94_noalca nAHEI94_noalca nAHEI98_noalca nAHEI98_noalca nAHEI02_noalca nAHEI02_noalca nAHEI06_noalca nAHEI06_noalca nAHEI10_noalca nAHEI10_noalca nAHEI10_noalca;
array npdqsca  {15}  test386ca   test386ca   test390ca   test390ca   test394ca   test394ca   test398ca   test398ca   test302ca   test302ca   test306ca   test306ca  test310ca  test310ca  test310ca;

array tveggca  {15}  tveg86ca tveg86ca tveg90ca tveg90ca tveg94ca tveg94ca tveg98ca tveg98ca tveg02ca tveg02ca tveg06ca tveg06ca tveg10ca tveg10ca tveg10ca;
array fruitca  {15}  fruit86ca fruit86ca fruit90ca fruit90ca fruit94ca fruit94ca fruit98ca fruit98ca fruit02ca fruit02ca fruit06ca fruit06ca fruit10ca fruit10ca fruit10ca;
array whgrnca  {15}  whgrn86aca whgrn86aca whgrn90aca whgrn90aca whgrn94aca whgrn94aca whgrn98aca whgrn98aca whgrn02aca whgrn02aca whgrn06aca whgrn06aca whgrn10aca whgrn10aca whgrn10aca;
array ssbbbca  {15}  ssb86ca ssb86ca ssb90ca ssb90ca ssb94ca ssb94ca ssb98ca ssb98ca ssb02ca ssb02ca ssb06ca ssb06ca ssb10ca ssb10ca ssb10ca;
array nutttca  {15}  nut86ca nut86ca nut90ca nut90ca nut94ca nut94ca nut98ca nut98ca nut02ca nut02ca nut06ca nut06ca nut10ca nut10ca nut10ca;
array rmeatca  {15}  rmea86tca rmea86tca rmea90tca rmea90tca rmea94tca rmea94tca rmea98tca rmea98tca rmea02tca rmea02tca rmea06tca rmea06tca rmea10tca rmea10tca rmea10tca;
array transca  {15}  ptran86ca ptran86ca ptran90ca ptran90ca ptran94ca ptran94ca ptran98ca ptran98ca ptran02ca ptran02ca ptran06ca ptran06ca ptran10ca ptran10ca ptran10ca;
array omegaca  {15}  mgomg86ca mgomg86ca mgomg90ca mgomg90ca mgomg94ca mgomg94ca mgomg98ca mgomg98ca mgomg02ca mgomg02ca mgomg06ca mgomg06ca mgomg10ca mgomg10ca mgomg10ca;
array ppolyca  {15}  ppoly86ca ppoly86ca ppoly90ca ppoly90ca ppoly94ca ppoly94ca ppoly98ca ppoly98ca ppoly02ca ppoly02ca ppoly06ca ppoly06ca ppoly10ca ppoly10ca ppoly10ca;
array   naaaaca {15}    na86nca na86nca na90nca na90nca na94nca na94nca na98nca na98nca na02nca na02nca na06nca na06nca na10nca na10nca na10nca;
array   drinkca {15}    drinks86ca drinks86ca drinks90ca drinks90ca drinks94ca drinks94ca drinks98ca drinks98ca drinks02ca drinks02ca drinks06ca drinks06ca drinks10ca drinks10ca drinks10ca;
array   alconca {15}    alco86nca alco86nca alco90nca alco90nca alco94nca alco94nca alco98nca alco98nca alco02nca alco02nca alco06nca alco06nca alco10nca alco10nca alco10nca;

array   cruveca {15}    cru86ca cru86ca cru90ca cru90ca cru94ca cru94ca cru98ca cru98ca cru02ca cru02ca cru06ca cru06ca cru10ca cru10ca cru10ca;
array   lfvegca {15}    lfveg86ca lfveg86ca lfveg90ca lfveg90ca lfveg94ca lfveg94ca lfveg98ca lfveg98ca lfveg02ca lfveg02ca lfveg06ca lfveg06ca lfveg10ca lfveg10ca lfveg10ca;*/

   do i=1 to 18;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 18;
       /*if actc{b}=. then actc{b}=actc{b-1};*/
      if actm{b}=. then actm{b}=actm{b-1};
      if pam{b}=. then pam{b}=pam{b-1};      
       if bmi{b}=. then bmi{b}=bmi{b-1};
       if alco{b}=. then alco{b}=alco{b-1};
       if alcoca{b}=. then alcoca{b}=alcoca{b-1};
       if nsmk{b}=. then nsmk{b}=nsmk{b-1};
       if aspyn{b}=. then aspyn{b}=aspyn{b-1};
       if horm{b}=. then horm{b}=horm{b-1};
       if mvit{b}=. then mvit{b}=mvit{b-1};
       if calor{b}=. then calor{b}=calor{b-1};
       if calorca{b}=. then calorca{b}=calorca{b-1};
       if cerafca{b}=. then cerafca{b}=cerafca{b-1};
       if satfca{b}=. then satfca{b}=satfca{b-1};
       if monfca{b}=. then monfca{b}=monfca{b-1};
       if polyfca{b}=. then polyfca{b}=polyfca{b-1};
       if transfca{b}=. then transfca{b}=transfca{b-1};
       if folca{b}=. then folca{b}=folca{b-1};
       if prot{b}=. then prot{b}=prot{b-1};
       if protden{b}=. then protden{b}=protden{b-1};
       if protca{b}=. then protca{b}=protca{b-1};
       if protdenca{b}=. then protdenca{b}=protdenca{b-1};
       if gidca{b}=. then gidca{b}=gidca{b-1};
       if ceraf{b}=. then ceraf{b}=ceraf{b-1};
       if aofib{b}=. then aofib{b}=aofib{b-1};
       if supp{b}=. then supp{b}=supp{b-1};
       if carbo{b}=. then carbo{b}=carbo{b-1};
       if carbden{b}=. then carbden{b}=carbden{b-1};
       if carboca{b}=. then carboca{b}=carboca{b-1};
       if carbdenca{b}=. then carbdenca{b}=carbdenca{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
       if tpotat{b}=. then tpotat{b}=tpotat{b-1};
       if bbmpot{b}=. then bbmpot{b}=bbmpot{b-1};
       if fpotat{b}=. then fpotat{b}=fpotat{b-1};
       if chipss{b}=. then chipss{b}=chipss{b-1};
       if prmeat{b}=. then prmeat{b}=prmeat{b-1};
       if urmeat{b}=. then urmeat{b}=urmeat{b-1};
       if trmeat{b}=. then trmeat{b}=trmeat{b-1};
       if poultr{b}=. then poultr{b}=poultr{b-1};
       if fishal{b}=. then fishal{b}=fishal{b-1};
       if regegg{b}=. then regegg{b}=regegg{b-1};
       if hdairy{b}=. then hdairy{b}=hdairy{b-1};
       if ldairy{b}=. then ldairy{b}=ldairy{b-1};
       /*if soypro{b}=. then soypro{b}=soypro{b-1};*/
       if nutsal{b}=. then nutsal{b}=nutsal{b-1};
       if legume{b}=. then legume{b}=legume{b-1};
       if fruits{b}=. then fruits{b}=fruits{b-1};
       if vegeal{b}=. then vegeal{b}=vegeal{b-1};
       if nstveg{b}=. then nstveg{b}=nstveg{b-1};
       if staveg{b}=. then staveg{b}=staveg{b-1};
       if whgrns{b}=. then whgrns{b}=whgrns{b-1};
       if rfgrns{b}=. then rfgrns{b}=rfgrns{b-1};
       if whgrn{b}=. then whgrn{b}=whgrn{b-1};
       if rfgrn{b}=. then rfgrn{b}=rfgrn{b-1};
       if gl{b}=. then gl{b}=gl{b-1};
       if gid{b}=. then gid{b}=gid{b-1};
       if aheifisha{b}=. then aheifisha{b}=aheifisha{b-1};
       if aheidairy{b}=. then aheidairy{b}=aheidairy{b-1};
       if aheinutbl{b}=. then aheinutbl{b}=aheinutbl{b-1};
       if aheipoult{b}=. then aheipoult{b}=aheipoult{b-1};
       if aheineggs{b}=. then aheineggs{b}=aheineggs{b-1};
       if tdairy{b}=. then tdairy{b}=tdairy{b-1};
       if coffee{b}=. then coffee{b}=coffee{b-1};
       if nutleg{b}=. then nutleg{b}=nutleg{b-1};
       if bwrice{b}=. then bwrice{b}=bwrice{b-1};
       if wtrice{b}=. then wtrice{b}=wtrice{b-1};
       if SSB{b}=. then SSB{b}=SSB{b-1};
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};

       if calorca{b}=. then calorca{b}=calorca{b-1};
       if tpotatca{b}=. then tpotatca{b}=tpotatca{b-1};
       if bbmpotca{b}=. then bbmpotca{b}=bbmpotca{b-1};
       if fpotatca{b}=. then fpotatca{b}=fpotatca{b-1};
       if chipssca{b}=. then chipssca{b}=chipssca{b-1};
       if trmeatca{b}=. then trmeatca{b}=trmeatca{b-1};
       if prmeatca{b}=. then prmeatca{b}=prmeatca{b-1};
       if urmeatca{b}=. then urmeatca{b}=urmeatca{b-1};
       if gidca{b}=. then gidca{b}=gidca{b-1};
       if poultrca{b}=. then poultrca{b}=poultrca{b-1};
       if fishalca{b}=. then fishalca{b}=fishalca{b-1};
       if regeggca{b}=. then regeggca{b}=regeggca{b-1};
       if tdairyca{b}=. then tdairyca{b}=tdairyca{b-1};
       if coffeeca{b}=. then coffeeca{b}=coffeeca{b-1};
       if nutsalca{b}=. then nutsalca{b}=nutsalca{b-1};
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};
       if aheinoptca{b}=. then aheinoptca{b}=aheinoptca{b-1};

       if alone{b}=. then alone{b}=alone{b-1};
       if married{b}=. then married{b}=married{b-1};
       if inc{b}=. then inc{b}=inc{b-1};
       if vhs{b}=. then vhs{b}=vhs{b-1};
       if pcoll{b}=. then pcoll{b}=pcoll{b-1};
       if phs{b}=. then phs{b}=phs{b-1};
       if pnohs{b}=. then pnohs{b}=pnohs{b-1};
       if pfint{b}=. then pfint{b}=pfint{b-1};
       if sfemale{b}=. then sfemale{b}=sfemale{b-1};
       if pkid{b}=. then pkid{b}=pkid{b-1};
       if pold{b}=. then pold{b}=pold{b-1};
       if pohse{b}=. then pohse{b}=pohse{b-1};
       if ppov{b}=. then ppov{b}=ppov{b-1};
       if pw{b}=. then pw{b}=pw{b-1};
       if popd{b}=. then popd{b}=popd{b-1};
       if div{b}=. then div{b}=div{b-1};
       if reg{b}=. then reg{b}=reg{b-1};

    end;


do i=1 to DIM(irt)-1;
  if irt{i} >0 then lastq=irt{i};
  end;
  drop i;
  if lastq=irt{dim(irt)-1} then lastq=.;


/*** Set cutoff at 2020.5 ***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1446;    /* nmw - cutoff 2016.5 */
   do i=1 to DIM(irt)-1;
      if (irt{i}<(990+24*i) | irt{i}>=(1014+24*i)) then irt{i}=990+24*i;
   end;  

%beginex();

   *****************Do-Loop over time periods*****************************;
   
   do i=1 to DIM(irt)-1;     
    period=i;
    do j=1 to DIM(tvar);
    tvar{j}=0;
    perioda{j}=0;
    end;
   
   tvar{i}=1;
   perioda{i}=1;      

/*** outcomes ***/
 /*Define mortality case variables and time to follow for MPHREG model*/
dead=0;    
tdead=irt{i+1}-irt{i};   
if irt{i}<dtdth<=irt{i+1} then do; 
dead=1;tdead=dtdth-irt{i}; 
end;

diabcase=0; 
tdiabcase=irt{i+1}-irt{i};
if diabcase eq 1 then tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
if irt{i} lt dtdxdiab le irt{i+1} then do;
diabcase=1;tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
end;

ageyr = round((irt{i}-bdt)/12);


        /****** DEFINE AGE ******/   
         age{i}=int((irt{i}-bdt)/12);      
            if age{i} =< 0 then age{i}=.;

            agecon=age{i};
            agegp=int((age{i}-30)/5);     **** Define the agegp in the i-th period;
            if agegp<=0 then agegp=1;
            if agegp>8 then agegp=8;
           %indic3(vbl=agegp, prefix=agegp, reflev=1, min=1, max=8, usemiss=0,
                     label1='age<40',
                     label2='age40-44',
                     label3='age45-49',
                     label4='age50-54',
                     label5='age55-59',
                     label6='age60-64',
                     label7='age65-69',
                     label8='age >= 70');


/******main exposure******/ 
if chol84 ne 2 then chol84=0;
if hbp84 ne 2 then hbp84=0;
if db84 ne 2 then db84=0;
if cabg84 ne 2 then cabg84=0;
if str84 ne 2  then str84=0;
calorcav =  calorca  {i};
calorv =  calor  {i};
gidcav = gidca  {i};
alcov = alco  {i};
alcocav = alcoca  {i};
satfcav = satfca  {i};
monfcav = monfca  {i};
polyfcav = polyfca  {i};
transfcav = transfca  {i};
folcav = folca  {i};
protv = prot  {i};
protdenv = protden  {i};
protcav = protca  {i};
protdencav = protdenca  {i};
cerafcav = cerafca  {i};
cerafv = ceraf  {i};
aofibcav = aofibca  {i};
aofibv = aofib  {i};
carbov = carbo  {i};
carbdenv = carbden  {i};
carbocav = carboca  {i};
carbdencav = carbdenca  {i};

tpotatv = tpotat  {i};
bbmpotv = bbmpot  {i};
fpotatv = fpotat  {i};
chipssv = chipss  {i};
prmeatv = prmeat  {i};
urmeatv = urmeat  {i};
trmeatv = trmeat  {i};
poultrv = poultr  {i};
fishalv = fishal  {i};
regeggv = regegg  {i};
hdairyv = hdairy  {i};
ldairyv = ldairy  {i};
/*soyprov = soypro  {i};*/
nutsalv = nutsal  {i};
legumev = legume  {i};
fruitsv = fruits  {i};
vegealv = vegeal  {i};
nstvegv = nstveg  {i};
stavegv = staveg  {i};
tdairyv = tdairy  {i};
coffeev = coffee  {i};
nutlegv = nutleg  {i};
bwricev = bwrice  {i};
wtricev = wtrice  {i};
SSBv = SSB        {i};
whgrnsv = whgrns  {i};
rfgrnsv = rfgrns  {i};
whgrnv = whgrn  {i};
rfgrnv = rfgrn  {i};
glv = gl  {i};
gidv = gid  {i};

tpotatcav = tpotatca  {i};
bbmpotcav = bbmpotca  {i};
fpotatcav = fpotatca  {i};
chipsscav = chipssca  {i};
prmeatcav = prmeatca  {i};
urmeatcav = urmeatca  {i};
trmeatcav = trmeatca  {i};
poultrcav = poultrca  {i};
fishalcav = fishalca  {i};
regeggcav = regeggca  {i};
hdairycav = hdairyca  {i};
ldairycav = ldairyca  {i};
/*soyprocav = soyproca  {i};*/
nutsalcav = nutsalca  {i};
legumecav = legumeca  {i};
fruitscav = fruitsca  {i};
vegealcav = vegealca  {i};
nstvegcav = nstvegca  {i};
stavegcav = stavegca  {i};
tdairycav = tdairyca  {i};
coffeecav = coffeeca  {i};
nutlegcav = nutlegca  {i};
bwricecav = bwriceca  {i};
wtricecav = wtriceca  {i};
SSBcav = SSBca        {i};
whgrnscav = whgrnsca  {i};
rfgrnscav = rfgrnsca  {i};
whgrncav = whgrnca  {i};
rfgrncav = rfgrnca  {i};
glcav = glca  {i};

aheiv = ahei  {i};
aheinoalv = aheinoal  {i};
aheinoptv = aheinopt  {i};
aheifishav = aheifisha  {i};
aheidairyv = aheidairy  {i};
aheinutblv = aheinutbl  {i};
aheipoultv = aheipoult  {i};
aheineggsv = aheineggs  {i};

aheicav = aheica  {i};
aheinoalcav = aheinoalca  {i};
aheinoptcav = aheinoptca  {i};
aheifishacav = aheifishaca  {i};
aheidairycav = aheidairyca  {i};
aheinutblcav = aheinutblca  {i};
aheipoultcav = aheipoultca  {i};
aheineggscav = aheineggsca  {i};

lgcerafcav = log(cerafcav+0.0001);
lgcalorcav = log(calorcav);
lgaofibcav = log(aofibcav+0.0001);

tpotatwv = tpotatv*7/3; 
bbmpotwv = bbmpotv*7/3; 
fpotatowv = fpotatv*7/3;
chipsswv = chipssv*7/3;
whgrnswv = whgrnsv*7/3;
rfgrnswv = rfgrnsv*7/3;
nstvegwv = nstvegv*7/3;  
stavegwv = stavegv*7/3;  
legumewv = legumev*7/3;

tpotatw = tpotatcav*7/3; 
bbmpotw = bbmpotcav*7/3; 
fpotatow = fpotatcav*7/3;
chipssw = chipsscav*7/3;
whgrnsw = whgrnscav*7/3;
rfgrnsw = rfgrnscav*7/3;
nstvegw = nstvegcav*7/3;  
stavegw = stavegcav*7/3;  
legumew = legumecav*7/3; 

/******AGE GROUP******/

agecon=age{i};
      if age{i}<60 then agegp=0;     **** Define the agegp in the i-th period;
            else if age{i}<65 then agegp=1;
            else if age{i}<70 then agegp=2;
            else if age{i}<75 then agegp=3;
            else if age{i}<80 then agegp=4;
            else agegp=5;
            if age{i}=. then agegp=.;

     if agegp>1 then agedi=1;
     else agedi=0;

      %indic3(vbl=agegp, prefix=agegp, min=1, max=5, reflev=0,missing=., usemiss=0,
                   label1='age<60ys',
                   label2='age60-64ys',
                   label3='age65-69ys',
                   label4='age70-74ys',
                   label5='age75-79ys',
                   label6='age>=80ys');

	if agecon<65 then age65=0;
	else if agecon>=65 then age65=1;

           /***smoking status***/
  smkk=nsmk{i};
   if smkk=1 or smkk=0 then smkdi=0;
   else smkdi=1;

   if smkk=1 or smkk=0 then smktr=0;
   else if smkk in (2,3,4,5,6,7,8) then smktr=1;
   else smktr=2;

        if smkk=1 then smkever=1;  *never;
        else if smkk in(2,3,4,5,6,7,8) then smkever=2; *past smoker;
        else if smkk in (9,10,15) then smkever=3; *current, 1-14 cigs ;
        else if smkk=11 then smkever=4; *current, 15-24 cigs ;
        else if smkk in(12,13,14) then smkever=5; *current, 25+ cigs ;
        else smkever=9; *missing;
        %indic3(vbl=smkever, prefix=smkc, min=2, max=5, reflev=1, missing=9, usemiss=1,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');
        if smkever in (3,4,5) then catsmkf=1;
        else catsmkf=0;
    
       /*** Indicator for BMI ***/ 
         bmicon=bmi{i};
        if bmicon = . then bmicon = 24.96000;
         bmia=bmi{i};
         if bmia = . then bmia = 24.96000;        
         if      0<   bmicon <21 then bmic=1;
         else if 21=< bmicon <25 then bmic=2;
         else if 25=< bmicon <30 then bmic=3;
         else if 30=< bmicon <32 then bmic=4;
         else if 32=< bmicon     then bmic=5;
         else if bmicon=. or bmicon=0 then bmic=.;
         %indic3(vbl=bmic, prefix=bmic, reflev=1, min=2, max=5, missing=., usemiss=0,
                    label1='bmi<20.9', 
                    label2='bmi 21-24.9',
                    label3='bmi 25-29.9', 
                    label4='bmi 30.0-31.9', 
                    label5='bmi 32.0+');

         if bmicon < 25 then bmidi = 0;
         else bmidi = 1;

         if bmicon < 25 then bmitr = 0;
         else if bmicon >= 25 and bmicon < 30 then bmitr = 1;
         else bmitr = 2;

         if      0<   bmicon <21 then bmic9=1;
         else if 21=< bmicon <23 then bmic9=2;
         else if 23=< bmicon <25 then bmic9=3;
         else if 25=< bmicon <27 then bmic9=4;
         else if 27=< bmicon <30 then bmic9=5;
         else if 30=< bmicon <33 then bmic9=6;
         else if 33=< bmicon <35 then bmic9=7;
         else if 35=< bmicon <40 then bmic9=8;
         else if 40=< bmicon     then bmic9=9;
         else if bmicon=. or bmicon=0 then bmic9=.;
         %indic3(vbl=bmic9, prefix=bmic9, reflev=1, min=2, max=9, missing=., usemiss=0);


/***category of exercise***/
       actcon=actm{i};
       if actcon = . then actcon = 10.60000;
       actmcon=pam{i};
       if .<actcon<=3      then actcc=1;
       else if 3<actcon<=9       then actcc=2;
       else if 9<actcon<=18      then actcc=3;
       else if 18<actcon<=27     then actcc=4;
       else if 27<actcon<900      then actcc=5;
      else actcc=.;
       %indic3(vbl=actcc, prefix=catact, min=2, max=5, reflev=1, missing=., usemiss=0);

       if actcon<10.6000 then actbi = 0;
      else if actcon>=10.6000 then actbi = 1;
      else actbi = 0;

       /*** alcohol ***/
             alccon=alcoca{i};
         if alccon = . then alccat=3;     
         if alccon = 0 then alccat=1;     
         if alccon > 0 and alccon < 5 then alccat=2;     
         if alccon >= 5 and alccon <10 then alccat=3;    
         if alccon >= 10 and alccon <15 then alccat=4;  
         if alccon >= 15 and alccon <30 then alccat=5;     
         if alccon =>30 then alccat=6; 
             %indic3(vbl=alccat, prefix=alcc, reflev=1, usemiss=0, min=2, max=6,      
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY');

          alcconsu=alco{i};
         if alcconsu = . then alccatsu=3;     
         if alcconsu = 0 then alccatsu=1;     
         if alcconsu > 0 and alcconsu < 5 then alccatsu=2;     
         if alcconsu >= 5 and alcconsu <10 then alccatsu=3;    
         if alcconsu >= 10 and alcconsu <15 then alccatsu=4;  
         if alcconsu >= 15 and alcconsu <30 then alccatsu=5;     
         if alcconsu =>30 then alccatsu=6; 
             %indic3(vbl=alccatsu, prefix=alccsu, reflev=1, usemiss=0, min=2, max=6,      
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY')  ;

 /*** Category of AHEI variables (<median vs. >median) ***/
	
      if aheinoptcav= . then aheinoptcav=39.3024;
      if aheinoptcav<39.3024 then aheinoptd = 0;
      else if aheinoptcav>=39.3024 then aheinoptd = 1;
      else aheinoptd = 0;
	

     /*** aspirin ***/
            select(aspyn{i});
                when (1)     aspirin=1; 
                  otherwise    aspirin=0;
            end;

     /*** Supplement ***/
            select(supp{i});
                when (1)     suppu=1; 
                  otherwise    suppu=0;
            end;

      
      /****** Indicator for History of antihypertensive user */
            select(antihp{i});
                when (1)     antihbp=1;
                  otherwise    antihbp=0;
            end;

      /****** Indicator for History of High Blood Pressure *******/
            select(hbp{i});
                when (1)     htn=1;
                  otherwise    htn=0;
            end;

      /****** Indicator for TC lowering */
            select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
            end;


/****** Indicator for multivitamin ******/
            select(mvit{i});
                when (1)     mlvit=1;
                  otherwise    mlvit=0;
            end;


/*hormone use*/
/*create missing hormone use for everyone who is not never/current/past*/

if horm{i} eq . or horm{i} lt 1 or horm{i} gt 4 then hormone = .;
else hormone = horm {i};
%indic3(vbl=hormone,prefix=hormone,min=2,max=4,reflev=1,missing=.,usemiss=1,
                        label1='premenopausal/missing menopause'
                        label2='no history of postmenopausal hormone use'
                        label3='current postmenopausal hormone use'
                        label4='past postmenopausal hormone use');

      /*** family history of MI***/
         IF mifh NE 1 THEN mifh=0;

      /*** family history of Diab***/
      IF dbfh82 NE 1 THEN dbfh82=0;

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxdiab in (0,.)then dtdxdiab=.;
       if dtdxdiab eq 9999 then dtdxdiab=.;


/*Chol level
      catchol=chollv{i};

      if catchol in (2,3) then catchol2=1;
      else if catchol in (4,5) then catchol2=2;
      else if catchol in (6,7) then catchol2=3;
      else if catchol in (8,9,10,11) then catchol2=4;
      else catchol2=9;

      if catchol2 in (2,3,4,5) then catchol3=0;
      else if catchol2 in (6,7,8,9,10,11) then catchol3=1;
      else catchol3=2;

      %indic3(vbl=catchol2, prefix=cholv, min=2, max=4, reflev=1, missing=9, usemiss=1,
                label1='<160',
                label2='160-200',
                label3='200-240',
                label4='>240');

      %indic3(vbl=catchol3, prefix=cholvdi, min=1, max=2, reflev=0, usemiss=0,
                label1='<200',
                label2='>200',
                label3='Missing');*/

/************************************************
Census tract-level SES
************************************************/
income=inc{i}/1000; *divide by $1000 to make more interpretable;
homeval=vhs{i}/10000; *divide by $10000 to be more interpretable;
pcollege=pcoll{1};
phigh=phs{i};
pnohigh=pnohs{i};
pfamint=pfint{i};
singlefemale=sfemale{i};
pkids=pkid{i};
polds=pold{i};
pocchse=pohse{i};
perpov=ppov{i};
pwhite=pw{i};
   
popden=popd{i}; 
region=reg{i};
division=div{i};

/**********************************************
          Individual SES
***********************************************/   
live_alone=alone{i};
if alone{i} ne 1 then live_alone=0; 
else live_alone=1;

cmarry=married{i};
if cmarry ne 1 then cmarry=0;
else cmarry=1; 

      
     /****************  BASELINE EXCLUSIONS ********************************************/
      if i=1 then do;

   %exclude(exrec eq 1);                 *multiple records and not in master file;
   %exclude(yobf lt 0);
   %exclude(lastq eq irt{1});          /*only returned baseline qq */  

        %exclude(hxcvd   eq 1);       /* baseline history of CVD*/  
        %exclude(hxcan   eq 1);       /*baseline history of cancer*/
        %exclude(hxdb   eq 1);        /*baseline history of diabetes*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le irt84);            /* Death before baseline*/
   %exclude(0 lt dtdxdiab le irt84);         /* Diagnoses diabetes before 1984 */
   %exclude(calor84n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor84n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor84n eq .);                 /* missing energy intake */
   %exclude(tpotat84d eq .);               /* missing potato intake */
   /*%exclude(ngdqscav eq .);
   %exclude(nhgdqscav eq .);
   %exclude(nugdqscav eq .);*/
   %exclude(age84    eq .);           /* missing age at 1984 */ 
   %output(); 
  end;
/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/

  else if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                   /*censor lost to follow up */    
   %exclude(irt{i-1} le dtdth lt irt{i});
   %exclude(irt{i-1} le dtdxdiab lt irt{i});
   %output();
  end;

   end;        /* END OF DO-LOOP OVER TIME PERIODs */
   %endex();   /* must do AFTER all exclusions */

/*** Variables kept for analysis ***/

keep id period agecon agegp agedi smkdi smkk chol84 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
 
     irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16 irt18 cutoff
     t84 t86 t88 t90 t92 t94 t96 t98 t00 t02 t04 t06 t08 t10 t12 t14 t16 t18 dtdth dtdxdiab
     tdead diabcase tdiabcase 
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib84n ceraf84n gid84n alco84n sat84n mon84n poly84n trans84n fol_84n prot84n
     white white2 &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
     actcon bmic alccon
     htn /*diabetes hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db84 chol84 hbp84 str84 hxcvd hxcan antihbp antihtc /*cvd86*/ cabg84
     age84 bmi84 alco84n calor84n /*actc84m*/ mifh cerafcav aofibcav smkever actcc th84 aspyn84 hormone aofibv
     
     /*Stratification variables*/
     age65 bmitr hxhbp dbfh82 smktr catrace2 actbi aheinoptd 

     lgaofibcav lgcerafcav lgcalorcav act86m hxchol hxdb ageyr cerafv bmia bmicon suppu carbov carbdenv carbocav carbdencav /*&catrace_*/ mlvit alcconsu &alccsu_ 
     tpotat84d bbmpot84d fpotat84d chipss84d prmeat84d urmeat84d trmeat84d poultr84d fishal84d hdairy84d ldairy84d /*soypro84d*/ nutsal84d legume84d fruits84d vegeal84d nstveg84d staveg84d tdairy84d nutleg84d bwrice84d wtrice84d SSB84d coffee84d 
     tpotatv bbmpotv fpotatv chipssv prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv nutlegv bwricev wtricev SSBv coffeev 
     tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav nutlegcav coffeecav bwricecav wtricecav SSBcav 
     whgrnsv rfgrnsv whgrnv rfgrnv glv gidv whgrnscav rfgrnscav whgrncav rfgrncav glcav whgrns84d rfgrns84d coffee84d race9204 catsmkf
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav
     mrace9204 eth9204 catrace bmidi 
     income homeval pcollege phigh pnohigh pfamint singlefemale pkids polds pocchse perpov pwhite popden; 
run;

data two;
   set two;
   zperpov=1-perpov; *invert to make increases good;
   zsinglefemale=1-singlefemale; *invert to make increases good;
   zincome=income;
   zhomeval=homeval;
   zpcollege=pcollege;
   zphigh=phigh;
   zpnohigh=pnohigh;
   zpfamint=pfamint;
   zpkids=pkids;
   zpolds=polds;
   zpocchse=pocchse;
   zpwhite=pwhite;
run;

/*create a score from the various nSES variables*/
proc standard data=two mean=0 std=1 out=two;
     var zincome zhomeval zpcollege zpfamint zpocchse zpwhite zperpov zsinglefemale;
run; 

data two;
   set two;
   nSES=zincome+zhomeval+zpcollege+zpfamint+zpocchse+zpwhite+zperpov; 

   if nSES = . then nSES = 0.0422921;
run;

proc freq data=two;tables catrace catrace2 mrace9204 age65 eth9204 actbi bmidi bmitr smktr &bmic9_ aheinoptd ;run;

proc freq data=two;tables hxdb hxhbp diabcase suppu smkc2 smkc3 smkc4 smkc5 white2 hormone2 hormone3 hormone4 catact2 catact3 catact4 catact5 dbfh82 antihbp antihtc alcc2 alcc3 alcc4 alcc5 alcc6 catsmkf;run;
proc univariate data=two; var actcon bmicon calorcav calorv alcov alcocav prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev
                              tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav whgrncav rfgrncav glcav gidcav
                              bwricecav wtricecav SSBcav coffeecav
                              aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav
                              income homeval pcollege phigh pnohigh pfamint singlefemale pkids polds pocchse perpov pwhite popden nSES;run;


%pctl9(
data=two,
varlist=aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav aheiv aheicav aheinoalv aheinoalcav,
numquant=5,
mscore=T,
quantname=q,
outdat=three,
indic=T,
cutdat=cuts,
usemiss=1,
pcut=T,
prnt=F);

%pctl9(
data=three,
varlist=calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv protdencav protdenv aofibv aofibcav cerafv cerafcav prmeatv urmeatv trmeatv poultrv 
      fishalv regeggv hdairyv ldairyv /*soyprov*/ prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav SSBcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav fruitsv
      vegealcav vegealv nstvegcav stavegcav gidcav rfgrnscav rfgrnsv whgrnsv whgrnscav  tdairyv nutlegv tdairycav nutlegcav gidv aheinoptcav nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);

data five;
   set four end=_end_;

     if 0.000<=tpotatcav<=0.070 then ctpotatcav=0;        
      else if 0.070<tpotatcav<=0.143 then ctpotatcav=1;       
      else if 0.143<tpotatcav<=0.430 then ctpotatcav=2;         
      else if 0.430<tpotatcav<=0.790 then ctpotatcav=3;       
      else if 0.790<tpotatcav then ctpotatcav=4;                   
  %indic3(vbl=ctpotatcav, prefix=ctpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if ctpotatcav=0 then medctpotatcav=0.0700000;
   if ctpotatcav=1 then medctpotatcav=0.1400000;
   if ctpotatcav=2 then medctpotatcav=0.2850000;
   if ctpotatcav=3 then medctpotatcav=0.5300000;
   if ctpotatcav=4 then medctpotatcav=0.9066667;


      if fpotatcav=0.000 then cfpotatcav=0;                     /**Almost never**/
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          /**1-3 serving per month**/
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         /**1 serving per week**/
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         /**2-4 serving per week**/
      else if 0.430<fpotatcav then cfpotatcav=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);
 

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0500000;
   if cfpotatcav=2 then medcfpotatcav=0.1140000;
   if cfpotatcav=3 then medcfpotatcav=0.2500000;
   if cfpotatcav=4 then medcfpotatcav=0.6100000;

      if chipsscav =0.000 then cchipsscav=0;                     /**Almost never**/
      else if 0.000<chipsscav <=0.070 then cchipsscav=1;          /**1-3 serving per month**/
      else if 0.070<chipsscav <=0.143 then cchipsscav=2;         /**1 serving per week**/
      else if 0.143<chipsscav <=0.430 then cchipsscav=3;         /**2-4 serving per week**/
      else if 0.430<chipsscav then cchipsscav=4;                 /** =>5 serving per week**/
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0525000;
   if cchipsscav=2 then medcchipsscav=0.1166667;
   if cchipsscav=3 then medcchipsscav=0.2675000;
   if cchipsscav=4 then medcchipsscav=0.6200000;


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                         
  %indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);


   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1400000;
   if cbbmpotcav=2 then medcbbmpotcav=0.3333333;
   if cbbmpotcav=3 then medcbbmpotcav=0.6100000;


     if 0.000<=tpotatv<=0.070 then ctpotatv=0;        
      else if 0.070<tpotatv<=0.143 then ctpotatv=1;       
      else if 0.143<tpotatv<=0.430 then ctpotatv=2;         
      else if 0.430<tpotatv<=0.790 then ctpotatv=3;       
      else if 0.790<tpotatv then ctpotatv=4;                   
  %indic3(vbl=ctpotatv, prefix=ctpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);


      if 0.000<=bbmpotv<=0.070 then cbbmpotv=0;        
      else if 0.070<bbmpotv<=0.143 then cbbmpotv=1;       
      else if 0.143<bbmpotv<=0.430 then cbbmpotv=2;         
      else if 0.430<bbmpotv then cbbmpotv=3;                         
  %indic3(vbl=cbbmpotv, prefix=cbbmpotv, reflev=0, min=1, max=3, missing=., usemiss=0);

      if fpotatv=0.000 then cfpotatv=0;                       /**Almost never**/
      else if 0.000<fpotatv<=0.070 then cfpotatv=1;          /**1-3 serving per month**/
      else if 0.070<fpotatv<=0.143 then cfpotatv=2;          /**1 serving per week**/
      else if 0.143<fpotatv<=0.430 then cfpotatv=3;          /**2-4 serving per week**/
      else if 0.430<fpotatv then cfpotatv=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatv, prefix=cfpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

      if SSBv=0.000 then qSSBv=0;
      else if 0.000<SSBv<=0.070 then qSSBv=1;          
      else if 0.070<SSBv<=0.143 then qSSBv=2;        
      else if 0.143<SSBv<=0.430 then qSSBv=3;         
      else if 0.430<SSBv then qSSBv=4;                 
%indic3(vbl=qSSBv, prefix=qSSBv, reflev=0, min=1, max=4, missing=., usemiss=0);
run;


proc means median data=five;var tpotatcav;class ctpotatcav; run;
proc means median data=five;var fpotatcav;class cfpotatcav; run;
proc means median data=five;var chipsscav;class cchipsscav; run;
proc means median data=five;var bbmpotcav;class cbbmpotcav; run;

/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=ctpotatcav cchipsscav cfpotatcav);

%pm(
 data=outpm,
 case=diabcase,
 exposure=ctpotatcav cchipsscav cfpotatcav,
 ref=0 0 0
);

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18,
         id=id, tvar=period,
         agevar=agecon, qret= irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &ctpotatcav_ &qcalorcav_ , 
         model2  = medctpotatcav &qcalorcav_,
         model3  = &ctpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model4  = medctpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model5  = &ctpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model6  = medctpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = &cchipsscav_ &qcalorcav_ , 
         model8  = medcchipsscav &qcalorcav_,
         model9  = &cchipsscav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model10  = medcchipsscav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model11  = &cchipsscav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model12  = medcchipsscav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model13  = &cfpotatcav_ &qcalorcav_ , 
         model14  = medcfpotatcav &qcalorcav_,
         model15  = &cfpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model16  = medcfpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model17  = &cfpotatcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         model18  = medcfpotatcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
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

ods rtf file="stable8.norec_nhs.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 RR4 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;



/*Per serving*/

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18,
         id=id, tvar=period,
         agevar=agecon, qret= irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = tpotatw &qcalorcav_ , 
         model2  = tpotatw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,  
         model3  = tpotatw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 

         model4  = chipssw &qcalorcav_ , 
         model5  = chipssw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model6  = chipssw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 

         model7  = fpotatow &qcalorcav_ , 
         model8  = fpotatow &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model9  = fpotatow &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         
         model10  = bbmpotw &qcalorcav_ , 
         model11  = bbmpotw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model12  = bbmpotw &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable8.norec_pserv_nhs.rtf";  
proc print data=scr_psd noobs;
   var  va model RR ProbChisq;   
run;

proc print data=all noobs;
   var  variable model beta see ProbChisq;
run;
ods rtf close;


/*baked,boiled, mashed potato person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10  irt12 irt14 irt16 irt18,
 cutoff=cutoff,
 dtdx=dtdxdiab,
 dtdth=dtdth,
 case=diabcase,
 var=cbbmpotcav);

%pm(
 data=outpm,
 case=diabcase,
 exposure=cbbmpotcav,
 ref=0
);


%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18,
         id=id, tvar=period,
         agevar=agecon, qret= irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &cbbmpotcav_ &qcalorcav_ , 
         model2  = medcbbmpotcav &qcalorcav_,
         model3  = &cbbmpotcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_, 
         model4  = medcbbmpotcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_,
         model5  = &cbbmpotcav_ &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_, 
         model6  = medcbbmpotcav &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable8.norec.bbm_nhs.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;





