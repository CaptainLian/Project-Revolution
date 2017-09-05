'use strict';

$('#myTable').DataTable();

[].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
  new CBPFWTabs(el);
});

$('#myTable > tbody > tr, .activity_row')
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
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log(errorThrown);
    }
  }); //$.ajax()
});
