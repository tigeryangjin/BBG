select --a.item,
 A.DEPT,
 A.TRAN_CODE,
 --units,
 total_cost,
 total_retail,
 coupon_amt,
 total_retail + nvl(coupon_amt, 0)
  from (select location,
               --item,
               DEPT,
               TRAN_CODE,
               sum(units) units,
               sum(total_cost) total_cost,
               sum(total_retail) total_retail
          from tran_data_history
         where tran_date = date '2016-06-28'
           and location = '120033'
           and tran_code in (1, 3)
           AND DEPT = 29
         group by location /*, item*/, DEPT, TRAN_CODE) a,
       (SELECT ssd.business_date,
               ssd.store,
               --sti.item,
               STI.DEPT,
               IM.INVENTORY_IND,
               SUM(std.qty * unit_discount_amt) coupon_amt
          FROM sa_store_day ssd,
               sa_tran_head sth,
               sa_tran_item sti,
               sa_tran_disc std,
               ITEM_MASTER  IM
         WHERE ssd.business_date = date
         '2016-06-28'
           and ssd.store = 120033
           AND STI.DEPT = 29
           AND IM.ITEM = STI.ITEM
           and ssd.store_day_seq_no = sth.store_day_seq_no
           AND ssd.store = sth.store
           AND ssd.day = sth.day
           AND sth.tran_seq_no = sti.tran_seq_no
           AND sth.store = sti.store
           AND sth.day = sti.day
           AND sti.tran_seq_no = std.tran_seq_no
           AND sti.store = std.store
           AND sti.day = std.day
           AND sti.item_seq_no = std.item_seq_no
           AND std.rms_promo_type IN (50, 51, 52)
         GROUP BY ssd.business_date,
                  ssd.store /*, sti.item*/,
                  STI.DEPT,
                  IM.INVENTORY_IND) b

 where A.DEPT = B.DEPT(+)
   AND DECODE(A.TRAN_CODE, 1, 'Y', 'N') = B.INVENTORY_IND
--a.item = b.item(+)
--order by item
;

select a.item,
       units,
       total_cost,
       total_retail,
       coupon_amt,
       total_retail + nvl(coupon_amt, 0)
  from (select location,
               item,
               sum(units) units,
               sum(total_cost) total_cost,
               sum(total_retail) total_retail
          from tran_data_history
         where tran_date = date '2016-06-28'
           and location = '120033'
           and tran_code in (1, 3)
         group by location, item) a,
       (SELECT ssd.business_date,
               ssd.store,
               sti.item,
               SUM(std.qty * unit_discount_amt) coupon_amt
          FROM sa_store_day ssd,
               sa_tran_head sth,
               sa_tran_item sti,
               sa_tran_disc std
         WHERE ssd.business_date = date
         '2016-06-28'
           and ssd.store = 120033
           and ssd.store_day_seq_no = sth.store_day_seq_no
           AND ssd.store = sth.store
           AND ssd.day = sth.day
           AND sth.tran_seq_no = sti.tran_seq_no
           AND sth.store = sti.store
           AND sth.day = sti.day
           AND sti.tran_seq_no = std.tran_seq_no
           AND sti.store = std.store
           AND sti.day = std.day
           AND sti.item_seq_no = std.item_seq_no
           AND std.rms_promo_type IN (50, 51, 52)
         GROUP BY ssd.business_date, ssd.store, sti.item) b

 where a.item = b.item(+)
 order by item;
