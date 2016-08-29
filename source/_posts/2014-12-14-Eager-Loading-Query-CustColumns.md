---
layout: post
title: Eager Loading 查詢自訂欄位
categories: articles
tags: [PHP, Laravel]
date: 2014-12-14 23:50
---
這篇是紀錄實作 [9d8TW](http://9d8.tw) 專案時，因對 Laravel 的 Eloquent ORM 不熟悉，所遭遇到問題後，自行找解答的過程。

## 寫在前頭

你可以從這篇文章得到：

+ 一位 Laravel 初心者，找解答的心路歷程！

無法得到：

+ 完整的 Eager Loading 原理！

## 發現問題

在 9d8TW 專案，有兩張資料表，分別是 pulls 和 confides，資料表關係是一對多，其中 confides.pull_id 是 FK ，有一個需求是找出全部資料。

+ 一般版本

其實，這個用一般版就可以搞定，但是~我要用 JSON 丟回結果，不需要給太多欄位。

{% codeblock lang:php %}
// models/Pull.php

class Pull extends Eloquent {

    public function confides() {
        return $this->hasMany('Confide');
    }
}

{% endcodeblock %}

{% codeblock lang:php %}
// controllers/PullController.php

$pulls = Pull::with('confides')
        ->get();

{% endcodeblock %}

+ 錯誤版本

然後~我就做了錯誤版出來，這版結果是 confides 完全沒串到資料，但我確定 DB 是有資料。

{% codeblock lang:php %}
// models/Pull.php

class Pull extends Eloquent {

    public function confides() {
        return $this->hasMany('Confide')
                ->select(array('content'));
    }
}

{% endcodeblock %}

{% codeblock lang:php %}
// controllers/PullController.php

$pulls = Pull::with('confides')
        ->get(array('lat','lng','address'));

{% endcodeblock %}

## 如何解決

+ Dump SQL Script

我試著用 ```dd(DB::getQueryLog())``` 把 SQL Script 抓出來看看，發現和我想的不一樣，它不是用 Join 方式處理。

+ 找出原因 

趕緊到官網找 [Laravel - Eager Loading](http://laravel.com/docs/4.2/eloquent#eager-loading) 文件研究，才知道 Eager Loading 的 ```with``` 拆成兩條查詢，而且~我因為自訂欄位，少給 ```id``` 才會發生在查詢 condfids 時，都傳成 NULL 為參數，導致沒有 confides 資料。  

+ 修改程式

缺 ```id``` 就給 ```id```。
{% codeblock lang:php %}
// models/Pull.php

class Pull extends Eloquent {

    public function confides() {
        return $this->hasMany('Confide')
                    ->select(array('pull_id','content'));
    }
}

{% endcodeblock %}

{% codeblock lang:php %}
// controllers/PullController.php

$pulls = Pull::with('confides')
        ->get(array('id','lat','lng','address'));

{% endcodeblock %}

## 結語

原來~我一直以為是用 Join 在處理，經過這次重新認識 Eager Loading ，看來是自己文件沒讀通，才發生這種烏龍事！ XD

## 參考資料

+ [Laravel - Eager Loading](http://laravel.com/docs/4.2/eloquent#eager-loading)
