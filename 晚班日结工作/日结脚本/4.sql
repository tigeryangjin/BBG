select loc,
       md_sale,
       resa_sale,
       md_sale - resa_sale as diff,
       case
         when (md_sale = 0 and resa_sale = 0) or (md_sale - resa_sale > 10) then
          '门店有销售未上传'
         when (resa_sale - md_sale > 10000 and md_sale > 1000) then
          '门店销售重复传'
         else
          ''
       end comment1
  from rj_shop@sale a, rtlog_check_audi@sale b
 where a.rjvalid = 'Y'
   and a.shopid = b.loc(+)
   and saledate = to_char(get_vdate, 'YYYYMMDD')
 order by 4;
