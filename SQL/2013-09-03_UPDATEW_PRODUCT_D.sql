/* Formatted on 2013/9/4 9:19:49 (QP5 v5.115.810.9015) */
UPDATE   RADM.W_PRODUCT_D T
   SET
         (SRC_EFF_FROM_DT,
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
            (SELECT   S.SRC_EFF_FROM_DT,
                      S.SRC_EFF_TO_DT,
                      S.PACK_FLG,
                      S.PROD_NUM,
                      S.SCD1_WID,
                      S.BBG_ITEM_BRAND,
                      S.BBG_ITEM_PLACE_OF_ORIGIN,
                      S.BBG_ITEM_UOM_DESC,
                      SYSDATE,
                      100
               FROM   (SELECT  /*USE_NL(STG,W_PRODUCT_D)*/
                                STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                                STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                                STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                                STG.INTEGRATION_ID INTEGRATION_ID,
                                STG.PROD_CAT5 PROD_CAT5,
                                STG.PACK_FLG PACK_FLG,
                                STG.PROD_NUM PROD_NUM,
                                CASE
                                   WHEN W_PRODUCT_D.INTEGRATION_ID IS NULL
                                        AND W_PRODUCT_D.DATASOURCE_NUM_ID IS NULL
                                   THEN
                                      RANK ()
                                         OVER (
                                            ORDER BY
                                               STG.INTEGRATION_ID,
                                               STG.DATASOURCE_NUM_ID
                                         )
                                      + 742282
                                   ELSE
                                      W_PRODUCT_D.SCD1_WID
                                END
                                   SCD1_WID,
                                STG.PROD_CAT5_AS_WAS PROD_CAT5_AS_WAS,
                                STG.BBG_ITEM_BRAND BBG_ITEM_BRAND,
                                STG.BBG_ITEM_PLACE_OF_ORIGIN
                                   BBG_ITEM_PLACE_OF_ORIGIN,
                                STG.BBG_ITEM_UOM_DESC BBG_ITEM_UOM_DESC,
                                COALESCE (
                                   STG.SRC_EFF_FROM_DT,
                                   TO_DATE ('2013-09-03', 'YYYY-MM-DD')
                                )
                                   EFFECTIVE_FROM_DT
                         FROM   RADM.W_PRODUCT_DS STG,
                                RADM.W_PRODUCT_D W_PRODUCT_D
                        WHERE   (1 = 1)
                                AND ( (STG.DATASOURCE_NUM_ID =
                                          W_PRODUCT_D.DATASOURCE_NUM_ID(+))
                                     AND STG.INTEGRATION_ID =
                                           W_PRODUCT_D.INTEGRATION_ID(+))
                                AND (W_PRODUCT_D.CURRENT_FLG(+) = 'Y')) S
              WHERE   S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
                      AND S.INTEGRATION_ID = T.INTEGRATION_ID
                      AND NOT EXISTS
                            (SELECT   'X'
                               FROM   RADM.W_PRODUCT_D T
                              WHERE   T.DATASOURCE_NUM_ID =
                                         S.DATASOURCE_NUM_ID
                                      AND T.INTEGRATION_ID = S.INTEGRATION_ID
                                      AND ( (T.SRC_EFF_FROM_DT =
                                                S.SRC_EFF_FROM_DT)
                                           OR (T.SRC_EFF_FROM_DT IS NULL
                                               AND S.SRC_EFF_FROM_DT IS NULL))
                                      AND ( (T.SRC_EFF_TO_DT =
                                                S.SRC_EFF_TO_DT)
                                           OR (T.SRC_EFF_TO_DT IS NULL
                                               AND S.SRC_EFF_TO_DT IS NULL))
                                      AND ( (T.PACK_FLG = S.PACK_FLG)
                                           OR (T.PACK_FLG IS NULL
                                               AND S.PACK_FLG IS NULL))
                                      AND ( (T.PROD_NUM = S.PROD_NUM)
                                           OR (T.PROD_NUM IS NULL
                                               AND S.PROD_NUM IS NULL))
                                      AND ( (T.SCD1_WID = S.SCD1_WID)
                                           OR (T.SCD1_WID IS NULL
                                               AND S.SCD1_WID IS NULL))
                                      AND ( (T.BBG_ITEM_BRAND =
                                                S.BBG_ITEM_BRAND)
                                           OR (T.BBG_ITEM_BRAND IS NULL
                                               AND S.BBG_ITEM_BRAND IS NULL))
                                      AND ( (T.BBG_ITEM_PLACE_OF_ORIGIN =
                                                S.BBG_ITEM_PLACE_OF_ORIGIN)
                                           OR (T.BBG_ITEM_PLACE_OF_ORIGIN IS NULL
                                               AND S.BBG_ITEM_PLACE_OF_ORIGIN IS NULL))
                                      AND ( (T.BBG_ITEM_UOM_DESC =
                                                S.BBG_ITEM_UOM_DESC)
                                           OR (T.BBG_ITEM_UOM_DESC IS NULL
                                               AND S.BBG_ITEM_UOM_DESC IS NULL))
                                      AND CURRENT_FLG = 'Y'
                                      AND EFFECTIVE_TO_DT =
                                            TO_DATE ('2100-01-01',
                                                     'YYYY-MM-DD')))
 WHERE   (T.DATASOURCE_NUM_ID, T.INTEGRATION_ID) IN
               (SELECT   S.DATASOURCE_NUM_ID, S.INTEGRATION_ID
                  FROM   (SELECT   STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                                   STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                                   STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                                   STG.INTEGRATION_ID INTEGRATION_ID,
                                   STG.PROD_CAT5 PROD_CAT5,
                                   STG.PACK_FLG PACK_FLG,
                                   STG.PROD_NUM PROD_NUM,
                                   CASE
                                      WHEN W_PRODUCT_D.INTEGRATION_ID IS NULL
                                           AND W_PRODUCT_D.DATASOURCE_NUM_ID IS NULL
                                      THEN
                                         RANK ()
                                            OVER (
                                               ORDER BY
                                                  STG.INTEGRATION_ID,
                                                  STG.DATASOURCE_NUM_ID
                                            )
                                         + 742282
                                      ELSE
                                         W_PRODUCT_D.SCD1_WID
                                   END
                                      SCD1_WID,
                                   STG.PROD_CAT5_AS_WAS PROD_CAT5_AS_WAS,
                                   STG.BBG_ITEM_BRAND BBG_ITEM_BRAND,
                                   STG.BBG_ITEM_PLACE_OF_ORIGIN
                                      BBG_ITEM_PLACE_OF_ORIGIN,
                                   STG.BBG_ITEM_UOM_DESC BBG_ITEM_UOM_DESC,
                                   COALESCE (
                                      STG.SRC_EFF_FROM_DT,
                                      TO_DATE ('2013-09-03', 'YYYY-MM-DD')
                                   )
                                      EFFECTIVE_FROM_DT
                            FROM   RADM.W_PRODUCT_DS STG,
                                   RADM.W_PRODUCT_D W_PRODUCT_D
                           WHERE   (1 = 1)
                                   AND ( (STG.DATASOURCE_NUM_ID =
                                             W_PRODUCT_D.DATASOURCE_NUM_ID(+))
                                        AND STG.INTEGRATION_ID =
                                              W_PRODUCT_D.INTEGRATION_ID(+))
                                   AND (W_PRODUCT_D.CURRENT_FLG(+) = 'Y')) S
                 WHERE   S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
                         AND S.INTEGRATION_ID = T.INTEGRATION_ID
                         AND NOT EXISTS
                               (SELECT   'X'
                                  FROM   RADM.W_PRODUCT_D T
                                 WHERE   T.DATASOURCE_NUM_ID =
                                            S.DATASOURCE_NUM_ID
                                         AND T.INTEGRATION_ID =
                                               S.INTEGRATION_ID
                                         AND ( (T.SRC_EFF_FROM_DT =
                                                   S.SRC_EFF_FROM_DT)
                                              OR (T.SRC_EFF_FROM_DT IS NULL
                                                  AND S.SRC_EFF_FROM_DT IS NULL))
                                         AND ( (T.SRC_EFF_TO_DT =
                                                   S.SRC_EFF_TO_DT)
                                              OR (T.SRC_EFF_TO_DT IS NULL
                                                  AND S.SRC_EFF_TO_DT IS NULL))
                                         AND ( (T.PACK_FLG = S.PACK_FLG)
                                              OR (T.PACK_FLG IS NULL
                                                  AND S.PACK_FLG IS NULL))
                                         AND ( (T.PROD_NUM = S.PROD_NUM)
                                              OR (T.PROD_NUM IS NULL
                                                  AND S.PROD_NUM IS NULL))
                                         AND ( (T.SCD1_WID = S.SCD1_WID)
                                              OR (T.SCD1_WID IS NULL
                                                  AND S.SCD1_WID IS NULL))
                                         AND ( (T.BBG_ITEM_BRAND =
                                                   S.BBG_ITEM_BRAND)
                                              OR (T.BBG_ITEM_BRAND IS NULL
                                                  AND S.BBG_ITEM_BRAND IS NULL))
                                         AND ( (T.BBG_ITEM_PLACE_OF_ORIGIN =
                                                   S.BBG_ITEM_PLACE_OF_ORIGIN)
                                              OR (T.BBG_ITEM_PLACE_OF_ORIGIN IS NULL
                                                  AND S.BBG_ITEM_PLACE_OF_ORIGIN IS NULL))
                                         AND ( (T.BBG_ITEM_UOM_DESC =
                                                   S.BBG_ITEM_UOM_DESC)
                                              OR (T.BBG_ITEM_UOM_DESC IS NULL
                                                  AND S.BBG_ITEM_UOM_DESC IS NULL))
                                         AND CURRENT_FLG = 'Y'
                                         AND EFFECTIVE_TO_DT =
                                               TO_DATE ('2100-01-01',
                                                        'YYYY-MM-DD')))
         AND T.CURRENT_FLG = 'Y'
         AND EFFECTIVE_TO_DT = TO_DATE ('2100-01-01', 'YYYY-MM-DD')
