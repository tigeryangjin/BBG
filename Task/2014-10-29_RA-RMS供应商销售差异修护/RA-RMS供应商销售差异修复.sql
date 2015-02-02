--******************************************************************************************
--******************************************************************************************
--RA跟踪语句
--******************************************************************************************
--******************************************************************************************
--
SELECT SLS.C4,
       SLS.C2 SLS_NOTAX_AMT,
       SUPPSLS.C1 SUPP_SLS_NOTAX_AMT,
       SLS.C2 - SUPPSLS.C1 AMT_DIFF
  FROM (SELECT D1.c2 AS c2, D1.c3 AS c3, D1.c4 AS c4
          FROM (SELECT SUM(NVL(T961218.SLS_AMT_LCL, 0) -
                           NVL(T961218.RET_AMT_LCL, 0)) -
                       (SUM(NVL(T961218.SLS_TAX_AMT_LCL, 0) -
                            NVL(T961218.RET_TAX_AMT_LCL, 0))) AS c2,
                       TRUNC(T960506.MCAL_DAY_DT) AS c3,
                       T960506.ROW_WID AS c4,
                       ROW_NUMBER() OVER(PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) AS c5
                  FROM W_INT_ORG_ATTR_D  T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */,
                       W_INT_ORG_D       T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                       W_MCAL_DAY_DV     T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                       W_RTL_SLS_LC_DY_A T961218 /* Fact_W_RTL_SLS_LC_DY_A */
                 WHERE (T957687.SCD1_WID = T964463.SCD1_WID AND
                       T957687.ORG_ATTR23_NAME = '1' AND
                       T960506.ROW_WID = T961218.DT_WID AND
                       T960506.MCAL_CAL_WID = 1.0 AND
                       T961218.ORG_SCD1_WID = T964463.SCD1_WID AND
                       '2010' < T960506.CAL_YEAR AND
                       TRUNC(T960506.MCAL_DAY_DT) BETWEEN
                       TO_DATE('2014-01-01', 'YYYY-MM-DD') AND
                       TO_DATE('2014-05-30', 'YYYY-MM-DD'))
                 GROUP BY T960506.ROW_WID, TRUNC(T960506.MCAL_DAY_DT)) D1
         WHERE (D1.c5 = 1)) SLS,
       (SELECT D1.c1 AS c1, D1.c2 AS c2, D1.c3 AS c3
          FROM (SELECT SUM(T1014905.SUPP_SALES_AMT) AS c1,
                       TRUNC(T960506.MCAL_DAY_DT) AS c2,
                       T960506.ROW_WID AS c3,
                       ROW_NUMBER() OVER(PARTITION BY T960506.ROW_WID ORDER BY T960506.ROW_WID ASC) AS c4
                  FROM W_INT_ORG_ATTR_D   T957687 /* Dim_W_INT_ORG_ATTR_D_Retail */,
                       W_INT_ORG_D        T964463 /* Dim_W_INT_ORG_D_Retail_As_Was */,
                       W_MCAL_DAY_DV      T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */,
                       BBG_RA_SLS_LC_DY_A T1014905 /* Fact_BBG_RA_SLS_LC_DY_A */
                 WHERE (T957687.SCD1_WID = T964463.SCD1_WID AND
                       T957687.ORG_ATTR23_NAME = '1' AND
                       T960506.ROW_WID = T1014905.DT_WID AND
                       T960506.MCAL_CAL_WID = 1.0 AND
                       T964463.ROW_WID = T1014905.ORG_WID AND
                       '2010' < T960506.CAL_YEAR AND
                       TRUNC(T960506.MCAL_DAY_DT) BETWEEN
                       TO_DATE('2014-01-01', 'YYYY-MM-DD') AND
                       TO_DATE('2014-05-30', 'YYYY-MM-DD'))
                 GROUP BY T960506.ROW_WID, TRUNC(T960506.MCAL_DAY_DT)) D1
         WHERE (D1.c4 = 1)) SUPPSLS
 WHERE SLS.C4 = SUPPSLS.C3(+)
 ORDER BY SLS.C4;
--*******************************************************************************
--单品差异  W_RTL_SLS_IT_LC_DY_A   vs   BBG_RA_SLS_IT_LC_DY_A 
--*******************************************************************************
SELECT /*+PARALLEL(T1,20) PARALLEL(T2,20)*/
 T1.ITEM,
 T1.LOC,
 T1.DT_WID,
 T1.SLS_NOTAX_AMT,
 T2.SUPP_NOTAX_SALES_AMT,
 ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) NOTAX_AMT_DIFF
  FROM (SELECT /*+PARALLEL(T3,20)*/
         T3.ITEM,
         T3.LOC,
         T3.DT_WID,
         SUM(T3.SLS_QTY) SLS_QTY,
         SUM(SLS_AMT) SLS_AMT,
         SUM(SLS_NOTAX_AMT) SLS_NOTAX_AMT
          FROM (SELECT /*+PARALLEL(W,20) PARALLEL(O,20) PARALLEL(P,20) PARALLEL(PK,20) PARALLEL(PK2,20)*/
                 CASE
                   WHEN PK.ITEM IS NULL THEN
                    P.PROD_IT_NUM
                   ELSE
                    PK.ITEM
                 END ITEM,
                 O.ORG_NUM LOC,
                 W.DT_WID,
                 SUM((NVL(W.SLS_QTY, 0) - NVL(W.RET_QTY, 0)) *
                     NVL(PK.PACK_QTY, 1)) SLS_QTY,
                 SUM((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_AMT,
                 SUM(((NVL(W.SLS_AMT_LCL, 0) - NVL(W.RET_AMT_LCL, 0)) -
                     (NVL(W.SLS_TAX_AMT_LCL, 0) - NVL(W.RET_TAX_AMT_LCL, 0))) /
                     NVL(PK2.PACK_QTY, 1) * NVL(PK.PACK_QTY, 1)) SLS_NOTAX_AMT
                  FROM RADM.W_RTL_SLS_IT_LC_DY_A W,
                       RABATCHER.W_INT_ORG_D_RTL_TMP O,
                       RABATCHER.W_PRODUCT_D_RTL_TMP P,
                       RADM.PACKITEM PK,
                       (SELECT /*+PARALLEL(PK1,20)*/
                         PACK_NO, SUM(PK1.PACK_QTY) PACK_QTY
                          FROM PACKITEM PK1
                         GROUP BY PACK_NO) PK2
                 WHERE W.PROD_WID = P.PROD_IT_WID
                   AND W.ORG_WID = O.ORG_WID
                   AND W.DT_WID = 120140126000
                   AND PK.PACK_NO(+) = P.PROD_IT_NUM
                      /*AND P.PROD_IT_NUM IN ('100075536', '800207722', '100844024')*/
                   AND PK2.PACK_NO(+) = PK.PACK_NO
                 GROUP BY P.PROD_IT_NUM, O.ORG_NUM, W.DT_WID, PK.ITEM) T3
         GROUP BY T3.ITEM, T3.LOC, T3.DT_WID) T1,
       (SELECT /*+PARALLEL(B,20) PARALLEL(O,20) PARALLEL(P,20)*/
         P.PROD_IT_NUM ITEM,
         O.ORG_NUM LOC,
         B.DT_WID,
         SUM(B.SUPP_SALES_QTY) SUPP_SALES_QTY,
         SUM(B.SUPP_SALES_AMT) SUPP_NOTAX_SALES_AMT
          FROM RADM.BBG_RA_SLS_IT_LC_DY_A    B,
               RABATCHER.W_INT_ORG_D_RTL_TMP O,
               RABATCHER.W_PRODUCT_D_RTL_TMP P
         WHERE B.PROD_WID = P.PROD_IT_WID
           AND B.ORG_WID = O.ORG_WID
           AND B.DT_WID = 120140126000
         GROUP BY P.PROD_IT_NUM, O.ORG_NUM, B.DT_WID) T2
 WHERE T1.ITEM = T2.ITEM(+)
   AND T1.LOC = T2.LOC(+)
   AND T1.DT_WID = T2.DT_WID(+)
   AND ABS(NVL(T1.SLS_NOTAX_AMT, 0) - NVL(T2.SUPP_NOTAX_SALES_AMT, 0)) > 0.1;

--RMS
SELECT *
  FROM CMX_SUPP_SALES T
 WHERE T.ORIGIN_SALES_DATE = DATE '2014-02-23'
   AND T.ITEM = 800020218
   AND T.STORE = 120199;
SELECT *
  FROM TRAN_DATA_HISTORY T
 WHERE T.TRAN_DATE = DATE '2014-02-23'
   AND T.ITEM = 800020218
   AND T.LOCATION = 120199
   AND T.TRAN_CODE IN (1, 3);
SELECT *
  FROM RA_RMS.BBG_XTERN_RDWT_HIST T
 WHERE T.BUSINESS_DT = '20140223'
   AND T.ITEM = 800020218
   AND T.LOCATION = '0000120199';

--RA
SELECT * FROM RABATCHER.W_INT_ORG_D_RTL_TMP T WHERE T.ORG_NUM = '120199';
SELECT *
  FROM RABATCHER.W_PRODUCT_D_RTL_TMP T
 WHERE T.PROD_IT_NUM = '800020218';

SELECT SUM((T.SLS_AMT_LCL - T.RET_AMT_LCL) -
           (T.SLS_TAX_AMT_LCL - T.RET_TAX_AMT_LCL)) sls_notax_amt
  FROM RADM.W_RTL_SLS_IT_LC_DY_A T
 WHERE T.PROD_WID = 271413
   AND T.ORG_WID = 60001
   AND T.DT_WID = 120140223000;

SELECT *
  FROM RADM.W_RTL_SLS_IT_LC_DY_A T
 WHERE T.PROD_WID = 271413
   AND T.ORG_WID = 60001
   AND T.DT_WID = 120140223000;

SELECT *
  FROM RADM.BBG_RA_SLS_IT_LC_DY_A T
 WHERE T.PROD_WID = 271413
   AND T.ORG_WID = 60001
   AND T.DT_WID = 120140223000;

--******************************************************************************************
--******************************************************************************************
--供应商销售表增加了经营属性后,RA和RMS有差异的数据修复
--******************************************************************************************
--******************************************************************************************

--1.差异清单
--临时表JIN_RA_SUPP_SALES_TMP
CREATE TABLE RADM.JIN_RA_SUPP_SALES_TMP AS
  SELECT /*+PARALLEL(T,20)*/
   TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
   SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
   SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
   SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
    FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
   WHERE T.DT_WID BETWEEN 120130101000 AND 120141111000
   GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')
   ORDER BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD');

DROP TABLE RADM.JIN_RA_SUPP_SALES_TMP;

--临时表JIN_RMS_SUPP_SALES_TMP
CREATE TABLE RMS.JIN_RMS_SUPP_SALES_TMP AS
  SELECT /*+PARALLEL(BBG_RA_SUPP_SALES_FV,20)*/
   BBG_RA_SUPP_SALES_FV.DAY_DT,
   BBG_RA_SUPP_SALES_FV.LOC,
   SUM(BBG_RA_SUPP_SALES_FV.SALES_QTY) SUPP_SALES_QTY,
   --供应商净销售成本
   SUM(CASE
         WHEN BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'LY' OR
              BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'ZL' THEN
          BBG_RA_SUPP_SALES_FV.SALES_COST /
          (1 + BBG_RA_SUPP_SALES_FV.COST_VAT_RATE / 100)
         ELSE
          BBG_RA_SUPP_SALES_FV.SALES_COST
       END) SUPP_SALES_COST,
   --供应商净销售金额
   SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT /
       (1 + (select VAT_RATE / 100
               from VAT_ITEM
              where ACTIVE_DATE =
                    (select max(v.ACTIVE_DATE)
                       from VAT_ITEM v
                      where v.ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                        and v.VAT_REGION = 1000
                        AND V.VAT_TYPE IN ('R', 'B')
                        and v.ACTIVE_DATE <= BBG_RA_SUPP_SALES_FV.DAY_DT)
                and ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                and VAT_REGION = 1000
                and VAT_TYPE IN ('R', 'B')))) SUPP_SALES_AMT,
								SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT) BBG_REFERENCE_FO1
    FROM (SELECT /*+PARALLEL(CSS,20)*/
           CSS.ORIGIN_SALES_DATE DAY_DT,
           CSS.ITEM,
           CSS.STORE LOC,
           CSS.SUPPLIER,
           CSS.QTY SALES_QTY,
           CSS.TOTAL_COST SALES_COST,
           CSS.TOTAL_RETAIL SALES_AMT,
           (SELECT SUPP.BUSINESS_TYPE
              FROM RMS.CMX_SUPPLIER_INFO SUPP
             WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BUSINESS_MODE,
           CSS.COST_VAT_RATE,
           (SELECT SUPP.BUSINESS_TYPE
              FROM RMS.CMX_SUPPLIER_INFO SUPP
             WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BBG_REFERENCE_DO1,
           '' BBG_REFERENCE_DO2,
           '' BBG_REFERENCE_DO3,
           '' BBG_REFERENCE_DO4,
           '' BBG_REFERENCE_DO5,
           NULL BBG_REFERENCE_FO1,
           NULL BBG_REFERENCE_FO2,
           NULL BBG_REFERENCE_FO3,
           NULL BBG_REFERENCE_FO4,
           NULL BBG_REFERENCE_FO5,
           NULL BBG_REFERENCE_FO6,
           NULL BBG_REFERENCE_FO7,
           NULL BBG_REFERENCE_FO8,
           NULL BBG_REFERENCE_FO9,
           NULL BBG_REFERENCE_FO10
            FROM RMS.CMX_SUPP_SALES CSS) BBG_RA_SUPP_SALES_FV
   /*WHERE BBG_RA_SUPP_SALES_FV.DAY_DT BETWEEN DATE '2013-01-01' AND DATE
   '2014-12-20'*/
  --AND FV.LOC <> '118001'
   GROUP BY BBG_RA_SUPP_SALES_FV.DAY_DT, BBG_RA_SUPP_SALES_FV.LOC
   ORDER BY BBG_RA_SUPP_SALES_FV.DAY_DT, BBG_RA_SUPP_SALES_FV.LOC;

CREATE TABLE RADM.JIN_RMS_SUPP_SALES_TMP AS
  SELECT * FROM RMS.JIN_RMS_SUPP_SALES_TMP@RA_RMS_DBLINK;

DROP TABLE RMS.JIN_RMS_SUPP_SALES_TMP;

DROP TABLE RADM.JIN_RMS_SUPP_SALES_TMP;

--删除临时表
DROP TABLE RADM.JIN_RMS_SUPP_SALES_TMP;
DROP TABLE RADM.JIN_RA_SUPP_SALES_TMP;

--ra-rms按天销售差异
SELECT /*+PARALLEL(T1,20) PARALLEL(T2,20)*/
 T2.DAY_DT,
 T2.SUPP_SALES_QTY RMS_SSQ,
 T1.SUPP_SALES_QTY RA_SSQ,
 T2.SUPP_SALES_QTY - T1.SUPP_SALES_QTY DIFF_SSQ,
 T2.SUPP_SALES_AMT RMS_SSA,
 T1.SUPP_SALES_AMT RA_SSA,
 ROUND(T2.SUPP_SALES_AMT - T1.SUPP_SALES_AMT, 4) DIFF_SSA,
 T2.SUPP_SALES_COST RMS_SSC,
 T1.SUPP_SALES_COST RA_SSC,
 ROUND(T2.SUPP_SALES_COST - T1.SUPP_SALES_COST, 4) DIFF_SSC
  FROM (SELECT /*+PARALLEL(T,20)*/
         TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
         SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
         SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
         SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
          FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
         WHERE T.DT_WID BETWEEN 120130101000 AND 120141111000
         GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')
         ORDER BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) T1,
       (SELECT /*+PARALLEL(T3,20)*/
         T3.DAY_DT,
         SUM(T3.SUPP_SALES_QTY) SUPP_SALES_QTY,
         SUM(T3.SUPP_SALES_AMT) SUPP_SALES_AMT,
         SUM(T3.SUPP_SALES_COST) SUPP_SALES_COST
          FROM RADM.JIN_RMS_SUPP_SALES_TMP T3
         GROUP BY T3.DAY_DT) T2
 WHERE T1.DAY_DT(+) = T2.DAY_DT
   AND T2.DAY_DT BETWEEN DATE '2013-01-01' AND DATE '2013-12-31'
 ORDER BY T2.DAY_DT;

--2.供应商销售表清单
/*
16张表
BBG_RA_SUPP_SALES_IT_LC_DY_F
BBG_RA_SLS_SC_LC_DY_CUR_A
BBG_RA_SLS_SC_LC_DY_A
BBG_RA_SLS_SC_DY_CUR_A
BBG_RA_SLS_SC_DY_A
BBG_RA_SLS_LC_DY_A
BBG_RA_SLS_IT_LC_DY_SN_A
BBG_RA_SLS_IT_LC_DY_A
BBG_RA_SLS_IT_DY_SN_A
BBG_RA_SLS_IT_DY_A
BBG_RA_SLS_DP_LC_DY_CUR_A
BBG_RA_SLS_DP_LC_DY_A
BBG_RA_SLS_DP_DY_CUR_A
BBG_RA_SLS_CL_LC_DY_CUR_A
BBG_RA_SLS_CL_LC_DY_A
BBG_RA_SLS_CL_DY_CUR_A
*/

--3.修复

--3.1删除RA的供应商销售数据----------------------------------------------------
--存储过程: jin_update_month
/*begin
  -- Call the procedure
  bbg_ra_del_supp_sls_dt(dtwid => '120130829000');
end;*/

--3.2修改源视图的日期条件----------------------------------------------------
SELECT DISTINCT T.DAY_DT
  FROM RMS.BBG_RA_SUPP_SALES_FIX_FV T
 ORDER BY T.DAY_DT;

--3.3清除ODI日志----------------------------------------------------
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--3.4修改维度的日期----------------------------------------------------
--地点维度
UPDATE RABATCHER.W_INT_ORG_DH_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2012-01-01'
 WHERE /*T.ORG_NUM IN (130024, 120066, 120157, 120161, 120163,120192)
   AND*/
 EXISTS (SELECT O.ORG_NUM, O.EFFECTIVE_FROM_DT
    FROM (SELECT A.ORG_NUM, MIN(A.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
            FROM RABATCHER.W_INT_ORG_DH_RTL_TMP A
           GROUP BY A.ORG_NUM) O
   WHERE T.ORG_NUM = O.ORG_NUM
     AND T.EFFECTIVE_FROM_DT = O.EFFECTIVE_FROM_DT);
COMMIT;

UPDATE RABATCHER.W_INT_ORG_D_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2012-01-01';
COMMIT;

--商品维度           
UPDATE RABATCHER.W_PRODUCT_D_RTL_TMP T
   SET T.SRC_EFF_FROM_DT = DATE '2012-01-01'
 WHERE EXISTS
 (SELECT O.PROD_IT_NUM, O.SRC_EFF_FROM_DT
          FROM (SELECT A.PROD_IT_NUM, MIN(A.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT
                  FROM RABATCHER.W_PRODUCT_D_RTL_TMP A
                 GROUP BY A.PROD_IT_NUM) O
         WHERE T.PROD_IT_NUM = O.PROD_IT_NUM
           AND T.SRC_EFF_FROM_DT = O.SRC_EFF_FROM_DT);
COMMIT;

--3.5 SDE: BBG_SDE_BBG_RA_SUPP_SALES_IT_LC_DY_FIX_F----------------------------------------------------
--3.6检查FACT STAGE
SELECT DISTINCT T.DAY_DT
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS T
 ORDER BY T.DAY_DT;

--3.7 SIL: BBG_SIL_BBG_RA_SUPP_SALES_IT_LC_DY_F

--3.8检查FACT STAGE TMP
SELECT * FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T;

--检查差异
SELECT SUPPSLS.DAY_DT,
       SUPPSLS.LOC,
       SUPPSLS.RMS_SSQ,
       SUPPSLS.FS_SSQ,
       SUPPSLS.DIF1_SSQ,
       SUPPSLS.TMP_SSQ,
       SUPPSLS.DIF2_SSQ,
       SUPPSLS.RMS_SSC,
       SUPPSLS.FS_SSC,
       SUPPSLS.DIF1_SSC,
       SUPPSLS.TMP_SSC,
       SUPPSLS.DIF2_SSC,
       SUPPSLS.RMS_SSA,
       SUPPSLS.FS_SSA,
       SUPPSLS.DIF1_SSA,
       SUPPSLS.TMP_SSA,
       SUPPSLS.DIF2_SSA,
       SUM((SLS.SLS_AMT_LCL - SLS.RET_AMT_LCL) -
           (SLS.SLS_TAX_AMT_LCL - SLS.RET_TAX_AMT_LCL)) SLSAMT,
       SUM((SLS.SLS_AMT_LCL - SLS.RET_AMT_LCL) -
           (SLS.SLS_TAX_AMT_LCL - SLS.RET_TAX_AMT_LCL)) - SUPPSLS.RMS_SSA DIF3_SSA
  FROM (SELECT RMS.DAY_DT,
               RMS.LOC,
               RMS.SUPP_SALES_QTY RMS_SSQ,
               FS.SUPP_SALES_QTY FS_SSQ,
               ROUND(RMS.SUPP_SALES_QTY - FS.SUPP_SALES_QTY, 4) DIF1_SSQ,
               TMP.SUPP_SALES_QTY TMP_SSQ,
               ROUND(RMS.SUPP_SALES_QTY - TMP.SUPP_SALES_QTY, 4) DIF2_SSQ,
               RMS.SUPP_SALES_COST RMS_SSC,
               FS.SUPP_SALES_COST FS_SSC,
               ROUND(RMS.SUPP_SALES_COST - FS.SUPP_SALES_COST, 4) DIF1_SSC,
               TMP.SUPP_SALES_COST TMP_SSC,
               ROUND(RMS.SUPP_SALES_COST - TMP.SUPP_SALES_COST, 4) DIF2_SSC,
               RMS.SUPP_SALES_AMT RMS_SSA,
               FS.SUPP_SALES_AMT FS_SSA,
               ROUND(RMS.SUPP_SALES_AMT - FS.SUPP_SALES_AMT, 4) DIF1_SSA,
               TMP.SUPP_SALES_AMT TMP_SSA,
               ROUND(RMS.SUPP_SALES_AMT - TMP.SUPP_SALES_AMT, 4) DIF2_SSA
          FROM RADM.JIN_RMS_SUPP_SALES_TMP RMS,
               (SELECT /*+PARALLEL(T,20)*/
                 T.DAY_DT,
                 T.ORG_NUM,
                 SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
                 SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
                 SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
                  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS T
                --WHERE T.ORG_NUM<>'118001'
                 GROUP BY T.DAY_DT, T.ORG_NUM) FS,
               (SELECT /*+PARALLEL(T,20)*/
                 T.DAY_DT,
                 T.ORG_NUM,
                 SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
                 SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
                 SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
                  FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T
                --WHERE T.ORG_NUM <>'118001'
                 GROUP BY T.DAY_DT, T.ORG_NUM) TMP
         WHERE RMS.DAY_DT = TMP.DAY_DT
           AND RMS.DAY_DT = FS.DAY_DT
           AND RMS.LOC = TMP.ORG_NUM
           AND RMS.LOC = FS.ORG_NUM
         ORDER BY RMS.DAY_DT) SUPPSLS,
       RADM.W_RTL_SLS_LC_DY_A SLS
 WHERE '1' || TO_CHAR(SUPPSLS.DAY_DT, 'YYYYMMDD') || '000' = SLS.DT_WID(+)
   AND SUPPSLS.LOC = SUBSTR(SLS.INTEGRATION_ID(+), 1, 6)
 GROUP BY SUPPSLS.DAY_DT,
          SUPPSLS.LOC,
          SUPPSLS.RMS_SSQ,
          SUPPSLS.FS_SSQ,
          SUPPSLS.DIF1_SSQ,
          SUPPSLS.TMP_SSQ,
          SUPPSLS.DIF2_SSQ,
          SUPPSLS.RMS_SSC,
          SUPPSLS.FS_SSC,
          SUPPSLS.DIF1_SSC,
          SUPPSLS.TMP_SSC,
          SUPPSLS.DIF2_SSC,
          SUPPSLS.RMS_SSA,
          SUPPSLS.FS_SSA,
          SUPPSLS.DIF1_SSA,
          SUPPSLS.TMP_SSA,
          SUPPSLS.DIF2_SSA
 ORDER BY SUPPSLS.DAY_DT, SUPPSLS.LOC;

SELECT * FROM RADM.W_RTL_SLS_LC_DY_A;
SELECT DISTINCT SUBSTR(T.INTEGRATION_ID, 1, 6)
  FROM RADM.W_RTL_SLS_LC_DY_A T;
--差异结果查询
SELECT /*+PARALLEL(F,20)*/
DISTINCT F.DAY_DT, F.PROD_IT_NUM, F.ORG_NUM, F.SUPPLIER_NUM /*,
       SUM(F.SUPP_SALES_QTY),
       SUM(F.SUPP_SALES_COST),
       SUM(F.SUPP_SALES_AMT)*/
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS F
 WHERE NOT EXISTS (SELECT /*+PARALLEL(T,20)*/
         1
          FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T
         WHERE T.DAY_DT = F.DAY_DT
           AND T.SUPPLIER_NUM = F.SUPPLIER_NUM
           AND T.ORG_NUM = F.ORG_NUM
           AND T.PROD_IT_NUM = F.PROD_IT_NUM)
 GROUP BY F.DAY_DT, F.PROD_IT_NUM, F.ORG_NUM, F.SUPPLIER_NUM
 ORDER BY F.ORG_NUM, F.SUPPLIER_NUM, F.PROD_IT_NUM;

SELECT *
  FROM (select T.PROD_IT_NUM,
               T.ORG_NUM,
               T.SUPPLIER_NUM,
               SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
               SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
               SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT,
               SUM(T.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1
          from BBG_RA_SLS_IT_LC_DY_FS t
         GROUP BY T.PROD_IT_NUM, T.ORG_NUM, T.SUPPLIER_NUM) F,
       (SELECT T.PROD_IT_NUM,
               T.ORG_NUM,
               T.SUPPLIER_NUM,
               SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
               SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
               SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT,
               SUM(T.BBG_REFERENCE_FO1) BBG_REFERENCE_FO1
          FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T
         GROUP BY T.PROD_IT_NUM, T.ORG_NUM, T.SUPPLIER_NUM) T
 WHERE F.PROD_IT_NUM = T.PROD_IT_NUM
   AND F.ORG_NUM = T.ORG_NUM
   AND F.SUPPLIER_NUM = T.SUPPLIER_NUM
   AND F.SUPP_SALES_QTY <> T.SUPP_SALES_QTY;

--3.9 UC4: BBG.CMX.RA.F20_SUPP_SALES

--******************************************************************************************
--******************************************************************************************
--供应商销售RA-RMS核对机制建立
--******************************************************************************************
--******************************************************************************************
--RMS数据源
SELECT * FROM RMS.BBG_RA_SUPP_SALES_FV@RA_RMS_DBLINK T;
--RA
SELECT * FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T;

--RMS创建视图BBG_RA_SUPP_SALES_CHECK_FV
CREATE VIEW RMS.BBG_RA_SUPP_SALES_CHECK_FV AS
  SELECT /*+PARALLEL(BBG_RA_SUPP_SALES_FV,20)*/
   BBG_RA_SUPP_SALES_FV.DAY_DT,
   SUM(BBG_RA_SUPP_SALES_FV.SALES_QTY) SUPP_SALES_QTY,
   --供应商净销售成本
   SUM(CASE
         WHEN BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'LY' OR
              BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'ZL' THEN
          BBG_RA_SUPP_SALES_FV.SALES_COST /
          (1 + BBG_RA_SUPP_SALES_FV.COST_VAT_RATE / 100)
         ELSE
          BBG_RA_SUPP_SALES_FV.SALES_COST
       END) SUPP_SALES_COST,
   --供应商净销售金额
   SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT /
       (1 + (select VAT_RATE / 100
               from VAT_ITEM
              where ACTIVE_DATE =
                    (select max(v.ACTIVE_DATE)
                       from VAT_ITEM v
                      where v.ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                        and v.VAT_REGION = 1000
                        AND V.VAT_TYPE IN ('R', 'B')
                        and v.ACTIVE_DATE <= BBG_RA_SUPP_SALES_FV.DAY_DT)
                and ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                and VAT_REGION = 1000
                and VAT_TYPE IN ('R', 'B')))) SUPP_SALES_AMT
    FROM RMS.BBG_RA_SUPP_SALES_FV BBG_RA_SUPP_SALES_FV
   GROUP BY BBG_RA_SUPP_SALES_FV.DAY_DT;

--RADM创建核对结果表
CREATE TABLE RADM.JIN_RMS_RA_SUPP_SLS_CHECK AS
  SELECT RMS.DAY_DT,
         RMS.SUPP_SALES_QTY RMS_SSQ,
         RA.SUPP_SALES_QTY RA_SSQ,
         ROUND(RMS.SUPP_SALES_QTY - RA.SUPP_SALES_QTY, 4) QTY_DIFF,
         RMS.SUPP_SALES_COST RMS_SSC,
         RA.SUPP_SALES_COST RA_SSC,
         ROUND(RMS.SUPP_SALES_COST - RA.SUPP_SALES_COST, 4) COST_DIFF,
         RMS.SUPP_SALES_AMT RMS_SSA,
         RA.SUPP_SALES_AMT RA_SSA,
         ROUND(RMS.SUPP_SALES_AMT - RA.SUPP_SALES_AMT, 4) AMT_DIFF
    FROM RMS.BBG_RA_SUPP_SALES_CHECK_FV@RA_RMS_DBLINK RMS,
         (SELECT /*+PARALLEL(v,20)*/
           TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
           SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
           SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
           SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
            FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
           WHERE T.DT_WID = '1' || TO_CHAR(SYSDATE - 1, 'YYYYMMDD') || '000'
           GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) RA
   WHERE RMS.DAY_DT = RA.DAY_DT;

SELECT * FROM RADM.JIN_RMS_RA_SUPP_SLS_CHECK;

--每日销售merge进核对表
MERGE /*+APPEND*/
INTO RADM.JIN_RMS_RA_SUPP_SLS_CHECK T
USING (SELECT RMS.DAY_DT,
              RMS.SUPP_SALES_QTY RMS_SSQ,
              RA.SUPP_SALES_QTY RA_SSQ,
              ROUND(RMS.SUPP_SALES_QTY - RA.SUPP_SALES_QTY, 4) QTY_DIFF,
              RMS.SUPP_SALES_COST RMS_SSC,
              RA.SUPP_SALES_COST RA_SSC,
              ROUND(RMS.SUPP_SALES_COST - RA.SUPP_SALES_COST, 4) COST_DIFF,
              RMS.SUPP_SALES_AMT RMS_SSA,
              RA.SUPP_SALES_AMT RA_SSA,
              ROUND(RMS.SUPP_SALES_AMT - RA.SUPP_SALES_AMT, 4) AMT_DIFF
         FROM RMS.BBG_RA_SUPP_SALES_CHECK_FV@RA_RMS_DBLINK RMS,
              (SELECT /*+PARALLEL(v,20)*/
                TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
                SUM(T.SUPP_SALES_QTY) SUPP_SALES_QTY,
                SUM(T.SUPP_SALES_COST) SUPP_SALES_COST,
                SUM(T.SUPP_SALES_AMT) SUPP_SALES_AMT
                 FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
                WHERE T.DT_WID =
                      '1' || TO_CHAR(SYSDATE - 1, 'YYYYMMDD') || '000'
                GROUP BY TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) RA
        WHERE RMS.DAY_DT = RA.DAY_DT) S
ON (T.DAY_DT = S.DAY_DT)
WHEN MATCHED THEN
  UPDATE
     SET T.RMS_SSQ   = S.RMS_SSQ,
         T.RA_SSQ    = S.RA_SSQ,
         T.QTY_DIFF  = S.QTY_DIFF,
         T.RMS_SSC   = S.RMS_SSC,
         T.RA_SSC    = S.RA_SSC,
         T.COST_DIFF = S.COST_DIFF,
         T.RMS_SSA   = S.RMS_SSA,
         T.RA_SSA    = S.RA_SSA,
         T.AMT_DIFF  = S.AMT_DIFF
WHEN NOT MATCHED THEN
  INSERT
    (T.DAY_DT,
     T.RMS_SSQ,
     T.RA_SSQ,
     T.QTY_DIFF,
     T.RMS_SSC,
     T.RA_SSC,
     T.COST_DIFF,
     T.RMS_SSA,
     T.RA_SSA,
     T.AMT_DIFF)
  VALUES
    (S.DAY_DT,
     S.RMS_SSQ,
     S.RA_SSQ,
     S.QTY_DIFF,
     S.RMS_SSC,
     S.RA_SSC,
     S.COST_DIFF,
     S.RMS_SSA,
     S.RA_SSA,
     S.AMT_DIFF);

--******************************************************************************************
--******************************************************************************************
--供应商销售税率处理
--******************************************************************************************
--******************************************************************************************
--1.修改维度的日期----------------------------------------------------
--地点维度
UPDATE RABATCHER.W_INT_ORG_DH_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2012-01-01'
 WHERE /*T.ORG_NUM IN (130024, 120066, 120157, 120161, 120163,120192)
   AND*/
 EXISTS (SELECT O.ORG_NUM, O.EFFECTIVE_FROM_DT
    FROM (SELECT A.ORG_NUM, MIN(A.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
            FROM RABATCHER.W_INT_ORG_DH_RTL_TMP A
           GROUP BY A.ORG_NUM) O
   WHERE T.ORG_NUM = O.ORG_NUM
     AND T.EFFECTIVE_FROM_DT = O.EFFECTIVE_FROM_DT);
COMMIT;

UPDATE RABATCHER.W_INT_ORG_D_RTL_TMP T
   SET T.EFFECTIVE_FROM_DT = DATE '2012-01-01';
COMMIT;

--商品维度           
UPDATE RABATCHER.W_PRODUCT_D_RTL_TMP T
   SET T.SRC_EFF_FROM_DT = DATE '2012-01-01'
 WHERE EXISTS
 (SELECT O.PROD_IT_NUM, O.SRC_EFF_FROM_DT
          FROM (SELECT A.PROD_IT_NUM, MIN(A.SRC_EFF_FROM_DT) SRC_EFF_FROM_DT
                  FROM RABATCHER.W_PRODUCT_D_RTL_TMP A
                 GROUP BY A.PROD_IT_NUM) O
         WHERE T.PROD_IT_NUM = O.PROD_IT_NUM
           AND T.SRC_EFF_FROM_DT = O.SRC_EFF_FROM_DT);
COMMIT;

--2.修改源视图的日期条件----------------------------------------------------
SELECT DISTINCT T.DAY_DT
  FROM RMS.BBG_RA_SUPP_SALES_FIX_FV T
 ORDER BY T.DAY_DT;

--3.清除ODI日志----------------------------------------------------
TRUNCATE TABLE RA_RMS.C_LOAD_DATES;
TRUNCATE TABLE RADM.C_LOAD_DATES;

--4.清除tmp临时表
BEGIN
  -- CALL THE PROCEDURE
  RADM.JIN_TRUNCATE_TMP_SUPP_SLS_T;
END;

--5. SDE: BBG_SDE_BBG_RA_SUPP_SALES_IT_LC_DY_FIX_F----------------------------------------------------
--6.检查FACT STAGE
SELECT DISTINCT T.DAY_DT
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS T
 ORDER BY T.DAY_DT;
--修改税率
UPDATE RADM.BBG_RA_SLS_IT_LC_DY_FS T
   SET T.SUPP_SALES_AMT = T.BBG_REFERENCE_FO1 /
                          (1 + (SELECT R.VAT_RATE / 100
                                  FROM RADM.JIN_ITEM_TAXRATE_TMP R
                                 WHERE R.DAY_DT = T.DAY_DT
                                   AND R.ITEM = T.PROD_IT_NUM))
 WHERE EXISTS (SELECT 1
          FROM RADM.JIN_ITEM_TAXRATE_TMP S
         WHERE T.DAY_DT = S.DAY_DT
           AND T.PROD_IT_NUM = S.ITEM);
COMMIT;

--7. SIL: BBG_SIL_BBG_RA_SUPP_SALES_IT_LC_DY_F

--8.检查FACT STAGE TMP
SELECT * FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T;

--9.检查差异
jin_pkg.p_ck_supp_sls_fix_result;

--SDE/SIL已经处理到2014-01-31,UC4从下面开始执行------------------------------------------
--10.供应商销售汇总表删除数据
DECLARE
  O_ERROR_MESSAGE VARCHAR(2000) := 'N';
  DTWID           NUMBER := 120140826000; --日期条件
BEGIN
  IF NOT JIN_PKG.F_DEL_RA_SUPPSLS_AGGREGATE_TAB(O_ERROR_MESSAGE, DTWID) THEN
    DBMS_OUTPUT.PUT_LINE('Y');
  END IF;
END;

--11.插入数据到BBG_RA_SUPP_SLS_IT_LC_DY_TMP表
DECLARE
  O_ERROR_MESSAGE VARCHAR(2000) := 'N';
  B_DTWID         NUMBER := &B_DTWID; --开始日期
  E_DTWID         NUMBER := &E_DTWID; --结束日期
BEGIN
  IF NOT JIN_PKG.F_INSERT_RA_SUPPSLS_ITLCDY_TMP(O_ERROR_MESSAGE,
                                                B_DTWID,
                                                E_DTWID) THEN
    DBMS_OUTPUT.PUT_LINE('Y');
  END IF;
END;

--12.核对数据
SELECT /*+PARALLEL(T,20)*/
 SUM(T.SUPP_SALES_QTY), SUM(T.SUPP_SALES_AMT), SUM(T.SUPP_SALES_COST)
  FROM RABATCHER.BBG_RA_SUPP_SLS_IT_LC_DY_TMP T;
SELECT /*+PARALLEL(T,20)*/
 SUM(T.SUPP_SALES_QTY), SUM(T.SUPP_SALES_AMT), SUM(T.SUPP_SALES_COST)
  FROM RADM.BBG_RA_SUPP_SALES_IT_LC_DY_F T
 WHERE T.DT_WID BETWEEN 120140821000 AND 120140825000;

--13.UC4:BBG.CMX.RA.F20_SUPP_SALES

--******************************************************************************************
--******************************************************************************************
--销售-供应商销售单品差异清单(CMX_SUPP_SALES---W_RTL_SLS_IT_LC_DY_A)
--******************************************************************************************
--******************************************************************************************
SELECT C.DAY_DT,
       C.ITEM,
       C.LOC,
       C.SUPP_SALES_AMT,
       C.SUPP_SALES_QTY,
       W.SLS_AMT,
       W.SLS_QTY,
       C.SUPP_SALES_AMT - W.SLS_AMT AMT_DIFF,
       C.SUPP_SALES_QTY - W.SLS_QTY QTY_DIFF,
       PI.PACK_QTY,
       ROUND(C.SUPP_NOTAX_SALES_AMT, 4) SUPP_NOTAX_SALES_AMT,
       W.SLS_NOTAX_AMT,
       ROUND(C.SUPP_NOTAX_SALES_AMT - W.SLS_NOTAX_AMT, 4) NOTAX_AMT_DIFF,
       S.SUPP_NOTAX_SALES_AMT,
       ROUND(W.SLS_NOTAX_AMT - S.SUPP_NOTAX_SALES_AMT, 4) FS_NOTAX_AMT_DIFF /*,
       C.SUPP_NOTAX_SALES_COST,
       W.SLS_NOTAX_COST,
       ROUND(C.SUPP_NOTAX_SALES_COST - W.SLS_NOTAX_COST, 4) NOTAX_COST_DIFF*/
  FROM (SELECT /*+PARALLEL(BBG_RA_SUPP_SALES_FV,20)*/
         BBG_RA_SUPP_SALES_FV.DAY_DT,
         BBG_RA_SUPP_SALES_FV.LOC,
         BBG_RA_SUPP_SALES_FV.ITEM,
         SUM(BBG_RA_SUPP_SALES_FV.SALES_QTY) SUPP_SALES_QTY,
         SUM(BBG_RA_SUPP_SALES_FV.SALES_COST) SUPP_SALES_COST,
         SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT) SUPP_SALES_AMT,
         --供应商净销售成本
         SUM(CASE
               WHEN BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'LY' OR
                    BBG_RA_SUPP_SALES_FV.BUSINESS_MODE = 'ZL' THEN
                BBG_RA_SUPP_SALES_FV.SALES_COST /
                (1 + BBG_RA_SUPP_SALES_FV.COST_VAT_RATE / 100)
               ELSE
                BBG_RA_SUPP_SALES_FV.SALES_COST
             END) SUPP_NOTAX_SALES_COST,
         --供应商净销售金额
         SUM(BBG_RA_SUPP_SALES_FV.SALES_AMT /
             (1 + (select VAT_RATE / 100
                     from VAT_ITEM@RA_RMS_DBLINK
                    where ACTIVE_DATE =
                          (select max(v.ACTIVE_DATE)
                             from VAT_ITEM@RA_RMS_DBLINK v
                            where v.ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                              and v.VAT_REGION = 1000
                              AND V.VAT_TYPE IN ('R', 'B')
                              and v.ACTIVE_DATE <= BBG_RA_SUPP_SALES_FV.DAY_DT)
                      and ITEM = BBG_RA_SUPP_SALES_FV.ITEM
                      and VAT_REGION = 1000
                      and VAT_TYPE IN ('R', 'B')))) SUPP_NOTAX_SALES_AMT
          FROM (SELECT /*+PARALLEL(CSS,20)*/
                 CSS.ORIGIN_SALES_DATE DAY_DT,
                 CSS.ITEM,
                 CSS.STORE LOC,
                 CSS.SUPPLIER,
                 CSS.QTY SALES_QTY,
                 CSS.TOTAL_COST SALES_COST,
                 CSS.TOTAL_RETAIL SALES_AMT,
                 (SELECT SUPP.BUSINESS_TYPE
                    FROM RMS.CMX_SUPPLIER_INFO@RA_RMS_DBLINK SUPP
                   WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BUSINESS_MODE,
                 CSS.COST_VAT_RATE,
                 (SELECT SUPP.BUSINESS_TYPE
                    FROM RMS.CMX_SUPPLIER_INFO@RA_RMS_DBLINK SUPP
                   WHERE SUPP.SUPPLIER = CSS.SUPPLIER) BBG_REFERENCE_DO1,
                 '' BBG_REFERENCE_DO2,
                 '' BBG_REFERENCE_DO3,
                 '' BBG_REFERENCE_DO4,
                 '' BBG_REFERENCE_DO5,
                 NULL BBG_REFERENCE_FO1,
                 NULL BBG_REFERENCE_FO2,
                 NULL BBG_REFERENCE_FO3,
                 NULL BBG_REFERENCE_FO4,
                 NULL BBG_REFERENCE_FO5,
                 NULL BBG_REFERENCE_FO6,
                 NULL BBG_REFERENCE_FO7,
                 NULL BBG_REFERENCE_FO8,
                 NULL BBG_REFERENCE_FO9,
                 NULL BBG_REFERENCE_FO10
                  FROM RMS.CMX_SUPP_SALES@RA_RMS_DBLINK CSS) BBG_RA_SUPP_SALES_FV
         WHERE BBG_RA_SUPP_SALES_FV.DAY_DT BETWEEN DATE
         '2014-01-11'
           AND DATE '2014-01-11'
           AND BBG_RA_SUPP_SALES_FV.LOC = '120194'
         GROUP BY BBG_RA_SUPP_SALES_FV.DAY_DT,
                  BBG_RA_SUPP_SALES_FV.LOC,
                  BBG_RA_SUPP_SALES_FV.ITEM
         ORDER BY BBG_RA_SUPP_SALES_FV.DAY_DT,
                  BBG_RA_SUPP_SALES_FV.LOC,
                  BBG_RA_SUPP_SALES_FV.ITEM) C,
       (SELECT O.ORG_NUM,
               P.PROD_IT_NUM,
               F.DT_WID,
               SUM(F.SLS_QTY - F.RET_QTY) SLS_QTY,
               SUM(F.SLS_AMT_LCL - F.RET_AMT_LCL) SLS_AMT,
               SUM((F.SLS_AMT_LCL - F.RET_AMT_LCL) -
                   (F.SLS_TAX_AMT_LCL - F.RET_TAX_AMT_LCL)) SLS_NOTAX_AMT,
               SUM((F.SLS_AMT_LCL - F.RET_AMT_LCL) -
                   (F.SLS_TAX_AMT_LCL - F.RET_TAX_AMT_LCL) -
                   (F.SLS_PROFIT_AMT_LCL - F.RET_PROFIT_AMT_LCL)) SLS_NOTAX_COST
          FROM RADM.W_RTL_SLS_IT_LC_DY_A     F,
               RABATCHER.W_INT_ORG_D_RTL_TMP O,
               RABATCHER.W_PRODUCT_D_RTL_TMP P
         WHERE F.PROD_WID = P.PROD_IT_WID
           AND F.ORG_WID = O.ORG_WID
           AND F.DT_WID BETWEEN 120140111000 AND 120140111000
           AND O.ORG_NUM = '120194'
         GROUP BY O.ORG_NUM, P.PROD_IT_NUM, F.DT_WID) W,
       (SELECT FS.DAY_DT,
               FS.PROD_IT_NUM,
               FS.ORG_NUM,
               SUM(FS.SUPP_SALES_QTY) SUPP_SALES_QTY,
               SUM(FS.SUPP_SALES_COST) SUPP_NOTAX_SALES_COST,
               SUM(FS.SUPP_SALES_AMT) SUPP_NOTAX_SALES_AMT
          FROM RADM.BBG_RA_SLS_IT_LC_DY_FS FS
         GROUP BY FS.DAY_DT, FS.PROD_IT_NUM, FS.ORG_NUM) S,
       PACKITEM@RA_RMS_DBLINK PI
 WHERE C.ITEM = W.PROD_IT_NUM
   AND C.LOC = W.ORG_NUM
   AND C.ITEM = S.PROD_IT_NUM
   AND C.ITEM = PI.ITEM(+)
   AND C.LOC = S.ORG_NUM
   AND C.DAY_DT = TO_DATE(SUBSTR(W.DT_WID, 2, 8), 'YYYYMMDD')
   AND C.DAY_DT = S.DAY_DT
   AND ( /*ROUND(C.SUPP_NOTAX_SALES_COST, 4) - ROUND(W.SLS_NOTAX_COST, 4) > 0.1
                                                                                                OR*/
        ROUND(C.SUPP_NOTAX_SALES_AMT, 4) - ROUND(W.SLS_NOTAX_AMT, 4) > 0.1);

--错误税率创建临时表
CREATE TABLE RADM.JIN_ITEM_TAXRATE_TMP AS
  SELECT T.TRAN_DATE DAY_DT, T.ITEM, T.TRAN_RATE VAT_RATE
    FROM RMSHIST.SUJH20141225VAT03@RA_RMS_DBLINK T;

--su-错误税率查找
CREATE TABLE RMSHIST.SUJH20141225VAT01
AS
SELECT DISTINCT SALET.TRAN_DATE, SALET.ITEM, SALET.VAT_RATE
  FROM TRAN_DATA_HISTORY SALET
 WHERE /*SALET.TRAN_DATE >= DATE'2014-01-01' AND*/
 SALET.TRAN_DATE < DATE '2014-01-01'
 AND SALET.TRAN_CODE IN (1, 3);

CREATE TABLE RMSHIST.SUJH20141225VAT02
AS
SELECT *
  FROM (SELECT T.TRAN_DATE,
               T.ITEM,
               T.VAT_RATE TRAN_VAT,
               VI.VAT_RATE ITEM_VAT,
               row_number() over(PARTITION BY t.item, T.TRAN_DATE ORDER BY vi.active_date DESC, vi.vat_type DESC) n#
          FROM RMSHIST.SUJH20141225VAT01 T, VAT_ITEM VI
         WHERE T.ITEM = VI.ITEM
           AND VI.ACTIVE_DATE <= T.TRAN_DATE
           AND VI.VAT_TYPE IN ('B', 'R')
           AND VI.VAT_REGION = 1000)
 WHERE N# = 1;

SELECT item, vat_region, vat_type, vat_code, vat_rate
  FROM (SELECT item,
               vat_region,
               vat_rate,
               vat_code,
               active_date,
               vat_type,
               row_number() over(PARTITION BY item ORDER BY active_date DESC, vat_type DESC) n#
          FROM vat_item
         WHERE active_date <= get_vdate
           AND vat_type IN ('B', 'R')
           AND vat_region = 1000) vi
 WHERE vi.n# = 1;


/*
SDE跑完后,核查差异情况,如果有差异,BBG_REFERENCE_FO1为sale_amt
*/
UPDATE RADM.BBG_RA_SLS_IT_LC_DY_FS T
   SET T.SUPP_SALES_AMT = T.BBG_REFERENCE_FO1 /
                          (1 + (SELECT R.VAT_RATE / 100
                                  FROM RADM.JIN_ITEM_TAXRATE_TMP R
                                 WHERE R.DAY_DT = T.DAY_DT
                                   AND R.ITEM = T.PROD_IT_NUM))
 WHERE EXISTS (SELECT 1
          FROM RADM.JIN_ITEM_TAXRATE_TMP S
         WHERE T.DAY_DT = S.DAY_DT
           AND T.PROD_IT_NUM = S.ITEM);
COMMIT;

SELECT *
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS T
 WHERE T.ORG_NUM = '120194'
   AND T.PROD_IT_NUM = '100249081';
SELECT *
  FROM CMX_SUPP_SALES@RA_RMS_DBLINK T
 WHERE T.STORE = 120194
   AND T.ITEM = 100249081
   AND T.ORIGIN_SALES_DATE = DATE '2014-01-13';
