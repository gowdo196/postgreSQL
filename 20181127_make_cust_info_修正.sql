CREATE OR REPLACE FUNCTION "dfh"."sf_make_v_cust_info"()
  RETURNS "pg_catalog"."void" AS $BODY$
DECLARE
    sqlcmd_ varchar;
    datas_ record;
    sql1_ varchar;
BEGIN
    sqlcmd_ = 'drop view if exists dfh.v_cust_info cascade;';
    sqlcmd_ = sqlcmd_ || 'create view dfh.v_cust_info as ';
    sqlcmd_ = sqlcmd_ || 'select * from ';
    sqlcmd_ = sqlcmd_ || '(select Z.branch as bhno, Z.cesq||Z.confirm as cesq, Z.name as name, Z.sale as salse, (select name from dfh.tb_salseinfo where sale = Z.sale and tb_salseinfo.branch=z.branch) as salesname,';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''01'') as discomm, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''02'') as buypower, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''07'') as mincomm, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''18'') as tel, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''12'') as address, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''11'') as account11, ';
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''10'') as account10, ';
    sqlcmd_ = sqlcmd_ || 'COALESCE((select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''00''),''undef'') as professional, ';
    sqlcmd_ = sqlcmd_ || 'COALESCE((select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''40''),''undef'') as risk, ';
    sqlcmd_ = sqlcmd_ || 'COALESCE((select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''41''),''undef'') as etf21, ';   
    for datas_ in (select market from dfh.tb_market where enable='1') loop
        sql1_ = 'COALESCE((select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=(select pstr from dfh.tb_parameters where wtype='''||datas_.market||'CustCommCut_Sys'')),''0'' ) as '||datas_.market||'discomm,';
        sqlcmd_ = sqlcmd_ ||sql1_;
        sql1_ = 'COALESCE((select B.att from dfh.tb_customer_attribute_working B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=(select pstr from dfh.tb_parameters where wtype='''||datas_.market||'CustCommMin_Sys'')),(select minvalue::character varying||''undef'' from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = '''||datas_.market||'CustCommMin_Sys'')) ) as '||datas_.market||'Mincomm,';
        sqlcmd_ = sqlcmd_ ||sql1_;
        sql1_ = 'COALESCE((select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=(select pstr from dfh.tb_parameters where wtype='''||datas_.market||'CustELECommCut_Sys'')),''0'' ) as '||datas_.market||'ELEdiscomm,';
        sqlcmd_ = sqlcmd_ ||sql1_;
        sql1_ = 'COALESCE((select B.att from dfh.tb_customer_attribute_working B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=(select pstr from dfh.tb_parameters where wtype='''||datas_.market||'CustELECommMin_Sys'')),(select minvalue::character varying||''undef'' from dfh.tb_trade_fee where ptype = (select pstr from dfh.tb_parameters where wtype = '''||datas_.market||'CustELECommMin_Sys'')) ) as '||datas_.market||'ELEMincomm,';
        sqlcmd_ = sqlcmd_ ||sql1_;
    end loop;
    sqlcmd_ = sqlcmd_ || '(select B.att from dfh.tb_customer_attribute B where Z.branch=B.bhno and Z.cesq=B.cseq and B.amode=''00'') as id ';
    sqlcmd_ = sqlcmd_ || 'from (select BB.branch, BB.cesq, BB.confirm, BB.name, BB.sale from ';
    sqlcmd_ = sqlcmd_ || '(select A.branch, A.cesq, A.confirm, A.name, A.sale, B.att from dfh.tb_customerinfo A ';
    sqlcmd_ = sqlcmd_ || 'left join dfh.tb_customer_attribute B on B.bhno=A.branch and B.cseq=A.cesq ';
    sqlcmd_ = sqlcmd_ || 'and B.amode=''03'') BB where BB.att=''正常'') Z) as table3;';


  EXECUTE sqlcmd_;
  RETURN ;
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
;

ALTER FUNCTION "dfh"."sf_make_v_cust_info"() OWNER TO "postgres";