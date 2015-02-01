select * from CMX.CMX_SUPP_SALES t;
SELECT T.V_DATE, SUM(T.TOTAL_RETAIL)
  FROM CMX.CMX_SUPP_SALES T
 WHERE T.V_DATE BETWEEN DATE '2014-08-01' AND DATE '2014-08-17'
 GROUP BY T.V_DATE;

SELECT T.DAY_DT, SUM(T.SALES_AMT)
  FROM BBG_RA_SUPP_SALES_FV T
 GROUP BY T.DAY_DT;

SELECT T.DAY_DT, SUM(T.SUPP_SALES_AMT)
  FROM RADM.BBG_RA_SLS_IT_LC_DY_FS@RMS_RA T
 GROUP BY T.DAY_DT;
--ODI中函数
$(AMT) / (1 + (
  select VAT_RATE / 100
    from VAT_ITEM
   where ACTIVE_DATE = (select max(v.ACTIVE_DATE)
                          from VAT_ITEM v
                         where v.ITEM = $(ITEM_NUM)
                           and v.VAT_REGION = $(VAT_REGION_NUM)
                           AND V.VAT_TYPE IN ('R', 'B')
                           and v.ACTIVE_DATE <= $(TRAN_DT))
     and ITEM = $(ITEM_NUM)
     and VAT_REGION = $(VAT_REGION_NUM)
     and VAT_TYPE IN ('R', 'B')))
  --SUPP_SALES_AMT
   BBG_RA_SUPP_SALES_FV.SALES_AMT / (1 + (select VAT_RATE / 100
                                            from VAT_ITEM
                                           where ACTIVE_DATE =
                                                 (select max(v.ACTIVE_DATE)
                                                    from VAT_ITEM v
                                                   where v.ITEM =
                                                         BBG_RA_SUPP_SALES_FV.ITEM
                                                     and v.VAT_REGION = 1000
                                                     AND V.VAT_TYPE IN
                                                         ('R', 'B')
                                                     and v.ACTIVE_DATE <=
                                                         BBG_RA_SUPP_SALES_FV.DAY_DT)
                                             and ITEM =
                                                 BBG_RA_SUPP_SALES_FV.ITEM
                                             and VAT_REGION = 1000
                                             and VAT_TYPE IN
                                                 ('R', 'B')))
  
  --TRAN_DATA_HISTORY-------------------------------------------------------------------------------
    SELECT SUM(T.TOTAL_RETAIL)
      FROM RMS.TRAN_DATA_HISTORY T
     WHERE T.TRAN_DATE = DATE '2014-01-24'
       AND T.TRAN_CODE IN (1, 3);


--RMS.CMX_SUPP_SALES------------------------------------------------------------------------------
SELECT SUM(T.TOTAL_RETAIL)
  FROM RMS.CMX_SUPP_SALES T
 WHERE T.Origin_Sales_Date = DATE '2014-01-24';

--差异核对
select *
  from (SELECT TRAN_DATE, item, location, SUM(T.TOTAL_RETAIL) tl
          FROM RMS.TRAN_DATA_HISTORY t
         WHERE T.TRAN_DATE >= DATE '2014-08-01'
           AND T.TRAN_CODE IN (1, 3)
         GROUP BY TRAN_DATE, item, LOCATION
         ORDER BY TRAN_DATE) a
  FULL JOIN
--RMS.CMX_SUPP_SALES---
 (SELECT Origin_Sales_Date, item, t.store, SUM(T.TOTAL_RETAIL) tl
    FROM CMX_SUPP_SALES T
   WHERE T.Origin_Sales_Date >= DATE '2014-08-01'
   GROUP BY Origin_Sales_Date, item, t.store
   ORDER BY Origin_Sales_Date) b
    ON a.item = b.item
   AND a.location = b.store
   AND A.TRAN_DATE = B.Origin_Sales_Date
 WHERE abs(NVL(a.tl, 0) - NVL(b.tl, 0)) > 1;

--差异核对  剔除招商，电商批发
select *
  from (SELECT T.TRAN_DATE, T.item, T.location, SUM(T.TOTAL_RETAIL) tl
          FROM RMS.TRAN_DATA_HISTORY t,
               RMS.ITEM_LOC          IL,
               CMX.CMX_SUPPLIER_INFO c
         WHERE T.TRAN_DATE BETWEEN DATE '2014-08-01' AND DATE'2014-08-31'
           AND T.TRAN_CODE IN (1, 3, 82)
           and t.item = il.item
           and t.location = il.loc
           and il.primary_supp = c.supplier
           and c.business_type <> 'ZS'
           AND NVL(T.REF_NO_1, '00') NOT IN
               (SELECT ADD_ATRRIB1
                  FROM CMX_IF_WF_HEAD
                 WHERE CUSTOMERID = '060002')
         GROUP BY T.TRAN_DATE, T.item, T.LOCATION
         ORDER BY T.TRAN_DATE) a
  FULL JOIN
--RMS.CMX_SUPP_SALES---
 (SELECT Origin_Sales_Date, item, t.store, SUM(T.TOTAL_RETAIL) tl
    FROM CMX_SUPP_SALES T
   WHERE T.Origin_Sales_Date BETWEEN DATE '2014-08-01' AND DATE'2014-08-31'
   GROUP BY Origin_Sales_Date, item, t.store
   ORDER BY Origin_Sales_Date) b
    ON a.item = b.item
   AND a.location = b.store
   AND A.TRAN_DATE = B.Origin_Sales_Date
 WHERE abs(NVL(a.tl, 0) - NVL(b.tl, 0)) > 1;
