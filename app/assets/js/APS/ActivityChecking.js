$(document).bind('customGenerated', function() {
    (function() {
        [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
            new CBPFWTabs(el);
        });

    })();
    // OLD THING
    // $('#section-linebox-5').css('visibility', "hidden");
    // $('#section-linebox-5').css('height', 0);
    // $('#section-linebox-5').css('width', 0);
    // $(document).on('click', '.sttabs li', function() {
    //     var page = $(this).find("a").attr("href");
    //     console.log(page);
    //     page = page.replace("#section-linebox-", "");
    //     console.log(page);
    //     if (page == "5") {
    //         console.log("REFRESH");

    //         $('#section-linebox-5').css('visibility', "visible");
    //         $('#section-linebox-5').css('height', "100%");
    //         $('#section-linebox-5').css('width', "100%");
    //     } else {
    //         $('#section-linebox-5').css('visibility', "hidden");
    //         $('#section-linebox-5').css('height', 0);
    //         $('#section-linebox-5').css('width', 0);
    //     }
    // });
});
$(document).trigger("customGenerated");
$(document).on('click', '#approve', function() {

    swal({
        title: "Are you sure?",
        showCancelButton: true,
        reverseButtons: true,
        confirmButtonColor: "#00C292",
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        focusConfirm: false,
        focusCancel: false,
        showLoaderOnConfirm: true,
        preConfirm: function(data) {
            console.log(data);
            console.log("DATA");
            return new Promise(function(resolve, reject) {
                setTimeout(function() {
                    if (data === 'taken@example.com') {
                        reject('This email is already taken.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        }

    }).then(function(data) {
        console.log("ASD");
        $("html, body").animate({
            scrollTop: 0
        }, function() {
            $('#doc').removeClass("bounceInRight animated").addClass("bounceInRight   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $(this).removeClass("bounceInRight animated");
            });
        });

    }).then(function() {
        $.ajax({
            type: 'POST',
            url: '/APS/ajax/SignProjectProposal',
            data: {
                activityID: $("#doc").attr("ct"),
                status: 1
            },

            success: function(data) {
                var doc = $(data).find("#doc");
                setTimeout(function() {
                    $("#doc").replaceWith(doc);
                    $(document).trigger("customGenerated");
                }, 1000);
            }
        });
    });
});
$(document).on('click', '#defer', function() {
    var question = '<div class="row">' +
        '<div class="col-md-12 text-left m-b-20">' +
        '<br/>Select the sections that should be change, then explain why.<br/>' +
        '</div>' +
        '<div class="form-group col-md-12">' +
        '<label class="col-md-12 text-left"><strong>Sections to be Edited:</strong></label>' +
        '<div class="col-md-12">' +
        '<select class="col-md-12" multiple="" id="select-sec">' +

        '<option value="Brief Context">I. Brief Context</option>' +
        '<option value="Program Design">II. Program Design</option>' +
        '<option value="Source of Funds">III. Source of Funds</option>' +
        '<option value="Organizational Funds">IV. Organizational Funds</option>' +
        '<option value="Revenue and Expense Table">V. Revenue and Expense Table</option>' +
        '<option value="Attachements">VI. Attachements</option>' +
        '</select>' +
        '</div>' +

        '</div>' +
        '<div class="form-group col-md-12">' +
        '<label class="col-md-12 text-left"><strong>Explanation</strong></label>' +
        '<div class="col-md-12">' +
        '<textarea id="comment" class="form-control" rows="5"></textarea>' +
        '</div>' +
        '</div>' +
        '</div>';


    swal({
        title: "Activity Details",
        text: "Select the sections that should be change, then explain why.",
        html: question,
        focusConfirm: false,
        focusCancel: false,
        showLoaderOnConfirm: true,
        reverseButtons: true,
        allowOutsideClick: false,
        preConfirm: function(data) {
            console.log($("#select-sec").val());
            console.log("DATA");
            return new Promise(function(resolve, reject) {
                setTimeout(function() {
                    if (data === 'taken@example.com') {
                        reject('This email is already taken.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        },
        onOpen: function(ele) {
            $(ele).find("select").select2();
            console.log("INIT SELECT");
        },

        showCancelButton: true,
        cancelButtonText: "Close",


    }).then(function(data) {

        console.log("ASD");
        $("html, body").animate({
            scrollTop: 0
        }, function() {
            $('#doc').removeClass("bounceOutUp animated").addClass("bounceOutUp   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $(this).removeClass("bounceOutUp animated");
            });
        });


    }).then(function(data) {
        $.ajax({
            type: 'POST',
            url: '/APS/ajax/SignProjectProposal',
            data: {
                activityID: $("#doc").attr("ct"),
                status: 2,
                comments: $("#comment").val(),
                sectionsToBeEdited: $("#select-sec").val()
                
            },
            success: function(data) {

                var doc = $(data).find("#doc");

                $("#doc").replaceWith(doc);
                $(document).trigger("customGenerated");
            }
        });
    });
});
$(document).on('click', '#reschedule', function() {
    var limit = $("#doc").attr("limit");
    var question = 

        '<div>' +
        '</div>' +
        '<div class="form-group col-md-12 >' +
            '<label class="col-md-12 text-left"  style="float:left" ><strong  style="float:left">New Schedule/s:</strong></label>' +
            '<input id="datepicker-inline" class="form-control mydatepicker" placeholder="" type="text">'+
            '<small> Number of dates should match the program design('+limit +')  </small>'+
        '</div>' +
        
        '<div class="form-group col-md-12">' +
            '<label class="col-md-12 text-left"><strong>Reason/s:</strong></label>' +
        
             '<select class="col-md-12" id="select-sec">' +
                 '<option value="3">Speaker Unavailable</option>' +
                 '<option value="2">Insufficient Participants</option>' +
                 '<option value="1">Class Suspension</option>' +
                 '<option value="4">Others</option>' +
             '</select>' +
            '<div class="form-group col-md-12" id="reason" style= "display:none">' +
                '<label class="col-md-12 text-left"  style="padding-left:0px" ><strong >Other Reason:</strong></label>' +
                '<input id="others" class="form-control" placeholder="" type="text">'+
            '</div>' +
            '<label class="col-md-12 text-left"><strong>Venue:</strong></label>' +
        
             '<select class="col-md-12" id="select-sec">' +
                 '<option value="3">venue1</option>' +
                 '<option value="2">venue1</option>' +
                 '<option value="1">venue1</option>' +
                 '<option value="4">venue1</option>' +
             '</select>' +
            '<div class="form-group col-md-12" id="reason" style= "display:none">' +
                '<label class="col-md-12 text-left"  style="padding-left:0px" ><strong >Other Reason:</strong></label>' +
                '<input id="others" class="form-control" placeholder="" type="text">'+
            '</div>' +
            '<div class="form-group col-md-12" >' +
            
            '</div>' +
            '<div class="form-group col-md-12 row">'+
                '<label class="col-md-12 text-left"  style="float:left" ><strong  style="float:left">Venue Reservation Ticket</strong></label>' +
                    '<div class="col-md-12">'+
                        '<div class="fileinput fileinput-new input-group" data-provides="fileinput">'+
                            '<div class="form-control" data-trigger="fileinput">'+
                                '<i class="glyphicon glyphicon-file fileinput-exists"></i>'+
                                '<span class="fileinput-filename"></span>'+
                            '</div>'+
                            '<span class="input-group-addon btn btn-default btn-file">'+
                                '<span class="fileinput-new">Select file</span>'+
                                '<span class="fileinput-exists">Change</span>'+
                                '<input type="hidden"><input required="" name="uploadfile[]" type="file">'+
                            '</span>'+
                            '<a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>'+
                        '</div>'+
                    '</div>'+
            '</div>'+
            
        '</div>';


    swal({
        title: "Reschedule Activity",
        html: question,
        focusConfirm: false,
        focusCancel: false,
        showLoaderOnConfirm: true,
        reverseButtons: true,
        allowOutsideClick: false,
        preConfirm: function(data) {
            console.log($("#datepicker-inline").val());
            console.log("DATA");
            return new Promise(function(resolve, reject) {
                setTimeout(function() {
                    if ($("#datepicker-inline").val().split(",").length != $("#doc").attr("limit")) {
                        reject('Date pick is not enough.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        },
        onOpen: function(ele) {
            $(ele).find("select").select2();
            $("#select-sec").change(function(event) {
                console.log("asd")
                if($("#select-sec").select2('val')=="4"){
                    $("#reason").css("display",'')
                }   
                
            });
            $('#datepicker-inline').datepicker({
                autoclose: true,
                todayHighlight: true,                
                startDate: new Date(),
                multidate:$("#doc").attr("limit")
                 
            });

            $('select').change(function(event) {
                value = $(this).val()
                if(value == "others"){
                    $('#reason').show()
                    console.log('yeys')
                }
            });
            console.log("INIT SELECT");

        },

        showCancelButton: true,
        confirmButtonColor: "#FEC107",
        confirmButtonText: "Confirm",
        cancelButtonText: "Cancel",

    }).then(function(data) {
        var modified = '';
        var arr = $("#doc").attr('ds').split(',');
        var arr2 = $('#datepicker-inline').val().split(',');
        arr2.sort(function(a,b){
          
          return new Date(a) - new Date(b);
        });
        var date2='';
        for(var ctr = 0; ctr < arr.length; ctr++){
            modified+=
            '<p>'+(new Date(arr[ctr])).toDateString()+' (old) to '+(new Date(arr2[ctr])).toDateString()+' (new)</p>';    
            date2+=arr2[ctr]
            if(ctr != arr.length -1){
                date2+=','
            }
        }
        var activityID = $("#doc").attr("ct")
        var reason = $("#select-sec").select2('val');
        var others = $("#others").val()
       swal({
            title: "Are you sure?",
            html:modified,
            showCancelButton: true,
            reverseButtons: true,
            confirmButtonColor: "#00C292",
            confirmButtonText: "Yes",
            cancelButtonText: "No",
            focusConfirm: false,
            focusCancel: false,    

        }).then(function(data2){
            $.ajax({
                type: 'POST',
                url: '/APS/ajax/approvalResched',
                data: {
                    activityID: activityID,
                    date: date2,
                    reason: reason  ,
                    others: others
                },
                success: function(data) {
                    if(data.status){
                        swal("Good job!", " ", "success").then(function(){
                            location.reload()
                        })

                    }else{
                        //    swal("Good job!", " ", "success").then(function(){
                        //     location.reload()
                        // })
                    }
                    
                }
            });
        })
        
    });
});
$(document).on('click', '#reject', function() {
    var question = '<div class="row">' +
        '<div class="col-md-12 text-left  m-b-20" style="padding-left:16px">' +
        '<br/>State the reason for rejection.<br/>' +
        '</div>' +

        '<div class="form-group col-md-12">' +

        '<div class="col-md-12">' +
        '<textarea id="reject-comment" class="form-control" rows="5"></textarea>' +
        '</div>' +
        '</div>' +
        '</div>';
    swal({
        title: "Reject",

        html: question,
        showLoaderOnConfirm: true,
        focusConfirm: false,
        focusCancel: false,
        reverseButtons: true,
        allowOutsideClick: false,
        showCancelButton: true,
        confirmButtonColor: "#FB9678",
        confirmButtonText: "Submit",
        cancelButtonText: "Cancel",
        preConfirm: function(email) {
            return new Promise(function(resolve, reject) {
                setTimeout(function() {
                    if (email === 'taken@example.com') {
                        reject('This email is already taken.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        }

    }).then(function(data) {
        console.log(data);
        console.log("REJECT");
        $("html, body").animate({
            scrollTop: 0
        }, function() {
            $('#doc').removeClass("rotateOutUpLeft animated").addClass("rotateOutUpLeft   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $(this).removeClass("rotateOutUpLeft animated");
            });
        });
    }).then(function() {
        $.ajax({
            type: 'POST',
            url: '/APS/ajax/SignProjectProposal',
            data: {
                activityID: $("#doc").attr("ct"),
                status: 3,
                comments: $("#reject-comment").val()
            },

            success: function(data) {
                var doc = $(data).find("#doc");
                $("#doc").replaceWith(doc);
                $(document).trigger("customGenerated");
            }
        });
    });


});
