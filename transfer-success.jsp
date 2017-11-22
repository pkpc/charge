<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币转账</title>
    <script src="../../js/flexible.debug.js"></script>
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
            background:url(http://plusmoney.cn/images/charge/transfer-success.png) no-repeat;
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
        div.return-btn {
            text-align: center;
            height: 1.1733333rem;
            line-height: 1.1733333rem;
            margin-top: 1.3333333rem;
            width: 100%;
            box-sizing: border-box;
            padding-left: 30px;
            padding-right: 30px;
        }
        div.return-btn a {
            color: #fff;
            width: 100%;
            display: inline-block;
            background: #4a90e2;
            border-radius: 2px;
        }
    </style>

</head>
<body>
<div class="wrapper">
    <div class="box">
        <div class="success-img"></div>
        <div class="note txtCenter ftsize17">恭喜您，转账成功</div>
        <div class="timer txtCenter ftsize12"><a href="//www.plusmoney.cn/charge/index.html?returnHome"><span id="timerNum" class="wordBlue">15</span><span class="wordBlue">秒</span>后将自动返回</a></div>
        <table class="transfer-result ftsize15">
            <tr>
                <td>转账加币</td>
                <td><span id="transferAmount"></span>个</td>
            </tr>
            <tr>
                <td>接收人</td>
                <td><span id="receiveName"></span>(<span id="phoneEnd"></span>)</td>
            </tr>
            <tr>
                <td>接收公司</td>
                <td><span id="toCompanyName"></span></td>
            </tr>
            <tr>
                <td>剩余加币</td>
                <td><span id="restAmount"></span>个</td>
            </tr>
        </table>
        <div class="return-btn">
            <a class="ftsize18" href="//www.plusmoney.cn/charge/index.html?returnHome">返回</a>
        </div>
    </div>
</div>

<script type="text/javascript">
    var int=self.setInterval("timer()",1000);
    window.onload = function(){
        document.getElementById("restAmount").innerHTML = toThousands(+getUrlParam("restAmount"));
        document.getElementById("transferAmount").innerHTML = toThousands(+getUrlParam("transferAmount"));
        document.getElementById("receiveName").innerHTML = decodeURI(getUrlParam("receiveName"));
        document.getElementById("phoneEnd").innerHTML = getUrlParam("phoneEnd");
        document.getElementById("toCompanyName").innerHTML = decodeURI(getUrlParam("toCompanyName"));
    }
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
    function timer(){
        var t=parseInt(document.getElementById("timerNum").innerHTML)-1;
        document.getElementById("timerNum").innerHTML=t;
        //$("#timerNum").html(t);
        if(t==1){
            int=window.clearInterval(int);
            postMsgToApp();
            window.location.href = "//www.plusmoney.cn/charge/index.html?returnHome";
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
