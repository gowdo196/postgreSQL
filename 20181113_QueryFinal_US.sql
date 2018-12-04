select '20181112' as tdate, trade_.org_seq as insq, '股票' as product,trade_.stock,
(select name from dfh.tb_stock_name where stock = trade_.stock) as stockname, trade_.tqty, trade_.price, trade_.bs,trade_.amt as groupamt,'' as amount,
(select dfh.sf_count_hk_commission(trade_.amt, 'US', trade_.deliver)) as comm ,
'0.0'as stamp,
'0.0'as levy,
'0.0' as tradefee,
'0.0' as clean,
case when 
(select dfh.sf_get_tradefee_change('20181112', 'US', trade_.org_seq, trade_.deliver, trade_.currency) = '-1')
then 
(select dfh.sf_count_gov_fee('', '', '', trade_.bs, trade_.amt, 'US') )::text
else
(select dfh.sf_get_tradefee_change('20181112', 'US', trade_.org_seq, trade_.deliver, trade_.currency) )::text
end as gov_fee
from 
    (select org_seq, bs, stock, tqty, price, amt, deliver, currency
     from dfh.cs_pxmh where tdate = '20181112' and market='US' 
     --group by org_seq, stock, bs, price, deliver, currency 
    ) trade_ ORDER BY stock,bs


(select sum(tqty)
     from dfh.cs_pxmh where tdate = '20181113' and market='US'  GROUP BY org_seq ) as tqty


select tdate, '' as insq, '股票' as product, bs, stock, ''as stockname, tqty, price, '' as amt, '' as groupamt,''as comm,''as stamp,'' as levy, '' as tradefee, '' as clean, '' as gov_fee ,'' as amount from dfh.cs_pxmh 
    WHERE tdate = '20181112' and market = 'US' ORDER BY stock,bs,price

select dfh.sf_get_tradefee_change('20181112', 'US', 'F01507', 'phli', 'USD')



