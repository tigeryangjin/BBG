
--会员资料
SELECT H.HYK_NO, --会员卡号
       H.JKRQ, --建卡日期
       FLOOR((SYSDATE - G.CSRQ) / 365) AGE, --出生日期
       CASE
         WHEN G.SEX = 0 THEN
          '男'
         ELSE
          '女'
       END SEX --性别
  FROM RADM.HYK_GRXX@RMS_RA G, RADM.HYK_HYXX@RMS_RA H
 WHERE G.HYID = H.HYID;

--活动周定义
SELECT DISTINCT P.PROMO_WK_KEY,
                P.PROMO_WK,
                TO_CHAR(P.WEEK_START_DT, 'YYYY-MM-DD') WEEK_START_DT,
                TO_CHAR(P.WEEK_END_DT, 'YYYY-MM-DD') WEEK_END_DT
  FROM RADM.BBG_RA_PROMO_STAMP_WK_D@RMS_RA P
-- WHERE P.PROMO_WK LIKE '%第1周%'
 ORDER BY P.PROMO_WK_KEY;

--参与换购的会员和非参与换购的会员都需要出来
--2013-05-08之后,创建视图RMS.YJ_VIP_TRX_SALE_AMT_NEW
--HYID:会员ID
--BUSINESS_DATE:销售日期
--TRAN_SEQ_NO:小票号
--VALUE:金额
CREATE OR REPLACE VIEW RMS.YJ_VIP_TRX_SALE_AMT_NEW AS
  SELECT H.HYID,
         SD.BUSINESS_DATE TRAN_DATE,
         SH.TRAN_SEQ_NO,
         --SH.VALUE AMT,
         /*ST.DEPT,
         ST.ITEM,
         SUM(ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0))) AMT*/
         SH.VALUE AMT
    FROM --SA_TRAN_ITEM ST,
         SA_TRAN_HEAD SH,
         SA_STORE_DAY SD,
         --SA_TRAN_DISC STD,
         RADM.HYXFJL@RMS_RA   H,
         RADM.MDDY@RMS_RA     M,
         RADM.HYK_GRXX@RMS_RA G,
         RADM.HYK_HYXX@RMS_RA HX /*,
                                                                                                                                                       (SELECT DISTINCT P.PROMO_WK_KEY,
                                                                                                                                                       P.PROMO_WK,P.WEEK_START_DT,P.WEEK_END_DT FROM RADM.BBG_RA_PROMO_STAMP_WK_D@RMS_RA P) PS*/
   WHERE /*ST.STORE = SH.STORE
                                                                                                                                            AND ST.DAY = SH.DAY
                                                                                                                                            AND ST.TRAN_SEQ_NO = SH.TRAN_SEQ_NO
                                                                                                                                            AND*/
   SH.STORE_DAY_SEQ_NO = SD.STORE_DAY_SEQ_NO
   AND SH.STORE = SD.STORE
   AND SH.DAY = SD.DAY
  /*AND ST.STORE = STD.STORE(+)
  AND ST.DAY = STD.DAY(+)
  AND ST.TRAN_SEQ_NO = STD.TRAN_SEQ_NO(+)
  AND ST.ITEM_SEQ_NO = STD.ITEM_SEQ_NO(+)*/
  --会员关联条件
   AND H.MDID = M.MDID
   AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(SH.STORE)
   AND H.JLBH = SH.TRAN_NO
   AND H.SKTNO = SH.REGISTER
   AND H.JZRQ = SD.BUSINESS_DATE
   AND G.HYID = HX.HYID
   AND HX.HYID = H.HYID
   AND SD.BUSINESS_DATE >= DATE '2013-05-08' --销售日期
  /*GROUP BY H.HYID, SH.TRAN_NO, SD.BUSINESS_DATE, ST.ITEM, ST.DEPT*/
  ;

--历史的会员销售2013-05-07之前---------------------------------------------------------------------------------------
/*select * from ksl_vip_tran_v;
SELECT SUBSTR(md.mddm, 3, 6) AS store,
           md.shdm AS TYPE,
           xfsj AS tran_datetime,
           xfjlid AS tran_seq_no,
           sktno AS register,
           jlbh AS tran_no,
           hyk_no as card_no, 
           hy.hyid AS vip_id,
           je AS amt
      FROM hyxfjl@rms_ra hy, mddy@rms_ra md, hyk_hyxx@rms_ra kh
     WHERE hy.mdid = md.mdid
     and kh.hyid=hy.hyid;*/

SELECT HY.HYID, COUNT(HY.XFJLID) TRX_CNT, SUM(HY.JE) AMT
  FROM (SELECT DISTINCT *
          FROM hyxfjl@rms_ra T
         WHERE T.JZRQ BETWEEN DATE '2012-06-01' AND DATE '2013-05-07') HY
 GROUP BY HY.HYID;

--平均购买类别数量-----------------------------------------------------------------------------
--切换后
CREATE OR REPLACE VIEW RMS.YJ_VIP_TRX_SALE_DEPT_NEW AS
  SELECT DISTINCT H.HYID,
                  SD.BUSINESS_DATE TRAN_DATE,
                  SH.TRAN_SEQ_NO,
                  ST.DEPT
    FROM SA_TRAN_ITEM         ST,
         SA_TRAN_HEAD         SH,
         SA_STORE_DAY         SD,
         SA_TRAN_DISC         STD,
         RADM.HYXFJL@RMS_RA   H,
         RADM.MDDY@RMS_RA     M,
         RADM.HYK_GRXX@RMS_RA G,
         RADM.HYK_HYXX@RMS_RA HX
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
        --会员关联条件
     AND H.MDID = M.MDID
     AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(SH.STORE)
     AND H.JLBH = SH.TRAN_NO
     AND H.SKTNO = SH.REGISTER
     AND H.JZRQ = SD.BUSINESS_DATE
     AND G.HYID = HX.HYID
     AND HX.HYID = H.HYID
     AND SD.BUSINESS_DATE >= DATE '2013-05-08' --销售日期
  /*GROUP BY H.HYID, SH.TRAN_NO, SD.BUSINESS_DATE, ST.ITEM, ST.DEPT*/
  --ORDER BY H.HYID, SD.BUSINESS_DATE TRAN_DATE, SH.TRAN_SEQ_NO, ST.DEPT
  ;
--切换前
SELECT * FROM HYXFJL@RMS_RA;
SELECT * FROM SALEDETAIL@RMS_RA;
SELECT * FROM MDDY@RMS_RA;
/*select *
  from ksl_saledetail_v A, ksl_vip_tran_v b
 where a.STORE = b.store
   and a.sd0101 = to_char(b.tran_datetime, 'yyyymmdd')
   and a.sd0106 = b.tran_no
   and a.sd0109 = b.register;*/
CREATE OR REPLACE VIEW RMS.YJ_VIP_TRX_SALE_DEPT_OLD AS
  SELECT DISTINCT H.HYID, H.JZRQ TRAN_DATE, SUBSTR(SD.CATEID, 1, 2) DEPT
    FROM RADM.MDDY@RMS_RA       M,
         RADM.HYXFJL@RMS_RA     H,
         RADM.SALEDETAIL@RMS_RA SD
   WHERE M.MDID = H.MDID
     AND SUBSTR(M.MDDM, 3, 6) =
         SUBSTR(SD.SHOPID, 2, 2) || SUBSTR(SD.SHOPID, 1, 1) ||
         SUBSTR(SD.SHOPID, 4, 3)
     AND SD.SD0101 = TO_CHAR(H.JZRQ, 'YYYYMMDD')
     AND SD.SD0106 = H.jlbh
     AND SD.SD0109 = H.sktno
     AND H.JZRQ BETWEEN DATE '2012-06-01' AND DATE '2013-05-07';
--换购数量---------------------------------------------------------------------
/*换购商品编码(20个)
100844024; 100846759; 100848076; 100848105; 100848164; 100848261; 100850264; 100850432; 100850521; 100850580; 
100850678; 100850715; 100850723; 100850731; 100850740; 100850758; 100850766; 100850774; 100850782; 100850791
*/
CREATE MATERIALIZED VIEW YJ_VIP_HG_QTY build deferred REFRESH FORCE ON DEMAND START
  WITH TO_DATE(CONCAT(TO_CHAR(SYSDATE,
   'DD-MM-YYYY'),
   '16:40:00'),
   'DD-MM-YYYY HH24:MI:SS') AS
  SELECT H.HYID, SUM(ST.QTY) QTY
    FROM SA_TRAN_ITEM       ST,
         SA_TRAN_HEAD       SH,
         SA_STORE_DAY       SD,
         SA_TRAN_DISC       STD,
         RADM.HYXFJL@RMS_RA H,
         RADM.MDDY@RMS_RA   M
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
        --会员关联条件
     AND H.MDID = M.MDID
     AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(SH.STORE)
     AND H.JLBH = SH.TRAN_NO
     AND H.SKTNO = SH.REGISTER
     AND H.JZRQ = SD.BUSINESS_DATE
     AND SD.BUSINESS_DATE BETWEEN DATE '2013-10-31' AND DATE
   '2014-03-19' --换购日期
         AND H.JZRQ BETWEEN DATE '2013-10-31' AND DATE
   '2014-03-19' --换购日期
     AND ST.ITEM IN (100844024,
                     100846759,
                     100848076,
                     100848105,
                     100848164,
                     100848261,
                     100850264,
                     100850432,
                     100850521,
                     100850580,
                     100850678,
                     100850715,
                     100850723,
                     100850731,
                     100850740,
                     100850758,
                     100850766,
                     100850774,
                     100850782,
                     100850791) --20个换购商品
   GROUP BY H.HYID;
--删除物化视图
DROP MATERIALIZED VIEW YJ_VIP_HG_QTY;

--REPORT SQL-------------------------------------------------------------------
CREATE MATERIALIZED VIEW YJ_VIP_SALE_HG_19_20 build deferred REFRESH FORCE ON DEMAND START
  WITH TO_DATE(CONCAT(TO_CHAR(SYSDATE,
   'DD-MM-YYYY'),
   '13:00:00'),
   'DD-MM-YYYY HH24:MI:SS') AS
  SELECT HYXX.HYK_NO 会员卡号,
         HYXX.JKRQ   会员加入日期,
         HYXX.AGE    年龄,
         HYXX.SEX    性别,
         --AMT3.AMT     活动开始前11周营业额,
         AMT4.AMT 活动期11周营业额,
         --AMT3.TRX_CNT 活动开始前11周客单数,
         AMT4.TRX_CNT 活动期11周客单数,
         --AMT1.AMT     去年活动前11周营业额,
         AMT2.AMT 去年活动11周营业额,
         --AMT1.TRX_CNT 去年活动前11周客单数,
         AMT2.TRX_CNT 去年活动11周客单数,
         --DP3.DP_CNT   活动前11周类别,
         DP4.DP_CNT 活动期11周类别,
         --DP1.DP_CNT   去年活动前11周类别,
         DP2.DP_CNT 去年活动11周类别,
         HG.QTY     换购数量
    FROM (SELECT H.HYID,
                 H.HYK_NO, --会员卡号
                 H.JKRQ, --建卡日期
                 FLOOR((SYSDATE - G.CSRQ) / 365) AGE, --出生日期
                 CASE
                   WHEN G.SEX = 0 THEN
                    '男'
                   ELSE
                    '女'
                 END SEX --性别
            FROM RADM.HYK_GRXX@RMS_RA G, RADM.HYK_HYXX@RMS_RA H
           WHERE G.HYID = H.HYID) HYXX,
         --营业额，客单-------------------------------------------------------
         /*(SELECT HY.HYID, COUNT(HY.XFJLID) TRX_CNT, SUM(HY.JE) AMT
          FROM (SELECT DISTINCT *
                  FROM hyxfjl@rms_ra T
                 WHERE T.SHDM = 'CS'
                   AND T.JZRQ BETWEEN DATE '2012-09-13' AND DATE
                 '2012-10-31' --去年活动前
                ) HY
         GROUP BY HY.HYID) AMT1,*/
         (SELECT HY.HYID, COUNT(HY.XFJLID) TRX_CNT, SUM(HY.JE) AMT
            FROM (SELECT DISTINCT *
                    FROM hyxfjl@rms_ra T
                   WHERE T.SHDM = 'CS'
                     AND T.JZRQ BETWEEN DATE '2013-03-07' AND DATE
                   '2013-03-20' --去年同期活动
                  ) HY
           GROUP BY HY.HYID) AMT2,
         /*(SELECT HYID, COUNT(TRAN_SEQ_NO) TRX_CNT, SUM(AMT) AMT
          FROM RMS.YJ_VIP_TRX_SALE_AMT_NEW
         WHERE TRAN_DATE BETWEEN DATE '2013-09-12' AND DATE '2013-10-30' --活动前日期条件
         GROUP BY HYID) AMT3,*/
         (SELECT HYID, COUNT(TRAN_SEQ_NO) TRX_CNT, SUM(AMT) AMT
            FROM RMS.YJ_VIP_TRX_SALE_AMT_NEW
           WHERE TRAN_DATE BETWEEN DATE '2014-01-16' AND DATE '2014-03-05' --本期活动日期条件
           GROUP BY HYID) AMT4,
         --平均购买类别-------------------------------------------------------------
         /*(SELECT B.HYID, COUNT(B.DEPT) DP_CNT
          FROM (SELECT DISTINCT A.HYID, A.DEPT
                  FROM RMS.YJ_VIP_TRX_SALE_DEPT_OLD A
                 WHERE A.TRAN_DATE BETWEEN DATE '2012-09-13' AND DATE
                 '2012-10-31' --去年活动前
                ) B
         GROUP BY B.HYID) DP1,*/
         (SELECT B.HYID, COUNT(B.DEPT) DP_CNT
            FROM (SELECT DISTINCT A.HYID, A.DEPT
                    FROM RMS.YJ_VIP_TRX_SALE_DEPT_OLD A
                   WHERE A.TRAN_DATE BETWEEN DATE '2013-03-07' AND DATE
                   '2013-03-20' --去年同期活动
                  ) B
           GROUP BY B.HYID) DP2,
         /*(SELECT B.HYID, COUNT(B.DEPT) DP_CNT
          FROM (SELECT DISTINCT A.HYID, A.DEPT
                  FROM RMS.YJ_VIP_TRX_SALE_DEPT_NEW A
                 WHERE A.TRAN_DATE BETWEEN DATE '2013-09-12' AND DATE
                 '2013-10-30' --活动前日期条件
                ) B
         GROUP BY B.HYID) DP3,*/
         (SELECT B.HYID, COUNT(B.DEPT) DP_CNT
            FROM (SELECT DISTINCT A.HYID, A.DEPT
                    FROM RMS.YJ_VIP_TRX_SALE_DEPT_NEW A
                   WHERE A.TRAN_DATE BETWEEN DATE '2014-03-06' AND DATE
                   '2014-03-19' --本期活动日期条件
                  ) B
           GROUP BY B.HYID) DP4,
         YJ_VIP_HG_QTY HG
   WHERE /*HYXX.HYID = AMT1.HYID(+)
                                               AND*/
   HYXX.HYID = AMT2.HYID(+)
  --AND HYXX.HYID = AMT3.HYID(+)
   AND HYXX.HYID(+) = AMT4.HYID
  --AND HYXX.HYID = DP1.HYID(+)
   AND HYXX.HYID = DP2.HYID(+)
  --AND HYXX.HYID = DP3.HYID(+)
   AND HYXX.HYID = DP4.HYID(+)
   AND HYXX.HYID = HG.HYID(+);

--1-11周和12-18周数据合并
--DROP MATERIALIZED VIEW YJ_VIP_SALE_HG_1_18;
SELECT * FROM YJ_VIP_SALE_HG_1_11;
SELECT * FROM YJ_VIP_SALE_HG_12_18;
SELECT * FROM YJ_VIP_SALE_HG_1_18;
SELECT * FROM YJ_VIP_SALE_HG_19_20;

CREATE MATERIALIZED VIEW YJ_VIP_SALE_HG_1_18 AS
  SELECT T.会员卡号,
         T.会员加入日期,
         T.性别,
         MAX(T.年龄) 年龄,
         SUM(活动开始前11周营业额) 活动开始前营业额,
         SUM(活动期11周营业额) 活动期营业额,
         SUM(活动开始前11周客单数) 活动开始前客单数,
         SUM(活动期11周客单数) 活动期客单数,
         SUM(去年活动前11周营业额) 去年活动前营业额,
         SUM(去年活动11周营业额) 去年活动营业额,
         SUM(去年活动前11周客单数) 去年活动前客单数,
         SUM(去年活动11周客单数) 去年活动客单数,
         SUM(活动前11周类别) 活动前类别,
         SUM(活动期11周类别) 活动期类别,
         SUM(去年活动前11周类别) 去年活动前类别,
         SUM(去年活动11周类别) 去年活动类别,
         SUM(换购数量) 换购数量
    FROM (SELECT *
            FROM YJ_VIP_SALE_HG_1_11
          UNION ALL
          SELECT *
            FROM YJ_VIP_SALE_HG_12_18) T
   GROUP BY T.会员卡号, T.会员加入日期, T.性别;

CREATE MATERIALIZED VIEW YJ_VIP_SALE_HG_1_20 AS
  SELECT T.会员卡号,
         T.会员加入日期,
         T.性别,
         MAX(T.年龄) 年龄,
         SUM(活动开始前营业额) 活动开始前营业额,
         SUM(活动期营业额) 活动期营业额,
         SUM(活动开始前客单数) 活动开始前客单数,
         SUM(活动期客单数) 活动期客单数,
         SUM(去年活动前营业额) 去年活动前营业额,
         SUM(去年活动营业额) 去年活动营业额,
         SUM(去年活动前客单数) 去年活动前客单数,
         SUM(去年活动客单数) 去年活动客单数,
         SUM(活动前类别) 活动前类别,
         SUM(活动期类别) 活动期类别,
         SUM(去年活动前类别) 去年活动前类别,
         SUM(去年活动类别) 去年活动类别,
         SUM(换购数量) 换购数量
    FROM (SELECT T1.会员卡号,
                 T1.会员加入日期,
                 T1.性别,
                 T1.年龄,
                 T1.活动开始前营业额,
                 T1.活动期营业额,
                 T1.活动开始前客单数,
                 T1.活动期客单数,
                 T1.去年活动前营业额,
                 T1.去年活动营业额,
                 T1.去年活动前客单数,
                 T1.去年活动客单数,
                 T1.活动前类别,
                 T1.活动期类别,
                 T1.去年活动前类别,
                 T1.去年活动类别,
                 0 换购数量
            FROM YJ_VIP_SALE_HG_1_18 T1
          UNION ALL
          SELECT T2.会员卡号,
                 T2.会员加入日期,
                 T2.性别,
                 T2.年龄,
                 0                     活动开始前营业额,
                 T2.活动期11周营业额   活动期营业额,
                 0                     活动开始前客单数,
                 T2.活动期11周客单数   活动期客单数,
                 0                     去年活动前营业额,
                 T2.去年活动11周营业额 去年活动营业额,
                 0                     去年活动前客单数,
                 T2.去年活动11周客单数 去年活动客单数,
                 0                     活动前类别,
                 T2.去年活动11周类别   活动期类别,
                 0                     去年活动前类别,
                 T2.去年活动11周类别   去年活动类别,
                 T2.换购数量
            FROM YJ_VIP_SALE_HG_19_20 T2) T
   GROUP BY T.会员卡号, T.会员加入日期, T.性别;

--18周销售+20周换购
SELECT * FROM YJ_VIP_SALE_HG_1_18;
SELECT * FROM YJ_VIP_HG_QTY;
SELECT H.HYID,
       H.HYK_NO, --会员卡号
       H.JKRQ, --建卡日期
       FLOOR((SYSDATE - G.CSRQ) / 365) AGE, --出生日期
       CASE
         WHEN G.SEX = 0 THEN
          '男'
         ELSE
          '女'
       END SEX --性别
  FROM RADM.HYK_GRXX@RMS_RA G, RADM.HYK_HYXX@RMS_RA H
 WHERE G.HYID = H.HYID;

CREATE MATERIALIZED VIEW RMS.YJ_VIP_SALE_18_HG_20 AS
  SELECT HYXX.HYK_NO        会员卡号,
         HYXX.JKRQ          会员加入日期,
         HYXX.AGE           年龄,
         HYXX.SEX           性别,
         S.活动开始前营业额,
         S.活动期营业额,
         S.活动开始前客单数,
         S.活动期客单数,
         S.去年活动前营业额,
         S.去年活动营业额,
         S.去年活动前客单数,
         S.去年活动客单数,
         S.活动前类别,
         S.活动期类别,
         S.去年活动前类别,
         S.去年活动类别,
         HG.QTY             二十周换购量
    FROM YJ_VIP_SALE_HG_1_18 S,
         (SELECT H.HYID,
                 H.HYK_NO, --会员卡号
                 H.JKRQ, --建卡日期
                 FLOOR((SYSDATE - G.CSRQ) / 365) AGE, --出生日期
                 CASE
                   WHEN G.SEX = 0 THEN
                    '男'
                   ELSE
                    '女'
                 END SEX --性别
            FROM RADM.HYK_GRXX@RMS_RA G, RADM.HYK_HYXX@RMS_RA H
           WHERE G.HYID = H.HYID) HYXX,
         YJ_VIP_HG_QTY HG
   WHERE S.会员卡号 = HYXX.HYK_NO(+)
     AND HG.HYID(+) = HYXX.HYID;

--*************************************************************************
--RMS有销售，HYXFJL没有记录
SELECT *
  FROM RMS.ITEM_MASTER T
 WHERE T.SHORT_DESC NOT LIKE '%非会员%'
   AND T.ITEM IN ('100844024',
                  '100846759',
                  '100848076',
                  '100848105',
                  '100848164',
                  '100848261',
                  '100850264',
                  '100850432',
                  '100850521',
                  '100850580',
                  '100850678',
                  '100850715',
                  '100850723',
                  '100850731',
                  '100850740',
                  '100850758',
                  '100850766',
                  '100850774',
                  '100850782',
                  '100850791');
/*
100850678
100850521
100850731
100850715
100844024
100850432
100848261
100848164
100848076
100850766
100850740
100850791
100850774
*/
CREATE MATERIALIZED VIEW RMS.YJ_VIP_HG_TRX_NOTIN_HYXFJ build deferred REFRESH FORCE ON DEMAND START
  WITH TO_DATE(CONCAT(TO_CHAR(SYSDATE,
   'DD-MM-YYYY'),
   '14:31:00'),
   'DD-MM-YYYY HH24:MI:SS') AS
  SELECT SH.STORE,
         SD.BUSINESS_DATE,
         SH.TRAN_NO,
         SH.REGISTER,
         ST.ITEM,
         ST.QTY
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
     AND SD.BUSINESS_DATE BETWEEN DATE '2013-10-31' AND DATE
   '2014-03-19' --换购日期
        --会员关联条件
     AND NOT EXISTS (SELECT 1
            FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
           WHERE H.MDID = M.MDID
             AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(SH.STORE)
             AND H.JLBH = SH.TRAN_NO
             AND H.SKTNO = SH.REGISTER
             AND H.JZRQ = SD.BUSINESS_DATE)
        --会员换购商品
     AND ST.ITEM IN (100850678,
                     100850521,
                     100850731,
                     100850715,
                     100844024,
                     100850432,
                     100848261,
                     100848164,
                     100848076,
                     100850766,
                     100850740,
                     100850791,
                     100850774);
--*************************************************************************
--RMS.YJ_VIP_SALE_HG_1_20+开卡区域+总会员数
CREATE MATERIALIZED VIEW RMS.YJ_VIP_SALE_HG_1_20_REGION AS
  select HG.*,
         CH.region || '-' || CH.region_name 区域,
         7100489 总开卡会员数
    from YJ_VIP_SALE_HG_1_20  HG,
         RMS.district_chain_v CH,
         RADM.HYK_HYXX@RMS_RA HY,
         RADM.MDDY@RMS_RA     MD
   WHERE HG.会员卡号 = HY.HYK_NO
     AND HY.MDID = MD.MDID
     AND MD.SHDM = 'CS'
     AND SUBSTR(MD.MDDM, 3, 6) = CH.store;
--总会员数
--7100489
SELECT COUNT(*) FROM RADM.HYK_HYXX HY WHERE HY.JKRQ <= DATE '2014-04-30';
