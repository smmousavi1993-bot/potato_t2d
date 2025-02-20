/******************************************************************************************************************************************
Program name:
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the NHS, NHS II, and HPFS by latency period



data one;
   set baseline0 end=_end_;

if hbp89 = 1 or hbp91 = 1 then hxhbp=1; else hxhbp = 0;
if chol89 = 1 or chol91 = 1 then hxchol=1; else hxchol = 0;
if db89 = 1 or db91 = 1 then hxdb = 1; else hxdb = 0;
if mi89 = 1 or mi91 = 1 or ang91=1 or str89 = 1 or str91 = 1 or cabg91=1 then hxcvd = 1; else hxcvd = 0;
if can89 = 1 or can91 = 1 then hxcan = 1; else hxcan = 0;
 
array nocum91 {*}  aofib91n ceraf91n alco91n calor91n trnss91n sat91n mon91n poly91n gid91n fol91n prot91n carbo91n carbden91n protden91n transden91n satden91n polyden91n monden91n tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d whgrn91n rfgrn91n whgrns91d rfgrns91d gl91n ahei91 aheinoal91 aheinopt91 aheifisha91 aheidairy91 aheinutbl91 aheipoult91 aheineggs91;  
array nocum95 {*}  aofib95n ceraf95n alco95n calor95n trnss95n sat95n mon95n poly95n gid95n fol95n prot95n carbo95n carbden95n protden95n transden95n satden95n polyden95n monden95n tpotat95d bbmpot95d fpotat95d chipss95d prmeat95d urmeat95d trmeat95d poultr95d fishal95d regegg95d hdairy95d ldairy95d /*soypro95d*/ nutsal95d legume95d fruits95d vegeal95d nstveg95d staveg95d tdairy95d coffee95d nutleg95d bwrice95d wtrice95d SSB95d  whgrn95n rfgrn95n whgrns95d rfgrns95d gl95n ahei95 aheinoal95 aheinopt95 aheifisha95 aheidairy95 aheinutbl95 aheipoult95 aheineggs95;  
array nocum99 {*}  aofib99n ceraf99n alco99n calor99n trn0099n sat99n mon99n poly99n gid99n fol9899n prot99n carbo99n carbden99n protden99n transden99n satden99n polyden99n monden99n tpotat99d bbmpot99d fpotat99d chipss99d prmeat99d urmeat99d trmeat99d poultr99d fishal99d regegg99d hdairy99d ldairy99d /*soypro99d*/ nutsal99d legume99d fruits99d vegeal99d nstveg99d staveg99d tdairy99d coffee99d nutleg99d bwrice99d wtrice99d SSB99d  whgrn99n rfgrn99n whgrns99d rfgrns99d gl99n ahei99 aheinoal99 aheinopt99 aheifisha99 aheidairy99 aheinutbl99 aheipoult99 aheineggs99;  
array nocum03 {*}  aofib03n ceraf03n alco03n calor03n trn0203n sat03n mon03n poly03n gid03n fol9803n prot03n carbo03n carbden03n protden03n transden03n satden03n polyden03n monden03n tpotat03d bbmpot03d fpotat03d chipss03d prmeat03d urmeat03d trmeat03d poultr03d fishal03d regegg03d hdairy03d ldairy03d /*soypro03d*/ nutsal03d legume03d fruits03d vegeal03d nstveg03d staveg03d tdairy03d coffee03d nutleg03d bwrice03d wtrice03d SSB03d whgrn03n rfgrn03n whgrns03d rfgrns03d gl03n ahei03 aheinoal03 aheinopt03 aheifisha03 aheidairy03 aheinutbl03 aheipoult03 aheineggs03;  
array nocum07 {*}  aofib07n ceraf07n alco07n calor07n trn0707n sat07n mon07n poly07n gid07n fol9807n prot07n carbo07n carbden07n protden07n transden07n satden07n polyden07n monden07n tpotat07d bbmpot07d fpotat07d chipss07d prmeat07d urmeat07d trmeat07d poultr07d fishal07d regegg07d hdairy07d ldairy07d /*soypro07d*/ nutsal07d legume07d fruits07d vegeal07d nstveg07d staveg07d tdairy07d coffee07d nutleg07d bwrice07d wtrice07d SSB07d whgrn07n rfgrn07n whgrns07d rfgrns07d gl07n ahei07 aheinoal07 aheinopt07 aheifisha07 aheidairy07 aheinutbl07 aheipoult07 aheineggs07;  
array nocum11 {*}  aofib11n ceraf11n alco11n calor11n trn1111n sat11n mon11n poly11n gid11n fol9811n prot11n carbo11n carbden11n protden11n transden11n satden11n polyden11n monden11n tpotat11d bbmpot11d fpotat11d chipss11d prmeat11d urmeat11d trmeat11d poultr11d fishal11d regegg11d hdairy11d ldairy11d /*soypro11d*/ nutsal11d legume11d fruits11d vegeal11d nstveg11d staveg11d tdairy11d coffee11d nutleg11d bwrice11d wtrice11d SSB11d whgrn11n rfgrn11n whgrns11d rfgrns11d gl11n ahei11 aheinoal11 aheinopt11 aheifisha11 aheidairy11 aheinutbl11 aheipoult11 aheineggs11;
array nocum15 {*}  aofib15n ceraf15n alco15n calor15n trn1115n sat15n mon15n poly15n gid15n fol9815n prot15n carbo15n carbden15n protden15n transden15n satden15n polyden15n monden15n tpotat15d bbmpot15d fpotat15d chipss15d prmeat15d urmeat15d trmeat15d poultr15d fishal15d regegg15d hdairy15d ldairy15d /*soypro15d*/ nutsal15d legume15d fruits15d vegeal15d nstveg15d staveg15d tdairy15d coffee15d nutleg15d bwrice15d wtrice15d SSB15d whgrn15n rfgrn15n whgrns15d rfgrns15d gl15n ahei15 aheinoal15 aheinopt15 aheifisha15 aheidairy15 aheinutbl15 aheipoult15 aheineggs15;
array nocum19 {*}  aofib19n ceraf19n alco19n calor19n trn1119n sat19n mon19n poly19n gid19n fol9819n prot19n carbo19n carbden19n protden19n transden19n satden19n polyden19n monden19n tpotat19d bbmpot19d fpotat19d chipss19d prmeat19d urmeat19d trmeat19d poultr19d fishal19d regegg19d hdairy19d ldairy19d /*soypro19d*/ nutsal19d legume19d fruits19d vegeal19d nstveg19d staveg19d tdairy19d coffee19d nutleg19d bwrice19d wtrice19d SSB19d whgrn19n rfgrn19n whgrns19d rfgrns19d gl19n ahei19 aheinoal19 aheinopt19 aheifisha19 aheidairy19 aheinutbl19 aheipoult19 aheineggs19;

array cumul91 {*}  aofib91ca ceraf91ca alco91ca calor91ca trnss91ca sat91ca mon91ca poly91ca gid91ca fol91ca prot91ca carbo91ca carbden91ca protden91ca transden91ca satden91ca polyden91ca monden91ca tpotat91ca bbmpot91ca fpotat91ca chipss91ca prmeat91ca urmeat91ca trmeat91ca poultr91ca fishal91ca regegg91ca hdairy91ca ldairy91ca /*soypro91ca*/ nutsal91ca legume91ca fruits91ca vegeal91ca nstveg91ca staveg91ca tdairy91ca coffee91ca nutleg91ca bwrice91ca wtrice91ca SSB91ca whgrn91ca rfgrn91ca whgrns91ca rfgrns91ca gl91ca ahei91ca aheinoal91ca aheinopt91ca aheifisha91ca aheidairy91ca aheinutbl91ca aheipoult91ca aheineggs91ca; 
array cumul95 {*}  aofib95ca ceraf95ca alco95ca calor95ca trnss95ca sat95ca mon95ca poly95ca gid95ca fol95ca prot95ca carbo95ca carbden95ca protden95ca transden95ca satden95ca polyden95ca monden95ca tpotat95ca bbmpot95ca fpotat95ca chipss95ca prmeat95ca urmeat95ca trmeat95ca poultr95ca fishal95ca regegg95ca hdairy95ca ldairy95ca /*soypro95ca*/ nutsal95ca legume95ca fruits95ca vegeal95ca nstveg95ca staveg95ca tdairy95ca coffee95ca nutleg95ca bwrice95ca wtrice95ca SSB95ca whgrn95ca rfgrn95ca whgrns95ca rfgrns95ca gl95ca ahei95ca aheinoal95ca aheinopt95ca aheifisha95ca aheidairy95ca aheinutbl95ca aheipoult95ca aheineggs95ca;  
array cumul99 {*}  aofib99ca ceraf99ca alco99ca calor99ca trn0099ca sat99ca mon99ca poly99ca gid99ca fol9899ca prot99ca carbo99ca carbden99ca protden99ca transden99ca satden99ca polyden99ca monden99ca tpotat99ca bbmpot99ca fpotat99ca chipss99ca prmeat99ca urmeat99ca trmeat99ca poultr99ca fishal99ca regegg99ca hdairy99ca ldairy99ca /*soypro99ca*/ nutsal99ca legume99ca fruits99ca vegeal99ca nstveg99ca staveg99ca tdairy99ca coffee99ca nutleg99ca bwrice99ca wtrice99ca SSB99ca whgrn99ca rfgrn99ca whgrns99ca rfgrns99ca gl99ca ahei99ca aheinoal99ca aheinopt99ca aheifisha99ca aheidairy99ca aheinutbl99ca aheipoult99ca aheineggs99ca;   
array cumul03 {*}  aofib03ca ceraf03ca alco03ca calor03ca trn0203ca sat03ca mon03ca poly03ca gid03ca fol9803ca prot03ca carbo03ca carbden03ca protden03ca transden03ca satden03ca polyden03ca monden03ca tpotat03ca bbmpot03ca fpotat03ca chipss03ca prmeat03ca urmeat03ca trmeat03ca poultr03ca fishal03ca regegg03ca hdairy03ca ldairy03ca /*soypro03ca*/ nutsal03ca legume03ca fruits03ca vegeal03ca nstveg03ca staveg03ca tdairy03ca coffee03ca nutleg03ca bwrice03ca wtrice03ca SSB03ca whgrn03ca rfgrn03ca whgrns03ca rfgrns03ca gl03ca ahei03ca aheinoal03ca aheinopt03ca aheifisha03ca aheidairy03ca aheinutbl03ca aheipoult03ca aheineggs03ca;  
array cumul07 {*}  aofib07ca ceraf07ca alco07ca calor07ca trn0707ca sat07ca mon07ca poly07ca gid07ca fol9807ca prot07ca carbo07ca carbden07ca protden07ca transden07ca satden07ca polyden07ca monden07ca tpotat07ca bbmpot07ca fpotat07ca chipss07ca prmeat07ca urmeat07ca trmeat07ca poultr07ca fishal07ca regegg07ca hdairy07ca ldairy07ca /*soypro07ca*/ nutsal07ca legume07ca fruits07ca vegeal07ca nstveg07ca staveg07ca tdairy07ca coffee07ca nutleg07ca bwrice07ca wtrice07ca SSB07ca whgrn07ca rfgrn07ca whgrns07ca rfgrns07ca gl07ca ahei07ca aheinoal07ca aheinopt07ca aheifisha07ca aheidairy07ca aheinutbl07ca aheipoult07ca aheineggs07ca;  
array cumul11 {*}  aofib11ca ceraf11ca alco11ca calor11ca trn1111ca sat11ca mon11ca poly11ca gid11ca fol9811ca prot11ca carbo11ca carbden11ca protden11ca transden11ca satden11ca polyden11ca monden11ca tpotat11ca bbmpot11ca fpotat11ca chipss11ca prmeat11ca urmeat11ca trmeat11ca poultr11ca fishal11ca regegg11ca hdairy11ca ldairy11ca /*soypro11ca*/ nutsal11ca legume11ca fruits11ca vegeal11ca nstveg11ca staveg11ca tdairy11ca coffee11ca nutleg11ca bwrice11ca wtrice11ca SSB11ca whgrn11ca rfgrn11ca whgrns11ca rfgrns11ca gl11ca ahei11ca aheinoal11ca aheinopt11ca aheifisha11ca aheidairy11ca aheinutbl11ca aheipoult11ca aheineggs11ca;
array cumul15 {*}  aofib15ca ceraf15ca alco15ca calor15ca trn1115ca sat15ca mon15ca poly15ca gid15ca fol9815ca prot15ca carbo15ca carbden15ca protden15ca transden15ca satden15ca polyden15ca monden15ca tpotat15ca bbmpot15ca fpotat15ca chipss15ca prmeat15ca urmeat15ca trmeat15ca poultr15ca fishal15ca regegg15ca hdairy15ca ldairy15ca /*soypro15ca*/ nutsal15ca legume15ca fruits15ca vegeal15ca nstveg15ca staveg15ca tdairy15ca coffee15ca nutleg15ca bwrice15ca wtrice15ca SSB15ca whgrn15ca rfgrn15ca whgrns15ca rfgrns15ca gl15ca ahei13ca aheinoal15ca aheinopt15ca aheifisha15ca aheidairy15ca aheinutbl15ca aheipoult15ca aheineggs15ca;
array cumul19 {*}  aofib19ca ceraf19ca alco19ca calor19ca trn1119ca sat19ca mon19ca poly19ca gid19ca fol9819ca prot19ca carbo19ca carbden19ca protden19ca transden19ca satden19ca polyden19ca monden19ca tpotat19ca bbmpot19ca fpotat19ca chipss19ca prmeat19ca urmeat19ca trmeat19ca poultr19ca fishal19ca regegg19ca hdairy19ca ldairy19ca /*soypro19ca*/ nutsal19ca legume19ca fruits19ca vegeal19ca nstveg19ca staveg19ca tdairy19ca coffee19ca nutleg19ca bwrice19ca wtrice19ca SSB19ca whgrn19ca rfgrn19ca whgrns19ca rfgrns19ca gl19ca ahei19ca aheinoal19ca aheinopt19ca aheifisha19ca aheidairy19ca aheinutbl19ca aheipoult19ca aheineggs19ca;


do i = 1 to DIM(nocum91);
        cumul91{i} = nocum91{i};
        cumul95{i} = mean(nocum91{i}, nocum95{i});
        cumul99{i} = mean(nocum91{i}, nocum95{i}, nocum99{i});
        cumul03{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i});
        cumul07{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i});
        cumul11{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i});
        cumul15{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i}, nocum15{i});
        cumul19{i} = mean(nocum91{i}, nocum95{i}, nocum99{i}, nocum03{i}, nocum07{i}, nocum11{i}, nocum15{i}, nocum19{i});

end;

run;

data two;
   set one end=_end_;   

array irt   {14}  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15  retmo17  retmo19  cutoff;
array perioda  {13}  period1  period2  period3  period4  period5  period6  period7  period8  period9  period10  period11  period12  period13;
array tvar  {13}  t95  t97  t99  t01  t03  t05   t07   t09   t11   t13   t15  t17   t19;
array age   {13}  age91     age93    age95    age97    age99    age01   age03    age05     age07     age09    age11  age13  age15;
array aspyn {13}  asp91 asp93 asp95 asp97 asp99 asp01 asp03 asp05 asp07 asp09 asp11 asp13 asp15;
array hbp   {13}  hbp91  hbp93   hbp95   hbp97  hbp99  hbp01 hbp03 hbp05 hbp07 hbp09 hbp11 hbp13 hbp15; 
array chol  {13}  chol91  chol93   chol95   chol97  chol99  chol01  chol03 chol05 chol07 chol09 chol11 chol13 chol15;
array db    {13}  db91  db93   db95   db97  db99  db01  db03 db05 db07 db09 db11 db13 db15;
array nsmk  {13}  smkdr91   smkdr93  smkdr95  smkdr97  smkdr99  smkdr01  smkdr03  smkdr05   smkdr07   smkdr09  smkdr11  smkdr13  smkdr15;
array bmi   {13}  bmi91     bmi93    bmi95    bmi97    bmi99    bmi01  bmi03    bmi05     bmi07     bmi09    bmi11   bmi13  bmi15;
array actm  {13}  act91m act91m act91m act97m act97m act01m act01m act05m act05m act09m act09m act13m act13m;
array horm  {13}  nhor91    nhor93   nhor95   nhor97   nhor99   nhor01  nhor03   nhor05    nhor07    nhor09   nhor11  nhor13  nhor15;
array mvit  {13}  mvitu91    mvitu93   mvitu95   mvitu97   mvitu99   mvitu01  mvitu03   mvitu05    mvitu07    mvitu09   mvitu11  mvitu13  mvitu15;
array antihp   {13}  hbptx89 hbptx93 hbptx95 hbptx97 hbptx99 hbptx01 hbptx03 hbptx05 hbptx07 hbptx09 hbptx11 hbptx13 hbptx15;
array antitc   {13}  hchtx93 hchtx93 hchtx95 hchtx97 hchtx99 hchtx01 hchtx03 hchtx05 hchtx07 hchtx09 hchtx11 hchtx13 hchtx15;

array calorca  {13}  calor91ca calor91ca calor95ca calor95ca calor99ca calor99ca calor03ca calor03ca calor07ca calor07ca calor11ca calor11ca calor15ca;
array aofibca  {13}  aofib91ca aofib91ca aofib95ca aofib95ca aofib99ca aofib99ca aofib03ca aofib03ca aofib07ca aofib07ca aofib11ca aofib11ca aofib15ca;
array cerafca  {13}  ceraf91ca ceraf91ca ceraf95ca ceraf95ca ceraf99ca ceraf99ca ceraf03ca ceraf03ca ceraf07ca ceraf07ca ceraf11ca ceraf11ca ceraf15ca;
array alcoca  {13}  alco91ca alco91ca alco95ca alco95ca alco99ca alco99ca alco03ca alco03ca alco07ca alco07ca alco11ca alco11ca alco15ca;
array satfca  {13}  sat91ca sat91ca sat95ca sat95ca sat99ca sat99ca sat03ca sat03ca sat07ca sat07ca sat11ca sat11ca sat15ca;
array satfdenca  {13}  satden91ca satden91ca satden95ca satden95ca satden99ca satden99ca satden03ca satden03ca satden07ca satden07ca satden11ca satden11ca satden15ca;
array monfca  {13}  mon91ca mon91ca mon95ca mon95ca mon99ca mon99ca mon03ca mon03ca mon07ca mon07ca mon11ca mon11ca mon15ca;
array monfdenca  {13}  monden91ca monden91ca monden95ca monden95ca monden99ca monden99ca monden03ca monden03ca monden07ca monden07ca monden11ca monden11ca monden15ca;
array polyfca  {13}  poly91ca poly91ca poly95ca poly95ca poly99ca poly99ca poly03ca poly03ca poly07ca poly07ca poly11ca poly11ca poly15ca;
array polyfdenca  {13}  polyden91ca polyden91ca polyden95ca polyden95ca polyden99ca polyden99ca polyden03ca polyden03ca polyden07ca polyden07ca polyden11ca polyden11ca polyden15ca;
array transfca  {13}  trnss91ca trnss91ca trnss95ca trnss95ca trn0099ca trn0099ca trn0203ca trn0203ca trn0707ca trn0707ca trn1111ca trn1111ca trn1115ca;
array transfdenca  {13}  transden91ca transden91ca transden95ca transden95ca transden99ca transden99ca transden03ca transden03ca transden07ca transden07ca transden11ca transden11ca transden15ca;
array folca  {13}  fol91ca fol91ca fol95ca fol95ca fol9899ca fol9899ca fol9803ca fol9803ca fol9807ca fol9807ca fol9811ca fol9811ca fol9815ca;
array protca  {13}  prot91ca prot91ca prot95ca prot95ca prot99ca prot99ca prot03ca prot03ca prot07ca prot07ca prot11ca prot11ca prot15ca;
array protdenca  {13}  protden91ca protden91ca protden95ca protden95ca protden99ca protden99ca protden03ca protden03ca protden07ca protden07ca protden11ca protden11ca protden15ca;
array gidca  {13}  gid91ca gid91ca gid95ca gid95ca gid99ca gid99ca gid03ca gid03ca gid07ca gid07ca gid11ca gid11ca gid15ca;
array carboca  {13}  carbo91ca carbo91ca carbo95ca carbo95ca carbo99ca carbo99ca carbo03ca carbo03ca carbo07ca carbo07ca carbo11ca carbo11ca carbo15ca;
array carbdenca  {13}  carbden91ca carbden91ca carbden95ca carbden95ca carbden99ca carbden99ca carbden03ca carbden03ca carbden07ca carbden07ca carbden11ca carbden11ca carbden15ca;

array calor  {13}  calor91n calor91n calor95n calor95n calor99n calor99n calor03n calor03n calor07n calor07n calor11n calor11n calor15n;
array carbo  {13}  carbo91n carbo91n carbo95n carbo95n carbo99n carbo99n carbo03n carbo03n carbo07n carbo07n carbo11n carbo11n carbo15n;
array carbden  {13}  carbden91n carbden91n carbden95n carbden95n carbden99n carbden99n carbden03n carbden03n carbden07n carbden07n carbden11n carbden11n carbden15n;
array prot  {13}  prot91n prot91n prot95n prot95n prot99n prot99n prot03n prot03n prot07n prot07n prot11n prot11n prot15n;
array protden  {13}  protden91n protden91n protden95n protden95n protden99n protden99n protden03n protden03n protden07n protden07n protden11n protden11n protden15n;
array alco  {13}  alco91n alco91n alco95n alco95n alco99n alco99n alco03n alco03n alco07n alco07n alco11n alco11n alco15n;
array ceraf  {13}  ceraf91n ceraf91n ceraf95n ceraf95n ceraf99n ceraf99n ceraf03n ceraf03n ceraf07n ceraf07n ceraf11n ceraf11n ceraf15n;
array aofib  {13}  aofib91n aofib91n aofib95n aofib95n aofib99n aofib99n aofib03n aofib03n aofib07n aofib07n aofib11n aofib11n aofib15n;
array polyf  {13}  poly91n poly91n poly95n poly95n poly99n poly99n poly03n poly03n poly07n poly07n poly11n poly11n poly15n;
array polyfden  {13}  polyden91n polyden91n polyden95n polyden95n polyden99n polyden99n polyden03n polyden03n polyden07n polyden07n polyden11n polyden11n polyden15n;
array transf  {13}  trnss91n trnss91n trnss95n trnss95n trn0099n trn0099n trn0203n trn0203n trn0707n trn0707n trn1111n trn1111n trn1115n;
array transfden  {13}  transden91n transden91n transden95n transden95n transden99n transden99n transden03n transden03n transden07n transden07n transden11n transden11n transden15n;
array satf  {13}  sat91n sat91n sat95n sat95n sat99n sat99n sat03n sat03n sat07n sat07n sat11n sat11n sat15n;
array satfden  {13}  satden91n satden91n satden95n satden95n satden99n satden99n satden03n satden03n satden07n satden07n satden11n satden11n satden15n;
array monf  {13}  mon91n mon91n mon95n mon95n mon99n mon99n mon03n mon03n mon07n mon07n mon11n mon11n mon15n;
array monfden  {13}  monden91n monden91n monden95n monden95n monden99n monden99n monden03n monden03n monden07n monden07n monden11n monden11n monden15n;

array tpotat  {13}  tpotat91d tpotat91d tpotat95d tpotat95d tpotat99d tpotat99d tpotat03d tpotat03d tpotat07d tpotat07d tpotat11d tpotat11d tpotat15d;
array bbmpot  {13}  bbmpot91d bbmpot91d bbmpot95d bbmpot95d bbmpot99d bbmpot99d bbmpot03d bbmpot03d bbmpot07d bbmpot07d bbmpot11d bbmpot11d bbmpot15d;
array fpotat  {13}  fpotat91d fpotat91d fpotat95d fpotat95d fpotat99d fpotat99d fpotat03d fpotat03d fpotat07d fpotat07d fpotat11d fpotat11d fpotat15d;
array chipss  {13}  chipss91d chipss91d chipss95d chipss95d chipss99d chipss99d chipss03d chipss03d chipss07d chipss07d chipss11d chipss11d chipss15d;
array prmeat  {13}  prmeat91d prmeat91d prmeat95d prmeat95d prmeat99d prmeat99d prmeat03d prmeat03d prmeat07d prmeat07d prmeat11d prmeat11d prmeat15d;
array urmeat  {13}  urmeat91d urmeat91d urmeat95d urmeat95d urmeat99d urmeat99d urmeat03d urmeat03d urmeat07d urmeat07d urmeat11d urmeat11d urmeat15d;
array trmeat  {13}  trmeat91d trmeat91d trmeat95d trmeat95d trmeat99d trmeat99d trmeat03d trmeat03d trmeat07d trmeat07d trmeat11d trmeat11d trmeat15d;
array poultr  {13}  poultr91d poultr91d poultr95d poultr95d poultr99d poultr99d poultr03d poultr03d poultr07d poultr07d poultr11d poultr11d poultr15d;
array fishal  {13}  fishal91d fishal91d fishal95d fishal95d fishal99d fishal99d fishal03d fishal03d fishal07d fishal07d fishal11d fishal11d fishal15d;
array regegg  {13}  regegg91d regegg91d regegg95d regegg95d regegg99d regegg99d regegg03d regegg03d regegg07d regegg07d regegg11d regegg11d regegg15d;
array hdairy  {13}  hdairy91d hdairy91d hdairy95d hdairy95d hdairy99d hdairy99d hdairy03d hdairy03d hdairy07d hdairy07d hdairy11d hdairy11d hdairy15d;
array ldairy  {13}  ldairy91d ldairy91d ldairy95d ldairy95d ldairy99d ldairy99d ldairy03d ldairy03d ldairy07d ldairy07d ldairy11d ldairy11d ldairy15d;
array nutsal  {13}  nutsal91d nutsal91d nutsal95d nutsal95d nutsal99d nutsal99d nutsal03d nutsal03d nutsal07d nutsal07d nutsal11d nutsal11d nutsal15d;
array legume  {13}  legume91d legume91d legume95d legume95d legume99d legume99d legume03d legume03d legume07d legume07d legume11d legume11d legume15d;
array fruits  {13}  fruits91d fruits91d fruits95d fruits95d fruits99d fruits99d fruits03d fruits03d fruits07d fruits07d fruits11d fruits11d fruits15d;
array vegeal  {13}  vegeal91d vegeal91d vegeal95d vegeal95d vegeal99d vegeal99d vegeal03d vegeal03d vegeal07d vegeal07d vegeal11d vegeal11d vegeal15d;
array nstveg  {13}  nstveg91d nstveg91d nstveg95d nstveg95d nstveg99d nstveg99d nstveg03d nstveg03d nstveg07d nstveg07d nstveg11d nstveg11d nstveg15d;
array staveg  {13}  staveg91d staveg91d staveg95d staveg95d staveg99d staveg99d staveg03d staveg03d staveg07d staveg07d staveg11d staveg11d staveg15d;
array tdairy  {13}  tdairy91d tdairy91d tdairy95d tdairy95d tdairy99d tdairy99d tdairy03d tdairy03d tdairy07d tdairy07d tdairy11d tdairy11d tdairy15d;
array coffee  {13}  coffee91d coffee91d coffee95d coffee95d coffee99d coffee99d coffee03d coffee03d coffee07d coffee07d coffee11d coffee11d coffee15d;
array nutleg  {13}  nutleg91d nutleg91d nutleg95d nutleg95d nutleg99d nutleg99d nutleg03d nutleg03d nutleg07d nutleg07d nutleg11d nutleg11d nutleg15d;
array bwrice  {13}  bwrice91d bwrice91d bwrice95d bwrice95d bwrice99d bwrice99d bwrice03d bwrice03d bwrice07d bwrice07d bwrice11d bwrice11d bwrice15d;
array wtrice  {13}  wtrice91d wtrice91d wtrice95d wtrice95d wtrice99d wtrice99d wtrice03d wtrice03d wtrice07d wtrice07d wtrice11d wtrice11d wtrice15d;
array SSB     {13}  SSB91d SSB91d SSB95d SSB95d SSB99d SSB99d SSB03d SSB03d SSB07d SSB07d SSB11d SSB11d SSB15d;
array whgrns  {13}  whgrns91d whgrns91d whgrns95d whgrns95d whgrns99d whgrns99d whgrns03d whgrns03d whgrns07d whgrns07d whgrns11d whgrns11d whgrns15d;
array rfgrns  {13}  rfgrns91d rfgrns91d rfgrns95d rfgrns95d rfgrns99d rfgrns99d rfgrns03d rfgrns03d rfgrns07d rfgrns07d rfgrns11d rfgrns11d rfgrns15d;
array whgrn  {13}  whgrn91n whgrn91n whgrn95n whgrn95n whgrn99n whgrn99n whgrn03n whgrn03n whgrn07n whgrn07n whgrn11n whgrn11n whgrn15n;
array rfgrn  {13}  rfgrn91n rfgrn91n rfgrn95n rfgrn95n rfgrn99n rfgrn99n rfgrn03n rfgrn03n rfgrn07n rfgrn07n rfgrn11n rfgrn11n rfgrn15n;
array gl  {13}  gl91n gl91n gl95n gl95n gl99n gl99n gl03n gl03n gl07n gl07n gl11n gl11n gl15n;
array gid  {13}  gid91n gid91n gid95n gid95n gid99n gid99n gid03n gid03n gid07n gid07n gid11n gid11n gid15n;


array tpotatca  {13}  tpotat91ca tpotat91ca tpotat95ca tpotat95ca tpotat99ca tpotat99ca tpotat03ca tpotat03ca tpotat07ca tpotat07ca tpotat11ca tpotat11ca tpotat15ca;
array bbmpotca  {13}  bbmpot91ca bbmpot91ca bbmpot95ca bbmpot95ca bbmpot99ca bbmpot99ca bbmpot03ca bbmpot03ca bbmpot07ca bbmpot07ca bbmpot11ca bbmpot11ca bbmpot15ca;
array fpotatca  {13}  fpotat91ca fpotat91ca fpotat95ca fpotat95ca fpotat99ca fpotat99ca fpotat03ca fpotat03ca fpotat07ca fpotat07ca fpotat11ca fpotat11ca fpotat15ca;
array chipssca  {13}  chipss91ca chipss91ca chipss95ca chipss95ca chipss99ca chipss99ca chipss03ca chipss03ca chipss07ca chipss07ca chipss11ca chipss11ca chipss15ca;
array prmeatca  {13}  prmeat91ca prmeat91ca prmeat95ca prmeat95ca prmeat99ca prmeat99ca prmeat03ca prmeat03ca prmeat07ca prmeat07ca prmeat11ca prmeat11ca prmeat15ca;
array urmeatca  {13}  urmeat91ca urmeat91ca urmeat95ca urmeat95ca urmeat99ca urmeat99ca urmeat03ca urmeat03ca urmeat07ca urmeat07ca urmeat11ca urmeat11ca urmeat15ca;
array trmeatca  {13}  trmeat91ca trmeat91ca trmeat95ca trmeat95ca trmeat99ca trmeat99ca trmeat03ca trmeat03ca trmeat07ca trmeat07ca trmeat11ca trmeat11ca trmeat15ca;
array poultrca  {13}  poultr91ca poultr91ca poultr95ca poultr95ca poultr99ca poultr99ca poultr03ca poultr03ca poultr07ca poultr07ca poultr11ca poultr11ca poultr15ca;
array fishalca  {13}  fishal91ca fishal91ca fishal95ca fishal95ca fishal99ca fishal99ca fishal03ca fishal03ca fishal07ca fishal07ca fishal11ca fishal11ca fishal15ca;
array regeggca  {13}  regegg91ca regegg91ca regegg95ca regegg95ca regegg99ca regegg99ca regegg03ca regegg03ca regegg07ca regegg07ca regegg11ca regegg11ca regegg15ca;
array hdairyca  {13}  hdairy91ca hdairy91ca hdairy95ca hdairy95ca hdairy99ca hdairy99ca hdairy03ca hdairy03ca hdairy07ca hdairy07ca hdairy11ca hdairy11ca hdairy15ca;
array ldairyca  {13}  ldairy91ca ldairy91ca ldairy95ca ldairy95ca ldairy99ca ldairy99ca ldairy03ca ldairy03ca ldairy07ca ldairy07ca ldairy11ca ldairy11ca ldairy15ca;
array nutsalca  {13}  nutsal91ca nutsal91ca nutsal95ca nutsal95ca nutsal99ca nutsal99ca nutsal03ca nutsal03ca nutsal07ca nutsal07ca nutsal11ca nutsal11ca nutsal15ca;
array legumeca  {13}  legume91ca legume91ca legume95ca legume95ca legume99ca legume99ca legume03ca legume03ca legume07ca legume07ca legume11ca legume11ca legume15ca;
array fruitsca  {13}  fruits91ca fruits91ca fruits95ca fruits95ca fruits99ca fruits99ca fruits03ca fruits03ca fruits07ca fruits07ca fruits11ca fruits11ca fruits15ca;
array vegealca  {13}  vegeal91ca vegeal91ca vegeal95ca vegeal95ca vegeal99ca vegeal99ca vegeal03ca vegeal03ca vegeal07ca vegeal07ca vegeal11ca vegeal11ca vegeal15ca;
array nstvegca  {13}  nstveg91ca nstveg91ca nstveg95ca nstveg95ca nstveg99ca nstveg99ca nstveg03ca nstveg03ca nstveg07ca nstveg07ca nstveg11ca nstveg11ca nstveg15ca;
array stavegca  {13}  staveg91ca staveg91ca staveg95ca staveg95ca staveg99ca staveg99ca staveg03ca staveg03ca staveg07ca staveg07ca staveg11ca staveg11ca staveg15ca;
array tdairyca  {13}  tdairy91ca tdairy91ca tdairy95ca tdairy95ca tdairy99ca tdairy99ca tdairy03ca tdairy03ca tdairy07ca tdairy07ca tdairy11ca tdairy11ca tdairy15ca;
array coffeeca  {13}  coffee91ca coffee91ca coffee95ca coffee95ca coffee99ca coffee99ca coffee03ca coffee03ca coffee07ca coffee07ca coffee11ca coffee11ca coffee15ca;
array nutlegca  {13}  nutleg91ca nutleg91ca nutleg95ca nutleg95ca nutleg99ca nutleg99ca nutleg03ca nutleg03ca nutleg07ca nutleg07ca nutleg11ca nutleg11ca nutleg15ca;
array bwriceca  {13}  bwrice91ca bwrice91ca bwrice95ca bwrice95ca bwrice99ca bwrice99ca bwrice03ca bwrice03ca bwrice07ca bwrice07ca bwrice11ca bwrice11ca bwrice15ca;
array wtriceca  {13}  wtrice91ca wtrice91ca wtrice95ca wtrice95ca wtrice99ca wtrice99ca wtrice03ca wtrice03ca wtrice07ca wtrice07ca wtrice11ca wtrice11ca wtrice15ca;
array SSBca     {13}  SSB91ca SSB91ca SSB95ca SSB95ca SSB99ca SSB99ca SSB03ca SSB03ca SSB07ca SSB07ca SSB11ca SSB11ca SSB15ca;
array whgrnsca  {13}  whgrns91ca whgrns91ca whgrns95ca whgrns95ca whgrns99ca whgrns99ca whgrns03ca whgrns03ca whgrns07ca whgrns07ca whgrns11ca whgrns11ca whgrns15ca;
array rfgrnsca  {13}  rfgrns91ca rfgrns91ca rfgrns95ca rfgrns95ca rfgrns99ca rfgrns99ca rfgrns03ca rfgrns03ca rfgrns07ca rfgrns07ca rfgrns11ca rfgrns11ca rfgrns15ca;
array whgrnca  {13}  whgrn91ca whgrn91ca whgrn95ca whgrn95ca whgrn99ca whgrn99ca whgrn03ca whgrn03ca whgrn07ca whgrn07ca whgrn11ca whgrn11ca whgrn15ca;
array rfgrnca  {13}  rfgrn91ca rfgrn91ca rfgrn95ca rfgrn95ca rfgrn99ca rfgrn99ca rfgrn03ca rfgrn03ca rfgrn07ca rfgrn07ca rfgrn11ca rfgrn11ca rfgrn15ca;
array glca  {13}  gl91ca gl91ca gl95ca gl95ca gl99ca gl99ca gl03ca gl03ca gl07ca gl07ca gl11ca gl11ca gl15ca;

array ahei       {13}  ahei91 ahei91 ahei95 ahei95 ahei99 ahei99 ahei03 ahei03 ahei07 ahei07 ahei11 ahei11 ahei15; 
array aheinoal   {13}  aheinoal91 aheinoal91 aheinoal95 aheinoal95 aheinoal99 aheinoal99 aheinoal03 aheinoal03 aheinoal07 aheinoal07 aheinoal11 aheinoal11 aheinoal15; 
array aheinopt   {13}  aheinopt91 aheinopt91 aheinopt95 aheinopt95 aheinopt99 aheinopt99 aheinopt03 aheinopt03 aheinopt07 aheinopt07 aheinopt11 aheinopt11 aheinopt15; 
array aheifisha  {13}  aheifisha91 aheifisha91 aheifisha95 aheifisha95 aheifisha99 aheifisha99 aheifisha03 aheifisha03 aheifisha07 aheifisha07 aheifisha11 aheifisha11 aheifisha15;
array aheidairy  {13}  aheidairy91 aheidairy91 aheidairy95 aheidairy95 aheidairy99 aheidairy99 aheidairy03 aheidairy03 aheidairy07 aheidairy07 aheidairy11 aheidairy11 aheidairy15;
array aheinutbl  {13}  aheinutbl91 aheinutbl91 aheinutbl95 aheinutbl95 aheinutbl99 aheinutbl99 aheinutbl03 aheinutbl03 aheinutbl07 aheinutbl07 aheinutbl11 aheinutbl11 aheinutbl15;
array aheipoult  {13}  aheipoult91 aheipoult91 aheipoult95 aheipoult95 aheipoult99 aheipoult99 aheipoult03 aheipoult03 aheipoult07 aheipoult07 aheipoult11 aheipoult11 aheipoult15;
array aheineggs  {13}  aheineggs91 aheineggs91 aheineggs95 aheineggs95 aheineggs99 aheineggs99 aheineggs03 aheineggs03 aheineggs07 aheineggs07 aheineggs11 aheineggs11 aheineggs15;

array aheica       {13}  ahei91ca ahei91ca ahei95ca ahei95ca ahei99ca ahei99ca ahei03ca ahei03ca ahei07ca ahei07ca ahei11ca ahei11ca ahei15ca; 
array aheinoalca   {13}  aheinoal91ca aheinoal91ca aheinoal95ca aheinoal95ca aheinoal99ca aheinoal99ca aheinoal03ca aheinoal03ca aheinoal07ca aheinoal07ca aheinoal11ca aheinoal11ca aheinoal15ca; 
array aheinoptca   {13}  aheinopt91ca aheinopt91ca aheinopt95ca aheinopt95ca aheinopt99ca aheinopt99ca aheinopt03ca aheinopt03ca aheinopt07ca aheinopt07ca aheinopt11ca aheinopt11ca aheinopt15ca;
array aheifishaca  {13}  aheifisha91ca aheifisha91ca aheifisha95ca aheifisha95ca aheifisha99ca aheifisha99ca aheifisha03ca aheifisha03ca aheifisha07ca aheifisha07ca aheifisha11ca aheifisha11ca aheifisha15ca;
array aheidairyca  {13}  aheidairy91ca aheidairy91ca aheidairy95ca aheidairy95ca aheidairy99ca aheidairy99ca aheidairy03ca aheidairy03ca aheidairy07ca aheidairy07ca aheidairy11ca aheidairy11ca aheidairy15ca;
array aheinutblca  {13}  aheinutbl91ca aheinutbl91ca aheinutbl95ca aheinutbl95ca aheinutbl99ca aheinutbl99ca aheinutbl03ca aheinutbl03ca aheinutbl07ca aheinutbl07ca aheinutbl11ca aheinutbl11ca aheinutbl15ca;
array aheipoultca  {13}  aheipoult91ca aheipoult91ca aheipoult95ca aheipoult95ca aheipoult99ca aheipoult99ca aheipoult03ca aheipoult03ca aheipoult07ca aheipoult07ca aheipoult11ca aheipoult11ca aheipoult15ca;
array aheineggsca  {13}  aheineggs91ca aheineggs91ca aheineggs95ca aheineggs95ca aheineggs99ca aheineggs99ca aheineggs03ca aheineggs03ca aheineggs07ca aheineggs07ca aheineggs11ca aheineggs11ca aheineggs15ca;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {13} alone93 alone93 alone93 alone93 alone93 alone01 alone01 alone05
                  alone05 alone09 alone09 alone13 alone13;
array married {13} mar89 marry93 marry93 marry93 marry93 marry01 marry01 marry05
                    marry05 marry09 marry09 marry13 marry13;

/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {13} mdinc90_91 mdinc90_93 mdinc00_95 mdinc00_97 mdinc00_99 mdinc00_01
        mdinc00_03 mdinc10_05 mdinc10_07 mdinc10_09 mdinc10_11 mdinc10_13 mdinc10_15; 
   array vhs {13} mdvhs90_91 mdvhs90_93 mdvhs00_95 mdvhs00_97 mdvhs00_99 mdvhs00_01
        mdvhs00_03 mdvhs10_05 mdvhs10_07 mdvhs10_09 mdvhs10_11 mdvhs10_13 mdvhs10_15; 
   array pcoll {13} pcolled90_91 pcolled90_93 pcolled00_95 pcolled00_97
          pcolled00_99 pcolled00_01 pcolled00_03 pcolled10_05 pcolled10_07 pcolled10_09
          pcolled10_11 pcolled10_13 pcolled10_15;
   array phs {13} phs90_91 phs90_93 phs00_95 phs00_97 phs00_99 phs00_01 phs00_03 phs10_05
        phs10_07 phs10_09 phs10_11 phs10_13 phs10_15;
   array pnohs {13} pnohs90_91 pnohs90_93 pnohs00_95 pnohs00_97 pnohs00_99 pnohs00_01 pnohs00_03 pnohs10_05
        pnohs10_07 pnohs10_09 pnohs10_11 pnohs10_13 pnohs10_15;
   array pfint {13} pfaminterest90_91 pfaminterest90_93 pfaminterest00_95
          pfaminterest00_97 pfaminterest00_99 pfaminterest00_01 pfaminterest00_03 pfaminterest10_05
          pfaminterest10_07 pfaminterest10_09 pfaminterest10_11 pfaminterest10_13 pfaminterest10_15;
   array sfemale {13} pfwchbf90_91 pfwchbf90_93 pfwchbf00_95 pfwchbf00_97 pfwchbf00_99
            pfwchbf00_01 pfwchbf00_03 pfwchbf10_05 pfwchbf10_07 pfwchbf10_09 pfwchbf10_11 pfwchbf10_13 pfwchbf10_15;
   array pkid {13} pkid90_91 pkid90_93 pkid00_95 pkid00_97 pkid00_99 pkid00_01 pkid00_03 pkid10_05
         pkid10_07 pkid10_09 pkid10_11 pkid10_13 pkid10_15;
   array pold {13} pold90_91 pold90_93 pold00_95 pold00_97 pold00_99 pold00_01 pold00_03 pold10_05
         pold10_07 pold10_09 pold10_11 pold10_13 pold10_15;
   array pohse {13} pohse90_91 pohse90_93 pohse00_95 pohse00_97 pohse00_99 pohse00_01 pohse00_03
          pohse10_05 pohse10_07 pohse10_09 pohse10_11 pohse10_13 pohse10_15;
   array ppov {13} ppov90_91 ppov90_93 ppov00_95 ppov00_97 ppov00_99 ppov00_01 ppov00_03
         ppov10_05 ppov10_07 ppov10_09 ppov10_11 ppov10_13 ppov10_15;
   array pw {13}   pwht90_91 pwht90_93 pwht00_95 pwht00_97 pwht00_99 pwht00_01 pwht00_03
         pwht10_05 pwht10_07 pwht10_09 pwht10_11 pwht10_13 pwht10_15;

   array popd {13} popd90_91 popd90_93 popd00_95 popd00_97 popd00_99 popd00_01 popd00_03
              popd10_05 popd10_07 popd10_09 popd10_11 popd10_13 popd10_15; 
   array div {13} division10_91 division10_93 division10_95 division10_97
        division10_99 division10_01 division10_03 division10_05 division10_07 division10_09
        division10_11 division10_13 division10_15;
   array reg {13} region10_91 region10_93 region10_95 region10_97 region10_99
        region10_01 region10_03 region10_05 region10_07 region10_09 region10_11 region10_13 region10_15;


   do i=1 to 13;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 13;
      if actm{b}=. then actm{b}=actm{b-1};  
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
       if monfdenca{b}=. then monfdenca{b}=monfdenca{b-1};    
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
       if carbo{b}=. then carbo{b}=carbo{b-1};
       if carbden{b}=. then carbden{b}=carbden{b-1};
       if carboca{b}=. then carboca{b}=carboca{b-1};
       if carbdenca{b}=. then carbdenca{b}=carbdenca{b-1};
       if antihp{b}=. then antihp{b}=antihp{b-1};
       if antitc{b}=. then antitc{b}=antitc{b-1};
       if transfca{b}=. then transfca{b}=transfca{b-1};
       if transfdenca{b}=. then transfdenca{b}=transfdenca{b-1};
       if transf{b}=. then transf{b}=transf{b-1};
       if transfden{b}=. then transfden{b}=transfden{b-1};
       if satfca{b}=. then satfca{b}=satfca{b-1};
       if satfdenca{b}=. then satfdenca{b}=satfdenca{b-1};
       if satf{b}=. then satf{b}=satf{b-1};
       if satfden{b}=. then satfden{b}=satfden{b-1};
       if polyfca{b}=. then polyfca{b}=polyfca{b-1};
       if polyfdenca{b}=. then polyfdenca{b}=polyfdenca{b-1};
       if polyf{b}=. then polyf{b}=polyf{b-1};
       if polyfden{b}=. then polyfden{b}=polyfden{b-1};
       if monf{b}=. then monf{b}=monf{b-1};
       if monfden{b}=. then monfden{b}=monfden{b-1};
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
       if ahei{b}=. then ahei{b}=ahei{b-1};
       if aheinoal{b}=. then aheinoal{b}=aheinoal{b-1};
       if aheinopt{b}=. then aheinopt{b}=aheinopt{b-1};
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
       if legumeca{b}=. then legumeca{b}=legumeca{b-1};
       if nutlegca{b}=. then nutlegca{b}=nutlegca{b-1};
       if fruitsca{b}=. then fruitsca{b}=fruitsca{b-1};
       if vegealca{b}=. then vegealca{b}=vegealca{b-1};
       if nstvegca{b}=. then nstvegca{b}=nstvegca{b-1};
       if stavegca{b}=. then stavegca{b}=stavegca{b-1};
       if whgrnsca{b}=. then whgrnsca{b}=whgrnsca{b-1};
       if rfgrnsca{b}=. then rfgrnsca{b}=rfgrnsca{b-1};
       if bwriceca{b}=. then bwriceca{b}=bwriceca{b-1};
       if wtriceca{b}=. then wtriceca{b}=wtriceca{b-1};
       if SSBca{b}=. then SSBca{b}=SSBca{b-1};

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

/*** Set cutoff at 2021.5***/

/*************************************************************************
***** If an irt date is before June of that qq year or after or equal ****
***** to the next qq year it is incorrect and should be defaulted to  ****
***** June of that qq year.    Make time period indicator tvar=0.     ****
*************************************************************************/
 cutoff=1458;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1122+24*i) | irt{i}>=(1146+24*i)) then irt{i}=1122+24*i;
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

diabcase=0;                                                                     /* case definition variable = diabcase */
tdiabcase=irt{i+1}-irt{i};                                                     /* time eq difference between return months */
if diabcase eq 1 then tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
if irt{i} lt dtdxdiab le irt{i+1} then do;
diabcase=1;tdiabcase=min(tdiabcase, dtdxdiab-irt{i});
end;

/******main exposure******/ 
if hxhbp ne 1 then hxhbp=0;
if hxchol ne 1 then hxchol=0;
if hxdb ne 1 then hxdb=0;
if hxcvd ne 1 then hxcvd=0;
if hxcan ne 1 then hxcan=0;
calorcav =  calorca  {i}   ;
calorv =  calor  {i}   ;
gidcav = gidca  {i}   ;
alcov = alco  {i}  ;
alcocav = alcoca  {i}  ;
satfcav = satfca  {i}  ;
monfcav = monfca  {i}  ;
monfdencav = monfdenca  {i}  ;
polyfcav = polyfca  {i}  ;
transfcav = transfca  {i}  ;
folcav = folca  {i}  ;
protv = prot  {i}  ;
protdenv = protden  {i}  ;
protcav = protca  {i}  ;
protdencav = protdenca  {i}  ;
cerafcav = cerafca  {i}  ;
cerafv = ceraf  {i};
aofibcav = aofibca  {i};
aofibv = aofib  {i};
carbov = carbo  {i};
carbdenv = carbden  {i};
carbocav = carboca  {i};
carbdencav = carbdenca  {i};
transfv = transf  {i}  ;
transfdenv = transfden  {i}  ;
transfdencav = transfdenca  {i}  ;
satfv = satf  {i}  ;
satfdenv = satfden  {i}  ;
satfdencav = satfdenca  {i}  ;
polyfv = polyf  {i}  ;
polyfdenv = polyfden  {i}  ;
polyfdencav = polyfdenca  {i}  ;
monfv = monf  {i}  ;
monfdenv = monfden  {i}  ;

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
SSBv =    SSB     {i};
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
SSBcav =    SSBca    {i};
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

   satfdencav5 = satfdencav/0.05;
   monfdencav5 = monfdencav/0.05;
   transfdencav5 = transfdencav/0.05;
   polyfdencav5 = polyfdencav/0.05;
   carbdencav20 = carbdencav/0.2;

   lgsatfdencav = log(satfdencav+0.0001);
   lgsatfdencav5 = log(satfdencav5+0.0001);
   lgsatfdenv = log(satfdenv+0.0001);
   lgcalorcav = log(calorcav+0.0001);
   lgprotdencav = log(protdencav+0.0001);
   lgpolyfdencav = log(polyfdencav+0.0001);
   lgmonfdencav = log(monfdencav+0.0001);
   lgtransfdencav = log(transfdencav+0.0001);  



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
if age{i} =< 0 then age{i}=.;

if age{i}=. then do;
   age{i}=round((irt{i}-birthday)/12);
   end;

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

	if age{i}=>65 then age65=1;            /*dichotomous age*/
        else age65=0;    

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
        else smkever=1; *missing;
        %indic3(vbl=smkever, prefix=smkc, min=2, max=5, reflev=1, missing=9, usemiss=0,
           label1='Never smoke',
           label2='Past smoker',
           label3='Current smoker 1-14 cigs',
           label4='Current smoker 15-24 cigs',
           label5='Current smoker 25+ cigs');
        if smkever in (3,4,5) then catsmkf=1;
        else catsmkf=0;

    
       /*** Indicator for BMI ***/ 
        bmicon=bmi{i};                                 /*continuous BMI*/
         if bmicon = . then bmicon = 25.0600;

         if bmicon < 25 then bmidi = 0;                /*dichotomous BMI*/
         else bmidi = 1;

         if bmicon < 25 then bmitr = 0;
         else if bmicon => 25 and bmicon < 30 then bmitr = 1;
         else bmitr = 2;
         
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
       if actcon = . then actcon = 14.00000;
       if .<actcon<=3      then actcc=1;
       else if 3<actcon<=9       then actcc=2;
       else if 9<actcon<=18      then actcc=3;
       else if 18<actcon<=27     then actcc=4;
       else if 27<actcon<900      then actcc=5;
      else actcc=.;

      if actcon<14.0000 then actbi = 0;
      else if actcon>=14.0000 then actbi = 1;
      else actbi = 0;

       %indic3(vbl=actcc, prefix=catact, min=2, max=5, reflev=1, missing=., usemiss=0);

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
                     label6= 'GREATER THAN 30 gm ALC/DAY')  ;

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

      if aheinoptcav= . then aheinoptcav=39.0070;
      if aheinoptcav<39.0070 then aheinoptd = 0;
      else if aheinoptcav>=39.0070 then aheinoptd = 1;
      else aheinoptd = 0;

     /*** aspirin ***/
            select(aspyn{i});
                when (1)     aspirin=1; 
                  otherwise    aspirin=0;
            end;

     /*** Supplement ***/
            /*select(supp{i});
                when (1)     suppu=1; 
                  otherwise    suppu=0;
            end;*/

      
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

            /*if hbp{i}=1 or antihp{i}=1 then highbp=1; else highbp=0;*/

      /****** Indicator for TC lowering */
            select(antitc{i});
                when (1)     antihtc=1;
                  otherwise    antihtc=0;
            end;

          
      /****** Indicator for History of High TC 
            select(chol{i});
                when (1)     hchol=1;
                  otherwise    hchol=0;
            end;******/
   
      /****** Indicator for History of diabetes *******/
            select(db{i});
                when (1)     diabetes=1;
                  otherwise    diabetes=0;
            end;


      /****** Indicator for History of selfreport heart disease MI & Angina 
            select(repmi{i});
                when (1)     mi=1;
                  otherwise    mi=0;
            end;******/

     /****** Indicator for History of selfreport heart disease MI & Angina 
            select(repcabg{i});
                when (1)     cabg=1;
                  otherwise    cabg=0;
            end;******/


      /****** Indicator for History of selfreport stroke
            select(str{i});
                when (1)     stroke=1;
                  otherwise    stroke=0;   
            end; ******/


      /****** Indicator for History of Cancer 
            select(can{i});
                when (1)     cancer=1;
                  otherwise    cancer=0;
            end;******/

/****** Indicator for History of htrhy 
            /*select(orhy{i});
                when (1)     htrhy=1;
                  otherwise    htrhy=0;
            end;*/

/****** Indicator for History of angina 
            select(ang{i});
                when (1)     angina=1;
                  otherwise    angina=0;
            end;******/

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
      IF dbfh NE 1 THEN dbfh=0;
      IF strfh NE 1 THEN strfh=0;
      IF cafh NE 1 THEN cafh=0;      

       if dtdth in (0,.)then dtdth=.;
       if dtdth eq 9999 then dtdth=.;

       if dtdxmi in (0,.)then dtdxmi=.;
       if dtdxmi eq 9999 then dtdxmi=.;

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

/**********************************************
          Individual SES
***********************************************/   
live_alone=alone{i};
if alone{i} ne 1 then live_alone=0; 
else live_alone=1;

cmarry=married{i};
if cmarry ne 1 then cmarry=0;
else cmarry=1; 
   
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

   %exclude(exrec eq 1);                /*multiple records and not in master file*/
   %exclude(birthday lt 0);
   %exclude(lastq eq irt{1});          /*only returned baseline qq */

        %exclude(hxcvd   eq 1);        /* baseline history of CVD*/    
        %exclude(hxcan   eq 1);        /*baseline history of cancer*/
        %exclude(hxdb   eq 1);         /*baseline history of diabetes*/
        /*%exclude(hxchol   eq 1);*/

   %exclude(dtdth ge 9998);                   /* Missing date of death */
   %exclude(0 lt dtdth le irt{i});          /* Death before baseline */
   %exclude(0 lt dtdxdiab le irt{i});      /* Diagnoses diabetes before 1991 */
   %exclude(calor91n lt 500);               /* caloric intake <500 kcal/d */
   %exclude(calor91n gt 3500);              /* caloric intake >3500 kcal/d */
   %exclude(calor91n eq .);                 /* missing energy intake */
   %exclude(tpotat91d eq .);               /* missing potato intake */
   %exclude(age91    eq .);               /* missing age at 1991 */ 
   %output();
  end;


/************* EXCLUSIONS DURING FOLLOW-UP *****************************************/
  if i> 1 then do;
   %exclude(0 lt lastq le irt{i});                   /*censor lost to follow up*/   
   %exclude(irt{i-1} le dtdth lt irt{i});            /* DEATHS */
   %exclude(irt{i-1} lt dtdxdiab le irt{i});         /* type2 diabetes CASES */
   %output();
   end;

        end;             /* END OF DO-LOOP OVER TIME PERIODs */
        %endex();        /* must do AFTER all exclusions */ 

/*** Variables kept for analysis ***/

keep id period agecon agegp agedi smkdi smkk chol91 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew 
     retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17 retmo19 cutoff
     t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17 t19  dtdth dtdxdiab
     tdead diabcase tdiabcase 
     calorcav calorv gidcav alcov alcocav satfcav monfcav polyfcav transfcav folcav protcav protv protdencav protdenv aofib91n ceraf91n gid91n alco91n sat91n mon91n poly91n trnss91n fol91n prot91n
     white &bmic_ &alcc_ &catact_ &smkc_ &hormone_ aspirin &bmic9_
    actcon bmic alccon
     htn diabetes /*hchol mi stroke cancer*/
     /****add variables for Table 1******/
     db91 chol91 hbp91 str91 hxcvd hxcan antihbp antihtc /*cvd86*/
     age91 bmi91 alco91n calor91n act91m mifh cerafcav aofibcav smkever actcc act91m asp91 mvitu91 hormone aofibv
     
     /*Stratification variables*/
     age65 bmitr hxhbp dbfh smktr catrace2 aheinoptd actbi 

     lgcalorcav hxchol hxdb cerafv bmicon carbov carbdenv carbocav carbdencav mlvit alcconsu &alccsu_ transfv transfdenv transfdencav satfv satfdenv satfdencav polyfv polyfdenv polyfdencav monfv monfdencav monfdenv
     satfdencav5 carbdencav20 lgsatfdencav5 lgcalorcav lgprotdencav lgpolyfdencav lgmonfdencav lgsatfdencav lgsatfdenv lgtransfdencav monfdencav5 transfdencav5 polyfdencav5
     tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d whgrn91n rfgrn91n whgrns91d rfgrns91d aheinopt91 gl91n tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d
     tpotatv bbmpotv fpotatv chipssv prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ nutsalv legumev fruitsv vegealv nstvegv stavegv tdairyv coffeev nutlegv bwricev wtricev SSBv 
     tpotatcav bbmpotcav fpotatcav chipsscav prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav tdairycav coffeecav nutlegcav bwricecav wtricecav SSBcav
     whgrnsv rfgrnsv whgrnv rfgrnv glv gidv whgrnscav rfgrnscav whgrncav rfgrncav glcav race8905 catsmkf
     aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav 
     mrace8905 eth8905 catrace actbi bmidi bmitr 
     tpotatwv fpotatowv chipsswv bbmpotwv whgrnswv rfgrnswv nstvegwv stavegwv legumewv
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

   if nSES = . then nSES = 0.154517;
run;

proc freq data=two;tables mrace8905 eth8905 catrace catrace2 actbi bmidi bmitr smktr &bmic9_;run;

proc univariate data=two;var bmicon actcon agecon calorcav gidcav tpotatcav bbmpotcav fpotatcav chipsscav trmeatcav prmeatcav urmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav bwricecav wtricecav SSBcav coffeecav 
                           gidv tpotatv bbmpotv fpotatv chipssv trmeatv prmeatv urmeatv poultrv fishalv regeggv hdairyv ldairyv nutsalv legumev fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev 
                           tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav nSES;run;
proc freq data=two;tables white &smkc_ &alcc_ &catact_ &hormone_ mlvit age65 actbi aheinoptd bmitr dbfh antihbp antihtc hxhbp catsmkf;run;


%pctl9(
data=two,
varlist= calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv protdencav protdenv aofibv aofibcav cerafv cerafcav transfv transfdenv transfcav transfdencav satfv satfdenv satfcav satfdencav polyfv polyfdenv polyfcav polyfdencav monfcav monfv monfdencav monfdenv
         prmeatv urmeatv trmeatv poultrv fishalv regeggv hdairyv ldairyv /*soyprov*/ prmeatcav urmeatcav trmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav /*soyprocav*/ nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav gidcav whgrns91d rfgrns91d whgrnscav rfgrnscav SSBcav
         tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav gidv fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv nSES, 
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
   if ctpotatcav=1 then medctpotatcav=0.1300000;
   if ctpotatcav=2 then medctpotatcav=0.2800000;
   if ctpotatcav=3 then medctpotatcav=0.5350000;
   if ctpotatcav=4 then medctpotatcav=0.8600000;


      if chipsscav =0.000 then cchipsscav=0;                     /**Almost never**/
      else if 0.000<chipsscav <=0.070 then cchipsscav=1;          /**1-3 serving per month**/
      else if 0.070<chipsscav <=0.143 then cchipsscav=2;         /**1 serving per week**/
      else if 0.143<chipsscav <=0.430 then cchipsscav=3;         /**2-4 serving per week**/
      else if 0.430<chipsscav then cchipsscav=4;                 /** =>5 serving per week**/
%indic3(vbl=cchipsscav, prefix=cchipsscav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipsscav=0 then medcchipsscav=0.0;
   if cchipsscav=1 then medcchipsscav=0.0525000;
   if cchipsscav=2 then medcchipsscav=0.1166667;
   if cchipsscav=3 then medcchipsscav=0.2500000;
   if cchipsscav=4 then medcchipsscav=0.6100000;

      if fpotatcav=0.000 then cfpotatcav=0;                       /**Almost never**/
      else if 0.000<fpotatcav<=0.070 then cfpotatcav=1;          /**1-3 serving per month**/
      else if 0.070<fpotatcav<=0.143 then cfpotatcav=2;          /**1 serving per week**/
      else if 0.143<fpotatcav<=0.430 then cfpotatcav=3;          /**2-4 serving per week**/
      else if 0.430<fpotatcav then cfpotatcav=4;                 /** =>5 serving per week**/
%indic3(vbl=cfpotatcav, prefix=cfpotatcav, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cfpotatcav=0 then medcfpotatcav=0.0;
   if cfpotatcav=1 then medcfpotatcav=0.0525000;
   if cfpotatcav=2 then medcfpotatcav=0.1066667;
   if cfpotatcav=3 then medcfpotatcav=0.2420000;
   if cfpotatcav=4 then medcfpotatcav=0.5740000;

      if 0.000<=bbmpotcav<=0.070 then cbbmpotcav=0;        
      else if 0.070<bbmpotcav<=0.143 then cbbmpotcav=1;       
      else if 0.143<bbmpotcav<=0.430 then cbbmpotcav=2;         
      else if 0.430<bbmpotcav then cbbmpotcav=3;                         
  %indic3(vbl=cbbmpotcav, prefix=cbbmpotcav, reflev=0, min=1, max=3, missing=., usemiss=0);

   if cbbmpotcav=0 then medcbbmpotcav=0.0700000;
   if cbbmpotcav=1 then medcbbmpotcav=0.1260000;
   if cbbmpotcav=2 then medcbbmpotcav=0.2850000;
   if cbbmpotcav=3 then medcbbmpotcav=0.5740000;


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


%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15  t17  t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17 retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,

         model1  = tpotatwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ , 
         model2  = bbmpotwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model3  = fpotatowv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_, 
         outdat=RR1);