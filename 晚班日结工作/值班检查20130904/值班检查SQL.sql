---1.外围接口err视图
Select * From v_Cmx_If_In_Error T;

---2.外围系统import视图

select source_if,count(1) from v_Cmx_If_In_All where processed='N' group by source_if;
 
-- 3.基础数据接口中未发布的信息 视图 
  
select table_name,count(1) from v_Cmx_Base_Data group by table_name;

-- 4.税率异常检查
 Select T.ITEM,T.VAT_REGION,T.active_Date,Count(1) From Vat_Item t Where T.vat_Type In ('B','C') Group By  T.ITEM,T.VAT_REGION,T.active_Date Having Count(1)>1;
  Select T.ITEM,T.VAT_REGION,T.active_Date,Count(1) From Vat_Item t Where T.vat_Type In ('B','R') Group By  T.ITEM,T.VAT_REGION,T.active_Date Having Count(1)>1;


--5.RIB检查
select case when count(*)>200 then 'RIB异常' else 'RIB正常' end from ORDER_PUB_INFO opi,ordhead ohd where opi.published='N' and opi.order_no=OHD.ORDER_NO and ohd.status='A';