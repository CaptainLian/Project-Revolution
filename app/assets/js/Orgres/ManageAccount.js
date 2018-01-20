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

		$("#add-org-row,#edit-org-row").css('display','none');
		$("#acc-type,#edit-acc-type").change(function(){
			console.log("BEFORe PUMASOK")
			console.log($(this).select2('val'))
			
			if($(this).select2('val')[0] == 1 ){
				console.log("PUMASOK")
				$("#add-org-row,#edit-org-row").css('display','');			
			}else{
				$("#add-org-row,#edit-org-row").css('display','none');			
			}
		})
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
 			$("#account-help").css("display",'none')
	    	$("#pos-help").css("display",'none')
	    	$("#edit-account-help").css("display",'none')
	    	$("#edit-pos-help").css("display",'none')

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
	    	var valid =true;
	    	if($("#acc-type").select2('val') == ''){
	    		valid = false;
	    		$("#account-help").css("display",'')
	    	}
	    	if($("#acc-type").select2('val')[0] == '1'){
	    		if($("#add-personInCharge").select2('val') == ''){
	    				valid = false;
	    				$("#pos-help").css("display",'')
	    		}
	    	}
            console.log("asd");
	    	var lastName = $("#lastName").val();
	    	var middleName = $("#middleName").val();
	    	var givenName = $("#givenName").val();

	    	var idNumber = $("#idNumber").val();
	    	var email  = $("#inputEmail3").val();
	    	var number = $("#basic-addon1").val();
	    	var orgpos = $("#add-personInCharge").select2("val");
	    	var accType = $("#acc-type").select2("val");
	    	if(valid){
	    		$("#account-help").css("display",'none')
	    		$("#pos-help").css("display",'none')
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
		    			if(data.status){
		    				var first = "<td>"+idNumber+"</td>";

		    				var orgpos = $("#add-personInCharge").select2("data");
		    				var accType = $("#acc-type").select2("data");
		    				var accTypeVal = $("#acc-type").select2("val");
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
					                            '</a>';
					        
					        var active = '<span class="label label-success">Active</span>';	
					        
					        
					    	var pos = '<p></p>'
					        if(accTypeVal[0] ==1){
					    		for (ctr = 0; ctr < orgpos.length; ctr++) {
					        		pos += "<p>"+orgpos[ctr].text+"</p>"
					        	}	
					    	}else{
					    		pos += "<p>"+accType[0].text+"</p>"
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
		    				   $.toast({
					            heading: 'Failed!',
					            text: 'Account not added.',
					            position: 'top-right',
					            loaderBg:'#ff6849',
					            icon: 'error',
					            hideAfter: 3500
					            
					          });
		    				
		    			}
		    			

		    			
		    		}
		    	});	    
	    	}else{

	    	}	
	    });

	    var editNode, showNode;
	    $("table").on("click",'tbody td a i.fa-pencil',function(){
	    	var id = $(this).closest("tr").find("td:first").text();
	    	if($(this).closest("tr").hasClass('footable-detail-show')){
	    		editNode = $(this).closest("tr")
	    		showNode = $(this).closest("tr").next('tr')
	    	}else{
	    		editNode = $(this).closest("tr")
	    		showNode = 1
	    	}
	    	
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
				    	$("#edit-givenName").val(data.details.firstname);

				    	$("#edit-idNumber").val(data.details.idnumber);
				    	$("#edit-inputEmail3").val(data.details.email);
				    	$("#edit-basic-addon1").val(data.details.contactnumber);
				    	console.log("POSITIONS")
				    	console.log(data.position)
				    	$("#edit-personInCharge").select2("val",data.position);
				    	$("#edit-acc-type").select2("val",data.details.id);
				    	if(data.details.id != 1){
				    		$("#add-org-row,#edit-org-row").css('display','none');
				    	}else{
				    		$("#add-org-row,#edit-org-row").css('display','');
				    	}
				    	$("#edit").modal("show");
				    	$("#editModal").modal("show");	
				    	$("input[value='"+data.details.status+"']").prop("checked",true)
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
   			var dis = $(this).closest("tr")
   			//remove
	    	$.ajax({
	    		type:'POST',
	    		url:'/ORGRES/AJAX/DeleteAccount',
	    		data:{id:id},
	    		success:function(data){
	    			if(data.status){
	    				 
	    				
	    				 $.toast({
				            heading: 'Success!',
				            text: 'Successfully deleted the account.',
				            position: 'top-right',
				            loaderBg:'#ff6849',
				            icon: 'success',
				            hideAfter: 3500, 
				            stack: 6
				          });
	    				 dis.remove();
	    				$("#myTable").trigger('footable_initialize');
	    			}else{
	    				  $.toast({
				            heading: 'Failed!',
				            text: 'Account cannot be deleted',
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
	    	var valid =true;
	    	if($("#edit-acc-type").select2('val') == ''){
	    		valid = false;
	    		$("#edit-account-help").css("display",'')
	    	}
	    	if($("#edit-acc-type").select2('val')[0] == '1'){
	    		if($("#edit-personInCharge").select2('val') == ''){
	    				valid = false;
	    				$("#edit-pos-help").css("display",'')
	    		}
	    	}
    		var lastName = $("#edit-lastName").val();
	    	var middleName = $("#edit-middleName").val();
	    	var givenName = $("#edit-givenName").val();

	    	var idNumber = $("#edit-idNumber").val();
	    	var email  = $("#edit-inputEmail3").val();
	    	var number = $("#edit-basic-addon1").val();
	    	var orgpos = $("#edit-personInCharge").select2("val");;
	    	var accType = $("#edit-acc-type").select2("val");;

	    	var status2 = $("input[name='optionsRadios2']:checked").val();
	    	if(valid){
	    		$.ajax({
		    		type: 'POST',
		    		url:'/ORGRES/AJAX/UpdateAccount',
		    		data:{
		    			id:idNumber,
		    			lastName:lastName,
		    			middleName: middleName,
		    			givenName: givenName ,
		    			email:email,
		    			number:number,
		    			orgpos:orgpos,
		    			accType:accType[0],
		    			status:status2
		    		},
		    		success:function(data){
		    			$("#editModal").modal("hide");
						//data > 0
						if(data.status){

						 	console.log("STATUS")
						 	console.log(status2)
							var first = "<td>"+idNumber+"</td>";

		    				var orgpos = $("#edit-personInCharge").select2("data");
		    				var accType = $("#edit-acc-type").select2("data");
		    				var accTypeVal = $("#edit-acc-type").select2("val");
		    				var com = givenName + ' ' + middleName +' '+ lastName;
		    				var second = "<td>"+com+"</td>";
		    				 
		    				
		    				 $.toast({
					            heading: 'Success!',
					            text: 'Successfully edited the account of '+com,
					            position: 'top-right',
					            loaderBg:'#ff6849',
					            icon: 'success',
					            hideAfter: 3500, 
					            stack: 6
					          });
		    				editNode.remove()
		    				if(showNode != 1){
		    					showNode.remove()	
		    				}
		    				
					    	var actions  =      '<a  data-toggle="tooltip" data-original-title="Edit"> '+
					                                '<i  class="fa fa-pencil text-inverse m-r-10"></i> '+
					                            '</a>';
					        if(status2 == 1){
					        	var active = '<span class="label label-success">Active</span>';	
					        }else{
					        	var active = '<span class="label label-warning">Inactive</span>';	
					        }
					        
					    	var pos = '<p></p>'
					    	if(accTypeVal[0] ==1){
					    		for (var ctr = 0; ctr < orgpos.length; ctr++) {
					        		pos += "<p>"+orgpos[ctr].text+"</p>"
					        	}	
					    	}else{
					    		pos += "<p>"+accType[0].text+"</p>"
					    	}
					        
					        
					        console.log("PUMASOK SA EDIT SUBMIT")
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

						}else{
							  $.toast({
					            heading: 'Failed!',
					            text: 'Something wrong happened.',
					            position: 'top-right',
					            loaderBg:'#ff6849',
					            icon: 'error',
					            hideAfter: 3500
					            
					          });
		    			}
		    			

		    			
		    		}
		    	});
	    	}else{

	    	}    

	    		
	    });


	    $('#largeModal, #editModal').on('hidden.bs.modal', function () {
		   clear();
		})