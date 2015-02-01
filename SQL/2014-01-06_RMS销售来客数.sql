select t.store , s.store_name, count(t.tran_seq_no), sum(t.sale_total) 
  from (select st.store,
               st.tran_seq_no,
               --st.dept,
               sum(st.qty * (st.unit_retail-nvl(std.unit_discount_amt,0))) sale_total
          from sa_tran_item st, SA_TRAN_HEAD sh, SA_STORE_DAY sd,sa_tran_disc std
         where st.store = sh.store
           and st.day = sh.day
           and st.tran_seq_no = sh.tran_seq_no
           and sh.store_day_seq_no = sd.store_day_seq_no
           and sh.store = sd.store
           and sh.day = sd.day
           and st.store = std.store(+)
           and st.day = std.day(+)
           and st.tran_seq_no = std.tran_seq_no(+)
           and st.item_seq_no = std.item_seq_no(+)
           and sd.business_date between &PM_STDATE and &PM_ENDDATE
           and st.dept not in (75, 76, 99, 9101)
           
          group by st.store, st.tran_seq_no) t,
       store s
 where t.store = s.store
 group by t.store, s.store_name;
