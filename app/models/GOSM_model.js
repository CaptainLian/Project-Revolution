'use strict';

module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	var insertProposedActivitySQL = queryFiles.insertProposedActivity;

	return {
		getAllActivityTypes: function(){
			return db.many(getAllActivityTypesSQL);
		},//getAllActivityTypes()
		insertProposedActivity: function(param){
			return db.none(insertProposedActivitySQL, param);
		}
	};
};