---
layout: post
title: Google APIs via NodeJS
categories: articles
tags: [Javascript, NodeJS, Google API, Fusion Table, GeoJSON, 天龍特公地]
date: 2014-10-16 11:00
---

## 寫在前頭

之前，實作 **天龍特公地** 專案時，接觸到 Google API 連到 Fusion Tables 的經驗，這篇隨手筆記存放有點久，現在才拿出來當 Blog 的新文章。 XD

想想 Fusion Tables 挺適合在小專案，但如果專案開始長大，就顯得有點不足，故 **天龍特公地** 即將以 PostgreSQL 為 DB，以應付越來越多擴展性功能。

## Google APIs

**建立專案**

先到 [Google Developers Console](https://console.developers.google.com/project) 建立新專案。 

![](http://i.imgur.com/10GICZK.png)

**開啟 API**

啟動想使用的 API  ，這邊以 [Google Fusion Tables APIs ](https://developers.google.com/fusiontables/?csw=1) 為例子。

![](http://i.imgur.com/T94oPB4.png)


**產生憑證**

這邊是以 **瀏覽器金鑰** 為例子。

*   按下 **建立新的金鑰 **按鈕後**，**在選擇按下** 瀏覽器金鑰  **按鈕。

![](http://i.imgur.com/Im8jyvv.png)

*   可以不填寫中介網址，按下 **建立** 按鈕，即會產生一組  **API 金鑰。**  

![](http://i.imgur.com/INetjjp.png)

*   記住這組金鑰，等等會用到。

![](http://i.imgur.com/nUz4SFO.png)

**如何練習 Google APIs？**

Google APIs  琳瑯滿目，常常不知道要怎麼用，又懶得爬文，沒關係！ Google 很搭心，可以直接用  [APIs Expoloer](https://developers.google.com/apis-explorer/) 把玩每個 APIs ， Try 遍每個 APis 提供的 Method。

## Fusion Table

**新增 Fusion Table**

*   Google Drive 連結 Fusion Table 。

![](http://i.imgur.com/KGHjSDN.png)

![](http://i.imgur.com/AVizYpP.png)

*   在 Google Drive 建立 **空白 Fusion Table** 。

![](http://i.imgur.com/DrjIeLC.png)

**設定存取權限**

*   將權限設定成 **Public **。 ( Fusion Table API 無法操作 Private 權限) 

![](http://i.imgur.com/G2L3KK6.png)


**取得 Table ID**

*      按下 **File** -> **About this table** ，取得 **Table ID**， 當然也可以從 URL 得知 ( docid 後面一大串東西)。

![](http://i.imgur.com/KykU7qS.png)


## NodeJS

**專為 NodeJS 打造的 Google APIs  Client**

可以參考  [Google/google-api-nodejs-client](https://github.com/google/google-api-nodejs-client/) ，裡面有很完整的安裝說明及[範例](https://github.com/google/google-api-nodejs-client/tree/master/examples)。

**小踹  Fusion Tables Query**

目的只能先 Try sql 語法，還不用動真格寫扣，可以利用 APIs Exploer 平台的 [fusiontables.query.sql](https://developers.google.com/apis-explorer/#p/fusiontables/v1/fusiontables.query.sql) 來踹踹看。

*   直接就丟 SQL Script： `SELECT * FROM YOUR_TABLE_ID`  ，接著就  **Execute **。 ( 記得把_ YOUR_TABLE_ID_ 替換成你剛剛準備的新 Fusion Table ID )

![](http://i.imgur.com/U6CJu35.png)


*   執行後，可以看到花費時間、Request ，以及  Response 結果，別得不管了！ 只要看到 **rows** 關鍵字，這裡面的東西才是我們要，另外，在看看 **query?** 後面一拖拉庫的東西，用了 _sql _和 _key_ 兩個參數，這是不是在告訴我們一件事，執行 API 時，記得下參數。

![](http://i.imgur.com/qxJ0AhU.png)


**動手踹 <s>共 </s>扣**

看完 [Google/google-api-nodejs-client](https://github.com/google/google-api-nodejs-client/) 的[ README.md ](https://github.com/google/google-api-nodejs-client/blob/master/README.md)，就可以抓到這工具大致用法，那就寫扣去…

{% codeblock lang:javascript %}
var google = require('googleapis');
var fusiontables = google.fusiontables('v1');
 // 從上面步驟得知 YOUR_API_KEY 和 YOUR_TABLE_ID 
var API_KEY = 'YOUR_API_KEY';
var TABLEID = 'YOUR_TABLE_ID';
var SQLSCRIPT = 'SELECT * FROM ' + TABLEID;
var params = {
        'sql': query,
        'key': API_KEY
};
fusiontables.query.sqlGet(params, function(err, result) {
    if (err) {
        console.log(err);
   }
   
   var rows = result.rows;
   
   console.log('ok');  
});
{% endcodeblock %}      
