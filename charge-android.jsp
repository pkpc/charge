<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>充值</title>
    <!--<link rel="stylesheet" type="text/css" href="css/charge/packages.css">-->
    <!--<link rel="stylesheet" href="css/charge/mobilebone.css">-->
    <!--<link rel="stylesheet" href="css/charge/reset2.css" />-->
</head>
<body>
    <div class="content">
        <div style="height: 0.32rem;width:100%;"></div>
        <div class="charge-content">
            <div class="flex-row-start row44 ftsize15">
                <img src="/images/charge/pluscoin4package.png" class="img-plus">
                <span class="ftsize15">充值加币</span>
                <input type="number" class="input_border_none blue_color ml_20" oninput="inputCoinCount()" placeholder="请输入">
            </div>
            <div style="margin-left:16px;width:96%;height:2px;border-top:1px #ddd solid;" ></div>
            <div class="flex-row-start row44 ftsize15">
                <img src="/images/charge/icon_RMB.png" class="img-plus">
                <span class="">所需金额</span>
                <span id="chargeMoney" class="ml_20 blue_color ">0元</span>
            </div>
        </div>
        <div class="packageBottom">
            <a id="nextStep" href="javascript:void(0)" class="btn_a ftsize18 mt_100 background_grey">下一步</a>
        </div>
    </div>
</body>
<!--<script src="js/flexible.debug.js"></script>-->
<!--<script src="js/jquery/jquery-1.8.3.min.js"></script>-->
<!--<script src="js/mobilebone.js"></script>-->
<!--<script src="js/fastclick.js" ></script>-->
<script>
    function fmoney(s, n){
        n = n > 0 && n <= 20 ? n : 2;
        s = parseFloat((s + '').replace(/[^\d\.-]/g, '')).toFixed(n) + '';
        var l = s.split('.') [0].split('').reverse(),
            r = s.split('.') [1];
        var t = '';
        for (var i = 0; i < l.length; i++){
            t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? ',' : '');
        }
        return t.split('').reverse().join('');
    }

    function inputCoinCount() {
        var chargeMoney = $('input[type=number]').val();
        var companyId =getUrlParam("companyId");
        if(chargeMoney.length === 0){
            $('#chargeMoney').text("0元");
            $('#nextStep').attr('href',"javascript:void(0)");
            $('#nextStep').addClass("background_grey");
        }else{
            $('#chargeMoney').text(fmoney(chargeMoney)+"元");
            $('#nextStep').removeClass("background_grey");
            $('#nextStep').attr('href',"charge.html?companyId="+companyId+"&chargeMoney="+chargeMoney);
        }
    }
</script>
</html>