var oTable = $('#myTable').DataTable(   {
	scrollY:        "300px",
	scrollX:        true,
	scrollCollapse: true,
	paging:         false,
	fixedColumns:   {
		leftColumns: 1,
	},
	"ordering": true,
    columnDefs: [{
      orderable: false,
      targets: "no-sort"
    }]

} );
