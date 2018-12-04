--20180605 入金維護
--smode = 3, 人工入金
    insert into dfh.tb_settlement (Account,ID,bank,tdate,smode,currency,amt) 
    values (_acno, _id, '022',lqueyday, '3', _cury, amt_offset_);

--負項
insert into dfh.tb_settlement(Account,ID,bank,tdate,smode,currency,amt) values 
('76543212344', 'A103988223', '022', '20180605', '3', 'HKD', -666666);

select
(select att  from dfh.tb_customer_attribute where amode='10' and bhno = '1260' and cseq = '211111') as cust_id,--76543212344
(select att  from dfh.tb_customer_attribute where amode='14' and bhno = '1260' and cseq = '211111') as account--A103988223


select sum(amt) --into smode3_ammount 
from dfh.tb_settlement where smode = '3' and account = '76543212344';