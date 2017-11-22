var userTel=""
var userTel=""
var submitCard="";
var defaultCard="";
var bankCard_had=false;
var defaultCard_use=false;
var cardNum_exist=true;

var countdown = 60;
var isNullReg = /^[\s]{0,}$/;
var phoneReg = /^(13|14|15|17|18)[0-9]{9}$/;
var idCardReg = /(^\d{15}$)|(^\d{17}([0-9]|X|x)$)/;
//    var cardReg = /^(\d{16}|\d{19})$/;
var cardReg = /^\d{10,25}$/;
var mid = null;

function contacts_eventHandler(){
    //点击展开
    $(".department").off("click").on("click",function(event){
        event.stopPropagation();
        if ($(this).attr("status") == 0) {//没展开
            $(this).children(".department-icon").replaceWith('<img class="department-icon" src="../../images/charge/contact-minus.png" alt="minus">');
            var height=$(this).children().children(".department-box").height();
            $(this).children(".department-box-height").css("height",height);
            $(this).children(".department-box-height").css("height","auto");
            $(this).attr("status", "1");
        } else if ($(this).attr("status") == 1) {
            $(this).children(".department-icon").replaceWith('<img class="department-icon" src="../../images/charge/contact-plus.png" alt="plus">');
            $(this).children(".department-box-height").css("height","0");
            $(this).attr("status", "0");
        }
    });
    //点击选中
    $("div.checked").off("click").on("click",function(event){
        event.stopPropagation();
        debugger
        if ($(this).attr("status") == 0) {//没选中
            if(selectedAdmin.length==5){
                openModal($("div.modal"));
                settime($("div.modal"));
                return;
            }
            $(this).find("img").replaceWith('<img class="" src="../../images/charge/contact-checked.png" alt="no-checkeds">');
            $(this).attr("status","1");
            var cid = $(this).attr("data-id");
            var ftoken = $(this).attr("data-token")
            if(cid){
                if(is_SelectedAdmin(cid)){
                    $.each(selectedAdmin,function(i){
                        if(cid==this.cid){
                            selectedAdmin.splice(i,1);
                        }
                    })
                }else{
                    selectedAdmin.push({cid:cid,ftoken:ftoken});
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
        $("#selected-admin").html(selectedAdmin.length);

    });
}
function eventHandler(){
    $("#allOpen").off("click").on("click",function () {
        var note=$(this).html();
        if(note=="全部展开"){
            $(this).html("全部收起");
            $(".department[status=0]").click();
        }else if(note=="全部收起"){
            $(this).html("全部展开");
            $(".department[status=1]").click();
        }
    });
    //点击选中

    //设置搜索框样式
    $(".icon-box").off("click").click(function(){
        $("input.search-input").addClass("search-input-active");
        $("input.search-input").focus();
        $(".icon-box").addClass("icon-box-active");
        $("#search span").html("");
        searchStatus=1;
    });
    $("input.search-input").off("click").blur(function(){
        $("input.search-input").removeClass("search-input-active");
        $(".icon-box").removeClass("icon-box-active");
        $("#search span").html("搜索");
    })
    //设置加币账户管理员
    $("#add-admin").off("click").click(function(){
        debugger
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
                    openModal($(".modal-success"));
                    settime($(".modal-success"));
                }else{
                    alert(data.res_info);
                }
            }
        })
    });
    //搜索事件
    $("#search input").off("click").on("input propertychange",function(){
        var searchInfo = $(this).val();
        if(searchInfo!=""){
            debugger
            search(searchInfo);
            loadAccountAdmin(1);
        }else{
            debugger
            $("#contacts").html("");
            childDeps=[];
            setDepartment();
            setPerson();
            loadAccountAdmin(1);
        }

    })
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
            window.history.back();
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
        async:false,
        beforeSend:function(xhr){
            xhr.setRequestHeader("Authorization","Bearer "+mptoken)
        },
        success:function(data){
            originDepartment = data;

        }


    });
}
function setDepartment(){
    var html="";
    var data = originDepartment;
    $.each(data,function(i){
        if(this.parentId == null) {//一级部门
            html += '<div class="department ftsize14" data-department=' + this.id + ' data-level="0" status="0">';
            html+= '<img class="department-icon" src="../../images/charge/contact-plus.png" alt="plus">';
            html+= '<div class="department-detail">';
            html+= '<span class="department-name">' + this.name + '</span>'
            html+= '<span>(</span><span class="department-num">' + this.totalPeople + '</span><span>)</span>';
            html+= '</div> <hr class="contacts"/>';
            html+= '<div class="department-box-height"><div class=department-box><div class="department-box-level"></div></div></div>';
            html+= '</div>';
        }else{
//                    html += '<div class="department" data-department=' + this.id + ' data-level=' + this.parentId + ' status="0">';
            childDeps.push(this);
        }
    });
    $("#contacts").append(html);
    childDepartment(childDeps,1);
}
function getPerson() {
    $.ajax({
        url: getContacts_url,
        type: "get",
        async: false,
        beforeSend: function (xhr) {
            xhr.setRequestHeader("Authorization", "Bearer " + mptoken)
        },
        success: function (data) {
            originContacts=data;
            $("#companyNum").html(originContacts.length);
        }
    });

}
function setPerson(){
    debugger
    var data = originContacts;
    var html = "";
    var ceohtml = "";
    var nodepHtml = "";
    var deps = $(".department");
    $.each(data, function (i, data) {
        if (data.isAdmin == true) {//管理者
            ceohtml += '<div class="person">';
            ceohtml += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
            ceohtml += '<div class="person-detail">';
            ceohtml += '<span class="person-name">' + data.name + '</span>';
            ceohtml += '<span class="position">' + data.position + '</span></div>';
            ceohtml += '<div data-id="' + data.id + '" data-token="' + data.ftoken + '"  class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
            ceohtml += '<hr class="contacts"/></div>';
            $("#contacts").prepend(ceohtml);
        }else if(data.departmentId == undefined){//无部门
            nodepHtml += '<div class="person"  data-department="null" data-level="1">';
            nodepHtml += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
            nodepHtml += '<div class="person-detail">';
            nodepHtml += '<span class="person-name">' + data.name + '</span>';
            nodepHtml += '<span class="position">' + data.position + '</span></div>';
            nodepHtml += '<div data-id="' + data.id + '" data-token="' + data.ftoken + '" class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
            nodephtml += '<hr class="contacts"/></div>';
        }else{
            $.each(deps, function (i, deps) {
                var depsId = $(deps).attr("data-department");
                if (data.departmentId != undefined) {
                    if (depsId == data.departmentId) {
                        var html = "";
                        html += '<div class="person"  data-department="' + data.departmentId + '" data-level="1">';
                        html += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
                        html += '<div class="person-detail">';
                        html += '<span class="person-name">' + data.name + '</span>';
                        html += '<span class="position">' + data.position + '</span></div>';
                        html += '<div data-id="' + data.id + '" data-token="' + data.ftoken + '"  class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
                        html += '<hr class="contacts"/></div>';
                        var level = $(deps).attr("data-level");
                        if (data.isDepManager == true) {
                            $(deps).children().children(".department-box").children(".department-box-level").prepend(html);

                        } else {
                            $(deps).children().children(".department-box").children(".department-box-level").append(html);
                        }
//                                    for(i=0,i<depsTotalLevels,i++) {
//                                        if (level == 0) {
//                                            if (data.isDepManager == true) {
//                                                $(deps).children(".department-box").children(".department-box-level").prepend(html);
//
//                                            } else {
//                                                $(deps).children(".department-box").children(".department-box-level").append(html);
//                                            }
//
//                                        } else {
//                                            if (data.isDepManager == true) {
//                                                $(deps).children(".department-box").prepend(html);
//                                            } else {
//                                                $(deps).children(".department-box").append(html);
//                                            }
//                                        }
//                                    }
                    }
                }
            });
        }
        $("#contacts").append(nodepHtml);
    });
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
                        html+= '<div class="department-detail">';
                        html+= '<span class="department-name">' + indexDep.name + '</span>'
                        html+= '<span>(</span><span class="department-num">' + indexDep.totalPeople + '</span><span>)</span>';
                        html+= '</div><hr class="contacts"/>';
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
    var depName = $("span.department-name");
    var pName=originContacts;
    var pPosition = $("span.position");
    var depSearch_result =false;
    var pNameSearch_result =false;
    var pPosSearch_result =false;
//    $.each(depName,function(){
//        if(findString(depName.innerHTML,searchInfo)){
//            depSearch_result=true;
//        }
//  });
    var html="";
    $.each(pName,function(){
        if(findString(this.name,searchInfo)){
            html += createSearchPerson(this);
            pNameSearch_result=true;
        }
    });
    if(pNameSearch_result){

        $("#contacts").html(html);
    }
//    $.each(pPosition,function(){
//        if(findString(pPosition.innerHTML,searchInfo)){
//            pPosSearch_result=true;
//        }
//    });
}
function loadAccountAdmin(type){
    if(type==0){//0，页面加载
        var str = urlParams.accountAdmin;
    }else if(type==1){
        var str = selectedAdmin.toString();
    }
    if(str){
        var paramsAdmins=str.split(",");
        $("#selected-admin").html(paramsAdmins.length);
        if(paramsAdmins.length>0){
            var pageAdmin =$("div.checked");
            $.each(paramsAdmins,function(i,para){
                $.each(pageAdmin,function(i,page){
                    if($(page).attr("data-id")==para){
                        if(type==0){
                            $(page).click()
                        }else{
                            $(page).children("img").attr("src","../../images/charge/contact-checked.png");
                            $(page).attr("status","1");
                        }
                    }
                });
            });
        }
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
function createSearchPerson(data){
    var html="";
    html += '<div class="person"  data-department="' + data.departmentId + '" data-level="1">';
    html += '<img class="photo" src="' + imgbase_url + data.imageName + '" alt="">';
    html += '<div class="person-detail">';
    html += '<span class="person-name">' + data.name + '</span>';
    html += '<span class="position">' + data.position + '</span></div>';
    if(is_SelectedAdmin(data.id)){
        html += '<div data-id="' + data.id + '" class="checked" status="1"> <img class="" src="../../images/charge/contact-checked.png" alt="checked"></div>';
    }else{
        html += '<div data-id="' + data.id + '" class="checked" status="0"> <img class="" src="../../images/charge/no-checked.png" alt="no-checked"></div>';
    }
    html += '<hr class="contacts"/></div>';
    return html;
}
function is_SelectedAdmin(cid){

    var flag=false;
    if(selectedAdmin.length!=0) {
        $.each(selectedAdmin, function () {
            if (this.cid == cid) {
                flag = true;
            }
        });
    }
    return flag;
}