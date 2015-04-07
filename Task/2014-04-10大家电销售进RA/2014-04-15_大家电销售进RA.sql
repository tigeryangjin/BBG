--********************************************************************************************
--接口定义
--********************************************************************************************
--商品资料接口
SELECT * FROM BBG_RA_PRODUCT_JL_V@RMS_JL;
--商品地点接口
SELECT * FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL;
--销售接口
SELECT * FROM BBG_RA_SLS_TRX_JL_V@RMS_JL;
--供应商销售接口
SELECT * FROM BBG_RA_SUPP_SLS_JL_V@RMS_JL;

--*********************************************************************************************
--金力系统数据导入RA创建package
--RA_RMS下的package名为:CMX_RMS_JL2RA_SQL
--RADM  下的package名为:CMX_RA_JL2RA_SQL
--RA_RMS下
/*CREATE OR REPLACE PACKAGE CMX_RMS_JL2RA_SQL AS
END CMX_RMS_JL2RA_SQL;

CREATE OR REPLACE PACKAGE BODY CMX_RMS_JL2RA_SQL AS
END CMX_RMS_JL2RA_SQL;*/

--*******************************************************************************************************
--*******************************************************************************************************
--金力商品资料删除

DELETE RADM.W_PRODUCT_ATTR_D P
 WHERE EXISTS (SELECT 1
          FROM BBG_RA_PRODUCT_JL_V@RA_JL J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;
DELETE RADM.W_PRODUCT_D_TL P
 WHERE EXISTS (SELECT 1
          FROM BBG_RA_PRODUCT_JL_V@RA_JL J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;
DELETE RADM.W_PRODUCT_D P
 WHERE EXISTS (SELECT 1
          FROM BBG_RA_PRODUCT_JL_V@RA_JL J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;
--RMS缺失的类别商品
--69
SELECT *
  FROM BBG_RA_PRODUCT_JL_V@RA_JL T
 WHERE /*EXISTS (SELECT 1
          FROM BBG_RA_SLS_TRX_JL_V@RA_JL S
         WHERE T.PROD_NUM = S.PROD_IT_NUM)
   AND */
 T.PROD_CAT5 IN ('7~78~78~786~786', '7~78~78~787~787');

SELECT *
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL S
 WHERE EXISTS
 (SELECT 1
          FROM BBG_RA_PRODUCT_JL_V@RA_JL T
         WHERE T.PROD_NUM = S.PROD_IT_NUM
           AND T.PROD_CAT5 IN ('7~78~78~786~786', '7~78~78~787~787'))
 ORDER BY S.DAY_DT DESC;

--*******************************************************************************************************
--*******************************************************************************************************
--1.金力商品导入
--RA_RMS.W_RTL_ITEM_D_TMP for SDE_RetailItemDimension
--在ra_rms创建金力商品视图：RA_RMS.BBG_RA_PRODUCT_JL_REF_V
CREATE OR REPLACE VIEW RA_RMS.BBG_RA_PRODUCT_JL_REF_V AS
  SELECT J.PROD_NUM PROD_IT_NUM,
         J.ITEM_DESC ITEM_DESC,
         J.PACK_FLG PACK_IND,
         J.ITEM_DESC ITEM_SHRT_DESC,
         J.ITEM_DESC ITEM_SECND_DESC,
         (SELECT CASE
                   WHEN U.UOM IS NOT NULL THEN
                    U.UOM
                   ELSE
                    'TAI'
                 END
            FROM RMS.UOM_CLASS U
           WHERE U.UOM_DESC = J.BBG_ITEM_UOM_DESC) STND_UOM_CODE,
         J.PROD_CAT5 SUBCLASS,
         'Y' INV_IND,
         'Y' MRCH_IND,
         'Y' SELLABLE_IND,
         -1 PACK_SELLABLE_CDE,
         -1 PACK_SIMPLE_CDE,
         -1 PACK_ORDERABLE_CDE,
         1 PACKAGE_SIZE,
         (SELECT CASE
                   WHEN U.UOM IS NOT NULL THEN
                    U.UOM
                   ELSE
                    'TAI'
                 END
            FROM RMS.UOM_CLASS U
           WHERE U.UOM_DESC = J.BBG_ITEM_UOM_DESC) PACKAGE_UOM,
         'ITEM' ITEM_NBR_TYPE_CODE,
         2 ITEM_LEVEL,
         2 TRAN_LEVEL,
         -1 LEVEL1_NUM,
         -1 LEVEL2_NUM,
         -1 LEVEL3_NUM,
         NULL DIFF1_NUM,
         NULL DIFF2_NUM,
         NULL DIFF3_NUM,
         NULL DIFF4_NUM,
         J.PROD_NUM INTEGRATION_ID,
         1 DATASOURCE_NUM_ID,
         NULL TENANT_ID,
         NULL CREATED_BY_WID,
         NULL CHANGED_BY_WID,
         NULL CREATED_ON_DT,
         NULL CHANGED_ON_DT,
         NULL AUX1_CHANGED_ON_DT,
         NULL AUX2_CHANGED_ON_DT,
         NULL AUX3_CHANGED_ON_DT,
         NULL AUX4_CHANGED_ON_DT,
         NULL W_INSERT_DT,
         NULL W_UPDATE_DT,
         NULL ETL_PROC_WID,
         1 PRODUCT_ATTR1_NUM_VALUE,
         NULL X_CUSTOM,
         J.ORIGINAL_RETAIL PRODUCT_ATTR2_NUM_VALUE,
         LANG.LANG LANGUAGE_CODE,
         J.MFG_REC_RETAIL PRODUCT_ATTR3_NUM_VALUE,
         J.BBG_ITEM_BRAND BBG_ITEM_BRAND,
         J.BBG_ITEM_PLACE_OF_ORIGIN BBG_ITEM_PLACE_OF_ORIGIN,
         J.BBG_ITEM_UOM_DESC BBG_ITEM_UOM_DESC,
         J.BBG_REFERENCE_NO1,
         J.BBG_REFERENCE_NO2,
         J.BBG_REFERENCE_NO3,
         J.BBG_REFERENCE_NO4
    FROM BBG_RA_PRODUCT_JL_V@RMS_JL J,
         (SELECT 'US' LANG FROM DUAL UNION ALL SELECT 'ZHS' LANG FROM DUAL) LANG;

INSERT INTO RA_RMS.W_RTL_ITEM_D_TMP D
  (D.PROD_IT_NUM,
   D.ITEM_DESC,
   D.PACK_IND,
   D.ITEM_SHRT_DESC,
   D.ITEM_SECND_DESC,
   D.STND_UOM_CODE,
   D.SUBCLASS,
   D.INV_IND,
   D.MRCH_IND,
   D.SELLABLE_IND,
   D.PACK_SELLABLE_CDE,
   D.PACK_SIMPLE_CDE,
   D.PACK_ORDERABLE_CDE,
   D.PACKAGE_SIZE,
   D.PACKAGE_UOM,
   D.ITEM_NBR_TYPE_CODE,
   D.ITEM_LEVEL,
   D.TRAN_LEVEL,
   D.LEVEL1_NUM,
   D.LEVEL2_NUM,
   D.LEVEL3_NUM,
   D.DIFF1_NUM,
   D.DIFF2_NUM,
   D.DIFF3_NUM,
   D.DIFF4_NUM,
   D.INTEGRATION_ID,
   D.DATASOURCE_NUM_ID,
   D.TENANT_ID,
   D.CREATED_BY_WID,
   D.CHANGED_BY_WID,
   D.CREATED_ON_DT,
   D.CHANGED_ON_DT,
   D.AUX1_CHANGED_ON_DT,
   D.AUX2_CHANGED_ON_DT,
   D.AUX3_CHANGED_ON_DT,
   D.AUX4_CHANGED_ON_DT,
   D.W_INSERT_DT,
   D.W_UPDATE_DT,
   D.ETL_PROC_WID,
   D.PRODUCT_ATTR1_NUM_VALUE,
   D.X_CUSTOM,
   D.PRODUCT_ATTR2_NUM_VALUE,
   D.LANGUAGE_CODE,
   D.PRODUCT_ATTR3_NUM_VALUE,
   D.BBG_ITEM_BRAND,
   D.BBG_ITEM_PLACE_OF_ORIGIN,
   D.BBG_ITEM_UOM_DESC,
   D.BBG_REFERENCE_NO1,
   D.BBG_REFERENCE_NO2,
   D.BBG_REFERENCE_NO3,
   D.BBG_REFERENCE_NO4)
  SELECT * FROM RA_RMS.BBG_RA_PRODUCT_JL_REF_V;

--W_RTL_IT_SUPPLIER_DS

SELECT * FROM RADM.W_RTL_IT_SUPPLIER_DS;
SELECT * FROM BBG_RA_PRODUCT_JL_V@RMS_JL;

--未导入RA的商品资料
CREATE TABLE RADM.JIN_JL_P_TMP AS
  SELECT A.PROD_NUM, A.SRC_EFF_FROM_DT
    FROM BBG_RA_PRODUCT_JL_V@RA_JL A
   WHERE NOT EXISTS
   (SELECT 1 FROM RADM.W_PRODUCT_D B WHERE A.PROD_NUM = B.PROD_NUM)
     AND A.SRC_EFF_FROM_DT <> TRUNC(SYSDATE);

DROP TABLE RADM.JIN_JL_P_TMP;

--导入未导入的商品资料 
--修改BBG_RA_PRODUCT_JL_REF_V视图
SELECT * FROM RA_RMS.BBG_RA_PRODUCT_JL_REF_V;

--只保留未导入的商品资料
DELETE RADM.W_PRODUCT_ATTR_DS P
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.JIN_JL_P_TMP J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;
DELETE RADM.W_PRODUCT_DS_TL P
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.JIN_JL_P_TMP J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;
DELETE RADM.W_PRODUCT_DS P
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.JIN_JL_P_TMP J
         WHERE P.INTEGRATION_ID = J.PROD_NUM);
COMMIT;

--*******************************************************************************************************
--*******************************************************************************************************
--2.金力商品地点维度导入RA

/*CREATE OR REPLACE PACKAGE CMX_JL2RA_SQL AS
END CMX_JL2RA_SQL;

CREATE OR REPLACE PACKAGE BODY CMX_JL2RA_SQL AS
END CMX_JL2RA_SQL;*/
--在ra_rms创建金力商品视图：RA_RMS.BBG_RA_ITEM_LOC_JL_V
CREATE OR REPLACE VIEW RA_RMS.BBG_RA_ITEM_LOC_JL_V AS
  SELECT * FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL;

--修改BBG_RA_ITEM_LOC_D_V视图
SELECT JL.ITEM,
       JL.LOC,
       JL.NBB,
       JL.NBO,
       JL.SALE_TYPE,
       JL.STANDARD_GROSS_MARGIN,
       JL.PROMO_GROSS_MARGIN,
       JL.BUSINESS_MODE,
       JL.ZC_IND,
       JL.BBG_ZG_IND,
       JL.HERO_ITEM_IND,
       JL.START_DATE,
       JL.END_DATE,
       JL.NEW_ITEM_FLAG,
       JL.REF_NO2,
       JL.REF_NO1,
       JL.REF_NO3,
       JL.REF_NO4,
       JL.SRC_EFF_FROM_DT,
       JL.SRC_EFF_FROM_DT
  FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL JL;

--插入BBG_RA_ITEM_LOC_DS
INSERT INTO RADM.BBG_RA_ITEM_LOC_DS@RMS_RA IL
  (IL.ITEM,
   IL.LOC,
   IL.NBB,
   IL.NBO,
   IL.SALE_TYPE,
   IL.STANDARD_GROSS_MARGIN,
   IL.PROMO_GROSS_MARGIN,
   IL.BUSINESS_MODE,
   IL.ZC_IND,
   IL.ZG_IND,
   IL.HERO_ITEM_IND,
   IL.NEW_ITEM_FLAG,
   IL.REF_NO1,
   IL.REF_NO2,
   IL.REF_NO3,
   IL.REF_NO4,
   IL.SRC_EFF_FROM_DT,
   IL.SRC_EFF_TO_DT,
   IL.EFFECTIVE_FROM_DT,
   IL.EFFECTIVE_TO_DT,
   IL.CURRENT_FLG,
   IL.W_INSERT_DT,
   IL.W_UPDATE_DT,
   IL.DATASOURCE_NUM_ID,
   IL.ETL_PROC_WID,
   IL.INTEGRATION_ID,
   IL.X_CUSTOM)
  SELECT JL.ITEM,
         JL.LOC,
         JL.NBB,
         JL.NBO,
         JL.SALE_TYPE,
         JL.STANDARD_GROSS_MARGIN,
         JL.PROMO_GROSS_MARGIN,
         JL.BUSINESS_MODE,
         JL.ZC_IND,
         JL.BBG_ZG_IND,
         JL.HERO_ITEM_IND,
         JL.NEW_ITEM_FLAG,
         JL.REF_NO1,
         JL.REF_NO2,
         JL.REF_NO3,
         JL.REF_NO4,
         TRUNC(JL.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT,
         NULL SRC_EFF_TO_DT,
         NULL EFFECTIVE_FROM_DT,
         NULL EFFECTIVE_TO_DT,
         NULL CURRENT_FLG,
         NULL W_INSERT_DT,
         NULL W_UPDATE_DT,
         1 DATASOURCE_NUM_ID,
         100 ETL_PROC_WID,
         JL.ITEM || '~' || JL.LOC INTEGRATION_ID,
         NULL X_CUSTOM
    FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL JL;

--检查金力商品-地点维度是否导入RA
SELECT /*+PARALLEL(B,20)*/
 *
  FROM BBG_RA_ITEM_LOC_JL_V@RA_JL A
 WHERE NOT EXISTS (SELECT /*+PARALLEL(B,20)*/
         1
          FROM RADM.BBG_RA_ITEM_LOC_D B
         WHERE A.ITEM = B.ITEM
           AND A.LOC = B.LOC);

--未导入RA的商品-地点维度插入
INSERT INTO RADM.BBG_RA_ITEM_LOC_DS IL
  (IL.ITEM,
   IL.LOC,
   IL.NBB,
   IL.NBO,
   IL.SALE_TYPE,
   IL.STANDARD_GROSS_MARGIN,
   IL.PROMO_GROSS_MARGIN,
   IL.BUSINESS_MODE,
   IL.ZC_IND,
   IL.ZG_IND,
   IL.HERO_ITEM_IND,
   IL.NEW_ITEM_FLAG,
   IL.REF_NO1,
   IL.REF_NO2,
   IL.REF_NO3,
   IL.REF_NO4,
   IL.SRC_EFF_FROM_DT,
   IL.SRC_EFF_TO_DT,
   IL.EFFECTIVE_FROM_DT,
   IL.EFFECTIVE_TO_DT,
   IL.CURRENT_FLG,
   IL.W_INSERT_DT,
   IL.W_UPDATE_DT,
   IL.DATASOURCE_NUM_ID,
   IL.ETL_PROC_WID,
   IL.INTEGRATION_ID,
   IL.X_CUSTOM)
  SELECT JL.ITEM,
         JL.LOC,
         JL.NBB,
         JL.NBO,
         JL.SALE_TYPE,
         JL.STANDARD_GROSS_MARGIN,
         JL.PROMO_GROSS_MARGIN,
         JL.BUSINESS_MODE,
         JL.ZC_IND,
         JL.BBG_ZG_IND,
         JL.HERO_ITEM_IND,
         JL.NEW_ITEM_FLAG,
         JL.REF_NO1,
         JL.REF_NO2,
         JL.REF_NO3,
         JL.REF_NO4,
         TRUNC(JL.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT,
         NULL SRC_EFF_TO_DT,
         NULL EFFECTIVE_FROM_DT,
         NULL EFFECTIVE_TO_DT,
         NULL CURRENT_FLG,
         NULL W_INSERT_DT,
         NULL W_UPDATE_DT,
         1 DATASOURCE_NUM_ID,
         100 ETL_PROC_WID,
         JL.ITEM || '~' || JL.LOC INTEGRATION_ID,
         NULL X_CUSTOM
    FROM BBG_RA_ITEM_LOC_JL_V@RA_JL JL
   WHERE NOT EXISTS (SELECT 1
            FROM RADM.BBG_RA_ITEM_LOC_D ILD
           WHERE JL.ITEM = ILD.ITEM
             AND JL.LOC = ILD.LOC);
COMMIT;

--*******************************************************************************************************
--*******************************************************************************************************
--3.金力商品销售导入RA
--销售接口
SELECT * FROM BBG_RA_SLS_TRX_JL_V@RA_JL;

--地点维度是否存在
SELECT * FROM RABATCHER.W_INT_ORG_D_RTL_TMP;
SELECT /*+PARALLEL(T,20)*/
 *
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL T
 WHERE NOT EXISTS (SELECT /*+PARALLEL(O,20)*/
         1
          FROM RABATCHER.W_INT_ORG_D_RTL_TMP O
         WHERE T.ORG_NUM = O.ORG_NUM);

--商品-地点维度是否存在
SELECT /*+PARALLEL(T,20)*/
 *
  FROM BBG_RA_SLS_TRX_JL_V@RA_JL T
 WHERE NOT EXISTS (SELECT /*+PARALLEL(O,20)*/
         1
          FROM BBG_RA_ITEM_LOC_D O
         WHERE T.ORG_NUM = O.LOC
           AND T.PROD_IT_NUM = O.ITEM);

--RADM创建金力商品销售视图
CREATE OR REPLACE VIEW RADM.BBG_RA_SLS_TRX_JL_V AS
  SELECT * FROM BBG_RA_SLS_TRX_JL_V@RA_JL;

--金力商品销售VS供应商销售
--销售接口
SELECT DAY_DT,
       SUM(SLS_QTY + RET_QTY),
       SUM(SLS_AMT_LCL + RET_AMT_LCL),
       SUM((SLS_AMT_LCL + RET_AMT_LCL) -
           (SLS_TAX_AMT_LCL + RET_TAX_AMT_LCL) -
           (SLS_PROFIT_AMT_LCL + RET_PROFIT_AMT_LCL)),
       SUM((SLS_AMT_LCL + RET_AMT_LCL) -
           (SLS_TAX_AMT_LCL + RET_TAX_AMT_LCL))
  FROM BBG_RA_SLS_TRX_JL_V@RMS_JL
 WHERE DAY_DT BETWEEN DATE '2015-03-08' AND DATE '2015-03-18'
 GROUP BY DAY_DT
 ORDER BY DAY_DT;
--供应商销售接口
SELECT DAY_DT,
       SUM(SUPP_SALES_QTY),
       SUM(BBG_REFERENCE_FO1),
       SUM(SUPP_SALES_COST),
       SUM(SUPP_SALES_AMT)
  FROM BBG_RA_SUPP_SLS_JL_V@RMS_JL
--WHERE DAY_DT BETWEEN DATE '2015-03-01' AND DATE '2015-03-09'
 GROUP BY DAY_DT
 ORDER BY DAY_DT;
--销售接口
SELECT *
  FROM BBG_RA_SLS_TRX_JL_V@RMS_JL
 WHERE DAY_DT = DATE '2015-03-08'
   AND PROD_IT_NUM = '2400072022728';
--供应商销售接口
SELECT *
  FROM BBG_RA_SUPP_SLS_JL_V@RMS_JL
 WHERE DAY_DT = DATE '2015-03-08'
   AND PROD_IT_NUM = '2400072022728';


--***************
--***************
--RADM.BBG_RA_SLS_TRX_JL_V插入RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
INSERT INTO RADM.W_RTL_SLS_TRX_IT_LC_DY_FS
  (SLS_TRX_ID,
   PROD_IT_NUM,
   ORG_NUM,
   DAY_DT,
   VOUCHER_ID,
   RTL_TYPE_CODE,
   MIN_NUM,
   EMPLOYEE_NUM,
   SLS_QTY,
   SLS_AMT_LCL,
   SLS_PROFIT_AMT_LCL,
   SLS_TAX_AMT_LCL,
   SLS_EMP_DISC_AMT_LCL,
   SLS_MANUAL_COUNT,
   SLS_SCAN_COUNT,
   RET_QTY,
   RET_AMT_LCL,
   RET_PROFIT_AMT_LCL,
   RET_TAX_AMT_LCL,
   RET_EMP_DISC_AMT_LCL,
   RET_MANUAL_COUNT,
   RET_SCAN_COUNT,
   REJECT_FLG,
   SLS_MANUAL_MKDN_AMT_LCL,
   SLS_MANUAL_MKUP_AMT_LCL,
   RET_MANUAL_MKDN_AMT_LCL,
   RET_MANUAL_MKUP_AMT_LCL,
   EXCHANGE_DT,
   AUX1_CHANGED_ON_DT,
   AUX2_CHANGED_ON_DT,
   AUX3_CHANGED_ON_DT,
   AUX4_CHANGED_ON_DT,
   CHANGED_BY_ID,
   CHANGED_ON_DT,
   CREATED_BY_ID,
   CREATED_ON_DT,
   DATASOURCE_NUM_ID,
   DELETE_FLG,
   DOC_CURR_CODE,
   ETL_THREAD_VAL,
   GLOBAL1_EXCHANGE_RATE,
   GLOBAL2_EXCHANGE_RATE,
   GLOBAL3_EXCHANGE_RATE,
   INTEGRATION_ID,
   LOC_CURR_CODE,
   LOC_EXCHANGE_RATE,
   TENANT_ID,
   X_CUSTOM,
   BBG_RETAIL_TYPE_ID,
   BBG_SERVICE_SATISFACTION,
   SRC_REF_NO1,
   SRC_REF_NO2,
   SRC_REF_NO3,
   SRC_REF_NO6,
   SRC_REF_NO7,
   SRC_REF_NO8,
   BBG_REFERENCE_DO1,
   BBG_REFERENCE_DO2,
   BBG_REFERENCE_DO3,
   BBG_REFERENCE_DO4,
   BBG_REFERENCE_DO5,
   BBG_REFERENCE_FO1,
   BBG_REFERENCE_FO2,
   BBG_REFERENCE_FO3,
   BBG_REFERENCE_FO4,
   BBG_REFERENCE_FO5,
   BBG_REFERENCE_FO6,
   BBG_REFERENCE_FO7,
   BBG_REFERENCE_FO8,
   BBG_REFERENCE_FO9,
   BBG_REFERENCE_FO10,
   HYK_NO)
  SELECT T.SLS_TRX_ID,
         T.PROD_IT_NUM,
         T.ORG_NUM,
         T.DAY_DT,
         -1 VOUCHER_ID,
         T.RTL_TYPE_CODE,
         T.MIN_NUM,
         -1 EMPLOYEE_NUM,
         T.SLS_QTY,
         T.SLS_AMT_LCL,
         T.SLS_PROFIT_AMT_LCL,
         T.SLS_TAX_AMT_LCL,
         T.SLS_EMP_DISC_AMT_LCL,
         T.SLS_MANUAL_COUNT,
         T.SLS_SCAN_COUNT,
         ABS(T.RET_QTY) RET_QTY,
         ABS(T.RET_AMT_LCL) RET_AMT_LCL,
         T.RET_PROFIT_AMT_LCL,
         ABS(T.RET_TAX_AMT_LCL) RET_TAX_AMT_LCL,
         T.RET_EMP_DISC_AMT_LCL,
         T.RET_MANUAL_COUNT,
         T.RET_SCAN_COUNT,
         NULL REJECT_FLG,
         T.SLS_MANUAL_MKDN_AMT_LCL,
         T.SLS_MANUAL_MKUP_AMT_LCL,
         T.RET_MANUAL_MKDN_AMT_LCL,
         T.RET_MANUAL_MKUP_AMT_LCL,
         T.DAY_DT EXCHANGE_DT,
         NULL AUX1_CHANGED_ON_DT,
         NULL AUX2_CHANGED_ON_DT,
         NULL AUX3_CHANGED_ON_DT,
         NULL AUX4_CHANGED_ON_DT,
         -1 CHANGED_BY_ID,
         SYSDATE CHANGED_ON_DT,
         -1 CREATED_BY_ID,
         SYSDATE CREATED_ON_DT,
         1 DATASOURCE_NUM_ID,
         NULL DELETE_FLG,
         'CNY' DOC_CURR_CODE,
         (SELECT L.THREAD_VAL
            FROM RA_RMS.RA_RESTART_LOC@RA_RMS_DBLINK L
           WHERE T.ORG_NUM = L.DRIVER_VALUE
             AND L.SCENARIO_NAME = 'SDE_BBG_RETAIL_SALESTRANSACTIONFACT') ETL_THREAD_VAL,
         NULL GLOBAL1_EXCHANGE_RATE,
         NULL GLOBAL2_EXCHANGE_RATE,
         NULL GLOBAL3_EXCHANGE_RATE,
         T.SLS_TRX_ID || '~' || T.PROD_IT_NUM || '~-1~' ||
         TO_CHAR(T.DAY_DT, 'DD-MON-YY', 'NLS_DATE_LANGUAGE = American') INTEGRATION_ID,
         'CNY' LOC_CURR_CODE,
         NULL LOC_EXCHANGE_RATE,
         NULL TENANT_ID,
         NULL X_CUSTOM,
         T.BBG_RETAIL_TYPE_ID,
         3.5 BBG_SERVICE_SATISFACTION,
         NULL SRC_REF_NO1,
         NULL SRC_REF_NO2,
         NULL SRC_REF_NO3,
         T.PROD_IT_NUM SRC_REF_NO6,
         NULL SRC_REF_NO7,
         NULL SRC_REF_NO8,
         NULL BBG_REFERENCE_DO1,
         NULL BBG_REFERENCE_DO2,
         NULL BBG_REFERENCE_DO3,
         NULL BBG_REFERENCE_DO4,
         NULL BBG_REFERENCE_DO5,
         NULL BBG_REFERENCE_FO1,
         NULL BBG_REFERENCE_FO2,
         NULL BBG_REFERENCE_FO3,
         NULL BBG_REFERENCE_FO4,
         NULL BBG_REFERENCE_FO5,
         NULL BBG_REFERENCE_FO6,
         NULL BBG_REFERENCE_FO7,
         NULL BBG_REFERENCE_FO8,
         NULL BBG_REFERENCE_FO9,
         NULL BBG_REFERENCE_FO10,
         NULL HYK_NO
    FROM RADM.BBG_RA_SLS_TRX_JL_V T;

--FS一条记录,F表四条记录
SELECT /*+PARALLEL(T,20)*/
 *
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
 WHERE T.DT_WID = 120150323000 AND T.BBG_SERVICE_SATISFACTION=3.5 AND T.INTEGRATION_ID LIKE '%2400071022380%';
 select * from W_RTL_SLS_TRX_IT_LC_DY_FS t WHERE T.PROD_IT_NUM='2400071022380';
--ITEM_LOC重复 
SELECT /*+PARALLEL(T,20)*/
 *
  FROM RADM.BBG_RA_ITEM_LOC_D T
 WHERE T.ITEM = 2400071022380
   AND T.LOC = 139185;
SELECT *
  FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL
 where item = 2400071022380
   and loc = 139185;
--删除商品-地点维度的日期(SRC_EFF_FROM_DT,EFFECTIVE_FROM_DT,EFFECTIVE_TO_DT)都一样的数据
DELETE RADM.BBG_RA_ITEM_LOC_D IL
 WHERE EXISTS (SELECT 1
          FROM (SELECT /*+PARALLEL(T,20)*/
                 T.ITEM,
                 T.LOC,
                 T.SRC_EFF_FROM_DT,
                 T.EFFECTIVE_FROM_DT,
                 T.EFFECTIVE_TO_DT
                  FROM BBG_RA_ITEM_LOC_D T
                 GROUP BY T.ITEM,
                          T.LOC,
                          T.SRC_EFF_FROM_DT,
                          T.EFFECTIVE_FROM_DT,
                          T.EFFECTIVE_TO_DT
                HAVING COUNT(*) > 1
                 ORDER BY ITEM, LOC) A
         WHERE IL.ITEM = A.ITEM
           AND IL.LOC = A.LOC
           AND IL.SRC_EFF_FROM_DT = A.SRC_EFF_FROM_DT
           AND IL.EFFECTIVE_FROM_DT = A.EFFECTIVE_FROM_DT
           AND IL.EFFECTIVE_TO_DT = A.EFFECTIVE_TO_DT);


----TMP
SELECT * FROM RADM.BBG_RA_SLS_TRX_JL_V;
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_FS;
