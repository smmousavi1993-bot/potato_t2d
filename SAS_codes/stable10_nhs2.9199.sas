 /******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/09/2024
Purpose of the program: 
   S.Table 10. Associations between potato intakes and risk of diabetes in the NHS II from 1991-1999



data one;
   set baseline0 end=_end_;

if hbp89 = 1 or hbp91 = 1 then hxhbp=1; else hxhbp = 0;
if chol89 = 1 or chol91 = 1 then hxchol=1; else hxchol = 0;
if db89 = 1 or db91 = 1 then hxdb = 1; else hxdb = 0;
if mi89 = 1 or mi91 = 1 or ang91=1 or str89 = 1 or str91 = 1 or cabg91=1 then hxcvd = 1; else hxcvd = 0;
if can89 = 1 or can91 = 1 then hxcan = 1; else hxcan = 0;
 
array nocum91 {*}  aofib91n ceraf91n alco91n calor91n trnss91n sat91n mon91n poly91n gid91n fol91n prot91n carbo91n carbden91n protden91n transden91n satden91n polyden91n monden91n tpotat91d bbmpot91d fpotat91d chipss91d prmeat91d urmeat91d trmeat91d poultr91d fishal91d regegg91d hdairy91d ldairy91d /*soypro91d*/ nutsal91d legume91d fruits91d vegeal91d nstveg91d staveg91d tdairy91d coffee91d nutleg91d bwrice91d wtrice91d SSB91d whgrn91n rfgrn91n whgrns91d rfgrns91d gl91n afat91d vfat91d ahei91 aheinoal91 aheinopt91 aheifisha91 aheidairy91 aheinutbl91 aheipoult91 aheineggs91;  
array nocum95 {*}  aofib95n ceraf95n alco95n calor95n trnss95n sat95n mon95n poly95n gid95n fol95n prot95n carbo95n carbden95n protden95n transden95n satden95n polyden95n monden95n tpotat95d bbmpot95d fpotat95d chipss95d prmeat95d urmeat95d trmeat95d poultr95d fishal95d regegg95d hdairy95d ldairy95d /*soypro95d*/ nutsal95d legume95d fruits95d vegeal95d nstveg95d staveg95d tdairy95d coffee95d nutleg95d bwrice95d wtrice95d SSB95d  whgrn95n rfgrn95n whgrns95d rfgrns95d gl95n afat95d vfat95d ahei95 aheinoal95 aheinopt95 aheifisha95 aheidairy95 aheinutbl95 aheipoult95 aheineggs95;  
array nocum99 {*}  aofib99n ceraf99n alco99n calor99n trn0099n sat99n mon99n poly99n gid99n fol9899n prot99n carbo99n carbden99n protden99n transden99n satden99n polyden99n monden99n tpotat99d bbmpot99d fpotat99d chipss99d prmeat99d urmeat99d trmeat99d poultr99d fishal99d regegg99d hdairy99d ldairy99d /*soypro99d*/ nutsal99d legume99d fruits99d vegeal99d nstveg99d staveg99d tdairy99d coffee99d nutleg99d bwrice99d wtrice99d SSB99d  whgrn99n rfgrn99n whgrns99d rfgrns99d gl99n afat99d vfat99d ahei99 aheinoal99 aheinopt99 aheifisha99 aheidairy99 aheinutbl99 aheipoult99 aheineggs99;  

array cumul91 {*}  aofib91ca ceraf91ca alco91ca calor91ca trnss91ca sat91ca mon91ca poly91ca gid91ca fol91ca prot91ca carbo91ca carbden91ca protden91ca transden91ca satden91ca polyden91ca monden91ca tpotat91ca bbmpot91ca fpotat91ca chipss91ca prmeat91ca urmeat91ca trmeat91ca poultr91ca fishal91ca regegg91ca hdairy91ca ldairy91ca /*soypro91ca*/ nutsal91ca legume91ca fruits91ca vegeal91ca nstveg91ca staveg91ca tdairy91ca coffee91ca nutleg91ca bwrice91ca wtrice91ca SSB91ca whgrn91ca rfgrn91ca whgrns91ca rfgrns91ca gl91ca afat91ca vfat91ca ahei91ca aheinoal91ca aheinopt91ca aheifisha91ca aheidairy91ca aheinutbl91ca aheipoult91ca aheineggs91ca; 
array cumul95 {*}  aofib95ca ceraf95ca alco95ca calor95ca trnss95ca sat95ca mon95ca poly95ca gid95ca fol95ca prot95ca carbo95ca carbden95ca protden95ca transden95ca satden95ca polyden95ca monden95ca tpotat95ca bbmpot95ca fpotat95ca chipss95ca prmeat95ca urmeat95ca trmeat95ca poultr95ca fishal95ca regegg95ca hdairy95ca ldairy95ca /*soypro95ca*/ nutsal95ca legume95ca fruits95ca vegeal95ca nstveg95ca staveg95ca tdairy95ca coffee95ca nutleg95ca bwrice95ca wtrice95ca SSB95ca whgrn95ca rfgrn95ca whgrns95ca rfgrns95ca gl95ca afat95ca vfat95ca ahei95ca aheinoal95ca aheinopt95ca aheifisha95ca aheidairy95ca aheinutbl95ca aheipoult95ca aheineggs95ca;  
array cumul99 {*}  aofib99ca ceraf99ca alco99ca calor99ca trn0099ca sat99ca mon99ca poly99ca gid99ca fol9899ca prot99ca carbo99ca carbden99ca protden99ca transden99ca satden99ca polyden99ca monden99ca tpotat99ca bbmpot99ca fpotat99ca chipss99ca prmeat99ca urmeat99ca trmeat99ca poultr99ca fishal99ca regegg99ca hdairy99ca ldairy99ca /*soypro99ca*/ nutsal99ca legume99ca fruits99ca vegeal99ca nstveg99ca staveg99ca tdairy99ca coffee99ca nutleg99ca bwrice99ca wtrice99ca SSB99ca whgrn99ca rfgrn99ca whgrns99ca rfgrns99ca gl99ca afat99ca vfat99ca ahei99ca aheinoal99ca aheinopt99ca aheifisha99ca aheidairy99ca aheinutbl99ca aheipoult99ca aheineggs99ca;   


do i = 1 to DIM(cumul99);
        cumul91{i} = nocum91{i};
        cumul95{i} = mean(nocum91{i}, nocum95{i});
        cumul99{i} = mean(nocum91{i}, nocum95{i}, nocum99{i});
end;

run;

data two;
   set one end=_end_;   

array irt   {5}  retmo91   retmo93  retmo95  retmo97 cutoff;
array perioda  {4}  period1  period2  period3  period4;
array tvar  {4}  t91  t93  t95  t97;
array age   {4}  age91     age93    age95    age97;
array aspyn {4}  asp91 asp93 asp95 asp97;
array hbp   {4}  hbp91  hbp93   hbp95   hbp97  ; 
array chol  {4}  chol91  chol93   chol95   chol97  ;
array db    {4}  db91  db93   db95   db97 ;
array nsmk  {4}  smkdr91   smkdr93  smkdr95  smkdr97 ;
array bmi   {4}  bmi91     bmi93    bmi95    bmi97;
array actm  {4}  act91m act91m act91m act97m ;
array horm  {4}  nhor91    nhor93   nhor95   nhor97;
array mvit  {4}  mvitu91    mvitu93   mvitu95   mvitu97;
array antihp   {4}  hbptx89 hbptx93 hbptx95 hbptx97;
array antitc   {4}  hchtx93 hchtx93 hchtx95 hchtx97;

array calorca  {4}  calor91ca calor91ca calor95ca calor95ca;
array aofibca  {4}  aofib91ca aofib91ca aofib95ca aofib95ca;
array cerafca  {4}  ceraf91ca ceraf91ca ceraf95ca ceraf95ca ;
array alcoca  {4}  alco91ca alco91ca alco95ca alco95ca ;
array satfca  {4}  sat91ca sat91ca sat95ca sat95ca ;
array satfdenca  {4}  satden91ca satden91ca satden95ca satden95ca;
array monfca  {4}  mon91ca mon91ca mon95ca mon95ca;
array monfdenca  {4}  monden91ca monden91ca monden95ca monden95ca;
array polyfca  {4}  poly91ca poly91ca poly95ca poly95ca;
array polyfdenca  {4}  polyden91ca polyden91ca polyden95ca polyden95ca;
array transfca  {4}  trnss91ca trnss91ca trnss95ca trnss95ca ;
array transfdenca  {4}  transden91ca transden91ca transden95ca transden95ca;
array folca  {4}  fol91ca fol91ca fol95ca fol95ca;
array protca  {4}  prot91ca prot91ca prot95ca prot95ca;
array protdenca  {4}  protden91ca protden91ca protden95ca protden95ca;
array gidca  {4}  gid91ca gid91ca gid95ca gid95ca;
array carboca  {4}  carbo91ca carbo91ca carbo95ca carbo95ca;
array carbdenca  {4}  carbden91ca carbden91ca carbden95ca carbden95ca;

array calor  {4}  calor91n calor91n calor95n calor95n;
array carbo  {4}  carbo91n carbo91n carbo95n carbo95n;
array carbden  {4}  carbden91n carbden91n carbden95n carbden95n;
array prot  {4}  prot91n prot91n prot95n prot95n;
array protden  {4}  protden91n protden91n protden95n protden95n;
array alco  {4}  alco91n alco91n alco95n alco95n;
array ceraf  {4}  ceraf91n ceraf91n ceraf95n ceraf95n;
array aofib  {4}  aofib91n aofib91n aofib95n aofib95n;
array polyf  {4}  poly91n poly91n poly95n poly95n;
array polyfden  {4}  polyden91n polyden91n polyden95n polyden95n;
array transf  {4}  trnss91n trnss91n trnss95n trnss95n ;
array transfden  {4}  transden91n transden91n transden95n transden95n;
array satf  {4}  sat91n sat91n sat95n sat95n;
array satfden  {4}  satden91n satden91n satden95n satden95n;
array monf  {4}  mon91n mon91n mon95n mon95n;
array monfden  {4}  monden91n monden91n monden95n monden95 ;

array tpotat  {4}  tpotat91d tpotat91d tpotat95d tpotat95d ;
array bbmpot  {4}  bbmpot91d bbmpot91d bbmpot95d bbmpot95d ;
array fpotat  {4}  fpotat91d fpotat91d fpotat95d fpotat95d ;
array chipss  {4}  chipss91d chipss91d chipss95d chipss95d ;
array prmeat  {4}  prmeat91d prmeat91d prmeat95d prmeat95d ;
array urmeat  {4}  urmeat91d urmeat91d urmeat95d urmeat95d ;
array trmeat  {4}  trmeat91d trmeat91d trmeat95d trmeat95d ;
array poultr  {4}  poultr91d poultr91d poultr95d poultr95d ;
array fishal  {4}  fishal91d fishal91d fishal95d fishal95d ;
array regegg  {4}  regegg91d regegg91d regegg95d regegg95d ;
array hdairy  {4}  hdairy91d hdairy91d hdairy95d hdairy95d ;
array ldairy  {4}  ldairy91d ldairy91d ldairy95d ldairy95d ;
array nutsal  {4}  nutsal91d nutsal91d nutsal95d nutsal95d ;
array legume  {4}  legume91d legume91d legume95d legume95d ;
array fruits  {4}  fruits91d fruits91d fruits95d fruits95d ;
array vegeal  {4}  vegeal91d vegeal91d vegeal95d vegeal95d ;
array nstveg  {4}  nstveg91d nstveg91d nstveg95d nstveg95d ;
array staveg  {4}  staveg91d staveg91d staveg95d staveg95d ;
array tdairy  {4}  tdairy91d tdairy91d tdairy95d tdairy95d ;
array coffee  {4}  coffee91d coffee91d coffee95d coffee95d ;
array nutleg  {4}  nutleg91d nutleg91d nutleg95d nutleg95d ;
array bwrice  {4}  bwrice91d bwrice91d bwrice95d bwrice95d ;
array wtrice  {4}  wtrice91d wtrice91d wtrice95d wtrice95d ;
array SSB     {4}  SSB91d SSB91d SSB95d SSB95d;
array whgrns  {4}  whgrns91d whgrns91d whgrns95d whgrns95d;
array rfgrns  {4}  rfgrns91d rfgrns91d rfgrns95d rfgrns95d ;
array whgrn  {4}  whgrn91n whgrn91n whgrn95n whgrn95n ;
array rfgrn  {4}  rfgrn91n rfgrn91n rfgrn95n rfgrn95n ;
array gl  {4}  gl91n gl91n gl95n gl95n;
array gid  {4}  gid91n gid91n gid95n gid95n ;
array afat   {4}  afat91d afat91d afat95d afat95d ;
array vfat   {4}  vfat91d vfat91d vfat95d vfat95d ;


array tpotatca  {4}  tpotat91ca tpotat91ca tpotat95ca tpotat95ca ;
array bbmpotca  {4}  bbmpot91ca bbmpot91ca bbmpot95ca bbmpot95ca ;
array fpotatca  {4}  fpotat91ca fpotat91ca fpotat95ca fpotat95ca ;
array chipssca  {4}  chipss91ca chipss91ca chipss95ca chipss95ca ;
array prmeatca  {4}  prmeat91ca prmeat91ca prmeat95ca prmeat95ca ;
array urmeatca  {4}  urmeat91ca urmeat91ca urmeat95ca urmeat95ca ;
array trmeatca  {4}  trmeat91ca trmeat91ca trmeat95ca trmeat95ca ;
array poultrca  {4}  poultr91ca poultr91ca poultr95ca poultr95ca ;
array fishalca  {4}  fishal91ca fishal91ca fishal95ca fishal95ca ;
array regeggca  {4}  regegg91ca regegg91ca regegg95ca regegg95ca ;
array hdairyca  {4}  hdairy91ca hdairy91ca hdairy95ca hdairy95ca ;
array ldairyca  {4}  ldairy91ca ldairy91ca ldairy95ca ldairy95ca ;
array nutsalca  {4}  nutsal91ca nutsal91ca nutsal95ca nutsal95ca ;
array legumeca  {4}  legume91ca legume91ca legume95ca legume95ca ;
array fruitsca  {4}  fruits91ca fruits91ca fruits95ca fruits95ca ;
array vegealca  {4}  vegeal91ca vegeal91ca vegeal95ca vegeal95ca ;
array nstvegca  {4}  nstveg91ca nstveg91ca nstveg95ca nstveg95ca ;
array stavegca  {4}  staveg91ca staveg91ca staveg95ca staveg95ca ;
array tdairyca  {4}  tdairy91ca tdairy91ca tdairy95ca tdairy95ca ;
array coffeeca  {4}  coffee91ca coffee91ca coffee95ca coffee95ca ;
array nutlegca  {4}  nutleg91ca nutleg91ca nutleg95ca nutleg95ca ;
array bwriceca  {4}  bwrice91ca bwrice91ca bwrice95ca bwrice95ca ;
array wtriceca  {4}  wtrice91ca wtrice91ca wtrice95ca wtrice95ca ;
array SSBca     {4}  SSB91ca SSB91ca SSB95ca SSB95ca ;
array whgrnsca  {4}  whgrns91ca whgrns91ca whgrns95ca whgrns95ca;
array rfgrnsca  {4}  rfgrns91ca rfgrns91ca rfgrns95ca rfgrns95ca ;
array whgrnca  {4}  whgrn91ca whgrn91ca whgrn95ca whgrn95ca ;
array rfgrnca  {4}  rfgrn91ca rfgrn91ca rfgrn95ca rfgrn95ca ;
array glca  {4}  gl91ca gl91ca gl95ca gl95ca ;
array afatca   {4}  afat91ca afat91ca afat95ca afat95ca ;
array vfatca   {4}  vfat91ca vfat91ca vfat95ca vfat95ca ;

array ahei       {4}  ahei91 ahei91 ahei95 ahei95 ; 
array aheinoal   {4}  aheinoal91 aheinoal91 aheinoal95 aheinoal95 ; 
array aheinopt   {4}  aheinopt91 aheinopt91 aheinopt95 aheinopt95 ; 
array aheifisha  {4}  aheifisha91 aheifisha91 aheifisha95 aheifisha95 ;
array aheidairy  {4}  aheidairy91 aheidairy91 aheidairy95 aheidairy95 ;
array aheinutbl  {4}  aheinutbl91 aheinutbl91 aheinutbl95 aheinutbl95 ;
array aheipoult  {4}  aheipoult91 aheipoult91 aheipoult95 aheipoult95 ;
array aheineggs  {4}  aheineggs91 aheineggs91 aheineggs95 aheineggs95 ;

array aheica       {4}  ahei91ca ahei91ca ahei95ca ahei95ca; 
array aheinoalca   {4}  aheinoal91ca aheinoal91ca aheinoal95ca aheinoal95ca; 
array aheinoptca   {4}  aheinopt91ca aheinopt91ca aheinopt95ca aheinopt95ca ;
array aheifishaca  {4}  aheifisha91ca aheifisha91ca aheifisha95ca aheifisha95ca ;
array aheidairyca  {4}  aheidairy91ca aheidairy91ca aheidairy95ca aheidairy95ca ;
array aheinutblca  {4}  aheinutbl91ca aheinutbl91ca aheinutbl95ca aheinutbl95ca ;
array aheipoultca  {4}  aheipoult91ca aheipoult91ca aheipoult95ca aheipoult95ca ;
array aheineggsca  {4}  aheineggs91ca aheineggs91ca aheineggs95ca aheineggs95ca ;

/*****************************************************************************;
* Individual SES data /
*****************************************************************************/
array alone {4} alone93 alone93 alone93 alone93;
array married {4} mar89 marry93 marry93 marry9;



/*****************************************************************************;
* Neighborhood SES data - use closest Census for each address year           /
* Alternative would be to use a single Census year for all address years    /
*****************************************************************************/

   array inc {4} mdinc90_91 mdinc90_93 mdinc00_95 mdinc00_97; 
   array vhs {4} mdvhs90_91 mdvhs90_93 mdvhs00_95 mdvhs00_97; 
   array pcoll {4} pcolled90_91 pcolled90_93 pcolled00_95 pcolled00_97;
   array phs {4} phs90_91 phs90_93 phs00_95 phs00_97;
   array pnohs {4} pnohs90_91 pnohs90_93 pnohs00_95 pnohs00_97;
   array pfint {4} pfaminterest90_91 pfaminterest90_93 pfaminterest00_95
          pfaminterest00_97;
   array sfemale {4} pfwchbf90_91 pfwchbf90_93 pfwchbf00_95 pfwchbf00_97;
   array pkid {4} pkid90_91 pkid90_93 pkid00_95 pkid00_97;
   array pold {4} pold90_91 pold90_93 pold00_95 pold00_97;
   array pohse {4} pohse90_91 pohse90_93 pohse00_95 pohse00_97;
   array ppov {4} ppov90_91 ppov90_93 ppov00_95 ppov00_97;
   array pw {4}   pwht90_91 pwht90_93 pwht00_95 pwht00_97 ;

   array popd {4} popd90_91 popd90_93 popd00_95 popd00_97; 
   array div {4} division10_91 division10_93 division10_95 division10_97;
   array reg {4} region10_91 region10_93 region10_95 region10_97;


   do i=1 to 4;
      if actm{i}>900 then actm{i}=.;
   end;

/****** missing replace ******/
    do b=2 to 4;
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
       if afat{b}=. then afat{b}=afat{b-1};
       if vfat{b}=. then vfat{b}=vfat{b-1};
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
       if afatca{b}=. then afatca{b}=afatca{b-1};
       if vfatca{b}=. then vfatca{b}=vfatca{b-1};

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
 cutoff=1194;    
   do i=1 to DIM(irt)-1;
      if (irt{i}<(1074+24*i) | irt{i}>=(1098+24*i)) then irt{i}=1074+24*i;
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

/****** Define symptomatic T2D case sin the ith time period ******/

	dbsymp=0; 
        tdbsymp=irt{i+1}-irt{i};
        if dbsymp eq 1 then tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
        if irt{i} lt dtdxdiab le irt{i+1} and symp=1 then do;
        dbsymp=1;
        tdbsymp=min(tdbsymp, dtdxdiab-irt{i});
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
afatv = afat  {i};
vfatv = vfat  {i};

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
afatcav = afatca  {i};
vfatcav = vfatca  {i};

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
bwricew = bwricecav*7/3;
wtricew = wtricecav*7/3; 
afatw =  afatcav*7/3; 
vfatw =  vfatcav*7/3; 

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

      if aheinoptcav= . then aheinoptcav=39.0435;
      if aheinoptcav<39.0435 then aheinoptd = 0;
      else if aheinoptcav>=39.0435 then aheinoptd = 1;
      
     /*** aspirin ***/
            select(aspyn{i});
                when (1)     aspirin=1; 
                  otherwise    aspirin=0;
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
   %exclude(0 lt dtdth le retmo91);          /* Death before baseline */
   %exclude(0 lt dtdxdiab le retmo91);      /* Diagnoses diabetes before 1991 */
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

keep id period agecon agegp agedi smkdi smkk chol91 tpotatw fpotatow chipssw bbmpotw whgrnsw rfgrnsw nstvegw stavegw legumew bwricew wtricew afatw vfatw
     retmo91   retmo93  retmo95  retmo97 cutoff
     t91  t93  t95  t97  dtdth dtdxdiab
     tdead diabcase tdiabcase dbsymp tdbsymp
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

   if nSES = . then nSES = 0.1349313;
run;

proc freq data=two;tables mrace8905 eth8905 catrace catrace2 actbi bmidi bmitr smktr &bmic9_;run;

proc univariate data=two;var agecon bmicon actcon agecon calorcav gidcav tpotatcav bbmpotcav fpotatcav chipsscav trmeatcav prmeatcav urmeatcav poultrcav fishalcav regeggcav hdairycav ldairycav nutsalcav legumecav fruitscav vegealcav nstvegcav stavegcav whgrnscav rfgrnscav bwricecav wtricecav SSBcav coffeecav 
                           gidv tpotatv bbmpotv fpotatv chipssv trmeatv prmeatv urmeatv poultrv fishalv regeggv hdairyv ldairyv nutsalv legumev fruitsv vegealv nstvegv stavegv whgrnsv rfgrnsv bwricev wtricev SSBv coffeev calorcav calorv carbov carbdenv carbocav carbdencav alcov alcocav protcav protv
                           tdairyv nutlegv tdairycav nutlegcav aheiv aheinoalv aheinoptv aheifishav aheidairyv aheinutblv aheipoultv aheineggsv aheicav aheinoalcav aheinoptcav aheifishacav aheidairycav aheinutblcav aheipoultcav aheineggscav nSES;run;
proc freq data=two;tables white &smkc_ &alcc_ &catact_ &hormone_ mlvit age65 actbi aheinoptd bmitr dbfh antihbp antihtc hxhbp diabcase dbsymp catsmkf;run;


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

   if ctpotatv=0 then medctpotatv=0.00;
   if ctpotatv=1 then medctpotatv=0.1400000;
   if ctpotatv=2 then medctpotatv=0.2100000;
   if ctpotatv=3 then medctpotatv=0.5000000;
   if ctpotatv=4 then medctpotatv=0.8600000;

      if fpotatv=0.000 then cfpotatv=0;                       
      else if 0.000<fpotatv<=0.070 then cfpotatv=1;          
      else if 0.070<fpotatv<=0.143 then cfpotatv=2;         
      else if 0.143<fpotatv<=0.430 then cfpotatv=3;         
      else if 0.430<fpotatv then cfpotatv=4;                 
%indic3(vbl=cfpotatv, prefix=cfpotatv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cfpotatv=0 then medcfpotatv=0.0;
   if cfpotatv=1 then medcfpotatv=0.0700000;
   if cfpotatv=2 then medcfpotatv=0.1400000;
   if cfpotatv=3 then medcfpotatv=0.4300000;
   if cfpotatv=4 then medcfpotatv=0.7900000;

      if chipssv =0.000 then cchipssv=0;                     
      else if 0.000<chipssv <=0.070 then cchipssv=1;          
      else if 0.070<chipssv <=0.143 then cchipssv=2;         
      else if 0.143<chipssv <=0.430 then cchipssv=3;         
      else if 0.430<chipssv then cchipssv=4;                 
%indic3(vbl=cchipssv, prefix=cchipssv, reflev=0, min=1, max=4, missing=., usemiss=0);

   if cchipssv=0 then medcchipssv=0.0;
   if cchipssv=1 then medcchipssv=0.0700000;
   if cchipssv=2 then medcchipssv=0.1400000;
   if cchipssv=3 then medcchipssv=0.4300000;
   if cchipssv=4 then medcchipssv=0.7900000;


      if 0.000<=bbmpotv<=0.070 then cbbmpotv=0;        
      else if 0.070<bbmpotv<=0.143 then cbbmpotv=1;       
      else if 0.143<bbmpotv<=0.430 then cbbmpotv=2;         
      else if 0.430<bbmpotv then cbbmpotv=3;                         
  %indic3(vbl=cbbmpotv, prefix=cbbmpotv, reflev=0, min=1, max=3, missing=., usemiss=0);

   if cbbmpotv=0 then medcbbmpotv=0.0;
   if cbbmpotv=1 then medcbbmpotv=0.1400000;
   if cbbmpotv=2 then medcbbmpotv=0.4300000;
   if cbbmpotv=3 then medcbbmpotv=0.7900000;

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
proc freq data=five;tables ctpotatcav cfpotatcav cchipsscav cbbmpotcav;run;


/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=retmo91   retmo93  retmo95  retmo97,
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
         timevar=t91  t93  t95  t97,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &ctpotatcav_ &qcalorcav_ , 
         model2  = medctpotatcav &qcalorcav_,
         model3  = &ctpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medctpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &ctpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model6  = medctpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = &cchipsscav_ &qcalorcav_ , 
         model8  = medcchipsscav &qcalorcav_,
         model9  = &cchipsscav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model10  = medcchipsscav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model11  = &cchipsscav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_, 
         model12  = medcchipsscav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model13  = &cfpotatcav_ &qcalorcav_ , 
         model14  = medcfpotatcav &qcalorcav_,
         model15  = &cfpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model16  = medcfpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model17  = &cfpotatcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_, 
         model18  = medcfpotatcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
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

ods rtf file="stable10_nhs2.9199.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 RR4 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;

/*Person-time*/
%pre_pm(
 data=five,
 out=outpm,
 timevar=period,
 irt=retmo91   retmo93  retmo95  retmo97,
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
         timevar=t91  t93  t95  t97 ,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = &cbbmpotcav_ &qcalorcav_ , 
         model2  = medcbbmpotcav &qcalorcav_,
         model3  = &cbbmpotcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_, 
         model4  = medcbbmpotcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model5  = &cbbmpotcav_ &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_, 
         model6  = medcbbmpotcav &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable10_nhs2.bbm.9199.rtf";  
proc print data=scr noobs;
   var  va model RR1 RR2 RR3 ProbChisq;   
   run;
 
proc print data=all noobs;
   var  variable model beta see ProbChisq;
   run;
ods rtf close;


/*Per serving*/
%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t91  t93  t95  t97 ,
         id=id, tvar=period, modopt=%quote(maxiter=30),
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,
         model1  = tpotatw &qcalorcav_, 
         model2  = tpotatw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model3  = tpotatw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model4  = chipssw &qcalorcav_ , 
         model5  = chipssw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model6  = chipssw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_,

         model7  = fpotatow &qcalorcav_ , 
         model8  = fpotatow &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model9  = fpotatow &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_,
         
         model10  = bbmpotw &qcalorcav_ , 
         model11  = bbmpotw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_,
         model12  = bbmpotw &qcalorcav_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_,
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

ods rtf file="stable10_nhs2.9199.pserv.rtf";  
proc print data=scr_psd noobs;
   var  va model RR ProbChisq;   
run;

proc print data=all noobs;
   var  variable model beta see ProbChisq;
run;
ods rtf close;