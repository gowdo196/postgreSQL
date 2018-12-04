--20180430 MarketManagement

/*20180502
DB內有的
都要能設定
*/

select m.market, m.name,m.currency,m.deliver,m.enable,
(select name from dfh.tb_deliver where deliver = m.deliver ) as "DeliverName",
(select sname from dfh.tb_deliver where deliver = m.deliver ) as "DeliverSName",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'UpDay' ) as "UpDay",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'BuyDay' )as "BuyDay",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SellDay' )as "SellDay",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SingleAmt') as "SingleAmt",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SingleVolume') as "SingleVolume",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CloseTime' )as "CloseTime",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'ChangeTime') as "ChangeTime",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'TimeZone') as "TimeZone",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'Trade' and deliver != 'sys')as "Trade",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'Payment')as "Payment",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'Settle' )as "Settle",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'Meta' )as "Meta",
'' as p01,
'' as p02,
'' as txbbfOrderTime,
'' as txbOrderTime,
'' as txbafOrderTime,
'' as txbpreOrderTime,
'' as txbbfOrderTime2,
'' as txbOrderTime2,
'' as txbafOrderTime2,
'' as txbpreOrderTime2,
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'BBR')) as "BBR", 
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter= 'BBT')) as "BBT",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter= 'BBU')) as "BBU",
(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'GOV' )as "GOV",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'MBR'))as "MBR",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'MBT'))as "MBT",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'MBU'))as "MBU",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SBR'))as "SBR",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SBT'))as "SBT",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'SBU'))as "SBU",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustComm')) as "CustComm",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustCommCut')) as "CustCommCut",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustCommMin')) as "CustCommMin",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustELEComm')) as "CustELEComm",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustELECommCut')) as "CustELECommCut",
(select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = m.market and wparameter = 'CustELECommMin'))as "CustELECommMin"
from dfh.tb_market m

--20180517
--tb_customer_attribute HK 01 07 51 52
--tb_currency 下拉選單
select currency, name from dfh.tb_currency where enable='1'
--tb_deliver 下拉選單
select deliver,name,sname from dfh.tb_deliver where enable = '1';

--tb_exchange 建立新市場 (輸入
select dfh.sf_new_market(_market varchar, _name varchar, _currency varchar, _deliver varchar, _user varchar, _exchangename varchar, _exchange varchar)

select dfh.sf_new_market('HC', '港股人民幣', 'RMB', 'phli', 'HorSecWeb', 'HONG KONG EXCHANGES TRADE RMB', 'HKRM')

select dfh.sf_new_market_gov_fee('HC','印花稅', 0.001, 0, 0, 2, 'A');
select dfh.sf_new_market_gov_fee('HC','中央結算費', 0.001, 0, 0, 2, 'A');
select dfh.sf_new_market_gov_fee('HC','聯所交易費', 0.001, 0, 0, 2, 'A');
select dfh.sf_new_market_gov_fee('HC','交易徵費', 0.001, 0, 0, 2, 'A');

select exchange from dfh.tb_exchange where market = 'US' limit 1
select name from dfh.tb_exchange where market = 'US' limit 1 

wparameter = 'BuyDay' 
wparameter = 'CloseTime'  
wparameter = 'CustComm' 
wparameter = 'CustCommCut' 
wparameter = 'CustCommMin' 
wparameter = 'CustELEComm' 
wparameter = 'CustELECommCut' 
wparameter = 'CustELECommMin' 

from dfh.tb_market m

select m.market, m.name,m.currency,m.deliver,m.enable,p.wtype,p.pstr,p.pname from dfh.tb_market m
LEFT JOIN dfh.tb_parameters p on m.market = p.market
where m.market = 'HK';

--測試crosstab(超爛超難用)
select * from crosstab('select wtype,pstr,pname from dfh.tb_parameters )as ct( wtype text, pstr text, pname text);

select crosstab('select sn, m.market, m.name,m.currency,m.deliver,m.enable,p.wtype,p.pstr,p.pname from dfh.tb_market m
LEFT JOIN dfh.tb_parameters p on m.market = p.market')
as ct(market text, wtype text, pstr text, pname text);


select * from  dfh.tb_parameters ORDER BY last_update

where m.market = 'HK')as ct(market text, name text,  text);

select * from dfh.tb_deliver ;

