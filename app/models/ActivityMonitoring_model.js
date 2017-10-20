'use strict';

module.exports = function(database, queryFiles){	
	const ActivityMonitoringModel = Object.create(null);

	const insertAMTActivityEvaluationSQL = queryFiles.insertAMTActivityEvaluation;
	
	ActivityMonitoringModel.insertAMTActivityEvaluation = function(param, connection = this._db) {
        
        return connection.none(insertAMTActivityEvaluationSQL, param);
    };


	return ActivityMonitoringModel;
};