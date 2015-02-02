--建立临时表，然后在取数，速度比较快
CREATE TABLE RADM.JIN_W_RTL_SLS_TRX_TMP AS
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID BETWEEN 120131001000 AND 120131007000
UNION ALL
SELECT * FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T WHERE T.DT_WID BETWEEN 120130823000 AND 120130825000;

DROP TABLE RADM.JIN_W_RTL_SLS_TRX_TMP;

--1--2013.5.8之后的小票统计_W_RTL_SLS_TRX_IT_LC_DY_F--------------------------------------------------
SELECT TRX.ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER100CNT) OVER100CNT,
       SUM(TRX.OVER100AMT) OVER100AMT
  FROM (SELECT /*+parallel(S,20) parallel(P,20) parallel(O,20)*/
         O.ORG_NUM,
         S.SLS_TRX_ID,
         SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 100 THEN --客单价
            1
           ELSE
            0
         END OVER100CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 100 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER100AMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RABATCHER.W_PRODUCT_D_RTL_TMP P,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.PROD_IT_WID
           AND S.ORG_WID = O.ROW_WID
              --分部LVL8ANC_PRODCAT_ID(1位)PROD_DV_WID
              --大类LVL6ANC_PRODCAT_ID(2位)PROD_DP_WID
              --中类LVL5ANC_PRODCAT_ID(3位)PROD_CL_WID
              --小类LVL4ANC_PRODCAT_ID(4位)PROD_SC_WID
              --AND P.PROD_DV_NUM NOT IN (6,7,8,9)
           AND NOT EXISTS
         (SELECT 1
                  FROM RADM.W_PROD_CAT_DH DH
                 WHERE DH.ROW_WID = P.PROD_DV_WID
                   AND DH.LVL8ANC_PRODCAT_ID IN (6, 7, 8, 9))
           AND S.DT_WID BETWEEN '120140430000' AND '120140503000' --销售日期
         GROUP BY O.ORG_NUM, S.SLS_TRX_ID) TRX
 GROUP BY TRX.ORG_NUM
 ORDER BY TRX.ORG_NUM;

--2013.5.8之后的小票统计_到商品明细_W_RTL_SLS_TRX_IT_LC_DY_F--------------------------------------------------
SELECT TRX.ORG_NUM,
       TRX.PROD_NUM,
       TRX.PRODUCT_NAME,
       SUM(TRX.QTY) QTY,
       SUM(TRX.AMT) AMT
  FROM (SELECT O.ORG_NUM,
               P.PROD_NUM,
               TL.PRODUCT_NAME,
               SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT,
               SUM(S.SLS_QTY - S.RET_QTY) QTY
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RADM.W_PRODUCT_D              P,
               RADM.W_PRODUCT_D_TL           TL,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.ROW_WID
           AND S.ORG_WID = O.ROW_WID
           AND P.DATASOURCE_NUM_ID = TL.DATASOURCE_NUM_ID
           AND P.INTEGRATION_ID = TL.INTEGRATION_ID
           AND TL.LANGUAGE_CODE = 'ZHS'
              --分部LVL8ANC_PRODCAT_ID(1位)PROD_DV_WID
              --大类LVL6ANC_PRODCAT_ID(2位)PROD_DP_WID
              --中类LVL5ANC_PRODCAT_ID(3位)PROD_CL_WID
              --小类LVL4ANC_PRODCAT_ID(4位)PROD_SC_WID
              --AND P.PROD_DP_NUM = '25'
           AND EXISTS
         (SELECT 1
                  FROM RADM.W_PROD_CAT_DH DH
                 WHERE DH.ROW_WID = P.Prod_Cat5_Wid_As_Was
                   AND DH.LVL4ANC_PRODCAT_ID = 2531)
           AND S.DT_WID BETWEEN '120140627000' AND '120140630000' --销售日期
         GROUP BY O.ORG_NUM, P.PROD_NUM, TL.PRODUCT_NAME) TRX
 GROUP BY TRX.ORG_NUM, TRX.PROD_NUM, TRX.PRODUCT_NAME
 ORDER BY TRX.ORG_NUM, TRX.PROD_NUM, TRX.PRODUCT_NAME;

----2013.5.8之后的小票统计_W_RTL_SLS_TRX_IT_LC_DY_F 单件商品满200元--------------------------------------------------
SELECT TRX.PROD_DP_NUM,
       TRX.ORG_NUM,
       --COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       --SUM(TRX.AMT) AMT,
       SUM(TRX.OVER200AMT) OVER200AMT,
       SUM(TRX.OVER200QTY) OVER200QTY
  FROM (SELECT P.PROD_DP_NUM,
               O.ORG_NUM,
               S.SLS_TRX_ID,
               SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) OVER200QTY, --销售数量
               SUM(S.SLS_QTY - S.RET_QTY) OVER200AMT --销售金额
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RABATCHER.W_PRODUCT_D_RTL_TMP P,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.PROD_IT_WID
           AND S.ORG_WID = O.ROW_WID
              --分部LVL8ANC_PRODCAT_ID(1位)PROD_DV_WID
              --大类LVL6ANC_PRODCAT_ID(2位)PROD_DP_WID
              --中类LVL5ANC_PRODCAT_ID(3位)PROD_CL_WID
              --小类LVL4ANC_PRODCAT_ID(4位)PROD_SC_WID
           AND P.PROD_DV_NUM = 7
           AND P.PROD_DP_NUM <> 76
              /*AND EXISTS
              (SELECT 1
                       FROM RADM.W_PROD_CAT_DH DH
                      WHERE DH.ROW_WID = P.PROD_DV_WID
                        AND DH.LVL8ANC_PRODCAT_ID NOT IN (6, 7, 8, 9))*/
              --单件商品满200元
           AND EXISTS
         (SELECT 1
                  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F TR
                 WHERE S.SLS_TRX_ID = TR.SLS_TRX_ID
                   AND S.SLS_AMT_LCL - S.RET_AMT_LCL >= 500)
           AND S.DT_WID BETWEEN '120140528000' AND '120140531000' --销售日期
         GROUP BY O.ORG_NUM, S.SLS_TRX_ID, P.PROD_DP_NUM) TRX
 GROUP BY TRX.ORG_NUM, TRX.PROD_DP_NUM
 ORDER BY TRX.ORG_NUM;

--2013.5.8之后 多段金额
SELECT TRX.ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER98CNT) OVER98CNT,
       SUM(TRX.OVER98AMT) OVER98AMT,
       SUM(TRX.OVER128CNT) OVER128CNT,
       SUM(TRX.OVER128AMT) OVER128AMT,
       SUM(TRX.OVER158CNT) OVER158CNT,
       SUM(TRX.OVER158AMT) OVER158AMT,
       SUM(TRX.OVER198CNT) OVER198CNT,
       SUM(TRX.OVER198AMT) OVER198AMT,
       SUM(TRX.OVER228CNT) OVER228CNT,
       SUM(TRX.OVER228AMT) OVER228AMT,
       SUM(TRX.OVER268CNT) OVER268CNT,
       SUM(TRX.OVER268AMT) OVER268AMT
  FROM (SELECT /*+parallel(S,20) parallel(P,20) parallel(O,20)*/
         O.ORG_NUM,
         S.SLS_TRX_ID,
         SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) AMT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 98 THEN --客单价
            1
           ELSE
            0
         END OVER98CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 98 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER98AMT,
         ------------
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 128 THEN --客单价
            1
           ELSE
            0
         END OVER128CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 128 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER128AMT,
         ------------
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 158 THEN --客单价
            1
           ELSE
            0
         END OVER158CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 158 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER158AMT,
         ------------
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 198 THEN --客单价
            1
           ELSE
            0
         END OVER198CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 198 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER198AMT,
         ------------
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 228 THEN --客单价
            1
           ELSE
            0
         END OVER228CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 228 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER228AMT,
         ------------
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 268 THEN --客单价
            1
           ELSE
            0
         END OVER268CNT,
         CASE
           WHEN SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL) >= 268 THEN --客单价
            SUM(S.SLS_AMT_LCL - S.RET_AMT_LCL)
           ELSE
            0
         END OVER268AMT
          FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F S,
               RABATCHER.W_PRODUCT_D_RTL_TMP P,
               RADM.W_INT_ORG_D              O
         WHERE S.PROD_WID = P.PROD_IT_WID
           AND S.ORG_WID = O.ROW_WID
              --分部LVL8ANC_PRODCAT_ID(1位)PROD_DV_WID
              --大类LVL6ANC_PRODCAT_ID(2位)PROD_DP_WID
              --中类LVL5ANC_PRODCAT_ID(3位)PROD_CL_WID
              --小类LVL4ANC_PRODCAT_ID(4位)PROD_SC_WID
              AND P.PROD_DV_NUM NOT IN (6,7,8,9)
           /*AND EXISTS
         (SELECT 1
                  FROM RADM.W_PROD_CAT_DH DH
                 WHERE DH.ROW_WID = P.PROD_DV_WID
                   AND DH.LVL8ANC_PRODCAT_ID NOT IN (6, 7, 8, 9))*/
           AND S.DT_WID BETWEEN '120140123000' AND '120140128000' --销售日期
         GROUP BY O.ORG_NUM, S.SLS_TRX_ID) TRX
 GROUP BY TRX.ORG_NUM
 ORDER BY TRX.ORG_NUM;
--2--2013.5.7之前的小票统计_SALEDETAIL---------------------------------------------------------------
SELECT SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
       SUBSTR(TRX.ORG_NUM, 4, 3) ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER100CNT) OVER100CNT,
       SUM(TRX.OVER100AMT) OVER100AMT
  FROM (SELECT T.SHOPID ORG_NUM,
               T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
               T.SD0106 SLS_TRX_ID,
               SUM(T.AMT) AMT,
               CASE
                 WHEN SUM(T.AMT) >= 58 THEN --客单价
                  1
                 ELSE
                  0
               END OVER100CNT,
               CASE
                 WHEN SUM(T.AMT) >= 58 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER100AMT
          FROM RADM.SALEDETAIL T
         WHERE T.SD0101 BETWEEN '20130428' AND '20130501' --销售日期
           AND SUBSTR(T.CATEID, 1, 1) IN (6, 7, 8, 9) --大类
        --AND T.SHOPID='012045'
         GROUP BY T.SHOPID,
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX
 GROUP BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3)
 ORDER BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3);
--多段
SELECT SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
       SUBSTR(TRX.ORG_NUM, 4, 3) ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER98CNT) OVER98CNT,
       SUM(TRX.OVER98AMT) OVER98AMT,
       SUM(TRX.OVER128CNT) OVER128CNT,
       SUM(TRX.OVER128AMT) OVER128AMT,
       SUM(TRX.OVER158CNT) OVER158CNT,
       SUM(TRX.OVER158AMT) OVER158AMT,
       SUM(TRX.OVER198CNT) OVER198CNT,
       SUM(TRX.OVER198AMT) OVER198AMT,
       SUM(TRX.OVER228CNT) OVER228CNT,
       SUM(TRX.OVER228AMT) OVER228AMT,
       SUM(TRX.OVER268CNT) OVER268CNT,
       SUM(TRX.OVER268AMT) OVER268AMT
  FROM (SELECT T.SHOPID ORG_NUM,
               T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
               T.SD0106 SLS_TRX_ID,
               SUM(T.AMT) AMT,
               CASE
                 WHEN SUM(T.AMT) >= 98 THEN --客单价
                  1
                 ELSE
                  0
               END OVER98CNT,
               CASE
                 WHEN SUM(T.AMT) >= 98 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER98AMT,
               -------------
               CASE
                 WHEN SUM(T.AMT) >= 128 THEN --客单价
                  1
                 ELSE
                  0
               END OVER128CNT,
               CASE
                 WHEN SUM(T.AMT) >= 128 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER128AMT,
               -------------
               CASE
                 WHEN SUM(T.AMT) >= 158 THEN --客单价
                  1
                 ELSE
                  0
               END OVER158CNT,
               CASE
                 WHEN SUM(T.AMT) >= 158 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER158AMT,
               -------------
               CASE
                 WHEN SUM(T.AMT) >= 198 THEN --客单价
                  1
                 ELSE
                  0
               END OVER198CNT,
               CASE
                 WHEN SUM(T.AMT) >= 198 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER198AMT,
               -------------
               CASE
                 WHEN SUM(T.AMT) >= 228 THEN --客单价
                  1
                 ELSE
                  0
               END OVER228CNT,
               CASE
                 WHEN SUM(T.AMT) >= 228 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER228AMT,
               -------------
               CASE
                 WHEN SUM(T.AMT) >= 268 THEN --客单价
                  1
                 ELSE
                  0
               END OVER268CNT,
               CASE
                 WHEN SUM(T.AMT) >= 268 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER268AMT
          FROM RADM.SALEDETAIL T
         WHERE T.SD0101 BETWEEN '20130202' AND '20130207' --销售日期
           AND SUBSTR(T.CATEID, 1, 1) NOT IN (6, 7, 8, 9) --大类
         GROUP BY T.SHOPID,
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX
 GROUP BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3)
 ORDER BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3);
--3--会员销售-RMS----------------------------------------------------------------------------------------
--门店号,机台号,小票号,日期
--2013.5.8之后_sa_tran_item
SELECT TRX.ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER100CNT) OVER100CNT,
       SUM(TRX.OVER100AMT) OVER100AMT
  FROM (SELECT /*+PARALLEL(ST,20) (SH,20) (SD,20) (STD,20)*/ ST.STORE ORG_NUM,
               ST.TRAN_SEQ_NO SLS_TRX_ID,
               SUM(ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) AMT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 38 THEN --客单价
                  1
                 ELSE
                  0
               END OVER100CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 38 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER100AMT
          FROM SA_TRAN_ITEM ST,
               SA_TRAN_HEAD SH,
               SA_STORE_DAY SD,
               SA_TRAN_DISC STD
         WHERE ST.STORE = SH.STORE
           AND ST.DAY = SH.DAY
           AND ST.TRAN_SEQ_NO = SH.TRAN_SEQ_NO
           AND SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
           AND SH.STORE = SD.STORE
           AND SH.DAY = SD.DAY
           AND ST.STORE = STD.STORE(+)
           AND ST.DAY = STD.DAY(+)
           AND ST.TRAN_SEQ_NO = STD.TRAN_SEQ_NO(+)
           AND ST.ITEM_SEQ_NO = STD.ITEM_SEQ_NO(+)
           AND SD.BUSINESS_DATE BETWEEN DATE '2014-02-10' AND DATE
         '2014-02-22' --销售日期
           AND SUBSTR(ST.DEPT, 1, 2) IN (27) --大类
           AND EXISTS (SELECT /*+PARALLEL(H,20) (M,20)*/ 'X'
                  FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
                 WHERE H.MDID = M.MDID
                   AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
                   AND H.JLBH = SH.TRAN_NO
                   AND H.SKTNO = SH.REGISTER
                   AND H.JZRQ = SD.BUSINESS_DATE)
         GROUP BY ST.STORE, ST.TRAN_SEQ_NO) TRX
 GROUP BY TRX.ORG_NUM
 ORDER BY TRX.ORG_NUM;
--多段
SELECT TRX.ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER98CNT) OVER98CNT,
       SUM(TRX.OVER98AMT) OVER98AMT,
       
       SUM(TRX.OVER128CNT) OVER128CNT,
       SUM(TRX.OVER128AMT) OVER128AMT,
       
       SUM(TRX.OVER158CNT) OVER158CNT,
       SUM(TRX.OVER158AMT) OVER158AMT,
       
       SUM(TRX.OVER198CNT) OVER198CNT,
       SUM(TRX.OVER198AMT) OVER198AMT,
       
       SUM(TRX.OVER228CNT) OVER228CNT,
       SUM(TRX.OVER228AMT) OVER228AMT,
       
       SUM(TRX.OVER268CNT) OVER268CNT,
       SUM(TRX.OVER268AMT) OVER268AMT
  FROM (SELECT ST.STORE ORG_NUM,
               ST.TRAN_SEQ_NO SLS_TRX_ID,
               SUM(ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) AMT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 98 THEN --客单价
                  1
                 ELSE
                  0
               END OVER98CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 98 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER98AMT,
               ----------
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 128 THEN --客单价
                  1
                 ELSE
                  0
               END OVER128CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 128 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER128AMT,
               ----------
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 158 THEN --客单价
                  1
                 ELSE
                  0
               END OVER158CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 158 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER158AMT,
               ----------
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 198 THEN --客单价
                  1
                 ELSE
                  0
               END OVER198CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 198 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER198AMT,
               ----------
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 228 THEN --客单价
                  1
                 ELSE
                  0
               END OVER228CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 228 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER228AMT,
               ----------
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 268 THEN --客单价
                  1
                 ELSE
                  0
               END OVER268CNT,
               CASE
                 WHEN SUM(ST.QTY *
                          (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) >= 268 THEN --客单价
                  SUM(ST.QTY *
                      (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)))
                 ELSE
                  0
               END OVER268AMT
          FROM SA_TRAN_ITEM ST,
               SA_TRAN_HEAD SH,
               SA_STORE_DAY SD,
               SA_TRAN_DISC STD
         WHERE ST.STORE = SH.STORE
           AND ST.DAY = SH.DAY
           AND ST.TRAN_SEQ_NO = SH.TRAN_SEQ_NO
           AND SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
           AND SH.STORE = SD.STORE
           AND SH.DAY = SD.DAY
           AND ST.STORE = STD.STORE(+)
           AND ST.DAY = STD.DAY(+)
           AND ST.TRAN_SEQ_NO = STD.TRAN_SEQ_NO(+)
           AND ST.ITEM_SEQ_NO = STD.ITEM_SEQ_NO(+)
           AND SD.BUSINESS_DATE BETWEEN DATE '2014-01-23' AND DATE
         '2014-01-28' --销售日期
           AND SUBSTR(ST.DEPT, 1, 1) NOT IN (6, 7, 8, 9) --大类
           AND EXISTS (SELECT 'X'
                  FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
                 WHERE H.MDID = M.MDID
                   AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
                   AND H.JLBH = SH.TRAN_NO
                   AND H.SKTNO = SH.REGISTER
                   AND H.JZRQ = SD.BUSINESS_DATE)
         GROUP BY ST.STORE, ST.TRAN_SEQ_NO) TRX
 GROUP BY TRX.ORG_NUM
 ORDER BY TRX.ORG_NUM;

--会员销售销售明细
SELECT ST.STORE 门店,
       SH.TRAN_NO 小票号,
       SH.TRAN_DATETIME 时间,
       SH.REGISTER 机台号,
       ST.ITEM 商品,
       ST.QTY 数量,
       ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)) AMT
  FROM SA_TRAN_ITEM ST, SA_TRAN_HEAD SH, SA_STORE_DAY SD, SA_TRAN_DISC STD
 WHERE ST.STORE = SH.STORE
   AND ST.DAY = SH.DAY
   AND ST.TRAN_SEQ_NO = SH.TRAN_SEQ_NO
   AND SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
   AND SH.STORE = SD.STORE
   AND SH.DAY = SD.DAY
   AND ST.STORE = STD.STORE(+)
   AND ST.DAY = STD.DAY(+)
   AND ST.TRAN_SEQ_NO = STD.TRAN_SEQ_NO(+)
   AND ST.ITEM_SEQ_NO = STD.ITEM_SEQ_NO(+)
   AND SD.BUSINESS_DATE BETWEEN DATE '2014-01-01' AND DATE
 '2014-01-03' --销售日期
   AND SUBSTR(ST.DEPT, 1, 1) NOT IN (6, 7, 8, 9) --大类
   AND EXISTS (SELECT 'X'
          FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
         WHERE H.MDID = M.MDID
              --AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
           AND H.JLBH = SH.TRAN_NO
           AND H.SKTNO = SH.REGISTER
           AND H.JZRQ = SD.BUSINESS_DATE);

--4--会员_2013.5.8之前_SALEDETAIL------------------------------------------------------------------
SELECT SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
       SUBSTR(TRX.ORG_NUM, 4, 3) ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER100CNT) OVER100CNT,
       SUM(TRX.OVER100AMT) OVER100AMT
  FROM (SELECT T.SHOPID ORG_NUM,
               T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
               T.SD0106 SLS_TRX_ID,
               SUM(T.AMT) AMT,
               CASE
                 WHEN SUM(T.AMT) >= 38 THEN --客单价
                  1
                 ELSE
                  0
               END OVER100CNT,
               CASE
                 WHEN SUM(T.AMT) >= 38 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER100AMT
          FROM RADM.SALEDETAIL T
         WHERE T.SD0101 BETWEEN '20130220' AND '20130222' --销售日期
           AND SUBSTR(T.CATEID, 1, 2) IN (27) --大类
           AND EXISTS
         (SELECT 1
                  FROM RADM.HYXFJL H, RADM.MDDY M
                 WHERE M.MDID = H.MDID
                   AND SUBSTR(M.MDDM, 3, 6) =
                       SUBSTR(T.SHOPID, 2, 2) || SUBSTR(T.SHOPID, 1, 1) ||
                       SUBSTR(T.SHOPID, 4, 3)
                   AND T.SD0101 = TO_CHAR(H.XFSJ, 'YYYYMMDD')
                   AND H.JLBH = T.Sd0106
                   and h.sktno = t.sd0109)
         GROUP BY T.SHOPID,
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX
 GROUP BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3)
 ORDER BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3);
--多段
SELECT SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
       SUBSTR(TRX.ORG_NUM, 4, 3) ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.OVER98CNT) OVER98CNT,
       SUM(TRX.OVER98AMT) OVER98AMT,
       
       SUM(TRX.OVER128CNT) OVER128CNT,
       SUM(TRX.OVER128AMT) OVER128AMT,
       
       SUM(TRX.OVER158CNT) OVER158CNT,
       SUM(TRX.OVER158AMT) OVER158AMT,
       
       SUM(TRX.OVER198CNT) OVER198CNT,
       SUM(TRX.OVER198AMT) OVER198AMT,
       
       SUM(TRX.OVER228CNT) OVER228CNT,
       SUM(TRX.OVER228AMT) OVER228AMT,
       
       SUM(TRX.OVER268CNT) OVER268CNT,
       SUM(TRX.OVER268AMT) OVER268AMT
  FROM (SELECT T.SHOPID ORG_NUM,
               T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
               T.SD0106 SLS_TRX_ID,
               SUM(T.AMT) AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 98 THEN --客单价
                  1
                 ELSE
                  0
               END OVER98CNT,
               CASE
                 WHEN SUM(T.AMT) >= 98 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER98AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 128 THEN --客单价
                  1
                 ELSE
                  0
               END OVER128CNT,
               CASE
                 WHEN SUM(T.AMT) >= 128 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER128AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 158 THEN --客单价
                  1
                 ELSE
                  0
               END OVER158CNT,
               CASE
                 WHEN SUM(T.AMT) >= 158 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER158AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 198 THEN --客单价
                  1
                 ELSE
                  0
               END OVER198CNT,
               CASE
                 WHEN SUM(T.AMT) >= 198 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER198AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 228 THEN --客单价
                  1
                 ELSE
                  0
               END OVER228CNT,
               CASE
                 WHEN SUM(T.AMT) >= 228 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER228AMT,
               ----------
               CASE
                 WHEN SUM(T.AMT) >= 268 THEN --客单价
                  1
                 ELSE
                  0
               END OVER268CNT,
               CASE
                 WHEN SUM(T.AMT) >= 268 THEN --客单价
                  SUM(T.AMT)
                 ELSE
                  0
               END OVER268AMT
          FROM RADM.SALEDETAIL T
         WHERE T.SD0101 BETWEEN '20130202' AND '20130207' --销售日期
           AND SUBSTR(T.CATEID, 1, 1) NOT IN (6, 7, 8, 9) --大类
           AND EXISTS
         (SELECT 1
                  FROM RADM.HYXFJL H, RADM.MDDY M
                 WHERE M.MDID = H.MDID
                   AND SUBSTR(M.MDDM, 3, 6) =
                       SUBSTR(T.SHOPID, 2, 2) || SUBSTR(T.SHOPID, 1, 1) ||
                       SUBSTR(T.SHOPID, 4, 3)
                   AND T.SD0101 = TO_CHAR(H.XFSJ, 'YYYYMMDD')
                   AND H.JLBH = T.Sd0106
                   and h.sktno = t.sd0109)
         GROUP BY T.SHOPID,
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX
 GROUP BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3)
 ORDER BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3);

--5--附商品明细的会员销售---------------------------------------------------------------
--2013.5.8之后的销售
SELECT TRX.ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.QTY) QTY
  FROM (SELECT ST.STORE ORG_NUM,
               ST.TRAN_SEQ_NO SLS_TRX_ID,
               SUM(ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) AMT,
               SUM(ST.QTY) QTY
          FROM SA_TRAN_ITEM ST,
               SA_TRAN_HEAD SH,
               SA_STORE_DAY SD,
               SA_TRAN_DISC STD
         WHERE ST.STORE = SH.STORE
           AND ST.DAY = SH.DAY
           AND ST.TRAN_SEQ_NO = SH.TRAN_SEQ_NO
           AND SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
           AND SH.STORE = SD.STORE
           AND SH.DAY = SD.DAY
           AND ST.STORE = STD.STORE(+)
           AND ST.DAY = STD.DAY(+)
           AND ST.TRAN_SEQ_NO = STD.TRAN_SEQ_NO(+)
           AND ST.ITEM_SEQ_NO = STD.ITEM_SEQ_NO(+)
           AND SD.BUSINESS_DATE BETWEEN DATE '2014-01-01' AND DATE
         '2014-01-03' --销售日期
              --AND SUBSTR(ST.DEPT, 1, 2) IN (16) --大类
           AND ST.ITEM IN ('100049434',
                           '100049469',
                           '100076475',
                           '100076539',
                           '100076555',
                           '100094227',
                           '100094315',
                           '100094374',
                           '100094391',
                           '100094411',
                           '100094471',
                           '100094534',
                           '100094593',
                           '100094614',
                           '100094690',
                           '100094737',
                           '100094770',
                           '100096476',
                           '100101790',
                           '100103171',
                           '100107833',
                           '100107956',
                           '100218411',
                           '100218883',
                           '100220406',
                           '100220924',
                           '100222073',
                           '100222145',
                           '100228109',
                           '100228272',
                           '100228408',
                           '100228504',
                           '100228627',
                           '100228651',
                           '100228694',
                           '100256716',
                           '100361962',
                           '100361989',
                           '100362009',
                           '100362383',
                           '100630472',
                           '100630536',
                           '100683101',
                           '100683128',
                           '100683161',
                           '100683179',
                           '100689407',
                           '100706975',
                           '100707046',
                           '100742571',
                           '100765182',
                           '100765203',
                           '100765220',
                           '800016075',
                           '800016125',
                           '800016128',
                           '800016241',
                           '800016299',
                           '800016301',
                           '800016347',
                           '800016410',
                           '800016411',
                           '800133475',
                           '800203953',
                           '800204671',
                           '800213309',
                           '800214615',
                           '800217288',
                           '800217289',
                           '800217290',
                           '800217291',
                           '800243981',
                           '800244000',
                           '800244001',
                           '800244004',
                           '800316361',
                           '800316362',
                           '800316363',
                           '800319482',
                           '800324184',
                           '800330237',
                           '800330265',
                           '800331675',
                           '800335211',
                           '800337095',
                           '800338216',
                           '800340628',
                           '800340631',
                           '800340632',
                           '800361322',
                           '800361323',
                           '800361324',
                           '800361325',
                           '800361326',
                           '800361327',
                           '800361328',
                           '800361329',
                           '800361330',
                           '800361331',
                           '800369136',
                           '800369137',
                           '800369138',
                           '800369139',
                           '800369140',
                           '800369141',
                           '800369142',
                           '800369143',
                           '800369144',
                           '800369145',
                           '800369146',
                           '800369147',
                           '800369148',
                           '800369149',
                           '800370444',
                           '800370448',
                           '800370449',
                           '800371360',
                           '800371361',
                           '800371362',
                           '800371363',
                           '800371364',
                           '800371376',
                           '800371377',
                           '800373060',
                           '800375674',
                           '800377742',
                           '800377743',
                           '800378256',
                           '800380031',
                           '800383168',
                           '800386844',
                           '800386847',
                           '800386848',
                           '800386849',
                           '800386850',
                           '800386851',
                           '800386852',
                           '800388908',
                           '800393864',
                           '800393865',
                           '800393866',
                           '800393867',
                           '800393868',
                           '800393869',
                           '800393870',
                           '800393871',
                           '800393872',
                           '800394227',
                           '800394673',
                           '800394674',
                           '800394675',
                           '800394676',
                           '800394713',
                           '800397629',
                           '800397630',
                           '800397633',
                           '800397634',
                           '800401775',
                           '800401776',
                           '800401777',
                           '800401778',
                           '800401779',
                           '800401780',
                           '800401781',
                           '800401782',
                           '800401783',
                           '800401786',
                           '800401787',
                           '800401788',
                           '800401789',
                           '800401790',
                           '800401791',
                           '800401792',
                           '800401793',
                           '800401794',
                           '800401795',
                           '800401796',
                           '800401797',
                           '800401798',
                           '800401799',
                           '800401800',
                           '800401801',
                           '800401802',
                           '800401810',
                           '800401811',
                           '800401831',
                           '800401832',
                           '800401833',
                           '800401835',
                           '800401837',
                           '800401838',
                           '800402535',
                           '800402537',
                           '800402923',
                           '800402946',
                           '800402947',
                           '800402948',
                           '800402949',
                           '800402950',
                           '800402951',
                           '800402952',
                           '800402953',
                           '800402954',
                           '800403012',
                           '800403388',
                           '800403422',
                           '800403423',
                           '800403611',
                           '800403612',
                           '800403613',
                           '800403614',
                           '800403615',
                           '800403616',
                           '800403617',
                           '800403618',
                           '800403651',
                           '800403652',
                           '800403653',
                           '800403654',
                           '800403655',
                           '800405775',
                           '800405776',
                           '800405777',
                           '800405778',
                           '800405782',
                           '800405783',
                           '800409003',
                           '800409004',
                           '800413224',
                           '800413225',
                           '800416619',
                           '800416620',
                           '800418637',
                           '100094850',
                           '100094948',
                           '100095027',
                           '100095086',
                           '100095140',
                           '100095220',
                           '100095289',
                           '100095326',
                           '100095406',
                           '100095511',
                           '100095713',
                           '100095781',
                           '100095879',
                           '100095941',
                           '100096020',
                           '100096071',
                           '100096151',
                           '100096214',
                           '100096273',
                           '100096290',
                           '100096628',
                           '100096644',
                           '100096716',
                           '100096775',
                           '100096847',
                           '100096935',
                           '100097006',
                           '100101861',
                           '100101888',
                           '100108035',
                           '100109071',
                           '100109118',
                           '100109134',
                           '100109151',
                           '100109177',
                           '100109193',
                           '100172379',
                           '100218525',
                           '100220764',
                           '100220895',
                           '100222436',
                           '100222532',
                           '100225063',
                           '100225303',
                           '100225346',
                           '100225637',
                           '100225688',
                           '100225901',
                           '100226015',
                           '100226058',
                           '100228301',
                           '100228555',
                           '100228846',
                           '100228862',
                           '100228871',
                           '100256783',
                           '100256821',
                           '100256871',
                           '100329428',
                           '100362033',
                           '100362068',
                           '100362455',
                           '100362498',
                           '100362711',
                           '100363108',
                           '100363124',
                           '100404740',
                           '100404774',
                           '100404791',
                           '100438915',
                           '100438974',
                           '100679321',
                           '100680138',
                           '100680154',
                           '100680226',
                           '100680242',
                           '100683662',
                           '100742693',
                           '100856105',
                           '100856121',
                           '800016067',
                           '800016068',
                           '800016181',
                           '800016229',
                           '800016231',
                           '800016232',
                           '800016233',
                           '800016295',
                           '800016340',
                           '800016341',
                           '800016342',
                           '800016457',
                           '800018775',
                           '800178058',
                           '800178095',
                           '800189550',
                           '800243997',
                           '800243998',
                           '800245343',
                           '800249512',
                           '800316626',
                           '800324186',
                           '800329696',
                           '800329697',
                           '800329699',
                           '800329708',
                           '800330261',
                           '800333721',
                           '800338723',
                           '800346237',
                           '800346238',
                           '800347951',
                           '800347959',
                           '800347960',
                           '800347961',
                           '800347962',
                           '800347963',
                           '800347980',
                           '800347994',
                           '800354973',
                           '800354974',
                           '800354975',
                           '800354976',
                           '800354980',
                           '800354981',
                           '800354982',
                           '800354983',
                           '800354984',
                           '800357376',
                           '800357774',
                           '800357775',
                           '800370445',
                           '800370451',
                           '800371353',
                           '800371354',
                           '800371355',
                           '800371367',
                           '800371368',
                           '800371369',
                           '800371382',
                           '800371739',
                           '800373646',
                           '800373648',
                           '800373742',
                           '800373792',
                           '800373793',
                           '800373798',
                           '800373799',
                           '800373801',
                           '800373802',
                           '800373803',
                           '800373805',
                           '800373807',
                           '800373809',
                           '800373811',
                           '800377112',
                           '800377741',
                           '800377744',
                           '800379200',
                           '800379966',
                           '800379967',
                           '800380758',
                           '800385553',
                           '800386471',
                           '800386472',
                           '800386473',
                           '800386474',
                           '800389016',
                           '800389017',
                           '800389019',
                           '800389020',
                           '800389022',
                           '800389072',
                           '800389073',
                           '800393149',
                           '800393152',
                           '800393153',
                           '800393154',
                           '800393886',
                           '800393887',
                           '800393888',
                           '800393889',
                           '800393890',
                           '800393891',
                           '800394643',
                           '800394644',
                           '800394685',
                           '800394917',
                           '800398425',
                           '800398426',
                           '800402922',
                           '800402924',
                           '800402925',
                           '800402926',
                           '800402927',
                           '800402928',
                           '800402929',
                           '800402930',
                           '800402931',
                           '800402932',
                           '800402933',
                           '800402934',
                           '800402935',
                           '800402936',
                           '800402937',
                           '800402940',
                           '800402941',
                           '800402942',
                           '800402957',
                           '800402958',
                           '800402959',
                           '800402960',
                           '800402961',
                           '800402962',
                           '800402963',
                           '800402965',
                           '800402966',
                           '800402967',
                           '800403011',
                           '800403391',
                           '800403392',
                           '800403393',
                           '800403394',
                           '800403622',
                           '800403623',
                           '800403624',
                           '800403625',
                           '800403626',
                           '800403627',
                           '800403628',
                           '800403629',
                           '800403630',
                           '800403631',
                           '800403632',
                           '800403633',
                           '800403634',
                           '800403635',
                           '800403641',
                           '800403647',
                           '800403648',
                           '800403656',
                           '800403657',
                           '800403658',
                           '800405781',
                           '800405784',
                           '800405785',
                           '800405786',
                           '800407484',
                           '800409005',
                           '800410528',
                           '800411163',
                           '800411164',
                           '800411167',
                           '800411874',
                           '800415955',
                           '800415956',
                           '800415958',
                           '800415961',
                           '800416640',
                           '800416641',
                           '800416642',
                           '800416643',
                           '800416644',
                           '800416645',
                           '800418631',
                           '800418632',
                           '800418633',
                           '800418634',
                           '800418635',
                           '800418650',
                           '800418656',
                           '800418658',
                           '800418661',
                           '800418662',
                           '800419570')
           AND EXISTS (SELECT 'X'
                  FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
                 WHERE H.MDID = M.MDID
                   AND H.JLBH = SH.TRAN_NO
                   AND H.SKTNO = SH.REGISTER
                   AND H.JZRQ = SD.BUSINESS_DATE)
         GROUP BY ST.STORE, ST.TRAN_SEQ_NO) TRX
 GROUP BY TRX.ORG_NUM
 ORDER BY TRX.ORG_NUM;

--2013.5.8之前的销售
SELECT SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
       SUBSTR(TRX.ORG_NUM, 4, 3) ORG_NUM,
       COUNT(TRX.SLS_TRX_ID) TRX_CNT,
       SUM(TRX.AMT) AMT,
       SUM(TRX.QTY) QTY
  FROM (SELECT T.SHOPID ORG_NUM,
               T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
               T.SD0106 SLS_TRX_ID,
               SUM(T.AMT) AMT,
               SUM(T.SD0104) QTY
          FROM RADM.SALEDETAIL T, RADM.GOODS G
         WHERE T.SD0102 = G.GOODSID
           AND T.SD0101 BETWEEN '20130101' AND '20130103' --销售日期
              --AND SUBSTR(T.CATEID, 1, 2) IN (16) --大类
           AND '8' || SUBSTR('00000000' || G.GOODSCODE, -8) IN
               ('100049434',
                '100049469',
                '100076475',
                '100076539',
                '100076555',
                '100094227',
                '100094315',
                '100094374',
                '100094391',
                '100094411',
                '100094471',
                '100094534',
                '100094593',
                '100094614',
                '100094690',
                '100094737',
                '100094770',
                '100096476',
                '100101790',
                '100103171',
                '100107833',
                '100107956',
                '100218411',
                '100218883',
                '100220406',
                '100220924',
                '100222073',
                '100222145',
                '100228109',
                '100228272',
                '100228408',
                '100228504',
                '100228627',
                '100228651',
                '100228694',
                '100256716',
                '100361962',
                '100361989',
                '100362009',
                '100362383',
                '100630472',
                '100630536',
                '100683101',
                '100683128',
                '100683161',
                '100683179',
                '100689407',
                '100706975',
                '100707046',
                '100742571',
                '100765182',
                '100765203',
                '100765220',
                '800016075',
                '800016125',
                '800016128',
                '800016241',
                '800016299',
                '800016301',
                '800016347',
                '800016410',
                '800016411',
                '800133475',
                '800203953',
                '800204671',
                '800213309',
                '800214615',
                '800217288',
                '800217289',
                '800217290',
                '800217291',
                '800243981',
                '800244000',
                '800244001',
                '800244004',
                '800316361',
                '800316362',
                '800316363',
                '800319482',
                '800324184',
                '800330237',
                '800330265',
                '800331675',
                '800335211',
                '800337095',
                '800338216',
                '800340628',
                '800340631',
                '800340632',
                '800361322',
                '800361323',
                '800361324',
                '800361325',
                '800361326',
                '800361327',
                '800361328',
                '800361329',
                '800361330',
                '800361331',
                '800369136',
                '800369137',
                '800369138',
                '800369139',
                '800369140',
                '800369141',
                '800369142',
                '800369143',
                '800369144',
                '800369145',
                '800369146',
                '800369147',
                '800369148',
                '800369149',
                '800370444',
                '800370448',
                '800370449',
                '800371360',
                '800371361',
                '800371362',
                '800371363',
                '800371364',
                '800371376',
                '800371377',
                '800373060',
                '800375674',
                '800377742',
                '800377743',
                '800378256',
                '800380031',
                '800383168',
                '800386844',
                '800386847',
                '800386848',
                '800386849',
                '800386850',
                '800386851',
                '800386852',
                '800388908',
                '800393864',
                '800393865',
                '800393866',
                '800393867',
                '800393868',
                '800393869',
                '800393870',
                '800393871',
                '800393872',
                '800394227',
                '800394673',
                '800394674',
                '800394675',
                '800394676',
                '800394713',
                '800397629',
                '800397630',
                '800397633',
                '800397634',
                '800401775',
                '800401776',
                '800401777',
                '800401778',
                '800401779',
                '800401780',
                '800401781',
                '800401782',
                '800401783',
                '800401786',
                '800401787',
                '800401788',
                '800401789',
                '800401790',
                '800401791',
                '800401792',
                '800401793',
                '800401794',
                '800401795',
                '800401796',
                '800401797',
                '800401798',
                '800401799',
                '800401800',
                '800401801',
                '800401802',
                '800401810',
                '800401811',
                '800401831',
                '800401832',
                '800401833',
                '800401835',
                '800401837',
                '800401838',
                '800402535',
                '800402537',
                '800402923',
                '800402946',
                '800402947',
                '800402948',
                '800402949',
                '800402950',
                '800402951',
                '800402952',
                '800402953',
                '800402954',
                '800403012',
                '800403388',
                '800403422',
                '800403423',
                '800403611',
                '800403612',
                '800403613',
                '800403614',
                '800403615',
                '800403616',
                '800403617',
                '800403618',
                '800403651',
                '800403652',
                '800403653',
                '800403654',
                '800403655',
                '800405775',
                '800405776',
                '800405777',
                '800405778',
                '800405782',
                '800405783',
                '800409003',
                '800409004',
                '800413224',
                '800413225',
                '800416619',
                '800416620',
                '800418637',
                '100094850',
                '100094948',
                '100095027',
                '100095086',
                '100095140',
                '100095220',
                '100095289',
                '100095326',
                '100095406',
                '100095511',
                '100095713',
                '100095781',
                '100095879',
                '100095941',
                '100096020',
                '100096071',
                '100096151',
                '100096214',
                '100096273',
                '100096290',
                '100096628',
                '100096644',
                '100096716',
                '100096775',
                '100096847',
                '100096935',
                '100097006',
                '100101861',
                '100101888',
                '100108035',
                '100109071',
                '100109118',
                '100109134',
                '100109151',
                '100109177',
                '100109193',
                '100172379',
                '100218525',
                '100220764',
                '100220895',
                '100222436',
                '100222532',
                '100225063',
                '100225303',
                '100225346',
                '100225637',
                '100225688',
                '100225901',
                '100226015',
                '100226058',
                '100228301',
                '100228555',
                '100228846',
                '100228862',
                '100228871',
                '100256783',
                '100256821',
                '100256871',
                '100329428',
                '100362033',
                '100362068',
                '100362455',
                '100362498',
                '100362711',
                '100363108',
                '100363124',
                '100404740',
                '100404774',
                '100404791',
                '100438915',
                '100438974',
                '100679321',
                '100680138',
                '100680154',
                '100680226',
                '100680242',
                '100683662',
                '100742693',
                '100856105',
                '100856121',
                '800016067',
                '800016068',
                '800016181',
                '800016229',
                '800016231',
                '800016232',
                '800016233',
                '800016295',
                '800016340',
                '800016341',
                '800016342',
                '800016457',
                '800018775',
                '800178058',
                '800178095',
                '800189550',
                '800243997',
                '800243998',
                '800245343',
                '800249512',
                '800316626',
                '800324186',
                '800329696',
                '800329697',
                '800329699',
                '800329708',
                '800330261',
                '800333721',
                '800338723',
                '800346237',
                '800346238',
                '800347951',
                '800347959',
                '800347960',
                '800347961',
                '800347962',
                '800347963',
                '800347980',
                '800347994',
                '800354973',
                '800354974',
                '800354975',
                '800354976',
                '800354980',
                '800354981',
                '800354982',
                '800354983',
                '800354984',
                '800357376',
                '800357774',
                '800357775',
                '800370445',
                '800370451',
                '800371353',
                '800371354',
                '800371355',
                '800371367',
                '800371368',
                '800371369',
                '800371382',
                '800371739',
                '800373646',
                '800373648',
                '800373742',
                '800373792',
                '800373793',
                '800373798',
                '800373799',
                '800373801',
                '800373802',
                '800373803',
                '800373805',
                '800373807',
                '800373809',
                '800373811',
                '800377112',
                '800377741',
                '800377744',
                '800379200',
                '800379966',
                '800379967',
                '800380758',
                '800385553',
                '800386471',
                '800386472',
                '800386473',
                '800386474',
                '800389016',
                '800389017',
                '800389019',
                '800389020',
                '800389022',
                '800389072',
                '800389073',
                '800393149',
                '800393152',
                '800393153',
                '800393154',
                '800393886',
                '800393887',
                '800393888',
                '800393889',
                '800393890',
                '800393891',
                '800394643',
                '800394644',
                '800394685',
                '800394917',
                '800398425',
                '800398426',
                '800402922',
                '800402924',
                '800402925',
                '800402926',
                '800402927',
                '800402928',
                '800402929',
                '800402930',
                '800402931',
                '800402932',
                '800402933',
                '800402934',
                '800402935',
                '800402936',
                '800402937',
                '800402940',
                '800402941',
                '800402942',
                '800402957',
                '800402958',
                '800402959',
                '800402960',
                '800402961',
                '800402962',
                '800402963',
                '800402965',
                '800402966',
                '800402967',
                '800403011',
                '800403391',
                '800403392',
                '800403393',
                '800403394',
                '800403622',
                '800403623',
                '800403624',
                '800403625',
                '800403626',
                '800403627',
                '800403628',
                '800403629',
                '800403630',
                '800403631',
                '800403632',
                '800403633',
                '800403634',
                '800403635',
                '800403641',
                '800403647',
                '800403648',
                '800403656',
                '800403657',
                '800403658',
                '800405781',
                '800405784',
                '800405785',
                '800405786',
                '800407484',
                '800409005',
                '800410528',
                '800411163',
                '800411164',
                '800411167',
                '800411874',
                '800415955',
                '800415956',
                '800415958',
                '800415961',
                '800416640',
                '800416641',
                '800416642',
                '800416643',
                '800416644',
                '800416645',
                '800418631',
                '800418632',
                '800418633',
                '800418634',
                '800418635',
                '800418650',
                '800418656',
                '800418658',
                '800418661',
                '800418662',
                '800419570')
           AND EXISTS
         (SELECT 1
                  FROM RADM.HYXFJL H, RADM.MDDY M
                 WHERE M.MDID = H.MDID
                   AND SUBSTR(M.MDDM, 3, 6) =
                       SUBSTR(T.SHOPID, 2, 2) || SUBSTR(T.SHOPID, 1, 1) ||
                       SUBSTR(T.SHOPID, 4, 3)
                   AND T.SD0101 = TO_CHAR(H.XFSJ, 'YYYYMMDD')
                   AND H.JLBH = T.Sd0106
                   and h.sktno = t.sd0109)
         GROUP BY T.SHOPID,
                  T.SHOPID || '|' || T.SD0101 || '|' || T.SD0109 || '|' ||
                  T.SD0106) TRX
 GROUP BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3)
 ORDER BY SUBSTR(TRX.ORG_NUM, 2, 2) || SUBSTR(TRX.ORG_NUM, 1, 1) ||
          SUBSTR(TRX.ORG_NUM, 4, 3);
----------------------------------
SELECT * FROM RADM.SALEDETAIL;
SELECT * FROM RADM.HYXFJL T;
SELECT * FROM RADM.MDDY T;
SELECT * FROM RADM.MDDY@RMS_RA;
SELECT * FROM SA_TRAN_HEAD;
SELECT * FROM SA_TRAN_ITEM;
