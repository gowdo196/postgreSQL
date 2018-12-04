--20170411 期貨改量

--第一步 用委託單資訊找nesh(剩餘量)
select lots from where comm = '4A161'

select coalesce((select sum(lots::numeric) from dfhf.tb_future_detail where comm = '4A161' and cdi in ('1','2','3','E','W','X')),0)
-- 第二步 找成交量
select coalesce((select sum(lots::numeric) from dfhf.tb_future_detail where comm = '4A161' and cdi in ('T','W','X')),0)

/*=============================================================================
Project	: [DCN order server proxy] Project.
Date 	: 2017.04.05
Author 	: al0926783757@mail.apex.com.tw
--tb_future_detail
--tb_future_detail_history
Desc 	: DCN order server proxy 改量歷程明細紀錄表(委託回報/成交回報 均寫入)
=============================================================================*/
drop table if exists dfhf.tb_future_detail cascade;

create table dfhf.tb_future_detail
(
"tdate" varchar(10),
"extm" varchar(8),
"dnflag" varchar(1),
"future_account" varchar(11) not null,
"comm" varchar(6),
"symb" varchar(20),
"bs" varchar(1),
"lino" varchar(1),
"lots" varchar(6),
"pric" varchar(10),
"orse" varchar(11),
"prodtype" varchar(1),
"cdi" varchar(1),
"log_time" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
CONSTRAINT "pk_tb_future_detail" PRIMARY KEY ("orse")
);

COMMENT ON TABLE  dfhf.tb_future_detail          IS 'DCN order server proxy 改量歷程明細紀錄表';

COMMENT ON COLUMN dfhf.tb_future_detail.tdate		IS '交易日期';
COMMENT ON COLUMN dfhf.tb_future_detail.dnflag	IS '日盤夜盤';
COMMENT ON COLUMN dfhf.tb_future_detail."future_account"	IS '客戶期貨帳號';
COMMENT ON COLUMN dfhf.tb_future_detail."comm"	  IS '委託書號';
COMMENT ON COLUMN dfhf.tb_future_detail."symb"	  IS '期交所商品代碼';
COMMENT ON COLUMN dfhf.tb_future_detail."bs"			IS ' B/S 買賣別';
COMMENT ON COLUMN dfhf.tb_future_detail."lino"		IS ' 市場別';
COMMENT ON COLUMN dfhf.tb_future_detail."lots"		IS ' 委託/減去/成交量';
COMMENT ON COLUMN dfhf.tb_future_detail."pric"		IS ' 委託/成交價';
COMMENT ON COLUMN dfhf.tb_future_detail."orse"		IS ' 流水號';
COMMENT ON COLUMN dfhf.tb_future_detail."prodtype" 	IS ' 1:期貨單式 2:選擇權單式 3:選擇權複式 4:期貨複式';
COMMENT ON COLUMN dfhf.tb_future_detail."cdi"			IS '1:新單 2:改量 3:刪單 T:成交';
COMMENT ON COLUMN dfhf.tb_future_detail.log_time IS 'LOG時間';

Drop Index if exists tb_future_detail_orse_idx;
Drop Index if exists tb_future_detail_comm_idx;
Drop Index if exists tb_future_detail_tdate_idx;
Drop Index if exists tb_future_detail_log_time_idx;

CREATE INDEX "tb_future_detail_orse_idx" ON "dfhf"."tb_future_detail" USING btree ("orse");
CREATE INDEX "tb_future_detail_comm_idx" ON "dfhf"."tb_future_detail" USING btree ("comm");
CREATE INDEX "tb_future_detail_tdate_idx" ON "dfhf"."tb_future_detail" USING btree ("tdate");
CREATE INDEX "tb_future_detail_log_time_idx" ON "dfhf"."tb_future_detail" USING btree ("log_time");