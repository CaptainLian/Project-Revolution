$(document).ready(function() {
		$("#acc-type").select2({
			maximumSelectionSize: 1,
			placeholder: "Student"
	   	});
		$("#edit-acc-type").select2({
			maximumSelectionSize: 1,
			placeholder: "Student"
	   });

		
});

		// $("#add-personInCharge, #edit-personInCharge").css('visibility','hidden');
		// $("#acc-type,#edit-acc-type").change(function(){
		// 	console.log("BEFORe PUMASOK")
		// 	console.log($(this).select2('val'))
			
		// 	if($(this).select2('val') == 1 ){
		// 		console.log("PUMASOK")
		// 		$("#add-personInCharge, #edit-personInCharge").css('visibility','visible');
		// 		// $("#acc-type").select2({
		// 		// 	maximumSelectionSize: 1,
		// 		// 	placeholder: "Student"
		// 	 //   	});
		// 		// $("#edit-acc-type").select2({
		// 		// 	maximumSelectionSize: 1,
		// 		// 	placeholder: "Student"
		// 	 //   });
		// 	}
		// })
		// var padding = ($(".form-inline").width() - $(".form-inline .row").width() - 130) + 'px';
		// $("#pad").css("padding-left",padding)
		// FOOTABLE

		$('#myTable').footable();
		$('#myTable').change(function (e) {
			e.preventDefault();
			var pageSize = $(this).val();
			$('#demo-foo-pagination').data('page-size', pageSize);
			$('#demo-foo-pagination').trigger('footable_initialized');
		});
		$('#demo-input-search2').on('input', function (e) {
			e.preventDefault();
			addrow.trigger('footable_filter', {filter: $(this).val()});
		});
		var addrow = $('#myTable');
		addrow.footable().on('click', '.delete-row-btn', function() {

			//get the footable object
			var footable = addrow.data('footable');

			//get the row we are wanting to delete
			var row = $(this).parents('tr:first');

			//delete the row
			footable.removeRow(row);
		});
		// END OF FOOTABLE



	   $("#add-personInCharge").select2({
	   	 placeholder: "LSCS - President"
	   });

	   $("#edit-personInCharge").select2({
	   	 placeholder: "LSCS - President"
	   });
        $("#sub-pos").click(function(){
            var json = ($("#nestable").nestable('serialize'));
            $.ajax({
                type:'POST',
                url:'',
                data:{ pos:json},
                success: function(data){

                }
            })
        });
        var nest = $('#nestable').nestable({
          

        });
        $('.dd span.remove-pos').on('mousedown', function (event) {
          event.preventDefault(); return false; 
        });
        $(document).on('click','span.remove-pos',function(){
            
            $(this).closest('li').remove();
            console.log("Na click");
        });

        $("#pos").keypress(function(e){
            if(e.which == 13){
                $("#add-position").trigger('click');
            }
        });
        $("#add-position").click(function(){

            var value  = $("#pos").val();
            // console.log("ASD");1
            // $('#nestable').nestable('add', {"id":value});   
            console.log("VALUE   - - "+value);
            var item = '<li class="dd-item" data-id="'+ value +'">'+
                            '<div class="dd-handle">'+ value +' <span class="remove-pos fa fa-times" style="float: right"></span> </div>'+
                        '</li>';
            $("#pos").val('');
            $("#nestable").append(item);
            $('.dd span.remove-pos').on('mousedown', function (event) {
              event.preventDefault(); return false; 
            });
            $(document).on('click','span.remove-pos',function(){
                
                $(this).closest('li').remove();
                console.log("Na click");
            });
                
        });
        
            
        
        
      



 function clear(){
	    	$("#lastName").val('');
	    	$("#middleName").val('');
	    	$("#givenName").val('');

	    	$("#idNumber").val('');
	    	$("#inputEmail3").val('');
	    	$("#basic-addon1").val('');
	    	$("select").select2("val",'');

	    	$("#edit-lastName").val('');
	    	$("#edit-middleName").val('');
	    	$("#edit-givenName").val('');

	    	$("#edit-idNumber").val('');
	    	$("#edit-inputEmail3").val('');
	    	$("#edit-basic-addon1").val('');
	    	
	    
	    }
	    function edit(data){

	    }
	    $("#demo-btn-addrow").click(function(){
	    	$("#largeModal").modal('show');
	    })
	    // var table = $('#myTable').DataTable( {
	    //         dom: 'Bfrtip',
	    //         buttons: [
	    //             {
	    //                 text: 'Add Account',
	    //                 action: function ( e, dt, node, config ) {
	    //                     $("#largeModal").modal('show');
	    //                 }
	    //             },
	    //             // {
	    //             //     text: 'Position',
	    //             //     action: function ( e, dt, node, config ) {
	    //             //         $("#position-modal").modal('show');
	    //             //     }
	    //             // }
	    //         ]
	    //     } );
	    $("#submit").click(function(){
            console.log("asd");
	    	var lastName = $("#lastName").val();
	    	var middleName = $("#middleName").val();
	    	var givenName = $("#givenName").val();

	    	var idNumber = $("#idNumber").val();
	    	var email  = $("#inputEmail3").val();
	    	var number = $("#basic-addon1").val();
	    	var orgpos = $("#add-personInCharge").select2("val");
	    	var accType = $("#acc-type").select2("val");;
	    	$.ajax({
	    		type: 'POST',
	    		url:'/ORGRES/AJAX/SaveAccount',
	    		data:{
	    			lastName:lastName,
	    			middleName: middleName,
	    			givenName: givenName ,
	    			idNumber: idNumber,
	    			email:email,
	    			number:number,
	    			orgpos: orgpos,
	    			accType:accType
	    		},
	    		success:function(data){
	    			$("#largeModal").modal("hide");
	    			//data > 0
	    			if(1){
	    				var first = "<td>"+idNumber+"</td>";

	    				var orgpos = $("#add-personInCharge").select2("data");
	    				var com = givenName + ' ' + middleName +' '+ lastName;
	    				var second = "<td>"+com+"</td>";
	    				$("#name").val(com);
	    				
	    				 $.toast({
				            heading: 'Success!',
				            text: 'Successfully Added the account of '+com,
				            position: 'top-right',
				            loaderBg:'#ff6849',
				            icon: 'success',
				            hideAfter: 3500, 
				            stack: 6
				          });
	    				
				    	var actions  =      '<a  data-toggle="tooltip" data-original-title="Edit"> '+
				                                '<i  class="fa fa-pencil text-inverse m-r-10"></i> '+
				                            '</a>'+
				                            '<a class="remove"  data-toggle="tooltip" data-original-title="Remove"> '+
				                                '<i class="fa fa-trash-o text-danger"></i> '+
				                            '</a>';
				        var active = '<span class="label label-success">Active</span>';
				    	var pos = '<p></p>'
				        for (ctr = 0; ctr < orgpos.length; ctr++) {
				        	pos += "<p>"+orgpos[ctr].text+"</p>"
				        }
				        var third = "<td>"+pos+"</td>";
				        var fourth = "<td>"+active+"</td>";
				        var fifth = "<td>"+actions+"</td>";
						// var row = table.row.add( [
				  //               		idNumber,
				  //               		com,
				  //                       pos,
				  //               		active,
				  //                   	actions                        
				  //               	]).draw().node();
				  		var newRow = "<tr class='text-center'>"+first+second+third+fourth+fifth+"</tr>";
						var footable = addrow.data('footable');
						$("#myTable").append(newRow);
						$("#myTable").trigger('footable_initialize');

						clear();
						// $(row).addClass("text-center");



	    			}else{
	    				$("#wrong").fadeIn("fast").delay(5000).fadeOut("slow");    
	    			}
	    			

	    			
	    		}
	    	});	    
	    		


	    	  
	    });
	    var editNode;
	    $("table").on("click",'tbody td a i.fa-pencil',function(){
	    	var id = $(this).closest("tr").find("td:first").text();

	    	// $("#editModal").modal("show");	
	    	//get DATA
	    	$.ajax({
	    		type:'POST',
	    		url:'/ORGRES/AJAX/getSpecificAccount',
	    		data:{idNumber:id},
	    		success:function(data){
	    			if(data.status){
	    				
	    				$("#edit-lastName").val(data.details.lastname);
				    	$("#edit-middleName").val(data.details.middlename);
				    	$("#edit-givenName").val(data.details.givenname);

				    	$("#edit-idNumber").val(data.details.idnumber);
				    	$("#edit-inputEmail3").val(data.details.email);
				    	$("#edit-basic-addon1").val(data.details.contactnumber);
				    	console.log("POSITIONS")
				    	console.log(data.position)
				    	$("#edit-personInCharge").select2("val",data.position);
				    	$("#edit-acc-type").select2("val",data.details.id);
				    	$("#edit").modal("show");
				    	$("#editModal").modal("show");	
	    				// table.row(thisNode).remove();
	    			}else{

	    			}
	    			

	    		}
	    	});
	    	
	    

	    });
   		$("table").on("click",'tbody td a i.fa-trash-o',function(){
   			// var id = table.row($(this).closest("tr")).data()[0];
   			// var row = $(this).closest("tr");
   			var id = $(this).closest("tr").find("td:first").text();
   			console.log($(this).closest("tr").find("td:first").text());
   			// $("#myTable").footable().data('footable').removeRow($(this).closest("tr"));
   			//remove
	    	$.ajax({
	    		type:'POST',
	    		url:'/ORGRES/AJAX/DeleteAccount',
	    		data:{id:id},
	    		success:function(data){
	    			if(1){
	    				 
	    				$("#myTable").footable().data('footable').removeRow($(this).closest("tr"));

	    				 $.toast({
				            heading: 'Success!',
				            text: 'Successfully deleted the account.',
				            position: 'top-right',
				            loaderBg:'#ff6849',
				            icon: 'success',
				            hideAfter: 3500, 
				            stack: 6
				          });
	    			}else{
	    				  $.toast({
				            heading: 'Failed!',
				            text: 'Something wrong happen.',
				            position: 'top-right',
				            loaderBg:'#ff6849',
				            icon: 'error',
				            hideAfter: 3500
				            
				          });
	    			}
	    		}
	    	});
	    });

	    $("#edit-submit").click(function(){
    		var lastName = $("#edit-lastName").val();
	    	var middleName = $("#edit-middleName").val();
	    	var givenName = $("#edit-givenName").val();

	    	var idNumber = $("#edit-idNumber").val();
	    	var email  = $("#edit-inputEmail3").val();
	    	var number = $("#edit-basic-addon1").val();
	    	var orgpos = $("#edit-personInCharge").select2("val");;
	    	var accType = $("#acc-type").select2("val");;


	    	$.ajax({
	    		type: 'POST',
	    		url:'/ORGRES/AJAX/EditAccount',
	    		data:{
	    			lastName:lastName,
	    			middleName: middleName,
	    			givenName: givenName ,
	    			idNumber: idNumber,
	    			email:email,
	    			number:number
	    		},
	    		success:function(data){
	    			$("#editModal").modal("hide");
					//data > 0
					if(1){
						var com = givenName + ' ' + middleName +' '+ lastName;
						$("#name").val(com);
						
						 $.toast({
				            heading: 'Success!',
				            text: 'Successfully edited account of '+com,
				            position: 'top-right',
				            loaderBg:'#ff6849',
				            icon: 'success',
				            hideAfter: 3500, 
				            stack: 6
				          });
						
				    	var actions  =      '<a  data-toggle="tooltip" data-original-title="Edit"> '+
				                                '<i  class="fa fa-pencil text-inverse m-r-10"></i> '+
				                            '</a>'+
				                            '<a class="remove"  data-toggle="tooltip" data-original-title="Remove"> '+
				                                '<i class="fa fa-trash-o text-danger"></i> '+
				                            '</a>';
				    	
				        table.row(editNode).remove().draw();
						var row = table.row.add( [
				                		idNumber,
				                		email,
				                        com,
				                		number,
				                    	actions                        
				                	]).draw().node();
						clear();
						$(row).find("td:last").addClass("text-center");


					}else{
						$("#wrong").fadeIn("fast").delay(5000).fadeOut("slow");    
	    			}
	    			

	    			
	    		}
	    	});	    

	    		
	    });


	    $('#largeModal, #editModal').on('hidden.bs.modal', function () {
		   clear();
		})