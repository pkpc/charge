function dataReady(){
    var html="";
    var url="/redPocket/QueryCoinFundWater?accountid="+urlParams.companyId;//1374700
    $.get(url,function(data){
        data = JSON.parse(data);
        if(data.result==0){
            if(data.msg!=""){
                $.each(data.msg,function(i){
                    html+='<div class="row">';
                    html+='<span class="col col1">' + (i+1) + '</span>';
                    if(this.tradeType==21){
                        html+='<span class="col col2">大管加使用费</span>';
                        html+='<span class="col col3 consume">-' + this.payOut + '</span>';
                    }else if(this.tradeType==20){
                        html+='<span class="col col2">充值</span>';
                        html+='<span class="col col3 charge">' + this.income + '</span>';
                    }
                    var date = this.tradeDate.substring(0,this.tradeDate.lastIndexOf(":"));
                    html+='<span class="col col4">' + date + '</span>';
                    html+='</div>';
                });
                $("div.account").html(html);
            }
        }
    });
}