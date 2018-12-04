/*=============================================================================
Project	: [Cathay Security] Project.
Date 	: 2014.07.29
Author 	: liwei_chour@mail.apex.com.tw
Desc 	: 收盤價歷史
=============================================================================*/
--/*
drop table if exists dfh.tb_stock_price_history cascade;

CREATE TABLE "dfh"."tb_stock_price_history" (
"stock" varchar(10) COLLATE "default" NOT NULL,
"tdate" varchar(8) COLLATE "default" NOT NULL,
"ref" numeric(8,3) NOT NULL,
"open" numeric(8,3) NOT NULL,
"high" numeric(8,3) NOT NULL,
"low" numeric(8,3) NOT NULL,
"price" numeric(8,3) NOT NULL,
"volume" int NOT NULL,
"market" char(2) COLLATE "default" DEFAULT 'HK'::bpchar,
"cuser" varchar(20) COLLATE "default" DEFAULT "current_user"(),
"last_update" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
exchange        varchar(10),
currency varchar(3)
);


COMMENT ON TABLE  dfh.tb_stock_price_history IS '收盤價歷史';
COMMENT ON COLUMN dfh.tb_stock_price_history.stock    IS '股代';
COMMENT ON COLUMN dfh.tb_stock_price_history.tdate    IS '日期';
COMMENT ON COLUMN dfh.tb_stock_price_history.ref	  IS '昨收';
COMMENT ON COLUMN dfh.tb_stock_price_history.open	  IS '開盤價';
COMMENT ON COLUMN dfh.tb_stock_price_history.high	  IS '最高價';
COMMENT ON COLUMN dfh.tb_stock_price_history.low	  IS '最低價';
COMMENT ON COLUMN dfh.tb_stock_price_history.price	  IS '收盤價';
COMMENT ON COLUMN dfh.tb_stock_price_history.volume	  IS '數量價';
COMMENT ON COLUMN dfh.tb_stock_price_history.market			IS '市場';
COMMENT ON COLUMN dfh.tb_stock_price_history.exchange        IS '交易所';
COMMENT ON COLUMN dfh.tb_stock_price_history.currency 	    IS '幣別';




insert into dfh.tb_stock_price_history(SELECT * FROM dfh.tb_stock_price WHERE tdate = '20180606');

--query
select tdate, price, last_update from dfh.tb_stock_price_history where market = 'HK' and stock = '00334'

--insert (先刪再加)
insert into dfh.tb_stock_price_history(tdate,ref,open,high,low,price,volume,market,stock) VALUES('20180724',0,0,0,0,0.77,0,'HK','00334')

--DELETE
delete from dfh.tb_stock_price_history where tdate = '20180724' and market = 'HK' and stock = '00334'



insert into dfh.tb_stock_price