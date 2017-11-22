<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币转账</title>
</head>
<body>
<div class="wrapper page ftsize15" id="account-transfer-page3" style="background:#efefef">
    <p style="font-size: smaller;padding-left: 0.32rem;height: .6rem;color: #999;">请核对转账信息</p>
    <div class="transfer-item">
        <div class="box">
           <span class="title">转账加币</span>
        </div><input id="transfer-login-transferAmount" readonly="1" class="ftsize15" type="text" >
    </div>
    <div class="transfer-item">
        <div class="box">
            <span class="title">接收人</span>
        </div><input id="transfer-login-receiveName" readonly="1" class="ftsize15" type="text">
    </div>
    <div class="transfer-item">
        <div class="box">
            <span class="title">接收公司</span>
        </div><input id="transfer-login-toCompanyName" readonly="1" class="ftsize15" type="text" >
    </div>

    <div class="transfer-item">
        <div class="box">
            <span class="title">登录密码</span>
        </div><input id="transfer-login-code" class="ftsize15" type="password" placeholder="请输入您的登录密码">
    </div>
    <div class="next_btn_box">
    <div id="transfer-submit" class="next_btn ftsize18 btn-active">
        转账
    </div>
        <div style="display:none" class="transfer3-mask"></div>
    </div>

</div>
<script>
    var mptoken = getUrlParam("mptoken");
    $(function(){
        var plusCoinAmount = +getUrlParam("plusCoinAmount");
        document.getElementById("transfer-login-transferAmount").value = toThousands(+getUrlParam("transferAmount"))+"个";
        var phone = getUrlParam("transferTel");
        document.getElementById("transfer-login-receiveName").value = decodeURI(getUrlParam("transferName"))+"("+phone.substring(phone.length-4,phone.length)+")";
        document.getElementById("transfer-login-toCompanyName").value = decodeURI(getUrlParam("toCompanyName"));

        $("#transfer-submit").click(function(){
            if($("#transfer-login-code").val()==""){
                openNoteModal("请输入登录密码");
                return false;
            }
            transferSubmit();
        });
    });

    function transferSubmit(){
        var params={};
        <%--params.url = '/lianlian/mppluscointransfer.htm';--%>
        params.url = '/mppay/mpPlusCoinTransfer';
        params.type = 'post';
        params.data = {
            amount:getUrlParam("transferAmount"),
            name:getUrlParam("transferName"),
            phone:getUrlParam("transferTel"),
            tocompanyId:getUrlParam("toCompanyId"),
            fromcompanyId:getUrlParam("fromCompanyId"),
            password:$("#transfer-login-code").val()
        };
        params.beforeSend = function(xhr){
            xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            $(".mask").css("display","block");
            $(".transfer3-mask").css("display","block");
        };
        params.complete = function(){
          $(".mask").css("display","none");
          $(".transfer3-mask").css("display","none");
        };
        params.success = function(data){
	
			var data = JSON.parse(data);
            if(data.result==0){
				var restAmount = +getUrlParam("plusCoinAmount") - parseInt(params.data.amount);
    <%--window.location.href='transfer-success.html';--%>
                window.location.href='transfer-success.html?receiveName='
                        +decodeURI(params.data.name)+'&' +
                        'restAmount='+ restAmount+'&'+
                        'transferAmount='+params.data.amount+'&'+
                        'phoneEnd='+params.data.phone.slice(-4,params.data.phone.length)+'&toCompanyName='+getUrlParam("toCompanyName");
            }else if(data.result==1){
			       $(".mask").css("display","none");
              	   openNoteModal(data.res_info);
            }
        }
        $.ajax(params);
    }
</script>
</body>
</html>