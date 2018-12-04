select rate from dfh.tb_trade_fee 
where ptype=(select pstr from dfh.tb_parameters where market = 'HK' and wparameter = 'BBR')

--update dfh.tb_trade_fee
update dfh.tb_trade_fee set rate = ''
where ptype=(select pstr from dfh.tb_parameters where market = 'HK' and wparameter = 'BBR')

--update dfh.tb_parameters 
update dfh.tb_parameters set pstr = '' where market = 'HK' and wparameter = 'BBR';

update dfh.tb_deliver set name sname


--govmanagement
--edit
update dfh.tb_trade_fee set name = '', sname='', rate='',minvalue='',maxvalue='',pointlen='' where sn = '11'

update dfh.tb_trade_fee set ptype = '03', name = '聯所交易費', disname='聯所交易費', rate=0.01005,minvalue=0,maxvalue=0,pointlen=2 where sn = '12'

--Add
insert into dfh.tb_trade_fee(ptype,name,disname,rate,minvalue,maxvalue,pointlen) VALUES ('','','','','','','');
update dfh.tb_parameters set pstr = '02,03,04,05'+',06' where market = 'HK' and wparameter = 'GOV'



select sn,market,ptype,name,rate,minvalue,maxvalue,pointlen from dfh.tb_trade_fee
where ptype in ('02','03','04','05') and market = 'HK' 

select sn,market,ptype,name,rate,minvalue,maxvalue,pointlen from dfh.tb_trade_fee where ptype in ('undefined') and market = 'undefined'