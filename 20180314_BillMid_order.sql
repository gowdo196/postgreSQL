--20180314
--新買單
select dfh.sf_order_new('apex00001','A123456789','6110','001001','6','00700',10.0,'0000000500','H',
'N','B','E','0','src123','qq', '00','0','HKD');

--001999接著做

	--購買力檢核
	select dfh.sf_lock_money('A123456789','6110','001001','6','HK','00','HKD','J00030',
	'apex00001');
	--購買力檢核結果
	select dfh.sf_lock_money_result('A123456789','6110','001001','6','HK','HKD','BA18C21902170168')

--全部都委託成功
sf_set_pxbs(_bhno varchar, _cseq varchar, _ckno bpchar, _sale bpchar, _insq bpchar, _tdate bpchar, _ttime bpchar, _mtype bpchar, _ecode bpchar, _term bpchar, _desq bpchar, _fflag bpchar, _stock varchar, _price numeric, _pcode bpchar, _rqty int4, _bs bpchar, _

--ini 可以決定要不要成交
sf_set_pxmh(_bhno varchar, _cseq varchar, _ckno bpchar, _sale bpchar, _ttime bpchar, _org_seq bpchar, _tseno bpchar, _mtype bpchar, _ecode bpchar, _term bpchar, _desq bpchar, _dno bpchar, _fflag bpchar, _stock varchar, _price numeric, _tqty int4, _bs bpchar, 


--刪單(先不作)
select dfh.sf_order_change('apex00002', 'A123456789', '6110', '001001', '6',
'J00030', 'Z', '0042', '00700', 100.0, 500, 'H', 'N',
'B', 'E', '0', 'C',  'SSS', '')

--清盤,關帳
--dfh.sf_hor_check_HK_trade


dfh.sf_clean_trade_with_date(tdate varchar, _market varchar)
dfh.sf_clean_meta_with_date(tdate varchar, _market varchar) 
--dfh.sf_clean_data_with_date(_tdate varchar, _market varchar)

--dfh.sf_close_daily 分公司*N
        --模擬分公司關帳,正式主機是用Web關分公司帳
        for bhnos_ in (select bhno from dfh.tb_branch where ap_id <> 0) loop
            select dfh.sf_close_daily(bhnos_.bhno, 'postgres', nowdate_, _market) into temp_;
        end loop;
--dfh.sf_close_daily 總帳
        --模擬關總帳,正式主機是用Web關總帳
        select dfh.sf_close_daily('0000', 'postgres', nowdate_, _market) into temp_;
