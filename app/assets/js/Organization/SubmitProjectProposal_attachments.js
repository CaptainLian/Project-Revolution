var AttachmentType;
var toAdd="";
$("select").select2();

$("select").trigger('change');
$('#attachmentModal').modal({ show: false});
$("input[type='file']").on('change',function(){
	console.log("PUMASOK");
	console.log($(this).val().split(/[\\/]/g).pop());
	var text = $(this).closest('div.fileinput.fileinput-new.input-group').find('span.fileinput-filename');
	var name = $(this).val().split(/[\\/]/g).pop()

	text.html(name);
})

$('#addBtn').click(function(event) {
	$('#attachmentModal').modal('show');
	AttachmentType = $('#types option:selected').text();
		
});
$(document.body).on('change','#types',function(event) {
		// AttachmentType = $(this).val();
	AttachmentType = $('#types option:selected').text();
	console.log(AttachmentType);

});
$('#insertBtn').click(function(event) {
	toAdd = '<div class="form-group row">'+
                '<label class="col-sm-3 offset-md-2">'+AttachmentType+'</label>'+
                    '<div class="col-sm-5">'+
                    
                        '<div class="fileinput fileinput-new input-group" data-provides="fileinput">'+
                            '<div class="form-control" data-trigger="fileinput">'+
                                '<i class="glyphicon glyphicon-file fileinput-exists"></i>'+
                                '<span class="fileinput-filename"></span>'+
                            '</div>'+
                            '<span class="input-group-addon btn btn-default btn-file">'+
                                '<span class="fileinput-new">Select file</span>'+
                                '<span class="fileinput-exists">Change</span>'+
                                '<input type="hidden"><input required="" name="uploadfile[]" type="file">'+
                            '</span>'+
                            '<a href="#" class="input-group-addon btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>'+
                        '</div>'+
                    '</div>'+
                    '<a class="remove" data-toggle="tooltip" data-original-title="Close">'+ 
                        '<i db-id="6" class="fa fa-close fa-2x text-danger"></i>'+ 
                     '</a>'+
            '</div>';
	$('#attachment').append(toAdd);
	
	$('.remove').click(function(event) {
		console.log('wews');
		$(this).parent().remove();
	});
	$('#attachmentModal').modal('hide');
});


