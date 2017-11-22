<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>升级加币套餐</title>

    <style>
        .background_grey{
            background-color: #CCCCCC!important;
        }
    </style>
</head>
<body>
    <div class="content">
            <div style="height: 0.32rem;width:100%;"></div>
            <div class="row44">
                <%--<div class="pd_16 flex_row_betweent">--%>
                <div class="pd_16 flex flex-pack-justify flex-align-center">
                    <div class="ftsize15 black03_color">升级后支持人数</div>
                    <%--<div class="flex_row_betweent" style="width: 3.573rem;align-items: center;">--%>
                    <div class="flex flex-pack-justify flex-align-center" style="width: 3.573rem;align-items: center;">
                        <img id="decStaffs" onclick="decCompanyStaff()" src="/images/charge/icn_minus.png" style="width: 0.827rem;height: 0.587rem;">
                        <input id="upCompanyStaffCounts" type="number" class="ml input_border_none ftsize15 blue_color" style="width:1.5rem;text-align:center" oninput="editCompanyStaffCounts()"/>
                        <img onclick="addCompanyStaff()" src="/images/charge/icn_add.png" style="width: 0.827rem;height: 0.587rem;">
                    </div>
                </div>
            </div>
            <div class="mt_12 row44">
                <%--<div class="pd_16 flex_row_betweent">--%>
                <div class="pd_16 flex flex-pack-justify flex-align-center">
                    <div class="ftsize15 black03_color">升级后有效期至</div>
                    <%--<div class="flex_row_end" style="align-items: center;position: relative;width: 4rem;">--%>
                    <div class="flex flex-align-center flex-pack-justify-end" style="align-items: center;position: relative;width: 4rem;">
                        <input type="date" class="timeFormatter ftsize15" onchange="getDateTime()" value="" style="position:absolute"/>
                        <span id="upgradeTime" class="ftsize15 grey_color mr_9"></span>
                        <img src="/images/charge/arrow.png" style="width: 0.213rem;height: 0.317rem;">
                    </div>
                </div>
            </div>
            <%--<div class="statisticsMoney flex_row_center">--%>
            <div class="statisticsMoney flex flex-pack-center flex-align-center">
                <span style="color:#999999" class="ftsize17">实付</span>
                <span id="needToSpendCoin" class="blue_color ftsize24 ml_5 mr_5">--</span>
                <span style="color:#999999" class="ftsize17">加币</span>
            </div>
            <div>
                <img src="/images/charge/triangles.png" style="width: 100%;">
            </div>
        <div class="pd15 mt_58" style="position:relative;text-align: center;height:3.107rem;">
            <div id="toastTip" class="toastTip ftsize15"></div>
            <a id="nextStep" class="btn_a background_grey ftsize18">下一步</a>
        </div>
        <!--<div class="pd15 mt_58" style="position:relative;text-align: center;height:3.107rem;">-->
            <!--<div id="toastTip" class="toastTip ftsize15"></div>-->
            <!--<a id="purchasePackages" class="btn_a ftsize18" onclick="buyPackage()">立即购买</a>-->
        <!--</div>-->
</div>
</body>
<script>
    var id = 0,
        type = 0,
        personNum = 0,   //套餐人数
        year = 0,
        month =0,
//            coin = getUrlParam("coin"),
        oldPersonNum = 0,    //老套餐人数
        afterPersonNum = 0,    //新套餐人数
        lastTime = "",            //升级前的有效期
        packagesNeedCoin ="",
        staffs =getUrlParam("staffs");   //公司人数
    $(function () {
        loadPackageMsg();
        console.log(staffs);
    })
    function editCompanyStaffCounts(){
        afterPersonNum = parseInt($('#upCompanyStaffCounts').val());
        if(afterPersonNum <= oldPersonNum){
            $('#decStaffs').attr('src',"/images/charge/icn_minus.png");
            $('#toastTip').text("套餐人数不得低于企业人数");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
                $('#toastTip').css("visibility","hidden");
            },3000);
            $('#nextStep').attr("href",'#');
            $('#nextStep').addClass("background_grey");
            $('#needToSpendCoin').text("--");
        }else if(afterPersonNum > oldPersonNum){
            $('#decStaffs').attr('src',"/images/charge/decrease-num.png");
            getCoinAfterUpPackage();
        }else{
            $('#decStaffs').attr('src',"/images/charge/icn_minus.png");
            $('#nextStep').attr("href",'#');
            $('#nextStep').addClass("background_grey");
            $('#needToSpendCoin').text("--");
        }
    }
    function loadPackageMsg() {
        $.ajax({
            url:'/mppay/getPurchasedPackages',
            type:'post',
            async:'false',
            contentType:'application/json',
            beforeSend:function (xhr) {
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            success:function (res) {
                var data = JSON.parse(res);
                if(data.result == 0){
                    if(staffs != null){
                        $('#upCompanyStaffCounts').val(staffs);
                        oldPersonNum = parseInt(staffs);
                        afterPersonNum = parseInt(staffs);
                    }else{
                        $('#upCompanyStaffCounts').val(data.data.personNum);
                        oldPersonNum = data.data.personNum;
                        afterPersonNum = data.data.personNum;
                    }
                    $(".flex_row_end input").attr('value',data.data.expiryDate.split(' ')[0]);
                    $("#upgradeTime").text(data.data.expiryDate.split(' ')[0]);
//                    $("#needToSpendCoin").text(coin);
                    year = data.data.year;
                    month = data.data.month;
                    personNum = data.data.personNum;
                    type = data.data.type;
                    id = data.data.id;
                    lastTime = data.data.expiryDate.split(' ')[0];
                    packagesNeedCoin = data.data.packagesNeedCoin;
                    if(staffs != null){
                        getCoinAfterUpPackage();
                    }
                }
            }
        })
    }
    //获得升级套餐后的应付加币数
    function getCoinAfterUpPackage() {
        var params = {
            "id":id,
            "type":type,
            "expiryDateAfterUpgrade":$('#upgradeTime').text(),
            "personNumAfterUpgrade":$("#upCompanyStaffCounts").val(),
            "personNum":personNum,
            "expiryDate":lastTime,
            "year":year,
            "month":month,
            "day":0
        }
        $.ajax({
            url:'/mppay/calPackagesNeedCoin',
            type:'post',
            contentType:'application/json',
            data:JSON.stringify(params),
            beforeSend:function (xhr) {
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            success:function (res) {
                var data = JSON.parse(res);
                if(data.result == 0){
                    if(data.data.packagesNeedCoinAfterUpgrade == 0){
                        $("#needToSpendCoin").text('--');
                        $('#nextStep').addClass("background_grey");
                        $('#nextStep').attr("href",'#');
                    }else{
                        $("#needToSpendCoin").text(toThousands(data.data.packagesNeedCoinAfterUpgrade));
                        var newPackageMsg = $("#upCompanyStaffCounts").val()+","+$('#upgradeTime').text()+","+data.data.packagesNeedCoinAfterUpgrade+","+packagesNeedCoin+","+data.data.type;
                        $("#nextStep").attr('href',"/charge/upgradeAfterPackage.html?newPackageMsg="+newPackageMsg);
                        $("#nextStep").removeClass("background_grey");
                    }
                }
            }
        })
    }
    //添加员工人数
    function addCompanyStaff() {
        $('#upCompanyStaffCounts').val(afterPersonNum+1);
        afterPersonNum = parseInt($('#upCompanyStaffCounts').val());
        if(afterPersonNum>oldPersonNum){
            $('#decStaffs').attr('src',"/images/charge/decrease-num.png");
        }
        getCoinAfterUpPackage();
    }
    //减少员工人数
    function decCompanyStaff() {
        if(staffs != null){
            if(afterPersonNum>staffs){
                $('#upCompanyStaffCounts').val(afterPersonNum-1);
                afterPersonNum = parseInt($('#upCompanyStaffCounts').val());
                if(afterPersonNum == staffs){
                    $('#decStaffs').attr('src',"/images/charge/icn_minus.png");
//                    $("#needToSpendCoin").text('--');
//                    $('#nextStep').addClass("background_grey");
//                    $('#nextStep').attr("href",'#');
                }
                getCoinAfterUpPackage();
            }else if(afterPersonNum == staffs){
                $('#toastTip').text("套餐人数不得低于企业人数");
                $('#toastTip').css("visibility","visible");
                setTimeout(function () {
                    $('#toastTip').css("visibility","hidden");
                },3000)
            }
        }else{
            if(afterPersonNum>oldPersonNum){
                $('#upCompanyStaffCounts').val(afterPersonNum-1);
                afterPersonNum = parseInt($('#upCompanyStaffCounts').val());
                if(afterPersonNum == oldPersonNum){
                    $('#decStaffs').attr('src',"/images/charge/icn_minus.png");
//                    $("#needToSpendCoin").text('--');
//                    $('#nextStep').addClass("background_grey");
//                    $('#nextStep').attr("href",'#');
                }
                getCoinAfterUpPackage();
            }else if(afterPersonNum == oldPersonNum){
                $('#toastTip').text("升级后人数不得小于当前套餐");
                $('#toastTip').css("visibility","visible");
                setTimeout(function () {
                    $('#toastTip').css("visibility","hidden");
                },3000)
            }
        }

    }
    function getDateTime() {
        console.info($('.timeFormatter').val());
        $('#upgradeTime').text($('.timeFormatter').val());
        var selectTimed = $('.timeFormatter').val();
        if(compareTime(selectTimed,lastTime)){
            getCoinAfterUpPackage();
        }else{
            $('#toastTip').text("升级后有效期不得小于当前有效期");
            $('#toastTip').css("visibility","visible");
            setTimeout(function () {
                $('#toastTip').css("visibility","hidden");
            },3000)

            $("#needToSpendCoin").text('--');
            $('#nextStep').addClass("background_grey");
            $('#nextStep').attr("href",'#');
        }
    }
    //判断日期，时间大小
    function compareTime(startDate, endDate) {
        var arrStartDate = startDate.split("-");
        var arrEndDate = endDate.split("-");
        var allStartDate = new Date(arrStartDate[0], arrStartDate[1], arrStartDate[2]);
        var allEndDate = new Date(arrEndDate[0], arrEndDate[1], arrEndDate[2]);
        console.info(allStartDate.getTime());
        console.info(allEndDate.getTime());
        if (allStartDate.getTime() >= allEndDate.getTime()) {
            return true;
        } else {
            return false;
        }
    }
</script>
</html>