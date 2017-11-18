

        $(".select2").select2();
        $('.selectpicker').selectpicker();
   

(function() {

    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

})();
function addRibbon(pub,stat){
   if(stat == 1){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-success").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-check-circle");
   }
   else if(stat == 2){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-warning").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-pause-circle");
   } 
   else if(stat == 3){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-danger").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-times-circle");
   }
}
$(".approve").on('click',function(){
    console.log("APPRVOE");
    var pub = $(this);
    
    swal({   
        title: "Are you sure?",                                           
        showCancelButton: true,   
        reverseButtons:true,
        confirmButtonColor: "#00C292",   
        confirmButtonText: "Yes",   
        cancelButtonText: "No", 
        focusConfirm:false,
        focusCancel:false,
        showLoaderOnConfirm: true,
        preConfirm: function (data) {
            console.log(data);
            return new Promise(function (resolve, reject) {
                    $.ajax({
                        type:'POST',
                        url:'/PNP/Pubs/checking',
                        data:{
                            id:pub.attr("data-id"),
                            stat:1,
                            comment:''

                        },
                        success:function(data){
                            addRibbon(pub,1)
                            console.log(data);
                            resolve(data[0]);
                           
                        }
                         
                    });
            //         resolve(data);
            // addRibbon(pub);  

            })

        }
         
    }).then(function(data){
        console.log("DATA ON APPROVE");
        console.log(pub.attr("data-id"));
        if(data){
            swal("Good job!", "You clicked the button!", "success");    
        }
        
        
    });
});
$(".pend").on('click',function(){
     var pub = $(this);
    var question = '<div class="row">'+
                        '<div class="col-md-12 text-left m-b-20">'+
                            '<br/>Select the sections that should be change, then explain why.<br/>'+
                        '</div>'+
                     
                        '<div class="form-group col-md-12">'+
                            '<label class="col-md-12 text-left"><strong>Explanation</strong></label>'+
                            '<div class="col-md-12">'+
                                '<textarea class="form-control" rows="5"></textarea>'+
                            '</div>'+
                        '</div>'+
                    '</div>';
    
    
    swal({   
        title: "Defer",   
        text:"Select the sections that should be change, then explain why.",
        html:question,
        focusConfirm:false,
        focusCancel:false,
        showLoaderOnConfirm: true,
        reverseButtons:true,
        allowOutsideClick: false,
        preConfirm: function (data) {
            console.log(data);
            return new Promise(function (resolve, reject) {
                    $.ajax({
                        type:'POST',
                        url:'/PNP/Pubs/checking',
                        data:{
                            id:pub.attr("data-id"),
                            stat:2,
                            comment:$("textarea").val()

                        },
                        success:function(data){
                            addRibbon(pub,2)
                            console.log(data);
                            resolve(data[0]);
                           
                        }
                         
                    });
            //         resolve(data);
            // addRibbon(pub);  

            })

        }
         
    }).then(function(data){
        console.log("DATA ON APPROVE");
        console.log(pub.attr("data-id"));
        if(data){
            swal("Good job!", "You clicked the button!", "success");    
        }
        
        
    });
         
});

$(".deny").on('click',function(){
     var pub = $(this);
    var question = '<div class="row">'+
                        '<div class="col-md-12 text-left  m-b-20" style="padding-left:16px">'+
                            '<br/>State the reason for rejection.<br/>'+
                        '</div>'+
                        
                        '<div class="form-group col-md-12">'+
                            
                            '<div class="col-md-12">'+
                                '<textarea class="form-control" rows="5"></textarea>'+
                            '</div>'+
                        '</div>'+
                    '</div>';
    swal({   
        title: "Reject",   
        
        html:question,
        showLoaderOnConfirm: true,
        focusConfirm:false,
        focusCancel:false,
        reverseButtons:true,
        allowOutsideClick: false,
        showCancelButton: true,   
        confirmButtonColor: "#FB9678",   
        confirmButtonText: "Submit",   
        cancelButtonText: "Cancel",
        preConfirm: function (data) {
            console.log(data);
            return new Promise(function (resolve, reject) {
                    $.ajax({
                        type:'POST',
                        url:'/PNP/Pubs/checking',
                        data:{
                            id:pub.attr("data-id"),
                            stat:3,
                            comment:$("textarea").val()

                        },
                        success:function(data){
                            addRibbon(pub,3)
                            console.log(data);
                            resolve(data[0]);
                           
                        }
                         
                    });
            //         resolve(data);
            // addRibbon(pub);  

            })

        }
         
    }).then(function(data){
        console.log("DATA ON APPROVE");
        console.log(pub.attr("data-id"));
        if(data){
            swal("Good job!", "You clicked the button!", "success");    
        }
        
        
    });

});





// // Date Picker
// jQuery('.mydatepicker, #datepicker').datepicker();
// jQuery('#datepicker-autoclose').datepicker({
//     autoclose: true,
//     todayHighlight: true
// });
// jQuery('#datepicker-autoclose2').datepicker({
//     autoclose: true,
//     todayHighlight: true
// });
// jQuery('#date-range').datepicker({
//     toggleActive: true
// });
// jQuery('#datepicker-inline').datepicker({
//     todayHighlight: true
// });


    $(".el-card-item").hover(function(){
       $(this).find("div.actions").css("visibility","visible");
    },function(){
         $(this).find("div.actions").css("visibility","hidden");
    });
$(".modal-desc").on('click',function(){
    var d = $(this)
     new Promise(function (resolve, reject) {
                                $.ajax({
                                    type:'POST',
                                    url:'/Organization/Publicity/modal',
                                    data:{id:d.attr("data-id"),type:1},                                 
                                    success:function(data){
                                        resolve(data);
                                    }
                                });
                               

                        }).then(data=>{
                            console.log(data);
                            var modal = $("#online-1").html(data);
                            $("#online-1").modal('show');

                            
                        })
});
