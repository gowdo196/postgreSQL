ALTER TABLE dfh.tb_stock_name ADD COLUMN cname VARCHAR(3000);--商品中文名稱

UPDATE dfh.tb_stock_name set cname = '蘋果咬一口還是蘋果' where stock = 'AAPL';
UPDATE dfh.tb_stock_name set cname = '我大亞馬遜一統江湖' where stock = 'AMZN';
