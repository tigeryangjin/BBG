--CLND
SELECT TO_CHAR(T.MCAL_DAY_DT, 'YYYYMMDD') || ',' ||
       TO_CHAR(T.MCAL_DAY_DT, 'yyyy"年"MM"月"dd"日"') || ',' ||
       TO_CHAR(T.MCAL_DAY_DT, '"M"MM"_"YYYY') || ',' ||
       TO_CHAR(T.MCAL_DAY_DT, 'YYYY"年"MM"月"') || ',' ||
       TO_CHAR(T.MCAL_DAY_DT, '"Y"YYYY') || ',' ||
       TO_CHAR(T.MCAL_DAY_DT, 'YYYY"年"')
  FROM RADM.W_MCAL_DAY_D T
 WHERE T.MCAL_DAY_DT BETWEEN DATE '2016-01-01' AND DATE '2016-12-31'
 ORDER BY T.MCAL_DAY_DT;

--PROD
SELECT T.subclass || ',' || T.sub_name || ',' || T.class || ',' ||
       T.class_name || ',' || T.dept || ',' || T.dept_name
  FROM RMS.ITEM_ORG_V T;

--LOC
SELECT T.STORE || ',' || T.STORE_NAME || ',' || T.REGION || ',' ||
       T.REGION_NAME || ',' || T.CHAIN || ',' || T.CHAIN_NAME
  FROM RMS.V_LOC T;
