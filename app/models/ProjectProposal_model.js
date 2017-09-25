'use strict';

const logger = global.logger;
const log_options = {
    from: 'ProjectProposal-ProjectProposalModel'
};

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles) {

    const insertProjectProposalSQL = queryFiles.insertProjectProposal;
    const insertProjectProposalProgramDesignSQL = queryFiles.insertProjectProposalProgramDesign;
    const insertProjectProposalProjectedIncomeSQL = queryFiles.insertProjectProposalProjectedIncome;
    const insertProjectProposalExpensesSQL = queryFiles.insertProjectProposalExpenses;
    const getProjectProposalsSQL = queryFiles.getProjectProposals;
    const getProjectProposalsPerStatusSQL = queryFiles.getProjectProposalsPerStatus;

    let dbHelper = require('../utility/databaseHelper')(db);

    const ProjectProposalModel = function(db, attachFields) {
        logger.debug('Constructing ProjectProposal-ProjectProposalModel');
        this._db = db;
        this._attachFields = attachFields;
    };

    /*  
        Merges the tables
        ProjectProposal = pp 
        GOSMActivity = ga
    */
    ProjectProposalModel.prototype.getActivityProjectProposalDetails = function(id, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.id = {$id}'))
            .with('GOSMA',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))
            .from('PPR', 'pp')
            .left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id');

        this._attachFields(query, fields);

        query = query.toString();
        logger.debug(`Query: ${query}`, log_options);

        return connection.oneOrNone(query, {
            id: id
        });
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
                .field('DISTINCT GOSMActivity')
                .from('PPR')))

        .with('GOSM',
            squel.select()
            .from('GOSM', 'g')
            .field('DISTINCT g.id')
            .field('g.studentOrganization')
            .where('g.id IN ?',
                squel.select()
                .field('GOSM')
                .from('GOSMA')))

        .with('ORG',
            squel.select()
            .from('StudentOrganization', 'so')
            .where('so.id IN ?',
                squel.select()
                .field('g.studentOrganization')
                .from('GOSM', 'g')))

        .from('PPR', 'pp')
            .left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id')
            .left_join('GOSM', 'g', 'ga.GOSM = g.id')
            .left_join('ORG', 'so', 'g.studentOrganization = so.id');
        this._attachFields(query, fields);

        query = query.toString();
        logger.debug(`Query: ${query}`, log_options);
        return connection.any(query);
    };

    ProjectProposalModel.prototype.insertProjectProposal = function(param, connection = this._db) {
        //TODO: implementation, test
        return connection.one(insertProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalDesign = function(param, connection = this._db) {
        //TODO: implementation, test 
        return connection.none(insertProjectProposalProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalProjectedIncome = function(param, connection = this._db) {
        //TODO: implementation, test
        return connection.none(insertProjectProposalProjectedIncomeSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalExpenses = function(param, connection = this._db) {
        //TODO: implementation, test
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

    return new ProjectProposalModel(db, dbHelper.attachFields);
};