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
        reverseButtons: false,
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
        reverseButtons: false,
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

        '<form method="POST" action="/APS/ajax/approvalResched" encType="multipart/form-data">' +
        
        '<input value="'+$("#doc").attr("ct")+'" name="activityID" class="form-control mydatepicker" placeholder="" type="hidden">'+
        '<div class="form-group col-md-12 >' +
            '<label class="col-md-12 text-left"  style="float:left" ><strong  style="float:left">New Schedule/s:</strong></label>' +
            '<input id="datepicker-inline" name="date" class="form-control mydatepicker" placeholder="" type="text">'+
            '<small> Number of dates should match the program design('+limit +')  </small>'+
        '</div>' +
        
        '<div class="form-group col-md-12">' +
            '<label class="col-md-12 text-left"><strong>Reason/s:</strong></label>' +
        
             '<select name="reason" class="col-md-12" id="select-sec">' +
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
        
             '<select class="col-md-12" name="venue" id="select-sec">' +
                 
 
 '<option value="0">A 1502-A Conference Room</option>' +
 '<option value="1">A 1502-B Conference Room</option>' +
 '<option value="2">A 1505-A Conference Room</option>' +
 '<option value="3">A 1505-B Conference Room</option>' +
 '<option value="4">A 1506 Conference Room</option>' +
 '<option value="5">A 1602 Conference Room</option>' +
 '<option value="6">A 703 Lecture Room</option>' +
 '<option value="7">A 903 Lecture Room</option>' +
 '<option value="8">A 1103 Lecture Room</option>' +
 '<option value="9">A 1403 Lecture Room</option>' +
 '<option value="10">A 1703 Lecture Room</option>' +
 '<option value="11">A1402 Micro Teaching Laboratory</option>' +
 '<option value="12">A1805 Micro Teaching Laboratory</option>' +
 '<option value="13">20th Floor Board Room</option>' +
 '<option value="14">20th Floor Conference Room</option>' +
 '<option value="15">20th Floor Multipurpose Room</option>' +
 '<option value="16">Classroom (Full-size)</option>' +
 '<option value="17">Classroom (Half-size</option>' +
 '<option value="18">Natividad Fajardo-Rosario Gonzalez Auditorium, 18th Flr.</option>' +
 '<option value="19">Br. Gabriel Connon Conference Room SPS 201</option>' +
 '<option value="20">Rehersal Room, SPS 507</option>' +
 '<option value="21">Tennis Court, Roof deck</option>' +
 '<option value="22">Waldo Perfecto Seminar Room, SPS 102</option>' +
 '<option value="23">Classroom</option>' +
 '<option value="24">Teresa Yuchengco Auditorium, 7th-9th flr.</option>' +
 '<option value="25">Y 407 Seminar Room</option>' +
 '<option value="26">Y 408 Seminar Room</option>' +
 '<option value="27">Y 409 Seminar Room</option>' +
 '<option value="28">Y 507 Seminar Room</option>' +
 '<option value="29">Y 508 Seminar Room</option>' +
 '<option value="30">Y 509 Seminar Room</option>' +
 '<option value="31">7th Floor Gym(w/ Scoreboard)</option>' +
 '<option value="32">7th Floor Gym(w/o Scoreboard)</option>' +
 '<option value="33">9th Floor Gym(w/ Scoreboard)</option>' +
 '<option value="34">9th Floor Gym(w/o Scoreboard)</option>' +
 '<option value="35">Classroom</option>' +
 '<option value="36">E201 Multipurpose Room</option>' +
 '<option value="37">E202 Multipurpose Room</option>' +
 '<option value="38">E 802 Practice Room</option>' +
 '<option value="39">E 803 Practice Room</option>' +
 '<option value="40">E 804 Dance Room</option>' +
 '<option value="41">E 1001 Practice Room</option>' +
 '<option value="42">E 1002 Practice Room</option>' +
 '<option value="43">E 1003 Practice Room</option>' +
 '<option value="44">E 1004 Practice Room</option>' +
 '<option value="45">E 1005 Practice Room</option>' +
 '<option value="46">Swimming Pool, 1st flr.</option>' +
 '<option value="47">Classroom</option>' +
 '<option value="48">Shell Companies in Philippines Audio Visual Room, V210</option>' +
 '<option value="49">Classroom</option>' +
 '<option value="50">Intellect Seminar Room</option>' +
 '<option value="51">Ariston Estrada Seminar Room, L 216</option>' +
 '<option value="52">Br. Richard Duerr Board Room, L 113</option>' +
 '<option value="53">Br. Richard Duerr Board Room Receiving Area, L 115</option>' +
 '<option value="54">Classroom</option>' +
 '<option value="55">Conference Room A, L128A</option>' +
 '<option value="56">Conference Room A, L128</option>' +
 '<option value="57">Conference Room A, L127A</option>' +
 '<option value="58">Conference Room A, L127</option>' +
 '<option value="59">L 112 Conference Room</option>' +
 '<option value="60">L 218 Case Room</option>' +
 '<option value="61">L 219 Case Room</option>' +
 '<option value="62">Marelian Gaerlan Conservatory North Wing (w/ Sound System), 1st flr.</option>' +
 '<option value="63">Marelian Gaerlan Conservatory North Wing (w/o Sound System) 1st flr.</option>' +
 '<option value="64">Marelian Gaerlan Conservatory South Wing, 1st flr.</option>' +
 '<option value="65">Medrano Hall, L213</option>' +
 '<option value="66">Most Blessed Sacrament (Main) Chapel (w/ airconditioning), 2nd flr.</option>' +
 '<option value="67">Most Blessed Sacrament (Main) Chapel (w/o airconditioning), 2nd flr.</option>' +
 '<option value="68">Pablo Nicholas Seminar Room, L 315</option>' +
 '<option value="69">Tereso Lara Seminar Room, L 230</option>' +
 '<option value="70">Classroom</option>' +
 '<option value="71">Laboratory (Room Only)</option>' +
 '<option value="72">Pearl of Great Price Chapel, 1st flr.</option>' +
 '<option value="73">Rosario Jose Science Lecture Room, J 504</option>' +
 '<option value="74">Classroom</option>' +
 '<option value="75">E Classroom, M 306</option>' +
 '<option value="76">Classroom</option>' +
 '<option value="77">STRC 412 Seminar Room</option>' +
 '<option value="78">Ortigas Seminar Room, 1st flr.</option>' +
 '<option value="79">William Shaw Little Theatre, 1st flr.</option>' +
 '<option value="80">Agno House</option>' +
 '<option value="81">Amphitheater (w/ Sound System)</option>' +
 '<option value="82">Amphitheater (w/o Sound System)</option>' +
 '<option value="83">Chess Plaza</option>' +
 '<option value="84">Football Field</option>' +
 '<option value="85">Marian Quadrangle (w/ Sound System)</option>' +
 '<option value="86">Marian Quadrangle (w/o Sound System)</option>' +
 '<option value="87">Retreat House Room 101</option>' +
 '<option value="88">Retreat House Room 201</option>' +
 '<option value="89">Sound System</option>' +
 '<option value="90">Sports Plaza (Per Court)</option>' +
 '<option value="91">HSH101 (The Meadow-Main Lobby)</option>' +
 '<option value="92">2nd Floor - Enrollment Central Lobby</option>' +
 '<option value="93">3rd Floor - Conference Room</option>' +
 '<option value="94">4th Floor - Function Room Lobby</option>' +
 '<option value="95">4th Floor (HSH401) - Multi-Purpose Room</option>' +
 '<option value="96">4th Floor (HSH402) - Meeting Room A</option>' +
 '<option value="97">4th Floor (HSH406) - Meeting Room B</option>' +
 '<option value="98">5th Floor - Function Room Lobby</option>' +
 '<option value="99">5th Floor (HSH501) - Multi-Purpose Room</option>' +
 '<option value="100">5th Floor - Bean Bag Area</option>' +
 '<option value="101">6th Floor - Display Area</option>' +
 '<option value="102">7th Floor (HSH701) - Meeting Room</option>' +
 '<option value="103">8th Floor (HSH801) - Meeting Room</option>' +
 '<option value="104">13th Floor - Audio Visual Room</option>' +
 '<option value="105">13th Floor - EDC Multi-Purpose Room</option>' +
 '<option value="106">14th Floor - Conference Room 1</option>' +
 '<option value="107">14th Floor - Conference Room 2</option>' +
 '<option value="108">14th Floor - Board Room</option>' +
 '<option value="109">Roof Deck - Dining Area</option>' +
 '<option value="110">Roof Deck - Garden</option>' +


             '</select>' +
            '<div class="form-group col-md-12" id="reason" style= "display:none">' +
                '<label class="col-md-12 text-left"  style="padding-left:0px" ><strong >Other Reason:</strong></label>' +
                '<input id="others" class="form-control" name="others" placeholder="" type="text">'+
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
                                '<input type="hidden"><input required="" id="file" name="file" type="file">'+
                            '</span>'+
                            '<a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>'+
                        '</div>'+
                    '</div>'+
            '</div>'+
            
        '</div>'+
        '</form>' ;


    swal({
        title: "Reschedule Activity",
        html: question,
        focusConfirm: false,
        focusCancel: false,
        showLoaderOnConfirm: true,
        reverseButtons: false,
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
                endDate: new Date (new Date($("#termend").val()) - (60*60*24*21*1000)  ),
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
        var file = $("#others").val();

        var formData = new FormData($("form")[0]);
        
        formData.append('_csrf',$('meta[data-name="csrf"]').attr("data-token"));
    
    
       swal({
            title: "Are you sure?",
            html:modified,
            showCancelButton: true,
            reverseButtons: false,
            confirmButtonColor: "#00C292",
            confirmButtonText: "Yes",
            cancelButtonText: "No",
            focusConfirm: false,
            focusCancel: false,    

        }).then(function(data2){
            
            $.ajax({
                type: 'POST',
                url: '/APS/ajax/approvalResched',
                data:formData,
                processData: false,
                    contentType: false,
                    cache: false,
                    enctype: 'multipart/form-data',
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
        reverseButtons: false,
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
