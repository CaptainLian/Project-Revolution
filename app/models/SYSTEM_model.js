'use strict';

module.exports = function(db, queryFiles){
	var checkAccount = queryFiles.checkAccount;
	

	return {
		checkAccount: function(param){
			return db.one(checkAccount, param);
		}//getAllActivityTypes()
		
	};
};