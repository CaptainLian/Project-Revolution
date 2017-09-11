'use strict';

(() => {
    const csrfToken = document.querySelector('meta[data-name="csrf"]').getAttribute('data-token');
    const table = $('#myTable');

    table.DataTable();

    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    table.find('tbody > .activity_row').click(function() {
        let row = $(this);
        let activityID = row.data('activity-id');
        setActivityModal(activityID);
    });

    document.getElementById('btn_approve')
        .addEventListener('click', function() {
            swal({
                title: "Approve Activity?",
                text: "Clicking confirm will approve the activity",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Confirm",
                closeOnConfirm: false
            }, function() {
                updateGOSMStatus(3, undefined, () => {
                    swal("Success!", "The activity has been approved", "success");
                }, () => {
                    swal("Oh oh!", "An error occured", "error");
                });
            }); //swal();
        }, false);

    document.getElementById('btn_pend')
        .addEventListener('click', function() {
            swal({
                    title: "Pend Activity",
                    text: "Write your reason for pending the activity:",
                    type: "input",
                    showCancelButton: true,
                    closeOnConfirm: false,
                    inputPlaceholder: "Input comments"
                },
                function(inputValue) {
                    if (inputValue) {
                        updateGOSMStatus(4, inputValue, () => {
                            swal('Success!', `you commented: ${inputValue}`, 'success');
                        }, () => {
                            swal("Uh oh!", "An error occured", "error");
                        });

                    } else {
                        swal.showInputError("You need to write something!");
                        return false;
                    }
                    return true;
                });
        }, false);

    document.getElementById('btn_deny')
        .addEventListener('click', function() {
            swal({
                    title: "Deny Activity",
                    text: "Write your reason for denying the activity:",
                    type: "input",
                    showCancelButton: true,
                    closeOnConfirm: false,
                    inputPlaceholder: "Write something"
                },
                function(inputValue) {
                    if (inputValue) {
                        updateGOSMStatus(5, inputValue, () => {
                            swal('Success!', `You commented ${inputValue}`, 'success');
                        }, () => {
                            swal("Oops", "An error occured", "error");
                        });
                    } else {
                        swal.showInputError("You need to write something!");
                        return false;
                    }
                    return true;
                });
        }, false);


    var currentActivity = -500;
    const modal_table = $('#modal_table_activity');
    const modal_type = $('#modal_type');
    const modal_nature = $('#modal_nature');
    const modal_date = $('#modal_date');
    const modal_comments = $('#modal_txtarea_comments');

    function setActivityModal(activityID) {
        currentActivity = activityID;
        $.ajax({
            type: 'GET',
            url: '/APS/ajax/GetGOSMActivityDetails',
            data: {
                _csrf: csrfToken,
                activityID: activityID
            },
            async: true,
            success: function(data, textStatus, jqXHR) {
                if (data.valid) {
                    console.log(data);
                    const activityDetails = data.activityDetails;
                    const projectHeads = data.projectHeads;
                    modal_type.html(activityDetails.type);
                    modal_nature.html(activityDetails.nature);
                    modal_date.html(activityDetails.startdate + ' - ' + activityDetails.enddate);
                    modal_comments.html(activityDetails.comments);

                    modal_table.find('.modal_head_row').remove();

                    console.log(JSON.stringify(projectHeads));
                    if (projectHeads.length > 0) {
                        modal_table.append('<tr class="modal_head_row"><th>Project Heads:</th><td colspan="6">' + projectHeads[0].name + ":&nbsp;" + projectHeads[0].contactnumber + '</td></tr>');
                        for (let index = 1, length = projectHeads.length; index < length; ++index) {
                            modal_table.append('<tr class="modal_head_row"><th></th><td colspan="6">' + projectHeads[index].name + ":&nbsp;" + projectHeads[index].contactnumber + '</td></tr>');
                        }
                    }
                } else {
                    $('#sampleModal').modal('hide');
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        }); //$.ajax()a
    }

    /*
      1 - Created
      2 - Initial Submission
      3 - Approved
      4 - Pending
      5 - Denied
    */
    function updateGOSMStatus(statusID, comments, success, fail) {
        const GOSMID = $('meta[data-name="GOSM"]').data('id');
        let data = {
            _csrf: csrfToken,
            GOSMID: GOSMID,
            statusID: statusID
        };
        if (comments) {
            data.comments = comments;
        }

        $.ajax({
            type: 'POST',
            url: '/APS/ajax/UpdateGOSM',
            data: data,
            async: true,
            success: function(data, textStatus, jqXHR) {
                console.log(data);
                if (data.valid && data.success) {
                    success();
                } else {
                    fail();
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(errorThrown);
                fail();
            }
        });
    }

    /*
    The wackiest set of symbols that makes sense in javascript
    #UnopinnionatedCode
        (() => {

        })();
    */
    (() => {
        let btnAddComment = document.getElementById('modal_btn_add_comment');
        btnAddComment.addEventListener('click', () => {
            console.log(currentActivity);
            const param = {
                _csrf: csrfToken,
                activityID: currentActivity,
                comments: modal_comments.val()
            };
            $.ajax({
                type: 'GET',
                url: '/APS/ajax/UpdateGOSMActivityComment',
                data: param,
                success: function(data, textStatus, jqXHR) {
                    if (data.valid && data.success) {
                        swal('Success!', `You commented: ${param.comments}`, 'success');
                    }else{
                        swal("Ouch!", "An internal error occured", "error");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(errorThrown);
                    swal("Yikes!", "An internal error occured", "error");
                }
            });
        }, false);
    })();

})();