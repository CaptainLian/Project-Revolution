'use strict';
$('#slimtest1').slimScroll({
    height: '250px',
    
    alwaysVisible: true,
    color: '#424242'
});
(() => {
	if(typeof $ === 'undefined'){
		console.error('WARNING: JQUERY NEEDED FOR THIS PAGE');
        return;
	}
    
    let numUnread = 0;
	let maxSequence = 0;
	let viewNotifs = document.getElementById('display_notifications');
    let anchorNotifDropdown = document.getElementById('dropdown_notification');
    let numNotificationDOM = document.getElementById('display_numNotifications');

    anchorNotifDropdown.addEventListener('click', () => {
        console.debug('Notif dropdown: clicked');
        getNotifications();

        return $.ajax({
            method: 'POST',
            url:'/System/AJAX/ViewAccountNotifications',
            data: {
                maxSequence: maxSequence
            },
            error: (jqXHR, textStatus, errorThrown) => {
                console.error(errorThrown);
            },
            success: (notifs, textStatus, jqXHR ) => {
                numUnread = 0;
                numNotificationDOM.innerHTML = '';

                let elements = document.querySelectorAll('.notif_unseen');
                for(const dom of elements){
                    dom.classList.remove('notif_unseen');
                    dom.classList.add('notif_seen');
                }
            }
        });
    });
   
    function getNotifications() {
        return $.ajax({
    		method: 'GET',
    		url:'/System/AJAX/GetAccountNotifications',
    		data: {
                minSequence: maxSequence
    		},
    		error: (jqXHR, textStatus, errorThrown) => {
                console.error(errorThrown);
    		},
    		success: (notifs, textStatus, jqXHR ) => {
                for(const notif of (notifs ? notifs: [])){
                    maxSequence = Math.max(maxSequence, notif.sequence);
                    if(notif.status != 1){
                    	numUnread++;
                    	numNotificationDOM.innerHTML = numUnread;
                    }

                    addNotifDOM(notif.title, notif.description, notif.displayDate, notif.status);
                }
    		}
    	});
    }

    function addNotifDOM(title, description, timestamp, status){
        var test =
          '<a href="#">'+
                '<span class="profile-status online pull-right"></span>'+
                '<div class="mail-content breaks">'+
                '<h5>'+title+'</h5> <span class="mail-desc"><small>'+description+'</small></span><br><span class="time"><small>'+timestamp+'</small></span> </div>'+
            '</a>';
                                    
        $("#display_notifications").append(test)

    }
    getNotifications();
    setInterval(getNotifications, 60000);

})();