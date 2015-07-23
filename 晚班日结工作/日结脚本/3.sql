select loc,
       md_sale,
       resa_sale,
       md_sale - resa_sale as diff,
       case
         when (md_sale = 0 and resa_sale = 0) or (md_sale - resa_sale > 10) then
          '�ŵ�������δ�ϴ�'
         when (resa_sale - md_sale > 10000 and md_sale > 1000) then
          '�ŵ������ظ���'
         else
          ''
       end comment1
  from rj_shop@sale a, rtlog_check_audi@sale b
 where a.rjvalid = 'Y'
   and a.shopid = b.loc(+)
   and saledate = to_char(get_vdate, 'YYYYMMDD')
 order by 4;
