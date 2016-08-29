---
layout: post
title: Crawl via Docker
categories: articles
tags: [Docker, eia_crawler]
date: 2014-10-19 21:00
---
## 寫在前頭

近來，想嘗試在 CentOS 7 x86_64 安裝 Scrapy 卻一直受挫，原因是 lxml 無法順利編譯，一些該裝套件（libxml2、libxslt、libxslt-devel 也沒少裝，可以試的方法也都試過，耗了許多寶貴時間，最後，宣告失敗。

根據以往經驗是在 Ubuntu 上安裝，過程簡單且順利，還順便做了 Vagrant File，其實我大可以在繼續用 Vagrant 方式執行爬蟲，但這次我是使用 DigitalOcean 陽春機，記憶體只有 512 MB，實在不想為了爬個資料就建一個笨重 VM，來拖累整體資源，讓人於心不忍呀！

有鑑於此，我改採用輕量級的 **Docker** 來執行爬蟲工作，解題過程如下：

## 安裝 Docker

在 CentOS 7 安裝 Docker 很容易，直接使用 ```yum install``` 即可，值得一提是 CentOS 7 的 firewalld 防火牆與 Docker 會小打架， firewalld 啟動或重新啟動時，會移除 ```DOCKER``` 防火牆設定，所以~啟動或重啟 firewalld 時，記得要在打開 Docker。

{% codeblock lang:bash %}
$ sudo yum install docker
{% endcodeblock %}

## Dockerfile

現在需要一個能跑 Scrapy 的爬蟲環境，既然 Ubuntu 安裝容易，就拿原生 Ubuntu 作為 Image OS，在安裝 Scrapy 以及爬蟲程式，這邊是以 eia_crawler 為例子。 

{% codeblock lang:bash %}
# Dockerfile for eia_crawler project 
 
FROM ubuntu:precise
MAINTAINER Donald Zhan <donald.zhan1984@gmail.com>
 
# Add necessary respnsitory
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 627220E7
RUN echo 'deb http://archive.scrapy.org/ubuntu scrapy main' > /etc/apt/sources.list.d/scrapy.list
 
# Install scrapy
RUN apt-get update -qq  
RUN apt-get -y install scrapy-0.22 git
 
# Clone eia_crawler project
RUN git clone https://github.com/dz1984/eia_crawler.git /home/eia_cralwer
 
# Seting Default Work Directory
WORKDIR /home/eia_cralwer
{% endcodeblock %}

## Docker Container

定義好後，就建立一個 Image，並召喚一個 Docker Container 在背景執行它。另外，要小心地方，是每次執行一個 Container 都會是一個乾淨的 Image 環境，所以~執行結束後，還得想個法子把結果拿回來，這邊是用 Volumn 方式，將檔案 Copy 回來。

{% codeblock lang:bash %}
$ sudo docker build -t eia-crawler .

$ sudo docker run -d -v $(pwd)/data:/data eia-crawler bash -c "scrapy crawl lists && scrapy crawl details && cp -r results/ /data"
{% endcodeblock %}

## 結語

使用 Docker 好處是不用為了爬資料而建立一個 VM，少了開機程序，所耗資源相對少很多，速度明顯變快，難怪 Docker 會如此火紅，有機會在寫一些 Docker 內容。

## 參考資料
+ [Docker](https://www.docker.com)
+ [Installing Docker - CentOS 7](https://docs.docker.com/installation/centos/)