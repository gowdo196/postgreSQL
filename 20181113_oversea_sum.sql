select (SELECT	pstr FROM dfh.tb_parameters WHERE wtype = 'osc') as CompanyID,
COALESCE((SELECT	pstr FROM dfh.tb_parameters WHERE wtype = 'oscode'),'73') as format,

branch,cesq,floor(sum(incoment)) as income,
'2018' as incomeyear,pp.NAME,pp.Address,
(SELECT	pstr FROM dfh.tb_parameters WHERE wtype = 'osc') AS OSC,
(SELECT	pstr FROM dfh.tb_parameters WHERE wtype = 'osg') AS OSG,pp.CustomerID
from (
select DISTINCT A.bhno as branch, A.cesq, A.currency, floor(COALESCE(sum(A.blance), 0)) as income, floor(COALESCE(sum(A.blance), 0)/(to_number(E.twd_ex,'999999D9999')/10000)) as incoment,
(select name from dfh.tb_customerinfo where branch=A.bhno and cesq = substr(A.cesq, 1, 6)) as name, 
(SELECT att FROM dfh.tb_customer_attribute WHERE bhno = A .bhno	AND cseq = substr(A .cesq, 1, 6) AND amode = '13') AS Address,
(SELECT att FROM dfh.tb_customer_attribute WHERE bhno = A .bhno AND cseq = substr(A .cesq, 1, 6) AND amode = '14') AS CustomerID
from dfh.tb_gain_loss A 
left JOIN ( select exch.date,exch.twd_ex,exch.currency from (
							select date,twd_ex,currency from dfh.tb_exch_rate_history GROUP BY date,twd_ex,currency 
							union all 
							select date,twd_ex,currency from dfh.tb_exch_rate GROUP BY date,twd_ex,currency
) exch ORDER BY exch.date desc limit 3) E on E.currency = A.currency 
where substr(tdate, 1, 4) = '2018' 
group by A.bhno, A.cesq, A.currency,E.twd_ex  
ORDER BY A.cesq,income DESC) pp GROUP BY branch,cesq, NAME,Address,CustomerID

HAVING floor(sum(incoment))>  (select rate from dfh.tb_trade_fee where ptype='14');