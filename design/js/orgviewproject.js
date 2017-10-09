$(function() {
	$('.distro').hide();
	$('.date').hide();
	$(".ModeDist").click(function(){
		if($('#online').is(':checked')) {
			$('.date').show();
		 	$('.pubmat').hide();
		}else {
			$('.date').hide();
			$('.pubmat').show();
		}

		/*
		if (document.getElementById('printed').checked) {
		    document.getElementById('pubmat').style.display = 'block';
		    console.log('printed');
		}else {
			document.getElementById('pubmat').style.display = 'none';
			console.log('notprinted');
		}
		*/
	});

});	

