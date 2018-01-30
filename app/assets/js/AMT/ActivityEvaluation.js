$("#feedback").click(function() {
    $("html, body").animate({
        scrollTop: 0
    }, "slow", function() {
        $("#fb").click();
    });

});
(function() {

    [].slice.call(document.querySelectorAll('.sttabs')).forEach(function(el) {
        new CBPFWTabs(el);
    });

})();
var clockpicker = $('#start-time').clockpicker({
    donetext: 'Done',
    autoclose: true,
});
var clockpicker2 = $('#end-time').clockpicker({
    donetext: 'Done',
    autoclose: true,
});