---
layout: post
title: 重構 9d8.tw 的 JS 
categories: articles
tags: [9d8.tw, Backbone.js]
date: 2015-04-14 23:00
---

![](/images/9d8tw/logo.png)

這篇心得文躺在 Hackpad.com 已經有三個多月，期間斷斷續續地填加內容，使得語句沒辦法一氣呵成，文末也是草率結尾，像是一篇未完待續的殘章，希望有時間能在豐富本文。

# 寫在前頭

<!-- more -->

你可以從這裡面得到：

+ 知道 9d8.tw 是什麼東西。

無法得到：

+ Google API 用法，雖然~這專案依賴於 Google Map API ，像是搜尋、地標、經緯度轉地址等功能，但這不是重構項目，就暫時先略過。

# 揪地霸 (9d8.tw)

9d8.tw 主要功能，是在 Google Map 上顯示出帶有拳頭圖示的「地霸」紀錄，每筆紀錄都保留著每位善男信女，向土地公公傾訴的內心話 ，所以，若是有哪位善男信女想傾訴那位「地霸」不當行徑，只需在地圖上一點，就會開啟真心話留言板，上面會標示著地址，中間則可供傾訴或指證事實，按下儲存後，就可在地圖上看到新的拳頭圖示。

# Mockup 畫面

+ 地圖上面提供 Google 位址搜尋功能，可精準尋找出地霸所侵占之公有地，而地圖標記 "拳頭" 圖示為熱心民眾舉報之紀錄，若在地圖上點選任意一處，就能向土地公傾訴您的心聲！

![](/images/9d8tw/mockup_1.png)

+ 輸入您的心聲給土地公公聽！

![](/images/9d8tw/mockup_2.png)

+ 地圖上會出現剛新增心聲。

![](/images/9d8tw/mockup_3.png)

# 後端 API

9d8.tw 後端僅提供兩個 API 功能：

+ GET /all 是接收前端傳來一個限制範圍的經緯度參數，從資料庫取得此範圍內所有紀錄。
+ GET /add 是將前端傳來內容，新增一筆紀錄至資料庫。

從上述所言，清楚知道 JS 部份，是負責將後端提供功能與地圖作大量互動。

# 前端 JS 重構前

接下來，在進行 JS 解說，直接來看程式碼，有幾個大的項目，像是：

## Google 地圖事件處理器

+ Titles 載入事件

{% codeblock lang:javascript %}
google.maps.event.addListener(map, 'tilesloaded', function(event){    
    var bounds = map.getBounds();
    // load all pull json dataset between this bound and place marker
    placeBoundPullMarker(map,bounds);        
});
{% endcodeblock %}

當 Google Map 有 Title 移動時，意味著地標也要重新整理，從程式碼可以看到先從 google.maps.Map 物件取得現在範圍值，然後~丟到 `placeBoundPullMarker` 函式去，這函式在幹嘛呢？讓我們看下去。

{% codeblock lang:javascript %}
var placeBoundPullMarker = function(map, bounds) {

    $.ajax('pull/all',
        {
            data: {
                'bounds': bounds.toUrlValue()
            },
            dataType: 'JSON',
            success: function(responseJson){
                if (responseJson.status === 'OK') {
                    var pullJsonList = responseJson.pulls;

                    pullJsonList.forEach(function(pullJson){
       
                        var marker = new Pull.Marker(
                            {
                                map: map, 
                                latLng: new google.maps.LatLng(pullJson.lat, pullJson.lng),
                                id: pullJson.id,
                                addr:  pullJson.address,
                                confides: pullJson.confides,               
                            }
                        );

                        marker.addDefaultClickCallback(panel);
                        
                        marker.placeIt(false);
                    });
            } // end success
        }
    }); // end ajax
};
{% endcodeblock %}

`placeBoundPullMarker` 函式主要工作，是從後端 /all API 取得資料後，一筆一筆地包成 Pull.Marker 類別，並加上 Click callback func ，接著在地圖上插上拳頭圖示。

+ 點擊地圖事件

{% codeblock lang:javascript %}
google.maps.event.addListener(map, 'click', function(event) {
    var newPullMarker = new Pull.Marker({map: map, latLng: event.latLng});
    
    panel.open(newPullMarker);
});
{% endcodeblock %}

另外，Click 地圖這個重要事件也要處理，將建立 Pull.Marker 物件，並傳入 Google Map 物件及點擊地圖之經緯度，交由 Pull.Panel 來開啟它。

## Pull Module

有兩個主要 Panel 和 Marker 兩個類別，Panel 是真心話留言板 UI 操作，Marker 是保存每個地標資訊的 Model。

[重構前 - 程式碼](https://github.com/dz1984/9d8TW/blob/a786511a545da99796fabf189ae1d0340e35c0cd/public/js/pull.js)

+ Marker 類別

屬性一覽：

```
map - google.maps.Map 物件
latLng - 地標的經緯度
id - 編號
addr - 地標地址
content - 傾訴內容
marker - google.maps.Marker 物件
condifes - 所有傾訴內容列表
clickCallback - Click callback 函式列表
```

從程式碼，可以看出來有大量的 getter/setter 函式，只有兩個 method  較為有作用， getAddress() 是透過 Google Geo 工具負責將經緯度轉成可讀性高的地址，並保留成屬性；而 placeIt() 則是在地圖上插入一地標，並加入 Click callback，有看到上面 DefaultCallback 中的  `panel.open(this);` ，是將 Marker 物件傳至 Panel 裡，當地標被點擊時，會開啟真心話留言板。

+ Panel 類別

建構式充滿好多 jqXXXX 的東西，說穿這類別，其實是處理 UI 部份的工作，先看 `open` 函式，可看到 Panel 會先把 Marker 物件的屬性，偷偷放到自己的 Web Container 裡作初始化動作，所以~當真心話留言板一打開，就能看到之前的匿名留言內容。
 
 真心話留言板打開後，便等待 儲存 和 取消 兩個按鈕事件釋發，若按下 取消，就呼叫 Panel 的 reset() ，並隱藏起來；若是 儲存，就會利用 Ajax 方式，呼叫 /add API 寫入資料庫，並將新增地標顯示在地圖上。

 Panel 類別非常混亂，一下要處理邏輯，一下又要處理 UI 內容。

 > 總之，9d8.tw 只需要 Model 和 View 就能搞定前端工作。

# 前端 JS 重構後

[重構後 - 程式碼](https://github.com/dz1984/9d8TW/blob/4901ba1b3c4e36daadb73b884c77c2a2e0a76e22/public/js/pull.js)

挑選一個老牌子的 JS Library - BackboneJS 來重構 Pull Module 的兩個類別，順便一提，我把 Marker 名稱改成 Fist (拳頭)，這名字更貼切地霸風格。

重構後，可以看到 Pull 是繼承 Backbone.View ，而 Fist 繼承 Backbone.Model ，在邏輯上沒有任何改變，但寫法上較直覺，且容易維護，少了很多冗餘的程式碼，原本用 jqXXXX 方式，初始化 Web Element 內容，現在~是用 template 方式。