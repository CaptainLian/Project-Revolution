$.ajaxSetup({
    beforeSend: function(xhr) {
        xhr.setRequestHeader('X-CSRF-TOKEN', $('meta[data-name="csrf"]').data('token'));
    }
});	