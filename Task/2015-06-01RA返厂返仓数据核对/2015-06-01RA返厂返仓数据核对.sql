--1.DATASOURCE
--RA
SELECT TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
       P.PROD_NUM ITEM,
       O.ORG_NUM LOC,
       S.SUPPLIER_NUM SUPPLIER,
       A.TRANSFER_QTY RTV_QTY,
       A.TRANSFER_COST RTV_COST
  FROM RADM.BBG_RA_RTV_IT_LC_SUPP_DY_F A,
       RADM.W_PRODUCT_D                P,
       RADM.W_INT_ORG_D                O,
       RADM.W_PARTY_ORG_D              S
 WHERE A.PROD_WID = P.ROW_WID
   AND A.ORG_WID = O.ROW_WID
   AND A.SUPPLIER_WID = S.ROW_WID
   AND A.DT_WID >= 120130515000;
--RMS
SELECT A.DAY_DT, A.ITEM, A.LOC, A.SUPPLIER, A.RTV_QTY, A.RTV_COST
  FROM (SELECT DAY_DT,
               ITEM,
               LOC,
               SUPPLIER,
               SHIP_TO_COUNTRY_ID,
               RTV_QTY,
               RTV_COST,
               '' BBG_REFERENCE_DO1,
               '' BBG_REFERENCE_DO2,
               '' BBG_REFERENCE_DO3,
               '' BBG_REFERENCE_DO4,
               '' BBG_REFERENCE_DO5,
               NULL BBG_REFERENCE_FO1,
               NULL BBG_REFERENCE_FO2,
               NULL BBG_REFERENCE_FO3,
               NULL BBG_REFERENCE_FO4,
               NULL BBG_REFERENCE_FO5,
               NULL BBG_REFERENCE_FO6,
               NULL BBG_REFERENCE_FO7,
               NULL BBG_REFERENCE_FO8,
               NULL BBG_REFERENCE_FO9,
               NULL BBG_REFERENCE_FO10
          FROM (SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                       RD.ITEM,
                       RH.STORE LOC,
                       RH.SUPPLIER,
                       RH.SHIP_TO_COUNTRY_ID,
                       SUM(RD.QTY_RETURNED) RTV_QTY,
                       SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                  FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                       RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                 WHERE 1 = 1
                   AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                   AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                   AND RH.STORE <> -1
                   AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                 GROUP BY TRUNC(RH.COMPLETED_DATE),
                          RD.ITEM,
                          RH.STORE,
                          RH.SUPPLIER,
                          RH.SHIP_TO_COUNTRY_ID
                UNION
                SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                       RD.ITEM,
                       RH.WH,
                       RH.SUPPLIER,
                       RH.SHIP_TO_COUNTRY_ID,
                       SUM(RD.QTY_RETURNED) RTV_QTY,
                       SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                  FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                       RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                 WHERE 1 = 1
                   AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                   AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                   AND RH.WH <> -1
                   AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                 GROUP BY TRUNC(RH.COMPLETED_DATE),
                          RD.ITEM,
                          RH.WH,
                          RH.SUPPLIER,
                          RH.SHIP_TO_COUNTRY_ID)) A;

--2.CHECK
--DROP TABLE RADM.JIN_RTV_DIFF_TMP;
--CREATE TABLE RADM.JIN_RTV_DIFF_TMP AS
SELECT RMS.DAY_DT,
       RMS.ITEM,
       RMS.LOC,
       RMS.SUPPLIER,
       RMS.RTV_QTY RMS_RTV_QTY,
       RMS.RTV_COST RMS_RTV_COST,
       NVL(RA.RTV_QTY, 0) RA_RTV_QTY,
       NVL(RA.RTV_COST, 0) RA_RTV_COST
  FROM (SELECT A.DAY_DT, A.ITEM, A.LOC, A.SUPPLIER, A.RTV_QTY, A.RTV_COST
          FROM (SELECT DAY_DT,
                       ITEM,
                       LOC,
                       SUPPLIER,
                       SHIP_TO_COUNTRY_ID,
                       RTV_QTY,
                       RTV_COST,
                       '' BBG_REFERENCE_DO1,
                       '' BBG_REFERENCE_DO2,
                       '' BBG_REFERENCE_DO3,
                       '' BBG_REFERENCE_DO4,
                       '' BBG_REFERENCE_DO5,
                       NULL BBG_REFERENCE_FO1,
                       NULL BBG_REFERENCE_FO2,
                       NULL BBG_REFERENCE_FO3,
                       NULL BBG_REFERENCE_FO4,
                       NULL BBG_REFERENCE_FO5,
                       NULL BBG_REFERENCE_FO6,
                       NULL BBG_REFERENCE_FO7,
                       NULL BBG_REFERENCE_FO8,
                       NULL BBG_REFERENCE_FO9,
                       NULL BBG_REFERENCE_FO10
                  FROM (SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                               RD.ITEM,
                               RH.STORE LOC,
                               RH.SUPPLIER,
                               RH.SHIP_TO_COUNTRY_ID,
                               SUM(RD.QTY_RETURNED) RTV_QTY,
                               SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                          FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                               RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                         WHERE 1 = 1
                           AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                           AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                           AND RH.STORE <> -1
                           AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                         GROUP BY TRUNC(RH.COMPLETED_DATE),
                                  RD.ITEM,
                                  RH.STORE,
                                  RH.SUPPLIER,
                                  RH.SHIP_TO_COUNTRY_ID
                        UNION
                        SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                               RD.ITEM,
                               RH.WH,
                               RH.SUPPLIER,
                               RH.SHIP_TO_COUNTRY_ID,
                               SUM(RD.QTY_RETURNED) RTV_QTY,
                               SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                          FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                               RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                         WHERE 1 = 1
                           AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                           AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                           AND RH.WH <> -1
                           AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                         GROUP BY TRUNC(RH.COMPLETED_DATE),
                                  RD.ITEM,
                                  RH.WH,
                                  RH.SUPPLIER,
                                  RH.SHIP_TO_COUNTRY_ID)) A) RMS,
       (SELECT TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
               P.PROD_NUM ITEM,
               O.ORG_NUM LOC,
               S.SUPPLIER_NUM SUPPLIER,
               A.TRANSFER_QTY RTV_QTY,
               A.TRANSFER_COST RTV_COST
          FROM RADM.BBG_RA_RTV_IT_LC_SUPP_DY_F A,
               RADM.W_PRODUCT_D                P,
               RADM.W_INT_ORG_D                O,
               RADM.W_PARTY_ORG_D              S
         WHERE A.PROD_WID = P.ROW_WID
           AND A.ORG_WID = O.ROW_WID
           AND A.SUPPLIER_WID = S.ROW_WID
           AND A.DT_WID >= 120130515000) RA
 WHERE RMS.DAY_DT = RA.DAY_DT(+)
   AND RMS.ITEM = RA.ITEM(+)
   AND RMS.LOC = RA.LOC(+)
   AND RMS.SUPPLIER = RA.SUPPLIER(+)
   AND RMS.RTV_COST <> NVL(RA.RTV_COST, 0)
 ORDER BY RMS.DAY_DT, RMS.ITEM, RMS.LOC, RMS.SUPPLIER;

--3.FIX
TRUNCATE TABLE RADM.BBG_RA_RTV_IT_LC_DY_FS;
--INSERT INTO
insert into RADM.BBG_RA_RTV_IT_LC_DY_FS T
  (DAY_DT,
   PROD_IT_NUM,
   ORG_NUM,
   SUPPLIER_NUM,
   BBG_SHIP_TO_COUNTRY_ID,
   RTV_QTY,
   RTV_COST,
   INTEGRATION_ID,
   DOC_CURR_CODE,
   BBG_REFERENCE_DO1,
   BBG_REFERENCE_DO2,
   BBG_REFERENCE_DO3,
   BBG_REFERENCE_DO4,
   BBG_REFERENCE_DO5,
   BBG_REFERENCE_FO1,
   BBG_REFERENCE_FO2,
   BBG_REFERENCE_FO3,
   BBG_REFERENCE_FO4,
   BBG_REFERENCE_FO5,
   BBG_REFERENCE_FO6,
   BBG_REFERENCE_FO7,
   BBG_REFERENCE_FO8,
   BBG_REFERENCE_FO9,
   BBG_REFERENCE_FO10,
   CHANGED_BY_ID,
   CHANGED_ON_DT,
   CREATED_BY_ID,
   CREATED_ON_DT,
   DATASOURCE_NUM_ID,
   ETL_THREAD_VAL,
   LOC_CURR_CODE)

  select S.DAY_DT,
         S.PROD_IT_NUM,
         S.ORG_NUM,
         S.SUPPLIER_NUM,
         S.BBG_SHIP_TO_COUNTRY_ID,
         S.RTV_QTY,
         S.RTV_COST,
         S.INTEGRATION_ID,
         S.DOC_CURR_CODE,
         S.BBG_REFERENCE_DO1,
         S.BBG_REFERENCE_DO2,
         S.BBG_REFERENCE_DO3,
         S.BBG_REFERENCE_DO4,
         S.BBG_REFERENCE_DO5,
         S.BBG_REFERENCE_FO1,
         S.BBG_REFERENCE_FO2,
         S.BBG_REFERENCE_FO3,
         S.BBG_REFERENCE_FO4,
         S.BBG_REFERENCE_FO5,
         S.BBG_REFERENCE_FO6,
         S.BBG_REFERENCE_FO7,
         S.BBG_REFERENCE_FO8,
         S.BBG_REFERENCE_FO9,
         S.BBG_REFERENCE_FO10,
         -1,
         SYSDATE,
         -1,
         SYSDATE,
         1,
         1,
         'CNY'
    from (select DAY_DT,
                 ITEM               PROD_IT_NUM,
                 LOC                ORG_NUM,
                 SUPPLIER           SUPPLIER_NUM,
                 SHIP_TO_COUNTRY_ID BBG_SHIP_TO_COUNTRY_ID,
                 RTV_QTY,
                 RTV_COST,
                 INTEGRATION_ID,
                 CURR_CODE          DOC_CURR_CODE,
                 BBG_REFERENCE_DO1,
                 BBG_REFERENCE_DO2,
                 BBG_REFERENCE_DO3,
                 BBG_REFERENCE_DO4,
                 BBG_REFERENCE_DO5,
                 BBG_REFERENCE_FO1,
                 BBG_REFERENCE_FO2,
                 BBG_REFERENCE_FO3,
                 BBG_REFERENCE_FO4,
                 BBG_REFERENCE_FO5,
                 BBG_REFERENCE_FO6,
                 BBG_REFERENCE_FO7,
                 BBG_REFERENCE_FO8,
                 BBG_REFERENCE_FO9,
                 BBG_REFERENCE_FO10
            from (select BBG_RA_RTV_IT_LC_SUPP_DY_FV.DAY_DT,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.ITEM,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.LOC,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.SUPPLIER,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.SHIP_TO_COUNTRY_ID,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.RTV_QTY,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.RTV_COST,
                         TO_CHAR(BBG_RA_RTV_IT_LC_SUPP_DY_FV.DAY_DT) ||
                         TO_CHAR(BBG_RA_RTV_IT_LC_SUPP_DY_FV.ITEM) ||
                         TO_CHAR(BBG_RA_RTV_IT_LC_SUPP_DY_FV.LOC) ||
                         TO_CHAR(BBG_RA_RTV_IT_LC_SUPP_DY_FV.SUPPLIER) ||
                         TO_CHAR(BBG_RA_RTV_IT_LC_SUPP_DY_FV.SHIP_TO_COUNTRY_ID) INTEGRATION_ID,
                         (SELECT B.CURR_CODE
                            FROM (SELECT STORE         LOCATION,
                                         CURRENCY_CODE CURR_CODE
                                    FROM STORE@RA_RMS_DBLINK
                                  UNION ALL
                                  SELECT WH LOCATION, CURRENCY_CODE CURR_CODE
                                    FROM WH@RA_RMS_DBLINK
                                  UNION ALL
                                  SELECT TO_NUMBER(PARTNER_ID),
                                         CURRENCY_CODE CURR_CODE
                                    FROM PARTNER@RA_RMS_DBLINK
                                   WHERE PARTNER_TYPE = 'E') B
                           WHERE B.LOCATION = BBG_RA_RTV_IT_LC_SUPP_DY_FV.LOC
                             and ROWNUM = 1) CURR_CODE,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_DO1,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_DO2,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_DO3,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_DO4,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_DO5,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO1,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO2,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO3,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO4,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO5,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO6,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO7,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO8,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO9,
                         BBG_RA_RTV_IT_LC_SUPP_DY_FV.BBG_REFERENCE_FO10
                    from (SELECT DAY_DT,
                                 ITEM,
                                 LOC,
                                 SUPPLIER,
                                 SHIP_TO_COUNTRY_ID,
                                 RTV_QTY,
                                 RTV_COST,
                                 '' BBG_REFERENCE_DO1,
                                 '' BBG_REFERENCE_DO2,
                                 '' BBG_REFERENCE_DO3,
                                 '' BBG_REFERENCE_DO4,
                                 '' BBG_REFERENCE_DO5,
                                 NULL BBG_REFERENCE_FO1,
                                 NULL BBG_REFERENCE_FO2,
                                 NULL BBG_REFERENCE_FO3,
                                 NULL BBG_REFERENCE_FO4,
                                 NULL BBG_REFERENCE_FO5,
                                 NULL BBG_REFERENCE_FO6,
                                 NULL BBG_REFERENCE_FO7,
                                 NULL BBG_REFERENCE_FO8,
                                 NULL BBG_REFERENCE_FO9,
                                 NULL BBG_REFERENCE_FO10
                            FROM (SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                                         RD.ITEM,
                                         RH.STORE LOC,
                                         RH.SUPPLIER,
                                         RH.SHIP_TO_COUNTRY_ID,
                                         SUM(RD.QTY_RETURNED) RTV_QTY,
                                         SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                                    FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                                         RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                                   WHERE 1 = 1
                                     AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                                     AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                                     AND RH.STORE <> -1
                                   GROUP BY TRUNC(RH.COMPLETED_DATE),
                                            RD.ITEM,
                                            RH.STORE,
                                            RH.SUPPLIER,
                                            RH.SHIP_TO_COUNTRY_ID
                                  UNION
                                  SELECT TRUNC(RH.COMPLETED_DATE) DAY_DT,
                                         RD.ITEM,
                                         RH.WH,
                                         RH.SUPPLIER,
                                         RH.SHIP_TO_COUNTRY_ID,
                                         SUM(RD.QTY_RETURNED) RTV_QTY,
                                         SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                                    FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                                         RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                                   WHERE 1 = 1
                                     AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                                     AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                                     AND RH.WH <> -1
                                   GROUP BY TRUNC(RH.COMPLETED_DATE),
                                            RD.ITEM,
                                            RH.WH,
                                            RH.SUPPLIER,
                                            RH.SHIP_TO_COUNTRY_ID)) BBG_RA_RTV_IT_LC_SUPP_DY_FV
                   where EXISTS
                   (SELECT 1
                            FROM RADM.JIN_RTV_DIFF_TMP DI
                           WHERE DI.DAY_DT =
                                 BBG_RA_RTV_IT_LC_SUPP_DY_FV.DAY_DT
                             AND DI.ITEM = BBG_RA_RTV_IT_LC_SUPP_DY_FV.ITEM
                             AND DI.LOC = BBG_RA_RTV_IT_LC_SUPP_DY_FV.LOC
                             AND DI.SUPPLIER =
                                 BBG_RA_RTV_IT_LC_SUPP_DY_FV.SUPPLIER))
           where (1 = 1)) S;

--4.ºË¶Ô»úÖÆ
INSERT INTO RADM.JIN_RMS_RA_RTV_CHECK
  SELECT RMS.DAY_DT,
         RMS.ITEM,
         RMS.LOC,
         RMS.SUPPLIER,
         RMS.RTV_QTY RMS_RTV_QTY,
         RMS.RTV_COST RMS_RTV_COST,
         NVL(RA.RTV_QTY, 0) RA_RTV_QTY,
         NVL(RA.RTV_COST, 0) RA_RTV_COST
    FROM (SELECT /*+ 1PARALLEL(A,20)*/
           A.DAY_DT, A.ITEM, A.LOC, A.SUPPLIER, A.RTV_QTY, A.RTV_COST
            FROM (SELECT DAY_DT,
                         ITEM,
                         LOC,
                         SUPPLIER,
                         SHIP_TO_COUNTRY_ID,
                         RTV_QTY,
                         RTV_COST,
                         '' BBG_REFERENCE_DO1,
                         '' BBG_REFERENCE_DO2,
                         '' BBG_REFERENCE_DO3,
                         '' BBG_REFERENCE_DO4,
                         '' BBG_REFERENCE_DO5,
                         NULL BBG_REFERENCE_FO1,
                         NULL BBG_REFERENCE_FO2,
                         NULL BBG_REFERENCE_FO3,
                         NULL BBG_REFERENCE_FO4,
                         NULL BBG_REFERENCE_FO5,
                         NULL BBG_REFERENCE_FO6,
                         NULL BBG_REFERENCE_FO7,
                         NULL BBG_REFERENCE_FO8,
                         NULL BBG_REFERENCE_FO9,
                         NULL BBG_REFERENCE_FO10
                    FROM (SELECT /*+ 1PARALLEL(RH,20) PARALLEL(RD,20)*/
                           TRUNC(RH.COMPLETED_DATE) DAY_DT,
                           RD.ITEM,
                           RH.STORE LOC,
                           RH.SUPPLIER,
                           RH.SHIP_TO_COUNTRY_ID,
                           SUM(RD.QTY_RETURNED) RTV_QTY,
                           SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                            FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                                 RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                           WHERE 1 = 1
                             AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                             AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                             AND RH.STORE <> -1
                             AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                           GROUP BY TRUNC(RH.COMPLETED_DATE),
                                    RD.ITEM,
                                    RH.STORE,
                                    RH.SUPPLIER,
                                    RH.SHIP_TO_COUNTRY_ID
                          UNION
                          SELECT /*+ 1PARALLEL(RH,20) PARALLEL(RD,20)*/
                           TRUNC(RH.COMPLETED_DATE) DAY_DT,
                           RD.ITEM,
                           RH.WH,
                           RH.SUPPLIER,
                           RH.SHIP_TO_COUNTRY_ID,
                           SUM(RD.QTY_RETURNED) RTV_QTY,
                           SUM(RD.UNIT_COST * RD.QTY_RETURNED) RTV_COST
                            FROM RMS.RTV_HEAD@RA_RMS_DBLINK   RH,
                                 RMS.RTV_DETAIL@RA_RMS_DBLINK RD
                           WHERE 1 = 1
                             AND RH.RTV_ORDER_NO = RD.RTV_ORDER_NO
                             AND RH.STATUS_IND = 15 -- 05- Input 10 - Approved 12 - In Progress 15 - Shipped 20 - Cancelled
                             AND RH.WH <> -1
                             AND RH.COMPLETED_DATE < TRUNC(SYSDATE - 1)
                           GROUP BY TRUNC(RH.COMPLETED_DATE),
                                    RD.ITEM,
                                    RH.WH,
                                    RH.SUPPLIER,
                                    RH.SHIP_TO_COUNTRY_ID)) A) RMS,
         (SELECT /*+ 1PARALLEL(A,20) PARALLEL(P,20) PARALLEL(O,20) PARALLEL(S,20)*/
           TO_DATE(SUBSTR(A.DT_WID, 2, 8), 'YYYYMMDD') DAY_DT,
           P.PROD_NUM ITEM,
           O.ORG_NUM LOC,
           S.SUPPLIER_NUM SUPPLIER,
           A.TRANSFER_QTY RTV_QTY,
           A.TRANSFER_COST RTV_COST
            FROM RADM.BBG_RA_RTV_IT_LC_SUPP_DY_F A,
                 RADM.W_PRODUCT_D                P,
                 RADM.W_INT_ORG_D                O,
                 RADM.W_PARTY_ORG_D              S
           WHERE A.PROD_WID = P.ROW_WID
             AND A.ORG_WID = O.ROW_WID
             AND A.SUPPLIER_WID = S.ROW_WID
             AND A.DT_WID >= 120130515000) RA
   WHERE RMS.DAY_DT = RA.DAY_DT(+)
     AND RMS.ITEM = RA.ITEM(+)
     AND RMS.LOC = RA.LOC(+)
     AND RMS.SUPPLIER = RA.SUPPLIER(+)
     AND RMS.RTV_COST <> NVL(RA.RTV_COST, 0)
   ORDER BY RMS.DAY_DT, RMS.ITEM, RMS.LOC, RMS.SUPPLIER;
