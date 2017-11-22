<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>账户系统</title>
    <link rel="stylesheet" href="../../css/reset2.css" />
    <link rel="stylesheet" href="../../css/charge/mobilebone.css">
    <link rel="stylesheet" href="../../css/charge/account-system.css">
    <link rel="stylesheet" href="../../css/charge/plus-charge.css">
    <link rel="stylesheet" href="../../css/charge/contacts.css">
    <link rel="stylesheet" href="../../css/charge/account-details.css">
    <link rel="stylesheet" href="../../css/chargecharge.css">

</head>
<body>
<div id="homePage" class="page out"  style="background-color: #efefef;">
    <div class="wrapper ftsize15">
        <div id="top" class="clearfix">
            <div style="text-align: center;padding-top: 5%">
                <span  class="ftsize64" style=" position:relative;"><span id="restMoney">2,345</span>  <img style="position:absolute;top: 50%;left: 0;" id="pimg" class="coinIcon" src="/charge/images/plus-coin-white.png" alt=""></span>
            </div>
            <div  class="round_btn txtCenter ftsize17">
                <a id="plusChargePage" href="plus-charge.html" data-reload="true" data-history="true" >加币充值</a>
            </div>
        </div>
        <ul class="accountSys">
            <li class="clearfix">
                <img class="title" src="/charge/images/rest-time.png" alt="rest-time">
                <span>剩余可用天数</span>
                <div class="fr day">天</div>
                <div id="restTime" class="fr"></div>
            </li>
            <li class="clearfix isAccountAdmin">
                <a  id="contactsPage" href="contacts.html" data-reload="true" data-history="true"  class="clearfix" style="display:block">
                    <img class="title" src="/charge/images/coin-admin.png" alt="coin-admin"><span>加币账户管理员</span>
                    <div class="fr day">人</div>
                    <div id="adminNum" class="fr"></div>
                    <a href="" class="arrow"><img  src="/charge/images/arrow.png" alt="arrow"></a>
                </a>
                <hr/>
            </li>

            <li class="clearfix">
                <a  id="acountDetailPage" href="account-details.html"  data-history="true" data-reload="true" class="clearfix" style="display:block">
                    <img class="title" src="/charge/images/account-details.png" alt="account-details">
                    <span>账户明细</span>
                    <a href="" class="arrow"><img class="arrow"  src="/charge/images/arrow.png" alt="arrow"></a>
                </a>
            </li>
            <li class="clearfix" onclick="window.location.href= location.href + '?service=1'">
                <img class="title" src="/charge/images/customer-service.png" alt="customer-service">
                <span>联系客服</span>
                <a href="" class="arrow" ><img  src="/charge/images/arrow.png" alt="arrow"></a>
            </li>
        </ul>
    </div>
</div>
</div>
<script src="../../flexible.debug.js"></script>
<script src=../../css/js/jquery-1.8.3.min.js" ></script>
<script src="../../js/mobilebone/mobilebone.js"></script>


<script>
    $(function(){
        Mobilebone.init();
    })
    Mobilebone.onpagefirstinto=function(pagein){
    }
    Mobilebone.callback=function(pagein){
        var ID = pagein.id;
        if(ID=="home"){
            ftoken=getUrlParam("ftoken");
            mptoken=getUrlParam("mptoken");
            Token();
            urlParams.userName = decodeURI(getUrlParam("userName"));
            urlParams.plusCoinAmount = getUrlParam("plusCoinAmount");
            urlParams.plusCoinReward = getUrlParam("plusCoinReward");
            urlParams.isAdmin = getUrlParam("isAdmin");
            urlParams.companyName = decodeURI(getUrlParam("companyName"));
            urlParams.indexUrl = window.location.href;
            getAccountCharger();
            pageDataInit();
            getPerson();
            cookieInit();
        }
    }


</script>
</body>
</html>
