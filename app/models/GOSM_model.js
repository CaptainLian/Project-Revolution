'use strict';

module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;
	var insertProposedActivitySQL = queryFiles.insertProposedActivity;

	return {
		getAllActivityTypes: function(){
			return db.many(getAllActivityTypesSQL);
		},//getAllActivityTypes()
		insertProposedActivity: function(){
			return db.none(insertProposedActivitySQL)
		}
	};
};