CREATE OR REPLACE VIEW "dfh"."v_cust_info" AS 
SELECT table3.bhno, table3.cesq, table3.name, table3.salse, table3.salesname, table3.discomm, table3.buypower, table3.mincomm, table3.tel, table3.address, table3.account11, 
table3.account10, table3.professional, table3.risk, table3.etf21, table3.uslimitfee, table3.cnlimitfee, table3.hkdiscomm, table3.hkmincomm, table3.hkelediscomm, table3.hkelemincomm, 
table3.usdiscomm, table3.usmincomm, table3.uselediscomm, table3.uselemincomm, table3.hhdiscomm, table3.hhmincomm, table3.hhelediscomm, table3.hhelemincomm, table3.hzdiscomm, 
table3.hzmincomm, table3.hzelediscomm, table3.hzelemincomm, table3.id 

FROM (SELECT z.branch AS bhno, ((z.cesq)::text || (z.confirm)::text) AS cesq, z.name, z.sale AS salse, 
(SELECT tb_salseinfo.name FROM dfh.tb_salseinfo WHERE (((tb_salseinfo.sale)::text = (z.sale)::text) AND ((tb_salseinfo.branch)::text = (z.branch)::text))) AS salesname, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '01'::text))) AS discomm, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '02'::text))) AS buypower, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '07'::text))) AS mincomm, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '18'::text))) AS tel, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '12'::text))) AS address, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '11'::text))) AS account11, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '10'::text))) AS account10, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '00'::text))), 'undef'::character varying) AS professional, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '40'::text))), 'undef'::character varying) AS risk, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '41'::text))), 'undef'::character varying) AS etf21, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '42'::text))), 'undef'::character varying) AS uslimitfee, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '43'::text))), 'undef'::character varying) AS cnlimitfee, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HKCustCommCut_Sys'::text)))::text))), 'undef'::character varying) AS hkdiscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HKCustCommMin_Sys'::text)))::text))), 'undef'::character varying) AS hkmincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HKCustELECommCut_Sys'::text)))::text))), 'undef'::character varying) AS hkelediscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HKCustELECommMin_Sys'::text)))::text))), 'undef'::character varying) AS hkelemincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'USCustCommCut_Sys'::text)))::text))), 'undef'::character varying) AS usdiscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'USCustCommMin_Sys'::text)))::text))), 'undef'::character varying) AS usmincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'USCustELECommCut_Sys'::text)))::text))), 'undef'::character varying) AS uselediscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'USCustELECommMin_Sys'::text)))::text))), 'undef'::character varying) AS uselemincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HHCustCommCut_Sys'::text)))::text))), 'undef'::character varying) AS hhdiscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HHCustCommMin_Sys'::text)))::text))), 'undef'::character varying) AS hhmincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HHCustELECommCut_Sys'::text)))::text))), 'undef'::character varying) AS hhelediscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HHCustELECommMin_Sys'::text)))::text))), 'undef'::character varying) AS hhelemincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HZCustCommCut_Sys'::text)))::text))), 'undef'::character varying) AS hzdiscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HZCustCommMin_Sys'::text)))::text))), 'undef'::character varying) AS hzmincomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HZCustELECommCut_Sys'::text)))::text))), 'undef'::character varying) AS hzelediscomm, 
COALESCE((SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = ((SELECT tb_parameters.pstr FROM dfh.tb_parameters WHERE ((tb_parameters.wtype)::text = 'HZCustELECommMin_Sys'::text)))::text))), 'undef'::character varying) AS hzelemincomm, 
(SELECT b.att FROM dfh.tb_customer_attribute b WHERE ((((z.branch)::text = (b.bhno)::text) AND ((z.cesq)::text = (b.cseq)::text)) AND ((b.amode)::text = '00'::text))) AS id FROM (SELECT bb.branch, bb.cesq, bb.confirm, bb.name, bb.sale FROM (SELECT a.branch, a.cesq, a.confirm, a.name, a.sale, b.att FROM (dfh.tb_customerinfo a LEFT JOIN dfh.tb_customer_attribute b ON (((((b.bhno)::text = (a.branch)::text) AND ((b.cseq)::text = (a.cesq)::text)) AND ((b.amode)::text = '03'::text))))) bb WHERE ((bb.att)::text = '正常'::text)) z) table3;

ALTER TABLE "dfh"."v_cust_info" OWNER TO "postgres";




--make_v_cust_info
select minvalue::character varying||'undef' as HKCustELECommMin_Sys
from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = 'HKCustELECommMin_Sys')

||'undef';
select rate::character varying||''undef'' from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = '''||datas_.market||'CustCommMin_Sys'')

select rate::character varying||'undef' from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = 'HHCustELECommMin_Sys');
select rate::character varying||'undef' from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = 'USCustELECommMin_Sys');


select dfh.sf_make_v_cust_info()
