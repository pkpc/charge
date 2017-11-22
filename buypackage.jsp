<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>包年套餐</title>
    <style>

    </style>
</head>
<body>
    <div class="wrapper page ftsize15" id="chargePage" style="background:#efefef">
        <div class="charge-page-mask" style="visibility: visible; display:none;">
            <div class="modal">
                <div class="test-modal-box">
                    <p class="ftsize17">获取短信验证码</p>
                    <div class="test-code clearfix">
                        <div class="fl">
                            <img class="img-test-code" src="http://www.plusmoney.cn/userphone/getimgverify?+Math.random()" alt="text-code">
                        </div>
                        <div class="fr ftsize12"><input class="ftsize14 img-code-input" type="text" placeholder="请输入验证码">
                        </div>
                    </div>
                    <p class="error-msg ftsize13" id="img-error-msg" style="padding: 0;color: #F75C4C;"></p>
                        <div class="clearfix charge-money-btn ftsize17"> <div class="fl cancel_btn">取消</div> <div class="fr getMsgCode_btn">获取</div> </div>
                </div>
            </div>
        </div>
        <div class="box">
        <ul id="recharge">
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-money"></span><span class="title">充值金额</span>
                </div><span id="rechargeMoney"></span>元
            </li>
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-name"></span><span class="title">姓名</span>
                </div><input id="userName" class="ftsize15" type="text" placeholder="请输入">
            </li>
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-phone"></span><span class="title">手机号</span>
                </div><input id="telNum" class="ftsize15" type="tel" placeholder="请输入">
            </li>
            <li class="clearfix test-code" style="display: none;">
                <div class="box">
                <span class="item-icon icon-test-code"></span><span class="title">验证码</span>
                </div><input id="testCode" class="ftsize15" type="tel" placeholder="请输入">
                <input type="button" id="getTestCode" class="ftsize12" value="获取验证码">

            </li>
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-id-card"></span><span class="title">身份证</span>
                </div><input id="idNum" class="ftsize15" type="text" placeholder="请输入">
            </li>
            <li class="clearfix">
                <div class="box">
                <span class="item-icon icon-card"></span><span class="title">银行卡</span>
                </div><input id="cardNum" class="ftsize15" type="tel" placeholder="请输入"><input id="cardNum_had" disabled="true" type="text" class="ftsize15 input-hidden" value="">
            </li>
        </ul>
        <p style="height: .7733333rem;line-height: .7733333rem;">
        <img class="charge-note" src="/images/charge/charge-note.png" style="margin: .08rem .1333333rem 0 .506666666rem;vertical-align: -2px;">
        <span class="charge-error-msg ftsize13" style="color: #F75C4C;">身份证不能为空</span>
        </p>
        <div class="next_btn ftsize18">
           下一步
    </div>
        </div>
    </div>
    <script type="text/javascript">
    var userTel=""
    var defaultCard="";
    var defaultCard_use=false;

    var countdown = 60;
    var idCardReg = /(^\d{15}$)|(^\d{17}([0-9]|X|x)$)/;
    var cardReg = /^\d{10,25}$/;
    var mid = null;
    var isRealName=true;
    var isxigu;
    Mobilebone.callback = function(pagein, pageout){
    	if(pagein.id == "chargePage"){
		dataReady();
	  }
    }
    $(function(){
    	if(isxigu==1){
        	var params = geturlParams();
            location.href='/charge/index.html?'+params;
        }
        dataReady();
        eventHandler();     
        $(".charge-error-msg").html("");
        $(".charge-note").css("visibility","hidden");
    });
    function dataReady(){
        getCardNo();
        getUserInfo();
        getRealNameCheck();
	    $("#rechargeMoney").html(getUrlParam("chargeMoney"));
        //$("#rechargeMoney").html(urlParams.username);
    }
    function eventHandler() {
        $("#telNum").on("input propertychange",function () {
            testNextBtn();
            if(checkPhone()){
                if ($("#telNum").val() != userTel) {
                    $("li.test-code").slideDown();
                } else {
                    $("li.test-code").slideUp();
                }
            }
        });
        $("#userName").on("input propertychange",function (){
            testNextBtn();
            checkName();
        });
        $("#idNum").on("input propertychange",function (){
            testNextBtn();
            checkIdCard();
        });
        $("#cardNum").on("input propertychange",function (){
            testNextBtn();
            checkCard();
        });
        $("#testCode").on("input propertychange",function (){
            testNextBtn();
            checkName();
	        countdown=0;
        });

        $("#getTestCode").click(function () {
            if(checkPhone()==true){
	       	$("input.img-code-input").val("");
                $(".img-test-code").attr("src","http://www.plusmoney.cn/userphone/getimgverify?Math.random()");
                openModal();
            }

        });
        $(".img-test-code").click(function () {
            $(this).attr("src", "http://www.plusmoney.cn/userphone/getimgverify?+Math.random()");
            $("#testCode").val("");
        });
        $("input.img-code-input").on("input propertychange",function () {
            $("#img-error-msg").text("");
        });
        $("div.cancel_btn").click(function () {
            closeModal();
            $("#img-error-msg").html("");
            $("div.test-code input").val("");
        });
        //获取短信验证码
        $("div.getMsgCode_btn").click(function () {
            var imgCode = $("input.img-code-input").val();
            var phoneTemp = $("#telNum").val();
            var params = {	
                phoneNumber: phoneTemp,
                needmsg: "yes",//--------->需要发短信就加这个参数
                code: imgCode
            };
            $.ajax({
                url: "http://www.plusmoney.cn/userphone/checkimgverify",
                type: 'post',
                data: params,
                dataType: "json",
                success: function (data) {
                    if (data.result == "2") {
                        $("#img-error-msg").text(data.res_info);
                    } else if (data.result == "1") {
                        $("#img-error-msg").text("验证码错误");
                    } else {
                        if (data.sendresult == "1") {
                            $("#img-error-msg").text(data.senddesc);
                        } else {
                            mid = data.mid;//--------->保存发送验证码的msgId
                            closeModal();
                            settime();
                        }
                    }
                }
            });
        });

        //下一步
        $(".next_btn").click(function(){
            debugger
            if(checkIdCard()&&checkCard()&&checkPhone()){
                if($("#telNum").val() != userTel){//跟预设手机不一样，需要验证验证短信验证码
                    checkMsg();
                    var MsgTest = $("#testCode").attr("status");
                    if(MsgTest=="true"){
                        if(isRealName==true){
                            paySubmit();
                        }else{
                            realNameCheck();
                            paySubmit();
                        }
                    }
                }else{
                   if(isRealName==true){
                            paySubmit();
                        }else{
                            realNameCheck();
                            paySubmit();
                        }
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
            $("div.charge-page-mask").fadeIn(300);
            $(".img-test-code").attr("src","http://www.plusmoney.cn/userphone/getimgverify?Math.random()");
        }
    function closeModal() {
            $("div.charge-page-mask").fadeOut(300);
        }
    function checkMsgNull(){
        var msgCodeTemp = $("#testCode").val();
        if(msgCodeTemp == undefined || msgCodeTemp == ''){
            $(".charge-error-msg").html("验证码不能为空");
            $(".charge-note").css("visibility","visible");
            $("#testCode").attr("status","false");
            return false;
        }else{
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");
        }
        return true;
    }
    //校验短信验证码
    function checkMsg() {
    var msgCodeTemp = $("#testCode").val();
    var params = {
        mid:mid,
        code:msgCodeTemp
    };
    $.ajax({
        async:false,
        type:"post",
        dataType:"json",
        url:"http://www.plusmoney.cn/mpapp/checkcode",
        data:params,
        error:function(){
            $(".charge-error-msg").html("验证码错误或过期");
            $(".charge-note").css("visibility","visible");
            return false;
        },
        success:function(data){

            if(data.status == "200"){
                $(".charge-error-msg").html("");
                $(".charge-note").css("visibility","hidden");
                $("#testCode").attr("status","true");
            }else{
                $(".charge-error-msg").html("验证码错误或过期");//400
                $(".charge-note").css("visibility","visible");
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
            $(".charge-error-msg").html("身份证不能为空");
            $(".charge-note").css("visibility","visible");
            return false;
        }else if(!idCardReg.test(idCardTemp)){
            $(".charge-error-msg").html("请输入正确的身份证");
            $(".charge-note").css("visibility","visible");
            return false;
        }else{
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");
        }
        return true;
    }

}
    function checkCard(){
    //如果不存在，返回true
    if($("#cardNum").css("display")!="none"){
        var cardTemp = $("#cardNum").val();
        if(isNullReg.test(cardTemp)){
            $(".charge-error-msg").html("银行卡号不能为空");
            $(".charge-note").css("visibility","visible");
            return false;
        }else if(!cardReg.test(cardTemp)){
            $(".charge-error-msg").html("请输入正确的银行卡号");
            $(".charge-note").css("visibility","visible");
            return false;
        }else{
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");
        }
        return true;
    }else{
        return true;
    }

}
    function checkPhone(){
    var phoneTemp = $("#telNum").val();
    if(isNullReg.test(phoneTemp)){
        $(".charge-error-msg").html("手机号不能为空");
        $(".charge-note").css("visibility","visible");
        return false;
    }else if(!phoneReg.test(phoneTemp)){
        $(".charge-error-msg").html("请输入正确的手机号");
        $(".charge-note").css("visibility","visible");
        return false;
    }else{
        $(".charge-error-msg").html("");
        $(".charge-note").css("visibility","hidden");
        $(".img-error-msg").html("");
    }
    return true;
}
    function checkName(){
        var nameTemp = $("#userName").val();
        if(isNullReg.test(nameTemp)){
            $(".charge-error-msg").html("姓名不能为空");
            $(".charge-note").css("visibility","visible");
            return false;
        }else if(!nameReg.test(nameTemp)){
            $(".charge-error-msg").html("请输入正确格式的姓名");
            $(".charge-note").css("visibility","visible");
            return false;
        }
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");
            return true;
    }
    function testNextBtn(){
        if($("#telNum").val() != userTel){
            if(checkName()&&checkPhone()&&checkMsgNull()&&checkIdCard()&&checkCard()){
                $(".next_btn").addClass("btn-active");
            }else{
                $(".next_btn").removeClass("btn-active");
            }
        }else{
            if(checkName()&&checkPhone()&&checkIdCard()&&checkCard()){
                $(".next_btn").addClass("btn-active");
            }else{
                $(".next_btn").removeClass("btn-active");
            }
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
        params.bankId = "20";
        params.name = $("#userName").val();
        params.idCard = $("#idNum").val();
        params.companyId = getUrlParam("companyId");
        $.ajax({
            url: "http://www.plusmoney.cn/lianlian/mplianlianpaycharge.htm",
            type: 'post',
            async:false,
            data: params,
            xhrFields: {
                withCredentials: true
            },     
            crossDomain: true,
            success:function(data){
                try{
                    data=JSON.parse(data);
                    openMessageModal(data.msg)
                }
            catch(err){
	    	if(data.code=!undefined&&data.code==4444){
		        openMessageModal(data.msg);
		    }else{
		        $(".wrapper").html(data);
		    }
            }
        }
        });
}
    //获取银行卡号、身份证号
    function getCardNo(){
    $.ajax({
        type:"get",
        url:"http://www.plusmoney.cn/h5/mpBankCardList.htm",
        async:true,
        success:function (data) {
            var data = $.parseJSON(data);
            if(data.code==4){
                $("#userName").val(data.realName);
                if(typeof(data.idNum)!="undefined"){
                    $("#idNum").val(data.idNum);
                    if(data.lockEdit=="1"){
                        $("#idNum").attr("disabled",true);
                        $("#userName").attr("disabled",true);
                       }
                }
                if(typeof(data.realName)!="undefined"){
                    if(data.items!=undefined&&data.items.length!=0){//有默认卡号
                        defaultCard_use = true;
                        $("#cardNum_had").css("display","inline");
                        $("#cardNum").css("display","none");
                        $("#cardNum_had").val(data.items[0].F05);
                        defaultCard=data.items[0].F06;
                    }else{
                        $("#cardNum_had").css("display","none");
                        $("#cardNum").css("display","inline");
                    }
                }
                testNextBtn();
            }
        },
        complete: function(){
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");}
    });
}
    //获取手机号
    function getUserInfo(){
    $.ajax({
        type:"post",
        url:"http://www.plusmoney.cn/userphone/getuserinfo",
        async:true,
        success:function(data){
            var data = $.parseJSON(data)
            if(data.result==0){
                if(typeof(data.data.phoneNumbers)!="undefined"){
                    $("#telNum").val(data.data.phoneNumbers);
                    userTel=data.data.phoneNumbers;
                    testNextBtn();
                }
            }
        },
        complete:function(data){
            $(".charge-error-msg").html("");
            $(".charge-note").css("visibility","hidden");
        }
    });
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
        //实名认证
    function realNameCheck(){
        var params= {
            usrName:$("#userName").val(),
            usrMp:$("#telNum").val(),
            certId:$("#idNum").val(),
            isMp:1
        }
        $.ajax({
            url:"http://www.plusmoney.cn/pay/localCommitToHuifu.htm",
            type:'post',
            data:params,
	    async:false,
            success:function (data) {
                data = $.parseJSON(data);
                if(data.result=="2"){
                console.log("已经实名认证过");
                }else if(data.result=="1"){
                console.log("实名认证成功");
                }else if(data.result=="0"){
                console.log("实名认证失败");
            }
        }
    });
    }
    function getRealNameCheck(){
        $.post("http://www.plusmoney.cn/pay/isUserTg.htm",function(data){
	        var $data = $.parseJSON(data);
	        if($data.respCode==000){
	        debugger
	            isRealName = true;
	        }else {
	            isRealName = false;
	        }
    	});

    }
</script>
    <script src="/js/bank-card-id.js"></script>
</body>
</html>