<!DOCTYPE html>
    <%@ page language="java" import="java.util.*" contentType="text/html;charset=utf-8"%>
<html lang="en">

<head>
    <title>账户明细</title>
</head>

<body>
    <div class="wrapper page ftsize15" id="accountDetailsPage" style="background:#fff">
        <div class="row row1">
            <span class="col col1">#</span><span class="col col2">项目</span><span class="col col3"><img src="../../images/charge/plus-icon.png" alt=""></span><span class="col col4">日期</span>
        </div>
        <div class="content">
            <div class="account">
            </div>
        </div>
    </div>
    <script>
    var pageNum = 1;
    $(function() {
        createPageItem(pageNum);
    });

    function dataReady() {}

    function createPageItem(pageNum) {
        var html = "";
        var params = {};
        var data = {
            accountid: getUrlParam("PMcompanyId"),
            page: pageNum,
            dataNum: 20
        };
        params.url = '/mppay/gccw';
        params.type = 'post';
        params.data = JSON.stringify(data);
        params.headers = {
            Authorization: 'Bearer ZTY0NjI1ODVmOTE4MzRiY2Y1ZTczYzM4NzE5ODZmZDE5MGFlMjYzOGVkZTVmNjdjYjlhZGU1MTc4NWQ4MWQ4Yw'
        };
        params.contentType = "text/plain";
        params.beforeSend = function() {
            if (pageNum > 1) {

                var html = '<div id="loading" class="ftsize15" style="text-align:center;height:1.17333rem;line-height:1.17333rem;">';
                html += '加载中....</div>';
                $("div.account").append(html);
            }
        };
        params.complete = function() {
            $("#loading").remove();
        }
        params.success = function(data) {
            var data = JSON.parse(data);
            console.log(data);
            var html = "";
            if (data.result == 0) {
                if (data.list.length > 0) {
                    $.each(data.list, function(i) {
                        if (this.tradeType == 22 || this.tradeType == 23) {
                            html += '<a class="row" href="account-pluscoin-details.html?tradeType='+this.tradeType+'&tradeId=' + this.id + '&accountId=' + this.accountid+'">';
                        } else {
                            html += '<div class="row">';
                        }
                        html += '<span class="col col1">' + ((i + 1) + (pageNum - 1) * 20) + '</span>';
                        if (this.tradeType == 21) {
                            html += '<span class="col col2">大管加使用费</span>';
                            html += '<span class="col col3 consume">-' + this.payOut + '</span>';
                        } else if (this.tradeType == 20) {
                            html += '<span class="col col2">充值</span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        } else if (this.tradeType == 22) { //转出
                            html += '<span class="col col2"><span>加币转出</span><img src="../../images/img-icon-detail.png" class="detail-img" alt="" /></span>';
                            html += '<span class="col col3 consume">-' + this.payOut + '</span>';
                        } else if (this.tradeType == 23) { //转入
                            html += '<span class="col col2"><span>加币转入</span><img src="../../images/img-icon-detail.png" class="detail-img" alt="" /></span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        } else if (this.tradeType == 24) { //MP新增注册员工奖励
                            html += '<span class="col col2">绑定手机奖励</span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        } else if (this.tradeType == 25) { //购买包年套餐
                            html += '<span class="col col2">购买包年套餐</span>';
                            html += '<span class="col col3 consume">-' + this.payOut + '</span>';
                        } else if (this.tradeType == 26) { //退订包年套餐
                            html += '<span class="col col2">退订包年套餐</span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        } else if (this.tradeType == 27) { //新手奖励
                            html += '<span class="col col2">新手奖励</span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        }else if(this.tradeType == 32){
                            html += '<span class="col col2">升级套餐</span>';
                            html += '<span class="col col3 consume">-' + this.payOut + '</span>';
                        } else if(this.tradeType == 30){  //兑现分润
                            html += '<span class="col col2">兑现分润</span>';
                            html += '<span class="col col3 charge">' + this.income + '</span>';
                        } else{
                            html += '<span class="col col2">' + this.remark + '</span>';
                            if (this.income == 0) {
                                html += '<span class="col col3 consume">-' + this.payOut + '</span>';
                            } else {
                                html += '<span class="col col3 charge">' + this.income + '</span>';
                            }
                        }

                        html += '<span class="col col4">' + formatDate(this.tradeTime) + '</span>';
                        if (this.tradeType == 22 || this.tradeType == 23) {
                            html += '</a>';
                        } else {
                            html += '</div>';
                        }
                    });
                    $("div.account").append(html);
                } else {
                    if (pageNum == 1) {
                        html += '<div style="text-align: center;margin-top: 2.9333333333rem;">';
                        html += '<img src="../../images/charge/account-detail-blank-icon.png" style="width: 1.92rem;">'
                        html += '<p class="ftsize12" style="margin-top: .2666666rem;color: #999;">暂无账户明细</p></div>'
                        $("div.account").html(html);
                    }

                }
            }
        };
        $.ajax(params);
    }

    $("#accountDetailsPage .content").scroll(function() {
        console.log(1);
        viewH = $(this).height(), //可见高度
            contentH = $(this).get(0).scrollHeight, //内容高度
            scrollTop = $(this).scrollTop(); //滚动高度
        if (scrollTop / (contentH - viewH) == 1 && $("#loading").length === 0) {
            createPageItem(++pageNum);
        }
    });

    function formatDate(tradeTime) {
        var time = new Date(tradeTime);
        var year = time.getFullYear().toString();
        var month = (time.getMonth() + 1).toString();
        var day = time.getDate().toString();
        var h = time.getHours().toString();
        var mm = time.getMinutes().toString();
        month = month.length == 2 ? month : '0' + month;
        day = day.length == 2 ? day : '0' + day;
        h = h.length == 2 ? h : '0' + h;
        mm = mm.length == 2 ? mm : '0' + mm;
        var date = year + '-' + month + '-' + day + '  ' + h + ':' + mm;
        return date;
    }
    </script>
</body>

</html>
