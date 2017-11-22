 $("select").select2();
        $('.selectpicker').selectpicker();
        (function() {
            $('#mainTable').editableTableWidget().numericInputExample().find('td:first').focus();
            [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
                new CBPFWTabs(el);
            });
        })();
    function arrayContains(string, array)
    {
        return (array.indexOf(string) > -1);
    }
    function showAttachments(array){
        //food, accomodation, others, venue, transportation, honorarium, cash prize
        if(arrayContains('food',array)||arrayContains('accomodation',array)){
            $('#elop').show();
        }else{
            $('#elop').hide();
        }
        if(arrayContains('cash prize',array)){
            $('#moc').show();
        }else{
            $('#moc').hide();
        }if(arrayContains('honorarium',array)){
            $('#honorarium').show();
            //show div of honorarium file input
        }else{
            $('#honorarium').hide();
            //hide div of honorarium file input
        }if(arrayContains('venue',array)){
            $('#venue').show();
            //show div of honorarium file input
        }else{
            $('#venue').hide();
            //hide div of honorarium file input
        }if(arrayContains('transportation',array)){
            $('#transportation').show();
            //show div of honorarium file input
        }else{
            $('#transportation').hide();
            //hide div of honorarium file input
        }
        
    }
    function submit(){
        if($('#ca_particular').val()!=null){
             alert("awyiss");
        }else {
            alert("aww cannot be empty");
        }
        
    }
    function empty(){
        $('#iq_body').html('');
        $('#memo_body').html('');
    }
    $('#ca_particular').change(function() {
    //reset table 
     empty();
     var sum=0.0;
     var value = $('#ca_particular').val();
     var attachments = [];
     var showInformalQuotation = false;
     var showListOfParticipants = false;
     var showMechanicsOfCompetition = false;

     if(value!=null){
            $('#purpose').show();
            $('#iq').show();
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

        attachments.push(type);

        //insert the selected element to the memo table
        $('#memo_body').append('<tr><td>'
                        +name+'</td><td>Php '
                        +total.toLocaleString(undefined, {maximumFractionDigits:2})+'</td></tr>');

      });

      //insert total expense to memo table
      $('#memo_body').append('<tr><th>Total Expense:</th><th>Php '
                        +sum.toLocaleString(undefined, {maximumFractionDigits:2})+'</th></tr>');

          if(showInformalQuotation){
            //show the informal quotation editable table 
            $('#informal_quotation').show();
            var td = document.getElementsByClassName('editable');
            for(var i=0;i<td.length;i++) {
                td[i].addEventListener('click', change, false);
                td[i].addEventListener('blur', changeback, false);
            }
            
            function change() {
                this.contentEditable = true;
                this.focus();
            }
            function changeback() {
                this.removeAttribute("contentEditable");
            }

          }else{
            $('#informal_quotation').hide();
          }
     }else{
        $('#purpose').hide();
        $('#iq').hide();
        attachments = [];
        $('#ca_amount').html("");
        $('#memo_body').html("");
        $('#informal_quotation').hide();
        console.log('hidden');

     }

    //show justification for not using direct payment if sum is greater than 2000

    showAttachments(attachments);

     console.log("value: "+value);
     console.log("sum: "+sum);
     console.log(attachments);
     $('#ca_amount').html("Php "+ sum.toLocaleString(undefined, {maximumFractionDigits:2}));
   });//end change function