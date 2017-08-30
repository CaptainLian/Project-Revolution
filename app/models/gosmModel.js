'use strict';

module.exports = function(db, queryFiles){
	const query_getSubmissionYears = queryFiles.gosm_getSubmissionYears;
	const query_getAllCurrent = queryFiles.gosm_getAllCurrent;
	const query_getAll = queryFiles.gosm_getAll;

	return {
		getSubmissionYears: function(){
			return db.any(query_getSubmissionYears);
		},
		getAll: function(){
			return db.any(query_getAll);
		} 
	};
};