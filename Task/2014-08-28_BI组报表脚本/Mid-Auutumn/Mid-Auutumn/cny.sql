--全部未税净销售额
DROP TABLE REPORT_CNY_SALES;
COMMIT;
create table REPORT_CNY_SALES AS
SELECT province_en,province_s,format_definition,district_en,shopid,store_name_en,status,division_en,categoryid,categoryname_en,
CNY,ty,
ROUND(sum(case when sdate=ty then xse else 0 end)/10000,2) salesty,--今年销售金额
ROUND(sum(case when sdate=ty then xse else 0 end)/10000,2) salesctsty,--今年销售占比
ROUND(sum(case when sdate=ty then ml else 0 end )/10000,2) marginty,--今年毛利额
ROUND(sum(case when sdate=ly then xse else 0 end)/10000,2) salesly,--去年销售金额
ROUND(sum(case when sdate=ly then xse else 0 end)/10000,2) salesctsly,--去年销售占比
ROUND(sum(case when sdate=ly then ml else 0 end )/10000,2) marginly--去年销售毛利额
 FROM STORESALE_NRATE,ORGCATE_T,report_cny2014
WHERE SHOPID=STOREID AND LCATE=CATEGORYID AND BUSINESS_DIVISION='超市事业部'
group by province_en,province_s,format_definition,district_en,shopid,store_name_en,status,division_en,categoryid,categoryname_en,
CNY,ty;
COMMIT;
CREATE INDEX REPORT_CNY_SALES_IND ON REPORT_CNY_SALES(PROVINCE_EN,PROVINCE_S,SHOPID,FORMAT_DEFINITION,DISTRICT_EN,DIVISION_EN,CATEGORYID,STATUS);
