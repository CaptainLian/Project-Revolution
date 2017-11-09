      var key = 0;
        var result = 0;
        $('select').select2();
        $("#file").change(function(){
            console.log("PUMASOK")
            var filename = $(this).val().split('\\').pop();
            $("#filename").text(filename);
        });
        $("#file").val("");


        function empty(){
            $("#part").val("");
            $("#est").val("");
            $("#price").val("");
            $("#filename").text("");
            $("#file").val("");
        }

        


       $("#insert-button").click(function(){
            var part = $("#part").val();
            var est = $("#est").val();
            var price = ($("#price").val());
            
            var has_selected_file =  $.trim( $('input[type=file]').val());
            
            var err = 0
            if($.trim(part) < 1){
                $("#part-help").text("Particulars cannot be empty!");
                $("#part").closest("div.form-group").addClass("has-error");
                err = 1;

            }
            if($.trim(est) < 1){
                $("#est-help").text("Establishment cannot be empty!");
                $("#est").closest("div.form-group").addClass("has-error");
                err = 1;
            }
            if($.trim(price) < 1){
                $("#price-help").text("Item Name cannot be empty!");
                $("#price").closest("div.form-group").addClass("has-error");
                err = 1;
            }
            console.log(parseFloat(price) === NaN);
            if(isNaN(parseFloat(price))){
                $("#price-help").text("Please input a number!");
                $("#price").closest("div.form-group").addClass("has-error");
                err = 1;
            }
            
            if(parseFloat(price) < 1){
                $("#price-help").text("Price cannot be below 0!");
                $("#price").closest("div.form-group").addClass("has-error");
                err = 1;
            }
            if(has_selected_file == ""){
                $("#file-help").text("File cannot be empty!");
                $("#file").closest("div.form-group").addClass("has-error").addClass("has-danger");
                err = 1;
            }

            if(err){

            }else{
                $("#price-help").text("");
                $("#price").closest("div.form-group").removeClass("has-error");
                $("#part-help").text("");
                $("#part").closest("div.form-group").removeClass("has-error");
                $("#est-help").text("");
                $("#est").closest("div.form-group").removeClass("has-error");
                $("#file-help").text("");
                $("#file").closest("div.form-group").removeClass("has-error").removeClass("has-danger");
                $("#data").clone().attr("id","asd"+key).addClass("price-cal").css("display","none").appendTo("#data");

                empty();

                

                
                
                    var tda = 
                        '<tr id='+key+' price="'+price+'">'+
                            '<td class="text-center" >'+part+'</td>'+
                           
                            '<td></td>'+
                            '<td class="text-right"><strong>₱</strong>'+price+'</td>'+
                            
                            '<td class="text-center">'+
                                 '<span class="mytooltip tooltip-effect-1">'+
                                    '<span class=   "tooltip-item" style="background-color:white;padding:0px"><i class="fa fa-comment-o view-details" ></i>  </span>'+
                                    '<span class="tooltip-content clearfix">'+
                                        '<span class="tooltip-text p-10">'+ 
                                                                             
                                            '<p>Establishment : '+est+' '+'</p>'+                                            
                                            '<p>File Name : '+ has_selected_file.split('\\').pop()+ '</p>'+
                                            
                                        '</span> '+
                                    '</span>'+
                                '</span> '+
                                 '<i class="fa fa-times text-danger  remove-time"></i>'+
                            '</td>'+
                        '</tr>';    
                    $(tda).insertBefore("tr#tot-exp");
                    result+=parseFloat(price);
                    $("#texp").text((result).toLocaleString());
                    
                  key++;   
                    
                
            }
                   
        });

            $("table").on("click"," tbody tr td i.remove-time",function(){
                var tr = $(this).closest("tr");
                var type = tr.attr("type");
                var keys = tr.attr("id");
                var price = parseFloat(tr.attr("price"));
                console.log("REMOVE "+keys );
                console.log("div#asd"+keys);
                tr.remove();                
                result-=price;
                $("#texp").text((result).toLocaleString());
                $("div#asd"+parseInt(keys)).remove();
                
            })

  var fields ='<div class="pic-group col-md-12">' +
                        '<div class="col-md-5 m-b-10 col-sm-12" style="overflow:hidden;"  >'+
                            '<input style="" type="file" accept=".jpeg, .jpe, .jpg,.png" name="pictures[]" >'+
                        '</div>'+
                        '<div class="col-md-5 col-sm-12 m-b-10">'+
                            '<input style="" type="text" placeholder="e.g. Post-group picture of Activity" required="" name="pictureCaption[]" style="box-sizing: border-box;width: 100%" >'+
                            
                        '</div>'+
                        '<div class="col-md-2 col-sm-12 "  style="margin-top:2px;vertical-align:middle">'+
                            '<span class="fa fa-times text-danger remove-pic" data-toggle="tooltip" data-title="Remove" ></span>'+
                        '</div>'+
                    '</div>';
        $("#insert-pictures").click(function(){
            console.log("asd");
            $("#upload").append(fields);
            $('[data-toggle="tooltip"]').tooltip(); 
        });
        $("#upload").on('click','.remove-pic ',function(){
            console.log("asd");
            $('.tooltip').remove();
            $(this).closest(".pic-group").remove();
        })
