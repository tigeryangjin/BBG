select t2.loc 门店编码,
       MAX((select s.store_name from store s where s.store=t2.loc)) 门店名称,
       im.item 商品编码,
			 im.item_desc 商品名称, 
       t2.qty 库存数量,
       t2.qm_cost 库存金额,
			 t2.day_total 周转天数
  from (select t.loc,
               t.item,
               t.qty,
               t.qm_cost,
               case
                 when t1.total_cost = 0 then
                  ''
                 else
                  to_char(round(((t.qm_cost + t.qch_cost) / 2) /
                                t1.total_cost,
                                4))
               end as day_total
          from (select ils1.loc,
                       ils1.item,
                       sum(ils1.stock_on_hand + ils1.in_transit_qty) qty,
                       sum((ils1.stock_on_hand + ils1.in_transit_qty) *
                           ils1.av_cost) qm_cost,
                       sum((ils2.stock_on_hand + ils2.in_transit_qty) *
                           ils2.av_cost) qch_cost
                  from item_loc_soh_hist             ils1,
                       rmshist.item_loc_soh_20130831 ils2
                 where ils1.item = ils2.item(+)
                   and ils1.loc = ils2.loc(+)
                   and ils1.stock_on_hand + ils1.in_transit_qty <> 0
                   and ils1.soh_bak_date = DATE'2013-9-30'
                 group by ils1.loc, ils1.item) t,
               (select th.location,
                       th.item,
                       round(sum(th.total_cost) / 30, 4) total_cost
                  from tran_data_history th
                 where th.tran_code = 1
                   and th.tran_date between DATE'2013-9-1' and DATE'2013-9-30'
                 group by th.location, th.item) t1
         where t.loc = t1.location(+)
           and t.item = t1.item(+)
           and t.loc in (120157,
                         120161,
                         120011,
                         120002,
                         120004,
                         120008,
                         120014,
                         120024,
                         120027,
                         120158)) t2,
       item_master im
 where t2.item = im.item
   --and t2.day_total >180
 group by t2.loc, im.item,im.item_desc,t2.qty,t2.qm_cost,t2.day_total;
