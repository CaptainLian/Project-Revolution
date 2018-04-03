(function() {

    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

})();
$("#myTable3").DataTable();
$("#approve").click(function(){
    swal({
      title: 'Warning',
      text: "Once you submit this you all finance transaction for this activity will be canceled, and you can no longer add finance transaction for this activity",
      type: 'warning',
      showCancelButton: true,
      reverseButtons:false,
      confirmButtonColor: '#00C292',
      
      confirmButtonText: 'Submit'
    }).then(function (result) {
        
      if (result) {
            $.ajax({
                type:'POST',
                url:'/ADM/Activity/Save',
                data:{status:4,gosmid:$("input#gosmid").val()},
                success:function(data){
                    if(data){
                        swal("Success!", "", "success").then(function(){
                            window.location.href='/ADM/Activity/List';
                        })
                        
                    }
                }
           })
      }
    })
});
$("#defer").click(function(){
    var question = '<div class="row">'+
    '<div class="col-md-12 text-left m-b-20">'+
    '<br/>Select the sections that should be changed, then explain why.<br/>'+
    '</div>'+
    '<div class="form-group col-md-12">'+
    '<label class="col-md-12 text-left"><strong>Sections to be Edited:</strong></label>'+
    '<div class="col-md-12">'+
    '<select class="col-md-12" multiple="" id="select-sec">'+
    '<option value="1">I. How objectives were met</option>'+
    '<option value="2">II. Learnings</option>'+
    '<option value="3">III. General Attendace Sheet</option>'+
    '<option value="4">IV. Event Pictures </option>'+ 
    '</select>'+
    '</div>'+

    '</div>'+
    '<div class="form-group col-md-12">'+
    '<label class="col-md-12 text-left"><strong>Explanation</strong></label>'+
    '<div class="col-md-12">'+
    '<textarea class="form-control" rows="5"></textarea>'+
    '</div>'+
    '</div>'+
    '</div>';


    swal({   
        title: "Pend",   
        text:"Select the sections that should be change, then explain why.",
        html:question,
        focusConfirm:false,
        focusCancel:false,
        showLoaderOnConfirm: true,
        reverseButtons:false,
        allowOutsideClick: false,
        preConfirm: function (data) {
            console.log($("#select-sec").val());
            console.log("DATA");
            return new Promise(function (resolve, reject) {
                setTimeout(function() {
                    if (data === 'taken@example.com') {
                        reject('This email is already taken.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        },
        onOpen:function(ele){
            $(ele).find("select").select2();
            console.log("INIT SELECT");
        },

        showCancelButton: true,   
        confirmButtonColor: "#FEC107",   
        confirmButtonText: "Pend",   
        cancelButtonText: "Cancel",   

    }).then(function(data){
       console.log($("#select-sec").val());
       var sections = $("#select-sec").val();
       console.log("sections")
       console.log(sections)
       if(data){
            $.ajax({
                type:'POST',
                url:'/ADM/Activity/Save',
                data:{sections:sections,comment:$("textarea").val(),status:5,gosmid:$("input#gosmid").val()},
                success:function(data){
                    if(data){
                        swal("Success!", "", "success").then(function(){
                            window.location.href='/ADM/Activity/List';
                        })
                    }
                }
           })
       }

       console.log(data)
      

    });
});

$("#reject").click(function(){
    var question = '<div class="row">'+
    '<div class="col-md-12 text-left  m-b-20" style="padding-left:16px">'+
    '<br/>State the reason for rejection.<br/>'+
    '</div>'+

    '<div class="form-group col-md-12">'+

    '<div class="col-md-12">'+
    '<textarea class="form-control" rows="5"></textarea>'+
    '</div>'+
    '</div>'+
    '</div>';
    swal({   
        title: "Reject",   

        html:question,
        showLoaderOnConfirm: true,
        focusConfirm:false,
        focusCancel:false,
        reverseButtons:true,
        allowOutsideClick: false,
        showCancelButton: true,   
        confirmButtonColor: "#FB9678",   
        confirmButtonText: "Submit",   
        cancelButtonText: "Cancel",
        preConfirm: function (email) {
            return new Promise(function (resolve, reject) {
                setTimeout(function() {
                    if (email === 'taken@example.com') {
                        reject('This email is already taken.')
                    } else {
                        resolve()
                    }
                }, 2000)
            })
        } 

    }).then(function(data){
        console.log(data);
        console.log("REJECT");
        $("html, body").animate({ scrollTop: 0 },function(){
            $('#doc').removeClass("rotateOutUpLeft animated").addClass("rotateOutUpLeft   animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
                $(this).removeClass("rotateOutUpLeft animated");
            });
        });


    });

});