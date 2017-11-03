$(document).ready(function() {
    //window.location.href("facebook.com");
    $('#myTable').DataTable();
});

(function() {
    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });
})();