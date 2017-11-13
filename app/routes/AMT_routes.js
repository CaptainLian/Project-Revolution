'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/AMT';
	router.get(`${base}/EvaluateActivity/:activity`, controllers.AMT_controller.viewActivityEvaluation);
	router.get(`${base}/AssignActivity`, controllers.AMT_controller.viewActivity);


	router.post(`${base}/EvaluateActivity`, controllers.AMT_controller.submitActivityEvaluation);

};
