'use strict';
module.exports = function(configuration, modules, db, queryFiles) {
    const squel = require('squel').useFlavour('postgres');

    const insertProposedActivitySQL = queryFiles.insertProposedActivity;
    const insertActivityProjectHeadSQL = queryFiles.insertActivityProjectHead;
    const getSchoolYearSQL = queryFiles.getSchoolYear;
    const deleteActivitySQL = queryFiles.deleteActivity;
    const updateActivitySQL = queryFiles.updateActivity;
    const submitGOSMSQL = queryFiles.submitGOSM;
    const getObjectives = queryFiles.getObjectives;
    const getOrgGOSMSQL = queryFiles.getOrgGOSM;
    const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
    const query_getAll = queryFiles.gosm_getAll;
    const getGOSMActivityProjectHeadsSQL = queryFiles.getGOSMActivityProjectHeads;
    const getGOSMActivitySQL = queryFiles.getGOSMActivity;
    const getGOSMActivityOrgSQL = queryFiles.getGOSMActivityOrg;

    const getActivitySummaryPerOrgSQL = getActivitySummaryPerOrg;

    const insertGOSM = queryFiles.gosm_insert;
    const insertGOSM_Returning = queryFiles.gosm_insert_returning;
    const dbHelper = require('../utility/databaseHelper');
    const attachFields = dbHelper.attachFields;

    const logger = modules.logger;
    const log_options= Object.create(null);
    log_options.from = 'GOSM-Model';

    return {

        clearProjectHeads: (activityID, connection = db) => {
            logger.debug('clearProjectHeads()', log_options);

            let query = squel.delete()
                .from('GOSMActivityProjectHead')
                .where('activityID = ${activityID}', {
                    dontQuote: true
                });

            return connection.none(query.toString(), {activityID: activityID});
        },

        insertProjectHead:(activityID, projectHead, connection = db) => {
            logger.debug('insertProjectHead()', log_options);
            let query = squel.insert()
                .into('GOSMActivityProjectHead')
                .set('activityID', '${activityID}', {
                    dontQuote: true
                }).set('idNumber', '${idNumber}', {
                    dontQuote: true
                });

            query = query.toString();
            logger.debug(query, log_options);
            return connection.none (query, {
                activityID: activityID,
                idNumber: projectHead
            });
        },

        getAllActivityTypes: function(fields, connection = db) {
            let query = squel.select()
            .from('ActivityType');
            attachFields(query, fields);

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);
            return connection.many(query);
        }, //getAllActivityTypes()

        getAllActivityNature: function(fields, connection = db) {
            let query = squel.select()
            .from('ActivityNature');
            attachFields(query, fields);

            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.many(query);
        },

        insertProposedActivity: function(param, connection = db) {
            return connection.one(insertProposedActivitySQL, param);
        },
        insertActivityProjectHead: function(param, connection = db) {
            return connection.none(insertActivityProjectHeadSQL, param);
        },
        getSchoolYear: function(connection = db) {
            return connection.one(getSchoolYearSQL);
        },
        getObjectives: function(param, connection = db) {
            return connection.one(getObjectives,param);
        },
        getBuffer: function(orgid, connection = db) {
            logger.info(`getBuffer(orgid: ${orgid})`, log_options);

            let query= squel.select()
                .from('GOSM',"G")
                    .left_join("GOSMActivity",'GA','G.ID = GA.GOSM')            
                .field('COUNT(GA.ID) AS CGAID')    
                .where('GA.isInGOSM = FALSE')            
                .where('G.studentOrganization = ?',orgid)
                .group('G.ID')
                .toString();
            
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query);
        },

        getGOSMActivities: function(GOSMID, fields, connection = db) {
            let query= squel.select()
            .from('GOSMActivity',"G")
                .left_join("ProjectProposal",'P','P.GOSMActivity = G.ID')
            .where('GOSM = ?',GOSMID)
            .field("TO_CHAR(G.targetdatestart,'Mon DD, YYYY') as startdate")
            .field("TO_CHAR(G.targetdatestart,'MM/DD/YYYY') as targetdatestart1")
            .field("TO_CHAR(G.targetdateend,'MM/DD/YYYY') as targetdateend1")
            .field("G.comments as gcomments")
            .field("*")
            .field("G.ID AS GID")
            .field('P.ID AS PID')
            .field('P.STATUS AS PSTATUS');

            query = query.toString();
            return connection.any(query);
        },
        getRelated:function(gosmid,connection = db){
             let query= squel.select()
            .from('GOSMActivity',"G")
            .where('GOSM = ?',gosmid)
            .where('isrelatedtoorganizationnature = true')
            .where('isingosm = true')
            .field('COUNT(id) as related');

            query = query.toString();
            return connection.one(query);
        },
        getNotRelated:function(gosmid,connection = db){
             let query= squel.select()
            .from('GOSMActivity',"G")
            .where('GOSM = ?',gosmid)
            .where('isrelatedtoorganizationnature = false')
            .where('isingosm = true')
            .field('COUNT(id) as notrelated');

            query = query.toString();
            return connection.one(query);
        },

        getnotinGOSMActivities: function(GOSMID, fields, connection = db) {
            let query= squel.select()
            .from('GOSMActivity',"G")
                .left_join("ProjectProposal",'P','P.GOSMActivity = G.ID')
            .field("TO_CHAR(G.targetdatestart,'Mon DD, YYYY') as startdate")
            .field("TO_CHAR(G.targetdatestart,'MM/DD/YYYY') as targetdatestart1")
            .field("TO_CHAR(G.targetdateend,'MM/DD/YYYY') as targetdateend1")
            .field("*")
            .field("G.ID AS GID")
            .field('P.ID AS PID')
            .field('P.STATUS AS PSTATUS')
            .where('GOSM = ?',GOSMID)
            .where('G.isingosm = false');

            query = query.toString();
            return connection.any(query);
        },

        getGOSMActivityType: function(GOSMID, fields = 'activityType', connection = db) {
            let query= squel.select()
            .from('GOSMActivity')
            .where('id = ${GOSMID}');
            attachFields(query, fields);

            let param = Object.create(null);
            param.GOSMID = GOSMID;

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query, param);
        },

        getGOSMActivityAttachmentRequirement: function(type, fields = 'activityType', connection = db) {
            let query= squel.select()
                .from('ActivityAttachmentRequirement','aar')
                    .left_join('DocumentAttachmentRequirement', 'dar', 'aar.attachment = dar.id')
                .where('aar.activitytype = ${type}');
            attachFields(query, fields);

            let param = Object.create(null);
            param.type = type;

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query, param);
        },

        getGOSMActivity: function(param) {
            return db.one(getGOSMActivitySQL, param);
        },

        getGOSMActivityProjectHeads: function(param) {
            return db.any(getGOSMActivityProjectHeadsSQL, param);
        },

        //TODO: Delete function
        getSubmissionYears: function() {
            return db.any(query_getSubmissionYears);
        },
        getAllCurrent: function() {
            return db.any(query_getAll);
        },

        /**
         * 
         * @method   insertNewGOSM
         * @param    {integer}           termID               [description]
         * @param    {integer}           studentOrganization  [description]
         * @param    {integer}           preparedBy           [description]
         * @param    {boolean}           returnID             If the id of the newly created GOSM should be returned
         * @param    {pg-connection}     connection           What task or transaction to use if any, defaults to the pg-database
         * @returns  {pg-promise}                             [description]
         */
        insertNewGOSM: function(termID, studentOrganization, preparedBy, returnID, connection = db) {
            logger.debug(`insertNewGOSM(termID: ${termID}, studentOrganization: ${studentOrganization}, preparedBy: ${preparedBy}, returnID: ${returnID})`, log_options);

            let param = Object.create(null);
            param.termID = termID;
            param.studentOrganization = studentOrganization;
            param.preparedBy = preparedBy;
            
            if(returnID){
                return connection.one(insertGOSM_Returning, param);
            }
            return connection.none(insertGOSM, param);
        },

        deleteActivity: function(param) {
            return db.none(deleteActivitySQL, param);
        },
        updateActivity: function(param) {
            return db.one(updateActivitySQL, param);
        },
        submitGOSM: function(param) {
            return db.none(submitGOSMSQL, param);
        },

        getOrgGOSM: function(param, connection = db) {
            return connection.oneOrNone(getOrgGOSMSQL, param);
        },

        getActivitySummaryPerOrg: function(param, connection = db){
            return connection.any(getActivitySummaryPerOrgSQL, param);
        },

        getOrgAllGOSM: function(orgid, connection = db) {
            let query = squel.select()
                .from('GOSM','G')
                .field('*')
                .field('G.ID','GID')                
                .left_join('Term','T','G.TERMID = T.ID')                
                .field("CONCAT(SUBSTR(CAST(T.schoolyearid AS TEXT),0,5),' - ',SUBSTR(CAST(T.schoolyearid AS TEXT),5,4)  ) AS YUGA")
                .field('*')
                .where('G.studentOrganization = ?',orgid);
                console.log(query.toString())
            return connection.any(query.toString());
        },

        getGOSMActivityOrg: function(param, connection = db) {
            return connection.oneOrNone(getGOSMActivityOrgSQL, param);
        },

        getActivitiesFromID: (GOSMID, fields, connection = db) => {
            let query = squel.select()
                .from('GOSMActivity')
                .where('GOSM = ${GOSMID}');

            attachFields(query, fields);
            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);

            /*
                let param = {
                    GOSMID: GOSMID
                };
            */
            let param = Object.create(null);
            param.GOSMID = GOSMID;
            return connection.any(query, param);
        },

        /**
            Aliases used:
            GOSMActivity = ga
            activityNature = an
            activityType = at
        */
        getActivityDetails: function(id, fields, connection = db) {
            logger.info(`call getActivityDetails(id: ${id}, fields: ${JSON.stringify(fields)})`, log_options);

            let param = Object.create(null);
            param.activityID = id;
            
            let query = squel.select()
                .from('GOSMActivity', 'ga')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .where('ga.id = ${activityID}');
            attachFields(query, fields);

            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.oneOrNone(query, param);
        },

        /**

        */
        getActivityProjectHeads: function(id, fields, connection = db) {
            logger.info(`call getActivityProjectHeads(id: ${id}, fields: ${JSON.stringify(fields)})`, log_options);

            let query = squel.select()
                .from('GOSMActivityProjectHead', 'ph')
                    .left_join('Account', 'a', 'ph.idNumber = a.idNumber')
                .where('ph.activityid = ${activityID}');
            attachFields(query, fields);
            query = query.toString();
            
            /*
                let param = {
                    activityID: id
                };
            */
            let param = Object.create(null);
            param.activityID = id;
            
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query, param);
        },

        updateGOSMStatus: function(id, statusID, preparedBy, comments, connection = db) {
            logger.debug(`updateGOSMStatus(id: ${id}, statusID: ${statusID}, preparedBy: ${preparedBy}, comments: ${comments})`, log_options);

            let dontQuote = {
                dontQuote: true
            };

            let query = squel.update()
                .table('GOSM')
                .set('status', '${statusID}', dontQuote)
                .set('statusEvaluator', '${preparedBy}', dontQuote)
                .where('id = ${id}');

            /*
                let param = {
                    id: id,
                    statusID: statusID,
                    comment: (optional)
                };
            */
            let param = Object.create(null);
            param.id = id;
            param.statusID = statusID;
            param.preparedBy = preparedBy;

            if (typeof comments === 'string') {
                query.set('comments', '${comments}', dontQuote);
                param.comments = comments;
            }

            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.none(query, param);
        },

        updateActivityComment: function(id, comments, connection = db) {
            let query = squel.update()
                .table('GOSMActivity')
                .set('comments', '${comments}', {
                    dontQuote: true
                }).where('id = ${id}');
            query = query.toString();

            let param = Object.create(null);
            param.id = id;
            param.comments = comments;

            logger.debug(`Executing query: ${query}`, log_options);
            return connection.none(query, param);
        },

        getGOSM: function(id, fields, connection = db) {
            logger.info(`getGOSM(id: ${id})`, log_options);

            let query = squel.select()
                .from('GOSM', 'g')
                .where('id = ${id}');
            attachFields(query, fields);
            query = query.toString();
            
            let param = Object.create(null);
            param.id = id;

            logger.debug(`Executing query: ${query}`, log_options);
            return connection.one(query, param);
        },

        getCurrentTermGOSM: function(organizationID, fields, connection = db) {
            logger.info(`getCurrentTermGOSM(organizationID: ${organizationID})`, log_options);

            let query = squel.select()
                .from('GOSM', 'g')
                .where('studentOrganization = ${organizationID}')
                .where('termID = system_get_current_term_id()');
            attachFields(query, fields);
            query = query.toString();
            
            let param = Object.create(null);
            param.organizationID = organizationID;

            logger.debug(`Executing query: ${query}`, log_options);
            return connection.oneOrNone(query, param);
        }
    };
};
