--RA日结执行时间和完成点
SELECT TRUNC(AH_TIMESTAMP2 + NUMTODSINTERVAL(8, 'hour')) 日期,
       --AH_NAME,
       (AH_TIMESTAMP2 + NUMTODSINTERVAL(8, 'hour')) 开始时间,
       (AH_TIMESTAMP4 + NUMTODSINTERVAL(8, 'hour')) 结束时间,
       SUBSTR(NUMTODSINTERVAL((AH_TIMESTAMP4 + NUMTODSINTERVAL(8, 'hour')) -
                              TRUNC(AH_TIMESTAMP4 +
                                    NUMTODSINTERVAL(8, 'hour')),
                              'day'),
              12,
              8) 结束时间点,
       CASE
         WHEN AH_TIMESTAMP4 + NUMTODSINTERVAL(8, 'hour') -
              TRUNC(AH_TIMESTAMP4 + NUMTODSINTERVAL(8, 'hour')) < 1 / 3 THEN
          1
         ELSE
          0
       END 是否0800之前完成,
       SUBSTR(NUMTODSINTERVAL(AH_TIMESTAMP4 - AH_TIMESTAMP2, 'DAY'), 12, 8) 执行时间,
       CASE
         WHEN AH_TIMESTAMP4 - AH_TIMESTAMP2 < 6 / 24 THEN
          1
         ELSE
          0
       END "是否6小时之内完成",
       CASE
         WHEN AH_STATUS = 1900 THEN
          'ENDED_OK-ended normally'
         WHEN AH_STATUS = 1800 THEN
          'ENDED_NOT_OK-aborted'
         WHEN AH_STATUS = 1850 THEN
          'ENDED_CANCEL-manually canceled'
       END 状态
  FROM AH@RMS_UC4
 WHERE AH_CLIENT = 80
   AND AH_STATUS IN (1800, 1850, 1900)
   AND TRUNC(AH_TIMESTAMP2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN &B_DATE AND
       &E_DATE
   AND AH_NAME = 'PF.ORACLE_ANALYTICS_TOP_LEVEL'
 ORDER BY 1;

--BBG_RA_ITEM_LOC_SUPP_SIL
SELECT trunc(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
       ah_name,
       (ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
       (ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time,
       SUBSTR(NUMTODSINTERVAL(AH_TIMESTAMP4 - AH_TIMESTAMP2, 'DAY'), 12, 8) RUN_TIME,
       case
         when AH_STATUS = 1900 then
          'ENDED_OK-ended normally'
         when AH_STATUS = 1800 then
          'ENDED_NOT_OK-aborted'
         when AH_STATUS = 1850 then
          'ENDED_CANCEL-manually canceled'
       end STATUS
  FROM ah@rms_uc4
 WHERE ah_client = 80
   AND AH_STATUS IN (1800, 1850, 1900)
   AND TRUNC(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN &B_DATE AND
       &E_DATE
   AND ah_name = 'BBG_RA_ITEM_LOC_SUPP_SIL.KSH'
 ORDER BY 1;

--BBG_RA_SUPP_SLSSLDPLP.KSH
SELECT trunc(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) days,
       ah_name,
       (ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) start_time,
       (ah_timestamp4 + NUMTODSINTERVAL(8, 'hour')) end_time,
       SUBSTR(NUMTODSINTERVAL(AH_TIMESTAMP4 - AH_TIMESTAMP2, 'DAY'), 12, 8) RUN_TIME,
       case
         when AH_STATUS = 1900 then
          'ENDED_OK-ended normally'
         when AH_STATUS = 1800 then
          'ENDED_NOT_OK-aborted'
         when AH_STATUS = 1850 then
          'ENDED_CANCEL-manually canceled'
       end STATUS
  FROM ah@rms_uc4
 WHERE ah_client = 80
   AND AH_STATUS IN (1800, 1850, 1900)
   AND TRUNC(ah_timestamp2 + NUMTODSINTERVAL(8, 'hour')) BETWEEN &B_DATE AND
       &E_DATE
   AND ah_name = 'BBG_RA_SUPP_SLSSLDPLP.KSH'
 ORDER BY 1;
