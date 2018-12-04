--20180917 台中商銀單一代理
WITH RECURSIVE T(sale,agent_sale) AS( 
select sale,agent_sale from dfh.tb_agent_working where sale ='029' 
UNION ALL 
	select T1.sale,T1.agent_sale from dfh.tb_agent_working T1 JOIN T ON T1.sale=T.agent_sale)
    

SELECT agent_sale FROM T GROUP BY agent_sale



--"amode" IS '時效 0=代理排除 1=單一代理';