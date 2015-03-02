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

--修改RA_RMS.BBG_RA_ITEM_LOC_D_V视图
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

SELECT * FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL;
SELECT COUNT(*) FROM BBG_RA_ITEM_LOC_D_V;
SELECT * FROM RADM.BBG_RA_ITEM_LOC_DS@RMS_RA;
