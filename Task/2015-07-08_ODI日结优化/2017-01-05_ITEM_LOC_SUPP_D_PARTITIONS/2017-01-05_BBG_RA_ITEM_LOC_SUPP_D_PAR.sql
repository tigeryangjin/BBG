CREATE TABLE RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR
(
  ROW_WID                   ,
  ITEM                      ,
  SUPPLIER                  ,
  ORIGIN_COUNTRY_ID         ,
  LOC                       ,
  LOGISTICS_DELIVERY_MODEL  ,
  DESC_CHINESE              ,
  DESC_ENGLISH              ,
  REF_NO1                   ,
  REF_NO2                   ,
  REF_NO3                   ,
  REF_NO4                   ,
  SRC_EFF_FROM_DT           ,
  SRC_EFF_TO_DT             ,
  EFFECTIVE_FROM_DT         ,
  EFFECTIVE_TO_DT           ,
  CURRENT_FLG               ,
  W_INSERT_DT               ,
  W_UPDATE_DT               ,
  DATASOURCE_NUM_ID         ,
  ETL_PROC_WID              ,
  INTEGRATION_ID            ,
  X_CUSTOM                  
)
TABLESPACE RETAIL_DATA
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             8M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
PARTITION BY RANGE (EFFECTIVE_TO_DT)
(  
  PARTITION ITEM_LOC_SUPP_201303 VALUES LESS THAN (DATE'2013-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
	PARTITION ITEM_LOC_SUPP_201304 VALUES LESS THAN (DATE'2013-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201305 VALUES LESS THAN (DATE'2013-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
	PARTITION ITEM_LOC_SUPP_201306 VALUES LESS THAN (DATE'2013-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201307 VALUES LESS THAN (DATE'2013-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201308 VALUES LESS THAN (DATE'2013-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201309 VALUES LESS THAN (DATE'2013-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201310 VALUES LESS THAN (DATE'2013-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201311 VALUES LESS THAN (DATE'2013-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	PARTITION ITEM_LOC_SUPP_201312 VALUES LESS THAN (DATE'2014-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
    PARTITION ITEM_LOC_SUPP_201401 VALUES LESS THAN (DATE'2014-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201402 VALUES LESS THAN (DATE'2014-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201403 VALUES LESS THAN (DATE'2014-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201404 VALUES LESS THAN (DATE'2014-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201405 VALUES LESS THAN (DATE'2014-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201406 VALUES LESS THAN (DATE'2014-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201407 VALUES LESS THAN (DATE'2014-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201408 VALUES LESS THAN (DATE'2014-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201409 VALUES LESS THAN (DATE'2014-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201410 VALUES LESS THAN (DATE'2014-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201411 VALUES LESS THAN (DATE'2014-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201412 VALUES LESS THAN (DATE'2015-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_201501 VALUES LESS THAN (DATE'2015-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201502 VALUES LESS THAN (DATE'2015-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201503 VALUES LESS THAN (DATE'2015-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201504 VALUES LESS THAN (DATE'2015-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201505 VALUES LESS THAN (DATE'2015-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201506 VALUES LESS THAN (DATE'2015-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201507 VALUES LESS THAN (DATE'2015-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201508 VALUES LESS THAN (DATE'2015-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201509 VALUES LESS THAN (DATE'2015-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201510 VALUES LESS THAN (DATE'2015-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201511 VALUES LESS THAN (DATE'2015-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201512 VALUES LESS THAN (DATE'2016-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_201601 VALUES LESS THAN (DATE'2016-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201602 VALUES LESS THAN (DATE'2016-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201603 VALUES LESS THAN (DATE'2016-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201604 VALUES LESS THAN (DATE'2016-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201605 VALUES LESS THAN (DATE'2016-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201606 VALUES LESS THAN (DATE'2016-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201607 VALUES LESS THAN (DATE'2016-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201608 VALUES LESS THAN (DATE'2016-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201609 VALUES LESS THAN (DATE'2016-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201610 VALUES LESS THAN (DATE'2016-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201611 VALUES LESS THAN (DATE'2016-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201612 VALUES LESS THAN (DATE'2017-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_201701 VALUES LESS THAN (DATE'2017-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201702 VALUES LESS THAN (DATE'2017-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201703 VALUES LESS THAN (DATE'2017-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201704 VALUES LESS THAN (DATE'2017-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201705 VALUES LESS THAN (DATE'2017-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201706 VALUES LESS THAN (DATE'2017-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201707 VALUES LESS THAN (DATE'2017-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201708 VALUES LESS THAN (DATE'2017-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201709 VALUES LESS THAN (DATE'2017-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201710 VALUES LESS THAN (DATE'2017-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201711 VALUES LESS THAN (DATE'2017-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201712 VALUES LESS THAN (DATE'2018-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_201801 VALUES LESS THAN (DATE'2018-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201802 VALUES LESS THAN (DATE'2018-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201803 VALUES LESS THAN (DATE'2018-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201804 VALUES LESS THAN (DATE'2018-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201805 VALUES LESS THAN (DATE'2018-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201806 VALUES LESS THAN (DATE'2018-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201807 VALUES LESS THAN (DATE'2018-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201808 VALUES LESS THAN (DATE'2018-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201809 VALUES LESS THAN (DATE'2018-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201810 VALUES LESS THAN (DATE'2018-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201811 VALUES LESS THAN (DATE'2018-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201812 VALUES LESS THAN (DATE'2019-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_201901 VALUES LESS THAN (DATE'2019-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201902 VALUES LESS THAN (DATE'2019-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201903 VALUES LESS THAN (DATE'2019-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_201904 VALUES LESS THAN (DATE'2019-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201905 VALUES LESS THAN (DATE'2019-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_201906 VALUES LESS THAN (DATE'2019-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201907 VALUES LESS THAN (DATE'2019-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201908 VALUES LESS THAN (DATE'2019-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201909 VALUES LESS THAN (DATE'2019-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201910 VALUES LESS THAN (DATE'2019-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201911 VALUES LESS THAN (DATE'2019-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_201912 VALUES LESS THAN (DATE'2020-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_202001 VALUES LESS THAN (DATE'2020-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202002 VALUES LESS THAN (DATE'2020-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202003 VALUES LESS THAN (DATE'2020-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_202004 VALUES LESS THAN (DATE'2020-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202005 VALUES LESS THAN (DATE'2020-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_202006 VALUES LESS THAN (DATE'2020-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202007 VALUES LESS THAN (DATE'2020-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202008 VALUES LESS THAN (DATE'2020-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202009 VALUES LESS THAN (DATE'2020-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202010 VALUES LESS THAN (DATE'2020-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202011 VALUES LESS THAN (DATE'2020-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202012 VALUES LESS THAN (DATE'2021-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
	  PARTITION ITEM_LOC_SUPP_202101 VALUES LESS THAN (DATE'2021-02-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202102 VALUES LESS THAN (DATE'2021-03-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202103 VALUES LESS THAN (DATE'2021-04-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),  
  PARTITION ITEM_LOC_SUPP_202104 VALUES LESS THAN (DATE'2021-05-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202105 VALUES LESS THAN (DATE'2021-06-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
  PARTITION ITEM_LOC_SUPP_202106 VALUES LESS THAN (DATE'2021-07-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202107 VALUES LESS THAN (DATE'2021-08-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202108 VALUES LESS THAN (DATE'2021-09-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202109 VALUES LESS THAN (DATE'2021-10-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202110 VALUES LESS THAN (DATE'2021-11-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202111 VALUES LESS THAN (DATE'2021-12-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ), 
  PARTITION ITEM_LOC_SUPP_202112 VALUES LESS THAN (DATE'2022-01-01')
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               ),
	PARTITION ITEM_LOC_SUPP_MAX VALUES LESS THAN (MAXVALUE)
    NOLOGGING
    NOCOMPRESS 
    TABLESPACE DM_FACT_DATA
    PCTFREE    10
    INITRANS   6
    MAXTRANS   255
    STORAGE    (
                INITIAL          8M
                NEXT             1M
                MAXSIZE          UNLIMITED
                MINEXTENTS       1
                MAXEXTENTS       UNLIMITED
                BUFFER_POOL      DEFAULT
                FLASH_CACHE      DEFAULT
                CELL_FLASH_CACHE DEFAULT
               )
							 				  
)           
LOGGING 
NOCOMPRESS 
NOCACHE
MONITORING 
PARALLEL 10 AS SELECT /*+ PARALLEL(T 10)*/  * FROM RADM.BBG_RA_ITEM_LOC_SUPP_D T;

ALTER TABLE RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR LOGGING;
ALTER TABLE RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR PARALLEL 1;  

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.ROW_WID IS 'ITEM_LOC代理键，可通过Sequence生成';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.ITEM IS '商品';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.SUPPLIER IS '供应商';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.ORIGIN_COUNTRY_ID IS '国家';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.LOC IS '地点';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.LOGISTICS_DELIVERY_MODEL IS '物流模式';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.DESC_CHINESE IS '物流模式中文描述';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.DESC_ENGLISH IS '物流模式英文描述';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.REF_NO1 IS '参考1';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.REF_NO2 IS '参考2';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.REF_NO3 IS '参考3';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.REF_NO4 IS '参考4';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.SRC_EFF_FROM_DT IS 'Source生效开始日期';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.SRC_EFF_TO_DT IS 'Source生效结束日期';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.EFFECTIVE_FROM_DT IS 'Source生效开始日期。如果该字段启用的话，则等同于SRC_EFF_FROM_DT';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.EFFECTIVE_TO_DT IS 'Source生效结束日期。如果该字段启用的话，则等同于SRC_EFF_FROM_DT';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.CURRENT_FLG IS '标识该记录当前在数据仓库中的状态。如果Source中已被删除，则值为N；反之为Y';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.W_INSERT_DT IS 'First insert date ';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.W_UPDATE_DT IS 'Last update date';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.DATASOURCE_NUM_ID IS '数据源标识';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.ETL_PROC_WID IS '系统字段。执行的ETL过程的唯一标识';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.INTEGRATION_ID IS 'Source中该记录的唯一标识。如果是多个字段，那么就将这些字段拼起来';

COMMENT ON COLUMN RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR.X_CUSTOM IS '客户化扩展字段';



CREATE INDEX RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR_I1 ON RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR
(INTEGRATION_ID, DATASOURCE_NUM_ID)
LOGGING
TABLESPACE RETAIL_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
PARALLEL ( DEGREE 2 INSTANCES 1 );


CREATE INDEX RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR_I2 ON RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR
(ITEM, LOC, SUPPLIER)
LOGGING
TABLESPACE RETAIL_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
PARALLEL ( DEGREE 20 INSTANCES 1 )
INVISIBLE;


CREATE UNIQUE INDEX RADM.PK_BBG_RA_ITEM_LOC_SUPP_D_PAR ON RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR
(ROW_WID)
LOGGING
TABLESPACE RETAIL_DATA
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
PARALLEL ( DEGREE 2 INSTANCES 1 );


ALTER TABLE RADM.BBG_RA_ITEM_LOC_SUPP_D_PAR ADD (
  CONSTRAINT PK_BBG_RA_ITEM_LOC_SUPP_D_PAR
  PRIMARY KEY
  (ROW_WID)
  USING INDEX RADM.PK_BBG_RA_ITEM_LOC_SUPP_D_PAR
  ENABLE VALIDATE);
