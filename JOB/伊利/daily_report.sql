SELECT TDH.TRAN_DATE 销售日期,
       TDH.LY_TRAN_DATE 去年同期日期,
       TDH.SUBCLASS 小类,
       (SELECT SC.SUB_NAME
          FROM RMS.SUBCLASS SC
         WHERE TDH.SUBCLASS = SC.SUBCLASS) 小类名称,
       (SELECT IL.PRIMARY_SUPP
          FROM RMS.ITEM_LOC IL
         WHERE IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION) 供应商编码,
       (SELECT su.sup_name
          FROM rms.sups su, RMS.ITEM_LOC IL
         where IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION
           and su.supplier(+) = IL.PRIMARY_SUPP) 供应商名称,
       TDH.LOCATION 门店编码,
       (SELECT S.STORE_NAME FROM STORE S WHERE TDH.LOCATION = S.STORE(+)) 门店名称,
       (SELECT DCV.chain_name
          FROM RMS.DISTRICT_CHAIN_V DCV
         WHERE DCV.store(+) = TDH.LOCATION) 业态,
       (SELECT DCV.region_name
          FROM RMS.DISTRICT_CHAIN_V DCV
         WHERE DCV.store(+) = TDH.LOCATION) 区域,
       TDH.ITEM 商品,
       (SELECT IM.ITEM_DESC
          FROM RMS.ITEM_MASTER IM
         WHERE IM.ITEM(+) = TDH.ITEM) 商品名称,
       TDH.UNITS 销售数量,
       TDH.TOTAL_COST 销售成本,
       TDH.TOTAL_RETAIL 销售金额,
       TDH.TOTAL_RETAIL - TDH.TOTAL_COST 毛利额,
       TDH.LY_UNITS 去年销售数量,
       TDH.LY_TOTAL_COST 去年销售成本,
       TDH.LY_TOTAL_RETAIL 去年销售金额,
       TDH.LY_TOTAL_RETAIL - TDH.LY_TOTAL_COST 去年毛利额
  FROM (SELECT T.TRAN_DATE TRAN_DATE,
               NVL(L.TRAN_DATE, :TODAY - 366) LY_TRAN_DATE,
               T.SUBCLASS,
               T.ITEM,
               T.LOCATION,
               T.UNITS,
               T.TOTAL_COST,
               T.TOTAL_RETAIL,
               NVL(L.UNITS, 0) LY_UNITS,
               NVL(L.TOTAL_COST, 0) LY_TOTAL_COST,
               NVL(L.TOTAL_RETAIL, 0) LY_TOTAL_RETAIL
          FROM (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM RMS.TRAN_DATA_HISTORY TDH
                 WHERE TDH.TRAN_DATE = :TODAY
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) T,
               (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM TRAN_DATA_HISTORY TDH /*TRAN_DATA_HISTORY@RTKHIST*/
                 WHERE TDH.TRAN_DATE = :TODAY - 366
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) L
         WHERE T.ITEM = L.ITEM(+)
           AND T.LOCATION = L.LOCATION(+)
        UNION
		/*去年有销售而今年没有销售*/
        SELECT L.TRAN_DATE + 366 TRAN_DATE,
               NVL(L.TRAN_DATE, :TODAY - 366) LY_TRAN_DATE,
               L.SUBCLASS,
               L.ITEM,
               L.LOCATION,
               NVL(T.UNITS, 0) UNITS,
               NVL(T.TOTAL_COST, 0) TOTAL_COST,
               NVL(T.TOTAL_RETAIL, 0) TOTAL_RETAIL,
               L.UNITS LY_UNITS,
               L.TOTAL_COST LY_TOTAL_COST,
               L.TOTAL_RETAIL LY_TOTAL_RETAIL
          FROM (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM RMS.TRAN_DATA_HISTORY TDH
                 WHERE TDH.TRAN_DATE = :TODAY
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) T,
               (SELECT TDH.TRAN_DATE,
                       TDH.SUBCLASS,
                       TDH.ITEM,
                       TDH.LOCATION,
                       SUM(TDH.UNITS) UNITS,
                       SUM(TDH.TOTAL_COST) TOTAL_COST,
                       SUM(TDH.TOTAL_RETAIL) TOTAL_RETAIL
                  FROM TRAN_DATA_HISTORY TDH /*TRAN_DATA_HISTORY@RTKHIST*/
                 WHERE TDH.TRAN_DATE = :TODAY - 366
                   AND EXISTS (SELECT 1
                          FROM uda_item_lov UIL
                         WHERE UIL.UDA_ID = 3
                           AND UIL.UDA_VALUE IN (5057, 8430)
                           AND TDH.ITEM = UIL.ITEM)
                   AND TDH.TRAN_CODE IN (1, 3)
                   AND TDH.CLASS = 215
                 GROUP BY TDH.TRAN_DATE, TDH.ITEM, TDH.LOCATION, TDH.SUBCLASS) L
         WHERE T.ITEM(+) = L.ITEM
           AND T.LOCATION(+) = L.LOCATION) TDH
 ORDER BY TDH.TRAN_DATE, TDH.LOCATION, TDH.ITEM
