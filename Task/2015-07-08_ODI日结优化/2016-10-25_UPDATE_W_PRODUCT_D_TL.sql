update RADM.W_PRODUCT_D_TL T
   set (PRODUCT_NAME,
        PRODUCT_DESCR,
        SRC_LANGUAGE_CODE,
        W_UPDATE_DT,
        ETL_PROC_WID) =
       (select S.PRODUCT_NAME,
               S.PRODUCT_DESCR,
               S.SRC_LANGUAGE_CODE,
               SYSDATE,
               100
        
          from (select STG.PRODUCT_NAME      PRODUCT_NAME,
                       STG.PRODUCT_DESCR     PRODUCT_DESCR,
                       STG.LANGUAGE_CODE     LANGUAGE_CODE,
                       STG.SRC_LANGUAGE_CODE SRC_LANGUAGE_CODE,
                       STG.INTEGRATION_ID    INTEGRATION_ID,
                       STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID
                  from RADM.W_PRODUCT_DS_TL_V STG
                 where (1 = 1)
                
                ) S
         where S.LANGUAGE_CODE = T.LANGUAGE_CODE
           and S.INTEGRATION_ID = T.INTEGRATION_ID
           and S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           AND NOT EXISTS
         (select 'X'
                  from RADM.W_PRODUCT_D_TL T
                 where T.LANGUAGE_CODE = S.LANGUAGE_CODE
                   and T.INTEGRATION_ID = S.INTEGRATION_ID
                   and T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   and ((T.PRODUCT_NAME = S.PRODUCT_NAME) or
                       (T.PRODUCT_NAME IS NULL and S.PRODUCT_NAME IS NULL))
                   and ((T.PRODUCT_DESCR = S.PRODUCT_DESCR) or
                       (T.PRODUCT_DESCR IS NULL and S.PRODUCT_DESCR IS NULL))
                   and ((T.SRC_LANGUAGE_CODE = S.SRC_LANGUAGE_CODE) or
                       (T.SRC_LANGUAGE_CODE IS NULL and
                       S.SRC_LANGUAGE_CODE IS NULL))
                
                )
        
        )
 where (T.LANGUAGE_CODE, T.INTEGRATION_ID, T.DATASOURCE_NUM_ID) in
       (select S.LANGUAGE_CODE, S.INTEGRATION_ID, S.DATASOURCE_NUM_ID
          from (select STG.PRODUCT_NAME      PRODUCT_NAME,
                       STG.PRODUCT_DESCR     PRODUCT_DESCR,
                       STG.LANGUAGE_CODE     LANGUAGE_CODE,
                       STG.SRC_LANGUAGE_CODE SRC_LANGUAGE_CODE,
                       STG.INTEGRATION_ID    INTEGRATION_ID,
                       STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID
                  from RADM.W_PRODUCT_DS_TL_V STG
                 where (1 = 1)
                
                ) S
         where S.LANGUAGE_CODE = T.LANGUAGE_CODE
           and S.INTEGRATION_ID = T.INTEGRATION_ID
           and S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           AND NOT EXISTS
         (select 'X'
                  from RADM.W_PRODUCT_D_TL T
                 where T.LANGUAGE_CODE = S.LANGUAGE_CODE
                   and T.INTEGRATION_ID = S.INTEGRATION_ID
                   and T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   and ((T.PRODUCT_NAME = S.PRODUCT_NAME) or
                       (T.PRODUCT_NAME IS NULL and S.PRODUCT_NAME IS NULL))
                   and ((T.PRODUCT_DESCR = S.PRODUCT_DESCR) or
                       (T.PRODUCT_DESCR IS NULL and S.PRODUCT_DESCR IS NULL))
                   and ((T.SRC_LANGUAGE_CODE = S.SRC_LANGUAGE_CODE) or
                       (T.SRC_LANGUAGE_CODE IS NULL and
                       S.SRC_LANGUAGE_CODE IS NULL)))
        
        )
