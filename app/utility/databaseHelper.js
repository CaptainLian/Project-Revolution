'use strict';

let DatabaseHelper = function() {
    this._log_options = Object.create(null);
    this._log_options.from = 'database-helper';
};

/**
 * 
 * @param  {squel query}
 * @param  {[String, Array] (Optional)}
 * @return {squel query}
 */
DatabaseHelper.prototype.attachFields = function(query, fields) {
    global.logger.debug(`Attaching Fields to query: ${JSON.stringify(fields)}`, this._log_options);
    if (typeof fields === 'string') {
        query.field(fields);
    } else if (Array.isArray(fields)) {
        //[], ['aguy', ['field', 'name']]
        for (let index = fields.length; index--;) {
            const field = fields[index];
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