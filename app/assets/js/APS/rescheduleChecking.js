var table = $("table").dataTable();

$(document).on('click', '#approve', function() {
    var id = $(this).attr('act');
    var dis = $(this)
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
         
        $.ajax({
            type: 'POST',
            url: '/APS/ajax/resched',
            data: {
                activityID: id,
                status: 3,
                comment:null
            },

            success: function(data) {
                if(data.status){
                    console.log(data)
                    swal("Success!", "", "success").then(function(){
                        location.reload()
                    })
                    table.row(dis.parents('tr')).remove().draw()    
                }
                
            }
        });
    });
});

$(document).on('click', '#deny', function() {
    var id = $(this).attr('act');
    var dis = $(this)
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
        confirmButtonText: "Reject",
        cancelButtonText: "Cancel",
        // preConfirm: function(data) {
        //     console.log(data);
        //     console.log("DATA");
        //     return new Promise(function(resolve, reject) {
        //         setTimeout(function() {
        //             if (data === 'taken@example.com') {
        //                 reject('This email is already taken.')
        //             } else {
        //                 resolve()
        //             }
        //         }, 2000)
        //     })
        // }
        
    }).then(function() {
        var comment = $("#reject-comment").val()

        $.ajax({
            type: 'POST',
            url: '/APS/ajax/resched',
            data: {
                activityID: id,
                comment:comment,
                status: 3
            },
            success: function(data) {
                 swal("Success!", "", "success").then(function(){
                    location.reload()
                })
                table.row(dis.parents('tr')).remove().draw()
            }
        });
    });
});
