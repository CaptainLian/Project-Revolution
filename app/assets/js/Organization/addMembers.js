$("#myTable").DataTable();
$("#name").focusout(function(event) {
   val = $(this).val()
   if(val == null){
        $('#fullnamesmall').show();
   }else{
        $('#fullnamesmall').hide();
   }
});
$("#idnumber").focusout(function(event) {
   val = $(this).val()
   if(val == null){
        $('#idnumber').show();
   }else{
        $('#idnumber').hide();
   }
});
$("#addtolist").click(function(event) {
    var idnum = $("#idnumber").val()
    var name = $("#name").val()
    //validation
    if(idnum==null || name ==null){
        $('#addtolist').attr('disabled', 'disabled');
        if(idnum==null){
            $('#idnumbersmall').show();
        }
        if(name==null){
            
        }

    }else{
        $('#idnumbersmall').hide();
        $('#fullnamesmall').hide();
        var add = "<tr>"+
                    "<td>"+name+"</td>"+
                    "<td>"+idnum+"</td>"+
                    '<td><i class="fa fa-pencil m-r-10" data-toggle="tooltip" data-original-title="edit"></i><i class="fa fa-times text-danger m-r-10" data-toggle="tooltip" data-original-title="delete"></i></td>'+
                +'</tr>'
        $('tbody').append(add);
    }
    
});
$(".fa-times").click(function(event) {
    console.log('fatimes')
    $('tbody').remove().closest('tr');
});
$(".fa-pencil").click(function(event) {
    console.log('fapencil')
});

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
            url: '',
            data: {
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