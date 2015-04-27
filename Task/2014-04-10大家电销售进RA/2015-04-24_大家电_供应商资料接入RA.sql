--查找金力系统已经存在的供应商,并不在RA中的
SELECT *
  FROM WLDW@RA_JL J
 WHERE NOT EXISTS
 (SELECT 1 FROM RADM.W_PARTY_ORG_D R WHERE J.WLDW03 = R.SUPPLIER_NUM)
   AND J.WLDW02 NOT LIKE '%步步高%'
   AND J.WLDW02 NOT LIKE '%家电事业部%'
   AND J.WLDW03 IS NOT NULL;

--RA目标表
SELECT * FROM RADM.W_PARTY_ORG_D;

INSERT INTO RADM.W_PARTY_ORG_D
  (ROW_WID,
   SCD1_WID,
   ORG_NAME,
   SUPPLIER_FLG,
   BASE_CURCY_CD,
   SUPPLIER_NUM,
   CURRENT_FLG,
   DATASOURCE_NUM_ID,
   EFFECTIVE_FROM_DT,
   EFFECTIVE_TO_DT,
   ETL_PROC_WID,
   INTEGRATION_ID,
   W_INSERT_DT,
   W_UPDATE_DT)
  SELECT RADM.W_PARTY_ORG_D_SEQ.NEXTVAL,
         RANK() OVER(ORDER BY T.WLDW03) + (SELECT NVL(MAX(SCD1_WID), 0)
                                             FROM RADM.W_PARTY_ORG_D) SCD1_WID,
         T.WLDW02,
         'Y' SUPPLIER_FLG,
         'CNY' BASE_CURCY_CD,
         T.WLDW03,
         'Y' CURRENT_FLG,
         1 DATASOURCE_NUM_ID,
         DATE '2013-01-01' EFFECTIVE_FROM_DT,
         DATE '2100-01-01' EFFECTIVE_TO_DT,
         100 ETL_PROC_WID,
         T.WLDW03 INTEGRATION_ID,
         SYSDATE W_INSERT_DT,
         SYSDATE W_UPDATE_DT
    FROM WLDW@RA_JL T
   WHERE NOT EXISTS
   (SELECT 1 FROM RADM.W_PARTY_ORG_D R WHERE T.WLDW03 = R.SUPPLIER_NUM)
     AND T.WLDW02 NOT LIKE '%步步高%'
     AND T.WLDW02 NOT LIKE '%家电事业部%'
     AND T.WLDW03 IS NOT NULL;

SELECT ROW_WID,
       SCD1_WID,
       ORG_NAME,
       SUPPLIER_FLG,
       BASE_CURCY_CD,
       SUPPLIER_NUM,
       CURRENT_FLG,
       DATASOURCE_NUM_ID,
       EFFECTIVE_FROM_DT,
       EFFECTIVE_TO_DT,
       ETL_PROC_WID,
       INTEGRATION_ID,
       W_INSERT_DT,
       W_UPDATE_DT
  FROM RADM.W_PARTY_ORG_D;

SELECT *
  FROM WLDW@RA_JL J
 WHERE NOT EXISTS
 (SELECT 1 FROM RADM.W_PARTY_ORG_D R WHERE J.WLDW03 = R.SUPPLIER_NUM)
   AND J.WLDW02 NOT LIKE '%步步高%'
   AND J.WLDW02 NOT LIKE '%家电事业部%'
   AND J.WLDW03 IS NOT NULL;

SELECT * FROM RMS.SUPS T WHERE T.SUPPLIER = '780001';

SELECT * FROM WLDW@RA_JL;
