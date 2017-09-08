const csrfToken = $('meta[data-name="csrf"]').data('token');

//Alerts
$(".myadmin-alert .closed").click(function(event) {
    $(this).parents(".myadmin-alert").fadeToggle(250);
    return false;
});
/* Click to close */
$(".myadmin-alert-click").click(function(event) {
    $(this).fadeToggle(250);
    return false;
});

//https://github.com/kamranahmedse/jquery-toast-plugin
$(".error").click(function() {
    let credential = $('#input_credential').val();
    let password = $('#input_password').val();
    
    if(credential == ''){
    	$.toast({
            text: "Warning", // Text that is to be shown in the toast
            heading: 'Please input E-mail or ID Number', // Optional heading to be shown on the toast
            icon: 'warning', // Type of toast icon
            showHideTransition: 'slide', // fade, slide or plain
            allowToastClose: true, // Boolean value true or false
            hideAfter: 1500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
            stack: 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
            position: 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
        });
    }else if(password == ''){
    	$.toast({
            text: "Warning", // Text that is to be shown in the toast
            heading: 'Please input password', // Optional heading to be shown on the toast
            icon: 'warning', // Type of toast icon
            showHideTransition: 'slide', // fade, slide or plain
            allowToastClose: true, // Boolean value true or false
            hideAfter: 1500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
            stack: 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
            position: 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values
        });
    }else{
        $.ajax({
            type: 'POST',
            url: '/',
            data: {
                credential: credential,
                password: password,
                _csrf: csrfToken
            },
            async: true,
            success: function(data, textStatus, jqXHR) {
                console.log(data);
                if (!data.valid) {
                    $.toast({
                        heading: 'Login Failed!',
                        text: 'Invalid username and/or password.',
                        position: 'top-center',
                        loaderBg: '#ff6849',
                        icon: 'error',
                        hideAfter: 1500
                    });
                } else {
                    $.toast().reset('all');

                    $.toast({
                        text: "Success!", // Text that is to be shown in the toast
                        heading: 'Logged-in successfully', // Optional heading to be shown on the toast
                        icon: 'success', // Type of toast icon
                        showHideTransition: 'slide', // fade, slide or plain
                        allowToastClose: true, // Boolean value true or false
                        hideAfter: 1500, // false to make it sticky or number representing the miliseconds as time after which toast needs to be hidden
                        stack: 5, // false if there should be only one toast at a time or a number representing the maximum number of toasts to be shown at a time
                        position: 'top-center', // bottom-left or bottom-right or bottom-center or top-left or top-right or top-center or mid-center or an object representing the left, right, top, bottom values

                        textAlign: 'left', // Text alignment i.e. left, right or center
                    });
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(errorThrown);
                $.toast({
                    heading: 'Authentication Error!',
                    text: 'Server Problem',
                    position: 'top-center',
                    loaderBg: '#ff6849',
                    icon: 'error'
                });
            }
        }); //$.ajax()
    }
});