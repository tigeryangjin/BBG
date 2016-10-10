drop table radm.yj_day_par;
drop table radm.yj_day_tmp;

create table radm.yj_day_par
(dt_wid number(15),mcal_day_dt date,lunar_month_desc varchar2(100))
partition by range(dt_wid)
(  partition yj_day_par_max values less than (MAXVALUE)
    tablespace DM_FACT_DATA
    pctfree 0
    initrans 1
    maxtrans 255
    storage
    (
      initial 8M
      next 1M
      minextents 1
      maxextents unlimited
    )
);

create table radm.yj_day_tmp as
select t.row_wid,t.mcal_day_dt,t.lunar_month_desc from radm.w_mcal_day_d t order by t.row_wid;

select * from radm.yj_day_par;
select * from radm.yj_day_tmp;

alter table radm.yj_day_par exchange partition yj_day_par_max with table yj_day_tmp;

alter table radm.yj_day_par split partition yj_day_par_max at (120100000000) into (partition yj_day_par_2009, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120110000000) into (partition yj_day_par_2010, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120120000000) into (partition yj_day_par_2011, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120130000000) into (partition yj_day_par_2012, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120140000000) into (partition yj_day_par_2013, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120150000000) into (partition yj_day_par_2014, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120160000000) into (partition yj_day_par_2015, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120170000000) into (partition yj_day_par_2016, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120180000000) into (partition yj_day_par_2017, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120190000000) into (partition yj_day_par_2018, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120200000000) into (partition yj_day_par_2019, partition yj_day_par_max);
alter table radm.yj_day_par split partition yj_day_par_max at (120210000000) into (partition yj_day_par_2020, partition yj_day_par_max);


drop table radm.yj_day_tmp;
alter table radm.yj_day_par rename to yj_day_tmp;
