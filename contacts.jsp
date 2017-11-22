<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>加币账户管理员</title>
</head>
<body>
<div class="wrapper page ftsize14" id="contactsPage" data-callback="contactCall" style="background:#f8f8f9">
    <div class="modal-success" style="display:none">
            <span>设置成功</span>
    </div>
        <div id="search">
        <!--<input type="text" placeholder="搜索">-->
            <input type="text" class="search-input ftsize14">
            <div class="icon-box">
                <div class="icon-box-wrapper">
                <i class="icon-search"></i>
                <span style="color:#7a797b;position: relative;top:1px;">搜索</span>
                </div>
            </div>
    </div>
        <div id="head" class="clearfix">
        <div class="title fl">
            <span class="title" id="companyName"></span><span class="title">(</span><span id="companyNum" class="title"></span><span class="title">)</span>
        </div>
        <div id="allOpen" class="fr">全部展开</div>
    </div>
        <div class="content">
            <div id="contacts" style="overflow-x:hidden;overflow-y:hidden">




    </div>
        </div>
        <div id="footer">
        <div class="box">
            <span style="display: inline-block;height: 0.666667rem;line-height: 0.6666667rem;">
                <span class="selected-word ftsize15">已选择：</span>
                <span class="selected-word ftsize15" id="selected-admin"></span><span class="selected-word ftsize15">人</span>
                </span>
            <span id="add-admin">确定</span>
        </div>
    </div>

</div>


<script type="text/javascript">
    var selectedAdmin= new Array;
    var countdown= 1;
    var childDeps = new Array;
    var originDepartment;
    var display=false;
    var mptoken=getUrlParam("mptoken");
    var ftoken=getUrlParam("ftoken");
    var isAdmin=getUrlParam("isAdmin");
    var isxigu=getUrlParam("isxigu");
    var plusCoinReward=getUrlParam("plusCoinReward");
    var companyName=decodeURI(decodeURI(getCookie("companyName")));
    var userName=decodeURI(decodeURI(getCookie("userName")));
    var reqParams = "mptoken="+mptoken+"&ftoken="+ftoken+"&isAdmin="+isAdmin+"&plusCoinReward="+plusCoinReward+"&companyName="+companyName+"&userName="+userName;

    $(function(){
    //加载公司名字
    $("#companyName").html(decodeURI(decodeURI(getCookie("companyName"))));
    $("#companyNum").html(getUrlParam("companyNum"));
    headHtml = $("#head").html();
    getDepartment();
    contacts_eventHandler();
    eventHandler();
 
});
    function contacts_eventHandler(){
        //点击展开
        $(document).off("click",".department-detail").on("click",".department-detail",function(event){
            event.stopPropagation();
            var department = $(this).parent();
            if ($(department).attr("status") == 0) {//没展开
                $(department).children(".department-icon").replaceWith('<img class="department-icon" src="../../images/charge/contact-minus.png" alt="minus">');
                <%--$(department).children(".department-box-height").css("height","auto");--%>
                $(department).children(".department-box-height").css("display","block");

                $(department).attr("status", "1");
            } else if ($(department).attr("status") == 1) {
                $(department).children(".department-icon").replaceWith('<img class="department-icon" src="../../images/charge/contact-plus.png" alt="plus">');
                <%--$(department).children(".department-box-height").css("height","0");--%>
                $(department).children(".department-box-height").css("display","none");
                $(department).attr("status", "0");
            }
        });
        //点击选中
        $(document).off("click","div.checked:not(div.checked.admin)").on("click","div.checked:not(div.checked.admin)",function(event){
            event.stopPropagation();

            if ($(this).attr("status") == 0) {//没选中
                console.log('selectedAdmin',selectedAdmin);
    var selectedList = [];
    $.each($('div.checked[status="1"]'),function(obj){

    if(selectedList.indexOf($(this).attr('data-id')) ===-1){
    selectedList.push($(this).attr('data-id'));
    }
    });
                if(selectedList.length>=5){
                openNoteModal("管理员人数已达上限");
                <%--openModal($("div.note-modal"));--%>
                <%--settime($("div.note-modal"));--%>
                return;
                }
                //mainContactId去重
                var list = [];
                $.each(selectedAdmin,function(i,obj){
                if(list.indexOf(obj.cid) ===-1){
                list.push(obj.cid);
                }
                });




                $(this).find("img").replaceWith('<img class="" src="../../images/charge/contact-checked.png" alt="no-checkeds">');
                $(this).attr("status","1");
                var cid = $(this).attr("data-id");
                var ftoken = $(this).attr("data-token")
                if(cid){
                    if(is_SelectedAdmin(cid)){
                        <%--console.log('is_SelectedAdmin',cid)--%>
                        <%--$.each(selectedAdmin,function(i){--%>
                            <%--if(cid==this.cid){--%>
                                <%--&lt;%&ndash;selectedAdmin.splice(i,1);&ndash;%&gt;--%>
                            <%--}--%>
                        <%--})--%>
                    }else{
                        var haveRepeat = false;
                        $.each(function(obj){
                            if(cid === obj.cid){
                            haveRepeat = true;
                        }
                        });
                        if(!haveRepeat){
                        selectedAdmin.push({cid:cid,ftoken:ftoken});
                        }

                    }
                    }
            } else if ($(this).attr("status") == 1) {
                $(this).find("img").replaceWith('<img class="" src="../../images/charge/no-checked.png" alt="no-checkeds">');
                $(this).attr("status","0");
                var cid = $(this).attr("data-id");
                var ftoken = $(this).attr("data-token")

                if(cid) {
                    $.each(selectedAdmin, function (i) {
                        if (cid == this.cid) {
                            selectedAdmin.splice(i, 1);
                        }
                    });
                }
            }
    //最终人数计算：多身份只算一人
            var list = [];
            $.each($('div.checked[status="1"]'),function(obj){

                if(list.indexOf($(this).attr('data-id')) ===-1){
                    list.push($(this).attr('data-id'));
                }
            });
            <%--$("#selected-admin").html(selectedAdmin.length);--%>
            $("#selected-admin").html(list.length);

        });
    }
    function eventHandler(){
    $("#allOpen").off("click").on("click",function () {
            var note=$(this).html();
            if(note=="全部展开"){
                $(this).html("全部收起");
                $(".department[status=0]").children(".department-detail").click();
            }else if(note=="全部收起"){
                $(this).html("全部展开");
                $(".department[status=1]").children(".department-detail").click();
            }
        });
    //点击选中

    //设置搜索框样式
    $(".icon-box").off("click").click(function(){
        $("input.search-input").addClass("search-input-active");
        $("input.search-input").focus();
        $(".icon-box").addClass("icon-box-active");
        $("#search span").html("");
    });
    $("input.search-input").off("blur").blur(function(){
        if($(this).val()==""){
            $("input.search-input").removeClass("search-input-active");
            $(".icon-box").removeClass("icon-box-active");
            $("#search span").html("搜索");
        }

    })
    //设置加币账户管理员
    $("#add-admin").off("click").click(function(){

        //对selectedAdmin去重
        var list = [];
        $.each(selectedAdmin,function(i,obj){
            if(list.indexOf(obj.cid) ===-1){
                list.push(obj.cid);
            }else{
                selectedAdmin.splice(i,1);
            }
        });
        console.log(selectedAdmin);
        $.ajax({
            url:"/mppay/sccac",
            type:"post",
            data:JSON.stringify(selectedAdmin),
            contentType: "text/plain; charset=utf-8",
            dataType:"json",
            beforeSend:function(xhr){
                xhr.setRequestHeader("Authorization","Bearer "+mptoken);
            },
            success:function(data){
                //data=$.parseJSON(data);
                if(data.result==0){//成功
    debugger
                    openModal($(".modal-success"));
                    settime($(".modal-success"));
                }else{
                    openMessageModal(data.res_info);
                }
            }
        })
    });

    //搜索事件
    $("#search input").off("click").on("input propertychange",function(){
        var searchInfo = $(this).val();
        if(searchInfo!=""){
            
            search(searchInfo);
            contacts_eventHandler();
            loadAccountAdmin(1);
        }else{
            
            if($("#head").html()==""){
                $("#head").html(headHtml);
                eventHandler();
            }
            $("#contacts").html("");
            childDeps=[];
            setDepartment();
            setPerson();
            contacts_eventHandler();
            loadAccountAdmin(1);
        }

    })
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

    function openModal(modal){
    $(modal).css("display","block");
}
    function closeModal(modal){
    $(modal).css("display","none");
}
    function settime(modal) {
        if (countdown == 0) {
            closeModal(modal);
            countdown=1;
            if($(modal).hasClass("modal-success")){
                <%--window.history.back();--%>
    window.location.href = "//www.plusmoney.cn/charge/index.html?"+reqParams;
            }
            return;
        } else {
            countdown--;
        }
        setTimeout(function () {
                    settime(modal)
                }
                , 1000)
}
    function getDepartment(){
    $.ajax({
        url:getDpmList_url,
        type:"get",
        async:true,
        beforeSend:function(xhr){
            xhr.setRequestHeader("Authorization","Bearer "+mptoken)
        },
        success:function(data){
            originDepartment = data;
            $("#contacts").css("display","none");
            setDepartment();
            setPerson();
            $("#contacts").css("display","block");
            loadAccountAdmin(0);
            deleteIdirector();
            expendDept();
            $("div.checked.admin").children("img").attr("src","../../images/charge/haveCheck.png");
            $(".mask").css("display","none");
        },
        complete:function(){
            $(".mask").css("display","none");
        }
    });
}
    function setDepartment(){
    var html="";
    var data = originDepartment;
    $.each(data,function(i){
        if(this.parentId == null) {//一级部门
            if(this.name=='无部门'){
                return true;
            }else{
            html += '<div class="department ftsize14" data-department=' + this.id + ' data-level="0" status="0">';
            html+= '<img class="department-icon" src="../../images/charge/contact-plus.png" alt="plus">';
            html+= '<div class="department-detail ftsize14">';
            html+= '<span class="department-name ftsize14">' + this.name + '</span>'
            html+= '<span>(</span><span class="department-num">' + this.totalPeople + '</span><span>)</span>';
            html+= '</div> <hr class="contacts"/>';
            html+= '<div class="department-box-height"><div class=department-box><div class="department-box-level"></div></div></div>';
            html+= '</div>';
          }
        }else{
//                    html += '<div class="department" data-department=' + this.id + ' data-level=' + this.parentId + ' status="0">';
            childDeps.push(this);
        }
    });
    $("#contacts").append(html);
    childDepartment(childDeps,1);
}
    function setPerson(){
    console.log(originContacts);
        var data = originContacts;

        var html = "";
        var ceohtml = "";
        var nodepHtml = "";
        var deps = $(".department");
        $.each(data, function (i, data) {
         
            if (data.isAdmin == true) {//管理者
                ceohtml += '<div class="person admin">';
                ceohtml += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
                ceohtml += '<div class="person-detail ftsize14">';
                ceohtml += '<span class="person-name ftsize14">' + data.name + '</span>';
                if(data.position != undefined){
                    ceohtml += '<span class="position">' + data.position + '</span></div>';
                }else{
                    ceohtml += '<span class="position"></span></div>';
                }
                ceohtml += '<div data-id="' + data.mainContactId + '" data-contact="' + data.id + '" data-token="' + data.ftoken + '"  class="checked admin" status="1"><img class="" src="../../images/charge/haveCheck.png" alt="no-checked2"> </div>';
				ceohtml += '<hr class="contacts"/></div>';
                $("#contacts").prepend(ceohtml);
            }else if(data.departmentId == undefined||data.departmentName=='无部门'){//无部门

                nodepHtml += '<div class="person"  data-department="null" data-level="1">';
                nodepHtml += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
                nodepHtml += '<div class="person-detail ftsize14">';
                nodepHtml += '<span class="person-name">' + data.name + '</span>';
                if(data.position != undefined){
                    nodepHtml += '<span class="position">' + data.position + '</span></div>';
                }else{
                    nodepHtml += '<span class="position"></span></div>';
                }
                nodepHtml += '<div data-id="' + data.mainContactId + '" data-contact="' + data.id + '" data-token="' + data.ftoken + '" class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
				nodepHtml += '<hr class="contacts"/></div>';
            }else{
                $.each(deps, function (i, deps) {
                    var depsId = $(deps).attr("data-department");
                    if (data.departmentId != undefined) {
                        if (depsId == data.departmentId) {
                            var html = "";
                            html += '<div class="person"  data-department="' + data.departmentId + '" data-level="1">';
                            html += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
                            html += '<div class="person-detail ftsize14">';
                            html += '<span class="person-name">' + data.name + '</span>';
                            if(data.position != undefined){
                                html += '<span class="position">' + data.position + '</span></div>';
                            }else{
                                html += '<span class="position"></span></div>';
                            }
                            html += '<div data-id="' + data.mainContactId + '" data-contact="' + data.id + '" data-token="' + data.ftoken + '"  class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
							html += '<hr class="contacts"/></div>';
                            var level = $(deps).attr("data-level");
                            if (data.isDepManager == true) {
                                $(deps).children().children(".department-box").children(".department-box-level").prepend(html);

                            } else {
                                $(deps).children().children(".department-box").children(".department-box-level").append(html);
                            }

                        }
                    }
                });
            }
        });

        $("#contacts").find('.person.admin').after(nodepHtml);
    }
    function childDepartment(childDeps,index){
    var index =parseInt(index);
    var childDepsTemp =new Array;
    var deps=$(".department");
    var html="";
    if(childDeps.length!=0){
        $.each(childDeps,function(i,indexDep){
            var deps=$(".department");
            if(this.path[index]==this.id){//是index+1级部门
                $.each(deps,function(i,currentDep){
                    
                    if(indexDep.path[index-1]==$(currentDep).attr("data-department")){
                        var html="";
                        html += '<div  class="department ftsize14" data-department=' + indexDep.id + ' data-level="'+ index +'" status="0">';
                        html+= '<img class="department-icon" src="../../images/charge/contact-plus.png" alt="plus">';
                        html+= '<div class="department-detail ftsize14">';
                        html+= '<span class="department-name ftsize14">' + indexDep.name + '</span>'
                        html+= '<span>(</span><span class="department-num">' + indexDep.totalPeople + '</span><span>)</span>';
                        html+= '</div> <hr class="contacts"/>';
                        html+= '<div class="department-box-height"><div class=department-box><div class="department-box-level"></div></div></div>'
                        html+= '</div>';
                        
                        $(currentDep).children().children(".department-box").append(html);
//                        var addedDeps = $(currentDep).siblings('.dempartment[data-level=' + index + ']');
//                        if(addedDeps.length==0) {
//                            $(currentDep).after(html);
//                        }else{
//                            $(addDeps[addDeps.length-1]).after(html);
//                        }
                    };
                })

            }else{
                childDepsTemp.push(this);
            }
        });
        childDepartment(childDepsTemp,index+1);
    }else{
        depsTotalLevel= index;
        return false;
    }

}
    function search(searchInfo){
    var pName=originContacts;
    var pNameSearch_result =false;
    var html="";
    $.each(pName,function(){
        if(findString(this.name,searchInfo)){
            html += createSearchPerson(this);
            pNameSearch_result=true;
        }
    });
    if(pNameSearch_result){
        if($("#head").html()==""){
            $("#head").html(headHtml);
            eventHandler();
        }
        $("#contacts").html(html);
    }else{
        $("#head").html("");
        html='<p style="height: 1.173333333rem;text-align: center;line-height: 1.17333333rem;color: #030303;border-bottom: 1px solid #efefef;">没有匹配的结果</p>'
         $("#contacts").html(html);
	}

}
    function loadAccountAdmin(type){
        var admin = new Object();
        admin.cid = $("div.checked.admin").attr("data-id");
        admin.ftoken = $("div.checked.admin").attr("data-token");
        var str =getUrlParam("accountCharger");
        if(type==0){
            selectedAdmin=[];
            if(str!=""){
                var paramsAdmin = str.split(",");//转换为数组
                //超级管理员不在传来的链接里
                if(paramsAdmin.indexOf(admin.cid)==-1){
                    selectedAdmin.push(admin);//
                }
                var pageUser =$("div.checked");
                var temp = paramsAdmin;
                $.each(pageUser,function(i,page){
                    if(temp.indexOf($(page).attr("data-contact"))!=-1){
                        var adminTemp= new Object();
                        adminTemp.cid = $(page).attr("data-id");
                        adminTemp.ftoken = $(page).attr("data-token");
                        selectedAdmin.push(adminTemp);
                        $(page).children("img").attr("src","../../images/charge/contact-checked.png");
                        $(page).attr("status","1");
                        temp.splice(temp.indexOf($(page).attr("data-id")),1);
                    }
                })

    console.log(selectedAdmin);
            }else{//传来的管理员为空,异常状况
                selectedAdmin.push(admin);
                }
        }else{//type==1
            var pageUser = $("div.checked");
            $.each(pageUser,function(i,page){
                $.each(selectedAdmin,function(){
                    var selectedAdminId = this.cid;
                    if(selectedAdminId==$(page).attr("data-id")){
                    $(page).children("img").attr("src","../../images/charge/contact-checked.png");
                    $(page).attr("status","1");
                    }
                });
            });
        }
        $("#selected-admin").html(selectedAdmin.length);
}
    function findString(str,searchInfo) {
    str=str.toLowerCase();
    searchInfo=searchInfo.toLowerCase();
    if (str){
        return str.split(searchInfo).length - 1;
    }
    return 0;
}
    function createSearchPerson(data){
    var html="";
    html += '<div class="person"  data-department="' + data.departmentId + '" data-level="1">';
    html += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
    html += '<div class="person-detail ftsize14">';
    html += '<span class="person-name ftsize14">' + data.name + '</span>';
    if(data.position != undefined){
        html += '<span class="position ftsize14">' + data.position + '</span></div>';
    }else{
        html += '<span class="position ftsize14"></span></div>';
    }
    if(is_SelectedAdmin(data.mainContactId)){
        html += '<div data-id="' + data.mainContactId + '" data-contact="' + data.id + '" data-token="' + data.ftoken + '" class="checked" status="1"> <img class="" src="../../images/charge/contact-checked.png" alt="checked"></div>';
    }else{
        html += '<div data-id="' + data.mainContactId + '" data-contact="' + data.id + '" data-token="' + data.ftoken + '"  class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
    }
    html += '<hr class="contacts"/></div>';
    return html;
}
    function is_SelectedAdmin(cid){

    var flag=false;
    if(selectedAdmin.length!=0) {
        $.each(selectedAdmin, function () {
            if (this.cid == cid) {
    console.log('this.cid',this.cid);
                flag = true;
            }
        });
    }
return flag;
}
    function deleteIdirector(){
        var department = $('.department-name');
        $.each(department,function(){
            if($(this).html()=='独立董事'){
                $(this).parent().parent().css("display","none");
            }
        });
    }
    function compareObjByOption(prop) {
    return function (obj1, obj2) {
    var val1 = obj1[prop];
    var val2 = obj2[prop];
    if (!isNaN(Number(val1)) && !isNaN(Number(val2))) {
    val1 = Number(val1);
    val2 = Number(val2);
    }
    if (val1 < val2) {
    return -1;
    } else if (val1 > val2) {
    return 1;
    } else {
    return 0;
    }
    }
    }

    function expendDept(){
    var list = [];
    var contactArr = originContacts.sort(compareObjByOption('id'));
    $.each(selectedAdmin,function(i,obj){
    $.each(originContacts,function(index,contact){
        if(parseInt(obj.cid) === contact.id){
    if(contact.departmentPath !== undefined){
        list = list.concat(contact.departmentPath);
    }
    }
    });
    });
    list = list.unique();
    $.each(list,function(i,deptId){
    console.log(deptId);
    $(".department[data-department="+deptId+"]").children(".department-detail").click();
    });
    }
</script>
</body>
</html>

