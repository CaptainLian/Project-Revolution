'use strict';
module.exports = function(configuration, modules, router, controllers){

	//APPROVE BY PNP OFFICERS
	router.post('/PNP/Pubs/checking', controllers.PNP_AJAX_controller.pubsChecked);

	
};
