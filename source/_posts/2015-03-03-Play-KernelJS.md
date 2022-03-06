---
layout: post
title: 初探 Kernel.js 記
categories: articles
tags: [Javascript, Kernel.js]
date: 2015-03-03 18:00
---
Nicholas Zakas 大神提出 Scalable Javascript architecutre 後，經由 Addy Osmani 大神不斷地推廣，對這架構非常著迷，所以~找了一些實作此架構的 JS ，一不小心就發現了 Kernel.js ，覺得它輕巧易懂，故寫一篇紀錄自己把玩 Kernel.js 過程。

## 寫在前頭

<!-- more -->

你可以從這篇文章得到：

+ Kernel.js 簡介。

無法得到：

+ 完整的 Scalable Javascript architecutre 原理。(建議可爬 Nicholas Zakas 和 Addy Osmani 兩位大神的文章)

## 簡介

[Kernel.js](http://alanlindsay.me/kerneljs/) 是受到  Nicholas Zakas 大神在 scalable Javascript architecutre 演講中得到啟發，用來打造可擴展性的 Javascript 應用輕量化架構(大約 4k)，提供消息系統能讓你解耦合(decouple)及彈性方式建置程式。

Kernel.js 並不是框架或是像 YUI 、Dojo 之類的 Library，而是用來連結框架的架構基礎。 Kernel.js 沒有像 underscore.js 提供底層的公用函式，也沒有像 jQuery 提供任何處理 DOM 工具，更沒有像 ExtJS 提供任何 widget。你會需要 Kernel.js 和其他 libraries (base library, widget library 等)，去建置一個複雜的網站應用程式。

### 主要構成元素

+ Base Library

隨意的使用基本程式庫(像是 jQuery 或 YUI ) 可處理瀏覽器規範和 ajax。

+ Kernel

抽象化 Base Library，管理物件生命週期。

+ Hub

其實 Hub 就是 message Bus ，協助 Module 之間訊息傳遞 ，可自行擴充 Hub  API。

+ Module

可以將商業邏輯分門別類放至 Module ，且 Module 之間不直接溝通，呈現低耦合 (lossely couple)。

![kernel architecture](http://i.imgur.com/w0t5trZ.png)

Addy Osmani 在解釋 Scalable Javascript architecutre 架構時，提出一個飛機與空中交通管制中心的例子，飛機之間是沒有直接介面，他們都是透過空中交通管制中心，決定起飛和降落。Hub 就像空中交通管制中心，而 Modules 就像飛機。

## 自己動手做範例

假設想紀錄每次按下按鈕次數，且可手動決定要不要要產生 Log 紀錄，當然~你大可以利用 if-else 方式，把邏輯塞在一起，但若是複雜度增加時，程式碼會出現一大串的 if-else 區塊，故將重復使用邏輯皆模組化，並練習操作 Kernel.js 試著完成這個範例。

定義三個獨立模組，分別是 Counter 、Status，以及 Log 。

### 三個模組功能

+ Counter 模組

顯示累積每次按下按鈕的次數。

+ Status 模組

接受狀態異動事件。

+ Log 模組

在 console 下顯示狀態紀錄。

### 運作原理

一開始 Status 模組會等待點擊按鈕的事件被觸發，當收到觸發事件後，會透過 Hub 發佈訊息。

這三個模組皆有 Listen 著 'status-update' 事件，所以~當  Hub 發佈 'status-update' 訊息時，各模組就會執行自己本分工作，另外~ Hub 會偷偷呼叫 updateLog 來開關 Log 模組， 若 Log 模組被停止，就不會和系統發生作用，直到 Log 模組又重新被啟動。


### 程式碼

+ [JSBin - Example](http://jsbin.com/sugoma/)
+ [Gist](https://gist.github.com/dz1984/8de2ad277205383280fe)



## 結語

模組的好處，是可以將領域邏輯劃分清楚，每一個模組獨自負責自己任務，僅透過 Hub 來傳遞所需訊息，各模組之間不會發生打架情形，甚至不知道對方的存在，完全符合單一責任原則 (SRP) ，也可提高可重復用性。
 
最後~引用心目中大神的話。

    In a well-modularized program each module should be about one topic, so I can remain ignorant of anything I don't need to understand.  - Martin Fowler
    
## 參考資料

+ [Nicholas Zakas - Scalable JavaScript Application Architecture](http://www.slideshare.net/nzakas/scalable-javascript-application-architecture)
+ [Addy Osmani - Future-proofing Your JavaScript Applications For Improved Scalability](http://addyosmani.com/futureproofjs/)
+ [Kernel.js](http://alanlindsay.me/kerneljs/)
+ [Refactoring code that accesses external services](http://martinfowler.com/articles/refactoring-external-service.html)
