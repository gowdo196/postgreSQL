select * from (
                                    (select * from 
                                    (select '1' as id,insq,bhno,department, case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20181001', 'B', 'US', 'phli') 
                                    else dfh."sf_hor_get_amt_pay_date"('20181001', 'S', 'US', 'phli') end as payday,
                                    case when bs = 'B' then dfh."sf_hor_get_up_pay_date"('20181001', 'B', 'US', 'phli') 
                                    else dfh."sf_hor_get_up_pay_date"('20181001', 'S', 'US', 'phli') end as up_payday,
                                    '110888' as cseq, bs, (stock || ' ' || name) as stock, price, volume, amt,0 as hk_commission,0 as other_fee, 0 as upper_pay,case when bs='"B"' then total_amt*-1 else total_amt end as total_amt 
                                    from dfh.v_pxmh_amt where tdate = '20181001' and market like '%US%'
                                    and bhno in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' 
                                    and "Enable"='1' and "EmployeeID"='adm001')
                                    union all
                                    select '2' as id ,insq,'','','','','', bs, stock||' '||name, 0, 0, 0, commission, coalesce(other_fee, 0) as other_fee, case when bs='B' then upper_pay*-1 else upper_pay end as upper_pay, 0
                                    from dfh.v_upper_amt where tdate = '20181001' and market like '%US%') as ddd
                                    where ddd.bs = 'S' order by stock desc, id)


                                     union all 


                                    (select * from 
                                    (select '1' as id,insq,bhno,department, case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20181001', 'B', 'US', 'phli') 
                                    else dfh."sf_hor_get_amt_pay_date"('20181001', 'S', 'US', 'phli') end as payday,
                                    case when bs = 'B' then dfh."sf_hor_get_up_pay_date"('20181001', 'B', 'US', 'phli') 
                                    else dfh."sf_hor_get_up_pay_date"('20181001', 'S', 'US', 'phli') end as up_payday,
                                    '110888' as cseq, bs, (stock || ' ' || name) as stock, price, volume, amt,0 as hk_commission,0 as other_fee, 0 as upper_pay,case when bs='"B"' then total_amt*-1 else total_amt end as total_amt 
                                    from dfh.v_pxmh_amt where tdate = '20181001' and market like '%US%'
                                    and bhno in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' 
                                    and "Enable"='1' and "EmployeeID"='adm001')

                                      union all
                                      select '2' as id ,insq,'','','','','', bs, stock||' '||name, 0, 0, 0, commission, coalesce(other_fee, 0) as other_fee, case when bs='B' then upper_pay*-1 else upper_pay end as upper_pay, 0
                                      from dfh.v_upper_amt where tdate = '20181001' and market like '%US%') as ddd
                                    where ddd.bs = 'B' 
                                      order by stock desc, id  )) as gogo order by gogo.stock desc,gogo.insq, gogo.bs, gogo.id