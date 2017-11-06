'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const ActivityMonitoringModel = Object.create(null);

	const insertAMTActivityEvaluationSQL = queryFiles.insertAMTActivityEvaluation;
	const getAvailableActivityToCheck = queryFiles.getAvailableActivityToCheck;
	
	ActivityMonitoringModel.insertAMTActivityEvaluation = function(param, connection = database) {
        
        return connection.none(insertAMTActivityEvaluationSQL, param);
    };
    ActivityMonitoringModel.getAvailableActivityToCheck = function(param, connection = database){
    	 param = Object.create(null);
    	return connection.any(getAvailableActivityToCheck, param);
    };
    ActivityMonitoringModel.getActivityToCheck = function(param, connection = database){
    	 param = Object.create(null);
    	return connection.any(getAvailableActivityToCheck, param);
    }


	return ActivityMonitoringModel;
};