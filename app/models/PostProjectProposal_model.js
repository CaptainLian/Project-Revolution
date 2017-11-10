'use strict';

const log_options= Object.create(null);
log_options.from = 'Post Project Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {

	const insertPostProjectProposal = queryFiles.insertPostProjectProposal;
	const updatePostProjectProposal = queryFiles.updatePostProjectProposal;
	const getPostActsToImplement = queryFiles.getPostActsToImplement;
    const getPostProjectProposalMain = queryFiles.getPostProjectProposalMain;
    const getPostBriefContext = queryFiles.getPostBriefContext;
    const insertPostExpense = queryFiles.insertPostExpense;


	return {
		updatePostProjectProposal:function (param, connection = db) {
        	return connection.none(updatePostProjectProposal, param);
    	},
    	insertPostProjectProposal:function (param, connection = db) {
        	return connection.one(insertPostProjectProposal, param);
    	},
        getPostBriefContext:function (param, connection = db) {
            return connection.one(getPostBriefContext, param);
        },
    	getPostActsToImplement:function (param, connection = db) {
        	return connection.any(getPostActsToImplement, param);
    	},
        getPostProjectProposalMain:function (param, connection = db) {
            return connection.one(getPostProjectProposalMain, param);
        },
        insertPostProjectExpense:function (param, connection = db) {
            return connection.none(insertPostExpense, param);
        },
	};
}