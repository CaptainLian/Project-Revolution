'use strict';
const logger = global.logger;
const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles){
	const getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	const insertProposedActivitySQL = queryFiles.insertProposedActivity;
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

	const dbType = typeof db;
	const queryExec = function(method, query, param, connection){
		const conType = typeof connection;
		if(conType === dbType || conType === 'undefined'){
			return db[method](query, param);
		}
		return connection[method](query, param);
	};

	return {
		getAllActivityTypes: function(){
			return db.many(getAllActivityTypesSQL);
		},//getAllActivityTypes()
		getAllActivityNature: function(){
			return db.many(getAllActivityNatureSQL);
		},
		insertProposedActivity: function(param){
			return db.none(insertProposedActivitySQL, param);
		},
		getSchoolYear: function(){
			return db.one(getSchoolYearSQL);
		},
		getGOSMActivities: function(param){
			return db.any(getGOSMActivitiesSQL, param);
		},
		getSubmissionYears: function(){
			return db.any(query_getSubmissionYears);
		},
		getAllCurrent: function(){
			return db.any(query_getAll);
		},
		insertNewGOSM: function(param){
			return db.none(insertNewGOSMSQL, param);
		},
		deleteActivity: function(param){
			return db.none(deleteActivitySQL, param);
		},
		getOrgGOSM: function(param){
			return db.oneOrNone(getOrgGOSMSQL, param);
		},

		getActivitiesFromID(GOSMID, fields, connection){
			let query = squel.select()
				.from('GOSMActivity')
				.where('GOSM = ${GOSMID}');
			if(typeof fields === 'string'){
				query.field(fields);
			}else if(Array.isArray(fields)){
				for(const field of fields){
					query.field(field);
				}
			}

			query = query.toString();
			logger.debug(`Executing query: ${query}`);
			return queryExec('any', query.toString(), {GOSMID: GOSMID}, connection);
		},

		getActivityDetails: function(id, connection){
			return queryExec('oneOrNone', queryFiles.gosm_getActivityFromID, {activityID: id}, connection);
		},

		getActivityProjectHeads: function(id, connection){
			return queryExec('manyOrNone', queryFiles.gosm_getActivityProjectHeadsFromID, {activityID: id});
		}
	};
};
