   
$(document).bind('tooltipTrigger',function(){
    console.log('Na trigger');
    $('[data-toggle="tooltip"]').tooltip();
});


$(document).trigger("test");
//GREEN
// $.toast({
//             heading: 'Welcome to my Elite admin',
//             text: 'Use the predefined ones, or specify a custom position object.',
//             position: 'top-right',
//             loaderBg:'#ff6849',
//             icon: 'success',
//             hideAfter: 3500
            
//           });
//RED
 // $(".tst4").click(function(){
 //           $.toast({
 //            heading: 'Welcome to my Elite admin',
 //            text: 'Use the predefined ones, or specify a custom position object.',
 //            position: 'top-right',
 //            loaderBg:'#ff6849',
 //            icon: 'error',
 //            hideAfter: 3500
            
 //          });

 //     });

$(document).ready(function(){
         

    // IMPORTANT
    $('a[data-toggle="tab"]').on( 'shown.bs.tab', function (e) {
        $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
    } );
    $("#home2").click();
   

    var table = $('#myTable').DataTable({
         
          "columns": [
            { "width": "35%" },
            { "width": "10%" },
            { "width": "30%" },
            { "width": "10%" },
            { "width": "10%" },
            { "width": "5%" },
          ]
    });
    var table2 = $('#myTable2').DataTable( {
         
          "columns": [
             { "width": "35%" },
            { "width": "10%" },
            { "width": "30%" },
            { "width": "10%" },
            { "width": "10%" },
            { "width": "5%" },
          ]
    });
    // table2.fnAdjustColumnSizing();
    // table.fnAdjustColumnSizing();

    $('a[data-toggle="tab"]').on('shown.bs.tab', function(e) {
        if(e.target.hash =="#profile"){
            console.log("asd");
           
        }
        // table2.fnAdjustColumnSizing();
        // table.fnAdjustColumnSizing();
    });


    $(document).on('click','.evaluate-activity', function(){
        console.log("evaluate-activity");
        var id = $(this).attr('activity-id');
        var vid = $(this).attr('venue-id');
        var d = $(this);
        var tr = $(this).closest("tr");
        var actName  = tr.find("td:nth-child(1)").html();
        var ven = tr.find("td:nth-child(3)").html();
        var date = tr.find("td:nth-child(4)").html();
        var time = (tr.find("td:nth-child(5)").html());
        var org = tr.find("td:nth-child(2)").html();
        console.log(tr.find("td:nth-child(1)").html());
        console.log(tr.find("td:nth-child(2)").html());
        console.log(tr.find("td:nth-child(3)").html());
        console.log(tr.find("td:nth-child(4)").text());
        // var actName = tr.
        $.ajax({
            type:'POST',
            url:'/AMT/getActivity',
            data:{id:id,vid:vid},
            success:function(data){
                if(parseInt(data)){
                    $('[data-toggle="tooltip"]').tooltip('hide');
                    table2.row(d.parents('tr')).remove().draw();


                    // $('.tooltip').hide();
                    // $('[data-toggle="tooltip"]').tooltip('hide');
                    var actions  =      '<a activity-id="'+id+'" href="/AMT/EvaluateActivity/'+id+'" data-toggle="tooltip" data-title="Evaluate Activity"> '+
                                            '<i  class="fa  fa-clipboard m-r-10 text-inverse "></i> '+
                                        '</a>'+                                   
                                         '<a activity-id="'+id+'"  venue-id="'+vid+'"  class="remove-activity"  data-toggle="tooltip" data-title="Remove from My Activity"> '+
                                            '<i  class="fa  fa-times m-r-10 text-inverse "></i> '+
                                        '</a>';
                    
                                        
                    var row = table.row.add( [
                                    actName,
                                    org,
                                    ven,
                                    date,
                                    time,
                                    actions                        
                                ]).draw().node();
                    $(row).find("td:last").addClass("text-center");
                    $(document).trigger("tooltipTrigger");
                    $.toast({
                        heading: 'Success!',
                        text: 'Successfully added to your My Activity.',
                        position: 'top-right',
                        loaderBg:'#ff6849',
                        icon: 'success',
                        hideAfter: 3500
                        
                      });
                }else{
                  $.toast({
                    heading: 'Failed!',
                    text: 'It seems like someone was able to get the activity first.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'error',
                    hideAfter: 3500
                    
                  });
                  $('[data-toggle="tooltip"]').tooltip('hide');
                    table2.row(d.parents('tr')).remove().draw();
                }
            }
        });
       
        
        

        // $('.tooltip').hide();
        // $('[data-toggle="tooltip"]').tooltip('hide');


    });
    $(document).on('click',' .remove-activity', function(){
        var tr = $(this).closest("tr");
         var actName  = tr.find("td:nth-child(1)").html();
        var ven = tr.find("td:nth-child(3)").html();
        var date = tr.find("td:nth-child(4)").html();
        var time = (tr.find("td:nth-child(5)").html());
        var org = tr.find("td:nth-child(2)").html();
        console.log("evaluate-activity");
        var d = $(this);
        var id = $(this).attr('activity-id');
        var vid = $(this).attr('venue-id');
        $.ajax({
            type:'POST',
            url:'/AMT/deleteActivity',
            data:{id:id},
            success:function(data){
                if(parseInt(data)){
                    $('[data-toggle="tooltip"]').tooltip('hide');
                    table.row(d.closest('tr')).remove().draw();

                    var actions  = '<a class="evaluate-activity"  activity-id="'+id+'" venue-id="'+vid+'"  data-toggle="tooltip" data-title="Get this Activity" >' +
                                        '<i  class="fa  fa-file m-r-10 text-inverse "></i> '+
                                    '</a>';
                    
                   
                    var row = table2.row.add( [
                                    actName,
                                    org,
                                    ven,
                                    date,
                                    time,
                                    actions                        
                                ]).draw().node();
                    $(row).find("td:last").addClass("text-center");
                    $(document).trigger("tooltipTrigger");
                    $.toast({
                        heading: 'Success!',
                        text: 'Successfully remove to your My Activity.',
                        position: 'top-right',
                        loaderBg:'#ff6849',
                        icon: 'success',
                        hideAfter: 3500
                        
                      });
                }else{
                    $.toast({
                    heading: 'Failed!',
                    text: 'There seems to be a problem.',
                    position: 'top-right',
                    loaderBg:'#ff6849',
                    icon: 'error',
                    hideAfter: 3500
                    
                  });
                  $('[data-toggle="tooltip"]').tooltip('hide');
                    table2.row(d.parents('tr')).remove().draw();
                }
            }
        });
        

       
     
        
       
       
        
        
    });
})
console.log("asd");   