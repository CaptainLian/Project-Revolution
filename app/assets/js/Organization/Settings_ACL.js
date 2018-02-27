var oTable = $('#myTable').DataTable(   {
	scrollY:        "300px",
	scrollX:        true,
	scrollCollapse: false,
	paging:         true,
	fixedColumns:   {
		leftColumns: 1,
	},
	"ordering": true,
    columnDefs: [{
      orderable: false,
      targets: "no-sort"
    }]

} );
$(document).ready(function(){

	$('form').on('submit', function(e){
  		 var $form = $(this);
  		 console.log("ASd")
	   // Iterate over all checkboxes in the table
	   oTable.$('input[type="checkbox"]').each(function(){
	      // If checkbox doesn't exist in DOM
	      if(!$.contains(document, this)){
	         // If checkbox is checked
	         if(this.checked){
	            // Create a hidden element 
	            $form.append(
	               $('<input>')
	                  .attr('type', 'hidden')
	                  .attr('name', this.name)
	                  .val(this.value)
	            );
	         }
	      } 
	   });          
	});
})