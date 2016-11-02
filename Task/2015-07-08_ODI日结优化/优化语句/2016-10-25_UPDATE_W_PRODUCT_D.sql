update RADM.W_PRODUCT_D T
   set (SRC_EFF_FROM_DT,
        SRC_EFF_TO_DT,
        PACK_FLG,
        PROD_NUM,
        SCD1_WID,
        BBG_ITEM_BRAND,
        BBG_ITEM_PLACE_OF_ORIGIN,
        BBG_ITEM_UOM_DESC,
        W_UPDATE_DT,
        ETL_PROC_WID
        
        ) =
       (select S.SRC_EFF_FROM_DT,
               S.SRC_EFF_TO_DT,
               S.PACK_FLG,
               S.PROD_NUM,
               S.SCD1_WID,
               S.BBG_ITEM_BRAND,
               S.BBG_ITEM_PLACE_OF_ORIGIN,
               S.BBG_ITEM_UOM_DESC,
               SYSDATE,
               100
        
          from (select STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                       STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                       STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                       STG.INTEGRATION_ID INTEGRATION_ID,
                       STG.PROD_CAT5 PROD_CAT5,
                       STG.PACK_FLG PACK_FLG,
                       STG.PROD_NUM PROD_NUM,
                       CASE
                         WHEN W_PRODUCT_D.INTEGRATION_ID IS NULL AND
                              W_PRODUCT_D.DATASOURCE_NUM_ID IS NULL THEN
                          RANK()
                          OVER(ORDER BY STG.INTEGRATION_ID,
                               STG.DATASOURCE_NUM_ID) +
                          (SELECT NVL(MAX(SCD1_WID), 0) FROM RADM.W_PRODUCT_D)
                         ELSE
                          W_PRODUCT_D.SCD1_WID
                       END SCD1_WID,
                       STG.PROD_CAT5_AS_WAS PROD_CAT5_AS_WAS,
                       STG.BBG_ITEM_BRAND BBG_ITEM_BRAND,
                       STG.BBG_ITEM_PLACE_OF_ORIGIN BBG_ITEM_PLACE_OF_ORIGIN,
                       STG.BBG_ITEM_UOM_DESC BBG_ITEM_UOM_DESC,
                       COALESCE(STG.SRC_EFF_FROM_DT,
                                TO_DATE('2016-10-24', 'YYYY-MM-DD')) EFFECTIVE_FROM_DT
                  from RADM.W_PRODUCT_DS STG, RADM.W_PRODUCT_D W_PRODUCT_D
                 where (1 = 1)
                   And ((STG.DATASOURCE_NUM_ID =
                       W_PRODUCT_D.DATASOURCE_NUM_ID(+)) AND
                       STG.INTEGRATION_ID = W_PRODUCT_D.INTEGRATION_ID(+))
                   And (W_PRODUCT_D.CURRENT_FLG(+) = 'Y')
                
                ) S
         where S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           and S.INTEGRATION_ID = T.INTEGRATION_ID
           AND NOT EXISTS
         (select 'X'
                  from RADM.W_PRODUCT_D T
                 where T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   and T.INTEGRATION_ID = S.INTEGRATION_ID
                   and ((T.SRC_EFF_FROM_DT = S.SRC_EFF_FROM_DT) or
                       (T.SRC_EFF_FROM_DT IS NULL and
                       S.SRC_EFF_FROM_DT IS NULL))
                   and ((T.SRC_EFF_TO_DT = S.SRC_EFF_TO_DT) or
                       (T.SRC_EFF_TO_DT IS NULL and S.SRC_EFF_TO_DT IS NULL))
                   and ((T.PACK_FLG = S.PACK_FLG) or
                       (T.PACK_FLG IS NULL and S.PACK_FLG IS NULL))
                   and ((T.PROD_NUM = S.PROD_NUM) or
                       (T.PROD_NUM IS NULL and S.PROD_NUM IS NULL))
                   and ((T.SCD1_WID = S.SCD1_WID) or
                       (T.SCD1_WID IS NULL and S.SCD1_WID IS NULL))
                   and ((T.BBG_ITEM_BRAND = S.BBG_ITEM_BRAND) or
                       (T.BBG_ITEM_BRAND IS NULL and
                       S.BBG_ITEM_BRAND IS NULL))
                   and ((T.BBG_ITEM_PLACE_OF_ORIGIN =
                       S.BBG_ITEM_PLACE_OF_ORIGIN) or
                       (T.BBG_ITEM_PLACE_OF_ORIGIN IS NULL and
                       S.BBG_ITEM_PLACE_OF_ORIGIN IS NULL))
                   and ((T.BBG_ITEM_UOM_DESC = S.BBG_ITEM_UOM_DESC) or
                       (T.BBG_ITEM_UOM_DESC IS NULL and
                       S.BBG_ITEM_UOM_DESC IS NULL))
                      
                   and CURRENT_FLG = 'Y'
                   and EFFECTIVE_TO_DT = to_date('2100-01-01', 'YYYY-MM-DD'))
        
        )
 where (T.DATASOURCE_NUM_ID, T.INTEGRATION_ID) in
       (select S.DATASOURCE_NUM_ID, S.INTEGRATION_ID
          from (select STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                       STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                       STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                       STG.INTEGRATION_ID INTEGRATION_ID,
                       STG.PROD_CAT5 PROD_CAT5,
                       STG.PACK_FLG PACK_FLG,
                       STG.PROD_NUM PROD_NUM,
                       CASE
                         WHEN W_PRODUCT_D.INTEGRATION_ID IS NULL AND
                              W_PRODUCT_D.DATASOURCE_NUM_ID IS NULL THEN
                          RANK()
                          OVER(ORDER BY STG.INTEGRATION_ID,
                               STG.DATASOURCE_NUM_ID) +
                          (SELECT NVL(MAX(SCD1_WID), 0) FROM RADM.W_PRODUCT_D)
                         ELSE
                          W_PRODUCT_D.SCD1_WID
                       END SCD1_WID,
                       STG.PROD_CAT5_AS_WAS PROD_CAT5_AS_WAS,
                       STG.BBG_ITEM_BRAND BBG_ITEM_BRAND,
                       STG.BBG_ITEM_PLACE_OF_ORIGIN BBG_ITEM_PLACE_OF_ORIGIN,
                       STG.BBG_ITEM_UOM_DESC BBG_ITEM_UOM_DESC,
                       COALESCE(STG.SRC_EFF_FROM_DT,
                                TO_DATE('2016-10-24', 'YYYY-MM-DD')) EFFECTIVE_FROM_DT
                  from RADM.W_PRODUCT_DS STG, RADM.W_PRODUCT_D W_PRODUCT_D
                 where (1 = 1)
                   And ((STG.DATASOURCE_NUM_ID =
                       W_PRODUCT_D.DATASOURCE_NUM_ID(+)) AND
                       STG.INTEGRATION_ID = W_PRODUCT_D.INTEGRATION_ID(+))
                   And (W_PRODUCT_D.CURRENT_FLG(+) = 'Y')
                
                ) S
         where S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           and S.INTEGRATION_ID = T.INTEGRATION_ID
           AND NOT EXISTS
         (select 'X'
                  from RADM.W_PRODUCT_D T
                 where T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   and T.INTEGRATION_ID = S.INTEGRATION_ID
                   and ((T.SRC_EFF_FROM_DT = S.SRC_EFF_FROM_DT) or
                       (T.SRC_EFF_FROM_DT IS NULL and
                       S.SRC_EFF_FROM_DT IS NULL))
                   and ((T.SRC_EFF_TO_DT = S.SRC_EFF_TO_DT) or
                       (T.SRC_EFF_TO_DT IS NULL and S.SRC_EFF_TO_DT IS NULL))
                   and ((T.PACK_FLG = S.PACK_FLG) or
                       (T.PACK_FLG IS NULL and S.PACK_FLG IS NULL))
                   and ((T.PROD_NUM = S.PROD_NUM) or
                       (T.PROD_NUM IS NULL and S.PROD_NUM IS NULL))
                   and ((T.SCD1_WID = S.SCD1_WID) or
                       (T.SCD1_WID IS NULL and S.SCD1_WID IS NULL))
                   and ((T.BBG_ITEM_BRAND = S.BBG_ITEM_BRAND) or
                       (T.BBG_ITEM_BRAND IS NULL and
                       S.BBG_ITEM_BRAND IS NULL))
                   and ((T.BBG_ITEM_PLACE_OF_ORIGIN =
                       S.BBG_ITEM_PLACE_OF_ORIGIN) or
                       (T.BBG_ITEM_PLACE_OF_ORIGIN IS NULL and
                       S.BBG_ITEM_PLACE_OF_ORIGIN IS NULL))
                   and ((T.BBG_ITEM_UOM_DESC = S.BBG_ITEM_UOM_DESC) or
                       (T.BBG_ITEM_UOM_DESC IS NULL and
                       S.BBG_ITEM_UOM_DESC IS NULL))
                      
                   and CURRENT_FLG = 'Y'
                   and EFFECTIVE_TO_DT = to_date('2100-01-01', 'YYYY-MM-DD'))
        
        )
   and T.CURRENT_FLG = 'Y'
   and EFFECTIVE_TO_DT = to_date('2100-01-01', 'YYYY-MM-DD')
