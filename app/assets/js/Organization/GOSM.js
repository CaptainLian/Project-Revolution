(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });
})();

$("#yes").click();

var con = $(document.createElement('div')).addClass("dy-obj");
var cObj = 0;
function removeError(){
        $("#help-strat").text("");
        $("#strategy").closest("div.form-group").removeClass("has-error");
        $("#help-goals").text("");
        $("#help-desc").text("");
        $("#help-rto").text("");
        $("#help-pic").text("");
        $("#goals").closest("div.form-group").removeClass("has-error");
        $("#help-measure").text("");
        $("#measures").closest("div.form-group").removeClass("has-error");
        $("#objectives").closest("div.form-group").removeClass("has-error");
        $("select").closest("div.form-group").removeClass("has-error");
        
        $("textarea").closest("div.form-group").removeClass("has-error");
        $("#help-date").text("");
        $("#targetDateStart").closest("div.form-group").removeClass("has-error");
        $("#help-rto").text();
        $("input[name='isRelatedToOrganization']").closest("div.form-group").removeClass("has-error");
        $("#help-budget").text("");
        $("#budget").closest("div.form-group").removeClass("has-error");
}

$("#objectives-add").click(function() {
    cObj++;
    $(con).append('<div class="temp"> <label class="control-label col-md-3">&nbsp</label><div class="col-md-8" id="div-objectives"><input name="objectives[]" type="text" placeholder="" class="form-control"><span class="help-block">&nbsp</span></div><div class="col-md-1" style="margin-top: 8px" > <i class="fa fa-times text-danger remove" data-toggle="tooltip" title="Remove"></i> </div></div>');
    $("#div-after-objectives").after(con);

});
var table = $("#added-act").DataTable()
$("#comment-table").DataTable()
$("select").select2();

$("body").on('click', "i.remove", function() {
    console.log($(this).parent());
    $(this).closest("div.temp").empty().remove();
});

$('#date-range').datepicker({
    toggleActive: true,
    startDate: new Date()
});


function clear() {
    $("#strategy").val('');
    $("#goals").val('');
    $(".temp").children().remove();
    $("textarea").val('');
    $("#measures").val('');
    $("#targetDateStart").val('');
    $("#targetDateEnd").val('');
    $("#objectives").val('');
    // $('input[name="isRelatedToOrganization"]').prop('checked', false);    
    $("#personInCharge").val('').trigger('change');
    $("#budget").val('');
}


$("#edit").on('click', function() {
    tPencil.trigger('click');
    $("#myModal").modal('hide');
    $("html, body").animate({
        scrollTop: 0
    }, function() {

        $("#home-tab").click();
        $("#add-gosm").css("display", "none");
        $("#edit-gosm").css("display", "");
        $("#cancel-gosm").css("display", "");
    });

});


$("#edit-gosm").click(function() {
    removeError();
    $("#add-gosm").css("display", "");
    $("#edit-gosm").css("display", "none");
    $("#cancel-gosm").css("display", "none");

    var strategy = $("#strategy").val();
    var goals = $("#goals").val();
    var objectives = $("input[name='objectives[]']")
        .map(function() {
            return $(this).val();
        }).get();
    var description = $("textarea").val();
    var measures = $("#measures").val();
    var targetDateStart = $("#targetDateStart").val();
    var targetDateEnd = $("#targetDateEnd").val();
    var activityType = $("#activity-type").val();
    var othersDescription = $("#othersDescription").val();
    var natureType = $("#nature-type").val();
    var personInCharge = $("select[name='personInCharge[]']")
        .map(function() {
            return $(this).val();
        }).get();
    var isRelatedToOrganization = $("input[name='isRelatedToOrganization']:checked").val();
    var budget = $("#budget").val();


    var err =0;

      if ($.trim(strategy) < 1) {
        $("#help-strat").text("Strategy cannot be empty!");
        $("#strategy").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
    if ($.trim(goals) < 1) {
        $("#help-goals").text("Goals cannot be empty!");
        $("#goals").closest("div.form-group").addClass("has-error");
        err = 1;

    }
   
    if ($.trim(measures) < 1) {
        $("#help-measure").text("Measures cannot be empty!");
        $("#measures").closest("div.form-group").addClass("has-error");
        err = 1;

    }

    if (objectives.length == 1 && objectives[0] == "") {
        // $("#help-obj").text("Objectives cannot be empty!");
        $("#objectives").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    if ($.trim(description) < 1) {
        $("#help-desc").text("Description cannot be empty!");
        $("textarea").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
    if ($.trim(targetDateStart) < 1) {
        $("#help-date").text("Date cannot be empty!");
        $("#targetDateStart").closest("div.form-group").addClass("has-error");
        err = 1;

    }
     if ($.trim(personInCharge) < 1) {
        $("#help-pic").text("Person in charge cannot be empty!");
        $("#personInCharge").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
     if ($.trim(isRelatedToOrganization) == '') {
        $("#help-rto").text("Field cannot be empty!");
        $("input[name='isRelatedToOrganization']").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
    if ($.trim(budget) < 1) {
    //     $("#help-budget").text("Budget cannot be empty!");
    //     $("#budget").closest("div.form-group").addClass("has-error");
    //     err = 1;
        $("#budget").val(0)

    }
    if(err){
          $("html, body").animate({
                    scrollTop: 0
                }, "fast");

    }else{
        removeError()
    $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/updateActivity',
        data: {
            "id": currentID,
            "strategy": strategy,
            "goals": goals,
            "objectives": objectives,
            "description": description,
            "measures": measures,
            "targetDateStart": targetDateStart,
            "targetDateEnd": targetDateEnd,
            "activity-type": activityType,
            "othersDescription": othersDescription,
            "nature-type": natureType,
            "personInCharge": personInCharge,
            "isRelatedToOrganization": isRelatedToOrganization,
            "budget": budget

        },
        success: function(data) {
            
            if (data.id > 0) {
                console.log("CLEAR")
                $("html, body").animate({
                    scrollTop: 0
                }, function() {
                    $(".myadmin-alert").hide();
                    clear();
                    $("#add-gosm").css("display", "");
                    $("#edit-gosm").css("display", "none");
                    $("#cancel-gosm").css("display", "none");
                });
                table.row(currentNode).remove().draw();
                var tr = 
                    '<a  data-toggle="tooltip" data-original-title="Details"> ' +
                    '<i db-id="' + currentID + '"  class="fa fa-eye text-inverse m-r-10"></i> ' +
                    '</a>' +
                    '<a data-toggle="tooltip" data-original-title="Edit"> <i db-id="' + currentID + '" class="fa fa-pencil text-inverse m-r-10"></i> </a>' +
                    '<a  data-toggle="tooltip" data-original-title="Close"> <i db-id="' + currentID + '" class="fa fa-close text-danger"></i> </a>';
                table.row.add([
                    targetDateStart + ' - ' + targetDateEnd ,
                    strategy,
                    description,
                    tr
                    ]).draw();

                $.ajax({
                    url:'/Organization/AJAX/checkRatio',
                    type:'POST',                
                    success:function(data){
                        var rel = parseInt(data.related)
                        var nrel = parseInt(data.notrelated)
                        var rratio = ((rel) / (rel + nrel))*100
                        var nratio = (nrel / (rel + nrel))*100
                        rratio = Math.round(rratio)
                        nratio = Math.round(nratio)
                        if(isNaN(Math.round(rratio))){
                            rratio = 0
                            nratio = 0
                        }
                        $("#rel").text(Math.round(rratio))
                        $("#notrel").text(Math.round(nratio))
                        $("#rele").text(data.related)
                        $("#nrele").text(data.notrelated)
                    }
                })
                $.toast({
                    heading: 'Success!',    
                    text:   'Edit is successful.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'success',
                    bgColor:'#00C292',
                    hideAfter: 3500, 
                    stack: 6
                  });
            } else {
                 $.toast({
                    heading: 'Failed!',    
                    
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'error',
                    bgColor:'#FB9678',
                    hideAfter: 3500, 
                    stack: 6
                  });
                 $("html, body").animate({
                    scrollTop: 0
                }, function() {
                    $(".myadmin-alert").hide();
                    clear();
                    $("#add-gosm").css("display", "");
                    $("#edit-gosm").css("display", "none");
                    $("#cancel-gosm").css("display", "none");
                });
            }

        }
    });
    }
});

$("#cancel-gosm").click(function() {
    removeError();
    $("#add-gosm").css("display", "");
    $("#edit-gosm").css("display", "none");
    $("#cancel-gosm").css("display", "none");

    clear();
    $("html, body").animate({
        scrollTop: 0
    }, function() {});
});


$(document).on('click', "i.fa-pencil", function() {
    currentNode = $(this).parents("tr");
    currentID = $(this).attr("db-id")
    var trRow = $(this).attr("db-id");
    $("html, body").animate({
        scrollTop: 0
    }, function() {
        $.ajax({
            type: 'POST',
            url: '/Organization/AJAX/getActivityDetails',
            data: {
                "dbid": trRow,
            },
            success: function(data) {
                console.log(data[1]);
                var pic = data[1];
                var id = [];
                for (var x = 0; x < pic.length; x++) {
                    id.push(pic[x].idnumber);
                }
                $(".temp").remove();
                fillObj(data[0].objectives);

                $("#personInCharge").select2('val', id);
                $("#strategy").val(data[0].strategies);
                $("#goals").val(data[0].goals);
                var objectives = $("input[name='objectives[]']")
                    .map(function() {
                        return $(this).val();
                    }).get();
                $("textarea").val(data[0].description);
                $("#measures").val(data[0].measures);

                // $("input[name='isRelatedToOrganization']").val(data[0].isrelatedorganizationnature);
                // var targetDateStart = $("#targetDateStart").val();
                // var targetDateEnd = $("#targetDateEnd").val();
                // var activityType = $("#activity-type").val();
                // var othersDescription = $("#othersDescription").val();
                // var natureType =  $("#nature-type").val();
                // var personInCharge = $("select[name='personInCharge[]']")
                //       .map(function(){return $(this).val();}).get();
                // $("#isRelatedToOrganization").val(data[0].isrelatedorganizationnature);
                $("#budget").val(data[0].budget);
                console.log("RTO")
                console.log(data[0].isrelatedtoorganizationnature);

                $("input[name='isRelatedToOrganization'][value='" + data[0].isrelatedtoorganizationnature + "']").prop('checked', 'checked');
                data = data[0];
                data.targetdatestart = data.targetdatestart.substring(0, 10);
                console.log(data.targetdatestart);
                var sdate = data.targetdatestart.split('-');
                var startday = sdate[1] + '/' + (parseInt(sdate[2])+1) + '/' + sdate[0];
                data.targetdateend = data.targetdateend.substring(0, 10);
                var edate = data.targetdateend.split('-');
                var endday = edate[1] + '/' + (parseInt(edate[2])+1) + '/' + edate[0];

                var targetDateStart = $("#targetDateStart").val(startday).trigger('change');
                var targetDateEnd = $("#targetDateEnd").val(endday).trigger('change');

                $("#add-gosm").css("display", "none");
                $("#edit-gosm").css("display", "");
                $("#cancel-gosm").css("display", "");
            }
        });
        $("#home-tab").click();
    });
});

function clearModal() {
    $("#modal-strat").text('');
    $("#modal-goals").text('');
    $("#modal-desc").text('');
    $("#modal-measures").text('');
    $("#modal-budget").text('');
    $("#modal-starttime").text('');
    $("#modal-endtime").text('');
    $("#modal-pic").html('');
    $("#modal-is").html('');
    $("#modal-nature").html('');
    $("#modal-type").html('');
}

function dType(val) {
    if (val == 0) {
        return "Competition";
    } else if (val == 1) {
        return "Distribution";
    } else if (val == 2) {
        return "General Assembly";
    } else if (val == 3) {
        return "Seminar/Workshops";
    } else if (val == 4) {
        return "Publicity/Awareness";
    } else if (val == 5) {
        return "Meetings";
    } else if (val == 6) {
        return "Spiritual Activity";
    } else if (val == 7) {
        return "Recruitment Audition";
    } else if (val == 8) {
        return "Recreation";
    } else if (val == 9) {
        return "Others";
    }
}

function dNat(val) {
    if (val == 1) {
        return "Academic";
    } else if (val == 2) {
        return "Special Interest";
    } else if (val == 3) {
        return "Department Initiative";
    } else if (val == 4) {
        return "Fundraising";
    } else if (val == 5) {
        return "Community Development";
    } else if (val == 6) {
        return "Organizational Development";
    } else if (val == 7) {
        return "issue Advocacy";
    } else if (val == 8) {
        return "Lasallian Formation/Spiritual Growth";
    } else if (val == 9) {
        return "Outreach";
    }
}
var currentID = 0;
var tPencil;
var currentNode = 0 ;

$(document).on('click', 'i.fa-eye', function() {
    $("#myModal").modal('show');
    tPencil = $(this).closest("i.fa-pencil");
    clearModal();
    currentID = $(this).attr("db-id");
    console.log("DB-ID = " + $(this).attr("db-id"));
    $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/getActivityDetails',

        data: {
            "dbid": $(this).attr("db-id"),

        },
        success: function(data) {
            console.log(data);
            var pic = data[1];

            data = data[0];
            $("#modal-strat").text(data.strategies);
            var objectives = data.objectives;
            $("#modal-goals").text(data.goals);
            $("#modal-desc").text(data.description);
            $("#modal-measures").text(data.measures);
            $("#modal-budget").text(data.budget);
            $("#modal-type").text(dType(data.activitytype));
            $("#modal-nature").text(dNat(data.activitynature));
            data.targetdatestart = data.targetdatestart.substring(0, 10);
            var sdate = data.targetdatestart.split('-');
            var startday = sdate[1] + '/' + (parseInt(sdate[2])+1) + '/' + sdate[0];
            data.targetdateend = data.targetdateend.substring(0, 10);
            var edate = data.targetdateend.split('-');
            var endday = edate[1] + '/' + (parseInt(edate[2])+1) + '/' + edate[0];
            $("#modal-starttime").text(startday).trigger('change');
            $("#modal-endtime").text(endday).trigger('change');
            var toBeInserted = '';
            for (let x = 0; x < pic.length; x++) {
                var i = '<p>' + pic[x].firstname + ' ' + pic[x].lastname + '</p>';
                toBeInserted = toBeInserted + i;
            }
            $("#modal-pic").html(toBeInserted);

            var toBeInserted2 = '';
            for (let x = 0; x < objectives.length; x++) {
                let i = '<p>' + objectives[x] + '</p>';
                toBeInserted2 = toBeInserted2 + i;
            }
            $("#modal-obj").html(toBeInserted2);
            if (data.isrelatedtoorganizationnature) {
                $("#modal-is").text("Yes");
            } else {
                $("#modal-is").text("No");
            }
        }
    });
});

$(document).on('click', 'i.fa-close', function() {
    // TO DELETE
    var trR = $(this).closest("tr");
    console.log("DB-ID" + $(this).attr("db-id"));
    $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/deleteActivity',
        data: {
            "dbid": $(this).attr("db-id")
        },
        success: function(data) {
            console.log(data);
            if (data == "1") {

                trR.remove();
                $.toast({
                    heading: 'Success!',    
                    text:   'Deletion is successful.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'success',
                    bgColor:'#00C292',
                    hideAfter: 3500, 
                    stack: 6
                  });
                 $.ajax({
                    url:'/Organization/AJAX/checkRatio',
                    type:'POST',                
                    success:function(data){
                        var rel = parseInt(data.related)
                        var nrel = parseInt(data.notrelated)
                        var rratio = ((rel) / (rel + nrel))*100
                        var nratio = (nrel / (rel + nrel))*100
                        rratio = Math.round(rratio)
                        nratio = Math.round(nratio)
                        if(isNaN(Math.round(rratio))){
                            rratio = 0
                            nratio = 0
                        }
                        $("#rel").text(Math.round(rratio))
                        $("#notrel").text(Math.round(nratio))
                        $("#rele").text(data.related)
                        $("#nrele").text(data.notrelated)
                    }
                })

            } else {
                 $.toast({
                    heading: 'Failed!',    
                    
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'error',
                    bgColor:'#FB9678',
                    hideAfter: 3500, 
                    stack: 6
                  });

            }
        }
    });
});

$("#add-gosm").click(function(e) {
    // $("#alerttopright").fadeToggle(350);
    e.preventDefault();
   removeError();
    var strategy = $("#strategy").val();
    var goals = $("#goals").val();
    var objectives = $("input[name='objectives[]']")
        .map(function() {
            return $(this).val();
        }).get();
    var description = $("textarea").val();
    var measures = $("#measures").val();
    var targetDateStart = $("#targetDateStart").val();
    var targetDateEnd = $("#targetDateEnd").val();
    var activityType = $("#activity-type").val();
    var othersDescription = $("#othersDescription").val();
    var natureType = $("#nature-type").val();
    var personInCharge = $("select[name='personInCharge[]']")
        .map(function() {
            return $(this).val();
        }).get();
    var isRelatedToOrganization = $("input[name='isRelatedToOrganization']:checked").val();
    var budget = $("#budget").val();
    var err = 0;
    if ($.trim(strategy) < 1) {
        $("#help-strat").text("Strategy cannot be empty!");
        $("#strategy").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
    if ($.trim(goals) < 1) {
        $("#help-goals").text("Goals cannot be empty!");
        $("#goals").closest("div.form-group").addClass("has-error");
        err = 1;

    }
   
    if ($.trim(measures) < 1) {
        $("#help-measure").text("Measures cannot be empty!");
        $("#measures").closest("div.form-group").addClass("has-error");
        err = 1;

    }

    if (objectives.length == 1 && objectives[0] == "") {
        // $("#help-obj").text("Objectives cannot be empty!");
        $("#objectives").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    if ($.trim(description) < 1) {
        $("#help-desc").text("Description cannot be empty!");
        $("textarea").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
    if ($.trim(targetDateStart) < 1) {
        $("#help-date").text("Date cannot be empty!");
        $("#targetDateStart").closest("div.form-group").addClass("has-error");
        err = 1;

    }
     if ($.trim(personInCharge) < 1) {
        $("#help-pic").text("Person in charge cannot be empty!");
        $("#personInCharge").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
     if ($.trim(isRelatedToOrganization) == '') {
        $("#help-rto").text("Field cannot be empty!");
        $("input[name='isRelatedToOrganization']").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    
      if ($.trim(budget) < 1) {
    //     $("#help-budget").text("Budget cannot be empty!");
    //     $("#budget").closest("div.form-group").addClass("has-error");
    //     err = 1;
    $("#budget").val(0)

    }

    if(err){
         $("html, body").animate({
                    scrollTop: 0
                }, "fast");

    }else{
        removeError();
        
         $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/createGOSM',
        data: {
            "strategy": strategy,
            "goals": goals,
            "objectives": objectives,
            "description": description,
            "measures": measures,
            "targetDateStart": targetDateStart,
            "targetDateEnd": targetDateEnd,
            "activity-type": activityType,
            "othersDescription": othersDescription,
            "nature-type": natureType,
            "personInCharge": personInCharge,
            "isRelatedToOrganization": isRelatedToOrganization,
            "budget": budget,
            "notingosm":true
        },

        success: function(data) {


            console.log("ADDED");
            console.log(parseInt(data));
            if (data > 0) {
                console.log("console" + data);
                var ctr = 1;
                $("#added-act tbody tr").each(function() {
                    ctr++;
                });

                var tr = 
                    '<a  data-toggle="tooltip" data-original-title="Details"> ' +
                    '<i db-id="' + data + '"  class="fa fa-eye text-inverse m-r-10"></i> ' +
                    '</a>' +
                    '<a data-toggle="tooltip" data-original-title="Edit"> <i db-id="' + data + '" class="fa fa-pencil text-inverse m-r-10"></i> </a>' +
                    '<a  data-toggle="tooltip" data-original-title="Close"> <i db-id="' + data + '" class="fa fa-close text-danger"></i> </a>';
                table.row.add([
                    targetDateStart + ' - ' + targetDateEnd ,
                    strategy,
                    description,
                    tr
                    ]).draw()

                $.ajax({
                    url:'/Organization/AJAX/checkRatio',
                    type:'POST',                
                    success:function(data){
                        var rel = parseInt(data.related)
                        var nrel = parseInt(data.notrelated)
                        var rratio = ((rel) / (rel + nrel))*100
                        var nratio = (nrel / (rel + nrel))*100
                        rratio = Math.round(rratio)
                        nratio = Math.round(nratio)
                        if(isNaN(Math.round(rratio))){
                            rratio = 0
                            nratio = 0
                        }
                        $("#rel").text(Math.round(rratio))
                        $("#notrel").text(Math.round(nratio))
                        $("#rele").text(data.related)
                        $("#nrele").text(data.notrelated)
                    }
                })

                // $("#added-act tbody").append(tr);
                // Change Name
                $("#strategy-name").html(strategy);
                //Hide Current Toast
                clear();
                
                $("html, body").animate({
                    scrollTop: 0
                }, "slow");
                $.toast({
                    heading: 'Success!',    
                    text:   'Activity is added in GOSM.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'success',
                    bgColor:'#00C292',
                    hideAfter: 3500, 
                    stack: 6
                  });

            } else {
                console.log("consol2");
                //Hide Current Toast
               $.toast({
                    heading: 'Failed!',    
                    text:   'Activity is not added in the GOSM.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'error',
                    bgColor:'#FB9678',
                    hideAfter: 3500, 
                    stack: 6
                  });

                // $("#alerttopright-fail").fadeToggle(350);
                $("html, body").animate({
                    scrollTop: 0
                }, "slow");
            }
        }
    });
    }

});
function fillObj(data) {
    console.log("OBJ");
    var con = $(document.createElement('div')).addClass("dy-obj");
    var cObj = 0;
    $("#objectives").val(data[0]);
    data.shift();
    for (var x = 0; x < data.length; x++) {
        console.log("OBJ LOOP");
        $(con).append('<div class="temp"> <label class="control-label col-md-3">&nbsp</label><div class="col-md-8" id="div-objectives"><input name="objectives[]" value="' + data[x] + '" type="text" placeholder="" class="form-control"><span class="help-block">&nbsp</span></div><div class="col-md-1" style="margin-top: 8px" > <i class="fa fa-times text-danger remove" data-toggle="tooltip" title="Remove"></i> </div></div>');
        $("#div-after-objectives").after(con);
    }



}

$("#submit-gosm").click(function() {
    console.log("PUMASOK");
    $('.sttabs').block({
            message: '<h3>Please Wait...</h3>',
            css: {
                border: '1px solid #fff'
            }
        });
    $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/submitGOSM',
        data: {
            'org': 1
        },
        success: function(data) {
            $('.sttabs').block({
                        message: '<h3>Success</h3>',
                        css: {
                            'text-color': 'white',
                            backgroundColor: '#00C292'
                        }
                    });
             setTimeout(function(){
                 window.location.href = '/Organization/ProjectHead/Home';
                  
             }
            , 3000);
            

        }
    });
});