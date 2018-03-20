var table = $("#myTable").DataTable();

$("input").change(function(){
    console.log("ASDASd")

    if($.trim($("#name").val().length) > 0 && $.trim($("#idnumber").val().length) == 8){
        $("#addtolist").removeAttr("disabled")
    }
})


$("#addtolist").click(function(event) {
    var idnum = $("#idnumber").val()
    var name = $("#name").val()
    var td = '<td><i class="fa fa-trash text-danger m-r-10" idnum='+idnum+' data-toggle="tooltip" data-original-title="delete"></i></td>'

   $.ajax({
        type: 'POST',
        url: '/Organization/AJAX/addMember',
        data: {
            idnumber:idnum,
            name:name
        },

        success: function(data) {
           
            if(data.status){
                $.toast({
                      heading: 'Success!',          
                      
                      position: 'top-right',
                      loaderBg:'#ff6849',
                      icon: 'success',
                      bgColor:'#00C292',
                      hideAfter: 3500, 
                      stack: 6
                    });

                  table.row.add([
                    idnum,
                    name,
                    td
                    ]).draw()
            }else{
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
            $("#name").val("") 
            $("#idnumber").val("") 
            $("input").trigger("change")
            $("#addtolist").attr("disabled","");

        }
    });

  
   
});

$(document).on('click','table tbody tr td .fa-trash',function(event) {
        console.log('fatimes')
         var dis =$(this)
        var idnum = $(this).attr("idnum");
         $.ajax({
            type: 'POST',
                url: '/Organization/AJAX/deleteMember',
                data: {
                    idnumber:idnum
                },

                success: function(data) {
                    if(data.status){
                        $.toast({
                              heading: 'Success!',          
                              
                              position: 'top-right',
                              loaderBg:'#ff6849',
                              icon: 'success',
                              bgColor:'#00C292',
                              hideAfter: 3500, 
                              stack: 6
                            });

                          
                            table.row(dis.closest("tr")).remove().draw()
                    }else{
                         $.toast({
                              heading: 'Failed!',          
                              text:'Member already added.',
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
        // table.row($(this).closest("tr")).remove().draw()

    });



 