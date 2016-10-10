--0.����׼��
--CREATE TABLE BBG_ORDER_VIP_TMP AS
SELECT H.ORDERID,
       H.BUYERMOBILE,
       TO_DATE(SUBSTR(H.ORDERSTATUSTIME, 1, 10), 'YYYY-MM-DD') ORDER_DATE,
       H.ORDERTOTALMONEY,
       D.ORDER_QTY,
       (SELECT NVL(MAX(1), 0)
          FROM BBG_JDDJ_VIP_BIRTHDAY V
         WHERE H.BUYERMOBILE = V.PHONE_NUMBER) ISVIP
  FROM ORDER_HDR_120036 H,
       (SELECT T.ORDERID, SUM(T.SKUCOUNT) ORDER_QTY
          FROM ORDER_DTL T
         GROUP BY T.ORDERID) D
 WHERE H.ORDERID = D.ORDERID
   AND H.BBGORDERSTATUS = 10;

--���������м���Ƶ�RADM��   
DROP TABLE RADM.ORDER_HDR_120036;
CREATE TABLE RADM.ORDER_HDR_120036 AS
  SELECT * FROM ORDER_HDR@RA_JDDJ;

DROP TABLE RADM.ORDER_TDL_120036;
CREATE TABLE RADM.ORDER_TDL_120036 AS
  SELECT * FROM ORDER_TDL@RA_JDDJ;

--1.������������
--1.0���ද����Ʒ
SELECT P.PROD_DP_NUM �������,
       COUNT(JD.SKUIDISV) ��Ʒ��,
       SUM(JD.SALES_AMT) ���۽��
  FROM (SELECT D.SKUIDISV, SUM(D.SKUJDPRICE * D.SKUCOUNT) SALES_AMT
          FROM RADM.ORDER_HDR_120036 H, RADM.ORDER_DTL_120036 D
         WHERE D.ORDERID = H.ORDERID
           AND TO_DATE(SUBSTR(H.ORDERSTATUSTIME, 1, 10), 'YYYY-MM-DD') <= DATE
         '2016-09-20'
           AND H.BBGORDERSTATUS = 10
         GROUP BY D.SKUIDISV) JD,
       RABATCHER.W_PRODUCT_D_RTL_TMP P
 WHERE JD.SKUIDISV = P.PROD_IT_NUM
   AND P.CURRENT_FLG = 'Y'
 GROUP BY P.PROD_DP_NUM
 ORDER BY 1;
--1.1��������
SELECT SUM(A.ORDERTOTALMONEY) ���������۶�,
       COUNT(A.ORDERID) ���϶�����,
       COUNT(DISTINCT A.BUYERMOBILE) �˿�����,
       SUM(A.ORDERTOTALMONEY) / COUNT(A.ORDERID) �͵���
  FROM BBG_ORDER_VIP_TMP A
 WHERE A.ORDER_DATE <= DATE '2016-09-20';

--1.2��Ա����
SELECT SUM(A.ORDERTOTALMONEY) ���ϻ�Ա���۶�,
       COUNT(A.ORDERID) ���ϻ�Ա������,
       COUNT(DISTINCT A.BUYERMOBILE) ��Ա����,
       SUM(A.ORDERTOTALMONEY) / COUNT(A.ORDERID) ��Ա�͵���
  FROM BBG_ORDER_VIP_TMP A
 WHERE A.ORDER_DATE <= DATE '2016-09-20'
   AND A.ISVIP = 1;

--1.3����ʱ������ͳ��
SELECT TO_CHAR(TO_DATE(T.ORDERSTATUSTIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24') ʱ��,
       COUNT(T.ORDERID) ���Ͻ��ױ���,
       RATIO_TO_REPORT(COUNT(T.ORDERID)) OVER() ����ռ��,
       SUM(T.ORDERTOTALMONEY) ���Ͻ��׽��,
       RATIO_TO_REPORT(SUM(T.ORDERTOTALMONEY)) OVER() ���ռ��
  FROM ORDER_HDR_120036 T
 WHERE TO_DATE(SUBSTR(T.ORDERSTATUSTIME, 1, 10), 'YYYY-MM-DD') BETWEEN DATE
 '2016-08-23'
   AND DATE '2016-09-11'
   AND T.BBGORDERSTATUS = 10
 GROUP BY TO_CHAR(TO_DATE(T.ORDERSTATUSTIME, 'YYYY-MM-DD HH24:MI:SS'),
                  'HH24')
 ORDER BY 1;

--1.4���Ϲ���Ƶ��
SELECT B.FREQUENCY �������Ϲ���Ƶ��,
       COUNT(B.BUYERMOBILE) ��������,
       RATIO_TO_REPORT(COUNT(B.BUYERMOBILE)) OVER() ����ռ��,
       SUM(B.ORDER_AMT) ������,
       RATIO_TO_REPORT(SUM(B.ORDER_AMT)) OVER() ���ռ��
  FROM (SELECT A.BUYERMOBILE,
               A.ISVIP,
               COUNT(1) FREQUENCY,
               SUM(A.ORDERTOTALMONEY) ORDER_AMT
          FROM BBG_ORDER_VIP_TMP A
         WHERE A.ORDER_DATE <= DATE '2016-09-20'
         GROUP BY A.BUYERMOBILE, A.ISVIP) B
 GROUP BY B.FREQUENCY
 ORDER BY 1;

SELECT B.FREQUENCY ��Ա���Ϲ���Ƶ��,
       COUNT(B.BUYERMOBILE) ��Ա��������,
       RATIO_TO_REPORT(COUNT(B.BUYERMOBILE)) OVER() ����ռ��,
       SUM(B.ORDER_AMT) ��Ա������,
       RATIO_TO_REPORT(SUM(B.ORDER_AMT)) OVER() ���ռ��
  FROM (SELECT A.BUYERMOBILE,
               A.ISVIP,
               COUNT(1) FREQUENCY,
               SUM(A.ORDERTOTALMONEY) ORDER_AMT
          FROM BBG_ORDER_VIP_TMP A
         WHERE A.ISVIP = 1
           AND A.ORDER_DATE <= DATE '2016-09-20'
         GROUP BY A.BUYERMOBILE, A.ISVIP) B
 GROUP BY B.FREQUENCY
 ORDER BY 1;

--2.��Ա�������
--2.1���Ϲ���
--2.1.1��Ա�Ա�
SELECT T.GENDER �Ա�,
       COUNT(T.CARD_NUM) ����,
       RATIO_TO_REPORT(COUNT(T.CARD_NUM)) OVER() ռ��
  FROM BBG_JDDJ_VIP_BIRTHDAY T
 GROUP BY T.GENDER;

--2.1.2���� 
SELECT TRUNC(T.AGE, -1) �����,
       COUNT(T.PHONE_NUMBER) ����,
       RATIO_TO_REPORT(COUNT(T.PHONE_NUMBER)) OVER() ռ��
  FROM BBG_JDDJ_VIP_BIRTHDAY T
 GROUP BY TRUNC(T.AGE, -1)
 ORDER BY 1;

--******************************************************************************
--2.2���¹������
--******************************************************************************
--2.2.1���ϻ�Ա���¹�������
SELECT COUNT(DISTINCT A.HYK_NO) ��Ա���¹�������,
       COUNT(A.SLS_TRX_ID) ���ױ���,
       SUM(A.SLS_AMT_LCL - A.RET_AMT_LCL) ������
  FROM RADM.BBG_RA_RFM_VIP_F A
 WHERE EXISTS (SELECT 1
          FROM RADM.BBG_JDDJ_VIP_BIRTHDAY B
         WHERE A.HYK_NO = B.CARD_NUM
           AND B.CARD_NUM NOT IN ('006066135352',
                                  '006064858772',
                                  '006061488200',
                                  '006064860097',
                                  '006062619094',
                                  '006062619737',
                                  '006064377037',
                                  '006061489501',
                                  '006061493854',
                                  '006063373398',
                                  '006061493968',
                                  '006065255479',
                                  '006061486678',
                                  '006062615508',
                                  '006061490546',
                                  '006061488499',
                                  '006061475417',
                                  '006064860030',
                                  '006064860368',
                                  '030020053794'))
   AND A.DT_WID BETWEEN 120140101000 AND 120160920000;

--2.2.2���ϻ�Ա���¹������������ͳ��
SELECT /*+PARALLEL(16)*/
 TRUNC(V.AGE, -1) �����,
 COUNT(DISTINCT V.CARD_NUM) ��Ա���¹�������,
 COUNT(R.SLS_TRX_ID) ���ױ���,
 RATIO_TO_REPORT(COUNT(DISTINCT V.CARD_NUM)) OVER() ����ռ��,
 SUM(R.SLS_AMT_LCL - R.RET_AMT_LCL) ������,
 RATIO_TO_REPORT(SUM(R.SLS_AMT_LCL - R.RET_AMT_LCL)) OVER() ���ռ��
  FROM RADM.BBG_JDDJ_VIP_BIRTHDAY V, RADM.BBG_RA_RFM_VIP_F R
 WHERE V.CARD_NUM = R.HYK_NO
   AND R.DT_WID BETWEEN 120140101000 AND 120160920000
   AND V.CARD_NUM NOT IN ('006066135352',
                          '006064858772',
                          '006061488200',
                          '006064860097',
                          '006062619094',
                          '006062619737',
                          '006064377037',
                          '006061489501',
                          '006061493854',
                          '006063373398',
                          '006061493968',
                          '006065255479',
                          '006061486678',
                          '006062615508',
                          '006061490546',
                          '006061488499',
                          '006061475417',
                          '006064860030',
                          '006064860368',
                          '030020053794')
 GROUP BY TRUNC(V.AGE, -1)
 ORDER BY 1;

--2.2.3���¹���Ƶ��
SELECT D.TRAN_COUNT ����Ƶ��,
       COUNT(D.HYK_NO) ��Ա����,
       SUM(D.SALES_AMT) ������
  FROM (SELECT C.HYK_NO,
               COUNT(C.SLS_TRX_ID) TRAN_COUNT,
               SUM(C.SALES_AMT) SALES_AMT
          FROM (SELECT /*+PARALLEL(16)*/
                 A.HYK_NO,
                 A.SLS_TRX_ID,
                 A.SLS_AMT_LCL - A.RET_AMT_LCL SALES_AMT
                  FROM RADM.BBG_RA_RFM_VIP_F A
                 WHERE EXISTS
                 (SELECT /*+PARALLEL(16)*/
                         1
                          FROM RADM.BBG_JDDJ_VIP_BIRTHDAY B
                         WHERE A.HYK_NO = B.CARD_NUM
                           AND B.CARD_NUM NOT IN
                               ('006066135352',
                                '006064858772',
                                '006061488200',
                                '006064860097',
                                '006062619094',
                                '006062619737',
                                '006064377037',
                                '006061489501',
                                '006061493854',
                                '006063373398',
                                '006061493968',
                                '006065255479',
                                '006061486678',
                                '006062615508',
                                '006061490546',
                                '006061488499',
                                '006061475417',
                                '006064860030',
                                '006064860368',
                                '030020053794'))
                   AND A.DT_WID BETWEEN 120140101000 AND 120160920000) C
         GROUP BY C.HYK_NO) D
 GROUP BY D.TRAN_COUNT
 ORDER BY 1;

--2.2.4��������ι���
SELECT A.MONTH �·�,
       A.AGE_GROUP �����,
       SUM(A.TRAN_COUNT) ���ױ���,
       SUM(A.SALES_AMT) ���׽��
  FROM (SELECT T.HYK_NO,
               SUBSTR(T.DT_WID, 2, 6) MONTH,
               TRUNC(V.AGE, -1) AGE_GROUP,
               COUNT(T.SLS_TRX_ID) TRAN_COUNT,
               SUM(T.SLS_AMT_LCL - T.RET_AMT_LCL) SALES_AMT
          FROM RADM.BBG_RA_RFM_VIP_F T, RADM.BBG_JDDJ_VIP_BIRTHDAY V
         WHERE T.HYK_NO = V.CARD_NUM
           AND T.DT_WID BETWEEN 120150901000 AND 120160911000
           AND V.CARD_NUM NOT IN ('006066135352',
                                  '006064858772',
                                  '006061488200',
                                  '006064860097',
                                  '006062619094',
                                  '006062619737',
                                  '006064377037',
                                  '006061489501',
                                  '006061493854',
                                  '006063373398',
                                  '006061493968',
                                  '006065255479',
                                  '006061486678',
                                  '006062615508',
                                  '006061490546',
                                  '006061488499',
                                  '006061475417',
                                  '006064860030',
                                  '006064860368',
                                  '030020053794')
         GROUP BY T.HYK_NO, SUBSTR(T.DT_WID, 2, 6), TRUNC(V.AGE, -1)) A
 GROUP BY A.MONTH, A.AGE_GROUP
 ORDER BY 1, 2;

SELECT A.MONTH �·�, A.AGE_GROUP �����, COUNT(A.HYK_NO) ��Ա����
  FROM (SELECT /*+PARALLEL(16)*/
         T.HYK_NO,
         SUBSTR(T.DT_WID, 2, 6) MONTH,
         TRUNC(V.AGE, -1) AGE_GROUP,
         COUNT(T.SLS_TRX_ID) TRAN_COUNT,
         SUM(T.SLS_AMT_LCL - T.RET_AMT_LCL) SALES_AMT
          FROM RADM.BBG_RA_RFM_VIP_F T, RADM.BBG_JDDJ_VIP_BIRTHDAY V
         WHERE T.HYK_NO = V.CARD_NUM
           AND T.DT_WID BETWEEN 120140101000 AND 120160920000
           AND V.CARD_NUM NOT IN ('006066135352',
                                  '006064858772',
                                  '006061488200',
                                  '006064860097',
                                  '006062619094',
                                  '006062619737',
                                  '006064377037',
                                  '006061489501',
                                  '006061493854',
                                  '006063373398',
                                  '006061493968',
                                  '006065255479',
                                  '006061486678',
                                  '006062615508',
                                  '006061490546',
                                  '006061488499',
                                  '006061475417',
                                  '006064860030',
                                  '006064860368',
                                  '030020053794')
         GROUP BY T.HYK_NO, SUBSTR(T.DT_WID, 2, 6), TRUNC(V.AGE, -1)) A
 GROUP BY A.MONTH, A.AGE_GROUP
 ORDER BY 1, 2;

--3.����������ڷ���
--3.1��������������ڷ���
SELECT SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6) ��������·�,
       COUNT(A.HYK_NO) ��Ա����
  FROM (SELECT /*+PARALLEL(16)*/
         T.HYK_NO, MAX(TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) MAXDATE
          FROM RADM.BBG_RA_RFM_VIP_F T, RADM.BBG_JDDJ_VIP_BIRTHDAY V
         WHERE T.HYK_NO = V.CARD_NUM
           AND T.DT_WID BETWEEN 120140101000 AND 120160920000
           AND V.CARD_NUM NOT IN ('006066135352',
                                  '006064858772',
                                  '006061488200',
                                  '006064860097',
                                  '006062619094',
                                  '006062619737',
                                  '006064377037',
                                  '006061489501',
                                  '006061493854',
                                  '006063373398',
                                  '006061493968',
                                  '006065255479',
                                  '006061486678',
                                  '006062615508',
                                  '006061490546',
                                  '006061488499',
                                  '006061475417',
                                  '006064860030',
                                  '006064860368',
                                  '030020053794')
         GROUP BY T.HYK_NO) A
 GROUP BY SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6)
 ORDER BY 1, 2;

--3.2�����������������ڷ���
SELECT A.AGE_GROUP �����,
       SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6) ��������·�,
       COUNT(A.HYK_NO) ��Ա����
  FROM (SELECT /*+PARALLEL(16)*/
         T.HYK_NO,
         TRUNC(V.AGE, -1) AGE_GROUP,
         MAX(TO_DATE(SUBSTR(T.DT_WID, 2, 8), 'YYYYMMDD')) MAXDATE
          FROM RADM.BBG_RA_RFM_VIP_F T, RADM.BBG_JDDJ_VIP_BIRTHDAY V
         WHERE T.HYK_NO = V.CARD_NUM
           AND T.DT_WID BETWEEN 120140101000 AND 120160920000
           AND V.CARD_NUM NOT IN ('006066135352',
                                  '006064858772',
                                  '006061488200',
                                  '006064860097',
                                  '006062619094',
                                  '006062619737',
                                  '006064377037',
                                  '006061489501',
                                  '006061493854',
                                  '006063373398',
                                  '006061493968',
                                  '006065255479',
                                  '006061486678',
                                  '006062615508',
                                  '006061490546',
                                  '006061488499',
                                  '006061475417',
                                  '006064860030',
                                  '006064860368',
                                  '030020053794')
         GROUP BY T.HYK_NO, TRUNC(V.AGE, -1)) A
 GROUP BY SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6), A.AGE_GROUP
 ORDER BY 1, 2;
