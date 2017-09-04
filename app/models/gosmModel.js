'use strict';

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles){
	const getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	const insertProposedActivitySQL = queryFiles.insertProposedActivity;
	const getSchoolYearSQL = queryFiles.getSchoolYear;
	const getAllActivityNatureSQL = queryFiles.getAllActivityNature;
	const getGOSMActivitiesSQL = queryFiles.getGOSMActivities;
	const insertNewGOSMSQL = queryFiles.insertNewGOSM;
	const getOrgGOSMSQL = queryFiles.getOrgGOSM;
	const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
	const query_getAllCurrent = queryFiles.gosm_getAllCurrent;
	const query_getAll = queryFiles.gosm_getAll;
	const query_getActivitiesFromID = queryFiles.gosm_getSpecificOrg;

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
		getOrgGOSM: function(param){
			return db.oneOrNone(getOrgGOSMSQL, param);
		},
		getActivitiesFromID(GOSMID, fields){
			const query = squel.select()
				.from('GOSMActivities')
				.where('GOSM = ${GOSMID}');
			if(typeof fields === 'string'){
				query.field(fields);
			}else if(Array.isArray(fields)){
				for(const field of fields){
					query.field(field);
				}	
			}

			return db.any(query.toString(), {GOSMID: GOSMID});
		}
	};
};
