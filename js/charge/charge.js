function eventHandler() {
    $("#telNum").on("input propertychange",function () {
        if(checkPhone()){
            if ($("#telNum").val() != userTel) {
                $("li.test-code").slideDown();
            } else {
                $("li.test-code").slideUp();
            }
        }
        testNextBtn();
    });
    $("#idNum").on("input propertychange",function (){
        checkIdCard()
        testNextBtn();
    });
    $("#cardNum").on("input propertychange",function (){
        checkCard();
        testNextBtn();
    });
    $("#testCode").on("input propertychange",function(){
        countdown=0;
    })
    $("#getTestCode").click(function () {
        debugger
        $("#msg-error-msg").html("");
        $(".img-test-code").attr("src","/userphone/getimgverify?Math.random()");
        openModal();
    });
    $(".img-test-code").click(function () {
        $(this).attr("src", "/userphone/getimgverify?+Math.random()");
        $("#testCode").val("");
    });
    $("input.img_code_input").change(function () {
        $("p.error-msg").text("");
    });
    $("div.cancel_btn").click(function () {
        closeModal();
        $("p.error-msg").html("");
        $("div.test-code input").val("");
    });
    //获取短信验证码
    $("div.getMsgCode_btn").click(function () {
        var imgCode = $("input.img-test-code").val();
        var phoneTemp = $("#telNum").val();
        var params = {
            phoneNumber: phoneTemp,
            needmsg: "yes",//--------->需要发短信就加这个参数
            code: imgCode,
            reqSource: "PM"
        };
        $.ajax({
            url: "/userphone/checkimgverify",
            type: 'post',
            data: params,
            xhrFields: {
                withCredentials: true
            },
            crossDomain: true,
            dataType: "json",
            success: function (data) {
                if (data.result == "2") {
                    $("p.error-msg").text(data.res_info);
                } else if (data.result == "1") {
                    $("p.error-msg").text("验证码错误");
                } else {
                    if (data.sendresult == "1") {
                        $("p.error-msg").text(data.senddesc);
                    } else {
                        mid = data.mid;//--------->保存发送验证码的msgId
                        closeModal();
                        settime();
                    }
                }
            }
        });
    });
    //更换银行卡按钮
    $("#cardChange").click(function(){
        if(bankCard_had){
            if(defaultCard_use==true){
                defaultCardChange(1);
            }else{
                defaultCardChange(1);
            }
        }
    });
    //下一步
    $(".next_btn").click(function(){
        debugger
        if(checkIdCard()&&checkCard()&&checkPhone()){
            if($("#telNum").val() != userTel){//跟预设手机不一样，需要验证验证短信验证码
                checkMsg();
                var MsgTest = $("#testCode").attr("status");
                if(MsgTest=="true"){
                    paySubmit();
                }
            }else{
                paySubmit();
            }
        }
    });
    //验证码弹出框被输入法键盘遮挡
    $(".modal input").focus(function(){
        testInputWatch=1;
        countwatch=2;
        if(countwatch!=0){
            var int=self.setInterval("inputWatch()",00)
        }else{
            int=window.clearInterval(int);
        }
    });
    $(".modal input").blur(function(){
        testInputWatch=0;
    });
}
//短信验证码计时
function settime() {
    obj = document.getElementById("getTestCode");
    if (countdown == 0) {
        obj.removeAttribute("disabled");
        obj.value = "获取验证码";
        countdown = 60;
        return;
    } else {
        obj.setAttribute("disabled", true);
        obj.value = countdown + " s" + "";
        countdown--;
    }
    setTimeout(function () {
        settime(obj)
    }, 1000)
}
//弹窗
function openModal() {
    $("div.mask").fadeIn(300);
    $(".img-test-code").attr("src","/userphone/getimgverify?Math.random()");
}
function closeModal() {
    $("div.mask").fadeOut(300);
}
//校验短信验证码
function checkMsg() {
    var msgCodeTemp = $("#testCode").val();
    if(msgCodeTemp == undefined || msgCodeTemp == ''){
        $("#msg-error-msg").html("验证码不能为空");
        $("#msg-error-msg").slideDown();
        $("#testCode").attr("status","false");
        return false;
    }
    var params = {
        mid:mid,
        code:msgCodeTemp
    };
    $.ajax({
        async:false,
        type:"post",
        dataType:"json",
        url:"/mpapp/checkcode",
        data:params,
        error:function(){
            $("#msg-error-msg").html("验证码过期");
            $("#msg-error-msg").slideDown();
            return false;
        },
        success:function(data){
            //alert(data);
            //alert(data.status);
            if(data.status == "200"){
                $("#msg-error-msg").html("");
                $("#testCode").attr("status","true");
            }else{
                $("#msg-error-msg").html("验证码过期");//400
                $("#msg-error-msg").slideDown();
                $("#testCode").attr("status","false");
            }
        }
    });
}
//输入框格式检查
function checkIdCard(){
    if($("#telNum").attr("disabled")==true){
        return true;
    }else{
        var idCardTemp = $("#idNum").val();
        if(isNullReg.test(idCardTemp)){
            $("#id-error-msg").html("身份证不能为空");
            $("#id-error-msg").slideDown();
            return false;
        }else if(!idCardReg.test(idCardTemp)){
            $("#id-error-msg").html("请输入正确的身份证");
            $("#id-error-msg").slideDown();
            return false;
        }else{
            $("#id-error-msg").html("");
            $("#id-error-msg").slideUp();
        }
        return true;
    }

}
function checkCard(){
    //如果不存在，返回true
    if($("#cardNum").css("display")!="none"){
        var cardTemp = $("#cardNum").val();
        if(isNullReg.test(cardTemp)){
            $("#card-error-msg").html("银行卡号不能为空");
            $("#card-error-msg").slideDown();
            return false;
        }else if(!cardReg.test(cardTemp)){
            $("#card-error-msg").html("请输入正确的银行卡号");
            $("#card-error-msg").slideDown();
            return false;
        }else{
            $("#card-error-msg").html("");
            $("#card-error-msg").slideUp();
        }
        return true;
    }else{
        return true;
    }

}
function checkPhone(){
    var phoneTemp = $("#telNum").val();
    if(isNullReg.test(phoneTemp)){
        $("#tel-error-msg").html("手机号不能为空");
        $("#tel-error-msg").slideDown();
        return false;
    }else if(!phoneReg.test(phoneTemp)){
        $("#tel-error-msg").html("请输入正确的手机号");
        $("#tel-error-msg").slideDown();
        return false;
    }else{
        $("#tel-error-msg").html("");
        $("#tel-error-msg").slideUp();
        $("#msg-error-msg").html("");
    }
    return true;
}
function testNextBtn(){
    if(checkIdCard()&&checkCard&&checkPhone()){
        $(".next_btn").addClass("btn-active");
    }else{
        $(".next_btn").removeClass("btn-active");
    }
}
//提交
function paySubmit(){
    var params = {};
    params.amount = $("#rechargeMoney").html();
    if(defaultCard_use){
        params.cardNo=defaultCard;
        var cardNo=$("#cardNum_had").val();
    }else{
        params.cardNo=$("#cardNum").val();
        var cardNo=$("#cardNum").val();
    }
    var bankId_sub = cardNo.substring(0, 6);
    params.bankId = getCardId(bankId_sub);
    params.name = $("#userName").html();
    params.idCard = $("#idNum").val();
    params.companyId = urlParams.companyId;
    params.url_return="https://www.plusmoney.cn/charge/recharge-success.html";
    var url = "/lianlian/mplianlianpaycharge.htm"
    var urlparams = addUrlParams(url,params);
    $.ajax({
        url: "/lianlian/mplianlianpaycharge.htm",
        type: 'post',
        async:false,
        data: params,
        xhrFields: {
            withCredentials: true
        },
        crossDomain: true,
        dataType: "html",
        success:function(data){
            $('body').html(data) ;
        }
    });
}
//获取银行卡号、身份证号
function getCardNo(){
    $.ajax({
        type:"get",
        url:"/h5/mpBankCardList.htm",
        async:false,
        success:function (data) {
            debugger
            var data = $.parseJSON(data)
            if(data.code==4){
                if(typeof(data.idNum)!="undefined"){
                    $("#idNum").val(data.idNum);
                    if(data.lockEdit=="1"){
                        $("#idNum").attr("disabled",true);
                    }
                }
                if(typeof(data.realName)!="undefined"){
                    $("#userName").html(data.realName);
                    if(data.items!=undefined&&data.items.length!=0){
                        bankCard_had=true;
                        defaultCard_use=true;
                        defaultCardChange(0);
                        $("#cardNum_had").val(data.items[0].F05);
                        defaultCard=data.items[0].F06;
                    }else{
                        defaultCardChange(0);
                    }
                }
            }else{
                defaultCardChange(0);
            }
        }
    });
}
//获取手机号
function getUserInfo(){
    $.ajax({
        type:"post",
        url:"/userphone/getuserinfo",
        async:false,
        success:function(data){
            var data = $.parseJSON(data)
            if(data.result==0){
                if(typeof(data.data.phoneNumbers)!="undefined"){
                    $("#telNum").val(data.data.phoneNumbers);
                    userTel=data.data.phoneNumbers;
                }
            }
        }
    });
}
//默认卡号获取
function defaultCardChange(e){
    if(bankCard_had==true){
        $("#cardNum_had").css("display","inline");
        $("#cardChange").css("display","inline");
        $("#cardNum").css("display","none");
        cardNum_exist=false;
        if(e==1){//1更换银行卡点击事件，0加载事件
            if(defaultCard_use==true){
                $("#cardChange").val("使用默认银行卡");
                $("#cardNum").css("display","inline");
                $("#cardNum_had").css("display","none");
                defaultCard_use=false;
            }else{
                $("#cardChange").val("更换银行卡");
                $("#cardNum").css("display","none");
                $("#cardNum_had").css("display","inline");
                cardNum_exist=true;
                submitCard="";//当submitcard为空，用输入方式输入银行卡
                defaultCard_use=true;
            }
        }

    }
    else{
        $("#cardNum_had").css("display","none");
        $("#cardChange").css("display","none");
        $("#cardNum").css("display","inline");
        submitCard="";
        cardNum_exist=true;
    }
}
//验证码输入框位置检查
function inputWatch(){
    if(testInputWatch==1){
        $(".modal").css("position","relative");
        $("body").scrollTop(parseInt($("body").height())/4);
    }else{
        $(".modal").css("position","absolute");
    }
}

