'use strict';

const logger = global.logger;
const log_options = {
    from: 'GOSM-Model'
};

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles) {
    let dbHelper = require('../utility/databaseHelper')(db);
    let queryExec = dbHelper.queryExec;
    let attachFields = dbHelper.attachFields;

    const Model = function(queryExec, attachFields){
    	this._queryExec = queryExec;
    	this._attachFields = attachFields;
    };

    Model.prototype.getProjectProposalDetails = function(id, fields, connection){
    	let query = squel.select()
    	.from('ProjectProposal', 'pp')
    	.where('pp.id = ${id}')
    	.with('GOSMA', 
    		squel.select()
    		.from('GOSMActivity', 'ga')
    		.where('ga.id = ?', squel.select()
    		                         .field('GOSMActivity')
    			                     .from('ProjectProposal', 'pp')
    			                     .where('pp.id = ${id}')))
    	.left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id');

    	this._attachFields(query, fields);

    	query = query.toString();
    	logger.debug(`Query: ${query}`,log_options);
    	//return this._queryExec('any', query, {id: id}, connection);
    };

    return new Model(queryExec, attachFields);
};