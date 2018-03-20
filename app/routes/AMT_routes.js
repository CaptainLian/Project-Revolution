'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/AMT';
	router.get(`${base}/EvaluateActivity/:activity`, controllers.AMT_controller.viewActivityEvaluation);
	router.get(`${base}/AssignActivity`, controllers.AMT_controller.viewActivity);
	router.get(`${base}/AMTHome`, controllers.AMT_controller.viewHome);


	router.post(`${base}/EvaluateActivity`, controllers.AMT_controller.submitActivityEvaluation);

};
