'use strict';

const logger = global.logger;
const log_options = {
    from: 'database-helper'
};
module.exports = function(db){
	const dbType = typeof db;
    return {
    	attachFields: function(query, fields) {
    		logger.debug(`Attaching Fields to query: ${JSON.stringify(fields)}`, log_options);
	        if (typeof fields === 'string') {
	            query.field(fields);
	        } else if (Array.isArray(fields)) {
	        	//[], ['aguy', ['field', 'name']]
	            for (const field of fields) {
	                if (Array.isArray(field)) {
	                    query.field(field[0], field[1]);
	                } else {
	                    query.field(field);
	                }
	            }
	        }
	        return query;
	    },

	    queryExec: function(method, query, param, connection) {
	    	logger.warn('databaseHelper.queryExec() deprecated, please prefer to use default connection paramenters instead', log_options);
        	const conType = typeof connection;
	        if (conType === dbType || conType === 'undefined') {
	            return db[method](query, param);
	        }
	        return connection[method](query, param);
	    }
	};
};