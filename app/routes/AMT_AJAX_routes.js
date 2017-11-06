'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/AMT';
	
	router.post(`${base}/getActivity`, controllers.AMT_controller.insertToMyActivityToCheck);
	router.post(`${base}/deleteActivity`, controllers.AMT_controller.removeToMyActivity);

};
