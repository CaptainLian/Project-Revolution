   $("select").select2();
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


	    	$("#edit-lastName").val('');
	    	$("#edit-middleName").val('');
	    	$("#edit-givenName").val('');

	    	$("#edit-idNumber").val('');
	    	$("#edit-inputEmail3").val('');
	    	$("#edit-basic-addon1").val('');
	    
	    }
	    function edit(data){

	    }
	    var table = $('#myTable').DataTable( {
	            dom: 'Bfrtip',
	            buttons: [
	                {
	                    text: 'Add Account',
	                    action: function ( e, dt, node, config ) {
	                        $("#largeModal").modal('show');
	                    }
	                },
	                // {
	                //     text: 'Position',
	                //     action: function ( e, dt, node, config ) {
	                //         $("#position-modal").modal('show');
	                //     }
	                // }
	            ]
	        } );
	    $("#submit").click(function(){
            console.log("asd");
	    	var lastName = $("#lastName").val();
	    	var middleName = $("#middleName").val();
	    	var givenName = $("#givenName").val();

	    	var idNumber = $("#idNumber").val();
	    	var email  = $("#inputEmail3").val();
	    	var number = $("#basic-addon1").val();

	    	
	    	$.ajax({
	    		type: 'POST',
	    		url:'#',
	    		data:{
	    			lastName:lastName,
	    			middleName: middleName,
	    			givenName: givenName ,
	    			idNumber: idNumber,
	    			email:email,
	    			number:number
	    		},
	    		success:function(data){
	    			$("#largeModal").modal("hide");
	    			//data > 0
	    			if(1){
	    				var com = givenName + ' ' + middleName +' '+ lastName;
	    				$("#name").val(com);
	    				
	    				$("#right").fadeIn("fast").delay(5000).fadeOut("slow");    
	    				
				    	var actions  =      '<a  data-toggle="tooltip" data-original-title="Edit"> '+
				                                '<i  class="fa fa-pencil text-inverse m-r-10"></i> '+
				                            '</a>'+
				                            '<a class="remove"  data-toggle="tooltip" data-original-title="Remove"> '+
				                                '<i class="fa fa-trash-o text-danger"></i> '+
				                            '</a>';
				    	
				                	
						var row = table.row.add( [
				                		idNumber,
				                		email,
				                        com,
				                		"+639"+number,
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
	    var editNode;
	    $("table").on("click",'tbody td a i.fa-pencil',function(){
	    	var node = table.row($(this).closest("tr")).data();
	    	editNode = $(this).closest("tr");
	    	console.log(node);
	    	$("#editModal").modal("show");	
	    	//get DATA
	    	$.ajax({
	    		type:'POST',
	    		url:'',
	    		data:node[0],
	    		success:function(data){
	    			$("#edit-lastName").val();
			    	$("#edit-middleName").val();
			    	$("#edit-givenName").val();

			    	$("#edit-idNumber").val();
			    	$("#edit-inputEmail3").val();
			    	$("#edit-basic-addon1").val();
			    	$("#edit").modal("show");
	    		}
	    	});
	    	
	    

	    });
   		$("table").on("click",'tbody td a i.fa-trash-o',function(){
   			var id = table.row($(this).closest("tr")).data()[0];
   			var row = $(this).closest("tr");
   			//remove
	    	$.ajax({
	    		type:'POST',
	    		url:'',
	    		data:id,
	    		success:function(data){
	    			if(1){
	    				table.row(row).remove().draw();
	    			}else{
	    				
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

	    	$.ajax({
	    		type: 'POST',
	    		url:'#',
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
						
						$("#right").fadeIn("fast").delay(5000).fadeOut("slow");    
						
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