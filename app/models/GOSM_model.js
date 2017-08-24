'use strict';

module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;

	return {
		getAllActivityTypes: function(){
			return db.many(getAllActivityTypesSQL);
		}//getAllActivityTypes()
	};
};