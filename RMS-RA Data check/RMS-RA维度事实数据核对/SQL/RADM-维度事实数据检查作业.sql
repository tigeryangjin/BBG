--1.维度和事实条目数核对---------------------------------------------------------------------
SELECT *
  FROM TABLE_CHECK_DIMENSION
 WHERE RUN_DATE = &RUN_DATE
 ORDER BY TABLE_NAME;
SELECT * FROM TABLE_CHECK_FACT WHERE RUN_DATE = &RUN_DATE ORDER BY ROW_WID;
--2.供应商销售核查(RMS-RA)--------------------------------------------------------------------
SELECT T.DAY_DT,
       T.DATASOURCE,
       T.RMS_SSQ,
       T.RA_SSQ,
       T.QTY_DIFF,
       T.RMS_SSC,
       T.RA_SSC,
       T.COST_DIFF,
       T.RMS_SSA,
       T.RA_SSA,
       T.AMT_DIFF
  FROM RADM.JIN_RMS_RA_SUPP_SLS_CHECK T
 WHERE SUBSTR(TO_CHAR(T.DAY_DT, 'YYYYMMDD'), 1, 6) = &MONTH
 ORDER BY T.DAY_DT DESC, T.DATASOURCE;
--3.每日库存核对(RMS-RA)---------------------------------------------------------------------
select * from RADM.RMS_RA_INV_CHECK_DIFF t;
--4.订单差异核查(RMS-RA)---------------------------------------------------------------------
SELECT * FROM RADM.JIN_RMS_RA_SUPPCM_DIFF T ORDER BY T.ORDER_NO;
--5.库存调整核查(RMS-RA)--------------------------------------------------------------------
SELECT * FROM RADM.JIN_RA_RMS_INVADJ_CHECK;
--6.前台销售:数量为0.001,金额小于1分钱,引起商品成本差异的数据检查---------------------------
SELECT *
  FROM RADM.JIN_RMS_IT_LC_COST_DIFF T
 WHERE SUBSTR(TO_CHAR(T.TRAN_DATE, 'YYYYMMDD'), 1, 6) = &MONTH
 ORDER BY T.TRAN_DATE DESC;
--6.小类:金力有,rms无
SELECT *
  FROM (SELECT DISTINCT 'SBC' || '|' || SUBSTR(T.PROD_CAT5, 6, 2) || '|' ||
                        SUBSTR(T.PROD_CAT5, 9, 3) || '|' ||
                        SUBSTR(T.PROD_CAT5, 13, 4) SBC,
                        T.PROD_CAT5
          FROM BBG_RA_PRODUCT_JL_V@Ra_Jl T
         ORDER BY SUBSTR(T.PROD_CAT5, 13, 4)) JL
 WHERE NOT EXISTS (SELECT 1
          FROM (SELECT 'SBC' || '|' || S.DEPT || '|' || S.CLASS || '|' ||
                       S.SUBCLASS SBC
                  FROM SUBCLASS@RA_RMS_DBLINK S
                 WHERE S.DEPT LIKE '7%'
                 ORDER BY S.SUBCLASS) RMS
         WHERE RMS.SBC = JL.SBC);
--7.返厂数据核对(RMS-RA)
SELECT * FROM RADM.JIN_RMS_RA_RTV_CHECK;
--8.				 
SELECT * FROM RADM.W_PARTY_ORG_D T WHERE T.SUPPLIER_NUM='780001';


--****************************************************************************************
--****************************************************************************************
/*
--BBG_RA_SLSFC_DP_LC_DY_FS销售预算重复处理
SELECT T.PROD_DH_WID, T.ORG_DH_WID, T.DT_WID, COUNT(*)
  FROM RABATCHER.BBG_RA_SLSFC_DP_LC_DY_TMP T
 GROUP BY T.PROD_DH_WID, T.ORG_DH_WID, T.DT_WID
HAVING COUNT(*) > 1;

SELECT T.DT_WID, T.PROD_DP_NUM, T.ORG_NUM, COUNT(*)
  FROM BBG_RA_SLSFC_DP_LC_DY_FS_V T
 WHERE T.DT_WID = '120141201000'
 GROUP BY T.DT_WID, T.PROD_DP_NUM, T.ORG_NUM
HAVING COUNT(*) > 1;

SELECT *
  FROM ZFL.BUDGET001@SCB_DBLINK T
 WHERE T.STOREID = 120215
   AND T.DAYS = 20141201;

--每日库存核对(RMS-RA)---------------------------------------------------------------------
select * from RADM.RMS_RA_INV_CHECK_DIFF t;

--CHEKC ITEM_LOC
SELECT * FROM RADM.W_PRODUCT_D T WHERE T.PROD_NUM = '800367536';
SELECT * FROM RADM.W_INT_ORG_D T WHERE T.ORG_NUM = '120065';
--W_RTL_INV_IT_LC_DY_F表二条999999999999999
SELECT \*+PARALLEL(T,20)*\
 T.PROD_SCD1_WID ITEM, T.ORG_SCD1_WID LOC
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE T.TO_DT_WID = '999999999999999'
 GROUP BY T.PROD_SCD1_WID, T.ORG_SCD1_WID
HAVING COUNT(*) > 1
 ORDER BY T.PROD_SCD1_WID, T.ORG_SCD1_WID;

--W_RTL_INV_IT_LC_DY_F
SELECT \*+PARALLEL(T,20)*\
 *
  FROM RADM.W_RTL_INV_IT_LC_DY_F T
 WHERE T.PROD_SCD1_WID = 400017
   AND T.ORG_SCD1_WID = 140
 ORDER BY T.FROM_DT_WID
   FOR UPDATE;
--RMS库存
SELECT *
  FROM RMS.ITEM_LOC_SOH@ra_rms_dblink T
 WHERE T.ITEM = 800162886
   AND T.LOC = 120115;
SELECT *
  FROM RMSHIST.ITEM_LOC_SOH_HIST@ra_rms_dblink T
 WHERE T.ITEM = 800162886
   AND T.LOC = 120115;
--item    loc
1 273441 247 2 274461 204 3 347966 4019

--订单差异核查-----------------------------------------------------------------------------------------
SELECT * FROM RADM.JIN_RMS_RA_SUPPCM_DIFF T ORDER BY T.ORDER_NO;

SELECT *
  FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T
 WHERE T.PURCHASE_ORDER_ID IN ('3351638', '3366011')
   AND EXISTS (SELECT 1
          FROM RADM.W_PRODUCT_D P
         WHERE T.PROD_WID = P.ROW_WID
           AND P.PROD_NUM = '101655217')
   FOR UPDATE;

SELECT T.PROD_NUM,T.ROW_WID FROM RADM.W_PRODUCT_D T WHERE T.PROD_NUM IN ('800412810', '800223816');
SELECT *
  FROM RABATCHER.W_PRODUCT_D_RTL_TMP T
 WHERE T.PROD_IT_NUM = '100578782';
SELECT * FROM RADM.W_PRODUCT_D_TL T WHERE T.INTEGRATION_ID = '100578782';
SELECT * FROM RADM.W_PRODUCT_D T WHERE T.ROW_WID = 1801027;

--RMS
SELECT * FROM RMS.ORDHEAD@RA_RMS_DBLINK T WHERE T.ORDER_NO = '3263906';
SELECT * FROM RMS.CMX_ORDHEAD@RA_RMS_DBLINK T WHERE T.ORDER_NO = '3263906';
SELECT *
  FROM RMS.ORDLOC@RA_RMS_DBLINK T
 WHERE T.ORDER_NO = '3263906'
   AND T.ITEM IN ('800412810', '800223816');
SELECT * FROM RMS.SHIPMENT@RA_RMS_DBLINK T WHERE T.ORDER_NO = '3263906';
SELECT *
  FROM RMS.SHIPSKU@RA_RMS_DBLINK T
 WHERE T.SHIPMENT IN ('3250290',
                      '3257427',
                      '3274249',
                      '3287542',
                      '3288175',
                      '3294346',
                      '3309049',
                      '3319430',
                      '3321087',
                      '3331615')
   AND T.ITEM IN (\*'800412810',*\ '800223816');
SELECT \*+PARALLEL(T,20)*\
 *
  FROM RMS.TRAN_DATA_HISTORY@RA_RMS_DBLINK T
 WHERE T.REF_NO_2 = '2529755';
--RA
SELECT * FROM RADM.JIN_RMS_RA_SUPPCM_DIFF T ORDER BY T.ORDER_NO;
SELECT *
  FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T
 WHERE T.PURCHASE_ORDER_ID = '3263906'
   AND T.PROD_WID IN( 320306)

   FOR UPDATE;
SELECT *
  FROM RADM.W_RTL_SUPPCM_IT_LC_DY_MV T
 WHERE T.PURCHASE_ORDER_ID = '3263906'
   AND T.PROD_WID = 320306;
--DELETE TABLE_CHECK_DIMENSION WHERE RUNDATE = DATE'2013-12-08';
--DELETE TABLE_CHECK_FACT WHERE RUN_DATE = DATE'2013-12-19';

begin
  -- Call the procedure
  check_dimension;
end;

begin
  -- Call the procedure
  check_fact;
end;

--W_RTL_PRICE_IT_LC_DY_FS 不一致
SELECT *
  FROM W_RTL_PRICE_IT_LC_DY_FS FS
 WHERE NOT EXISTS
 (SELECT 1
          FROM W_RTL_PRICE_IT_LC_DY_F F
         WHERE FS.PROD_IT_NUM = SUBSTR(F.INTEGRATION_ID, 1, 9)
           AND FS.ORG_NUM = SUBSTR(F.INTEGRATION_ID, 11, 6)
           AND F.FROM_DT_WID =
               '1' || TO_CHAR(SYSDATE - 1, 'YYYYMMDD') || '000');

--手工插入W_RTL_SUPPCM_IT_LC_DY_F-------------------------------------------------------------------
--org
SELECT * FROM RADM.W_INT_ORG_D T WHERE T.ORG_NUM = '120195';
SELECT *
  FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T
 WHERE T.ORG_WID = 40002
 ORDER BY T.DT_WID DESC;
--PROD
SELECT * FROM RADM.W_PRODUCT_D T WHERE T.PROD_NUM = '100578782';
--SUPPLIER
SELECT * FROM RADM.W_PARTY_ORG_D T WHERE T.Supplier_Num = '12003009'; --200126
--bbg_item_loc_wid
SELECT *
  FROM RADM.BBG_RA_ITEM_LOC_D T
 WHERE T.ITEM = '100578782'
   AND T.LOC = '120195';
--BBG_ITEM_LOC_SUPP_WID
SELECT *
  FROM RADM.BBG_RA_ITEM_LOC_SUPP_D T
 WHERE T.ITEM = '100578782'
   AND T.LOC = '120195'
   AND T.SUPPLIER = '12003009';
INSERT INTO RADM.W_RTL_SUPPCM_IT_LC_DY_F
VALUES
  (w_rtl_suppcm_it_lc_dy_f_seq.nextval,
   40002,
   40001,
   1116,
   2064029,
   952245,
   120141006000,
   200126,
   2885296,
   2882715,
   24,
   24,
   null,
   0,
   1,
   0,
   0,
   0,
   1,
   0,
   0,
   5,
   0,
   0,
   0,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   sysdate,
   sysdate,
   1,
   100,
   '100578782~120195~04-OCT-14~2885296~2882715',
   null,
   null,
   53280190,
   30059907,
   date '2014-10-06',
   date '2014-10-04',
   date '2014-09-27',
   null,
   null,
   129.2304,
   129.2304,
   null,
   null,
   null,
   null,
   null,
   null,
   null,
   null);

--供应商销售差异处理
SELECT *
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS T
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F S
         WHERE T.INTEGRATION_ID = S.INTEGRATION_ID);
--供应商资料在RA中不存在
SELECT *
  FROM BBG_RA_SUPP_SLS_JL_V@RA_JL S
 WHERE S.DAY_DT = TRUNC(SYSDATE - 1)
   AND NOT EXISTS (SELECT 1
          FROM RADM.W_PARTY_ORG_D P
         WHERE S.SUPPLIER_NUM = P.SUPPLIER_NUM);
*/
