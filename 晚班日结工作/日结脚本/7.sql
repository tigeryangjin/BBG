select r.store, r.business_date, r.amount - nvl(s.amount, 0)
  from v_cmx_resa r, v_Cmx_Resa_Tran_Data s
 where r.business_date = get_vdate
   and R.store = S.store(+)
   And get_vdate = s.tran_date(+)
 order by 3;
--3.3.2  -- 数量对比
select r.store, r.business_date, r.qty - s.qty
  from v_cmx_resa_qty r, v_cmx_resa_tran_data s
 where r.business_date = get_vdate
   and s.store = r.store
   and s.tran_date = get_vdate
 order by 3;
--3.3.3  -- tran_data和扣减库存数据
SELECT td.loc, td.qty - (cils.qty - ils.qty)
  FROM (SELECT d.location loc, SUM(DECODE(tran_code, 1, d.units, 0)) qty
          FROM tran_data d
         WHERE d.tran_code IN (1, 3)
         GROUP BY d.location) td,
       (SELECT il.loc, SUM(il.stock_on_hand) qty
          FROM item_loc_soh il
         WHERE il.loc_type = 'S'
         GROUP BY il.loc) ils,
       (SELECT il.loc, SUM(il.stock_on_hand) qty
          FROM cmx_item_loc_soh_13 il
         WHERE il.loc_type = 'S'
         GROUP BY il.loc) cils
 WHERE td.loc = ils.loc
   AND ils.loc = cils.loc;

--按单品
SELECT td.loc, td.item, td.qty - (cils.qty - ils.qty)
  FROM (SELECT d.location loc,
               d.item,
               SUM(DECODE(tran_code, 1, d.units, 0)) qty
          FROM tran_data d
         WHERE d.tran_code IN (1, 3)
           and d.location = 120191
         GROUP BY d.location, d.item) td,
       (SELECT il.loc, il.item, SUM(il.stock_on_hand) qty
          FROM item_loc_soh il
         WHERE il.loc_type = 'S'
           and il.loc = 120191
         GROUP BY il.loc, il.item) ils,
       (SELECT il.loc, il.item, SUM(il.stock_on_hand) qty
          FROM cmx_item_loc_soh_13 il
         WHERE il.loc_type = 'S'
           and il.loc = 120191
         GROUP BY il.loc, il.item) cils
 WHERE td.loc = ils.loc
   AND ils.loc = cils.loc
   and td.item = ils.item
   AND ils.item = cils.item;
