--会员资料
--006065347762   
--006065539259

SELECT VIP.HYID, VIP.HYK_NO
  FROM RADM.HYK_HYXX VIP
 WHERE VIP.HYK_NO = '006065347762';

SELECT * FROM RADM.HYK_GRXX VIP WHERE VIP.HYID = '2080003178';

SELECT /*+PARALLEL(T,20)*/
 *
  FROM RADM.HYXFJL T
 WHERE T.HYID = 2020001757
   AND TO_DATE(TO_CHAR(T.XFSJ, 'YYYY-MM-DD'), 'YYYY-MM-DD') BETWEEN DATE
 '2013-10-31'
   AND DATE '2014-03-19';

SELECT T.HYK_NO, T.HY_NAME, G.PHONE, G.SJHM, SUBSTR(M.MDDM, 3, 6) MDDM
  FROM RADM.HYK_HYXX T, RADM.HYK_GRXX G, RADM.MDDY M
 WHERE T.HYID = G.HYID
   AND T.MDID = M.MDID
   AND T.HYK_NO IN ('006062469778',
                    '006063043249',
                    '006062237118',
                    '006062262699',
                    '3',
                    '006063135088',
                    '006062566097',
                    '666666000410066',
                    '666666000409764',
                    '006064836520',
                    '006064815297',
                    '006065347762',
                    '006065628588',
                    '006065539259',
                    '006065628593',
                    '006065536610');

--HYXFJL
SELECT /*PARALLEL(T,20)*/
 SUM(T.JE)
  FROM RADM.HYXFJL T
 WHERE T.SHDM = 'CS'
   AND TO_DATE(TO_CHAR(T.XFSJ, 'YYYY-MM-DD'), 'YYYY-MM-DD') BETWEEN DATE
 '2013-10-31'
   AND DATE '2014-03-19'
   AND EXISTS (SELECT 1
          FROM RADM.HYK_HYXX H
         WHERE T.HYID = H.HYID
           AND H.HYK_NO IN ('006062469778',
                            '006063043249',
                            '006062237118',
                            '006062262699',
                            '3',
                            '006063135088',
                            '006062566097',
                            '666666000410066',
                            '666666000409764',
                            '006064836520',
                            '006064815297',
                            '006065347762',
                            '006065628588',
                            '006065539259',
                            '006065628593',
                            '006065536610'));

--创建临时表
CREATE TABLE RADM.JIN_VIP_TRX_20140923_TMP AS
  SELECT /*+PARALLEL(H,20) (M,20)*/
   X.HYK_NO, SUBSTR(M.MDDM, 3, 6) MDDM, H.JLBH, H.SKTNO, H.XFSJ
    FROM RADM.HYXFJL H, RADM.MDDY M, RADM.HYK_HYXX X
   WHERE H.MDID = M.MDID
     AND H.HYID = X.HYID
     AND TO_DATE(TO_CHAR(H.XFSJ, 'YYYY-MM-DD'), 'YYYY-MM-DD') BETWEEN DATE
   '2013-10-31'
     AND DATE '2014-03-19'
     AND X.HYK_NO IN ('006062469778',
                      '006063043249',
                      '006062237118',
                      '006062262699',
                      '3',
                      '006063135088',
                      '006062566097',
                      '666666000410066',
                      '666666000409764',
                      '006064836520',
                      '006064815297',
                      '006065347762',
                      '006065628588',
                      '006065539259',
                      '006065628593',
                      '006065536610');

DROP TABLE RADM.JIN_VIP_TRX_20140923_TMP;

SELECT * FROM RMS.SA_TRAN_HEAD;
--消费记录
CREATE TABLE RMS.JIN_VIP_TRX_0923_TMP AS
  SELECT SLS.HYK_NO,
         SLS.ORG_NUM,
         S.STORE_NAME,
         SLS.TRAN_DATETIME,
         SLS.REGISTER,
         SLS.REF_NO2,
         SLS.ITEM,
         IM.ITEM_DESC,
         SLS.QTY,
         SLS.AMT
    FROM (SELECT /*+PARALLEL(ST,20) PARALLEL(SH,20) PARALLEL(SD,20) PARALLEL(STD,20) PARALLEL(V,20)*/
           V.HYK_NO,
           ST.STORE ORG_NUM,
           SH.TRAN_DATETIME,
           SH.REGISTER,
           SH.REF_NO2,
           ST.ITEM,
           ST.QTY,
           ST.QTY * (ST.UNIT_RETAIL - NVL(STD.UNIT_DISCOUNT_AMT, 0)) AMT
            FROM RMS.SA_TRAN_ITEM                     ST,
                 RMS.SA_TRAN_HEAD                     SH,
                 RMS.SA_STORE_DAY                     SD,
                 RMS.SA_TRAN_DISC                     STD,
                 RADM.JIN_VIP_TRX_20140923_TMP@rms_ra V
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
             AND TO_DATE(TO_CHAR(V.XFSJ, 'YYYY-MM-DD'), 'YYYY-MM-DD') BETWEEN DATE
           '2013-10-31'
             AND DATE
           '2014-03-19' --销售日期
             AND V.MDDM = TO_CHAR(ST.STORE)
             AND V.JLBH = SH.TRAN_NO
             AND V.SKTNO = SH.REGISTER
             AND TO_DATE(TO_CHAR(V.XFSJ, 'YYYY-MM-DD'), 'YYYY-MM-DD') =
                 TO_DATE(TO_CHAR(SH.TRAN_DATETIME, 'YYYY-MM-DD'),
                         'YYYY-MM-DD') /*AND EXISTS
                                                                                                 (SELECT \*+PARALLEL(H,20) (M,20)*\
                                                                                                         'X'
                                                                                                          FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
                                                                                                         WHERE H.MDID = M.MDID
                                                                                                           AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
                                                                                                           AND H.JLBH = SH.TRAN_NO
                                                                                                           AND H.SKTNO = SH.REGISTER
                                                                                                           AND H.JZRQ = SD.BUSINESS_DATE
                                                                                                           AND H.JZRQ BETWEEN DATE '2013-10-31' AND DATE
                                                                                                         '2014-03-19')*/
          ) SLS,
         RMS.ITEM_MASTER IM,
         RMS.STORE S
   WHERE SLS.ORG_NUM = S.STORE
     AND IM.ITEM = SLS.ITEM;

DROP TABLE RMS.JIN_VIP_TRX_0923_TMP;
