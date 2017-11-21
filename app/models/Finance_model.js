'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const FinanceModel = Object.create(null);

    const insertPreActivityCashAdvanceSQL = queryFiles.insertPreActivityCashAdvance;
    const insertPreActivityCashAdvanceParticularSQL = queryFiles.insertPreActivityCashAdvanceParticular;
    const getParticularsSQL = queryFiles.getParticulars;
    const getActivitiesWithFinancialDocumentsSQL = queryFiles.getActivitiesWithFinancialDocuments;
    const getTransactionTotalPerActivitySQL = queryFiles.getTransactionTotalPerActivity;
    const getApprovedTransactionTotalPerActivitySQL = queryFiles.getApprovedTransactionTotalPerActivity;
    const getActivityTransactionsSQL = queryFiles.getActivityTransactions;
    const getPreActivityCashAdvanceSQL = queryFiles.getPreActivityCashAdvance;
    const getCashAdvanceParticularsSQL = queryFiles.getCashAdvanceParticulars;

	
	FinanceModel.insertPreActivityCashAdvance = function(param, connection = database) {
        
        return connection.one(insertPreActivityCashAdvanceSQL, param);
    };

    FinanceModel.insertPreActivityCashAdvanceParticular = function(param, connection = database){

        return connection.none(insertPreActivityCashAdvanceParticularSQL, param);
    };

    FinanceModel.getParticulars = function(param, connection = database){
        return connection.any(getParticularsSQL, param);
    };

    FinanceModel.getActivitiesWithFinancialDocuments = function(connection = database){
        return connection.any(getActivitiesWithFinancialDocumentsSQL);
    };

    FinanceModel.getTransactionTotalPerActivity = function(connection = database){
        return connection.any(getTransactionTotalPerActivitySQL);
    };

    FinanceModel.getApprovedTransactionTotalPerActivity = function(connection = database){
        return connection.any(getApprovedTransactionTotalPerActivitySQL);
    };

    FinanceModel.getActivityTransactions = function(param, connection = database){
        return connection.any(getActivityTransactionsSQL, param);
    };

    FinanceModel.getPreActivityCashAdvance = function(param, connection = database){
        return connection.one(getPreActivityCashAdvanceSQL, param);
    };

    FinanceModel.getCashAdvanceParticulars = function(param, connection = database){
        return connection.any(getCashAdvanceParticularsSQL, param);
    };

	return FinanceModel;
};