--ORG_NUM
SELECT T.ORG_NUM,
       CASE
         WHEN T.ORG_NUM NOT LIKE '12%' THEN
          T.ORG_NUM
         ELSE
          '139' || SUBSTR(T.ORG_NUM, -3, 3)
       END BBG_EXT_ORG_NUM
  FROM RADM.W_INT_ORG_D T;

CAST(CASE WHEN "RA"."Dim �C Retail Organization As Was"."Loc Number" NOT LIKE '12%' THEN CAST("RA"."Dim �C Retail Organization As Was"."Loc Number" AS VARCHAR(20)) ELSE '139' || Substring(CAST("RA"."Dim �C Retail Organization As Was"."Loc Number" AS VARCHAR(20)) FROM - 3 FOR 3) END AS INT)

--��������
CN_Retail_As - Was_Organization_As_Was_Loc_Number_by_JinLi CD_Retail_As - Was_Organization_As_Was_Loc_Number_by_JinLi
  SELECT *
    FROM RADM.W_LOCALIZED_STRING_G T
   WHERE T.MSG_TEXT =
         'CN_Retail_As-Was_Organization_As_Was_Loc_Number_by_JinLi'
     FOR UPDATE;

--ORG_NAME
SELECT T.INTEGRATION_ID,
       T.ORG_NAME,
       NVL(CASE
             WHEN T.INTEGRATION_ID NOT LIKE '12%' THEN
              T.ORG_NAME
             ELSE
              (SELECT A.ORG_NAME
                 FROM RADM.W_INT_ORG_D_TL A
                WHERE A.INTEGRATION_ID = '139' || SUBSTR(T.INTEGRATION_ID, -3, 3))
           END,
           T.ORG_NAME) BBG_EXT_ORG_NAME
  FROM RADM.W_INT_ORG_D_TL T
 WHERE T.INTEGRATION_ID IN (120033, 139033);


CN_Retail_As - Was_Organization_As_Was_Loc_Name_by_JinLi 
CD_Retail_As - Was_Organization_As_Was_Loc_Name_by_JinLi
  SELECT *
    FROM RADM.W_LOCALIZED_STRING_G T
   WHERE T.MSG_TEXT =
         'CN_Retail_As-Was_Organization_As_Was_Loc_Name_by_JinLi'
     FOR UPDATE;
