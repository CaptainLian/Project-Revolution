'use strict';
module.exports = function(configuration, modules, router, controllers, models, database, queryFiles){
	const base = '/AMT';
	router.get(`${base}/EvaluateActivity`, controllers.AMT_controller.viewActivityEvaluation);

	router.post(`${base}/EvaluateActivity`, controllers.AMT_controller.submitActivityEvaluation);
};
