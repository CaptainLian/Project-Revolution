   
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
            { "width": "25%" },
            { "width": "20%" },
            { "width": "15%" },
            { "width": "5%" },
          ]
    });
    var table2 = $('#myTable2').DataTable( {
         
          "columns": [
            { "width": "35%" },
            { "width": "25%" },
            { "width": "20%" },
            { "width": "15%" },
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
        // $.ajax({
        //     type:'POST',
        //     url:'',
        //     data:id,
        //     success:function(data){

        //     }
        // });
        // $('.tooltip').hide();
        $('[data-toggle="tooltip"]').tooltip('hide');
        table2.row($(this).parents('tr')).remove().draw();


        // $('.tooltip').hide();
        // $('[data-toggle="tooltip"]').tooltip('hide');
        var actions  =      '<a activity-id="1" href="#" data-toggle="tooltip" data-title="Evaluate Activity"> '+
                                '<i  class="fa  fa-clipboard m-r-10 text-inverse "></i> '+
                            '</a>'+                                   
                             '<a activity-id="1" class="remove-activity"  data-toggle="tooltip" data-title="Remove from My Activity"> '+
                                '<i  class="fa  fa-times m-r-10 text-inverse "></i> '+
                            '</a>';
        
                            
        var row = table.row.add( [
                        "activityName",
                        "venue",
                        "date",
                        "time",
                        actions                        
                    ]).draw().node();
        $(row).find("td:last").addClass("text-center");
        $(document).trigger("tooltipTrigger");
        

        // $('.tooltip').hide();
        // $('[data-toggle="tooltip"]').tooltip('hide');


    });
    $(document).on('click',' .remove-activity', function(){
        console.log("evaluate-activity");
        var id = $(this).attr('activity-id');
        // $.ajax({
        //     type:'POST',
        //     url:'',
        //     data:id,
        //     success:function(data){
                
        //     }
        // });

       
     
        // $('.tooltip').hide();
        $('[data-toggle="tooltip"]').tooltip('hide');
        table.row($(this).closest('tr')).remove().draw();

        var actions  = '<a class="evaluate-activity"  activity-id="1" data-toggle="tooltip" data-title="Get this Activity" >' +
                            '<i  class="fa  fa-file m-r-10 text-inverse "></i> '+
                        '</a>';
        
        // $('.tooltip').hide();
        // table.find(".tooltip").hide();
        // table2.find(".tooltip").hide();
        var row = table2.row.add( [
                        "activityName",
                        "venue",
                        "date",
                        "time",
                        actions                        
                    ]).draw().node();
        $(row).find("td:last").addClass("text-center");
        $(document).trigger("tooltipTrigger");
        // $('.tooltip').hide();
        // $('[data-toggle="tooltip"]').tooltip('hide');
        
        
    });
})
console.log("asd");   