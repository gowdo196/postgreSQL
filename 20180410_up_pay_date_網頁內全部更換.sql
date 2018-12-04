select * from (
                                    (select * from 
                                    (select '1' as id,bhno,department, case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20180402', 'B', 'HK', 'phli') 
                                    else dfh."sf_hor_get_amt_pay_date"('20180402', 'S', 'HK', 'phli') end as payday,
                                    case when bs = 'B' then dfh."sf_hor_get_up_pay_date"('20180402', 'B', 'HK', 'phli') 
                                    else dfh."sf_hor_get_up_pay_date"('20180402', 'S', 'HK', 'phli') end as up_payday,
                                    '110888' as cseq, bs, (stock || ' ' || name) as stock, price, volume, amt,0 as hk_commission,0 as other_fee, 0 as upper_pay,case when bs='"B"' then total_amt*-1 else total_amt end as total_amt 
                                    from dfh.v_pxmh_amt where tdate = '20180402' and market = 'HK'
                                    and bhno in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' 
                                    and "Enable"='1' and "EmployeeID"='adm001')
                                    union all
                                    select '2' as id ,'','','','','', bs, stock||' '||name, 0, 0, 0, commission, coalesce(other_fee, 0) as other_fee, case when bs='B' then upper_pay*-1 else upper_pay end as upper_pay, 0
                                    from dfh.v_upper_amt where tdate = '20180402') as ddd
                                    where ddd.bs = 'S' order by stock desc, id)
                                     union all 
                                    (select * from 
                                    (select '1' as id,bhno,department, case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20180402', 'B', 'HK', 'phli') 
                                    else dfh."sf_hor_get_amt_pay_date"('20180402', 'S', 'HK', 'phli') end as payday,
                                    case when bs = 'B' then dfh."sf_hor_get_up_pay_date"('20180402', 'B', 'HK', 'phli') 
                                    else dfh."sf_hor_get_up_pay_date"('20180402', 'S', 'HK', 'phli') end as up_payday,
                                    '110888' as cseq, bs, (stock || ' ' || name) as stock, price, volume, amt,0 as hk_commission,0 as other_fee, 0 as upper_pay,case when bs='"B"' then total_amt*-1 else total_amt end as total_amt 
                                    from dfh.v_pxmh_amt where tdate = '20180402' and market = 'HK'
                                    and bhno in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' 
                                    and "Enable"='1' and "EmployeeID"='adm001')

                                      union all
                                      select '2' as id ,'','','','','', bs, stock||' '||name, 0, 0, 0, commission, coalesce(other_fee, 0) as other_fee, case when bs='B' then upper_pay*-1 else upper_pay end as upper_pay, 0
                                      from dfh.v_upper_amt where tdate = '20180402') as ddd
                                    where ddd.bs = 'B' 
                                      order by stock desc, id  )) as gogo order by gogo.stock desc, gogo.bs, gogo.id



交割日: select dfh.sf_hor_get_amt_pay_date('20180409', 'S', 'HK', 'phli') 		, 'HK', 'phli'
				select dfh.sf_hor_get_amt_pay_date('20180409', 'S', 'US', 'phli') 		, 'US', 'phli'
				select dfh.sf_hor_get_amt_pay_date('20180409', 'B', 'US', 'phli') 		, '{2}', 'phli'
上手交割日  select dfh.sf_hor_get_up_pay_date('20180409', 'S', 'HK', 'phli')
						select dfh.sf_hor_get_up_pay_date('20180409', 'S', 'US', 'phli')
						select dfh.sf_hor_get_up_pay_date('20180409', 'B', 'US', 'phli')


--tb_stock_name

select * from dfh.tb_stock_name where stock = 'AAPL'
select dfh.sf_hor_stock_name_import('AGILENT TECHNOLOGIES INC','US00846U1016','A','1','2520153','00846U101','US','XNYS','USD')


UPDATE dfh.tb_stock_name set  = '' where stock in ('02','06')
ALTER TABLE dfh.tb_stock_name ADD COLUMN SEDOL_Code   VARCHAR(10);
ALTER TABLE dfh.tb_stock_name ADD COLUMN CUSIP_Code   VARCHAR(10);
ALTER TABLE dfh.tb_stock_name SET COLUMN SEDOL_Code   VARCHAR(30);
ALTER TABLE "dfh"."tb_stock_name" ALTER COLUMN SEDOL_Code TYPE varchar(30);
ALTER TABLE "dfh"."tb_stock_name" ALTER COLUMN CUSIP_Code TYPE varchar(30);

ALTER TABLE dfh.tb_stock_name_history ADD COLUMN SEDOL_Code   VARCHAR(30);
ALTER TABLE dfh.tb_stock_name_history ADD COLUMN CUSIP_Code   VARCHAR(30);
ALTER TABLE "dfh"."tb_stock_name_history" ALTER COLUMN SEDOL_Code TYPE varchar(30);
ALTER TABLE "dfh"."tb_stock_name_history" ALTER COLUMN CUSIP_Code TYPE varchar(30);

select dfh.sf_hor_stock_name_import('AARON''S INC','US0025353006','AAN','','2002918','002535300','US','XNYS','USD');

CREATE OR REPLACE FUNCTION "dfh"."sf_hor_stock_name_import"(_stock_long_name varchar, _isin varchar, _symbol varchar, _apex_type varchar, _SEDOL_Code varchar, _CUSIP_Code varchar, _Market varchar, _Exchange varchar, _Currency varchar)
  RETURNS "pg_catalog"."text" AS $BODY$
DECLARE
    datas record;
	temp_ varchar;
BEGIN
    select SEDOL_Code into temp_ from dfh.tb_stock_name where stock=_symbol;
    if temp_ is not null then
			update dfh.tb_stock_name 
			set market = _Market,
					exchange = _Exchange,
					currency = _Currency,
					isincode = _isin,
					cname = _stock_long_name,
          sedol_code = _SEDOL_Code,
					cusip_code = _CUSIP_Code,
          last_update = timezone('CCT'::text, now()) 
          where stock = _symbol ;
		ELSE 

			insert into dfh.tb_stock_name ("stock","name","apex_type","unit","hon_type","hon_type_cn","apex","market","exchange","deliver","currency","isincode","cname","sedol_code","cusip_code") 
			VALUES (_symbol, _stock_long_name ,'', 1,'','',_apex_type, 
					_Market , _Exchange , 'phli', _Currency ,_isin, _stock_long_name,_SEDOL_Code, _CUSIP_Code);
	  end if;
	return '0000';
END;
$BODY$
  LANGUAGE 'plpgsql' VOLATILE COST 100
;

ALTER FUNCTION "dfh"."sf_hor_stock_name_import"(_stock_long_name varchar, _isin varchar, _symbol varchar, _apex_type varchar, _SEDOL_Code varchar, _CUSIP_Code varchar, _Market varchar, _Exchange varchar, _Currency varchar) OWNER TO "postgres";
