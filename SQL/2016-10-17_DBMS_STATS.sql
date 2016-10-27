--1.
BEGIN
  DBMS_STATS.GATHER_TABLE_STATS(OWNNAME          => 'ODI_WREP_USER',
                                TABNAME          => 'BBG_RA_SLS_IT_LC_DY_A',
                                GRANULARITY      => 'ALL',
                                DEGREE           => 8,
                                ESTIMATE_PERCENT => SYS.DBMS_STATS.AUTO_SAMPLE_SIZE,
                                CASCADE          => TRUE);
END;

--2.
BEGIN
  DBMS_STATS.gather_schema_stats(OWNNAME          => 'ODI_WREP_USER',
                                 GRANULARITY      => 'ALL',
                                 DEGREE           => 8,
                                 CASCADE          => TRUE,
                                 ESTIMATE_PERCENT => SYS.DBMS_STATS.AUTO_SAMPLE_SIZE);
END;
