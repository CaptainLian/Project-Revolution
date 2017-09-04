'use strict';

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
	const query_getSpecificOrg = queryFiles.gosm_getSpecificOrg;

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
		getAll: function(){
			return db.any(query_getAll);
		},
		getSpecificOrg: function(organizationID){
			return db.any(query_getSpecificOrg, {organization: organizationID});
		},
		insertNewGOSM: function(param){
			return db.none(insertNewGOSMSQL, param);
		},
		getOrgGOSM: function(param){
			return db.any(getOrgGOSMSQL, param);
		}
	};
};
