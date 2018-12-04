select par.pstr,par.pname,par.wparameter from dfh.tb_parameters par
LEFT JOIN dfh.tb_market mkt on mkt.market = par.market
where par.workmode = '2' and mkt.enable = '1' order by pstr;