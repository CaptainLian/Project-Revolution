'use strict';

let databaseHelper = Object.create(null);

/**
 * 
 * @param  {squel query}
 * @param  {[String, Array] (Optional)}
 * @return {squel query}
 */
databaseHelper.attachFields = (query, fields) => {
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

/**
 * Attaches specified returning field/s to the specified query
 * @param  {squel (postgres flavour)} query     [description]
 * @param  {[String, Array(String)] (Optional)} returning [description]
 * @return {Boolean}           true if any fields were attached, false otherwise
 */
databaseHelper.attachReturning = (query, returning) =>{
    if(typeof returning === 'string'){
        query.returning(returning);
        return true;
    } else if(Array.isArray(returning)){
        for(let index = returning.index; index--; ){
            query.returning(returning[index]);
        }
        return true;
    }

    return false;
};

module.exports = databaseHelper;