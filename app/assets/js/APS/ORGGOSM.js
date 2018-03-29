'use strict';

(() => {
    const csrfToken = document.querySelector('meta[data-name="csrf"]').getAttribute('data-token');
    const table = $('#myTable');

    table.DataTable();

    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    var currentActivity = -500;
    const modal_table = $('#modal_table_activity');
    const modal_type = $('#modal_type');
    const modal_nature = $('#modal_nature');
    const modal_date = $('#modal_date');
    const modal_comments = $('#modal_txtarea_comments');

    /* Viewing and updating of each GOSM activity */
    (() => {
        function setActivityModal(activityID) {
            currentActivity = activityID;
            $.ajax({
                type: 'POST',
                url: '/APS/ajax/GetGOSMActivityDetails',
                data: {
                    _csrf: csrfToken,
                    activityID: activityID
                },
                async: true,
                success: function(data, textStatus, jqXHR) {
                    if (data.valid) {
                        const activityDetails = data.activityDetails;
                        const projectHeads = data.projectHeads;
                        modal_type.html(activityDetails.type);
                        modal_nature.html(activityDetails.nature);
                        modal_date.html(activityDetails.startdate + ' - ' + activityDetails.enddate);
                        modal_comments.val(activityDetails.comments);

                        modal_table.find('.modal_head_row').remove();

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
            }); //$.ajax()
        }

        table.find('tbody > .activity_row').click(function() {
            let row = $(this);
            let activityID = row.data('activity-id');
            setActivityModal(activityID);
        });

    })();

    /*
    The wackiest set of symbols that makes sense in javascript
    #UnopinnionatedCode
        (() => {

        })();
    */

    /* 
        Activity Comments
    */
    (() => {
        let btnAddComment = document.getElementById('modal_btn_add_comment');
        btnAddComment.addEventListener('click', () => {
            const param = {
                _csrf: csrfToken,
                activityID: currentActivity,
                comments: modal_comments.val()
            };
            $.ajax({
                type: 'POST',
                url: '/APS/ajax/UpdateGOSMActivityComment',
                data: param,
                success: function(data, textStatus, jqXHR) {
                    if (data.valid && data.success) {
                        swal('Success!', `You commented: ${param.comments}`, 'success');
                    } else {
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


    /*
        update of GOSM Status
        it has 3 buttons
        approve, pend, and deny
    */
    (() => {
        /*
          1 - Created
          2 - Initial Submission
          3 - Approved
          4 - Pending
          5 - Denied

          Function called by the 3 buttons
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

        let btn_approve = document.getElementById('btn_approve');
        if (btn_approve != null) {
            btn_approve.addEventListener('click', function() {
                swal({
                    title: "Approve Activity?",
                    text: "Clicking confirm will approve the activity",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "Confirm",
                    closeOnConfirm: false,
                    reverseButton:false
                }, function() {
                    updateGOSMStatus(3, undefined, () => {
                        swal({
                                title: "Success!",
                                text: "The activity has been approved",
                                type: "success"
                            },
                            () => {
                                location.reload(true);
                            });
                    }, () => {
                        swal("Oh oh!", "An error occured", "error");
                    });
                }); //swal();
            }, false);
        }


        let btn_pend = document.getElementById('btn_pend');
        if (btn_pend != null) {
            btn_pend.addEventListener('click', function() {
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
        }

        let btn_deny = document.getElementById('btn_deny');
        if (btn_deny != null) {
            btn_deny.addEventListener('click', function() {
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
        }
    })();
})();