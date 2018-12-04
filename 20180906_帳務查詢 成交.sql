select hct.insq, cp.term||cp.desq as apexcode,hct.tdate,hct.bs,hct.stock,hct.price,hct.stock,hct.price,hct.volume,hct.amode,hct.cuser ,to_char(hct.last_update,'YYYY/MM/DD HH24:mi:ss') as last_update
                        from dfh.hor_check_trade hct
LEFT JOIN dfh.cs_pxbs_history cp on hct.insq = cp.insq and hct.tdate = cp.tdate
where hct.tdate = '20180904' and hct.amode = '4' and hct.volume>0 and cp.cdi = 'O'

select sum(bb.amt) from (
select tdate,bhno, amt, abs(coalesce(hk_commission,0)) as hk_commission, coalesce(other_fee, 0) as other_fee, --sd."Name"||'('||am.department||')'  as department,
	        coalesce(case when bs = 'B' then (amt+abs(hk_commission)+other_fee) * -1 else amt-abs(hk_commission)-other_fee end, 0) as up_amt,(case when bs = 'S' then total_amt*-1 else 0 end) as payment,
	        commission, total_amt, (commission-abs(coalesce(hk_commission,0))) as income
	        from dfh.v_pxmh_amt am 
		        /*left join dfh."sfGetSalesList"('201809','201809') si on am.bhno=si.branch and am.sale=si.sale
		        left join dfh."sfGetDepartmentList"('201809','201809') sd on am.bhno=sd."BranchNo" and am.department=sd."DepartmentID"*/
	        where tdate like '201809%' and bhno like '%1260%' and market like '%HK%'
            --and bhno in (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001') and am.department in ('') */
--order by bhno, am.cseq, amt
order by tdate
) bb




select sum(commission) as commission, sum(other_fee) as other_fee, 
sum(upper_pay) as upper_pay,bs
                                    from dfh.v_upper_amt
                                    where tdate like '201809%' and market='HK'
                                    GROUP BY bs