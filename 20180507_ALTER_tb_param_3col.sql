ALTER TABLE dfh.tb_parameters ADD COLUMN market VARCHAR(10);--市場
ALTER TABLE dfh.tb_parameters ADD COLUMN wparameter VARCHAR(100);--
ALTER TABLE dfh.tb_parameters ADD COLUMN deliver VARCHAR(100);--上手
ALTER TABLE dfh.tb_parameters ADD COLUMN workmode VARCHAR(100);--0:, 1:trade_fee, 2:customer_attribute

update dfh.tb_parameters set market = 'HK' where wtype like 'HK%';
update dfh.tb_parameters set market = 'HH' where wtype like 'HH%';
update dfh.tb_parameters set market = 'US' where wtype like 'US%';
update dfh.tb_parameters set market = 'HZ' where wtype like 'HZ%';
update dfh.tb_parameters set market = 'TI' where wtype like 'TI%';
update dfh.tb_parameters set deliver = 'phli' where wtype like '%_phli';
update dfh.tb_parameters set deliver = 'sys' where wtype like '%_Sys';

update dfh.tb_parameters set wparameter = 'BBR' where wtype like '%BBR%';
update dfh.tb_parameters set wparameter = 'BBT' where wtype like '%BBT%';
update dfh.tb_parameters set wparameter = 'BBU' where wtype like '%BBU%';
update dfh.tb_parameters set wparameter = 'GOV' where wtype like '%GOV%';
update dfh.tb_parameters set wparameter = 'MBR' where wtype like '%MBR%';
update dfh.tb_parameters set wparameter = 'MBT' where wtype like '%MBT%';
update dfh.tb_parameters set wparameter = 'MBU' where wtype like '%MBU%';
update dfh.tb_parameters set wparameter = 'SBR' where wtype like '%SBR%';
update dfh.tb_parameters set wparameter = 'SBT' where wtype like '%SBT%';
update dfh.tb_parameters set wparameter = 'SBU' where wtype like '%SBU%';
update dfh.tb_parameters set wparameter = 'Meta' where wtype like '%Meta%';
update dfh.tb_parameters set wparameter = 'Payment' where wtype like '%Payment%';
update dfh.tb_parameters set wparameter = 'SellDay' where wtype like '%SellDay%';
update dfh.tb_parameters set wparameter = 'Trade' where wtype like '%Trade%';
update dfh.tb_parameters set wparameter = 'TimeZone' where wtype like '%TimeZone%';
update dfh.tb_parameters set wparameter = 'UpDay' where wtype like '%UpDay%';
update dfh.tb_parameters set wparameter = 'TradeFee' where wtype like '%TradeFee%';

update dfh.tb_parameters set wparameter = 'BuyDay' where wtype like '%BuyDay%';
update dfh.tb_parameters set wparameter = 'CloseTime' where wtype like '%CloseTime%';
update dfh.tb_parameters set wparameter = 'CustComm' where wtype like '%CustComm%';
update dfh.tb_parameters set wparameter = 'CustCommCut' where wtype like '%CustCommCut%';
update dfh.tb_parameters set wparameter = 'CustCommMin' where wtype like '%CustCommMin%';
update dfh.tb_parameters set wparameter = 'CustELEComm' where wtype like '%CustELEComm%';
update dfh.tb_parameters set wparameter = 'CustELECommCut' where wtype like '%CustELECommCut%';
update dfh.tb_parameters set wparameter = 'CustELECommMin' where wtype like '%CustELECommMin%';


select * from dfh.tb_parameters where wtype like 'HK%'
select * from dfh.tb_parameters where wtype like 'US%'
select * from dfh.tb_parameters where wtype like 'HH%'
select * from dfh.tb_parameters where wtype like '%_phli'
select * from dfh.tb_parameters where wtype like '%_Sys'