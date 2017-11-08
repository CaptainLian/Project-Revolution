$("select").select2();

$("input[type='file']").change(function(){
	console.log("PUMASOK");
	console.log($(this).val().split(/[\\/]/g).pop());
	var text = $(this).closest('div.fileinput.fileinput-new.input-group').find('span.fileinput-filename');
	var name = $(this).val().split(/[\\/]/g).pop()

	text.html(name);
})