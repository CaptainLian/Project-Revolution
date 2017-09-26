'use strict';

const logger = global.logger;
const log_options = {
    from: 'ProjectProposal-Model'
};

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles) {

    const insertProjectProposalSQL = queryFiles.insertProjectProposal;
    const insertProjectProposalProgramDesignSQL = queryFiles.insertProjectProposalProgramDesign;
    const insertProjectProposalProjectedIncomeSQL = queryFiles.insertProjectProposalProjectedIncome;
    const insertProjectProposalExpensesSQL = queryFiles.insertProjectProposalExpenses;
    const getProjectProposalsSQL = queryFiles.getProjectProposals;
    const getProjectProposalsPerStatusSQL = queryFiles.getProjectProposalsPerStatus;
    const getSubmittedProjectProposalsSQL = queryFiles.getSubmittedProjectProposals;
    const getProjectProposalExpensesSQL = queryFiles.getProjectProposalExpenses;
    const getProjectProposalProjectedIncomeSQL = queryFiles.getProjectProposalProjectedIncome;
    const getProjectProposalProgramDesignSQL = queryFiles.getProjectProposalProgramDesign;



    let dbHelper = require('../utility/databaseHelper');

    const ProjectProposalModel = function(db, attachFields) {
        this._db = db;
        this._attachFields = attachFields;
    };

    /*  
        Merges the tables
        ProjectProposal = pp 
        GOSMActivity = ga
    */
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
                .left_join('gosm_activity', 'ga', 'pp.GOSMActivity = ga.id')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('student_organization', 'so', 'TRUE');

        this._attachFields(query, fields);

        query = query.toString();
        logger.debug(`Executing Query: ${query}`, log_options);

        let param = Object.create(null);
        param.id = id;
        return connection.oneOrNone(query, param);
    };

    /*  
        Merges the tables
        ProjectProposal = pp 
        GOSMActivity = ga
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
        logger.debug(`Query: ${query}`, log_options);
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
        return connection.any(query, {id: id});
    };

    ProjectProposalModel.prototype.getProjectProposalExpenses = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalExpenses', 'ppe')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();
        
        /**
         * { 
         *     id: id    
         * }
         * @type {Object}
         */
        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.insertProjectProposal = function(param, connection = this._db) {
        //TODO: test
        return connection.one(insertProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalDesign = function(param, connection = this._db) {
        //TODO: test 
        return connection.none(insertProjectProposalProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalProjectedIncome = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalProjectedIncomeSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalExpenses = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalExpensesSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposals = function(param, connection = this._db) {
        //TODO: implementation, test
        return connection.one(getProjectProposalsSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalsPerStatus = function(param, connection = this._db) {
        //TODO: implementation, test
        return connection.one(getProjectProposalsPerStatusSQL, param);
    };

    ProjectProposalModel.prototype.getSubmittedProjectProposals = function(connection = this._db) {
        //TODO: implementation, test
        return connection.oneOrNone(getSubmittedProjectProposalsSQL);
    };

    ProjectProposalModel.prototype.getProjectProposalExpenses = function(param, connection = this._db) {
        return connection.any(getProjectProposalExpensesSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProjectedIncome = function(param, connection = this._db) {
        return connection.any(getProjectProposalProjectedIncomeSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProgramDesign = function(param, connection = this._db) {
        return connection.any(getProjectProposalProgramDesignSQL, param);
    };

    return new ProjectProposalModel(db, dbHelper.attachFields);
};