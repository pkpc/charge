<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币转账</title>
</head>
<body>
<div class="wrapper page ftsize15" id="account-transfer-page1" style="background:#efefef">
    <div class="transfer-amount-item">
        <span class="title">转账加币数(个)</span>
        <input id="transfer-amount" class="ftsize15" type="tel" placeholder="">
    </div>
    <div class="next_btn ftsize18">
        <a id="account-transfer2" href="javascript:void(0)" data-error="ajax_error" data-mask="false" data-reload="false" data-root="root" data-callback="charge_callback">
            下一步
        </a>
    </div>

</div>
<script>
    $(function(){
        var plusCoinAmount = +getUrlParam("plusCoinAmount");
        $("#transfer-amount").attr("placeholder","当前可用加币"+ toThousands(plusCoinAmount)+"个");
        //激活下一步按钮
        $("#transfer-amount").on("input propertychange",function(){
            var inputAmount = $("#transfer-amount").val();//空，
            $("#account-transfer2").attr("href","javascript:void(0)");
            if(inputAmount==""){
				$("#account-transfer2").parent().removeClass("btn-active");
                return;
            }else if(!inputMoneyCheck(inputAmount)){
                $("#account-transfer2").parent().removeClass("btn-active");
                if(inputAmount==0){
                    openNoteModal("请输入大于0的数额")
                }else{
                    openNoteModal("请输入整数数额");
                }
            }else if(inputAmount>parseInt(plusCoinAmount)){
			
                $("#account-transfer2").parent().removeClass("btn-active");
                openNoteModal("当前可用加币不足");
            }else{
                $("#account-transfer2").attr("href","account-transfer2.html?transferAmount="+inputAmount+'&fromCompanyId='+getUrlParam("fromCompanyId"));
                $("#account-transfer2").parent().addClass("btn-active");
            }
        });
    });
</script>
</body>
</html>