

/*
(
case when 
(select dfh.sf_get_tradefee_change('20181105', 'US', 'D01218',  'phli', 'USD') <> '-1')
then
(select dfh.sf_get_tradefee_change('20181105', 'US', 'D01218', 'phli', 'USD'))
else
(select dfh.sf_count_gov_fee('', '', '', 'B', 9900, 'US'))
end
) as gov_fee

 select fee from dfh.tb_trade_fee_fix
*/

select trade_.tdate, trade_.org_seq as insq,trade_.stock,(select name from dfh.tb_stock_name where stock = trade_.stock) as stockname,trade_.bs,trade_.amt as groupamt,
(select dfh.sf_count_hk_commission(trade_.amt, 'US', trade_.deliver)) as comm ,
'0.0'as stamp,
'0.0'as levy,
--(select dfh.sf_count_gov_fee('', '', '', trade_.bs, trade_.amt, 'US')) as gov_fee

case when 
(select dfh.sf_get_tradefee_change('20181105', 'US', 'D01218',  'phli', 'USD') = '-1')
then 
(select dfh.sf_count_gov_fee('', '', '', 'B', '9900', 'US') )::text
else
(select dfh.sf_get_tradefee_change('20181105', 'US', 'D01218', 'phli', 'USD') )::text
end 
 as gov_fee
from 
    (select tdate, org_seq, bs, stock, sum(amt) as amt, deliver, currency
     from dfh.cs_pxmh where tdate = '20181105' and market='US' 
     group by tdate, org_seq, stock, bs, price, deliver, currency 
    ) trade_ ORDER BY stock,bs