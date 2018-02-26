'use strict';

module.exports = function(configuration, modules, database, queryFiles){
    const squel = require('squel').useFlavour('postgres');


	const FinanceModel = Object.create(null);
    

    const attachFields = require('../utility/databaseHelper').attachFields;

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Finance-Model';


    const insertPreActivityCashAdvanceSQL = queryFiles.insertPreActivityCashAdvance;
	FinanceModel.insertPreActivityCashAdvance = function(param, connection = database) {
        return connection.one(insertPreActivityCashAdvanceSQL, param);
    };

    const insertPreActivityCashAdvanceParticularSQL = queryFiles.insertPreActivityCashAdvanceParticular;
    FinanceModel.insertPreActivityCashAdvanceParticular = function(param, connection = database){
        return connection.none(insertPreActivityCashAdvanceParticularSQL, param);
    };

    const getParticularsSQL = queryFiles.getParticulars;
    FinanceModel.getParticulars = function(param, connection = database){
        return connection.any(getParticularsSQL, param);
    };

    const getActivitiesWithFinancialDocumentsSQL = queryFiles.getActivitiesWithFinancialDocuments;
    FinanceModel.getActivitiesWithFinancialDocuments = function(connection = database){
        return connection.any(getActivitiesWithFinancialDocumentsSQL);
    };

    const getTransactionTotalPerActivitySQL = queryFiles.getTransactionTotalPerActivity;
    FinanceModel.getTransactionTotalPerActivity = function(connection = database){
        return connection.any(getTransactionTotalPerActivitySQL);
    };

    const getApprovedTransactionTotalPerActivitySQL = queryFiles.getApprovedTransactionTotalPerActivity;
    FinanceModel.getApprovedTransactionTotalPerActivity = function(connection = database){
        return connection.any(getApprovedTransactionTotalPerActivitySQL);
    };

    const getActivityTransactionsSQL = queryFiles.getActivityTransactions;
    FinanceModel.getActivityTransactions = function(param, connection = database){
        return connection.any(getActivityTransactionsSQL, param);
    };

    const getPreActivityCashAdvanceSQL = queryFiles.getPreActivityCashAdvance;
    FinanceModel.getPreActivityCashAdvance = function(param, connection = database){
        return connection.one(getPreActivityCashAdvanceSQL, param);
    };

    const getCashAdvanceParticularsSQL = queryFiles.getCashAdvanceParticulars;
    FinanceModel.getCashAdvanceParticulars = function(param, connection = database){
        return connection.any(getCashAdvanceParticularsSQL, param);
    };

    const getActivityTransactionsForSignatorySQL = queryFiles.getActivityTransactionsForSignatory;
    FinanceModel.getActivityTransactionsForSignatory = function(param, connection = database){
        return connection.any(getActivityTransactionsForSignatorySQL, param);
    };

    const checkCashAdvanceSignatorySQL = queryFiles.checkCashAdvanceSignatory;
    FinanceModel.checkCashAdvanceSignatory = function(param, connection = database){
        return connection.oneOrNone(checkCashAdvanceSignatorySQL, param);
    };

    const getTransactionTotalPerActivityForSignatorySQL = queryFiles.getTransactionTotalPerActivityForSignatory;
    FinanceModel.getTransactionTotalPerActivityForSignatory = function(param, connection = database){
        return connection.any(getTransactionTotalPerActivityForSignatorySQL, param);
    };

    const insertPreActivityDirectPaymentSQL = queryFiles.insertPreActivityDirectPayment;
    FinanceModel.insertPreActivityDirectPayment = function(param, connection = database){
        return connection.one(insertPreActivityDirectPaymentSQL, param);
    };

    const insertPreActivityDirectPaymentParticularSQL = queryFiles.insertPreActivityDirectPaymentParticular;
    FinanceModel.insertPreActivityDirectPaymentParticular = function(param, connection = database){
        return connection.none(insertPreActivityDirectPaymentParticularSQL, param);
    };

    const getPreActivityDirectPaymentSQL = queryFiles.getPreActivityDirectPayment;
    FinanceModel.getPreActivityDirectPayment = function(param, connection = database){
        return connection.one(getPreActivityDirectPaymentSQL, param);
    };

    const getDirectPaymentParticularsSQL = queryFiles.getDirectPaymentParticulars;
    FinanceModel.getDirectPaymentParticulars = function(param, connection = database){
        return connection.any(getDirectPaymentParticularsSQL, param);
    };

    const pendDirectPaymentSQL = queryFiles.pendDirectPayment;
    FinanceModel.pendDirectPayment = function(param, connection = database){
        return connection.none(pendDirectPaymentSQL, param);
    };

    const pendCashAdvanceSQL = queryFiles.pendCashAdvance;
    FinanceModel.pendCashAdvance = function(param, connection = database){
        return connection.none(pendCashAdvanceSQL, param);
    };

    const getExpensesWithoutTransactionCountSQL = queryFiles.getExpensesWithoutTransactionCount;
    FinanceModel.getExpensesWithoutTransactionCount = function(param, connection = database){
        return connection.one(getExpensesWithoutTransactionCountSQL, param);
    };

    const getDirectPaymentSignatorySQL = queryFiles.getDirectPaymentSignatory;
    FinanceModel.getDirectPaymentSignatory = function(param, connection = database){
        return connection.oneOrNone(getDirectPaymentSignatorySQL, param);
    };

    const insertReimbursementSQL = queryFiles.insertReimbursement;
    FinanceModel.insertReimbursement = function(param, connection = database){
        return connection.one(insertReimbursementSQL, param);
    };

    const insertReimbursementParticularSQL = queryFiles.insertReimbursementParticular;
    FinanceModel.insertReimbursementParticular = function(param, connection = database){
        return connection.none(insertReimbursementParticularSQL, param);
    };

    const insertPreActivityBookTransferSQL = queryFiles.insertPreActivityBookTransfer;
    FinanceModel.insertPreActivityBookTransfer = function(param, connection = database){
        return connection.one(insertPreActivityBookTransferSQL, param);
    };

    const insertPreActivityBookTransferParticularSQL = queryFiles.insertPreActivityBookTransferParticular;
    FinanceModel.insertPreActivityBookTransferParticular = function(param, connection = database){
        return connection.none(insertPreActivityBookTransferParticularSQL, param);
    };

    const getPreActivityBookTransferSQL = queryFiles.getPreActivityBookTransfer;
    FinanceModel.getPreActivityBookTransfer = function(param, connection = database){
        return connection.one(getPreActivityBookTransferSQL, param);
    };

    const getPostProjectReimbursementSQL = queryFiles.getPostProjectReimbursement;
    FinanceModel.getPostProjectReimbursement = function(param, connection = database){
        return connection.one(getPostProjectReimbursementSQL, param);
    };

    const getBookTransferSignatorySQL = queryFiles.getBookTransferSignatory;
    FinanceModel.getBookTransferSignatory = function(param, connection = database){
        return connection.oneOrNone(getBookTransferSignatorySQL, param);
    };

    const getReimbursementSignatorySQL = queryFiles.getReimbursementSignatory;
    FinanceModel.getReimbursementSignatory = function(param, connection = database){
        return connection.oneOrNone(getReimbursementSignatorySQL, param);
    };

    const getBookTransferParticularsSQL = queryFiles.getBookTransferSignatory;
    FinanceModel.getBookTransferParticulars = function(param, connection = database){
        return connection.any(getBookTransferParticularsSQL, param);
    };

    const getReimbursementParticularsSQL = queryFiles.getReimbursementParticulars;
    FinanceModel.getReimbursementParticulars = function(param, connection = database){
        return connection.any(getReimbursementParticularsSQL, param);
    };

    const approveReimbursementSQL  = queryFiles.approveReimbursement;
    FinanceModel.approveReimbursement = function(param, connection = database){
        return connection.none(approveReimbursementSQL, param);
    };

    const pendReimbursementSQL = queryFiles.pendReimbursement;
    FinanceModel.pendReimbursement = function(param, connection = database){
        return connection.none(pendReimbursementSQL, param);
    };

    const approveBookTransferSQL = queryFiles.approveBookTransfer;
    FinanceModel.approveBookTransfer = function(param, connection = database){
        return connection.none(approvebookTransferSQL, param);
    };

    const pendBookTransferSQL = queryFiles.pendbookTransfer;
    FinanceModel.pendBookTransfer = function(param, connection = database){
        return connection.none(pendBookTransferSQL, param);
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

    
    const getNextSignantorySQL = queryFiles.finance_get_next_signatory;
    FinanceModel.getPreActivityDirectPaymentNextSignatory = (directPaymentID, connection = database) => {
        logger.debug(`getPreActivityDirectPaymentNextSignatory(directPaymentID: ${directPaymentID})`, log_options);

        let param = Object.create(null);
        param.financeTable = 'PreActivityDirectPaymentSignatory';
        param.tableAcronym = 'padps';
        param.column = 'bookTransfer';
        param.value = directPaymentID;

        return connection.oneOrNone(getNextSignantorySQL, param);
    };

    FinanceModel.getPreActivityCashAdvanceNextSignatory = (cashAdvanceID, connection = database) => {
        logger.debug(`getPreActivityCashAdvanceNextSignatory(cashAdvanceID: ${directPaymentID})`, log_options);

        let param = Object.create(null);
        param.financeTable = 'PreActivityCashAdvanceSignatory';
        param.tableAcronym = 'pacas';
        param.column = 'cashAdvance';
        param.value = cashAdvanceID;

        return connection.oneOrNone(getNextSignantorySQL, param);
    };

	return FinanceModel;
};
