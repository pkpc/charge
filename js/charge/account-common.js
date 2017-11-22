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
function Token(){
    if(ftoken!=null&&ftoken.length>8){
        $.ajax({
            async:false,
            type: "POST",
            url:"/mpapp/getToken",
            success:function(data){

                data = $.parseJSON(data);
                if(data.result == "0"){
                    debugger
                    var token = data.token;
                    addCookie("136a3d03-9748-4f83-a54f-9b2a93f979a0",token,"1","/","");
                }else{
                    alert(data.msg);
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
            xhrFields: {
                withCredentials: true
            },
            crossDomain: true,
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
                    alert("不好意思，登录失败，可以帮程序猿联系下客服反映下错误吗，谢谢");
                }
            }
        });
    }
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
    var empNum=parseInt(empNum);
    var amount=parseInt(amount);
    if(amount>0&&empNum>0){
        return parseInt(amount/empNum/6);
    }else{
        return 0;
    }
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
        success:function(data){

            if(data.result==0){
                urlParams.accountAdmin=data.data.accountCharger;
                urlParams.companyId=data.data.companyId;
            }
        },
    })
}
function getUrlParam(paras){
    var url = document.location.href;
    var paraString = url.substring(url.lastIndexOf("?")+1,url.length).split("&");
    var paraObj = {}
    for (i=0; j=paraString[i]; i++){
        paraObj[j.substring(0,j.indexOf("=")).toLowerCase()] = j.substring(j.indexOf("=")+1,j.length);
    }
    var returnValue = paraObj[paras.toLowerCase()];
    if(typeof(returnValue)=="undefined"){
        return null;
    }else{
        return returnValue;
    }
}
function addUrlParams(url,params){
    if(url.lastIndexOf("?")!=-1){
        url=url.substring(0,url.lastIndexOf("?"));
    }
    url+='?';
    $.each(params,function(i,data){
        url += i+'='+data+"&";
    });
    url = url.substring(0,url.length-1);
    return url;
}