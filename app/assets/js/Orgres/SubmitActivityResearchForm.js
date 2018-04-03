$('#myTable').DataTable();

(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    $(".select2").select2();
    $('.selectpicker').selectpicker();

    function isValidIDNumber(id){
    	id = parseInt(id);
    	let sum = 0;
    	
    	sum += (id%10);
    	id = parseInt(id/10);

    	sum += (id%10)*2;
    	id = parseInt(id/10);

    	sum += (id%10)*3;
    	id = parseInt(id/10);

    	sum += (id%10)*4;
    	id = parseInt(id/10);

    	sum += (id%10)*5;
    	id = parseInt(id/10);

    	sum += (id%10)*6;
    	id = parseInt(id/10);

    	sum += (id%10)*7;
    	id = parseInt(id/10);

    	sum += (id%10)*8;
    	id = parseInt(id/10);

    	return (sum%11) === 0;
    }

    $('#idNumber').on('change', function(event){
    	console.log('idNumber checking');
    	let form = $('#id_num_group');

    	let val = $(this).val();
    	console.debug(`value: ${val}`);

    	let isValid = isValidIDNumber(val);
    	console.debug(`isValid: ${isValid}`);

    	form.removeClass('has-success');
        form.removeClass('has-error');
        if(isValid){
        	form.addClass('has-success');
        }else{
        	form.addClass('has-error');
        }
    });
})();