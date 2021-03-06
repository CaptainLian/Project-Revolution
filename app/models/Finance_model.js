'use strict';

module.exports = function(configuration, modules, database, queryFiles){
    const squel = require('squel').useFlavour('postgres');

    const attachFields = require('../utility/databaseHelper').attachFields;

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Finance-Model';

    const FinanceModel = Object.create(null);

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
        logger.info(`call getPreActivityCashAdvance(${JSON.stringify(param)})`, log_options);
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

    const getExpensesWithoutTransactionCountSQL = queryFiles.getExpensesWithoutTransactionCount;
    FinanceModel.getExpensesWithoutTransactionCount = function(param, connection = database){
        return connection.oneOrNone(getExpensesWithoutTransactionCountSQL, param);
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
        logger.debug(`insertPreActivityBookTransfer(${JSON.stringify(param)})`, log_options);

        logger.debug(`Executing query: ${insertPreActivityBookTransferSQL}`, log_options);
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

    const getBookTransferParticularsSQL = queryFiles.getBookTransferParticulars;
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
        return connection.none(approveBookTransferSQL, param);
    };

    const pendBookTransferSQL = queryFiles.pendBookTransfer;
    FinanceModel.pendBookTransfer = function(param, connection = database){
        return connection.none(pendBookTransferSQL, param);
    };

    const getCashAdvancePendSignatorySQL = queryFiles.getCashAdvancePendSignatory;
    FinanceModel.getCashAdvancePendSignatory = function(param, connection = database){
        return connection.one(getCashAdvancePendSignatorySQL, param);
    };

    const getDirectPaymentPendSignatorySQL = queryFiles.getDirectPaymentPendSignatory;
    FinanceModel.getDirectPaymentPendSignatory = function(param, connection = database){
        return connection.one(getDirectPaymentPendSignatorySQL, param);
    };

    const getBookTransferPendSignatorySQL = queryFiles.getBookTransferPendSignatory;
    FinanceModel.getBookTransferPendSignatory = function(param, connection = database){
        return connection.one(getBookTransferPendSignatorySQL, param);
    };

    const getReimbursementPendSignatorySQL = queryFiles.getReimbursementPendSignatory;
    FinanceModel.getReimbursementPendSignatory = function(param, connection = database){
        return connection.one(getReimbursementPendSignatorySQL, param);
    };

    const resubmitCashAdvanceSQL = queryFiles.resubmitCashAdvance;
    FinanceModel.resubmitCashAdvance = function(param, connection = database){
        return connection.none(resubmitCashAdvanceSQL, param);
    };

    const deleteCashAdvanceParticularsSQL = queryFiles.deleteCashAdvanceParticulars;
    FinanceModel.deleteCashAdvanceParticulars = function(param, connection = database){
        return connection.none(deleteCashAdvanceParticularsSQL, param);
    };

    const resubmitCashAdvanceSignatorySQL = queryFiles.resubmitCashAdvanceSignatory;
    FinanceModel.resubmitCashAdvanceSignatory = function(param, connection = database){
        return connection.none(resubmitCashAdvanceSignatorySQL, param);
    };

    const resubmitReimbursementSQL = queryFiles.resubmitReimbursement;
    FinanceModel.resubmitReimbursement = function(param, connection = database){
        return connection.none(resubmitReimbursementSQL, param);
    };

    const resubmitReimbursementSignatorySQL = queryFiles.resubmitReimbursementSignatory;
    FinanceModel.resubmitReimbursementSignatory = function(param, connection = database){
        return connection.none(resubmitReimbursementSignatorySQL, param);
    };

    const resubmitDirectPaymentSQL = queryFiles.resubmitDirectPayment;
    FinanceModel.resubmitDirectPayment = function(param, connection = database){
        return connection.none(resubmitDirectPaymentSQL, param);
    };

    const resubmitDirectPaymentSignatorySQL = queryFiles.resubmitDirectPaymentSignatory;
    FinanceModel.resubmitDirectPaymentSignatory = function(param, connection = database){
        return connection.none(resubmitDirectPaymentSignatorySQL, param);
    };

    const resubmitBookTransferSQL = queryFiles.resubmitBookTransfer;
    FinanceModel.resubmitBookTransfer = function(param, connection = database){
        return connection.none(resubmitBookTransferSQL, param);
    };

    const resubmitBookTransferSignatorySQL = queryFiles.resubmitBookTransferSignatory;
    FinanceModel.resubmitBookTransferSignatory = function(param, connection = database){
        return connection.none(resubmitBookTransferSignatorySQL, param);
    };

    const getBookTransferEstablishmentSQL = queryFiles.getBookTransferEstablishment;
    FinanceModel.getBookTransferEstablishment = function(connection = database){
        return connection.any(getBookTransferEstablishmentSQL);
    };

    const getAllApprovedTransactionsSQL = queryFiles.getAllApprovedTransactions;
    FinanceModel.getAllApprovedTransactions = function(param, connection = database){
        return connection.any(getAllApprovedTransactionsSQL, param);
    };

    const getAllApprovedActivityExpensesSQL = queryFiles.getAllApprovedActivityExpenses;
    FinanceModel.getAllApprovedActivityExpenses = function(param, connection = database){
        return connection.any(getAllApprovedActivityExpensesSQL, param);
    };

    const getOrganizationBudgetExpensesSQL = queryFiles.getOrganizationBudgetExpenses;
    FinanceModel.getOrganizationBudgetExpenses = function(param, connection = database){
        return connection.oneOrNone(getOrganizationBudgetExpensesSQL, param);
    };

    const pendDirectPaymentTableSQL = queryFiles.pendDirectPaymentTable;
    FinanceModel.pendDirectPaymentTable = function(param, connection = database){
        return connection.none(pendDirectPaymentTableSQL, param);
    };

    const approveDirectPaymentTableSQL = queryFiles.approveDirectPaymentTable;
    FinanceModel.approveDirectPaymentTable = function(param, connection = database){
        return connection.none(approveDirectPaymentTableSQL, param);
    };

    const getDirectPaymentAccountSQL = queryFiles.getDirectPaymentAccount;
    FinanceModel.getDirectPaymentAccount = function(param, connection = database){
        return connection.one(getDirectPaymentAccountSQL, param);
    };

    const getCashAdvanceAccountSQL = queryFiles.getCashAdvanceAccount;
    FinanceModel.getCashAdvanceAccount = function(param, connection = database){
        return connection.one(getCashAdvanceAccountSQL, param);
    };

    const getBookTransferAccountSQL = queryFiles.getBookTransferAccount;
    FinanceModel.getBookTransferAccount = function(param, connection = database){
        return connection.one(getBookTransferAccountSQL, param);
    };

    const deductExpensesSQL = queryFiles.deductExpenses;
    FinanceModel.deductExpenses = function(param, connection = database){
        return connection.none(deductExpensesSQL, param);
    };

    const getOrgApprovedTransactionsSQL = queryFiles.getOrgApprovedTransactions;
    FinanceModel.getOrgApprovedTransactions = function(param, connection = database){
        return connection.any(getOrgApprovedTransactionsSQL, param);
    };

    //Used for signing
    FinanceModel.getPreActivityCashAdvanceDetails = (cashAdvanceID, fields, connection = database) => {
        logger.info(`getPreActivityCashAdvanceDetails(cashAdvanceID: ${cashAdvanceID})`, log_options);
        let query = squel.select()
        .from('"PreActivityCashAdvance"', 'preca')
         .left_join('"PreActivityCashAdvanceStatus"', 'pacas', 'preca.status = pacas.id')
         .left_join('Account', 'a', 'preca."submittedBy" = a.idNumber')
        .where('preca."id" = ${cashAdvanceID}');
        attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.cashAdvanceID = cashAdvanceID;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.one(query, param);
    };

    //Used for signing
    FinanceModel.getPreActivityCashAdvanceParticularDetails = (cashAdvanceID, fields, connection = database) => {
        logger.info(`getPreActivityCashAdvanceDetails(cashAdvanceID: ${cashAdvanceID})`, log_options);
        let query = squel.select()
        .from('"PreActivityCashAdvanceParticular"', 'precap')
         .left_join('ProjectProposalExpenses', 'ppe', 'precap."particular" = ppe.id')
         .left_join('ExpenseType', 'et', 'ppe.type = et.id')
        .where('precap."cashAdvance" = ${cashAdvanceID}');
        attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.cashAdvanceID = cashAdvanceID;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.any(query, param);
    };

    //Used for signing
    FinanceModel.getPreActivityDirectPaymentDetails = (directPaymentID, fields, connection = database) => {
        logger.info(`getPreActivityDirectPaymentDetails(directPaymentID: ${directPaymentID})`, log_options);

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
        logger.info(`getPreActivityDirectPaymentParticularDetails(directPaymentID: ${directPaymentID})`, log_options);

        let query = squel.select()
            .from('"PreActivityDirectPaymentParticular"', 'padpp')
                .left_join('ProjectProposalExpenses', 'ppe', 'padpp."particular" = ppe.id')
                .left_join('ExpenseType', 'et', 'ppe.type = et.id')
            .where('padpp."directPayment" = ${directPaymentID}');
        attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.directPaymentID = directPaymentID;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.any(query, param);
    };

    
    const queryNextSignatory = (financeSignatoryTable, column, value, connection) => {
        logger.info('call queryNextSignatory()', log_options);

        const getNextSignantorySQL = squel.select()
            .field('"signatory"', '"idNumber"')
            .from(squel.select()
                .from(`"${financeSignatoryTable}"`)
                .where(`"${column}"` + ' = ${value}')
                .where('"status" = 0'), '"sl"')
                .left_join('"FinanceSignatoryType"', '"fst"', '"sl"."type" = "fst"."id"')
            .order('"fst"."lineup"', true)
            .limit(1)
            .toString();

        let param = Object.create(null);
        param.value = value;

        logger.debug(`Executing query: ${getNextSignantorySQL}`, log_options);
        return connection.oneOrNone(getNextSignantorySQL, param);
    };

    FinanceModel.getPreActivityDirectPaymentNextSignatory = (directPaymentID, connection = database) => {
        logger.info(`getPreActivityDirectPaymentNextSignatory(directPaymentID: ${directPaymentID})`, log_options);

        return queryNextSignatory('PreActivityDirectPaymentSignatory', 'directPayment', directPaymentID, connection);
    };

    FinanceModel.getPreActivityCashAdvanceNextSignatory = (cashAdvanceID, connection = database) => {
        logger.info(`getPreActivityCashAdvanceNextSignatory(cashAdvanceID: ${cashAdvanceID})`, log_options);

        return queryNextSignatory('PreActivityCashAdvanceSignatory', 'cashAdvance', cashAdvanceID, connection);
    };

    const queryAllSignatory = (financeSignatoryTable, column, value, fields, connection) => {
        logger.info(`call queryAllSignatory(financeSignatoryTable: ${financeSignatoryTable}, column: ${column}, value: ${value})`, log_options);
        let query = squel.select()
            .from(squel.select()
                .from(`"${financeSignatoryTable}"`)
                .where(`"${column}" = \${value}`), '"sl"' )
            .left_join('"FinanceSignatoryType"', '"fst"', '"sl"."type" = "fst"."id"')
            .left_join('Account', 'a', '"sl"."signatory" = "a".idNumber')
            .left_join('SignatoryStatus', 'ss', '"sl"."status" = ss.id')
            .order('"fst"."lineup"', true);
        attachFields(query, fields);

        query = query.toString();

        let param = Object.create(null);
        param.financeSignatoryTable = financeSignatoryTable;
        param.column = column;
        param.value = value;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.many(query, param);
    };

    FinanceModel.getPreActivityDirectPaymentAllSignatory = (directPaymentID, fields, connection = database) => {
        logger.info(`call getPreActivityDirectPaymentAllSignatory(directPaymentID: ${directPaymentID})`, log_options);

        return queryAllSignatory('PreActivityDirectPaymentSignatory',
            'directPayment',
            directPaymentID,
            fields,
            connection
        );
    };

    FinanceModel.getPreActivityCashAdvanceAllSignatory = (cashAdvanceID, fields, connection = database) => {
        logger.info(`call getPreActivityDirectPaymentAllSignatory(cashAdvanceID: ${cashAdvanceID})`, log_options);

        return queryAllSignatory('PreActivityCashAdvanceSignatory',
            'cashAdvance',
            cashAdvanceID,
            fields,
            connection
        );
    };
    
    FinanceModel.getPreActivityBookTransferAllSignatory = (bookTransferID, fields, connection = database) => {
        logger.info(`call getPreActivityBookTransferAllSignatory(bookTransferID: ${bookTransferID})`, log_options);

        return queryAllSignatory('PreActivityBookTransferSignatory',
            'bookTransfer',
            bookTransferID,
            fields,
            connection
        );
    };

    FinanceModel.getPostProjectReimbursmentAllSignatory = (reimbursementID, fields, connection = database) => {
        logger.info(`call getPreActivityBookTransferAllSignatory(bookTransferID: ${bookTransferID})`, log_options);

        return queryAllSignatory('PostProjectReimbursementSignatory',
            'reimbursement',
            bookTransferID,
            fields,
            connection
        );
    };

	return FinanceModel;
};
