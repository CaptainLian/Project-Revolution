$(document).ready(function() {
    $('select').trigger('change');
    $('select').val('den');
});

$("select").change(function() {
    if ($(this).val() == 'pen') {
        $("tr.pen").css('display', '');
        $("tr.app").css('display', 'none');
        $("tr.den").css('display', 'none');

        $("div.pending").css('display', '');
        $("div.denied").css('display', 'none');

        $('.comment-center').removeClass("flash animated").addClass("flash animated").one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
            $(this).removeClass("flash animated");
        });
    } else if ($(this).val() == 'app') {
        $("tr.pen").css('display', 'none');
        $("tr.app").css('display', '');
        $("tr.den").css('display', 'none');


        $("div.pending").css('display', 'none');
        $("div.denied").css('display', 'none');
    } else if ($(this).val() == 'den') {
        $("tr.pen").css('display', 'none');
        $("tr.app").css('display', 'none');
        $("tr.den").css('display', '');


        $("div.pending").css('display', 'none');
        $("div.denied").css('display', '');

        $('.comment-center')
            .removeClass("shake animated")
            .addClass("shake   animated")
            .one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend',
                function() {
                    $(this).removeClass("shake animated");
                });
    }
});