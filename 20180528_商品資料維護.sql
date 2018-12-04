select bhno, cesq as cseq, name, id as CusType, discomm as FeeRate, BuyPower,(
select to_number(BuyPower,'9999999999D99')/(select 1/coalesce((substr(twd_ex, 1, 6)||'.'||substr(twd_ex, 7,4))::DECIMAL,1) as exchange 
 from (select * from dfh.tb_exch_rate union select * from dfh.tb_exch_rate_history) as ex 
   where date <= to_char(now() at time zone 'CCT','YYYYMMDD') 
   order by date desc limit 1)
) as BuyPowerhk, hkmincomm, usmincomm, hzmincomm, hhmincomm, usdiscomm, hzdiscomm, hhdiscomm, hkdiscomm
from dfh.v_cust_info where bhno like '%%' and cesq like '%%' and 
 bhno in (select "BranchNo" from dfh."EmployeeDepartment" 
where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001')

--改動筆記
discomm -> hkdiscomm  --原本discomm 手續費折讓率 代表的值 讓其符合動態規則
mincomm -> hkmincomm  --原本mincomm 最低手續費 代表的值 讓其符合動態規則

--js 用迴圈抓 市場+discomm mincomm
select market, name, currency, deliver, enable from dfh.tb_market where enable='1'

select dfh.sf_query_cust_info('%%','%%')

--20180528 客戶參數 設定回去
/*先查個人參數 在cust_attribute 內使用的 amode (pstr)
CommCut
ELECommCut
CommMin
ELECommMin

*/
select pstr,pname,wparameter from dfh.tb_parameters where workmode = '2' order by pstr;-- and market = 'HH'

--20180529 商品資料維護

select market,exchange,stock,name,cname,apex_type,unit,hon_type,hon_type_cn,apex,--apex_type1,apex_type2,apex_type3,apex_type4,apex_type5,apex_type6,
deliver,currency,isincode,sedol_code,cusip_code,daytrade,sellonly,active,professional,risk,etf21,
cuser,last_update
from dfh.tb_stock_name
where stock like '%MMPL%' and isincode like '%%' and market = 'US' order by stock;

--過濾條件  市場 股代 isincode

--Add
select isincode from dfh.tb_stock_name where stock = '';
select * from dfh.tb_stock_name where stock = '';
--dt count == 0
insert into dfh.tb_stock_name(market,exchange,stock,name,cname,apex_type, unit, hon_type, hon_type_cn, apex, hon_type_TF, hon_type_cn_TF,
deliver,currency,isincode,sedol_code,cusip_code,daytrade,sellonly,active,professional,risk,etf21) 
VALUES ('','','','','','',8,'','','','1','1'
'','','','','','','','','','','');

--edit
update dfh.tb_stock_name set market = 'US', exchange='', stock='', name='', cname='', apex_type='', unit=, hon_type='', hon_type_cn='', apex='',
deliver='', currency='', isincode='', sedol_code='', cusip_code='', daytrade='', sellonly='', active='', professional='', risk='', etf21=''
where market = 'US' or stock = '%%' or isincode = '%%'

--edit2
delete from dfh.tb_stock_name where stock = 'MMPL'


insert into dfh.tb_stock_name(market,exchange,stock,name,cname,apex_type, unit, hon_type, hon_type_cn, apex, hon_type1, hon_type_cn0,
deliver,currency,isincode,sedol_code,cusip_code,daytrade,sellonly,active,professional,risk,etf21) 
VALUES ('US','XNGS','MMPL','MANGO INC','Mango_Inc/芒果','1',1,'1','0','0','1','1'
'phli','USD','US0378336665','2046251','037833100','1','0','1','0','0','0');

