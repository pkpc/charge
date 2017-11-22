<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <%
	String res_data=request.getParameter("res_data");
%>
<script>
 var res_data = <%=res_data%>;
if(res_data==undefined||res_data.result_pay!="SUCCESS"){
    postMsgToApp();
        window.location.href = "//www.plusmoney.cn/charge/index.html?returnHome";
   }else{
   	window.location.href= "//www.plusmoney.cn/charge/charge-success1.html"
   }
    /* 向App发送消息 */
    function postMsgToApp(){
    var ua = window.navigator.userAgent.toLowerCase();
    try {
    if (/iphone|ipad|ipod/.test(ua)) {
    <%--window.webkit.messageHandlers.iOS.postMessage(obj)--%>
    } else if (/android/.test(ua)) {
    window.Android.updateUserProfile();
    <%--window.Android.updateUserProfile(JSON.stringify(obj).replace(/"/g, '\''))--%>
    }
    } catch (e) {

    }
    }
   
</script>
</head>
<body>
</body>
</html>