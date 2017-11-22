<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>充值成功</title>
    <script src="../../js/flexible.debug.js"></script>
    <style>
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
        .ftsize12{font-size:12px;}
        [data-dpr="2"] .ftsize12{
            font-size:24px;
        }
        [data-dpr="3"] .ftsize12{
            font-size:36px;
        }
        .box{
            padding-top: 1.8666666rem;
	    text-align:center;
        }
        div.success-img{
            background:url("https://www.plusmoney.cn/images/charge/recharge-success.png") no-repeat;
            background-size:cover;
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
            margin-top: 20px;
        }
        div.timer a{
            color: #a9a9a9;
        }
        .wordBlue{
            color: #4a90e2;
        }
    </style>

</head>
<body>
<div class="wrapper">
    <div class="box">
        <div class="success-img"></div>
        <div class="note txtCenter ftsize17">恭喜您，充值成功</div>
        <div class="timer txtCenter ftsize12"><a id="toCharge" href="//www.plusmoney.cn/charge/index.html?returnHome">点击此处回到首页，<span id="timerNum" class="wordBlue">5</span><span class="wordBlue">秒</span>后自动返回</a></div>
    </div>
</div>

<script type="text/javascript">
    var reqParams = getCookie("reqParams");
    console.log(getCookie('chargeFlag'));
    console.log(getCookie('reqParams'));
    if(getCookie('chargeFlag')==1){
        $("#tocharge").attr('href',"//www.plusmoney.cn/charge/index.html?"+reqParams+"#&/charge/packageconfirm.html?chosen="+getCookie("chosen"));
    }else if(getCookie('chargeFlag')==2){
        $("#tocharge").attr('href',"//www.plusmoney.cn/charge/index.html?"+reqParams+"#&/charge/upgradeAfterPackage.html?newPackageMsg="+getCookie("newPackageMsg"));
    }else{
        $("#tocharge").attr('href',"//www.plusmoney.cn/charge/index.html?"+reqParams);
    }
    var int=self.setInterval("timer()",1000);
 	function timer(){
        var t=parseInt(document.getElementById("timerNum").innerHTML)-1;
        document.getElementById("timerNum").innerHTML=t;
        //$("#timerNum").html(t);
        if(t==1){
            int=window.clearInterval(int);
            if(getCookie('chargeFlag')==1){
                window.location.href = "//www.plusmoney.cn/charge/index.html?"+reqParams+"#&/charge/packageconfirm.html?chosen="+getCookie("chosen");
            }else if(getCookie('chargeFlag')==2){
                window.location.href = "//www.plusmoney.cn/charge/index.html?"+reqParams+"#&/charge/upgradeAfterPackage.html?newPackageMsg="+getCookie("newPackageMsg");
            }else{
                window.location.href = "//www.plusmoney.cn/charge/index.html?"+reqParams;
            }
        }
    }
    //获得coolie 的值
    function getCookie(objName){//获取指定名称的cookie的值
    var arrStr = document.cookie.split("; ");
    for(var i = 0;i < arrStr.length;i ++){
    var temp = arrStr[i].split("=");
    if(temp[0] == objName) return unescape(temp[1]);
    }
    }
</script>
</body>
</html>
