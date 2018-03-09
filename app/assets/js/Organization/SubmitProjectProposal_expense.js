
$(document).ready(function(){
    //START 
    // <<<<<<< HEAD
    // // $(".fund").css("display", "none");
    // // $("#rev-opt").remove();
    // // $(".expense").css("display","none");
    // =======
    
    if(!rev){
        alert("1");
        $(".fund").css("display", "none");
        $("#rev-opt").remove();
        $(".expense").css("display","none");    
    }

    $("#rev-opt").change(function(){
        console.log("change");
        if($(this).is(":checked")){
            $(".toi").css("display","none")
        }else{
            $(".toi").css("display","")
        }
    });
    $("#exp").change(function(){
        console.log("change");
        if($(this).is(":checked")){
             $(".toi").css("display","")
        }else{
           
        }
    })
    
    // >>>>>>> lian
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
        $("div.reve").each(function(){
            var price = parseFloat($(this).find("input[name='quantity[]']").val())
            var quan = parseFloat($(this).find("input[name='price[]']").val())
            result += price*quan
        })
        return result;
    }

    function exp() {

        var result = 0;
        $("div.expe").each(function(){
            var price = parseFloat($(this).find("input[name='quantity[]']").val())
            var quan = parseFloat($(this).find("input[name='price[]']").val())
            result += price*quan
        })
        return result;
    }
    $("#sel0").select2();
    $("#sel0").select2("val", '0');

    $("#exp").prop("checked",true);
    var idCounter = 0;
    $("#insert-button").click(function() {
        $("#price-help").text("");
        $("#price").closest("div.form-group").removeClass("has-error");
        $("#quantity-help").text("");
        $("#quantity").closest("div.form-group").removeClass("has-error");
        $("#item-help").text("");
        $("#item").closest("div.form-group").removeClass("has-error");
        var itemName = $("#item").val();
        var typeOfItem = $("#sel0").val();
        var price = ($("#price").val());
        var quantity = ($("#quantity").val());
        var kind = $("input[name='optionsRadios2[]']:checked").val();
        console.log("asd");
        console.log(itemName);
        console.log(typeOfItem);
        console.log(price);
        console.log(quantity);
        console.log("KIND" + kind);
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
            var clone = $("#clone").clone();

            clone.find("#item").prop("id",idCounter+1);
            clone.find("#sel0").prop("id",idCounter+2);
            clone.find("#price").prop("id",idCounter+3);
            clone.find("#quantity").prop("id",idCounter+4);
            clone.find("#exp").remove();
            clone.find("#rev-opt").attr('type','text');
            clone.find(".radio-list").prop("id",idCounter+6);
            $(".radio-list").find("input[type=radio]").each(function(index) {
               
                if( $(this).is(':checked') ){
                   
                     clone.find("#rev-opt").val($(this).val());
                }
            });
            // clone.find("input[type=radio]").each(function(index) {
            //     console.log( $(this).is(':checked'));
            //     console.log( $(this).val());
            // })
            // console.log("VALUE NG RADIOBUTTONS");
            // console.log(clone.find("#rev-opt").val());
               clone.find("#rev-opt").prop("id",idCounter+5);
                clone.find(".radio-list").removeClass("radio-list");
            
             

             clone.prop("id",idCounter);
             idCounter++;

             clone.css("display","none").insertBefore("tr#tot-rev");
             empty();
           
            if (kind == "Expense") {
                  clone.addClass("expe")
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
                    '<i data-id="'+(idCounter-1)+'"" class="fa fa-times text-danger  remove-time"></i>' +
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
                $("#exp").prop("checked",true);
                $("#texp").text(exp().toLocaleString());
                $("#org-exp").val(parseFloat(exp()));
                $("#org-exp").trigger('change')
                $("#tfin").text((rev() - exp()).toLocaleString());



            } else if (kind == "Revenue") {
                clone.addClass("reve")
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
                    '<i data-id="'+(idCounter-1)+'"" class="fa fa-times text-danger  remove-time"></i>' +
                    '</td>' +
                    '</tr>';
                $("#rev-opt").prop("checked",true);
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
            var keyDiv = $(this).attr("data-id");
            console.log(keyDiv)
            $("#"+keyDiv).remove();
            
            tr.remove();
            $("#texp").text(exp().toLocaleString());
            $("#org-exp").val(parseFloat(exp()));
            $("#org-exp").trigger('change')
            $("#trev").text(rev().toLocaleString());
            $("#tfin").text((rev() - exp()).toLocaleString());
            console.log(item);
            console.log("REMOVE TIME")
        })



    });
        $("table").on("click", " tbody tr td i.remove-time", function() {
            var tr = $(this).closest("tr");
            var type = tr.attr("type");
            var key = tr.attr("id");
            var keyDiv = $(this).attr("data-id");
            console.log(keyDiv)
            $("#"+keyDiv).remove();
            
            tr.remove();
            $("#texp").text(exp().toLocaleString());
            $("#org-exp").val(parseFloat(exp()));
            $("#org-exp").trigger('change')
            $("#trev").text(rev().toLocaleString());
            $("#tfin").text((rev() - exp()).toLocaleString());
            console.log(item);
            console.log("REMOVE TIME")
        })
    
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
        var oth = parseFloat($("#oth2-exp").val());
        return result = result + ope + dep + oth;
    }
    

    $("#ope-fund, #dep-fund, #oth-fund, #org-exp, #pat-exp, #oth2-exp").change(function() {
        $("#tcd").text(fund().toLocaleString());
        $("#tpe").text(exp2().toLocaleString());
        $("#rb").text((fund() - exp2()).toLocaleString())
    });
    $("#ope-fund").trigger("change");


    


    $("#save").click(function(e) {
            e.preventDefault();
            console.log("asd");
            $("#tpe2").text("");
            $("#tpe2").closest("div.form-group").removeClass("has-error");
            $("#oth-help").text("");
            $("#oth-fund").closest("div.form-group").removeClass("has-error");
            $("#org-help").text("");
            $("#org-exp").closest("div.form-group").removeClass("has-error");
            $("#pat-help").text("");
            $("#pat-exp").closest("div.form-group").removeClass("has-error");
            $("#oth2-help").text("");
            $("#oth2-exp").closest("div.form-group").removeClass("has-error");
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


        if ($.trim($("#oth-fund").val()) < 0) {
            $("#oth-help").text("Others should not be Empty!");
            $("#oth-fund").closest("div.form-group").addClass("has-error");
            err = 1;
        }

        if ($.trim($("#org-exp").val()) < 0) {
            $("#org-help").text("Organization Funds should not be Empty!");
            $("#org-exp").closest("div.form-group").addClass("has-error");
            err = 1;
        }
        if ($.trim($("#pat-exp").val()) < 0) {
            $("#pat-help").text("Participant's fee should not be Empty!");
            $("#pat-exp").closest("div.form-group").addClass("has-error");
            err = 1;
        }
        if ($.trim($("#oth2-exp").val()) < 0) {
            $("#oth2-help").text("Others should not be Empty!");
            $("#oth2-exp").closest("div.form-group").addClass("has-error");
            err = 1;
        }
        console.log("exp() :"+exp())
        console.log("fund() :"+fund())
        if(exp() > fund()){
            $.toast({
                heading: 'Failed!',    
                text:   'Expense should not be greater than Total Cash Disbursement.',
                position: 'top-right',
                loaderBg:'#ff6849',
                icon: 'error',
                bgColor:'#FB9678',
                hideAfter: 5500, 
                stack: 6
              });
             
            $("#tpe2").closest("div.form-group").addClass("has-error");
            err = 1;   
        }

        if (err) {
            $('body,html').animate({
                scrollTop: 150
            }, 500);
        } else {
            $("#tpe2").text("");
            $("#tpe2").closest("div.form-group").removeClass("has-error");
            $("#oth-help").text("");
            $("#oth-fund").closest("div.form-group").removeClass("has-error");
            $("#org-help").text("");
            $("#org-exp").closest("div.form-group").removeClass("has-error");
            $("#pat-help").text("");
            $("#pat-exp").closest("div.form-group").removeClass("has-error");
            $("#oth2-help").text("");
            $("#oth2-exp").closest("div.form-group").removeClass("has-error");
            $("#form-id").submit();
        }
        console.log("ASd");
    });

    $("#texp").text(exp().toLocaleString());
    $("#org-exp").val(parseFloat(exp()));
    $("#org-exp").trigger('change')
                $("#trev").text(rev().toLocaleString());
                $("#tfin").text((rev() - exp()).toLocaleString());

    
})