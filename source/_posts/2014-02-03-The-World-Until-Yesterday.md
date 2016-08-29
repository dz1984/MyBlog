---
layout: post
title: 昨日世界：找回文明新命脈
categories: articles
tags: [book,Python,統計]
image:
  feature: texture-feature-01.jpg
---
戴蒙大叔繼「槍炮、病菌與鋼鐵」及「大崩壞」之後，又出新作「昨日世界」。

或許這本書太過沉重，導致鮮少有人走去翻閱，一邊看書一邊偷偷觀察，發現平均每1.5小時，會有一位路人甲翻閱(真正拿起來用心欣賞)，在一定時間內，發生讀者翻閱的可能性，心中浮現泊松分配定理。

泊松分配即X在一段期間或空間事件發生次數，且事件發生滿足泊松隨機實驗特性。

泊松隨機實驗之四個特性：

1. 在一連續區間與另一區間發生事件個數是獨立的。
2. 連續區間發生事件的期望值與區間大小成比例。
3. 在很短的區間內會發生1個或0個事件。
4. 隨機變數X定義為一段連續區間內事件發生次數。

分配公式：
$$f(x)=\frac{\lambda\^xe^{-\lambda}}{x!} x=0,1,2,...,\infty$$

{% codeblock lang:python %}
# Poisson distribution
f = lambda la,x: ((la**x)*(math.exp(1)**(-la)))/math.factorial(x);

# 平均每1.5小時就有一人
f(8.0,3) # 0.02862614424768102
{% endcodeblock %}
