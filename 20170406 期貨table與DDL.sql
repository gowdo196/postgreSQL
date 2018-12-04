--20170406 期貨table與DDL
--customer_data只依照期貨帳號查


select info.fbhno,info.cesq,info.name,attr.att,info.branch from dfhf.tb_customerinfo info
left join dfhf.tb_customer_attribute attr on info.cesq = attr.cseq
 where cseq = '2600065' limit 1

-- ----------------------------
-- Table structure for "dfhf"."tb_proxy_error"
-- ----------------------------
DROP TABLE "dfhf"."tb_proxy_error";
CREATE TABLE "dfhf"."tb_proxy_error" (
--"sn" int4 DEFAULT nextval('"dfhf".tb_proxy_error_sn_seq'::regclass) NOT NULL,
"dsep" char(8) NOT NULL,
"error" varchar(6) NOT NULL,
"msg" varchar(100) NOT NULL,
"cuser" varchar(20) DEFAULT "current_user"(),
"last_update" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL
)
WITH (OIDS=FALSE)

;
COMMENT ON TABLE "dfhf"."tb_proxy_error" IS '委託回報錯誤說明';
--COMMENT ON COLUMN "dfhf"."tb_proxy_error"."sn" IS '序號';
COMMENT ON COLUMN "dfhf"."tb_proxy_error"."dsep" IS '委託回報錯誤';
COMMENT ON COLUMN "dfhf"."tb_proxy_error"."error" IS '自打錯誤編號';
COMMENT ON COLUMN "dfhf"."tb_proxy_error"."msg" IS '錯誤訊息';
COMMENT ON COLUMN "dfhf"."tb_proxy_error"."cuser" IS '修改帳號';
COMMENT ON COLUMN "dfhf"."tb_proxy_error"."last_update" IS '最後更新日期時間';

-- ----------------------------
-- Records of tb_proxy_error
-- ----------------------------
INSERT INTO "dfhf"."tb_proxy_error" VALUES ( '', '', '', 'postgres', '2016-09-01 11:48:09');
-- ----------------------------
-- Primary Key structure for table "dfhf"."tb_proxy_error"
-- ----------------------------
ALTER TABLE "dfhf"."tb_proxy_error" ADD PRIMARY KEY ("error");

CREATE TABLE "dfhf"."tb_import_log" (
"sn" char(14) DEFAULT dfh.gen_log_no() NOT NULL,
"run_sn" int4,
"log_time" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
"wtype" char(1),
"bhno" varchar(4),
"wmode" char(1),
"msg" varchar(3000),
CONSTRAINT "pk_import_log" PRIMARY KEY ("sn")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "dfhf"."tb_import_log" OWNER TO "postgres";
COMMENT ON TABLE "dfhf"."tb_import_log" IS '匯入紀錄';
COMMENT ON COLUMN "dfhf"."tb_import_log"."sn" IS 'LOG序號,YYMDHHNNSS9999';
COMMENT ON COLUMN "dfhf"."tb_import_log"."run_sn" IS '匯入次數 對應 dfh.tb_import_result.run_sn';
COMMENT ON COLUMN "dfhf"."tb_import_log"."wtype" IS '種類 ''b''=分公司檔案 ''c''=客戶檔案 ''s''=營業員檔案 ''k''=帳戶維持率 ''g''=集保 ''m''=融資 ''t''=融卷';
COMMENT ON COLUMN "dfhf"."tb_import_log"."bhno" IS '分公司編號';
COMMENT ON COLUMN "dfhf"."tb_import_log"."wmode" IS '工作類型 ''0''=匯入開始 ''1''=匯入錯誤 ''2''=匯入結束 ''3''=回復';
COMMENT ON COLUMN "dfhf"."tb_import_log"."msg" IS '錯誤訊息';

/*=============================================================================
Project	: [Cathay Security] Project.
Date 	: 2013.05.20
Author 	: liwei_chour@mail.apex.com.tw
Desc 	: 客戶資料
=============================================================================*/
--/*
drop table if exists dfhf.tb_customerinfo cascade;

create table dfhf.tb_customerinfo
(
cesq	    	varchar(10)	not null,
fbhno         varchar(6) not null,
name			varchar(10)	,
sale	  	    varchar(8) not null,
branch          varchar(6) not null,
wmode           char(1) default(0),
cd              char(1) default(0),
hcd             char(1) default(0),
imvamt          int default(0),
imveamt         int default(0),
mrmax           int default(0),
shmax           int default(0),
telphone        varchar(15),
cuser varchar(20) default "current_user"(),
last_update	timestamp not null default(timezone('CCT'::text, now())),
constraint pk_tb_customerinfo primary key (cesq,branch)

);

COMMENT ON TABLE  dfhf.tb_customerinfo IS '客戶資料';
COMMENT ON COLUMN dfhf.tb_customerinfo.cesq 			IS '客戶帳號';
COMMENT ON COLUMN dfhf.tb_customerinfo.fbhno 		IS '期貨分公司';
COMMENT ON COLUMN dfhf.tb_customerinfo.name 			IS '客戶姓名';
COMMENT ON COLUMN dfhf.tb_customerinfo.sale	        IS '所屬營業員代碼';
COMMENT ON COLUMN dfhf.tb_customerinfo.branch	    IS '所屬分公司帳號';
COMMENT ON COLUMN dfhf.tb_customerinfo.wmode	    	IS '帳號種類 0=現貨 1=期貨';
COMMENT ON COLUMN dfhf.tb_customerinfo.cd	    	IS '可信用戶 Y=是 N=否';
COMMENT ON COLUMN dfhf.tb_customerinfo.hcd	    	IS '可當日沖銷 Y=是 N=否';
COMMENT ON COLUMN dfhf.tb_customerinfo.imvamt	    IS '投資上限';
COMMENT ON COLUMN dfhf.tb_customerinfo.imveamt	    IS '電子投資上限';
COMMENT ON COLUMN dfhf.tb_customerinfo.mrmax	    	IS '融資額度';
COMMENT ON COLUMN dfhf.tb_customerinfo.shmax	    	IS '融券額度';
COMMENT ON COLUMN dfhf.tb_customerinfo.telphone	    IS '連絡電話';
COMMENT ON COLUMN dfhf.tb_customerinfo.cuser 		IS '修改帳號';
COMMENT ON COLUMN dfhf.tb_customerinfo.last_update 		IS '最後修改日期';
--*/

/*=============================================================================
Project	: [Cathay Security] Project.
Date 	: 2014.05.23
Author 	: liwei_chour@mail.apex.com.tw
Desc 	: 客戶參數資料
=============================================================================*/
--/*
drop table if exists dfhf.tb_customer_attribute cascade;

create table dfhf.tb_customer_attribute
(
bhno	        varchar(4) not null,
cseq	        varchar(10) not null,
fbhno            varchar(6) not null,
amode           varchar(2) not null,
att             varchar(100),
cuser           varchar(20) default "current_user"(),
last_update	    timestamp not null default(timezone('CCT'::text, now())),
constraint pk_customer_attribute primary key (bhno,cseq,amode)
);

Drop Index if exists tb_customer_attribute_idx;
CREATE INDEX tb_customer_attribute_idx 
ON dfhf.tb_customer_attribute(bhno);

Drop Index if exists tb_customer_attribute_cseq_idx;
CREATE INDEX tb_customer_attribute_cseq_idx 
ON dfhf.tb_customer_attribute(cseq);

COMMENT ON TABLE  dfhf.tb_customer_attribute IS '客戶參數資料';
COMMENT ON COLUMN dfhf.tb_customer_attribute.bhno 		IS '分公司代碼';
COMMENT ON COLUMN dfhf.tb_customer_attribute.cseq 		IS '客戶帳號';
COMMENT ON COLUMN dfhf.tb_customer_attribute.fbhno 		IS '期貨分公司';
COMMENT ON COLUMN dfhf.tb_customer_attribute.amode 		IS '參數類型 00:是否可以當沖  01:身分證字號';
COMMENT ON COLUMN dfhf.tb_customer_attribute.att     	IS '參數';
COMMENT ON COLUMN dfhf.tb_customer_attribute.cuser 		IS '修改帳號';
COMMENT ON COLUMN dfhf.tb_customer_attribute.last_update	IS '最後修改時間';
/*
amode = '00', att=Y:是 N:否
*/
CREATE TABLE "dfh"."tb_order" (
"order_sn" int4 NOT NULL,
"order_no" varchar(20) NOT NULL,
"insq" varchar(10),
"desq" varchar(4),
"branch_no" char(4) NOT NULL,
"cust_id" varchar(10) NOT NULL,
"cust_cofirm" char(1) NOT NULL,
"agent_id" varchar(10) NOT NULL,
"stock" varchar(10) NOT NULL,
"price" numeric(6,2) NOT NULL,
"volume" char(10) NOT NULL,
"m_type" char(1) NOT NULL,
"e_code" char(1) NOT NULL,
"bs" char(1) NOT NULL,
"o_type" char(1) NOT NULL,
"p_code" char(1) NOT NULL,
"term" char(1) DEFAULT ' '::bpchar,
"order_date" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
"cdi" char(1) NOT NULL,
"order_src" varchar(50),
"reserve" varchar(50),
"from_ip" varchar(20) DEFAULT inet_client_addr() NOT NULL,
"keyin_id" varchar(10) NOT NULL,
"error_code" varchar(2) NOT NULL,
"last_update" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
CONSTRAINT "pk_tb_order" PRIMARY KEY ("order_no")
)
WITH (OIDS=FALSE)
;

ALTER TABLE "dfh"."tb_order" OWNER TO "postgres";

COMMENT ON TABLE "dfh"."tb_future_order" IS '期貨委託簿';
COMMENT ON COLUMN "dfh"."tb_order"."order_sn" IS '查詢序號';
COMMENT ON COLUMN "dfh"."tb_order"."order_no" IS '委託單號(前台給的)';
COMMENT ON COLUMN "dfh"."tb_order"."insq" IS '網路單號(中台給的)';
COMMENT ON COLUMN "dfh"."tb_order"."desq" IS '委託書編號';
COMMENT ON COLUMN "dfh"."tb_order"."branch_no" IS '分公司代碼';
COMMENT ON COLUMN "dfh"."tb_order"."cust_id" IS '客戶帳號';
COMMENT ON COLUMN "dfh"."tb_order"."cust_cofirm" IS '客戶帳號檢查碼';
COMMENT ON COLUMN "dfh"."tb_order"."agent_id" IS '營業員代號';
COMMENT ON COLUMN "dfh"."tb_order"."stock" IS '商品代號';
COMMENT ON COLUMN "dfh"."tb_order"."price" IS '委託價格';
COMMENT ON COLUMN "dfh"."tb_order"."volume" IS '目前委託股數';
COMMENT ON COLUMN "dfh"."tb_order"."m_type" IS '市場別(T-上市  O-上櫃)';
COMMENT ON COLUMN "dfh"."tb_order"."e_code" IS '作業別(N-整股  F-定價  O-零股)';
COMMENT ON COLUMN "dfh"."tb_order"."bs" IS '買賣別(B:買,S:賣)';
COMMENT ON COLUMN "dfh"."tb_order"."o_type" IS '委託類別(0:普通  3:自資  4:自券)';
COMMENT ON COLUMN "dfh"."tb_order"."p_code" IS '價格類別—0:限價  2:平盤  3:跌停  4:漲停';
COMMENT ON COLUMN "dfh"."tb_order"."term" IS '櫃號';
COMMENT ON COLUMN "dfh"."tb_order"."order_date" IS '委託日期時間';
COMMENT ON COLUMN "dfh"."tb_order"."cdi" IS '動作別(O:新單  M:改量  C:刪單)';
COMMENT ON COLUMN "dfh"."tb_order"."order_src" IS '來源陳述';
COMMENT ON COLUMN "dfh"."tb_order"."reserve" IS '保留';
COMMENT ON COLUMN "dfh"."tb_order"."from_ip" IS '來源的IP';
COMMENT ON COLUMN "dfh"."tb_order"."keyin_id" IS '打單人員代號';
COMMENT ON COLUMN "dfh"."tb_order"."error_code" IS '錯誤代碼 ''00''=正確 ''01''=客戶帳號不存在 ''02''=客戶帳號檢查碼錯誤 ''03''=非交易日 ''04''=非交易日時間 ''05''=認證碼不存在 ''99''=後台連線失敗';
COMMENT ON COLUMN "dfh"."tb_order"."last_update" IS '最後更新日期時間';

CREATE INDEX "tb_order_agent_id_idx" ON "dfh"."tb_order" USING btree ("agent_id");
CREATE INDEX "tb_order_branch_no_idx" ON "dfh"."tb_order" USING btree ("branch_no");
CREATE INDEX "tb_order_cust_id_idx" ON "dfh"."tb_order" USING btree ("cust_id");
CREATE INDEX "tb_order_keyin_id_idx" ON "dfh"."tb_order" USING btree ("keyin_id");
CREATE INDEX "tb_order_last_update_idx" ON "dfh"."tb_order" USING btree ("last_update");
CREATE INDEX "tb_order_order_sn_idx" ON "dfh"."tb_order" USING btree ("order_sn");

/*=============================================================================
Project	: [DCN order server proxy] Project.
Date 	: 2016.10.19
Author 	: al0926783757@mail.apex.com.tw
--tb_future_pxbs
--tb_future_pxbs_history
Desc 	: DCN order server proxy 委託回報商品代碼紀錄表(這邊是雛形,實際內容請參考192.168.12.22 dfhf內的table)
=============================================================================*/

drop table if exists dfhf.tb_future_pxbs cascade;

create table dfhf.tb_future_pxbs
(
--"sn" int8 DEFAULT nextval('"dfh".cs_pxbs_history_sn_seq'::regclass) NOT NULL,
"sn" int8 serial primary key,
"tdate" varchar(8),
"extm" varchar(8),
"dnflag" varchar(1),
"bhno" varchar(10),
"future_account" varchar(11) not null,
"comm" varchar(6),
"symb" varchar(20),
"bs" varchar(1),
"lino" varchar(1),
"kind" varchar(2),
"orsh" varchar(6),
"duov" varchar(6),
"nesh" varchar(6),
"orpr" varchar(10),
"orpt" varchar(1),
"ortr" varchar(1),
"orcn" varchar(1),
"orse" varchar(11),
"prodtype" varchar(1),
"cdi" varchar(1),
"rowdata" varchar(1000),
"log_time" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
CONSTRAINT "pk_tb_future_pxbs" PRIMARY KEY ("orse")
);

COMMENT ON TABLE  dfhf.tb_future_pxbs          IS 'DCN order server proxy 期貨委託回報歷程紀錄表';

COMMENT ON COLUMN dfhf.tb_future_pxbs.tdate		IS '交易日期';
COMMENT ON COLUMN dfhf.tb_future_pxbs.dnflag	IS '日盤夜盤';
COMMENT ON COLUMN dfhf.tb_future_pxbs."bhno"	  IS '分公司';
COMMENT ON COLUMN dfhf.tb_future_pxbs."future_account"	IS '客戶期貨帳號';
COMMENT ON COLUMN dfhf.tb_future_pxbs."comm"	  IS '委託書號';
COMMENT ON COLUMN dfhf.tb_future_pxbs."symb"	  IS '期交所商品代碼';
COMMENT ON COLUMN dfhf.tb_future_pxbs."bs"			IS 'ZF B/S 買賣別';
COMMENT ON COLUMN dfhf.tb_future_pxbs."lino"		IS 'ZF 市場別';
COMMENT ON COLUMN dfhf.tb_future_pxbs."kind"		IS '1=單式,10=複式';
COMMENT ON COLUMN dfhf.tb_future_pxbs."orsh"		IS ' 委託量';
COMMENT ON COLUMN dfhf.tb_future_pxbs."duov"		IS ' 改前量';
COMMENT ON COLUMN dfhf.tb_future_pxbs."nesh"		IS ' 改後量';
COMMENT ON COLUMN dfhf.tb_future_pxbs."orpr"		IS ' 委託價';
COMMENT ON COLUMN dfhf.tb_future_pxbs."orpt"		IS 'ZF 價格別';
COMMENT ON COLUMN dfhf.tb_future_pxbs."ortr"		IS 'ZF 委託別';
COMMENT ON COLUMN dfhf.tb_future_pxbs."orcn"		IS 'ZF 委託條件';
COMMENT ON COLUMN dfhf.tb_future_pxbs."orse"		IS 'ZF 流水號';
COMMENT ON COLUMN dfhf.tb_future_pxbs."prodtype"IS '1:期貨單式 2:選擇權單式 3:選擇權複式 4:期貨複式';
COMMENT ON COLUMN dfhf.tb_future_pxbs."cdi" 		IS 'ZF 委託性質(1:新單,4:刪單,5:改量,M:改價), YD 委託性質(期貨選擇權 [1-委託 2-改量 3-取銷 6-改價])';
COMMENT ON COLUMN dfhf.tb_future_pxbs."rowdata"IS '元大rowdata';
COMMENT ON COLUMN dfhf.tb_future_pxbs.log_time IS 'LOG時間';

Drop Index if exists tb_future_pxbs_orse_idx;
Drop Index if exists tb_future_pxbs_comm_idx;
Drop Index if exists tb_future_pxbs_tdate_idx;
Drop Index if exists tb_future_pxbs_log_time_idx;

CREATE INDEX "tb_future_pxbs_orse_idx" ON "dfhf"."tb_future_pxbs" USING btree ("orse");
CREATE INDEX "tb_future_pxbs_comm_idx" ON "dfhf"."tb_future_pxbs" USING btree ("comm");
CREATE INDEX "tb_future_pxbs_tdate_idx" ON "dfhf"."tb_future_pxbs" USING btree ("tdate");
CREATE INDEX "tb_future_pxbs_log_time_idx" ON "dfhf"."tb_future_pxbs" USING btree ("log_time");


/*=============================================================================
Project	: [DCN order server proxy] Project.
Date 	: 2016.10.20
Author 	: al0926783757@mail.apex.com.tw
--tb_future_pxmh
--tb_future_pxmh_history
Desc 	: DCN order server proxy 委託回報商品代碼紀錄表(這邊是雛形,實際內容請參考192.168.12.22 dfhf內的table)
=============================================================================*/
drop table if exists dfhf.tb_future_pxmh cascade;

create table dfhf.tb_future_pxmh
(
"sn" int8 DEFAULT nextval('"dfh".cs_pxbs_history_sn_seq'::regclass) NOT NULL,
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
"rowdata" varchar(1000),
"log_time" timestamp(6) DEFAULT timezone('CCT'::text, now()) NOT NULL,
CONSTRAINT "pk_tb_future_pxmh" PRIMARY KEY ("orse")
);

COMMENT ON TABLE  dfhf.tb_future_pxmh          IS 'DCN order server proxy 期貨成交回報歷程紀錄表';

COMMENT ON COLUMN dfhf.tb_future_pxmh.tdate		IS '交易日期';
COMMENT ON COLUMN dfhf.tb_future_pxmh.dnflag	IS '日盤夜盤';
COMMENT ON COLUMN dfhf.tb_future_pxmh."future_account"	IS '客戶期貨帳號';
COMMENT ON COLUMN dfhf.tb_future_pxmh."comm"	  IS '委託書號';
COMMENT ON COLUMN dfhf.tb_future_pxmh."symb"	  IS '期交所商品代碼';
COMMENT ON COLUMN dfhf.tb_future_pxmh."bs"			IS ' B/S 買賣別';
COMMENT ON COLUMN dfhf.tb_future_pxmh."lino"		IS ' 市場別';
COMMENT ON COLUMN dfhf.tb_future_pxmh."lots"		IS ' 成交量';
COMMENT ON COLUMN dfhf.tb_future_pxmh."pric"		IS ' 成交價';
COMMENT ON COLUMN dfhf.tb_future_pxmh."orse"		IS ' 流水號';
COMMENT ON COLUMN dfhf.tb_future_pxmh."prodtype" 	IS ' 1:期貨單式 2:選擇權單式 3:選擇權複式 4:期貨複式';
COMMENT ON COLUMN dfhf.tb_future_pxmh."rowdata"IS '元大rowdata';
COMMENT ON COLUMN dfhf.tb_future_pxmh.log_time IS 'LOG時間';

Drop Index if exists tb_future_pxmh_orse_idx;
Drop Index if exists tb_future_pxmh_comm_idx;
Drop Index if exists tb_future_pxmh_tdate_idx;
Drop Index if exists tb_future_pxmh_log_time_idx;

CREATE INDEX "tb_future_pxmh_orse_idx" ON "dfhf"."tb_future_pxmh" USING btree ("orse");
CREATE INDEX "tb_future_pxmh_comm_idx" ON "dfhf"."tb_future_pxmh" USING btree ("comm");
CREATE INDEX "tb_future_pxmh_tdate_idx" ON "dfhf"."tb_future_pxmh" USING btree ("tdate");
CREATE INDEX "tb_future_pxmh_log_time_idx" ON "dfhf"."tb_future_pxmh" USING btree ("log_time");