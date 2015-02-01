
W_RTL_INV_IT_LC_G--此表已经只保留最后一天的库存,因此不再创建其他表

--数据来源
W_RTL_INV_IT_LC_G.BBG_REFERENCE_F01=ITEM_LOC_SOH.RTV_QTY
W_RTL_INV_IT_LC_G.BBG_REFERENCE_F02=ITEM_LOC_SOH.TSF_RESERVED_QTY

--原RA中文名称
SELECT * FROM w_localized_string_g T WHERE LANG_ID IN ('zh-cn','en') and t.msg_num like '%Retail_As-Was_Inventory_Position%'
ORDER BY t.msg_num;

--昨日库存中文名称
select * from w_localized_string_g T WHERE t.msg_num like '%Retail_As-Was_Last_Inventory_Position%' for update;
VALUEOF(NQ_SESSION.CN_Retail_As-Was_Last_Inventory_Position_INV_SOH_QTY)--昨日库存数量
CN_Retail_As-Was_Last_Inventory_Position


CN_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_QTY  昨日未交货订单数量
CD_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_QTY
CN_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_COST_AMT_LCL 昨日未交货订单成本
CD_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_COST_AMT_LCL
CN_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_RTL_AMT_LCL 昨日未交货订单零售价
CD_Retail_As-Was_Last_Inventory_Position_INV_ON_ORD_RTL_AMT_LCL
--以W_RTL_INV_IT_LC_G表为基础创建视图，增加DT_WID列
CREATE VIEW W_RTL_INV_IT_LC_GV AS
SELECT '1'||TO_CHAR(SYSDATE-1,'YYYYMMDD')||'000' DT_WID,G.*
FROM W_RTL_INV_IT_LC_G G;

SELECT * FROM W_RTL_INV_IT_LC_GV




