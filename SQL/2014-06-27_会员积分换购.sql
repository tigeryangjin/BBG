--2--------
SELECT T1.STORE      门店编码,
       T2.STORE_NAME 门店名称,
       T1.TRAN_NO    整体客流,
       T1.AMT        整体销售,
       T.VIP_NO      会员客流,
       T.VIP_AMT     会员销售
  FROM (SELECT STORE, SUM(AMT) VIP_AMT, COUNT(VIP_ID) VIP_NO
          FROM KSL_VIP_TRAN_V V
         WHERE TO_CHAR(TRAN_DATETIME, 'YYYYMMDD') = '20140626'
           AND EXISTS
         (SELECT *
                  FROM (SELECT T.*, H.TRAN_DATETIME, H.REGISTER, H.TRAN_NO
                          FROM SA_TRAN_ITEM T, SA_TRAN_HEAD H
                         WHERE T.TRAN_SEQ_NO = H.TRAN_SEQ_NO
                           AND TO_CHAR(H.TRAN_DATETIME, 'YYYYMMDD') =
                               '20140626') I
                 WHERE EXISTS
                 (SELECT 1 FROM KSL_TMP_ITEM KI WHERE I.ITEM = KI.ITEM)
                   AND V.TRAN_SEQ_NO = I.TRAN_NO
                   AND V.REGISTER = I.REGISTER
                   AND V.STORE = I.STORE
                   AND TO_CHAR(V.TRAN_DATETIME, 'YYYYMMDD') =
                       TO_CHAR(I.TRAN_DATETIME, 'YYYYMMDD'))
         GROUP BY STORE) T,
       (SELECT STORE, COUNT(TRAN_SEQ_NO) TRAN_NO, SUM(VALUE) AMT
          FROM SA_TRAN_HEAD H
         WHERE TO_CHAR(TRAN_DATETIME, 'YYYYMMDD') = '20140626'
           AND EXISTS
         (SELECT 1
                  FROM SA_TRAN_ITEM I
                 WHERE EXISTS
                 (SELECT 1 FROM KSL_TMP_ITEM KI WHERE KI.ITEM = I.ITEM)
                   AND H.TRAN_SEQ_NO = I.TRAN_SEQ_NO)
         GROUP BY STORE) T1,
       STORE T2
 WHERE T1.STORE = T.STORE(+)
   AND T1.STORE = T2.STORE;

--3--------
SELECT STORE.STORE       门店编码,
       STORE.STORE_NAME  门店名称,
       HYXX.HYK_NO       会员卡号,
       VIP.JF            清积分,
       IM.ITEM           商品编码,
       IM.ITEM_DESC      商品名称,
       VIP.SLS_QTY       兑礼数量,
       VIP.STOCK_ON_HAND 库存数量
  FROM (SELECT ST.STORE ORG_NUM,
               --ST.TRAN_SEQ_NO SLS_TRX_ID,
               H.HYID,
               ST.ITEM,
               SUM(ST.QTY) SLS_QTY,
               SUM(ST.QTY) * K.JF JF,
               ILS.STOCK_ON_HAND
          FROM SA_TRAN_ITEM       ST,
               SA_TRAN_HEAD       SH,
               SA_STORE_DAY       SD,
               SA_TRAN_DISC       STD,
               RADM.HYXFJL@RMS_RA H,
               RADM.MDDY@RMS_RA   M,
               RMS.KSL_TMP_ITEM   K,
               RMS.ITEM_LOC_SOH   ILS
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
              /* AND SD.BUSINESS_DATE BETWEEN DATE '2014-06-26' AND DATE
              '2014-02-22' --销售日期*/
           AND SD.BUSINESS_DATE = DATE '2014-06-26'
              --AND SUBSTR(ST.DEPT, 1, 2) IN (27) --大类
           AND EXISTS (SELECT 'X'
                  FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
                 WHERE H.MDID = M.MDID
                   AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
                   AND H.JLBH = SH.TRAN_NO
                   AND H.SKTNO = SH.REGISTER
                   AND H.JZRQ = SD.BUSINESS_DATE)
           AND H.MDID = M.MDID
           AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
           AND H.JLBH = SH.TRAN_NO
           AND H.SKTNO = SH.REGISTER
           AND H.JZRQ = SD.BUSINESS_DATE
           AND ST.ITEM = K.ITEM
           AND ILS.ITEM = ST.ITEM
           AND ILS.LOC = ST.STORE
					 AND ST.UNIT_RETAIL-STD.UNIT_DISCOUNT_AMT=1
         GROUP BY ST.STORE,
                  --ST.TRAN_SEQ_NO,
                  H.HYID,
                  ST.ITEM,
                  K.JF,
                  ILS.STOCK_ON_HAND) VIP,
       RMS.STORE,
       RMS.ITEM_MASTER IM,
       RADM.HYK_HYXX@RMS_RA HYXX
 WHERE VIP.ORG_NUM = STORE.STORE
   AND VIP.ITEM = IM.ITEM
   AND VIP.HYID = HYXX.HYID;
--
SELECT ST.STORE ORG_NUM,
       --ST.TRAN_SEQ_NO SLS_TRX_ID,
       H.HYID,
       ST.ITEM,
       SUM(ST.QTY) SLS_QTY,
       SUM(ST.QTY) * K.JF JF,
       ILS.STOCK_ON_HAND
  FROM SA_TRAN_ITEM       ST,
       SA_TRAN_HEAD       SH,
       SA_STORE_DAY       SD,
       SA_TRAN_DISC       STD,
       RADM.HYXFJL@RMS_RA H,
       RADM.MDDY@RMS_RA   M,
       RMS.KSL_TMP_ITEM   K,
       RMS.ITEM_LOC_SOH   ILS
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
      /* AND SD.BUSINESS_DATE BETWEEN DATE '2014-06-26' AND DATE
      '2014-02-22' --销售日期*/
   AND SD.BUSINESS_DATE = DATE '2014-06-26'
      --AND SUBSTR(ST.DEPT, 1, 2) IN (27) --大类
   AND EXISTS (SELECT 'X'
          FROM RADM.HYXFJL@RMS_RA H, RADM.MDDY@RMS_RA M
         WHERE H.MDID = M.MDID
           AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
           AND H.JLBH = SH.TRAN_NO
           AND H.SKTNO = SH.REGISTER
           AND H.JZRQ = SD.BUSINESS_DATE)
   AND H.MDID = M.MDID
   AND SUBSTR(M.MDDM, 3, 6) = TO_CHAR(ST.STORE)
   AND H.JLBH = SH.TRAN_NO
   AND H.SKTNO = SH.REGISTER
   AND H.JZRQ = SD.BUSINESS_DATE
   AND ST.ITEM = K.ITEM
   AND ILS.ITEM = ST.ITEM
   AND ILS.LOC = ST.STORE
	 AND ST.UNIT_RETAIL-STD.UNIT_DISCOUNT_AMT=1
 GROUP BY ST.STORE,
          --ST.TRAN_SEQ_NO,
          H.HYID,
          ST.ITEM,
          K.JF,
          ILS.STOCK_ON_HAND
