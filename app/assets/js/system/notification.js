'use strict';

(() => {
	if(typeof $ === 'undefined'){
		console.error('WARNING: JQUERY NEEDED FOR THIS PAGE');
        return;
	}

    $('#slimtest1').slimScroll({
        height: '250px',
        alwaysVisible: true,
        color: '#424242'
    });

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
        let seenClass = '';
        if(status != 1){
            seenClass = 'notif_unseen';
        }
        const notifDOM = `<a href="#" class="${seenClass}">
                            <span class="profile-status online pull-right"></span>
                            <div class="mail-content breaks">
                                <h5>${title}</h5>
                                <span class="mail-desc">
                                    <small>${description}</small>
                                </span>
                                <br />
                                <span class="time text-gray">
                                <small>${timestamp}</small></span>
                            </div>
                          </a>`;

        $(viewNotifs).append(notifDOM)
    }
    getNotifications();
    setInterval(getNotifications, 60000);
})();
