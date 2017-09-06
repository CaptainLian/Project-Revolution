'use strict';

$('#myTable').DataTable();

[].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
  new CBPFWTabs(el);
});

$('#myTable > tbody > .activity_row')
.click(function() {
  console.log('CLICKED ON A ROW');
  let row = $(this);
  let activityID = row.data('activity-id');

  console.log(activityID);
  $.ajax({
    type: 'GET',
    url: '/APS/ajax/GetGOSMActivityDetails',
    data: {
      activityID: activityID
    },
    async: true,
    success: function(data, textStatus, jqXHR) {
      console.log(data);
      const activityDetails = data.activityDetails;
      const projectHeads = data.projectHeads;
      $('#modal_type').html(activityDetails.type);
      $('#modal_nature').html(activityDetails.nature);
      $('#modal_date').html(activityDetails.startdate + ' - '+ activityDetails.enddate);

      const table = $('#modal_table_activity');
      table.find('.modal_head_row').remove();

      console.log(JSON.stringify(projectHeads));
      if(projectHeads.length > 0){
        table.append('<tr class="modal_head_row"><th>Project Heads:</th><td colspan="6">' + projectHeads[0].name + ": " + projectHeads[0].contactnumber + '</td></tr>');
        for(let index = 1, length = projectHeads.length; index < length; ++index){
          table.append('<tr class="modal_head_row"><th></th><td colspan="6">' + projectHeads[index].name + ": " + projectHeads[index].contactnumber + '</td></tr>');
        }
      }

    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
    }
  }); //$.ajax()
});
