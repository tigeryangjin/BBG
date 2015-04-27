SELECT O.ORG_NUM,
       ABS(SUM(T.TRANSFER_QTY)) TRANSFER_QTY,
       ABS(SUM(T.TRANSFER_COST)) TRANSFER_COST
  FROM RADM.BBG_RA_INVTSF_IT_LC_DY_F T,
       RADM.W_PRODUCT_D              P,
       RADM.W_INT_ORG_D              O
 WHERE T.PROD_WID = P.ROW_WID
   AND T.TO_ORG_WID = O.ROW_WID
   AND EXISTS (SELECT 1
          FROM RADM.W_PRODUCT_D P
         WHERE T.PROD_WID = P.ROW_WID
           AND P.PROD_NUM = '800032738')
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_D O
         WHERE T.ORG_WID = O.ROW_WID
           AND O.ORG_NUM = '118001')
   AND T.DT_WID BETWEEN 120130101000 AND 120130930000
   AND T.BBG_REFERENCE_DO1 = 'OUT'
   AND O.ORG_NUM IN ('120043',
                     '120044',
                     '120073',
                     '120088',
                     '120092',
                     '120111',
                     '120127',
                     '120138',
                     '120148',
                     '120152',
                     '120174',
                     '120180',
                     '120197',
                     '120198',
                     '120218')
 GROUP BY O.ORG_NUM
 ORDER BY O.ORG_NUM;

SELECT T.*
  FROM RADM.BBG_RA_INVTSF_IT_LC_DY_F T,
       RADM.W_PRODUCT_D              P,
       RADM.W_INT_ORG_D              O
 WHERE T.PROD_WID = P.ROW_WID
   AND T.TO_ORG_WID = O.ROW_WID
   AND EXISTS (SELECT 1
          FROM RADM.W_PRODUCT_D P
         WHERE T.PROD_WID = P.ROW_WID
           AND P.PROD_NUM = '800032738')
   AND EXISTS (SELECT 1
          FROM RADM.W_INT_ORG_D O
         WHERE T.ORG_WID = O.ROW_WID
           AND O.ORG_NUM = '118001')
   AND T.DT_WID BETWEEN 120130101000 AND 120130930000
   AND T.BBG_REFERENCE_DO1 = 'IN'
   AND O.ORG_NUM IN ('120043',
                     '120044',
                     '120073',
                     '120088',
                     '120092',
                     '120111',
                     '120127',
                     '120138',
                     '120148',
                     '120152',
                     '120174',
                     '120180',
                     '120197',
                     '120198',
                     '120218')
 --GROUP BY O.ORG_NUM
 ORDER BY O.ORG_NUM;

SELECT *
  FROM RADM.BBG_RA_INVTSF_REF T
 WHERE T.ITEM = 800032738
   AND T.FROM_LOC = 118001;
SELECT DISTINCT T.TO_LOC
  FROM RADM.BBG_RA_INVTSF_REF T
 WHERE T.ITEM = 800032738
   AND T.DAY_DT > DATE '2013-01-01'
   AND T.FROM_LOC = 118001;

SELECT * FROM BBG_RA_INVTSF_IT_LC_DY_F;
