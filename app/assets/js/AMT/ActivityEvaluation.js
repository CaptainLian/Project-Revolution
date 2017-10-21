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