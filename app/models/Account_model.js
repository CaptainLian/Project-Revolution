'use strict';

/**
 * Query Files Used:
 *     account_insert.sql
 */
module.exports = function(database, queryFiles) {

    /**
     * Private: 
     *     _database
     *     _insertSQL
           _squel
           _TABLE: {
                NAME
                ACRONYM
           }
           _attachReturning
           _attachFields
     */
    class AccountModel {

        constructor(database, insertSQL) {
            const dbHelper = require('../utility/databaseHelper');

            this._database = database;
            this._insertSQL = insertSQL;
            this._squel = require('squel').useFlavour('postgres');

            this._TABLE = Object.create(null);
            this._TABLE.NAME = 'Account';
            this._TABLE.ACRONYM = 'a';

            this._attachReturning = dbHelper.attachReturning;
            this._attachFields = dbHelper.attachFields;
        }

        /**
         * [insertAccount description]
         * @method  insertAccount
         * @param  {Integer}         idNumber      [description]
         * @param  {String}          email         [description]
         * @param  {Integer}         type          [description]
         * @param  {String}          password      [description]
         * @param  {String}          firstname     [description]
         * @param  {String}          middlename    [description]
         * @param  {String}          lastname      [description]
         * @param  {String}          contactNumber [description]
         * @param  {String}          publicKey     [description]
         * @param  {String}          privateKey    [description]
         * @param  {[String, Array(String)] (Optional)}                           returning     [description]
         * @param  {[pg-task, pg-connection, pg-transaction] (Optional)}          connection    [description]
         * @returns {Promise} [description]
         */
        insertAccount(idNumber, email, type, password, firstname, middlename, lastname, contactNumber, publicKey, privateKey, returning, connection = this._database) {
            let param = {};
            param.idNumber = idNumber;
            param.email = email;
            param.type = type;
            param.password = password;
            param.firstname = firstname;
            param.middlename = middlename;
            param.lastname = lastname;
            param.contactNumber = contactNumber;
            param.publicKey = publicKey;
            param.privateKey = privateKey;

            if (returning) {
                let query = this._squel.insert()
                    .into(this._TABLE.NAME)
                    .set('idNumber', '${idNumber}')
                    .set('email', '${email}')
                    .set('type', '${type}')
                    .set('password', '${password}')
                    .set('firstname', '${firstname}')
                    .set('middlename', '${middlename}')
                    .set('lastname', '${lastname}')
                    .set('contactNumber', '${contactNumber}')
                    .set('publicKey', '${publicKey}')
                    .set('privateKey', '${privateKey}');
                this._attachReturning(query, returning);

                return connection.one(query.toString(), param);
            } 
            return connection.none(this._insertSQL, param);
        }

        /**
         *  
         * @method  getAccountDetails
         * @param   {Integer}          idNumber   [description]
         * @param   {[Array, String(String)] (Optional)}                             fields     [description]
         * @param   {[pg-connection, pg-task, pg-transaction] (Optional)}          connection [description]
         * @returns {Promise}  [description]
         */
        getAccountDetails(idNumber, fields, connection = this._database) {
            let param = {};
            param.idNumber = idNumber;

            let query = this._squel.select()
                .from(this._TABLE.NAME, this._TABLE.ACRONYM)
                .where('idNumber = ${idNumber}');
            this._attachFields(query, fields);
            return connection.one(query.toString(), param);
        }

        /**
         * Calculates which dashboard/s or home pagesthe given account can view
         * 
         * @method  getAccountHome
         * @param   {[type]}       idNumber [description]
         * @returns {[type]}                [description]
         */
        getAccountHome(idNumber){
            //TODO implementation
        }
    }

    return new AccountModel(database, queryFiles.account_insert);
};