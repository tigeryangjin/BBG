select distinct t4.dept 大类,
								t.item 商品编码,
								t5.to_loc 门店编码,
								t.start_date 促销开始日期,
								t.end_date 促销结束日期,
								t.promo_cost 促销进价,
								t1.store_name 门店名称,
								t2.item_desc 商品名称,
								t5.receive_date 入库时间,
								t3.qty_received 入库数量,
								t3.qty_received * t3.unit_cost 入库金额
	from cmx_dm_track t,
			 store        t1,
			 item_master  t2,
			 shipsku      t3,
			 deps         t4,
			 shipment     t5
 where t.start_date >= date
 '2013-09-04'
	 and t.item = t2.item
	 and t4.dept = t2.dept
	 and t2.item = t3.item
	 and t5.shipment = t3.shipment
	 and t.store = t1.store
	 and t.store = t5.to_loc
	 AND t5.RECEIVE_DATE BETWEEN t.START_DATE AND t.END_DATE
UNION
select distinct t4.dept 大类,
                t.item 商品编码,
                118001 门店编码,
                t.start_date 促销开始日期,
                t.end_date 促销结束日期,
                t.promo_cost 促销进价,
                '仓库' 门店名称,
                t2.item_desc 商品名称,
                t3.receive_date 入库时间,
                t3.qty_received 入库数量,
                t3.COST_received 入库金额
  from cmx_dm_track t,
       store t1,
       item_master t2,
       (select PROD.PROD_IT_NUM ITEM,
               TO_DATE(SUBSTR(CM.DT_WID, 2, 8), 'YYYYMMDD') receive_date,
               CM.RECEIVED_QTY qty_received,
               CM.BBG_REFERENCE_FO2 COST_received
          from W_RTL_SUPPCM_IT_LC_DY_F@rms_ra       CM,
               RABATCHER.W_PRODUCT_D_RTL_TMP@RMS_RA PROD
         WHERE CM.PROD_WID = PROD.PROD_IT_WID
           AND CM.ORG_WID = 9
           AND CM.RECEIVED_QTY > 0) t3,
       deps t4
 where t.start_date >= date
 '2013-09-04'
   and t.item = t2.item
   and t4.dept = t2.dept
   and t2.item = t3.item
      --and t5.shipment = t3.shipment
   and t.store = t1.store
      --and t.store = t5.to_loc
   AND t3.RECEIVE_DATE BETWEEN t.START_DATE AND t.END_DATE;

