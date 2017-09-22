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
    ProjectProposalModel.prototype.getActivityProjectProposalDetails = function(id, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.id = ${id}'))
            .with('GOSMA',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))
            .from('PPR', 'pp')
                .left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id');

        this._attachFields(query, fields);

        query = query.toString();
        logger.debug(`Executing Query: ${query}`, log_options);

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
        return connection.any(query, {id: id});
    };

    ProjectProposalModel.prototype.getProjectProposalExpenses = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalExpenses', 'ppe')
        .where('projectProposal = ${id}');
        this._attachFields(query, fields);

        query = query.toString();
        return connection.any(query, {id: id});
    };

    /*

        
    
    */
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

    return new ProjectProposalModel(db, dbHelper.attachFields);
};