SELECT
	B.bhname,
	C.cseq,
	D.name AS cName,
	E.name AS sName,
	F.name as salesName,
	A.*
FROM
	(SELECT * FROM dfh.hor_wrong_account where sn='3') AS A
LEFT JOIN (
	SELECT
		bhno,
		bhname
	FROM
		dfh.tb_branch
) AS B ON A .bhno = B.bhno
LEFT JOIN (
	SELECT
		insq,
		cseq
	FROM
		dfh.v_real_volume
) AS C ON A .insq = C .insq
LEFT JOIN (SELECT * FROM dfh.tb_customerinfo) AS D ON D.cesq = substr(C .cseq, 1, 6)
LEFT JOIN (
	SELECT
		*
	FROM
		dfh.v_tb_stock_name
) AS E ON A.stock = E.stock
LEFT JOIN (SELECT * FROM dfh.tb_salseinfo) AS F ON A .tlno = F.tlno


SELECT * FROM dfh.sf_hor_wa_duty('3', '1', 'null', '2', '20181127', 'adm001')

delete from dfh.tb_customer_attribute where cseq in ('200486','705518','004213')