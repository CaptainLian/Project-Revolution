(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });
})();

var con = $(document.createElement('div')).addClass("dy-obj");
var cObj = 0;
$("#objectives-add").click(function() {
    cObj++;
    $(con).append('<div class="temp"> <label class="control-label col-md-3">&nbsp</label><div class="col-md-8" id="div-objectives"><input name="objectives[]" type="text" placeholder="" class="form-control"><span class="help-block">&nbsp</span></div><div class="col-md-1" style="margin-top: 8px" > <i class="fa fa-times text-danger remove" data-toggle="tooltip" title="Remove"></i> </div></div>');
    $("#div-after-objectives").after(con);

});
$("#nature-type").select2();
$("#activity-type").select2();
$("#personInCharge").select2();
$("body").on('click', "i.remove", function() {
    console.log($(this).parent());
    $(this).closest("div.temp").empty().remove();
});
$(function() {
    $('.panel').lobiPanel({
        sortable: false,
        reload: false,
        editTitle: false,
        unpin: false,
        minimize: false,
        expand: {
            icon: 'fa fa-expand',
            icon2: 'fa fa-expand',
            tooltip: 'Fullscreen'
        },
        close: false
    });
});
$('#date-range').datepicker({
    toggleActive: true
});

$("#activity-type").change(function() {
    if ($(this).val() == "10") {
        $("#activity-others").val("");

        $("#div-space").css("display", "");
        $("#act-others-label").css("display", "");
        $("#div-others").css("display", "");
        $("#activity-others").css("display", "");

    } else {
        $("#activity-others").val("");


        $("#div-space").css("display", "none");
        $("#act-others-label").css("display", "none");
        $("#div-others").css("display", "none");
        $("#activity-others").css("display", "none");
    }
});

$(document).ready(function() {
    if ($("#activity-type").val() == "10") {
        $("#activity-others").val("");
        $("#div-space").css("display", "");
        $("#act-others-label").css("display", "");
        $("#div-others").css("display", "");
        $("#activity-others").css("display", "");
    }
});
$('#exampleBasic').wizard({
    onFinish: function() {
        alert('finish');
    }
});

// $("table tbody tr").on('click',function(){
//     console.log("EDIT");
//     $(this).find("i.fa-eye").click();
// });
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


//CLEAR INPUT
function clear() {
    $("#strategy").val('');
    $("#goals").val('');
    $(".temp").children().remove();
    $("textarea").val('');
    $("#measures").val('');
    $("#targetDateStart").val('');
    $("#targetDateEnd").val('');
    $("#objectives").val('');
    $('input[name="isRelatedToOrganization"]').prop('checked', false);
    // var activityType = $("#activity-type").val();
    // var othersDescription = $("#othersDescription").val();
    // var natureType =  $("#nature-type").val();
    $("#personInCharge").val('').trigger('change');
    /*$("#isRelatedToOrganization").val(data[0].isrelatedorganizationnature);*/
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
            if (data > 0) {

                $("html, body").animate({
                    scrollTop: 0
                }, function() {
                    $(".myadmin-alert").hide();
                    clear();
                    $("#add-gosm").css("display", "");
                    $("#edit-gosm").css("display", "none");
                    $("#cancel-gosm").css("display", "none");
                });
            } else {

            }

        }
    });
});
$("#cancel-gosm").click(function() {

    $("#add-gosm").css("display", "");
    $("#edit-gosm").css("display", "none");
    $("#cancel-gosm").css("display", "none");

    clear();
    $("html, body").animate({
        scrollTop: 0
    }, function() {});


});


$(document).on('click', "i.fa-pencil", function() {
    currentID = $(this).attr('db-id');
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
                console.log(data[0].isrelatedtoorganizationnature);
                $("input[name='isRelatedToOrganization'][value='" + data[0].isrelatedtoorganizationnature + "']").attr('checked', 'checked');
                data = data[0];
                data.targetdatestart = data.targetdatestart.substring(0, 10);
                console.log(data.targetdatestart);
                var sdate = data.targetdatestart.split('-');
                var startday = sdate[1] + '/' + sdate[2] + '/' + sdate[0];
                data.targetdateend = data.targetdateend.substring(0, 10);
                var edate = data.targetdateend.split('-');
                var endday = edate[1] + '/' + edate[2] + '/' + edate[0];

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
    if (val == 1) {
        return "Academic Contest";
    } else if (val == 2) {
        return "Distribution";
    } else if (val == 3) {
        return "General Assembly";
    } else if (val == 4) {
        return "Seminar/Workshops";
    } else if (val == 5) {
        return "Publicity/Awareness";
    } else if (val == 6) {
        return "Meetings";
    } else if (val == 7) {
        return "Spiritual Activity";
    } else if (val == 8) {
        return "Recruitment Audition";
    } else if (val == 9) {
        return "Recreation";
    } else if (val == 10) {
        return "Others";
    }
}

function dNat(val) {
    if (val == 1) {
        return "Academic";
    } else if (val == 2) {
        return "special Interest";
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
            var startday = sdate[1] + '/' + sdate[2] + '/' + sdate[0];
            data.targetdateend = data.targetdateend.substring(0, 10);
            var edate = data.targetdateend.split('-');
            var endday = edate[1] + '/' + edate[2] + '/' + edate[0];
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
                $(".myadmin-alert").hide();
                $("#alerttopright-success-delete").fadeToggle(350);

            } else {

            }
        }
    });
});

$(".myadmin-alert .closed").click(function(event) {
    $(this).parents(".myadmin-alert").fadeToggle(350);
    return false;
});

$("#add-gosm").click(function(e) {
    // $("#alerttopright").fadeToggle(350);
    e.preventDefault();
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
            "budget": budget
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

                var tr = '<tr>' +
                    '<td width="5%" class="text-left">' + data + '</td>' +
                    '<td width="15%" class="td-title text-left" >' + strategy + '</td>' +
                    '<td width="15%" class="td-title text-left" >' + targetDateStart + ' - ' + targetDateEnd + '</td>' +
                    '<td width="35%" class="td-title text-left" >' + description + '</td>' +
                    '<td width="10%" class="text-nowrap text-center">' +
                    '<a  data-toggle="tooltip" data-original-title="Details"> ' +
                    '<i db-id="' + data + '"  class="fa fa-eye text-inverse m-r-10"></i> ' +
                    '</a>' +
                    '<a data-toggle="tooltip" data-original-title="Edit"> <i db-id="' + data + '" class="fa fa-pencil text-inverse m-r-10"></i> </a>' +
                    '<a  data-toggle="tooltip" data-original-title="Close"> <i db-id="' + data + '" class="fa fa-close text-danger"></i> </a>' +
                    '</td>' +
                    '</tr>';
                $("#added-act tbody").append(tr);
                // Change Name
                $("#strategy-name").html(strategy);
                //Hide Current Toast
                clear();
                $(".myadmin-alert").hide();
                $("html, body").animate({
                    scrollTop: 0
                }, "slow");
                $("#alerttopright-success").fadeToggle(350);

            } else {
                console.log("consol2");
                //Hide Current Toast
                $(".myadmin-alert").hide();


                $("#alerttopright-fail").fadeToggle(350);

                // $("#alerttopright-fail").fadeToggle(350);
                $("html, body").animate({
                    scrollTop: 0
                }, "slow");
            }
        }
    });
});

$("#submit-gosm").click(function() {
    $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/submitGOSM',
        //TODO: edit data, add with session
        data: {
            'org': 1
        },
        success: function(data) {

        }
    });
});
