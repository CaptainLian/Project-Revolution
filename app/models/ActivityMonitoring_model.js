'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const ActivityMonitoringModel = Object.create(null);

	const insertAMTActivityEvaluationSQL = queryFiles.insertAMTActivityEvaluation;
    const updateAMTActivityEvaluationSQL = queryFiles.updateAMTActivityEvaluation;

    const insertAMTActivityEvaluation = queryFiles.insertAmtActivityEvaluation;
    const deleteToMyActivity = queryFiles.deleteAmtActivityEvaluation;
	const getAvailableActivityToCheck = queryFiles.getAvailableActivityToCheck;
    const getAmtMyActivity = queryFiles.getAmtMyActivity;
	
	ActivityMonitoringModel.insertAMTActivityEvaluation = function(param, connection = database) {
        
        return connection.none(insertAMTActivityEvaluationSQL, param);
    };
    ActivityMonitoringModel.updateAMTActivityEvaluation = function(param, connection = database) {
        return connection.none(updateAMTActivityEvaluationSQL, param);
    };
    ActivityMonitoringModel.getAvailableActivityToCheck = function(param, connection = database){
    	 param = Object.create(null);
    	return connection.any(getAvailableActivityToCheck, param);
    };
    ActivityMonitoringModel.getActivityToCheck = function(param, connection = database){
    	 param = Object.create(null);
    	return connection.any(getAvailableActivityToCheck, param);
    };

    ActivityMonitoringModel.getAmtMyActivity = function(param, connection = database){
         
        return connection.any(getAmtMyActivity, param);
    };

    ActivityMonitoringModel.insertToMyActivityToCheck = function(param, connection = database){
         
        return connection.any(insertAMTActivityEvaluation, param);
    };

    ActivityMonitoringModel.deleteToMyActivity = function(param, connection = database){
         
        return connection.result(deleteToMyActivity, param);
    }



	return ActivityMonitoringModel;
};