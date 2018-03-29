'use strict';

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
        let usrDOM = document.createElement('div');
        
        let statusDOM = document.createElement('span');
        
        usrDOM.appendChild(statusDOM);

        let contentDOM = document.createElement('div');
        let titleDOM = document.createElement('h5');
        titleDOM.innerHTML = title;
        let descriptionDOM = document.createElement('span');
        descriptionDOM.innerHTML = description;
        let timestampDOM = document.createElement('span');
        timestampDOM.innerHTML = timestamp;
        
        usrDOM.classList.add('user-img');
        statusDOM.classList.add('profile-status');
        statusDOM.classList.add('online');
        statusDOM.classList.add('pull-right');
        contentDOM.classList.add('mail-content');
        if(status == 1){
            contentDOM.classList.add('notif_seen');
        }else{
            contentDOM.classList.add('notif_unseen');
        }
        descriptionDOM.classList.add('mail-desc');
        timestampDOM.classList.add('time');

        contentDOM.appendChild(titleDOM);
        contentDOM.appendChild(descriptionDOM);
        contentDOM.appendChild(timestampDOM);

        viewNotifs.appendChild(usrDOM);
        viewNotifs.appendChild(contentDOM);

    }
    getNotifications();
    setInterval(getNotifications, 60000);

})();