<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币套餐</title>
</head>
<body>
    <div class="content">
        <div class="packageContent">
            <div class="pd15">
                <div>当前套餐</div>
                <div class="packageSmallBox mt_12">
                    <div class="pd18">
                        <div id="packageName" class="ftsize17 black_color"></div>
                        <div class="flex_row_betweent ftsize12 mt_16 grey_color">
                            <div>
                                <span>购买日期</span><span id="purchaseCoinTime" class="ml_5"></span>
                            </div>
                            <div>
                                <span>有效期至</span><span id="isUseToTime" class="ml_5"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="packageBottom">
            <a href="/charge/upgradePackage.html" class="btn_a ftsize18 mt_50">升级套餐</a>
        </div>
    </div>
</body>
<script>
    $(function () {
        loadPackageMsg();
    })
    function loadPackageMsg() {
        $.ajax({
            url:'/mppay/getPurchasedPackages',
            type:'post',
            contentType:'application/json',
            beforeSend:function (xhr) {
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            success:function (res) {
                var data = JSON.parse(res);
                if(data.result == 0){
                    $('#packageName').text(data.data.personNum+'人套餐');
//                    if(data.data.month == 6){
//                        $('#packageName').text(data.data.personNum+'人'+data.data.month+'个月套餐');
//                    }else{
//                        $('#packageName').text(data.data.personNum+'人'+data.data.year+'年期套餐');
//                    }
                    $('#purchaseCoinTime').text(data.data.buyTime.split(' ')[0]);
                    $('#isUseToTime').text(data.data.expiryDate.split(' ')[0]);
//                    $(".packageBottom a").attr('href','/mppaytest/upgradePackage.jsp?coin='+data.data.packagesNeedCoin);
                }
            }
        });
    }
</script>
</html>