

var objReupload;

function addRibbon(pub,stat){
   if(stat == 1){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-success").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-check-circle");
   }
   else if(stat == 2){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-warning").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-pause-circle");
   } 
   else if(stat == 3){
     pub.closest(".el-card-item").find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").addClass("ribbon-danger").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      .addClass("fa").addClass("fa-times-circle");
   }else if(stat == 0){
     pub.find(".ribbon").removeClass("ribbon-warning")
                      .removeClass("ribbon-success").removeClass("ribbon-danger").find("i")
                      .removeClass("fa-check-circle").removeClass("fa-pause-circle").removeClass("fa-times-circle")
                      
   }
}

 $("#file").on('change',function(){
    console.log("PUMASOK")
    var filename = $(this).val().split('\\').pop();
    $("#filename").text(filename);
});

$("input[type='radio'][name='optionsRadios2']").change(function(){
	$("#pubMat").toggle();
	$("#publication").toggle();
	console.log("asd");
})

// $(".ModeDist").change(function(){
// 	$("div#pubMat").toggle();
// 	console.log("asd");
// })
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
	var formData = new FormData($(this)[0]);
	console.log("Clicked!")
	e.preventDefault();
	
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
											resolve(data)
										}else{
											reject()
										}
									}
								});
			                   

			            }).then(data=>{
			            	console.log("data");
			            	$("#online-1").modal('hide');
			            	console.log(objReupload);
			            	addRibbon(objReupload,0);
			            	objReupload.find("img").attr('src',data.path);
			            	objReupload.find("li:first").find("a").attr("href",data.path);

			            	objReupload.find("li:last").find("a").attr("data-id",data.id).removeClass("modal-reupload").addClass("modal-desc");
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
$(document).on('submit','#form2',function(e){
	var formData = new FormData($(this)[0]);
	console.log("Clicked!")
	e.preventDefault();
	
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
											resolve(data)
										}else{
											reject()
										}
									}
								});
			                   

			            }).then(data=>{
			            	console.log("data");
			            	$("#online-1").modal('hide');
			            	console.log(objReupload);
			            	// addRibbon(objReupload,0);
			            	objReupload.find("img").attr('src',data.path);
			            	objReupload.find("li:first").find("a").attr("href",data.path);

			            	objReupload.find("li:last").find("a").attr("data-id",data.id).removeClass("modal-reupload").addClass("modal-desc");
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
$(document).on('click','.modal-desc',function(){
	var d = $(this)
	objReupload =  $(this).closest(".el-card-item");
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
	var d = $(this);
	objReupload =  $(this).closest(".el-card-item");

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
	$("#filename").text("")
	$("#filename2").text("");
	$("#filename2").val("");
	$("#title").val("");
	$("#online").prop('checked',true);
	$("select").val("0");
	$(".mydatepicker").datepicker('update', new Date())
	$("#file").val("");
	$("#file2").val("");
} 
$(document).on('submit','#form1',function(e){
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
											resolve(data)
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
					          var pic = '<div class="col-md-4 el-card-item">'+
									        '<div class="ribbon ribbon-'+data.id+' ribbon-vertical-l ">'+
									            '<i class=""></i>'+
									        '</div>    '+
									    '<div class="el-card-content el-overlay-1 "> '+
									        '<img src="'+data.path+'" />'+
									        '<div class="el-overlay">'+
									            '<ul class="el-info">'+
									                '<li><a class="btn default btn-outline image-popup-vertical-fit" href="'+data.path+'"><i class="icon-magnifier"></i></a></li>'+
									                '<li><a class="btn default btn-outline modal-desc"  data-id="'+data.id+'"><i class="icon-link"></i></a></li>'+
									            '</ul>'+
									        '</div>'+        
									    '</div>'+
									    '<div class="el-card-content text-left">'+
									        '<h3 class="box-title">'+data.description+'</h3>'
									        '<br />'+
									    '</div>'+
									'</div>';
								if(data.type == 1){
									$(".printed-card-item:last").after(pic);
									
								}else{
									$(".online-card-item:last").after(pic);
								}
								$('.image-popup-vertical-fit').magnificPopup({
									type: 'image',
									closeOnContentClick: true,
									mainClass: 'mfp-img-mobile',
									image: {
										verticalFit: true
									}
									
								});
			            })

	empty();
})