'use strict';

const logger = global.logger;
const log_options = {
    from: 'GOSM-Model'
};

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles) {
    const getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
    const insertProposedActivitySQL = queryFiles.insertProposedActivity;
    const insertActivityProjectHeadSQL = queryFiles.insertActivityProjectHead;
    const getSchoolYearSQL = queryFiles.getSchoolYear;
    const getAllActivityNatureSQL = queryFiles.getAllActivityNature;
    const getGOSMActivitiesSQL = queryFiles.getGOSMActivities;
    const insertNewGOSMSQL = queryFiles.insertNewGOSM;
    const deleteActivitySQL = queryFiles.deleteActivity;
    const updateActivitySQL = queryFiles.updateActivity;
    const submitGOSMSQL = queryFiles.submitGOSM;
    const getOrgGOSMSQL = queryFiles.getOrgGOSM;
    const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
    const query_getAll = queryFiles.gosm_getAll;

    const dbHelper = require('../utility/databaseHelper');
    const attachFields = dbHelper.attachFields;

    return {
        getAllActivityTypes: function(connection = db) {
            return connection.many(getAllActivityTypesSQL);
        }, //getAllActivityTypes()
        getAllActivityNature: function(connection = db) {
            return connection.many(getAllActivityNatureSQL);
        },
        insertProposedActivity: function(param, connection = db) {
            return connection.one(insertProposedActivitySQL, param);
        },
        insertActivityProjectHead: function(param, connection = db) {
            return db.none(insertActivityProjectHeadSQL, connection);
        },
        getSchoolYear: function(connection = db) {
            return connection.one(getSchoolYearSQL);
        },

        getGOSMActivities: function(param, connection = db) {
            return connection.any(getGOSMActivitiesSQL, param);
        },

        //TODO: Delete function
        getSubmissionYears: function() {
            return db.any(query_getSubmissionYears);
        },
        getAllCurrent: function() {
            return db.any(query_getAll);
        },
        insertNewGOSM: function(param) {
            return db.none(insertNewGOSMSQL, param);
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