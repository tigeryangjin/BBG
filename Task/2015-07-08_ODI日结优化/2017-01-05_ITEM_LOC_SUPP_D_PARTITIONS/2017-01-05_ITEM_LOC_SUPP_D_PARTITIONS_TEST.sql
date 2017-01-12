--1.
CREATE TABLE RADM.BBG_RA_ITEM_LOC_SUPP_DS_BAK AS
SELECT * FROM RADM.BBG_RA_ITEM_LOC_SUPP_DS;
--2.
UPDATE RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR T
   SET (DESC_CHINESE,
        DESC_ENGLISH,
        REF_NO1,
        REF_NO2,
        REF_NO3,
        REF_NO4,
        SRC_EFF_FROM_DT,
        SRC_EFF_TO_DT,
        ETL_PROC_WID,
        W_UPDATE_DT
        
        ) =
       (SELECT S.DESC_CHINESE,
               S.DESC_ENGLISH,
               S.REF_NO1,
               S.REF_NO2,
               S.REF_NO3,
               S.REF_NO4,
               S.SRC_EFF_FROM_DT,
               S.SRC_EFF_TO_DT,
               S.ETL_PROC_WID,
               SYSDATE
        
          FROM (SELECT /*+PARALLEL(16)*/
                 STG.ITEM ITEM,
                 STG.SUPPLIER SUPPLIER,
                 STG.ORIGIN_COUNTRY_ID ORIGIN_COUNTRY_ID,
                 STG.LOC LOC,
                 STG.LOGISTICS_DELIVERY_MODEL LOGISTICS_DELIVERY_MODEL,
                 STG.DESC_CHINESE DESC_CHINESE,
                 STG.DESC_ENGLISH DESC_ENGLISH,
                 STG.REF_NO1 REF_NO1,
                 STG.REF_NO2 REF_NO2,
                 STG.REF_NO3 REF_NO3,
                 STG.REF_NO4 REF_NO4,
                 STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                 STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                 STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                 100 ETL_PROC_WID,
                 STG.INTEGRATION_ID INTEGRATION_ID,
                 COALESCE(STG.SRC_EFF_FROM_DT,
                          TO_DATE('2017-01-03', 'YYYY-MM-DD')) EFFECTIVE_FROM_DT
                  FROM RADM.BBG_RA_ITEM_LOC_SUPP_DS_BAK STG
                 WHERE (1 = 1)
                
                ) S
         WHERE S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           AND S.INTEGRATION_ID = T.INTEGRATION_ID
           AND NOT EXISTS
         (SELECT 'X'
                  FROM RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR T
                 WHERE T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   AND T.INTEGRATION_ID = S.INTEGRATION_ID
                   AND ((T.DESC_CHINESE = S.DESC_CHINESE) OR
                       (T.DESC_CHINESE IS NULL AND S.DESC_CHINESE IS NULL))
                   AND ((T.DESC_ENGLISH = S.DESC_ENGLISH) OR
                       (T.DESC_ENGLISH IS NULL AND S.DESC_ENGLISH IS NULL))
                   AND ((T.REF_NO1 = S.REF_NO1) OR
                       (T.REF_NO1 IS NULL AND S.REF_NO1 IS NULL))
                   AND ((T.REF_NO2 = S.REF_NO2) OR
                       (T.REF_NO2 IS NULL AND S.REF_NO2 IS NULL))
                   AND ((T.REF_NO3 = S.REF_NO3) OR
                       (T.REF_NO3 IS NULL AND S.REF_NO3 IS NULL))
                   AND ((T.REF_NO4 = S.REF_NO4) OR
                       (T.REF_NO4 IS NULL AND S.REF_NO4 IS NULL))
                   AND ((T.SRC_EFF_FROM_DT = S.SRC_EFF_FROM_DT) OR
                       (T.SRC_EFF_FROM_DT IS NULL AND
                       S.SRC_EFF_FROM_DT IS NULL))
                   AND ((T.SRC_EFF_TO_DT = S.SRC_EFF_TO_DT) OR
                       (T.SRC_EFF_TO_DT IS NULL AND S.SRC_EFF_TO_DT IS NULL))
                      
                   AND CURRENT_FLG = 'Y'
                   AND EFFECTIVE_TO_DT = TO_DATE('2100-01-01', 'YYYY-MM-DD'))
        
        )
 WHERE (T.DATASOURCE_NUM_ID, T.INTEGRATION_ID) IN
       (SELECT S.DATASOURCE_NUM_ID, S.INTEGRATION_ID
          FROM (SELECT /*+PARALLEL(16)*/
                 STG.ITEM ITEM,
                 STG.SUPPLIER SUPPLIER,
                 STG.ORIGIN_COUNTRY_ID ORIGIN_COUNTRY_ID,
                 STG.LOC LOC,
                 STG.LOGISTICS_DELIVERY_MODEL LOGISTICS_DELIVERY_MODEL,
                 STG.DESC_CHINESE DESC_CHINESE,
                 STG.DESC_ENGLISH DESC_ENGLISH,
                 STG.REF_NO1 REF_NO1,
                 STG.REF_NO2 REF_NO2,
                 STG.REF_NO3 REF_NO3,
                 STG.REF_NO4 REF_NO4,
                 STG.SRC_EFF_FROM_DT SRC_EFF_FROM_DT,
                 STG.SRC_EFF_TO_DT SRC_EFF_TO_DT,
                 STG.DATASOURCE_NUM_ID DATASOURCE_NUM_ID,
                 100 ETL_PROC_WID,
                 STG.INTEGRATION_ID INTEGRATION_ID,
                 COALESCE(STG.SRC_EFF_FROM_DT,
                          TO_DATE('2017-01-03', 'YYYY-MM-DD')) EFFECTIVE_FROM_DT
                  FROM RADM.BBG_RA_ITEM_LOC_SUPP_DS_BAK STG
                 WHERE (1 = 1)
                
                ) S
         WHERE S.DATASOURCE_NUM_ID = T.DATASOURCE_NUM_ID
           AND S.INTEGRATION_ID = T.INTEGRATION_ID
           AND NOT EXISTS
         (SELECT 'X'
                  FROM RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR T
                 WHERE T.DATASOURCE_NUM_ID = S.DATASOURCE_NUM_ID
                   AND T.INTEGRATION_ID = S.INTEGRATION_ID
                   AND ((T.DESC_CHINESE = S.DESC_CHINESE) OR
                       (T.DESC_CHINESE IS NULL AND S.DESC_CHINESE IS NULL))
                   AND ((T.DESC_ENGLISH = S.DESC_ENGLISH) OR
                       (T.DESC_ENGLISH IS NULL AND S.DESC_ENGLISH IS NULL))
                   AND ((T.REF_NO1 = S.REF_NO1) OR
                       (T.REF_NO1 IS NULL AND S.REF_NO1 IS NULL))
                   AND ((T.REF_NO2 = S.REF_NO2) OR
                       (T.REF_NO2 IS NULL AND S.REF_NO2 IS NULL))
                   AND ((T.REF_NO3 = S.REF_NO3) OR
                       (T.REF_NO3 IS NULL AND S.REF_NO3 IS NULL))
                   AND ((T.REF_NO4 = S.REF_NO4) OR
                       (T.REF_NO4 IS NULL AND S.REF_NO4 IS NULL))
                   AND ((T.SRC_EFF_FROM_DT = S.SRC_EFF_FROM_DT) OR
                       (T.SRC_EFF_FROM_DT IS NULL AND
                       S.SRC_EFF_FROM_DT IS NULL))
                   AND ((T.SRC_EFF_TO_DT = S.SRC_EFF_TO_DT) OR
                       (T.SRC_EFF_TO_DT IS NULL AND S.SRC_EFF_TO_DT IS NULL))
                      
                   AND CURRENT_FLG = 'Y'
                   AND EFFECTIVE_TO_DT = TO_DATE('2100-01-01', 'YYYY-MM-DD'))
        
        )
   AND T.CURRENT_FLG = 'Y'
   AND EFFECTIVE_TO_DT = TO_DATE('2100-01-01', 'YYYY-MM-DD');

--3.

--4.

--5.

--6.



SELECT /*+PARALLEL(32)*/
 T.EFFECTIVE_TO_DT, COUNT(1)
  FROM RADM.BBG_RA_ITEM_LOC_SUPP_D T
 GROUP BY T.EFFECTIVE_TO_DT
 ORDER BY T.EFFECTIVE_TO_DT;
