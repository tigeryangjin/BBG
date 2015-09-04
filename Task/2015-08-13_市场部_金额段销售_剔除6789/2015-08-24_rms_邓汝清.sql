--整体（注意改日期）
select resa1.store,
       count(distinct resa1.tran_seq_no),
       sum(resa1.normal_sale - nvl(resa2.disc_value, 0))
  from (select SSD1.BUSINESS_DATE,
               sth1.store,
               sth1.tran_seq_no,
               sti1.dept,
               sti1.item_seq_no,
               sti1.qty * sti1.unit_retail normal_sale
          from sa_tran_head sth1, sa_store_day ssd1, sa_tran_item sti1
         where SSD1.BUSINESS_DATE >= date '2015-9-1'
           and SSD1.BUSINESS_DATE <= date
         '2015-9-1'
           and sth1.store_day_seq_no = SSD1.STORE_DAY_SEQ_NO
           and sth1.tran_seq_no = sti1.tran_seq_no
           and sth1.store = sti1.store
           and sth1.day = sti1.day) resa1,
       (select SSD1.BUSINESS_DATE,
               sth1.store,
               sth1.tran_seq_no,
               sti1.dept,
               sti1.item_seq_no,
               sum(nvl(std1.qty, 0) * nvl(std1.unit_discount_amt, 0)) disc_value
          from sa_tran_head sth1,
               sa_store_day ssd1,
               sa_tran_item sti1,
               sa_tran_disc std1
         where SSD1.BUSINESS_DATE >= date '2015-9-1'
           and SSD1.BUSINESS_DATE <= date
         '2015-9-1'
           and sth1.store_day_seq_no = SSD1.STORE_DAY_SEQ_NO
           and sth1.tran_seq_no = sti1.tran_seq_no
           and sth1.store = sti1.store
           and sth1.day = sti1.day
           and sti1.tran_seq_no = std1.tran_seq_no(+)
           and sti1.store = std1.store(+)
           and sti1.day = std1.day(+)
           and STI1.ITEM_SEQ_NO = std1.ITEM_SEQ_NO(+)
         group by SSD1.BUSINESS_DATE,
                  sth1.store,
                  sth1.tran_seq_no,
                  sti1.dept,
                  sti1.item_seq_no) resa2
 where resa1.business_date = resa2.business_date(+)
   and resa1.store = resa2.store(+)
   and resa1.tran_seq_no = resa2.tran_seq_no(+)
   and resa1.dept = resa2.dept(+)
   and resa1.item_seq_no = resa2.item_seq_no(+)
   and resa1.dept in (12,
                      13,
                      14,
                      15,
                      16,
                      17,
                      18,
                      19,
                      21,
                      22,
                      23,
                      24,
                      25,
                      26,
                      27,
                      29,
                      30,
                      31,
                      32,
                      33,
                      34,
                      35,
                      36,
                      37,
                      38,
                      39,
                      40,
                      41,
                      42)
 group by resa1.store
 order by 1; 

--大于等于多少（注意改日期及大于等于条件值）
select store, count(*), sum(sale)
  from (select resa1.store,
               resa1.tran_seq_no,
               sum(resa1.normal_sale - nvl(resa2.disc_value, 0)) sale
          from (select SSD1.BUSINESS_DATE,
                       sth1.store,
                       sth1.tran_seq_no,
                       sti1.dept,
                       sti1.item_seq_no,
                       sti1.qty * sti1.unit_retail normal_sale
                  from sa_tran_head sth1,
                       sa_store_day ssd1,
                       sa_tran_item sti1
                 where SSD1.BUSINESS_DATE >= date
                 '2014-1-24'
                   and SSD1.BUSINESS_DATE <= date
                 '2014-1-26'
                   and sth1.store_day_seq_no = SSD1.STORE_DAY_SEQ_NO
                   and sth1.tran_seq_no = sti1.tran_seq_no
                   and sth1.store = sti1.store
                   and sth1.day = sti1.day) resa1,
               (select SSD1.BUSINESS_DATE,
                       sth1.store,
                       sth1.tran_seq_no,
                       sti1.dept,
                       sti1.item_seq_no,
                       sum(nvl(std1.qty, 0) * nvl(std1.unit_discount_amt, 0)) disc_value
                  from sa_tran_head sth1,
                       sa_store_day ssd1,
                       sa_tran_item sti1,
                       sa_tran_disc std1
                 where SSD1.BUSINESS_DATE >= date
                 '2014-1-24'
                   and SSD1.BUSINESS_DATE <= date
                 '2014-1-26'
                   and sth1.store_day_seq_no = SSD1.STORE_DAY_SEQ_NO
                   and sth1.tran_seq_no = sti1.tran_seq_no
                   and sth1.store = sti1.store
                   and sth1.day = sti1.day
                   and sti1.tran_seq_no = std1.tran_seq_no(+)
                   and sti1.store = std1.store(+)
                   and sti1.day = std1.day(+)
                   and STI1.ITEM_SEQ_NO = std1.ITEM_SEQ_NO(+)
                 group by SSD1.BUSINESS_DATE,
                          sth1.store,
                          sth1.tran_seq_no,
                          sti1.dept,
                          sti1.item_seq_no) resa2
         where resa1.business_date = resa2.business_date(+)
           and resa1.store = resa2.store(+)
           and resa1.tran_seq_no = resa2.tran_seq_no(+)
           and resa1.dept = resa2.dept(+)
           and resa1.item_seq_no = resa2.item_seq_no(+)
           and resa1.dept in (12,
                              13,
                              14,
                              15,
                              16,
                              17,
                              18,
                              19,
                              21,
                              22,
                              23,
                              24,
                              25,
                              26,
                              27,
                              29,
                              30,
                              31,
                              32,
                              33,
                              34,
                              35,
                              36,
                              37,
                              38,
                              39,
                              40,
                              41,
                              42)
         group by resa1.store, resa1.tran_seq_no)
 where sale >= 100
 group by store
 order by 1;
