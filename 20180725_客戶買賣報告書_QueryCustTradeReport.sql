--20180725 客戶買賣報告書 QueryCustTradeReport
--SQLstring + QueryCustTradeReport_all

select tdate, 
            case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20180608', 'B', '', 'phli') else dfh."sf_hor_get_amt_pay_date"('20180608', 'S', '', 'phli') end as payday,
            market, (case when bs = 'B' then '普買' else '普賣' end) as bs, (stock || ' ' ||name) as stock,
            price, currency, volume, amt, commission, coalesce(other_fee, 0) as other_fee, 
            Coalesce((case when bs = 'B' then total_amt else 0 end),0) as receive, Coalesce((case when bs = 'S' then total_amt*-1 else 0 end),0) as payment
            from dfh.v_pxmh_amt
            where bhno like '%%' and "substring"(cseq,1,6) like '%%' and department like '%%' and market in(select market from dfh.tb_market)  and bhno in 
	            (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001')


select tdate, 
            case when bs = 'B' then dfh."sf_hor_get_amt_pay_date"('20180608', 'B', '', 'phli') else dfh."sf_hor_get_amt_pay_date"('20180608', 'S', '', 'phli') end as payday,
            market, (case when bs = 'B' then '普買' else '普賣' end) as bs, (stock || ' ' ||name) as stock,
            price, currency, volume, amt, commission, coalesce(other_fee, 0) as other_fee, 
            Coalesce((case when bs = 'B' then total_amt else 0 end),0) as receive, Coalesce((case when bs = 'S' then total_amt*-1 else 0 end),0) as payment
            from dfh.v_pxmh_amt
            where tdate = '20180608' and bhno like '%1260%' and "substring"(cseq,1,6) like '%000088%' and department like '%%' and market = '' and bhno in 
	            (select "BranchNo" from dfh."EmployeeDepartment" where "DepartmentID"=' ' and "Enable"='1' and "EmployeeID"='adm001')