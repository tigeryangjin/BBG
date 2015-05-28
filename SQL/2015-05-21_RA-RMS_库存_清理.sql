--***********************************************************************************
--RA-供应商库存清理
--***********************************************************************************
--RMS
SELECT *
  FROM CMX_SUPP_INV T
 WHERE T.ITEM = '800044955'
   AND T.LOC = '118010'
   AND T.SUPPLIER = '';

SELECT *
  FROM CMX_SUPP_INV_HIST T
 WHERE T.ITEM = '800044955'
   AND T.LOC = '118010';

SELECT *
  FROM ITEM_LOC_SOH T
 WHERE T.ITEM = '800044955'
   AND T.LOC = '118010';

--RA
SELECT *
  FROM RADM.BBG_RA_SUPP_INV_IT_LC_G T
 WHERE T.PROD_IT_NUM = '101440187'
   AND T.ORG_NUM = '120145'
   AND T.SUPPLIER_NUM = '';

SELECT *
  FROM RADM.BBG_RA_SUPP_INV_IT_LC_DY_F T
 WHERE T.PROD_WID = 1600200
   AND T.ORG_WID = 129;

SELECT *
  FROM RADM.W_RTL_INV_IT_LC_G T
 WHERE T.PROD_DP_NUM IN (35, 36)
 ORDER BY T.INV_SOH_QTY DESC;

--清理库存注意点:BBG_RA_SUPP_INV_IT_LC_DY_F和BBG_RA_SUPP_INV_IT_LC_G要保持一致!!!!!

--1.王勇昱把清理库存的记录插入CMX_SUPP_INV_HIST,RA手工运行供应商库存(SDE,SIL),剔出不为0的数据,并且rms和ra一致的数据
DROP TABLE RADM.BBG_RA_SUP_INV_IT_LC_DY_FS_BAK;

CREATE TABLE RADM.BBG_RA_SUP_INV_IT_LC_DY_FS_BAK AS
  SELECT *
    FROM RADM.BBG_RA_SUP_INV_IT_LC_DY_FS T
   WHERE T.SUPP_INV_QTY = 0
     AND EXISTS (SELECT 1
            FROM RADM.BBG_RA_SUPP_INV_IT_LC_G E
           WHERE T.PROD_IT_NUM = E.PROD_IT_NUM
             AND T.ORG_NUM = E.ORG_NUM
             AND T.SUPPLIER_NUM = E.SUPPLIER_NUM
             AND E.SUPP_INV_QTY <> T.SUPP_INV_QTY)
     AND EXISTS
   (SELECT 1
            FROM (SELECT DISTINCT C.ITEM, C.LOC, C.SUPPLIER
                    FROM RMS.CMX_SUPP_INV_HIST@RA_RMS_DBLINK C
                   WHERE C.V_DATE = DATE '2015-05-20'
                     AND C.REFERENCE_NO1 = '20150521FIX'
                     AND NOT EXISTS (SELECT 1
                            FROM RMS.CMX_SUPP_INV@RA_RMS_DBLINK A
                           WHERE A.ITEM = C.ITEM
                             AND A.LOC = C.LOC
                             AND A.SUPPLIER = C.SUPPLIER)
                     AND NOT EXISTS
                   (SELECT 1
                            FROM RMS.CMX_SUPP_INV_HIST@RA_RMS_DBLINK B
                           WHERE B.REFERENCE_NO1 <> '20150521FIX'
                             AND B.ITEM = C.ITEM
                             AND B.LOC = C.LOC
                             AND B.SUPPLIER = C.SUPPLIER)) D
           WHERE T.PROD_IT_NUM = D.ITEM
             AND T.ORG_NUM = D.LOC
             AND T.SUPPLIER_NUM = D.SUPPLIER);

TRUNCATE TABLE RADM.BBG_RA_SUP_INV_IT_LC_DY_FS;

INSERT INTO RADM.BBG_RA_SUP_INV_IT_LC_DY_FS
  SELECT * FROM BBG_RA_SUP_INV_IT_LC_DY_FS_BAK;

--2.核对rms-ra的供应商库存,cmx_supp_inv没有的商品-地点-供应商记录,则RA库存=0.
DROP TABLE RADM.JIN_SUPP_INV_TMP;

CREATE TABLE RADM.JIN_SUPP_INV_TMP AS
  SELECT B.ITEM,
         B.LOC,
         B.SUPPLIER,
         SUM(B.SOH) SOH,
         SUM(B.WAC * B.SOH) TOTAL_COST
    FROM CMX_SUPP_INV@RA_RMS_DBLINK B
   GROUP BY B.ITEM, B.LOC, B.SUPPLIER;

create unique index PK_JIN_SUPP_INV_TMP on JIN_SUPP_INV_TMP(ITEM,
                                                            LOC,
                                                            SUPPLIER) tablespace RETAIL_DATA pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M
                                                                                                                                        minextents 1
                                                                                                                                        maxextents
                                                                                                                                        unlimited);

--差异清单
/*
三种情况:
1:RMS有 RA无 补传过去??,已修复
2:RMS无 RA有 update为0,已修复
3:RMS,RA都有,但不相等,已修复
*/
--***
--1:RMS有 RA无
DROP TABLE RADM.JIN_SUPP_INV_TMP1;
CREATE TABLE RADM.JIN_SUPP_INV_TMP1 AS
  SELECT *
    FROM RADM.JIN_SUPP_INV_TMP A
   WHERE NOT EXISTS (SELECT 1
            FROM RADM.BBG_RA_SUPP_INV_IT_LC_G B
           WHERE A.ITEM = B.PROD_IT_NUM
             AND A.LOC = B.ORG_NUM
             AND A.SUPPLIER = B.SUPPLIER_NUM);
--***
--2:RMS无 RA有 update为0
SELECT *
  FROM RADM.BBG_RA_SUPP_INV_IT_LC_G B
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.JIN_SUPP_INV_TMP A
         WHERE A.ITEM = B.PROD_IT_NUM
           AND A.LOC = B.ORG_NUM
           AND A.SUPPLIER = B.SUPPLIER_NUM)
   AND B.SUPP_INV_QTY <> 0;

--FIX BBG_RA_SUPP_INV_IT_LC_G
UPDATE /*+PARALLEL(B,20)*/ RADM.BBG_RA_SUPP_INV_IT_LC_G B
   SET B.SUPP_INV_QTY = 0, B.SUPP_INV_COST = 0
 WHERE NOT EXISTS (SELECT /*+PARALLEL(A,20)*/
         1
          FROM RADM.JIN_SUPP_INV_TMP A
         WHERE A.ITEM = B.PROD_IT_NUM
           AND A.LOC = B.ORG_NUM
           AND A.SUPPLIER = B.SUPPLIER_NUM)
   AND B.SUPP_INV_QTY <> 0;

--FIX BBG_RA_SUPP_INV_IT_LC_DY_F
UPDATE /*+PARALLEL(A,20)*/ RADM.BBG_RA_SUPP_INV_IT_LC_DY_F A
   SET A.SUPP_INV_QTY = 0, A.SUPP_INV_COST = 0
 WHERE A.TO_DT_WID = 999999999999999
   AND NOT EXISTS (SELECT /*+PARALLEL(B,20) PARALLEL(P,20) PARALLEL(O,20) PARALLEL(S,20)*/
         1
          FROM RADM.JIN_SUPP_INV_TMP B,
               RADM.W_PRODUCT_D      P,
               RADM.W_INT_ORG_D      O,
               RADM.W_PARTY_ORG_D    S
         WHERE B.LOC = O.ORG_NUM
           AND B.ITEM = P.PROD_NUM
           AND B.SUPPLIER = S.SUPPLIER_NUM
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND A.SUPPLIER_WID = S.ROW_WID);
--CHECK
SELECT SUM(B.SUPP_INV_QTY), SUM(B.SUPP_INV_COST)
  FROM RADM.BBG_RA_SUPP_INV_IT_LC_G B
 WHERE NOT EXISTS (SELECT 1
          FROM RADM.JIN_SUPP_INV_TMP A
         WHERE A.ITEM = B.PROD_IT_NUM
           AND A.LOC = B.ORG_NUM
           AND A.SUPPLIER = B.SUPPLIER_NUM)
   AND B.SUPP_INV_QTY <> 0;

SELECT SUM(A.SUPP_INV_QTY), SUM(A.SUPP_INV_COST)
  FROM RADM.BBG_RA_SUPP_INV_IT_LC_DY_F A
 WHERE A.TO_DT_WID = 999999999999999
   AND NOT EXISTS (SELECT 1
          FROM RADM.JIN_SUPP_INV_TMP B,
               RADM.W_PRODUCT_D      P,
               RADM.W_INT_ORG_D      O,
               RADM.W_PARTY_ORG_D    S
         WHERE B.LOC = O.ORG_NUM
           AND B.ITEM = P.PROD_NUM
           AND B.SUPPLIER = S.SUPPLIER_NUM
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND A.SUPPLIER_WID = S.ROW_WID);

--***
--3:RMS,RA都有,但不相等
SELECT A.ITEM,
       A.LOC,
       A.SUPPLIER,
       A.SOH           RMS_SOH,
       A.TOTAL_COST    RMS_COST,
       B.SUPP_INV_QTY  RA_SOH,
       B.SUPP_INV_COST RA_COST
  FROM RADM.JIN_SUPP_INV_TMP A, RADM.BBG_RA_SUPP_INV_IT_LC_G B
 WHERE A.ITEM = B.PROD_IT_NUM(+)
   AND A.LOC = B.ORG_NUM(+)
   AND A.SUPPLIER = B.SUPPLIER_NUM(+)
   AND A.SOH <> B.SUPP_INV_QTY;
--FIX BBG_RA_SUPP_INV_IT_LC_G
UPDATE RADM.BBG_RA_SUPP_INV_IT_LC_G A
   SET (A.SUPP_INV_QTY, A.SUPP_INV_COST) =
       (SELECT B.SOH, B.TOTAL_COST
          FROM RADM.JIN_SUPP_INV_TMP B
         WHERE A.ORG_NUM = B.LOC
           AND A.PROD_IT_NUM = B.ITEM
           AND A.SUPPLIER_NUM = B.SUPPLIER
           AND A.SUPP_INV_QTY <> B.SOH)
 WHERE EXISTS (SELECT 1
          FROM RADM.JIN_SUPP_INV_TMP C
         WHERE A.ORG_NUM = C.LOC
           AND A.PROD_IT_NUM = C.ITEM
           AND A.SUPPLIER_NUM = C.SUPPLIER
           AND A.SUPP_INV_QTY <> C.SOH);

--FIX BBG_RA_SUPP_INV_IT_LC_DY_F
UPDATE RADM.BBG_RA_SUPP_INV_IT_LC_DY_F A
   SET (A.SUPP_INV_QTY, A.SUPP_INV_COST) =
       (SELECT B.SOH, B.TOTAL_COST
          FROM RADM.JIN_SUPP_INV_TMP B,
               RADM.W_PRODUCT_D      P,
               RADM.W_INT_ORG_D      O,
               RADM.W_PARTY_ORG_D    S
         WHERE B.LOC = O.ORG_NUM
           AND B.ITEM = P.PROD_NUM
           AND B.SUPPLIER = S.SUPPLIER_NUM
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND A.SUPPLIER_WID = S.ROW_WID
           AND B.SOH <> A.SUPP_INV_QTY)
 WHERE A.TO_DT_WID = 999999999999999
   AND EXISTS (SELECT 1
          FROM RADM.JIN_SUPP_INV_TMP B,
               RADM.W_PRODUCT_D      P,
               RADM.W_INT_ORG_D      O,
               RADM.W_PARTY_ORG_D    S
         WHERE B.LOC = O.ORG_NUM
           AND B.ITEM = P.PROD_NUM
           AND B.SUPPLIER = S.SUPPLIER_NUM
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND A.SUPPLIER_WID = S.ROW_WID
           AND B.SOH <> A.SUPP_INV_QTY);

--***********************************************************************************
--RA-商品库存清理
--***********************************************************************************
--ITEM_LOC_SOH_HIST
--RADM.W_RTL_INV_IT_LC_DY_F
--RADM.W_RTL_INV_IT_LC_G

--ITEM_LOC_SOH_HIST VS W_RTL_INV_IT_LC_G
--1,RMS有,RA无,不需要清理
SELECT *
  FROM ITEM_LOC_SOH_HIST@RA_RMS_DBLINK B
 WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1)
   AND B.STOCK_ON_HAND <> 0
   AND NOT EXISTS (SELECT 1
          FROM RADM.W_RTL_INV_IT_LC_G A
         WHERE B.ITEM = A.PROD_IT_NUM
           AND B.LOC = A.ORG_NUM);

--2,RA有,RMS无
SELECT *
  FROM RADM.W_RTL_INV_IT_LC_G A
 WHERE A.INV_SOH_QTY <> 0
   AND NOT EXISTS (SELECT 1
          FROM ITEM_LOC_SOH_HIST@RA_RMS_DBLINK B
         WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1)
           AND B.ITEM = A.PROD_IT_NUM
           AND B.LOC = A.ORG_NUM);

--创建临时表
DROP TABLE RADM.ITEM_LOC_SOH_HIST_BAK;
CREATE TABLE RADM.ITEM_LOC_SOH_HIST_BAK AS
  SELECT *
    FROM ITEM_LOC_SOH_HIST@RA_RMS_DBLINK B
   WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1);

CREATE UNIQUE INDEX PK_ITEM_LOC_SOH_HIST_BAK ON ITEM_LOC_SOH_HIST_BAK(ITEM,
                                                                      LOC) tablespace RETAIL_DATA pctfree 10 initrans 2 maxtrans 255 storage(initial 64K next 1M
                                                                                                                                             minextents 1
                                                                                                                                             maxextents
                                                                                                                                             unlimited);

--FIX W_RTL_INV_IT_LC_G
UPDATE RADM.W_RTL_INV_IT_LC_G A
   SET A.INV_SOH_QTY          = 0,
       A.INV_SOH_RTL_AMT_LCL  = 0,
       A.INV_SOH_COST_AMT_LCL = 0
 WHERE A.INV_SOH_QTY <> 0
   AND NOT EXISTS (SELECT 1
          FROM RADM.ITEM_LOC_SOH_HIST_BAK B
         WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1)
           AND B.ITEM = A.PROD_IT_NUM
           AND B.LOC = A.ORG_NUM);
--FIX W_RTL_INV_IT_LC_DY_F
UPDATE RADM.W_RTL_INV_IT_LC_DY_F A
   SET A.INV_SOH_QTY          = 0,
       A.INV_SOH_RTL_AMT_LCL  = 0,
       A.INV_SOH_COST_AMT_LCL = 0
 WHERE A.TO_DT_WID = 999999999999999
   AND A.INV_SOH_QTY <> 0
   AND NOT EXISTS (SELECT 1
          FROM RADM.ITEM_LOC_SOH_HIST_BAK B,
               RADM.W_PRODUCT_D           P,
               RADM.W_INT_ORG_D           O
         WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1)
           AND B.ITEM = P.PROD_NUM
           AND B.LOC = O.ORG_NUM
           AND A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID);

--3,RMS,RA都有
SELECT B.ITEM,
       B.LOC,
       B.STOCK_ON_HAND RMS_SOH,
       B.STOCK_ON_HAND * B.AV_COST RMS_COST,
       A.INV_SOH_QTY RA_SOH,
       A.INV_AVG_COST_AMT_LCL RA_COST
  FROM RADM.W_RTL_INV_IT_LC_G A, ITEM_LOC_SOH_HIST@RA_RMS_DBLINK B
 WHERE B.SOH_BAK_DATE = TRUNC(SYSDATE - 1)
   AND B.ITEM = A.PROD_IT_NUM
   AND B.LOC = A.ORG_NUM
   AND NVL(B.STOCK_ON_HAND, 0) <> NVL(A.INV_SOH_QTY, 0);

--FIX W_RTL_INV_IT_LC_G

--FIX W_RTL_INV_IT_LC_DY_F

SELECT * FROM ITEM_LOC_SOH_HIST@RA_RMS_DBLINK;
