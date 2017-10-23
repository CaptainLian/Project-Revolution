'use strict';

module.exports = function(configuration, modules, database, queryFiles){
    const query_account_is_allowed_functionality = queryFiles.account_is_allowed_functionality;

	const AccessControlModel = Object.create(null);

	AccessControlModel.getAccountAccessControl = (idNumber, connection = database) => {

	};
    AccessControlModel.isAllowedAccessFunctionality = (idNumber, functionalitySequence, organizationSequence, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        param.functionalitySequence = functionalitySequence;
        param.organizationSequence = organizationSequence;
        
        return connection.one(query_account_is_allowed_functionality, param);
    };

	return AccessControlModel;
};
