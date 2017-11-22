<!doctype html>
    <%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
    <html>
<head>
    <meta charset="utf-8">
    <title>账户系统</title>
    <link rel="stylesheet" href="/css/charge/reset2.css" />
    <link rel="stylesheet" href="/css/charge/mobilebone.css">
    <link rel="stylesheet" href="/css/charge/charge.css">
    <link rel="stylesheet" href="/css/charge/packageConfirm.css">
    <link rel="stylesheet" href="/css/charge/plus-charge.css">
    <link rel="stylesheet" href="/css/charge/account-details.css">
    <link rel="stylesheet" href="/css/charge/choosepackage.css">
    <link rel="stylesheet" href="/css/charge/activepackage.css">
    <link rel="stylesheet" href="/css/charge/mergepackage.css">
    <link rel="stylesheet" href="/css/charge/contacts.css">
    <link rel="stylesheet" href="/css/charge/index.css">
	<link rel="stylesheet" href="/css/charge/package.css">
	<link rel="stylesheet" href="/css/charge/packages.css">
    <link rel="stylesheet" href="/css/charge/account-transfer.css">
    <link rel="stylesheet" href="/css/charge/account-pluscoin-details.css">
    <style>
     .myMask{
        position:absolute;
        z-index:99;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0);
     }
     #select-his-receiver {
        /*position: absolute;*/
        bottom:1.15rem;
     }
    .danger{
        margin-right: 1rem;
        background-color: #FE3824;
        border-radius: 0.7rem;
        padding: 0.1rem 0.3rem;
        /* width: 3.2rem; */
        text-align: center;
        vertical-align: center;
        height: 0.5rem;
        color:#fff;
        margin-top: 0.3rem!important;
        line-height: 0.53rem;
    }
    </style>
</head>
<body>
    <div class="myMask" style="display:none"></div>
    <div class="message-modal" style="display:none">
    	<span class="message-modal img"></span>
        <span class="message-modal ftsize14"></span>
    </div>
    <div class="note-modal" style="display:none">
        <img src="/images/charge/contact-info.png" alt="">
        <p class="ftsize14" style="color:#fff;padding-top:.4266666rem">管理员人数已达上限</p>
    </div>
<div id="account-system" class="page out" data-callback="home" style="background-color: #efefef;">
    <div class="wrapper ftsize15">
        <div id="top" class="clearfix">
            <div style="text-align: center;padding-top: 5%">
                <span  class="ftsize64" style=" position:relative;"><span id="restMoney">0</span>  <img style="position:absolute;top: 50%;left: 0;" id="pimg" class="coinIcon" src="../images/charge/plus-coin-white.png" alt=""></span>
            </div>
            <div class="flex_row_center ftsize17 ">
                <a id="plusChargePageLink" class="btn_active_white "  href="javascript:void(0)" data-error="ajax_error" data-success="preventRepeat" data-reload="true" data-history="true">充值</a>
                <a id="callUSLink" class="btn_active_org ml_20"  href="/charge/callUs.html" data-error="ajax_error" data-success="preventRepeat" data-reload="true" data-history="true">预约演示</a>
            </div>
            <%--<div  class="round_btn txtCenter ftsize17 hidden">--%>
                <%--<a id="plusChargePageLink"  href="javascript:void(0)" data-error="ajax_error" data-success="preventRepeat" data-reload="true" data-history="true" style="display:inline-block; width:100%" >预约演示</a>--%>
            <%--</div>--%>
            <!--<div id="recharge-btn" class="clearfix"><div class="round_btn_left fl"></div> <div class="fl middle">加币充值</div>  <div class="round_btn_right fl"></div></div>-->
        </div>
        <ul class="accountSys">
       		<li id="companyStaff" class="clearfix">
                <img class="title" src="/images/charge/icon_staffs.png" alt="allpeople"><span>企业人数</span>
                <div class="fr people">人</div>
                <div id="allpeople" class="fr"></div>
				<HR id="theFirstRow" style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="80%" color=#e2e2e2 SIZE=1>
            </li>
            <li id="companyLeftDays" class="clearfix getAwayBelow">
                <img class="title" src="/images/charge/icon_leftDays.png" alt="rest-time"><span id="leftdayspan">剩余可用天数</span>
                <div class="fr day grey-color">天</div>
                <div id="restTime" class="fr grey-color"></div>
            </li>
            <li class="clearfix isPackages" id="isPackagesBox">
                <a href=""  id="packagePageLink" data-reload="true" data-success="preventRepeat" data-error="ajax_error" data-history="true"  class="clearfix" style="display:block">
                    <img id="purchaseIcon" class="title" src="/images/charge/icon_purchaseCoin.png" alt="coin-admin"><span class="account-item-name" id="packageStatus" data-isBought="" data-isActivated=""></span>
                    <div class="fr grey-color" id="packageDetail"></div>
                    <a href="" class="arrow" id="isPackagesA"><img  src="/images/charge/arrow.png" alt="arrow"></a>
                </a>
				<HR id="secondRow" style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="80%" color=#e2e2e2 SIZE=1>
            </li>
            <li class="clearfix leftDays" id="leftDaysBox">
                <img class="title" src="/images/charge/icon_leftDays.png" alt="coin-admin"><span class="account-item-name">套餐可用天数</span>
                <div class="fr grey-color" id="leftDays" style="margin-right:0.2rem"></div>
            </li>
            <li class="clearfix isAccountAdmin">
                <a href="javascript:void(0)"  id="contactsPageLink" data-reload="true" data-success="preventRepeat" data-error="ajax_error" data-history="true"  class="clearfix" style="display:block">
                    <img class="title" src="/images/charge/icon_manager.png" alt="coin-admin"><span class="account-item-name">账户管理员</span>
                    <div class="fr day" style="margin-right:0.853rem">人</div>
                    <div id="adminNum" class="fr"></div>
                    <a href="" class="arrow"><img  src="/images/charge/arrow.png" alt="arrow"></a>
                </a>
				<HR style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="80%" color=#e2e2e2 SIZE=1>
            </li>
            <li class="clearfix">
                <a id="accountDetailsPageLink"  href="javascript:void(0)" data-success="preventRepeat" data-error="ajax_error" data-history="true" data-reload="true" class="clearfix" style="display:block">
                    <img class="title" src="/images/charge/icon_accountDetail.png" alt="account-details"><span class="account-item-name">账户明细</span>
                    <a href="" class="arrow"><img class="arrow"  src="/images/charge/arrow.png" alt="arrow"></a>
                </a>
                <HR style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="80%" color=#e2e2e2 SIZE=1>
            </li>
            <li class="clearfix">
                <a id="accountTransferPage1Link"  href="javascript:void(0)" data-success="preventRepeat" data-error="ajax_error" data-history="true" data-reload="true" class="clearfix" style="display:block">
                    <img class="title" src="/images/charge/icon_transfer.png" alt="account-details"><span>加币转账</span>
                    <a href="" class="arrow"><img class="arrow"  src="/images/charge/arrow.png" alt="arrow"></a>
                </a>
            </li>
            <li class="clearfix mt-12">
                <a href="tel:0755-82777607"  style="display:block">
                <img class="title" src="/images/charge/icon_call.png" alt="customer-service"><span>联系客服</span>
                <a href="" class="arrow" ><img src="/images/charge/phone.png" style="width:0.4267rem;height:0.4267rem" alt="arrow"></a>
                </a>
            </li>
        </ul>
    </div>
</div>
</div>
    <script src="/js/flexible.debug.js"></script>
    <script src="/js/jquery/jquery-1.8.3.min.js"></script>
    <script src="/js/mobilebone.js"></script>
    <script src="/js/fastclick.js" ></script>
    <script src="/js/getParam.js"></script>
<script>
	var isNullReg = /^[\s]{0,}$/;
	var phoneReg = /^(13|14|15|17|18)[0-9]{9}$/;
	var nameReg=/^[\u4e00-\u9fa5]+$|^[a-zA-Z]+$/;
	var plusCoinAmount_url = '/mppay/getCompanyCoinInfo';
	var base_url = 'https://www.erplus.co/api/v1';
	var getDpmList_url = base_url + '/departments';
	var getContacts_url = base_url + '/contacts';
	var getProfile_url = base_url + '/profile';
	var imgbase_url = "https://www.erplus.co/uploads/avatars";//头像 路径
	var originContacts;
	var mptoken,ftoken,isxigu;
    var isAdmin = getUrlParam("isAdmin");
    if(isAdmin == null){
    isAdmin = getUrlParam('isBoss');
    }
	var adminId;
	var peopleNum;
	var packagePersonNum;
	var plusCoinAmountTotal;
    var companyName=decodeURI(decodeURI(getCookie("companyName")));
    var release = 1;
    if(getUrlParam("release")==0 ||getCookie('release')==0){
    release = 0
    }
    if(getUrlParam("release")==1){
    release = 1
    }
    setCookie("release",release);

	var urlParams={
	    companyId:"",
	    accountAdmin:"",
	    userName:"",
	    empNum:"",
	    plusCoinAmount:"",
	    companyName:"",
	    plusMoneyReward:"",
	    indexUrl:""
	};
    var companyId = 0;
    var preventRepeat = function(target){
        //$("#contactsPageLink").attr("href","javascript:void(0);")
    }
    var ajax_error = function(target){
        openMessageModal("<p>网络异常,请稍后再试</p>")
    }

   $(function(){
		Mobilebone.evalScript = true;
		Mobilebone.init();
		FastClick.attach(document.body);
		//获得mpat
		mptoken=getUrlParam("mptoken");
		//pm登录
		Token();
		//获得员工，可以获得总表originContacts，和adminId
		peopleNum = getPerson();
        //获得管理员，可获得companyId
        companyId = getAccountCharger();
        //获得公司加币
        plusCoinAmountTotal = getCompanyPlusCoin(companyId);
        //获得套餐详情
        getPackageStatus();
		console.log("peopleNum "+peopleNum+" companyId "+companyId+" plusCoinAmount "+plusCoinAmountTotal);
		isxigu = getUrlParam("isxigu");
		if(isxigu==1){
		    $('#isPackagesBox').css("display","none");
		}
		addCookie("companyName", encodeURI(getUrlParam("companyName")), "1","/","");
		addCookie("userName", encodeURI(getUrlParam("userName")), "1","/","");
		console.log(decodeURI(decodeURI(getCookie("companyName"))));
    });

    var home = function(pagein,pageout){
        $(".myMask").css("display","block");
        ftoken=getUrlParam("ftoken");
        if(ftoken.length>32){
            ftoken= ftoken.slice(0,32);
        }
        $(".myMask").css("display","none");
    }
    Mobilebone.fallback = function(pagein,pageout) {
        $("input").blur();
	    if(pageout.id == "account-transfer-page2"&&pagein.id == "account-transfer-page1"){
	            $("#transfer-userName").val("");
	            $("#transfer-telNum").val("");
	            $("li.select-company #transfer-select-company").remove();
	            $(".select-company-note").css("display","block");
	            $("#account-transfer3").parent().removeClass("btn-active");
	            $("#account-transfer3").attr("href","javascript:void(0)");
	    }else if(pageout.id == "account-transfer-page2"){
	          //  var curSelectedIndex = $("li.select-company #transfer-select-company")[0].selectedIndex;
	            //$("li.select-company #transfer-select-company")[0].selectedIndex = curSelectedIndex;
	    }
    };
    function calLeftDay(plusCoinAmount,peopleNum){
    	console.log("***************"+plusCoinAmount);
    	console.log("***************"+peopleNum);
    	var restDay = calRestDays(plusCoinAmount,peopleNum);
    	console.log("***************"+restDay);
        $("#restTime").html(restDay);
    }
    function Token(){
	    if(ftoken!=null&&ftoken.length>8){
	        $.ajax({
	            async:false,
	            type: "POST",
	            url:"/mpapp/getToken",
	            xhrFields: {
                    withCredentials: true
           		},
           		crossDomain: true,
	            success:function(data){
	                data = $.parseJSON(data);
	                if(data.result == "0"){
	                    var token = data.token;
	                    addCookie("136a3d03-9748-4f83-a54f-9b2a93f979a0",token,"1","/","");
	                }else{
	                    openMessageModal(data.msg);
	                }
	            }
	        });
	        $.ajax({
	            async:false,
	            type: "POST",
	            url:"/mpapp/mp2pm",
	            data: {
	                "ftoken":ftoken,
	            },
	            crossDomain: true,
	            xhrFields: {
                    withCredentials: true
           		},
	            success:function(data){
	                data = $.parseJSON(data);
	                if(data.result == "0"){
	                    //登录成功
	                    loginFlag=true;
	                    console.log("登录成功");
	                    addCookie("ftoken",ftoken,"1","/","");
	                    addCookie("voajnsal",data.voajnsal,"1","/","");
	                }else{
	                    console.log("未登录");
	                    openMessageModal("<p>参数出错，请联系程序员</p>");
	                }
	            }
	        });
	    }
	}
    function getPerson() {
    	
    	var peopleNum = 1;
        $.ajax({
            url: getContacts_url,
            type: "get",
            async: false,
            crossDomain: true,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
            },
            error: function() {
                openMessageModal("<p>参数出错，请联系程序员</p>");
            },
            success: function (data) {
            	
            	//员工表
                originContacts=data;
				
				//去掉多身份
				var arr = new Array();    //定义一个临时数组  
				for(var i = 0; i < data.length; i++){    //循环遍历当前数组  
                //判断当前数组下标为i的元素是否已经保存到临时数组  
                //如果已保存，则跳过，否则将此元素保存到临时数组中  
					if(arr.indexOf(data[i].parentId) == -1){  
                    <%--arr.push(data[i].parentId);  --%>
                    arr.push(data[i].parentId);
					}
				}  
				 peopleNum = arr.length;
				
				
				
               // peopleNum = data.length;
                var isIdirectorCount = 0;
                $.each(originContacts,function(i,data){
	                if(data.isAdmin==true){
	                    adminId = data.mainContactId.toString();
	                }else if(data.departmentName=='独立董事'){
	                    isIdirectorCount++;
	            	}
        		});
		        $.each(originContacts,function(i,data){
		            data.ftoken = (data.ftoken.length>32)?data.ftoken.substring(0,32):data.ftoken;
		        });
		        <%--employeeNum = originContacts.length;--%>
		        <%--var contact_url=addUrlParams($("#contactsPageLink").attr("href"),{companyNum:originContacts.length-isIdirectorCount});--%>
		        <%--var plus_url=addUrlParams($("#plusChargePageLink").attr("href"),{empNum:originContacts.length-isIdirectorCount});--%>
		        <%--$("#plusChargePageLink").attr("href",plus_url);--%>
		        <%--$("#contactsPageLink").attr("href",contact_url);--%>
    		}
    	});
        return peopleNum;
    }
    Array.prototype.unique = function(){
    var res = [];
    var json = {};
    for(var i = 0; i < this.length; i++){
    if(!json[this[i]]){
    res.push(this[i]);
    json[this[i]] = 1;
    }
    }
    return res;
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
                openMessageModal("<p>参数错误，请联系程序员</p>");
            },
            success:function(data){
            	
                if(data.result==0){
                	companyId = data.data.companyId;
                    var accountCharger =data.data.accountCharger==""?[]:data.data.accountCharger.split(",");
                    if(accountCharger.indexOf(adminId)==-1){
                        accountCharger.push(adminId);
                    }
    accountCharger = accountCharger.unique();
    console.log(accountCharger);
                    $("#adminNum").html(accountCharger.length);

                    var ua = navigator.userAgent.toLowerCase();
                    //iphone不展示充值
                    if (/iphone|ipad|ipod/.test(ua)) {
                           var plusChargeurl = addUrlParams("plus-charge.html",{
                                companyId:data.data.companyId,
                                empNum:originContacts.length
                            });
                           if(decodeURI(getUrlParam("userName")) == "张楷鸿"){
                             $('.round_btn').removeClass('hidden');
                           }
                            $('#plusChargePageLink').css('display','none');
                            $('#callUSLink').removeClass('ml_20');
                    } else if (/android/.test(ua)) {
                            $('.round_btn').removeClass('hidden');
                            var plusChargeurl = addUrlParams("charge-android.html",{
                                companyId:data.data.companyId,
                                <%--empNum:originContacts.length--%>
                            });
                    }
                    $("#plusChargePageLink").attr("href",plusChargeurl);
                    var accountUrl = addUrlParams("account-details.html",{PMcompanyId:data.data.pmId});
                    $("#accountDetailsPageLink").attr("href",accountUrl);
                    var contactUrl = addUrlParams("contacts.html",{
                        accountCharger:accountCharger.toString(),
                        companyNum: originContacts.length,
                        companyName:getUrlParam("companyName")
                    });
                    $("#contactsPageLink").attr("href",contactUrl);
                    addCookie("PMcompanyId",data.data.pmId,"1","/","");
                    $("#accountTransferPage1Link").attr("href","account-transfer1.html?fromCompanyId="+data.data.companyId);
                }else {
                    openMessageModal("<p>参数错误，请联系程序员</p>");
                }
            },
        })
        return companyId;
    }
    //查询公司加币
    function getCompanyPlusCoin(id){
    	
        var param = {};
        param.companyId = id;
        $.ajax({
            url:plusCoinAmount_url,
            async:false,
            type:'POST',
            data:JSON.stringify(param),
            contentType:'application/json',
            headers:{
                Authorization:'Bearer '+ mptoken
            },
            success:function(data){
            	
                data  = JSON.parse(data);
                
                if(data.result=='0'){
                	plusCoinAmountTotal = data.data.plusCoinAmount;
                    pageDataInit(plusCoinAmountTotal);
                }
            }
        });
		return plusCoinAmountTotal;
    }
     //获得购买套餐状态接口
    function getPackageStatus(){
        $.ajax({
            url:"/mppay/getCurrentlyUsedPackage",
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
                openMessageModal("<p>参数错误，请联系程序员</p>");
            },
            success:function(data){
                if(data.result==0){
                    if(data.list == undefined || data.list.length == 0){
                        //未购买套餐
                        $("#isPackagesBox").addClass("getAwayBelow");
                        $("#packageStatus").text("加币兑换套餐");
                        $("#packageStatus").attr("data-isBought","0");
                        $("#packageStatus").attr("data-isActivated","0");
                        $("#packagePageLink").attr("href","/charge/purchasePackage.html?staff="+peopleNum+"&plusCoinAmountTotal="+plusCoinAmountTotal+"&companyId="+companyId);
                        $("#isPackagesA").attr("href","/charge/purchasePackage.html?staff="+peopleNum+"&plusCoinAmountTotal="+plusCoinAmountTotal+"&companyId="+companyId);
                        $('#secondRow').css('display','none');
                        var list = ['加号野战一军','加号野战二军','加号野战三军','加号野战四军','加号野战六军','加号野战七军','加号野战八军','加号野战九军','拓荒队加号野战军','深圳大管加软件与技术服务有限公司','大管加企业管理系统','深圳蓝雨管理咨询有限公司','深圳哆啦企业服务有限公司','深圳晨星科技有限公司','大管加企业管理系统'];
                        if(release =="1" && list.indexOf(companyName)===-1){
                        $("#isPackagesBox").css('display','none');
                        }
                        $("#packageDetail").html('<div class="activated"><img src="/images/charge/icn_gift.png" style="width: 0.453rem;height: 0.453rem;margin-right: 0.08rem;"/><span>更优惠</span></div>');
                    }else{
                    	var isActivated = false;
                    	var num = 0;
                    	for(var i = 0 ; i < data.list.length ; i++){
                    		var item = data.list[i];
                    		if(data.list[i].state == 2){
                    			isActivated = true;
                    			num = i;
                    			break;
                    		}
                    	}
                        if(!isActivated){
                            //已购买未激活
                            $("#packageStatus").text("包年套餐");
                            $("#packageStatus").attr("data-isBought","1");
                            $("#packageStatus").attr("data-isActivated","0");
                            $("#packageDetail").html('<span class="redFont">未激活</span>');
                            //设置跳转
                            $("#packagePageLink").attr("href","/charge/activepackage.html");
                            $("#isPackagesA").attr("href","/charge/activepackage.html");
                            $("#isPackagesBox").addClass("getAwayBelow");
                        }else{
                        	var item = data.list[num];
                            //已购买已激活
                            $("#packageStatus").text("当前激活套餐");
                            $("#packageStatus").attr("data-isBought","1");
                            $("#packageStatus").attr("data-isActivated","1");
                            $("#companyLeftDays").css("display","none");
                            $("#theFirstRow").css("display","none");
                            $("#companyStaff").addClass("getAwayBelow");
                            if(item.empNumOutOfPack == 0){
                                $("#packageDetail").html('<div class="activated"><span>'+item.personNum+'人套餐</span></div>');
                                //设置跳转
                                $("#packagePageLink").attr("href","/charge/activePackage.html");
                                $("#isPackagesA").attr("href","/charge/activePackage.html");
                            }else{
                                debugger
                                $("#packageDetail").html('<div class="danger"><span>已超出'+item.empNumOutOfPack+'人</span></div>');
                                $("#packagePageLink").attr('href','/charge/upgradePackage.html?staffs='+item.sumOfEmployee);
                                $("#purchaseIcon").attr('src','/images/charge/icon_danger.png');
                            }
                            packagePersonNum = item.personNum;
                            $("#leftDaysBox").css("display","block");
                            $("#leftDaysBox").addClass("getAwayBelow");
                            $("#leftDays").text(item.leftDay+'天');

                        }
                    }
                }
            },
        })
    }

    function getUrlParam(paras){
        var urlArray = document.location.href.split("?");
        var returnValue;
        for(var a=1;url=urlArray[a];a++){
            var paraString = url.split("&");
            for (i=0; j=paraString[i]; i++){
            if(j.indexOf(paras)==0){
            returnValue = j.substring(j.indexOf("=")+1,j.length);
        }
        }
    }
        if(typeof(returnValue)=="undefined"){
            return null;
        }else if(returnValue.indexOf("#")!=-1){
                returnValue=returnValue.substring(0,returnValue.length-1);
        return returnValue;
        }
    else{
            return returnValue;
        }
    }
    function addUrlParams(url,params){
        if(url.lastIndexOf("?")==-1){
            url+='?';
        }else{
        url+='&';
    }
    var index=0;
        for (i in params){
            url += i+ '=' + params[i]+'&';
        index++;
        }
        url = url.substring(0,url.length-1);
        return url;
    }
    function pageDataInit(val){
        <%--$("#contactsPageLink").attr("href","contacts.html");--%>
        <%--$("#plusChargePageLink").attr("href","plus-charge.html");--%>
        <%--$("#accountDetailsPageLink").attr("href","account-details.html");--%>
        var isBought = $("#packageStatus").attr("data-isBought");
        var isActivated = $("#packageStatus").attr("data-isActivated");
        if(isActivated ==0){
        	$("#allpeople").html(peopleNum);
        	calLeftDay(plusCoinAmountTotal,(peopleNum));
        }else{
        	if(packagePersonNum<peopleNum){
        		$("#allpeople").html(packagePersonNum+"+"+(peopleNum-packagePersonNum));
        		calLeftDay(plusCoinAmountTotal,(peopleNum-packagePersonNum));
        		$("#leftdayspan").text("套餐外员工可用天数");
        	}else{
        		$("#allpeople").html(peopleNum);
        		$("#leftdayspan").parent().css("display","none");
        		$("ul.accountSys li:nth-child(1)").css("margin-bottom","0.32rem");
        	}
        }
	    if(typeof val=='undefined'){
	        $("#restMoney").html(0);
	    }else{
	        $("#restMoney").html(toThousands(+val));
	    }
        getUrlParam("userName");
        if(isAdmin=="1"){
            $("li.isAccountAdmin").css("display","block");
            $("#accountTransferPage1Link").parent("li").css("display","block");
        }else{
            $("li.isAccountAdmin").css("display","none");
            $("#accountTransferPage1Link").parent("li").css("display","none");
        }
    }
    function openMessageModal(message){
    	$("div.message-modal span.img").html('<img class="message-modal" src="/images/charge/Artboard@2x.png" />');
        $("div.message-modal span.ftsize14").html(message);
        $("div.message-modal").css("display","block");
        setTimeout('$("div.message-modal").css("display","none")',3000);
    }
    function openNoteModal(message){
        $("div.note-modal p").html(message);
        $("div.note-modal").css("display","block");
        setTimeout('$("div.note-modal").css("display","none")',2000);
    }
  //读cookies
    function getCookie(name) {
        var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
        if (arr = document.cookie.match(reg)) {
            return unescape(arr[2]);
        } else {
            return null;
        }
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
    //输入加币整数校验
    function inputMoneyCheck(str){
        if(str!="") {
            var re = /^[1-9]\d*$/g;
            re.lastIndex=0;
            return re.test(str);
        }else{
            return true;
        }
    }
    function addCookie(name,value,expires,path,domain){
        var str=name+"="+escape(value);
        if(expires!=""){
            var date=new Date();
            date.setTime(date.getTime()+expires*24*3600*1000);//expires单位为天
            str+=";expires="+date.toGMTString();
        }
        if(path!=""){
            str+=";path="+path;//指定可访问cookie的目录
        }
        if(domain!=""){
            str+=";domain="+domain;//指定可访问cookie的域
        }
        document.cookie=str;
    }
    function calRestDays(amount,empNum){
    	console.log("计算剩余天数：金额 "+amount+"人员"+empNum)
        var empNum=parseInt(empNum);
        var amount=parseInt(amount);
        if(amount>0&&empNum>0){
            return parseInt(amount/empNum/2);
        }else{
            return 0;
        }
    }
    </script>
</body>
</html>
