%h86_dt(keep= fries86d pot86d pchip86d
              procm86d bacon86d dog86d
              hamb86d bmix86d bmain86d
              chwi86d chwo86d
              ctuna86d dkfsh86d ofish86d
              whole86d cream86d sour86d icecr86d crmch86d otch86d 
              skim86d sherb86d yog86d cotch86d
              egg86d
              tofu86d
              pbut86d pnut86d onut86d
              peas86d bean86d
              rais86d avoc86d ban86d cant86d h2om86d appl86d oran86d grfr86d straw86d blueb86d peach86d
              sbean86d brocc86d kraut86d slaw86d ccabb86d cauli86d bruss86d car86d corn86d mixv86d cel86d ysqua86d eggpl86d yam86d cspin86d rspin86d kale86d ilett86d rlett86d tom86d tosau86d
              cola86d cnoc86d otsug86d punch86d 
              dcaf86d cof86d
              brice86d
              wrice86d
              cdyw86d cdywo86d choco86d);

%h86_nts(keep= whgrn86n rfgrn86n gl86n gid86n afat86n vfat86n calor86n pot_carb86n trnss86n);

data h86_dt;
    set h86_dt;

    array foods {*} fries86d pot86d pchip86d
              procm86d bacon86d dog86d
              hamb86d bmix86d bmain86d
              chwi86d chwo86d
              ctuna86d dkfsh86d ofish86d
              whole86d cream86d sour86d icecr86d crmch86d otch86d 
              skim86d sherb86d yog86d cotch86d
              egg86d
              tofu86d
              pbut86d pnut86d onut86d
              peas86d bean86d
              rais86d avoc86d ban86d cant86d h2om86d appl86d oran86d grfr86d straw86d blueb86d peach86d
              sbean86d brocc86d kraut86d slaw86d ccabb86d cauli86d bruss86d car86d corn86d mixv86d cel86d ysqua86d eggpl86d yam86d cspin86d rspin86d kale86d ilett86d rlett86d tom86d tosau86d
              cola86d cnoc86d otsug86d punch86d 
              dcaf86d cof86d
              brice86d
              wrice86d
              cdyw86d cdywo86d choco86d;
    array foods2 {*} fries86ds pot86ds pchip86ds
              procm86ds bacon86ds dog86ds
              hamb86ds bmix86ds bmain86ds
              chwi86ds chwo86ds
              ctuna86ds dkfsh86ds ofish86ds
              whole86ds cream86ds sour86ds icecr86ds crmch86ds otch86ds 
              skim86ds sherb86ds yog86ds cotch86ds
              egg86ds
              tofu86ds
              pbut86ds pnut86ds onut86ds
              peas86ds bean86ds
              rais86ds avoc86ds ban86ds cant86ds h2om86ds appl86ds oran86ds grfr86ds straw86ds blueb86ds peach86ds
              sbean86ds brocc86ds kraut86ds slaw86ds ccabb86ds cauli86ds bruss86ds car86ds corn86ds mixv86ds cel86ds ysqua86ds eggpl86ds yam86ds cspin86ds rspin86ds kale86ds ilett86ds rlett86ds tom86ds tosau86ds
              cola86ds cnoc86ds otsug86ds punch86ds 
              dcaf86ds cof86ds
              brice86ds
              wrice86ds
              cdyw86ds cdywo86ds choco86ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel86ds = cel86ds*0.33;
    pbut86ds = pbut86ds/2;
    bmain86ds = bmain86ds*(5/3);
    chwi86ds = chwi86ds*(5/3);
    chwo86ds = chwo86ds*(5/3);

    /*Total Potato*/
    tpotat86d = sum(0, fries86ds, pot86ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot86d = sum(0, pot86ds);

    /*Fries Potato*/
    fpotat86d = sum(0, fries86ds);

    /*Chips*/
    chipss86d = sum(0, pchip86ds);

    /*Red meat*/
    prmeat86d = sum(0, procm86ds, bacon86ds, dog86ds);
    urmeat86d = sum(0, hamb86ds, bmix86ds, bmain86ds);
    trmeat86d = sum(0, prmeat86d, urmeat86d);

    /*Unprocessed poultry*/
    poultr86d = sum(0, chwi86ds, chwo86ds);

    /*Fish*/
    fishal86d = sum(0, ctuna86ds, dkfsh86ds, ofish86ds);

    /*High fat dairy*/
    hdairy86d = sum(0, whole86ds, cream86ds, sour86ds, icecr86ds, crmch86ds, otch86ds);

    /*Low fat dairy*/
    ldairy86d = sum(0, skim86ds, sherb86ds, yog86ds, cotch86ds);

    /*Regular eggs*/
    regegg86d = sum(0, egg86ds);

    /*Soy*/
    soypro86d = sum(0, tofu86ds);

    /*Nuts*/
    nutsal86d = sum(0, pbut86ds, pnut86ds, onut86ds);

    /*Legumes*/
    legume86d = sum(0, peas86ds, bean86ds);

    /*Fruits*/
    fruits86d = sum(0, rais86ds, avoc86ds, ban86ds, cant86ds, h2om86ds, appl86ds, oran86ds, grfr86ds, straw86ds, blueb86ds, peach86ds);

    /*Vegetables*/
    vegeal86d = sum(0, sbean86ds, brocc86ds, kraut86ds, slaw86ds, ccabb86ds, cauli86ds, bruss86ds, car86ds, mixv86ds, cel86ds, eggpl86ds, yam86ds, cspin86ds, rspin86ds, kale86ds, ilett86ds, rlett86ds, tom86ds, tosau86d);

   /*Non-starchy Vegetables*/
    nstveg86d = sum(0, sbean86ds, brocc86ds, kraut86ds, slaw86ds, ccabb86ds, cauli86ds, bruss86ds, car86ds, corn86ds, mixv86ds, cel86ds, ysqua86ds, eggpl86ds, cspin86ds, rspin86ds, kale86ds, ilett86ds, rlett86ds, tom86ds, tosau86d);

    /*Starchy Vegetables*/
    staveg86d = sum(0, corn86ds, ysqua86ds, yam86ds, peas86ds, bean86ds);

    /*Dairy*/
    tdairy86d = sum(0, hdairy86d, ldairy86d);

    /*Coffee*/
    coffee86d = sum(0, dcaf86ds, cof86ds);

    /*Nut, Legumes, Beans*/
    nutleg86d = sum(0, nutsal86d, legume86d);

    /*Brown rice*/
    bwrice86d = sum(0, brice86ds);

    /*White rice*/
    wtrice86d = sum(0, wrice86ds);

    /*Sugar-sweetened beverage*/
    SSB86d = sum(0, cola86ds, cnoc86ds, otsug86ds, punch86ds);

            /*confectionery*/
   conf86d = sum(0, cdyw86ds, cdywo86ds, choco86ds);

run;

data h86_nts;
    set h86_nts;

    whgrns86d = whgrn86n/28;
    rfgrns86d = rfgrn86n/28;
    afat86d= afat86n/15;
    vfat86d= vfat86n/15;

run;




%h90_dt(keep= fries90d potb90d pchip90d
              bacon90d dog90d procm90d
              hamb90d bmix90d pmain90d bmain90d
              chwi90d chwo90d 
              ctuna90d dkfsh90d ofsh90d
              whole90d cream90d sour90d icecr90d crmch90d otch90d
              skim90d sherb90d yog90d cotch90d
              egg90d
              tofu90d
              pbut90d pnut90d onut90d
              peas90d bean90d
              rais90d prune90d ban90d cant90d h2om90d appl90d asau90d oran90d grfr90d straw90d blueb90d peach90d 
              tom90d tosau90d sbean90d brocc90d slaw90d cauli90d bruss90d rcar90d ccar90d corn90d mixv90d osqua90d eggpl90d yam90d cspin90d rspin90d kale90d ilett90d rlett90d cel90d beet90d oniov90d
              cola90d cnoc90d otsug90d punch90d
              decaf90d cof90d
              brice90d
              wrice90d
              cdyw90d cdywo90d choco90d);

%h90_nts(keep= whgrn90n rfgrn90n gl90n gid90n afat90n vfat90n calor90n pot_carb90n trnss90n);

data h90_dt;
    set h90_dt;

    array foods {*} fries90d potb90d pchip90d
              bacon90d dog90d procm90d
              hamb90d bmix90d pmain90d bmain90d
              chwi90d chwo90d 
              ctuna90d dkfsh90d ofsh90d
              whole90d cream90d sour90d icecr90d crmch90d otch90d
              skim90d sherb90d yog90d cotch90d
              egg90d
              tofu90d
              pbut90d pnut90d onut90d
              peas90d bean90d
              rais90d prune90d ban90d cant90d h2om90d appl90d asau90d oran90d grfr90d straw90d blueb90d peach90d 
              tom90d tosau90d sbean90d brocc90d slaw90d cauli90d bruss90d rcar90d ccar90d corn90d mixv90d osqua90d eggpl90d yam90d cspin90d rspin90d kale90d ilett90d rlett90d cel90d beet90d oniov90d
              cola90d cnoc90d otsug90d punch90d
              decaf90d cof90d
              brice90d
              wrice90d
              cdyw90d cdywo90d choco90d;
    array foods2 {*} fries90ds potb90ds pchip90ds
              bacon90ds dog90ds procm90ds
              hamb90ds bmix90ds pmain90ds bmain90ds
              chwi90ds chwo90ds 
              ctuna90ds dkfsh90ds ofsh90ds
              whole90ds cream90ds sour90ds icecr90ds crmch90ds otch90ds
              skim90ds sherb90ds yog90ds cotch90ds
              egg90ds
              tofu90ds
              pbut90ds pnut90ds onut90ds
              peas90ds bean90ds
              rais90ds prune90ds ban90ds cant90ds h2om90ds appl90ds asau90ds oran90ds grfr90ds straw90ds blueb90ds peach90ds 
              tom90ds tosau90ds sbean90ds brocc90ds slaw90ds cauli90ds bruss90ds rcar90ds ccar90ds corn90ds mixv90ds osqua90ds eggpl90ds yam90ds cspin90ds rspin90ds kale90ds ilett90ds rlett90ds cel90ds beet90ds oniov90ds
              cola90ds cnoc90ds otsug90ds punch90ds
              decaf90ds cof90ds
              brice90ds
              wrice90ds
              cdyw90ds cdywo90ds choco90ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel90ds = cel90ds*0.33;
    pbut90ds = pbut90ds/2;
    bmain90ds = bmain90ds*(5/3);
    pmain90ds = pmain90ds*(5/3);
    chwi90ds = chwi90ds*(5/3);
    chwo90ds = chwo90ds*(5/3);

    /*Total Potato*/
    tpotat90d = sum(0, fries90ds, potb90ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot90d = sum(0, potb90ds);

    /*Fries Potato*/
    fpotat90d = sum(0, fries90ds);

    /*Chips*/
    chipss90d = sum(0, pchip90ds);

    /*Red meat*/
    prmeat90d = sum(0, bacon90ds, dog90ds, procm90ds);
    urmeat90d = sum(0, hamb90ds, bmix90ds, pmain90ds, bmain90ds);
    trmeat90d = sum(0, prmeat90d, urmeat90d);

    /*Unprocessed poultry*/
    poultr90d = sum(0, chwi90ds, chwo90ds);

    /*Fish*/
    fishal90d = sum(0, ctuna90ds, dkfsh90ds, ofsh90ds);

    /*High fat dairy*/
    hdairy90d = sum(0, whole90ds, cream90ds, sour90ds, icecr90ds, crmch90ds, otch90ds);

    /*Low fat dairy*/
    ldairy90d = sum(0, skim90ds, sherb90ds, yog90ds, cotch90ds);

    /*Regular eggs*/
    regegg90d = sum(0, egg90ds);

    /*Soy*/
    soypro90d = sum(0, tofu90ds);

    /*Nuts*/
    nutsal90d = sum(0, pbut90ds, pnut90ds, onut90ds);

    /*Legumes*/
    legume90d = sum(0, peas90ds, bean90ds);

    /*Fruits*/
    fruits90d = sum(0, rais90ds, prune90ds, ban90ds, cant90ds, h2om90ds, appl90ds, asau90ds, oran90ds, grfr90ds, straw90ds, blueb90ds, peach90ds);

    /*Vegetables*/
    vegeal90d = sum(0, tom90ds, tosau90ds, sbean90ds, brocc90ds, slaw90ds, cauli90ds, bruss90ds, rcar90ds, ccar90ds, corn90ds, mixv90ds, eggpl90ds, yam90ds, cspin90ds, rspin90ds, kale90ds, ilett90ds, rlett90ds, cel90ds, beet90ds, oniov90ds);

   /*Non-starchy Vegetables*/
    nstveg90d = sum(0, tom90ds, tosau90ds, sbean90ds, brocc90ds, slaw90ds, cauli90ds, bruss90ds, rcar90ds, ccar90ds, mixv90ds, osqua90ds, eggpl90ds, cspin90ds, rspin90ds, kale90ds, ilett90ds, rlett90ds, cel90ds, beet90ds, oniov90ds);

    /*Starchy Vegetables*/
    staveg90d = sum(0, corn90ds, osqua90ds, yam90ds, peas90ds, bean90ds);

    /*Dairy*/
    tdairy90d = sum(0, hdairy90d, ldairy90d);

    /*Coffee*/
    coffee90d = sum(0, decaf90ds, cof90ds);

    /*Nut, Legumes, Beans*/
    nutleg90d = sum(0, nutsal90d, legume90d);

    /*Brown rice*/
    bwrice90d = sum(0, brice90ds);

    /*White rice*/
    wtrice90d = sum(0, wrice90ds);

    /*Sugar-sweetened beverage*/
    SSB90d = sum(0, cola90ds, cnoc90ds, otsug90ds, punch90ds);

           /*confectionery*/
   conf90d = sum(0, cdyw90ds, cdywo90ds, choco90ds);
run;

data h90_nts;
    set h90_nts;

    whgrns90d = whgrn90n/28;
    rfgrns90d = rfgrn90n/28;
    afat90d= afat90n/15;
    vfat90d= vfat90n/15;
run;



%h94_dt(keep= fries94d pot94d pchip94d
              bacon94d dog94d procm94d
              hamb94d hambl94d bmix94d pmain94d bmain94d
              chwi94d chwo94d ctdog94d
              ctuna94d dkfsh94d ofish94d
              whole94d cream94d icecr94d crmch94d otch94d chtyp94d
              skim194d milk294d sherb94d flyog94d plyog94d cotch94d
              egg94d
              tofu94d
              pbut94d pnut94d onut94d
              peas94d bean94d
              rais94d prune94d ban94d cant94d avo94d appl94d oran94d grfr94d straw94d blueb94d peach94d 
              tom94d tosau94d sbean94d brocc94d cabb94d cauli94d bruss94d rcar94d ccar94d corn94d mixv94d osqua94d eggpl94d yam94d cspin94d rspin94d kale94d ilett94d rlett94d cel94d oniov94d
              cola94d cnoc94d otsug94d punch94d
              dcaf94d coff94d
              brice94d
              wrice94d
              cdyw94d cdywo94d choco94d);

%h94_nts(keep= whgrn94n rfgrn94n gl94n gid94n afat94n vfat94n calor94n pot_carb94n trnss94n);

data h94_dt;
    set h94_dt;

    array foods {*} fries94d pot94d pchip94d
              bacon94d dog94d procm94d
              hamb94d hambl94d bmix94d pmain94d bmain94d
              chwi94d chwo94d ctdog94d
              ctuna94d dkfsh94d ofish94d
              whole94d cream94d icecr94d crmch94d otch94d
              skim194d milk294d sherb94d flyog94d plyog94d cotch94d
              egg94d
              tofu94d
              pbut94d pnut94d onut94d
              peas94d bean94d
              rais94d prune94d ban94d cant94d avo94d appl94d oran94d grfr94d straw94d blueb94d peach94d 
              tom94d tosau94d sbean94d brocc94d cabb94d cauli94d bruss94d rcar94d ccar94d corn94d mixv94d osqua94d eggpl94d yam94d cspin94d rspin94d kale94d ilett94d rlett94d cel94d oniov94d
              cola94d cnoc94d otsug94d punch94d
              dcaf94d coff94d
              brice94d
              wrice94d
              cdyw94d cdywo94d choco94d;
    array foods2 {*} fries94ds pot94ds pchip94ds
              bacon94ds dog94ds procm94ds
              hamb94ds hambl94ds bmix94ds pmain94ds bmain94ds
              chwi94ds chwo94ds ctdog94ds
              ctuna94ds dkfsh94ds ofish94ds
              whole94ds cream94ds icecr94ds crmch94ds otch94ds
              skim194ds milk294ds sherb94ds flyog94ds plyog94ds cotch94ds
              egg94ds
              tofu94ds
              pbut94ds pnut94ds onut94ds
              peas94ds bean94ds
              rais94ds prune94ds ban94ds cant94ds avo94ds appl94ds oran94ds grfr94ds straw94ds blueb94ds peach94ds 
              tom94ds tosau94ds sbean94ds brocc94ds cabb94ds cauli94ds bruss94ds rcar94ds ccar94ds corn94ds mixv94ds osqua94ds eggpl94ds yam94ds cspin94ds rspin94ds kale94ds ilett94ds rlett94ds cel94ds oniov94ds
              cola94ds cnoc94ds otsug94ds punch94ds
              dcaf94ds coff94ds
              brice94ds
              wrice94ds
              cdyw94ds cdywo94ds choco94ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel94ds = cel94ds*0.33;
    pbut94ds = pbut94ds/2;
    bmain94ds = bmain94ds*(5/3);
    pmain94ds = pmain94ds*(5/3);
    chwi94ds = chwi94ds*(5/3);
    chwo94ds = chwo94ds*(5/3);

    /*Total Potato*/
    tpotat94d = sum(0, fries94ds, pot94ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot94d = sum(0, pot94ds);

    /*Fries Potato*/
    fpotat94d = sum(0, fries94ds);

    /*Chips*/
    chipss94d = sum(0, pchip94ds);

    /*Red meat*/
    prmeat94d = sum(0, bacon94ds, dog94ds, procm94ds);
    urmeat94d = sum(0, hamb94ds, hambl94ds, bmix94ds, pmain94ds, bmain94ds);
    trmeat94d = sum(0, prmeat94d, urmeat94d);

    /*Unprocessed poultry*/
    poultr94d = sum(0, chwi94ds, chwo94ds, ctdog94ds);

    /*Fish*/
    fishal94d = sum(0, ctuna94ds, dkfsh94ds, ofish94ds);

    /*High fat dairy*/
    if chtyp94d in (1,3,4) then hfcheese94 = otch94ds; else hfcheese94 = .;
    hdairy94d = sum(0, whole94ds, cream94ds, icecr94ds, crmch94ds, hfcheese94);

    /*Low fat dairy*/
    if chtyp94d = 2 then lfcheese94 = otch94ds; else lfcheese94 = .;
    ldairy94d = sum(0, skim194ds, milk294ds, sherb94ds, flyog94ds, plyog94ds, cotch94ds, lfcheese94);

    /*Regular eggs*/
    regegg94d = sum(0, egg94ds);

    /*Soy*/
    soypro94d = sum(0, tofu94ds);

    /*Nuts*/
    nutsal94d = sum(0, pbut94ds, pnut94ds, onut94ds);

    /*Legumes*/
    legume94d = sum(0, peas94ds, bean94ds);

    /*Fruits*/
    fruits94d = sum(0, rais94ds, prune94ds, ban94ds, cant94ds, avo94ds, appl94ds, oran94ds, grfr94ds, straw94ds, blueb94ds, peach94ds);

    /*Vegetables*/
    vegeal94d = sum(0, tom94ds, tosau94ds, sbean94ds, brocc94ds, cabb94ds, cauli94ds, bruss94ds, rcar94ds, ccar94ds, corn94ds, mixv94ds, osqua94ds, eggpl94ds, yam94ds, cspin94ds, rspin94ds, kale94ds, ilett94ds, rlett94ds, cel94ds, oniov94ds);

   /*Non-starchy Vegetables*/
    nstveg94d = sum(0, tom94ds, tosau94ds, sbean94ds, brocc94ds, cabb94ds, cauli94ds, bruss94ds, rcar94ds, ccar94ds, mixv94ds, eggpl94ds, cspin94ds, rspin94ds, kale94ds, ilett94ds, rlett94ds, cel94ds, oniov94ds);

    /*Starchy Vegetables*/
    staveg94d = sum(0, corn94ds, osqua94ds, yam94ds, peas94ds, bean94ds);

    /*Dairy*/
    tdairy94d = sum(0, hdairy94d, ldairy94d);

    /*Coffee*/
    coffee94d = sum(0, dcaf94ds, coff94ds);

    /*Nut, Legumes, Beans*/
    nutleg94d = sum(0, nutsal94d, legume94d);

    /*Brown rice*/
    bwrice94d = sum(0, brice94ds);

    /*White rice*/
    wtrice94d = sum(0, wrice94ds);

    /*Sugar-sweetened beverage*/
    SSB94d = sum(0, cola94ds, cnoc94ds, otsug94ds, punch94ds);

           /*confectionery*/
   conf94d = sum(0, cdyw94ds, cdywo94ds, choco94ds);
run;

data h94_nts;
    set h94_nts;

    whgrns94d = whgrn94n/28;
    rfgrns94d = rfgrn94n/28;
    afat94d= afat94n/15;
    vfat94d= vfat94n/15;
run;




%h98_dt(keep= fries98d pot98d pchip98d
              dog98d bacon98d sbol98d oprom98d
              hamb98d hambl98d bmix98d pmain98d bmain98d
              ctdog98d ctsan98d chwi98d chwo98d
              ctuna98d bfsh98d dkfsh98d ofish98d
              whole98d cream98d icecr98d crmch98d otch98d q31dp98d chreg98d chlf98d chnf98d noch98d
              skim198d milk298d sherb98d plyog98d flyog98d cotch98d
              eggbt98d egg98d
              tofu98d
              pbut98d pnut98d wnut98d onut98d
              peas98d bean98d
              rais98d prune98d ban98d cant98d avo98d appl98d oran98d grfr98d straw98d blueb98d peach98d 
              tom98d tosau98d sbean98d brocc98d cabb98d cauli98d bruss98d rcar98d ccar98d corn98d mixv98d yam98d osqua98d eggpl98d kale98d cspin98d rspin98d ilett98d rlett98d cel98d oniov98d
              cola98d cnoc98d otsug98d punch98d
              dcaf98d coff98d
              brice98d
              wrice98d
              cdyw98d cdywo98d choco98d);

%h98_nts(keep= whgrn98n rfgrn98n gl98n gid98n afat98n vfat98n calor98n pot_carb98n ttrn098n);

data h98_dt;
    set h98_dt;

    array foods {*} fries98d pot98d pchip98d
              dog98d bacon98d sbol98d oprom98d
              hamb98d hambl98d bmix98d pmain98d bmain98d
              ctdog98d ctsan98d chwi98d chwo98d
              ctuna98d bfsh98d dkfsh98d ofish98d
              whole98d cream98d icecr98d crmch98d otch98d
              skim198d milk298d sherb98d plyog98d flyog98d cotch98d
              eggbt98d egg98d
              tofu98d
              pbut98d pnut98d wnut98d onut98d
              peas98d bean98d
              rais98d prune98d ban98d cant98d avo98d appl98d oran98d grfr98d straw98d blueb98d peach98d 
              tom98d tosau98d sbean98d brocc98d cabb98d cauli98d bruss98d rcar98d ccar98d corn98d mixv98d yam98d osqua98d eggpl98d kale98d cspin98d rspin98d ilett98d rlett98d cel98d oniov98d
              cola98d cnoc98d otsug98d punch98d
              dcaf98d coff98d
              brice98d
              wrice98d
              cdyw98d cdywo98d choco98d;
    array foods2 {*} fries98ds pot98ds pchip98ds
              dog98ds bacon98ds sbol98ds oprom98ds
              hamb98ds hambl98ds bmix98ds pmain98ds bmain98ds
              ctdog98ds ctsan98ds chwi98ds chwo98ds
              ctuna98ds bfsh98ds dkfsh98ds ofish98ds
              whole98ds cream98ds icecr98ds crmch98ds otch98ds
              skim198ds milk298ds sherb98ds plyog98ds flyog98ds cotch98ds
              eggbt98ds egg98ds
              tofu98ds
              pbut98ds pnut98ds wnut98ds onut98ds
              peas98ds bean98ds
              rais98ds prune98ds ban98ds cant98ds avo98ds appl98ds oran98ds grfr98ds straw98ds blueb98ds peach98ds 
              tom98ds tosau98ds sbean98ds brocc98ds cabb98ds cauli98ds bruss98ds rcar98ds ccar98ds corn98ds mixv98ds yam98ds osqua98ds eggpl98ds kale98ds cspin98ds rspin98ds ilett98ds rlett98ds cel98ds oniov98ds
              cola98ds cnoc98ds otsug98ds punch98ds
              dcaf98ds coff98ds
              brice98ds
              wrice98ds
              cdyw98ds cdywo98ds choco98ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel98ds = cel98ds*0.33;
    pbut98ds = pbut98ds/2;
    bmain98ds = bmain98ds*(5/3);
    pmain98ds = pmain98ds*(5/3);
    chwi98ds = chwi98ds*(5/3);
    chwo98ds = chwo98ds*(5/3);

    /*Total Potato*/
    tpotat98d = sum(0, fries98ds, pot98ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot98d = sum(0, pot98ds);

    /*Fries Potato*/
    fpotat98d = sum(0, fries98ds);

    /*Chips*/
    chipss98d = sum(0, pchip98ds);

    /*Red meat*/
    prmeat98d = sum(0, dog98ds, bacon98ds, sbol98ds, oprom98ds);
    urmeat98d = sum(0, hamb98ds, hambl98ds, bmix98ds, pmain98ds, bmain98ds);
    trmeat98d = sum(0, prmeat98d, urmeat98d);

    /*Unprocessed poultry*/
    poultr98d = sum(0, ctdog98ds, ctsan98ds, chwi98ds, chwo98ds);

    /*Fish*/
    fishal98d = sum(0, ctuna98ds, bfsh98ds, dkfsh98ds, ofish98ds);

    /*High fat dairy*/
    if chreg98d=1 or noch98d=1 or q31dp98d=1 then hfcheese98 = otch98ds; else hfcheese98 = .;
    hdairy98d = sum(0, whole98ds, cream98ds, icecr98ds, crmch98ds, hfcheese98);

    /*Low fat dairy*/
    if chlf98d = 1 or chnf98d=1  then lfcheese98 = otch98ds; else lfcheese98 = .;
    ldairy98d = sum(0, skim198ds, milk298ds, sherb98ds, plyog98ds, flyog98ds, cotch98ds, lfcheese98);

    /*Regular eggs*/
    regegg98d = sum(0, eggbt98ds, egg98ds);

    /*Soy*/
    soypro98d = sum(0, tofu98ds);

    /*Nuts*/
    nutsal98d = sum(0, pbut98ds, pnut98ds, wnut98ds, onut98ds);

    /*Legumes*/
    legume98d = sum(0, peas98ds, bean98ds);

    /*Fruits*/
    fruits98d = sum(0, rais98ds, prune98ds, ban98ds, cant98ds, avo98ds, appl98ds, oran98ds, grfr98ds, straw98ds, blueb98ds, peach98ds);

    /*Vegetables*/
    vegeal98d = sum(0, tom98ds, tosau98ds, sbean98ds, brocc98ds, cabb98ds, cauli98ds, bruss98ds, rcar98ds, ccar98ds, corn98ds, mixv98ds, yam98ds, osqua98ds, eggpl98ds, kale98ds, cspin98ds, rspin98ds, ilett98ds, rlett98ds, cel98ds, oniov98ds);

   /*Non-starchy Vegetables*/
    nstveg98d = sum(0, tom98ds, tosau98ds, sbean98ds, brocc98ds, cabb98ds, cauli98ds, bruss98ds, rcar98ds, ccar98ds, mixv98ds, eggpl98ds, kale98ds, cspin98ds, rspin98ds, ilett98ds, rlett98ds, cel98ds, oniov98ds);

    /*Starchy Vegetables*/
    staveg98d = sum(0, corn98ds, yam98ds, osqua98ds, peas98ds, bean98ds);

    /*Dairy*/
    tdairy98d = sum(0, hdairy98d, ldairy98d);

    /*Coffee*/
    coffee98d = sum(0, dcaf98ds, coff98ds);

    /*Nut, Legumes, Beans*/
    nutleg98d = sum(0, nutsal98d, legume98d);

    /*Brown rice*/
    bwrice98d = sum(0, brice98ds);

    /*White rice*/
    wtrice98d = sum(0, wrice98ds);
   
    /*Sugar-sweetened beverage*/
    SSB98d = sum(0, cola98ds, cnoc98ds, otsug98ds, punch98ds);

           /*confectionery*/
   conf98d = sum(0, cdyw98ds, cdywo98ds, choco98ds);
run;

data h98_nts;
    set h98_nts;

    whgrns98d = whgrn98n/28;
    rfgrns98d = rfgrn98n/28;
    afat98d= afat98n/15;
    vfat98d= vfat98n/15;
run;


%hp02(keep= fries02d pot02d pchip02d
            dog02d bacon02d sbol02d oprom02d
            hambl02d hamb02d bmix02d pmain02d bmain02d
            ctdog02d ctsan02d chwi02d chwo02d
            ctuna02d bfsh02d dkfsh02d ofish02d
            whole02d cream02d icecr02d crmch02d otch02d chreg02d chlf02d chnf02d noch02d tppt02d
            skim02d mlk1202d sherb02d plyog02d flyog02d cotch02d 
            eggbt02d egg02d
            soym02d tofu02d
            pbut02d pnut02d wnut02d onut02d
            peas02d bean02d
            rais02d prune02d ban02d cant02d avo02d appl02d oran02d grfrj02d straw02d blueb02d peach02d 
            tom02d tosau02d sbean02d brocc02d cauli02d cabb02d bruss02d rcar02d ccar02d corn02d mixv02d yam02d osqua02d eggpl02d kale02d cspin02d rspin02d ilett02d rlett02d cel02d oniov02d
            colas02d obvcs02d otsug02d punch02d
            dcaf02d coff02d
            brice02d
            wrice02d
            cdyw02d cdywo02d choco02d);

%h02_nts(keep= whgrn02n rfgrn02n gl02n gid02n afat02n vfat02n calor02n pot_carb02n trn0202n);

data hp02;
    set hp02;

    array foods {*} fries02d pot02d pchip02d
            dog02d bacon02d sbol02d oprom02d
            hambl02d hamb02d bmix02d pmain02d bmain02d
            ctdog02d ctsan02d chwi02d chwo02d
            ctuna02d bfsh02d dkfsh02d ofish02d
            whole02d cream02d icecr02d crmch02d otch02d
            skim02d mlk1202d sherb02d plyog02d flyog02d cotch02d 
            eggbt02d egg02d
            soym02d tofu02d
            pbut02d pnut02d wnut02d onut02d
            peas02d bean02d
            rais02d prune02d ban02d cant02d avo02d appl02d oran02d grfrj02d straw02d blueb02d peach02d 
            tom02d tosau02d sbean02d brocc02d cauli02d cabb02d bruss02d rcar02d ccar02d corn02d mixv02d yam02d osqua02d eggpl02d kale02d cspin02d rspin02d ilett02d rlett02d cel02d oniov02d
            colas02d obvcs02d otsug02d punch02d
            dcaf02d coff02d
            brice02d
            wrice02d
            cdyw02d cdywo02d choco02d;
    array foods2 {*} fries02ds pot02ds pchip02ds
            dog02ds bacon02ds sbol02ds oprom02ds
            hambl02ds hamb02ds bmix02ds pmain02ds bmain02ds
            ctdog02ds ctsan02ds chwi02ds chwo02ds
            ctuna02ds bfsh02ds dkfsh02ds ofish02ds
            whole02ds cream02ds icecr02ds crmch02ds otch02ds
            skim02ds mlk1202ds sherb02ds plyog02ds flyog02ds cotch02ds
            eggbt02ds egg02ds
            soym02ds tofu02ds
            pbut02ds pnut02ds wnut02ds onut02ds
            peas02ds bean02ds
            rais02ds prune02ds ban02ds cant02ds avo02ds appl02ds oran02ds grfrj02ds straw02ds blueb02ds peach02ds 
            tom02ds tosau02ds sbean02ds brocc02ds cauli02ds cabb02ds bruss02ds rcar02ds ccar02ds corn02ds mixv02ds yam02ds osqua02ds eggpl02ds kale02ds cspin02ds rspin02ds ilett02ds rlett02ds cel02ds oniov02ds
            colas02ds obvcs02ds otsug02ds punch02ds
            dcaf02ds coff02ds
            brice02ds
            wrice02ds
            cdyw02ds cdywo02ds choco02ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel02ds = cel02ds*0.33;
    pbut02ds = pbut02ds/2;
    bmain02ds = bmain02ds*(5/3);
    pmain02ds = pmain02ds*(5/3);

    /*Total Potato*/
    tpotat02d = sum(0, fries02ds, pot02ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot02d = sum(0, pot02ds);

    /*Fries Potato*/
    fpotat02d = sum(0, fries02ds);

    /*Chips*/
    chipss02d = sum(0, pchip02ds);

    /*Red meat*/
    prmeat02d = sum(0, dog02ds, bacon02ds, sbol02ds, oprom02ds);
    urmeat02d = sum(0, hambl02ds, hamb02ds, bmix02ds, pmain02ds, bmain02ds);
    trmeat02d = sum(0, prmeat02d, urmeat02d);

    /*Unprocessed poultry*/
    poultr02d = sum(0, ctdog02ds, ctsan02ds, chwi02ds, chwo02ds);

    /*Fish*/
    fishal02d = sum(0, ctuna02ds, bfsh02ds, dkfsh02ds, ofish02ds);

    /*High fat dairy*/
    if chreg02d=1 or noch02d=1 or tppt02d=1 then hfcheese02 = otch02ds; else hfcheese02 = .;
    hdairy02d = sum(0, whole02ds, cream02ds, icecr02ds, crmch02ds, hfcheese02);

    /*Low fat dairy*/
    if chlf02d = 1 or chnf02d=1  then lfcheese02 = otch02ds; else lfcheese02 = .;
    ldairy02d = sum(0, skim02ds, mlk1202ds, sherb02ds, plyog02ds, flyog02ds, cotch02ds, lfcheese02);

    /*Regular eggs*/
    regegg02d = sum(0, eggbt02ds, egg02ds);

    /*Soy*/
    soypro02d = sum(0, soym02ds, tofu02ds);

    /*Nuts*/
    nutsal02d = sum(0, pbut02ds, pnut02ds, wnut02ds, onut02ds);

    /*Legumes*/
    legume02d = sum(0, peas02ds, bean02ds);

    /*Fruits*/
    fruits02d = sum(0, rais02ds, prune02ds, ban02ds, cant02ds, avo02ds, appl02ds, oran02ds, grfrj02ds, straw02ds, blueb02ds, peach02ds);

    /*Vegetables*/
    vegeal02d = sum(0, tom02ds, tosau02ds, sbean02ds, brocc02ds, cauli02ds, cabb02ds, bruss02ds, rcar02ds, ccar02ds, corn02ds, mixv02ds, yam02ds, osqua02ds, eggpl02ds, kale02ds, cspin02ds, rspin02ds, ilett02ds, rlett02ds, cel02ds, oniov02ds);

   /*Non-starchy Vegetables*/
    nstveg02d = sum(0, tom02ds, tosau02ds, sbean02ds, brocc02ds, cauli02ds, cabb02ds, bruss02ds, rcar02ds, ccar02ds, mixv02ds, eggpl02ds, kale02ds, cspin02ds, rspin02ds, ilett02ds, rlett02ds, cel02ds, oniov02ds);

    /*Starchy Vegetables*/
    staveg02d = sum(0, corn02ds, yam02ds, osqua02ds, peas02ds, bean02ds);

    /*Dairy*/
    tdairy02d = sum(0, hdairy02d, ldairy02d);

    /*Coffee*/
    coffee02d = sum(0, dcaf02ds, coff02ds);

    /*Nut, Legumes, Beans*/
    nutleg02d = sum(0, nutsal02d, legume02d);

    /*Brown rice*/
    bwrice02d = sum(0, brice02ds);

    /*White rice*/
    wtrice02d = sum(0, wrice02ds);

    /*Sugar-sweetened beverage*/
    SSB02d = sum(0, colas02ds, obvcs02ds, otsug02ds, punch02ds);

           /*confectionery*/
   conf02d = sum(0, cdyw02ds, cdywo02ds, choco02ds);
run;

data h02_nts;
    set h02_nts;

    whgrns02d = whgrn02n/28;
    rfgrns02d = rfgrn02n/28;
    afat02d= afat02n/15;
    vfat02d= vfat02n/15;
run;



%hp06(keep= fries06d pot06d pchip06d
            dog06d bacon06d sbol06d oprom06d 
            hambl06d hamb06d bmix06d pmain06d bmain06d
            ctdog06d ctsan06d chwi06d chwo06d
            ctuna06d bfsh06d dkfsh06d ofish06d
            whole06d cream06d icecr06d crmch06d otch06d chreg06d chlf06d chnf06d noch06d tppt06d
            skim06d mlk1206d sherb06d plyog06d flyog06d cotch06d
            eggom06d egg06d
            soym06d tofu06d
            pbut06d pnut06d wnut06d onut06d
            peas06d bean06d
            rais06d prune06d ban06d cant06d avo06d appl06d oran06d grfrj06d straw06d blueb06d peach06d apric06d 
            tom06d tosau06d sbean06d brocc06d cauli06d cabb06d bruss06d rcar06d ccar06d corn06d mixv06d yam06d osqua06d eggpl06d kale06d cspin06d rspin06d ilett06d rlett06d cel06d oniov06d
            cbvcfs06d otsug06d punch06d
            dcaf06d coff06d
            brice06d
            wrice06d
            cdyw06d cdywo06d dchoc06d mchoc06d);

%h06_nts(keep= whgrn06n rfgrn06n gl06n gid06n afat06n vfat06n calor06n pot_carb06n trn0706n);

data hp06;
    set hp06;

    array foods {*} fries06d pot06d pchip06d
            dog06d bacon06d sbol06d oprom06d 
            hambl06d hamb06d bmix06d pmain06d bmain06d
            ctdog06d ctsan06d chwi06d chwo06d
            ctuna06d bfsh06d dkfsh06d ofish06d
            whole06d cream06d icecr06d crmch06d otch06d chreg06d chlf06d chnf06d noch06d tppt06d
            skim06d mlk1206d sherb06d plyog06d flyog06d cotch06d
            eggom06d egg06d
            soym06d tofu06d
            pbut06d pnut06d wnut06d onut06d
            peas06d bean06d
            rais06d prune06d ban06d cant06d avo06d appl06d oran06d grfrj06d straw06d blueb06d peach06d apric06d 
            tom06d tosau06d sbean06d brocc06d cauli06d cabb06d bruss06d rcar06d ccar06d corn06d mixv06d yam06d osqua06d eggpl06d kale06d cspin06d rspin06d ilett06d rlett06d cel06d oniov06d
            cbvcfs06d otsug06d punch06d
            dcaf06d coff06d
            brice06d
            wrice06d
            cdyw06d cdywo06d dchoc06d mchoc06d;
    array foods2 {*} fries06ds pot06ds pchip06ds
            dog06ds bacon06ds sbol06ds oprom06ds 
            hambl06ds hamb06ds bmix06ds pmain06ds bmain06ds
            ctdog06ds ctsan06ds chwi06ds chwo06ds
            ctuna06ds bfsh06ds dkfsh06ds ofish06ds
            whole06ds cream06ds icecr06ds crmch06ds otch06ds
            skim06ds mlk1206ds sherb06ds plyog06ds flyog06ds cotch06ds
            eggom06ds egg06ds
            soym06ds tofu06ds
            pbut06ds pnut06ds wnut06ds onut06ds
            peas06ds bean06ds
            rais06ds prune06ds ban06ds cant06ds avo06ds appl06ds oran06ds grfrj06ds straw06ds blueb06ds peach06ds apric06ds 
            tom06ds tosau06ds sbean06ds brocc06ds cauli06ds cabb06ds bruss06ds rcar06ds ccar06ds corn06ds mixv06ds yam06ds osqua06ds eggpl06ds kale06ds cspin06ds rspin06ds ilett06ds rlett06ds cel06ds oniov06ds
            cbvcfs06ds otsug06ds punch06ds
            dcaf06ds coff06ds
            brice06ds
            wrice06ds
            cdyw06ds cdywo06ds dchoc06ds mchoc06ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel06ds = cel06ds*0.33;
    pbut06ds = pbut06ds/2;
    bmain06ds = bmain06ds*(5/3);
    pmain06ds = pmain06ds*(5/3);

    /*Total Potato*/
    tpotat06d = sum(0, fries06ds, pot06ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot06d = sum(0, pot06ds);

    /*Fries Potato*/
    fpotat06d = sum(0, fries06ds);

    /*Chips*/
    chipss06d = sum(0, pchip06ds);

    /*Red meat*/
    prmeat06d = sum(0, dog06ds, bacon06ds, sbol06ds, oprom06ds);
    urmeat06d = sum(0, hambl06ds, hamb06ds, bmix06ds, pmain06ds, bmain06ds);
    trmeat06d = sum(0, prmeat06d, urmeat06d);

    /*Unprocessed poultry*/
    poultr06d = sum(0, ctdog06ds, ctsan06ds, chwi06ds, chwo06ds);

    /*Fish*/
    fishal06d = sum(0, ctuna06ds, bfsh06ds, dkfsh06ds, ofish06ds);

    /*High fat dairy*/
    if chreg06d=1 or noch06d=1 or tppt06d=1 then hfcheese06 = otch06ds; else hfcheese06 = .;
    hdairy06d = sum(0, whole06ds, cream06ds, icecr06ds, crmch06ds, hfcheese06);

    /*Low fat dairy*/
    if chlf06d = 1 or chnf06d=1  then lfcheese06 = otch06ds; else lfcheese06 = .;
    ldairy06d = sum(0, skim06ds, mlk1206ds, sherb06ds, plyog06ds, flyog06ds, cotch06ds, lfcheese06);

    /*Regular eggs*/
    regegg06d = sum(0, eggom06ds, egg06ds);

    /*Soy*/
    soypro06d = sum(0, soym06ds, tofu06ds);

    /*Nuts*/
    nutsal06d = sum(0, pbut06ds, pnut06ds, wnut06ds, onut06ds);

    /*Legumes*/
    legume06d = sum(0, peas06ds, bean06ds);

    /*Fruits*/
    fruits06d = sum(0, rais06ds, prune06ds, ban06ds, cant06ds, avo06ds, appl06ds, oran06ds, grfrj06ds, straw06ds, blueb06ds, peach06ds, apric06ds );

    /*Vegetables*/
    vegeal06d = sum(0, tom06ds, tosau06ds, sbean06ds, brocc06ds, cauli06ds, cabb06ds, bruss06ds, rcar06ds, ccar06ds, corn06ds, mixv06ds, yam06ds, osqua06ds, eggpl06ds, kale06ds, cspin06ds, rspin06ds, ilett06ds, rlett06ds, cel06ds, oniov06ds);

   /*Non-starchy Vegetables*/
    nstveg06d = sum(0, tom06ds, tosau06ds, sbean06ds, brocc06ds, cauli06ds, cabb06ds, bruss06ds, rcar06ds, ccar06ds, mixv06ds, eggpl06ds, kale06ds, cspin06ds, rspin06ds, ilett06ds, rlett06ds, cel06ds, oniov06ds);

    /*Starchy Vegetables*/
    staveg06d = sum(0, corn06ds, yam06ds, osqua06ds, peas06ds, bean06ds);

    /*Dairy*/
    tdairy06d = sum(0, hdairy06d, ldairy06d);

    /*Coffee*/
    coffee06d = sum(0, dcaf06ds, coff06ds);

    /*Nut, Legumes, Beans*/
    nutleg06d = sum(0, nutsal06d, legume06d);

    /*Brown rice*/
    bwrice06d = sum(0, brice06ds);

    /*White rice*/
    wtrice06d = sum(0, wrice06ds);

    /*Sugar-sweetened beverage*/
    SSB06d = sum(0, cbvcfs06ds, otsug06ds, punch06ds);

           /*confectionery*/
   conf06d = sum(0, cdyw06ds, cdywo06ds, dchoc06ds, mchoc06ds);

run;

data h06_nts;
    set h06_nts;

    whgrns06d = whgrn06n/28;
    rfgrns06d = rfgrn06n/28;
    afat06d= afat06n/15;
    vfat06d= vfat06n/15;

run;


%hp10(keep= fries10d pot10d pchip10d
            dog10d bacon10d sbol10d oprom10d
            hambl10d hamb10d bmix10d pmain10d bmain10d
            ctdog10d ctsan10d chwi10d chwo10d
            ctuna10d bfsh10d dkfsh10d ofish10d
            eggom10d egg10d
            whole10d cream10d icecr10d crmch10d otch10d chreg10d chlf10d chnf10d noch10d tppt10d
            skim10d mlk1210d sherb10d plyog10d artyog10d sweyog10d cotch10d
            soym10d tofu10d
            pbut10d pnut10d wnut10d onut10d
            peas10d bean10d
            rais10d prune10d ban10d cant10d avo10d appl10d oran10d grfrj10d straw10d blueb10d peach10d apric10d
            tom10d tosau10d sbean10d brocc10d cauli10d cabb10d bruss10d rcar10d ccar10d corn10d mixv10d yam10d osqua10d eggpl10d kale10d cspin10d rspin10d ilett10d rlett10d cel10d oniov10d
            cbvcfs10d otsug10d punch10d
            dcaf10d coff10d
            brice10d
            wrice10d
            cdyw10d cdywo10d dchoc10d mchoc10d);

%h10_nts(keep= whgrn10n rfgrn10n gl10n gid10n afat10n vfat10n calor10n pot_carb10n trn1110n);

data hp10;
    set hp10;

    array foods {*} fries10d pot10d pchip10d
            dog10d bacon10d sbol10d oprom10d
            hambl10d hamb10d bmix10d pmain10d bmain10d
            ctdog10d ctsan10d chwi10d chwo10d
            ctuna10d bfsh10d dkfsh10d ofish10d
            eggom10d egg10d
            whole10d cream10d icecr10d crmch10d otch10d
            skim10d mlk1210d sherb10d plyog10d artyog10d sweyog10d cotch10d
            soym10d tofu10d
            pbut10d pnut10d wnut10d onut10d
            peas10d bean10d
            rais10d prune10d ban10d cant10d avo10d appl10d oran10d grfrj10d straw10d blueb10d peach10d apric10d
            tom10d tosau10d sbean10d brocc10d cauli10d cabb10d bruss10d rcar10d ccar10d corn10d mixv10d yam10d osqua10d eggpl10d kale10d cspin10d rspin10d ilett10d rlett10d cel10d oniov10d
            cbvcfs10d otsug10d punch10d
            dcaf10d coff10d
            brice10d
            wrice10d
            cdyw10d cdywo10d dchoc10d mchoc10d;
    array foods2 {*} fries10ds pot10ds pchip10ds
            dog10ds bacon10ds sbol10ds oprom10ds
            hambl10ds hamb10ds bmix10ds pmain10ds bmain10ds
            ctdog10ds ctsan10ds chwi10ds chwo10ds
            ctuna10ds bfsh10ds dkfsh10ds ofish10ds
            eggom10ds egg10ds
            whole10ds cream10ds icecr10ds crmch10ds otch10ds
            skim10ds mlk1210ds sherb10ds plyog10ds artyog10ds sweyog10ds cotch10ds
            soym10ds tofu10ds
            pbut10ds pnut10ds wnut10ds onut10ds
            peas10ds bean10ds
            rais10ds prune10ds ban10ds cant10ds avo10ds appl10ds oran10ds grfrj10ds straw10ds blueb10ds peach10ds apric10ds
            tom10ds tosau10ds sbean10ds brocc10ds cauli10ds cabb10ds bruss10ds rcar10ds ccar10ds corn10ds mixv10ds yam10ds osqua10ds eggpl10ds kale10ds cspin10ds rspin10ds ilett10ds rlett10ds cel10ds oniov10ds
            cbvcfs10ds otsug10ds punch10ds
            dcaf10ds coff10ds
            brice10ds
            wrice10ds
            cdyw10ds cdywo10ds dchoc10ds mchoc10ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    cel10ds = cel10ds*0.33;
    pbut10ds = pbut10ds/2;
    bmain10ds = bmain10ds*(5/3);
    pmain10ds = pmain10ds*(5/3);

    /*Total Potato*/
    tpotat10d = sum(0, fries10ds, pot10ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot10d = sum(0, pot10ds);

    /*Fries Potato*/
    fpotat10d = sum(0, fries10ds);

    /*Chips*/
    chipss10d = sum(0, pchip10ds);

    /*Red meat*/
    prmeat10d = sum(0, dog10ds, bacon10ds, sbol10ds, oprom10ds);
    urmeat10d = sum(0, hambl10ds, hamb10ds, bmix10ds, pmain10ds, bmain10ds);
    trmeat10d = sum(0, prmeat10d, urmeat10d);

    /*Total Potato*/
    tpotat10d = sum(0, fries10ds, pot10ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot10d = sum(0, pot10ds);

    /*Fries Potato*/
    fpotat10d = sum(0, fries10ds);

    /*Chips*/
    chipss10d = sum(0, pchip10ds);

    /*Unprocessed poultry*/
    poultr10d = sum(0, ctdog10ds, ctsan10ds, chwi10ds, chwo10ds);

    /*Fish*/
    fishal10d = sum(0, ctuna10ds, bfsh10ds, dkfsh10ds, ofish10ds);

    /*Regular eggs*/
    regegg10d = sum(0, eggom10ds, egg10ds);

    /*High fat dairy*/
    if chreg10d=1 or noch10d=1 or tppt10d=1 then hfcheese10 = otch10ds; else hfcheese10 = .;
    hdairy10d = sum(0, whole10ds, cream10ds, icecr10ds, crmch10ds, hfcheese10);

    /*Low fat dairy*/
    if chlf10d = 1 or chnf10d=1  then lfcheese10 = otch10ds; else lfcheese10 = .;
    ldairy10d = sum(0, skim10ds, mlk1210ds, sherb10ds, plyog10ds, artyog10ds, sweyog10ds, cotch10ds, lfcheese10);

    /*Soy*/
    soypro10d = sum(0, soym10ds, tofu10ds);

    /*Nuts*/
    nutsal10d = sum(0, pbut10ds, pnut10ds, wnut10ds, onut10ds);

    /*Legumes*/
    legume10d = sum(0, peas10ds, bean10ds);

    /*Fruits*/
    fruits10d = sum(0, rais10ds, prune10ds, ban10ds, cant10ds, avo10ds, appl10ds, oran10ds, grfrj10ds, straw10ds, blueb10ds, peach10ds, apric10ds);

    /*Vegetables*/
    vegeal10d = sum(0, tom10ds, tosau10ds, sbean10ds, brocc10ds, cauli10ds, cabb10ds, bruss10ds, rcar10ds, ccar10ds, corn10ds, mixv10ds, yam10ds, osqua10ds, eggpl10ds, kale10ds, cspin10ds, rspin10ds, ilett10ds, rlett10ds, cel10ds, oniov10ds);

   /*Non-starchy Vegetables*/
    nstveg10d = sum(0, tom10ds, tosau10ds, sbean10ds, brocc10ds, cauli10ds, cabb10ds, bruss10ds, rcar10ds, ccar10ds, mixv10ds, eggpl10ds, kale10ds, cspin10ds, rspin10ds, ilett10ds, rlett10ds, cel10ds, oniov10ds);

    /*Starchy Vegetables*/
    staveg10d = sum(0, corn10ds, yam10ds, osqua10ds, peas10ds, bean10ds);

    /*Dairy*/
    tdairy10d = sum(0, hdairy10d, ldairy10d);

    /*Coffee*/
    coffee10d = sum(0, dcaf10ds, coff10ds);

    /*Nut, Legumes, Beans*/
    nutleg10d = sum(0, nutsal10d, legume10d);

    /*Brown rice*/
    bwrice10d = sum(0, brice10ds);

    /*White rice*/
    wtrice10d = sum(0, wrice10ds);

    /*Sugar-sweetened beverage*/
    SSB10d = sum(0, cbvcfs10ds, otsug10ds, punch10ds);

           /*confectionery*/
   conf10d = sum(0, cdyw10ds, cdywo10ds, dchoc10ds, mchoc10ds);
run;

data h10_nts;
    set h10_nts;

    whgrns10d = whgrn10n/28;
    rfgrns10d = rfgrn10n/28;
    afat10d= afat10n/15;
    vfat10d= vfat10n/15;

run;



%hp14(keep= fries14d pot14d pchip14d
            dog14d bacon14d sbol14d oprom14d
            hambl14d hamb14d bmix14d pmain14d bmain14d
            ctdog14d ctsan14d chwi14d chwo14d
            ctuna14d bfsh14d dkfsh14d ofish14d
            eggom14d egg14d
            whole14d cream14d icecr14d crmch14d otch14d chreg14d chlf14d chnf14d noch14d tppt14d
            skim14d mlk1214d sherb14d plyog14d artyog14d sweyog14d cotch14d 
            soym14d tofu14d
            pbut14d pnut14d wnut14d onut14d
            bean14d peas14d hummus14d
            rais14d prune14d ban14d cant14d avo14d appl14d tang14d oran14d grfrj14d straw14d blueb14d peach14d apric14d
            tom14d tosau14d salsa14d sbean14d brocc14d cauli14d cabb14d bruss14d rcar14d ccar14d corn14d mixv14d yam14d osqua14d eggpl14d kale14d cspin14d rspin14d ilett14d rlett14d grpep14d oniov14d
            beer14d lbeer14d rwine14d wwine14d liq14d            
            aj14d ojca14d ojreg14d grfrj14d othj14d toj14d
            cbvcfs14d otsug14d punch14d
            dcaf14d coff14d
            brice14d
            wrice14d
            cdyw14d cdywo14d dchoc14d mchoc14d);

%h14_nts(keep=calor14n whgrn14n rfgrn14n gl14n gid14n na14n poly14n omega14n trn1114n afat14n vfat14n pot_carb14n trn1114n);
%h14_ant(keep=whgrn14a);
proc sort data=h14_ant;by id;run;

data hp14;
    set hp14;

    array foods {*} fries14d pot14d pchip14d
            dog14d bacon14d sbol14d oprom14d
            hambl14d hamb14d bmix14d pmain14d bmain14d
            ctdog14d ctsan14d chwi14d chwo14d
            ctuna14d bfsh14d dkfsh14d ofish14d
            eggom14d egg14d
            whole14d cream14d icecr14d crmch14d otch14d
            skim14d mlk1214d sherb14d plyog14d artyog14d sweyog14d cotch14d 
            soym14d tofu14d
            pbut14d pnut14d wnut14d onut14d
            bean14d peas14d hummus14d
            rais14d prune14d ban14d cant14d avo14d appl14d tang14d oran14d grfrj14d straw14d blueb14d peach14d apric14d
            tom14d tosau14d salsa14d sbean14d brocc14d cauli14d cabb14d bruss14d rcar14d ccar14d corn14d mixv14d yam14d osqua14d eggpl14d kale14d cspin14d rspin14d ilett14d rlett14d grpep14d oniov14d
            aj14d ojca14d ojreg14d grfrj14d othj14d toj14d
            beer14d lbeer14d rwine14d wwine14d liq14d
            cbvcfs14d otsug14d punch14d
            dcaf14d coff14d
            brice14d
            wrice14d
            cdyw14d cdywo14d dchoc14d mchoc14d;
    array foods2 {*} fries14ds pot14ds pchip14ds
            dog14ds bacon14ds sbol14ds oprom14ds
            hambl14ds hamb14ds bmix14ds pmain14ds bmain14ds
            ctdog14ds ctsan14ds chwi14ds chwo14ds
            ctuna14ds bfsh14ds dkfsh14ds ofish14ds
            eggom14ds egg14ds
            whole14ds cream14ds icecr14ds crmch14ds otch14ds
            skim14ds mlk1214ds sherb14ds plyog14ds artyog14ds sweyog14ds cotch14ds 
            soym14ds tofu14ds
            pbut14ds pnut14ds wnut14ds onut14ds
            bean14ds peas14ds hummus14ds
            rais14ds prune14ds ban14ds cant14ds avo14ds appl14ds tang14ds oran14ds grfrj14ds straw14ds blueb14ds peach14ds apric14ds
            tom14ds tosau14ds salsa14ds sbean14ds brocc14ds cauli14ds cabb14ds bruss14ds rcar14ds ccar14ds corn14ds mixv14ds yam14ds osqua14ds eggpl14ds kale14ds cspin14ds rspin14ds ilett14ds rlett14ds grpep14ds oniov14ds
            aj14ds ojca14ds ojreg14ds grfrj14ds othj14ds toj14ds
            beer14ds lbeer14ds rwine14ds wwine14ds liq14ds
            cbvcfs14ds otsug14ds punch14ds
            dcaf14ds coff14ds
            brice14ds
            wrice14ds
            cdyw14ds cdywo14ds dchoc14ds mchoc14ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    pbut14ds = pbut14ds/2;
    bmain14ds = bmain14ds*(5/3);
    pmain14ds = pmain14ds*(5/3);

    /*Total Potato*/
    tpotat14d = sum(0, fries14ds, pot14ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot14d = sum(0, pot14ds);

    /*Fries Potato*/
    fpotat14d = sum(0, fries14ds);

    /*Chips*/
    chipss14d = sum(0, pchip14ds);

    /*Red meat*/
    prmeat14d = sum(0, dog14ds, bacon14ds, sbol14ds, oprom14ds);
    urmeat14d = sum(0, hambl14ds, hamb14ds, bmix14ds, pmain14ds, bmain14ds);
    trmeat14d = sum(0, prmeat14d, urmeat14d);

    /*Unprocessed poultry*/
    poultr14d = sum(0, ctdog14ds, ctsan14ds, chwi14ds, chwo14ds);

    /*Fish*/
    fishal14d = sum(0, ctuna14ds, bfsh14ds, dkfsh14ds, ofish14ds);

    /*Regular eggs*/
    regegg14d = sum(0, eggom14ds, egg14ds);

    /*High fat dairy*/
    if chreg14d=1 or noch14d=1 or tppt14d=1 then hfcheese14 = otch14ds; else hfcheese14 = .;
    hdairy14d = sum(0, whole14ds, cream14ds, icecr14ds, crmch14ds, hfcheese14);

    /*Low fat dairy*/
    if chlf14d = 1 or chnf14d=1  then lfcheese14 = otch14ds; else lfcheese14 = .;
    ldairy14d = sum(0, skim14ds, mlk1214ds, sherb14ds, plyog14ds, artyog14ds, sweyog14ds, cotch14ds, lfcheese14);

    /*Soy*/
    soypro14d = sum(0, soym14ds, tofu14ds);

    /*Nuts*/
    nutsal14d = sum(0, pbut14ds, pnut14ds, wnut14ds, onut14ds);

    /*Legumes*/
    legume14d = sum(0, bean14ds, peas14ds, hummus14ds);

    /*Fruits*/
    fruits14d = sum(0, rais14ds, prune14ds, ban14ds, cant14ds, avo14ds, appl14ds, tang14ds, oran14ds, grfrj14ds, straw14ds, blueb14ds, peach14ds, apric14ds);

    /*Vegetables*/
    vegeal14d = sum(0, tom14ds, tosau14ds, sbean14ds, brocc14ds, cauli14ds, cabb14ds, bruss14ds, rcar14ds, ccar14ds, corn14ds, mixv14ds, yam14ds, osqua14ds, eggpl14ds, kale14ds, cspin14ds, rspin14ds, ilett14ds, rlett14ds, oniov14ds);

   /*Non-starchy Vegetables*/
    nstveg14d = sum(0, tom14ds, tosau14ds, sbean14ds, brocc14ds, cauli14ds, cabb14ds, bruss14ds, rcar14ds, ccar14ds, mixv14ds, eggpl14ds, kale14ds, cspin14ds, rspin14ds, ilett14ds, rlett14ds, oniov14ds);

    /*Starchy Vegetables*/
    staveg14d = sum(0, corn14ds, yam14ds, osqua14ds, bean14ds, peas14ds);

    /*Dairy*/
    tdairy14d = sum(0, hdairy14d, ldairy14d);

    /*Coffee*/
    coffee14d = sum(0, dcaf14ds, coff14ds);

    /*Nut, Legumes, Beans*/
    nutleg14d = sum(0, nutsal14d, legume14d);

    /*Brown rice*/
    bwrice14d = sum(0, brice14ds);

    /*White rice*/
    wtrice14d = sum(0, wrice14ds);

    /*Sugar-sweetened beverage*/
    SSB14d = sum(0, cbvcfs14ds, otsug14ds, punch14ds);

           /*confectionery*/
   conf14d = sum(0, cdyw14ds, cdywo14ds, dchoc14ds, mchoc14ds);
run;
proc sort data=hp14;by id;run;

data h14_nts;
    set h14_nts;

    whgrns14d = whgrn14n/28;
    rfgrns14d = rfgrn14n/28;
    afat14d= afat14n/15;
    vfat14d= vfat14n/15;

run;
proc sort data=h14_nts;by id;run;


proc rank data=h14_nts group=11 out=h14_sod;
   var na14n;
   ranks na14nq;
   keep id na14nq;
run;
proc sort data=h14_sod; by id;run;

/* reverse sodium rankings to give high score for low intake **/
data h14_sod; set h14_sod;
if na14nq=10 then na14s=0;
else if na14nq=9 then na14s=1;
else if na14nq=8 then na14s=2;
else if na14nq=7 then na14s=3;
else if na14nq=6 then na14s=4;
else if na14nq=5 then na14s=5;
else if na14nq=4 then na14s=6;
else if na14nq=3 then na14s=7;
else if na14nq=2 then na14s=8;
else if na14nq=1 then na14s=9;
else if na14nq=0 then na14s=10;
proc sort; by id ;run;

data ahei14;
    merge hp14(in=a) h14_nts(in=b) h14_sod(in=c) h14_ant(in=d);
    by id;
    if a=b=c=d;

    fruit14 = sum(0, rais14ds, prune14ds, ban14ds, cant14ds, avo14ds, appl14ds, tang14ds, oran14ds, grfrj14ds, straw14ds, blueb14ds, peach14ds, apric14ds);

    tveg14 = sum(0, tom14ds, toj14ds, tosau14ds, salsa14ds, sbean14ds, brocc14ds, cauli14ds, cabb14ds, bruss14ds, rcar14ds, ccar14ds, corn14ds, mixv14ds, yam14ds, osqua14ds, eggpl14ds, kale14ds, cspin14ds, rspin14ds, ilett14ds, rlett14ds, grpep14ds, oniov14ds);

    nut14 = sum(0, bean14ds, peas14ds, hummus14ds, pbut14ds, pnut14ds, wnut14ds, onut14ds, tofu14ds);

    rmea14t = sum(0, dog14ds, bacon14ds, sbol14ds, oprom14ds, hambl14ds, hamb14ds, bmix14ds, pmain14ds, bmain14ds);

    frtjc14 = sum(0, aj14ds, ojca14ds, ojreg14ds, grfrj14ds, othj14ds, toj14ds);

    ssb14 = sum(0, cbvcfs14ds, otsug14ds, punch14ds, frtjc14);

    poly14 = poly14n - omega14n;
    ppoly14 = (poly14*900)/calor14n;
    apoly14 = (poly14n*900)/calor14n;


    pomeg14 = (omega14n*90)/calor14n;
    mgomg14 = omega14n*1000;

    ptran14 = (trn1114n*9)/calor14n;

    drinks14 = sum(0, beer14ds, lbeer14ds, rwine14ds, wwine14ds, liq14ds);

    /**
            COMPONENT #1: RED MEAT
            BEST = <1/month (<0.07)
            WORST = >1.5/day
    **/

    if rmea14t=. then rmea14t=0;

    if rmea14t le 0.07 then meataI14 = 10;
    else if rmea14t gt 0.07 then do;
            meataI14 = (1.5 - rmea14t)/0.143;
            end;
    if meataI14 le 0 then meataI14 = 0;
    else if meataI14 ge 10 then meataI14 = 10;


    /**

            COMPONENT #2 -- nuts
            BEST = >1
            WORST = 0

    **/

    if nut14 eq 0 then nutI14=0;
    else if nut14 gt 0 then do;
            nutI14 = (nut14/0.1);
            end;

    if nutI14 ge 10 then nutI14 = 10;
    if nutI14 le 0 then nutI14 = 0;

    /**

            COMPONENT #3: SSB + Fruit Juice
            BEST = 0
            WORST = 1+ per day

    **/

    if ssb14 eq 0 then ssbI14 = 10;
    else if ssb14 gt 0 then do;
            ssbI14 = 10 - (ssb14/0.1);
            end;
    if ssbI14 ge 10 then ssbI14 = 10;
    if ssbI14 le 0 then ssbI14  = 0;

    /**

            COMPONENT #4: Total vegetables
            BEST = 5+
            WORST = 0

    **/

    if tveg14 = 0 then tvegI14=0;
    else if tveg14 gt 0 then do;
            tvegI14 = tveg14/0.5;
            end;
    if tvegI14 ge 10 then tvegI14 = 10;
    if tvegI14 le 0 then tvegI14  = 0;

    /**

            COMPONENT #5: Fruits
            BEST = 4+
            WORST = 0

    **/

    if  fruit14 eq 0 then frtI14a=0;
    else if fruit14 gt 0 then do;
            frtI14a = fruit14/0.4;
            end;
    if frtI14a ge 10 then frtI14a = 10;
    if frtI14a le 0 then frtI14a  = 0;

    /**

            COMPONENT #6: Poly fat
            Best: >10%
            Worst: <2%

    **/
    if ppoly14 le 2 then ppolyI14 = 0;
    else if ppoly14 gt 2 then do;
            ppolyI14 = (ppoly14-2)/0.8;
            end;
    if ppolyI14 le 0 then ppolyI14=0;
    if ppolyI14 ge 10 then ppolyI14=10;

    if apoly14 le 2 then polyI14 = 0;
    else if apoly14 gt 2 then do;
            polyI14 = (apoly14-2)/0.8;
            end;
    if polyI14 le 0 then polyI14=0;
    if polyI14 ge 10 then polyI14=10;

    /**

            COMPONENT #7 -- trans fat
            BEST = <0.5%
            WORST = >4%

    **/

    if ptran14 le 0.005 then tranI14=10;

    if ptran14 le 0.005 then tranI14=10;
    else if ptran14 gt 0.005 then do;

            tranI14 = (0.04-ptran14)/0.0035;
            end;

    if tranI14 ge 10 then tranI14 = 10;
    if tranI14 le 0 then tranI14 = 0;

    /**

            COMPONENT #8 -- ALCOHOL
            best = 0.5 - 1.5 drinks/day
            worst = 0 or >2.5 /day

    **/


    if             drinks14 eq 0   then nETOHI14b=2.5;
    else if 0   lt drinks14 lt 0.5 then nETOHI14b=5.0;
    else if 0.5 le drinks14 le 2.0 then nETOHI14b=10;
    else if 2.0 lt drinks14 le 2.5 then nETOHI14b=5.0;
    else if 2.5 lt drinks14 lt 3.5 then nETOHI14b=2.5;
    else if        drinks14 ge 3.5 then nETOHI14b=0;


    /**

            COMPONENT #9 -- omega
            best = 250+ mg/day
            worst = 0 day

    **/

    if mgomg14=0 then omegI14=0;
    else if mgomg14 gt 0 then do;
            omegI14 = mgomg14/25;
            end;

    if omegI14 le 0 then omegI14 = 0;
    else if omegI14 ge 10 then omegI14 = 10;


    /**

            COMPONENT #10: Whole grains
            best = 90 g
            worst = 0 g

    **/

    if whgrn14a eq 0 then wgI14=0;
    else if whgrn14a gt 0 then do;
            wgI14 = whgrn14a/9;
            end;
    if wgI14 ge 10 then wgI14 = 10;
    if wgI14 le 0 then wgI14  = 0;

    nAHEI14a = sum(meataI14, nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, omegI14, wgI14, na14s);
    ahei14=nAHEI14a; 
    aheinoal14 = sum(meataI14, nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, omegI14, wgI14, na14s);
    aheinopt14 = sum (meataI14, nutI14, ssbI14, tvegI14, frtI14a, nETOHI14b, omegI14, wgI14, na14s);
    aheifisha14 = sum(nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, wgI14, na14s);
    aheidairy14 = sum(nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, omegI14, wgI14, na14s);
    aheinutbl14 = sum(ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, omegI14, wgI14, na14s);
    aheipoult14 = sum(nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, omegI14, wgI14, na14s);
    aheineggs14 = sum(nutI14, ssbI14, tvegI14, frtI14a, ppolyI14, tranI14, nETOHI14b, omegI14, wgI14, na14s);
run;
proc sort data=ahei14;by id;run;



%hp18(keep= fries18d pot18d pchip18d
            dog18d bacon18d sbol18d oprom18d
            hambl18d hamb18d bmix18d pmain18d bmain18d
            ctdog18d ctsan18d chwi18d chwo18d
            ctuna18d bfsh18d dkfsh18d ofish18d
            eggom18d egg18d
            whole18d cream18d icecr18d crmch18d otch18d chreg18d chlf18d chnf18d noch18d tppt18d
            skim18d mlk1218d sherb18d plyog18d artyog18d sweyog18d cotch18d 
            soym18d tofu18d
            pbut18d pnut18d wnut18d onut18d
            bean18d peas18d hummus18d
            rais18d prune18d ban18d cant18d avo18d appl18d tang18d oran18d grfrj18d straw18d blueb18d peach18d apric18d
            tom18d toj18d tosau18d salsa18d sbean18d brocc18d cauli18d cabb18d bruss18d rcar18d ccar18d corn18d mixv18d yam18d osqua18d eggpl18d kale18d cspin18d rspin18d ilett18d rlett18d grpep18d oniov18d
            aj18d ojca18d ojreg18d grfrj18d othj18d toj18d
            beer18d lbeer18d rwine18d wwine18d liq18d
            cbvcfs18d otsug18d punch18d
            dcaf18d coff18d
            brice18d
            wrice18d
            cdyw18d cdywo18d dchoc18d mchoc18d);

%h18_nts(keep=calor18n whgrn18n rfgrn18n gl18n gid18n na18n poly18n omega18n afat18n vfat18n pot_carb18n);
%h18_ant(keep=whgrn18a);
proc sort data=h18_ant;by id;run;

data hp18;
    set hp18;

    array foods {*} fries18d pot18d pchip18d
            dog18d bacon18d sbol18d oprom18d
            hambl18d hamb18d bmix18d pmain18d bmain18d
            ctdog18d ctsan18d chwi18d chwo18d
            ctuna18d bfsh18d dkfsh18d ofish18d
            eggom18d egg18d
            whole18d cream18d icecr18d crmch18d otch18d chreg18d chlf18d chnf18d noch18d tppt18d
            skim18d mlk1218d sherb18d plyog18d artyog18d sweyog18d cotch18d 
            soym18d tofu18d
            pbut18d pnut18d wnut18d onut18d
            bean18d peas18d hummus18d
            rais18d prune18d ban18d cant18d avo18d appl18d tang18d oran18d grfrj18d straw18d blueb18d peach18d apric18d
            tom18d toj18d tosau18d salsa18d sbean18d brocc18d cauli18d cabb18d bruss18d rcar18d ccar18d corn18d mixv18d yam18d osqua18d eggpl18d kale18d cspin18d rspin18d ilett18d rlett18d grpep18d oniov18d
            aj18d ojca18d ojreg18d grfrj18d othj18d toj18d
            beer18d lbeer18d rwine18d wwine18d liq18d
            cbvcfs18d otsug18d punch18d
            dcaf18d coff18d
            brice18d
            wrice18d
            cdyw18d cdywo18d dchoc18d mchoc18d;
    array foods2 {*} fries18ds pot18ds pchip18ds
            dog18ds bacon18ds sbol18ds oprom18ds
            hambl18ds hamb18ds bmix18ds pmain18ds bmain18ds
            ctdog18ds ctsan18ds chwi18ds chwo18ds
            ctuna18ds bfsh18ds dkfsh18ds ofish18ds
            eggom18ds egg18ds
            whole18ds cream18ds icecr18ds crmch18ds otch18ds chreg18ds chlf18ds chnf18ds noch18ds tppt18ds
            skim18ds mlk1218ds sherb18ds plyog18ds artyog18ds sweyog18ds cotch18ds 
            soym18ds tofu18ds
            pbut18ds pnut18ds wnut18ds onut18ds
            bean18ds peas18ds hummus18ds
            rais18ds prune18ds ban18ds cant18ds avo18ds appl18ds tang18ds oran18ds grfrj18ds straw18ds blueb18ds peach18ds apric18ds
            tom18ds toj18ds tosau18ds salsa18ds sbean18ds brocc18ds cauli18ds cabb18ds bruss18ds rcar18ds ccar18ds corn18ds mixv18ds yam18ds osqua18ds eggpl18ds kale18ds cspin18ds rspin18ds ilett18ds rlett18ds grpep18ds oniov18ds
            aj18ds ojca18ds ojreg18ds grfrj18ds othj18ds toj18ds
            beer18ds lbeer18ds rwine18ds wwine18ds liq18ds
            cbvcfs18ds otsug18ds punch18ds
            dcaf18ds coff18ds
            brice18ds
            wrice18ds
            cdyw18ds cdywo18ds dchoc18ds mchoc18ds;

    do i = 1 to DIM(foods2);
        if foods{i}=0 then foods2{i}=0;
        if foods{i}=1 then foods2{i}=0.07;
        if foods{i}=2 then foods2{i}=0.14;
        if foods{i}=3 then foods2{i}=0.43;
        if foods{i}=4 then foods2{i}=0.79;
        if foods{i}=5 then foods2{i}=1;
        if foods{i}=6 then foods2{i}=2.5;
        if foods{i}=7 then foods2{i}=4.5;
        if foods{i}=8 then foods2{i}=6;
        if foods{i}=9 or foods{i}=. then foods2{i}=.;
    end;

    pbut18ds = pbut18ds/2;
    bmain18ds = bmain18ds*(5/3);
    pmain18ds = pmain18ds*(5/3);

    /*Total Potato*/
    tpotat18d = sum(0, fries18ds, pot18ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot18d = sum(0, pot18ds);

    /*Fries Potato*/
    fpotat18d = sum(0, fries18ds);

    /*Chips*/
    chipss18d = sum(0, pchip18ds);

    /*Red meat*/
    prmeat18d = sum(0, dog18ds, bacon18ds, sbol18ds, oprom18ds);
    urmeat18d = sum(0, hambl18ds, hamb18ds, bmix18ds, pmain18ds, bmain18ds);
    trmeat18d = sum(0, prmeat18d, urmeat18d);

    /*Unprocessed poultry*/
    poultr18d = sum(0, ctdog18ds, ctsan18ds, chwi18ds, chwo18ds);

    /*Fish*/
    fishal18d = sum(0, ctuna18ds, bfsh18ds, dkfsh18ds, ofish18ds);

    /*Regular eggs*/
    regegg18d = sum(0, eggom18ds, egg18ds);

    /*High fat dairy*/
    if chreg18d=1 or noch18d=1 or tppt18d=1 then hfcheese18 = otch18ds; else hfcheese18 = .;
    hdairy18d = sum(0, whole18ds, cream18ds, icecr18ds, crmch18ds, hfcheese18);

    /*Low fat dairy*/
    if chlf18d = 1 or chnf18d=1  then lfcheese18 = otch18ds; else lfcheese18 = .;
    ldairy18d = sum(0, skim18ds, mlk1218ds, sherb18ds, plyog18ds, artyog18ds, sweyog18ds, cotch18ds, lfcheese18);

    /*Soy*/
    soypro18d = sum(0, soym18ds, tofu18ds);

    /*Nuts*/
    nutsal18d = sum(0, pbut18ds, pnut18ds, wnut18ds, onut18ds);

    /*Legumes*/
    legume18d = sum(0, bean18ds, peas18ds, hummus18ds);

    /*Fruits*/
    fruits18d = sum(0, rais18ds, prune18ds, ban18ds, cant18ds, avo18ds, appl18ds, tang18ds, oran18ds, grfrj18ds, straw18ds, blueb18ds, peach18ds, apric18ds);

    /*Vegetables*/
    vegeal18d = sum(0, tom18ds, tosau18ds, sbean18ds, brocc18ds, cauli18ds, cabb18ds, bruss18ds, rcar18ds, ccar18ds, corn18ds, mixv18ds, yam18ds, osqua18ds, eggpl18ds, kale18ds, cspin18ds, rspin18ds, ilett18ds, rlett18ds, oniov18ds);

   /*Non-starchy Vegetables*/
    nstveg18d = sum(0, tom18ds, tosau18ds, sbean18ds, brocc18ds, cauli18ds, cabb18ds, bruss18ds, rcar18ds, ccar18ds, mixv18ds, eggpl18ds, kale18ds, cspin18ds, rspin18ds, ilett18ds, rlett18ds, oniov18ds);

    /*Starchy Vegetables*/
    staveg18d = sum(0, corn18ds, yam18ds, osqua18ds, bean18ds, peas18ds);

    /*Dairy*/
    tdairy18d = sum(0, hdairy18d, ldairy18d);

    /*Coffee*/
    coffee18d = sum(0, dcaf18d, coff18d);

    /*Nut, Legumes, Beans*/
    nutleg18d = sum(0, nutsal18d, legume18d);

    /*Brown rice*/
    bwrice18d = sum(0, brice18ds);

    /*White rice*/
    wtrice18d = sum(0, wrice18ds);

    /*Sugar-sweetened beverage*/
    SSB18d = sum(0, cbvcfs18ds, otsug18ds, punch18ds);

           /*confectionery*/
   conf18d = sum(0, cdyw18ds, cdywo18ds, dchoc18ds, mchoc18ds);
run;
proc sort data=hp18;by id;run;

data h18_nts;
    set h18_nts;

    whgrns18d = whgrn18n/28;
    rfgrns18d = rfgrn18n/28;
    afat18d= afat18n/15;
    vfat18d= vfat18n/15;

run;
proc sort data=h18_nts;by id;run;


proc rank data=h18_nts group=11 out=h18_sod;
   var na18n;
   ranks na18nq;
   keep id na18nq;
run;
proc sort data=h18_sod; by id;run;

/* reverse sodium rankings to give high score for low intake **/
data h18_sod; set h18_sod;
if na18nq=10 then na18s=0;
else if na18nq=9 then na18s=1;
else if na18nq=8 then na18s=2;
else if na18nq=7 then na18s=3;
else if na18nq=6 then na18s=4;
else if na18nq=5 then na18s=5;
else if na18nq=4 then na18s=6;
else if na18nq=3 then na18s=7;
else if na18nq=2 then na18s=8;
else if na18nq=1 then na18s=9;
else if na18nq=0 then na18s=10;
proc sort; by id ;run;

data ahei18;
    merge hp18(in=a) h18_nts(in=b) h18_sod(in=c) h18_ant(in=d) h14_nts(in=e);
    by id;
    if a=b=c=d;

    fruit18 = sum(0, rais18ds, prune18ds, ban18ds, cant18ds, avo18ds, appl18ds, tang18ds, oran18ds, grfrj18ds, straw18ds, blueb18ds, peach18ds, apric18ds);

    tveg18 = sum(0, tom18ds, toj18ds, tosau18ds, salsa18ds, sbean18ds, brocc18ds, cauli18ds, cabb18ds, bruss18ds, rcar18ds, ccar18ds, corn18ds, mixv18ds, yam18ds, osqua18ds, eggpl18ds, kale18ds, cspin18ds, rspin18ds, ilett18ds, rlett18ds, grpep18ds, oniov18ds);

    nut18 = sum(0, bean18ds, peas18ds, hummus18ds, pbut18ds, pnut18ds, wnut18ds, onut18ds, tofu18ds);

    rmea18t = sum(0, dog18ds, bacon18ds, sbol18ds, oprom18ds, hambl18ds, hamb18ds, bmix18ds, pmain18ds, bmain18ds);

    frtjc18 = sum(0, aj18ds, ojca18ds, ojreg18ds, grfrj18ds, othj18ds, toj18ds);

    ssb18 = sum(0, cbvcfs18ds, otsug18ds, punch18ds, frtjc18);

    poly18 = poly18n - omega18n;
    ppoly18 = (poly18*900)/calor18n;
    apoly18 = (poly18n*900)/calor18n;


    pomeg18 = (omega18n*90)/calor18n;
    mgomg18 = omega18n*1000;

    if trn1114n=. then trn1114n = 1.030000;

    ptran18 = (trn1114n*9)/calor14n;

    drinks18 = sum(0, beer18ds, lbeer18ds, rwine18ds, wwine18ds, liq18ds);

    /**
            COMPONENT #1: RED MEAT
            BEST = <1/month (<0.07)
            WORST = >1.5/day
    **/

    if rmea18t=. then rmea18t=0;

    if rmea18t le 0.07 then meataI18 = 10;
    else if rmea18t gt 0.07 then do;
            meataI18 = (1.5 - rmea18t)/0.143;
            end;
    if meataI18 le 0 then meataI18 = 0;
    else if meataI18 ge 10 then meataI18 = 10;


    /**

            COMPONENT #2 -- nuts
            BEST = >1
            WORST = 0

    **/

    if nut18 eq 0 then nutI18=0;
    else if nut18 gt 0 then do;
            nutI18 = (nut18/0.1);
            end;

    if nutI18 ge 10 then nutI18 = 10;
    if nutI18 le 0 then nutI18 = 0;

    /**

            COMPONENT #3: SSB + Fruit Juice
            BEST = 0
            WORST = 1+ per day

    **/

    if ssb18 eq 0 then ssbI18 = 10;
    else if ssb18 gt 0 then do;
            ssbI18 = 10 - (ssb18/0.1);
            end;
    if ssbI18 ge 10 then ssbI18 = 10;
    if ssbI18 le 0 then ssbI18  = 0;

    /**

            COMPONENT #4: Total vegetables
            BEST = 5+
            WORST = 0

    **/

    if tveg18 = 0 then tvegI18=0;
    else if tveg18 gt 0 then do;
            tvegI18 = tveg18/0.5;
            end;
    if tvegI18 ge 10 then tvegI18 = 10;
    if tvegI18 le 0 then tvegI18  = 0;

    /**

            COMPONENT #5: Fruits
            BEST = 4+
            WORST = 0

    **/

    if  fruit18 eq 0 then frtI18a=0;
    else if fruit18 gt 0 then do;
            frtI18a = fruit18/0.4;
            end;
    if frtI18a ge 10 then frtI18a = 10;
    if frtI18a le 0 then frtI18a  = 0;

    /**

            COMPONENT #6: Poly fat
            Best: >10%
            Worst: <2%

    **/
    if ppoly18 le 2 then ppolyI18 = 0;
    else if ppoly18 gt 2 then do;
            ppolyI18 = (ppoly18-2)/0.8;
            end;
    if ppolyI18 le 0 then ppolyI18=0;
    if ppolyI18 ge 10 then ppolyI18=10;

    if apoly18 le 2 then polyI18 = 0;
    else if apoly18 gt 2 then do;
            polyI18 = (apoly18-2)/0.8;
            end;
    if polyI18 le 0 then polyI18=0;
    if polyI18 ge 10 then polyI18=10;

    /**

            COMPONENT #7 -- trans fat
            BEST = <0.5%
            WORST = >4%

    **/

    if ptran18 le 0.005 then tranI18=10;

    if ptran18 le 0.005 then tranI18=10;
    else if ptran18 gt 0.005 then do;

            tranI18 = (0.04-ptran18)/0.0035;
            end;

    if tranI18 ge 10 then tranI18 = 10;
    if tranI18 le 0 then tranI18 = 0;

    /**

            COMPONENT #8 -- ALCOHOL
            best = 0.5 - 1.5 drinks/day
            worst = 0 or >2.5 /day

    **/


    if             drinks18 eq 0   then nETOHI18b=2.5;
    else if 0   lt drinks18 lt 0.5 then nETOHI18b=5.0;
    else if 0.5 le drinks18 le 2.0 then nETOHI18b=10;
    else if 2.0 lt drinks18 le 2.5 then nETOHI18b=5.0;
    else if 2.5 lt drinks18 lt 3.5 then nETOHI18b=2.5;
    else if        drinks18 ge 3.5 then nETOHI18b=0;


    /**

            COMPONENT #9 -- omega
            best = 250+ mg/day
            worst = 0 day

    **/

    if mgomg18=0 then omegI18=0;
    else if mgomg18 gt 0 then do;
            omegI18 = mgomg18/25;
            end;

    if omegI18 le 0 then omegI18 = 0;
    else if omegI18 ge 10 then omegI18 = 10;


    /**

            COMPONENT #10: Whole grains
            best = 90 g
            worst = 0 g

    **/

    if whgrn18a eq 0 then wgI18=0;
    else if whgrn18a gt 0 then do;
            wgI18 = whgrn18a/9;
            end;
    if wgI18 ge 10 then wgI18 = 10;
    if wgI18 le 0 then wgI18  = 0;

    nAHEI18a = sum(meataI18, nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, omegI18, wgI18, na18s);
    ahei18=nAHEI18a; 
    aheinoal18 = sum(meataI18, nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, omegI18, wgI18, na18s);
    aheinopt18 = sum(meataI18, nutI18, ssbI18, tvegI18, frtI18a, nETOHI18b, omegI18, wgI18, na18s);
    aheifisha18 = sum(nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, wgI18, na18s);
    aheidairy18 = sum(nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, omegI18, wgI18, na18s);
    aheinutbl18 = sum(ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, omegI18, wgI18, na18s);
    aheipoult18 = sum(nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, omegI18, wgI18, na18s);
    aheineggs18 = sum(nutI18, ssbI18, tvegI18, frtI18a, ppolyI18, tranI18, nETOHI18b, omegI18, wgI18, na18s);
run;
proc sort data=ahei18;by id;run;


data foods;
    merge /*h86_tf*/ h86_dt h86_nts h90_dt h90_nts h94_dt h94_nts h98_dt h98_nts hp02 h02_nts hp06 h06_nts hp10 h10_nts hp14 h14_nts hp18 h18_nts ahei14 ahei18;
    by id;
run;

/*PROC DATASETS;
    delete h86_tf h86_dt h86_nts h90_dt h90_nts h94_dt h94_nts h98_dt h98_nts hp02 h02_nts hp06 h06_nts hp10 h10_nts hp14 h14_nts hp18 h18_nts ahei14;
RUN;*/


proc means data=foods;var tpotat86d tpotat90d tpotat94d tpotat98d tpotat02d tpotat06d tpotat10d tpotat14d tpotat18d
                          bbmpot86d bbmpot90d bbmpot94d bbmpot98d bbmpot02d bbmpot06d bbmpot10d bbmpot14d bbmpot18d
                          fpotat86d fpotat90d fpotat94d fpotat98d fpotat02d fpotat06d fpotat10d fpotat14d fpotat18d
                          chipss86d chipss90d chipss94d chipss98d chipss02d chipss06d chipss10d chipss14d chipss18d  
                          trmeat86d trmeat90d trmeat94d trmeat98d trmeat02d trmeat06d trmeat10d trmeat14d trmeat18d
                          prmeat86d prmeat90d prmeat94d prmeat98d prmeat02d prmeat06d prmeat10d prmeat14d prmeat18d
                          urmeat86d urmeat90d urmeat94d urmeat98d urmeat02d urmeat06d urmeat10d urmeat14d urmeat18d
                          poultr86d poultr90d poultr94d poultr98d poultr02d poultr06d poultr10d poultr14d poultr18d
                          fishal86d fishal90d fishal94d fishal98d fishal02d fishal06d fishal10d fishal14d fishal18d
                          regegg86d regegg90d regegg94d regegg98d regegg02d regegg06d regegg10d regegg14d regegg18d
                          hdairy86d hdairy90d hdairy94d hdairy98d hdairy02d hdairy06d hdairy10d hdairy14d hdairy18d
                          ldairy86d ldairy90d ldairy94d ldairy98d ldairy02d ldairy06d ldairy10d ldairy14d ldairy18d
                          soypro86d soypro90d soypro94d soypro98d soypro02d soypro06d soypro10d soypro14d soypro18d
                          nutsal86d nutsal90d nutsal94d nutsal98d nutsal02d nutsal06d nutsal10d nutsal14d nutsal18d
                          legume86d legume90d legume94d legume98d legume02d legume06d legume10d legume14d legume18d
                          fruits86d fruits90d fruits94d fruits98d fruits02d fruits06d fruits10d fruits14d fruits18d
                          vegeal86d vegeal90d vegeal94d vegeal98d vegeal02d vegeal06d vegeal10d vegeal14d vegeal18d
                          nstveg86d nstveg90d nstveg94d nstveg98d nstveg02d nstveg06d nstveg10d nstveg14d nstveg18d
                          staveg86d staveg90d staveg94d staveg98d staveg02d staveg06d staveg10d staveg14d staveg18d    
                          tdairy86d tdairy90d tdairy94d tdairy98d tdairy02d tdairy06d tdairy10d tdairy14d tdairy18d
                          coffee86d coffee90d coffee94d coffee98d coffee02d coffee06d coffee10d coffee14d coffee18d  
                          nutleg86d nutleg90d nutleg94d nutleg98d nutleg02d nutleg06d nutleg10d nutleg14d nutleg18d
                          bwrice86d bwrice90d bwrice94d bwrice98d bwrice02d bwrice06d bwrice10d bwrice14d bwrice18d
                          wtrice86d wtrice90d wtrice94d wtrice98d wtrice02d wtrice06d wtrice10d wtrice14d wtrice18d
                          SSB86d SSB90d SSB94d SSB98d SSB02d SSB06d SSB10d SSB14d SSB18d
                          trnss86n trnss90n trnss94n ttrn098n trn0202n trn0706n trn1110n trn1114n
                          afat86d afat90d afat94d afat98d afat02d afat06d afat10d afat14d afat18d
                          vfat86d vfat90d vfat94d vfat98d vfat02d vfat06d vfat10d vfat14d vfat18d
                          ahei14 aheinoal14 aheinopt14 aheifisha14 aheidairy14 aheinutbl14 aheipoult14 aheineggs14
                          ahei18 aheinoal18 aheinopt18 aheifisha18 aheidairy18 aheinutbl18 aheipoult18 aheineggs18
                          conf86d conf90d conf94d conf98d conf02d conf06d conf10d conf14d conf18d;run;












