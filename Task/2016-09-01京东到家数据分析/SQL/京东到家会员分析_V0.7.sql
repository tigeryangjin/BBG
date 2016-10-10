--0.数据准备
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

--京东到家中间层移到RADM中   
DROP TABLE RADM.ORDER_HDR_120036;
CREATE TABLE RADM.ORDER_HDR_120036 AS
  SELECT * FROM ORDER_HDR@RA_JDDJ;

DROP TABLE RADM.ORDER_TDL_120036;
CREATE TABLE RADM.ORDER_TDL_120036 AS
  SELECT * FROM ORDER_TDL@RA_JDDJ;

--1.基础交易数据
--1.0大类动销单品
SELECT P.PROD_DP_NUM 大类编码,
       COUNT(JD.SKUIDISV) 单品数,
       SUM(JD.SALES_AMT) 销售金额
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
--1.1整体销售
SELECT SUM(A.ORDERTOTALMONEY) 线上总销售额,
       COUNT(A.ORDERID) 线上订单数,
       COUNT(DISTINCT A.BUYERMOBILE) 顾客总数,
       SUM(A.ORDERTOTALMONEY) / COUNT(A.ORDERID) 客单价
  FROM BBG_ORDER_VIP_TMP A
 WHERE A.ORDER_DATE <= DATE '2016-09-20';

--1.2会员销售
SELECT SUM(A.ORDERTOTALMONEY) 线上会员销售额,
       COUNT(A.ORDERID) 线上会员订单数,
       COUNT(DISTINCT A.BUYERMOBILE) 会员总数,
       SUM(A.ORDERTOTALMONEY) / COUNT(A.ORDERID) 会员客单价
  FROM BBG_ORDER_VIP_TMP A
 WHERE A.ORDER_DATE <= DATE '2016-09-20'
   AND A.ISVIP = 1;

--1.3购物时段数据统计
SELECT TO_CHAR(TO_DATE(T.ORDERSTATUSTIME, 'YYYY-MM-DD HH24:MI:SS'), 'HH24') 时段,
       COUNT(T.ORDERID) 线上交易笔数,
       RATIO_TO_REPORT(COUNT(T.ORDERID)) OVER() 笔数占比,
       SUM(T.ORDERTOTALMONEY) 线上交易金额,
       RATIO_TO_REPORT(SUM(T.ORDERTOTALMONEY)) OVER() 金额占比
  FROM ORDER_HDR_120036 T
 WHERE TO_DATE(SUBSTR(T.ORDERSTATUSTIME, 1, 10), 'YYYY-MM-DD') BETWEEN DATE
 '2016-08-23'
   AND DATE '2016-09-11'
   AND T.BBGORDERSTATUS = 10
 GROUP BY TO_CHAR(TO_DATE(T.ORDERSTATUSTIME, 'YYYY-MM-DD HH24:MI:SS'),
                  'HH24')
 ORDER BY 1;

--1.4线上购物频次
SELECT B.FREQUENCY 整体线上购物频次,
       COUNT(B.BUYERMOBILE) 购物人数,
       RATIO_TO_REPORT(COUNT(B.BUYERMOBILE)) OVER() 人数占比,
       SUM(B.ORDER_AMT) 购物金额,
       RATIO_TO_REPORT(SUM(B.ORDER_AMT)) OVER() 金额占比
  FROM (SELECT A.BUYERMOBILE,
               A.ISVIP,
               COUNT(1) FREQUENCY,
               SUM(A.ORDERTOTALMONEY) ORDER_AMT
          FROM BBG_ORDER_VIP_TMP A
         WHERE A.ORDER_DATE <= DATE '2016-09-20'
         GROUP BY A.BUYERMOBILE, A.ISVIP) B
 GROUP BY B.FREQUENCY
 ORDER BY 1;

SELECT B.FREQUENCY 会员线上购物频次,
       COUNT(B.BUYERMOBILE) 会员购物人数,
       RATIO_TO_REPORT(COUNT(B.BUYERMOBILE)) OVER() 人数占比,
       SUM(B.ORDER_AMT) 会员购物金额,
       RATIO_TO_REPORT(SUM(B.ORDER_AMT)) OVER() 金额占比
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

--2.会员购物分析
--2.1线上购买
--2.1.1会员性别
SELECT T.GENDER 性别,
       COUNT(T.CARD_NUM) 人数,
       RATIO_TO_REPORT(COUNT(T.CARD_NUM)) OVER() 占比
  FROM BBG_JDDJ_VIP_BIRTHDAY T
 GROUP BY T.GENDER;

--2.1.2年龄 
SELECT TRUNC(T.AGE, -1) 年龄段,
       COUNT(T.PHONE_NUMBER) 人数,
       RATIO_TO_REPORT(COUNT(T.PHONE_NUMBER)) OVER() 占比
  FROM BBG_JDDJ_VIP_BIRTHDAY T
 GROUP BY TRUNC(T.AGE, -1)
 ORDER BY 1;

--******************************************************************************
--2.2线下购物分析
--******************************************************************************
--2.2.1线上会员线下购物人数
SELECT COUNT(DISTINCT A.HYK_NO) 会员线下购物人数,
       COUNT(A.SLS_TRX_ID) 交易笔数,
       SUM(A.SLS_AMT_LCL - A.RET_AMT_LCL) 购物金额
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

--2.2.2线上会员线下购物人数年龄段统计
SELECT /*+PARALLEL(16)*/
 TRUNC(V.AGE, -1) 年龄段,
 COUNT(DISTINCT V.CARD_NUM) 会员线下购物人数,
 COUNT(R.SLS_TRX_ID) 交易笔数,
 RATIO_TO_REPORT(COUNT(DISTINCT V.CARD_NUM)) OVER() 人数占比,
 SUM(R.SLS_AMT_LCL - R.RET_AMT_LCL) 购物金额,
 RATIO_TO_REPORT(SUM(R.SLS_AMT_LCL - R.RET_AMT_LCL)) OVER() 金额占比
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

--2.2.3线下购物频次
SELECT D.TRAN_COUNT 购物频次,
       COUNT(D.HYK_NO) 会员人数,
       SUM(D.SALES_AMT) 购物金额
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

--2.2.4线下年龄段购物
SELECT A.MONTH 月份,
       A.AGE_GROUP 年龄段,
       SUM(A.TRAN_COUNT) 交易笔数,
       SUM(A.SALES_AMT) 交易金额
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

SELECT A.MONTH 月份, A.AGE_GROUP 年龄段, COUNT(A.HYK_NO) 会员人数
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

--3.最近购物日期分析
--3.1整体最近购物日期分析
SELECT SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6) 最近购物月份,
       COUNT(A.HYK_NO) 会员人数
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

--3.2按年龄段最近购物日期分析
SELECT A.AGE_GROUP 年龄段,
       SUBSTR(TO_CHAR(A.MAXDATE, 'YYYYMMDD'), 1, 6) 最近购物月份,
       COUNT(A.HYK_NO) 会员人数
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
