create or replace package CMX_APL_INSERT_SQL as
/******************************************
--- ������CMX_APL_INSERT_SQL
--- Ŀ�ģ�  �Ӹ�ϵͳ��ȡ���ݵ�APL��
--- ���ߣ� david
--- ����ʱ�䣺 2013/10/25
--- ����޸��ˣ�
--- ���������ڣ�
*******************************************/
function main(O_error_message in out varchar2) return BOOLEAN;

-----------------------------------------------------------------------
--- ��������ȫ�� city -----------------------------------------------------------------------
function FULL_master_city_province(O_error_message in out varchar2) return BOOLEAN;
-- ���� SUPP_SALES
function INC_TXN_SUPP_SALES(O_error_message in out varchar2) return BOOLEAN;





end CMX_APL_INSERT_SQL;
/
create or replace package body CMX_APL_INSERT_SQL as
  -----------------------------------------------------------------------
  function main(O_error_message in out varchar2) return BOOLEAN IS
    L_error_message varchar2(1000);
    L_count         number;
  BEGIN
  
    if not FULL_master_city_province(L_error_message) then
      O_error_message := L_error_message;
      return FALSE;
    end if;
  
    return TRUE;
  END;

  -----------------------------------------------------------------------
  --ȫ����ȡcity
  function FULL_master_city_province(O_error_message in out varchar2)
    return BOOLEAN IS
    L_partition_name varchar2(100);
    ln_count         number(10);
  
  BEGIN
  
    insert into master_city_province
      (city_id,
       -- city_name_en,
       city_name_ch,
       province_id,
       --  province_name_en,
       province_name_ch,
       create_time)    
      select t.district, ----����_id
             t.district_name, ----����_����_����
             t.area, -----ʡ��_id
             t.area_name, -----ʡ��_����_����
             sysdate
        from district_chain_v@dw_rms t;
  
    commit;
    return TRUE;
  EXCEPTION
    when OTHERS then
      O_error_message := sqlerrm;
      return FALSE;
  END;
  -----------------------------------------------------------------------
  --������ȡcmx_supp_sales
  function INC_TXN_SUPP_SALES(O_error_message in out varchar2) return BOOLEAN IS
    L_partition_name varchar2(100);
    ln_count         number(10);
  
  BEGIN
    select count(1) into ln_count from cmx_supp_sales@dw_rms where trunc(sales_date) =trunc(sysdate);
    if ln_count > 0 then
      insert into txn_supp_sales
        (sale_date,
         outlet_id,
         supplier_id,
         product_id,
         units_type,
         quantity,
         cost_value,
         create_time)
        select t.sales_date,
               t.store,
               t.supplier,
               t.item,
               null,
               t.qty,
               t.total_retail,
               sysdate
          from cmx_supp_sales@dw_rms t where trunc(t.sales_date) =trunc(sysdate);
      commit;
    end if;
    return TRUE;
  EXCEPTION
    when OTHERS then
      O_error_message := sqlerrm;
      return FALSE;
  END;

-----------------------------------------------------------------------

-----------------------------------------------------------------------
end CMX_APL_INSERT_SQL;
/
