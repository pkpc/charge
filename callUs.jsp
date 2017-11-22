<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>预约演示</title>
</head>
<body>
    <div class="content ">
        <div class="flex_col_betweent">
            <div class="flex_col_start">
                <div class="bg_callUs">
                </div>
                <!--<div>-->
                    <!--<img src="images/charge/callUs.png" style="width: 100%;height: 5.227rem;">-->
                <!--</div>-->
                <div class="mt_20 rows_2">
                    <div class="row44 ftsize14">
                        <div class="flex_row_start pd_16">
                            <div class="flex_row_start" style="width: 3rem;">
                                <span class="ml_5">姓名</span>
                            </div>
                            <input id="callName" oninput="checkForm()" class="input_border_none ftsize14" type="text" placeholder="请输入姓名"></input>
                        </div>
                    </div>
                    <div style="margin-left:0.4267rem;width:96%;height:0.053rem;border-top:0.0267rem #ddd solid;"></div>
                    <div class="row44 ftsize14">
                        <div class="flex_row_start pd_16">
                            <div class="flex_row_start" style="width: 3rem;">
                                <span class="ml_5">职位</span>
                            </div>
                            <input id="callPosition" oninput="checkForm()" class="input_border_none ftsize14" type="text" placeholder="请输入职位"></input>
                        </div>
                    </div>
                    <div style="margin-left:0.4267rem;width:96%;height:0.053rem;border-top:0.0267rem #ddd solid;"></div>
                    <div class="row44 ftsize14">
                        <div class="flex_row_start pd_16">
                            <div class="flex_row_start" style="width: 3rem;">
                                <span class="ml_5">公司</span>
                            </div>
                            <input id="callCompany" oninput="checkForm()" class="input_border_none ftsize14" type="text" placeholder="请输入公司名"></input>
                        </div>
                    </div>
                    <div style="margin-left:0.4267rem;width:96%;height:0.053rem;border-top:0.0267rem #ddd solid;"></div>
                    <div class="row44 ftsize14">
                        <div class="flex_row_start pd_16">
                            <div class="flex_row_start" style="width: 3rem;">
                                <span class="ml_5">手机号</span>
                            </div>
                            <input id="callPhone" oninput="checkForm()" class="input_border_none ftsize14" type="text" placeholder="请输入手机号码"></input>
                        </div>
                    </div>
                </div>
            </div>
            <div style="margin-bottom: 1.16rem;">
                <div class="pd_16">
                    <a id="appointment" href="#" class="btn_a_grey ftsize18">确认预约</a>
                </div>
            </div>
        </div>

    </div>
    <div id="modalTip" style="display: none;" >
        <img src="/images/charge/appointment.png" class="modal_tip" style="width: 3.68rem;height: 3.173rem;;">
    </div>

</body>
<script>
    var companyName = decodeURI(getUrlParam("companyName"));
    var mptoken = getUrlParam("mptoken");
    var ftoken=getUrlParam("ftoken");
    var isAdmin=getUrlParam("isAdmin");
    var isxigu=getUrlParam("isxigu");
    var plusCoinReward=getUrlParam("plusCoinReward");
    var userName=decodeURI(decodeURI(getCookie("userName")));

    var reqParams ="mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;
    console.log(companyName);
    $("#callCompany").val(companyName);
    function checkForm() {
        if($('#callName').val()!="" && $('#callPosition').val()!="" && $('#callCompany').val()!="" && $('#callPhone').val().length==11){
            $('#appointment').removeClass("btn_a_grey");
            $('#appointment').addClass("btn_a");
//            if($('#callPhone').val().length ==11){
                resumeBtn();
//            }
        }else{
            $('#appointment').removeClass("btn_a");
            $('#appointment').addClass("btn_a_grey");
            suspendBtn();
        }
    }
    //挂起按钮
    function suspendBtn(){
        $("#appointment").unbind();
    }
    function resumeBtn() {
        $('#appointment').on('click',function () {
            var params ={
                "name":$("#callName").val(),
                "position":$("#callPosition").val(),
                "companyName":$("#callCompany").val(),
                "phoneNum":$("#callPhone").val()
        }
            $.ajax({
                url:'https://www.plusmoney.cn/feedback/confirmToBespokeInMp',
                type:'POST',
                dataType : "jsonp",
                jsonp: "callbackparam",
                jsonpCallback:"jsonpCallback1",
                dataType:"json",
                contentType:'application/json',
                data:JSON.stringify(params),
                beforeSend:function(xhr){
                    xhr.setRequestHeader("Authorization","Bearer "+mptoken);
                },
                success:function (data) {
//                    var data = JSON.parse(res);
                    if(data.result == 0){
                        $('#modalTip').css('display','block');
                        window.setTimeout(function () {
                            $('#modalTip').css('display','none');
                            window.location.href = "//www.plusmoney.cn/charge/index.html?"+reqParams;
                        },1000)
                    }else{
                        openMessageModal('<p>'+data.res_info+'</p>')
                    }
                }
            })
        });
    }
</script>
</html>