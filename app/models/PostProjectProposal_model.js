'use strict';

const log_options = Object.create(null);
log_options.from = 'Post Project Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {
    const logger = modules.logger;
    const log_options = {
        from: 'PostProjectProposal-Model'
    };

    const {
        attachReturning,
        attachFields
    } = (() => {
        let dbHelper = require('../utility/databaseHelper');

        let ret = Object.create(null);
        ret.attachReturning = dbHelper.attachReturning;
        ret.attachFields = dbHelper.attachFields;
        return ret;
    })();

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

    const getLatestEventPicture = queryFiles.getLatestEventPicture;
    const getPostExpenseMaxSubmissionID = queryFiles.getPostExpenseMaxSubmissionID;
    const getLatestPostExpense = queryFiles.getLatestPostExpense;
    const getPostActsToCheck = queryFiles.getPostActsToCheck;

    const updatePostPPR = queryFiles.updatePostPPR;
    const updatePostStatus = queryFiles.updatePostStatus;

    const getAllPostProjectProposalSQL = queryFiles.getAllPostProjectProposal;

    const getAllPostProjectProposalPerTermSQL = queryFiles.getAllPostProjectProposalPerTerm;


    return {
        insertPostBT: function(param, connection = db) {
            return connection.none(insertPostBT, param);
        },

        insertPostReim: function(param, connection = db) {
            return connection.none(insertPostReim, param);
        },

        insertPostDP: function(param, connection = db) {
            return connection.none(insertPostDP, param);
        },

        updatePostProjectProposal: function(param, connection = db) {
            return connection.none(updatePostProjectProposal, param);
        },

        updatePostProjectProposalCompleteness: function(param, connection = db) {
            return connection.any(updatePostProjectProposalCompleteness, param);
        },

        updatePostPPR: function(param, connection = db) {
            return connection.any(updatePostPPR, param);
        },

        getPostActsToCheck: function(param, connection = db) {
            return connection.any(getPostActsToCheck, param);
        },

        updatePostProjectRequiredCompleteness: function(param, connection = db) {
            return connection.any(updatePostProjectRequiredCompleteness, param);
        },

        updatePostProjectFinanceCompleteness: function(param, connection = db) {
            return connection.any(updatePostProjectFinanceCompleteness, param);
        },

        updatePostProjectProposalFinanceDocumentStatus: function(param, connection = db) {
            return connection.none(updatePostProjectProposalFinanceDocumentStatus, param);
        },

        updatePostStatus: function(param, connection = db) {
            return connection.none(updatePostStatus, param);
        },

        insertPostProjectProposalGals: function(param, connection = db) {
            return connection.none(insertPostProjectProposalGals, param);
        },

        insertPostProjectProposalEventPictures: function(param, connection = db) {
            return connection.none(insertPostProjectProposalEventPictures, param);
        },

        insertPostProjectProposal: function(param, connection = db) {
            return connection.any(insertPostProjectProposal, param);
        },

        getPostBriefContext: function(param, connection = db) {
            return connection.one(getPostBriefContext, param);
        },

        getPostProjectProposal: function(param, connection = db) {
            return connection.one(getPostProjectProposal, param);
        },

        getPostActsToImplement: function(param, connection = db) {
            return connection.any(getPostActsToImplement, param);
        },

        getPostProjectProposalMain: function(param, connection = db) {
            return connection.one(getPostProjectProposalMain, param);
        },

        getPostActsDetails: function(param, connection = db) {
            return connection.one(getPostActsDetails, param);
        },

        getEventPictureMaxSubmission: function(param, connection = db) {
            return connection.any(getEventPictureMaxSubmission, param);
        },

        getLatestEventPicture: function(param, connection = db) {
            return connection.any(getLatestEventPicture, param);
        },

        getLatestPostExpense: function(param, connection = db) {
            return connection.any(getLatestPostExpense, param);
        },

        getPostExpenseMaxSubmissionID: function(param, connection = db) {
            return connection.any(getPostExpenseMaxSubmissionID, param);
        },

        insertPostProjectExpense: function(param, connection = db) {
            return connection.none(insertPostExpense, param);
        },

        getAllPostProjectProposal: function(connection = db) {
            return connection.any(getAllPostProjectProposalSQL);
        },

        getAllPostProjectProposalPerTerm: function(param, connection = db) {
            return connection.any(getAllPostProjectProposalPerTermSQL, param);
        },

        getAllPostProjectSignatories: (GOSMActivityID, fields, connection = db) => {
            logger.info(`call getAllPostProjectSignatories(GOSMActivityID: ${GOSMActivityID})`, log_options);

            let query = squel.select()
                .from(squel.select()
                    .from('"PostProjectProposalSignatory"', '"ppps"')
                    .where('"ppps"."GOSMActivity" = ${GAID}'), '"sig"')
                .left_join('"PostProjectSignatoryType"', '"ppst"', '"sig"."type" = "ppst"."id"')
                .left_join('"PostProjectSignatoryStatus"', '"ppss"', '"sig"."status" = "ppss"."id"')
                .left_join('Account', 'a', '"sig"."signatory" = a.idNumber')

                .order('"ppst"."lineup"', true);
            attachFields(query, fields);

            query = query.toString();
            logger.debug(`Executing query: ${query}`, log_options);
            return connection.any(query, {
                GAID: GOSMActivityID
            });
        }
    };
}
