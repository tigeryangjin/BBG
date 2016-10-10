--1.1
CREATE TABLE RA_RMS.BBG_JL_ITEM_LOC_DAY AS
SELECT ITEM,
       LOC,
       SRC_EFF_FROM_DT,
       NBB,
       NBO,
       --SALE_TYPE,
       STANDARD_GROSS_MARGIN,
       PROMO_GROSS_MARGIN,
       BUSINESS_MODE,
       ZC_IND,
       BBG_ZG_IND,
       HERO_ITEM_IND,
       --START_DATE,
       --END_DATE,
       NEW_ITEM_FLAG,
       --REF_NO1,
       REF_NO2 /*,
         REF_NO3,
         REF_NO4*/
  FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL;

--1.2
-- Create/Recreate indexes 
create index IX_BBG_JL_ITEM_LOC_DAY on BBG_JL_ITEM_LOC_DAY (ITEM, LOC, SRC_EFF_FROM_DT)
  tablespace RETEK_DATA
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
	
--1.3
TRUNCATE TABLE RA_RMS.BBG_JL_ITEM_LOC_DAY;

--1.4
INSERT INTO RA_RMS.BBG_JL_ITEM_LOC_DAY
SELECT ITEM,
       LOC,
       SRC_EFF_FROM_DT,
       NBB,
       NBO,
       --SALE_TYPE,
       STANDARD_GROSS_MARGIN,
       PROMO_GROSS_MARGIN,
       BUSINESS_MODE,
       ZC_IND,
       BBG_ZG_IND,
       HERO_ITEM_IND,
       --START_DATE,
       --END_DATE,
       NEW_ITEM_FLAG,
       --REF_NO1,
       REF_NO2 /*,
         REF_NO3,
         REF_NO4*/
  FROM BBG_RA_ITEM_LOC_JL_V@RMS_JL;
	
--1.5
SELECT * FROM RMS.BBG_RA_ITEM_LOC_JL_V;
