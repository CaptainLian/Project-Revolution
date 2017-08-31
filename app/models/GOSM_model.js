'use strict';

module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	var insertProposedActivitySQL = queryFiles.insertProposedActivity;
	var getSchoolYearSQL = queryFiles.getSchoolYear;
	var getAllActivityNatureSQL = queryFiles.getAllActivityNature;
	var getGOSMActivitiesSQL = queryFiles.getGOSMActivities;

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
		}
	};
};