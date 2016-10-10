drop table radm.yj_test;
create table radm.yj_test
(
  row_wid                  NUMBER(10) not null,
  prod_wid                 NUMBER(10) not null,
  prod_scd1_wid            NUMBER(10) not null,
  org_wid                  NUMBER(10) not null,
  org_dh_wid               NUMBER(10) not null,
  org_scd1_wid             NUMBER(10) not null,
  dt_wid                   NUMBER(15) not null,
  bbg_item_loc_wid         NUMBER(10) not null,
  bbg_customer_count       NUMBER(20,4),
  bbg_service_satisfaction NUMBER(20,4),
  datasource_num_id        NUMBER(10) not null,
  integration_id           VARCHAR2(80 CHAR) not null,
  w_insert_dt              DATE,
  w_update_dt              DATE,
  bbg_reference_do1        VARCHAR2(250),
  bbg_reference_do2        VARCHAR2(250),
  bbg_reference_do3        VARCHAR2(250),
  bbg_reference_do4        VARCHAR2(250),
  bbg_reference_do5        VARCHAR2(250),
  bbg_reference_fo1        NUMBER(20,4),
  bbg_reference_fo2        NUMBER(20,4),
  bbg_reference_fo3        NUMBER(20,4),
  bbg_reference_fo4        NUMBER(20,4),
  bbg_reference_fo5        NUMBER(20,4),
  bbg_reference_fo6        NUMBER(20,4),
  bbg_reference_fo7        NUMBER(20,4),
  bbg_reference_fo8        NUMBER(20,4),
  bbg_reference_fo9        NUMBER(20,4),
  bbg_reference_fo10       NUMBER(20,4)
)
partition by range (DT_WID)
(  
    partition yj_test_201301 values less than (120130200000)
    tablespace DM_FACT_DATA
    pctfree 0
    initrans 1
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    )
)
tablespace RETAIL_DATA
  pctfree 10
  initrans 1
  maxtrans 255;
	
--添加分区	
alter table radm.yj_test add partition yj_test_max values less than (maxvalue);	
--分割分区
alter table radm.yj_test split partition yj_test_max at (120130300000) into (partition yj_test_201302, partition yj_test_max);
