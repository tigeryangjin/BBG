SELECT SUM(UNITS)
	FROM RMS.TRAN_DATA_HISTORY T
 WHERE T.ITEM = 800009235
	 AND T.TRAN_DATE BETWEEN DATE '2013-05-09' AND DATE '2013-05-31';
AND T.TRAN_CODE IN(1, 3);

--高晶
select a.item, sum(a.qty) qty
	from rms.CMX_SUPP_SALES a
 where a.item = '800009235'
	 AND to_char(sales_date, 'yyyymmdd') between '20130509' and '20130531'
 group by a.item
					
					 SELECT SUM(T.QTY)
						 FROM cmx_supp_sales T
						WHERE T.ITEM = 800009235
							AND SALES_DATE BETWEEN DATE '2013-05-09' AND DATE
						'2013-06-01';


--刘兴 
--日期条件使用ORIGIN_SALES_DATE列
SELECT *
	FROM RMS.CMX_SUPP_SALES A
 WHERE A.ITEM = '800009235'
	 AND TO_CHAR(A.ORIGIN_SALES_DATE, 'yyyymmdd') BETWEEN '20130509' AND
			 '20130531'

--excel
	select a.item,
				 b.supp_pack_size,
				 b.inner_pack_size,
				 count(distinct a.store) shop_num,
				 sum(a.qty) qty,
				 sum(a.total_retail)
					from cmx_supp_sales a, item_supp_country b
				 where a.item = b.item
					 and a.supplier = b.supplier
					 and to_char(sales_date, 'yyyymmdd') between '20130509' and
							 '20130531'
					 and a.item in ('800009235', '800009295', '800009300')
				 group by a.item, b.supp_pack_size, b.inner_pack_size
