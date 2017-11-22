<!DOCTYPE html>
<html lang="en">

<head>
    <title>转账明细</title>
</head>

<body>
    <div class="wrapper page" id="accountPluscoinDetailsPage" style="background:#fff">
        <div class="content">
            <div class="pluscoin-title text-center mt67 ">
                <div class="mb31"><img class="pluscoin-status-bg" src="" alt=""></div>
                <p class="pluscoin-status fs_17 mb10 fc_777"></p>
                <p class="fs_13 mb106 fc_999 flex-item">
                    <span class="pluscoin-out"></span>
                    <span class="fs_17">→</span>
                    <span class="pluscoin-in"></span>
                </p>
            </div>
            <div class="bars-group fs_15">
                <div class="base-bar">
                    <span class="details-title"></span>
                    <span class="details-value"></span>
                </div>
                <div class="base-bar">
                    <span class="details-title"></span>
                    <span class="details-value"></span>
                </div>
                <div class="base-bar">
                    <span class="details-title"></span>
                    <span class="details-value"></span>
                </div>
                <div class="base-bar">
                    <span class="details-title"></span>
                    <span class="details-value"></span>
                </div>
            </div>
        </div>
    </div>
    <script>
    var token = getUrlParam('mptoken');
    var urlParams = {
        tradeType:getUrlParam('tradeType'),
        tradeId:getUrlParam('tradeId'),
        accountId:getUrlParam('accountId'),
        userName:decodeURI(getUrlParam('userName'))
    }

    var reqParams = {};
    reqParams.id = urlParams.tradeId;
    reqParams.pmCompanyId = urlParams.accountId;
    $.ajax({
        url:"/mppay/getTranferCoinWaterDetail",
        type:"POST",
        data:JSON.stringify(reqParams),
        headers:{
            "Authorization":"Bearer " + token
        },
        contentType:"application/json",
        dataType:"JSON",
        success:function(data){
            if(data.result=='0'){
                    var resData = data.data;
                    var resAdPhone = resData.adminPhone;
                    var lastFourPhone = resAdPhone.substring(resAdPhone.length-4,resAdPhone.length);
                    if(urlParams.tradeType=='22'){
                        //转出
                        $('.pluscoin-status-bg').attr("src","../../images/charge/img-bg-transform-out.png");
                        $('.pluscoin-status').text("加币转出");
                        $('.pluscoin-out').text(resData.accountName).addClass("fc_blue");
                        $('.pluscoin-in').text(resData.tranferPerson);
                        $('.details-value').eq(1).text(resData.payout+"个");
                        $('.details-title').eq(1).text("转出加币");
                        $('.details-title').eq(2).text("接收人");
                        $('.details-title').eq(3).text("接收公司");
                    }else{
                        //转入
                        $('.pluscoin-status-bg').attr("src","../../images/charge/img-bg-transform-in.png");
                        $('.pluscoin-status').text("加币转入");
                        $('.pluscoin-in').text(resData.accountName).addClass("fc_blue");
                        $('.pluscoin-out').text(resData.tranferPerson);
                        $('.details-value').eq(1).text(resData.income+"个");
                        
                        $('.details-title').eq(1).text("转入加币");
                        $('.details-title').eq(2).text("发起人");
                        $('.details-title').eq(3).text("发起公司");
                    }
                    $('.details-title').eq(0).text("转账时间");
                    $('.details-value').eq(0).text(formatDate(resData.tranferTime));
                    $('.details-value').eq(2).text(resData.tranferPerson+"("+lastFourPhone+")");
                    $('.details-value').eq(3).text(resData.tranferCompanyName);

            }
        }
    })



    function formatDate(tradeTime) {
        var time = new Date(parseInt(tradeTime));
        var year = time.getFullYear().toString();
        var month = (time.getMonth() + 1).toString();
        var day = time.getDate().toString();
        var h = time.getHours().toString();
        var mm = time.getMinutes().toString();
        month = month.length == 2 ? month : '0' + month;
        day = day.length == 2 ? day : '0' + day;
        h = h.length == 2 ? h : '0' + h;
        mm = mm.length == 2 ? mm : '0' + mm;
        var date = year + '-' + month + '-' + day + '  ' + h + ':' + mm;
        return date;
    }
    </script>
</body>

</html>
