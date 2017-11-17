'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const OrgresModel = Object.create(null);

    const getActivitiesForResearchFormSQL = queryFiles.getActivitiesForResearchForm;
    const getOrganizationsForResearchFormSQL = queryFiles.getOrganizationsForResearchForm;
	
	OrgresModel.getActivitiesForResearchForm = function(connection = database) {
        
        return connection.any(getActivitiesForResearchFormSQL);
    };

    OrgresModel.getOrganizationsForResearchForm = function(connection = database) {

        return connection.any(getOrganizationsForResearchFormSQL);
    };


	return OrgresModel;
};