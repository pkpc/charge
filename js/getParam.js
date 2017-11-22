/**
 * Created by zl on 2016/11/22.
 */
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
function geturlParams(){
	var url = document.URL;
	var str = url.split("?")[1];
	var params = str.split("#")[0];
	return params;
}
function getAllParamsStringFromUrl(){
	var str = "";
	var url = location.search;
	if (url.indexOf("?") != -1) {
	      str = url.substr(1);
	}
	return str;
}
function getAllParamsStringPlusCurrentPageFromUrl(data){
	return "?"+getAllParamsStringFromUrl()+"#&"+data;
}
// //获得coolie 的值
// function getCookie(objName){//获取指定名称的cookie的值
//     var arrStr = document.cookie.split("; ");
//     for(var i = 0;i < arrStr.length;i ++){
//         var temp = arrStr[i].split("=");
//         if(temp[0] == objName) return unescape(temp[1]);
//     }
// }
function addCookie(objName,objValue,objHours){      //添加cookie
    var str = objName + "=" + escape(objValue);
    if(objHours > 0){                               //为时不设定过期时间，浏览器关闭时cookie自动消失
        var date = new Date();
        var ms = objHours*3600*1000;
        date.setTime(date.getTime() + ms);
        str += "; expires=" + date.toGMTString();
    }
    document.cookie = str;
}
//写cookies
function setCookie(name,value){
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString()+";path=/";
}
//读cookies
function getCookie(name){
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
    if(arr=document.cookie.match(reg)){
        return unescape(arr[2]);
    }else{
        return null;
    }
}