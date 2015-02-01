--BIP报表语句
select c.supplier 供应商编码,
       s.sup_name 供应商名称,
       --c.contract_no 合同编号,
       --c.rev_no 版本,
       --dd.deal_comp_type 费用代码,
       sum(dail.actual_turnover_revenue) 金额
  from deal_actuals_item_loc dail,
       deal_head             dh,
       deal_detail           dd,
       cmx_contract          c,
       sups                  s
 where c.contract_no || '_' || c.rev_no = dh.ext_ref_no
   and c.status = 'A'
   and dh.deal_id = dd.deal_id
   and dd.deal_id = dail.deal_id
   and dd.deal_detail_id = dail.deal_detail_id
   and c.supplier=s.supplier
   and dail.reporting_date = last_day(get_vdate)
   --and not(:PM_CODE is null and :PM_TYPE is null)
   --and dd.deal_comp_type =:PM_CODE
   --and dail.loc_type=decode(:PM_TYPE,'',dail.loc_type,:PM_TYPE)
   and get_vdate between dh.active_date and
       nvl(dh.close_date, dh.active_date + 100)
   and c.supplier=12000287
 group by c.supplier,s.sup_name;

SELECT DISTINCT T.DT_WID FROM W_RTL_SUPPCM_IT_LC_DY_F T;

--RA跟踪出的语句
select distinct 0 as c1,
     D1.c2 as c2,
     D1.c1 as c3
from 
     (select sum(T963294.BBG_REFERENCE_FO2) as c1,
               T954755.SUPPLIER_NUM as c2
          from 
               W_MCAL_DAY_DV T960506 /* Dim_W_MCAL_DAY_D_Retail_Gregorian_Calendar */ ,
               W_PARTY_ORG_D T954755 /* Dim_W_PARTY_ORG_D_Retail_Supplier */ ,
               W_RTL_SUPPCM_IT_LC_DY_F T963294 /* Fact_W_RTL_SUPPCM_IT_LC_DY_F */ 
          where  ( T954755.ROW_WID = T963294.SUPPLIER_WID and T960506.ROW_WID = T963294.DT_WID and T960506.MCAL_CAL_WID = 1.0 and '2010' < T960506.CAL_YEAR and (T954755.SUPPLIER_NUM in ('12000287')) and  TRUNC(T960506.MCAL_DAY_DT) between TO_DATE('2013-10-01' , 'YYYY-MM-DD') and TO_DATE('2013-10-28' , 'YYYY-MM-DD') ) 
          group by T954755.SUPPLIER_NUM
     ) D1
order by c2;
--2658762.2239
SELECT SUM(BBG_REFERENCE_FO2) 
FROM   W_RTL_SUPPCM_IT_LC_DY_F SUPPCM,W_PARTY_ORG_D SUPP WHERE SUPPCM.SUPPLIER_WID=SUPP.ROW_WID AND SUPP.SUPPLIER_NUM='12000287' AND SUPPCM.DT_WID BETWEEN '120131001000' AND '120131028000';
--RA
--订单号，收货金额
SELECT SUPPCM.PURCHASE_ORDER_ID,SUM(SUPPCM.BBG_REFERENCE_FO2) 
FROM W_RTL_SUPPCM_IT_LC_DY_F SUPPCM,W_PARTY_ORG_D SUPP WHERE SUPPCM.SUPPLIER_WID=SUPP.ROW_WID AND SUPP.SUPPLIER_NUM='12000287' AND SUPPCM.DT_WID BETWEEN '120131001000' AND '120131028000' /*AND SUPPCM.PURCHASE_ORDER_ID='840454'*/
GROUP BY SUPPCM.PURCHASE_ORDER_ID;



--RMS数据
SELECT SUM(TDH.TOTAL_COST)
FROM RMS.TRAN_DATA_HISTORY@RA_RMS_DBLINK TDH,RMS.ORDHEAD@RA_RMS_DBLINK ORDH
WHERE TDH.REF_NO_1=ORDH.ORDER_NO AND ORDH.SUPPLIER='12000287' AND TDH.TRAN_DATE BETWEEN DATE'2013-10-01' AND DATE'2013-10-28' AND TDH.TRAN_CODE=20;

--RMS
--订单号，收货金额
SELECT TDH.REF_NO_1,SUM(TDH.TOTAL_COST)
FROM RMS.TRAN_DATA_HISTORY@RA_RMS_DBLINK TDH,RMS.ORDHEAD@RA_RMS_DBLINK ORDH
WHERE TDH.REF_NO_1=ORDH.ORDER_NO AND ORDH.SUPPLIER='12000287' AND TDH.TRAN_DATE BETWEEN DATE'2013-10-01' AND DATE'2013-10-28' AND TDH.TRAN_CODE=20
GROUP BY TDH.REF_NO_1;

--差异查找
SELECT * FROM TRAN_DATA_HISTORY@RA_RMS_DBLINK T WHERE T.TRAN_CODE=20 AND T.REF_NO_1='808668';
SELECT * FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T WHERE T.PURCHASE_ORDER_ID='808668';

--W_RTL_SUPPCM_IT_LC_DY_F重复行查找
SELECT T.ORG_WID,T.PROD_WID,T.DT_WID,T.PURCHASE_ORDER_ID,T.BBG_REFERENCE_FO1,T.BBG_REFERENCE_FO2,COUNT(*) 
FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T 
GROUP BY T.ORG_WID,T.PROD_WID,T.DT_WID,T.PURCHASE_ORDER_ID,T.BBG_REFERENCE_FO1,T.BBG_REFERENCE_FO2 
HAVING COUNT(*)>1;

SELECT T.INTEGRATION_ID,T.BBG_REFERENCE_FO1,T.BBG_REFERENCE_FO2,COUNT(*) 
FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T 
WHERE T.DT_WID BETWEEN '120130501000' AND '120130507000'
GROUP BY T.INTEGRATION_ID,T.BBG_REFERENCE_FO1,T.BBG_REFERENCE_FO2 
HAVING COUNT(*)>1;

SELECT * FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T WHERE T.PURCHASE_ORDER_ID='854091' AND T.PROD_WID='312661';
SELECT * FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F T WHERE T.Integration_Id='700001082~118001~11-OCT-13~814236~811795';
--重复数据删除
--SELECT * FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F A
--删除2013年5月7日之后的
DELETE FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F A
WHERE (A.INTEGRATION_ID,
       A.BBG_REFERENCE_FO1,
			 A.BBG_REFERENCE_FO2) in 
      (select INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2
       from W_RTL_SUPPCM_IT_LC_DY_F 
       group by INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2 
       having count(*) > 1)
and row_wid not in (
                       select min(row_wid) 
                       from W_RTL_SUPPCM_IT_LC_DY_F 
									     group by INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2 
									     having count(*)>1
									 ) 
AND A.DT_WID>'120130507000';
COMMIT;

--删除2013年5月8日之前的
--SELECT * FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F A
DELETE FROM RADM.W_RTL_SUPPCM_IT_LC_DY_F A
WHERE (A.INTEGRATION_ID,A.BBG_REFERENCE_FO1,A.BBG_REFERENCE_FO2) in 
      (select INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2
         from W_RTL_SUPPCM_IT_LC_DY_F
        WHERE SUBSTR(DT_WID,2,6) = '201303' 
     group by INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2 
       having count(*) > 1)
and row_wid not in (
                   select min(row_wid) 
									 from W_RTL_SUPPCM_IT_LC_DY_F 
									 WHERE SUBSTR(DT_WID,2,6) = '201303' 
									 group by INTEGRATION_ID,BBG_REFERENCE_FO1,BBG_REFERENCE_FO2 
									 having count(*)>1
									 );
COMMIT;

/*
RTL_SUPPCM_F_TMP.BBG_RECEIVED_AMOUNT
RTL_SUPPCM_D_TMP.BBG_RECEIVED_AMOUNT
RTL_SUPPCM_A_TMP.BBG_RECEIVED_AMOUNT
IF_TRAN_DATA.TOTAL_COST

ORDER_NO:840454,TRAN_DATA_HISTORY:927.131,W_RTL_SUPPCM_IT_LC_DY_F:927.131
*/
--ORDHEAD.ORDER_NO=IF_TRAN_DATA.REF_NO_1
SELECT COUNT(*) FROM IF_TRAN_DATA T WHERE T.TRAN_CODE=20;
SELECT * FROM IF_TRAN_DATA T WHERE T.TRAN_CODE=20;
SELECT * FROM ORDHEAD;
SELECT * FROM TRAN_DATA_CODES;
SELECT DISTINCT T.DAY_DT FROM RA_RMS.W_RTL_SUPPCM_A_TMP T;

SELECT * FROM RMS.ORDHEAD T WHERE T.ORDER_NO=808668;
SELECT * FROM RMS.ORDSKU T WHERE T.ORDER_NO=808668;
SELECT * FROM RMS.ORDLOC T WHERE T.ORDER_NO=808668;
SELECT * FROM ALL_ALL_TABLES T WHERE T.table_name LIKE 'ORD%' AND T.owner='RMS' ORDER BY T.table_name;

