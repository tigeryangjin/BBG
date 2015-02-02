SELECT 门店编码,
       SUM(交易笔数) 客流,
       SUM(销售金额) 销售,
       SUM(OVER100CNT) OVER100CNT,
       SUM(ORVER100AMT) ORVER100AMT
  FROM (
        
        select t.tran_datetime 销售时段,
                t.store 门店编码,
                s.store_name 门店名称,
                count(t.tran_seq_no) 交易笔数,
                sum(t.sale_total) 销售金额,
                sum(t.qty) 销售数量,
                CASE
                  WHEN T.SALE_TOTAL >= 100 THEN
                   1
                  ELSE
                   0
                END OVER100CNT,
                CASE
                  WHEN T.SALE_TOTAL >= 100 THEN
                   T.SALE_TOTAL
                  ELSE
                   0
                END ORVER100AMT
          from (select to_char(sh.tran_datetime, 'yyyy/MM/dd hh24') tran_datetime,
                        st.store,
                        st.tran_seq_no,
                        --st.dept,
                        sum(st.qty) qty,
                        sum(st.qty *
                            (st.unit_retail - nvl(std.unit_discount_amt, 0))) sale_total
                   from sa_tran_item st,
                        SA_TRAN_HEAD sh,
                        SA_STORE_DAY sd,
                        sa_tran_disc std
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
                       --and st.store = &PM_STORE
                       --and sd.business_date between &PM_STDATE and &PM_ENDDATE
                    and sd.business_date between date
                  '2014-06-29'
                    and date '2014-06-30'
                  group by to_char(sh.tran_datetime, 'yyyy/MM/dd hh24'),
                           st.store,
                           st.tran_seq_no) t,
                store s
         where t.store = s.store
         group by t.tran_datetime, t.store, s.store_name, T.SALE_TOTAL
         order by 1) A
 WHERE 销售时段 BETWEEN '2014/06/29 20' AND '2014/06/30 01'
 GROUP BY 门店编码;
