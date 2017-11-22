<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>充值</title>

</head>
<body>
<div class="wrapper page ftsize15 bdbox" id="plusChargePage" style="background:#efefef">
    <div class="plus-page-mask" style=" display:none;">
        <div class="modal bdbox">
            <div class="modal-box bdbox" style="position: relative;height: 100%;">
                <div class="text1 ftsize17 bdbox">其他数额</div>
                <div class="text2 ftsize13 bdbox">请输入需要充值的加币</div>
                <div class="input-money bdbox"><input style="text-indent:0.2rem" class="ftsize12" type="tel" placeholder="充值加币不能超过5,000个"></div>
                <p style="margin-top:.1rem;color: #F75C4C;font-size:smaller;" class="error-msg bdbox"></p>
                <div class="bdbox" style="position: absolute;bottom: 0;width:100%">
                    <div class="bdbox clearfix btn ftsize17"> <div class="fl bdbox cancel_btn">取消</div> <div class="fr bdbox ok_btn">确定</div> </div>
                </div>
            </div>
        </div>
    </div>
    <div id="content">
    <div id="overflowBox">
    <div id="employeeNum" class="clearfix bdbox hidden">
        <div class="fl title bdbox">企业人数</div>
        <div class="fr">

            <div class="emp-num-btn" ><img src="../../images/charge/decrease-num.png" id="employeeDe"/></div>
            <span id="employee">1</span>
            <div class="emp-num-btn"><img src="../../images/charge/increase-num.png" id="employeeIn"/></div>
        </div>
    </div>
    <div class="clearfix bdbox" id="timeForSale">
    <div class="fl bdbox title">购买加币</div>
    <div class="fr bdbox ftsize12">当前剩余加币&nbsp;<span id="plusBalence">475</span>&nbsp;</div>
    </div>
    <div class="timeWrapper bdbox">
        <ul class="clearfix bdbox">
            <li class="active bdbox" data-money="588" isBind="1" data-time="90">
                <div class="li-wrapper bdbox">
                        <div class="up bdbox ftsize17">588</div>
                        <div class="down bdbox ftsize12">加币</div>
                </div>
            </li>
            <li class="bdbox" data-money="998" isBind="1" data-time="180">
                <div class="li-wrapper bdbox">
                    <div class="up bdbox ftsize17">998</div>
                    <div class="down bdbox ftsize12">加币</div>
                </div>
            </li>
            <li class="bdbox" data-money="1998" isBind="1" data-time="365">
                <div class="li-wrapper  bdbox">
                    <div class="up bdbox ftsize17">1,998</div>
                    <div class="down bdbox ftsize12">加币</div>
                </div>
            </li>
            <li class="bdbox" data-money="2998" isBind="1" data-time="1095">
                <div class="li-wrapper bdbox">
                    <div class="up bdbox ftsize17">2,998</div>
                    <div class="down bdbox ftsize12">加币</div>
                </div>
            </li>
            <li class="bdbox" data-money="3998" isBind="1" data-time="1825">
                <div class="li-wrapper">
                    <div class="up ftsize17 bdbox">3,998</div>
                    <div class="down ftsize12">加币</div>
                </div>
            </li>
            <li class="bdbox" data-money="4998" isBind="1" data-time="1825">
                <div class="li-wrapper">
                    <div class="up ftsize17 bdbox">4,998</div>
                    <div class="down ftsize12">加币</div>
                </div>
            </li>
            <!-- <li class="bdbox optional-amount" data-money="0" isBind="1"  data-time="">
                <div class="li-wrapper bdbox">
                    <div class="up bdbox ftsize17">其他数额</div>
                    <div class="down bdbox ftsize12">（加币）</div>
                </div>
            </li> -->
    </div>
    <div class="timeWrapper tubeWrapper bdbox hidden">
    <div class="tube clearfix bdbox">
                <div class="fl bdboxs">
                    <div class="word-wrapper ftsize12 bdbox">
                        <div class="up"></div>
                        <div><span id="plusGift"></span>&nbsp;加币噢！</div>
                    </div>
                </div>
                <div class="fr" bdbox></div>
    </div>
    </div>
    <hr class="plus-recharge bdbox"/>
    <div class="final-money ftsize17" bdbox>
        实付 <span id="finalMoney" class="ftsize24"></span> 元
    </div>

    <div class="triangle"></div>
    <div class="recharge-btn active ftsize18">
    <a id="chargePage2" href="charge.html" data-error="ajax_error" data-mask="false" data-reload="false" data-root="root" data-callback="charge_callback">
    立即充值
    </a>
    </div>
    </div>
    </div>

</div>
<script type="text/javascript">
    var minChargeMoney=1000;
    var maxChargeMoney=50000;
    $(function(){
        dataReady();
        eventHandler();
        finalMoneyCal();
        $(".timeWrapper li").bind({click:li_click});
        loadPeriodMoney();
        loadFinalMoney();
        loadRewardMoney();
    });
    function eventHandler(){
        //购买时长点击事件
//        $(".timeWrapper li").click(function () {
//            if ($(this).hasClass("active")) {
//                $(this).siblings().removeClass("active");
//            } else {
//                $(this).addClass("active");
//                $(this).siblings().removeClass("active");
//            }
//            finalMoneyCal();
//        });
        //其他数额点击
        $(".timeWrapper li.optional-amount").click(function () {
            li_click();
            $(".plus-page-mask").css("display","block");
        });
        //员工人数增加减少点击
        $("#employeeIn").click(function () {
            $("#employee").html(parseInt($("#employee").html())+1);
            loadPeriodMoney();
            loadFinalMoney();
            loadRewardMoney();

        });
        $("#employeeDe").click(function () {
            if(parseInt($("#employee").html())>1){
                $("#employee").html(parseInt($("#employee").html())-1);
            }
            loadPeriodMoney();
            loadFinalMoney();
            loadRewardMoney();
        });
        //弹窗按钮点击
        $(".ok_btn").click(function () {
            if($("p.error-msg").html()==""&&$("div.input-money input").val()!="") {
            //if($("div.input-money input").val()!="") {

            $(".plus-page-mask").css("display", "none");
                $("p.error-msg").html("");
                var optionalAmount = $("div.input-money input").val();
                $("li.optional-amount").attr("data-money",optionalAmount);
                $("li.optional-amount div.down").html(toThousands(optionalAmount)+"&nbsp;加币");
                $("div.input-money input").val("");
                loadFinalMoney();
                loadRewardMoney();
            }
	    
        });
        $(".cancel_btn").click(function () {
            $(".plus-page-mask").css("display","none");
            $("p.error-msg").html("");
            $("div.input-money input").val("");
            var li=$(".timeWrapper li[isBind=1]")[0];
            if(li!=undefined&&!$(li).hasClass("optional-amount")){
                $(li).click();
            }

        });
        //弹窗输入框
        $("div.input-money input").keyup(function(){
            var inputMoney=$("#plusChargePage .input-money input").val();
            <%--if(inputMoneyCheck(inputMoney)&&parseInt($(this).val())>=minChargeMoney){--%>
            if(inputMoneyCheck(inputMoney)&&parseInt($(this).val())<=maxChargeMoney){
                $("p.error-msg").html("");
            }else if(!inputMoneyCheck(inputMoney)){
                $("p.error-msg").html("请输入整数数额");
            <%--}else if(parseInt($(this).val())<minChargeMoney){--%>
            }else if(parseInt($(this).val())>maxChargeMoney){
                <%--限额修改10.7--%>
                <%--$("p.error-msg").html("充值加币不可小于1,000");--%>
                $("p.error-msg").html("充值加币不可超过50,000个");
            }else{
                $("p.error-msg").html("");
            }

        });
    }
    //数据初始化
    function dataReady(){
        $(".mask").css("display","block");
        $("#plusBalence").html(getUrlParam("plusCoinAmount"));
        $("#employee").html(getUrlParam("empNum"));
	var url = $("#chargePage2").attr("href");
        $("#chargePage2").attr("href",addUrlParams(url,{
            companyId:getUrlParam("companyId")
        }));
        $(".mask").css("display","none");
    }
    //实付金额计算
    function finalMoneyCal(){
        var amount=+$(".timeWrapper li.active").attr("data-money");
        finalMoney=amount;
        return finalMoney;
    }
    function rewardMoneyCal(finalMoney){
        finalMoney=parseFloat(finalMoney);
        if(finalMoney<3000){
            rewardMoney=0;
        }else if(finalMoney<6000){
            rewardMoney=finalMoney*0.05;
        }else if(finalMoney<20000){
            rewardMoney=finalMoney*0.1;
        }else if(finalMoney<60000){
            rewardMoney=finalMoney*0.15;
        }else{
            rewardMoney=finalMoney*0.2;
        }
        return parseInt(rewardMoney);
    }
    function periodMoneyCal(time,empNum){
        // time= parseInt(time);
        // empNum =parseInt(empNum);
        // return time*empNum*2;
    }

    //加载时长加币
    function loadPeriodMoney(){
        var empNum=$("#employee").html();
        var period=$(".timeWrapper li:not(.optional-amount) div.down");
        $.each(period,function(i){
            var time = parseInt($(this).parent().parent("li").attr("data-time"));
            var periodMoney= parseInt($(this).parent().parent("li").attr("data-money"))
            // $(this).html(toThousands(periodMoneyCal(time,empNum))+"&nbsp;加币");
            // $(this).parent().parent("li").attr("data-money",periodMoneyCal(time,empNum));
            var li=$(this).parent().parent("li");
            <%--修改限额10.7--%>
            <%--if(periodMoney<minChargeMoney){--%>
            if(periodMoney>maxChargeMoney){
                if($(li).attr("isBind")==1){
                    $(li).unbind({click:li_click});
                    $(li).attr("isBind",0);
                }
                $(this).siblings().css("color","#a8a8a8");
                $(this).parent().parent("li").css("border","1px solid #a8a8a8");
            }else{
                if($(li).attr("isBind")==0){
                    $(li).bind({click:li_click});
                    $(li).attr("isBind",1);
                }
                $(this).siblings().css("color","#4a90e2");
                $(this).parent().parent("li").css("border","1px solid #4a90e2");
            }
        });
        //判定当前选中是大于充值限额
        <%--限额修改10.7--%>
        <%--if(parseInt($(".timeWrapper li.active").attr("data-money"))<minChargeMoney){--%>
        if(parseInt($(".timeWrapper li.active").attr("data-money"))>maxChargeMoney){
            var li=$(".timeWrapper li[isBind=1]")[0];
            if(li!=undefined){
                $(li).click();
            }
        }
    }
    //加载奖励性加币
    function loadRewardMoney(){
        var rewardMoney = rewardMoneyCal(finalMoney);
        if(rewardMoney==0){
            var addMoney = toThousands(3000-finalMoney);
            $(".tube .up").html('再多充值 <span style="color:#f75c4c">'+ addMoney +'</span> 加币即可获赠')
            $("#plusGift").html(toThousands(150));
        }else{
            $(".tube .up").html('现在充值该金额，小管子将额外奉上')
            $("#plusGift").html(toThousands(rewardMoneyCal(finalMoney)));
    }
    }
    function loadFinalMoney(){
        //加载充值金额

        $("#finalMoney").html(toThousands(finalMoneyCal()));
        var url = $("#chargePage2").attr("href");
        if(url.indexOf("chargeMoney")!=-1){
            var urlArray = url.split("?");
            var paraArray = urlArray[1].split("&");
            for (var i=0; j=paraArray[i];i++){
                if(j.indexOf("chargeMoney")!=-1){
                    paraArray.splice(i,1);
                }
            }
            var para = paraArray.join("&");
            url = urlArray[0] + "?" + para;
        }
        $("#chargePage2").attr('href','javascript:;');
        $("#chargePage2").unbind('click').bind('click',function(){
            window.webkit.messageHandlers.iOS.postMessage({"money":finalMoneyCal()});
        })

        // $("#chargePage2").attr("href",addUrlParams(url,{
        //     chargeMoney:finalMoney
        // }));
    }
    //购买时长选项点击
    function li_click(){
        if ($(this).hasClass("active")) {
            $(this).siblings().removeClass("active");
        } else {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");
        }
    loadFinalMoney();
    loadRewardMoney();
    }
</script>
</body>
</html>

