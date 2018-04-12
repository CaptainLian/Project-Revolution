'use strict';

module.exports = function(configuration, modules, database, queryFiles){
	const AccessControlModel = Object.create(null);
    
    const query_account_is_allowed_functionality = queryFiles.account_is_allowed_functionality;
    AccessControlModel.getAccountAccessControl = (idNumber, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        
        return connection.any(query_account_get_organization_functionalities, param);
    };

    const query_account_get_organization_functionalities = queryFiles. account_get_account_organization_functionalities;
    AccessControlModel.isAllowedAccessFunctionality = (idNumber, functionalitySequence, organizationSequence, connection = database) => {
        const param = Object.create(null);
        param.idNumber = idNumber;
        param.functionalitySequence = functionalitySequence;
        param.organizationSequence = organizationSequence;
        
        return connection.one(query_account_is_allowed_functionality, param);
    };

	return AccessControlModel;
};
