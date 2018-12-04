--20180609 對帳頁面 group by stock

select "OrderNo", "TradeDate", "TradeTime", 
            "Product", "OrderType", "Price", "Quantity", "BranchNo", "AccountNo"||"CheckedNo" as "AccountNo", 
            "SalesID", case when "OrderExists" = '1' then '存在' else '不存在' end as "OrderExists", "OrderKind" 
            from dfh."CheckedStatement" where "OrderKind" = '0' and "StatementChecked" = '0' 
            order by "OrderNo"

--dfh.sf_make_checkedstatement('{0}','{1}') ", market, strDate

--12.21 cs_mutil
ALTER TABLE dfh.tb_stock_name ADD COLUMN active char(1) DEFAULT '0'::bpchar;--是否啟用
ALTER TABLE dfh.tb_stock_name ADD COLUMN daytrade char(1) DEFAULT '1'::bpchar;
ALTER TABLE dfh.tb_stock_name ADD COLUMN sellonly char(1) DEFAULT '0'::bpchar;
ALTER TABLE dfh.tb_stock_name ADD COLUMN active char(1) DEFAULT '0'::bpchar;
ALTER TABLE dfh.tb_stock_name ADD COLUMN professional char(1) DEFAULT '1'::bpchar;
ALTER TABLE dfh.tb_stock_name ADD COLUMN risk char(1) DEFAULT '1'::bpchar;
ALTER TABLE dfh.tb_stock_name ADD COLUMN etf21 char(1) DEFAULT '1'::bpchar;

ALTER TABLE dfh.tb_stock_name ADD COLUMN manual char(1) DEFAULT '0'::bpchar;


select stock,manual from dfh.tb_stock_name where stock='AAPL' and market='US' limit 1 