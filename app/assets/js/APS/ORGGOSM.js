'use strict';

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
                    updateGOSMStatus  (4, inputValue, () => {
                      swal(`Success! you commented: ${inputValue}`, 'success');
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
                        swal(`Success! you commented: ${inputValue}`, 'success');
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

const modal_table = $('#modal_table_activity');
function setActivityModal(activityID) {
    $.ajax({
        type: 'GET',
        url: '/APS/ajax/GetGOSMActivityDetails',
        data: {
            activityID: activityID
        },
        async: true,
        success: function(data, textStatus, jqXHR) {
            if (data.valid) {
                console.log(data);
                const activityDetails = data.activityDetails;
                const projectHeads = data.projectHeads;
                $('#modal_type').html(activityDetails.type);
                $('#modal_nature').html(activityDetails.nature);
                $('#modal_date').html(activityDetails.startdate + ' - ' + activityDetails.enddate);

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
function updateGOSMStatus(statusID, comments, succcess, fail) {
    const GOSMID = $('meta[data-name="GOSM"]').data('id');
    let data = {
        GOSMID: GOSMID,
        statusID: statusID
    };
    if (comments) {
        data.comments = comments;
    }

    $.ajax({
        type: 'GET',
        url: '/APS/ajax/UpdateGOSM',
        data: data,
        async: true,
        success: function(data, textStatus, jqXHR) {
            console.log(data);
            if (data.valid && data.success) {
                success();
            } else if (data.valid && !data.success) {
                fail();
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

function date(activityID, comments) {
    $.ajax({

    }); //ajax();
}