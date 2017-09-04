$('#myTable').DataTable();

[].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
    new CBPFWTabs(el);
});

$('#myTable .activity_row')
.each(() => {
	const row = $(this);
	const activityID = row.attr('data-activityID');
	row.click(() => {
		$.ajax({
            type: 'GET',
            url: '/APS/ajax/GetGOSMActivityDetails',
            data: {
                activityID: activityID
            },
            async: false,
            success: function(data, textStatus, jqXHR) {
                console.log(data);
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(errorThrown);
            }
        }); //$.ajax()
		console.log(attribute);
	});
});	