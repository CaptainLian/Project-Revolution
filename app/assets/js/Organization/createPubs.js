 


 $("#file").on('change',function(){
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
	startDate:new Date(),
	dateFormat:'yyyy-mm-dd'
}).datepicker('update', new Date());
 $(document).on('change',"#file2",function(){
				    console.log("PUMASOK")
				    var filename = $(this).val().split('\\').pop();
				    $("#filename2").text(filename);
				});
$(document).on('submit','#form-pend',function(e){
	e.preventDefault();
	var formData = new FormData($(this)[0]);
	formData.append('_csrf',$('meta[data-name="csrf"]').attr("data-token"));
	var submit = new Promise(function (resolve, reject) {
								$.ajax({
									type:'POST',
									url:'/Organization/Publicity/Reupload',
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

});

$(".modal-desc").on('click',function(){
	var d = $(this)
	 new Promise(function (resolve, reject) {
								$.ajax({
									type:'POST',
									url:'/Organization/Publicity/modal',
									data:{id:d.attr("data-id"),type:1},									
									success:function(data){
										resolve(data);
									}
								});
			                   

			            }).then(data=>{
			            	console.log(data);
			            	var modal = $("#online-1").html(data);
			            	$("#online-1").modal('show');

							
			            })
});

$(".modal-reupload").on('click',function(){
	var d = $(this)
	 new Promise(function (resolve, reject) {
								$.ajax({
									type:'POST',
									url:'/Organization/Publicity/modal',
									data:{id:d.attr("data-id"),type:0},									
									success:function(data){
										resolve(data);
									}
								});
			                   

			            }).then(data=>{
			            	console.log(data);
			            	$("#online-1").html(data);
			            	$("#online-1").modal('show');
			            })
});



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