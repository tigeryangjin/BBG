--1.统计分析表
BEGIN
  SYS.DBMS_STATS.GATHER_TABLE_STATS (
     OwnName           => 'RADM'
    ,TabName           => 'W_RTL_SLS_TRX_IT_LC_DY_F'
    ,Estimate_Percent  => 10
    ,Method_Opt        => 'FOR ALL COLUMNS SIZE 1'
    ,Degree            => 4
    ,Cascade           => TRUE
    ,No_Invalidate  => FALSE);
END;



