$('#date-range, #date-range2, #date-range3').datepicker({
    toggleActive: true
});

$("#save").click(function(e){
	clear();
	console.log("ASd");
	e.preventDefault();
	console.log("AS2d");
	var firstStart = $("input[name='first-start']").val();
	var secondStart = $("input[name='second-start']").val();
	var thirdStart = $("input[name='third-start']").val();
	var firstEnd = $("input[name='first-end']").val();
	var secondEnd = $("input[name='second-end']").val();
	var thirdEnd = $("input[name='third-end']").val();

	var fs = new Date(firstStart);
	var ss = new Date(secondStart);
	var ts = new Date(thirdStart);

	var fe = new Date(firstEnd);
	var se = new Date(secondEnd);
	var te = new Date(thirdEnd);

	console.log(fe);console.log(ss);
	console.log(ss.getTime() > fe.getTime());
	console.log(ts.getTime() > se.getTime());
	var err = 0
	if(fs.getTime() == fe.getTime()){
		$("#first").closest(".form-group").addClass("has-error");
		$("#first").append("Start and End Date cannot be equal!");
		err = 1;
	}	
	if(ss.getTime() == se.getTime()){
		$("#second").closest(".form-group").addClass("has-error");
		$("#second").append("Start and End Date cannot be equal!");
		err = 1;
	}
	if(ts.getTime() == te.getTime()){
		$("#third").closest(".form-group").addClass("has-error");
		$("#third").append("Start and End Date cannot be equal!");
		err = 1;
	}



	if(ss.getTime() < fe.getTime()){
		$("#second").closest(".form-group").addClass("has-error");
		$("#second").append("Cannot be Earlier than First Term!");
		err = 1;
	}

	if(ts.getTime() < se.getTime()){
		$("#third").closest(".form-group").addClass("has-error");
		$("#third").append("Cannot be Earlier than Second Term!");
		err = 1;
	}

	if(err){

	}else{
		clear();
		$("#form").submit();
	}	

});

function clear(){
	$("#first").closest(".form-group").removeClass("has-error");
	$("#first").text("");
	$("#second").closest(".form-group").removeClass("has-error");
	$("#second").text("");
	$("#third").closest(".form-group").removeClass("has-error");
	$("#third").text("");
}