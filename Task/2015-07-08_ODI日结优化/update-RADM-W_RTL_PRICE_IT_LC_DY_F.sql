--昨日运行时间：3571秒
--10个进程，每个平均更新5万条记录。
--不能提交
update RADM.W_RTL_PRICE_IT_LC_DY_F t
   set (t.ORG_DH_WID, t.BBG_REFERENCE_FO10, t.TO_DT_WID, t.W_UPDATE_DT) =
       (select
        
         s.ORG_DH_WID, s.BBG_REFERENCE_FO10, s.TO_DT_WID, s.W_UPDATE_DT
          from (Select W_RTL_PRICE_IT_LC_DY_TMP.PROD_IT_WID PROD_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.ORG_WID ORG_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.ORG_LC_WID ORG_DH_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.DT_WID FROM_DT_WID,
                       to_number('120160330000') TO_DT_WID,
                       SYSDATE W_UPDATE_DT,
                       W_RTL_PRICE_IT_LC_DY_TMP.BBG_REFERENCE_FO10 BBG_REFERENCE_FO10
                  From RABATCHER.W_RTL_PRICE_IT_LC_DY_TMP W_RTL_PRICE_IT_LC_DY_TMP
                 where (1 = 1)
                      
                   And (W_RTL_PRICE_IT_LC_DY_TMP.ETL_THREAD_VAL = 2)
                
                ) s
         where (1 = 1)
           and t.PROD_WID = s.PROD_WID
           and t.ORG_WID = s.ORG_WID
              
           and s.FROM_DT_WID > t.FROM_DT_WID
           and t.TO_DT_WID = TO_NUMBER('999999999999999')
        
        )
 where (PROD_WID, ORG_WID) in
       (select PROD_WID, ORG_WID
          from (Select W_RTL_PRICE_IT_LC_DY_TMP.PROD_IT_WID PROD_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.ORG_WID ORG_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.ORG_LC_WID ORG_DH_WID,
                       W_RTL_PRICE_IT_LC_DY_TMP.DT_WID FROM_DT_WID,
                       to_number('120160330000') TO_DT_WID,
                       SYSDATE W_UPDATE_DT,
                       W_RTL_PRICE_IT_LC_DY_TMP.BBG_REFERENCE_FO10 BBG_REFERENCE_FO10
                  From RABATCHER.W_RTL_PRICE_IT_LC_DY_TMP W_RTL_PRICE_IT_LC_DY_TMP
                 where (1 = 1)
                      
                   And (W_RTL_PRICE_IT_LC_DY_TMP.ETL_THREAD_VAL = 2)
                
                ) s
         where (1 = 1)
           and t.PROD_WID = s.PROD_WID
           and t.ORG_WID = s.ORG_WID
              
           and s.FROM_DT_WID > t.FROM_DT_WID
           and t.TO_DT_WID = TO_NUMBER('999999999999999')
        
        )
/* No filter on target */
