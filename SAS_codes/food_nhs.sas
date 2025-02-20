%serv84(keep= fries_s84 pot_s84 pchip_s84
              dog_s84 bacon_s84 procm_s84 
              hamb_s84 bmix_s84 bmain_s84
              chwi_s84 chwo_s84
              ctuna_s84 dkfsh_s84 ofish_s84
              whole_s84 cream_s84 icecr_s84 but_s84 sour_s84 crmch_s84 otch_s84
              skim_s84 sherb_s84 yog_s84 cotch_s84
              egg_s84
              tofu_s84
              pbut_s84 nut_s84
              peas_s84 bean_s84
              rais_s84 prune_s84 ban_s84 cant_s84 appl_s84 oran_s84 grfr_s84 straw_s84 blueb_s84 peach_s84 h2om_s84
              tom_s84 tosau_s84 sbean_s84 brocc_s84 cauli_s84 cabb_s84 bruss_s84 car_s84 corn_s84 mixv_s84 yam_s84 ysqua_s84 eggpl_s84 kale_s84 rspin_s84 cspin_s84 ilett_s84 rlett_s84 cel_s84 beet_s84
              cola_s84 cnoc_s84 otsug_s84 punch_s84
              coff_s84 dcaf_s84
              brice_s84
              wrice_s84
              cdywo_s84 cdyw_s84 choco_s84);

%n84_nts(keep= whgrn84n rfgrn84n gl84n gid84n afat84n vfat84n calor84n pot_carb84n trans84n);

data food84;
    set serv84;
run;

data food84;
    set food84;

    /*Total Potato*/
    tpotat84d = sum(0, fries_s84, pot_s84);

    /*Baked, boiled, mashed Potato*/
    bbmpot84d = sum(0, pot_s84);

    /*Fries Potato*/
    fpotat84d = sum(0, fries_s84);

    /*Chips*/
    chipss84d = sum(0, pchip_s84);

    /*Red meat*/
    prmeat84d = sum(0, dog_s84, bacon_s84, procm_s84 );
    urmeat84d = sum(0, hamb_s84, bmix_s84, bmain_s84);
    trmeat84d = sum(0, prmeat84d, urmeat84d);

    /*Unprocessed poultry*/
    poultr84d = sum(0, chwi_s84, chwo_s84);

    /*Fish*/
    fishal84d = sum(0, ctuna_s84, dkfsh_s84, ofish_s84);

    /*High fat dairy*/
    hdairy84d = sum(0, whole_s84, cream_s84, icecr_s84, sour_s84, crmch_s84, otch_s84);

    /*Low fat dairy*/
    ldairy84d = sum(0, skim_s84, sherb_s84, yog_s84, cotch_s84);

    /*Regular eggs*/
    regegg84d = sum(0, egg_s84);

    /*Soy*/
    soypro84d = sum(0, tofu_s84);

    /*Nuts*/
    nutsal84d = sum(0, pbut_s84, nut_s84);

    /*Legumes*/
    legume84d = sum(0, peas_s84, bean_s84);

    /*Fruits*/
    fruits84d = sum(0, rais_s84, prune_s84, ban_s84, cant_s84, appl_s84, oran_s84, grfr_s84, straw_s84, blueb_s84, peach_s84, h2om_s84);

    /*Vegetables*/
    vegeal84d = sum(0, tom_s84, tosau_s84, sbean_s84, brocc_s84, cauli_s84, cabb_s84, bruss_s84, car_s84, corn_s84, mixv_s84, yam_s84, ysqua_s84, eggpl_s84, kale_s84, rspin_s84, cspin_s84, ilett_s84, rlett_s84, cel_s84, beet_s84);

   /*Non-starchy Vegetables*/
    nstveg84d = sum(0, tom_s84, tosau_s84, sbean_s84, brocc_s84, cauli_s84, cabb_s84, bruss_s84, car_s84, mixv_s84, eggpl_s84, kale_s84, rspin_s84, cspin_s84, ilett_s84, rlett_s84, cel_s84, beet_s84);

    /*Starchy Vegetables*/
    staveg84d = sum(0, corn_s84, yam_s84, ysqua_s84, peas_s84, bean_s84);

    /*Dairy*/
    tdairy84d = sum(0, hdairy84d, ldairy84d);

    /*Coffee*/
    coffee84d = sum(0, coff_s84, dcaf_s84);

    /*Nut, Legumes, Beans*/
    nutleg84d = sum(0, nutsal84d, legume84d);

    /*Brown rice*/
    bwrice84d = sum(0, brice_s84);

    /*White rice*/
    wtrice84d = sum(0, wrice_s84);

    /*Sugar sweetened beverages*/
    SSB84d = sum(0, cola_s84, cnoc_s84, otsug_s84, punch_s84);

    /*confectionery*/
   conf84d = sum(0, cdywo_s84, cdyw_s84, choco_s84);
run;

data n84_nts;
    set n84_nts;

    whgrns84d = whgrn84n/28;
    rfgrns84d = rfgrn84n/28;
    afat84d = afat84n/15;
    vfat84d = vfat84n/15;
run;


%serv86(keep= fries_s86 pot_s86 pchip_s86
              dog_s86 bacon_s86 procm_s86
              hamb_s86 bmix_s86 bmain_s86
              chwi_s86 chwo_s86
              ctuna_s86 dkfsh_s86 ofish_s86
              whole_s86 cream_s86 icecr_s86 but_s86 sour_s86 crmch_s86 otch_s86
              skim_s86 sherb_s86 yog_s86 cotch_s86 
              egg_s86
              tofu_s86 
              pbut_s86 pnut_s86 onut_s86
              peas_s86 bean_s86
              rais_s86 prune_s86 ban_s86 cant_s86 avo_s86 appl_s86 pear_s86 apsau_s86 oran_s86 grfr_s86 straw_s86 blueb_s86 peach_s86 h2om_s86 cpeac_s86 cpear_s86 fcock_s86
              tom_s86 tosau_s86 sbean_s86 brocc_s86 cauli_s86 slaw_s86 ccabb_s86 bruss_s86 rcar_s86 ccar_s86 corn_s86 mixv_s86 yam_s86 ysqua_s86 eggpl_s86 kale_s86 rspin_s86 cspin_s86 ilett_s86 rlett_s86 cel_s86 kraut_s86
              soda_s86 punch_s86
              coff_s86 dcaf_s86
              brice_s86
              wrice_s86
              cdywo_s86 cdyw_s86 choco_s86);

%n86_nts(keep= whgrn86n rfgrn86n gl86n gid86n afat86n vfat86n calor86n pot_carb86n trnss86n);

data food86;
    set serv86;
run;

data food86;
    set food86;

    /*Total Potato*/
    tpotat86d = sum(0, fries_s86, pot_s86);

    /*Baked, boiled, mashed Potato*/
    bbmpot86d = sum(0, pot_s86);

    /*Fries Potato*/
    fpotat86d = sum(0, fries_s86);

    /*Chips*/
    chipss86d = sum(0, pchip_s86);

    /*Red meat*/
    prmeat86d = sum(0, dog_s86, bacon_s86, procm_s86);
    urmeat86d = sum(0, hamb_s86, bmix_s86, bmain_s86);
    trmeat86d = sum(0, prmeat86d, urmeat86d);

    /*Unprocessed poultry*/
    poultr86d = sum(0, chwi_s86, chwo_s86);

    /*Fish*/
    fishal86d = sum(0, ctuna_s86, dkfsh_s86, ofish_s86);

    /*High fat dairy*/
    hdairy86d = sum(0, whole_s86, cream_s86, icecr_s86, sour_s86, crmch_s86, otch_s86);

    /*Low fat dairy*/
    ldairy86d = sum(0, skim_s86, sherb_s86, yog_s86, cotch_s86);

    /*Regular eggs*/
    regegg86d = sum(0, egg_s86);

    /*Soy*/
    soypro86d = sum(0, tofu_s86);

    /*Nuts*/
    nutsal86d = sum(0, pbut_s86, pnut_s86, onut_s86);

    /*Legumes*/
    legume86d = sum(0, peas_s86, bean_s86);

    /*Fruits*/
    fruits86d = sum(0, rais_s86, prune_s86, ban_s86, cant_s86, avo_s86, appl_s86, pear_s86, apsau_s86, oran_s86, grfr_s86, straw_s86, blueb_s86, peach_s86, h2om_s86, cpeac_s86, cpear_s86, fcock_s86);

    /*Vegetables*/
    vegeal86d = sum(0, tom_s86, tosau_s86, sbean_s86, brocc_s86, cauli_s86, slaw_s86, ccabb_s86, bruss_s86, rcar_s86, ccar_s86, corn_s86, mixv_s86, yam_s86, ysqua_s86, eggpl_s86, kale_s86, rspin_s86, cspin_s86, ilett_s86, rlett_s86, cel_s86, kraut_s86);

    /*Non-starchy Vegetables*/
    nstveg86d = sum(0, tom_s86, tosau_s86, sbean_s86, brocc_s86, cauli_s86, slaw_s86, ccabb_s86, bruss_s86, rcar_s86, ccar_s86, mixv_s86, eggpl_s86, kale_s86, rspin_s86, cspin_s86, ilett_s86, rlett_s86, cel_s86, kraut_s86);

    /*Starchy Vegetables*/
    staveg86d = sum(0, corn_s86, yam_s86, ysqua_s86, peas_s86, bean_s86);

    /*Dairy*/
    tdairy86d = sum(0, hdairy86d, ldairy86d);

    /*Coffee*/
    coffee86d = sum(0, coff_s86, dcaf_s86);

    /*Nut, Legumes, Beans*/
    nutleg86d = sum(0, nutsal86d, legume86d);

    /*Brown rice*/
    bwrice86d = sum(0, brice_s86);

    /*White rice*/
    wtrice86d = sum(0, wrice_s86);

    /*Sugar sweetened beverages*/
    SSB86d = sum(0, soda_s86, punch_s86);

        /*confectionery*/
   conf86d = sum(0, cdywo_s86, cdyw_s86, choco_s86);

run;

data n86_nts;
    set n86_nts;

    whgrns86d = whgrn86n/28;
    rfgrns86d = rfgrn86n/28;
    afat86d = afat86n/15;
    vfat86d = vfat86n/15;
run;


%serv90(keep= fries_s90 pot_s90 pchip_s90
              dog_s90 bacon_s90 procm_s90
              hamb_s90 bmix_s90 pmain_s90 bmain_s90
              chwi_s90 chwo_s90
              ctuna_s90 dkfsh_s90 ofish_s90
              whole_s90 cream_s90 icecr_s90 but_s90 sour_s90 crmch_s90 otch_s90
              skim_s90 sherb_s90 yog_s90 cotch_s90
              egg_s90
              tofu_s90
              pbut_s90 pnut_s90 onut_s90
              peas_s90 bean_s90
              rais_s90 prune_s90 ban_s90 cant_s90 appl_s90 apsau_s90 oran_s90 grfr_s90 straw_s90 blueb_s90 peach_s90 h2om_s90 
              tom_s90 tosau_s90 sbean_s90 brocc_s90 cauli_s90 cabb_s90 bruss_s90 rcar_s90 ccar_s90 corn_s90 mixv_s90 yam_s90 osqua_s90 eggpl_s90 kale_s90 rspin_s90 cspin_s90 ilett_s90 rlett_s90 cel_s90 oniov_s90 beet_s90
              cola_s90 cnoc_s90 otsug_s90 punch_s90
              dcaf_s90 coff_s90
              brice_s90
              wrice_s90
              cdywo_s90 cdyw_s90 choco_s90);

%n90_nts(keep= whgrn90n rfgrn90n gl90n gid90n afat90n vfat90n calor90n pot_carb90n trnss90n);

data food90;
    set serv90;
run;

data food90;
    set food90;

    /*Total Potato*/
    tpotat90d = sum(0, fries_s90, pot_s90);

    /*Baked, boiled, mashed Potato*/
    bbmpot90d = sum(0, pot_s90);

    /*Fries Potato*/
    fpotat90d = sum(0, fries_s90);

    /*Chips*/
    chipss90d = sum(0, pchip_s90);

    /*Red meat*/
    prmeat90d = sum(0, dog_s90, bacon_s90, procm_s90);
    urmeat90d = sum(0, hamb_s90, bmix_s90, pmain_s90, bmain_s90);
    trmeat90d = sum(0, prmeat90d, urmeat90d);

    /*Unprocessed poultry*/
    poultr90d = sum(0, chwi_s90, chwo_s90);

    /*Fish*/
    fishal90d = sum(0, ctuna_s90, dkfsh_s90, ofish_s90);

    /*High fat dairy*/
    hdairy90d = sum(0, whole_s90, cream_s90, icecr_s90, sour_s90, crmch_s90, otch_s90);

    /*Low fat dairy*/
    ldairy90d = sum(0, skim_s90, sherb_s90, yog_s90, cotch_s90);

    /*Regular eggs*/
    regegg90d = sum(0, egg_s90);

    /*Soy*/
    soypro90d = sum(0, tofu_s90);

    /*Nuts*/
    nutsal90d = sum(0, pbut_s90, pnut_s90, onut_s90);

    /*Legumes*/
    legume90d = sum(0, peas_s90, bean_s90);

    /*Fruits*/
    fruits90d = sum(0, rais_s90, prune_s90, ban_s90, cant_s90, appl_s90, apsau_s90, oran_s90, grfr_s90, straw_s90, blueb_s90, peach_s90, h2om_s90);

    /*Vegetables*/
    vegeal90d = sum(0, tom_s90, tosau_s90, sbean_s90, brocc_s90, cauli_s90, cabb_s90, bruss_s90, rcar_s90, ccar_s90, corn_s90, mixv_s90, yam_s90, osqua_s90, eggpl_s90, kale_s90, rspin_s90, cspin_s90, ilett_s90, rlett_s90, cel_s90, oniov_s90, beet_s90);

    /*Non-starchy Vegetables*/
    nstveg90d = sum(0, tom_s90, tosau_s90, sbean_s90, brocc_s90, cauli_s90, cabb_s90, bruss_s90, rcar_s90, ccar_s90, mixv_s90, eggpl_s90, kale_s90, rspin_s90, cspin_s90, ilett_s90, rlett_s90, cel_s90, oniov_s90, beet_s90);

    /*Starchy Vegetables*/
    staveg90d = sum(0, corn_s90, yam_s90, osqua_s90, peas_s90, bean_s90);

    /*Dairy*/
    tdairy90d = sum(0, hdairy90d, ldairy90d);

    /*Coffee*/
    coffee90d = sum(0, dcaf_s90, coff_s90);

    /*Nut, Legumes, Beans*/
    nutleg90d = sum(0, nutsal90d, legume90d);

    /*Brown rice*/
    bwrice90d = sum(0, brice_s90);

    /*White rice*/
    wtrice90d = sum(0, wrice_s90);

    /*Sugar sweetened beverages*/
    SSB90d = sum(0, cola_s90, cnoc_s90, otsug_s90, punch_s90);

    /*confectionery*/
   conf90d = sum(0, cdywo_s90, cdyw_s90, choco_s90);
run;

data n90_nts;
    set n90_nts;

    whgrns90d = whgrn90n/28;
    rfgrns90d = rfgrn90n/28;
    afat90d = afat90n/15;
    vfat90d = vfat90n/15;

run;


%serv94(keep= fries_s94 pot_s94 pchip_s94
              bfdog_s94 bacon_s94 procm_s94
              hamb_s94 hambl_s94 bmix_s94 pmain_s94 bmain_s94
              ctdog_s94 chwi_s94 chwo_s94
              ctuna_s94 bfsh_s94 dkfsh_s94 ofish_s94
              whole_s94 cream_s94 icecr_s94 but_s94 crmch_s94 otch_s94
              skim_s94 m1or2_s94 sherb_s94 plyog_s94 flyog_s94 cotch_s94
              egg_s94
              tofu_s94 
              pbut_s94 pnut_s94 onut_s94
              peas_s94 bean_s94
              rais_s94 prune_s94 ban_s94 cant_s94 avo_s94 appl_s94 oran_s94 grfr_s94 straw_s94 blueb_s94 peach_s94 
              tom_s94 tosau_s94 sbean_s94 brocc_s94 cauli_s94 cabb_s94 bruss_s94 rcar_s94 ccar_s94 corn_s94 mixv_s94 yam_s94 osqua_s94 eggpl_s94 kale_s94 rspin_s94 cspin_s94 ilett_s94 rlett_s94 cel_s94 oniov_s94
              cola_s94 cnoc_s94 otsug_s94 punch_s94
              dcaf_s94 coff_s94
              brice_s94
              wrice_s94
              cdywo_s94 cdyw_s94 choco_s94);

%n94_nts(keep= whgrn94n rfgrn94n gl94n gid94n afat94n vfat94n calor94n pot_carb94n trnss94n);
%n94_dt(keep= chtyp94d)

data food94;
    merge serv94 n94_dt;
    by id;
run;

data food94;
    set food94;

    /*Total Potato*/
    tpotat94d = sum(0, fries_s94, pot_s94);

    /*Baked, boiled, mashed Potato*/
    bbmpot94d = sum(0, pot_s94);

    /*Fries Potato*/
    fpotat94d = sum(0, fries_s94);

    /*Chips*/
    chipss94d = sum(0, pchip_s94);

    /*Red meat*/
    prmeat94d = sum(0, bfdog_s94, bacon_s94, procm_s94);
    urmeat94d = sum(0, hamb_s94, hambl_s94, bmix_s94, pmain_s94, bmain_s94);
    trmeat94d = sum(0, prmeat94d, urmeat94d);

    /*Unprocessed poultry*/
    poultr94d = sum(0, ctdog_s94, chwi_s94, chwo_s94);

    /*Fish*/
    fishal94d = sum(0, ctuna_s94, bfsh_s94, dkfsh_s94, ofish_s94);

    /*High fat dairy*/
    if chtyp94d in (1,3,4) then hfcheese94 = otch_s94; else hfcheese94 = .;
    hdairy94d = sum(0, whole_s94, cream_s94, icecr_s94, crmch_s94, hfcheese94);

    /*Low fat dairy*/
    if chtyp94d = 2 then lfcheese94 = otch_s94; else lfcheese94 = .;
    ldairy94d = sum(0, skim_s94, m1or2_s94, sherb_s94, plyog_s94, flyog_s94, cotch_s94, lfcheese94);

    /*Regular eggs*/
    regegg94d = sum(0, egg_s94);

    /*Soy*/
    soypro94d = sum(0, tofu_s94);

    /*Nuts*/
    nutsal94d = sum(0, pbut_s94, pnut_s94, onut_s94);

    /*Legumes*/
    legume94d = sum(0, peas_s94, bean_s94);

    /*Fruits*/
    fruits94d = sum(0, rais_s94, prune_s94, ban_s94, cant_s94, avo_s94, appl_s94, oran_s94, grfr_s94, straw_s94, blueb_s94, peach_s94);

    /*Vegetables*/
    vegeal94d = sum(0, tom_s94, tosau_s94, sbean_s94, brocc_s94, cauli_s94, cabb_s94, bruss_s94, rcar_s94, ccar_s94, corn_s94, mixv_s94, yam_s94, osqua_s94, eggpl_s94, kale_s94, rspin_s94, cspin_s94, ilett_s94, rlett_s94, cel_s94, oniov_s94);
    
    /*Non-starchy Vegetables*/
    nstveg94d = sum(0, tom_s94, tosau_s94, sbean_s94, brocc_s94, cauli_s94, cabb_s94, bruss_s94, rcar_s94, ccar_s94, mixv_s94, eggpl_s94, kale_s94, rspin_s94, cspin_s94, ilett_s94, rlett_s94, cel_s94, oniov_s94);

    /*Starchy Vegetables*/
    staveg94d = sum(0, corn_s94, yam_s94, osqua_s94, peas_s94, bean_s94);

    /*Dairy*/
    tdairy94d = sum(0, hdairy94d, ldairy94d);
    
    /*Coffee*/
    coffee94d = sum(0, dcaf_s94, coff_s94);

    /*Nut, Legumes, Beans*/
    nutleg94d = sum(0, nutsal94d, legume94d);

    /*Brown rice*/
    bwrice94d = sum(0, brice_s94);

    /*White rice*/
    wtrice94d = sum(0, wrice_s94);

    /*Sugar sweetened beverages*/
    SSB94d = sum(0, cola_s94, cnoc_s94, otsug_s94, punch_s94);

    /*confectionery*/
   conf94d = sum(0, cdywo_s94, cdyw_s94, choco_s94);

run;

data n94_nts;
    set n94_nts;

    whgrns94d = whgrn94n/28;
    rfgrns94d = rfgrn94n/28;
    afat94d = afat94n/15;
    vfat94d = vfat94n/15;
run;


%serv98(keep= fries_s98 pot_s98 pchip_s98
              bfdog_s98 bacon_s98 pmsan_s98 procm_s98
              hamb_s98 hambl_s98 bmix_s98 pmain_s98 bmain_s98
              ctdog_s98 chksa_s98 chwi_s98 chwo_s98
              ctuna_s98 bfsh_s98 dkfsh_s98 ofish_s98
              whole_s98 cream_s98 icecr_s98 but_s98 crmch_s98 otch_s98
              skim_s98 m2_s98 sherb_s98 plyog_s98 flyog_s98 cotch_s98
              egg_s98
              soy_s98 tofu_s98
              pbut_s98 pnut_s98 wnut_s98 onut_s98
              peas_s98 bean_s98
              rais_s98 prune_s98 ban_s98 cant_s98 avo_s98 appl_s98 oran_s98 grfr_s98 straw_s98 blueb_s98 peach_s98 
              tom_s98 tosau_s98 sbean_s98 brocc_s98 cauli_s98 cabb_s98 bruss_s98 rcar_s98 ccar_s98 corn_s98 mixv_s98 yam_s98 osqua_s98 eggpl_s98 kale_s98 rspin_s98 cspin_s98 ilett_s98 rlett_s98 cel_s98 oniov_s98
              cola_s98 otsnc_s98 otsug_s98 punch_s98
              dcaf_s98 coff_s98
              brice_s98
              wrice_s98
              cdywo_s98 cdyw_s98 choco_s98);

%n98_nts(keep= whgrn98n rfgrn98n gl98n gid98n afat98n vfat98n calor98n pot_carb98n trn0098n);
%n98_dt(keep= chtyp98d)

data food98;
    merge serv98 n98_dt;
    by id;
run;

data food98;
    set food98;

    /*Total Potato*/
    tpotat98d = sum(0, fries_s98, pot_s98);

    /*Baked, boiled, mashed Potato*/
    bbmpot98d = sum(0, pot_s98);

    /*Fries Potato*/
    fpotat98d = sum(0, fries_s98);

    /*Chips*/
    chipss98d = sum(0, pchip_s98);

    /*Red meat*/
    prmeat98d = sum(0, bfdog_s98, bacon_s98, pmsan_s98, procm_s98);
    urmeat98d = sum(0, hamb_s98, hambl_s98, bmix_s98, pmain_s98, bmain_s98);
    trmeat98d = sum(0, prmeat98d, urmeat98d);

    /*Unprocessed poultry*/
    poultr98d = sum(0, ctdog_s98, chksa_s98, chwi_s98, chwo_s98);

    /*Fish*/
    fishal98d = sum(0, ctuna_s98, bfsh_s98, dkfsh_s98, ofish_s98);

    /*High fat dairy*/
    if chtyp98d in (1,3,4) then hfcheese98 = otch_s98; else hfcheese98 = .;
    hdairy98d = sum(0, whole_s98, cream_s98, icecr_s98, crmch_s98, hfcheese98);

    /*Low fat dairy*/
    if chtyp98d = 2 then lfcheese98 = otch_s98; else lfcheese98 = .;
    ldairy98d = sum(0, skim_s98, m2_s98, sherb_s98, plyog_s98, flyog_s98, cotch_s98, lfcheese98);

    /*Regular eggs*/
    regegg98d = sum(0, egg_s98);

    /*Soy*/
    soypro98d = sum(0, soy_s98, tofu_s98);

    /*Nuts*/
    nutsal98d = sum(0, pbut_s98, pnut_s98, wnut_s98, onut_s98);

    /*Legumes*/
    legume98d = sum(0, peas_s98, bean_s98);

    /*Fruits*/
    fruits98d = sum(0, rais_s98, prune_s98, ban_s98, cant_s98, avo_s98, appl_s98, oran_s98, grfr_s98, straw_s98, blueb_s98, peach_s98 );

    /*Vegetables*/
    vegeal98d = sum(0, tom_s98, tosau_s98, sbean_s98, brocc_s98, cauli_s98, cabb_s98, bruss_s98, rcar_s98, ccar_s98, corn_s98, mixv_s98, yam_s98, osqua_s98, eggpl_s98, kale_s98, rspin_s98, cspin_s98, ilett_s98, rlett_s98, cel_s98, oniov_s98);

    /*Non-starchy Vegetables*/
    nstveg98d = sum(0, tom_s98, tosau_s98, sbean_s98, brocc_s98, cauli_s98, cabb_s98, bruss_s98, rcar_s98, ccar_s98, mixv_s98, eggpl_s98, kale_s98, rspin_s98, cspin_s98, ilett_s98, rlett_s98, cel_s98, oniov_s98);

    /*Starchy Vegetables*/
    staveg98d = sum(0, corn_s98, yam_s98, osqua_s98, peas_s98, bean_s98);

    /*Dairy*/
    tdairy98d = sum(0, hdairy98d, ldairy98d);
 
    /*Coffee*/
    coffee98d = sum(0, dcaf_s98, coff_s98);

    /*Nut, Legumes, Beans*/
    nutleg98d = sum(0, nutsal98d, legume98d);

    /*Brown rice*/
    bwrice98d = sum(0, brice_s98);

    /*White rice*/
    wtrice98d = sum(0, wrice_s98);

    /*Sugar sweetened beverages*/
    SSB98d = sum(0, cola_s98, otsnc_s98, otsug_s98, punch_s98);

    /*confectionery*/
   conf98d = sum(0, cdywo_s98, cdyw_s98, choco_s98);
run;

data n98_nts;
    set n98_nts;

    whgrns98d = whgrn98n/28;
    rfgrns98d = rfgrn98n/28;
    afat98d = afat98n/15;
    vfat98d = vfat98n/15;

run;


%serv02(keep= fries_s02 pot_s02 pchip_s02
              bfdog_s02 bacon_s02 pmsan_s02 procm_s02
              hamb_s02 hambl_s02 bmix_s02 pmain_s02 bmain_s02
              ctdog_s02 chksa_s02 chwi_s02 chwo_s02
              ctuna_s02 bfsh_s02 dkfsh_s02 ofish_s02
              whole_s02 cream_s02 icecr_s02 but_s02 crmch_s02 otch_s02
              skim_s02 m1or2_s02 sherb_s02 plyog_s02 flyog_s02 cotch_s02
              egg_s02 eggwh_s02
              soy_s02 tofu_s02
              pbut_s02 pnut_s02 wnut_s02 onut_s02
              peas_s02 bean_s02
              rais_s02 prune_s02 ban_s02 cant_s02 appl_s02 apsau_s02 oran_s02 grfr_s02 straw_s02 blueb_s02 peach_s02
              tom_s02 tosau_s02 sbean_s02 brocc_s02 cauli_s02 cabb_s02 bruss_s02 rcar_s02 ccar_s02 corn_s02 mixv_s02 yam_s02 osqua_s02 eggpl_s02 kale_s02 rspin_s02 cspin_s02 ilett_s02 rlett_s02 cel_s02 oniov_s02
              cola_s02 otsug_s02 punch_s02
              dcaf_s02 coff_s02
              brice_s02
              wrice_s02
              cdywo_s02 cdyw_s02 choco_s02);

%n02_nts(keep= whgrn02n rfgrn02n gl02n gid02n afat02n vfat02n calor02n pot_carb02n trn0202n);
%nur02(keep= chreg02d chlit02d chnft02d chnon02d chpt02d)

data food02;
    merge serv02 nur02;
    by id;
run;

data food02;
    set food02;

    /*Total Potato*/
    tpotat02d = sum(0, fries_s02, pot_s02);

    /*Baked, boiled, mashed Potato*/
    bbmpot02d = sum(0, pot_s02);

    /*Fries Potato*/
    fpotat02d = sum(0, fries_s02);

    /*Chips*/
    chipss02d = sum(0, pchip_s02);

    /*Red meat*/
    prmeat02d = sum(0, bfdog_s02, bacon_s02, pmsan_s02, procm_s02);
    urmeat02d = sum(0, hamb_s02, hambl_s02, bmix_s02, pmain_s02, bmain_s02);
    trmeat02d = sum(0, prmeat02d, urmeat02d);

    /*Unprocessed poultry*/
    poultr02d = sum(0, ctdog_s02, chksa_s02, chwi_s02, chwo_s02);

    /*Fish*/
    fishal02d = sum(0, ctuna_s02, bfsh_s02, dkfsh_s02, ofish_s02);

    /*High fat dairy*/
    if chreg02d=1 or chnon02d=1 or chpt02d=1 then hfcheese02 = otch_s02; else hfcheese02 = .;
    hdairy02d = sum(0, whole_s02, cream_s02, icecr_s02, crmch_s02, hfcheese02);

    /*Low fat dairy*/
    if chlit02d = 1 or chnft02d=1  then lfcheese02 = otch_s02; else lfcheese02 = .;
    ldairy02d = sum(0, skim_s02, m1or2_s02, sherb_s02, plyog_s02, flyog_s02, cotch_s02, lfcheese02);

    /*Regular eggs*/
    regegg02d = sum(0, egg_s02, eggwh_s02);

    /*Soy*/
    soypro02d = sum(0, soy_s02, tofu_s02);

    /*Nuts*/
    nutsal02d = sum(0, pbut_s02, pnut_s02, wnut_s02, onut_s02);

    /*Legumes*/
    legume02d = sum(0, peas_s02, bean_s02);

    /*Fruits*/
    fruits02d = sum(0, rais_s02, prune_s02, ban_s02, cant_s02, appl_s02, apsau_s02, oran_s02, grfr_s02, straw_s02, blueb_s02, peach_s02);

    /*Vegetables*/
    vegeal02d = sum(0, tom_s02, tosau_s02, sbean_s02, brocc_s02, cauli_s02, cabb_s02, bruss_s02, rcar_s02, ccar_s02, corn_s02, mixv_s02, yam_s02, osqua_s02, eggpl_s02, kale_s02, rspin_s02, cspin_s02, ilett_s02, rlett_s02, cel_s02, oniov_s02);

    /*Non-starchy Vegetables*/
    nstveg02d = sum(0, tom_s02, tosau_s02, sbean_s02, brocc_s02, cauli_s02, cabb_s02, bruss_s02, rcar_s02, ccar_s02, mixv_s02, eggpl_s02, kale_s02, rspin_s02, cspin_s02, ilett_s02, rlett_s02, cel_s02, oniov_s02);

    /*Starchy Vegetables*/
    staveg02d = sum(0, corn_s02, yam_s02, osqua_s02, peas_s02, bean_s02);

    /*Coffee*/
    coffee02d = sum(0, dcaf_s02, coff_s02);

    /*Dairy*/
    tdairy02d = sum(0, hdairy02d, ldairy02d);

    /*Nut, Legumes, Beans*/
    nutleg02d = sum(0, nutsal02d, legume02d);

    /*Brown rice*/
    bwrice02d = sum(0, brice_s02);

    /*White rice*/
    wtrice02d = sum(0, wrice_s02);

    /*Sugar sweetened beverages*/
    SSB02d = sum(0, cola_s02, otsug_s02, punch_s02);

    /*confectionery*/
   conf02d = sum(0, cdywo_s02, cdyw_s02, choco_s02);
run;

data n02_nts;
    set n02_nts;

    whgrns02d = whgrn02n/28;
    rfgrns02d = rfgrn02n/28;
    afat02d = afat02n/15;
    vfat02d = vfat02n/15;
run;


%serv06(keep= fries_s06 pot_s06 pchip_s06
              bfdog_s06 bacon_s06 pmsan_s06 procm_s06
              hamb_s06 hambl_s06 bmix_s06 pmain_s06 bmain_s06
              ctdog_s06 chksa_s06 chwi_s06 chwo_s06
              ctuna_s06 bfsh_s06 dkfsh_s06 ofish_s06
              whole_s06 cream_s06 icecr_s06 but_s06 crmch_s06 otch_s06
              skim_s06 m1or2_s06 sherb_s06 plyog_s06 flyog_s06 cotch_s06
              egg_s06 eggom_s06
              soy_s06 tofu_s06
              pbut_s06 pnut_s06 wnut_s06 onut_s06
              peas_s06 bean_s06
              rais_s06 prune_s06 ban_s06 cant_s06 avo_s06 appl_s06 oran_s06 grfr_s06 straw_s06 blueb_s06 peach_s06 apric_s06
              tom_s06 tosau_s06 sbean_s06 brocc_s06 cauli_s06 cabb_s06 bruss_s06 rcar_s06 ccar_s06 corn_s06 mixv_s06 yam_s06 osqua_s06 eggpl_s06 kale_s06 rspin_s06 cspin_s06 ilett_s06 rlett_s06 cel_s06 oniov_s06
              cola_s06 otsug_s06 punch_s06
              dcaf_s06 coff_s06
              brice_s06
              wrice_s06
              cdywo_s06 cdyw_s06 dchoc_s06 mchoc_s06);

%n06_nts(keep= whgrn06n rfgrn06n gl06n gid06n afat06n vfat06n calor06n pot_carb06n trn0706n);
%nur06(keep= chreg06d chlit06d chnft06d chnon06d chpt06d)

data food06;
    merge serv06 nur06;
    by id;
run;

data food06;
    set food06;

    /*Total Potato*/
    tpotat06d = sum(0, fries_s06, pot_s06);

    /*Baked, boiled, mashed Potato*/
    bbmpot06d = sum(0, pot_s06);

    /*Fries Potato*/
    fpotat06d = sum(0, fries_s06);

    /*Chips*/
    chipss06d = sum(0, pchip_s06);

    /*Red meat*/
    prmeat06d = sum(0, bfdog_s06, bacon_s06, pmsan_s06, procm_s06);
    urmeat06d = sum(0, hamb_s06, hambl_s06, bmix_s06, pmain_s06, bmain_s06);
    trmeat06d = sum(0, prmeat06d, urmeat06d);

    /*Unprocessed poultry*/
    poultr06d = sum(0, ctdog_s06, chksa_s06, chwi_s06, chwo_s06);

    /*Fish*/
    fishal06d = sum(0, ctuna_s06, bfsh_s06, dkfsh_s06, ofish_s06);

    /*High fat dairy*/
    if chreg06d=1 or chnon06d=1 or chpt06d=1 then hfcheese06 = otch_s06; else hfcheese06 = .;
    hdairy06d = sum(0, whole_s06, cream_s06, icecr_s06, crmch_s06, hfcheese06);

    /*Low fat dairy*/
    if chlit06d = 1 or chnft06d=1  then lfcheese06 = otch_s06; else lfcheese06 = .;
    ldairy06d = sum(0, skim_s06, m1or2_s06, sherb_s06, plyog_s06, flyog_s06, cotch_s06, lfcheese06);

    /*Regular eggs*/
    regegg06d = sum(0, egg_s06, eggom_s06);

    /*Soy*/
    soypro06d = sum(0, soy_s06, tofu_s06);

    /*Nuts*/
    nutsal06d = sum(0, pbut_s06, pnut_s06, wnut_s06, onut_s06);

    /*Legumes*/
    legume06d = sum(0, peas_s06, bean_s06);

    /*Fruits*/
    fruits06d = sum(0, rais_s06, prune_s06, ban_s06, cant_s06, avo_s06, appl_s06, oran_s06, grfr_s06, straw_s06, blueb_s06, peach_s06, apric_s06);

    /*Vegetables*/
    vegeal06d = sum(0, tom_s06, tosau_s06, sbean_s06, brocc_s06, cauli_s06, cabb_s06, bruss_s06, rcar_s06, ccar_s06, corn_s06, mixv_s06, yam_s06, osqua_s06, eggpl_s06, kale_s06, rspin_s06, cspin_s06, ilett_s06, rlett_s06, cel_s06, oniov_s06);

    /*Non-starchy Vegetables*/
    nstveg06d = sum(0, tom_s06, tosau_s06, sbean_s06, brocc_s06, cauli_s06, cabb_s06, bruss_s06, rcar_s06, ccar_s06, mixv_s06, eggpl_s06, kale_s06, rspin_s06, cspin_s06, ilett_s06, rlett_s06, cel_s06, oniov_s06);

    /*Starchy Vegetables*/
    staveg06d = sum(0, corn_s06, yam_s06, osqua_s06, peas_s06, bean_s06);

    /*Dairy*/
    tdairy06d = sum(0, hdairy06d, ldairy06d);

    /*Coffee*/
    coffee06d = sum(0, dcaf_s06, coff_s06);

    /*Nut, Legumes, Beans*/
    nutleg06d = sum(0, nutsal06d, legume06d);

    /*Brown rice*/
    bwrice06d = sum(0, brice_s06);

    /*White rice*/
    wtrice06d = sum(0, wrice_s06);

    /*Sugar sweetened beverages*/
    SSB06d = sum(0, cola_s06, otsug_s06, punch_s06);

    /*confectionery*/
   conf06d = sum(0, cdywo_s06, cdyw_s06, dchoc_s06, mchoc_s06);

run;

data n06_nts;
    set n06_nts;

    whgrns06d = whgrn06n/28;
    rfgrns06d = rfgrn06n/28;
    afat06d = afat06n/15;
    vfat06d = vfat06n/15;
run;


%serv10(keep= fries_s10 pot_s10 pchip_s10
              bfdog_s10 bacon_s10 pmsan_s10 procm_s10 
              hamb_s10 hambl_s10 bmix_s10 pmain_s10 bmain_s10
              ctdog_s10 chksa_s10 chwi_s10 chwo_s10
              ctuna_s10 bfsh_s10 dkfsh_s10 ofish_s10
              egg_s10 eggom_s10
              whole_s10 cream_s10 icecr_s10 but_s10 crmch_s10 otch_s10
              skim_s10 m1or2_s10 sherb_s10 plyog_s10 artyog_s10 flyog_s10 cotch_s10
              soy_s10 tofu_s10
              pbut_s10 pnut_s10 wnut_s10 onut_s10
              peas_s10 bean_s10
              rais_s10 prune_s10 ban_s10 cant_s10 avo_s10 appl_s10 oran_s10 grfr_s10 straw_s10 blueb_s10 peach_s10 apric_s10
              tom_s10 tosau_s10 sbean_s10 brocc_s10 cauli_s10 cabb_s10 bruss_s10 rcar_s10 ccar_s10 corn_s10 mixv_s10 yam_s10 osqua_s10 eggpl_s10 kale_s10 rspin_s10 cspin_s10 ilett_s10 rlett_s10 cel_s10 oniov_s10
              cola_s10 otsug_s10 punch_s10
              dcaf_s10 coff_s10
              brice_s10
              wrice_s10
              cdywo_s10 cdyw_s10 dchoc_s10 mchoc_s10);

%n10_nts(keep= whgrn10n rfgrn10n gl10n gid10n afat10n vfat10n calor10n pot_carb10n trn1110n);
%nur10(keep= chreg10d chlit10d chnft10d chnon10d chpt10d)

data food10;
    merge serv10 nur10;
    by id;
run;

data food10;
    set food10;

    /*Total Potato*/
    tpotat10d = sum(0, fries_s10, pot_s10);

    /*Baked, boiled, mashed Potato*/
    bbmpot10d = sum(0, pot_s10);

    /*Fries Potato*/
    fpotat10d = sum(0, fries_s10);

    /*Chips*/
    chipss10d = sum(0, pchip_s10);

    /*Red meat*/
    prmeat10d = sum(0, bfdog_s10, bacon_s10, pmsan_s10, procm_s10);
    urmeat10d = sum(0, hamb_s10, hambl_s10, bmix_s10, pmain_s10, bmain_s10);
    trmeat10d = sum(0, prmeat10d, urmeat10d);

    /*Unprocessed poultry*/
    poultr10d = sum(0, ctdog_s10, chksa_s10, chwi_s10, chwo_s10);

    /*Fish*/
    fishal10d = sum(0, ctuna_s10, bfsh_s10, dkfsh_s10, ofish_s10);

    /*Regular eggs*/
    regegg10d = sum(0, egg_s10, eggom_s10);

    /*High fat dairy*/
    if chreg10d=1 or chnon10d=1 or chpt10d=1 then hfcheese10 = otch_s10; else hfcheese10 = .;
    hdairy10d = sum(0, whole_s10, cream_s10, icecr_s10, crmch_s10, hfcheese10);

    /*Low fat dairy*/
    if chlit10d = 1 or chnft10d=1  then lfcheese10 = otch_s10; else lfcheese10 = .;
    ldairy10d = sum(0, skim_s10, m1or2_s10, sherb_s10, plyog_s10, artyog_s10, flyog_s10, cotch_s10, lfcheese10);

    /*Soy*/
    soypro10d = sum(0, soy_s10, tofu_s10);

    /*Nuts*/
    nutsal10d = sum(0, pbut_s10, pnut_s10, wnut_s10, onut_s10);

    /*Legumes*/
    legume10d = sum(0, peas_s10, bean_s10);

    /*Fruits*/
    fruits10d = sum(0, rais_s10, prune_s10, ban_s10, cant_s10, avo_s10, appl_s10, oran_s10, grfr_s10, straw_s10, blueb_s10, peach_s10, apric_s10);

    /*Vegetables*/
    vegeal10d = sum(0, tom_s10, tosau_s10, sbean_s10, brocc_s10, cauli_s10, cabb_s10, bruss_s10, rcar_s10, ccar_s10, corn_s10, mixv_s10, yam_s10, osqua_s10, eggpl_s10, kale_s10, rspin_s10, cspin_s10, ilett_s10, rlett_s10, cel_s10, oniov_s10);

    /*Non-starchy Vegetables*/
    nstveg10d = sum(0, tom_s10, tosau_s10, sbean_s10, brocc_s10, cauli_s10, cabb_s10, bruss_s10, rcar_s10, ccar_s10, mixv_s10, eggpl_s10, kale_s10, rspin_s10, cspin_s10, ilett_s10, rlett_s10, cel_s10, oniov_s10);

    /*Starchy Vegetables*/
    staveg10d = sum(0, corn_s10, yam_s10, osqua_s10, peas_s10, bean_s10);

    /*Dairy*/
    tdairy10d = sum(0, hdairy10d, ldairy10d);

    /*Coffee*/
    coffee10d = sum(0, dcaf_s10, coff_s10);

    /*Nut, Legumes, Beans*/
    nutleg10d = sum(0, nutsal10d, legume10d);

    /*Brown rice*/
    bwrice10d = sum(0, brice_s10);

    /*White rice*/
    wtrice10d = sum(0, wrice_s10);

    /*Sugar sweetened beverages*/
    SSB10d = sum(0, cola_s10, otsug_s10, punch_s10);

    /*confectionery*/
   conf10d = sum(0, cdywo_s10, cdyw_s10, dchoc_s10, mchoc_s10);
run;

data n10_nts;
    set n10_nts;

    whgrns10d = whgrn10n/28;
    rfgrns10d = rfgrn10n/28;
    afat10d = afat10n/15;
    vfat10d = vfat10n/15;
run;

data foods;
    merge food84 food86 food90 food94 food98 food02 food06 food10 n84_nts n86_nts n90_nts n94_nts n98_nts n02_nts n06_nts n10_nts;
    by id;
run;


/*PROC DATASETS;
    delete n80_tf food84 food86 food90 food94 food98 food02 food06 food10 n84_nts n86_nts n90_nts n94_nts n98_nts n02_nts n06_nts n10_nts;
RUN;*/


proc means data=foods;var tpotat84d tpotat86d tpotat90d tpotat94d tpotat98d tpotat02d tpotat06d tpotat10d 
                          bbmpot84d bbmpot86d bbmpot90d bbmpot94d bbmpot98d bbmpot02d bbmpot06d bbmpot10d 
                          fpotat84d fpotat86d fpotat90d fpotat94d fpotat98d fpotat02d fpotat06d fpotat10d 
                          chipss84d chipss86d chipss90d chipss94d chipss98d chipss02d chipss06d chipss10d 
                          trmeat84d trmeat86d trmeat90d trmeat94d trmeat98d trmeat02d trmeat06d trmeat10d
                          prmeat84d prmeat86d prmeat90d prmeat94d prmeat98d prmeat02d prmeat06d prmeat10d
                          urmeat84d urmeat86d urmeat90d urmeat94d urmeat98d urmeat02d urmeat06d urmeat10d
                          poultr84d poultr86d poultr90d poultr94d poultr98d poultr02d poultr06d poultr10d
                          fishal84d fishal86d fishal90d fishal94d fishal98d fishal02d fishal06d fishal10d
                          regegg84d regegg86d regegg90d regegg94d regegg98d regegg02d regegg06d regegg10d
                          hdairy84d hdairy86d hdairy90d hdairy94d hdairy98d hdairy02d hdairy06d hdairy10d
                          ldairy84d ldairy86d ldairy90d ldairy94d ldairy98d ldairy02d ldairy06d ldairy10d
                          soypro84d soypro86d soypro90d soypro94d soypro98d soypro02d soypro06d soypro10d
                          nutsal84d nutsal86d nutsal90d nutsal94d nutsal98d nutsal02d nutsal06d nutsal10d
                          legume84d legume86d legume90d legume94d legume98d legume02d legume06d legume10d
                          fruits84d fruits86d fruits90d fruits94d fruits98d fruits02d fruits06d fruits10d
                          vegeal84d vegeal86d vegeal90d vegeal94d vegeal98d vegeal02d vegeal06d vegeal10d
                          nstveg84d nstveg86d nstveg90d nstveg94d nstveg98d nstveg02d nstveg06d nstveg10d 
                          staveg84d staveg86d staveg90d staveg94d staveg98d staveg02d staveg06d staveg10d 
                          tdairy84d tdairy86d tdairy90d tdairy94d tdairy98d tdairy02d tdairy06d tdairy10d
                          coffee84d coffee86d coffee90d coffee94d coffee98d coffee02d coffee06d coffee10d
                          nutleg84d nutleg86d nutleg90d nutleg94d nutleg98d nutleg02d nutleg06d nutleg10d
                          bwrice84d bwrice86d bwrice90d bwrice94d bwrice98d bwrice02d bwrice06d bwrice10d
                          wtrice84d wtrice86d wtrice90d wtrice94d wtrice98d wtrice02d wtrice06d wtrice10d
                          SSB84d SSB86d SSB90d SSB94d SSB98d SSB02d SSB06d SSB10d 
                          whgrns84d whgrns86d whgrns90d whgrns94d whgrns98d whgrns02d whgrns06d whgrns10d
                          rfgrns84d rfgrns86d rfgrns90d rfgrns94d rfgrns98d rfgrns02d rfgrns06d rfgrns10d
                          trans84n trnss86n trnss90n trnss94n trn0098n trn0202n trn0706n trn1110n
                          afat84d afat86d afat90d afat94d afat98d afat02d afat06d afat10d
                          vfat84d vfat86d vfat90d vfat94d vfat98d vfat02d vfat06d vfat10d
                          conf84d conf86d conf90d conf94d conf98d conf02d conf06d conf10d;run;










