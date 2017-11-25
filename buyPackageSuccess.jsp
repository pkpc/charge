<!DOCTYPE html>
    <%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
    <html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币兑换套餐</title>
    <script src="/js/flexible.debug.js"></script>
    <link rel="stylesheet" href="/css/charge/reset2.css" />
    <link rel="stylesheet" href="/css/charge/mobilebone.css">
    <link rel="stylesheet" href="/css/charge/charge.css">
    <link rel="stylesheet" href="/css/charge/packageConfirm.css">
    <link rel="stylesheet" href="/css/charge/plus-charge.css">
    <link rel="stylesheet" href="/css/charge/account-details.css">
    <link rel="stylesheet" href="/css/charge/choosepackage.css">
    <link rel="stylesheet" href="/css/charge/activepackage.css">
    <link rel="stylesheet" href="/css/charge/mergepackage.css">
    <link rel="stylesheet" href="/css/charge/contacts.css">
    <link rel="stylesheet" href="/css/charge/index.css">
    <link rel="stylesheet" href="/css/charge/account-transfer.css">
    <link rel="stylesheet" href="/css/charge/account-pluscoin-details.css">
    <style>
        html,body{
            padding:0;
            margin:0;
        }
        .wrapper{
            background:#fff;
            height:100%;
            width:100%;
        }
	    a {
    	    text-decoration: none;
    	    -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
	    }
	    a:hover{
    	    text-decoration: none;
	    }
        .ftsize17{font-size:17px;}
        [data-dpr="2"] .ftsize17{
            font-size:34px;
        }
        [data-dpr="3"] .ftsize17{
            font-size:51px;
        }
        .ftsize18{font-size:18px;}
        [data-dpr="2"] .ftsize18{
            font-size:36px;
        }
        [data-dpr="3"] .ftsize18{
            font-size:54px;
        }
        .ftsize12{font-size:12px;}
        [data-dpr="2"] .ftsize12{
            font-size:24px;
        }
        [data-dpr="3"] .ftsize12{
            font-size:36px;
        }
        .box{
            padding-top: 1.5rem;
	    	text-align:center;
        }
        div.success-img{
            background:url(/images/charge/bg_plusbox.png) no-repeat;
            background-size:contain;
            background-position: center;
            width:5.2rem;
            height:2.826666rem;
            margin:0 auto;
            margin-bottom:0.4rem;
        }
        div.note{
            margin-top: 0.4rem;
            color:#777;
        }
        div.timer{
            margin-top: .26666rem;
            margin-bottom: .8rem;
        }
        div.timer a{
            color: #a9a9a9;
        }
        .wordBlue{
            color: #4a90e2;
        }
        table.transfer-result {
            color: #333;
            font-size: 15px;
            width: 100%;
            border-collapse: collapse;
        }
        [data-dpr="2"] .ftsize15{
            font-size: 30px;
        }
        [data-dpr="3"] .ftsize15{
            font-size: 45px;
        }
        table.transfer-result tr {
            border-bottom: 1px solid #e2e2e2;
            line-height: 1.17333rem;
            height: 1.17333rem;
        }
        table.transfer-result tr:first-child {
            border-top: 1px solid #e2e2e2;
        }
        table.transfer-result tr td:first-child{
            padding-left: .8rem;
            text-align: left;
        }
        table.transfer-result tr td:nth-child(2){
            padding-right: .8rem;
            text-align: right;
        }
        .return-btn {
            display: block;
        }
        div.active-now-btn {
            text-align: center;
            height: 1.1733333rem;
            line-height: 1.1733333rem;
            margin-top: 1.3333333rem;
            width: 100%;
            box-sizing: border-box;
            padding-left: 30px;
            padding-right: 30px;
        }
        div.return-btn {
            text-align: center;
            height: 1.1733333rem;
            line-height: 1.1733333rem;
            margin-top: 0.3333333rem;
            width: 100%;
            box-sizing: border-box;
            padding-left: 30px;
            padding-right: 30px;
            margin-bottom: 0.8rem;
        }
        div.return-btn a {
            color: #fff;
            width: 100%;
            display: inline-block;
            background: #4a90e2;
            border-radius: 2px;
        }
        div.active-now-btn a {
            color: #4a90e2;
            width: 100%;
            display: inline-block;
            background: #fff;
            border-radius: 2px;
            border: 1px solid #4a90e2;
        }
    </style>

</head>
<body>
<div class="message-modal" style="display:none">
    	<span class="message-modal img"></span>
        <span class="message-modal ftsize14"></span>
</div>
<div class="wrapper">
    <div class="box">
        <div class="success-img"></div>
        <div class="note txtCenter ftsize17">恭喜您，套餐已成功</div>
        <div class="timer txtCenter ftsize12"><a href=""><span id="timerNum" class="wordBlue">15</span><span class="wordBlue">秒</span>后将自动返回</a></div>
        <table class="transfer-result ftsize15">
            <tr>
                <td>已购套餐</td>
                <td><span id="packageType"></span></td>
            </tr>
            <tr>
                <td>花费加币</td>
                <td><span id="plusCoinSpended"></span></td>
            </tr>
            <tr>
                <td>剩余加币</td>
                <td><span id="plusCoinLeft"></span></td>
            </tr>
        </table>
        <%--<div class="active-now-btn">--%>
            <%--<a class="ftsize18" href="" id="activeNow">立即激活套餐</a>--%>
        <%--</div>--%>
        <div class="return-btn" style="margin-top:1.84rem">
            <a class="ftsize18" href="">返回</a>
        </div>
    </div>
</div>
<script src="/js/mobilebone.js"></script>
<script src="/js/jquery/jquery-1.8.3.min.js"></script>
<script src="/js/getParam.js"></script>
<script type="text/javascript">
	var mptoken=getUrlParam("mptoken");
	var ftoken=getUrlParam("ftoken");
	var isAdmin=getUrlParam("isAdmin");
	var isxigu=getUrlParam("isxigu");
	var plusCoinReward=getUrlParam("plusCoinReward");
	var companyName=decodeURI(decodeURI(getCookie("companyName")));
	var userName=decodeURI(decodeURI(getCookie("userName")));
    var chosen = getUrlParam("chosen");
	if(isxigu==1){
    	<%--var params = geturlParams();--%>
        location.href='/charge/index.html?'+params;
    }
    $(function(){
        loadBasicData();
        postMsgToApp();
    })
    /* 向App发送消息 */
    function postMsgToApp(){
        var ua = window.navigator.userAgent.toLowerCase();
        try {
            if (/iphone|ipad|ipod/.test(ua)) {
                <%--window.webkit.messageHandlers.iOS.postMessage(obj)--%>
            } else if (/android/.test(ua)) {
                window.Android.updateUserProfile();
                <%--window.Android.updateUserProfile(JSON.stringify(obj).replace(/"/g, '\''))--%>
            }
        } catch (e) {

        }
    }
    function loadBasicData(){
        var cd = chosen.split(",");
        if(cd[1].substr(0,1)==6){
        $("#packageType").text(cd[0]+"人6个月套餐");
    }else{
        $("#packageType").text(cd[0]+"人"+cd[1].substr(0,1)+"年期套餐");
    }
        $("#plusCoinSpended").text(toThousands(cd[2])+"个");
    }
	var retParam = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;
	<%--$(".return-btn a").attr("href","/charge/index.html?"+retParam);--%>
	$(".return-btn a").attr("href","/charge/index.html?returnHome");
	<%--$(".timer a").attr("href","/charge/index.html?"+retParam);--%>
	$(".timer a").attr("href","/charge/index.html?returnHome");
	<%--$("#activeNow").attr("href","/charge/index.html?"+retParam+"#&/charge/activepackage.html");--%>
    var int=self.setInterval("timer()",1000);
    window.onload = function(){
    	$.ajax({
            url:"/mppay/getLastestPackages",
            type:"POST",
            xhrFields: {
                withCredentials: true
            },
            async:false,
            data:{},
            dataType:"json",
            crossDomain: true,
            contentType:'application/json',
            beforeSend:function(xhr){
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            error: function(){
                openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
            },
            success:function(data){
                if(data.result==0){
                    document.getElementById("plusCoinLeft").innerHTML = toThousands(data.data.plusCoinAmount)+"个";
                }else {
                    openMessageModal("<p>"+data.res_info+"</p>");
                }
            },
        })
       
    }
    function timer(){
        var t=parseInt(document.getElementById("timerNum").innerHTML)-1;
        document.getElementById("timerNum").innerHTML=t;
        if(t==1){
            int=window.clearInterval(int);
            <%--window.location.href = "/charge/index.html?"+retParam+"#&account-system";--%>
            window.location.href = "/charge/index.html?returnHome";
        }
    }
  	//读cookies
    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg)) {
            return unescape(arr[2]);
        } else {
            return null;
        }
    }
    function getUrlParam(paras){
        var urlArray = document.location.href.split("?");
        var returnValue;
        for(var a=1;url=urlArray[a];a++){
            var paraString = url.split("&");
            for (i=0; j=paraString[i]; i++){
                if(j.indexOf(paras)==0){
                    returnValue = j.substring(j.indexOf("=")+1,j.length);
                }
            }
        }

        if(typeof(returnValue)=="undefined"){
            return null;
        }else if(returnValue.indexOf("#")!=-1){
            returnValue=returnValue.substring(0,returnValue.length-1);
            return returnValue;
        }
        else{
            return returnValue;
        }
    }
    //千位分隔符
    function toThousands(number){
    number = number.toString();
    //小数部分
    var Int =parseInt(number).toString();
    Int=Int.replace(/(\d{1,3})(?=(\d{3})+(?:$|\.))/g, "$1,");
    if(number.lastIndexOf(".")!=-1){
    var Float= number.substring(number.lastIndexOf("."),number.length);
    }else{
    var Float="";
    }
    //整数部分
    return Int+Float;
    }
</script>
</body>
</html>
