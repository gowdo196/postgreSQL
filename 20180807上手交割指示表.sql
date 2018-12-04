--20180807 上手交割指示表
select tdate as "交易日(T)", realdate as "上手交割日(T+2)", currency as "幣別", 
                             case when bs='B' then '淨買入' else '淨賣出' end as "淨買賣", amt as "金額" 


from dfh.hor_make_up_pay  where tdate>='20180731' and tdate<='20180807'


-- 用幣別當迴圈去查, 沒有正值就不產生該區段的報表, 最後補上表尾
 
--select tdate as "交易日(T)",
select "PayDate" as paydate, sum("Instruct") as instruct ,currency 
from dfh."TransferInstruct" where "PayDate"='20180525'  and currency = 'USD'GROUP BY "PayDate"  ,currency
union all
select "PayDate" as paydate, sum("Instruct") as instruct  ,currency
from dfh."TransferInstruct" where "PayDate"='20180525'  and currency = 'HKD'GROUP BY "PayDate" ,currency
union all 
select "PayDate" as paydate, sum("Instruct") as instruct  ,currency
from dfh."TransferInstruct" where "PayDate"='20180525'  and currency = 'RMB'GROUP BY "PayDate" ,currency


--202180807 FInal
select "PayDate" as paydate, sum("Instruct") as instruct ,currency 
from dfh."TransferInstruct" where "PayDate"='20180525' GROUP BY "PayDate"  ,currency

--印表尾
select wtype,pstr from dfh.tb_parameters where deliver ='instruct'
union ALL
select 'valuedate' as wtype ,(select dfh.sf_get_next_trade_day('20180807','HK')) as pstr