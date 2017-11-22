<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>包年套餐</title>
    <script src="/js/flexible.debug.js"></script>
    <link rel="stylesheet" href="/css/charge/reset2.css" />
    <link rel="stylesheet" href="/css/charge/mobilebone.css">
    <link rel="stylesheet" href="/css/charge/charge.css">
    <link rel="stylesheet" href="/css/charge/packageConfirm.css">
    <link rel="stylesheet" href="/css/charge/plus-charge.css">
    <link rel="stylesheet" href="/css/charge/account-details.css">
    <link rel="stylesheet" href="/css/charge/choosepackage.css">
    <link rel="stylesheet" href="/css/charge/mergepackage.css">
    <link rel="stylesheet" href="/css/charge/contacts.css">
    <link rel="stylesheet" href="/css/charge/index.css">
    <link rel="stylesheet" href="/css/charge/account-transfer.css">
</head>
<body>
<div class="message-modal" style="display:none">
    	<span class="message-modal img"></span>
        <span class="message-modal ftsize14"></span>
</div>
<div class="wrapper page ftsize15 bdbox" id="mergePackagePage" style="background:#efefef">
	<div class="plus-page-mask modal-window-merge-mask" style=" display:none;">
    	<div class="modal bdbox">
			<div class="modal-window-merge">
		        <div class="modal-header ftsize17">合并套餐</div>
		        <div class="modal-body">
		            <div class="modal-item">
		            </div>
		        </div>
		        <div class="modal-footer">
		            <div class="btn-group">
		                <a href="javascript:;" class="item-btn cancelMerge ftsize17" onclick="hideMergeWindow()" style="color: #4a90e2">取消</a>
		                <a href="javascript:;" class="item-btn confirmMerge ftsize17" onclick="mergePackageConfirm()" style="color: #f75c4c">合并</a>
		            </div>
		        </div>
		    </div>
	    </div>
    </div>
    <div id="content">
    	<div id="overflowBox">
		    <div class="mergePackageWrapper bdbox"  id="mergeItemBed">
		    	<div class="fl bdbox title ftsize14 colorgray">请选择您想要合并的套餐</div>
		    	<ul>

		    	</ul>
		    </div>
		    <!-- <div class="triangle"></div> -->
		    <div class="btnGroupWrapper bdbox flex-container-between">
	    		<div class="ftsize18 flex-container-between flex-container-row btnGroup">
				    <div class="bdbox mergeBtnLongDiv bgblue colorwhite" id="mergeBtnLong">
					    <a data-error="ajax_error" data-mask="false" data-reload="false" data-root="root" class="colorwhite">
					    	合并
					    </a>
				    </div>
	    		</div>
    		</div>
    		<!-- <div id="activePackageNotice">
	    		<ul class="clearfix bdbox" >
	    			<li class="activePackageNoticeTitle ftsize12">关于退订包年套餐</li>
	    		</ul>
    			<ul class="clearfix bdbox" style='list-style-type: decimal'>
                    <li class="activePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord" style='margin-left: -0.47rem;'>若包年套餐在激活前被退订，则退还加币数为购入时所花费加币数的9折；</div></li>
                    <li class="activePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord" style='margin-left: -0.47rem;'>若包年套餐在被激活使用后退订，则需按照剩余可用天数先计算出该套餐当前价值多少个加币，再打7折后返还</div></li>
                    <li class="activePackageNoticeLine ftsize12" style='margin-left: 0.47rem'><div class="noticeWord" style='margin-left: -0.47rem;'>大管加保留有关加币套餐的最终解释权，如有疑问请致电0755-82777607。</div></li>
    			</ul>
    		</div> -->
    	</div>
    </div>
</div>
<script src="/js/flexible.debug.js"></script>
    <script src="/js/jquery/jquery-1.8.3.min.js"></script>
    <script src="/js/mobilebone.js"></script>
    <script src="/js/fastclick.js" ></script>
    <script src="/js/getParam.js"></script>
<script type="text/javascript">
/**
 * 什么是待完成的
 *	1.由于现在只能买一个包，所以点击事件没做，默认第一个li就是active
 */
	var base_url = 'http://mp.plusmoney.cn/api/v1';
	var getDpmList_url = base_url + '/departments';
	var getContacts_url = base_url + '/contacts';
	var getPerson = base_url + '/profile';
	var chosen = [];
	var mptoken=getUrlParam("mptoken");
	var ftoken=getUrlParam("ftoken");
	var isAdmin=getUrlParam("isAdmin");
	var isxigu=getUrlParam("isxigu");
	var plusCoinReward=getUrlParam("plusCoinReward");
	var companyName=decodeURI(decodeURI(getCookie("companyName")));
	var userName=decodeURI(decodeURI(getCookie("userName")));
	if(isxigu==1){
    	var params = geturlParams();
        location.href='/charge/index.html?'+params;
    }
	var retParam = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&isxigu="+isxigu+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;
		
    $(function(){
    	if(isxigu==1){
        	var params = geturlParams();
            location.href='/charge/index.html?'+params;
        }
        eventHandler();
        $("#packageBought").bind({click:li_click});
        getPackageIHave();
        $('input[type="checkbox"]').bind({click:checkBox});
    });
    function checkBox(){
    	var willadd = true;
    	var tocheck = $("input[id="+this.id+"]")
    	var id = tocheck.attr("id");
    	var year = tocheck.val();
    	for(var i = 0 ; i < chosen.length ; i++ ){
    		var item = chosen[i];
    		if(item==id){
    			chosen.splice(i,1);
    			willadd = false;
    		}
    	}
    	if(willadd){
    		$(this).removeClass("unchecked");
    		$(this).addClass("checked");
    		chosen.push(id);
    	}else{
    		$(this).removeClass("checked");
    		$(this).addClass("unchecked");
    	}
    	//获得所有可合并的元素
    	var divs = $("div.year"+year);
    	var inputs = $("input.checkbox");
    	console.log(divs);
    	for(var i = 0; i < divs.length; i++){
    		var div = divs[i];
    		console.log(div);
    		div.removeChild(div.firstChild);
    		console.log(div);
    		div.innerHTML = '<span class="ftsize12">可合并</span>';
    		$(div).removeClass("deactive");
    		$(div).addClass("mergeable");
    	}
    	if(chosen.length != 0){
	    	//隐藏不可合并的圈圈
			for(var i = 0 ; i < inputs.length; i++){
				var input = inputs[i];
				if($(input).val() != year){
					$(input).removeClass("unchecked");
					$(input).attr("disabled","disabled");
				}
			}
    	}
		if(chosen.length != 0){
    		//改变不可用说明
        	var spans = $("span.year");
        	for(var i = 0 ; i < spans.length ; i++){
        		var span = spans[i];
        		$(span).removeClass();
        		$(span).addClass("unable");
        		$(span).addClass("ftsize12");
        		$(span).parent().removeClass("colorred");
        		$(span).parent().addClass("colororange");
        		span.innerHTML = '该套餐与您所选套餐的时长不一致，不可合并';
        	}
    	}
    	//初始化
		if(chosen.length == 0 ){
			$("#mergeItemBed ul").html("");
			$("#mergeItemBed ul").append(ostr);
			$('input[type="checkbox"]').bind({click:checkBox});
		}
    	console.log(chosen);
    }
    function eventHandler(){
        //购买时长点击事件
        $(".mergePackageWrapper li").click(function () {
           if ($(this).hasClass("active")) {
                $(this).siblings().removeClass("active");
            } else {
                $(this).addClass("active");
                $(this).siblings().removeClass("active");
            }
        });
        $("#mergeBtnLong").bind({click:mergePackage});
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
    function li_click(){
        if ($(this).hasClass("active")) {
            $(this).siblings().removeClass("active");
        } else {
            $(this).addClass("active");
            $(this).siblings().removeClass("active");
        }
    }
    function getPerson() {
        $.ajax({
            url: getContacts_url,
            type: "get",
            async: true,
            crossDomain: true,
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
            },
            error: function() {
                openMessageModal("<p>参数出错</p><p>请联系程序员</p>");
            },
            success: function (data) {
                originContacts=data;
                var isIdirectorCount = 0;
                $.each(originContacts,function(i,data){
	                if(data.isAdmin==true){
	                    adminId = data.parentId.toString();
	                }else if(data.departmentName=='独立董事'){
	                    isIdirectorCount++;
	                }
            	})
            }
        });
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
    function openMessageModal(message){
    	$("div.message-modal span.img").html('<img class="message-modal" src="/images/charge/Artboard@2x.png" />');
        $("div.message-modal span.ftsize14").html(message);
        $("div.message-modal").css("display","block");
        setTimeout('$("div.message-modal").css("display","none")',3000);
    }
    function getPackageIHave(){
    	var isActived=false;
    	$.ajax({
            url: "/mppay/purchasedPackages",
            type: "POST",
            async: false,
            crossDomain: true,
            dataType:"json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
            },
            error: function() {
                openMessageModal("<p>参数出错</p><p>请联系程序员</p>");
            },
            success: function (data) {
            	if(data.result==0){
            		var list = data.data;
            		var str = "";
            		if(list != undefined){
            			for(var i = 0; i < list.length; i++){
                			var item = list[i];
                			var buyTime = item.buyTime.substring(0,10);
                			var men = item.personNum;
                			var year = item.year;
                			if(item.state ==1 || item.state ==2){
                				str += '<li id="packageBought" class="active" data-id="'+item.id+'" data-type="'+item.type+'">';
               						str += '<div class="flex-container-column flex-info-center needBorder">';
	                					str += '<div class="clearfix bdbox flex-container-row flex-info-between">';
	                   						str += '<div class="packageType bdbox flex-container-column flex-info-center">';
	                   							str += '<span class="up ftsize17">'+men+'人'+year+'年期套餐'+'</span>';
	                   							str += '<span class="down ftsize12">购买日期 '+buyTime+'</span>';
	                   						str += '</div>';
                    			if(item.state==1){
                    				//未激活
                    						str += '<div class="packageStatusEmpty bdbox flex-container-row flex-info-center"></div>';
	                    					str += '<div class="packageStatus bdbox flex-container-row flex-info-center">';
	                    						str += '<input class="magic-checkbox checkbox unchecked" type="checkbox" name="layout" id="'+item.id+'" value="'+year+'"><label for="'+item.id+'"></label>';
	                    					str += '</div>';
	                   					str += '</div>';
	                   					str += '<div class="clearfix bdbox flex-container-row flex-info-between flex-footer">';
	                   						str += '<div class="bdbox flex-info-center deactive year'+year+' colorred"><span class="ftsize12 year">未激活</span></div>';
	                   					str += '</div>';
                   					str += '</div>';
                    			}else{
                    				//已激活
                    				isActived=true;
	                    					str += '<div class="packageActivated bdbox flex-cont flex-footer-activated">';
	                    					str += '</div>';
	                    				str += '</div>';
	                    				str += '<div class="clearfix bdbox flex-container-row flex-info-between flex-footer">';
                   							str += '<div class="packageStatus bdbox flex-info-center colorred activated">'
               									str += '<span class="ftsize12">已激活，不可合并</span>';
             								str += '</div>';
                   						str += '</div>';
               						str += '</div>';
                    			}
           					str += '</div></li>'
                			}
                		}
            			ostr = str;
                		$("#mergeItemBed ul").append(str);
            		}else{
            			str += '<li id="packageBought" class="flex-info-center flex-cont"></li>';
            			$("#mergeItemBed ul").append(str);
            			$("#unsubscribe").unbind();
            			$("#mergeItemBed div.title").text("未购买套餐");
            		}
                }else {
                    openMessageModal("<p>"+data.res_info+"</p>");
                }
            }
        });
    }
	function grayTheBtn(){
		debugger;
		var btn = $("#activeBtn");
    	btn.removeClass("activeBtn");
    	btn.addClass("deactiveBtn");
	}
	function lightTheBtn(){
		var btn = $("#activeBtn");
    	btn.removeClass("deactiveBtn");
    	btn.addClass("activeBtn");
	}
	function showMergeWindow(){
   		$(".modal-window-merge-mask").css("display","block");
   	}
    function hideMergeWindow(){
    	$(".modal-window-merge-mask").css("display","none");
    	$(".modal-item").text("");
    }
    function mergePackage(){
    	if(chosen.length>1){
    		var param = {};
        	param.multiIdList=chosen;
        	$.ajax({
                url:"/mppay/packagesInfoIfCombined",
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
                	debugger;
                	console.log(data);
                    if(data.result==0){
                    	$(".modal-item").text("你确定要合并"+chosen.length+"个套餐？合并后得到的套餐为【"+data.data.packagesPersonNum+"人"+data.data.year+"年期套餐】");
                    	showMergeWindow();
                    }else {
                        openMessageModal("<p>"+data.res_info+"</p>");
                    }
                },
            })
    	}else{
    		openMessageModal("<p>请选择需要合并的套餐</p>");
    	}
    }
    function mergePackageConfirm(){
    	if(chosen.length>1){
    		var param = {};
        	param.multiIdList=chosen;
        	$.ajax({
                url:"/mppay/combinedPackages",
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
                	debugger;
                	console.log(data);
                    if(data.result==0){
                    	window.location.href="/charge/activepackage.html?"+retParam;
                    }else {
                        openMessageModal("<p>"+data.res_info+"</p>");
                    }
                },
            })
    	}else{
    		openMessageModal("<p>请选择需要合并的套餐</p>");
    	}
    }
</script>
</body>
</html>

