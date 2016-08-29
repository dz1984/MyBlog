---
layout: post
title: 天龍特公地製作過程
categories: articles
tags: [GeoJSON, 公有地大行動, Google Maps API]
date: 2014-08-03 18:30
---
[天龍特公地](http://g0v.github.io/POPonFire/)是[公有地大行動](http://hackfoldr.org/POPonFire/)的子項目之一，主要是因為獲得一份野生並帶點神秘色彩資料，裡面記載臺北市區全部公有可建築空地，其資料是如此無比珍貴，卻因為是```CSV```格式，難以讓人閱讀，就萌生做成 Web 版，提供大家方便使用，正是此計畫用意。

### Google Maps API

在 2014 年三月多，Google Maps API (v3) 開始支援 GeoJSON 功能<sup>[1](#footer01)</sup>，方便在 Google 地圖存取 GeoJSON 資料，[GeoJSON]() 是目前火紅地理資訊的開放標準資料格式，官方定義：

>GeoJSON is a format for encoding a variety of geographic data structures. A GeoJSON object may represent a geometry, a feature, or a collection of features. GeoJSON supports the following geometry types: Point, LineString, Polygon, MultiPoint, MultiLineString, MultiPolygon, and GeometryCollection. Features in GeoJSON contain a geometry object and additional properties, and a feature collection represents a list of features.

先來研究Google Maps API 提供範例：

{% codeblock lang:javascript %}
var map;
function initialize() {
  // Create a simple map.
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 4,
    center: {lat: -28, lng: 137.883}
  });

  // Load a GeoJSON from the same server as our demo.
  map.data.loadGeoJson('https://storage.googleapis.com/maps-devrel/google.json');
}

google.maps.event.addDomListener(window, 'load', initialize);
{% endcodeblock %}

弄一張地圖出來，把GeoJSON餵給它，就完成了！ *(謎之音：啥！就這麼簡單…)*

既然，Google Maps API 在套 GeoJSON 那麼方便，那就直接實作吧！

### 準備動作

+ GeoJSON

GeoJSON 從那裡來？ 首先，要感謝 [@runnywang](https://github.com/ronnywang) 把零時資料中心的[神秘資料](http://data.g0v.tw/dataset/70)轉成GeoJSON<sup>[2](#footer02)</sup> ，然後，我又弄了一個 API ，如下所示： 

```
/api/taipei/:area

area - 北市各區名。 Ex: 中山區
```

專門吐臺北市各區 GeoJSON 資料，有了這些後，基本上，我可以無痛地，隨便將一個區 GeoJSON 打在地圖上。

+ Google Maps

為了讓地圖更好看，所以~決定加點顏色，現在來看看 Google Maps API 上，另一個範例：

{% codeblock lang:javascript %}
var map;
function initialize() {
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 4,
    center: {lat: -28, lng: 137.883}
  });

  // Load GeoJSON.
  map.data.loadGeoJson('https://storage.googleapis.com/maps-devrel/google.json');

  // Set the stroke width, and fill color for each polygon
  var featureStyle = {
    fillColor: 'green',
    strokeWeight: 1
  }
  map.data.setStyle(featureStyle);
}

google.maps.event.addDomListener(window, 'load', initialize);
{% endcodeblock %}

跟上一個範例的程式碼差不多，不過~這次多設定 ```featureStyle``` ，這個多邊形瞬間多了一道顏色。
接著，我又想讓使用者，按下多邊形後，會出現這塊公有地資訊，所以~我又找了一個處理事件的範例來看。

{% codeblock lang:javascript %}
var map;
function initialize() {
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    zoom: 4,
    center: {lat: -28, lng: 137.883}
  });

  // Load GeoJSON.
  map.data.loadGeoJson('https://storage.googleapis.com/maps-devrel/google.json');

  // Add some style.
  map.data.setStyle(function(feature) {
    return /** @type {google.maps.Data.StyleOptions} */({
      fillColor: feature.getProperty('color'),
      strokeWeight: 1
    });
  });

  // Set mouseover event for each feature.
  map.data.addListener('mouseover', function(event) {
    document.getElementById('info-box').textContent =
        event.feature.getProperty('letter');
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
{% endcodeblock %}

### 開始拼裝

進入拼裝程序，[部份程式碼](http://bit.ly/UTJm6k)是將上面那些東西全部串起來結果，其流程是接收到一個臺北市區名，就向 API 要這區的 GeoJSON 資料，取得後就利用 Google Maps API 載入 GeoJSON，並顯示以該區為中心的地圖，在幫各個多邊形加點顏色及事件處理，好讓使用者按下去時，就能出現資訊。若完整程式碼有興趣，歡迎到 [CodePen](http://codepen.io/dz1984/pen/zLgjr/) 上，就能看全部東西。

### 結語

你/妳知道嗎？我們台灣的公有土地總量逐年下降，即私有化，以及許多公有土地開發的公共監理機制未盡完備，而淪為地產炒作標的，故公有地大行動的出發點，是**公有土地資訊，全民都有知的權利**，希望能藉由這個子計畫項目，可以喚起公民對公有地的認知。

>請大家一起來關注屬於你、我、他、她，大家所擁有的土地。

最後，[天龍特公地](http://g0v.github.io/POPonFire/)這份成果為[公有地大行動](http://hackfoldr.org/POPonFire/)團隊共同享有。

#### 參考資料

+ [GeoJSON](http://geojson.org)
+ [Data layer: Loading GeoJSON](https://developers.google.com/maps/documentation/javascript/examples/layer-data-simple?hl=zh-tw)
+ [Data layer: Styling](https://developers.google.com/maps/documentation/javascript/examples/layer-data-style?hl=zh-tw)
+ [Data layer: Event Handling](https://developers.google.com/maps/documentation/javascript/examples/layer-data-event?hl=zh-tw)

#### 備註

1. <a name='footer01'></a> [Google Geo Developers Blog - Maps made easier: GeoJSON in the JavaScript Maps API](http://bit.ly/1pPVFsU)
2. <a name='footer02'></a> [g0v-data/POP-data](http://bit.ly/1maOdY9)