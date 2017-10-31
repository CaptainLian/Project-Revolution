'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const ActivityMonitoringModel = Object.create(null);

	const insertAMTActivityEvaluationSQL = queryFiles.insertAMTActivityEvaluation;
	
	ActivityMonitoringModel.insertAMTActivityEvaluation = function(param, connection = database) {
        
        return connection.none(insertAMTActivityEvaluationSQL, param);
    };


	return ActivityMonitoringModel;
};