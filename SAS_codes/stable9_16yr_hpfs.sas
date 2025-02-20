/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the HPFS by latency period


data one;
set base0 end=_end_;

array nocum86 {*}  calor86n alco86n gid86n tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d soypro86d nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d whgrn86n rfgrn86n whgrns86d rfgrns86d gl86n ahei86 aheinoal86 aheinopt86 aheifisha86 aheidairy86 aheinutbl86 aheipoult86 aheineggs86;  
array nocum90 {*}  calor90n alco90n gid90n tpotat90d bbmpot90d fpotat90d chipss90d prmeat90d urmeat90d trmeat90d poultr90d fishal90d regegg90d hdairy90d ldairy90d soypro90d nutsal90d legume90d fruits90d vegeal90d nstveg90d staveg90d tdairy90d coffee90d nutleg90d bwrice90d wtrice90d SSB90d whgrn90n rfgrn90n whgrns90d rfgrns90d gl90n ahei90 aheinoal90 aheinopt90 aheifisha90 aheidairy90 aheinutbl90 aheipoult90 aheineggs90;
array nocum94 {*}  calor94n alco94n gid94n tpotat94d bbmpot94d fpotat94d chipss94d prmeat94d urmeat94d trmeat94d poultr94d fishal94d regegg94d hdairy94d ldairy94d soypro94d nutsal94d legume94d fruits94d vegeal94d nstveg94d staveg94d tdairy94d coffee94d nutleg94d bwrice94d wtrice94d SSB94d whgrn94n rfgrn94n whgrns94d rfgrns94d gl94n ahei94 aheinoal94 aheinopt94 aheifisha94 aheidairy94 aheinutbl94 aheipoult94 aheineggs94;
array nocum98 {*}  calor98n alco98n gid98n tpotat98d bbmpot98d fpotat98d chipss98d prmeat98d urmeat98d trmeat98d poultr98d fishal98d regegg98d hdairy98d ldairy98d soypro98d nutsal98d legume98d fruits98d vegeal98d nstveg98d staveg98d tdairy98d coffee98d nutleg98d bwrice98d wtrice98d SSB98d whgrn98n rfgrn98n whgrns98d rfgrns98d gl98n ahei98 aheinoal98 aheinopt98 aheifisha98 aheidairy98 aheinutbl98 aheipoult98 aheineggs98;
array nocum02 {*}  calor02n alco02n gid02n tpotat02d bbmpot02d fpotat02d chipss02d prmeat02d urmeat02d trmeat02d poultr02d fishal02d regegg02d hdairy02d ldairy02d soypro02d nutsal02d legume02d fruits02d vegeal02d nstveg02d staveg02d tdairy02d coffee02d nutleg02d bwrice02d wtrice02d SSB02d whgrn02n rfgrn02n whgrns02d rfgrns02d gl02n ahei02 aheinoal02 aheinopt02 aheifisha02 aheidairy02 aheinutbl02 aheipoult02 aheineggs02;
array nocum06 {*}  calor06n alco06n gid06n tpotat06d bbmpot06d fpotat06d chipss06d prmeat06d urmeat06d trmeat06d poultr06d fishal06d regegg06d hdairy06d ldairy06d soypro06d nutsal06d legume06d fruits06d vegeal06d nstveg06d staveg06d tdairy06d coffee06d nutleg06d bwrice06d wtrice06d SSB06d whgrn06n rfgrn06n whgrns06d rfgrns06d gl06n ahei06 aheinoal06 aheinopt06 aheifisha06 aheidairy06 aheinutbl06 aheipoult06 aheineggs06;
array nocum10 {*}  calor10n alco10n gid10n tpotat10d bbmpot10d fpotat10d chipss10d prmeat10d urmeat10d trmeat10d poultr10d fishal10d regegg10d hdairy10d ldairy10d soypro10d nutsal10d legume10d fruits10d vegeal10d nstveg10d staveg10d tdairy10d coffee10d nutleg10d bwrice10d wtrice10d SSB10d whgrn10n rfgrn10n whgrns10d rfgrns10d gl10n ahei10 aheinoal10 aheinopt10 aheifisha10 aheidairy10 aheinutbl10 aheipoult10 aheineggs10;
array nocum14 {*}  calor14n alco14n gid14n tpotat14d bbmpot14d fpotat14d chipss14d prmeat14d urmeat14d trmeat14d poultr14d fishal14d regegg14d hdairy14d ldairy14d soypro14d nutsal14d legume14d fruits14d vegeal14d nstveg14d staveg14d tdairy14d coffee14d nutleg14d bwrice14d wtrice14d SSB14d whgrn14n rfgrn14n whgrns14d rfgrns14d gl14n ahei14 aheinoal14 aheinopt14 aheifisha14 aheidairy14 aheinutbl14 aheipoult14 aheineggs14;

array cumul86 {*}  calor86ca alco86ca gid86ca tpotat86ca bbmpot86ca fpotat86ca chipss86ca prmeat86ca urmeat86ca trmeat86ca poultr86ca fishal86ca regegg86ca hdairy86ca ldairy86ca soypro86ca nutsal86ca legume86ca fruits86ca vegeal86ca nstveg86ca staveg86ca tdairy86ca coffee86ca nutleg86ca bwrice86ca wtrice86ca SSB86ca whgrn86ca rfgrn86ca whgrns86ca rfgrns86ca gl86ca ahei86ca aheinoal86ca aheinopt86ca aheifisha86ca aheidairy86ca aheinutbl86ca aheipoult86ca aheineggs86ca;  
array cumul90 {*}  calor90ca alco90ca gid90ca tpotat90ca bbmpot90ca fpotat90ca chipss90ca prmeat90ca urmeat90ca trmeat90ca poultr90ca fishal90ca regegg90ca hdairy90ca ldairy90ca soypro90ca nutsal90ca legume90ca fruits90ca vegeal90ca nstveg90ca staveg90ca tdairy90ca coffee90ca nutleg90ca bwrice90ca wtrice90ca SSB90ca whgrn90ca rfgrn90ca whgrns90ca rfgrns90ca gl90ca ahei90ca aheinoal90ca aheinopt90ca aheifisha90ca aheidairy90ca aheinutbl90ca aheipoult90ca aheineggs90ca; 
array cumul94 {*}  calor94ca alco94ca gid94ca tpotat94ca bbmpot94ca fpotat94ca chipss94ca prmeat94ca urmeat94ca trmeat94ca poultr94ca fishal94ca regegg94ca hdairy94ca ldairy94ca soypro94ca nutsal94ca legume94ca fruits94ca vegeal94ca nstveg94ca staveg94ca tdairy94ca coffee94ca nutleg94ca bwrice94ca wtrice94ca SSB94ca whgrn94ca rfgrn94ca whgrns94ca rfgrns94ca gl94ca ahei94ca aheinoal94ca aheinopt94ca aheifisha94ca aheidairy94ca aheinutbl94ca aheipoult94ca aheineggs94ca; 
array cumul98 {*}  calor98ca alco98ca gid98ca tpotat98ca bbmpot98ca fpotat98ca chipss98ca prmeat98ca urmeat98ca trmeat98ca poultr98ca fishal98ca regegg98ca hdairy98ca ldairy98ca soypro98ca nutsal98ca legume98ca fruits98ca vegeal98ca nstveg98ca staveg98ca tdairy98ca coffee98ca nutleg98ca bwrice98ca wtrice98ca SSB98ca whgrn98ca rfgrn98ca whgrns98ca rfgrns98ca gl98ca ahei98ca aheinoal98ca aheinopt98ca aheifisha98ca aheidairy98ca aheinutbl98ca aheipoult98ca aheineggs98ca; 
array cumul02 {*}  calor02ca alco02ca gid02ca tpotat02ca bbmpot02ca fpotat02ca chipss02ca prmeat02ca urmeat02ca trmeat02ca poultr02ca fishal02ca regegg02ca hdairy02ca ldairy02ca soypro02ca nutsal02ca legume02ca fruits02ca vegeal02ca nstveg02ca staveg02ca tdairy02ca coffee02ca nutleg02ca bwrice02ca wtrice02ca SSB02ca whgrn02ca rfgrn02ca whgrns02ca rfgrns02ca gl02ca ahei02ca aheinoal02ca aheinopt02ca aheifisha02ca aheidairy02ca aheinutbl02ca aheipoult02ca aheineggs02ca; 
array cumul06 {*}  calor06ca alco06ca gid06ca tpotat06ca bbmpot06ca fpotat06ca chipss06ca prmeat06ca urmeat06ca trmeat06ca poultr06ca fishal06ca regegg06ca hdairy06ca ldairy06ca soypro06ca nutsal06ca legume06ca fruits06ca vegeal06ca nstveg06ca staveg06ca tdairy06ca coffee06ca nutleg06ca bwrice06ca wtrice06ca SSB06ca whgrn06ca rfgrn06ca whgrns06ca rfgrns06ca gl06ca ahei06ca aheinoal06ca aheinopt06ca aheifisha06ca aheidairy06ca aheinutbl06ca aheipoult06ca aheineggs06ca; 
array cumul10 {*}  calor10ca alco10ca gid10ca tpotat10ca bbmpot10ca fpotat10ca chipss10ca prmeat10ca urmeat10ca trmeat10ca poultr10ca fishal10ca regegg10ca hdairy10ca ldairy10ca soypro10ca nutsal10ca legume10ca fruits10ca vegeal10ca nstveg10ca staveg10ca tdairy10ca coffee10ca nutleg10ca bwrice10ca wtrice10ca SSB10ca whgrn10ca rfgrn10ca whgrns10ca rfgrns10ca gl10ca ahei10ca aheinoal10ca aheinopt10ca aheifisha10ca aheidairy10ca aheinutbl10ca aheipoult10ca aheineggs10ca;  
array cumul14 {*}  calor14ca alco14ca gid14ca tpotat14ca bbmpot14ca fpotat14ca chipss14ca prmeat14ca urmeat14ca trmeat14ca poultr14ca fishal14ca regegg14ca hdairy14ca ldairy14ca soypro14ca nutsal14ca legume14ca fruits14ca vegeal14ca nstveg14ca staveg14ca tdairy14ca coffee14ca nutleg14ca bwrice14ca wtrice14ca SSB14ca whgrn14ca rfgrn14ca whgrns14ca rfgrns14ca gl14ca ahei14ca aheinoal14ca aheinopt14ca aheifisha14ca aheidairy14ca aheinutbl14ca aheipoult14ca aheineggs14ca;  

do i = 1 to DIM(cumul14);
        cumul86{i} = nocum86{i};
        cumul90{i} = mean(nocum86{i}, nocum90{i});
        cumul94{i} = mean(nocum86{i}, nocum90{i}, nocum94{i});
        cumul98{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i});
        cumul02{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i});
        cumul06{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i});
        cumul10{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i});
        cumul14{i} = mean(nocum86{i}, nocum90{i}, nocum94{i}, nocum98{i}, nocum02{i}, nocum06{i}, nocum10{i}, nocum14{i});

end;

run;

data two;
set one end=_end_;
 
  %indic3(vbl=eth3g, prefix=strrace, reflev=1, min=2, max=3, missing=., usemiss=1,
           label1='causcasian',
           label2='african',
           label3='asian & others');

  %indic3(vbl=white, prefix=white,min=1,max=1, reflev=0, missing=., usemiss=1);  
array rtmnyr   {9} rtmnyr02 rtmnyr04 rtmnyr06 rtmnyr08 rtmnyr10 rtmnyr12 rtmnyr14 rtmnyr16  cutoff;
array irt   {9} irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16   cutoff;
array perioda  {8}  period1  period2  period3  period4  period5  period6  period7  period8 ;
array tvar  {8}  t02   t04   t06   t08   t10   t12   t14   t16     ;
array age   {8}  age86 age88 age90 age92 age94 age96 age98 age00;
array aspi  {8}  asp86 asp88 asp90 asp92 asp94 asp96 asp96 asp00 ;
array hbp   {8}  hbp86 hbp88 hbp90 hbp92 hbp94 hbp96 hbp98 hbp00 ;
array chol  {8}  chol86   chol88   chol90   chol92   chol94   chol96   chol98   chol00;
array db {8}  db86  db88  db90  db92  db94  db96  db98  db00  ;

array smoke {8}  smoke86  smoke88  smoke90  smoke92  smoke94  smoke96  smoke98  smoke00  ;
array cgnm  {8}  cgnm86   cgnm88   cgnm90   cgnm92   cgnm94   cgnm96   cgnm98   cgnm00   ;
array smm   {8}  smm86 smm88 smm90 smm92 smm94 smm96 smm98 smm00 ;
array bmi   {8}  bmi86   bmi88   bmi90   bmi92   bmi94   bmi96   bmi98   bmi00 ;
array bmicq {8}  bmic86   bmic88   bmic90   bmic92   bmic94   bmic96   bmic98   bmic00;
array alco  {8}  alco86n  alco86n  alco90n  alco90n  alco94n  alco94n  alco98n  alco98n;
array alcoca  {8}  alco86ca alco86ca alco90ca alco90ca alco94ca alco94ca alco98ca alco98ca;
array alcq  {8}  alc86 alc88 alc90 alc92 alc94 alc96 alc98 alc00 ;
array actm  {8}  act86 act88 act90 act92 act94 act96 act98 act00 ;
array antitc   {8}  hchtx86  hchtx88  hchtx90  hchtx92  hchtx94  hchtx96  hchtx98  hchtx00  ; 
array repcabg   {8}  cabg86  cabg88  cabg90  cabg92 cabg94  cabg96  cabg98  cabg00  ; 
array ang   {8}  ang86  ang88  ang90  ang92  ang94  ang96  ang98  ang00; 
array antihp   {8}  htnrx86  htnrx88  htnrx90  htnrx92  htnrx94  htnrx96  htnrx98  htnrx00;
array mvit    {8}   mvit86 mvit86 mvit90 mvit90 mvit94 mvit94 mvit98 mvit98;

/*Statin*/
array statin {8}    hchtx86 hchtx88 hchtx90 hchtx92 hchtx94 hchtx96 hchtx98 chrx00;
                                       
array calor   {8}  calor86n calor86n calor90n calor90n calor94n calor94n calor98n calor98n;
array gl      {8}  gl86n gl86n gl90n gl90n gl94n gl94n gl98n gl98n;
array gid     {8}  gid86n gid86n gid90n gid90n gid94n gid94n gid98n gid98n;
array whgrns  {8}  whgrns86d whgrns86d whgrns90d whgrns90d whgrns94d whgrns94d whgrns98d whgrns98d ;
array rfgrns  {8}  rfgrns86d rfgrns86d rfgrns90d rfgrns90d rfgrns94d rfgrns94d rfgrns98d rfgrns98d ;
array whgrn   {8}  whgrn86n whgrn86n whgrn90n whgrn90n whgrn94n whgrn94n whgrn98n whgrn98n ;
array rfgrn   {8}  rfgrn86n rfgrn86n rfgrn90n rfgrn90n rfgrn94n rfgrn94n rfgrn98n rfgrn98n ;

array tpotat  {8}  tpotat86d tpotat86d tpotat90d tpotat90d tpotat94d tpotat94d tpotat98d tpotat98d ;
array bbmpot  {8}  bbmpot86d bbmpot86d bbmpot90d bbmpot90d bbmpot94d bbmpot94d bbmpot98d bbmpot98d ;
array fpotat  {8}  fpotat86d fpotat86d fpotat90d fpotat90d fpotat94d fpotat94d fpotat98d fpotat98d ;
array chipss  {8}  chipss86d chipss86d chipss90d chipss90d chipss94d chipss94d chipss98d chipss98d ;
array prmeat  {8}  prmeat86d prmeat86d prmeat90d prmeat90d prmeat94d prmeat94d prmeat98d prmeat98d ;
array urmeat  {8}  urmeat86d urmeat86d urmeat90d urmeat90d urmeat94d urmeat94d urmeat98d urmeat98d ;
array trmeat  {8}  trmeat86d trmeat86d trmeat90d trmeat90d trmeat94d trmeat94d trmeat98d trmeat98d ;
array poultr  {8}  poultr86d poultr86d poultr90d poultr90d poultr94d poultr94d poultr98d poultr98d ;
array fishal  {8}  fishal86d fishal86d fishal90d fishal90d fishal94d fishal94d fishal98d fishal98d ;
array regegg  {8}  regegg86d regegg86d regegg90d regegg90d regegg94d regegg94d regegg98d regegg98d ;
array hdairy  {8}  hdairy86d hdairy86d hdairy90d hdairy90d hdairy94d hdairy94d hdairy98d hdairy98d ;
array ldairy  {8}  ldairy86d ldairy86d ldairy90d ldairy90d ldairy94d ldairy94d ldairy98d ldairy98d ;
array soypro  {8}  soypro86d soypro86d soypro90d soypro90d soypro94d soypro94d soypro98d soypro98d ;
array nutsal  {8}  nutsal86d nutsal86d nutsal90d nutsal90d nutsal94d nutsal94d nutsal98d nutsal98d ; 
array legume  {8}  legume86d legume86d legume90d legume90d legume94d legume94d legume98d legume98d ;
array fruits  {8}  fruits86d fruits86d fruits90d fruits90d fruits94d fruits94d fruits98d fruits98d ;
array vegeal  {8}  vegeal86d vegeal86d vegeal90d vegeal90d vegeal94d vegeal94d vegeal98d vegeal98d ;
array nstveg  {8}  nstveg86d nstveg86d nstveg90d nstveg90d nstveg94d nstveg94d nstveg98d nstveg98d ;
array staveg  {8}  staveg86d staveg86d staveg90d staveg90d staveg94d staveg94d staveg98d staveg98d ;
array tdairy  {8}  tdairy86d tdairy86d tdairy90d tdairy90d tdairy94d tdairy94d tdairy98d tdairy98d ;
array coffee  {8}  coffee86d coffee86d coffee90d coffee90d coffee94d coffee94d coffee98d coffee98d ;
array nutleg  {8}  nutleg86d nutleg86d nutleg90d nutleg90d nutleg94d nutleg94d nutleg98d nutleg98d ;
array bwrice  {8}  bwrice86d bwrice86d bwrice90d bwrice90d bwrice94d bwrice94d bwrice98d bwrice98d ;
array wtrice  {8}  wtrice86d wtrice86d wtrice90d wtrice90d wtrice94d wtrice94d wtrice98d wtrice98d ;
array SSB     {8}  SSB86d SSB86d SSB90d SSB90d SSB94d SSB94d SSB98d SSB98d;

array calorca   {8}  calor86ca calor86ca calor90ca calor90ca calor94ca calor94ca calor98ca calor98ca ;
array glca      {8}  gl86ca gl86ca gl90ca gl90ca gl94ca gl94ca gl98ca gl98ca ;
array gidca     {8}  gid86ca gid86ca gid90ca gid90ca gid94ca gid94ca gid98ca gid98ca ;
array whgrnsca  {8}  whgrns86ca whgrns86ca whgrns90ca whgrns90ca whgrns94ca whgrns94ca whgrns98ca whgrns98ca ;
array rfgrnsca  {8}  rfgrns86ca rfgrns86ca rfgrns90ca rfgrns90ca rfgrns94ca rfgrns94ca rfgrns98ca rfgrns98ca ;
array whgrnca   {8}  whgrn86ca whgrn86ca whgrn90ca whgrn90ca whgrn94ca whgrn94ca whgrn98ca whgrn98ca ;
array rfgrnca   {8}  rfgrn86ca rfgrn86ca rfgrn90ca rfgrn90ca rfgrn94ca rfgrn94ca rfgrn98ca rfgrn98ca ;

array tpotatca  {8}  tpotat86ca tpotat86ca tpotat90ca tpotat90ca tpotat94ca tpotat94ca tpotat98ca tpotat98ca ;
array bbmpotca  {8}  bbmpot86ca bbmpot86ca bbmpot90ca bbmpot90ca bbmpot94ca bbmpot94ca bbmpot98ca bbmpot98ca ;
array fpotatca  {8}  fpotat86ca fpotat86ca fpotat90ca fpotat90ca fpotat94ca fpotat94ca fpotat98ca fpotat98ca ;
array chipssca  {8}  chipss86ca chipss86ca chipss90ca chipss90ca chipss94ca chipss94ca chipss98ca chipss98ca ;
array prmeatca  {8}  prmeat86ca prmeat86ca prmeat90ca prmeat90ca prmeat94ca prmeat94ca prmeat98ca prmeat98ca ;
array urmeatca  {8}  urmeat86ca urmeat86ca urmeat90ca urmeat90ca urmeat94ca urmeat94ca urmeat98ca urmeat98ca ;
array trmeatca  {8}  trmeat86ca trmeat86ca trmeat90ca trmeat90ca trmeat94ca trmeat94ca trmeat98ca trmeat98ca ;
array poultrca  {8}  poultr86ca poultr86ca poultr90ca poultr90ca poultr94ca poultr94ca poultr98ca poultr98ca ;
array fishalca  {8}  fishal86ca fishal86ca fishal90ca fishal90ca fishal94ca fishal94ca fishal98ca fishal98ca ;
array regeggca  {8}  regegg86ca regegg86ca regegg90ca regegg90ca regegg94ca regegg94ca regegg98ca regegg98ca ;
array hdairyca  {8}  hdairy86ca hdairy86ca hdairy90ca hdairy90ca hdairy94ca hdairy94ca hdairy98ca hdairy98ca ;
array ldairyca  {8}  ldairy86ca ldairy86ca ldairy90ca ldairy90ca ldairy94ca ldairy94ca ldairy98ca ldairy98ca ;
array soyproca  {8}  soypro86ca soypro86ca soypro90ca soypro90ca soypro94ca soypro94ca soypro98ca soypro98ca ;
array nutsalca  {8}  nutsal86ca nutsal86ca nutsal90ca nutsal90ca nutsal94ca nutsal94ca nutsal98ca nutsal98ca ;
array legumeca  {8}  legume86ca legume86ca legume90ca legume90ca legume94ca legume94ca legume98ca legume98ca ;
array fruitsca  {8}  fruits86ca fruits86ca fruits90ca fruits90ca fruits94ca fruits94ca fruits98ca fruits98ca ;
array vegealca  {8}  vegeal86ca vegeal86ca vegeal90ca vegeal90ca vegeal94ca vegeal94ca vegeal98ca vegeal98ca ;
array nstvegca  {8}  nstveg86ca nstveg86ca nstveg90ca nstveg90ca nstveg94ca nstveg94ca nstveg98ca nstveg98ca ;
array stavegca  {8}  staveg86ca staveg86ca staveg90ca staveg90ca staveg94ca staveg94ca staveg98ca staveg98ca ;
array tdairyca  {8}  tdairy86ca tdairy86ca tdairy90ca tdairy90ca tdairy94ca tdairy94ca tdairy98ca tdairy98ca ;
array coffeeca  {8}  coffee86ca coffee86ca coffee90ca coffee90ca coffee94ca coffee94ca coffee98ca coffee98ca ;
array nutlegca  {8}  nutleg86ca nutleg86ca nutleg90ca nutleg90ca nutleg94ca nutleg94ca nutleg98ca nutleg98ca ;
array bwriceca  {8}  bwrice86ca bwrice86ca bwrice90ca bwrice90ca bwrice94ca bwrice94ca bwrice98ca bwrice98ca ;
array wtriceca  {8}  wtrice86ca wtrice86ca wtrice90ca wtrice90ca wtrice94ca wtrice94ca wtrice98ca wtrice98ca ;
array SSBca     {8}  SSB86ca SSB86ca SSB90ca SSB90ca SSB94ca SSB94ca SSB98ca SSB98ca ;


array ahei       {8}  ahei86 ahei86 ahei90 ahei90 ahei94 ahei94 ahei98 ahei98 ;
array aheinoal   {8}  aheinoal86 aheinoal86 aheinoal90 aheinoal90 aheinoal94 aheinoal94 aheinoal98 aheinoal98 ;
array aheinopt   {8}  aheinopt86 aheinopt86 aheinopt90 aheinopt90 aheinopt94 aheinopt94 aheinopt98 aheinopt98 ;
array aheifisha  {8}  aheifisha86 aheifisha86 aheifisha90 aheifisha90 aheifisha94 aheifisha94 aheifisha98 aheifisha98 ;
array aheidairy  {8}  aheidairy86 aheidairy86 aheidairy90 aheidairy90 aheidairy94 aheidairy94 aheidairy98 aheidairy98 ;
array aheinutbl  {8}  aheinutbl86 aheinutbl86 aheinutbl90 aheinutbl90 aheinutbl94 aheinutbl94 aheinutbl98 aheinutbl98 ;
array aheipoult  {8}  aheipoult86 aheipoult86 aheipoult90 aheipoult90 aheipoult94 aheipoult94 aheipoult98 aheipoult98 ;
array aheineggs  {8}  aheineggs86 aheineggs86 aheineggs90 aheineggs90 aheineggs94 aheineggs94 aheineggs98 aheineggs98 ;

array aheica       {8}  ahei86ca ahei86ca ahei90ca ahei90ca ahei94ca ahei94ca ahei98ca ahei98ca ; 
array aheinoalca   {8}  aheinoal86ca aheinoal86ca aheinoal90ca aheinoal90ca aheinoal94ca aheinoal94ca aheinoal98ca aheinoal98ca ;
array aheinoptca   {8}  aheinopt86ca aheinopt86ca aheinopt90ca aheinopt90ca aheinopt94ca aheinopt94ca aheinopt98ca aheinopt98ca ;
array aheifishaca  {8}  aheifisha86ca aheifisha86ca aheifisha90ca aheifisha90ca aheifisha94ca aheifisha94ca aheifisha98ca aheifisha98ca ;
array aheidairyca  {8}  aheidairy86ca aheidairy86ca aheidairy90ca aheidairy90ca aheidairy94ca aheidairy94ca aheidairy98ca aheidairy98ca ;
array aheinutblca  {8}  aheinutbl86ca aheinutbl86ca aheinutbl90ca aheinutbl90ca aheinutbl94ca aheinutbl94ca aheinutbl98ca aheinutbl98ca ;
array aheipoultca  {8}  aheipoult86ca aheipoult86ca aheipoult90ca aheipoult90ca aheipoult94ca aheipoult94ca aheipoult98ca aheipoult98ca ;
array aheineggsca  {8}  aheineggs86ca aheineggs86ca aheineggs90ca aheineggs90ca aheineggs94ca aheineggs94ca aheineggs98ca aheineggs98ca ;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {8} mdinc90_88 mdinc90_88 mdinc90_90 mdinc90_92 mdinc90_94 mdinc00_96 mdinc00_98 mdinc00_00; 
   array vhs {8} mdvhs90_88 mdvhs90_88 mdvhs90_90 mdvhs90_92 mdvhs90_94 mdvhs00_96 mdvhs00_98 mdvhs00_00; 
   array pcoll {8} pcolled90_88 pcolled90_88 pcolled90_90 pcolled90_92 pcolled90_94 pcolled00_96
        pcolled00_98 pcolled00_00;
   array phs {8} phs90_88 phs90_88 phs90_90 phs90_92 phs90_94 phs00_96 phs00_98 phs00_00 ;
   array pnohs {8} pnohs90_88 pnohs90_88 pnohs90_90 pnohs90_92 pnohs90_94 pnohs00_96 pnohs00_98 pnohs00_00 ;
   array pfint {8} pfaminterest90_88 pfaminterest90_88 pfaminterest90_90 pfaminterest90_92 pfaminterest90_94
          pfaminterest00_96 pfaminterest00_98 pfaminterest00_00;
   array sfemale {8} pfwchbf90_88 pfwchbf90_88 pfwchbf90_90 pfwchbf90_92 pfwchbf90_94 pfwchbf00_96 pfwchbf00_98
          pfwchbf00_00;
   array pkid {8} pkid90_88 pkid90_88 pkid90_90 pkid90_92 pkid90_94 pkid00_96 pkid00_98 pkid00_00 ;
       
   array pold {8} pold90_88 pold90_88 pold90_90 pold90_92 pold90_94 pold00_96 pold00_98 pold00_00 ;
   array pohse {8} pohse90_88 pohse90_88 pohse90_90 pohse90_92 pohse90_94 pohse00_96 pohse00_98 pohse00_00;
   array ppov {8} ppov90_88 ppov90_88 ppov90_90 ppov90_92 ppov90_94 ppov00_96 ppov00_98 ppov00_00;
   array pw {8}   pwht90_88 pwht90_88 pwht90_90 pwht90_92 pwht90_94 pwht00_96 pwht00_98 pwht00_00;

   array popd {8} popd90_88 popd90_88 popd90_90 popd90_92 popd90_94 popd00_96 popd00_98 popd00_00; 
   array div {8} division10_88 division10_88 division10_90 division10_92 division10_94 division10_96
      division10_98 division10_00;
   array reg {8} region10_88 region10_88 region10_90 region10_92 region10_94 region10_96 region10_98
      region10_00 ;

/****** missing replace ******/
    do b=2 to 8;
       if rtmnyr{b}=. then rtmnyr{b}=rtmnyr{b-1}+24;
       if actm{b}=. then actm{b}=actm{b-1};
       if bmi{b}=. then bmi{b}=bmi{b-1};
       if alco{b}=. then alco{b}=alco{b-1};
       if smm{b}=. then smm{b}=smm{b-1};
       if statin{b}=. then statin{b}=statin{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
       if aspi{b}=. then aspi{b}=aspi{b-1};
       if calor{b}=. then calor{b}=calor{b-1};
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
       if soypro{b}=. then soypro{b}=soypro{b-1};
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
       if mvit{b}=. then mvit{b}=mvit{b-1};
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};
       if aheifisha{b}=. then aheifisha{b}=aheifisha{b-1};
       if aheidairy{b}=. then aheidairy{b}=aheidairy{b-1};
       if aheinutbl{b}=. then aheinutbl{b}=aheinutbl{b-1};
       if aheipoult{b}=. then aheipoult{b}=aheipoult{b-1};
       if aheineggs{b}=. then aheineggs{b}=aheineggs{b-1};
       if tdairy{b}=. then tdairy{b}=tdairy{b-1};
       if nutleg{b}=. then nutleg{b}=nutleg{b-1};
       if bwrice{b}=. then bwrice{b}=bwrice{b-1};
       if wtrice{b}=. then wtrice{b}=wtrice{b-1};
       if coffee{b}=. then coffee{b}=coffee{b-1};
       if SSB{b}=. then SSB{b}=SSB{b-1};

       if alcoca{b}=. then alcoca{b}=alcoca{b-1};
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
       if nutsalca{b}=. then nutsalca{b}=nutsalca{b-1};
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if coffeeca{b}=. then coffeeca{b}=coffeeca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};

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
    
    /****** DEFINE AGE ******/
    do c=1 to 8;
     irt{c}=rtmnyr{c};
     age{c}=int((irt{c}-birthday)/12);
     if age{c} =< 0 then age{c}=.;   
    end;
    do d=2 to 8;
       if age{d}=. then age{d}=age{d-1}+2;
    end;


do i=1 to DIM(irt)-1;
  if irt{i} >0 then lastq=irt{i};
  end;
  drop i;
  if lastq=irt{dim(irt)-1} then lastq=.;

/*** Set cutoff at 2018 Jan 31 ***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
  cutoff=1417;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1201+24*i) | irt{i}>=(1225+24*i)) then irt{i}=1201+24*i;
   end;  

%beginex();

   *****************Do-Loop over time periods*****************************;
   
   do i=1 to dim(irt)-1;
      period=i;
      do j=1 to dim(tvar);
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

/******main exposure******/ 
if chol86 ne 1 then chol86=0;
if hbp86 ne 1 then hbp86=0;
if mi86 ne 1 then mi86=0;
if db86 ne 1 then db86=0;
if cabg86 ne 1 then cabg86=0;
if ang86 ne 1 then ang86=0;
if str86 ne 1 then str86=0;
if mi86=1 or cabg86=1 or ang86=1 or str86=1 then cvd86=1;else cvd86=0;
if can86 ne 1 then can86=0;
calorv   =  calor    {i};
calorcav =  calorca  {i};
glv      =  gl  {i};
glcav    =  glca  {i};
gidv     =  gid  {i};
gidcav   =  gidca  {i};
alcov    =  alco  {i};
alcocav  =  alcoca  {i};

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
soyprov = soypro  {i};
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
SSBv =    SSB     {i};
whgrnsv = whgrns  {i};
rfgrnsv = rfgrns  {i};
whgrnv = whgrn  {i};
rfgrnv = rfgrn  {i};

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
soyprocav = soyproca  {i};
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
SSBcav =    SSBca     {i};
whgrnscav = whgrnsca  {i};
rfgrnscav = rfgrnsca  {i};
whgrncav = whgrnca  {i};
rfgrncav = rfgrnca  {i};

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

      /****** Indicator for Smoking ******/ 
     catsmk=smm{i};
     if catsmk=. then catsmk=1;
     %indic3(vbl=catsmk, prefix=catsmkc,min=2,max=5, reflev=1, missing=., usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');

     if catsmk=1 then smkdi=0;
     else smkdi=1;

     if catsmk=1 then smktr=0;
     else if catsmk=2 then smktr=1;
     else smktr=2;

     if smm{i} in (1,2) then catsmkf=0;
     else if smm{i} in (3,4,5) then catsmkf=1;
     else catsmkf=0;
     /*%indic3(vbl=catsmkf, prefix=catsmkfc,min=2,max=4, reflev=1, missing=., usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker >=15 cigs');*/
       /****** Indicator for BMI ******/
      bmicon=bmi{i};if bmi{i}=0 then bmicon=.;
      if bmicon=. then bmicon=25.38358700;

      if bmicon < 25 then bmidi = 0;
         else bmidi = 1;

      if bmicon < 25 then bmitr = 0;
      else if bmicon >= 25 and bmicon < 30 then bmitr = 1;
      else bmitr = 2;

      if 0<bmicon<21 then bmicq{i}=1;
         else if bmicon>=21 and bmicon<25 then bmicq{i}=2;
         else if bmicon>=25 and bmicon<30 then bmicq{i}=3;
         else if bmicon>=30 and bmicon<32 then bmicq{i}=4;
         else if bmicon>=32 then bmicq{i}=5;
         else bmicq{i}=.;
 
       bmic=bmicq{i};    
       if bmic=. then bmic=3;  
      %indic3(vbl=bmic, prefix=bmic, min=1, max=5, reflev=2, missing=., usemiss=0,
                label1='bmi<21', 
                label2='bmi 21-24.9',
                label3='bmi 25-29.9', 
                label4='bmi 30.0-31.9', 
                label5='bmi 32.0+');

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
 
      /****** Indicator Physical Activity ******/
       actcon=actm{i}; 
       if actcon=. then actcon=22.00000;
              if 0<=actcon<3 then actcc=1;
      else if actcon>=3 and actcon<9 then actcc=2;
      else if actcon>=9 and actcon<18 then actcc=3;
      else if actcon>=18 and actcon<27 then actcc=4;
      else if actcon>=27 then actcc=5;
      else actcc=.;/*very few missing use median*/

      if actcon<22.00000 then actbi = 0;
      else if actcon>=22.00000 then actbi = 1;
      else actbi = 0;
      
%indic3(vbl=actcc, prefix=actc, min=2, max=5, reflev=1, missing=., usemiss=0);

      
      /****** Indicator Alcohol consumption ******/
       alcocon=alcoca{i}; /***continuous variable, g/day***/ 
            if alcoca{i}=0.0                     then alcq{i}=1;
            if alcoca{i}>0.0  and alcoca{i}<5.0   then alcq{i}=2;
            if alcoca{i}>=5.0 and alcoca{i}<10.0  then alcq{i}=3;
            if alcoca{i}>=10.0 and alcoca{i}<15.0 then alcq{i}=4;
            if alcoca{i}>=15.0 and alcoca{i}<30.0 then alcq{i}=5;
            if alcoca{i}>=30.0                   then alcq{i}=6;
      
        alc=alcq{i};
       %indic3(vbl=alc, prefix=alcc, min=2, max=6, reflev=1, usemiss=0,
                     label1='NON-DRINKERS',      
                     label2='0-4.9 gm ALC/DAY',      
                     label3= '5-9.9 gm ALC/DAY',   
                     label4= '10-14.9 gm ALC/DAY',  
                     label5= '15.0-29.9 gm ALC/DAY',     
                     label6= 'GREATER THAN 30 gm ALC/DAY');
   
   /*** Category of AHEI variables (<median vs. >median) ***/
	
      if aheinoptcav= . then aheinoptcav=41.91077;
      if aheinoptcav<41.91077 then aheinoptd = 0;
      else if aheinoptcav>=41.91077 then aheinoptd = 1;
      else aheinoptd = 0;
     
     /*** aspirin ***/
             asp=aspi{i};
             if asp ne 1 then asp=0;  
             %indic3(vbl=asp, prefix=aspirin, reflev=0, usemiss=0, min=1, max=1);

     /***family history of MI***/
       if famhxmi ne 1 then famhxmi=0;

      
      /****** Indicator for History of antihypertensive user *******/
            select(antihp{i});
                when (1)     antihbp=1;
                  otherwise    antihbp=0;
            end;

      /****** Indicator for History of High Blood Pressure *******/
            select(hbp{i});
                when (1)     htn=1;
                  otherwise    htn=0;
            end;

            if hbp{i}=1 or antihp{i}=1 then highbp=1; else highbp=0;

      /****** Indicator for TC lowering *******/
            select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
            end;

          
      /****** Indicator for History of High TC ******/
            select(chol{i});
                when (1)     hchol=1;
                  otherwise    hchol=0;
            end;
   
      /****** Indicator for History of diabetes *******/
            select(db{i});
                when (1)     diabetes=1;
                  otherwise    diabetes=0;
            end;

      /****** Indicator for multivitamin use *******/
            select(mvit{i});
                when (1)     mlvit=1;
                  otherwise    mlvit=0;
            end;

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxdiab in (0,.)then dtdxdiab=.;
       if dtdxdiab eq 9999 then dtdxdiab=.;

/*Statin*/
      statindi=statin{i};

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

     /****************  BASELINE EXCLUSIONS ********************************************/
      if i=1 then do;

   %exclude(exrec eq 1);                      *multiple records and not in master file;
   %exclude(dbmy09 lt 0);
   %exclude(lastq eq irt{1});                 *only returned baseline qq ;    

        %exclude(cvd86   eq 1);               /* baseline history of CVD*/ 
        %exclude(can86   eq 1);               /*baseline history of cancer*/
        %exclude(db86   eq 1)                 /*baseline history of diabetes*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le irt{i});             /* Death before baseline */
   %exclude(0 lt dtdxdiab le irt{i});          /* Diagnoses diabetes before 1986 */
   %exclude(calor86n lt 800);                 /* caloric intake <800 kcal/d */
   %exclude(calor86n gt 4200);                /* caloric intake >4200 kcal/d */
   %exclude(calor86n eq .);                   /* missing energy intake */
   %exclude(tpotat86d eq .);                  /* missing potato intake */ 
   %exclude(age86    eq .);                   /* missing age at 1991 */
   %output();
  end;

/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/
  else if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                      /*censor lost to follow up*/    
   %exclude(irt{i-1} le dtdth lt irt{i});               /* DEATHS */
   %exclude(irt{i-1} lt dtdxdiab le irt{i});            /* type2 diabetes CASES */
   %output();
  end;


      end;            /* END OF DO-LOOP OVER TIME PERIODs */
      %endex();       /* must do AFTER all exclusions */

/*** Variables kept for analysis ***/

keep id period dtdth agecon agegp bmidi agedi 
     irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16   cutoff
     t02 t04 t06 t08 t10 t12 t14 t16  newicda tdiabcase diabcase dtdxdiab
    dead tdead 

     /*Potato variables*/
     tpotatcav bbmpotcav fpotatcav chipsscav tpotatv bbmpotv fpotatv chipssv tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew 
     tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv

     /*Covariates*/
     prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv soyprov nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv coffeev nutlegv bwricev wtricev SSBv
     prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav soyprocav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav coffeecav nutlegcav bwricecav wtricecav SSBcav 
     whgrnsv rfgrnsv whgrnv rfgrnv whgrnscav rfgrnscav whgrncav rfgrncav 
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
     catrace ethnic hisp14 smkdi
     calorv calorcav alcov alcocav gidv gidcav glv glcav
     white2 &white_ &bmic_ &alcc_ &actc_ asp famhxmi mlvit bmicon actcon &bmic9_
     actcon bmic alc actcc alcocon
     highbp hchol 
     catsmk &catsmkc_ catsmkf /*&catsmkfc_*/ 
     
     /*Stratification variables*/
     age65 bmitr aheinoptd dbfh smktr actbi catrace2 hbp86 

     /*Table 1 variables*/
     tpotat86d bbmpot86d fpotat86d chipss86d prmeat86d urmeat86d trmeat86d poultr86d fishal86d regegg86d hdairy86d ldairy86d soypro86d nutsal86d legume86d fruits86d vegeal86d nstveg86d staveg86d tdairy86d coffee86d nutleg86d bwrice86d wtrice86d SSB86d aheinopt86 ahei86
     db86 chol86 str86 mi86 can86 antihbp antihtc cvd86 whgrns86d rfgrns86d
     age86 bmi86 alco86n calor86n act86 statindi eth3g &strrace_

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

   if nSES = . then nSES = 0.0729500; 
run;

%pctl9(
data=two,
varlist=calorcav calorv alcov alcocav prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv tdairyv nutlegv legumev fruitsv soyprov vegealv nstvegv stavegv bwricev wtricev
        tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav soyprocav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav gidcav SSBcav tdairycav nutlegcav bwricecav wtricecav
        whgrnscav rfgrnscav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
        gidv whgrnsv rfgrnsv nSES,
numquant=5,
mscore=T,
quantname=q,
outdat=four,
indic=T,
cutdat=cuts,
usemiss=0,
pcut=T,
prnt=F);

proc freq data=four;tables white2 catsmk &catsmkc_ &bmic_ &alcc_ &actc_ mlvit dbfh antihbp antihtc hbp86;run;
proc univariate data=four;var bmicon actcon prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav soyprocav nutsalcav legumecav fruitscav vegealcav gidcav trmeat86d whgrns86d rfgrns86d nSES;run;

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
   if ctpotatcav=1 then medctpotatcav=0.1400000;
   if ctpotatcav=2 then medctpotatcav=0.2840000;
   if ctpotatcav=3 then medctpotatcav=0.5500000;
   if ctpotatcav=4 then medctpotatcav=0.8950000;


      if chipsscav=0.000 then cchipsscav=0;                     
      else if 0.000<chipsscav<=0.070 then cchipsscav=1;          
      else if 0.070<chipsscav<=0.143 then cchipsscav=2;         
      else if 0.143<chipsscav<=0.430 then cchipsscav=3;         
      else if 0.430<chipsscav then cchipsscav=4;                 
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);
 
   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0500000;
   if cchipsscav=2 then medcchipsscav=0.1166667;
   if cchipsscav=3 then medcchipsscav=0.2611111;
   if cchipsscav=4 then medcchipsscav=0.6100000;


      if fpotatcav=0.000 then cfpotatcav=0;                     
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;         
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;         
      else if 0.430<fpotatcav then cfpotatcav=4;                
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);
 

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0500000;
   if cfpotatcav=2 then medcfpotatcav=0.1120000;
   if cfpotatcav=3 then medcfpotatcav=0.2500000;
   if cfpotatcav=4 then medcfpotatcav=0.6100000;


      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                        
%indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);
 

   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1400000;
   if cbbmpotcav=2 then medcbbmpotcav=0.3125000;
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
proc means median data=five;var chipsscav;class cchipsscav; run;
proc means median data=five;var fpotatcav;class cfpotatcav; run;
proc means median data=five;var bbmpotcav;class cbbmpotcav; run;
proc freq data=five;tables qSSBv;run; 

%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t02 t04 t06 t08 t10 t12 t14 t16,
         id=id, tvar=period,
         agevar=agecon, qret=irt02 irt04 irt06 irt08 irt10 irt12 irt14 irt16, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,

         model1  = tpotatwv &qcalorv_ white2 &catsmkc_ &alcc_ &actc_ &bmic9_ mlvit dbfh antihbp antihtc hbp86 &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_, 
         model2  = bbmpotwv &qcalorv_ white2 &catsmkc_ &alcc_ &actc_ &bmic9_ mlvit dbfh antihbp antihtc hbp86 &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model3  = fpotatowv &qcalorv_ white2 &catsmkc_ &alcc_ &actc_ &bmic9_ mlvit dbfh antihbp antihtc hbp86 &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_,
         outdat=RR1);