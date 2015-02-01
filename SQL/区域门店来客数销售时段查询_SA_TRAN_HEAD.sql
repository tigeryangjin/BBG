SELECT trunc(t.tran_datetime) 日期,
       max(r.region_name) 区域,
       t.store 门店编码,
       max(st.store_name) 门店名称,
       '07:00-10:00'  时间段,
       count(1) 来客数,
       sum(t.value) 销售金额,
       round(sum(t.value) / count(1), 4) 客单价
  FROM sa_tran_head t,store st,district d,region r
 where t.tran_datetime >= to_date ('2013-11-10 07:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.tran_datetime < to_date ('2013-11-10 10:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.store = st.store
   and st.district = d.district
   and d.region = r.region
 group by t.store, trunc(t.tran_datetime)
having sum(t.value) <> 0
union all
SELECT trunc(t.tran_datetime) 日期,
       max(r.region_name) 区域,
       t.store 门店编码,
       max(st.store_name) 门店名称,
       '19:00-22:00'  时间段,
       count(1) 来客数,
       sum(t.value) 销售金额,
       round(sum(t.value) / count(1), 4) 客单价
  FROM sa_tran_head t,store st,district d,region r
 where t.tran_datetime >= to_date ('2013-11-10 19:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.tran_datetime < to_date ('2013-11-10 22:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.store = st.store
   and st.district = d.district
   and d.region = r.region
 group by t.store, trunc(t.tran_datetime)
having sum(t.value) <> 0 

