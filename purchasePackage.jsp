<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币兑换套餐</title>
    <link rel="stylesheet" href="/css/charge/packages.css">
    <link rel="stylesheet" href="/css/charge/choosepackage.css">
    <link rel="stylesheet" href="/css/charge/reset2.css" />
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
            height: 1.453rem;
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
            /*padding-bottom: 0.267rem;*/
            padding-bottom: 0.2rem;
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
            /*height: 3.9rem;*/
            height: 4rem;
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
        <div class="flex_col_betweent">
            <div>
                <div class="mt_12 row44">
                    <div class="pd_29 flex_row_betweent">
                        <div id="counts" class="ftsize15 black03_color">企业人数</div>
                        <div class="flex_row_betweent" style="width: 3.573rem;align-items: center;">
                            <img id="decStaff" onclick="decCompanyStaff()" src="/images/charge/icn_minus.png" style="width: 0.827rem;height: 0.587rem;">
                            <input id="companyStaffCounts" class="ml input_border_none ftsize15 blue_color" type="number" style="width:1.5rem;text-align:center"  oninput="editStaffCounts()"/>
                            <img onclick="addCompanyStaff()" src="/images/charge/icn_add.png" style="width: 0.827rem;height: 0.587rem;">
                        </div>
                    </div>
                </div>
                <div class="mt_12 row44">
                    <div class="pd_29 flex_row_betweent">
                        <div class="ftsize15 black03_color">购买时长</div>
                        <div class="flex_row_betweent" style="width: 3.573rem;align-items: center;">
                            <img id="decTime" onclick="decPackageTime()" src="/images/charge/icn_minus.png" style="width: 0.827rem;height: 0.587rem;">
                            <span id="packageTime" class="ml ftsize15 blue_color">6个月</span>
                            <img onclick="addPackageTime()" src="/images/charge/icn_add.png" style="width: 0.827rem;height: 0.587rem;">
                        </div>
                    </div>
                </div>
                <div class="statisticsMoney flex_row_center">
                    <span style="color:#999999" class="ftsize17">实付</span>
                    <span id="plusmonyCount" class="blue_color ftsize24 ml_5 mr_5"></span>
                    <span style="color:#999999" class="ftsize17">加币</span>
                </div>
                <div>
                    <img src="/images/charge/triangles.png" style="width: 100%;">
                </div>
            </div>
            <div class="pd15 " style="position:relative;text-align: center;height:3.107rem;">
                <div id="toastTip" class="toastTip ftsize15"></div>
                <a id="purchasePackages" class="btn_a ftsize18" onclick="buyPackage()">立即购买</a>
            </div>
            <div class="Tagging pd15 ftsize12">
                <ul class="clearfix bdbox" style='list-style-type: decimal'>
                    <li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem;'><div class="noticeWord " style='margin-left: -0.47rem;'>加币套餐有人数和使用时长限制，请根据您企业的实际情况选择，超出人数限制的员工需升级套餐后才能使用；</div></li>
                    <li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>加币套餐即日起开放购买，截止时间以大管加公告为准；</div></li>
                    <li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>本活动最终解释权归大管加所有，如有疑问请致电<a href="tel:0755-82777607" class="blue_color">0755-82777607</a>。</div></li>
                </ul>
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
    </div>
</body>
<script>
    var list = ['6个月','1年','2年','3年','4年','5年'],
            mptoken = getUrlParam("mptoken"),
            packageTimeIndex = 0,
            staff =parseInt(getUrlParam("staff")),
            staffInPackage = parseInt(getUrlParam("staff")),
            lastPackageTime =$('#packageTime').text(),
            spendPmyCounts = "",
            plusCoinAmountTotal = getUrlParam("plusCoinAmountTotal"),
            chosen ="",
            companyId = getUrlParam("companyId");
    var mptoken=getUrlParam("mptoken");
    var ftoken=getUrlParam("ftoken");
    var isAdmin=getUrlParam("isAdmin");
    var isxigu=getUrlParam("isxigu");
    var plusCoinReward=getUrlParam("plusCoinReward");
    var companyName=decodeURI(decodeURI(getCookie("companyName")));
    var userName=decodeURI(decodeURI(getCookie("userName")));
    var reqParams ="";
    $(function () {
        console.log(staff);
        reqParams = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;
    if(staff<10){
    staffInPackage = 10;
    $("#counts").html("套餐人数");
    $('#companyStaffCounts').val(staffInPackage);
    }else{
    $("#counts").html("企业人数");
    $('#companyStaffCounts').val(staff);
    }
    getPlusMoneyNeedPay();
    })
    function editStaffCounts(){
        staffInPackage = parseInt($('#companyStaffCounts').val());
    if(staffInPackage === 10){
        $('#decStaff').attr('src',"/images/charge/icn_minus.png");
        getPlusMoneyNeedPay();
        $("#purchasePackages").removeClass('background_grey');
        downButtom();
    }else if(staffInPackage < 10){
        $('#toastTip').text("套餐最小购买人数为10人");
        $('#toastTip').css("visibility","visible");
        setTimeout(function () {
            $('#toastTip').css("visibility","hidden");
        },3000);
        $('#decStaff').attr('src',"/images/charge/icn_minus.png");
        $("#purchasePackages").addClass('background_grey');
        $("#purchasePackages").attr('href','#');
        upButton();
    }else if(staffInPackage>staff){
            $('#decStaff').attr('src',"/images/charge/decrease-num.png");
            $("#purchasePackages").removeClass('background_grey');
            getPlusMoneyNeedPay();
            downButtom();
        }else if(staffInPackage == staff){
            $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            getPlusMoneyNeedPay();
            $("#purchasePackages").removeClass('background_grey');
            downButtom();
        }else{
            $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            $('#toastTip').text("套餐人数不得低于企业人数");
            $('#toastTip').css("visibility","visible");
            getPlusMoneyNeedPay();
            $("#purchasePackages").addClass('background_grey');
            upButton();
            setTimeout(function () {
                $('#toastTip').css("visibility","hidden");
            },3000);
        }
    }
    function modal_cancel() {
        $('#modal_select').css("display","none");
    }
    function activeChangeCheck() {
        $('#modal_select').css("display","none");
    }
    function buyPackage() {
        if(staffInPackage>=10){
            if(staffInPackage >= staff){
                if(spendPmyCounts > plusCoinAmountTotal){
                    $('#purchasePackages').attr('href',"#");
                    $('#modal_select').css("display","block");
                    var u = navigator.userAgent;
                    var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
                    var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
                    if(isAndroid){
                        var plusChargeurl = addUrlParams("charge.html",{
                        companyId:companyId,
                        chargeMoney:spendPmyCounts-plusCoinAmountTotal
                        });
                        $('#charge').attr('href',plusChargeurl);
                        setCookie("chargeFlag",1);
                        setCookie("reqParams",reqParams);
                        setCookie("chosen",chosen);
                    }else if(isiOS){
                        $(".modal-body .modal-item").text("您当前剩余的加币不足以购买该套餐，建议您先联系客服进行加币充值")
                        $(".modal-footer").html('<a href="tel:0755-82777607" onclick="activeChangeCheck()" class="ftsize15  blue_color" style="text-align: center;display: block;height: 1.17rem;line-height: 1.17rem;">联系客服</a>');
                    }
                }else{
                    $('#purchasePackages').attr('href',"/charge/packageconfirm.html?chosen="+chosen);
                }
            }
        }
    }
    //获得该套餐的最终消耗的加币数
    function getPlusMoneyNeedPay() {
        var params ={}
        if($('#packageTime').text().substr(0,1) == "6"){
            params ={
                "personNum":staffInPackage,
                "year":0,
                "month":6,
                "day":0
            }
        }else{
            params ={
                "personNum":staffInPackage,
                "year":$('#packageTime').text().substr(0,1),
                "month":0,
                "day":0
            }
        }
        $.ajax({
            url:"/mppay/calPackagesNeedCoin",
            data:JSON.stringify(params),
            contentType:'application/json',
            type:'post',
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
            },
            error: function() {
//                openMessageModal("<p>参数出错，请联系程序员</p>");
            },
            success:function (res) {
                var res = JSON.parse(res);
                if(res.result == 0){
                    var data = res.data;
                    spendPmyCounts = data.packagesNeedCoin;
                    $('#plusmonyCount').text(toThousands(data.packagesNeedCoin));
                    chosen = staffInPackage+","+$('#packageTime').text()+","+spendPmyCounts;
                }
            }
        })
    }
    //减少套餐时长
    function decPackageTime() {
        if(packageTimeIndex>0){
            packageTimeIndex--;
            $('#packageTime').text(list[packageTimeIndex]);
            lastPackageTime =$('#packageTime').text();
            if(packageTimeIndex == 0){
                $('#decTime').attr('src',"/images/charge/icn_minus.png");
            }
            getPlusMoneyNeedPay();
        }else if(packageTimeIndex == 0){
            $('#toastTip').text("兑换时长至少为6个月");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
                $('#toastTip').css("visibility","hidden");
            },3000)
        }
    }
    //增加套餐时长
    function addPackageTime() {
        if(packageTimeIndex <5){
            packageTimeIndex++;
            $('#packageTime').text(list[packageTimeIndex]);
            lastPackageTime =$('#packageTime').text();
            if(packageTimeIndex>0){
                $('#decTime').attr('src',"/images/charge/decrease-num.png");
            }
            getPlusMoneyNeedPay();
        }
    }
    //添加员工人数
    function addCompanyStaff() {
        $('#companyStaffCounts').val(staffInPackage+1);
        staffInPackage = parseInt($('#companyStaffCounts').val());
        if(staffInPackage === 10){
            $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            $("#purchasePackages").removeClass('background_grey');

        }else if(staffInPackage < 10){
            $("#purchasePackages").attr('href','');
        }else if(staffInPackage>staff){
            $('#decStaff').attr('src',"/images/charge/decrease-num.png");
            $("#purchasePackages").removeClass('background_grey');
        }else if(staffInPackage == staff){
            $("#purchasePackages").removeClass('background_grey');
            downButtom();
        }
        getPlusMoneyNeedPay();
    }
    //减少员工人数
    function decCompanyStaff() {
        if(staffInPackage === 10){
            $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            $('#toastTip').text("套餐最小购买人数为10人");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
            $('#toastTip').css("visibility","hidden");
            },3000)
        }else if(staffInPackage < 10){
            $('#toastTip').text("套餐最小购买人数为10人");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
            $('#toastTip').css("visibility","hidden");
            },3000)
        }else if(staffInPackage>staff){
            $('#companyStaffCounts').val(staffInPackage-1);
            staffInPackage = parseInt($('#companyStaffCounts').val());
            if(staffInPackage == staff || staffInPackage ===10){
                $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            }
            getPlusMoneyNeedPay();
        }else if(staffInPackage == staff){
//            $('#decStaff').attr('src',"/images/charge/icn_minus.png");
            $('#toastTip').text("套餐人数不得低于企业人数");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
                $('#toastTip').css("visibility","hidden");
            },3000)
        }
    }
    //悬挂按钮
    function upButton(){
        $('#purchasePackages').unbind();
    $('#purchasePackages').attr('href',"#");
    }
    //恢复按钮
    function downButtom(){
        $('#purchasePackages').on('click',function(){
        });
    $('#purchasePackages').attr('href',"/charge/packageconfirm.html?chosen="+chosen);
    }
</script>
</html>