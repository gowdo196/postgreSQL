-- 20180222 BILLMID

insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','00','1','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','01','0','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','02','499000000','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','03','正常','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','04','2018/02/21','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','05','','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','06','499000000','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','07','100','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','08','0','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','09','外幣','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','10','30140022517','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','11','30168116796','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','12','新竹市北區客雅里３３鄰延平路一段２６１巷２弄２號','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','13','桃園市平鎮區新富里２５鄰新富四街１１巷５號','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','14','J220160286','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','15','2016-09-14 12:00:00','postgres');

insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','16','0','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','17','','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','18','0926777888','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','19','derek.chou@mail.apex.com.tw','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','20','1','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','21','0','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','22','0','postgres');
insert into dfh.tb_customer_attribute(bhno,cseq,amode,att,cuser) VALUES ('1260','004213','23','德瑞克','postgres');

/*
00:交易身分 01:手續費折扣 02:購買力 03:狀態 04:開戶日期 05:註銷日期 06:賣的購買力 07:最低手續費120預設150 
08:風控身分別代號 09:幣別 10:銀行帳號 11:自有資金帳號 12:通訊地址 13:戶籍地 14:身分證 15:評估日期 16:自動查詢意願'
17:銀行代碼 18:聯絡電話, 19:電子郵件信箱, 20:是否可當沖, 21: 是否為專業投資人, 22:是否為法人'; 0否1是
*/

-- 20180223 查詢客戶資料 Query
--step 1 wmode判斷是營業員還是一般戶 0=營業員 1=打單員 2=系統管理員 3=取消 4=一般客戶
select wmode
from dfh.tb_salseinfo where tlno = 'Z127062482' --Y166050939	Z127062482	J220160286


select bhno,cseq from dfh.tb_customer_attribute where amode = '14' and
        att='J220160286';

select 3 as bhno, 4 as cseq;

--step 2 wmode =4 一般客戶 
select bhno,cseq
from dfh.tb_customer_attribute where amode = '14' and att='J220160286';

select att
from dfh.tb_customer_attribute where bhno='1260' and cseq='004213' and amode in ('12','18','19','20','21','22','23')
order by amode


--step 2 wmode =0 營業員
select tlno from dfh.tb_salseinfo where sale = '887' 

select A.bhno,A.cseq, B.confirm from dfh.tb_customer_attribute A
							left join dfh.tb_customerinfo B on A.bhno=B.branch and A.cseq=B.cesq
							where amode = '14' and att='Y166050939';

select att from dfh.tb_customer_attribute where bhno='1260' and cseq='705518' 
and amode in ('12','18','19','20','21','22','23') order by amode

--query pxbs
select *from 

select sn, tlno, clorderid, orgiclorderid, orderid, exechid, transcattime, exectype, ordstatus, ordrejreason,
			branch, account, symbol, side, orderqty, ordtype, timeinforce, price, lastqty, lastpx, leavesqty, cumqty, cxlqty,
			text, market, exchange, delivertocompid, currency, settlcurrency from dfh.cs_gwresult where tlno = 'A123456789' and branch like '%%'


--tb_cntl
ALTER TABLE dfh.tb_cntl ADD COLUMN average_price   int default(0);--均價
ALTER TABLE dfh.tb_cntl_history ADD COLUMN average_price   int default(0);


insert into dfh.tb_cntl(branch_no,cust_id,cust_cofirm,stock,update_time,current_value,average_price,use_stock,today_sell,yest_buy,today_save,market,cuser,deliver) 
VALUES ('1260','004213','7','AMZN','20180308','10000',1578.89,'0','0','0','0','US','postgres','00');
insert into dfh.tb_cntl(branch_no,cust_id,cust_cofirm,stock,update_time,current_value,average_price,use_stock,today_sell,yest_buy,today_save,market,cuser,deliver) 
VALUES ('1260','004213','7','AAPL','20180308','20000',179.98,'0','0','0','0','US','postgres','01');

select stock,average_price,current_value from dfh.tb_cntl where branch_no = '1260' and cust_id = '004213'




    select count(A.deal_sn) into pxmh_check_ from dfh.cs_pxmh A 
    join dfh.cs_pxbs B on A.term = B.term and A.deqs = B.desq where length(A.org_seq) = 0;
    if pxmh_check_ > 0 then
        update dfh.cs_pxmh X set org_seq = Y.insq
        from dfh.cs_pxbs Y 
        where X.term = Y.term and X.deqs = Y.desq
        and length(X.org_seq)=0;

        insert into dfh.tb_log (thread,log_level,logger,msg,error) 
        values('','INFO','dfh.sf_set_pxbs','Add pxmh insq at '||_term||'-'||_desq,'');
    end if;