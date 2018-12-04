--20170406 期貨table DML

--customer data 期貨帳號不重覆
select info.fbhno,info.cesq,info.name,attr.att from dfhf.tb_customerinfo info
left join dfhf.tb_customer_attribute attr on info.cesq = attr.cseq
 where info.cesq = '2600065' and attr.amode = '01' limit 1



--主動委託回報
insert into dfhf.tb_future_pxbs
("tdate", "dnflag", "future_account", "comm", "symb", "bs",
"lino", "lino", "orsh", "duov", "nesh", "orpr", "orpt", "ortr", "orcn", "orse", "prodtype", "cdi", "rowdata") 
VALUES ()

--主動成交回報
insert into dfhf.tb_future_pxmh ("tdate", "dnflag", "bhno", "future_account", "comm", "symb", "bs",
"lino", "orsh", "duov", "nesh", "orpr", "orpt", "ortr", "orcn", "orse", "cdi", "rowdata")
VALUES ()

--雙向委託回補
select tdate,extm,dnflag,future_account,comm,symb,bs,lino,kind,orsh,duov,nesh,orpr,orpt,ortr,orcn,orse,prodtype,cdi from dfhf.tb_future_pxbs 
where dnflag = 'D' and future_account = '2600065' and tdate = '20170418'

select fbhno, cesq from dfhf.tb_customerinfo where sale = '036' and branch = (select branch from dfh.tb_salseinfo where tlno = '110036')

822 2540439
822 9837365
select tdate,extm,dnflag,bhno,future_account,comm,symb,bs,lino,kind,orsh,duov,nesh,orpr,orpt,ortr,orcn,orse,prodtype,cdi 
from dfhf.tb_future_pxbs_history where dnflag = 'D' and future_account in (
	select cesq from dfhf.tb_customerinfo where sale = '036' and branch = (
		select branch from dfh.tb_salseinfo where tlno = '110036'
	)
) and tdate = '20171207'

--雙向成交回補
select tdate,extm,dnflag,future_account,comm,symb,bs,lino,lots,pric,orse,prodtype,rowdata from dfhf.tb_future_pxmh where dnflag = 'D' and future_account = '2600065' and tdate = '20170418'
200012051542823 2600065          144A003TXFI7     0009550.00B0L        0001               00000004 0912216000205                                NWB
--每日清盤 移到history

--清盤 檢查是否唯一
select tvalue from public.tb_trade_parameter where ptype = '08'--期貨
select tvalue from public.tb_trade_parameter where ptype = '09'--台股現貨

insert into dfhf.tb_future_pxbs_history(tdate,extm,dnflag,bhno,future_account,comm,symb,bs,lino
,orsh,duov,nesh,orpr,orpt,ortr,orcn,orse,prodtype,cdi,rowdata) 
select tdate, extm, dnflag, bhno, future_account, comm, symb, bs, lino
, orsh, duov, nesh, orpr, orpt, ortr, orcn, orse, prodtype, cdi, rowdata from dfhf.tb_future_pxbs where tdate !='20170420'
insert into dfhf.tb_future_pxmh_history (tdate, extm, dnflag, future_account, comm, symb, bs, lino, lots, pric, orse, prodtype, rowdata) 
select tdate, extm, dnflag, future_account, comm, symb, bs, lino, lots, pric, orse, prodtype, rowdata from dfhf.tb_future_pxmh where tdate !='20170419';
insert into dfhf.tb_future_detail_history("tdate","extm","dnflag","future_account","comm","symb","bs","lino","lots","pric","orse","prodtype","cdi")
select tdate,extm,dnflag,future_account,comm,symb,bs,lino,lots,pric,orse,prodtype,cdi from dfhf.tb_future_detail where tdate !='20170421';

delete from dfhf.tb_future_pxbs where tdate !='20170414';
delete from dfhf.tb_future_pxmh where tdate !='20170414';
delete from dfhf.tb_future_detail where tdate !='20170421';
--#清盤標記必須小於今天
update public.tb_trade_parameter set tvalue = '20170417' , last_update = now() at time zone 'CCT' where ptype = '08'
/*=============================================================================
Project	: [TCB order server proxy] Project.
Date 	: 2017.04.12
Author 	: al0926783757@mail.apex.com.tw
Desc 	: 20160412 新增

Param	:
用法 : select dfhf.sf_proxy_pxmh_insert ('2017/04/12','D','2600065','4A008','TXFD7','S','1','0001','0009816.00','0008994','T','200089941542823 2600065          144A008TXFD7     0009816.00S0L        0001               00000004 1159027200205                                NWB')
=============================================================================*/
CREATE OR REPLACE FUNCTION dfhf.sf_proxy_pxmh_insert(_tdate varchar, _extm varchar,_dnflag varchar, _future_account varchar, _comm varchar, _symb varchar
													, _bs varchar, _lino varchar, _lots varchar, _pric varchar, _exse varchar, _prodtype varchar, rowdata varchar)
RETURNS text AS $$
DECLARE
		comm_temp varchar;
BEGIN
		select comm into comm_temp from dfhf.tb_future_pxmh where orse=_exse;
--select comm from dfhf.tb_future_pxmh where orse='0018162'
		if comm_temp is null then
			insert into dfhf.tb_future_pxmh(tdate, extm, dnflag, future_account, comm, symb, bs, lino, lots, pric, orse, prodtype, rowdata)
			VALUES (_tdate,_extm,_dnflag,_future_account,_comm,_symb,_bs,_lino,_lots,_pric,_exse,_prodtype,rowdata);
			
			insert into dfhf.tb_future_detail("tdate", "extm", "dnflag", "future_account", "comm", "symb", "bs", "lino", "lots", "pric", "orse", "prodtype", "cdi") 
			VALUES(_tdate,_extm,_dnflag,_future_account,_comm,_symb,_bs,_lino,_lots,_pric,_exse,_prodtype,'T');
		end if;
		return '0000';
END;
$$
LANGUAGE plpgsql;


/*=============================================================================
Project	: [TCB order server proxy] Project.
Date 	: 2017.04.12
Author 	: al0926783757@mail.apex.com.tw
Desc 	: 20160412 新增

Param	:
用法 : select dfhf.sf_proxy_pxbs_insert ()
=============================================================================*/
CREATE OR REPLACE FUNCTION dfhf.sf_proxy_pxbs_insert( _tdate varchar, _extm varchar, _dnflag varchar, _bhno varchar, _future_account varchar, _comm varchar, _symb varchar
													, _bs varchar, _lino varchar, _kind varchar,_orsh varchar, _duov varchar, _nesh varchar
													, _orpr varchar, _orpt varchar, _ortr varchar, _orcn varchar, _orse varchar, _prodtype varchar, _cdi varchar, rowdata varchar) 
RETURNS text AS $$
DECLARE
		comm_temp varchar;
BEGIN
		select comm into comm_temp from dfhf.tb_future_pxbs where orse=_orse;
--select comm from dfhf.tb_future_pxbs where orse='0044329'
		if comm_temp is null then
			insert into dfhf.tb_future_pxbs("tdate","extm","dnflag","bhno","future_account","comm","symb","bs","lino","kind","orsh","duov","nesh","orpr"
,"orpt","ortr","orcn","orse","prodtype","cdi","rowdata")
			VALUES (_tdate,_extm,_dnflag,_bhno,_future_account,_comm,_symb,_bs,_lino,_kind,_orsh,_duov,_nesh,_orpr,_orpt,_ortr,_orcn,_orse,_prodtype,_cdi,rowdata);
			value_ := 0;
			if _cdi = '1' then value_ = _nesh::numeric; end if;
			if _cdi = '2' then value_ := (_duov::numeric-_nesh::numeric)*(-1); end if;
			if _cdi = '3' then value_ := (_duov::numeric-_nesh::numeric)*(-1); end if;

			insert into dfhf.tb_future_detail("tdate", "extm", "dnflag", "future_account", "comm", "symb", "bs", "lino", "lots", "pric", "orse", "prodtype", "cdi") 
			VALUES(_tdate,_extm,_dnflag,_future_account,_comm,_symb,_bs,_lino,value_,_orpr,_orse,_prodtype,_cdi);
		end if;
		return '0000';
END;
$$
LANGUAGE plpgsql;