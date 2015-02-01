--月份\门店\会员卡号\消费金额\来客数\客单
SELECT COUNT(DISTINCT T.HYID)
  FROM RADM.HYXFJL T
 WHERE T.JZRQ BETWEEN DATE '2013-01-01' AND DATE '2014-03-31';

SELECT SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
       T.MDID,
       T.HYID,
       SUM(T.JE) AMT,
       COUNT(T.HYID) CNT
  FROM RADM.HYXFJL T
 WHERE T.SHDM = 'CS'
   AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE '2014-03-31'
 GROUP BY SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6), T.MDID, T.HYID;

--REPORT 1
CREATE MATERIALIZED VIEW RADM.YJ_VIP_SLS_CNT AS
  SELECT VS.MONTH 月份,
         SUBSTR(MD.MDDM, 3, 6) 门店编码,
         HY.HYK_NO 会员卡号,
         VS.AMT 消费金额,
         VS.CNT 来客数,
         ROUND(VS.AMT / VS.CNT, 2) 客单价
    FROM (SELECT SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
                 T.MDID,
                 T.HYID,
                 SUM(T.JE) AMT,
                 COUNT(T.HYID) CNT
            FROM RADM.HYXFJL T
           WHERE T.SHDM = 'CS'
             AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE
           '2014-07-31'
           GROUP BY SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6),
                    T.MDID,
                    T.HYID) VS,
         RADM.MDDY MD,
         RADM.HYK_HYXX HY
   WHERE VS.MDID = MD.MDID
     AND VS.HYID = HY.HYID;
		 
--REPORT 2 会员消费档汇总
DROP MATERIALIZED VIEW RADM.YJ_VIP_SLS_CNT_1;
CREATE MATERIALIZED VIEW RADM.YJ_VIP_SLS_CNT_1 AS
 SELECT C.MONTH 月份,
        C.DSC1  消费档,
        C.AMT   消费金额,
        C.CNT   消费来客数,
        D.HYCNT 会员数
   FROM (SELECT B.MONTH, B.DSC1, SUM(B.AMT) AMT, SUM(B.CNT) CNT
           FROM (SELECT T.XFJLID,
                        T.HYID,
                        SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
                        T.JE AMT,
                        1 CNT,
                        DQ.DSC1
                   FROM RADM.HYXFJL T, RADM.BBG_RA_SLS_SEGMENT_D DQ
                  WHERE T.JE BETWEEN DQ.LOW AND DQ.HIGH
                    AND T.SHDM = 'CS'
                    AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE
                  '2014-07-31') B
          GROUP BY B.MONTH, B.DSC1) C,
        (SELECT A.MONTH, A.DSC1, SUM(A.HYCNT) HYCNT
           FROM (SELECT DISTINCT T.HYID,
                                 SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
                                 DQ.DSC1,
                                 1 HYCNT
                   FROM RADM.HYXFJL T, RADM.BBG_RA_SLS_SEGMENT_D DQ
                  WHERE T.JE BETWEEN DQ.LOW AND DQ.HIGH
                    AND T.SHDM = 'CS'
                    AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE
                  '2014-07-31'
                  GROUP BY T.HYID,
                           SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6),
                           DQ.DSC1) A
          GROUP BY A.MONTH, A.DSC1) D
  WHERE C.MONTH = D.MONTH
    AND C.DSC1 = D.DSC1;
						
--消费来客数
SELECT B.MONTH, B.DSC1, SUM(B.AMT) AMT, SUM(B.CNT) CNT
  FROM (SELECT T.XFJLID,
               T.HYID,
               SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
               T.JE AMT,
               1 CNT,
               DQ.DSC1
          FROM RADM.HYXFJL T, RADM.BBG_RA_SLS_SEGMENT_D DQ
         WHERE T.JE BETWEEN DQ.LOW AND DQ.HIGH
           AND T.SHDM = 'CS'
           AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE '2014-07-31') B
 GROUP BY B.MONTH, B.DSC1;
--会员数
SELECT A.MONTH, A.DSC1, SUM(A.HYCNT) HYCNT
  FROM (SELECT DISTINCT T.HYID,
                        SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6) MONTH,
                        DQ.DSC1,
                        1 HYCNT
          FROM RADM.HYXFJL T, RADM.BBG_RA_SLS_SEGMENT_D DQ
         WHERE T.JE BETWEEN DQ.LOW AND DQ.HIGH
           AND T.SHDM = 'CS'
           AND T.JZRQ BETWEEN DATE '2013-01-01' AND DATE '2014-07-31'
         GROUP BY T.HYID, SUBSTR(TO_CHAR(T.JZRQ, 'YYYYMMDD'), 1, 6), DQ.DSC1) A
 GROUP BY A.MONTH, A.DSC1;
