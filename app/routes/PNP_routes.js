'use strict';
module.exports = function(configuration, modules, router, controllers){

	router.get('/PNP/ViewPubs', controllers.PNP_controller.viewPubs);
	router.get('/PNP/Pubs/List', controllers.PNP_controller.viewPubsList);
	router.get('/PNP/main', controllers.PNP_controller.viewHome);
 
	//PUBS PER ACTIVITY
	router.get('/PNP/Pubs/:gosmid', controllers.PNP_controller.viewSpecificPubs);
};
