'use strict';

const squel = require('squel').useFlavour('postgres');
module.exports = function(configuration, modules, database, queryFiles){
	const ActivityMonitoringModel = Object.create(null);

	const insertAMTActivityEvaluationSQL = queryFiles.insertAMTActivityEvaluation;
    const updateAMTActivityEvaluationSQL = queryFiles.updateAMTActivityEvaluation;

    const insertAMTActivityEvaluation = queryFiles.insertAMTActivityEvaluation;
    const deleteToMyActivity = queryFiles.deleteAmtActivityEvaluation;
	const getAvailableActivityToCheck = queryFiles.getAvailableActivityToCheck;
    const getAmtMyActivity = queryFiles.getAmtMyActivity;

    const getAllAMTEvaluationResultsSQL = queryFiles.getAllAMTEvaluationResults;
    const getAllAMTScoreAveragesSQL = queryFiles.getAllAMTScoreAverages;

    const getAllAMTEvaluationSQL = queryFiles.getAllAMTEvaluation;

	ActivityMonitoringModel.insertAMTActivityEvaluation = function(param, connection = database) {
        return connection.none(insertAMTActivityEvaluationSQL, param);
    };

    ActivityMonitoringModel.updateAMTActivityEvaluation = function(param, connection = database) {
        return connection.none(updateAMTActivityEvaluationSQL, param);
    };

    ActivityMonitoringModel.getAvailableActivityToCheck = function(param, connection = database){
    	return connection.any(getAvailableActivityToCheck, param);
    };
    
    ActivityMonitoringModel.getActivityToCheck = function(param, connection = database){
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
    };

    ActivityMonitoringModel.viewOrgMyActivity = function(idNumber, connection = database){
          var query = squel.select()
            .from('GOSMActivity','GA')

            .join(squel.select().from("ProjectProposal").where("status = 3"),'PP','GA.ID = PP.GOSMActivity')
            
            .join('GOSM','G','G.ID = GA.GOSM')
            .join(squel.select().from("GOSMActivityProjectHead").where("idNumber = ?",idNumber),'GAPH','GA.ID = GAPH.ActivityID')
            .join('AMTActivityEvaluation','AAE','AAE.Activity = GA.ID')
            .field('*')
            .field('AAE.status as aaestatus')


            
            .where(squel.expr().or("GA.ActivityType = 3").or("GA.ActivityType = 2").or("GA.ActivityNature = 1"))
            .where("G.TERMID = ?", squel.str('system_get_current_term_id()'))            
        console.log("=========================")    
        console.log(query.toString())
        return connection.any(query.toString());



    };

    ActivityMonitoringModel.getAllAMTEvaluationResults = function(param, connection = database){
        return connection.any(getAllAMTEvaluationResultsSQL, param);
    };

    ActivityMonitoringModel.getAllAMTScoreAverages = function(param, connection = database){
        return connection.oneOrNone(getAllAMTScoreAveragesSQL, param);
    };

    ActivityMonitoringModel.getAllAMTEvaluation = function(connection = database){
        return connection.any(getAllAMTEvaluationSQL);
    };

	return ActivityMonitoringModel;
};
