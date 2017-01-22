SELECT TDH.LOCATION 门店编码,
       (SELECT S.STORE_NAME FROM STORE S WHERE TDH.LOCATION = S.STORE(+)) 门店名称,
       TDH.ITEM 商品,
       (SELECT IM.ITEM_DESC
          FROM RMS.ITEM_MASTER IM
         WHERE IM.ITEM(+) = TDH.ITEM) 商品名称,
       (SELECT IL.PRIMARY_SUPP
          FROM RMS.ITEM_LOC IL
         WHERE IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION) 供应商编码,
       (SELECT su.sup_name
          FROM rms.sups su, RMS.ITEM_LOC IL
         where IL.ITEM(+) = TDH.ITEM
           AND IL.LOC(+) = TDH.LOCATION
           and su.supplier(+) = IL.PRIMARY_SUPP) 供应商名称,
       SUM(TDH.UNITS) 销售数量,
       SUM(TDH.TOTAL_COST) 销售成本,
       SUM(TDH.TOTAL_RETAIL) 销售金额,
       SUM(TDH.TOTAL_RETAIL) - SUM(TDH.TOTAL_COST) 毛利额
  FROM RMS.TRAN_DATA_HISTORY TDH
 WHERE TDH.TRAN_DATE BETWEEN :BDATE AND :EDATE
   AND TDH.ITEM IN (:ITEM_LIST)
   AND TDH.TRAN_CODE IN (1, 3)
 GROUP BY TDH.ITEM, TDH.SUBCLASS, TDH.LOCATION
 ORDER BY TDH.LOCATION, TDH.ITEM
