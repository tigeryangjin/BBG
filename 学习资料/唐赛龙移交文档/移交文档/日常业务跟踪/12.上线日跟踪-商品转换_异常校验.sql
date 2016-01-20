--商品转换：校验生成的91，92总成本不等的异常
SELECT * FROM
(SELECT cbh.approval_date,
        cbh.status,
        cbh.creation_date,
        cbh.req_no,
       cbh.store,
       cbd.from_item,
       cbd.to_item,
       cbd.convert_qty,
       cbd.in_qty
       FROM cmx_bom_convert_head cbh,
            cmx_bom_convert_detail cbd
      WHERE cbd.req_no=cbh.req_no
        AND cbh.status='A'
        ) cbhd,
   --交易
  (SELECT td_f.LOCATION
          ,td_f.item
          ,td_f.ref_no_1
          ,td_f.units f_units
          ,td_f.units t_units
          ,td_f.total_cost f_total_cost 
          ,td_t.total_cost t_total_cost 
            FROM tran_data td_f,
                 tran_data td_t
            WHERE td_f.ref_no_1=td_t.ref_no_1
              AND td_f.ref_no_2=td_t.ref_no_2
              AND td_f.tran_code=91
              AND td_t.tran_code=92
              --
              AND NVL(td_f.total_cost,0)<>NVL(td_t.total_cost,0) --总成本不等
              ) td_ft
  WHERE cbhd.req_no=td_ft.ref_no_1;

--有商品转换单，未生成91,92的异常
SELECT cbh.approval_date,
        cbh.status,
        cbh.creation_date,
        cbh.req_no,
       cbh.store,
       cbd.from_item,
       cbd.to_item,
       cbd.convert_qty,
       cbd.in_qty
       FROM cmx_bom_convert_head cbh,
            cmx_bom_convert_detail cbd
      WHERE cbd.req_no=cbh.req_no
        AND cbh.status='A'
        --AND cbh.approval_date=TO_DATE('&vdate','YYYYMMDD') --传参数
        AND cbh.approval_date=get_vdate
        --
        AND (NOT EXISTS (SELECT 1 FROM tran_data td_f
                                 WHERE td_f.tran_code=91
                                   AND td_f.ref_no_1=cbh.req_no)
            OR
            NOT EXISTS (SELECT 1 FROM tran_data td_t
                                 WHERE td_t.tran_code=92
                                   AND td_t.ref_no_1=cbh.req_no)
            );
     

                        