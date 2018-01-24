
'use strict';

/**
 * Query Files Used:
 *     account_insert.sql
 */
module.exports = function(configuration, modules, database, queryFiles) {
    const squel = require('squel').useFlavour('postgres');

    const ACCOUNT_TYPES = require('../utility/CONSTANTS_account_types.json');

    const {attachReturning, attachFields} = (() => {
        let dbHelper = require('../utility/databaseHelper');

        let ret = Object.create(null);
        ret.attachReturning = dbHelper.attachReturning;
        ret.attachFields = dbHelper.attachFields;
        return ret;
    })();

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Account-model';

    const forge = require('../utility/forge-promise.js');

    const AccountModel = Object.create(null);

    const query_insert_account = queryFiles.account_insert;

    /**
     * [createAccount description]
     * @method  createAccount
     * @param  {Integer}         idNumber      [description]
     * @param  {String}          email         [description]
     * @param  {Integer}         type          [description]
     * @param  {String}          password      [description]
     * @param  {String}          firstname     [description]
     * @param  {String}          middlename    [description]
     * @param  {String}          lastname      [description]
     * @param  {String}          contactNumber [description]
     * @param  {[String, Array(String)] (Optional)}                           returning     [description]
     * @param  {[pg-task, pg-connection, pg-transaction] (Optional)}          connection    [description]
     * @returns {Promise} [description]
     */
    AccountModel.createAccount = (idNumber, email, type, password, firstname, middlename, lastname, contactNumber, returning, connection = database) => {
        logger.debug('createAccount()', log_options);

        let param = Object.create(null);
        param.idNumber = idNumber;
        param.email = email;
        param.type = type;
        param.password = password;
        param.firstname = firstname;
        param.middlename = middlename;
        param.lastname = lastname;
        param.contactNumber = contactNumber;

        logger.debug(`Generating key pair\n\tParameters: bits: ${configuration.security.encryption.bits}, workers: ${configuration.security.encryption.web_workers_amount}`, log_options);
        return forge.pki.rsa.generateKeyPair({
            bits: configuration.security.encryption.bits,
            workers: configuration.security.encryption.web_workers_amount
        }).then(pair => {
            pair[0] = forge.forge.pki.publicKeyToPem(pair.publicKey);
            pair[1] = forge.forge.pki.privateKeyToPem(pair.privateKey);
            logger.debug(`Public key: ${pair[0]}`, log_options);
            logger.debug(`Private key: ${pair[1]}`, log_options);
            param.publicKey = pair[0];
            param.privateKey = pair[1];

            if (returning) {
                logger.debug('Returning query', log_options);
                let query = squel.insert()
                    .into('Account')
                    .set('idNumber', squel.str('${idNumber}'))
                    .set('email', squel.str('${email}'))
                    .set('type', squel.str('${type}'))
                    .set('password', squel.str('${password}'))
                    .set('firstname', squel.str('${firstname}'))
                    .set('middlename', squel.str('${middlename}'))
                    .set('lastname', squel.str('${lastname}'))
                    .set('publicKey', squel.str('${publicKey}'))
                    .set('privateKey', squel.str('${privateKey}'))
                    .set('contactNumber', squel.str('${contactNumber}'));
                attachReturning(query, returning);

                query = query.toString();
                logger.debug(`Executing query: ${query}`, log_options);
                return connection.one(query, param);
            }
            logger.debug(`Non-returning query\nExecuting query: ${query_insert_account}\nParameters: ${JSON.stringify(param)}`, log_options);
            logger.debug(`Parameters: ${JSON.stringify(param)}`,log_options);
            return connection.none(query_insert_account, param);
        });
    };

    /**
     * @method
     * @param  {Integer}          idNumber       [description]
     * @param  {String}           email          [description]
     * @param  {Integer}          type           [description]
     * @param  {String}           password       [description]
     * @param  {String}           firstname      [description]
     * @param  {String}           middlename     [description]
     * @param  {String}           lastname       [description]
     * @param  {String}           contactNumber  [description]
     * @param  { Array(Integer) } roles          [An array of roleIDs, check database table OrganizationRole]
     * @returns  {pg-promise}                    [description]
     */
    AccountModel.createStudentAccount = (idNumber, email, password, firstname, middlename, lastname, contactNumber, roles, connection = database) => {
        logger.debug('createStudentAccount()', log_options);
        return connection.tx(transaction => {
            AccountModel.createAccount(
                idNumber,
                email,
                ACCOUNT_TYPES.Student,
                password,
                firstname,
                middlename,
                lastname,
                contactNumber,
                null,
                transaction
            )
            .then(() => {
                let queries = null;
                let query = squel.insert()
                    .into('OrganizationOfficer')
                    .set('idNumber', squel.str('${idNumber}'))
                    .set('role', squel.str('${roleID}'))
                    .set('yearID', squel.str('system_get_current_year_id()'));

                query = query.toString();
                if(Array.isArray(roles)){
                    logger.debug(`Batch roles`,log_options);
                    for(const roleID of roles){
                        queries = [];

                        let param = Object.create(null);
                        param.idNumber = idNumber;
                        param.roleID = roleID;

                        queries[queries.length] = transaction.none(query, param);

                        return transaction.batch(queries);
                    }
                }
                logger.debug(`Single roles\nExecuting query: ${query}`,log_options);

                let param = Object.create(null);
                param.idNumber = idNumber;
                param.roleID = roles;

                queries = [transaction.none(query, param)];

                return queries;
            });
        });
    };

    /**
     *
     * @method  getAccountDetails
     * @param   {Integer}          idNumber   [description]
     * @param   {[Array, String(String)] (Optional)}                             fields     [description]
     * @param   {[pg-connection, pg-task, pg-transaction] (Optional)}          connection [description]
     * @returns {Promise}  [description]
     */
    AccountModel.getAccountDetails = (idNumber, fields, connection = database) => {
        logger.debug('getAccountDetails()', log_options);

        let param = Object.create(null);
        param.idNumber = idNumber;

        let query = squel.select()
            .from('Account', 'a')
            .where('idNumber = ${idNumber}');
        attachFields(query, fields);
        return connection.one(query.toString(), param);
    };
    AccountModel.getAccounts = (fields, connection = database) => {
        logger.debug('getAccountDetails()', log_options);

        let param = Object.create(null);
        

        let query = squel.select()
            .from('Account', 'a')
            .left_join('organizationofficer','oo','oo.idNumber = a.idNumber')
            .left_join('organizationrole','oro','oro.id = oo.role')
            .left_join('studentorganization','so','so.id = oro.organization')
            .order('a.idNumber',false)
        attachFields(query, fields);
        return connection.many(query.toString(), param);
    };


    AccountModel.getOrganizationRoles = (fields,connection = database) => {
        logger.debug('getOrganizationRoles()', log_options);

        let param = Object.create(null);
        

        let query = squel.select()
            .from('organizationrole','oro')
            .field('oro.id','orid')
            .field('oro.organization','oroorg')
            .field('oro.name','oroname')
            .field('oro.rank','ororank')
            .left_join('studentorganization','so','so.id = oro.organization')
            .field('so.id','soid')
            .field('so.name','soname')
            .field('so.acronym','soacro')
            .order('oro.organization')
            .order('oro.rank');
        attachFields(query, fields);
        return connection.many(query.toString(), param);
    };
    AccountModel.getAccountType = (fields, connection = database) => {
        logger.debug('getAccountType()', log_options);

        let param = Object.create(null);
        

        let query = squel.select()
            .from('accounttype');
            
        attachFields(query, fields);
        return connection.many(query.toString(), param);
    };
    // AccountModel.getOrg = (fields, connection = database) => {
    //     logger.debug('getAccountType()', log_options);

    //     let param = Object.create(null);
        

    //     let query = squel.select()
    //         .from('studentorganization');
            
            
    //     attachFields(query, fields);
    //     return connection.many(query.toString(), param);
    // };
    const query_get_student_studentOrganizations = queryFiles.student_get_studentOrganizations;
    AccountModel.getStudentOrganizations = (idNumber, connection = database) => {
        logger.debug('getStudentOrganizations()', log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.any(query_get_student_studentOrganizations, param);
    };

    AccountModel.getRoleDetailsInOrganization = (idNumber, organization, fields, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        param.organization = organization;

        let query = squel.select()
            .with('officership',
                squel.select()
                .from('OrganizationOfficer')
                .where('idNumber = ${idNumber}')
                .field('role')
            ).from('OrganizationRole')
            .where('id IN ?',
                squel.select()
                .from('officership')
            ).where('organization = ${organization}');

        attachFields(query, fields);
        return connection.one(query.toString(), param);
    };

    const getAccountLogsSQL = queryFiles.getAccountLogs;
    AccountModel.getAccountLogs = (connection = database) =>{
        return connection.any(getAccountLogsSQL);
    };

    const hasGOSMActivityWithoutPPRSQL = queryFiles.account_GOSMActivity_has_without_PPR;
    AccountModel.hasGOSMActivityWithoutPPR = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasGOSMActivityWithoutPPRSQL, param);
    };

    const hasGOSMActivityWithAMTActivityEvaluationSQL = queryFiles.account_has_gosmactivity_with_AMTActivityEvaluation;
    AccountModel.hasGOSMACtivityWithAMTActivityEvaluation = (idNumber, organizationID, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        param.organizationID = organizationID;

        return connection.one(hasGOSMActivityWithAMTActivityEvaluationSQL, param);
    };

    const hasPPRWithoutPostProjectProposal = queryFiles.account_PPR_has_without_PostProjectProposal;
    AccountModel.hasPPRWithoutPostProjectProposal = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRWithoutPostProjectProposal, param);
    };

    const hasPPRApprovedSQL = queryFiles.account_PPR_has_approved;
    AccountModel.hasPPRApproved = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRApprovedSQL, param);
    };

    const hasPPRToSignSQL = queryFiles.account_PPR_has_to_sign;
    AccountModel.hasPPRToSign = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRToSignSQL, param);
    };

    const getPPRsToSignSQL = queryFiles.account_PPR_get_to_sign;
    AccountModel.getPPRToSignList = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.any(getPPRsToSignSQL, param);
    };

    const approvePPRSQL = queryFiles.account_PPR_approve;
    AccountModel.approvePPR = (activityID, idNumber, document, digitalSignature, connection = database) => {
        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.document = document;
        param.digitalSignature = digitalSignature;

        return connection.none(approvePPRSQL, param);
    };

    const pendPPRSQL = queryFiles.account_PPR_pend;
    AccountModel.pendPPR = (activityID, idNumber, comments, sections, connection = database) => {
        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.comments = comments;
        param.sections = sections;

        return connection.none(pendPPRSQL, param);
    };

    const denyPPRSQL = queryFiles.account_PPR_deny;
    AccountModel.denyPPR = (activityID, idNumber, comments, connection = database) => {
        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.comments = comments;

        return connection.none(denyPPRSQL, param);
    };

    const approvePreActCashAdvanceSQL = queryFiles.account_PreActCashAdvance_approve;
    AccountModel.approvePreActCashAdvance = (cashAdvance, idNumber, document, digitalSignature, connection = database) => {
        const param = Object.create(null);
        param.cashAdvance = cashAdvance;
        param.idNumber = idNumber;
        param.document = document;
        param.digitalSignature = digitalSignature;

        return connection.none(approvePreActCashAdvanceSQL, param);
    };

    const pendPreActCashAdvanceSQL = queryFiles.account_PreActCashAdvance_approve;
    AccountModel.pendPreActCashAdvance = (cashAdvance, idNumber, comments, sections, connection = database) => {
        const param = Object.create(null);
        param.cashAdvance = cashAdvance;
        param.idNumber = idNumber;
        param.comments = comments;
        param.sections = sections;

        return connection.none(pendPreActCashAdvanceSQL, param);
    };

    const isProjectHeadSQL = queryFiles.account_is_project_head;
    AccountModel.isProjectHead = (idNumber, connection = database) => {
        logger.debug(`isProjectHead(idNumber: ${idNumber})`, log_options);
        logger.debug(isProjectHeadSQL, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(isProjectHeadSQL, param);
    };

    const getNotifcationsSQL = queryFiles.account_get_notifications;
    AccountModel.getNotifications = (idNumber, connection = database) => {
        logger.debug(`getNotifications(idNumber: ${idNumber})`, log_options);
        logger.debug(getNotifcationsSQL, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.any(getNotifcationsSQL, param);
    };

    AccountModel.addNotification = (idNumber, connection = database) => {
        //TODO implemented
        logger.error('addNotification() - FUNCTION HAS NO IMPLEMENTATION YET', log_options);
        return null;
    };

    return AccountModel;
};
