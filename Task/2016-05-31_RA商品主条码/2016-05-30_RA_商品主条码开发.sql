--RA_RMS.W_RTL_ITEM_LANG_TMP--RA_RMS.W_RTL_ITEM_D_TMP--W_PRODUCT_ATTR_DS
--BBG_PRIMARY_BARCODE(VARCHAR2(25))

--1.修改：BBG_RA_ITEM_CUSTOM_V

--2.RA_RMS.W_RTL_ITEM_LANG_TMP add column BBG_PRIMARY_BARCODE(VARCHAR2(25))
SELECT * FROM RA_RMS.W_RTL_ITEM_LANG_TMP;

--3.RA_RMS.W_RTL_ITEM_D_TMP add column BBG_PRIMARY_BARCODE(VARCHAR2(25))
-- Add/modify columns 
alter table RA_RMS.W_RTL_ITEM_D_TMP add bbg_primary_barcode VARCHAR2(25 CHAR);
-- Add comments to the columns 
comment on column RA_RMS.W_RTL_ITEM_D_TMP.bbg_primary_barcode
  is '商品主条码';
	
--4.RADM.W_PRODUCT_ATTR_DS add column BBG_PRIMARY_BARCODE(VARCHAR2(25))
-- Add/modify columns 
alter table W_PRODUCT_ATTR_DS add bbg_primary_barcode varchar2(25);
-- Add comments to the columns 
comment on column W_PRODUCT_ATTR_DS.bbg_primary_barcode
  is '商品主条码';
	
--5.RADM.W_PRODUCT_ATTR_D add column BBG_PRIMARY_BARCODE(VARCHAR2(25))
-- Add/modify columns 
alter table W_PRODUCT_ATTR_D add bbg_primary_barcode varchar2(25);
-- Add comments to the columns 
comment on column W_PRODUCT_ATTR_D.bbg_primary_barcode
  is '商品主条码';

--6.
RABATCHER.W_PRODUCT_D_RTL_TMP;


SELECT T.PROD_NUM,
       T.PRODUCT_ATTR11_NAME,
       T.PRODUCT_ATTR12_NAME,
       T.SCD1_WID,
       T.PRODUCT_ATTR13_NAME,
       T.PRODUCT_ATTR14_NAME,
       T.PRODUCT_ATTR15_NAME,
       T.INTEGRATION_ID
  FROM RADM.W_PRODUCT_ATTR_D T
 WHERE T.PRODUCT_ATTR13_NAME = '900020341';


