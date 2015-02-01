--1.入库数量，金额----------------------------------------------------------------------------
--直送
CREATE MATERIALIZED VIEW RADM.YJ_REC AS
SELECT S.MN_WID,
       S.ORG_WID,
       S.PROD_WID,
       SUM(S.RECEIVED_QTY) RECEIVED_QTY,
       SUM(S.RECEIVED_AMOUNT) RECEIVED_AMOUNT
  FROM (SELECT SUBSTR(TO_CHAR(T.BBG_REFERENCE_DO2, 'YYYYMMDD'), 1, 6) MN_WID,
               T.ORG_WID,
               T.PROD_WID,
               SUM(NVL(T.RECEIVED_QTY, 0)) RECEIVED_QTY,
               SUM(NVL(T.BBG_REFERENCE_FO2, 0)) RECEIVED_AMOUNT
          FROM RADM.W_RTL_SUPPCM_IT_LC_DY_MV T
         WHERE T.BBG_REFERENCE_DO2 BETWEEN DATE '2013-06-01' AND DATE
         '2014-05-31'
         GROUP BY SUBSTR(TO_CHAR(T.BBG_REFERENCE_DO2, 'YYYYMMDD'), 1, 6),
                  T.ORG_WID,
                  T.PROD_WID
        UNION ALL
        --配送
        SELECT SUBSTR(T.DT_WID, 2, 6) MN_WID,
               T.TO_ORG_WID ORG_WID,
               T.PROD_WID,
               SUM(ABS(T.TRANSFER_QTY)) RECEIVED_QTY,
               SUM(ABS(T.Transfer_Cost)) RECEIVED_AMOUNT
          FROM RADM.BBG_RA_INVTSF_IT_LC_DY_F T
         WHERE T.TRANSFER_TYPE_ID = 2
           AND T.BBG_REFERENCE_DO1 = 'OUT'
           AND T.DT_WID BETWEEN 120130601000 AND 120140531000
         GROUP BY SUBSTR(T.DT_WID, 2, 6), T.TO_ORG_WID, T.PROD_WID) S
 WHERE S.RECEIVED_QTY <> 0
 GROUP BY S.MN_WID, S.ORG_WID, S.PROD_WID;
--2.销售数量，金额，销售成本。--------------------------------------------------------------------------
CREATE MATERIALIZED VIEW RADM.YJ_SLS AS
SELECT SUBSTR(T.DT_WID, 2, 6) MN_WID,
       T.ORG_WID,
       T.PROD_WID,
       SUM(NVL(T.SLS_QTY, 0) - NVL(T.RET_QTY, 0)) SLS_QTY,
       SUM(NVL(T.SLS_AMT_LCL, 0) - NVL(T.RET_AMT_LCL, 0)) -
       SUM(NVL(T.SLS_TAX_AMT_LCL, 0) - NVL(T.RET_TAX_AMT_LCL, 0)) SLS_AMOUNT,
       SUM(NVL(T.SLS_AMT_LCL, 0) - NVL(T.RET_AMT_LCL, 0)) -
       SUM(NVL(T.SLS_TAX_AMT_LCL, 0) - NVL(T.RET_TAX_AMT_LCL, 0)) -
       sum(NVL(T.SLS_PROFIT_AMT_LCL, 0) - NVL(T.RET_PROFIT_AMT_LCL, 0)) SLS_COST
  FROM RADM.W_RTL_SLS_IT_LC_DY_A T
 WHERE SUBSTR(T.DT_WID, 2, 6) BETWEEN 201306 AND 201405
 GROUP BY SUBSTR(T.DT_WID, 2, 6), T.ORG_WID, T.PROD_WID;
--3.退货数量，金额-----------------------------------------------------------------------
--直送退货
CREATE MATERIALIZED VIEW RADM.YJ_RTV AS
SELECT R.MN_WID,
       R.ORG_WID,
       R.PROD_WID,
       SUM(R.RTV_QTY) RTV_QTY,
       SUM(R.RTV_COST) RTV_COST
  FROM (SELECT SUBSTR(T.DT_WID, 2, 6) MN_WID,
               T.ORG_WID,
               T.PROD_WID,
               SUM(T.TRANSFER_QTY) RTV_QTY,
               SUM(T.TRANSFER_COST) RTV_COST
          FROM RADM.BBG_RA_RTV_IT_LC_SUPP_DY_F T
         WHERE T.DT_WID BETWEEN 120130601000 AND 120140531000
         GROUP BY SUBSTR(T.DT_WID, 2, 6), T.ORG_WID, T.PROD_WID
        UNION ALL
        --退货回配送
        SELECT SUBSTR(T.DT_WID, 2, 6) MN_WID,
               T.ORG_WID,
               T.PROD_WID,
               SUM(ABS(T.TRANSFER_QTY)) RTV_QTY,
               SUM(ABS(T.Transfer_Cost)) RTV_COST
          FROM RADM.BBG_RA_INVTSF_IT_LC_DY_F T
         WHERE T.TRANSFER_TYPE_ID = 3
           AND T.BBG_REFERENCE_DO1 = 'OUT'
           AND T.DT_WID BETWEEN 120130601000 AND 120140531000
         GROUP BY SUBSTR(T.DT_WID, 2, 6), T.ORG_WID, T.PROD_WID) R
 GROUP BY R.MN_WID, R.ORG_WID, R.PROD_WID;
--4.合并-----------------------------------------------------------------------------------
CREATE MATERIALIZED VIEW RADM.YJ_SJB_2 AS
  SELECT TD.MN_WID 月份,
         O.ORG_NUM 门店编码,
         P.PROD_IT_NUM 商品编码,
         SUM(TD.RECEIVED_QTY) 入库数量,
         SUM(TD.RECEIVED_AMOUNT) 入库金额,
         SUM(TD.SLS_QTY) 销售数量,
         SUM(TD.SLS_AMOUNT) 销售金额,
         SUM(TD.SLS_COST) 销售成本,
         SUM(TD.RTV_QTY) 退货数量,
         SUM(TD.RTV_COST) 退货金额
    FROM (SELECT NVL(A_1.MN_WID, RTV.MN_WID) MN_WID,
                 NVL(A_1.ORG_WID, RTV.ORG_WID) ORG_WID,
                 NVL(A_1.PROD_WID, RTV.PROD_WID) PROD_WID,
                 A_1.RECEIVED_QTY,
                 A_1.RECEIVED_AMOUNT,
                 A_1.SLS_QTY,
                 A_1.SLS_AMOUNT,
                 A_1.SLS_COST,
                 RTV.RTV_QTY,
                 RTV.RTV_COST
            FROM (SELECT NVL(REC.MN_WID, SLS.MN_WID) MN_WID,
                         NVL(REC.ORG_WID, SLS.ORG_WID) ORG_WID,
                         NVL(REC.PROD_WID, SLS.PROD_WID) PROD_WID,
                         REC.RECEIVED_QTY,
                         REC.RECEIVED_AMOUNT,
                         SLS.SLS_QTY,
                         SLS.SLS_AMOUNT,
                         SLS.SLS_COST
                    FROM RADM.YJ_REC REC
                    FULL OUTER JOIN RADM.YJ_SLS SLS
                      ON REC.MN_WID = SLS.MN_WID
                     AND REC.ORG_WID = SLS.ORG_WID
                     AND REC.PROD_WID = SLS.PROD_WID) A_1
            FULL OUTER JOIN RADM.YJ_RTV RTV
              ON A_1.MN_WID = RTV.MN_WID
             AND A_1.ORG_WID = RTV.ORG_WID
             AND A_1.PROD_WID = RTV.PROD_WID) TD,
         RABATCHER.W_PRODUCT_D_RTL_TMP P,
         RABATCHER.W_INT_ORG_D_RTL_TMP O
   WHERE TD.PROD_WID = P.PROD_IT_WID
     AND TD.ORG_WID = O.ORG_WID
     AND P.PROD_DV_NUM <> 7
   GROUP BY TD.MN_WID, O.ORG_NUM, P.PROD_IT_NUM
   ORDER BY TD.MN_WID, O.ORG_NUM, P.PROD_IT_NUM;

DROP MATERIALIZED VIEW RADM.YJ_SJB_2;

--5.库存金额
SELECT INV.MN_WID                   月份,
       O.ORG_NUM                    门店编码,
       P.PROD_IT_NUM                商品编码,
       INV.INV_QTY                  库存数量,
       INV.INV_COST                 库存成本,
       INV.INV_IN_TRAN_QTY          在途数量,
       INV.INV_IN_TRAN_COST_AMT_LCL 在途成本
  FROM (SELECT SUBSTR(T.DT_WID, 2, 6) MN_WID,
               T.DT_WID,
               T.ORG_WID,
               T.PROD_WID,
               NVL(T.INV_SOH_QTY, 0) INV_QTY,
               NVL(T.INV_SOH_COST_AMT_LCL, 0) INV_COST,
               NVL(T.INV_IN_TRAN_QTY, 0) INV_IN_TRAN_QTY,
               NVL(T.INV_IN_TRAN_COST_AMT_LCL, 0) INV_IN_TRAN_COST_AMT_LCL
          FROM RADM.W_RTL_INV_IT_LC_DY_FV T
         WHERE T.DT_WID = 120131231000
           AND T.INV_SOH_QTY <> 0) INV,
       RABATCHER.W_PRODUCT_D_RTL_TMP P,
       RABATCHER.W_INT_ORG_D_RTL_TMP O
 WHERE INV.PROD_WID = P.PROD_IT_WID
   AND INV.ORG_WID = O.ORG_WID
   AND TO_DATE(SUBSTR(INV.DT_WID,2,8),'YYYYMMDD') BETWEEN P.SRC_EFF_FROM_DT AND P.SRC_EFF_TO_DT
   AND P.PROD_DV_NUM <> 7
   AND O.ORG_WID NOT IN (1, 2, 3, 4, 5, 6, 7, 8, 10, 12, 13, 14, 15, 16);
---邓汝清
select ils.loc 门店,
       LV.LOC_NAME 门店名称,
       ILS.ITEM 编码,
       IM.ITEM_DESC 名称,
       IM.DEPT 大类,
       IM.CLASS 中类,
       IM.SUBCLASS 小类,
       ILS.PRIMARY_SUPP 主供应商编码,
       SS.SUP_NAME 主供应商名称,
       ILS.STOCK_ON_HAND 库存数量,
       ILS.IN_TRANSIT_QTY 在途数量,
       ILS.AV_COST 成本价,
       ILS.STOCK_ON_HAND * ILS.AV_COST 库存金额,
       ILS.IN_TRANSIT_QTY * ILS.AV_COST 在途金额
  from item_loc_soh ils, item_loc il, item_master im, sups ss, loc_v lv
 where ILS.ITEM = il.item
   and ILS.LOC = IL.LOC
   and ils.loc = lv.loc
   and ils.item = im.item
   and ILS.PRIMARY_SUPP = SS.SUPPLIER
   and IM.INVENTORY_IND = 'Y'
   and IM.ITEM_LEVEL = IM.TRAN_LEVEL
   and ILS.STOCK_ON_HAND <> 0
   AND (LV.LOC_TYPE = 'S'
      --OR LV.LOC IN (110001, 110004)
   OR EXISTS (SELECT 1
          FROM WH
         WHERE WH.WH = LV.loc
           AND WH.WH IN (110001, 110004)))
 order by ILS.LOC, im.dept, ILS.PRIMARY_SUPP;
