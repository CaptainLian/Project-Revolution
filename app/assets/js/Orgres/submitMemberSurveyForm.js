$('#myTable').DataTable();

(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    $(".select2").select2();
    $('.selectpicker').selectpicker();
})();

$(document).ready(function(){
	$("#submit").attr("disabled","")
	console.log("Doms")

	$("#idnumber, #org-select").change(function(){
		console.log("DOMS2")
		var orgid = $("#org-select").val()
		var idnumber = $("#idnumber").val()
		$('#idnumber').parent('.form-group').removeClass("has-error")
		$.ajax({
			type:'POST',
			url:'/ORGRES/AJAX/idnumber',
			data:{orgid: orgid,idnumber: idnumber},
			success:function(data){
				if(data.status){
					$("#submit").removeAttr("disabled")
					$(this).closest('.form-group').removeClass("has-error")
					$("span.highlight").text("")
					
				}else{
					$('#idnumber').parent('.form-group').addClass("has-error")
					$("span.highlight").text("Member does not exist")
					$("span.highlight").css("color","#fb9678")
					$("#submit").attr("disabled","")
				}
			}

		})
	})


})