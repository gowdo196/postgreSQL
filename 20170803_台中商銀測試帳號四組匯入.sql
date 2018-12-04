insert into dfhf.tb_customer_attribute (bhno, cseq, fbhno, amode, att, cuser) values ('6114','2600065','823','01','N123202120','ALevo');
insert into dfhf.tb_customer_attribute (bhno, cseq, fbhno, amode, att, cuser) values ('6115','8271320','824','01','P222577023','ALevo');
insert into dfhf.tb_customer_attribute (bhno, cseq, fbhno, amode, att, cuser) values ('6110','8220575','822','01','N222252217','ALevo');
insert into dfhf.tb_customer_attribute (bhno, cseq, fbhno, amode, att, cuser) values ('6110','8220724','822','01','P221074738','ALevo');



select dfhf.sf_import_customerinfo('2600065', '823', '陳泰安', '205', '6114', '1', 'N', 'N', 5678, 5678, 6666, 6666, '0926111111');
select dfhf.sf_import_customerinfo('8271320', '824', '王秀麗', '524', '6115', '1', 'N', 'N', 77, 77, 0, 0, '0926222222');
select dfhf.sf_import_customerinfo('8220724', '822', '黃玉全', '015', '6110', '1', 'N', 'N', 5, 5, 0, 0, '0912987654');
select dfhf.sf_import_customerinfo('8220575', '822', '吳富美', '036', '6110', '1', 'N', 'N', 8, 8, 0, 0, '0912345876');
