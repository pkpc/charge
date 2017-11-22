<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币兑换套餐</title>
	<style>
		a.item-btn2 {
			display: inline-block;
			width: 50%;
			float: left;
			text-align: center;
			box-sizing: border-box;
			/*padding: 0.24rem 0 0.213rem 0px;*/
			height: 1.14rem;
			line-height:1.14rem;
			font-size: 0.453rem;
		}
		.modal-footer {
			height: 1.173333rem;
			border-top: 0.0267rem solid #ccc;
			box-sizing: border-box;
		}
		.modal-body {
			/*height: 1.6rem;*/
			margin: 0 0.4rem 0;
			text-align: center;
			font-size: 0.347rem;
			/* line-height: 3.1rem; */
			box-sizing: border-box;
		}
		.modal{
			min-height: 0;
			position: static;
		}
		.modal-header {
			/* line-height: 1.17rem; */
			font-family: PingFangSC-Regular;
			padding-top: 0.56rem;
			color: #030303;
			padding-bottom: 0.267rem;
			text-align: center;
			font-size: 0.453rem;
			/* border-bottom: 0.02rem solid #ccc; */
		}
		.modal-window-activate {
			position: absolute;
			top: 0;
			bottom: 4.987rem;
			left: 0;
			right: 0;
			width: 7.2rem;
			height: 3.9rem;
			margin: auto 1.333rem;
			background: rgba(255, 255, 255, 0.95);
			border-radius: 0.213rem;
		}
		.plus-page-mask div.modal {
			z-index: 11;
			overflow: hidden;
		}
		.plus-page-mask {
			height: 100%;
			width: 100%;
			background-color: rgba(0,0,0,.3);
			position: absolute;
			top:0;
			left:0;
			right:0;bottom:0;
			margin:auto;
			z-index: 9;
		}
	</style>
</head>
<body>
    <div class="wrapper page ftsize15" id="packageConfirmPage" style="background:#efefef">
        <div class="bigbox">
			<div class="rows_2">
				<div class="row44">
					<div class="flex_row_betweent pd_16">
						<div class="flex_row_start" style="width: 3rem;">
							<img src="/images/charge/icon_purchaseCoin.png" style="width:0.48rem;height: 0.48rem;">
							<span class="ftsize15 ml_5">已选套餐</span>
						</div>
						<div id="packageChosen" class="ftsize13"></div>
					</div>
				</div>
				<div style="margin-left:0.4267rem;width:96%;height:0.053rem;border-top:0.0267rem #ddd solid;"></div>
				<div class="row44">
					<div class="flex_row_betweent pd_16">
						<div class="flex_row_start" style="width: 3rem;">
							<img src="/images/charge/pluscoin4package.png" style="width:0.48rem;height: 0.48rem;">
							<span class="ftsize15 ml_5">所需加币</span>
						</div>
						<div id="coinNeed" class="ftsize15 black03_color"></div>
				</div>
				</div>
			</div>
			<div class="rows_2 mt_12">
				<div class="row44">
					<div class="flex_row_betweent pd_16">
						<div class="flex_row_start" style="width: 3rem;">
							<img src="/images/charge/icn_password.png" style="width:0.48rem;height: 0.48rem;">
							<span class="ftsize15 ml_5">登录密码</span>
						</div>
						<input id="pwd" class="ftsize15 floatL" type="password" placeholder="请输入登录密码" style="text-align: right;margin-right: 0.2rem;padding-right:0" oninput="onInput()">
					</div>
				</div>
			</div>
	        <%--<ul id="packageConfirm">--%>
	            <%--<li class="clearfix wb flex-cont flex-info-center">--%>
	                <%--<div class="box flex-cont flex-info-center">--%>
	                    <%--<img alt="" src="/images/charge/icn_pluspacket.png" style="width: 0.453rem;height: 0.453rem;;">--%>
                	<%--</div>--%>
                	<%--<div class="packageConfirm_each">--%>
                		<%--<span class="packageConfirm_chosened">已选套餐</span>--%>
	                    <%--<span id="packageChosen"></span>--%>
                	<%--</div>--%>
	            <%--</li>--%>
	            <%--<HR style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="80%" color=#e2e2e2 SIZE=1>--%>
	            <%--<li class="clearfix wb flex-cont flex-info-center">--%>
	                <%--<div class="box flex-cont flex-info-center">--%>
	                    <%--<img alt="" src="/images/charge/pluscoin4package.png" style="width: 0.453rem;height: 0.453rem;;">--%>
                	<%--</div>--%>
                	<%--<div class="packageConfirm_each">--%>
                		<%--<span class="packageConfirm_chosened">所需加币</span>--%>
	                    <%--<span id="coinNeed" class="normal"></span>--%>
                	<%--</div>--%>
	            <%--</li>--%>
	            <%--<li class="clearfix wb flex-cont flex-info-center" id="packageConfirmPassword">--%>
	                <%--<div class="box flex-cont flex-info-center">--%>
	                   <%--<img alt="" src="/images/charge/icn_password.png" style="width: 0.53rem;height: 0.53rem;;">--%>
                	<%--</div>--%>
                	<%--<div class="box flex-cont flex-info flex-info-between">--%>
                		<%--<span class="title flex-cont flex-info flex-info-center normal">登录密码</span>--%>
	                    <%--<input id="pwd" class="ftsize15 floatL" type="password" placeholder="请输入登录密码" style="text-align: right;margin-right: 0.2rem;padding-right:0" oninput="onInput()">--%>
                	<%--</div>--%>
	            <%--</li>--%>
	        <%--</ul>--%>
	        <p style="height: .7733333rem;line-height: .7733333rem;">
        		<img class="charge-note" src="../../images/charge/charge-note.png" style="margin: .08rem .1333333rem 0 .506666666rem;vertical-align: -2px;">
        		<span class="charge-error-msg ftsize13 normal" style="color: #F75C4C;"></span>
        	</p>
	        <a class="next_btn ftsize18">
	           	确认购买
		    </a>
        </div>
    </div>
	<div id="modal_select" class="plus-page-mask modal-window-activate-mask" style="background-color: rgba(0,0,0,.3); display:none;">
		<div class="modal bdbox">
			<div class="modal-window-activate">
				<div class="modal-header ftsize17"><div id="modal_title">加币不足</div></div>
				<div class="modal-body">
					<div class="modal-item">
						您当前剩余的加币不足以购买该套餐，建议您先进行加币充值。
					</div>
				</div>
				<div class="modal-footer">
					<div class="btn-group">
						<a style="border-right:0.0267rem #dddddd solid;color: #333333" href="javascript:;" onclick="modal_cancel()" class="item-btn2 cancelActivate ftsize17">取消</a>
						<a id="charge" href="javascript:;" class="item-btn2 confirmActivate ftsize17" onclick="activeChangeCheck()" data-mask="true" style="color: #4A90E2">充值</a>
					</div>
				</div>
			</div>
		</div>
	</div>
    <script type="text/javascript">
    var userTel="",
			cd =[];
    var defaultCard="";
    var defaultCard_use=false;
	var costData = "";
    var countdown = 60;
    var idCardReg = /(^\d{15}$)|(^\d{17}([0-9]|X|x)$)/;
    var cardReg = /^\d{10,25}$/;
    var mid = null;
    var isRealName=true;
    var mptoken=getUrlParam("mptoken");
	var ftoken=getUrlParam("ftoken");
	var isAdmin=getUrlParam("isAdmin");
	var isxigu=getUrlParam("isxigu");
	var plusCoinReward=getUrlParam("plusCoinReward");
	var companyName=decodeURI(decodeURI(getCookie("companyName")));
	var userName=decodeURI(decodeURI(getCookie("userName")));
	if(isxigu==1){
//    	var params = geturlParams();
        location.href='/charge/index.html?'+params;
    }
	var retParam ="";
	Mobilebone.callback = function(pagein, pageout){
    	if(pagein.id == "chargePage"){
		dataReady();
	  }
    }
    $(function(){
        dataReady();
        eventHandler();     
        $(".charge-error-msg").html("");
        $(".charge-note").css("visibility","hidden");
		retParam = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&chosen="+costData+"&userName="+userName;
    });
    function dataReady(){
    	costData = getUrlParam("chosen");
		console.log(costData);
    	cd = costData.split(",");
    	$("#packageChosen").text(cd[0]+"人"+decodeURI(cd[1])+"套餐");
    	$("#coinNeed").text(toThousands(cd[2])+"个");
    }
  	//挂起按钮
    function suspendBtn(btn){
    	$(".next_btn").unbind();
    }
     
    //恢复按钮
    function resumeBtn(btn){
    	$(".next_btn").click(function(){
        	suspendBtn($(".next_btn"));
//        	var cd = costData.split(",");
        	var params = {};
			if(cd[1].substr(0,1) == "6"){
				params ={
					"personNum":cd[0],
					"year":0,
					"month":6,
					"day":0,
					"packagesNeedCoin":cd[2],
					"password":$("#pwd").val()
				}
			}else{
				params ={
					"personNum":cd[0],
					"year":cd[1].substr(0,1),
					"month":0,
					"day":0,
					"packagesNeedCoin":cd[2],
					"password":$("#pwd").val()
				}
			}
            if(checkPwd()){
            	$.ajax({
                    url:"/mppay/comfirmToBuyPackage",
                    type:"POST",
                    xhrFields: {
                        withCredentials: true
                    },
                    async:false,
                    data:JSON.stringify(params),
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
                        	window.location.href="/charge/buyPackageSuccess.html?"+retParam;
                        }else if(data.result==1){
							resumeBtn($(".next_btn"));
							openMessageModal("<p>"+data.res_info+"</p>");
						}else{
                        	resumeBtn($(".next_btn"));
                            openMessageModal("<p>"+data.res_info+"</p>");
                        }
                    },
                })
            }
        });
    }
    function onInput(){
    	if($("#pwd").val().length>0){
    		//输入密码恢复按钮
    		suspendBtn($(".next_btn"));
    		resumeBtn($(".next_btn"));
    	}else{
    		//未输入密码挂起按钮
    		suspendBtn($(".next_btn"));
    	}
    }
    function eventHandler() {
    	suspendBtn($(".next_btn"));
        $("input.img-code-input").on("input propertychange",function () {
            $("#img-error-msg").text("");
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
    function checkPwd(){
	    var pwd = $("#pwd").val();
	    if(isNullReg.test(pwd)){
	        $(".charge-error-msg").html("密码不能为空");
	        $(".charge-note").css("visibility","visible");
	        return false;
	    }
	    return true;
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
	function modal_cancel() {
		$('#modal_select').css("display","none");
	}
	function activeChangeCheck() {
		$('#modal_select').css("display","none");
	}
</script>
</body>
</html>