--20180523 tb_country 與假日相關
--建立
insert into dfh.tb_country(country,name,sname,enable,cuser) VALUES ('US','美利堅合眾國','USA','1','postgres');
insert into dfh.tb_country(country,name,sname,enable,cuser) VALUES ('TW','中華民國','Taiwan','1','postgres');
insert into dfh.tb_country(country,name,sname,enable,cuser) VALUES ('CN','中華人民共和國','China','1','postgres');
insert into dfh.tb_country(country,name,sname,enable,cuser) VALUES ('UK','英國','Britain','1','postgres');

select * from dfh.tb_country;

--tb_deliver
INSERT INTO dfh.tb_deliver(deliver, name, sname, country, swiftcode, isbank, enable, dealbank, address, tel, fax, contact) 
VALUES ( 'QQQQ', '測試股份有限公司', '就說了測試', 'CN','','0','1','近平吃包子銀行','北京天安門六十四號','請輸入電話','請輸入傳真','');


