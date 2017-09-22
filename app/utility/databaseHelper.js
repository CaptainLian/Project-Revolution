'use strict';

const logger = global.logger;
const log_options = {
    from: 'database-helper'
};

let DatabaseHelper = function() {};

DatabaseHelper.prototype.attachFields = function(query, fields) {
    logger.debug(`Attaching Fields to query: ${JSON.stringify(fields)}`, log_options);
    if (typeof fields === 'string') {
        query.field(fields);
    } else if (Array.isArray(fields)) {
        //[], ['aguy', ['field', 'name']]
        for(let index = fields.length ; index--;){

            const field = fields[index];
            logger.debug(`${index}`);
            logger.debug(`${JSON.stringify(field)}`);
            if (Array.isArray(field)) {
                query.field(field[0], field[1]);
            } else {
                query.field(field);
            }
        }
    }
    return query;
};

module.exports = new DatabaseHelper();