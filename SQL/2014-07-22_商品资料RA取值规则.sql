select ITEM_MASTER.ITEM,
       ITEM_MASTER.ITEM_DESC,
       ITEM_MASTER.PACK_IND,
       ITEM_MASTER.SHORT_DESC,
       CASE
         WHEN case
                when '' IS NULL THEN
                 (SELECT 'X'
                    FROM ALL_TAB_COLUMNS
                   WHERE TABLE_NAME = 'ITEM_MASTER'
                     AND COLUMN_NAME = 'ITEM_DESC_SECONDARY'
                     AND OWNER = UPPER('RA_RMS'))
                else
                 (SELECT 'X'
                    FROM ALL_TAB_COLUMNS
                   WHERE TABLE_NAME = 'ITEM_MASTER'
                     AND COLUMN_NAME = 'ITEM_DESC_SECONDARY'
                     AND OWNER = UPPER(''))
              end = 'X' THEN
          ITEM_MASTER.ITEM_DESC_SECONDARY
         ELSE
          NULL
       END,
       ITEM_MASTER.STANDARD_UOM,
       DIVISION.DIVISION || '~' || GROUPS.GROUP_NO || '~' ||
       ITEM_MASTER.DEPT || '~' || ITEM_MASTER.CLASS || '~' ||
       ITEM_MASTER.SUBCLASS,
       ITEM_MASTER.INVENTORY_IND,
       ITEM_MASTER.MERCHANDISE_IND,
       ITEM_MASTER.SELLABLE_IND,
       CASE
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND ITEM_MASTER.SELLABLE_IND = 'Y' THEN
          'S'
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND ITEM_MASTER.SELLABLE_IND = 'N' THEN
          'N'
         ELSE
          '-1'
       END,
       CASE
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND
              ITEM_MASTER.SIMPLE_PACK_IND = 'Y' THEN
          'S'
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND
              ITEM_MASTER.SIMPLE_PACK_IND = 'N' THEN
          'C'
         ELSE
          '-1'
       END,
       CASE
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND ITEM_MASTER.ORDERABLE_IND = 'Y' AND
              ITEM_MASTER.PACK_TYPE = 'V' THEN
          'V'
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND ITEM_MASTER.ORDERABLE_IND = 'Y' AND
              ITEM_MASTER.PACK_TYPE != 'V' THEN
          'B'
         WHEN ITEM_MASTER.PACK_IND = 'Y' AND ITEM_MASTER.ORDERABLE_IND = 'N' THEN
          'N'
         ELSE
          '-1'
       END,
       ITEM_MASTER.PACKAGE_SIZE,
       ITEM_MASTER.PACKAGE_UOM,
       ITEM_MASTER.ITEM_NUMBER_TYPE,
       ITEM_MASTER.ITEM_LEVEL,
       ITEM_MASTER.TRAN_LEVEL,
       CASE
         WHEN ITEM_MASTER.ITEM_LEVEL = 3 AND
              ITEM_MASTER.ITEM_GRANDPARENT IS NOT NULL THEN
          ITEM_MASTER.ITEM_GRANDPARENT
         WHEN ITEM_MASTER.ITEM_LEVEL = 2 AND
              ITEM_MASTER.ITEM_PARENT IS NOT NULL THEN
          ITEM_MASTER.ITEM_PARENT
         WHEN ITEM_MASTER.ITEM_LEVEL = 1 THEN
          ITEM_MASTER.ITEM
         ELSE
          '-1'
       END,
       CASE
         WHEN ITEM_MASTER.ITEM_LEVEL = 3 AND
              ITEM_MASTER.ITEM_PARENT IS NOT NULL THEN
          ITEM_MASTER.ITEM_PARENT
         WHEN ITEM_MASTER.ITEM_LEVEL = 2 THEN
          ITEM_MASTER.ITEM
         ELSE
          '-1'
       END,
       CASE
         WHEN ITEM_MASTER.ITEM_LEVEL = 3 THEN
          ITEM_MASTER.ITEM
         ELSE
          '-1'
       END,
       ITEM_MASTER.DIFF_1,
       ITEM_MASTER.DIFF_2,
       ITEM_MASTER.DIFF_3,
       ITEM_MASTER.DIFF_4,
       ITEM_MASTER.ITEM,
       ITEM_MASTER.RETAIL_ZONE_GROUP_ID,
       LANG.LANG,
       ITEM_MASTER.ORIGINAL_RETAIL,
       CASE
         WHEN COALESCE(LANG.ISO_CODE, /*'#RA_BI.RA_SRC_PRIMARY_LANGUAGE_CODE'*/
                       'EN') = 'ZHT' THEN
          'ZHT'
         WHEN COALESCE(LANG.ISO_CODE, /*'#RA_BI.RA_SRC_PRIMARY_LANGUAGE_CODE'*/
                       'EN') = 'FRC' THEN
          'FRC'
         WHEN COALESCE(LANG.ISO_CODE, /*'#RA_BI.RA_SRC_PRIMARY_LANGUAGE_CODE'*/
                       'EN') = 'ESA' THEN
          'ESA'
         ELSE
          DECODE(COALESCE(LANG.ISO_CODE,
                          /*'#RA_BI.RA_SRC_PRIMARY_LANGUAGE_CODE'*/
                          'EN'),
                 'PTB',
                 'PTB',
                 UTL_I18N.MAP_TO_SHORT_LANGUAGE(UTL_I18N.MAP_LANGUAGE_FROM_ISO(COALESCE(LANG.ISO_CODE,
                                                                                        /*'#RA_BI.RA_SRC_PRIMARY_LANGUAGE_CODE'*/
                                                                                        'EN'))))
       END,
       ITEM_MASTER.MFG_REC_RETAIL,
       BBG_RA_ITEM_CUSTOM_V.BBG_ITEM_BRAND,
       BBG_RA_ITEM_CUSTOM_V.BBG_ITEM_PLACE_OF_ORIGIN,
       UOM_CLASS.UOM_DESC,
       1 /*#RA_BI.DATASOURCE_NUM_ID*/
  from RMS.LANG                 LANG,
       RMS.ITEM_MASTER          ITEM_MASTER,
       RMS.CODE_DETAIL          CODE_DETAIL,
       RMS.UOM_CLASS            UOM_CLASS,
       RMS.DIVISION             DIVISION,
       RMS.GROUPS               GROUPS,
       RMS.DEPS                 DEPS,
       RMS.BBG_RA_ITEM_CUSTOM_V BBG_RA_ITEM_CUSTOM_V
 where (1 = 1)
   And (ITEM_MASTER.ITEM = BBG_RA_ITEM_CUSTOM_V.ITEM)
   AND (ITEM_MASTER.STANDARD_UOM = UOM_CLASS.UOM)
   AND (ITEM_MASTER.ITEM_NUMBER_TYPE = CODE_DETAIL.CODE)
   AND (GROUPS.DIVISION = DIVISION.DIVISION)
   AND (DEPS.GROUP_NO = GROUPS.GROUP_NO)
   AND (ITEM_MASTER.DEPT = DEPS.DEPT)
   And (ITEM_MASTER.STATUS = 'A')
   And (CODE_DETAIL.CODE_TYPE = 'UPCT')
   And (ITEM_MASTER.PACK_IND = 'N' OR
       (ITEM_MASTER.PACK_IND = 'Y' AND NOT EXISTS
        (SELECT 'X'
            FROM RA_RMS.V_PACKSKU_QTY V_PACKSKU1, RA_RMS.ITEM_MASTER IM1
           WHERE V_PACKSKU1.PACK_NO = ITEM_MASTER.ITEM
             AND V_PACKSKU1.ITEM = IM1.ITEM
             AND IM1.ITEM_XFORM_IND = 'Y'
             AND ROWNUM = 1)))
   And (ITEM_MASTER.ITEM_XFORM_IND != 'Y')
      /*And (TRUNC(ITEM_MASTER.LAST_UPDATE_DATETIME) >=
      TO_DATE(\*'#RA_BI.RA_SRC_BUSINESS_CURRENT_DT'*\'2014-07-21', 'YYYY-MM-DD'))*/
   And (CASE
         WHEN LANG.ISO_CODE = 'ZHT' THEN
          'ZHT'
         WHEN LANG.ISO_CODE = 'FRC' THEN
          'FRC'
         WHEN LANG.ISO_CODE = 'ESA' THEN
          'ESA'
         ELSE
          DECODE(LANG.ISO_CODE,
                 'PTB',
                 'PTB',
                 UTL_I18N.MAP_TO_SHORT_LANGUAGE(UTL_I18N.MAP_LANGUAGE_FROM_ISO(LANG.ISO_CODE)))
       END IN ( /*#RA_BI.RA_SRC_LANGUAGE_LIST*/ 'ZHS', 'US'))
   AND ITEM_MASTER.ITEM = '101019173';
