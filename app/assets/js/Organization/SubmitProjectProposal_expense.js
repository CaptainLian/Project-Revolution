//START 
$(".fund").css("display", "none");
$("#rev-opt").remove();
//END KPAG FUNDRAISING
var item = {};
item["rev"] = {};
item["exp"] = {};
var key = 0;

function empty() {
    $("#item").val("");

    $("#sel0").select2("val", '0');
    ($("#price").val(""));
    ($("#quantity").val(""));
}

function rev() {
    var result = 0;
    for (var x = 0; x < Object.keys(item["rev"]).length; x++) {
        console.log(item["rev"][Object.keys(item["rev"])[x]].price + "  WHOl");
        console.log(Object.keys(item["rev"])[x].quan);

        result += parseFloat(item["rev"][Object.keys(item["rev"])[x]].price) * parseInt(item["rev"][Object.keys(item["rev"])[x]].quan);
    }
    return result;
}

function exp() {
    var result = 0;
    for (var x = 0; x < Object.keys(item["exp"]).length; x++) {
        result += parseFloat(item["exp"][Object.keys(item["exp"])[x]].price) * parseInt(item["exp"][Object.keys(item["exp"])[x]].quan);
    }
    return result;
}
$("#sel0").select2();
$("#sel0").select2("val", '0');



$("#insert-button").click(function() {
    var itemName = $("#item").val();
    var typeOfItem = $("#sel0").val();
    var price = ($("#price").val());
    var quantity = ($("#quantity").val());
    var kind = $("input[name='optionsRadios2']:checked").val();
    console.log("asd");
    console.log(itemName);
    console.log(typeOfItem);
    console.log(price);
    console.log(quantity);
    var err = 0
    if ($.trim(itemName) < 1) {
        $("#item-help").text("Item Name cannot be empty!");
        $("#item").closest("div.form-group").addClass("has-error");
        err = 1;

    }
    if ($.trim(price) < 1) {
        $("#price-help").text("Item Name cannot be empty!");
        $("#price").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    if ($.trim(quantity) < 1) {
        $("#quantity-help").text("Item Name cannot be empty!");
        $("#quantity").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    console.log(parseFloat(price) === NaN);
    if (isNaN(parseFloat(price))) {
        $("#price-help").text("Please input a number!");
        $("#price").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    if (isNaN(parseFloat(quantity))) {
        $("#quantity-help").text("Please input a number!");
        $("#quantity").closest("div.form-group").addClass("has-error");
        err = 1;
    }

    if (parseFloat(price) < 1) {
        $("#price-help").text("Price cannot be below 0!");
        $("#price").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    if (parseFloat(quantity) < 1) {
        $("#quantity-help").text("Quantity cannot be below 0!");
        $("#quantity").closest("div.form-group").addClass("has-error");
        err = 1;
    }

    if (err) {

    } else {
        $("#price-help").text("");
        $("#price").closest("div.form-group").removeClass("has-error");
        $("#quantity-help").text("");
        $("#quantity").closest("div.form-group").removeClass("has-error");
        $("#item-help").text("");
        $("#item").closest("div.form-group").removeClass("has-error");
        empty();
        if (kind == "Expense") {
            var tde =
                '<tr type="exp" id=' + key + '>' +
                '<td >' + itemName + '</td>' +

                '<td></td>' +
                '<td class="text-right"><strong>₱</strong>' + ((quantity * price).toLocaleString()) + '</td>' +
                '<td class="text-center">' +
                '<span class="mytooltip tooltip-effect-1">' +
                '<span class="tooltip-item" style="background-color:white;padding:0px"><i class="fa fa-comment-o view-details" ></i>  </span>' +
                '<span class="tooltip-content clearfix">' +
                '<span class="tooltip-text p-10">' +

                '<p>Quantity: ' + quantity + ' ' + 'pcs</p>' +
                '<p>Price: ₱ ' + price + '</p>' +
                '<p>Type: ' + $("#sel0").select2("data").text + '</p>' +

                '</span> ' +
                '</span>' +
                '</span> ' +
                '<i class="fa fa-times text-danger  remove-time"></i>' +
                '</td>' +
                '</tr>';
            $(tde).insertBefore("tr#tot-exp");
            obj = {
                item: itemName,
                quan: quantity,
                price: price,
                type: typeOfItem,
                kind: kind
            };
            item["exp"][key] = obj;
            $("#texp").text(exp().toLocaleString());
            $("#tfin").text((rev() - exp()).toLocaleString());



        } else if (kind == "Revenue") {
            var tda =
                '<tr type="rev" id=' + key + '>' +
                '<td >' + itemName + '</td>' +


                '<td class="text-right"><strong>₱</strong>' + ((quantity * price).toLocaleString()) + '</td>' +
                '<td></td>' +
                '<td class="text-center">' +
                '<span class="mytooltip tooltip-effect-1">' +
                '<span class="tooltip-item" style="background-color:white;padding:0px"><i class="fa fa-comment-o view-details" ></i>  </span>' +
                '<span class="tooltip-content clearfix">' +
                '<span class="tooltip-text p-10">' +

                '<p>Quantity: ' + quantity + ' ' + 'pcs</p>' +
                '<p>Price: ₱ ' + price + '</p>' +
                '<p>Type: ' + $("#sel0").select2("data").text + '</p>' +

                '</span> ' +
                '</span>' +
                '</span> ' +
                '<i class="fa fa-times text-danger  remove-time"></i>' +
                '</td>' +
                '</tr>';
            $(tda).insertBefore("tr#tot-rev");
            obj = {
                item: itemName,
                quan: quantity,
                price: price,
                type: typeOfItem,
                kind: kind
            };
            item["rev"][key] = obj;
            $("#trev").text(rev().toLocaleString());
            $("#tfin").text((rev() - exp()).toLocaleString());

        }
        console.log(item);
        key++;


    }


    $("table").on("click", " tbody tr td i.remove-time", function() {
        var tr = $(this).closest("tr");
        var type = tr.attr("type");
        var key = tr.attr("id");

        delete item[type][key];
        tr.remove();
        $("#texp").text(exp().toLocaleString());
        $("#trev").text(rev().toLocaleString());
        $("#tfin").text((rev() - exp()).toLocaleString());
        console.log(item);
        console.log("REMOVE TIME")
    })



});

function fund() {
    var result = 0;
    var ope = parseFloat($("#ope-fund").val());
    var dep = parseFloat($("#dep-fund").val());
    var oth = parseFloat($("#oth-fund").val());
    return result = result + ope + dep + oth;
}

function exp2() {
    var result = 0;
    var ope = parseFloat($("#org-exp").val());
    var dep = parseFloat($("#pat-exp").val());
    var oth = parseFloat($("#oth-exp").val());
    return result = result + ope + dep + oth;
}


$("#ope-fund, #dep-fund, #oth-fund, #org-exp, #pat-exp, #oth-exp").keydown(function() {
    $("#tcd").text(fund().toLocaleString());
    $("#tpe").text(exp2().toLocaleString());
    $("#rb").text((fund() - exp2()).toLocaleString())
});

$("#save").click(function() {
    var err = 0;
    if (isNaN($("#ope-fund").val())) {

    }
    if (isNaN($("#dep-fund").val())) {

    }
    if (isNaN($("#oth-fund").val())) {
        $("#oth-help").text("Others should be number!");
        $("#oth-fund").closest("div.form-group").addClass("has-error");
        err = 1;
    }

    if (isNaN($("#org-exp").val())) {
        $("#org-help").text("Organization Funds should be number!");
        $("#org-exp").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    if (isNaN($("#pat-exp").val())) {
        $("#pat-help").text("Participant's fee should be number!");
        $("#pat-exp").closest("div.form-group").addClass("has-error");
        err = 1;
    }
    if (isNaN($("#oth2-exp").val())) {
        $("#oth2-help").text("Others should be number!");
        $("#oth2-exp").closest("div.form-group").addClass("has-error");
        err = 1;
    }

    if (err) {
        $('body,html').animate({
            scrollTop: 150
        }, 500);
    } else {
        $("#oth-help").text("");
        $("#oth-fund").closest("div.form-group").removeClass("has-error");
        $("#org-help").text("");
        $("#org-exp").closest("div.form-group").removeClass("has-error");
        $("#pat-help").text("");
        $("#pat-exp").closest("div.form-group").removeClass("has-error");
        $("#oth2-help").text("");
        $("#oth2-exp").closest("div.form-group").removeClass("has-error");
    }
});