select *
  from tran_data td, cmx_item_loc_info cil
 where td.ITEM = cil.item
   and td.LOCATION = cil.loc
   and cil.business_mode in ('LY', 'ZL')
   and (cil.standard_gross_margin is null or cil.promo_gross_margin is null);


select *
  from sa_tran_item td, cmx_item_loc_info cil
 where td.ITEM = cil.item
   and td.store = cil.loc
   and cil.business_mode in ('LY', 'ZL')
   and (cil.standard_gross_margin is null or cil.promo_gross_margin is null)
   and td.day=12;

select r.range_id, c.start_month, c.end_month
      from cmx_contract c, cmx_contract_range r,sa_tran_item i
     where c.contract_id = r.contract_id
       and c.contract_type in ('LY', 'ZL')
       and c.status = 'A' 
       and i.store = r.loc
       and i.day = 12
       and r.loc_type = 'S'
       and not exists (select 1
              from cmx_contract_range_plan p
             where p.range_id = r.range_id);
