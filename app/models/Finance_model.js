'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const FinanceModel = Object.create(null);

    const insertPreActivityCashAdvanceSQL = queryFiles.insertPreActivityCashAdvance;
    const insertPreActivityCashAdvanceParticularSQL = queryFiles.insertPreActivityCashAdvanceParticular;
    const getParticularsSQL = queryFiles.getParticulars;

	
	FinanceModel.insertPreActivityCashAdvance = function(param, connection = database) {
        
        return connection.one(insertPreActivityCashAdvanceSQL, param);
    };

    FinanceModel.insertPreActivityCashAdvanceParticular = function(param, connection = database){

        return connection.none(insertPreActivityCashAdvanceParticularSQL, param);
    };

    FinanceModel.getParticulars = function(param, connection = database){
        return connection.any(getParticularsSQL, param);
    };

	return FinanceModel;
};