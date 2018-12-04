

select branch,cesq,sum(incoment) as twsum from (
select DISTINCT A.bhno as branch, A.cesq, A.currency, COALESCE(sum(A.blance), 0) as income, 
COALESCE(sum(A.blance), 0)/(to_number(E.twd_ex,'999999D9999')/10000) as incoment,

(select name from dfh.tb_customerinfo where branch=A.bhno and cesq = substr(A.cesq, 1, 6)) as name from dfh.tb_gain_loss A 
--LEFT JOIN dfh.tb_exch_rate E on E.currency = A.currency 
LEFT JOIN (select twd_ex,currency from dfh.tb_exch_rate_history GROUP BY date,twd_ex,currency ORDER BY date desc limit 3) E on E.currency = A.currency 
where substr(tdate, 1, 4) = '2018' 
group by A.bhno, A.cesq, A.currency,E.twd_ex ORDER BY A.cesq,income DESC
) pp GROUP BY branch,cesq;