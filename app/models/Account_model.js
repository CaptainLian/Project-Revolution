'use strict';

module.exports = function(database, queryFiles) {

    class AccountModel {

        constructor(database) {
            this._database = database;
            this._squel = require('squel').useFlavour('postgres');
            this._forgePromise = require('../utility/node-forge-promise');
        }

        /**
         * 
         * @param  {Integer} idNumber      [description]
         * @param  {String} email         [description]
         * @param  {Integer} type          [description]
         * @param  {String} password      [description]
         * @param  {String} firstname     [description]
         * @param  {} middlename    [description]
         * @param  {String} lastname      [description]
         * @param  {[Integer, String]} contactNumber [description]
         * @param  {[pg-connection, pg-database, pg-task] (Optional)} connection    [description]

         * @return {[type]}               [description]
         */
        createAccount(idNumber, email, type, password, firstname, middlename, lastname, contactNumber, connection = this._database) {
            let param = Object.create(null);
            param.idNumber = idNumber;
            param.email = email;
            param.type = type;
            param.password = password;
            param.firstname = firstname;
            param.middlename = middlename;
            param.lastname = lastname;
            param.contactNumber = contactNumber;
        }

        getAccountDetails(idNumber, fields, connection = this._database) {
            let param = Object.create(null);
            param.idNumber = idNumber;
            let query = this._squel.select()
                .from('Account')
                .where('idNumber = ${idNumber}');
            return connection.oneOrNone(query, param);
        }
    }

    return new AccountModel(database);
};