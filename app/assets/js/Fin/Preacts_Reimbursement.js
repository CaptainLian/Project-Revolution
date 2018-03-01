
$('#ca_particular').change(function(event) {
		console.log('hihihi')
		sum = 0;
		$('#memo_body').html("");
		$('#ca_particular :selected').each(function(){

        //get the value of current selected item
        value = $(this).val();

        //set properties for the object
        var name = $(this).data('item');
        var quantity = Number($(this).data('quantity'));
        var amount = parseFloat($(this).data('amount'));
        var total = quantity*amount;
        var type = $(this).data('type');


        sum+=total;

        //insert the selected element to the memo table
        $('#memo_body').append('<tr><td>'
                        +name+'</td><td>Php '
                        +total.toLocaleString(undefined, {maximumFractionDigits:2})+'</td></tr>');

		});

		if(sum>1000){
			$('#justification').show();
			$('#justificationinput').attr({
				required: '',
			});
		}else{
			$('#justification').hide();
			$('#justificationinput').removeAttr('required')
		}
});

