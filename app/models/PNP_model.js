'use strict';

const log_options= Object.create(null);
log_options.from = 'PNP Proposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {

	const getPubsToCheck = queryFiles.getPubsToCheck;
	const getSpecificPubSeq = queryFiles.getSpecificPubSeq;


	return{
		getPubsToCheck:function (param, connection = db) {
            return connection.any(getPubsToCheck, param);
        },
        getSpecificPubSeq:function (param, connection = db) {
            return connection.one(getSpecificPubSeq, param);
        },
	};
}