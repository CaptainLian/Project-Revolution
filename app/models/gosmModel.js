'use strict';

module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	var insertProposedActivitySQL = queryFiles.insertProposedActivity;
	var getSchoolYearSQL = queryFiles.getSchoolYear;
	var getAllActivityNatureSQL = queryFiles.getAllActivityNature;
	var getGOSMActivitiesSQL = queryFiles.getGOSMActivities;
	const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
	const query_getAllCurrent = queryFiles.gosm_getAllCurrent;
	const query_getAll = queryFiles.gosm_getAll;

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
			return db.many(getGOSMActivitiesSQL, param);
		},
		getSubmissionYears: function(){
			return db.any(query_getSubmissionYears);
		},
		getAll: function(){
			return db.any(query_getAll);
		} 
	};
};