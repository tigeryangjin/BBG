--1.
SELECT D.ITEM, D.BUSINESS_MODE, MAX(D.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
  FROM RADM.BBG_RA_ITEM_LOC_D D
 WHERE LENGTH(D.ITEM) = 13
   AND D.CURRENT_FLG = 'Y'
   AND EXISTS (SELECT 1
          FROM (SELECT A.ITEM, COUNT(A.BUSINESS_MODE)
                  FROM (SELECT DISTINCT B.ITEM, B.BUSINESS_MODE
                          FROM RADM.BBG_RA_ITEM_LOC_D B
                         WHERE LENGTH(B.ITEM) = 13
                           AND B.CURRENT_FLG = 'Y') A
                 GROUP BY A.ITEM
                HAVING COUNT(A.BUSINESS_MODE) > 1) C
         WHERE D.ITEM = C.ITEM)
 GROUP BY D.ITEM, D.BUSINESS_MODE
 ORDER BY 1, 3;
--2.
UPDATE RADM.BBG_RA_ITEM_LOC_D E
   SET E.BUSINESS_MODE =
       (SELECT F.BUSINESS_MODE
          FROM (SELECT G.ITEM,
                       G.BUSINESS_MODE,
                       G.EFFECTIVE_FROM_DT,
                       RANK() OVER(PARTITION BY G.ITEM ORDER BY G.EFFECTIVE_FROM_DT DESC, G.BUSINESS_MODE) RANK1
                  FROM (SELECT D.ITEM,
                               D.BUSINESS_MODE,
                               MAX(D.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
                          FROM RADM.BBG_RA_ITEM_LOC_D D
                         WHERE LENGTH(D.ITEM) = 13
                           AND D.CURRENT_FLG = 'Y'
                           AND EXISTS
                         (SELECT 1
                                  FROM (SELECT A.ITEM, COUNT(A.BUSINESS_MODE)
                                          FROM (SELECT DISTINCT B.ITEM,
                                                                B.BUSINESS_MODE
                                                  FROM RADM.BBG_RA_ITEM_LOC_D B
                                                 WHERE LENGTH(B.ITEM) = 13
                                                   AND B.CURRENT_FLG = 'Y') A
                                         GROUP BY A.ITEM
                                        HAVING COUNT(A.BUSINESS_MODE) > 1) C
                                 WHERE D.ITEM = C.ITEM)
                         GROUP BY D.ITEM, D.BUSINESS_MODE) G) F
         WHERE E.ITEM = F.ITEM
           AND F.RANK1 = 1)
 WHERE EXISTS
 (SELECT 1
          FROM (SELECT G.ITEM,
                       G.BUSINESS_MODE,
                       G.EFFECTIVE_FROM_DT,
                       RANK() OVER(PARTITION BY G.ITEM ORDER BY G.EFFECTIVE_FROM_DT DESC, G.BUSINESS_MODE) RANK1
                  FROM (SELECT D.ITEM,
                               D.BUSINESS_MODE,
                               MAX(D.EFFECTIVE_FROM_DT) EFFECTIVE_FROM_DT
                          FROM RADM.BBG_RA_ITEM_LOC_D D
                         WHERE LENGTH(D.ITEM) = 13
                           AND D.CURRENT_FLG = 'Y'
                           AND EXISTS
                         (SELECT 1
                                  FROM (SELECT A.ITEM, COUNT(A.BUSINESS_MODE)
                                          FROM (SELECT DISTINCT B.ITEM,
                                                                B.BUSINESS_MODE
                                                  FROM RADM.BBG_RA_ITEM_LOC_D B
                                                 WHERE LENGTH(B.ITEM) = 13
                                                   AND B.CURRENT_FLG = 'Y') A
                                         GROUP BY A.ITEM
                                        HAVING COUNT(A.BUSINESS_MODE) > 1) C
                                 WHERE D.ITEM = C.ITEM)
                         GROUP BY D.ITEM, D.BUSINESS_MODE) G) H
         WHERE E.ITEM = H.ITEM
           AND E.EFFECTIVE_FROM_DT = H.EFFECTIVE_FROM_DT
           AND E.BUSINESS_MODE = H.BUSINESS_MODE
           AND H.RANK1 <> 1)
   AND E.CURRENT_FLG = 'Y'
   AND LENGTH(E.ITEM) = 13;
--3.
SELECT *
  FROM RADM.BBG_RA_ITEM_LOC_D T
 WHERE T.ITEM = '2400071022670'
   AND T.CURRENT_FLG = 'Y'
 ORDER BY T.EFFECTIVE_FROM_DT;
--4.

--5.

SELECT DISTINCT LENGTH(T.ITEM) FROM RADM.BBG_RA_ITEM_LOC_D T;
SELECT * FROM RADM.BBG_RA_ITEM_LOC_D T WHERE LENGTH(T.ITEM)<>13 AND LENGTH(T.ITEM)<>9 ORDER BY T.ITEM;
