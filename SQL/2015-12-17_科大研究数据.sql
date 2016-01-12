--2014.11.30~2015.11.30 超市湘潭区域
--交易号、部门、商品编码、单价、数量、金额、商品名称、会员卡号

SELECT T.SLS_TRX_ID 交易号,
       SUBSTR(P.PROD_CAT5,
              INSTR(P.PROD_CAT5, '~', 1, 2) + 1,
              INSTR(P.PROD_CAT5, '~', 1, 3) -
              (INSTR(P.PROD_CAT5, '~', 1, 2) + 1)) 部门,
       T.HYK_NO 会员卡号,
       P.PROD_NUM 商品编码,
       PT.PRODUCT_NAME 商品名称,
       ROUND(DECODE(T.SQTY, 0, 0, T.SAMT / T.SQTY), 4) 单价,
       T.SQTY 销售数量,
       T.SAMT 销售金额
  FROM (SELECT T1.DT_WID,
               T1.ORG_WID,
               T1.ORG_DH_WID,
               T1.HYK_NO,
               T1.SLS_TRX_ID,
               T1.PROD_WID,
               SUM(T1.SLS_QTY - T1.RET_QTY) SQTY,
               SUM(T1.SLS_AMT_LCL - T1.RET_AMT_LCL) SAMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T1
         WHERE T1.DT_WID BETWEEN 120141130000 AND 120151130000
           AND T1.HYK_NO IS NOT NULL
         GROUP BY T1.DT_WID,
                  T1.ORG_WID,
                  T1.ORG_DH_WID,
                  T1.HYK_NO,
                  T1.SLS_TRX_ID,
                  T1.PROD_WID) T,
       RADM.W_PRODUCT_D P,
       RADM.W_PRODUCT_D_TL PT,
       RADM.W_INT_ORG_D O,
       RADM.W_INT_ORG_DH OH
 WHERE T.PROD_WID = P.ROW_WID
   AND P.DATASOURCE_NUM_ID = PT.DATASOURCE_NUM_ID
   AND P.INTEGRATION_ID = PT.INTEGRATION_ID
   AND PT.LANGUAGE_CODE = 'ZHS'
   AND T.ORG_WID = O.ROW_WID
   AND T.ORG_DH_WID = OH.ROW_WID
   AND OH.ORG_HIER10_NUM = 107002;

SELECT COUNT(1)
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T1
 WHERE T1.HYK_NO IS NOT NULL
   AND T1.DT_WID BETWEEN 120141130000 AND 120151130000
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_DH OH
         WHERE T1.ORG_DH_WID = OH.ROW_WID
           AND OH.ORG_HIER10_NUM = 107002);
