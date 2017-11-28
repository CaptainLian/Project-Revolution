'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/ADM';

	router.get(`${base}/Activity/List`, controllers.ADM_controller.viewActivityToCheck);
	router.get(`${base}/Activity/:id`, controllers.ADM_controller.viewActivity);


	router.post(`${base}/Activity/Save`, controllers.ADM_controller.updateStatus);
};

