SELECT SUBSTR(ADJ.DT_WID, 2, 6) 月份,
       ORG.ORG_NUM 地点编码,
       T955085.LVL6ANC_PRODCAT_ID 大类编码,
       T14449.PROD_NUM 商品编码,
       T18745.PRODUCT_NAME 商品名称,
       T14449.BBG_ITEM_UOM_DESC 单位,
       '[' || RS.REASON || ']' || RS.REASON_DESC 报损原因,
       SUM(ADJ.ADJ_QTY) 报损数量,
       SUM(ADJ.ADJ_COST) 报损成本,
       VAT.VAT_RATE 进项税率
  FROM RADM.BBG_RA_INVADJ_IT_LC_DY_F ADJ,
       RADM.BBG_RA_AJUSTMENT_REASON_D RS,
       W_PROD_CAT_DH T955085,
       RMS.VAT_ITEM@RA_RMS_DBLINK VAT,
       W_INT_ORG_D ORG,
       (SELECT T.*
          FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
         WHERE T.SCD1_WID = A.SCD1_WID
           AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449, /*商品编码*/
       (SELECT DATASOURCE_NUM_ID,
               INTEGRATION_ID,
               PRODUCT_DESCR,
               PRODUCT_NAME,
               LANGUAGE_CODE
          FROM W_PRODUCT_D_TL
         WHERE LANGUAGE_CODE = 'ZHS') T18745 /*商品名称*/
 WHERE T14449.DATASOURCE_NUM_ID = T18745.DATASOURCE_NUM_ID
   and T14449.INTEGRATION_ID = T18745.INTEGRATION_ID
   AND ADJ.PROD_WID = T14449.ROW_WID
   AND ADJ.ADJUSTMENT_REASON_WID = RS.ROW_WID
   AND T14449.PROD_CAT5_WID_AS_WAS = T955085.ROW_WID
   AND T14449.PROD_NUM = VAT.ITEM(+)
   AND VAT.VAT_TYPE IN ('B', 'C')
   AND ADJ.ORG_WID = ORG.ROW_WID
   AND RS.REASON IN ('801', '810')
   AND ADJ.DT_WID BETWEEN '120130101000' AND '120131231000'
 GROUP BY SUBSTR(ADJ.DT_WID, 2, 6),
          ORG.ORG_NUM,
          T955085.LVL6ANC_PRODCAT_ID,
          T14449.PROD_NUM,
          T18745.PRODUCT_NAME,
          T14449.BBG_ITEM_UOM_DESC,
          '[' || RS.REASON || ']' || RS.REASON_DESC,
          VAT.VAT_RATE
 ORDER BY SUBSTR(ADJ.DT_WID, 2, 6),
          T955085.LVL6ANC_PRODCAT_ID,
          T14449.PROD_NUM,
          T18745.PRODUCT_NAME,
          T14449.BBG_ITEM_UOM_DESC;
-----------------------------------------------------------------------
SELECT * FROM RMS.VAT_ITEM@RA_RMS_DBLINK;
SELECT * FROM RADM.W_PROD_CAT_DH;

SELECT * FROM RADM.BBG_RA_AJUSTMENT_REASON_D;
SELECT T.*
  FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
 WHERE T.SCD1_WID = A.SCD1_WID
   AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME;

SELECT *
  FROM RADM.BBG_RA_INVADJ_IT_LC_DY_F T
 WHERE T.DT_WID BETWEEN '120130101000' AND '120131231000'
 ORDER BY T.DT_WID;

(
  SELECT T.*
    FROM W_PRODUCT_D T, W_PRODUCT_ATTR_D A
   WHERE T.SCD1_WID = A.SCD1_WID
     AND A.PRODUCT_ATTR12_NAME = A.PRODUCT_ATTR11_NAME) T14449, /*商品编码*/
   (SELECT DATASOURCE_NUM_ID,
           INTEGRATION_ID,
           PRODUCT_DESCR,
           PRODUCT_NAME,
           LANGUAGE_CODE
      FROM W_PRODUCT_D_TL
     WHERE LANGUAGE_CODE = 'ZHS') T18745, /*商品名称*/
