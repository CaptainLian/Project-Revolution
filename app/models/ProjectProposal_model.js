'use strict';

const logger = global.logger;
const log_options = {
    from: 'GOSM-Model'
};

const squel = require('squel').useFlavour('postgres');

module.exports = function(db, queryFiles) {
    const dbHelper = require('../utility/databaseHelper')(db);
    const queryExec = dbHelper.queryExec;
    const attachFields = dbHelper.attachFields;

    return {

    };
};