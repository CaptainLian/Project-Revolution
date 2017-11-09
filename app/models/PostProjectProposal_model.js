'use strict';

const log_options= Object.create(null);
log_options.from = 'Post Project Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {

	const insertPostProjectProposal = queryFiles.insertPostProjectProposal;
	const updatePostProjectProposal = queryFiles.updatePostProjectProposal;
	const getPostActsToImplement = queryFiles.getPostActsToImplement;


	return {
		updatePostProjectProposal:function (param, connection = db) {
        	return connection.none(updatePostProjectProposal, param);
    	},
    	insertPostProjectProposal:function (param, connection = db) {
        	return connection.one(insertPostProjectProposal, param);
    	},
    	getPostActsToImplement:function (param, connection = db) {
        	return connection.one(getPostActsToImplement, param);
    	},
	};
}