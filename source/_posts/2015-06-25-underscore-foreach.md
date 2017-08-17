---
layout: post
title: 在 Underscore Template 上完成 foreach
categories: articles
tags: [underscore, Memo]
date: 2015-06-25 16:05
---

簡單來說是使用 Subview 方式來解決，原理是逐一產生子樣版內容，然後~拼出完成的主要內容。

細節如下：

* JS 部份

{% codeblock lang:js %}

var data = {land_info:[{k: 'k1', v:'v1'},{k:'k2',v:'v2'}]};
var content_compiled = _.template($('#content-tpl').html());
var content = content_compiled(data);

console.log(content);

{% endcodeblock %}


* 主樣版內容

{% codeblock lang:html %}

<script type="text/template" id="content-tpl">
<table>
 <%=_.reduce(land_info,function(content, land){
   var content_compiled = _.template($('#item-tpl').html());
   var land_content = content_compiled({land:land});
   return content+land_content;
 },"")%>
</table>
</script>

{% endcodeblock %}

* 子樣版內容

{% codeblock lang:html %}

<script type="text/template" id="item-tpl">
    <tr>
        <td><%=land.k%></td>
        <td><%=land.v%></td>
    </tr>
</script>

{% endcodeblock %}
