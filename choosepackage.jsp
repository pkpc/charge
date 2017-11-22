<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>包年套餐</title>
</head>
<body>
<div class="wrapper page ftsize15 bdbox" id="choosePackagePage" style="background:#efefef">
	<div class="cp-modal-window" style="display:none">
        <div class="cp-modal-header">加币不足</div>
        <div class="cp-modal-body">
            <div class="cp-modal-item ftsize13">
            	您当前剩余的加币不足以购买该套餐
            </div>
        </div>
        <div class="cp-modal-footer">
            <div class="cp-btn-group">
                <a href="javascript:;" class="cp-item-btn cp-cancel ftsize12">取消</a>
                <!-- <a href="javascript:;" class="cp-item-btn cp-charge">充值</a> -->
            </div>
        </div>
    </div>
    <div id="content">
    	<div id="overflowBox">
		    <div class="clearfix bdbox" id="packageForSale">
			    <div class="fl bdbox title">选择套餐</div>
			    <div class="fr bdbox ftsize12">当前剩余加币&nbsp;<span id="plusBalence"></span>&nbsp;</div>
		    </div>
		    <div class="packageWrapper bdbox">
		        <ul class="clearfix bdbox" id="cardlist">
	            </ul>
		    </div>
		    <div class="packageWrapper tubeWrapper bdbox">
			    <div class="tube clearfix bdbox">
	                <div class="fl bdboxs">
	                    <div class="word-wrapper ftsize12 bdbox">
	                        <div id="talkingWordChosen" class="chosen ftsize12" style="display:none">现在购买该套餐，即可劲省<span id="savehowmany"></span></br>加币，相当于<span id="disaccount"></span>折哦</div>
	                        <div id="talkingWordNone" class="none ftsize12">快来选择套餐吧！购买越多优惠越多！</div>
	                    </div>
	                </div>
	                <div class="fr laugh tt"></div>
			    </div>
		    </div>
    		<div class="triangle"></div>
    		<div class="next-btn deactive ftsize18">
			    <a id="packagePage2" data-error="ajax_error" data-mask="false" data-reload="false" data-root="root" data-callback="charge_callback">
			    	下一步
			    </a>
    		</div>
    		<div id="choosePackageNotice">
    			<ul class="clearfix bdbox" style='list-style-type: decimal'>
    				<li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem;'><div class="noticeWord " style='margin-left: -0.47rem;'>包年套餐有不同的人数和使用时长限制，请根据您企业的实际情况选择，超出套餐外的员工将正常收取使用费；</div></li>
    				<li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>购买的包年套餐需要激活后才可使用；</div></li>
    				<li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>包年套餐可退换为加币，但须按照使用情况进行折算；</div></li>
    				<li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>包年套餐活动不定期开放，具体时间以公告为准；</div></li>
    				<li class="choosePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord ftsize12" style='margin-left: -0.47rem;'>本活动最终解释权归大管加所有，如有疑问请致电0755-82777607。</div></li>
    			</ul>
    		</div>
    	</div>
    </div>
</div>
<script src="/js/flexible.debug.js"></script>
    <script src="/js/jquery/jquery-1.8.3.min.js"></script>
    <script src="/js/mobilebone.js"></script>
    <script src="/js/fastclick.js" ></script>
<script type="text/javascript">
    var isxigu = getUrlParam("isxigu");
	var mptoken=getUrlParam("mptoken");
	var ftoken=getUrlParam("ftoken");
	var base_url = 'https://www.erplus.co/api/v1';
    var getDpmList_url = base_url + '/departments';
    var getContacts_url = base_url + '/contacts';
    var getPerson_url = base_url + '/profile';
    var companyId = 0;
    var empNum = 0;
    $(function(){
	   	getPerson();
	   	getPlusCoinBalance();
	   	getAllPackageType();
	       eventHandler();
	        if(isxigu==1){
	        	var params = geturlParams();
	            location.href='/charge/index.html?'+params;           
	        }
    });
    function eventHandler(){
        //弹窗按钮点击
        $(".confirm").click(function () {

        });
        //弹窗输入框
        $("div.input-money input").keyup(function(){
            var inputMoney=$("#choosePackagePage .input-money input").val();
            if(inputMoneyCheck(inputMoney)&&parseInt($(this).val())<=maxChargeMoney){
                $("p.error-msg").html("");
            }else if(!inputMoneyCheck(inputMoney)){
                $("p.error-msg").html("请输入整数数额");
            }else if(parseInt($(this).val())>maxChargeMoney){
                $("p.error-msg").html("充值加币不可超过50,000个");
            }else{
                $("p.error-msg").html("");
            }

        });
    }
    function getAccountCharger(){
        $.ajax({
            url:"/mppay/gccac",
            type:"post",
            xhrFields: {
                withCredentials: true
            },
            async:false,
            dataType:"json",
            crossDomain: true,
            beforeSend:function(xhr){
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            error: function(){
                openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
            },
            success:function(data){
                if(data.result==0){
                	companyId=data.data.companyId;
                }else{
                    openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
                }
            },
        })
    }
    //购买时长选项点击
    function li_available_click(){
        if ($(this).hasClass("active")) {
            $(this).siblings().removeClass("active");
        } else {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");
        }
        var costData = $(this).attr("datacost");
        calOff(costData);
        $("#packagePage2").attr("href","/charge/packageconfirm.jsp?chosen="+costData);
        $(".cp-modal-window").css("display","none");
        $("div.next-btn").removeClass("deactive");
        $("div.next-btn").addClass("active");
        $("#talkingWordChosen").css("display","block");
        $("#talkingWordNone").css("display","none");
        $(".tubeWrapper .tube .tt").removeClass("laugh");
        $(".tubeWrapper .tube .tt").addClass("buling");
    }
  	//购买时长选项点击
    function li_disable_click(){
    	$(this).siblings().removeClass("active");
        var costData = $(this).attr("datacost");
        calOff(costData);
        $("#packagePage2").attr("href","");
        $(".cp-modal-window").css("display","block");
        $(".cp-cancel").bind({
        	click:function cpcancel(){
        		$(".cp-modal-window").css("display","none");
        		$(".cp-charge").unbind();
        	}
        })
        $(".cp-charge").bind({
        	click:function cpcancel(){
        		$(".cp-charge").attr("href","/charge/plus-charge.html?companyId="+companyId+"&empNum="+empNum);
        	}
        })
        $("div.next-btn").removeClass("active");
        $("div.next-btn").addClass("deactive");
        $(".tubeWrapper .tube .tt").removeClass("laugh");
        $(".tubeWrapper .tube .tt").addClass("buling");
    }
    function calOff(cost){
    	var costdata = cost.split(",");
    	var man = costdata[1];
    	var year = costdata[2];
    	var coin = costdata[3];
    	var costOrigin = man*2*365*year;
    	var save = costOrigin-coin;
    	var offPersentage = (coin/costOrigin*10).toFixed(2);
    	$("#savehowmany").text(toThousands(save));
    	$("#disaccount").text(offPersentage);
    }
    function getPerson() {
        $.ajax({
            url: getContacts_url,
            type: "get",
            async: false,
            crossDomain: true,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
            },
            error: function() {
                openMessageModal("<p>参数出错</p><p>请联系程序员</p>");
            },
            success: function (data) {
            	empNum=data.length;
            }
    	});
        getAccountCharger();
    }
    function getPlusCoinBalance(){
    	var param = {};
        param.companyId = companyId;
    	$.ajax({
            url:"/mppay/getCompanyCoinInfo",
            type:"POST",
            xhrFields: {
                withCredentials: true
            },
            async:false,
            data:JSON.stringify(param),
            dataType:"json",
            crossDomain: true,
            contentType:'application/json',
            beforeSend:function(xhr){
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            error: function(){
                openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
            },
            success:function(data){
                if(data.result==0){
                	$("#plusBalence").text(toThousands(data.data.plusCoinAmount));
                }else {
                    openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
                }
            },
        })
    }
    function getAllPackageType(){
    	debugger;
   		$.ajax({
            url:"/mppay/getAllPackageType",
            type:"post",
            xhrFields: {
                withCredentials: true
            },
            async:true,
            data:{

            },
            dataType:"json",
            crossDomain: true,
            beforeSend:function(xhr){
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            error: function(){
                openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
            },

            success:function(data){
                if(data.result==0){
                	var cardList = $("#cardlist");
                	var list = data.data;
                	var bal = $("#plusBalence").text();
                	var bals = bal.split(",");
                	bal = "";
                	for(var i = 0; i<bals.length;i++){
                		bal+=bals[i];
                	}
                	for(var i = 0; i<list.length;i++){
                		var card = list[i];
                		if(bal>=card.packagesNeedCoin){
                			cardList.append('<li class="bdbox available" datacost="'+card.type+','+card.personNum+','+card.year+','+card.packagesNeedCoin+'" isBind="1"><div class="li-wrapper bdbox"><div class="up bdbox ftsize17">'+card.personNum+'人 '+card.year+'年</div><div class="down bdbox ftsize12">'+toThousands(card.packagesNeedCoin)+'&nbsp;加币</div></div></li>');
                		}else{
                			cardList.append('<li class="bdbox disable" datacost="'+card.type+','+card.personNum+','+card.year+','+card.packagesNeedCoin+'" isBind="1"><div class="li-wrapper bdbox"><div class="up bdbox ftsize17">'+card.personNum+'人 '+card.year+'年</div><div class="down bdbox ftsize12">'+toThousands(card.packagesNeedCoin)+'&nbsp;加币</div></div></li>');
                		}
                	}
                }else {
                    openMessageModal("<p>参数错误</p><p>请联系程序员</p>");
                }
                $(".packageWrapper li.available").bind({click:li_available_click});
                $(".packageWrapper li.disable").bind({click:li_disable_click});
            },
        })
    }
  //千位分隔符
    function toThousands(number){
        number = number.toString();
        //小数部分
        var Int =parseInt(number).toString();
        Int=Int.replace(/(\d{1,3})(?=(\d{3})+(?:$|\.))/g, "$1,");
        if(number.lastIndexOf(".")!=-1){
            var Float= number.substring(number.lastIndexOf("."),number.length);
        }else{
            var Float="";
        }
        //整数部分
        return Int+Float;
    }
</script>
</body>
</html>

