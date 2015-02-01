SELECT trunc(t.tran_datetime) ����,
       max(r.region_name) ����,
       t.store �ŵ����,
       max(st.store_name) �ŵ�����,
       '07:00-10:00'  ʱ���,
       count(1) ������,
       sum(t.value) ���۽��,
       round(sum(t.value) / count(1), 4) �͵���
  FROM sa_tran_head t,store st,district d,region r
 where t.tran_datetime >= to_date ('2013-11-10 07:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.tran_datetime < to_date ('2013-11-10 10:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.store = st.store
   and st.district = d.district
   and d.region = r.region
 group by t.store, trunc(t.tran_datetime)
having sum(t.value) <> 0
union all
SELECT trunc(t.tran_datetime) ����,
       max(r.region_name) ����,
       t.store �ŵ����,
       max(st.store_name) �ŵ�����,
       '19:00-22:00'  ʱ���,
       count(1) ������,
       sum(t.value) ���۽��,
       round(sum(t.value) / count(1), 4) �͵���
  FROM sa_tran_head t,store st,district d,region r
 where t.tran_datetime >= to_date ('2013-11-10 19:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.tran_datetime < to_date ('2013-11-10 22:00:00','yyyy-mm-dd hh24:mi:ss')
   and t.store = st.store
   and st.district = d.district
   and d.region = r.region
 group by t.store, trunc(t.tran_datetime)
having sum(t.value) <> 0 

