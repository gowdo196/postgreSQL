--20180816 非交易
select auto, (case when status = '1' then '已執行' when status = '2' then '已召回' else '未執行' end )as status,ntype,ntname,market,stock,currency,deliver,declaredate,effectivedate
,summary_f,summary_g,summary_h,summary_i,summary_j,summary_k,summary_l,summary_m
                                    from dfh.tb_stock_action 
where effectivedate >= '20180701' and effectivedate <= '20180801'
and ntype like '%%' and market like '%%' and stock like '%%' 

/*select auto, status,ntype,ntname,market,stock,currency,deliver,declaredate,effectivedate,summary_f,summary_g,summary_h,summary_i,summary_j,summary_k,summary_l,summary_m 
from dfh.tb_stock_action where effectivedate >= '20180701' and effectivedate <= '20180819' and ntype like '%01%' and market like '%%' and stock like '%%' 
*/
--亂勾沒關係, 只處理status=0 未執行, 2已召回
--add to tb_stock_buy  & update status=1 tb_stock_action


--del from tb_stock_buy & update status=2 tb_stock_action


        if datas_.ntype = '01' then
            select dfh.sf_notrade_symbole_change(datas_.sn) into temp_;
        end if;
        if datas_.ntype = '02' then
            select dfh.sf_notrade_cash(datas_.sn) into temp_;
        end if;
        if datas_.ntype = '03' then
            select dfh.sf_notrade_stock(datas_.sn) into temp_;
        end if;
        if datas_.ntype = '04' then
            select dfh.sf_notrade_split(datas_.sn) into temp_;
        end if;
        if datas_.ntype = '09' then
            select dfh.sf_notrade_spinoff(datas_.sn) into temp_;
        end if;



select auto, (case when status = '1' then '已執行' when status = '2' then '已召回' else '未執行' end )as status,
ntype,ntname,market,stock,currency,deliver,declaredate,effectivedate,summary_f,summary_g,summary_h,summary_i,summary_j,summary_k,summary_l,summary_m 
from dfh.tb_stock_action where effectivedate >= '20180702' and effectivedate <= '20180801' and ntype like '%%' and market like '%US%' and stock like '%SGAPY%' 