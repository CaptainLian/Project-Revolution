'use strict';
module.exports = function(configuration, modules, router, controllers){

	router.get('/PNP/ViewPubs', controllers.PNP_controller.viewPubs);
	router.get('/PNP/Pubs/List', controllers.PNP_controller.viewPubsList);
};
