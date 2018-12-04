
select 1/coalesce((substr(twd_ex, 1, 6)||'.'||substr(twd_ex, 7,4))::DECIMAL,1) as exchange 
                from (select * from dfh.tb_exch_rate union select * from dfh.tb_exch_rate_history) as ex 
                where date <= '20180413' and market = 'HK'
                order by date desc limit 1



ALTER TABLE dfh.tb_exch_rate ADD COLUMN market VARCHAR(10);--市場
ALTER TABLE dfh.tb_exch_rate_history ADD COLUMN market VARCHAR(10);--
update dfh.tb_exch_rate set market = 'HK' where currency = 'HKD'
update dfh.tb_exch_rate set market = 'US' where currency = 'USD'
update dfh.tb_exch_rate_history set market = 'HK' where currency = 'HKD'
update dfh.tb_exch_rate_history set market = 'US' where currency = 'USD'
--以上廢棄(舊規則)

--GetExchangeRate 修改

select 1/coalesce(
select    (substr(twd_ex, 1, 6)||'.'||substr(twd_ex, 7,4))::DECIMAL             
from (select * from dfh.tb_exch_rate union select * from dfh.tb_exch_rate_history) as ex 
								left JOIN dfh.tb_market mk on ex.currency = mk.currency
                where date <= '20180430' and mk.market = 'HZ' order by date desc limit 1 as exchange ,1
) as exchange

select 1/coalesce((select (substr(twd_ex, 1, 6)||'.'||substr(twd_ex, 7,4))::DECIMAL             
from (select * from dfh.tb_exch_rate union select * from dfh.tb_exch_rate_history) as ex 
								left JOIN dfh.tb_market mk on ex.currency = mk.currency
                where date <= '20180430' and mk.market = 'HK'),1) as exchange
--HK,HZ
                


order by date desc limit 1