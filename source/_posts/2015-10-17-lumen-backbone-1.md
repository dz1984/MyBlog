---
layout: post
title: Lumen + Backbone.js (一)
categories: articles
tags: [PHP, Lumen, Backbone.js]
date: 2015-10-17 08:00
---

這篇殘文擺在 Hackpad.com 很久，快有六個月了！ 都到現還沒完成，暫且先放上一部份 (後端)，記錄 Lumen 剛釋出時，自己動手踹踹看的心得，由 Lumen 處理後端東西，前端呢？ 還是交給最愛的 Backbone 。 

# 寫在前頭

你可以從這裡面得到：

+ Lumen 與 Backbone 搭配的陽春起手式。

無法得到：

+  Lumen 完整介紹及操作。

# Lumen

Lumen 是從 Laravel 切割出來的 micro-framework，並非用來取代 Laravel，基本上 Lumen 有很多元件仍來自於 Lavavel，主要適用於 Micro Service 和 RESTFul API ，最大賣點是速度。

補充 Taylor Otwell 有一段測試影片：

<iframe width="420" height="315" src="https://www.youtube.com/embed/WqRpa_5m7h4" frameborder="0" allowfullscreen></iframe>

測試結果是…

```
Silex: 950 requests per second
Slim: 1250 requests per second
Lumen: 1700 requests per second
```

# 動手實作

+ lumen 安裝工具 

{% codeblock lang:bash %}
composer global require "laravel/lumen-installer=~1.0"
{% endcodeblock %}

+ 建立新的專案

{% codeblock lang:bash %}
lumen new booklib
{% endcodeblock %}

+ 環境設定檔，設定 DB 帳密

{% codeblock lang:bash %}
cp .env.example .env
{% endcodeblock %}

+ 移除 bootstrap/app.php 的註解

{% codeblock lang:php %} 
Dotenv::load(__DIR__.'/../');
$app->withFacades();

$app->withEloquent();
{% endcodeblock %}

+ 啟動 server

{% codeblock lang:bash %}
php artisan serve
{% endcodeblock %}

+ 建立 Database

{% codeblock lang:bash %}
php artisan make database
{% endcodeblock %}

+ 加入 database 至 classmap，並更新 composer.json 。

{% codeblock lang:javascript %}
...
"classmap": [
    "database/"
]
...
{% endcodeblock %}

{% codeblock lang:bash %}
composer dump-autoload
{% endcodeblock %}

+ 建立 Books Table

{% codeblock lang:bash %}
php artisan make:migration create_books_table --create=books
{% endcodeblock %}

+ 增加 Books Table 欄位

{% codeblock lang:php %}
$table->increments('id');
$table->string('coverImage');
$table->string('title');
$table->string('author');
$table->string('releaseDate');
{% endcodeblock %}

+ migrate

{% codeblock lang:bash %}
php artisan migrate
{% endcodeblock %}

+ 在 app 資料夾下，新增 Book Model 檔案

{% codeblock lang:php %}

<?php namespace App;
use Illuminate\Database\Eloquent\Model;

class Book extends Model {


}
{% endcodeblock %}

# 後台 RESTFul API

+ 建立 resource 資料夾

{% codeblock lang:bash %}
php artisan make resources
{% endcodeblock %}

+ 在 resources\views 資料夾，加入 index.blade.php 檔案。

PHP 基本上是不大產生頁面內容，而把大部份的工作都交給 JS 處理，最主要是這一段：

{% codeblock lang:html %}
<div id="books">
    <form id="addBook" action="#">
        <div>
            <label for="coverImage">封面圖檔: </label>
            <input id="coverImage" type="file" />
            <label for="title">書名: </label>
            <input id="title" type="text" />
            <label for="author">作者: </label>
            <input id="author" type="text" />
            <label for="releaseDate">出版日期: </label>
            <input id="releaseDate" type="text" />
            <label for="keywords">關鍵字: </label>
            <input id="keywords" type="text" />
            <button id="add">增加</button>
        </div>
    </form>
</div>
{% endcodeblock %}

+ app\Http\routes.php

接下來是 Book Model 的 CRUD 時間。

{% codeblock lang:php %}
$app->get('books', function() 
{
    $books = Book::all();

    return response()->json($books);
});

$app->get('books/{id}', function($id)
{
    $book = Book::find($id);

    return response()->json($book);
});

$app->post('books', function() 
{
    $target_path = 'upload/images/';
    $book = new Book;
    // TODO : move the upload file to images folder
    $file_name = md5(rand());

    if (Request::hasFile('coverImage')) {
        $upload_file = Request::file('coverImage');
        $ext_file_name = $upload_file->getClientOriginalExtension();
        $file_name = "$file_name.$ext_file_name" ;

        $upload_file->move($target_path,$file_name);
    }
    $book->coverImage = $target_path.$file_name;
    $book->title = Request::input('title');
    $book->author = Request::input('author');
    $book->releaseDate = Request::input('releaseDate');

    $book->save();

    return response()->json($book);
});

$app->put('books/{id}', function($id)
{
    $book = Book::find($id);

    $book->title = Request::input('title');
    $book->author = Request::input('author');
    $book->releaseDate = Request::input('releaseDate');

    $book->save();

    return response()->json($book);
});

$app->delete('books/{id}', function($id)
{
    $book = Book::find($id);

    $book->delete();

    return '';
});
{% endcodeblock %}

下一篇將會介紹 Backbone 的部份。
