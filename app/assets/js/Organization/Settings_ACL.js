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
