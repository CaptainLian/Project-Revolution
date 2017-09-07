'use strict';

const logger = global.logger;
const log_options = {from: 'GOSM-Model'};

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
        getAllActivityTypes: function(connection) {
            return db.many(getAllActivityTypesSQL);
        }, //getAllActivityTypes()
        getAllActivityNature: function() {
            return db.many(getAllActivityNatureSQL);
        },
        insertProposedActivity: function(param, connection) {
            return queryExec('one', insertProposedActivitySQL, param, connection);
        },
        insertActivityProjectHead: function(param, connection) {
            return queryExec('none', insertActivityProjectHeadSQL, param, connection);
        },
        getSchoolYear: function(connection) {
            return queryExec('one', getSchoolYearSQL, undefined, connection);
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
        getOrgGOSM: function(param, connection) {
            return queryExec('oneOrNone', getOrgGOSMSQL, param, connection);
        },

        getActivitiesFromID(GOSMID, fields, connection) {
            let query = squel.select()
                .from('GOSMActivity')
                .where('GOSM = ${GOSMID}');

            attachFields(query, fields);
            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
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

        	attachFields(query, fields);

        	query = query.toString();
        	logger.debug(`Executing query: ${query}`, log_options);
            return queryExec('oneOrNone', query, {
                activityID: id
            }, connection);
        },

        /**
			
        */
        getActivityProjectHeads: function(id, fields, connection) {
        	let query = squel.select()
        	.from('GOSMActivityProjectHead', 'ph')
        		.left_join('Account', 'a', 'ph.idNumber = a.idNumber');
        	attachFields(query, fields);	
            
            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
            return queryExec('manyOrNone', query, {
                activityID: id
            }, connection);
        },

        updateActivityStatus: function(id, statusID, comments, connection){
        	let query = squel.update()
        	.table('GOSM')
        	.set('id', '${id}')
        	.set('status', '${statusID}');
        	query = query.toString();

        	let param = {
        		id: id,
        		statusID: statusID
        	};
        	if(typeof comments === 'string'){
        		query.set('comments', '${comments}')
        		param.comments = comments;
        	}

            logger.debug(`Executing query: ${query}`, log_options);
            return queryExec('none', query, param, connection);
        }
    };
};