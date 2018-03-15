'use strict';

const log_options= Object.create(null);
log_options.from = 'PNP Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {
    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'PNP-Model';

    const squel = modules.squel;

	const getUnapprovePubsToCheck = queryFiles.getUnapprovePubsToCheck;
	const getSpecificPubSeq = queryFiles.getSpecificPubSeq;
	const insertActivityPublicity = queryFiles.insertActivityPublicity;
	const getPubsNumberToApprove = queryFiles.getPubsNumberToApprove;
	const getPubsOfActivity = queryFiles.getPubsOfActivity;
	const getActivityDetailsforPubs = queryFiles.getActivityDetailsforPubs;
    const updatePublicityStatus = queryFiles.updatePublicityStatus;
    const getMypubs = queryFiles.getMypubs;
    const getPubDetails = queryFiles.getPubDetails;
    const updatePubsToPend = queryFiles.updatePubsToPend;

	return{
		getUnapprovePubsToCheck:function ( connection = db) {
            return connection.any(getUnapprovePubsToCheck);
        },

        getMypubs:function (param, connection = db) {
            return connection.any(getMypubs, param);
        },

        updatePublicityStatus:function (param, connection = db) {
            return connection.none(updatePublicityStatus, param);
        },

        getPubsOfActivity:function (param, connection = db) {
            return connection.any(getPubsOfActivity, param);
        },

        getActivityDetailsforPubs:function (param, connection = db) {
            return connection.one(getActivityDetailsforPubs, param);
        },

        getPubDetails:function (param, connection = db) {
            return connection.one(getPubDetails, param);
        },

        getPubsNumberToApprove:function ( connection = db) {
            return connection.any(getPubsNumberToApprove);
        },

        insertActivityPublicity:function (param, connection = db) {
            return connection.one(insertActivityPublicity, param);
        },

        getSpecificPubSeq:function (param, connection = db) {
            return connection.one(getSpecificPubSeq, param);
        },
        
        updatePubsToPend:function (param, connection = db) {
            return connection.none(updatePubsToPend, param);
        },

        getPublicityDetails: function(pubID, connection = db){
            logger.info('getPublicityDetails()', log_options);

            let query = squel.select()
                .from('"ActivityPublicity"', 'ap')
                .where('ap.id = ${publicityID}')
                .toString();

            let param = Object.create(null);
            param.publicityID = pubID;


            logger.debug(query, log_options);
            return connection.one(query, param);
        }
	};
}
