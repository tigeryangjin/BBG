--RA中，供应商销售报表，当供应商编码和供应商名称分成二列时，数据不正确，当只有一列供应商编码或者一列供应商（编码+名称）时，数据都是正确的。

--供应商编码/名称
select D1.c1 as c1,
			 D1.c2 as c2,
			 D1.c3 as c3,
			 D1.c4 as c4,
			 D1.c5 as c5
			 D1.c6 as c6,
			 D1.c7 as c7
	from (select D1.c1 as c1,
							 D1.c2 as c2,
							 D1.c3 as c3,
							 D1.c4 as c4,
							 D1.c5 as c5,
							 D1.c6 as c6,
							 D1.c7 as c7
					from (select 0 as c1,
											 D1.c2 as c2,
											 D1.c3 as c3,
											 D1.c4 as c4,
											 D1.c1 as c5,
											 D1.c5 as c6,
											 D1.c6 as c7,
											 ROW_NUMBER() OVER(PARTITION BY D1.c2, D1.c3, D1.c4, D1.c5, D1.c6 ORDER BY D1.c2 ASC, D1.c3 ASC, D1.c4 ASC, D1.c5 ASC, D1.c6 ASC) as c8
									from (select distinct T1025918.SUPP_SALES_AMT as c1,
																				T960458.PER_NAME_MONTH  as c2,
																				T954755.ORG_NAME        as c3,
																				T954755.SUPPLIER_NUM    as c4,
																				T954755.ROW_WID         as c5,
																				T960458.ROW_WID         as c6
													from W_MONTH_D                 T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */,
															 W_PARTY_ORG_D             T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */,
															 BBG_RA_SLS_CL_LC_MN_CUR_A T1025918 /* Fact_BBG_RA_SLS_CL_LC_MN_CUR_A */
												 where (T954755.ROW_WID = T1025918.SUPPLIER_WID and
															 T954755.SUPPLIER_NUM = '18001366' and
															 T960458.ROW_WID = T1025918.MN_WID and
															 '2010' < T960458.CAL_YEAR and
															 (T960458.PER_NAME_MONTH = '2013 / 10'))) D1) D1
				 where (D1.c8 = 1)) D1
 order by c1, c2, c4, c3;

--供应商编码
select distinct 0 as c1, D1.c2 as c2, D1.c3 as c3, D1.c1 as c4, D1.c4 as c5
	from (select sum(T1025918.SUPP_SALES_AMT) as c1,
							 T960458.PER_NAME_MONTH as c2,
							 T954755.SUPPLIER_NUM as c3,
							 T960458.ROW_WID as c4
					from W_MONTH_D                 T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */,
							 W_PARTY_ORG_D             T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */,
							 BBG_RA_SLS_CL_LC_MN_CUR_A T1025918 /* Fact_BBG_RA_SLS_CL_LC_MN_CUR_A */
				 where (T954755.ROW_WID = T1025918.SUPPLIER_WID and
							 T954755.SUPPLIER_NUM = '18001366' and
							 T960458.ROW_WID = T1025918.MN_WID and
							 '2010' < T960458.CAL_YEAR and
							 (T960458.PER_NAME_MONTH = '2013 / 10'))
				 group by T954755.SUPPLIER_NUM,
									T960458.ROW_WID,
									T960458.PER_NAME_MONTH) D1
 order by c2, c3;
 
 --供应商
 select distinct 0 as c1,
     D1.c2 as c2,
     D1.c3 as c3,
     D1.c1 as c4,
     D1.c4 as c5
from 
     (select sum(T1025918.SUPP_SALES_AMT) as c1,
               T960458.PER_NAME_MONTH as c2,
               concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) as c3,
               T960458.ROW_WID as c4
          from 
               W_MONTH_D T960458 /* Dim_W_MONTH_D_Retail_Gregorian_Calendar */ ,
               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
               BBG_RA_SLS_CL_LC_MN_CUR_A T1025918 /* Fact_BBG_RA_SLS_CL_LC_MN_CUR_A */ 
          where  ( T954755.ROW_WID = T1025918.SUPPLIER_WID and T960458.ROW_WID = T1025918.MN_WID and T960458.PER_NAME_MONTH = '2013 / 10' and concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME) = '18001366-深圳市百利达深贸易有限公司' and '2010' < T960458.CAL_YEAR ) 
          group by T960458.ROW_WID, T960458.PER_NAME_MONTH, concat(concat(cast(T954755.SUPPLIER_NUM as  VARCHAR ( 20 ) ), '-'), T954755.ORG_NAME)
     ) D1
order by c2, c3;
