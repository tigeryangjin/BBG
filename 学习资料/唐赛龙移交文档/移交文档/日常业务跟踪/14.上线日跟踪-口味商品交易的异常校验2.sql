--校验口味商品交易异常数据
--门店 口味商品入库,请查看Shipment号及状态来判断
SELECT pi_in.tran_code,pi_in.tran_date,pi_in.loc_type,pi_in.LOCATION,pi_in.item,pi_in.units,
       t_dif.total_cost_out,t_dif.total_cost_in
       ,s.shipment,s.STATUS_CODE
       FROM
(SELECT * FROM tran_data td
         WHERE td.loc_type='S'
           AND tran_code IN (22,20,30) --PO,库存调整，调拨
           --判别是否是口味商品
           AND EXISTS (SELECT 1
                           FROM item_master im,
                                uda_item_lov uil
                           WHERE im.item=uil.item
                             AND uil.uda_id=22 --口味销售商品属性
                             AND uil.uda_value=1 --Y
                             AND im.item_level=2
                             AND EXISTS (SELECT 1 FROM item_master im_p
                                                 WHERE im_p.item=td.item --I_item
                                                   AND im_p.item_parent=im.item_parent
                                                   AND im_p.item<>im.item
                                                   AND im_p.item_level=im.item_level)) --口味商品
          -- AND (NOT EXISTS (SELECT 1 FROM shipment s WHERE s.status='I' AND s.shipment=td.REF_NO_2)                                        
                                                   ) pi_in ,
(SELECT t_out.item item_out
        ,t_out.LOCATION location_out
        ,t_out.units
        ,t_out.total_cost total_cost_out 
        ,t_in.total_cost total_cost_in
       FROM
        -- 门店 口味商品出
        (SELECT *
                FROM tran_data td
                 WHERE td.loc_type='S'
                   AND td.tran_code=91
                   AND td.pgm_name='CMX_SOH_TASTE_TRG') t_out
        ,           
        -- 门店 口味销售入
        (SELECT *
                FROM tran_data td
                 WHERE td.loc_type='S'
                   AND td.tran_code=92
                   AND td.pgm_name='CMX_SOH_TASTE_TRG'
                   ) t_in
        WHERE t_out.Ref_No_2=t_in.ref_no_2
          AND NVL(t_out.total_cost,0)=NVL(t_in.total_cost,0)
          ) t_dif
          ,shipment s
WHERE pi_in.item=t_dif.item_out(+)
  AND pi_in.LOCATION=t_dif.location_out(+)
  AND pi_in.units=t_dif.units(+)
  AND pi_in.REF_no_2 = s.shipment(+) ;
      
--有PO、INV IN，没有转换的交易91，92
SELECT * FROM tran_data td
         WHERE td.loc_type='S'
           AND tran_code IN (22,20)
           AND EXISTS (SELECT 1
                           FROM item_master im,
                                uda_item_lov uil
                           WHERE im.item=uil.item
                             AND uil.uda_id=22 --口味销售商品属性
                             AND uil.uda_value=1 --Y
                             AND im.item_level=2
                             AND EXISTS (SELECT 1 FROM item_master im_p
                                                 WHERE im_p.item=td.item --I_item
                                                   AND im_p.item_parent=im.item_parent
                                                   AND im_p.item<>im.item
                                                   AND im_p.item_level=im.item_level)) --口味商品
          AND NOT EXISTS (SELECT 1 FROM tran_data td_91
                                   WHERE td_91.loc_type='S'
                                     AND td_91.tran_code=91 --出
                                     AND td_91.pgm_name='CMX_SOH_TASTE_TRG'
                                     --
                                     AND td_91.item=td.item
                                     AND td_91.LOCATION=td.LOCATION
                                     AND td_91.units=td.units
                                     AND EXISTS (SELECT 1 FROM tran_data td_92
                                                        WHERE td_92.loc_type='S'
                                                         AND td_92.tran_code=92 --入
                                                         AND td_92.pgm_name='CMX_SOH_TASTE_TRG'
                                                         --
                                                         AND td_92.REF_NO_2=td_91.REF_NO_2
                                                         AND td_92.LOCATION=td.LOCATION
                                                         AND td_92.units=td.units
                                                         ))
               ;
               
--校验仓库存在异常的91,92
SELECT * FROM tran_data td
         WHERE td.loc_type='W'
           AND td.tran_code IN (91,92);
