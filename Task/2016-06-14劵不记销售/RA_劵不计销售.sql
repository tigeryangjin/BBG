SELECT F.FOLDER_NAME, P.POP_NAME
  FROM ODI_WREP_USER.SNP_POP P, ODI_WREP_USER.SNP_FOLDER F
 WHERE P.I_FOLDER = F.I_FOLDER
   AND F.FOLDER_NAME IN
       ('BBG_SDE_Retail_SalesTransactionFact',
        'BBG_SDE_BBG_RA_SUPP_SALES_IT_LC_DY_F',
        'BBG_SIL_BBG_RA_SUPP_SALES_IT_LC_DY_F',
        'BBG_SIL_Retail_SalesTransactionFact',
        'BBG_PLP_Retail_Sales_Current_Aggregate_Fact',
        'BBG_PLP_Retail_Sales_Aggregate_Fact',
        'PLP_Retail_SUPP_Sales_Aggregate_Fact',
        'PLP_Retail_SUPP_Sales_Current_Aggregate_Fact')
 ORDER BY 1, 2;

SELECT * FROM SA_TRAN_DISC T WHERE T.QTY<>T.STANDARD_QTY;
SELECT DISTINCT T.DISC_TYPE FROM SA_TRAN_DISC T;
SELECT * FROM CMX_PROMO_TYPE;
SELECT * FROM RPM_PROMO_COMP;
