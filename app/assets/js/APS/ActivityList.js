'use strict';

(() => {
    const csrfToken = document.querySelector('meta[data-name="csrf"]').getAttribute('data-token');

    (() => {
        [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
            new CBPFWTabs(el);
        });
    })();

    (() => {
        const activityTable = $('#myTable');
        //window.location.href("facebook.com");
        activityTable.DataTable();
        // location.replace("https://www.facebook.com");
        var table = $('#example').DataTable({
            "columnDefs": [{
                "visible": false,
                "targets": 2
            }],
            "order": [
                [2, 'asc']
            ],
            "displayLength": 25,
            "drawCallback": function(settings) {
                var api = this.api();
                var rows = api.rows({
                    page: 'current'
                }).nodes();
                var last = null;

                api.column(2, {
                    page: 'current'
                }).data().each(function(group, i) {
                    if (last !== group) {
                        $(rows).eq(i).before(
                            '<tr class="group"><td colspan="5">' + group + '</td></tr>'
                        );

                        last = group;
                    }
                });
            }
        });

        // Order by the grouping
        $('#example tbody').on('click', 'tr.group', function() {
            var currentOrder = table.order()[0];
            if (currentOrder[0] === 2 && currentOrder[1] === 'asc') {
                table.order([2, 'desc']).draw();
            } else {
                table.order([2, 'asc']).draw();
            }
        });

        const modal_table_details = document.getElementById('modal_table_details');

        const modal_view_activityType = document.getElementById('modal_view_type');
        const modal_view_activityNature = document.getElementById('modal_view_nature');
        const modal_view_venue = document.getElementById('modal_view_venue');
        const modal_view_date = document.getElementById('modal_view_date');
        const modal_view_enp = document.getElementById('modal_view_enp');

        activityTable.find('tbody > .activity_row')
            .click(function() {
                const row = $(this);
                const PPRID = row.data('ppr-id');
                console.log(`PPRID: ${PPRID}`);
                $.ajax({
                    type: 'POST',
                    url: '/APS/AJAX/getProjectProposaActivityDetails',
                    data: {
                        _csrf: csrfToken,
                        PPRID: PPRID
                    },

                    success: (data, textStatus, jqXHR) => {
                        console.log(JSON.stringify(data));
                    },

                    error: (jqXHR, textStatus, errorThrown) => {
                        console.log(errorThrown);
                    }
                });
            });
    })();
})();