
    (function() {

        [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
            new CBPFWTabs(el);
        });

    })();
    $("#approve").click(function(){
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
                console.log("DATA");
                return new Promise(function (resolve, reject) {
                  setTimeout(function() {
                    if (data === 'taken@example.com') {
                      reject('This email is already taken.')
                    } else {
                      resolve()
                    }
                  }, 2000)
                })
            }
             
        }).then(function(data){
            if(data){
                $("#form-id").submit();
            }
            console.log(data);
            console.log("ASD");
            $("html, body").animate({ scrollTop: 0 },function(){
                $('#doc').removeClass("bounceInRight animated").addClass("bounceInRight   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                    $(this).removeClass("bounceInRight animated");
                });    
            });
            
        });
    });
    $("#defer").click(function(){
        var question = '<div class="row">'+
                            '<div class="col-md-12 text-left m-b-20">'+
                                '<br/>Select the sections that should be changed, then explain why.<br/>'+
                            '</div>'+
                            '<div class="form-group col-md-12">'+
                                '<label class="col-md-12 text-left"><strong>Sections to be Edited:</strong></label>'+
                                '<div class="col-md-12">'+
                                    '<select class="col-md-12" multiple="" name="sections" id="select-sec">'+
                                        
                                        '<option value="Particulars">I. Particulars</option>'+
                                        '<option value="Memo">II. Memo</option>'+
                                        '<option value="Attachments">III. Attachments</option>'+
                                        
                                        
                                    '</select>'+
                                '</div>'+
                                
                            '</div>'+
                            '<div class="form-group col-md-12">'+
                                '<label class="col-md-12 text-left"><strong>Explanation</strong></label>'+
                                '<div class="col-md-12">'+
                                    '<textarea id="explain" class="form-control" rows="5" name="explain"></textarea>'+
                                '</div>'+
                            '</div>'+
                        '</div>';
        
        
        swal({   
            title: "Pend",   
            text:"Select the sections that should be change, then explain why.",
            html:question,
            focusConfirm:false,
            focusCancel:false,
            showLoaderOnConfirm: true,
            reverseButtons:true,
            allowOutsideClick: false,
            preConfirm: function (data) {
                console.log($("#select-sec").val());
                console.log("DATA");
                return new Promise(function (resolve, reject) {
                  setTimeout(function() {
                    if (data === 'taken@example.com') {
                      reject('This email is already taken.')
                    } else {
                      resolve()
                    }
                  }, 2000)
                })
            },
            onOpen:function(ele){
                $(ele).find("select").select2();
                console.log("INIT SELECT");
            },
           
            showCancelButton: true,   
            confirmButtonColor: "#FEC107",   
            confirmButtonText: "Pend",   
            cancelButtonText: "Cancel",   
             
        }).then(function(data){
            if(data){
                $('<input>').attr({
                    type: 'hidden',
                    id: 'asd',
                    name: 'sections',
                    value:$("#select-sec").val()
                }).appendTo('#form-id2');

                $('<input>').attr({
                    type: 'text',
                    id: 'asd2',
                    name: 'explain',
                    value:$("#explain").val()
                }).appendTo('#form-id2');

                $("#form-id2").submit();
            }
            console.log(data);
            console.log("ASD");
            $("html, body").animate({ scrollTop: 0 },function(){
                $('#doc').removeClass("bounceOutUp animated").addClass("bounceOutUp   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                    $(this).removeClass("bounceOutUp animated");
                });    
            });
            
            
        });
    });
    
    $("#reject").click(function(){
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
            preConfirm: function (email) {
                return new Promise(function (resolve, reject) {
                  setTimeout(function() {
                    if (email === 'taken@example.com') {
                      reject('This email is already taken.')
                    } else {
                      resolve()
                    }
                  }, 2000)
                })
            } 
           
        }).then(function(data){
            console.log(data);
            console.log("REJECT");
            $("html, body").animate({ scrollTop: 0 },function(){
                $('#doc').removeClass("rotateOutUpLeft animated").addClass("rotateOutUpLeft   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                    $(this).removeClass("rotateOutUpLeft animated");
                });
            });
            

        });

    });
