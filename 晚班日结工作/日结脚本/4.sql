drop table cmx_item_loc_soh_13;              --��ɾ����ʷ��
create table cmx_item_loc_soh_13 as   select * from item_loc_soh il where il.loc_type = 'S';   
