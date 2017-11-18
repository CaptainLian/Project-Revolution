
!function($) {
    "use strict";

    var SweetAlert = function() {};

    //examples 
    SweetAlert.prototype.init = function() {
        
    //Basic
    $('.sa-basic').click(function(){
        swal("Here's a message!");
    });

    //A title with a text under
    $('.sa-title').click(function(){
        swal("Here's a message!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.")
    });

    //Success Message
    $('.sa-success').click(function(){
        swal("Good job!", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed lorem erat eleifend ex semper, lobortis purus sed.", "success")
    });

    //success request
    $('.sa-successRequest').click(function(){
        swal("Success!", "Request has been submitted for approval.", "success")
    });
    //Warning Message
    $('.sa-warning').click(function(){
        swal({   
            title: "Are you sure?",   
            text: "Clicking Yes will ",   
            type: "warning",   
            showCancelButton: true,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "approve !",   
            closeOnConfirm: false 
        }, function(){   
            swal("Deleted!", "Your imaginary file has been deleted.", "success"); 
        });
    });
    /*
        FINANCE SWEET ALERT
    */
    $('.ca-approve').click(function(){
        swal({   
            title: "Approve Request?",   
            text: "Clicking confirm will approve the financial request for the activity",   
            type: "warning",   
            showCancelButton: true,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "Confirm",   
            closeOnConfirm: false 
        }, function(){   
            swal("Success!", "The request has been approved", "success"); 
        });
    });
    $('.ca-pend').click(function(){
        swal({
          title: "Pend Request",
          text: "Write your reason for pending the request:",
          type: "input",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    $('.ca-deny').click(function(){
        swal({
          title: "Deny Request",
          text: "Write your reason for denying the request:",
          type: "input",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    /*
         END of FINANCE SWEET ALERT
    /*
        START OF PNP SWEET ALERT
    */ 

    $('.pnp-approve').click(function(){
        swal({   
            title: "Approve Publicity Material?",   
            text: "Clicking confirm will allow the org to use the publicity material.",   
            type: "warning",   
            showCancelButton: true,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "Confirm",   
            closeOnConfirm: false 
        }, function(){   
            swal("Success!", "The request has been approved", "success"); 
        });
    });
    $('.pnp-pend').click(function(){
        swal({
          title: "Pend Publicity Material",
          text: "Write your reason for pending the publicity material:",
          type: "input",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    $('.pnp-deny').click(function(){
        swal({
          title: "Deny Publicity Material",
          text: "Write your reason for denying the publicity material:",
          type: "input",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    /*
        END OF PNP SWEET ALERT
    */ 

    $('.sa-approve').click(function(){
        swal({   
            title: "Approve Activity?",   
            text: "Clicking confirm will approve the activity",   
            type: "warning",   
            showCancelButton: true,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "Confirm",   
            closeOnConfirm: false 
        }, function(){   
            swal("Success!", "The activity has been approved", "success"); 
        });
    });
    //Pend Activity
    $('.sa-pend').click(function(){
        swal({
          title: "Pend Activity",
          text: "Write your reason for pending the activity:",
          type: "info",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    //Deny Activity
    $('.sa-deny').click(function(){
        swal({
          title: "Deny Activity",
          text: "Write your reason for denying the activity:",
          type: "input",
          showCancelButton: true,
          closeOnConfirm: false,
          inputPlaceholder: "Write something"
        },
        function(inputValue){
          if (inputValue === false) return false;
          
          if (inputValue === "") {
            swal.showInputError("You need to write something!");
            return false
          }
          
          swal("Success!", "You wrote: " + inputValue, "success");
        });
    });
    //Parameter
    $('#sa-params').click(function(){
        swal({   
            title: "Are you sure?",   
            text: "You will not be able to recover this imaginary file!",   
            type: "warning",   
            showCancelButton: true,   
            confirmButtonColor: "#DD6B55",   
            confirmButtonText: "Yes, delete it!",   
            cancelButtonText: "No, cancel plx!",   
            closeOnConfirm: false,   
            closeOnCancel: false 
        }, function(isConfirm){   
            if (isConfirm) {     
                swal("Deleted!", "Your imaginary file has been deleted.", "success");   
            } else {     
                swal("Cancelled", "Your imaginary file is safe :)", "error");   
            } 
        });
    });

    //Custom Image
    $('#sa-image').click(function(){
        swal({   
            title: "Govinda!",   
            text: "Recently joined twitter",   
            imageUrl: "../plugins/images/users/govinda.jpg" 
        });
    });

    //Auto Close Timer
    $('#sa-close').click(function(){
         swal({   
            title: "Auto close alert!",   
            text: "I will close in 2 seconds.",   
            timer: 2000,   
            showConfirmButton: false 
        });
    });


    },
    //init
    $.SweetAlert = new SweetAlert, $.SweetAlert.Constructor = SweetAlert
}(window.jQuery),

//initializing 
function($) {
    "use strict";
    $.SweetAlert.init()
}(window.jQuery);