'use strict';

const logger = global.logger;

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
    const getOrgGOSMSQL = queryFiles.getOrgGOSM;
    const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
    const query_getAllCurrent = queryFiles.gosm_getAllCurrent;
    const query_getAll = queryFiles.gosm_getAll;
    const query_getActivitiesFromID = queryFiles.gosm_getSpecificOrg;

    const dbHelper = require('../utility/databaseHelper')(db);
	const queryExec = dbHelper.queryExec;
	const attachFields = dbHelper.attachFields;

    return {
        getAllActivityTypes: function(fields, connection) {
            return db.many(getAllActivityTypesSQL);
        }, //getAllActivityTypes()
        getAllActivityNature: function() {
            return db.many(getAllActivityNatureSQL);
        },
        insertProposedActivity: function(param) {
            return db.one(insertProposedActivitySQL, param);
        },
        insertActivityProjectHead: function(param) {
            return db.none(insertActivityProjectHeadSQL, param);
        },
        getSchoolYear: function() {
            return db.one(getSchoolYearSQL);
        },
        getGOSMActivities: function(param) {
            return db.any(getGOSMActivitiesSQL, param);
        },
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
        getOrgGOSM: function(param) {
            return db.oneOrNone(getOrgGOSMSQL, param);
        },

        getActivitiesFromID(GOSMID, fields, connection) {
            let query = squel.select()
                .from('GOSMActivity')
                .where('GOSM = ${GOSMID}');

            attachFields(query, fields);
            query = query.toString();
            logger.debug(`Executing query: ${query}`);
            return queryExec('any', query, {GOSMID: GOSMID}, connection);
        },

        /**
			Aliases used:
			GOSMActivity = ga
			activityNature = an
			activityType = at
        */
        getActivityDetails: function(id, fields, connection) {
        	let query = squel.select()
        		.from('GOSMActivity', 'ga')
        			.left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
        			.left_join('ActivityType', 'at', 'ga.activityType = at.id')
        		.where('ga.id = ${activityID}');

        	dbHelper.attachFields(query, fields);

        	query = query.toString();
        	logger.debug(`Executing query: ${query}`, {from: 'GOSM_model'});
            return queryExec('oneOrNone', query, {
                activityID: id
            }, connection);
        },

        getActivityProjectHeads: function(id, connection) {
            return queryExec('manyOrNone', queryFiles.gosm_getActivityProjectHeadsFromID, {
                activityID: id
            }, connection);
        }
    };
};