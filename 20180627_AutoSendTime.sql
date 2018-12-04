ALTER TABLE dfh.tb_market ADD COLUMN autosendtime VARCHAR(30);--依市場自動寄送報表時間
insert into 
--web設定自動寄送時間
--py 早上5:00啟動 讀取DB拿自動寄送時間
--自動寄送時間到了 發送C# ajax URL

/*
1. 檔名: 一個客戶一個檔案，產生在程式路徑下的子路徑 bill
2. 索引檔(產生在程式路徑下的子路徑 main)
3. 密碼檔(產生在程式路徑下的子路徑 pwd)
要測試前，先產生檔案，給我對看看，再放入相關路徑
因為一放進去，就會自動MAIL出


import time, datetime

startTime = datetime.datetime(2016, 6, 8, 16, 45, 0)
print('Program not starting yet...')
while datetime.datetime.now() < startTime:
    time.sleep(1)
print('Program now starts on %s' % startTime)
print('Executing...')

*/
UPDATE dfh.tb_market set autosendtime = '8:00am' where market = 'HK';
UPDATE dfh.tb_market set autosendtime = '8:30am' where market = 'US';
UPDATE dfh.tb_market set autosendtime = '10:00pm' where market = 'HH';
UPDATE dfh.tb_market set autosendtime = '11:00am' where market = 'HZ';