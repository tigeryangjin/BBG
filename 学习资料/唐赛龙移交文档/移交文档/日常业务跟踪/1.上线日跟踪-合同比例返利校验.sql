----------------从合同找比例返利头
SELECT *
  FROM cmx_contract cmc
 WHERE cmc.contract_type IN ('JX', 'DX')
   AND cmc.status = 'A'
   AND cmc.approve_date = get_vdate
   and cmc.rev_no=1
   AND (NOT EXISTS
        (SELECT 1
           FROM deal_head dh
          WHERE dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
            AND dh.bill_back_period = 'M' HAVING COUNT(dh.deal_id) = 1) OR
        NOT EXISTS
        (SELECT 1
           FROM deal_head dh
          WHERE dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
            AND dh.bill_back_period = 'A' HAVING COUNT(dh.deal_id) = 1));
---------------------------------从合同找比例返利detail    

SELECT DISTINCT cmc.*
  FROM cmx_contract cmc, cmx_contract_options cco
 WHERE cco.income_type = 'P'
   AND cmc.status = 'A'
   and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND cmx_create_deal_sql.check_wh(cmc.contract_id) = 'Y'
   AND cmc.contract_no || '_' || cmc.rev_no || '_' || cco.cost_code NOT IN
       (SELECT dh.ext_ref_no || '_' || dd.deal_comp_type
          FROM deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id)
UNION ALL
SELECT DISTINCT cmc.*
  FROM cmx_contract cmc, cmx_contract_options cco
 WHERE cco.income_type = 'P'
   AND cmc.status = 'A'
   and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND cco.cost_code <> '2211'
   AND cmx_create_deal_sql.check_wh(cmc.contract_id) = 'N'
   AND cmc.contract_no || '_' || cmc.rev_no || '_' || cco.cost_code NOT IN
       (SELECT dh.ext_ref_no || '_' || dd.deal_comp_type
          FROM deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id);
-------------------------------------------检查地点插入的完整性
SELECT DISTINCT cmc.*
  FROM cmx_contract cmc, cmx_contract_range ccr, cmx_contract_options cco
 WHERE cmc.contract_id = ccr.contract_id
   AND cmc.status = 'A'
and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND cco.income_type = 'P'
   AND ccr.loc_type = 'W'
   AND cco.cost_code = '2211'
   AND NOT EXISTS
 (SELECT 1
          FROM deal_itemloc_div_grp didg, deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id
           AND dh.deal_id = didg.deal_id
           AND dd.deal_detail_id = didg.deal_detail_id
           AND dd.deal_comp_type = cco.cost_code
           AND dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
           AND ccr.loc = didg.location
           AND ccr.loc_type = didg.loc_type)
UNION
SELECT DISTINCT cmc.*
  FROM cmx_contract cmc, cmx_contract_range ccr, cmx_contract_options cco
 WHERE cmc.contract_id = ccr.contract_id
   AND cmc.status = 'A'
and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND cco.income_type = 'P'
   AND cco.cost_code <> '2211'
   AND NOT EXISTS
 (SELECT 1
          FROM deal_itemloc_div_grp didg, deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id
           AND dh.deal_id = didg.deal_id
           AND dd.deal_detail_id = didg.deal_detail_id
           AND dd.deal_comp_type = cco.cost_code
           AND dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
           AND ccr.loc = didg.location
           AND ccr.loc_type = didg.loc_type);

--------------------------------------检查最小值、最大值、返点插入的准确性
SELECT DISTINCT cmc.*
  FROM cmx_contract                   cmc,
       cmx_contract_proportion_deal   ccpd,
       cmx_contract_proportion_ladder ccpl
 WHERE cmc.contract_id = ccpd.contract_id
   AND ccpd.deal_id = ccpl.deal_id
   AND cmc.status = 'A'
and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND NOT EXISTS
 (SELECT 1
          FROM deal_threshold dt, deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id
           AND dh.deal_id = dt.deal_id
           AND dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
           AND dd.deal_detail_id = dt.deal_detail_id
           AND dt.lower_limit = ccpl.lower_value
           AND dt.upper_limit = ccpl.upper_value
           AND dt.value = ccpl.value)
UNION
SELECT DISTINCT cmc.*
  FROM cmx_contract cmc, cmx_contract_options cco
 WHERE cmc.status = 'A'
and cmc.rev_no=1
   AND cmc.approve_date = get_vdate
   AND cmc.contract_type IN ('JX', 'DX')
   AND cco.income_type = 'P'
   AND cco.cost_code || cmc.contract_id NOT IN
       (SELECT ccpd.cost_code || ccpd.contract_id
          FROM cmx_contract_proportion_deal ccpd)
   AND NOT EXISTS
 (SELECT 1
          FROM deal_threshold dt, deal_head dh, deal_detail dd
         WHERE dh.deal_id = dd.deal_id
           AND dh.deal_id = dt.deal_id
           AND dd.deal_detail_id = dt.deal_detail_id
           AND dh.ext_ref_no = cmc.contract_no || '_' || cmc.rev_no
           AND dt.lower_limit = '9999999999999.01'
           AND dt.upper_limit = '9999999999999.99'
           AND dt.value = 1);
----------------------------------检查deal_actuals_forecast数量

DECLARE
  CURSOR c_contract IS
    SELECT *
      FROM cmx_contract cmc
     WHERE cmc.status = 'A'
and cmc.rev_no=1
       AND cmc.approve_date = get_vdate
       AND cmc.contract_type IN ('JX', 'DX')
     ORDER BY cmc.contract_id;
  CURSOR c_option IS
    SELECT * FROM cmx_contract_options cco WHERE cco.income_type = 'P';
  v_reporting_date cmx_contract.start_date%TYPE;
  v_record_num     NUMBER;
  v_num            NUMBER;
BEGIN
  FOR rec IN c_contract LOOP
    v_num := 0;
    FOR rec_option IN c_option LOOP
      v_reporting_date := last_day(rec.start_date);
      LOOP
        EXIT WHEN v_reporting_date > last_day(rec.start_date);
        SELECT COUNT(1)
          INTO v_record_num
          FROM deal_actuals_forecast daf, deal_head dh, deal_detail dd
         WHERE daf.deal_id = dh.deal_id
           AND daf.deal_detail_id = dd.deal_detail_id
           AND dd.deal_id = dh.deal_id
           AND daf.reporting_date = v_reporting_date
           AND dh.ext_ref_no = rec.contract_no || '_' || rec.rev_no;
        IF v_record_num = 0 THEN
          v_num := 1;
        END IF;
      
        v_reporting_date := add_months(v_reporting_date, 1);
      END LOOP;
    END LOOP;
    IF v_num = 1 THEN
      dbms_output.put_line(rec.contract_id);
    END IF;
  END LOOP;
END;

-----------------------------cost_event_deal：检查deal_id是否都存在

SELECT *
  FROM deal_head dh
 WHERE NOT EXISTS
 (SELECT 1
          FROM cost_event ce, cost_event_deal ced
         WHERE ce.cost_event_process_id = ced.cost_event_process_id
           AND ced.deal_id = dh.deal_id)
   AND EXISTS
 (SELECT 1
          FROM cmx_contract cmc
         WHERE cmc.contract_no || '_' || cmc.rev_no = dh.ext_ref_no
           AND cmc.approve_date = get_vdate
and cmc.rev_no=1);
