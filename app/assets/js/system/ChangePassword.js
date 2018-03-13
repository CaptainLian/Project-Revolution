(() => {
    const btnSubmit = document.querySelector('#Submit');

    const formPassword = document.querySelector('#PasswordForm');
    const inputOldPassword = document.querySelector('#OldPassword');
    const inputNewPassword1 = document.querySelector('#NewPassword1');
    const inputNewPassword2 = document.querySelector('#NewPassword2');

    const divError_PasswordMismatch = document.createElement('div');
    divError_PasswordMismatch.setAttribute('class', 'alert alert-danger fade in');
    divError_PasswordMismatch.setAttribute('id', '#ErrorAlert_NewPasswordMismatch');
    divError_PasswordMismatch.innerHTML = '<strong>Error</strong> New passwords does not match.';

    const divError_PasswordMatchOld = document.createElement('div');
    divError_PasswordMatchOld.setAttribute('class', 'alert alert-danger fade in');
    divError_PasswordMatchOld.setAttribute('id', '#ErrorAlert_PasswordMatchOld');
    divError_PasswordMatchOld.innerHTML = '<strong>Error</strong> New password matches old.';

    let currentAlert = null;
    const removeAlert = () => {
        if(currentAlert && currentAlert.parentNode){
            currentAlert.parentNode.removeChild(currentAlert);
            currentAlert = null;
        }
    };

    const setCurrentAlert = alert => {
        removeAlert();
        formPassword.appendChild(alert, btnSubmit);
        currentAlert = alert;
    };

    btnSubmit.addEventListener('click', event => {
        let ajax = Object.create(null);
        ajax.type = 'POST';
        ajax.url = '/System/AJAX/UpdatePassword';
        ajax.async = true;
        ajax.data = {
            oldPassword: inputOldPassword.value,
            newPassword1: inputNewPassword1.value,
            newPassword2: inputNewPassword2.value
        };

        ajax.success = (data, textStatus, jqXHR) => {
            const valid = data.valid;
            const success = data.success;
            const failureReason = data.failureReason;

            if(valid && success){
                window.location.replace(data.url);
            }else{
                switch(failureReason){
                    default:
                        console.log('wew');
                }
            }
        };

        ajax.error = (jqXHR, textStatus, errorThrown) => {
            console.error(errorThrown);
            $.toast({
                heading: 'Authentication Error!',
                text: 'Server Problem',
                position: 'top-center',
                loaderBg: '#ff6849',
                icon: 'error'
            });
        }

        $.ajax(ajax);
    });
    
    /**
     * @type {function}
     */
    const onNewPasswordChange = event => {
        if(inputNewPassword1.value !== inputNewPassword2.value){
            setCurrentAlert(divError_PasswordMismatch);
            btnSubmit.setAttribute('disabled', 'disabled');
        }else if(inputNewPassword1.value === inputOldPassword.value){
            setCurrentAlert(divError_PasswordMatchOld);
            btnSubmit.setAttribute('disabled', 'disabled');
        }else{
            removeAlert();
            btnSubmit.removeAttribute('disabled', 'disabled');
        }
    };

    inputNewPassword1.addEventListener('change', onNewPasswordChange);
    inputNewPassword2.addEventListener('change', onNewPasswordChange);
})();
