"use strict";

// Код, реализующий ajax функционал на странице "новости"

var fNewsBindHistoryAdapter;
var fNewsdoAjaxRequest;
var fNewsProccessPaginateLinks;
var fNewsStartWillPaginateAjax;
var fNewsProcessBlocks; // при клике по preview-картинке новости будет происходить переход на просмотр новости

$(function () {
   if ($('.news_block[data-is_render_paginator="true"]').length) {

       fNewsBindHistoryAdapter = function () {
           History.Adapter.bind(window,'statechange',function(){ // Note: We are using statechange instead of popstate

               // Log the State
               var State = History.getState(); // Note: We are using History.getState() instead of event.state
               var p;

               //History.log('statechange:', State.data, State.title, State.url);
               if (State.title == "") {
                   p = 1;
               } else {
                   p = State.data.page;
               }

               fNewsdoAjaxRequest(p);
           });
       };

       fNewsdoAjaxRequest = function (page/*integer*/,callback/*function*/) {

           var $ajax_div = $('.ajax_div'); // к этому контейнеру изначально прикреплены кое-какие данные
           
           $.ajax({
               url: "/news_guru",
               type: "POST",
               data: {
                   page: page,
                   is_render_paginator: $ajax_div.data('is_render_paginator'),  // эти переменные
                   partial_name: $ajax_div.data('partial_name'),                // уходят транзитом
                   css_class_news_block: $ajax_div.data('css_class_news_block') // на render_news_block
               },
               dataType: "script"
           }).done(callback);
       };

       fNewsProccessPaginateLinks = function () {
           //console.log("fNewsProccessPaginateLinks");
           $(".news_block .div_will_paginate a").click(function (e) {
               e.preventDefault();
               var page = $(this).attr('href').split("?page=")[1];
               History.pushState({page:page},window.document.title,"?page="+page);
           });
       };

       fNewsStartWillPaginateAjax = function () {
           if ($(".news_block .div_will_paginate a").length > 0) {
               fNewsProccessPaginateLinks();
               fNewsBindHistoryAdapter();
           }
       };

       fNewsProcessBlocks = function() {
           $(".fact img").click(function (e) {
               // NB:: parent().parent() хардкод: картинка лежит в ссылке, ссылка лежит в диве
               window.location.href = $(this).parent().parent().data('url');
           });
       };

       fNewsStartWillPaginateAjax();
       fNewsProcessBlocks();

   }
});