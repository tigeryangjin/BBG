--1.取成本有问题的商品-地点，准确的AV_COST=472.080866666667
SELECT *
  FROM TRAN_DATA_HISTORY T
 WHERE T.TRAN_DATE = DATE '2016-10-10'
   AND T.LOCATION = 130007
   AND T.ITEM = '103461694'
   AND T.TRAN_CODE = 3;

--2.AV_COST
--103461694有问题
--102222712没有问题
SELECT *
  FROM (SELECT B.TRAN_DATE,
               B.TRAN_CODE,
               B.ITEM,
               B.LOCATION,
               B.QTY,
               B.AMT,
               B.COST,
               B.AV_COST,
               B.AV_COST_NEW
          FROM (SELECT A.TRAN_DATE,
                       A.TRAN_CODE,
                       A.ITEM,
                       A.LOCATION,
                       A.QTY,
                       A.AMT,
                       A.COST,
                       A.AV_COST,
                       A.AV_COST_NEW,
											 RANK() OVER(PARTITION BY A.TRAN_DATE, A.ITEM, A.LOCATION ORDER BY A.TRAN_CODE DESC) RANK1
                  FROM (SELECT T.TRAN_DATE,
                               T.TRAN_CODE,
                               T.ITEM,
                               T.LOCATION,
                               SUM(T.UNITS) QTY,
                               SUM(T.TOTAL_RETAIL / (1 + (CASE
                                     WHEN T.TRAN_CODE = 3 THEN
                                      T.VAT_RATE / 100
                                     ELSE
                                      0
                                   END))) AMT,
                               SUM(T.TOTAL_COST / (1 + (CASE
                                     WHEN T.TRAN_CODE = 3 THEN
                                      (SELECT VAT_RATE / 100
                                         FROM VAT_ITEM
                                        WHERE ACTIVE_DATE =
                                              (SELECT MAX(V.ACTIVE_DATE)
                                                 FROM VAT_ITEM V
                                                WHERE V.ITEM = T.ITEM
                                                  AND V.VAT_REGION = 1000
                                                  AND V.VAT_TYPE IN ('C', 'B')
                                                  AND V.ACTIVE_DATE <= T.TRAN_DATE)
                                          AND ITEM = T.ITEM
                                          AND VAT_REGION = 1000
                                          AND VAT_TYPE IN ('C', 'B'))
                                     ELSE
                                      0
                                   END))) COST,
                               SUM(T.TOTAL_COST / (1 + (CASE
                                     WHEN T.TRAN_CODE = 3 THEN
                                      (SELECT VAT_RATE / 100
                                         FROM VAT_ITEM
                                        WHERE ACTIVE_DATE =
                                              (SELECT MAX(V.ACTIVE_DATE)
                                                 FROM VAT_ITEM V
                                                WHERE V.ITEM = T.ITEM
                                                  AND V.VAT_REGION = 1000
                                                  AND V.VAT_TYPE IN ('C', 'B')
                                                  AND V.ACTIVE_DATE <= T.TRAN_DATE)
                                          AND ITEM = T.ITEM
                                          AND VAT_REGION = 1000
                                          AND VAT_TYPE IN ('C', 'B'))
                                     ELSE
                                      0
                                   END))) / SUM(ABS(T.UNITS)) AV_COST,
                               SUM(T.TOTAL_COST / (1 + (CASE
                                     WHEN T.TRAN_CODE = 3 THEN
                                      (SELECT VAT_RATE / 100
                                         FROM VAT_ITEM
                                        WHERE ACTIVE_DATE =
                                              (SELECT MAX(V.ACTIVE_DATE)
                                                 FROM VAT_ITEM V
                                                WHERE V.ITEM = T.ITEM
                                                  AND V.VAT_REGION = 1000
                                                  AND V.VAT_TYPE IN ('C', 'B')
                                                  AND V.ACTIVE_DATE <= T.TRAN_DATE)
                                          AND ITEM = T.ITEM
                                          AND VAT_REGION = 1000
                                          AND VAT_TYPE IN ('C', 'B'))
                                     ELSE
                                      0
                                   END))) / ABS(SUM(T.UNITS)) AV_COST_NEW
                          FROM RMS.TRAN_DATA_HISTORY T
                         WHERE T.TRAN_CODE = 3
                              --AND T.TRAN_DATE = get_vdate - 1
                           AND T.TRAN_DATE = DATE '2016-10-10'
                         GROUP BY T.TRAN_DATE, T.TRAN_CODE, T.ITEM, T.LOCATION
                        UNION ALL
                        SELECT ITD.TRAN_DATE,
                               ITD.TRAN_CODE,
                               ITD.ITEM,
                               ITD.LOCATION,
                               SUM(ITD.UNITS) QTY,
                               SUM(ITD.TOTAL_RETAIL) AMT,
                               SUM(ITD.TOTAL_COST) COST,
                               AVG(ITD.TOTAL_COST / ITD.UNITS) AV_COST,
                               AVG(ITD.TOTAL_COST / ITD.UNITS) AV_COST_NEW
                          FROM RMS.TRAN_DATA_HISTORY ITD
                         WHERE ITD.TRAN_CODE = 2
                              --AND ITD.TRAN_DATE = get_vdate - 1
                           AND ITD.TRAN_DATE = DATE '2016-10-10'
                         GROUP BY ITD.TRAN_DATE,
                                  ITD.TRAN_CODE,
                                  ITD.ITEM,
                                  ITD.LOCATION) A) B
         WHERE B.RANK1 = 1) C
 WHERE C.ITEM = '103461694'
   AND C.LOCATION = '130007';

--3.需要用ABS的例子，
SELECT /*+PARALLEL(32)*/
 *
  FROM TRAN_DATA_HISTORY T
 WHERE T.TRAN_DATE = DATE '2016-10-10'
   AND T.TRAN_CODE IN (1, 2, 3)
   AND T.LOCATION = 120173
   AND T.ITEM = '101730580';

--4.
SELECT /*+PARALLEL(32)*/
 *
  FROM RADM.W_RTL_SLS_TRX_IT_LC_DY_F T
 WHERE T.DT_WID = 120161010000
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_D O
         WHERE T.ORG_WID = O.ROW_WID
           AND O.ORG_NUM = '12064')
   AND EXISTS (SELECT 1
          FROM RADM.W_PRODUCT_D P
         WHERE T.PROD_WID = P.ROW_WID
           AND P.PROD_NUM = '800217605');

--5.
SELECT * FROM RA_RMS.BBG_RA_ITEM_LOC_SOH_V;

--6.
SELECT *
  FROM (SELECT /*+PARALLEL(32)*/
         T.ITEM, T.LOCATION, SUM(T.UNITS) UNITS
          FROM TRAN_DATA_HISTORY T
         WHERE T.TRAN_DATE = DATE '2016-10-10'
           AND T.TRAN_CODE = 3
         GROUP BY T.ITEM, T.LOCATION) A
 WHERE A.UNITS < 0;

SELECT /*+PARALLEL(32)*/
 *
  FROM TRAN_DATA_HISTORY T
 WHERE T.TRAN_DATE = DATE '2016-10-10'
   AND T.TRAN_CODE = 3
   AND T.ITEM = '800217605'
   AND T.LOCATION = '120164';
