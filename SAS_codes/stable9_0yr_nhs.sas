/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/06/2024
Purpose of the program: 
   S.Table 9. Associations between every 3-serving/week increment in potato intakes and risk of diabetes in the NHS by latency period


%mphreg9(data=five, event=diabcase, time=tdiabcase,  
         timevar=t84 t86   t88   t90   t92   t94   t96   t98   t00   t02   t04   t06  t08 t10 t12 t14 t16 t18,
         id=id, tvar=period,
         agevar=agecon, qret=irt84 irt86 irt88 irt90 irt92 irt94 irt96 irt98 irt00 irt02 irt04 irt06  irt08   irt10 irt12   irt14 irt16 irt18, cutoff=cutoff,
         dtdx=dtdxdiab, dtdth=dtdth,labels=F,

         model1  = tpotatwv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_, 
         model2  = bbmpotwv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cfpotatv_, 
         model3  = fpotatowv &qcalorv_ white2 &smkc_ &alcc_ &catact_ &bmic9_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatv_ &qpoultrv_ &qfishalv_ &qregeggv_ &qtdairyv_ &qnutlegv_ &qfruitsv_ &qvegealv_ &qSSBv_ &qwhgrnsv_ &qrfgrnsv_ &cbbmpotv_,
         outdat=RR1);