<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>升级加币套餐</title>
    <style>
        a.item-btn2 {
            display: inline-block;
            width: 50%;
            float: left;
            text-align: center;
            box-sizing: border-box;
            /*padding: 0.24rem 0 0.213rem 0px;*/
            height: 1.14rem;
            line-height:1.14rem;
            font-size: 0.453rem;
        }
        .modal-footer {
            height: 1.173333rem;
            border-top: 0.0267rem solid #ccc;
            box-sizing: border-box;
        }
        .modal-body {
            /*height: 1.6rem;*/
            margin: 0 0.4rem 0;
            text-align: center;
            font-size: 0.347rem;
            /* line-height: 3.1rem; */
            box-sizing: border-box;
        }
        .modal{
            min-height: 0;
            position: static;
        }
        .modal-header {
            /* line-height: 1.17rem; */
            font-family: PingFangSC-Regular;
            padding-top: 0.56rem;
            color: #030303;
            padding-bottom: 0.267rem;
            text-align: center;
            font-size: 0.453rem;
            /* border-bottom: 0.02rem solid #ccc; */
        }
        .modal-window-activate {
            position: absolute;
            top: 0;
            bottom: 4.987rem;
            left: 0;
            right: 0;
            width: 7.2rem;
            height: 3.9rem;
            margin: auto 1.333rem;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 0.213rem;
        }
        .plus-page-mask div.modal {
            z-index: 11;
            overflow: hidden;
        }
        .plus-page-mask {
            height: 100%;
            width: 100%;
            background-color: rgba(0,0,0,.3);
            position: absolute;
            top:0;
            left:0;
            right:0;bottom:0;
            margin:auto;
            z-index: 9;
        }
    </style>
</head>
<body>
    <div class="content">
        <div class="upgradeContent">
            <div class="pd15">
                <div>当前套餐</div>
                <div class="packageSmallBox mt_12">
                    <div class="pd18">
                        <div id="oldPackageName" class="ftsize17 black_color"></div>
                        <div class="flex_row_betweent ftsize12 mt_16 grey_color">
                            <div>
                                <span>购买日期</span><span id="oldPurchaseTime" class="ml_5"></span>
                            </div>
                            <div>
                                <span>有效期至</span><span id="oldUsedTime" class="ml_5"></span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="mt_22">升级后套餐</div>
                <div class="packageSmallOrgBox mt_12">
                    <div class="pd18">
                        <div id="upPackageName" class="ftsize17 black_color"></div>
                        <div class="flex_row_betweent ftsize12 mt_16 grey_color">
                            <div>
                                <span>升级日期</span><span id="upTime" class="ml_5"></span>
                            </div>
                            <div>
                                <span>有效期至</span><span id="upUsedTime" class="ml_5"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="background-color: #ffffff">
            <div class="row44 mt_12 ftsize15">
                <div class="pd_16 flex_row_betweent">
                    <div>
                        <img src="/images/charge/pluscoin4package.png" style="width: 0.48rem;height: 0.48rem;margin-top: 0.35rem;">
                        <span class="">所需加币</span>
                    </div>
                    <div style="color: #777777;">
                        <span id="TheLastCoinNeed"></span>
                        <span>个</span>
                    </div>
                </div>
            </div>
            <div style="margin-left:0.4267rem;width:96%;height:0.053rem;border-top:0.0267rem #ccc solid;" ></div>
            <div class="row44 ftsize15">
                <div class="pd_16 flex_row_betweent">
                    <div>
                        <img src="/images/charge/icn_password.png" style="width: 0.48rem;height: 0.48rem;margin-top: 0.3rem;">
                        <span class="">登录密码</span>
                    </div>
                    <div style="color: #777777;">
                        <input type="password" class="password ftsize15" placeholder="为确保安全，请输入登录密码">
                    </div>
                </div>
            </div>
        </div>
        <div class="packageBottom">
        <a id="toSuccess" href="javascript:void(0)" onclick="updatePackage()" class="btn_a ftsize18 mt_50">确认升级</a>
            <a id="hideToSuccess"  href="/charge/upgradePackageSuccess.html" style="display: none;"></a>
        </div>
    </div>
    <div id="modal_select" class="plus-page-mask modal-window-activate-mask" style="background-color: rgba(0,0,0,.3); display:none;">
        <div class="modal bdbox">
            <div class="modal-window-activate">
                <div class="modal-header ftsize17"><div id="modal_title">加币不足</div></div>
                <div class="modal-body">
                    <div class="modal-item">
                        您当前剩余的加币不足以购买该套餐，建议您先进行加币充值。
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="btn-group">
                        <a style="border-right:0.0267rem #dddddd solid;color: #333333" href="javascript:;" onclick="modal_cancel()" class="item-btn2 cancelActivate ftsize17">取消</a>
                        <a id="charge" href="javascript:;" class="item-btn2 confirmActivate ftsize17" onclick="activeChangeCheck()" data-mask="true" style="color: #4A90E2">充值</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    var newPackageMsg = getUrlParam("newPackageMsg");
    var newPackageData = newPackageMsg.split(',')
            ,chosen="",reqParams="",companyId="",plusCoinAmountTotal="";
    var mptoken=getUrlParam("mptoken");
    var ftoken=getUrlParam("ftoken");
    var isAdmin=getUrlParam("isAdmin");
    var isxigu=getUrlParam("isxigu");
    var plusCoinReward=getUrlParam("plusCoinReward");
    var companyName=decodeURI(decodeURI(getCookie("companyName")));
    var userName=decodeURI(decodeURI(getCookie("userName")));
    $(function () {
        loadPackageMsg();
        //获取公司的剩余加币
        getCompanyPlusCoin(companyId);
        reqParams = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;
    })
    //升级套餐
    function updatePackage() {
        if($('input[type="password"]').val() == ""){
            openMessageModal("<p>请输入密码</p>");
        }else{
            var params ={
                "personNumAfterUpgrade":newPackageData[0],
                "expiryDateAfterUpgrade":newPackageData[1],
                "packagesNeedCoinAfterUpgrade":newPackageData[2],
                "packagesNeedCoin":newPackageData[3],
                "password":$('input[type="password"]').val(),
                "type":newPackageData[4]
            }
            $.ajax({
                url:'/mppay/upgradeThePackage',
                type:'post',
                contentType:'application/json',
                data:JSON.stringify(params),
                beforeSend:function (xhr) {
                    xhr.setRequestHeader("Authorization","Bearer "+mptoken);
                },
                success:function (res) {
                    var data = JSON.parse(res);
                    if(data.result == 0){
                        location.href="/charge/index.html?"+reqParams+"#&/charge/upgradePackageSuccess.html?chosen="+chosen;
                    }else{
                        if(data.res_info =="加币余额不足"){
                            $('#modal_select').css("display","block");
                            var u = navigator.userAgent;
                            var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
                            var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
                            if(isAndroid){
    console.log(newPackageData[2]-plusCoinAmountTotal);
                                var plusChargeurl = addUrlParams("charge.html",{
                                    companyId:companyId,
                                    chargeMoney:newPackageData[2]-plusCoinAmountTotal
                                    <%--chargeMoney:1--%>
                                });
                                console.log(plusChargeurl)
                                $('#charge').attr('href',plusChargeurl);
                                setCookie("chargeFlag",2);
                                setCookie("reqParams",reqParams);
                                setCookie("newPackageMsg",newPackageMsg);
                                console.log(getCookie("chargeFlag"));
                                console.log(getCookie("reqParams"));
                                console.log(getCookie("newPackageMsg"));
                            }else if(isiOS){
                                $(".modal-body .modal-item").text("您当前剩余的加币不足以购买该套餐，建议您先联系客服进行加币充值")
                                $(".modal-footer").html('<a href="tel:0755-82777607" onclick="activeChangeCheck()" class="ftsize15  blue_color" style="text-align: center;display: block;height: 1.17rem;line-height: 1.17rem;">联系客服</a>');
                            }
                        }else{
                            openMessageModal("<p>"+data.res_info+"</p>");
                        }
                    }
                }
            })
        }
    }
    function getCompanyPlusCoin(companyId){
        var param = {};
        param.companyId = companyId;
        $.ajax({
            url:plusCoinAmount_url,
            async:false,
            type:'POST',
            data:JSON.stringify(param),
            contentType:'application/json',
            headers:{
            Authorization:'Bearer '+ mptoken
            },
            success:function(data){
                data  = JSON.parse(data);
                if(data.result=='0'){
                    plusCoinAmountTotal = data.data.plusCoinAmount;
                }
            }
        });
    }
    function loadPackageMsg() {
        //加载之前的原始套餐的数据
        $.ajax({
            url:'/mppay/getPurchasedPackages',
            type:'post',
            async:false,
            contentType:'application/json',
            beforeSend:function (xhr) {
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            success:function (res) {
                var data = JSON.parse(res);
                if(data.result == 0){
                    $("#oldUsedTime").text(data.data.expiryDate.split(' ')[0]);
                    $("#oldPurchaseTime").text(data.data.buyTime.split(' ')[0]);
                    $("#oldPackageName").text(data.data.personNum+"人套餐");
                    companyId = data.data.companyId;
                }
            }
        })
        //加载新套餐的数据
        $("#upPackageName").text(newPackageData[0]+"人套餐");
        var nowTime = new Date();
        var year = nowTime.getFullYear();
        var month = nowTime.getMonth()+1;
        if(month<10){
            month = "0"+month;
        }
        var day = nowTime.getDate();
        $("#upTime").text(year+"-"+month+"-"+day);
        $("#upUsedTime").text(newPackageData[1]);
        console.log(newPackageData[2]);
        $("#TheLastCoinNeed").text(toThousands(newPackageData[2]));

        //加载a标签的跳转
        chosen = newPackageData[0]+","+newPackageData[1]+","+newPackageData[2];
//        $('#hideToSuccess').attr('href','/mppaytest/upgradePackageSuccess.jsp?chosen='+chosen);
    }
    function modal_cancel() {
        $('#modal_select').css("display","none");
    }
    function activeChangeCheck() {
        $('#modal_select').css("display","none");
    }
    function toChargeForAndroid() {

    }
</script>
</html>