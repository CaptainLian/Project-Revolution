$(document).bind('customGenerated', function() {
    (function() {
        [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
            new CBPFWTabs(el);
        });
    })();

    $('#section-linebox-5').css('visibility', "hidden");
    $('#section-linebox-5').css('height', 0);
    $('#section-linebox-5').css('width', 0);
    $(document).on('click', '.sttabs li', function() {
        var page = $(this).find("a").attr("href");
        console.log(page);
        page = page.replace("#section-linebox-", "");
        console.log(page);
        if (page == "5") {
            console.log("REFRESH");

            $('#section-linebox-5').css('visibility', "visible");
            $('#section-linebox-5').css('height', "100%");
            $('#section-linebox-5').css('width', "100%");
        } else {
            $('#section-linebox-5').css('visibility', "hidden");
            $('#section-linebox-5').css('height', 0);
            $('#section-linebox-5').css('width', 0);
        }
    });
});
$(document).trigger("customGenerated");

(() => {
    const DELAY_REROUTE_APPROVE = 400;
    const DELAY_REROUTE_PEND = 650;
    const DELAY_REROUTE_REJECT = 800;

    const STORAGE = localStorage || window.localStorage;

    const activity = STORAGE.getItem('GOSMACtivityID');
    console.log('activityID: ' + activity);

    (() => {
        [].slice.call(document.querySelectorAll('.sttabs'))
            .forEach(function(el) {
                new CBPFWTabs(el);
            });
    })();

    $("#approve").click(function() {
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
                if(data){
                    return Promise.resolve({proceed: data});
                }

                return Promise.reject({proceed: data});
            }
            //after swal(), promise from preConfirm
        }).then(() => {
            return acceptPPR();
        }).then(data => {
            console.log('PEND');
            console.log('after ajax-data: ' + JSON.stringify(data));

            return new Promise((resolve, reject) => {
                console.log(`Is success: ${data.success}`);
                if(data.success){
                    $("html, body").animate({
                        scrollTop: 0
                    }, function() {
                        $('#doc').removeClass("bounceInRight animated").addClass("bounceInRight   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                            $(this).removeClass("bounceInRight animated");
                        });
                    });

                    return setTimeout(() => {
                        return resolve(data);
                    }, DELAY_REROUTE_APPROVE);
                }else{
                    swal(
                      'Oh no!',
                      'Something went wrong! Please try again.',
                      'error'
                  );
                  return reject('Error?');
                }
            });
        }).then(data => {
            console.log('Rerouting user');
            return window.location.replace(data.reroute);
        }).catch(err => {
            console.log(err);
        });
    });



    $("#defer").click(function() {
        var question = '<div class="row">' +
            '<div class="col-md-12 text-left m-b-20">' +
            '<br/>Select the sections that should be change, then explain why.<br/>' +
            '</div>' +
            '<div class="form-group col-md-12">' +
            '<label class="col-md-12 text-left"><strong>Sections to be Edited:</strong></label>' +
            '<div class="col-md-12">' +
            '<select class="col-md-12" multiple=""s id="select-sec">' +

            '<option value="Brief Context">I. Brief Context</option>' +
            '<option value="Program Design">II. Program Design</option>' +
            // '<option value="Source of Funds">III. Source of Funds</option>' +
            // '<option value="Organizational Funds">IV. Organizational Funds</option>' +
            '<option value="Revenue and Expense Table">III. Revenue and Expense Table</option>' +
            '<option value="Attachments">IV. Attachments</option>' +
            '</select>' +
            '</div>' +

            '</div>' +
            '<div class="form-group col-md-12">' +
            '<label class="col-md-12 text-left"><strong>Explanation</strong></label>' +
            '<div class="col-md-12">' +
            '<textarea class="form-control" rows="5" id="pend-explanation"></textarea>' +
            '</div>' +
            '</div>' +
            '</div>';
        swal({
            title: "Pend",
            text: "Select the sections that should be change, then explain why.",
            html: question,
            focusConfirm: false,
            focusCancel: false,
            showLoaderOnConfirm: true,
            reverseButtons: true,
            allowOutsideClick: false,
            showCancelButton: true,
            confirmButtonColor: "#FEC107",
            confirmButtonText: "Pend",
            cancelButtonText: "Cancel",
            onOpen: function(ele) {
                $(ele).find("select").select2();
            },
            preConfirm: function(data) {
                let sections = $("#select-sec").val();
                let explanation = $("#pend-explanation").val();

                console.log(`Sections: ${sections}`);
                console.log(`Explanation: ${explanation}`);
                if(data){
                    return Promise.resolve({
                        proceed: data,
                        sections: sections,
                        explanation: explanation
                    });
                }

                return Promise.reject({proceed: data});
            }
        //after swal(), promise from preConfirm
        //Process ajax request
        }).then(data => {
            return pendPPR(data.sections, data.explanation);
        }).then(data => {
            console.log('PEND');
            console.log('after ajax-data: ' + JSON.stringify(data));

            return new Promise((resolve, reject) => {
                if(data.success){
                    $("html, body").animate({
                        scrollTop: 0
                    }, function() {
                        $('#doc').removeClass("bounceOutUp animated")
                            .addClass("bounceOutUp animated")
                            .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                                $(this).removeClass("bounceOutUp animated");
                            });
                    });

                    return setTimeout(() => {
                        return resolve(data);
                    }, DELAY_REROUTE_PEND);
                }else{
                    swal(
                      'Oops...',
                      'Something went wrong! Please try again.',
                      'error'
                  );
                  return reject();
                }
            });
        }).then(data => {
            console.log('Rerouting user');
            return window.location.replace(data.reroute);
        }).catch(err => {
            console.log(err);
        });
    });

    $("#reject").click(function() {
        var question = '<div class="row">' +
            '<div class="col-md-12 text-left  m-b-20" style="padding-left:16px">' +
            '<br/>State the reason for rejection.<br/>' +
            '</div>' +

            '<div class="form-group col-md-12">' +

            '<div class="col-md-12">' +
            '<textarea class="form-control" rows="5" id="reject-reason"></textarea>' +
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
            preConfirm: function(data) {
                let reason = $('#reject-reason').val();
                console.log(`Reason: ${reason}`);

                if(data){
                    return Promise.resolve({
                        proceed: data,
                        reason: reason
                    });
                }

                return Promise.reject({proceed: data});
            }
        //after swal(), promise from preConfirm
        }).then(data => {
            return rejectPPR(data.reason);
        }).then(function(data) {
            console.log('REJECT');
            console.log('after ajax-data: ' + JSON.stringify(data));
            return new Promise((resolve, reject) => {
                if(data.success){
                    $("html, body").animate({
                        scrollTop: 0
                    }, function() {
                        $('#doc').removeClass("rotateOutUpLeft animated")
                            .addClass("rotateOutUpLeft   animated")
                            .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                                $(this).removeClass("rotateOutUpLeft animated");
                            });
                    });

                    return setTimeout(() => {
                        return resolve(data);
                    }, DELAY_REROUTE_REJECT);
                }else{
                    swal(
                      'Uh oh!',
                      'Something went wrong! Please try again.',
                      'error'
                  );
                  return reject();
                }
            });
        }).then(data => {
            console.log('Rerouting user');
            return window.location.replace(data.reroute);
        }).catch(err => {
            console.log(err);
        });
    });

    function evaluatePPR(data) {
        console.log('data:' + JSON.stringify(data));

        return new Promise((resolve, reject) => {
            try {
                $.ajax({
                    url: '/APS/ajax/SignProjectProposal',
                    method: 'POST',
                    data: JSON.stringify(data),
                    dataType: 'json',
                    contentType: 'application/json; charset=UTF-8',
                    error: (jqXHR, textStatus, errorThrown) => {
                        console.log(jqXHR);
                        let err = new Error();
                        err.message = `${textStatus}\n${errorThrown}`;

                        return reject(err);
                    },
                    success: (data, textStatus, jqXHR) => {
                        return resolve(data);
                    }
                });
            } catch (err) {
                return reject(err);
            }
        });
    }

    function acceptPPR() {
        return evaluatePPR({
            activityID: activity,
            status: 1
        });
    }

    function pendPPR(sectionsToBeEdited, explanation) {
        return evaluatePPR({
            activityID: activity,
            sectionsToBeEdited: sectionsToBeEdited,
            comments: explanation,
            status: 2
        });
    }

    function rejectPPR(reason) {
        return evaluatePPR({
            activityID: activity,
            comments: reason,
            status: 3
        });
    }
})();
