--1130 跟 2000當參數丟進去, 從美東時間轉台灣時間(至於擺放先後順序...跟為何不能用簡稱 就黑人問號???反正照著用吧) 
SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-12-01 09:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180730 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-07-31 08:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'CCT') AT TIME ZONE 'EST';--2018-12-01 09:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180730 200000' AT TIME ZONE 'CCT') AT TIME ZONE 'EST';--2018-07-31 09:00:00+08
--1203 跟 0200當參數丟進去, 從美東時間轉台灣時間(至於擺放先後順序...跟為何不能用簡稱 就黑人問號???) 
SELECT (TIMESTAMP WITH TIME ZONE '20181203 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-12-03 15:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180703 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-07-03 14:00:00+08


--網頁操作 登入
--20181128 web上選的日期
select n_start_time,n_end_time from dfh.tb_trade_time where market='US';--0200   2000

--20181127 往前找一天交易日
select dfh.sf_get_last_trade_day(_now_date varchar, _market varchar)
select dfh.sf_get_last_trade_day('20181203', 'US')
--20181128 當天是否假日, 是則往後找一天
	select dfh.is_trade_holiday(_now_date, _market, _deliver);--C#

    if is_holiday_ = 0 
      return workdate_;
		else 
			select dfh.sf_get_next_trade_day(_now_date varchar, _market varchar);--C#

--sqlstr組成 1203 跟 0200當參數
select * from dfh.tb_non_current_order
where insert_dt >= (SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern')
and insert_dt <= (SELECT (TIMESTAMP WITH TIME ZONE '20181203 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern')
(SELECT (TIMESTAMP WITH TIME ZONE '20181203 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE (select timezone from dfh.tb_market where market = 'US'))

--tb_market放時區參數
ALTER TABLE dfh.tb_market ADD COLUMN timezone VARCHAR(30);--時區
ALTER TABLE dfh.tb_non_current_order ADD COLUMN order_no VARCHAR(5);
update dfh.tb_market set timezone= 'US/Eastern' where market = 'US';
update dfh.tb_market set timezone= 'Asia/Taipei' where market != 'US';
