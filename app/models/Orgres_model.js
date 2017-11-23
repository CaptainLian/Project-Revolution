'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const OrgresModel = Object.create(null);

    const getActivitiesForResearchFormSQL = queryFiles.getActivitiesForResearchForm;
    const getOrganizationsForResearchFormSQL = queryFiles.getOrganizationsForResearchForm;
    const insertActivityResearchFormSQL = queryFiles.insertActivityResearchForm;
    const getOrgresList = queryFiles.getOrgresList;
    const getOrgresOtherDetails = queryFiles.getOrgresOtherDetails;
    
	
	OrgresModel.getActivitiesForResearchForm = function(connection = database) {
        
        return connection.any(getActivitiesForResearchFormSQL);
    };

    OrgresModel.getOrganizationsForResearchForm = function(connection = database) {

        return connection.any(getOrganizationsForResearchFormSQL);
    };

    OrgresModel.insertActivityResearchForm = function(param, connection = database) {
        return connection.none(insertActivityResearchFormSQL, param);
    };
    OrgresModel.getOrgresList = function(param, connection = database) {
        return connection.any(getOrgresList, param);
    };
    OrgresModel.getOrgresOtherDetails = function(param, connection = database) {
        return connection.any(getOrgresOtherDetails, param);
    };


	return OrgresModel;
};