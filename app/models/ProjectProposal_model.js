'use strict';


const log_options = Object.create(null);
log_options.from = 'ProjectProposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {


    const getLatestProjectProposalAttachment = queryFiles.getLatestProjectProposalAttachment;
    const getProjectHeadsGOSM = queryFiles.getProjectHeadsGOSM;
    const insertProjectProposalAttachment = queryFiles.insertProjectProposalAttachment;
    const updatePPRBriefContextSQL = queryFiles.updatePPRBriefContext;
    const insertProjectProposalSQL = queryFiles.insertProjectProposal;
    const insertProjectProposalProgramDesignSQL = queryFiles.insertProjectProposalProgramDesign;
    const insertProjectProposalProjectedIncomeSQL = queryFiles.insertProjectProposalProjectedIncome;
    const insertProjectProposalExpensesSQL = queryFiles.insertProjectProposalExpenses;
    const getProjectProposalSQL = queryFiles.getProjectProposal;
    const getProjectProposalsPerStatusSQL = queryFiles.getProjectProposalsCountPerStatus;
    const getPPRProjectedCostSQL = queryFiles.getPPRProjectedCost;
    const getApprovedPPRsSQL = queryFiles.getApprovedPPRs;
    const getNextActivityForApprovalSQL = queryFiles.getNextActivityForApproval;
    const getGOSMActivitiesToImplementSQL = queryFiles.getGOSMActivitiesToImplement;
    const updatePPRStatusSQL = queryFiles.updatePPRStatus;
    const updateIsProgramDesignCompleteSQL = queryFiles.updateIsProgramDesignComplete;
    const updateIsAttachmentsCompleteSQL = queryFiles.updateIsAttachmentsComplete;
    const updatePPRExpensesSQL = queryFiles.updatePPRExpenses;
    const submitProjectProposalSQL = queryFiles.submitProjectProposal;
    const deleteProgramDesignSQL = queryFiles.deleteProgramDesign;
    const deleteExpensesSQL = queryFiles.deleteExpenses;
    const getAllVenuesSQL = queryFiles.getAllVenues;
    const getOrgFacultyAdvisersSQL = queryFiles.getOrgFacultyAdvisers;
    const getAllMyActivity = queryFiles.getAllMyActivity;
    const getPPRToCreatePubsList = queryFiles.getPPRToCreatePubsList;
    const getExpenseTypesSQL = queryFiles.getExpenseTypes;

    /**
     * class with properties
     * {
     *     _db
     *     _attachfields
     * }
     * @Class ProjectProposalModel
     * @param  {pg-connection} db [description]
     */
    const ProjectProposalModel = function(db, modules) {
        this._db = db;
        const dbHelper = require('../utility/databaseHelper');
        this._attachFields = dbHelper.attachFields;

        this._logger = modules.logger;
    };

   /**
    * Tables that can be currently accessed in this query for fields
    * ProjectProposal ppr
    * GosmActivity ga
    * ActivityType at
    * ActivityNature an
    * studentOrganization so
    *
    * @method  getActivityProjectProposalDetails
    * @param   {Integer}                                     id            [description]
    * @param   {[String, Array] (Optional)}                  fields        [description]
    * @param   {[pg-connection, pg-task, pg-transaction]}    connection    [description]
    * @returns {Promise}                                                   [description]
    */
    ProjectProposalModel.prototype.getActivityProjectProposalDetails = function(id, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.id = ${id}'))

            .with('gosm_activity',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))

            .with('student_organization',
                squel.select()
                .from('StudentOrganization', 'o')
                .where('o.id = ?',
                    squel.select()
                    .from('GOSM', 'g')
                    .field('studentOrganization')
                    .where('g.id = ?',
                        squel.select()
                        .from('gosm_activity', 'ga')
                        .field('GOSM'))))

            .from('PPR', 'pp')
                .left_join('gosm_activity', 'ga', 'TRUE')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('student_organization', 'so', 'TRUE')
                .left_join('ActivityVenue', 'av', 'pp.venue = av.id');

        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Executing Query: ${query}`, log_options);

        let param = Object.create(null);
        param.id = id;
        return connection.oneOrNone(query, param);
    };

    /**
    * Tables that can be currently accessed in this query for fields
    * ProjectProposal ppr
    * GosmActivity ga
    * ActivityType at
    * ActivityNature an
    * studentOrganization so
    *
    * @method  getActivityProjectProposalDetails
    * @param   {Integer}                                     id            [description]
    * @param   {[String, Array] (Optional)}                  fields        [description]
    * @param   {[pg-connection, pg-task, pg-transaction]}    connection    [description]
    * @returns {Promise}                                                   [description]
    */
    ProjectProposalModel.prototype.getActivityProjectProposalDetailsGAID = function(GOSMActivity, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.GOSMActivity = ${GOSMActivity}'))

            .with('gosm_activity',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))

            .with('student_organization',
                squel.select()
                .from('StudentOrganization', 'o')
                .where('o.id = ?',
                    squel.select()
                    .from('GOSM', 'g')
                    .field('studentOrganization')
                    .where('g.id = ?',
                        squel.select()
                        .from('gosm_activity', 'ga')
                        .field('GOSM'))))

            .from('PPR', 'pp')
                .left_join('gosm_activity', 'ga', 'TRUE')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('student_organization', 'so', 'TRUE')
                .left_join('"ActivityVenue"', 'av', 'pp.venue = av.id');

        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Executing Query: ${query}`, log_options);

        let param = Object.create(null);
        param.GOSMActivity = GOSMActivity;
        return connection.oneOrNone(query, param);
    };

    /*
        Merges the tables
        ProjectProposal = pp
        GOSMActivity = ga
    */
   /**
    * Retrieves All Project Proposals
    * @method  getAllActivityProjectProposal
    * @param   {[String, Array] (Optional)}                  fields     [description]
    * @param   {[pg-conncetion, pg-transaction, pg-task]}    connection [description]
    * @returns {Promise}                                     [description]
    */
    ProjectProposalModel.prototype.getAllActivityProjectProposal = function(fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal')
                .where('status <> 1')
                .where('status <> 3'))

        .with('GOSMA',
            squel.select()
            .from('GOSMActivity')
            .where('id IN ?',
                squel.select()
                .from('PPR')
                .field('DISTINCT GOSMActivity')))

        .with('GOSM',
            squel.select()
            .from('GOSM', 'g')
            .field('DISTINCT g.id')
            .field('g.studentOrganization')
            .where('g.id IN ?',
                squel.select()
                .from('GOSMA')
                .field('GOSM')))

        .with('ORG',
            squel.select()
            .from('StudentOrganization', 'so')
            .where('so.id IN ?',
                squel.select()
                .from('GOSM', 'g')
                .field('g.studentOrganization')))

        .from('PPR', 'pp')
            .left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id')
            .left_join('GOSM', 'g', 'ga.GOSM = g.id')
            .left_join('ORG', 'so', 'g.studentOrganization = so.id');
        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Query: ${query}`, log_options);
        return connection.any(query);
    };

    ProjectProposalModel.prototype.getProjectProposalProgramDesign = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProgramDesign', 'pppd')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();
        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getProjectProposalExpenses = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalExpenses', 'ppe')
            .left_join('ExpenseType', 'et', 'ppe.type = et.id')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();

        /**
         * conts param = {
         *     id: id
         * }
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProjectedIncome =  function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProjectedIncome', 'pppi')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();

        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getProjectProposalAttachment = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalAttachment', 'ppa')
            .left_join('DocumentAttachmentRequirement', 'dar', 'ppa.requirement = dar.id')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();

        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getPPRProjectedCost = function(param, connection = this._db) {
        return connection.oneOrNone(getPPRProjectedCostSQL, param);
    };
    ProjectProposalModel.prototype.getProjectHeadsGOSM = function(param, connection = this._db) {
        return connection.any(getProjectHeadsGOSM, param);
    };

    ProjectProposalModel.prototype.getGOSMActivitiesToImplement = function(param, connection = this._db) {
        return connection.any(getGOSMActivitiesToImplementSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposal = function(param, connection = this._db) {
        return connection.one(getProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRBriefContext = function(param, connection = this._db) {
        //TODO: test
        return connection.none(updatePPRBriefContextSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposal  = function(param, connection = this._db){
        return connection.one(insertProjectProposalSQL, param);
    };


    ProjectProposalModel.prototype.updateIsProgramDesignComplete = function(param, connection = this._db) {
        return connection.none(updateIsProgramDesignCompleteSQL, param);
    };

    ProjectProposalModel.prototype.updateIsAttachmentsComplete = function(param, connection = this._db){
        return connection.none(updateIsAttachmentsCompleteSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalDesign = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalAttachment = function(param, connection = this._db) {
        //TODO: test

        return connection.none(insertProjectProposalAttachment, param);
    };

    ProjectProposalModel.prototype.getLatestProjectProposalAttachment = function(param, connection = this._db) {
        //TODO: test

        return connection.any(getLatestProjectProposalAttachment, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalProjectedIncome = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalProjectedIncomeSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalExpenses = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalExpensesSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalsCountPerStatus = function(gosm, status, connection = this._db) {

        /**
         * const param = {
         *     gosm: gosm,
         *     status: status
         * };
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.gosm = gosm;
        param.status = status;

        return connection.one(getProjectProposalsPerStatusSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProjectHeads = function(id, fields, connection = this._db){
        /**
         * const param = {
         *     id: id
         * };
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.id = id;

        return connection.any(queryFiles.getProjectProposalProjectHeads, param);
    };

    ProjectProposalModel.prototype.getNextActivityForApproval = function(idNumber, connection = this._db){
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.oneOrNone(getNextActivityForApprovalSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRStatus = function(param, connection = this._db){
        return connection.none(updatePPRStatusSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRExpenses = function(param, connection = this._db){
        return connection.none(updatePPRExpensesSQL, param);
    };

    ProjectProposalModel.prototype.submitProjectProposal = function(param, connection = this._db){
        return connection.none(submitProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.getApprovedPPRs = function(connection = this._db){
        return connection.any(getApprovedPPRsSQL);
    };

    ProjectProposalModel.prototype.deleteProgramDesign = function(param, connection = this._db){
        return connection.none(deleteProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.deleteExpenses = function(param, connection = this._db){
        return connection.none(deleteExpensesSQL, param);
    };
    ProjectProposalModel.prototype.getAllMyActivity = function(param, connection = this._db){
        return connection.any(getAllMyActivity, param);
    };

    ProjectProposalModel.prototype.getAllVenues = function(connection = this._db){
        return connection.any(getAllVenuesSQL);
    };

    ProjectProposalModel.prototype.getOrgFacultyAdvisers = function(param, connection = this._db){
        return connection.any(getOrgFacultyAdvisersSQL, param);
    };
    ProjectProposalModel.prototype.getPPRToCreatePubsList = function(param, connection = this._db){
        return connection.any(getPPRToCreatePubsList, param);
    };

    ProjectProposalModel.prototype.getExpenseTypes = function(connection = this._db){
        return connection.many(getExpenseTypesSQL);
    };

    const getSignatoriesSQL = queryFiles.PPR_get_signatories;
    ProjectProposalModel.prototype.getSignatories = function(activityID, connection = this._db){
        return connection.many(getSignatoriesSQL, {
            activityID: activityID
        });
    };

    return new ProjectProposalModel(db, modules);
};
