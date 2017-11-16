'use strict';

const log_options= Object.create(null);
log_options.from = 'PNP Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {

	const getUnapprovePubsToCheck = queryFiles.getUnapprovePubsToCheck;
	const getSpecificPubSeq = queryFiles.getSpecificPubSeq;
	const insertActivityPublicity = queryFiles.insertActivityPublicity;
	const getPubsNumberToApprove = queryFiles.getPubsNumberToApprove;
	const getPubsOfActivity = queryFiles.getPubsOfActivity;
	const getActivityDetailsforPubs = queryFiles.getActivityDetailsforPubs;
    const updatePublicityStatus = queryFiles.updatePublicityStatus;


	return{
		getUnapprovePubsToCheck:function ( connection = db) {
            return connection.any(getUnapprovePubsToCheck);
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
        getPubsNumberToApprove:function ( connection = db) {
            return connection.any(getPubsNumberToApprove);
        },
        insertActivityPublicity:function (param, connection = db) {
            return connection.any(insertActivityPublicity, param);
        },
        getSpecificPubSeq:function (param, connection = db) {
            return connection.one(getSpecificPubSeq, param);
        },



        
	};
}