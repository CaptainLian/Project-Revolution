'use strict';

const log_options= Object.create(null);
log_options.from = 'Post Project Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {

	const insertPostProjectProposal = queryFiles.insertPostProjectProposal;
	const updatePostProjectProposal = queryFiles.updatePostProjectProposal;


	return {
		updatePostProjectProposal (param, connection = this._db) {
        	return connection.none(updatePostProjectProposal, param);
    	},
    	insertPostProjectProposal (param, connection = this._db) {
        	return connection.none(insertPostProjectProposal, param);
    	},
	};
}