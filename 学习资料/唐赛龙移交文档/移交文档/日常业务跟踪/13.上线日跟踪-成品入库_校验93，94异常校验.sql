
--��Ʒ��⣺У�����ɵ�93��94�ܳɱ����ȵ��쳣
SELECT * FROM
(SELECT cbh.Last_Update_Date,
        cbh.status,
        cbh.creation_date,
        cbh.bom_in_no,
       cbh.store,
       cbd.item,
       cbd.qty
       FROM cmx_bom_in_head cbh,
            cmx_bom_in_p cbd
      WHERE cbd.bom_in_no=cbh.bom_in_no
        AND cbh.status='A'
        ) cbhd,
   --����
  (SELECT td_t.LOCATION
          ,td_t.item
          ,td_t.ref_no_1
          --,td_f.units f_units
          --,td_f.units t_units
          ,td_f.total_cost f_total_cost 
          ,td_t.total_cost t_total_cost 
            FROM 
                 (SELECT td.REF_NO_1,
                        td.ref_no_2,
                        SUM(td.TOTAL_COST) total_cost
                        FROM tran_data td
                        WHERE td.tran_code=93
                        GROUP BY td.REF_NO_1,
                                 td.ref_no_2) td_f,
                 tran_data td_t
            WHERE td_f.ref_no_1=td_t.ref_no_1
              AND td_f.ref_no_2=td_f.ref_no_2
              AND td_t.tran_code=94
              --
              AND NVL(td_f.total_cost,0)<>NVL(td_t.total_cost,0) --�ܳɱ�����
              ) td_ft
  WHERE cbhd.bom_in_no=td_ft.ref_no_1;
  

--����Ʒת������δ����93,94���쳣
SELECT cbh.Last_Update_Date,
        cbh.status,
        cbh.creation_date,
        cbh.bom_in_no,
       cbh.store,
       cbd.item,
       cbd.qty
       FROM cmx_bom_in_head cbh,
            cmx_bom_in_p cbd
      WHERE cbd.bom_in_no=cbh.bom_in_no
        AND cbh.status='A'
        AND TRUNC(cbh.last_update_date)=get_vdate
        --
        AND (NOT EXISTS (SELECT 1 FROM tran_data td_f
                                 WHERE td_f.tran_code=93
                                   AND td_f.ref_no_1=cbh.bom_in_no)
            OR
            NOT EXISTS (SELECT 1 FROM tran_data td_t
                                 WHERE td_t.tran_code=94
                                   AND td_t.ref_no_1=cbh.bom_in_no)
            );
     

                        