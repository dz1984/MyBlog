---
layout: post
title: TinyMCE 限制部份功能
categories: articles
tags: [Javascript, TinyMCE]
date: 2014-12-09 17:30
---
TinyMCE (Tiny Moxiecode Content Editor) 是一款非常熱門的輕量級的所見即所得編輯器，提供許多佈景主題與面板，以及各種類型的外掛模組，並且支援多語系翻譯套件，更多資訊可參考 [TinyMCE 官方說明文件](http://www.tinymce.com/wiki.php)。

## 寫在前頭
你可以從這篇文章得到：

+ 如何限制編輯器上部份功能。

無法得到：

+ TinyMCE 操作教學。
+ TinyMCE 核心詳解。

## 解法過程

在 [Configuration](http://www.tinymce.com/wiki.php/Configuration) 說明文件發現 ```setup callback``` 能拿到 **TinyMCE.Editor** 物件，從範例中得知，```setup``` 函式是用來設定一些處理編輯器的事件觸發程式碼。

{% codeblock lang:javascript %}
tinymce.init({
  selector: 'textarea',
  setup: function(editor) {
    editor.on('click', function(event) {     
      console.log('Click');
    });
  }
});
{% endcodeblock %}

接著要找出適合事件來處理，這時爬一下文件，可以從 [tinymce.Editer](http://www.tinymce.com/wiki.php/api4:class.tinymce.Editor)　下手，果然~在 **Events** 段落列出編輯器的所有事件，這次目的是要做限制，自然很容易聯想到 **BeforeExecCommand** 事件，只要在執行指令之前擋住不處理即可，看到下面程式碼，當觸發到 **BeforeExecCommand** 時，馬上傳回 false，然後~編輯器就什麼功能也都不能用了！ 

{% codeblock lang:javascript %}
tinymce.init({
  selector: 'textarea',
  setup: function(editor) {
    editor.on('BeforeExecCommand', function(event) {     
      return false;
    });
  }
});
{% endcodeblock %}

基本上，上面那一步驟，已經做到限制功能目標，但若只想做到部份限制，就須加入一些判斷條件來篩選，那開始把焦點移到 [tinymce.CommandEvent](http://www.tinymce.com/wiki.php/api4:class.tinymce.CommandEvent) 身上，看看有什麼可以用的，找到 ```CommandEvent```有三個屬性很可疑，趕緊秀出來看。

{% codeblock lang:javascript %}
tinymce.init({
  selector: 'textarea',
  setup: function(editor) {
    editor.on('BeforeExecCommand', function(event) {
      console.log('Command:'+event.command);
      console.log('Type:' + event.type);
      console.log('Value:' + event.value);
      return false;
    });
  }
});
{% endcodeblock %}

玩一下上面的程式碼後，發現在 Toolbar 按下 **粗體** 和在 ```Format``` 選單按下 **粗體** ，居然會出現不同的 ```command``` 名稱，分別是 ```mceToggleFormat``` 和 ```Bold``` ，還有從選單按下 **粗體** 和用快速鍵(Ctrl+B) ，也會出現不同的 ```value```，分別是 ```undefined``` 和 ```null``` ，從這些差異可以開始加入限制條件，弄一個完全禁用 **粗體**　的編輯器。

{% codeblock lang:javascript %}
tinymce.init({
  selector: 'textarea',
  setup: function(editor) {
    editor.on('BeforeExecCommand', function(event) {
      var isDisable = (event.command === 'Bold') || (event.command === 'mceToggleFormat' && event.value === 'bold');
      if (isDisable) {
        console.log('disable');
        return false;
      }
      return true;
    });
  }
});
{% endcodeblock %}

## 結語
結語還真沒什麼好寫的…

Have Fun! XD

## 參考資料
+ [TinyMCE API 4.x](http://www.tinymce.com/wiki.php/api4:index)
