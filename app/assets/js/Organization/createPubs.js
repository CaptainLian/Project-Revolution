 $("#file").change(function(){
    console.log("PUMASOK")
    var filename = $(this).val().split('\\').pop();
    $("#filename").text(filename);
});
$("input[type='radio']").change(function(){
	$("div#pubMat").toggle();
	console.log("asd");
})

$("#file").val("");


$('.mydatepicker, #datepicker').datepicker({
	"setDate": new Date(),
	startDate:new Date()
}).datepicker('update', new Date());

function empty(){
	$("#filename").val("");
	$("#title").val("");
	$("#online").prop('checked',true);
	$("select").val("0");
	$(".mydatepicker").datepicker('update', new Date())
	$("#file").val("");
} 
$("form").submit(function(e){
	console.log("ASD");
var formData = new FormData($(this)[0]);
  	// formDataSerialized.append('name',"asd");
  	
	e.preventDefault();
	
	
	var submit = new Promise(function (resolve, reject) {
								$.ajax({
									type:'POST',
									url:'/Organization/Publicity/Insert',
									data:formData,
									processData: false,
									contentType: false,
									cache: false,
									enctype: 'multipart/form-data',
									success:function(data){
										if(data.status){
											resolve()
										}else{
											reject()
										}
									}
								});
			                   

			            }).then(data=>{
			            	$("#addModal").modal('hide');
			            	  $.toast({
					            heading: 'Successfully added!',
					            text: 'The pubs was sent for approval',
					            position: 'top-right',
					            loaderBg:'#ff6849',
					            icon: 'success',
					            hideAfter: 3500, 
					            stack: 6
					          });
			            })

	empty();
})