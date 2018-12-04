select  cph.tdate, cl.branch as bhno, cph.cseq,cl.name,(cph.stock || ' ' ||(SELECT substring(name ,0,6) from dfh.v_tb_stock_name where stock=cph.stock)) as stock, cph.market as market,
                        case when cph.price is null then at.price else cph.price end as OrderPrice , 
                        case when rqty is null then at.volume else rqty end as OrderQty,
                        cph.term||'-'||cph.desq as hk_order, cph.bs as bs,
                        case when cph.price is null then at.price else cph.price end * case when rqty is null then at.volume else rqty end as OrderAmt,
                        to_char(case when cph.last_update is null then to_timestamp(at.tdate, 'YYYYMMDD') else cph.last_update end ,'YYYY/MM/DD HH24:mi:ss')as last_update,
case when cph.dsep = '000000  ' then cph.cdi else (select msg from dfh.tb_pxbs_error where dsep = cph.dsep) end as status,-- 讓C#去update 新 刪 部分成交狀態...

                        case when at.price isnull then '' else LTRIM(to_char(at.price,'999999.99')) end as price,
						case when at.volume isnull then '0' else LTRIM(to_char(at.volume,'999999')) end as volume,
						case when at.amt isnull then '' else LTRIM(to_char(at.amt,'999999.99')) end as amt 
            from dfh.v_cs_pxbs cph LEFT JOIN dfh.v_pxmh_amt at on at.insq=cph.insq  and at.tdate=cph.tdate and cph.bhno=at.bhno 
            left join dfh."sfGetCustomerList"('20180801', '20180814') cl on  substr(cph.cseq,1,6)=cl.cesq and cl.branch = cph.bhno and cl.confirm = cph.ckno
            LEFT JOIN dfh.v_hor_hk_map hm on hm.cseq=cph.cseq and hm.insq=cph.insq and hm.bhno=cph.bhno and cph.tdate = to_char(hm.last_update,'YYYYMMDD')
            where cph.tdate >= '20180801' and cph.market = 'HK' and cph.bhno like '%%' and cph.cseq like '%%' 
						and cph.stock like '%%' and cph.bs like '%%' ORDER BY last_update
/*SQLString.QueryUnTradeReportDetail, 
sStartDate, sEndDate, branch, custID, sStock, sType, SESS.UserID, SESS.Market);

where cph.dsep= '000000  ' and cph.tdate >= '20180801' and cph.tdate <= '20180814' and cph.bhno like '%%' and cph.cseq like '%%' and cph.cdi='O' and cph.stock like '%%' and cph.bs like '%%' 
            and cph.market = 'HK' and cph.bhno in  (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='cuser') 
            ORDER BY last_update,name
*/

SELECT * from dfh."sfGetCustomerList"('20180808', '20180830') where cesq = ''


select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                            cust.name as name, stock.market as market, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                            volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type,       
                            case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                            o.market as market, o.term||'-'||o.desq as delivercode, o.keyin_id, o.order_src, o.currency, o.currency as Tcurrency
                                    from dfh.tb_order_history o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180801','20180821') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
                                    where tdate = '20180820' and o.market = 'HK' and o.branch_no = '6110' 
                                    UNION ALL
                                    select o.order_no, o.tdate, to_char(order_date, 'YYYY/MM/DD HH24:mi:ss') as trade_date, branch_no||'-'||cust_id||'-'||cust_cofirm as acc, 
                                    cust.name as name, stock.market as market, stock.exchange as exchange, o.stock||' '||stock.name as stock,  case when o.bs = 'B' then '買' else '賣' end as bs, 
                                    volume, price, volume*price as amt, cust.sale as sales, error_code as result, o_type as type,       
                                    case when cdi='O' then '新單' when cdi='M' then '改單' when cdi='C' then '刪單' else '' end as action ,
                                    o.market as market, o.term||'-'||o.desq as delivercode, o.keyin_id, o.order_src, o.currency, o.currency as Tcurrency
                                    from dfh.tb_order o 
                                    INNER JOIN dfh."sfGetCustomerList"('20180801','20180821') cust on o.cust_id=cust.cesq and o.cust_cofirm=cust.confirm 
                                    INNER JOIN dfh.v_tb_stock_name stock on o.stock=stock.stock 
                                    where tdate = '20180820' and o.market = 'HK' and o.branch_no = '6110' 
                                order by trade_date


select sn,case when wmode='0' then '派股' else '派息' end as wmode,tdate,stock,rate,workdate,total,reason,market,cuser,to_char("last_update", 'YYYY/MM/DD HH24:mi:ss') as "last_update"
                                        from dfh.tb_stock_bonus 
                                        where substr(tdate, 0, 5) = '2018' and flag='0' and market = ''
                                        order by sn desc