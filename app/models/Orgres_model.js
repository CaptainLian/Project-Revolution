'use strict';
const squel = require('squel').useFlavour('postgres');
module.exports = function(configuration, modules, database, queryFiles){
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'ORGRES-Model';

	const OrgresModel = Object.create(null);

    const getActivitiesForResearchFormSQL = queryFiles.getActivitiesForResearchForm;
    const getOrganizationsForResearchFormSQL = queryFiles.getOrganizationsForResearchForm;
    
    const getOrgresList = queryFiles.getOrgresList;
    const getOrgresOtherDetails = queryFiles.getOrgresOtherDetails;
    const calculate_peractivity = queryFiles.calculate_peractivity;

    const insertTermSQL = queryFiles.insertTerm;
    const insertSchoolYearSQL = queryFiles.insertSchoolYear;
    const getCurrentSchoolYearTermsSQL = queryFiles.getCurrentSchoolYearTerms;

    const insertOfficerSurveyFormSQL = queryFiles.insertOfficerSurveyForm;
    const insertMemberSurveyFormSQL = queryFiles.insertMemberSurveyForm;

    const getAllOfficerSurveyFormSQL = queryFiles.getAllOfficerSurveyForm;
    const getAllActivityResearchFormSQL = queryFiles.getAllActivityResearchForm;
    const getAllMemberSurveyFormSQL = queryFiles.getAllMemberSurveyForm;

    const getAllOfficerSurveyFormPerTermSQL = queryFiles.getAllOfficerSurveyFormPerTerm;
    const getAllActivityResearchFormPerTermSQL = queryFiles.getAllActivityResearchFormPerTerm;
    const getAllMemberSurveyFormPerTermSQL = queryFiles.getAllMemberSurveyFormPerTerm;

	OrgresModel.getActivitiesForResearchForm = function(connection = database) {
        return connection.any(getActivitiesForResearchFormSQL);
    };

    OrgresModel.getOrganizationsForResearchForm = function(connection = database) {
        return connection.any(getOrganizationsForResearchFormSQL);
    };
    
    const insertActivityResearchFormSQL = queryFiles.insertActivityResearchForm;
    OrgresModel.insertActivityResearchForm = function(param, connection = database) {
        logger.info(`call insertActivityResearchForm(${JSON.stringify(param)})`, log_options);
        return connection.none(insertActivityResearchFormSQL, param);
    };
    OrgresModel.idNumbercheck = function(id, orig, connection = database) {
        logger.info(`call idNumbercheck(id: ${id}, orig: ${orig})`, log_options);
        var query = squel.select()
            .from('"OrganizationMember"')
            .where("organization = ${orig}")
            .where('"idNumber" = ${id}')
            .toString();

        let param = Object.create(null);
        param.id = id;
        param.orig = orig;

        logger.debug(`Executing query: ${query}`, log_options);
        return connection.one(query, param);
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
        logger.info('call insertMemberSurveyForm(' + JSON.stringify(param) + ')', log_options);
        logger.debug('Executing query: ' + insertMemberSurveyFormSQL, log_options);
        return connection.none(insertMemberSurveyFormSQL, param);
    };

    OrgresModel.getAllOfficerSurveyForm = function(connection = database){
        return connection.any(getAllOfficerSurveyFormSQL);
    };

    OrgresModel.getAllActivityResearchForm = function(connection = database){
        return connection.any(getAllActivityResearchFormSQL);
    };

    OrgresModel.getAllMemberSurveyForm = function(connection = database){
        return connection.any(getAllMemberSurveyFormSQL);
    };

    OrgresModel.getAllOfficerSurveyFormPerTerm = function(param, connection = database){
        return connection.any(getAllOfficerSurveyFormPerTermSQL, param);
    };

    OrgresModel.getAllActivityResearchFormPerTerm = function(param, connection = database){
        return connection.any(getAllActivityResearchFormPerTermSQL, param);
    };

    OrgresModel.getAllMemberSurveyFormPerTerm = function(param, connection = database){
        return connection.any(getAllMemberSurveyFormPerTermSQL, param);
    };

	return OrgresModel;
};
