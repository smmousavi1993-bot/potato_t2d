/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/07/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the NHS II by latency period


%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t91  t93  t95  t97  t99  t01  t03 t05   t07   t09   t11   t13   t15 t17  t19,
         id=id, tvar=period,
         agevar=agecon, qret= retmo91   retmo93  retmo95  retmo97  retmo99  retmo01  retmo03  retmo05   retmo07   retmo09  retmo11  retmo13  retmo15 retmo17 retmo19, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,

         model1  = tpotatwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ , 
         model2  = bbmpotwv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model3  = fpotatowv &qcalorv_ white &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_, 
         outdat=RR1);