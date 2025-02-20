/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/06/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the NHS by latency period


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
        cumul86{i} = mean(nocum84{i}, nocum86{i});
        cumul90{i} = mean(nocum84{i}, nocum86{i}, nocum90{i});
        cumul94{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i});
        cumul98{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
        cumul02{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i});
        cumul06{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i});
        cumul10{i} = mean(nocum84{i}, nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i});
end;

run;

data two;
   set one end=_end_;
 
  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1); 
   if white=1 then white2=1;
   else white2=0;
   
array irt   {7} irt08   irt10 irt12  irt14  irt16 irt18 cutoff;
array perioda  {6}  period1  period2  period3  period4  period5  period6 ;
array tvar  {6}  t08 t10 t12 t14 t16 t18;
array age   {6}  age84 age86 age88 age90 age92 age94;
array aspyn {6}  aspyn84 aspyn86 aspyn88   aspyn90  aspyn92  aspyn94;
array hbp   {6}  hbp84 hbp86   hbp88   hbp90   hbp92   hbp94; 
array nsmk  {6}  smkdr84 smkdr86  smkdr88  smkdr90  smkdr92  smkdr94;
array bmi   {6}  bmi84 bmi86 bmi88 bmi90 bmi92 bmi94;
array actm  {6}  act86m act86m act88m act88m act92m act94m;
array pam   {6}  act86m act86m act88m act88m act92m act94m;
array horm  {6}  nhor84 nhor86 nhor88 nhor90 nhor92 nhor94;
array mvit  {6}  mvitu84 mvitu86 mvitu88 mvitu90 mvitu92 mvitu94;
array supp  {6}  suppu84 suppu86 suppu88 suppu90 suppu92 suppu94;
array antihp   {6}  htnrx88  htnrx88  htnrx88  htnrx88  htnrx88  htnrx94; 
array antitc   {6}  hchtx88  hchtx88  hchtx88  hchtx88  hchtx88  hchtx94;

array calorca  {6}  calor84ca calor86ca calor86ca calor90ca calor90ca calor94ca;
array aofibca  {6}  aofib84ca aofib86ca aofib86ca aofib90ca aofib90ca aofib94ca;
array cerafca  {6}  ceraf84ca ceraf86ca ceraf86ca ceraf90ca ceraf90ca ceraf94ca;
array alcoca  {6}  alco84ca alco86ca alco86ca alco90ca alco90ca alco94ca;
array satfca  {6}  sat84ca sat86ca sat86ca sat90ca sat90ca sat94ca;
array monfca  {6}  mon84ca mon86ca mon86ca mon90ca mon90ca mon94ca;
array polyfca  {6}  poly84ca poly86ca poly86ca poly90ca poly90ca poly94ca;
array transfca  {6}  trans84ca trnss86ca trnss86ca trnss90ca trnss90ca trnss94ca;
array folca  {6}  fol_84ca fol_86ca fol_86ca fol_90ca fol_90ca fol_94ca ;
array protca  {6}  prot84ca prot86ca prot86ca prot90ca prot90ca prot94ca;
array protdenca  {6}  protden84ca protden86ca protden86ca protden90ca protden90ca protden94ca;
array gidca  {6}   gid84ca gid86ca gid86ca gid90ca gid90ca gid94ca;
array carboca  {6}   carbo84ca carbo86ca carbo86ca carbo90ca carbo90ca carbo94ca;
array carbdenca  {6}   carbden84ca carbden86ca carbden86ca carbden90ca carbden90ca carbden94ca;

array calor  {6}   calor84n calor86n calor86n calor90n calor90n calor94n;
array carbo  {6}   carbo84n carbo86n carbo86n carbo90n carbo90n carbo94n;
array carbden  {6}  carbden84n carbden86n carbden86n carbden90n carbden90n carbden94n;
array prot  {6}   prot84n prot86n prot86n prot90n prot90n prot94n;
array protden  {6} protden84n protden86n protden86n protden90n protden90n protden94n;
array alco  {6}   alco84n alco86n alco86n alco90n alco90n alco94n;
array ceraf  {6}  ceraf84n ceraf86n ceraf86n ceraf90n ceraf90n ceraf94n;
array aofib  {6}  aofib84n aofib86n aofib86n aofib90n aofib90n aofib94n;

array tpotat  {6}  tpotat84d tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d ;
array bbmpot  {6}  bbmpot84d bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d ;
array fpotat  {6}  fpotat84d fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d ; 
array chipss  {6}  chipss84d chipss86d chipss86d chipss90d chipss90d chipss94d ;
array prmeat  {6}  prmeat84d prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d ;
array urmeat  {6}  urmeat84d urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d ;
array trmeat  {6}  trmeat84d trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d ;
array poultr  {6}  poultr84d poultr86d poultr86d poultr90d poultr90d poultr94d ;
array fishal  {6}  fishal84d fishal86d fishal86d fishal90d fishal90d fishal94d ;
array regegg  {6}  regegg84d regegg86d regegg86d regegg90d regegg90d regegg94d ;
array hdairy  {6}  hdairy84d hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d ;
array ldairy  {6}  ldairy84d ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ;
/*array soypro  {6}  soypro84d soypro86d soypro86d soypro90d soypro90d soypro94d ;*/
array nutsal  {6}  nutsal84d nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d ;
array legume  {6}  legume84d legume86d legume86d legume90d legume90d legume94d ;
array fruits  {6}  fruits84d fruits86d fruits86d fruits90d fruits90d fruits94d ;
array vegeal  {6}  vegeal84d vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d ;
array nstveg  {6}  nstveg84d nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d ;
array staveg  {6}  staveg84d staveg86d staveg86d staveg90d staveg90d staveg94d ;
array tdairy  {6}  tdairy84d tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d ;
array coffee  {6}  coffee84d coffee86d coffee86d coffee90d coffee90d coffee94d ;
array nutleg  {6}  nutleg84d nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d ;
array bwrice  {6}  bwrice84d bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d;
array wtrice  {6}  wtrice84d wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d ;
array SSB     {6}  SSB84d SSB86d SSB86d SSB90d SSB90d SSB94d;
array whgrns  {6}  whgrns84d whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d ;
array rfgrns  {6}  rfgrns84d rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d;
array whgrn  {6}  whgrn84n whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n;
array rfgrn  {6}  rfgrn84n rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n;
array gl     {6}     gl84n gl86n gl86n gl90n gl90n gl94n;
array gid    {6}  gid84n gid86n gid86n gid90n gid90n gid94n;

array tpotatca  {6}  tpotat84ca tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca;
array bbmpotca  {6}  bbmpot84ca bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca;
array fpotatca  {6}  fpotat84ca fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca;
array chipssca  {6}  chipss84ca chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca;
array prmeatca  {6}  prmeat84ca prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca;
array urmeatca  {6}  urmeat84ca urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca;
array trmeatca  {6}  trmeat84ca trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca;
array poultrca  {6}  poultr84ca poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca;
array fishalca  {6}  fishal84ca fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca;
array regeggca  {6}  regegg84ca regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca;
array hdairyca  {6}  hdairy84ca hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca;
array ldairyca  {6}  ldairy84ca ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca;
/*array soyproca  {6} soypro84ca soypro86ca soypro86ca soypro90ca soypro90ca soypro94ca;*/
array nutsalca  {6}  nutsal84ca nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca;
array legumeca  {6}  legume84ca legume86ca legume86ca legume90ca legume90ca legume94ca;
array fruitsca  {6}  fruits84ca fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca;
array vegealca  {6}  vegeal84ca vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca;
array nstvegca  {6}  nstveg84ca nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca;
array stavegca  {6}  staveg84ca staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca;
array tdairyca  {6}  tdairy84ca tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca; 
array coffeeca  {6}  coffee84ca coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca;
array nutlegca  {6}  nutleg84ca nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca;
array bwriceca  {6}  bwrice84ca bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca;
array wtriceca  {6}  wtrice84ca wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca;
array SSBca     {6}  SSB84ca SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca;
array whgrnsca  {6}  whgrns84ca whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca;
array rfgrnsca  {6}  rfgrns84ca rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca;
array whgrnca  {6}   whgrn84ca whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca;
array rfgrnca  {6}   rfgrn84ca rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca;
array glca  {6}  gl84ca gl86ca gl86ca gl90ca gl90ca gl94ca;

array ahei  {6}  ahei84 ahei86 ahei86 ahei90 ahei90 ahei94 ;
array aheinoal  {6}  aheinoal84 aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 ;
array aheinopt  {6}  aheinopt84 aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 ;
array aheifisha  {6}  aheifisha84 aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 ;
array aheidairy  {6}  aheidairy84 aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 ;
array aheinutbl  {6}  aheinutbl84 aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 ;
array aheipoult  {6}  aheipoult84 aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 ;
array aheineggs  {6}  aheineggs84 aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 ;

array aheica  {6}  ahei84ca ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca;
array aheinoalca  {6}   aheinoal84ca aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca;
array aheinoptca  {6}   aheinopt84ca aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca;
array aheifishaca  {6}  aheifisha84ca aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca ;
array aheidairyca  {6}  aheidairy84ca aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca ;
array aheinutblca  {6}  aheinutbl84ca aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca ;
array aheipoultca  {6}  aheipoult84ca aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca ;
array aheineggsca  {6}  aheineggs84ca aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca ;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {6} alone92 alone92 alone92 alone92 alone92 alone92;
array married {6} marry92 marry92 marry92 marry92 marry92 marry92;


/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {6} mdinc90_86 mdinc90_86 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94;
   array vhs {6} mdvhs90_86 mdvhs90_86 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94;
   array pcoll {6} pcolled80_86 pcolled90_86 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94;
   array phs {6} phs80_86 phs90_86 phs90_88 phs90_90 phs90_92 phs90_94;
   array pnohs {6} pnohs80_86 pnohs90_86 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94;
   array pfint {6} pfaminterest80_86 pfaminterest90_86 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94;
   array sfemale {6} pfwchbf80_86 pfwchbf90_86 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94;
   array pkid {6} pkid80_86 pkid90_86 pkid90_88 pkid90_90 pkid90_92 pkid90_94;
   array pold {6} pold80_86 pold90_86 pold90_88 pold90_90 pold90_92 pold90_94;
   array pohse {6} pohse80_86 pohse90_86 pohse90_88 pohse90_90 pohse90_92 pohse90_94;
   array ppov {6} ppov80_86 ppov90_86 ppov90_88 ppov90_90 ppov90_92 ppov90_94;
   array pw {6}   pwht80_86 pwht90_86 pwht90_88 pwht90_90 pwht90_92 pwht90_94;
   
   array popd {6}  popd80_86 popd90_86 popd90_88 popd90_90 popd90_92 popd90_94;
   array div {6} division10_86 division10_86 division10_88 division10_90 division10_92 division10_94;
   array reg {6} region10_86 region10_86 region10_88 region10_90 region10_92 region10_94;

   do i=1 to 6;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 6;
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

/*** Set cutoff at 2020.5***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1446;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1278+24*i) | irt{i}>=(1302+24*i)) then irt{i}=1278+24*i;
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
   %exclude(0 lt dtdth le irt{i});            /* Death before baseline*/
   %exclude(0 lt dtdxdiab le irt{i});         /* Diagnoses diabetes before 1984 */
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



keep id period agecon agegp agedi smkdi smkk chol84 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
 
     irt08 irt10 irt12 irt14 irt16 irt18 cutoff
     t08 t10 t12 t14 t16 t18 dtdth dtdxdiab
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
      fishalv hdairyv ldairyv /*soyprov*/ prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav fruitsv
      vegealcav vegealv nstvegcav stavegcav gidcav rfgrnscav SSBcav rfgrnsv whgrnsv whgrnscav  tdairyv nutlegv tdairycav nutlegcav gidv aheinoptcav nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);


proc freq data=four;tables qnSES &qnSES_;run;

data five;
   set four end=_end_;

     if 0.000<=tpotatcav<=0.070 then ctpotatcav=0;        
      else if 0.070<tpotatcav<=0.143 then ctpotatcav=1;       
      else if 0.143<tpotatcav<=0.430 then ctpotatcav=2;         
      else if 0.430<tpotatcav<=0.790 then ctpotatcav=3;       
      else if 0.790<tpotatcav then ctpotatcav=4;                   
  %indic3(vbl=ctpotatcav, prefix=ctpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if ctpotatcav=0 then medctpotatcav=0.0700000;
   if ctpotatcav=1 then medctpotatcav=0.1260000;
   if ctpotatcav=2 then medctpotatcav=0.2857143;
   if ctpotatcav=3 then medctpotatcav=0.5350000;
   if ctpotatcav=4 then medctpotatcav=0.8971429;


      if fpotatcav=0.000 then cfpotatcav=0;                     /**Almost never**/
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          /**1-3 serving per month**/
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         /**1 serving per week**/
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         /**2-4 serving per week**/
      else if 0.430<fpotatcav then cfpotatcav=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);
 

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0420000;
   if cfpotatcav=2 then medcfpotatcav=0.1050000;
   if cfpotatcav=3 then medcfpotatcav=0.2250000;
   if cfpotatcav=4 then medcfpotatcav=0.5733333;

      if chipsscav =0.000 then cchipsscav=0;                     /**Almost never**/
      else if 0.000<chipsscav <=0.070 then cchipsscav=1;          /**1-3 serving per month**/
      else if 0.070<chipsscav <=0.143 then cchipsscav=2;         /**1 serving per week**/
      else if 0.143<chipsscav <=0.430 then cchipsscav=3;         /**2-4 serving per week**/
      else if 0.430<chipsscav then cchipsscav=4;                 /** =>5 serving per week**/
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0437500;
   if cchipsscav=2 then medcchipsscav=0.1062500;
   if cchipsscav=3 then medcchipsscav=0.2500000;
   if cchipsscav=4 then medcchipsscav=0.6000000;


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                         
  %indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);


   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1225000;
   if cbbmpotcav=2 then medcbbmpotcav=0.3100000;
   if cbbmpotcav=3 then medcbbmpotcav=0.5928571;


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

      if regeggv=0.000 then qregeggv=0;
      else if 0.000<regeggv<=0.070 then qregeggv=1;          
      else if 0.070<regeggv<=0.143 then qregeggv=2;        
      else if 0.143<regeggv<=0.430 then qregeggv=3;         
      else if 0.430<regeggv then qregeggv=4;                 
%indic3(vbl=qregeggv, prefix=qregeggv, reflev=0, min=1, max=4, missing=., usemiss=0);
run;


proc means median data=five;var tpotatcav;class ctpotatcav; run;
proc means median data=five;var fpotatcav;class cfpotatcav; run;
proc means median data=five;var chipsscav;class cchipsscav; run;
proc means median data=five;var bbmpotcav;class cbbmpotcav; run;
proc freq data=five;tables qSSBv qregeggv;run; 

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t08 t10 t12 t14 t16 t18,
         id=id, tvar=period,
         agevar=agecon, qret=irt08   irt10 irt12   irt14 irt16 irt18, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,

         model1  = tpotatwv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_, 
         model2  = bbmpotwv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model3  = fpotatowv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_,
         outdat=RR1);