/*
门店编码：120124/120094/120165/120010/120011/120028     这6个门店的商品信息：
格式如下：门店编码 门店名称  商品编码 商品名称 物流模式 供应商编码 供应商名称 库存数量 进价
*/
SELECT ST.STORE 门店编码,
       ST.STORE_NAME 门店名称,
       IM.ITEM 商品编码,
       IM.ITEM_DESC 商品名称,
       (SELECT WL_MODE
          FROM (SELECT A.SUPPLIER,
                       A.LOC,
                       A.ITEM,
                       CCD.CODE || CCD.CODE_DESC WL_MODE
                  FROM RMS.CMX_CODE_DETAIL           CCD,
                       RMS.CMX_ITEM_SUPP_COUNTRY_LOC A
                 WHERE A.LOGISTICS_DELIVERY_MODEL = CCD.CODE
                   AND CCD.CODE_TYPE = 'LDMD') B
         WHERE IL.PRIMARY_SUPP = B.SUPPLIER(+)
           AND IL.LOC = B.LOC(+)
           AND IL.ITEM = B.ITEM(+)) 物流模式,
       (select su.supplier || su.sup_name
          from rms.sups su
         where su.supplier(+) = IL.PRIMARY_SUPP) 供应商,
       SOH.STOCK_ON_HAND 库存数量,
       SOH.AV_COST 进价
  FROM RMS.ITEM_MASTER  IM,
       RMS.ITEM_LOC     IL,
       RMS.STORE        ST,
       RMS.ITEM_LOC_SOH SOH
 WHERE IM.ITEM = IL.ITEM
   AND IL.LOC = ST.STORE
   AND IL.ITEM = SOH.ITEM
   AND IL.LOC = SOH.LOC
   AND ST.STORE in
       ('120124', '120094', '120165', '120010', '120011', '120028');
