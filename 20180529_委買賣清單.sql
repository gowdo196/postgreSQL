--20180529 委買賣清單
select 
o.order_no,
o.tdate,
to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, 
branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
cust.name as name,  
o.stock||' '||stock.name as stock, 
case when o.bs = 'B' then '買' else '賣' end as bs, 
volume, 
price, 
volume*price as amt, 
cust.sale as sales, 
error_code as result, 
o_type as type,       
case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
o.market as market,
o.term||'-'||o.desq as delivercode,
o.keyin_id,
o.order_src,
o.currency,
o.currency as Tcurrency

--select * 
from dfh.tb_order_history o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180531','20180531') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
--left join dfh.hor_hk_map map on map.insq=o.insq and to_char(map.last_update, 'YYYYMMDD')=tdate 
INNER join dfh.cs_pxbs_history pxbs on pxbs.insq=o.insq
INNER join dfh.cs_pxmh_history pxmh on pxmh.org_seq=o.insq
left join dfh.tb_pxbs_error err on err.dsep=pxbs.dsep 
                                    where order_date >= '20180531 00:00:00' and order_date <= '20180531 23:59:59' and o.branch_no like '%%' and 
                                        o.cust_id like '%%' and bs like '%%' and o.market like '%US%' and
                                        o.branch_no in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001') 

                                    UNION ALL
                                    select to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, 
                                    branch_no||'-'||cust_id||'-'||cust_cofirm as acc, cust.name as name, '' as order_no, 
                                    o.stock||' '||stock.name as stock, case when o.bs = 'B' then '買' else '賣' end as bs, 
                                    volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type, 
                                    case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,o.market as market
                                    from dfh.tb_order o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180531','20180531') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 


                                    where order_date >= '20180531 00:00:00' and order_date <= '20180531 23:59:59' and o.branch_no like '%%' and 
                                        o.cust_id like '%%' and bs like '%%' and o.market like '%US%' and
                                        o.branch_no in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001') 
                                order by trade_date
                                


select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                            cust.name as name, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                            volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type,       
                            case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                            o.market as market, o.term||o.desq as delivercode, o.keyin_id, o.order_src, o.currency, o.currency as Tcurrency
                                    from dfh.tb_order_history o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180601','20180601') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
                                    where tdate = '20180601' and o.market like '%HK%' and o.currency = 'HKD' and
                                        o.branch_no in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='20180601') 
                                    UNION ALL
                                    select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                                    cust.name as name, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                                    volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type,       
                                    case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                                    o.market as market, o.term||o.desq as delivercode, o.keyin_id, o.order_src, o.currency, o.currency as Tcurrency
                                    from dfh.tb_order o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180601','20180601') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 

                                    where tdate = '20180601' and o.market = 'HK' and o.currency = 'HKD' and
                                        o.branch_no in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='20180601') 
                                order by trade_date