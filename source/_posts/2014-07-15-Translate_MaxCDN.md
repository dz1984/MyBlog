---
layout: post
title: 超譯MaxCDN的分析平台
categories: articles
tags: [Translate, Memo]
date: 2014-07-15 17:35
---

這篇是以 MaxCDN 的[分析平台](http://blog.maxcdn.com/maxcdn-analytics-platform-debug-automate-like-boss/)為例，這平台每天大約會產生 8TB 多的 Log 原始資料，在尖峰時伺服器更是要承受每秒 200,000 個 Requset，在這樣持續成長下，將會面臨到一波波難題要克服，故必須要完成：

+ 處理目前及未來增加流量
+ 處理非結構性的Request資料
+ 降低冗餘硬體設備規模
+ 減少軟體層
+ 讓客戶直接查詢

<!-- more -->

MaxCDN 工程師打算重新建置報表及分析平台，提供更多資訊給客戶做決策，像是強大API提供客戶存取 Log 資料，以及給非開發人員使用的 [Log Viewer](https://cp.maxcdn.com/reporting/logs) 。因為這樣特別的需求，MaxCDN 工程團隊使用夢幻工具打造出一個全新的報表環境(reporting stack)，其平台是以[MongoDB](http://www.mongodb.com/)強化版的 [TokuMX](http://www.tokutek.com/products/tokumx-for-mongodb/) 為基礎，比起 MongoDB 還更快速。

為了更快速塞資料到 TokuMX ，就特別用Go寫成的代理人，Go 比起傳統語言在平行處理策略中，像是C++、Java等，能充分發揮出多核 CPUs 能力，寫出極速的應用程式。


下面將進入重頭戲，要開始講點技術了！

  ![img](http://i.imgur.com/dQ3Wjmd.jpg)

  為了防止發生任何故障，MaxCDN 多提供訊息層這一道防線，選擇使用輕鬆跟上傳入資料速度的 [Redis](http://redis.io/) ，來橋接 CDN 和資料庫叢集(database cluster)之間大量訊息佇例。

在 API 層，需要開發處理龐大的併發(concurrency)報表請求及好維護平台，故選用超火紅以 [Node.js](http://nodejs.org/) 寫成的  [Expresss 框架](http://expressjs.com/) ，利用 Node.js 和 Express 組合為基礎，能輕鬆增加 API 功能，像是大量的正則表達式比對查詢請求。


確保高品質備援和靈活性，在達拉斯數據中心設有20個分散點，提供異地備援報表和分析叢集，每台資料庫伺服器都是使用RAID10設定、SSD硬碟、記憶體提高到 128G 。

![img](http://i.imgur.com/Ly6gv6M.jpg)


每當有請求(request)進來時，就直接放到訊息佇列處理，馬上記錄每筆請求並保存5天，最精華部份是資料會依照公司規模做排序,之後，預計能提供即時綜合統計給需求客戶。為了符合 MongoDB 規模設計，儲存層可依資料成長量做水平擴充，近來測試結果，現在硬體架構可承受每秒 600,000 即時事件請求。

此解法最大問題是如何有效率接收每秒 200,000 請求及即時儲存，使用 Go 建置可擴充模型， 採用多核CPU搭配 64GB 記憶體優勢，快速處理 TokuMX/MongoDB 之間儲存，比原本設計是每秒處理 200,000 請求之目標，表現得更為.出色。

(以下省略不譯)

# 資料來源
  
+ [HOW WE BUILT OUR REAL-TIME ANALYTICS PLATFORM](http://blog.maxcdn.com/learned-stop-worrying-love-logs/)
