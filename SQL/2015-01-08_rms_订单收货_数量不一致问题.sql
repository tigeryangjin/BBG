--A
SELECT *
  FROM (SELECT A.ORDER_NO,
               A.ITEM,
               A.QTY_PRESCALED,
               A.QTY_CANCELLED,
               SUM(A.QTY_RECEIVED) QTY_RECEIVED
          FROM (SELECT H.ORDER_NO,
                       M.SHIPMENT,
                       L.ITEM,
                       L.QTY_PRESCALED,
                       L.QTY_CANCELLED,
                       M.RECEIVE_DATE,
                       S.QTY_RECEIVED
                  FROM ORDHEAD H, ORDLOC L, SHIPMENT M, SHIPSKU S
                 WHERE H.ORDER_NO = L.ORDER_NO
                   AND H.ORDER_NO = M.ORDER_NO
                   AND M.SHIPMENT = S.SHIPMENT
                   AND L.ITEM = S.ITEM
									 AND H.STATUS='C'
                   AND EXISTS
                 (SELECT T1.ORDER_NO, COUNT(*)
                          FROM ORDHEAD T1, SHIPMENT T2
                         WHERE T1.ORDER_NO = T2.ORDER_NO
                           AND T1.ORDER_NO = H.ORDER_NO
                           AND T1.ORIG_APPROVAL_DATE > DATE '2014-10-01'
                         GROUP BY T1.ORDER_NO
                        HAVING COUNT(*) = 1)) A
         GROUP BY A.ORDER_NO, A.ITEM, A.QTY_PRESCALED, A.QTY_CANCELLED
        /*HAVING COUNT(A.RECEIVE_DATE) > 1*/) B
 WHERE B.QTY_PRESCALED <>  B.QTY_RECEIVED;

--FULL
SELECT * FROM ORDHEAD T WHERE T.ORDER_NO = &ORDER_NO;
SELECT *
  FROM ORDLOC T
 WHERE T.ORDER_NO = &ORDER_NO
   AND T.ITEM = &ITEM;
SELECT * FROM SHIPMENT T WHERE T.ORDER_NO = &ORDER_NO;
SELECT *
  FROM SHIPSKU T
 WHERE EXISTS (SELECT 1
          FROM SHIPMENT S
         WHERE T.SHIPMENT = S.SHIPMENT
           AND S.ORDER_NO = &ORDER_NO)
   AND T.ITEM = &ITEM;
