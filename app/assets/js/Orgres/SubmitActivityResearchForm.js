$('#myTable').DataTable();

(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

    $(".select2").select2();
    $('.selectpicker').selectpicker();
})();