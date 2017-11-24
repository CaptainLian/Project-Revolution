'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
    const squel = require('squel').useFlavour('postgres');
    
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
    const updatePreActivityCashAdvanceStatusSQL = queryFiles.updatePreActivityCashAdvanceStatus;
    const getActivityTransactionsForSignatorySQL = queryFiles.getActivityTransactionsForSignatory;
    const checkCashAdvanceSignatorySQL = queryFiles.checkCashAdvanceSignatory;
    const getTransactionTotalPerActivityForSignatorySQL = queryFiles.getTransactionTotalPerActivityForSignatory;

    const attachFields = require('../utility/databaseHelper').attachFields;
	
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Finance-Model';

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

    FinanceModel.updatePreActivityCashAdvanceStatus = function(param, connection = database){
        return connection.none(updatePreActivityCashAdvanceStatusSQL, param);
    };

    FinanceModel.getActivityTransactionsForSignatory = function(param, connection = database){
        return connection.any(getActivityTransactionsForSignatorySQL, param);
    };

    FinanceModel.checkCashAdvanceSignatory = function(param, connection = database){
        return connection.any(checkCashAdvanceSignatorySQL, param);
    };  

    FinanceModel.getTransactionTotalPerActivityForSignatory = function(param, connection = database){
        return connection.any(getTransactionTotalPerActivityForSignatorySQL, param);
    };

    //Used for signing
    FinanceModel.getPreActivityCashAdvanceDetails = (cashAdvanceID, fields, connection = database) => {
        logger.debug(`getPreActivityCashAdvanceDetails(cashAdvanceID: ${cashAdvanceID})`, log_options);
        let query = squel.select()
        .from('"PreActivityCashAdvance"', 'preca')
         .left_join('"PreActivityCashAdvanceStatus"', 'pacas', 'preca.status = pacas.id')
         .left_join('Account', 'a', 'preca."submittedBy" = a.idNumber')
        .where('preca."id" = ${cashAdvanceID}');
        attachFields(query, fields);

        query = query.toString();

        logger.debug(query, log_options);
        return connection.one(query, {
            cashAdvanceID: cashAdvanceID
        });
    };

    //Used for signing
    FinanceModel.getPreActivityCashAdvanceParticularDetails = (cashAdvanceID, fields, connection = database) => {
        logger.debug(`getPreActivityCashAdvanceDetails(cashAdvanceID: ${cashAdvanceID})`, log_options);
        let query = squel.select()
        .from('"PreActivityCashAdvanceParticular"', 'precap')
         .left_join('ProjectProposalExpenses', 'ppe', 'precap."particular" = ppe.id')
         .left_join('ExpenseType', 'et', 'ppe.type = et.id')
        .where('precap."cashAdvance" = ${cashAdvanceID}');
        attachFields(query, fields);

        query = query.toString();

        logger.debug(query, log_options);
        return connection.any(query, {
            cashAdvanceID: cashAdvanceID
        });
    };
	return FinanceModel;
};