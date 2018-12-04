select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                            cust.name as name, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                            volume, o.price, volume*o.price as amt, cust.sale as sales, error_code as result, o_type as type,       
                            case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                            o.market as market, o.term||o.desq as delivercode, o.keyin_id, o.order_src, o.currency as Tcurrency, nco.status, nco.err_msg
                                    from dfh.tb_order_history o 
LEFT JOIN dfh.tb_non_current_order nco on o.stock = nco.symbol and o.market = nco.market and o.term||o.desq = nco.order_no
                                    INNER JOIN dfh."sfGetCustomerList"('20181203','20181203') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
                                    where  tdate = '20181203' and o.market like '%US%' and o.branch_no like '%%'
                                    UNION ALL
                                    select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                                    cust.name as name, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                                    volume, o.price, volume*o.price as amt, cust.sale as sales, error_code as result, o_type as type,       
                                    case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                                    o.market as market, o.term||o.desq as delivercode, o.keyin_id, o.order_src, o.currency as Tcurrency, nco.status, nco.err_msg
                                    from dfh.tb_order o 
                                    INNER JOIN dfh."sfGetCustomerList"('20181203','20181203') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
LEFT JOIN dfh.tb_non_current_order nco on o.stock = nco.symbol and o.market = nco.market and o.term||o.desq = nco.order_no
                                    where tdate = '20181203' and o.market like '%US%' and o.branch_no like '%%'
                                    union all
                                    select '' as order_no, to_char( o.insert_dt, 'YYYYMMDD') as tdate, to_char( o.insert_dt, 'YYYY/MM/DD HH24:mi:ss') as trade_date, o.branch||'-'||substr(o.account, 0, 7)||'-'||substr(o.account, 7, 1) as acc,
                                    cust.name as name, stock.exchange as exchange, o.symbol||' '||stock.name as stock, case when o.side = '1' then '買' else '賣' end as bs,
                                    o.order_qty::NUMERIC as volume, o.price::NUMERIC, o.order_qty::NUMERIC*o.price::NUMERIC as amt, cust.sale as sales, '預約單' as result, '' as type, '新單' as action ,
                                    o.market as market, '-' as delivercode, insert_user as keyin_id, '' as order_src, stock.currency as Tcurrency, o.status, o.err_msg
                                        from dfh.tb_non_current_order o
                                        INNER JOIN dfh."sfGetCustomerList"('20181203','20181203') cust on substr(o.account, 0, 7)=cust.cesq and o.branch=cust.branch
                                        INNER JOIN dfh.v_tb_stock_name stock on o.symbol=stock.stock 
                                        where insert_dt >= (SELECT (TIMESTAMP WITH TIME ZONE '20181130 200000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE (select timezone from dfh.tb_market where market = 'US')) 
and insert_dt <= (SELECT (TIMESTAMP WITH TIME ZONE '20181203 020000' AT TIME ZONE 'Asia/Taipei') AT TIME ZONE (select timezone from dfh.tb_market where market = 'US'))
                                order by trade_date