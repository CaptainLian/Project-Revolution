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

            return connection.none (query.toString(), {activityID: activityID});
        },

        insertProjectHead:(activityID, projectHead, connection = db) => {
            logger.debug('insertProjectHead()', log_options);
            let query = squel.insert()
                .into('GOSMActivityProjectHead')
                .set('activityID', '${activityID}', {
                    dontQuote: true
                })
                .set('idNumber', '${idNumber}', {
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

        getGOSMActivities: function(GOSMID, fields, connection = db) {
            let query= squel.select()
            .from('GOSMActivity')
            .where('GOSM = ${GOSMID}');
            attachFields(query, fields);

            let param = Object.create(null);
            param.GOSMID = GOSMID;

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query, param);
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
         * [insertNewGOSM description]
         * @method  insertNewGOSM
         * @param   {Integer}      termID              [description]
         * @param   {Integer}      studentOrganization [description]
         * @param   {Boolean}      returning           [description]
         * @param   {[pg-connection, pg-task, pg-transaction] (Optional)}      connection          [description]
         * @returns {Promise}                          [description]
         */
        insertNewGOSM: function(termID, studentOrganization, returning, connection = db) {
            let param = Object.create(null);
            param.termID = termID;
            param.studentOrganization = studentOrganization;
            if(returning){
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
            let query = squel.select()
                .from('GOSMActivity', 'ga')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .where('ga.id = ${activityID}');

            attachFields(query, fields);

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);

            /*
                let param = {
                    activityID: id
                };
            */
            let param = Object.create(null);
            param.activityID = id;
            return connection.oneOrNone(query, param);
        },

        /**

        */
        getActivityProjectHeads: function(id, fields, connection = db) {
            let query = squel.select()
                .from('GOSMActivityProjectHead', 'ph')
                    .left_join('Account', 'a', 'ph.idNumber = a.idNumber')
                .where('ph.activityid = ${activityID}');
            attachFields(query, fields);

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);
            /*
                let param = {
                    activityID: id
                };
            */
            let param = Object.create(null);
            param.activityID = id;
            return connection.any(query, param);
        },

        updateGOSMStatus: function(id, statusID, comments, connection = db) {
            let query = squel.update()
                .table('GOSM')
                .set('status', '${statusID}')
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

            if (typeof comments === 'string') {
                query.set('comments', '${comments}', {
                    dontQuote: true
                });
                param.comments = comments;
            }

            query = query.toString();
             logger.debug(`Executing query: ${query} with parameters ${JSON.stringify(param)}`, log_options);
            return connection.none(query, param);
        },

        updateActivityComment: function(id, comments, connection = db) {
            let query = squel.update()
                .table('GOSMActivity')
                .set('comments', '${comments}', {
                    dontQuote: true
                })
                .where('id = ${id}');

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);

            /*
                let param = {
                    id: id,
                    comments: comments
                };
            */
            let param = Object.create(null);
            param.id = id;
            param.comments = comments;
            return connection.none(query, param);
        },

        getGOSM: function(id, fields, connection = db) {
            let query = squel.select()
                .from('GOSM', 'g')
                .where('id = ${id}');
            attachFields(query, fields);

            query = query.toString();
             logger.debug(`Executing query: ${query}`, log_options);

            /*
                let param = {
                    id: id
                };
            */
            let param = Object.create(null);
            param.id = id;
            return connection.one(query, param);
        }
    };
};
