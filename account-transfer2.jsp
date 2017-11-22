<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币转账</title>
</head>
<body>
<div class="wrapper page ftsize15" id="account-transfer-page2" style="background:#efefef">
    <div class='content'>
    <div class="transfer-info-box">
        <ul id="account-input">
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-name"></span><span class="title">接收人</span>
                </div><input id="transfer-userName" class="ftsize15" type="text" placeholder="请输入接收人的真实姓名">
            </li>
            <li class="clearfix">
                <div class="box">
                    <span class="item-icon icon-phone"></span><span class="title">手机号</span>
                </div><input id="transfer-telNum" class="ftsize15" type="tel" placeholder="请输入接收人的手机">
                <input style="display:none" id="true-transfer-telNum" class="ftsize15" type="tel">
            </li>
            <li class="clearfix select-company">
                <div class="select-company-note">请选择接收加币的公司</div>
                <img class="icon-select-down" src="../../images/charge/black-arrow-down.png">
                <div class="box">
                    <span class="item-icon icon-select-company"></span><span class="title">公司</span>
                </div>
            </li>
        </ul>
        <div class="next_btn ftsize18">
            <div class="transfer2-mask" style="display:none"></div>
            <a id="account-transfer3" href="javascript:void(0)" data-preventdefault="isParamsReady" data-mask="false" data-reload="false" >
                下一步
            </a>
        </div>
    </div>
    <div id="select-his-receiver">
            <div class="his-box">

            </div>
        </div>
    </div>
</div>
<script>
    var mptoken = getUrlParam("mptoken");
    $(function(){
        $("#transfer-userName").val("");
        $("#transfer-telNum").val("");
        $("#transfer-select-company").html("");
        $(".select-company-note").css("display","block");


        //事件绑定
        getHisReceiver();
        trans2EventHandler();
    });
    function trans2EventHandler(){
        //加载可选择公司
        $("#transfer-telNum").on("input propertychange",function(){
            var receiverName = $("#transfer-userName").val();
            var receiverTel = $("#transfer-telNum").val();
            $("#true-transfer-telNum").val(receiverTel);
            if(checkTransName()&&checkTransPhone()){
                getReceiverCompany(receiverName,receiverTel);
            }else{
                var select = $("li.select-company #transfer-select-company")
                if(select.length!=0){
                    $("li.select-company #transfer-select-company").remove();
                    $(".select-company-note").css("display","block");
                }
                testParamReady();
            }

        });
        $("#transfer-userName").on("input propertychange",function(){
            var receiverName = $("#transfer-userName").val();
            var receiverTel = $("#transfer-telNum").val();
            if(checkTransName()&&checkTransPhone()){
                getReceiverCompany(receiverName,receiverTel);
            }else {
                var select = $("li.select-company #transfer-select-company")
                if(select.length!=0){
                    $("li.select-company #transfer-select-company").remove();
                    $(".select-company-note").css("display","block");
                }
                testParamReady();
            }
        });
        //公司更换


    }
    function selectChange(){
 
        testParamReady();
    }
    <%--ZTY0NjI1ODVmOTE4MzRiY2Y1ZTczYzM4NzE5ODZmZDE5MGFlMjYzOGVkZTVmNjdjYjlhZGU1MTc4NWQ4MWQ4Yw--%>
    function getReceiverCompany(receiverName,receiverTel,companyName){

        var params={};
        params.url = 'https://www.erplus.co/api/v1/profile/belongCompany/?phone='+receiverTel+'&name='+receiverName;
        params.type = 'get';
        params.headers ={
            Authorization:'Bearer '+mptoken
        };
        params.beforeSend = function(){
            $(".transfer2-mask").css("display","block");
        };
        params.success = function(data){
            $("li.select-company #transfer-select-company").remove();
            if(data.code==404){
			   <%--$(".select-company-note").css("display","block");--%>
               <%--openNoteModal("用户与手机号不匹配");--%>
           }else{
               var html="";
               var companyCount = 0;
               $.each(data,function(){
			   //state==2是已删除公司
                   if(this.company!=null&&this.company.state!==2){
                       companyCount++;
                        var companyNameTemp ="";
                        if(this.company.name.length>13){
                        companyNameTemp = this.company.name.substring(0,13)+"...";
                        }else{
                        companyNameTemp = this.company.name;
                        }
                       if(companyCount==1&&companyName == null){
						   html+='<select onchange="selectChange()" id="transfer-select-company" class="ftsize15" type="select">';
                           html+='<option selected value='+ this.companyId +'>'+ companyNameTemp +'</option>';
                       }else if(companyCount==1){
                           html+='<select onchange="selectChange()" id="transfer-select-company" class="ftsize15" type="select">';
                           html+='<option value='+ this.companyId +'>'+ companyNameTemp +'</option>';

					   }else if(companyName==null){
                           html+='<option value='+ this.companyId +'>'+ companyNameTemp +'</option>';
                       }else{
                           if(this.company.name==companyName){
                               html+='<option selected value='+ this.companyId +'>'+ companyNameTemp +'</option>';
                           }else{
                               html+='<option value='+ this.companyId +'>'+ companyNameTemp +'</option>';
                           }
                       }
                   }
               });
			   $(".select-company-note").css("display","none");
			   html+='</select>';
               $("li.select-company").append(html);
               if(companyCount==1){
                   $("#transfer-select-company").attr("disabled","true");
                   $(".icon-select-down").remove();
               }else{
                   $("#transfer-select-company").removeAttr("disabled");
                   var str = '<img class="icon-select-down" src="../../images/charge/black-arrow-down.png">';
                   $("li.select-company").append(str);
               }
           }
        };
        params.complete = function(){
            testParamReady();
            $(".transfer2-mask").css("display","none");
        };
        $.ajax(params);
    }
    function checkTransPhone(){
        if(findString($("#transfer-telNum").val(),'****')){
            var phoneTemp = $("#true-transfer-telNum").val();
        }else{
            var phoneTemp = $("#transfer-telNum").val();
        }
    if(phoneTemp.length>=10){
    return true
    }else{
    return false
    }
        <%--if(isNullReg.test(phoneTemp)){--%>
            <%--return false;--%>
        <%--}--%>
    <%--else if(!phoneReg.test(phoneTemp)){--%>
            <%--return false;--%>
        <%--}--%>
    <%--else{--%>
            <%--return true;--%>
        <%--}--%>
    }
    function checkTransName(){
        var nameTemp = $("#transfer-userName").val();
        if(isNullReg.test(nameTemp)){
            return false;
        }else{
            return true;
        }
    }
    function testParamReady(){
        $(".transfer2-mask").css("display","block");
        var receiverName = $("#transfer-userName").val();
        if(findString($("#transfer-telNum").val(),"****")){
            var receiverTel = $("#true-transfer-telNum").val();
        }else{
            var receiverTel = $("#transfer-telNum").val();
        }
        var receiverCompany = $("#transfer-select-company").val();
        var toCompanyName = $("#transfer-select-company").find('option[value='+ receiverCompany +']').html();
        var fromCompanyId = getUrlParam("fromCompanyId");
        if(fromCompanyId==receiverCompany){
            openNoteModal("不支持同公司转账");
            $("#account-transfer3").parent().removeClass("btn-active");
            $("#account-transfer3").attr("href","javascript:void(0)");
        }else if(checkTransName()&&checkTransPhone()&&receiverCompany!=null&&receiverCompany!=""){
            $("#account-transfer3").parent().addClass("btn-active");
            var url = "account-transfer3.html?toCompanyId="+receiverCompany+'&transferName='+encodeURI(receiverName)+'&transferTel='+receiverTel+'&transferAmount='+getUrlParam("transferAmount")+'&fromCompanyId='+getUrlParam("fromCompanyId")+
                    '&toCompanyName='+toCompanyName;
            $("#account-transfer3").attr("href",url);
        }else{
            $("#account-transfer3").parent().removeClass("btn-active");
            $("#account-transfer3").attr("href","javascript:void(0)");
        }
        $(".transfer2-mask").css("display","none");
    }
    //历史联系人点击事件
    function loadHisReceiver(elm){
        var $elm = $(elm);
        var receiverTel = $elm.find(".his-tel-hidden").text();
        var receiverTelStar = $elm.find(".his-tel").text();
        var receiverName = $elm.find(".his-name").text();
        var companyName = $elm.find(".his-toCompanyName").text();
        $("#true-transfer-telNum").val(receiverTel);
        if($("#transfer-userName").val()==receiverName&&$("#transfer-telNum").val()==receiverTelStar&&$("#transfer-select-company").length!==0){
            var companyId = $elm.find(".companyId-hidden").text();
            $("#transfer-select-company").val(companyId);
        }else{
            $("#transfer-userName").val(receiverName);
            $("#transfer-telNum").val(receiverTelStar);
            getReceiverCompany(receiverName,receiverTel,companyName);
        }

    }
    //
    function getHisReceiver(){
        var params={};
        params.url = '/mppay/gctp?pmId='+getCookie("PMcompanyId");
        params.type = 'post';
        params.headers ={
            Authorization:'Bearer '+mptoken
        };
        params.beforeSend = function(){
            $(".transfer2-mask").css("display","block");
        };
        params.success = function(data){
            var data = JSON.parse(data);
            if(data.result== 0&&data.list.length>0){
                hisReceiver_data = data.list;
                createHisReceiver(hisReceiver_data,1);
            }
        };
        params.conplete = function(){

        };
        $.ajax(params);
    }
    function createHisReceiver(hisReceiver_data,type){
        //type:1 本页面的item 2:历史联系人页面里的item
        var str = "";
        var count = 0;
        $.each(hisReceiver_data,function(){
            count++;
            var phone = this.phone.split("#")[0];
            var phoneStart = phone.substring(0,3);
            var phoneEnd = phone.slice(-4);
            if(count==4&&type==1){
                return false;
            }
            if(type==1){
                str += '<a class="his-item" onclick="loadHisReceiver(this)">'
            }else{
                str += '<a class="his-item" onclick="loadHisReceiver(this);history.go(-1);">';
            }
            str+='<div class="his-item-box ftsize14">';
            str+='<span class="his-name">' + this.name + '</span>';
            str+='<span class="his-tel">'+phoneStart+'****'+phoneEnd +'</span>';
            str+='<span class="his-tel-hidden" style="display:none">'+phone+'</span>';
            str+='<span class="companyId-hidden" style="display:none">'+this.mpCompanyId+'</span>';
            str+='</div>';
            str+='<div class="his-toCompanyName ftsize13">'+this.companyName+'</div>';
            str+='<img src="../../images/charge/arrow.png" alt="arrow">';
            str+=' </a>';

        });

        if(type==1){
            var str1 = '';
            str1+='<div class="clearfix title">';
            if(count<=3){
                str1+='<a class="fl">近期联系人</a>';
                str1+='</div>'
            }else{
                str1+='<a class="fl">近期联系人</a>';
                str1+='<a class="fr" href="account-transfer-selectReceiver.html" data-reload="true">更多...</a></div>'
            }
            $("#account-transfer-page2 .his-box").append(str1+str);
               var marginTop = $(window).height()-$(".transfer-info-box").height()-$("#select-his-receiver").height() - 39;
	   $("#select-his-receiver").css("margin-top",marginTop+"px");


        }else{
            $("#account-transfer-Page4 .his-box .receiver").html("");
            $("#account-transfer-Page4 .his-box .receiver").append(str);
        }
    }
    function findString(str,searchInfo) {
        str=str.toLowerCase();
        searchInfo=searchInfo.toLowerCase();
        if (str){
            return str.split(searchInfo).length - 1;
        }
        return 0;
    }
</script>
</body>
</html>