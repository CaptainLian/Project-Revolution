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
    const getActivityTransactionsForSignatorySQL = queryFiles.getActivityTransactionsForSignatory;
    const checkCashAdvanceSignatorySQL = queryFiles.checkCashAdvanceSignatory;
    const getTransactionTotalPerActivityForSignatorySQL = queryFiles.getTransactionTotalPerActivityForSignatory;
    const insertPreActivityDirectPaymentSQL = queryFiles.insertPreActivityDirectPayment;
    const insertPreActivityDirectPaymentParticularSQL = queryFiles.insertPreActivityDirectPaymentParticular;
    const getPreActivityDirectPaymentSQL = queryFiles.getPreActivityDirectPayment;
    const getDirectPaymentParticularsSQL = queryFiles.getDirectPaymentParticulars;
    const pendDirectPaymentSQL = queryFiles.pendDirectPayment;
    const pendCashAdvanceSQL = queryFiles.pendCashAdvance;
    const getExpensesWithoutTransactionCountSQL = queryFiles.getExpensesWithoutTransactionCount;
    const getDirectPaymentSignatorySQL = queryFiles.getDirectPaymentSignatory;

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

    FinanceModel.getActivityTransactionsForSignatory = function(param, connection = database){
        return connection.any(getActivityTransactionsForSignatorySQL, param);
    };

    FinanceModel.checkCashAdvanceSignatory = function(param, connection = database){
        return connection.any(checkCashAdvanceSignatorySQL, param);
    };

    FinanceModel.getTransactionTotalPerActivityForSignatory = function(param, connection = database){
        return connection.any(getTransactionTotalPerActivityForSignatorySQL, param);
    };

    FinanceModel.insertPreActivityDirectPayment = function(param, connection = database){
        return connection.one(insertPreActivityDirectPaymentSQL, param);
    };

    FinanceModel.insertPreActivityDirectPaymentParticular = function(param, connection = database){
        return connection.none(insertPreActivityDirectPaymentParticularSQL, param);
    };

    FinanceModel.getPreActivityDirectPayment = function(param, connection = database){
        return connection.one(getPreActivityDirectPaymentSQL, param);
    };

    FinanceModel.getDirectPaymentParticulars = function(param, connection = database){
        return connection.any(getDirectPaymentParticularsSQL, param);
    };

    FinanceModel.pendDirectPayment = function(param, connection = database){
        return connection.none(pendDirectPaymentSQL, param);
    };

    FinanceModel.pendCashAdvance = function(param, connection = database){
        return connection.none(pendCashAdvanceSQL, param);
    };

    FinanceModel.getExpensesWithoutTransactionCount = function(param, connection = database){
        return connection.one(getExpensesWithoutTransactionCountSQL, param);
    };

    FinanceModel.getDirectPaymentSignatory = function(param, connection = database){
        return connection.oneOrNone(getDirectPaymentSignatory, param);
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

    //Used for signing
    FinanceModel.getPreActivityDirectPaymentDetails = (directPaymentID, fields, connection = database) => {
        logger.debug(`getPreActivityDirectPaymentDetails(directPaymentID: ${directPaymentID})`, log_options);

        let query = squel.select()
            .from('"PreActivityDirectPayment"', 'padp')
             .left_join('"PreActivityDirectPaymentStatus"', 'padps', 'padp.status = padps.id')
             .left_join('Account', 'a', 'padp."submittedBy" = a.idNumber')
            .where('padp."id" = ${directPaymentID}');
        attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.directPaymentID = directPaymentID;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.one(query, param);
    };

    //Used for signing
    FinanceModel.getPreActivityDirectPaymentParticularDetails = (directPaymentID, fields, connection = database) => {
        logger.debug(`getPreActivityDirectPaymentParticularDetails(directPaymentID: ${directPaymentID})`, log_options);

        let query = squel.select()
            .from('"PreActivityDirectPaymentParticular"', 'padpp')
                .left_join('ProjectProposalExpenses', 'ppe', 'padpp."particular" = ppe.id')
                .left_join('ExpenseType', 'et', 'ppe.type = et.id')
            .where('precap."cashAdvance" = ${directPaymentID}');
        attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.directPaymentID = directPaymentID;

        logger.debug(query, log_options);
        return connection.any(query, param);
    };

	return FinanceModel;
};
