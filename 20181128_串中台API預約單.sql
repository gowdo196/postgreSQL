
select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                            cust.name as name, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                            volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type,       
                            case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                            o.market as market, o.term||'-'||o.desq as delivercode, o.keyin_id, o.order_src, o.currency as Tcurrency
union all
select '' as order_no, o.insert_dt/*o.tdate*/ , o.insert_dt as trade_date, o.branch||'-'||substr(o.account, 0, 7)||'-'||substr(o.account, 7, 1) as acc,
cust.name as name, stock.exchange as exchange, o.symbol||' '||stock.name as stock, case when o.side = '1' then '買' else '賣' end as bs,
o.order_qty as volume, o.price, o.order_qty::NUMERIC*o.price::NUMERIC as amt, cust.sale as sales, '預約單' as result, '' as type, '新單' as action ,

 o.market as market, '-' as delivercode, insert_user as keyin_id, '' as order_src, stock.currency as Tcurrency


/*serial_no, creator, insert_user, insert_dt, COALESCE(modify_user, '') as modify_user,
        COALESCE(modify_dt, DATE '0001-01-01') as modify_dt, cmd_type,
        msg_type, exch_dest, side, msg_seq_num, time_in_force, deliver_comp, account, branch,
        price, token_id, order_qty, client_ord_id, ord_type, symbol, username*/
    from dfh.tb_non_current_order o
    INNER JOIN dfh."sfGetCustomerList"('20181101','20181129') cust on substr(o.account, 0, 7)=cust.cesq and o.branch=cust.branch
    INNER JOIN dfh.v_tb_stock_name stock on o.symbol=stock.stock 
		INNER JOIN dfh.cs_pxbs_history pxbsh on o.symbol=pxbsh.stock and branch= and cseq= and term + desq = X0107 and market=US and price=48.99

    where --((branch='6110' and account like '0010016') or (branch='1260' and account='0042137')) and
        ((o.status is null) or ((o.status != 'deleted') and (o.status != 'Success') and
        (o.status != 'Failed') and (o.status != 'waiting') and (o.status != 'processing')))
-- status not in ('Failed', 'waiting', 'processing', 'Success')
    order by o.serial_no



select dfh."sfGetCustomerList"('20181101','20181129')

REPLACE (o.delivercode,'-','')
--20181130 找出預約轉正式(跟tb_order對得起來才改action = '預約轉正式' C#作)
select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                            cust.name as name, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                            volume, o.price, volume*o.price as amt, cust.sale as sales, error_code as result, o_type as type,       
                            case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                            o.market as market, o.term||'-'||o.desq as delivercode, o.keyin_id, o.order_src, o.currency as Tcurrency, nco.insert_dt as insert_dt, nco.status, nco.err_msg
                                    from dfh.tb_order o --from dfh.tb_order_history o 
                                    INNER JOIN dfh."sfGetCustomerList"('20181203','20181203') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
LEFT JOIN dfh.tb_non_current_order nco on o.stock = nco.symbol and o.market = nco.market and o.term||o.desq = nco.order_no
                                    where o.tdate = '20181203' and o.market like '%%' and o.branch_no like '%%'



/*
    --建立時區的字串 'YYYY-MM-DD HH24:MM:SS+0'
    --TIMESTAMP WITH TIME ZONE 'YYYY-MM-DD HH24:MM:SS+0' 將時間轉換成 UTC(+0) 時區
	select market into market_ from dfh.tb_exchange where exchange=_exchange;
    select pstr into timezone_ from dfh.tb_parameters where wtype = market_||'TimeZone_Sys';
    if timezone_ is null then
        timezone_ = 'CCT';    
    end if;
    
    real_time_ := substr(_transcattime, 1, 4)||'-'||substr(_transcattime, 5, 2)||'-'||substr(_transcattime, 7, 2)||' '||substr(_transcattime, 10,8)||'+0';
    sql_ = 'select to_char((TIMESTAMP WITH TIME ZONE '''||real_time_||''') at time zone '''||timezone_||''', ''YYYYMMDD'')';
    execute sql_ into tdate_;
    sql_ = 'select to_char((TIMESTAMP WITH TIME ZONE '''||real_time_||''') at time zone '''||timezone_||''', ''HH24MISS'')';
    execute sql_ into ttime_;

--當天是否假日, 是則往後找一天
	select dfh.is_trade_holiday(_now_date, _market, _deliver);--C#

        if is_holiday_ = 0 
            return workdate_;
				else 
						select dfh.sf_get_next_trade_day(_now_date varchar, _market varchar);--C#
--往前找一天交易日
select dfh.sf_get_last_trade_day(_now_date varchar, _market varchar)

--拿某個市場的時間
select sf_get_trade_data('US')


    select pstr into timezone_ from dfh.tb_parameters where wtype=_market||'TimeZone_Sys';
    select pstr from dfh.tb_parameters where wtype='USTimeZone_Sys'
    if timezone_ is null then
        timezone_ = 'CCT';
    end if;        
    --
    sql_cmd_ = 'select to_char('2018-11-30 02:00:00' at time zone '''||timezone_||''', ''HH24MISS'')::varchar as ttime';
*/

--網頁操作 登入
--20181128 web上選的日期
select n_start_time,n_end_time from dfh.tb_trade_time where market='US';--0200   2000
select pstr into timezone_ from dfh.tb_parameters where wtype=_market||'TimeZone_Sys';-- pstr = 'EDT'
    if timezone_ is null then
        timezone_ = 'CCT';--C#
    end if;

--US n_start 回推 TW insert_dt 區間上限(n_end_time要跟前一交易日組合)
select to_char((TIMESTAMP WITH TIME ZONE '20181128 020000') at time zone 'EDT', 'YYYYMMDD HH24MISS');--C#
select to_char((TIMESTAMP WITH TIME ZONE '''||real_time_||''') at time zone '''||timezone_||''', ''YYYYMMDD'')
select cast(
         cast(
          to_timestamp('20181130' || '200000',
                       'FXYYYYMMDDHH24MISS') as timestamp
             ) || ' EST' as timestamptz
            ); 

--US n_end 回推 TW insert_dt 區間下限(n_start_time要跟當天是否假日組合)
SELECT (TIMESTAMP WITH TIME ZONE '2018-07-01 20:00:00 EST') AT TIME ZONE 'CCT';
SELECT (TIMESTAMP WITH TIME ZONE '2018-12-01 20:00:00 EST') AT TIME ZONE 'CCT';
SELECT TIMESTAMP WITH TIME ZONE '2018-12-01 00:00:00' AT TIME ZONE 'EST';
SELECT TIMESTAMP WITH TIME ZONE '2018-07-01 00:00:00' AT TIME ZONE 'EST';

select now() at time zone 'CCT'--2018-07-03 11:43:48.921
select now() at time zone 'EST'--2018-07-02 22:43:58.562

select now() at time zone 'CCT'--2018-12-03 11:44:20.312
select now() at time zone 'EST'--2018-12-02 22:44:27.687

SELECT now() AT TIME ZONE 'US/Pacific'--2018-12-02 19:49:06.359
SELECT now() AT TIME ZONE 'US/Pacific'--2018-07-02 20:49:31.656

SELECT ('2018-07-01 20:00:00-4') AT TIME ZONE 'US/Eastern' AT TIME ZONE 'Asia/Taipei';--2018-07-01 08:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '2018-12-02 20:00:44.546+08' AT TIME ZONE 'US/Eastern') --AT TIME ZONE 'Asia/Taipei';--2018-12-01 07:00:00+08

--1130 跟 2000當參數丟進去, 從美東時間轉台灣時間(至於擺放先後順序...跟為何不能用簡稱 就黑人問號???反正照著用吧) 
SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-12-01 09:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180730 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-07-31 08:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'CCT') AT TIME ZONE 'EST';--2018-12-01 09:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180730 200000' AT TIME ZONE 'CCT') AT TIME ZONE 'EST';--2018-07-31 09:00:00+08
--1203 跟 0200當參數丟進去, 從美東時間轉台灣時間(至於擺放先後順序...跟為何不能用簡稱 就黑人問號???) 
SELECT (TIMESTAMP WITH TIME ZONE '20181203 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-12-03 15:00:00+08
SELECT (TIMESTAMP WITH TIME ZONE '20180703 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE 'US/Eastern'; --2018-07-03 14:00:00+08

select cast(
         cast(
          to_timestamp('20181130' || '200000',
                       'FXYYYYMMDDHH24MISS') as timestamp
             ) || ' EDT' as timestamptz
            ); 
--得到2018-12-01 09:00:00+08
select cast(
      select   cast(
          to_timestamp('20181201' || '200000',
                       'FXYYYYMMDDHH24MISS')at time zone 'EDT' as timestamp 
             ) || ' EDT' as timestamptz
            ); 
--得到2018-12-01 09:00:00+08

select to_char(to_char('20181130 200000' at time zone 'EST', 'YYYYMMDD HH24MISS') at time zone 'CCT', 'YYYYMMDD HH24MISS');--C#   
select to_char((TIMESTAMP WITH TIME ZONE '''||real_time_||''') at time zone '''||timezone_||''', ''YYYYMMDD'')


--20181127 往前找一天交易日
select dfh.sf_get_last_trade_day(_now_date varchar, _market varchar)
--20181128 當天是否假日, 是則往後找一天
	select dfh.is_trade_holiday(_now_date, _market, _deliver);--C#

    if is_holiday_ = 0 
      return workdate_;
		else 
			select dfh.sf_get_next_trade_day(_now_date varchar, _market varchar);--C#

--算出最後結果, where條件去查tb_non_current_order
insert_dt >= '20181127 080000'
insert_dt <= '20181128 140000'

--輸入20181203, 反推去查的日期區間
select * from dfh.tb_non_current_order
where insert_dt >= (select cast(
         cast(
          to_timestamp('20181130' || '200000',
                       'FXYYYYMMDDHH24MISS') as timestamp
             ) || ' EST' as timestamptz
            )) and insert_dt <= '20181203 140000'
