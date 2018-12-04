
--unreal 單獨select
		select settlement_date,currency,sum(amt) as amt from dfh.tb_unrealized_meta 
where settlement_date>'20181113' and settlement_date<='20181115' GROUP BY settlement_date,currency


/*
剩下C#處理
在web 用 tran."PayDate" = unreal.settlement_date and unreal.currency = tran.currency 合併

*/
	select tran."PayDate" as paydate, tran.currency, 
COALESCE(sum(case when tran."Instruct" > 0 then tran."Instruct" else 0 end),0) as sellover,
COALESCE(sum(case when tran."Instruct" < 0 then tran."Instruct" else 0 end),0) as buyover, 
COALESCE(sum(tran."Instruct"),0) as instruct,'' as custsellover, '' as custbuyover, '' as amt, '' as income
 from dfh."TransferInstruct"  tran
	where tran."PayDate">'20181008' and tran."PayDate"<='20181010' 
	GROUP BY tran."PayDate",tran.currency
order by tran."PayDate"


select unreal.settlement_date,unreal.currency,
COALESCE(sum(case when unreal.amt > 0 then unreal.amt else 0 end),0) as custsellover,
COALESCE(sum(case when unreal.amt < 0 then unreal.amt else 0 end),0) as custbuyover,
COALESCE(sum(unreal.amt),0) as amt
from(
		select settlement_date,currency,amt from dfh.tb_unrealized_meta
		union ALL 
		select settlement_date,currency,amt from dfh.tb_unrealized_meta_history--GROUP BY settlement_date,currency
	) unreal
where unreal.settlement_date>'20181008' and unreal.settlement_date<='20181010' 
GROUP BY unreal.settlement_date,unreal.currency  
order by unreal.settlement_date



