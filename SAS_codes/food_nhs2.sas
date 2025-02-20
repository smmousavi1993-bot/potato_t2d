%serv91(keep= fries_s91 pot_s91 pchip_s91
              dog_s91 bacon_s91 procm_s91
              hamb_s91 bmix_s91 pmain_s91 bmain_s91
              turk_s91 chwi_s91 chwo_s91
              ctuna_s91 dkfsh_s91 ofish_s91
              egg_s91
              whole_s91 cream_s91 icecr_s91 but_s91 sour_s91 cotch_s91 crmch_s91 otch_s91
              skim_s91 sherb_s91 yog_s91
              tofu_s91 
              pbut_s91 pnut_s91 onut_s91 
              peas_s91 bean_s91
              rais_s91 prune_s91 ban_s91 cant_s91 avo_s91 appl_s91 oran_s91 grfr_s91 straw_s91 blueb_s91 peach_s91
              tom_s91 tosau_s91 sbean_s91 brocc_s91 cauli_s91 cabb_s91 bruss_s91 rcar_s91 ccar_s91 corn_s91 mixv_s91 yam_s91 osqua_s91 eggpl_s91 kale_s91 rspin_s91 cspin_s91 ilett_s91 rlett_s91 cel_s91 oniov_s91 beet_s91
              cola_s91 cnoc_s91 otsug_s91 punch_s91
              dcaf_s91 coff_s91
              brice_s91
              wrice_s91
              cdywo_s91 cdyw_s91 choco_s91);


%n91_nts(keep= whgrn91n rfgrn91n gl91n gid91n afat91n vfat91n calor91n pot_carb91n trnss91n);


data food91;
    set serv91;
run;

data food91;
    set food91;

    /*Total Potato*/
    tpotat91d = sum(0, fries_s91, pot_s91);

    /*Baked, boiled, mashed Potato*/
    bbmpot91d = sum(0, pot_s91);

    /*Fries Potato*/
    fpotat91d = sum(0, fries_s91);

    /*Chips*/
    chipss91d = sum(0, pchip_s91);

    /*Red meat*/
    prmeat91d = sum(0, dog_s91, bacon_s91, procm_s91);
    urmeat91d = sum(0, hamb_s91, bmix_s91, pmain_s91, bmain_s91);
    trmeat91d = sum(0, prmeat91d, urmeat91d);
    
    /*Unprocessed poultry*/
    poultr91d = sum(0, turk_s91, chwi_s91, chwo_s91);

    /*Fish*/
    fishal91d = sum(0, ctuna_s91, dkfsh_s91, ofish_s91);

    /*Regular eggs*/
    regegg91d = sum(0, egg_s91);

    /*High fat dairy*/
    hdairy91d = sum(0, whole_s91, cream_s91, icecr_s91, sour_s91, crmch_s91, otch_s91);

    /*Low fat dairy*/
    ldairy91d = sum(0, skim_s91, sherb_s91, yog_s91, cotch_s91);

    /*Soy*/
    soypro91d = sum(0, tofu_s91);

    /*Nuts*/
    nutsal91d = sum(0, pbut_s91, pnut_s91, onut_s91 );

    /*Legumes*/
    legume91d = sum(0, peas_s91, bean_s91);

    /*Fruits*/
    fruits91d = sum(0, rais_s91, prune_s91, ban_s91, cant_s91, avo_s91, appl_s91, oran_s91, grfr_s91, straw_s91, blueb_s91, peach_s91);

    /*Vegetables*/
    vegeal91d = sum(0, tom_s91, tosau_s91, sbean_s91, brocc_s91, cauli_s91, cabb_s91, bruss_s91, rcar_s91, ccar_s91,  mixv_s91, yam_s91, osqua_s91, eggpl_s91, kale_s91, rspin_s91, cspin_s91, ilett_s91, rlett_s91, cel_s91, oniov_s91, beet_s91);

    /*Non-starchy Vegetables*/
    nstveg91d = sum(0, tom_s91, tosau_s91, sbean_s91, brocc_s91, cauli_s91, cabb_s91, bruss_s91, rcar_s91, ccar_s91, mixv_s91, eggpl_s91, kale_s91, rspin_s91, cspin_s91, ilett_s91, rlett_s91, cel_s91, oniov_s91, beet_s91);

    /*Starchy Vegetables*/
    staveg91d = sum(0, corn_s91, yam_s91, osqua_s91, peas_s91, bean_s91);

    /*Dairy*/
    tdairy91d = sum(0, hdairy91d, ldairy91d);

    /*Coffee*/
    coffee91d = sum(0, dcaf_s91, coff_s91);

    /*Nut, Legumes, Beans*/
    nutleg91d = sum(0, nutsal91d, legume91d);

    /*Brown rice*/
    bwrice91d = sum(0, brice_s91);

    /*White rice*/
    wtrice91d = sum(0, wrice_s91);
     
    /*Sugar sweetened beverages*/
    SSB91d = sum(0, cola_s91, cnoc_s91, otsug_s91, punch_s91);

    /*confectionery*/
   conf91d = sum(0, cdywo_s91, cdyw_s91, choco_s91);
run;

data n91_nts;
    set n91_nts;

    whgrns91d = whgrn91n/28;
    rfgrns91d = rfgrn91n/28;
    afat91d= afat91n/15;
    vfat91d= vfat91n/15;

run;



%serv95(keep= fries_s95 pot_s95 pchip_s95
              bacon_s95 procm_s95 bfdog_s95
              hamb_s95 hambl_s95 bmix_s95 pmain_s95 bmain_s95
              ctdog_s95 chwi_s95 chwo_s95
              ctuna_s95 bfsh_s95 dkfsh_s95 ofish_s95
              egg_s95
              whole_s95 cream_s95 icecr_s95 but_s95 cotch_s95 crmch_s95 otch_s95
              skim_s95 m1or2_s95 sherb_s95 plyog_s95 flyog_s95
              tofu_s95
              pbut_s95 pnut_s95 onut_s95 
              peas_s95 bean_s95
              rais_s95 prune_s95 ban_s95 cant_s95 avo_s95 appl_s95 oran_s95 grfr_s95 straw_s95 blueb_s95 peach_s95
              tom_s95 tosau_s95 sbean_s95 brocc_s95 cauli_s95 cabb_s95 bruss_s95 rcar_s95 ccar_s95 corn_s95 mixv_s95 yam_s95 osqua_s95 eggpl_s95 kale_s95 rspin_s95 cspin_s95 ilett_s95 rlett_s95 cel_s95 oniov_s95
              cola_s95 cnoc_s95 otsug_s95 punch_s95
              dcaf_s95 coff_s95
              brice_s95
              wrice_s95
              cdywo_s95 cdyw_s95 choco_s95);

%n95_dt(keep= chtyp95d);
%n95_nts(keep= whgrn95n rfgrn95n gl95n gid95n afat95n vfat95n calor95n pot_carb95n trnss95n);

data food95;
    merge serv95 n95_dt;
    by id;
run;

data food95;
    set food95;

    /*Total Potato*/
    tpotat95d = sum(0, fries_s95, pot_s95);

    /*Baked, boiled, mashed Potato*/
    bbmpot95d = sum(0, pot_s95);

    /*Fries Potato*/
    fpotat95d = sum(0, fries_s95);

    /*Chips*/
    chipss95d = sum(0, pchip_s95);

    /*Red meat*/
    prmeat95d = sum(0, bacon_s95, procm_s95, bfdog_s95);
    urmeat95d = sum(0, hamb_s95, hambl_s95, bmix_s95, pmain_s95, bmain_s95);
    trmeat95d = sum(0, prmeat95d, urmeat95d);
    
    /*Unprocessed poultry*/
    poultr95d = sum(0, ctdog_s95, chwi_s95, chwo_s95);

    /*Fish*/
    fishal95d = sum(0, ctuna_s95, bfsh_s95, dkfsh_s95, ofish_s95);

    /*Regular eggs*/
    regegg95d = sum(0, egg_s95);

    /*High fat dairy*/
    if chtyp95d in (1,3,4) then hfcheese95 = otch_s95; else hfcheese95 = .;
    hdairy95d = sum(0, whole_s95, cream_s95, icecr_s95, crmch_s95, hfcheese95);

    /*Low fat dairy*/
    if chtyp95d = 2 then lfcheese95 = otch_s95; else lfcheese95 = .;
    ldairy95d = sum(0, skim_s95, m1or2_s95, sherb_s95, plyog_s95, flyog_s95, cotch_s95, lfcheese95);

    /*Soy*/
    soypro95d = sum(0, tofu_s95);

    /*Nuts*/
    nutsal95d = sum(0, pbut_s95, pnut_s95, onut_s95 );

    /*Legumes*/
    legume95d = sum(0, peas_s95, bean_s95);

    /*Fruits*/
    fruits95d = sum(0, rais_s95, prune_s95, ban_s95, cant_s95, avo_s95, appl_s95, oran_s95, grfr_s95, straw_s95, blueb_s95, peach_s95);

    /*Vegetables*/
    vegeal95d = sum(0, tom_s95, tosau_s95, sbean_s95, brocc_s95, cauli_s95, cabb_s95, bruss_s95, rcar_s95, ccar_s95, corn_s95, mixv_s95, yam_s95, osqua_s95, eggpl_s95, kale_s95, rspin_s95, cspin_s95, ilett_s95, rlett_s95, cel_s95, oniov_s95);

    /*Non-starchy Vegetables*/
    nstveg95d = sum(0, tom_s95, tosau_s95, sbean_s95, brocc_s95, cauli_s95, cabb_s95, bruss_s95, rcar_s95, ccar_s95, mixv_s95, eggpl_s95, kale_s95, rspin_s95, cspin_s95, ilett_s95, rlett_s95, cel_s95, oniov_s95);

    /*Starchy Vegetables*/
    staveg95d = sum(0, corn_s95,yam_s95, osqua_s95, peas_s95, bean_s95);

    /*Dairy*/
    tdairy95d = sum(0, hdairy95d, ldairy95d);

    /*Coffee*/
    coffee95d = sum(0, dcaf_s95, coff_s95);

    /*Nut, Legumes, Beans*/
    nutleg95d = sum(0, nutsal95d, legume95d);

    /*Brown rice*/
    bwrice95d = sum(0, brice_s95);

    /*White rice*/
    wtrice95d = sum(0, wrice_s95);

    /*Sugar sweetened beverages*/
    SSB95d = sum(0, cola_s95, cnoc_s95, otsug_s95, punch_s95);

    /*confectionery*/
   conf95d = sum(0, cdywo_s95, cdyw_s95, choco_s95);
run;

data n95_nts;
    set n95_nts;

    whgrns95d = whgrn95n/28;
    rfgrns95d = rfgrn95n/28;
    afat95d= afat95n/15;
    vfat95d= vfat95n/15;

run;



%serv99(keep= fries_s99 pot_s99 pchip_s99
              bfdog_s99 bacon_s99 pmsan_s99 procm_s99
              hamb_s99 hambl_s99 bmix_s99 pmain_s99 bmain_s99
              ctdog_s99 chksa_s99 chwi_s99 chwo_s99
              ctuna_s99 bfsh_s99 dkfsh_s99 ofish_s99
              egg_s99 eggwh_s99
              whole_s99 cream_s99 icecr_s99 but_s99 cotch_s99 crmch_s99 otch_s99
              skim_s99 m2_s99 sherb_s99 plyog_s99 flyog_s99
              soy_s99 tofu_s99
              pbut_s99 pnut_s99 wnut_s99 onut_s99
              peas_s99 bean_s99
              rais_s99 prune_s99 ban_s99 cant_s99 avo_s99 appl_s99 oran_s99 grfr_s99 straw_s99 blueb_s99 peach_s99 
              tom_s99 tosau_s99 sbean_s99 brocc_s99 cauli_s99 cabb_s99 bruss_s99 rcar_s99 ccar_s99 corn_s99 mixv_s99 yam_s99 osqua_s99 eggpl_s99 kale_s99 rspin_s99 cspin_s99 ilett_s99 rlett_s99 cel_s99 oniov_s99
              cola_s99 otsnc_s99 otsug_s99 punch_s99
              dcaf_s99 coff_s99
              brice_s99
              wrice_s99
              cdywo_s99 cdyw_s99 choco_s99);

%n99_dt(keep= chreg99d chlit99d chnft99d chnon99d );
%n99_nts(keep= whgrn99n rfgrn99n gl99n gid99n afat99n vfat99n calor99n pot_carb99n trn0099n);

data food99;
    merge serv99 n99_dt;
    by id;
run;

data food99;
    set food99;

    /*Total Potato*/
    tpotat99d = sum(0, fries_s99, pot_s99);

    /*Baked, boiled, mashed Potato*/
    bbmpot99d = sum(0, pot_s99);

    /*Fries Potato*/
    fpotat99d = sum(0, fries_s99);

    /*Chips*/
    chipss99d = sum(0, pchip_s99);

    /*Red meat*/
    prmeat99d = sum(0, bfdog_s99, bacon_s99, pmsan_s99, procm_s99);
    urmeat99d = sum(0, hamb_s99, hambl_s99, bmix_s99, pmain_s99, bmain_s99);
    trmeat99d = sum(0, prmeat99d, urmeat99d);

    /*Unprocessed poultry*/
    poultr99d = sum(0, ctdog_s99, chksa_s99, chwi_s99, chwo_s99);

    /*Fish*/
    fishal99d = sum(0, ctuna_s99, bfsh_s99, dkfsh_s99, ofish_s99);

    /*Regular eggs*/
    regegg99d = sum(0, egg_s99, eggwh_s99);

    /*High fat dairy*/
    if chreg99d=1 or chnon99d=1 then hfcheese99 = otch_s99; else hfcheese99 = .;
    hdairy99d = sum(0, whole_s99, cream_s99, icecr_s99, crmch_s99, hfcheese99);

    /*Low fat dairy*/
    if chlit99d = 1 or chnft99d=1  then lfcheese99 = otch_s99; else lfcheese99 = .;
    ldairy99d = sum(0, skim_s99, m2_s99, sherb_s99, plyog_s99, flyog_s99, cotch_s99, lfcheese99);

    /*Soy*/
    soypro99d = sum(0, soy_s99, tofu_s99);

    /*Nuts*/
    nutsal99d = sum(0, pbut_s99, pnut_s99, wnut_s99, onut_s99);

    /*Legumes*/
    legume99d = sum(0, peas_s99, bean_s99);

    /*Fruits*/
    fruits99d = sum(0, rais_s99, prune_s99, ban_s99, cant_s99, avo_s99, appl_s99, oran_s99, grfr_s99, straw_s99, blueb_s99, peach_s99);

    /*Vegetables*/
    vegeal99d = sum(0, tom_s99, tosau_s99, sbean_s99, brocc_s99, cauli_s99, cabb_s99, bruss_s99, rcar_s99, ccar_s99, corn_s99, mixv_s99, yam_s99, osqua_s99, eggpl_s99, kale_s99, rspin_s99, cspin_s99, ilett_s99, rlett_s99, cel_s99, oniov_s99);

    /*Non-starchy Vegetables*/
    nstveg99d = sum(0, tom_s99, tosau_s99, sbean_s99, brocc_s99, cauli_s99, cabb_s99, bruss_s99, rcar_s99, ccar_s99, mixv_s99, eggpl_s99, kale_s99, rspin_s99, cspin_s99, ilett_s99, rlett_s99, cel_s99, oniov_s99);

    /*Starchy Vegetables*/
    staveg99d = sum(0, corn_s99, yam_s99, osqua_s99, peas_s99, bean_s99);

    /*Dairy*/
    tdairy99d = sum(0, hdairy99d, ldairy99d);

    /*Coffee*/
    coffee99d = sum(0, dcaf_s99, coff_s99);

    /*Nut, Legumes, Beans*/
    nutleg99d = sum(0, nutsal99d, legume99d);

    /*Brown rice*/
    bwrice99d = sum(0, brice_s99);

    /*White rice*/
    wtrice99d = sum(0, wrice_s99);

    /*Sugar sweetened beverages*/
    SSB99d = sum(0, cola_s99, otsnc_s99, otsug_s99, punch_s99);

    /*confectionery*/
   conf99d = sum(0, cdywo_s99, cdyw_s99, choco_s99);

run;

data n99_nts;
    set n99_nts;

    whgrns99d = whgrn99n/28;
    rfgrns99d = rfgrn99n/28;
    afat99d= afat99n/15;
    vfat99d= vfat99n/15;

run;



%serv03(keep= fries_s03 pot_s03 pchip_s03
              bfdog_s03 bacon_s03 pmsan_s03 procm_s03 
              hamb_s03 hambl_s03 bmix_s03 pmain_s03 bmain_s03
              chksa_s03 chwi_s03 chwo_s03
              ctuna_s03 bfsh_s03 dkfsh_s03 ofish_s03
              egg_s03 eggwh_s03
              whole_s03 cream_s03 icecr_s03 cotch_s03 crmch_s03 otch_s03
              skim_s03 m1or2_s03 sherb_s03 plyog_s03 flyog_s03 
              tofu_s03 soy_s03
              pbut_s03 pnut_s03 wnut_s03 onut_s03
              peas_s03 bean_s03
              rais_s03 grape_s03 prune_s03 ban_s03 cant_s03 appl_s03 apsau_s03 oran_s03 grfr_s03 straw_s03 blueb_s03 peach_s03
              tom_s03 tosau_s03 sbean_s03 brocc_s03 cauli_s03 cabb_s03 bruss_s03 rcar_s03 ccar_s03 corn_s03 mixv_s03 yam_s03 osqua_s03 eggpl_s03 kale_s03 rspin_s03 cspin_s03 ilett_s03 rlett_s03 cel_s03 oniov_s03
              cola_s03 otsug_s03 punch_s03
              dcaf_s03 coff_s03
              brice_s03
              wrice_s03
              cdywo_s03 cdyw_s03 choc_s03);

%nur03(keep= chty03d)
%n03_nts(keep= whgrn03n rfgrn03n gl03n gid03n afat03n vfat03n calor03n pot_carb03n trn0203n);

data food03;
    merge serv03 nur03;
    by id;
run;

data food03;
    set food03;

    /*Total Potato*/
    tpotat03d = sum(0, fries_s03, pot_s03);

    /*Baked, boiled, mashed Potato*/
    bbmpot03d = sum(0, pot_s03);

    /*Fries Potato*/
    fpotat03d = sum(0, fries_s03);

    /*Chips*/
    chipss03d = sum(0, pchip_s03);

    /*Red meat*/
    prmeat03d = sum(0, bfdog_s03, bacon_s03, pmsan_s03, procm_s03);
    urmeat03d = sum(0, hamb_s03, hambl_s03, bmix_s03, pmain_s03, bmain_s03);
    trmeat03d = sum(0, prmeat03d, urmeat03d);

    /*Unprocessed poultry*/
    poultr03d = sum(0, chksa_s03, chwi_s03, chwo_s03);

    /*Fish*/
    fishal03d = sum(0, ctuna_s03, bfsh_s03, dkfsh_s03, ofish_s03);

    /*Regular eggs*/
    regegg03d = sum(0, egg_s03, eggwh_s03);

    /*High fat dairy*/
    if chty03d in (1,4,5) then hfcheese03 = otch_s03; else hfcheese03 = .;
    hdairy03d = sum(0, whole_s03, cream_s03, icecr_s03, crmch_s03, hfcheese03);

    /*Low fat dairy*/
    if chty03d in (2,3) then lfcheese03 = otch_s03; else lfcheese03 = .;
    ldairy03d = sum(0, skim_s03, m1or2_s03, sherb_s03, plyog_s03, flyog_s03, cotch_s03, lfcheese03);

    /*Soy*/
    soypro03d = sum(0, tofu_s03, soy_s03);

    /*Nuts*/
    nutsal03d = sum(0, pbut_s03, pnut_s03, wnut_s03, onut_s03);

    /*Legumes*/
    legume03d = sum(0, peas_s03, bean_s03);

    /*Fruits*/
    fruits03d = sum(0, rais_s03, grape_s03, prune_s03, ban_s03, cant_s03, appl_s03, apsau_s03, oran_s03, grfr_s03, straw_s03, blueb_s03, peach_s03);

    /*Vegetables*/
    vegeal03d = sum(0, tom_s03, tosau_s03, sbean_s03, brocc_s03, cauli_s03, cabb_s03, bruss_s03, rcar_s03, ccar_s03, corn_s03, mixv_s03, yam_s03, osqua_s03, eggpl_s03, kale_s03, rspin_s03, cspin_s03, ilett_s03, rlett_s03, cel_s03, oniov_s03);

    /*Non-starchy Vegetables*/
    nstveg03d = sum(0, tom_s03, tosau_s03, sbean_s03, brocc_s03, cauli_s03, cabb_s03, bruss_s03, rcar_s03, ccar_s03, mixv_s03, eggpl_s03, kale_s03, rspin_s03, cspin_s03, ilett_s03, rlett_s03, cel_s03, oniov_s03);

    /*Starchy Vegetables*/
    staveg03d = sum(0, corn_s03, yam_s03, osqua_s03, peas_s03, bean_s03);

    /*Dairy*/
    tdairy03d = sum(0, hdairy03d, ldairy03d);

    /*Coffee*/
    coffee03d = sum(0, dcaf_s03, coff_s03);

    /*Nut, Legumes, Beans*/
    nutleg03d = sum(0, nutsal03d, legume03d);

    /*Brown rice*/
    bwrice03d = sum(0, brice_s03);

    /*White rice*/
    wtrice03d = sum(0, wrice_s03);

    /*Sugar sweetened beverages*/
    SSB03d = sum(0, cola_s03, otsug_s03, punch_s03);

        /*confectionery*/
   conf03d = sum(0, cdywo_s03, cdyw_s03, choc_s03);

run;

data n03_nts;
    set n03_nts;

    whgrns03d = whgrn03n/28;
    rfgrns03d = rfgrn03n/28;
    afat03d= afat03n/15;
    vfat03d= vfat03n/15;

run;



%serv07(keep= fries_s07 pot_s07 pchip_s07
              bfdog_s07 bacon_s07 pmsan_s07 procm_s07 
              hamb_s07 hambl_s07 bmix_s07 pmain_s07 bmain_s07 
              chksa_s07 chwi_s07 chwo_s07
              ctuna_s07 bfsh_s07 dkfsh_s07 ofish_s07 
              egg_s07 eggom_s07
              whole_s07 cream_s07 icecr_s07 cotch_s07 crmch_s07 otch_s07
              skim_s07 m1or2_s07 sherb_s07 plyog_s07 flyog_s07
              soy_s07 tofu_s07
              pbut_s07 pnut_s07 wnut_s07 onut_s07
              peas_s07 bean_s07 
              rais_s07 prune_s07 ban_s07 cant_s07 avo_s07 appl_s07 oran_s07 grfr_s07 straw_s07 blueb_s07 peach_s07 apric_s07
              tom_s07 tosau_s07 sbean_s07 brocc_s07 cauli_s07 cabb_s07 bruss_s07 rcar_s07 ccar_s07 corn_s07 mixv_s07 yam_s07 osqua_s07 eggpl_s07 kale_s07 rspin_s07 cspin_s07 ilett_s07 rlett_s07 cel_s07 oniov_s07
              cola_s07 otsug_s07 punch_s07
              dcaf_s07 coff_s07
              brice_s07
              wrice_s07
              cdywo_s07 cdyw_s07 dchoc_s07 mchoc_s07);

%nur07(keep= chreg07d chlit07d chnft07d chnon07d chpt07d)
%n07_nts(keep= whgrn07n rfgrn07n gl07n gid07n afat07n vfat07n calor07n pot_carb07n trn0707n);

data food07;
    merge serv07 nur07;
    by id;
run;

data food07;
    set food07;

    /*Total Potato*/
    tpotat07d = sum(0, fries_s07, pot_s07);

    /*Baked, boiled, mashed Potato*/
    bbmpot07d = sum(0, pot_s07);

    /*Fries Potato*/
    fpotat07d = sum(0, fries_s07);

    /*Chips*/
    chipss07d = sum(0, pchip_s07);

    /*Red meat*/
    prmeat07d = sum(0, bfdog_s07, bacon_s07, pmsan_s07, procm_s07);
    urmeat07d = sum(0, hamb_s07, hambl_s07, bmix_s07, pmain_s07, bmain_s07);
    trmeat07d = sum(0, prmeat07d, urmeat07d);

    /*Unprocessed poultry*/
    poultr07d = sum(0, chksa_s07, chwi_s07, chwo_s07);

    /*Fish*/
    fishal07d = sum(0, ctuna_s07, bfsh_s07, dkfsh_s07, ofish_s07);

    /*Regular eggs*/
    regegg07d = sum(0, egg_s07, eggom_s07);

    /*High fat dairy*/
    if chreg07d=1 or chnon07d=1 or chpt07d=1 then hfcheese07 = otch_s07; else hfcheese07 = .;
    hdairy07d = sum(0, whole_s07, cream_s07, icecr_s07, crmch_s07, hfcheese07);

    /*Low fat dairy*/
    if chlit07d = 1 or chnft07d=1  then lfcheese07 = otch_s07; else lfcheese07 = .;
    ldairy07d = sum(0, skim_s07, m1or2_s07, sherb_s07, plyog_s07, flyog_s07, cotch_s07, lfcheese07);

    /*Soy*/
    soypro07d = sum(0, soy_s07, tofu_s07);

    /*Nuts*/
    nutsal07d = sum(0, pbut_s07, pnut_s07, wnut_s07, onut_s07);

    /*Legumes*/
    legume07d = sum(0, peas_s07, bean_s07);

    /*Fruits*/
    fruits07d = sum(0, rais_s07, prune_s07, ban_s07, cant_s07, avo_s07, appl_s07, oran_s07, grfr_s07, straw_s07, blueb_s07, peach_s07, apric_s07);

    /*Vegetables*/
    vegeal07d = sum(0, tom_s07, tosau_s07, sbean_s07, brocc_s07, cauli_s07, cabb_s07, bruss_s07, rcar_s07, ccar_s07, corn_s07, mixv_s07, yam_s07, osqua_s07, eggpl_s07, kale_s07, rspin_s07, cspin_s07, ilett_s07, rlett_s07, cel_s07, oniov_s07);

    /*Non-starchy Vegetables*/
    nstveg07d = sum(0, tom_s07, tosau_s07, sbean_s07, brocc_s07, cauli_s07, cabb_s07, bruss_s07, rcar_s07, ccar_s07, mixv_s07, eggpl_s07, kale_s07, rspin_s07, cspin_s07, ilett_s07, rlett_s07, cel_s07, oniov_s07);

    /*Starchy Vegetables*/
    staveg07d = sum(0, corn_s07, yam_s07, osqua_s07, peas_s07, bean_s07);

    /*Dairy*/
    tdairy07d = sum(0, hdairy07d, ldairy07d);

    /*Coffee*/
    coffee07d = sum(0, dcaf_s07, coff_s07);

    /*Nut, Legumes, Beans*/
    nutleg07d = sum(0, nutsal07d, legume07d);

    /*Brown rice*/
    bwrice07d = sum(0, brice_s07);

    /*White rice*/
    wtrice07d = sum(0, wrice_s07);

    /*Sugar sweetened beverages*/
    SSB07d = sum(0, cola_s07, otsug_s07, punch_s07);

        /*confectionery*/
   conf07d = sum(0, cdywo_s07, cdyw_s07, dchoc_s07, mchoc_s07);

run;

data n07_nts;
    set n07_nts;

    whgrns07d = whgrn07n/28;
    rfgrns07d = rfgrn07n/28;
    afat07d= afat07n/15;
    vfat07d= vfat07n/15;

run;


%serv11(keep= fries_s11 pot_s11 pchip_s11
              bfdog_s11 bacon_s11 pmsan_s11 procm_s11
              hamb_s11 hambl_s11 bmix_s11 pmain_s11 bmain_s11
              chksa_s11 chwi_s11 chwo_s11 
              ctuna_s11 bfsh_s11 dkfsh_s11 ofish_s11 
              egg_s11 eggom_s11
              whole_s11 cream_s11 icecr_s11 cotch_s11 crmch_s11 otch_s11
              skim_s11 m1or2_s11 sherb_s11 plyog_s11 artyog_s11 flyog_s11
              soy_s11 tofu_s11 
              pbut_s11 pnut_s11 wnut_s11 onut_s11
              peas_s11 bean_s11
              rais_s11 prune_s11 ban_s11 cant_s11 avo_s11 appl_s11 oran_s11 grfr_s11 straw_s11 blueb_s11 peach_s11 apric_s11 mdrfr_s11
              tom_s11 tosau_s11 sbean_s11 brocc_s11 cauli_s11 cabb_s11 bruss_s11 rcar_s11 ccar_s11 corn_s11 mixv_s11 yam_s11 osqua_s11 eggpl_s11 kale_s11 rspin_s11 cspin_s11 ilett_s11 rlett_s11 cel_s11 oniov_s11
              cola_s11 otsug_s11 punch_s11
              dcaf_s11 coff_s11
              brice_s11
              wrice_s11
              cdywo_s11 cdyw_s11 dchoc_s11 mchoc_s11);

%nur11(keep= chreg11d chlit11d chnft11d chnon11d chpt11d )
%n11_nts(keep= whgrn11n rfgrn11n gl11n gid11n afat11n vfat11n calor11n pot_carb11n trn1111n);

data food11;
    merge serv11 nur11;
    by id;
run;

data food11;
    set food11;

    /*Total Potato*/
    tpotat11d = sum(0, fries_s11, pot_s11);

    /*Baked, boiled, mashed Potato*/
    bbmpot11d = sum(0, pot_s11);

    /*Fries Potato*/
    fpotat11d = sum(0, fries_s11);

    /*Chips*/
    chipss11d = sum(0, pchip_s11);

    /*Red meat*/
    prmeat11d = sum(0, bfdog_s11, bacon_s11, pmsan_s11, procm_s11);
    urmeat11d = sum(0, hamb_s11, hambl_s11, bmix_s11, pmain_s11, bmain_s11);
    trmeat11d = sum(0, prmeat11d, urmeat11d);

    /*Unprocessed poultry*/
    poultr11d = sum(0, chksa_s11, chwi_s11, chwo_s11);

    /*Fish*/
    fishal11d = sum(0, ctuna_s11, bfsh_s11, dkfsh_s11, ofish_s11);

    /*Regular eggs*/
    regegg11d = sum(0, egg_s11, eggom_s11);

    /*High fat dairy*/
    if chreg11d=1 or chnon11d=1 or chpt11d=1 then hfcheese11 = otch_s11; else hfcheese11 = .;
    hdairy11d = sum(0, whole_s11, cream_s11, icecr_s11, crmch_s11, hfcheese11);

    /*Low fat dairy*/
    if chlit11d = 1 or chnft11d=1  then lfcheese11 = otch_s11; else lfcheese11 = .;
    ldairy11d = sum(0, skim_s11, m1or2_s11, sherb_s11, plyog_s11, artyog_s11, flyog_s11, cotch_s11, lfcheese11);

    /*Soy*/
    soypro11d = sum(0, soy_s11, tofu_s11);

    /*Nuts*/
    nutsal11d = sum(0, pbut_s11, pnut_s11, wnut_s11, onut_s11);

    /*Legumes*/
    legume11d = sum(0, peas_s11, bean_s11);

    /*Fruits*/
    fruits11d = sum(0, rais_s11, prune_s11, ban_s11, cant_s11, avo_s11, appl_s11, oran_s11, grfr_s11, straw_s11, blueb_s11, peach_s11, apric_s11, mdrfr_s11);

    /*Vegetables*/
    vegeal11d = sum(0, tom_s11, tosau_s11, sbean_s11, brocc_s11, cauli_s11, cabb_s11, bruss_s11, rcar_s11, ccar_s11, corn_s11, mixv_s11, yam_s11, osqua_s11, eggpl_s11, kale_s11, rspin_s11, cspin_s11, ilett_s11, rlett_s11, cel_s11, oniov_s11);

    /*Non-starchy Vegetables*/
    nstveg11d = sum(0, tom_s11, tosau_s11, sbean_s11, brocc_s11, cauli_s11, cabb_s11, bruss_s11, rcar_s11, ccar_s11, mixv_s11, eggpl_s11, kale_s11, rspin_s11, cspin_s11, ilett_s11, rlett_s11, cel_s11, oniov_s11);

    /*Starchy Vegetables*/
    staveg11d = sum(0, corn_s11, yam_s11, osqua_s11, peas_s11, bean_s11);

    /*Coffee*/
    coffee11d = sum(0, dcaf_s11, coff_s11);

    /*Dairy*/
    tdairy11d = sum(0, hdairy11d, ldairy11d);

    /*Nut, Legumes, Beans*/
    nutleg11d = sum(0, nutsal11d, legume11d);

    /*Brown rice*/
    bwrice11d = sum(0, brice_s11);

    /*White rice*/
    wtrice11d = sum(0, wrice_s11);

    /*Sugar sweetened beverages*/
    SSB11d = sum(0, cola_s11, otsug_s11, punch_s11);

   /*confectionery*/
   conf11d = sum(0, cdywo_s11, cdyw_s11, dchoc_s11, mchoc_s11);
run;

data n11_nts;
    set n11_nts;

    whgrns11d = whgrn11n/28;
    rfgrns11d = rfgrn11n/28;
    afat11d= afat11n/15;
    vfat11d= vfat11n/15;

run;



%serv15(keep= fries_s15 pot_s15 pchip_s15
              bfdog_s15 bacon_s15 pmsan_s15 procm_s15
              hamb_s15 hambl_s15 bmix_s15 pmain_s15 bmain_s15
              chksa_s15 chwi_s15 chwo_s15
              ctuna_s15 bfsh_s15 dkfsh_s15 ofish_s15
              egg_s15 eggom_s15
              whole_s15 cream_s15 icecr_s15 cotch_s15 crmch_s15 otch_s15
              skim_s15 m1or2_s15 sherb_s15 plyog_s15 artyog_s15 flyog_s15
              soy_s15 tofu_s15
              pbut_s15 pnut_s15 wnut_s15 onut_s15
              peas_s15 bean_s15 humm_s15
              rais_s15 prune_s15 ban_s15 cant_s15 avo_s15 appl_s15 tancl_s15 oran_s15 grfr_s15 straw_s15 blueb_s15 peach_s15 drcr_s15 mdrfr_s15
              tom_s15 tosau_s15 salsa_s15 sbean_s15 brocc_s15 cauli_s15 cabb_s15 bruss_s15 rcar_s15 ccar_s15 corn_s15 mixv_s15 yam_s15 osqua_s15 eggpl_s15 kale_s15 rspin_s15 cspin_s15 ilett_s15 rlett_s15 cel_s15 grpep_s15 oniov_s15
              toj_s15 aj_s15 oj_s15 ojca_s15 grj_s15 othj_s15 
              cola_s15 otsug_s15 punch_s15 
              beer_s15 lbeer_s15 rwine_s15 wwine_s15 liq_s15
              dcaf_s15 coff_s15
              brice_s15
              wrice_s15
              cdywo_s15 cdyw_s15 dchoc_s15 mchoc_s15);

%nur15(keep= chreg15d chlit15d chnft15d chnon15d chpt15d cerbr15d)
%n15_nts(keep= calor15n whgrn15n rfgrn15n gl15n gid15n poly15n omega15n na15n trn1115n afat15n vfat15n pot_carb15n trn1115n);
%n15_ant(keep= whgrn15a);
proc sort data=n15_ant;by id;run;

data food15;
    merge serv15 nur15;
    by id;
run;

data food15;
    set food15;

    /*Total Potato*/
    tpotat15d = sum(0, fries_s15, pot_s15);

    /*Baked, boiled, mashed Potato*/
    bbmpot15d = sum(0, pot_s15);

    /*Fries Potato*/
    fpotat15d = sum(0, fries_s15);

    /*Chips*/
    chipss15d = sum(0, pchip_s15);

    /*Red meat*/
    prmeat15d = sum(0, bfdog_s15, bacon_s15, pmsan_s15, procm_s15);
    urmeat15d = sum(0, hamb_s15, hambl_s15, bmix_s15, pmain_s15, bmain_s15);
    trmeat15d = sum(0, prmeat15d, urmeat15d);

    /*Unprocessed poultry*/
    poultr15d = sum(0, chksa_s15, chwi_s15, chwo_s15);

    /*Fish*/
    fishal15d = sum(0, ctuna_s15, bfsh_s15, dkfsh_s15, ofish_s15);

    /*Regular eggs*/
    regegg15d = sum(0, egg_s15, eggom_s15);

    /*High fat dairy*/
    if chreg15d=1 or chnon15d=1 or chpt15d=1 then hfcheese15 = otch_s15; else hfcheese15 = .;
    hdairy15d = sum(0, whole_s15, cream_s15, icecr_s15, crmch_s15, hfcheese15);

    /*Low fat dairy*/
    if chlit15d = 1 or chnft15d=1  then lfcheese15 = otch_s15; else lfcheese15 = .;
    ldairy15d = sum(0, skim_s15, m1or2_s15, sherb_s15, plyog_s15, artyog_s15, flyog_s15, cotch_s15, lfcheese15);

    /*Soy*/
    soypro15d = sum(0, soy_s15, tofu_s15);

    /*Nuts*/
    nutsal15d = sum(0, pbut_s15, pnut_s15, wnut_s15, onut_s15);

    /*Legumes*/
    legume15d = sum(0, peas_s15, bean_s15, humm_s15);

    /*Fruits*/
    fruits15d = sum(0, rais_s15, prune_s15, ban_s15, cant_s15, avo_s15, appl_s15, tancl_s15, oran_s15, grfr_s15, straw_s15, blueb_s15, peach_s15, drcr_s15, mdrfr_s15);

    /*Vegetables*/
    vegeal15d = sum(0, tom_s15, tosau_s15, sbean_s15, brocc_s15, cauli_s15, cabb_s15, bruss_s15, rcar_s15, ccar_s15, corn_s15, mixv_s15, yam_s15, osqua_s15, eggpl_s15, kale_s15, rspin_s15, cspin_s15, ilett_s15, rlett_s15, cel_s15, oniov_s15);

    /*Non-starchy Vegetables*/
    nstveg15d = sum(0, tom_s15, tosau_s15, sbean_s15, brocc_s15, cauli_s15, cabb_s15, bruss_s15, rcar_s15, ccar_s15, mixv_s15, eggpl_s15, kale_s15, rspin_s15, cspin_s15, ilett_s15, rlett_s15, cel_s15, oniov_s15);

    /*Starchy Vegetables*/
    staveg15d = sum(0, corn_s15, yam_s15, osqua_s15, peas_s15, bean_s15);

    /*Dairy*/
    tdairy15d = sum(0, hdairy15d, ldairy15d);

    /*Coffee*/
    coffee15d = sum(0, dcaf_s15, coff_s15);

    /*Nut, Legumes, Beans*/
    nutleg15d = sum(0, nutsal15d, legume15d);

    /*Brown rice*/
    bwrice15d = sum(0, brice_s15);

    /*White rice*/
    wtrice15d = sum(0, wrice_s15);

    /*Sugar sweetened beverages*/
    SSB15d = sum(0, cola_s15, otsug_s15, punch_s15);

   /*confectionery*/
   conf15d = sum(0, cdywo_s15, cdyw_s15, dchoc_s15, mchoc_s15);
run;
proc sort data=food15;by id;run;

data n15_nts;
    set n15_nts;

    whgrns15d = whgrn15n/28;
    rfgrns15d = rfgrn15n/28;
    afat15d= afat15n/15;
    vfat15d= vfat15n/15;
run;
proc sort data=n15_nts;by id;run;

proc rank data=n15_nts group=11 out=n15_sod;
   var na15n;
   ranks na15nq;
   keep id na15nq;
run;
proc sort data=n15_sod; by id;run;

/* reverse sodium rankings to give high score for low intake **/
data n15_sod; set n15_sod;
if na15nq=10 then na15s=0;
else if na15nq=9 then na15s=1;
else if na15nq=8 then na15s=2;
else if na15nq=7 then na15s=3;
else if na15nq=6 then na15s=4;
else if na15nq=5 then na15s=5;
else if na15nq=4 then na15s=6;
else if na15nq=3 then na15s=7;
else if na15nq=2 then na15s=8;
else if na15nq=1 then na15s=9;
else if na15nq=0 then na15s=10;
proc sort; by id ;run;

data ahei15;
    merge food15(in=a) n15_nts(in=b) n15_sod(in=c) n15_ant(in=d);
    by id;
    if a=b=c=d;

    fruit15 = sum (0, rais_s15, prune_s15, ban_s15, cant_s15, avo_s15, appl_s15, tancl_s15, oran_s15, grfr_s15, straw_s15, blueb_s15, peach_s15, drcr_s15, mdrfr_s15);

    tveg15 = sum (0, tom_s15, tosau_s15, salsa_s15, sbean_s15, brocc_s15, cauli_s15, cabb_s15, bruss_s15, rcar_s15, ccar_s15, corn_s15, mixv_s15, yam_s15, osqua_s15, eggpl_s15, kale_s15, rspin_s15, cspin_s15, ilett_s15, rlett_s15, cel_s15, grpep_s15, oniov_s15);

    nut15 = sum (0, peas_s15, bean_s15, humm_s15, pbut_s15, pnut_s15, wnut_s15, onut_s15, tofu_s15);

    rmeat15 = sum (0, bfdog_s15, bacon_s15, pmsan_s15, procm_s15, hamb_s15, hambl_s15, bmix_s15, pmain_s15, bmain_s15);

    frtjc15 = sum (0, toj_s15, aj_s15, oj_s15, ojca_s15, grj_s15, othj_s15 );

    ssb15 = sum (0, cola_s15, otsug_s15, punch_s15, frtjc15);

    poly15 = poly15n - omega15n;
    ppoly15 = (poly15*900)/calor15n;

    apoly15 = (poly15n*900)/calor15n;

    pomeg15 = (omega15n*90)/calor15n;
    mgomg15 = omega15n*1000;

    ptran15 = (trn1115n*9)/calor15n;

    drinks15 = sum (0, beer_s15, lbeer_s15, rwine_s15, wwine_s15, liq_s15);

    /**
            COMPONENT #1: RED MEAT
            BEST = <1/month (<0.07)
            WORST = >1.5/day
    **/

    if rmeat15=. then rmeat15=0;

    if rmeat15 le 0.07 then meataI15 = 10;
    else if rmeat15 gt 0.07 then do;
            meataI15 = (1.5 - rmeat15)/0.143;
            end;
    if meataI15 le 0 then meataI15 = 0;
    else if meataI15 ge 10 then meataI15 = 10;

    /**
            COMPONENT #2 -- nuts
            BEST = >1
            WORST = 0

    **/

    if nut15 eq 0 then nutI15=0;
    else if nut15 gt 0 then do;
            nutI15 = (nut15/0.1);
            end;

    if nutI15 ge 10 then nutI15 = 10;
    if nutI15 le 0 then nutI15 = 0;

    /**


            COMPONENT #3: SSB + Fruit Juice
            BEST = 0
            WORST = 1+ per day

    **/

    if ssb15 eq 0 then ssbI15 = 10;
    else if ssb15 gt 0 then do;
            ssbI15 = 10 - (ssb15/0.1);
            end;
    if ssbI15 ge 10 then ssbI15 = 10;
    if ssbI15 le 0 then ssbI15  = 0;

    /**

            COMPONENT #4: Total vegetables
            BEST = 5+
            WORST = 0

    **/
    if tveg15 = 0 then tvegI15=0;
    else if tveg15 gt 0 then do;
            tvegI15 = tveg15/0.5;
            end;
    if tvegI15 ge 10 then tvegI15 = 10;
    if tvegI15 le 0 then tvegI15  = 0;

    /**

            COMPONENT #5: Fruits
            BEST = 4+
            WORST = 0

    **/

    if  fruit15 eq 0 then frtI15a=0;
    else if fruit15 gt 0 then do;
            frtI15a = fruit15/0.4;
            end;
    if frtI15a ge 10 then frtI15a = 10;
    if frtI15a le 0 then frtI15a  = 0;

    /**

            COMPONENT #6: Poly fat
            Best: >10%
            Worst: <2%

    **/
    if ppoly15 le 2 then ppolyI15 = 0;
    else if ppoly15 gt 2 then do;
            ppolyI15 = (ppoly15-2)/0.8;
            end;
    if ppolyI15 le 0 then ppolyI15=0;
    if ppolyI15 ge 10 then ppolyI15=10;

    if apoly15 le 2 then polyI15 = 0;
    else if apoly15 gt 2 then do;
            polyI15 = (apoly15-2)/0.8;
            end;
    if polyI15 le 0 then polyI15=0;
    if polyI15 ge 10 then polyI15=10;

    /**

            COMPONENT #7 -- trans fat
            BEST = <0.5%
            WORST = >4%

    **/

    if ptran15 le 0.005 then tranI15=10;

    if ptran15 le 0.005 then tranI15=10;
    else if ptran15 gt 0.005 then do;

            tranI15 = (0.04-ptran15)/0.0035;
            end;

    if tranI15 ge 10 then tranI15 = 10;
    if tranI15 le 0 then tranI15 = 0;

    /**

            COMPONENT #8 -- ALCOHOL
            best = 0.5 - 1.5 drinks/day
            worst = 0 or >2.5 /day

    **/


    if             drinks15 eq 0   then nETOHI15c=2.5;
    else if 0   lt drinks15 lt 0.5 then nETOHI15c=5.0;
    else if 0.5 le drinks15 le 1.5 then nETOHI15c=10;
    else if 1.5 lt drinks15 le 2.0 then nETOHI15c=5.0;
    else if 2.0 lt drinks15 lt 2.5 then nETOHI15c=2.5;
    else if        drinks15 ge 2.5 then nETOHI15c=0;


    /**
            COMPONENT #9 -- omega
            best = 250+ mg/day
            worst = 0 day

    **/

    if mgomg15=0 then omegI15=0;
    else if mgomg15 gt 0 then do;
            omegI15 = mgomg15/25;
            end;

    if omegI15 le 0 then omegI15 = 0;
    else if omegI15 ge 10 then omegI15 = 10;

    /**

            COMPONENT #10: Whole grains
            best =75 g
            worst = 0 g

    **/

    if whgrn15a eq 0 then wgI15=0;
    else if whgrn15a gt 0 then do;
            wgI15 = whgrn15a/7.5;
            end;
    if wgI15 ge 10 then wgI15 = 10;
    if wgI15 le 0 then wgI15  = 0;

    nAHEI15a = sum(meataI15, nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, omegI15, wgI15, na15s);
    ahei15=nAHEI15a; 
    aheinoal15 = sum(meataI15, nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, omegI15, wgI15, na15s);
    aheinopt15 = sum(meataI15, nutI15, ssbI15, tvegI15, frtI15a, nETOHI15c, omegI15, wgI15, na15s);
    aheifisha15 = sum(nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, wgI15, na15s);
    aheidairy15 = sum(nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, omegI15, wgI15, na15s);
    aheinutbl15 = sum(ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, omegI15, wgI15, na15s);
    aheipoult15 = sum(nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, omegI15, wgI15, na15s);
    aheineggs15 = sum(nutI15, ssbI15, tvegI15, frtI15a, ppolyI15, tranI15, nETOHI15c, omegI15, wgI15, na15s);
run;
proc sort data=ahei15;by id;run;    



%nur19(keep= fries19d pot19d pchip19d
              bfdog19d bacon19d pmsan19d procm19d
              hamb19d hambl19d bmix19d pmain19d bmain19d
              chksa19d chwi19d chwo19d
              ctuna19d bfsh19d dkfsh19d ofish19d
              egg19d eggom19d
              whole19d cream19d icecr19d cotch19d crmch19d otch19d
              skim19d m1or219d sherb19d plyog19d artyog19d flyog19d
              soy19d tofu19d
              pbut19d pnut19d wnut19d onut19d
              peas19d bean19d humm19d
              rais19d prune19d ban19d cant19d avo19d appl19d tancl19d oran19d grfr19d straw19d blueb19d peach19d drcr19d mdrfr19d
              tom19d tosau19d salsa19d sbean19d brocc19d cauli19d cabb19d bruss19d rcar19d ccar19d corn19d mixv19d yam19d osqua19d eggpl19d kale19d rspin19d cspin19d ilett19d rlett19d grpep19d oniov19d
              toj19d aj19d oj19d ojca19d othj19d 
              cola19d otsug19d punch19d
              beer19d lbeer19d rwine19d wwine19d liq19d
              decaf19d coff19d
              brice19d
              wrice19d
              chreg19d chlit19d chnft19d chnon19d chpt19d
              cdywo19d cdyw19d dchoc19d mchoc19d);

%n19_nts(keep= calor19n whgrn19n rfgrn19n gl19n gid19n poly19n omega19n na19n afat19n vfat19n pot_carb19n);
%n19_ant(keep= whgrn19a);
proc sort data=n19_ant;by id;run;

data nur19;
    set nur19;

    array foods {*} fries19d pot19d pchip19d
              bfdog19d bacon19d pmsan19d procm19d
              hamb19d hambl19d bmix19d pmain19d bmain19d
              chksa19d chwi19d chwo19d
              ctuna19d bfsh19d dkfsh19d ofish19d
              egg19d eggom19d
              whole19d cream19d icecr19d cotch19d crmch19d otch19d
              skim19d m1or219d sherb19d plyog19d artyog19d flyog19d
              soy19d tofu19d
              pbut19d pnut19d wnut19d onut19d
              peas19d bean19d humm19d
              rais19d prune19d ban19d cant19d avo19d appl19d tancl19d oran19d grfr19d straw19d blueb19d peach19d drcr19d mdrfr19d
              tom19d tosau19d salsa19d sbean19d brocc19d cauli19d cabb19d bruss19d rcar19d ccar19d corn19d mixv19d yam19d osqua19d eggpl19d kale19d rspin19d cspin19d ilett19d rlett19d cel19d grpep19d oniov19d
              toj19d aj19d oj19d ojca19d grj19d othj19d 
              cola19d otsug19d punch19d
              beer19d lbeer19d rwine19d wwine19d liq19d
              decaf19d coff19d
              brice19d
              wrice19d
              cdywo19d cdyw19d dchoc19d mchoc19d;

    array foods2 {*} fries19ds pot19ds pchip19ds
              bfdog19ds bacon19ds pmsan19ds procm19ds
              hamb19ds hambl19ds bmix19ds pmain19ds bmain19ds
              chksa19ds chwi19ds chwo19ds
              ctuna19ds bfsh19ds dkfsh19ds ofish19ds
              egg19ds eggom19ds
              whole19ds cream19ds icecr19ds cotch19ds crmch19ds otch19ds
              skim19ds m1or219ds sherb19ds plyog19ds artyog19ds flyog19ds
              soy19ds tofu19ds
              pbut19ds pnut19ds wnut19ds onut19ds
              peas19ds bean19ds humm19ds
              rais19ds prune19ds ban19ds cant19ds avo19ds appl19ds tancl19ds oran19ds grfr19ds straw19ds blueb19ds peach19ds drcr19ds mdrfr19ds
              tom19ds tosau19ds salsa19ds sbean19ds brocc19ds cauli19ds cabb19ds bruss19ds rcar19ds ccar19ds corn19ds mixv19ds yam19ds osqua19ds eggpl19ds kale19ds rspin19ds cspin19ds ilett19ds rlett19ds cel19ds grpep19ds oniov19ds
              toj19ds aj19ds oj19ds ojca19ds grj19ds othj19ds 
              cola19ds otsug19ds punch19ds
              beer19ds lbeer19ds rwine19ds wwine19ds liq19ds
              decaf19ds coff19ds
              brice19ds
              wrice19ds
              cdywo19ds cdyw19ds dchoc19ds mchoc19ds;


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

    pbut19ds = pbut19ds/2;
    bmain19ds = bmain19ds*(5/3);
    pmain19ds = pmain19ds*(5/3);


    /*Total Potato*/
    tpotat19d = sum(0, fries19ds, pot19ds);

    /*Baked, boiled, mashed Potato*/
    bbmpot19d = sum(0, pot19ds);

    /*Fries Potato*/
    fpotat19d = sum(0, fries19ds);

    /*Chips*/
    chipss19d = sum(0, pchip19ds);

    /*Red meat*/
    prmeat19d = sum(0, bfdog19ds, bacon19ds, pmsan19ds, procm19ds);
    urmeat19d = sum(0, hamb19ds, hambl19ds, bmix19ds, pmain19ds, bmain19ds);
    trmeat19d = sum(0, prmeat19d, urmeat19d);

    /*Unprocessed poultry*/
    poultr19d = sum(0, chksa19ds, chwi19ds, chwo19ds);

    /*Fish*/
    fishal19d = sum(0, ctuna19ds, bfsh19ds, dkfsh19ds, ofish19ds);

    /*Regular eggs*/
    regegg19d = sum(0, egg19ds, eggom19ds);

    /*High fat dairy*/
    if chreg19d=1 or chnon19d=1 or chpt19d=1 then hfcheese19 = otch19ds; else hfcheese19 = .;
    hdairy19d = sum(0, whole19ds, cream19ds, icecr19ds, crmch19ds, hfcheese19);

    /*Low fat dairy*/
    if chlit19d = 1 or chnft19d=1  then lfcheese19 = otch19ds; else lfcheese19 = .;
    ldairy19d = sum(0, skim19ds, m1or219ds, sherb19ds, plyog19ds, artyog19ds, flyog19ds, cotch19ds, lfcheese19);

    /*Soy*/
    soypro19d = sum(0, soy19ds, tofu19ds);

    /*Nuts*/
    nutsal19d = sum(0, pbut19ds, pnut19ds, wnut19ds, onut19ds);

    /*Legumes*/
    legume19d = sum(0, peas19ds, bean19ds, humm19ds);

    /*Fruits*/
    fruits19d = sum(0, rais19ds, prune19ds, ban19ds, cant19ds, avo19ds, appl19ds, tancl19ds, oran19ds, grfr19ds, straw19ds, blueb19ds, peach19ds, drcr19ds, mdrfr19ds);

    /*Vegetables*/
    vegeal19d = sum(0, tom19ds, tosau19ds, sbean19ds, brocc19ds, cauli19ds, cabb19ds, bruss19ds, rcar19ds, ccar19ds, corn19ds, mixv19ds, yam19ds, osqua19ds, eggpl19ds, kale19ds, rspin19ds, cspin19ds, ilett19ds, rlett19ds, cel19ds, oniov19ds);

    /*Non-starchy Vegetables*/
    nstveg19d = sum(0, tom19ds, tosau19ds, sbean19ds, brocc19ds, cauli19ds, cabb19ds, bruss19ds, rcar19ds, ccar19ds, mixv19ds, eggpl19ds, kale19ds, rspin19ds, cspin19ds, ilett19ds, rlett19ds, cel19ds, oniov19ds);

    /*Starchy Vegetables*/
    staveg19d = sum(0, corn19ds, yam19ds, osqua19ds, peas19ds, bean19ds);

    /*Dairy*/
    tdairy19d = sum(0, hdairy19d, ldairy19d);

    /*Coffee*/
    coffee19d = sum(0, decaf19ds, coff19ds);

    /*Nut, Legumes, Beans*/
    nutleg19d = sum(0, nutsal19d, legume19d);

    /*Brown rice*/
    bwrice19d = sum(0, brice19ds);

    /*White rice*/
    wtrice19d = sum(0, wrice19ds);

    /*Sugar sweetened beverages*/
    SSB19d = sum(0, cola19ds, otsug19ds, punch19ds);

   /*confectionery*/
   conf19d = sum(0, cdywo19ds, cdyw19ds, dchoc19ds, mchoc19ds);

run;
proc sort data=nur19;by id;run;


data n19_nts;
    set n19_nts;

    whgrns19d = whgrn19n/28;
    rfgrns19d = rfgrn19n/28;
    afat19d= afat19n/15;
    vfat19d= vfat19n/15;
run;
proc sort data=n19_nts;by id;run;

proc rank data=n19_nts group=11 out=n19_sod;
   var na19n;
   ranks na19nq;
   keep id na19nq;
run;
proc sort data=n19_sod; by id;run;

/* reverse sodium rankings to give high score for low intake **/
data n19_sod; set n19_sod;
if na19nq=10 then na19s=0;
else if na19nq=9 then na19s=1;
else if na19nq=8 then na19s=2;
else if na19nq=7 then na19s=3;
else if na19nq=6 then na19s=4;
else if na19nq=5 then na19s=5;
else if na19nq=4 then na19s=6;
else if na19nq=3 then na19s=7;
else if na19nq=2 then na19s=8;
else if na19nq=1 then na19s=9;
else if na19nq=0 then na19s=10;
proc sort; by id ;run;

data ahei19;
    merge nur19(in=a) n19_nts(in=b) n19_sod(in=c) n19_ant(in=d) n15_nts(in=e);
    by id;
    if a=b=c=d;

    fruit19 = sum (0, rais19ds, prune19ds, ban19ds, cant19ds, avo19ds, appl19ds, tancl19ds, oran19ds, grfr19ds, straw19ds, blueb19ds, peach19ds, drcr19ds, mdrfr19ds);

    tveg19 = sum (0, tom19ds, tosau19ds, salsa19ds, sbean19ds, brocc19ds, cauli19ds, cabb19ds, bruss19ds, rcar19ds, ccar19ds, corn19ds, mixv19ds, yam19ds, osqua19ds, eggpl19ds, kale19ds, rspin19ds, cspin19ds, ilett19ds, rlett19ds, cel19ds, grpep19ds, oniov19ds);

    nut19 = sum (0, peas19ds, bean19ds, humm19ds, pbut19ds, pnut19ds, wnut19ds, onut19ds, tofu19ds);

    rmeat19 = sum (0, bfdog19ds, bacon19ds, pmsan19ds, procm19ds, hamb19ds, hambl19ds, bmix19ds, pmain19ds, bmain19ds);

    frtjc19 = sum (0, toj19ds, aj19ds, oj19ds, ojca19ds, grj19ds, othj19ds);

    ssb19 = sum (0, cola19ds, otsug19ds, punch19ds, frtjc19);

    poly19 = poly19n - omega19n;
    ppoly19 = (poly19*900)/calor19n;

    apoly19 = (poly19n*900)/calor19n;

    pomeg19 = (omega19n*90)/calor19n;
    mgomg19 = omega19n*1000;

    ptran19 = (trn1115n*9)/calor15n;

    drinks19 = sum (0, beer19ds, lbeer19ds, rwine19ds, wwine19ds, liq19ds);

    /**
            COMPONENT #1: RED MEAT
            BEST = <1/month (<0.07)
            WORST = >1.5/day
    **/

    if rmeat19=. then rmeat19=0;

    if rmeat19 le 0.07 then meataI19 = 10;
    else if rmeat19 gt 0.07 then do;
            meataI19 = (1.5 - rmeat19)/0.143;
            end;
    if meataI19 le 0 then meataI19 = 0;
    else if meataI19 ge 10 then meataI19 = 10;

    /**
            COMPONENT #2 -- nuts
            BEST = >1
            WORST = 0

    **/

    if nut19 eq 0 then nutI19=0;
    else if nut19 gt 0 then do;
            nutI19 = (nut19/0.1);
            end;

    if nutI19 ge 10 then nutI19 = 10;
    if nutI19 le 0 then nutI19 = 0;

    /**


            COMPONENT #3: SSB + Fruit Juice
            BEST = 0
            WORST = 1+ per day

    **/

    if ssb19 eq 0 then ssbI19 = 10;
    else if ssb19 gt 0 then do;
            ssbI19 = 10 - (ssb19/0.1);
            end;
    if ssbI19 ge 10 then ssbI19 = 10;
    if ssbI19 le 0 then ssbI19  = 0;

    /**

            COMPONENT #4: Total vegetables
            BEST = 5+
            WORST = 0

    **/
    if tveg19 = 0 then tvegI19=0;
    else if tveg19 gt 0 then do;
            tvegI19 = tveg19/0.5;
            end;
    if tvegI19 ge 10 then tvegI19 = 10;
    if tvegI19 le 0 then tvegI19  = 0;

    /**

            COMPONENT #5: Fruits
            BEST = 4+
            WORST = 0

    **/

    if  fruit19 eq 0 then frtI19a=0;
    else if fruit19 gt 0 then do;
            frtI19a = fruit19/0.4;
            end;
    if frtI19a ge 10 then frtI19a = 10;
    if frtI19a le 0 then frtI19a  = 0;

    /**

            COMPONENT #6: Poly fat
            Best: >10%
            Worst: <2%

    **/
    if ppoly19 le 2 then ppolyI19 = 0;
    else if ppoly19 gt 2 then do;
            ppolyI19 = (ppoly19-2)/0.8;
            end;
    if ppolyI19 le 0 then ppolyI19=0;
    if ppolyI19 ge 10 then ppolyI19=10;

    if apoly19 le 2 then polyI19 = 0;
    else if apoly19 gt 2 then do;
            polyI19 = (apoly19-2)/0.8;
            end;
    if polyI19 le 0 then polyI19=0;
    if polyI19 ge 10 then polyI19=10;

    /**

            COMPONENT #7 -- trans fat
            BEST = <0.5%
            WORST = >4%

    **/

    if ptran19 le 0.005 then tranI19=10;

    if ptran19 le 0.005 then tranI19=10;
    else if ptran19 gt 0.005 then do;

            tranI19 = (0.04-ptran19)/0.0035;
            end;

    if tranI19 ge 10 then tranI19 = 10;
    if tranI19 le 0 then tranI19 = 0;

    /**

            COMPONENT #8 -- ALCOHOL
            best = 0.5 - 1.5 drinks/day
            worst = 0 or >2.5 /day

    **/


    if             drinks19 eq 0   then nETOHI19c=2.5;
    else if 0   lt drinks19 lt 0.5 then nETOHI19c=5.0;
    else if 0.5 le drinks19 le 1.5 then nETOHI19c=10;
    else if 1.5 lt drinks19 le 2.0 then nETOHI19c=5.0;
    else if 2.0 lt drinks19 lt 2.5 then nETOHI19c=2.5;
    else if        drinks19 ge 2.5 then nETOHI19c=0;


    /**
            COMPONENT #9 -- omega
            best = 250+ mg/day
            worst = 0 day

    **/

    if mgomg19=0 then omegI19=0;
    else if mgomg19 gt 0 then do;
            omegI19 = mgomg19/25;
            end;

    if omegI19 le 0 then omegI19 = 0;
    else if omegI19 ge 10 then omegI19 = 10;

    /**

            COMPONENT #10: Whole grains
            best =75 g
            worst = 0 g

    **/

    if whgrn19a eq 0 then wgI19=0;
    else if whgrn19a gt 0 then do;
            wgI19 = whgrn19a/7.5;
            end;
    if wgI19 ge 10 then wgI19 = 10;
    if wgI19 le 0 then wgI19  = 0;

    nAHEI19a = sum(meataI19, nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, omegI19, wgI19, na19s);
    ahei19=nAHEI19a; 
    aheinoal19 = sum(meataI19, nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, omegI19, wgI19, na19s);
    aheinopt19 = sum(meataI19, nutI19, ssbI19, tvegI19, frtI19a, nETOHI19c, omegI19, wgI19, na19s);
    aheifisha19 = sum(nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, wgI19, na19s);
    aheidairy19 = sum(nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, omegI19, wgI19, na19s);
    aheinutbl19 = sum(ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, omegI19, wgI19, na19s);
    aheipoult19 = sum(nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, omegI19, wgI19, na19s);
    aheineggs19 = sum(nutI19, ssbI19, tvegI19, frtI19a, ppolyI19, tranI19, nETOHI19c, omegI19, wgI19, na19s);
run;
proc sort data=ahei19;by id;run;    


data foods;
    merge food91 n91_nts food95 n95_nts food99 n99_nts food03 n03_nts food07 n07_nts food11 n11_nts food15 n15_nts nur19 n19_nts ahei15 ahei19;
    by id;
run;


/*PROC DATASETS;
    delete food91 n91_nts food95 n95_nts food99 n99_nts food03 n03_nts food07 n07_nts food11 n11_nts food15 n15_nts ahei15;
RUN;*/

proc means data=foods;var tpotat91d tpotat95d tpotat99d tpotat03d tpotat07d tpotat11d tpotat15d tpotat19d 
                          bbmpot91d bbmpot95d bbmpot99d bbmpot03d bbmpot07d bbmpot11d bbmpot15d bbmpot19d
                          fpotat91d fpotat95d fpotat99d fpotat03d fpotat07d fpotat11d fpotat15d fpotat19d
                          chipss91d chipss95d chipss99d chipss03d chipss07d chipss11d chipss15d chipss19d 
                          trmeat91d trmeat95d trmeat99d trmeat03d trmeat07d trmeat11d trmeat15d trmeat19d
                          prmeat91d prmeat95d prmeat99d prmeat03d prmeat07d prmeat11d prmeat15d prmeat19d
                          urmeat91d urmeat95d urmeat99d urmeat03d urmeat07d urmeat11d urmeat15d urmeat19d
                          poultr91d poultr95d poultr99d poultr03d poultr07d poultr11d poultr15d poultr19d
                          fishal91d fishal95d fishal99d fishal03d fishal07d fishal11d fishal15d fishal19d
                          regegg91d regegg95d regegg99d regegg03d regegg07d regegg11d regegg15d regegg19d
                          hdairy91d hdairy95d hdairy99d hdairy03d hdairy07d hdairy11d hdairy15d hdairy19d
                          ldairy91d ldairy95d ldairy99d ldairy03d ldairy07d ldairy11d ldairy15d ldairy19d
                          soypro91d soypro95d soypro99d soypro03d soypro07d soypro11d soypro15d soypro19d
                          nutsal91d nutsal95d nutsal99d nutsal03d nutsal07d nutsal11d nutsal15d nutsal19d
                          legume91d legume95d legume99d legume03d legume07d legume11d legume15d legume19d
                          fruits91d fruits95d fruits99d fruits03d fruits07d fruits11d fruits15d fruits19d
                          vegeal91d vegeal95d vegeal99d vegeal03d vegeal07d vegeal11d vegeal15d vegeal19d
                          nstveg91d nstveg95d nstveg99d nstveg03d nstveg07d nstveg11d nstveg15d nstveg19d 
                          staveg91d staveg95d staveg99d staveg03d staveg07d staveg11d staveg15d staveg19d   
                          tdairy91d tdairy95d tdairy99d tdairy03d tdairy07d tdairy11d tdairy15d tdairy19d
                          coffee91d coffee95d coffee99d coffee03d coffee07d coffee11d coffee15d coffee19d 
                          nutleg91d nutleg95d nutleg99d nutleg03d nutleg07d nutleg11d nutleg15d nutleg19d
                          bwrice91d bwrice95d bwrice99d bwrice03d bwrice07d bwrice11d bwrice15d bwrice19d
                          wtrice91d wtrice95d wtrice99d wtrice03d wtrice07d wtrice11d wtrice15d wtrice19d
                          SSB91d SSB95d SSB99d SSB03d SSB07d SSB11d SSB15d SSB19d
                          trnss91n trnss95n trn0099n trn0203n trn0707n trn1111n trn1115n
                          afat91d afat95d afat99d afat03d afat07d afat11d afat15d afat19d
                          vfat91d vfat95d vfat99d vfat03d vfat07d vfat11d vfat15d vfat19d
                          ahei15 aheinopt15 aheinoal15 aheifisha15 aheidairy15 aheinutbl15 aheipoult15 aheineggs15 aheineggs15
                          ahei19 aheinopt19 aheinoal19 aheifisha19 aheidairy19 aheinutbl19 aheipoult19 aheineggs19 aheineggs19
                          conf91d conf95d conf99d conf03d conf07d conf11d conf15d conf19d;run;








