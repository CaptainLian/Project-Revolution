'use strict';

module.exports = function(configuration, modules, database, queryFiles) {
    const squel = require('squel').useFlavour('postgres');

    const ACCOUNT_TYPES = require('../utility/CONSTANTS_account_types.json');

    const JSON_STRINGIFY = require('json-stable-stringify');

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
     * @param  {[pg-task, pg-connection, pg-transaction] (Optional)}          connection    [description]
     * @returns {Promise} [description]
     */
    AccountModel.createAccount = (idNumber, email, type, password, firstname, middlename, lastname, contactNumber, connection = database) => {
        logger.info(`call createAccount()\nGenerating key pair\n\tParameters: bits: ${configuration.security.encryption.bits}, workers: ${configuration.security.encryption.web_workers_amount}`, log_options);

        return forge.pki.rsa.generateKeyPair({
            bits: configuration.security.encryption.bits,
            workers: configuration.security.encryption.web_workers_amount
        }).then(pair => {
            pair[0] = forge.forge.pki.publicKeyToPem(pair.publicKey);
            pair[1] = forge.forge.pki.privateKeyToPem(pair.privateKey);
            logger.debug(`Public key: ${pair[0]}\nPrivate key: ${pair[1]}`, log_options);

            let param = Object.create(null);
            param.idNumber = idNumber;
            param.email = email;
            param.type = type;
            param.password = password;
            param.firstname = firstname;
            param.middlename = middlename;
            param.lastname = lastname;
            param.contactNumber = contactNumber;
            param.publicKey = pair[0];
            param.privateKey = pair[1];

            let query = squel.insert()
                .into('Account')
                .set('status', 3)
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

            query = query.toString();
            logger.debug(`Executing query: ${query}\nParameters: ${JSON.stringify(param)}`, log_options);
            return connection.none(query, param);
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
        logger.info('call createStudentAccount()', log_options);
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
                transaction
            ).then(() => {
                let query = squel.insert()
                    .into('OrganizationOfficer')
                    .set('idNumber', squel.str('${idNumber}'))
                    .set('role', squel.str('${roleID}'))
                    .set('yearID', squel.str('system_get_current_year_id()'))
                    .toString();

                logger.debug(`Batch roles\nExecuting query: ${query}`,log_options);

                let queries = [];
                for(const roleID of roles){
                    let param = Object.create(null);
                    param.idNumber = idNumber;
                    param.roleID = roleID;

                    queries[queries.length] = transaction.none(query, param);
                }

                return transaction.batch(queries);
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
        logger.info(`call getAccountDetails(idNumber: ${idNumber})`, log_options);

        let param = Object.create(null);
        param.idNumber = idNumber;

        let query = squel.select()
            .from('Account', 'a')
            .where('idNumber = ${idNumber}');
        attachFields(query, fields);

        query = query.toString();
        logger.debug(`Executing query ${query}`, log_options);
        return connection.one(query, param);
    };

    /**
     *
     * @param  {Integer}         idNumber     ID number of the account 
     * @param  {Object}            fields     A key value pair of, the columns to update as key and the value to update
     * @param  {pg_connection} connection     (Optional)
     * @return {[pg_promise}                  void
     */
    AccountModel.updateAccountDetails = (idNumber, fields, connection = database) => {
        logger.info(`call updateAccountDetails(idNumber: ${idNumber}, fields: ${JSON.stringify(fields)})`, log_options);

        const DONT_QUOTE = Object.create(null);
        DONT_QUOTE.dontQuote = true;

        let query = squel.update()
            .table('Account a')
            .where('idNumber = ${idNumber}');

        let param = Object.create(null);
        param.idNumber = idNumber;

        for(const key in fields){
            param[key] = fields[key];
            query.set(key, '${' + key + '}', DONT_QUOTE);
        }

        query = query.toString();

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.none(query, param);
    };

    AccountModel.getAccounts = (fields, connection = database) => {
        logger.info('call getAccounts()', log_options);

        let param = Object.create(null);

        let query = squel.select()
            .from('Account', 'a')
            .left_join(squel.select()
            	.from('organizationofficer')
                .where('isactive = ?', true)
                .where('yearid = ?',
                	squel.str('system_get_current_year_id()')
                ), 'oo',
                'oo.idNumber = a.idNumber'
             ).left_join('organizationrole','oro',' oo.role = oro.id ')
            .left_join('studentorganization','so','so.id = oro.organization')
            .left_join('accounttype','ac','a.type = ac.id')
            .field('ac.name','acname')
            .where('a.status <> ?',2)
            .order('a.idNumber',false);
        attachFields(query, fields);

        console.log(query.toString());
        return connection.many(query.toString(), param);
    };

    AccountModel.updateAccount = (idNumber,email,type,status,firstname,middlename,lastname,contactNumber, orgpos, connection = database) => {
        logger.info('call updateAccount()', log_options);

        let param = Object.create(null);

        return connection.tx(t=>{
            //update basic info
            let query = squel.update()
                        .table('account')
                        .setFields({
                            'email':email,
                            'type':type,
                            'status':status,
                            'firstname':firstname,
                            'middlename':middlename,
                            'lastname':lastname,
                            'contactNumber':contactNumber
                        })
                        .where('idNumber = ?', idNumber).toString();
            //update position to false
            let query2 = squel.update()
                        .table('organizationofficer')
                        .set("isactive",false)
                        .where('idNumber = ?', idNumber)
                        .where('yearid = system_get_current_year_id()').toString();
            let query3 ='';
            if(!Array.isArray(orgpos) && type ==1){
                console.log("IF");

                query3 += squel.insert()
                        .into('organizationofficer')
                        .set('idnumber', idNumber)
                        .set('role',orgpos)
                        .set('yearid',squel.str('system_get_current_year_id()'))
                        .set('isactive',true)
                        .toString();
                query3 +=" ON CONFLICT (idnumber, role, yearid ) DO UPDATE set isactive=true";
            }else if(Array.isArray(orgpos) && type ==1){
                console.log("ELSE");
                for(var ctr = 0; ctr < orgpos.length; ctr++){
                     query3+=squel.insert()
                            .into('organizationofficer')
                            .set('idnumber', idNumber)
                            .set('role',orgpos[ctr])
                            .set('yearid',squel.str('system_get_current_year_id()'))
                            .set('isactive',true)
                            .toString();
                        query3 +=" ON CONFLICT (idnumber, role, yearid ) DO UPDATE set isactive=true";

                    // if(ctr+1 != orgpos.length)
                        query3+=';';
                }

            }else{
                query3=query2;
            }

            return t.batch([
                t.none(query),
                t.none(query2),
                t.none(query3)
            ]);
        });
        // attachFields(query, fields)
    };

     AccountModel.deleteAccount = (idNumber,status , connection = database) => {
        logger.info('call deleteAccount()', log_options);

        let param = Object.create(null);
        let query = squel.update()
            .table('account')
            .set('status',status)
            .where('idNumber = ?', idNumber);
        // attachFields(query, fields);

        logger.debug('deleteAccount()', log_options);
        return connection.any(query.toString());
    };

    AccountModel.deleteAcl = (connection = database) => {
    	logger.info(`call deleteAcl()`, log_options);

        let param = Object.create(null);	
        let query = squel.delete()
        	.from("organizationaccesscontrol")
        // attachFields(query, fields);
        return connection.any(query.toString());

    };

    AccountModel.insertACL = (acls ,connection = database) => {
    	logger.info(`call insertACL()`, log_options);
        let query = ""

        for( var acl in acls){
            var data = acl.split("+");
            query += squel.insert()
                .into("organizationaccesscontrol")
                .set("role",data[0])
                .set("functionality",data[1])
                .set("isallowed",true)
                .toString() + ";"
        }

        return connection.any(query.toString());
    };

     AccountModel.getSpecificAccount = (idNumber,fields, connection = database) => {
        logger.info('call getSpecificAccount()', log_options);

        let param = Object.create(null);
        let query = squel.select()
            .from('Account', 'a')
            .left_join(squel.select()
                .from('organizationofficer')
                .where('isactive = ?',true)
                .where('yearid = ?',
                    squel.str('system_get_current_year_id()')),
                    'oo',
                    'oo.idNumber = a.idNumber')
            .left_join('organizationrole','oro','oro.id = oo.role')
            .left_join('studentorganization','so','so.id = oro.organization')
            .left_join('accounttype','aca','aca.id = a.type')
            .where('a.idNumber = ?',idNumber)
            .order('a.idNumber',false);
        attachFields(query, fields);

        return connection.many(query.toString(), param);
    };


    AccountModel.getOrganizationRoles = (fields,connection = database) => {
        logger.info('call getOrganizationRoles()', log_options);

        //TODO figure out parameters
        let param = Object.create(null);

        let query = squel.select()
            .from('organizationrole','oro')
            .left_join('studentorganization','so','so.id = oro.organization')
            .field('so.id','soid')
            .field('so.name','soname')
            .field('so.acronym','soacro')
            .field('oro.id','orid')
            .field('oro.organization','oroorg')
            .field('oro.name','oroname')
            .field('oro.rank','ororank')
            .order('oro.organization')
            .order('oro.rank');
        attachFields(query, fields);

        return connection.many(query.toString(), param);
    };

    AccountModel.getAccountType = (fields, connection = database) => {
        logger.info('call getAccountType()', log_options);

        let param = Object.create(null);


        let query = squel.select()
            .from('accounttype');
        attachFields(query, fields);

        return connection.many(query.toString(), param);
    };

    const query_get_student_studentOrganizations = queryFiles.student_get_studentOrganizations;
    AccountModel.getStudentOrganizations = (idNumber, connection = database) => {
        logger.info(`call getStudentOrganizations(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        logger.debug(`Executing query: ${query_get_student_studentOrganizations}`, log_options);
        return connection.any(query_get_student_studentOrganizations, param);
    };

    AccountModel.getRoleDetailsInOrganization = (idNumber, organization, fields, connection = database) => {
    	logger.info(`call getRoleDetailsInOrganization(idNumber: ${idNumber}, organization: ${organization})`, log_options);

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
    	logger.info(`call hasGOSMActivityWithoutPPR(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasGOSMActivityWithoutPPRSQL, param);
    };

    const hasGOSMActivityWithAMTActivityEvaluationSQL = queryFiles.account_has_gosmactivity_with_AMTActivityEvaluation;
    AccountModel.hasGOSMACtivityWithAMTActivityEvaluation = (idNumber, organizationID, connection = database) => {
    	logger.info(`call hasGOSMACtivityWithAMTActivityEvaluation(idNumber: ${idNumber}, organizationID: ${organizationID})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;
        param.organizationID = organizationID;

        return connection.one(hasGOSMActivityWithAMTActivityEvaluationSQL, param);
    };

    const hasPPRWithoutPostProjectProposal = queryFiles.account_PPR_has_without_PostProjectProposal;
    AccountModel.hasPPRWithoutPostProjectProposal = (idNumber, connection = database) => {
    	logger.info(`call hasPPRWithoutPostProjectProposal(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRWithoutPostProjectProposal, param);
    };

    const hasPPRApprovedSQL = queryFiles.account_PPR_has_approved;
    AccountModel.hasPPRApproved = (idNumber, connection = database) => {
    	logger.info(`call hasPPRApproved(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRApprovedSQL, param);
    };

    const hasPPRToSignSQL = queryFiles.account_PPR_has_to_sign;
    AccountModel.hasPPRToSign = (idNumber, connection = database) => {
    	logger.info(`hasPPRToSign(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.one(hasPPRToSignSQL, param);
    };

    //TODO: Display signed PPR as well.
    const getPPRsToSignSQL = queryFiles.account_PPR_get_to_sign;
    AccountModel.getPPRToSignList = (idNumber, connection = database) => {
    	logger.info(`call getPPRToSignList(idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.any(getPPRsToSignSQL, param);
    };

    const approvePPRSQL = queryFiles.account_PPR_approve;
    AccountModel.approvePPR = (activityID, idNumber, document, digitalSignature, connection = database) => {
    	logger.info(`call approvePPR(activityID: ${activityID}, idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.document = document;
        param.digitalSignature = digitalSignature;

        return connection.none(approvePPRSQL, param);
    };

    const pendPPRSQL = queryFiles.account_PPR_pend;
    AccountModel.pendPPR = (activityID, idNumber, comments, sections, connection = database) => {
    	logger.info(`call pendPPR(activityID: ${activityID}, idNumber: ${idNumber}, comments: ${comments}, sections: ${sections})`, log_options);

        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.comments = comments;
        param.sections = sections;

        return connection.none(pendPPRSQL, param);
    };

    const denyPPRSQL = queryFiles.account_PPR_deny;
    AccountModel.denyPPR = (activityID, idNumber, comments, connection = database) => {
    	logger.info(`call denyPPR(activityID: ${activityID}, idNumber: ${idNumber}, comments: ${comments})`, log_options);

        const param = Object.create(null);
        param.activityID = activityID;
        param.idNumber = idNumber;
        param.comments = comments;

        return connection.none(denyPPRSQL, param);
    };

    const approvePreActCashAdvanceSQL = queryFiles.account_PreActCashAdvance_approve;
    AccountModel.approvePreActCashAdvance = (cashAdvance, idNumber, document, digitalSignature, connection = database) => {
    	logger.info(`call approvePreActCashAdvance(cashAdvance: ${cashAdvance}, idNumber: ${idNumber})`, log_options);

        const param = Object.create(null);
        param.cashAdvance = cashAdvance;
        param.idNumber = idNumber;
        param.document = document;
        param.digitalSignature = digitalSignature;

        return connection.none(approvePreActCashAdvanceSQL, param);
    };

    const pendPreActCashAdvanceSQL = queryFiles.account_PreActCashAdvance_approve;
    AccountModel.pendPreActCashAdvance = (cashAdvance, idNumber, comments, sections, connection = database) => {
    	logger.info(`call pendPreActCashAdvance(cashAdvance: ${cashAdvance}, idNumber: ${idNumber}, comments: ${comments}, sections: ${sections})`, log_options);

        const param = Object.create(null);
        param.cashAdvance = cashAdvance;
        param.idNumber = idNumber;
        param.comments = comments;
        param.sections = sections;

        return connection.none(pendPreActCashAdvanceSQL, param);
    };

    const isProjectHeadSQL = queryFiles.account_is_project_head;
    AccountModel.isProjectHead = (idNumber, connection = database) => {
        logger.info(`call isProjectHead(idNumber: ${idNumber})`, log_options);
        logger.debug(isProjectHeadSQL, log_options);

        const param = Object.create(null);
        param.idNumber = idNumber;

        logger.debug(`Executing query: ${isProjectHeadSQL}`, log_options);
        return connection.one(isProjectHeadSQL, param);
    };

    const getNotifcationsSQL = queryFiles.account_get_notifications;
    AccountModel.getNotifications = (idNumber, minSequence, fields, connection = database) => {
        logger.info(`call getNotifications(idNumber: ${idNumber}, minSequence: ${minSequence})`, log_options);
        
        let query = squel.select()
            .from('"AccountNotification"')
            .where('"account" = ${idNumber}')
            //Descending
            .order('"sequence"', false);
        attachFields(query, fields);

        const param = Object.create(null);

        if(minSequence){
            query.where('"sequence" > ${sequence}');
            param.sequence = minSequence;
        }

        param.idNumber = idNumber;
        
        query = query.toString();
        logger.debug(`Executing query: ${query}`, log_options);
        return connection.any(query, param);
    };

    /**
     * [addNotification description]
     * @param {Integer} idNumber             [description]
     * @param {String} title                 [description]
     * @param {String} description           [description]
     * @param {Object} details               An object to be JSON string
     * @param {pg-connection} connection [description]
     */
    AccountModel.addNotification = (idNumber, title, description, details, returning, connection = database) => {
        logger.info(`call addNotification()`, log_options);

        let param = Object.create(null);
        param.idNumber = idNumber;
        param.title = title;
        param.description = description;
        param.details = JSON_STRINGIFY(details);

        let query = squel.insert()
            .into('"AccountNotification"')
            .set('"account"', squel.str('${idNumber}'))
            .set('"title"', squel.str('${title}'))
            .set('"description"', squel.str('${description}'))
            .set('"details"', squel.str('${details}'));

        if(returning){
            attachReturning(query, returning);
            logger.debug('Returning query', log_options);
        }

        query = query.toString();
        logger.debug(`Executing query: ${query}`, log_options);
        return connection.oneOrNone(query, param);
    };
    
    AccountModel.updateNotifications = (idNumber, maxSequence, connection = database) => {
        logger.info(`call viewNotifications(idNumber: ${idNumber}, maxSequence: ${maxSequence})`, log_options);

        let query = squel.update()
            .table('"AccountNotification"')
            .set('"status" = 1')
            .where('"account" = ${idNumber}')
            .where('"sequence" <= ${maxSequence}')
            .where('"status" <> 1')
            .toString();
        
        let param = Object.create(null);
        param.idNumber = idNumber;
        param.maxSequence = maxSequence;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.none(query, param);
    };

    AccountModel.isInOrganization = (idNumber, organizationID, connection = database) => {
        logger.info(`call isInOrganization(idNumber: ${idNumber}, organizationID: ${organizationID})`, log_options);

        let query = squel.select()
            .field(squel.str(`EXISTS(${squel.select()
                    .from('OrganizationRole')
                    .field('organization')
                    .where('id IN ?',
                        squel.select()
                            .from('OrganizationOfficer')
                            .field('role')
                            .where('yearID = system_get_current_year_id()')
                            .where('isActive')
                            .where('idNumber = ${idNumber}'))
                    .where('organization = ${organizationID}')
                    .toString()})`), '"isIn"')
            .toString();

        let param = Object.create(null);
        param.idNumber = idNumber;
        param.organizationID = organizationID;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.one(query, param);
    };

    /********************************
     * FINANCE ACCOUNTING SIGNATORY *
     ********************************/
    
    const approvePreActDirectPaymentSQL = queryFiles.account_PreActDirectPayment_approve;
    AccountModel.approveDirectPayment = (directPaymentID, idNumber, document, digitalSignature, connection = database) => {
        logger.info(`call approveDirectPayment(directPaymentID: ${directPaymentID}, idNumber: ${idNumber})`)

        let param = Object.create(null);
        param.idNumber = idNumber;
        param.directPayment = directPaymentID;
        param.signatory = idNumber;
        param.document = document;
        param.digitalSignature = digitalSignature;

        logger.debug(`Executing query: ${approvePreActDirectPaymentSQL}`, log_options);
        return connection.none(approvePreActDirectPaymentSQL, param);
    };

    const pendPreActDirectPaymentSQL = queryFiles.account_PreActDirectPayment_pend;
    AccountModel.pendDirectPayment = (directPaymentID, idNumber, comments, sections, connection = database) => {
    	logger.info('call pendDirectPayment()', log_options);

        const param = Object.create(null);
        param.directPayment = directPaymentID;
        param.idNumber = idNumber;
        param.comments = comments;
        param.sections = sections;

        logger.debug(`Executing query: ${pendPreActDirectPaymentSQL}`, log_options);
        return connection.none(pendPreActDirectPaymentSQL, param);
    };

    const pendCashAdvanceSQL = queryFiles.pendCashAdvance;
    AccountModel.pendCashAdvance = function(cashAdvance, signatory, sections, explain, connection = database){
        logger.info(`call pendCashAdvance(cashAdvance: ${cashAdvance}, signatory: ${signatory})`, log_options);

        let param = Object.create(null);
        param.signatory = signatory;
        param.cashAdvance = cashAdvance;
        param.sections = sections;
        param.explain = explain;
        logger.debug(`Executing query: ${pendCashAdvanceSQL}`, log_options);
        return connection.none(pendCashAdvanceSQL, param);
    };

    /******
    * ADM *
    *******/

    AccountModel.approvePostProjectProposal = (GOSMActivityID, idNumber, document, digitalSignature, connection = database) => {
        logger.info(`call approvePostProjectProposal(GOSMActivityID: ${GOSMActivityID}, idNumber: ${idNumber})`);
        const DONT_QUOTE = Object.create(null);
        DONT_QUOTE.dontQuote = true;

        let query = squel.update()
            .table('"PostProjectProposalSignatory"', DONT_QUOTE)
            .set('"status"', 1, DONT_QUOTE)
            .set('"document"', '${document}', DONT_QUOTE)
            .set('"digitalSignature"', '${digitalSignature}', DONT_QUOTE)
            .set('"dateSigned"', 'CURRENT_TIMESTAMP', DONT_QUOTE)
            .where('"GOSMActivity" = ${GOSMActivityID}')
            .where('"signatory" = ${idNumber}')
            .toString();

        let param = Object.create(null);
        param.document = document;
        param.digitalSignature = digitalSignature;
        param.GOSMActivityID = GOSMActivityID;
        param.idNumber = idNumber;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.none(query, param);
    };

    AccountModel.pendPostProjectProposal = (GOSMActivityID, idNumber, comments, sections, connection = database) => {
        logger.info(`call pendPostProjectProposal(GOSMActivityID: ${GOSMActivityID}, idNumber: ${idNumber})`);

        let query = squel.update()
            .table('"PostProjectProposalSignatory"', DONT_QUOTE)
            .set('"status"', 2, DONT_QUOTE)
            .set('"comments"', '${comments}', DONT_QUOTE)
            .set('"sectionsToBeEdited"', '${sectionsToBeEdited}', DONT_QUOTE)
            .where('"GOSMActivity" = ${GOSMActivityID}')
            .where('"signatory" = ${idNumber}')
            .toString();

        let param = Object.create(null);
        param.comments = comments;
        param.sectionsToBeEdited = sections;
        param.GOSMActivityID = GOSMActivityID;
        param.idNumber = idNumber;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.none(query, param);
    };

    return AccountModel;
};
