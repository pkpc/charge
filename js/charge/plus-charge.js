//实付金额计算
function finalMoneyCal(){
    var amount=parseInt($(".timeWrapper li.active").attr("data-money"));
    finalMoney=amount/10;
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
    time= parseInt(time);
    empNum =parseInt(empNum);
    return time*empNum*6;
}

//加载时长加币
function loadPeriodMoney(){
    var empNum=$("#employee").html();
    var period=$(".timeWrapper li:not(.optional-amount) div.down");
    $.each(period,function(i){
        var time = parseInt($(this).parent().parent("li").attr("data-time"));
        var periodMoney= periodMoneyCal(time,empNum)
        $(this).html(toThousands(periodMoneyCal(time,empNum))+"加币");
        $(this).parent().parent("li").attr("data-money",periodMoneyCal(time,empNum));
        var li=$(this).parent().parent("li");
        if(periodMoney<minChargeMoney){
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
    if(parseInt($(".timeWrapper li.active").attr("data-money"))<minChargeMoney){
        var li=$(".timeWrapper li[isBind=1]")[0];
        if(li!=undefined){
            $(li).click();
        }
    }
}
//加载奖励性加币
function loadRewardMoney(){
    $("#plusGift").html(toThousands(rewardMoneyCal(finalMoney)));
}
function loadFinalMoney(){
    //加载充值金额
    $("#finalMoney").html(toThousands(finalMoneyCal()));
    var url = $("#chargePage2").attr("href");
    $("#chargePage2").attr("href",addUrlParams(url,{
        chargeMoney:finalMoney
    }));
}
//输入框整数校验
function inputMoneyCheck(){
    var str=$(".input-money input").val();
    if(str!="") {
        var re = /^[1-9]\d*$/g;
        re.lastIndex=0;
        return re.test(str);
    }else{
        return true;
    }
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