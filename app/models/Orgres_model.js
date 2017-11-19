'use strict';

module.exports = function(configuration, modules, database, queryFiles){	
	const OrgresModel = Object.create(null);

    const getActivitiesForResearchFormSQL = queryFiles.getActivitiesForResearchForm;
    const getOrganizationsForResearchFormSQL = queryFiles.getOrganizationsForResearchForm;
    const insertActivityResearchFormSQL = queryFiles.insertActivityResearchForm;
	
	OrgresModel.getActivitiesForResearchForm = function(connection = database) {
        
        return connection.any(getActivitiesForResearchFormSQL);
    };

    OrgresModel.getOrganizationsForResearchForm = function(connection = database) {

        return connection.any(getOrganizationsForResearchFormSQL);
    };

    OrgresModel.insertActivityResearchForm = function(param, connection = database) {
        return connection.none(insertActivityResearchFormSQL, param);
    };


	return OrgresModel;
};