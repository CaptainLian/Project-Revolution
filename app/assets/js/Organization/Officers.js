 (function() {

     [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
         new CBPFWTabs(el);
     });

 })();


 $("#sub-pos").click(function() {
     var json = ($("#nestable").nestable('serialize'));
     $.ajax({
         type: 'POST',
         url: '',
         data: {
             pos: json
         },
         success: function(data) {

         }
     });
 });
 
 var nest = $('#nestable').nestable({
 });

 $('.dd span.remove-pos').on('mousedown', function(event) {
     event.preventDefault();
     return false;
 });

 $(document).on('click', 'span.remove-pos', function() {

     $(this).closest('li').remove();
     console.log("Na click");
 });

 $("#pos").keypress(function(e) {
     if (e.which == 13) {
         $("#add-position").trigger('click');
     }
 });

 $("#add-position").click(function() {

     var value = $("#pos").val();
     // console.log("ASD");1
     // $('#nestable').nestable('add', {"id":value});   
     console.log("VALUE   - - " + value);
     var item = '<li class="dd-item" data-id="' + value + '">' +
         '<div class="dd-handle">' + value + ' <span class="remove-pos fa fa-times" style="float: right"></span> </div>' +
         '</li>';
     $("#pos").val('');
     $("#nestable").append(item);
     $('.dd span.remove-pos').on('mousedown', function(event) {
         event.preventDefault();
         return false;
     });
     $(document).on('click', 'span.remove-pos', function() {

         $(this).closest('li').remove();
         console.log("Na click");
     });

 });

 $('#myTable').DataTable({
     dom: 'Bfrtip',
     buttons: [{
         text: 'Add Member',
         action: function(e, dt, node, config) {
             $("#largeModal").modal('show');
         }
     }, {
         text: 'Position',
         action: function(e, dt, node, config) {
             $("#position-modal").modal('show');
         }
     }]
 });