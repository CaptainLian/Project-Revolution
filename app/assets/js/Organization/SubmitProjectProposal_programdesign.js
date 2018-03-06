
$('#date-range').datepicker({
        toggleActive: true
      });
$("select").select2();
$('#createEventModal').modal({ show: false})
$('#single-input').clockpicker({
        placement: 'bottom',
        align: 'left',
        autoclose: true,
        'default': 'now'
    });
    $('.clockpicker').clockpicker({
        donetext: 'Done',
    }).find('input').change(function() {
        console.log(this.value);
    });
    $('#check-minutes').click(function(e) {
        // Have to stop propagation here
        e.stopPropagation();
        input.clockpicker('show').clockpicker('toggleView', 'minutes');
    });
$('#responsible')
$(".wizard-back").clone().appendTo(".buttons");
var sched = {};
var revenueLess = 0;

ctr = 0;


$("#venue").select2();
$("textarea").change(function() {
    $(this).val();
});
$(".select2").select2();
$("div.fixed-table-loading").remove();
$("#myTabs ").on('click', 'i.close-day', function() {
    var c = $(this).closest("a").attr("href");
    ctr--;
    console.log("asd" + c);
    $(this).closest("li").remove();
    // var id = c.substring(1);
    var toRemove = $(c).find("table").find("td:first").attr("date");
    delete sched[toRemove];
    console.log(toRemove);
    $(c).remove();
    var tabFirst = $('#myTabs a:first');
    // resetTab();
    tabFirst.tab('show');

});
$(document).ready(function() {
    if (revenueLess) {
        $(".table-less").css('display', 'none');
        $("#mainTable2").removeClass('success-bordered-table').addClass('danger-bordered-table');

    }
    $("div.fixed-table-loading").remove();
    $('#datepicker-autoclose').datepicker({
        autoclose: true,
        todayHighlight: true,
        startDate: new Date()
    });



    $("#org-exp").trigger("focus");
    $("#ope-fund, #dep-fund, #other-fund, #org-exp, #par-exp, #others-exp").val("0");


    // $('.fxsdr').attr('checked', true);
    // $("tr.no-records-found").remove();.on("focus","input",
});
$(document).bind("customHtmlGenerated", function() {






    var idNumber = $("ul#myTabs").find(".active").attr("id").substring(1);
    var length = sched.length - 1;
    console.log("DATE " + Object.keys(sched).slice(-1)[0]);
    var day = (new Date(new Date(Object.keys(sched).slice(-1)[0]).getTime() + 1000 * 60 * 60 * 24).getMonth() + 1) + '/' + new Date(new Date(Object.keys(sched).slice(-1)[0]).getTime() + 1000 * 60 * 60 * 24).getDate() + '/' + new Date(new Date(Object.keys(sched).slice(-1)[0]).getTime() + 1000 * 60 * 60 * 24).getFullYear();
    console.log(day);
    $('#datepicker-autoclose' + ctr).datepicker({
        autoclose: true,
        todayHighlight: true,
        startDate: day
    });
    $("#datepicker-autoclose" + ctr).on('change', function() {
        console.log($(this).closest("div.col-md-12").removeClass("has-error").addClass("has-success"));
        $(this).attr("disabled", "");
    });

    var clockpicker = $('#start-time' + ctr).clockpicker({
        donetext: 'Done',
        autoclose: true,
    });
    console.log("asd");
    var clockpicker2 = $('#end-time' + ctr).clockpicker({
        donetext: 'Done',
        autoclose: true,
    });

    $("#program-tables" + idNumber).on('click', '.view-details', function() {


        var date = $(this).closest("tr").attr("date");
        var date2 = $(this).closest("tr").find("td:first").attr("date");
        console.log("ROW INDEX");
        console.log($(this).closest("table").find("tr").index($(this).closest("tr")));
        var ind = $(this).closest("table").find("tr").index($(this).closest("tr")) - 1;

        if (sched[date] == undefined) {
            // console.log( sched[date2].splice(ind,1));
            var actName = sched[date2][ind].act;
            var start = sched[date2][ind].start;
            var end = sched[date2][ind].end;
            var desc = sched[date2][ind].desc;
            var person = sched[date2][ind].person;
            console.log()
            $("#activity-preview" + idNumber).text(actName);
            $("#time-preview" + idNumber).text(start + ' to ' + end);
            $("#description-preview" + idNumber).text(desc);
            $("#person-preview" + idNumber).text(person);

        } else {
            // console.log( sched[date].splice(ind,1));

            var actName = sched[date][ind].act;
            var start = sched[date][ind].start;
            var end = sched[date][ind].end;
            var desc = sched[date][ind].desc;
            var person = sched[date][ind].person;
            $("#activity-preview" + idNumber).text(actName);
            $("#time-preview" + idNumber).text(start + ' to ' + end);
            $("#description-preview" + idNumber).text(desc);
            $("#person-preview" + idNumber).text(person);
        }
        $('body,html').animate({
            scrollTop: $('body').height()
        }, 500);





    });


    $("#program-tables" + idNumber).on('click', '.remove-time', function() {
        tctr--;
        var tspace =
            '<td ></td>' +
            '<td></td>' +
            '<td class="descri"></td>' +
            '<td></td>' +
            '<td></td>' +
            '<td></td>';
        // DELETE FROM JSON
        var date = $(this).closest("tr").attr("date");
        var date2 = $(this).closest("tr").find("td:first").attr("date");
        console.log("ROW INDEX");
        console.log($(this).closest("table").find("tr").index($(this).closest("tr")));
        var ind = $(this).closest("table").find("tr").index($(this).closest("tr")) - 1;

        if (sched[date] == undefined) {
            console.log(sched[date2].splice(ind, 1));
        } else {
            console.log(sched[date].splice(ind, 1));
        }
        console.log(sched);
        // DELETE FROM JSON
        if (tctr == 0) {
            $(this).closest("tr").attr("class", "no-records-found").find("td").html(" ");
        } else {
            $(this).closest("tr").remove();
            // $(this).closest("tr").css("display","none");
        }




    });


    $("#insert-button" + ctr).click(function() {
        var dateInp = $("#datepicker-autoclose" + idNumber).val();
        var startInp = $("#start-time" + idNumber).val();
        var endInp = $("#end-time" + idNumber).val();
        var actInp = $("#act" + idNumber).val();
        var descInp = $("#desc" + idNumber).val();
        var selInp = $("#sel" + idNumber).val();
        var obj = {};
        $("#start-time" + idNumber).closest("div.form-group").removeClass("has-error");
        $("#time-help" + idNumber).text("");
        $("#start-time" + idNumber).closest("div.form-group").removeClass("has-error");
        $("#time-help" + idNumber).text("");
        $("#act" + idNumber).closest("div.form-group").removeClass("has-error");
        $("#desc" + idNumber).closest("div.form-group").removeClass("has-error");
        $("#desc-help" + idNumber).text("");
        $("#act-help" + idNumber).text("");

        var error = 0;
        if ($.trim(startInp) == $.trim(endInp)) {
            $("#start-time" + idNumber).closest("div.form-group").addClass("has-error");
            $("#time-help" + idNumber).append("Start Time and End Time cannot be the same");
            error = 1;
        }
        if ($.trim(dateInp) < 1) {
            console.log("ERROR");
            $("#datepicker-autoclose" + idNumber).closest("div.col-md-12").addClass("has-error");
            $("#datepicker-autoclose-help" + idNumber).text("Cannot accept empty Date");
            error = 1;
            $('body,html').animate({
                scrollTop: 100
            }, 500);
        }
        if (Date.parse(dateInp + " " + startInp) > Date.parse(dateInp + " " + endInp)) {
            console.log(dateInp + startInp + "ERROR" + dateInp + endInp);
            $("#start-time" + idNumber).closest("div.form-group").addClass("has-error");
            $("#time-help" + idNumber).append("End Time cannot be earlier than Start Time. ");

            error = 1;
        }
        if (dateInp in sched) {
            var length = sched[dateInp].length;
            console.log("PUMASOK SA IF" + length);
            if (Date.parse(dateInp + " " + startInp) < Date.parse(dateInp + " " + sched[dateInp][length - 1].end)) {
                console.log(dateInp + startInp + "ERROR" + dateInp + endInp);
                $("#start-time" + idNumber).closest("div.form-group").addClass("has-error");
                $("#time-help" + idNumber).append("Overlapping of time with the previous activity.");

                error = 1;
            }
        }


        if ($.trim(actInp) < 1) {
            console.log("ERROR");
            $("#act" + idNumber).closest("div.form-group").addClass("has-error");
            $("#act-help" + idNumber).text("Cannot accept empty Activity Name");
            error = 1;
        }

        if ($.trim(descInp) < 1) {
            $("#desc" + idNumber).closest("div.form-group").addClass("has-error");
            $("#desc-help" + idNumber).text("Cannot accept empty Activity Description");
            $("#desc" + idNumber).addClass("has-error");
            error = 1;
        }
        if (error) {

        } else {

            var newEnd = new Date(dateInp + " " + endInp).getTime() + (new Date(dateInp + " " + endInp).getTime() - new Date(dateInp + " " + startInp).getTime());
            console.log("NEW END IEM " + new Date(newEnd).getHours() + ":" + new Date(newEnd).getMinutes());

            $("#start-time" + idNumber).val(endInp);
            $("#end-time" + idNumber).val(('0'+new Date(newEnd).getHours()).slice(-2) + ":" + ("0"+new Date(newEnd).getMinutes()).slice(-2));

            $("#act" + idNumber).val("");
            $("#desc" + idNumber).val("");



            $("#datepicker-autoclose" + idNumber).closest("div.col-md-12").remove("has-error");
            $("#datepicker-autoclose-help" + idNumber).text("");
            $("#start-time" + idNumber).closest("div.form-group").removeClass("has-error");
            $("#time-help" + idNumber).text("");
            $("#start-time" + idNumber).closest("div.form-group").removeClass("has-error");
            $("#time-help" + idNumber).text("");
            $("#act" + idNumber).closest("div.form-group").removeClass("has-error");
            $("#desc" + idNumber).closest("div.form-group").removeClass("has-error");
            $("#desc-help" + idNumber).text("");
            $("#act-help" + idNumber).text("");

            console.log("BEFORE");
            console.log(dateInp in sched);

            if (dateInp in sched) {
                console.log("pum");
                var act = {

                    'start': startInp,
                    'end': endInp,
                    'act': actInp,
                    'desc': descInp,
                    'person': selInp

                };

                sched[dateInp].push(act);
            } else {
                var act = {

                    'start': startInp,
                    'end': endInp,
                    'act': actInp,
                    'desc': descInp,
                    'person': selInp

                };
                sched[dateInp] = [];
                sched[dateInp].push(act);

                // obj[dateInp] = act;
                // sched.push(obj);  
                // sched.dateInp.push(ac)
            }

            console.log(sched);

            var trow = " <tr date='" + dateInp + "' start='" + startInp + "' end='" + endInp + "'>" +

                "<td  class='text-center' style='color:#2b2b2b'>" + startInp + " - " + endInp + "</td>" +
                // "<td style='color:#2b2b2b'>Roshan</td>"+
                "<td class='text-center' style='color:#2b2b2b'>" + actInp + "</td>" +
                // "<td  class='descri' style='color:#2b2b2b'>"+descInp+"</td>"+
                // "<td style='color:#2b2b2b'>"+selInp+"</td>"+
                '<td > <i class="fa fa-comment-o view-details "></i>  <i data-toggle="tooltip" data-tittle="Remove" class="fa fa-times text-danger  remove-time"></i></td>' +
                "</tr>";
            var ttd =
                "<td  class='text-center' date='" + dateInp + "' start='" + startInp + "' end='" + endInp + "'  style='color:#2b2b2b'>" + startInp + " - " + endInp + "</td>" +
                // "<td style='color:#2b2b2b'>Roshan</td>"+
                "<td class='text-center' style='color:#2b2b2b'>" + actInp + "</td>" +
                // "<td  class='descri' style='color:#2b2b2b'>"+descInp+"</td>"+
                // "<td style='color:#2b2b2b'>"+selInp+"</td>"+
                '<td > <i class="fa fa-comment-o  view-details  "></i>  <i data-toggle="tooltip" data-tittle="Remove" class="fa fa-times text-danger  remove-time"></i></td>' +
                console.log("ASD");

            console.log("UNANG IF" + $("#program-tables" + ctr + " tbody tr:first").hasClass("no-records-found"));
            if ($("#program-tables" + $("ul#myTabs").find(".active").attr("id").substring(1) + " tbody tr:first").hasClass("no-records-found")) {
                console.log("PASOK asd")
                $("#program-tables" + $("ul#myTabs").find(".active").attr("id").substring(1) + " tr.no-records-found").find("td").remove();
                $("#program-tables" + $("ul#myTabs").find(".active").attr("id").substring(1) + " tr.no-records-found").append(ttd);
                $("#program-tables" + $("ul#myTabs").find(".active").attr("id").substring(1) + " tbody tr.no-records-found").removeClass("no-records-found");
            } else {
                console.log("pasok");
                console.log("TABLE NUMBER " + $("ul#myTabs").find(".active").attr("id").substring(1));
                $("#program-tables" + $("ul#myTabs").find(".active").attr("id").substring(1) + " tbody").append(trow);
            }

        }

    });
    //NEED TO BE FIXED TO ROUND
    // clockpicker.change(function(){
    //     console.log("DONW");
    //     clockpicker.val(round());
    // });
    // clockpicker2.change(function(){
    //     console.log("DONW");
    //     clockpicker2.val(round2());
    // });

});
$("ul li").on('click', 'a#add-tab', function(e) {
    var div = $("<div class='row'><div style='display:none'></div></div>");

    // var toBeInserted = div.find("div").append(qclon,qtabl);



    ctr++;
    e.preventDefault();
    console.log("ASd");

    var tni =

        '<div class="col-md-12"   style="padding: 25px;position: relative;  ">' +


        '<input style="height:0px; top:-1000px; position:absolute;display: none" type="text" value="">' +
        '<div class="col-md-12 ">' +
        '<label class="form-control-label">Date</label>' +
        '<div class="input-group  ">' +
        '<input name="date" readonly="" class="form-control" id="datepicker-autoclose' + ctr + '" placeholder="mm/dd/yyyy" type="text">' +
        '<span class="input-group-addon"><i class="icon-calender"></i></span> ' +
        '</div>' +
        '<div>' +
        '<span id="datepicker-autoclose-help' + ctr + '" class="help-block"> Date of the Activity could only be set once</span>' +
        '</div>' +
        '</div>' +



        '</div>' +
        '<div class=" col-xs-12 col-md-8  " id="clone-table" style="padding-top: 30px">' +
        '<div class="table-responsive"  style="overflow-x:auto;">' +
        '<table id="program-tables' + ctr + '" style="table-layout: fixed" class=" table program color-bordered-table success-bordered-table" >' +
        '<thead>' +
        '<tr>' +

        '<th width="25%" class="text-center"  >Time</th>' +

        '<th width="65%"  class="text-center">Activity</th>' +

        '<th width="10%" data-field="state" data-checkbox="true"></th>' +
        '</tr>' +
        '</thead>' +
        '<tbody>' +
        '<tr class="no-records-found">' +
        '<td ></td>' +

        '<td></td>' +

        '<td></td>' +
        '</tr>' +

        '</tbody>' +
        '</table>' +
        '</div>' +
        '</div>' +

        '<div class="col-md-4 " style="margin-top: 50px;">' +
        '<div>&nbsp</div>' +
        '<div class="form-group">' +
        '<label class="form-control-label" for="start-time">Time</label>' +
        '<div class="input-group clockpicker " data-autoclose="true">' +
        '<input name="timeStart" type="text" id="start-time' + ctr + '" class="form-control" value="00:00" readonly="">' +
        '<span class=" input-group-addon bg-info b-0 text-white">to</span>' +
        '<input name="timeEnd" type="text" id="end-time' + ctr + '" class="form-control" value="00:00" readonly="">' +
        '</div>' +
        '<div>' +
        '<span class="help-block" id="time-help' + ctr + '"></span>' +
        '</div>' +
        '</div>' +
        '<div class="form-group">' +
        '<label class="form-control-label">Activity</label>' +
        '<input name="activity" id="act' + ctr + '"  type="text" class="form-control">' +
        '<div>' +
        '<span class="help-block" id="act-help' + ctr + '"></span>' +
        '</div>' +
        '</div>' +
        '<div class="form-group">' +
        '<label class="form-control-label">Description</label>' +
        '<textarea name="description" id="desc' + ctr + '" class="form-control" rows="2" ></textarea>' +
        '<div>' +
        '<span class="help-block" id="desc-help' + ctr + '"></span>' +
        '</div>' +
        '</div>' +

        '<div class="form-group">' +
        '<label class="form-control-label">Person in Charge</label>' +
        '<select name="personInCharge" id="sel' + ctr + '" class="form-control select2">' +
        '<option value="11445955">Delaware</option>' +
        '<option value="11445955">Florida</option>' +
        '<option value="11445955">Georgia</option>' +
        '</select>' +
        '<div>' +
        '<span class="help-block" id="time-help' + ctr + '"></span>' +
        '</div>' +
        '</div>' +

        '<div class="m-t-5 form-group text-center">' +

        '<button type="button" id="insert-button' + ctr + '" class="btn btn-info">Insert </button>' +

        '</div>' +

        '</div>' +
        '<div class="col-md-12" style="margin-top:32px;padding:20px;border: 1px solid grey;border-radius: 2px">' +
        '<h3 class="text-center">Activity Details</h3>' +
        '<label style=" position: absolute;right: 20px;top:20px">Time</label>' +
        '<p  style="word-break: break-all; position: absolute;right: 20px;top:40px" class="form-control-static"  id="time-preview' + ctr + '"></p>' +

        '<label >Activity</label>' +
        '<p  style="word-break: break-all;" class="form-control-static" id="activity-preview' + ctr + '" ></p>' +
        '<div>&nbsp</div>' +
        '<label>Description</label>' +
        '<p style="word-break: break-all;" id="description-preview' + ctr + '"></p>' +
        '<div>&nbsp</div>' +
        '<label>Person in Charge</label>' +
        '<p  style="word-break: break-all;" class="form-control-static"  id="person-preview' + ctr + '"></p>' +
        '<div>' +
        '&nbsp' +

        '</div>' +

        '</div>';



    $("#t" + (ctr - 1)).after('<li role="presentation" class="nav-item " id="t' + ctr + '"><a aria-controls="profile " class="nav-link" id="tab-' + ctr + '" data-toggle="tab" href="#ctab' + ctr + '" role="tab"  aria-expanded="true">Day ' + (ctr + 1) + '      ' + '<i class="fa ti-close close-day" style="font-size:8px;top:5px;right:5px;position:absolute;"></i></a></li>');
    var cont = $("#ctab" + (ctr - 1)).after('<div aria-labelledby="tab-' + ctr + '" id="ctab' + ctr + '" class="tab-pane " role="tabpanel"><div id="temp' + ctr + '" class="row">' + tni + '</div></div>');
    // cont.find("#temp").append(toBeInserted);

    //NEED TO REINITIALIZE





    //  var qclon = $("#clone-question").clone(true).appendTo("#temp"+ctr);
    // var qtabl = $("#clone-table").clone(true).appendTo("#temp"+ctr);


    $(".nav-tabs  a[href='#ctab" + (ctr) + "']").tab("show");
    $("#tab-0").removeAttr("class", "active");
    $(document).trigger("customHtmlGenerated");


});

var clockpicker = $('#start-time').clockpicker({
    donetext: 'Done',
    autoclose: true,
});
var clockpicker2 = $('#end-time').clockpicker({
    donetext: 'Done',
    autoclose: true,
});

clockpicker.change(function() {
    console.log("DONW");
    clockpicker.val(round());
});
clockpicker2.change(function() {
    console.log("DONW");
    clockpicker2.val(round2());
});


function round() {
    var time = clockpicker.val(),
        arr = time.split(':'),
        hour = arr[0],
        min = arr[1],
        newMin = (Math.floor(parseInt(min) / 5)) * 5;

    return hour + ':' + (newMin > 9 ? '' : '0') + newMin;
}
// JEJEMON TO TINAMAD NA AKO. AYUSIN KO NEXT TIME
function round2() {
    var time = clockpicker2.val(),
        arr = time.split(':'),
        hour = arr[0],
        min = arr[1],
        newMin = (Math.floor(parseInt(min) / 5)) * 5;

    return hour + ':' + (newMin > 9 ? '' : '0') + newMin;
}
// $('#start-time').clockpicker({
//     donetext: 'Done',
//     autoclose:true,


// });
$('#datepicker-autoclose').datepicker({
    autoclose: true,
    todayHighlight: true,
    startDate: new Date()
});
tctr = 0

$("#insert-button").click(function() {

    var dateInp = $("#datepicker-autoclose").val();
    var startInp = $("#start-time").val();
    var endInp = $("#end-time").val();
    var actInp = $("#act0").val();
    var descInp = $("#desc0").val();
    var selInp = $("#sel0").val();
    var obj = {};
    $("#start-time").closest("div.form-group").removeClass("has-error");
    $("#time-help").text("");
    $("#start-time").closest("div.form-group").removeClass("has-error");
    $("#time-help").text("");
    $("#act0").closest("div.form-group").removeClass("has-error");
    $("#trdesc0").closest("div.form-group").removeClass("has-error");
    $("#desc-help").text("");
    $("#act-help").text("");

    var error = 0;

    if ($.trim(dateInp) < 1) {
        console.log("ERROR");
        $("#datepicker-autoclose").closest("div.col-md-12").addClass("has-error");
        $("#datepicker-autoclose-help").text("Cannot accept empty Date");
        $('body,html').animate({
            scrollTop: 100
        }, 500);
        error = 1;
    }
    if ($.trim(startInp) == $.trim(endInp)) {
        $("#start-time").closest("div.form-group").addClass("has-error");
        $("#time-help").append("Start Time and End Time cannot be the same");
        error = 1;
    }
    if (Date.parse(dateInp + " " + startInp) > Date.parse(dateInp + " " + endInp)) {
        console.log(dateInp + startInp + "ERROR" + dateInp + endInp);
        $("#start-time").closest("div.form-group").addClass("has-error");
        $("#time-help").append("End Time cannot be earlier than Start Time. ");

        error = 1;
    }
    if (dateInp in sched) {
        var length = sched[dateInp].length;
        console.log("PUMASOK SA IF" + length);
        if (Date.parse(dateInp + " " + startInp) < Date.parse(dateInp + " " + sched[dateInp][length - 1].end)) {
            console.log(dateInp + startInp + "ERROR" + dateInp + endInp);
            $("#start-time").closest("div.form-group").addClass("has-error");
            $("#time-help").append("Overlapping of time with the previous activity.");

            error = 1;
        }
    }


    if ($.trim(actInp) < 1) {
        console.log("ERROR");
        $("#act0").closest("div.form-group").addClass("has-error");
        $("#act-help").text("Cannot accept empty Activity Name");
        error = 1;
    }

    if ($.trim(descInp) < 1) {
        $("#desc0").closest("div.form-group").addClass("has-error");
        $("#desc-help").text("Cannot accept empty Activity Description");
        $("#desc0").addClass("has-error");
        error = 1;
    }
    if (error) {

    } else {

        var newEnd = new Date(dateInp + " " + endInp).getTime() + (new Date(dateInp + " " + endInp).getTime() - new Date(dateInp + " " + startInp).getTime());
        $("#end-time").val(('0'+new Date(newEnd).getHours()).slice(-2) + ":" + ("0"+new Date(newEnd).getMinutes()).slice(-2));

        $("#start-time").val(endInp);
        // $("#end-time").val(new Date(newEnd).getHours() + ":" + new Date(newEnd).getMinutes());

        $("#act0").val("");
        $("#desc0").val("");


        $("#datepicker-autoclose").closest("div.col-md-12").remove("has-error");
        $("#datepicker-autoclose-help").text("");
        $("#start-time").closest("div.form-group").removeClass("has-error");
        $("#time-help").text("");
        $("#start-time").closest("div.form-group").removeClass("has-error");
        $("#time-help").text("");
        $("#act0").closest("div.form-group").removeClass("has-error");
        $("#desc0").closest("div.form-group").removeClass("has-error");
        $("#desc-help").text("");
        $("#act-help").text("");

        console.log("BEFORE");
        console.log(dateInp in sched);

        if (dateInp in sched) {
            console.log("pum");
            var act = {

                'start': startInp,
                'end': endInp,
                'act': actInp,
                'desc': descInp,
                'person': selInp

            };

            sched[dateInp].push(act);
        } else {
            var act = {

                'start': startInp,
                'end': endInp,
                'act': actInp,
                'desc': descInp,
                'person': selInp

            };
            sched[dateInp] = [];
            sched[dateInp].push(act);

            // obj[dateInp] = act;
            // sched.push(obj);  
            // sched.dateInp.push(ac)
        }


        console.log(sched);
        var trow = " <tr date='" + dateInp + "' start='" + startInp + "' end='" + endInp + "'>" +

            "<td class='text-center'  style='color:#2b2b2b'>" + startInp + " - " + endInp + "</td>" +
            // "<td style='color:#2b2b2b'>Roshan</td>"+
            "<td class='text-center' style='color:#2b2b2b'>" + actInp + "</td>" +
            // "<td  class='descri' style='color:#2b2b2b'>"+descInp+"</td>"+
            // "<td style='color:#2b2b2b'>"+selInp+"</td>"+
            '<td > <i class="fa fa-comment-o view-details "></i>  <i data-toggle="tooltip" data-tittle="Remove" class="fa fa-times text-danger  remove-time"></i></td>' +
            "</tr>";
        var ttd =
            "<td  class='text-center' date='" + dateInp + "' start='" + startInp + "' end='" + endInp + "'  style='color:#2b2b2b'>" + startInp + " - " + endInp + "</td>" +
            // "<td style='color:#2b2b2b'>Roshan</td>"+
            "<td class='text-center' style='color:#2b2b2b'>" + actInp + "</td>" +
            // "<td  class='descri' style='color:#2b2b2b'>"+descInp+"</td>"+
            // "<td style='color:#2b2b2b'>"+selInp+"</td>"+
            '<td > <i class="fa fa-comment-o view-details" ></i>  <i data-toggle="tooltip" data-tittle="Remove" class="fa fa-times text-danger  remove-time"></i></td>' +
            console.log("ASD");
        if ($("#program-tables tbody tr:first").hasClass("no-records-found")) {

            $("#program-tables tr.no-records-found").find("td").remove();
            $("#program-tables tr.no-records-found").append(ttd);
            $("#program-tables tr.no-records-found").removeAttr("class", "no-records-found");
        } else {
            console.log("pasok");
            $("#program-tables tbody").append(trow);
        }

        tctr++;
        console.log(tctr);
    }

});
$("#program-tables").on('click', '.remove-time', function() {
    tctr--;
    var tspace =
        '<td ></td>' +
        '<td></td>' +
        '<td  class="descri"></td>' +
        '<td></td>' +
        '<td></td>' +
        '<td></td>';

    var date = $(this).closest("tr").attr("date");
    var date2 = $(this).closest("tr").find("td:first").attr("date");
    console.log("ROW INDEX");
    console.log($(this).closest("table").find("tr").index($(this).closest("tr")));
    var ind = $(this).closest("table").find("tr").index($(this).closest("tr")) - 1;

    if (sched[date] == undefined) {
        console.log(sched[date2].splice(ind, 1));
    } else {
        console.log(sched[date].splice(ind, 1));
    }
    console.log(sched);

    $(this).closest("tr").remove();
    if (tctr == 0) {
        $(this).closest("tr").attr("class", "no-records-found").find("td").html(" ");
    } else {
        $(this).closest("tr").remove();
    }




});
$("#datepicker-autoclose").change(function() {

    console.log($(this).closest("div.col-md-12").removeClass("has-error").addClass("has-success"));
    $(this).attr("disabled", "");
});


$("#program-tables").on('click', '.view-details', function() {


    var date = $(this).closest("tr").attr("date");
    var date2 = $(this).closest("tr").find("td:first").attr("date");
    console.log("ROW INDEX");
    console.log($(this).closest("table").find("tr").index($(this).closest("tr")));
    var ind = $(this).closest("table").find("tr").index($(this).closest("tr")) - 1;

    if (sched[date] == undefined) {
        // console.log( sched[date2].splice(ind,1));
        var actName = sched[date2][ind].act;
        var start = sched[date2][ind].start;
        var end = sched[date2][ind].end;
        var desc = sched[date2][ind].desc;
        var person = sched[date2][ind].person;
        console.log()
        $("#activity-preview").text(actName);
        $("#time-preview").text(start + ' to ' + end);
        $("#description-preview").text(desc);
        $("#person-preview").text(person);

    } else {
        // console.log( sched[date].splice(ind,1));

        var actName = sched[date][ind].act;
        var start = sched[date][ind].start;
        var end = sched[date][ind].end;
        var desc = sched[date][ind].desc;
        var person = sched[date][ind].person;
        console.log()
        $("#activity-preview").text(actName);
        $("#time-preview").text(start + ' to ' + end);
        $("#description-preview").text(desc);
        $("#person-preview").text(person);
    }
    $('body,html').animate({
        scrollTop: $('body').height()
    }, 500);





});


var tempExp = 0;


$("#submit-but").click(function(){
    $.ajax({
        type:'POST',
        url:'/Organization/projectproposal/SaveDesign',
        data:{"sched":JSON.stringify(sched), gid:$("#data-route").attr("gid"),pid:$("#data-route").attr("pid")},
        success:function(data){
            if(parseInt(data))
            window.location.href="/organization/projectproposal/main/"+$("#data-route").attr("gid")+'/'+$("#data-route").attr("status");
        }
    })
})
$("#cancel-but").click(function(){
    window.location.href="/organization/projectproposal/main";
        
})