--�·�\�ŵ�\��Ա����\���ѽ��\������\�͵�
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
  SELECT VS.MONTH �·�,
         SUBSTR(MD.MDDM, 3, 6) �ŵ����,
         HY.HYK_NO ��Ա����,
         VS.AMT ���ѽ��,
         VS.CNT ������,
         ROUND(VS.AMT / VS.CNT, 2) �͵���
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
		 
--REPORT 2 ��Ա���ѵ�����
DROP MATERIALIZED VIEW RADM.YJ_VIP_SLS_CNT_1;
CREATE MATERIALIZED VIEW RADM.YJ_VIP_SLS_CNT_1 AS
 SELECT C.MONTH �·�,
        C.DSC1  ���ѵ�,
        C.AMT   ���ѽ��,
        C.CNT   ����������,
        D.HYCNT ��Ա��
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
						
--����������
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
--��Ա��
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
