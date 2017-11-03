'use strict';

/**
 * Query Files Used:
 *     account_insert.sql
 */
module.exports = function(configuration, modules, database, queryFiles) {
    const squel = require('squel').useFlavour('postgres');



    let dbHelper = require('../utility/databaseHelper');
    const attachReturning = dbHelper.attachReturning;
    const attachFields = dbHelper.attachFields;
    dbHelper = null;

    const logger = modules.logger;

    const AccountModel = Object.create(null);


    const query_insert_account = queryFiles.account_insert;
    /**
     * [insertAccount description]
     * @method  insertAccount
     * @param  {Integer}         idNumber      [description]
     * @param  {String}          email         [description]
     * @param  {Integer}         type          [description]
     * @param  {String}          password      [description]
     * @param  {String}          firstname     [description]
     * @param  {String}          middlename    [description]
     * @param  {String}          lastname      [description]
     * @param  {String}          contactNumber [description]
     * @param  {String}          publicKey     [description]
     * @param  {String}          privateKey    [description]
     * @param  {[String, Array(String)] (Optional)}                           returning     [description]
     * @param  {[pg-task, pg-connection, pg-transaction] (Optional)}          connection    [description]
     * @returns {Promise} [description]
     */
    AccountModel.insertAccount = (idNumber, email, type, password, firstname, middlename, lastname, contactNumber, publicKey, privateKey, returning, connection = database) => {
        let param = Object.create(null);
        param.idNumber = idNumber;
        param.email = email;
        param.type = type;
        param.password = password;
        param.firstname = firstname;
        param.middlename = middlename;
        param.lastname = lastname;
        param.contactNumber = contactNumber;
        param.publicKey = publicKey;
        param.privateKey = privateKey;

        if (returning) {
            let query = squel.insert()
                .into('Account')
                .set('idNumber', '${idNumber}')
                .set('email', '${email}')
                .set('type', '${type}')
                .set('password', '${password}')
                .set('firstname', '${firstname}')
                .set('middlename', '${middlename}')
                .set('lastname', '${lastname}')
                .set('contactNumber', '${contactNumber}')
                .set('publicKey', '${publicKey}')
                .set('privateKey', '${privateKey}');
            attachReturning(query, returning);

            return connection.one(query.toString(), param);
        }
        return connection.none(query_insert_account, param);
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
        let param = Object.create(null);
        param.idNumber = idNumber;

        let query = squel.select()
            .from('Account', 'a')
            .where('idNumber = ${idNumber}');
        attachFields(query, fields);
        return connection.one(query.toString(), param);
    };

    /**
     * Calculates which dashboard/s or home pagesthe given account can view
     *
     * @method  getAccountHome
     * @param   {[type]}       idNumber [description]
     * @returns {[type]}                [description]
     */
    AccountModel.getAccountHome = (idNumber) => {
        //TODO implementation
    };

    const query_get_student_studentOrganizations = queryFiles.student_get_studentOrganizations;
    AccountModel.getStudentOrganizations = (idNumber, connection = database) => {
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

    const hasGOSMActivityWithoutPPRSQL = queryFiles.account_has_gosmactivity_without_ppr;
    AccountModel.hasGOSMActivityWithoutPPR = (idNumber, organizationID, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        param.organizationID = organizationID;
        return connection.one(hasGOSMActivityWithoutPPRSQL, param);
    };

    return AccountModel;
};
