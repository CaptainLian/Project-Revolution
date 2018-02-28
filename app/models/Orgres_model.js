'use strict';

module.exports = function(configuration, modules, database, queryFiles){
	const OrgresModel = Object.create(null);

    const getActivitiesForResearchFormSQL = queryFiles.getActivitiesForResearchForm;
    const getOrganizationsForResearchFormSQL = queryFiles.getOrganizationsForResearchForm;
    const insertActivityResearchFormSQL = queryFiles.insertActivityResearchForm;
    const getOrgresList = queryFiles.getOrgresList;
    const getOrgresOtherDetails = queryFiles.getOrgresOtherDetails;
    const calculate_peractivity = queryFiles.calculate_peractivity;

    const insertTermSQL = queryFiles.insertTerm;
    const insertSchoolYearSQL = queryFiles.insertSchoolYear;
    const getCurrentSchoolYearTermsSQL = queryFiles.getCurrentSchoolYearTerms;

    const insertOfficerSurveyFormSQL = queryFiles.insertOfficerSurveyForm;
    const insertMemberSurveyFormSQL = queryFiles.insertMemberSurveyForm;


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

    OrgresModel.calculate_peractivity = function(param, connection = database) {
        return connection.any(calculate_peractivity, param);
    };

    OrgresModel.insertTerm  = function (param, connection = database) {
        return connection.none(insertTermSQL, param);
    };

    OrgresModel.insertSchoolYear = function (param, connection = database) {
        return connection.one(insertSchoolYearSQL, param);
    };

    OrgresModel.getCurrentSchoolYearTerms = function (connection = database){
        return connection.any(getCurrentSchoolYearTermsSQL);
    };

    OrgresModel.insertOfficerSurveyForm = function(param, connection = database){
        return connection.none(insertOfficerSurveyFormSQL, param);
    };

    OrgresModel.insertMemberSurveyForm = function(param, connection = database){
        return connection.none(insertMemberSurveyFormSQL, param);
    };

	return OrgresModel;
};
