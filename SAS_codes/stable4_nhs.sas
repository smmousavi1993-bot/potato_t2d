/******************************************************************************************************************************************
Program name: 
Name of programmer(s): Seyed Mohammad Mousavi
Dates: 05/06/2024
Purpose of the program: 
   S.Table 4. Percentage of the association between potato intakes and risk of diabetes that is statistically accounted for by BMI


%include ****

%mediate(data=five, 
		 exposure=tpotatw, 
		 intermed=&bmic9_, 
		 id=id period, 
		 time=tdiabcase, 
		 event=diabcase, 
		 intmiss=F, 
		 strata=period agecon,
		 covars= &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_);

%mediate(data=five, 
		 exposure=bbmpotw, 
		 intermed=&bmic9_, 
		 id=id period, 
		 time=tdiabcase, 
		 event=diabcase, 
		 intmiss=F, 
		 strata=period agecon,
		 covars= &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cfpotatcav_);

%mediate(data=five, 
		 exposure=fpotatow, 
		 intermed=&bmic9_, 
		 id=id period, 
		 time=tdiabcase, 
		 event=diabcase, 
		 intmiss=F, 
		 strata=period agecon,
		 covars= &qcalorcav_ white2 &smkc_ &alcc_ &catact_ &hormone_ mlvit dbfh82 antihbp antihtc hxhbp &qnSES_ &qtrmeatcav_ &qpoultrcav_ &qfishalcav_ &qregeggcav_ &qtdairycav_ &qnutlegcav_ &qfruitscav_ &qvegealcav_ &qSSBcav_ &qwhgrnscav_ &qrfgrnscav_ &cbbmpotcav_);