select insq,tdate,ttime,bs,stock,price,stock,price,volume,amode,cuser ,to_char(last_update,'YYYY/MM/DD HH24:mi:ss') as last_update
                        from dfh.hor_check_trade_history where tdate = '20180608' and amode = '4' and market = 'HK'
                        UNION ALL
                        select insq,tdate,ttime,bs,stock,price,stock,price,volume,amode,cuser ,to_char(last_update,'YYYY/MM/DD HH24:mi:ss') as last_update
                        from dfh.hor_check_trade where tdate = '20180608' and amode = '4' and market = 'HK'
                        order by insq


select bhno,cseq||ckno as cseq,sale,org_seq,term,deqs,stock,price,tqty,bs,market,tdate,currency from dfh.cs_pxmh
where tdate = '20180720' and market = 'US'
union ALL
select bhno,cseq||ckno as cseq,sale,org_seq,term,deqs,stock,price,tqty,bs,market,tdate,currency from dfh.cs_pxmh_history 
where tdate = '20180720' and market = 'US'



--有改客戶要用sf_pxmh_change_change
--先查成交單 用編號去找 看cseq跟bhno是否有異動, 不用管"委託單新增"
select bhno, cseq, ckno, deliver, currency, sum(tqty) as tqty, (select sale from dfh.tb_customerinfo where branch = '1260' and cesq = '247786' and confirm = '3' limit 1)as sale,
(select att from  dfh.tb_customer_attribute  where bhno = '1260' and cseq = '555555' and amode = '14')  as userid
from dfh.cs_pxmh_history where org_seq = 'E01479' GROUP BY bhno, cseq, ckno, deliver, currency
--查即將變更成的新客戶帳號的營業員
--select * from dfh.tb_customerinfo where branch = '1260' and cesq = '555555' and confirm = '5' limit 1



 select dfh.sf_pxmh_change_change(_bhno varchar, _cseq varchar, _ckno varchar, _market varchar, _insq varchar, _stock varchar, _price numeric,
                            _tag_bhno varchar, _tag_cseq varchar, _tag_ckno varchar, _volume int, _sales varchar)

--_bhno _cseq 不變, 只變動成交單資訊
select dfh.sf_pxmh_change_modify('1260', '271063', '0', 'HK', '901460', '00005', '78', 800)


select dfh.sf_pxmh_change_change('1260', '288886', '3', 'HK', '901478', '00003', '15.84', '1260','211111','1',500,'00666')


--20180808 賣 成交單
select dfh.sf_pxmh_change_modify('1260', '247786', '3', 'HK', 'E01479', '00003', '16.04', 1000)

--20180813
select coalesce(sum(afqty),0) from dfh.cs_pxbs where insq = '901507' and bhno='1260' and cseq= '247786' and market = 'HK';








--第一層
select DISTINCT stock from dfh.cs_pxmh WHERE market = 'HK'
--stock = 00002, bs = B

--20180810 美股對帳單
select tdate, '股票' as product, bs, stock, ''as stockname, sum(tqty) as tqty, price, '' as amt,''as comm,''as tradefee from dfh.cs_pxmh 
WHERE market = 'US' --and stock = '00003' --and bs = 'B'
GROUP BY tdate,stock, bs ,price 
HAVING SUM(tqty) > 0 ORDER BY stock,bs,price

--20180810 港股對帳單

select tdate, '股票' as product, bs, stock, ''as stockname, sum(tqty) as tqty, price, '' as amt, '' as groupamt,''as comm,''as stamp,'' as levy, '' as tradefee, '' as clean, '' as gov_fee from dfh.cs_pxmh 
	WHERE market = 'HK' --and stock = '00003' --and bs = 'B'
	GROUP BY tdate,stock, bs ,price 
	HAVING SUM(tqty) > 0 ORDER BY stock,bs,price
/*
select q.stock, q.bs, sum(q.tqty*q.price)as aamt, '' as comm from (
	select tdate, bs, stock, sum(tqty) as tqty, price, deliver from dfh.cs_pxmh 
	WHERE market = 'HK' 
  GROUP BY tdate,stock, bs ,price 
	HAVING SUM(tqty) > 0 ORDER BY stock,bs
) q
GROUP BY q.stock, q.bs
*/

--最後過濾掉qty = 0的項目
--HK 其他費用計算
(select dfh.sf_count_hk_commission(trade_.amt, 'HK', trade_.deliver)) as comm;
                                            dfh.sf_count_stamp('','', trade_.stock, trade_.amt),
                                            dfh.sf_count_levy('','', trade_.amt),
                                            dfh.sf_count_fee('','', trade_.amt),
                                            dfh.sf_count_cleaning('','', trade_.amt),

--US 其他費用計算
select dfh.sf_count_hk_commission(trade_.amt, _market, trade_.deliver) into commission_;
stamp = 0
levy = 0
dfh.sf_count_gov_fee('', '', '', trade_.bs, trade_.amt, _market),


--20180815
--sum tqty + 去掉錯帳專戶 的 供修改用第一層對帳單
select bhno,cseq||ckno as cseq,(select name from dfh.tb_customerinfo where branch=pxmh.bhno and cesq= pxmh.cseq) as cname,sale,org_seq,term||deqs as apex,stock,price,
(select coalesce(sum(tqty),0) from dfh.cs_pxmh where bhno=pxmh.bhno and cseq= pxmh.cseq and org_seq = pxmh.org_seq and market = 'HK' and price =pxmh.price ) as tqty
,bs,market,tdate,currency from dfh.cs_pxmh pxmh where market = 'HK'
GROUP BY bhno,cseq,ckno,sale,org_seq,term,deqs,stock,price,bs,market,tdate,currency
order by org_seq

--計算費用sql HK (輝立對帳單)
select trade_.bs, trade_.stock, (select name from dfh.tb_stock_name where stock = trade_.stock) as stockname, trade_.amt as groupamt,
(select dfh.sf_count_hk_commission(trade_.amt, 'HK', trade_.deliver)) as comm ,
(select dfh.sf_count_stamp('','', trade_.stock, trade_.amt)) as stamp,
(select dfh.sf_count_levy('','', trade_.amt)) as levy,
(select dfh.sf_count_fee('','', trade_.amt)) as tradefee,
(select dfh.sf_count_cleaning('','', trade_.amt)) as clean
from 
	(select bs, stock, sum(amt) as amt, deliver, currency
	 from dfh.cs_pxmh where market='HK' 
	 group by stock, bs, deliver, currency 
	) trade_
ORDER BY stock,bs

--計算費用sql US (輝立對帳單)
select trade_.stock, (select name from dfh.tb_stock_name where stock = trade_.stock) as stockname, trade_.bs, trade_.amt as groupamt,
(select dfh.sf_count_hk_commission(trade_.amt, 'US', trade_.deliver)) as comm ,
'0.0'as stamp,
'0.0'as levy,
(select dfh.sf_count_gov_fee('', '', '', trade_.bs, trade_.amt, 'US')) as gov_fee
from 
	(select bs, stock, sum(amt) as amt, deliver, currency
	 from dfh.cs_pxmh where market='US' 
	 group by stock, bs, price, deliver, currency 
	) trade_
ORDER BY stock,bs

--for dt2  update
select dfh.sf_clean_trade('HK');
select dfh.sf_clean_trade_with_date('20180813', 'HK') ;
select dfh.sf_clean_trade_with_date_inside('20180810','HK');
select dfh.sf_clean_trade_with_date_inside('20180810','HH');
select dfh.sf_clean_trade_with_date_inside('20180810','HZ');
select dfh.sf_clean_trade_with_date_inside('20180810','US');

select dfh.sf_clean_meta_with_date('20180810', 'HK') ;
select dfh.sf_clean_meta_with_date('20180810', 'HH') ;
select dfh.sf_clean_meta_with_date('20180810', 'HZ') ;
