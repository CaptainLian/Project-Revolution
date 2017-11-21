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

    const getPostProjectProposal = queryFiles.getPostProjectProposal;
    const insertPostProjectProposalGals = queryFiles.insertPostProjectProposalGals;
    const updatePostProjectProposalFinanceDocumentStatus = queryFiles.updatePostProjectProposalFinanceDocumentStatus;
    const insertPostProjectProposalEventPictures = queryFiles.insertPostProjectProposalEventPictures;

    const updatePostProjectFinanceCompleteness = queryFiles.updatePostProjectFinanceCompleteness;
    const updatePostProjectRequiredCompleteness = queryFiles.updatePostProjectRequiredCompleteness;
    
    const updatePostProjectProposalCompleteness = queryFiles.updatePostProjectProposalCompleteness;

    const insertPostBT = queryFiles.insertPostBT;
    const insertPostReim = queryFiles.insertPostReim;
    const insertPostDP = queryFiles.insertPostDP;

    const getPostActsDetails = queryFiles.getPostActsDetails;
    const getEventPictureMaxSubmission = queryFiles.getEventPictureMaxSubmission;
    


	return {
        insertPostBT:function (param, connection = db) {
            return connection.none(insertPostBT, param);
        },
        insertPostReim:function (param, connection = db) {
            return connection.none(insertPostReim, param);
        },
        insertPostDP:function (param, connection = db) {
            return connection.none(insertPostDP, param);
        },
		updatePostProjectProposal:function (param, connection = db) {
        	return connection.none(updatePostProjectProposal, param);
    	},
        updatePostProjectProposalCompleteness:function (param, connection = db) {
            return connection.any(updatePostProjectProposalCompleteness, param);
        },
        updatePostProjectRequiredCompleteness:function (param, connection = db) {
            return connection.any(updatePostProjectRequiredCompleteness, param);
        },
        updatePostProjectFinanceCompleteness:function (param, connection = db) {
            return connection.any(updatePostProjectFinanceCompleteness, param);
        },
        updatePostProjectProposalFinanceDocumentStatus:function (param, connection = db) {
            return connection.none(updatePostProjectProposalFinanceDocumentStatus, param);
        },
        insertPostProjectProposalGals:function (param, connection = db) {
            return connection.none(insertPostProjectProposalGals, param);
        },
        insertPostProjectProposalEventPictures:function (param, connection = db) {
            return connection.none(insertPostProjectProposalEventPictures, param);
        },
    	insertPostProjectProposal:function (param, connection = db) {
        	return connection.any(insertPostProjectProposal, param);
    	},
        getPostBriefContext:function (param, connection = db) {
            return connection.one(getPostBriefContext, param);
        },
        getPostProjectProposal:function (param, connection = db) {
            return connection.one(getPostProjectProposal, param);
        },
    	getPostActsToImplement:function (param, connection = db) {
        	return connection.any(getPostActsToImplement, param);
    	},
        getPostProjectProposalMain:function (param, connection = db) {
            return connection.one(getPostProjectProposalMain, param);
        },
        getPostActsDetails:function (param, connection = db) {
            return connection.one(getPostActsDetails, param);
        },
        getEventPictureMaxSubmission:function (param, connection = db) {
            return connection.any(getEventPictureMaxSubmission, param);
        },
        insertPostProjectExpense:function (param, connection = db) {
            return connection.none(insertPostExpense, param);
        },
	};
}