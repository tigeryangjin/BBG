select il.item,il.loc_type,il.loc,il.primary_supp from item_loc il, tran_data td
 where not exists (select 1
          from deal_item_loc_explode dile
         where td.ITEM = dile.item
           and td.LOCATION = dile.location)
   and td.TRAN_CODE in (20, 24)
   and il.item=td.ITEM
   and il.loc=td.LOCATION;