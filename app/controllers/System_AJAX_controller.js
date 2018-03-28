module.exports = function(configuration, modules, models, database, queryFiles) {
    /**
    * Query builder
    * @type {Object}
    */
    const squel = require('squel').useFlavour('postgres');

    /**
    * Used for password hashing
    * @type {bcryptjs}
    */
    const bcrypt = require('bcryptjs');
    
    /**
    * Contains data regarding logging
    * const log_options = {
    *     from: 'Account'
    * };
    * @type {Object}
    */
    const log_options = Object.create(null);
    log_options.from = 'System-Controller';

    const accountModel = models.Account_model;
    const logger = modules.logger;

    const Promise = modules.Promise;

    const SystemController = Object.create(null);

    SystemController.updatePassword = (req, res) => {
        //TODO: Check if new password is the same as old password
        logger.info('updatePassword()', log_options);

        const input = req.body;
        const inputOldPassword = input.oldPassword;
        const inputNewPassword1 = input.newPassword1;
        const inputNewPassword2 = input.newPassword2;

        let reply = Object.create(null);
        reply.valid = false;
        reply.success = true;

        if(inputNewPassword1 !== inputNewPassword2){
            logger.debug(`Password mismatch between new passwords, 1: "${inputNewPassword1}" 2: "${inputNewPassword2}"`, log_options);

            reply.failureReason = 0;
            return res.send(reply);
        }

        return accountModel.getAccountDetails(req.session.user.idNumber, [
            'password',
            'salt'
        ]).then(account => {
            if(account.password === bcrypt.hashSync(inputOldPassword, account.salt)){
                return accountModel.updateAccountDetails(req.session.user.idNumber, {
                    password: inputNewPassword1
                });
            }else{
                logger.debug('Password mismatch between input and stored password', log_options);
                return Promise.resolve({mismatch: true});
            }
        }).then(data => {
            if(data && data.mismatch === true){
                reply.valid = false;
                reply.failureReason = 2;
            }else{
                reply.valid = true;
                reply.url = '\\home';
            }

            return res.send(reply);
        }).catch(err => {
            reply.valid = null;
            reply.success = false;
            reply.failureReason = 1;

            res.send(reply);
            return logger.error(`${err.message}: ${err.stack}`, log_options);
        });
    };

    SystemController.checkLogin = (req, res) => {
        logger.info('checkLogin()', log_options);
        let input = req.body;
        logger.debug(`Login attempt input: ${JSON.stringify(input)}`, log_options);
        //parse id number
        let credential = parseInt(input.credential);

        let query = squel.select()
            .from('Account')
            .field('idNumber')
            .field('status')
            .field('email')
            .field('passwordExpiration')
            .field('password')
            .field('salt')
            .field('Firstname')
            .field('Lastname')
            .field('Middlename')
            .field('type');

        if (isNaN(credential)) {
            //this is email. possibly invalid
            query.where('email=${credential}');
        } else if (!Number.isInteger(credential)) {
            //this is a decimal number or invalid value
            logger.debug('Aguy input');
            return res.send({
                valid: false
            });
        } else {
            query.where('idNumber=${credential}');
        }

        query = query.toString();
        logger.debug(`Executing query: ${query}`, log_options);
        database.one(query, {
            credential: input.credential
        }).then(account => {
            logger.debug(`Account found: ${JSON.stringify(account)}`, log_options);

            if (account.password === bcrypt.hashSync(input.password, account.salt)) {
                logger.debug('Valid!', log_options);


                if(account.status === 1 || account.status === 2){
                    logger.debug('Disabled account! blocking', log_options);

                    const reply = Object.create(null);
                    reply.url = '/System/NotAllowed';
                    reply.reroute = true;
                    reply.valid = true;

                    return res.send(reply);
                }

                /**
                 * Part of the sessions that contains the user credentials
                 * Only the idNumber and non-sensitive information is stored
                 * @type {Object}
                 */
                let user = Object.create(null);
                /**
                 * The account's idNumber
                 * @type {Integer}
                 */
                user.idNumber = account.idnumber;
                /**
                 * The name of the user compromising of 3 properties:
                 * The firstname
                 * The middlename
                 * The lastname
                 * @type {Object}
                 */
                user.name = Object.create(null);
                /**
                 * @type {String}
                 */
                user.name.first = account.firstname;
                /**
                 * @type {String}
                 */
                user.name.middle = account.middlename;
                /**
                 * @type {String}
                 */
                user.name.last = account.lastname;
                /**
                 * The account type, see AccountType database table for a list of values
                 * @type {Integer}
                 */
                user.type = account.type;

                /**
                 * Session Contents
                 * {
                 *     user: {
                 *         idNumber
                 *         name: {
                 *             first
                 *             middle
                 *             last
                 *         },
                 *         type
                 *         organizationSelected{
                 *              id,
                 *              path_profilePicture
                 *         } (For student types)
                 *     }
                 * }
                 * @type {Object}
                 */
                req.session.user = user;
                /**
                 * Validity of the session
                 * @type {Boolean}
                 */
                req.session.valid = true;

                let step = Promise.resolve(true);
                /**
                 * Account is student
                 */
                if(req.session.user.type === 1){
                    logger.debug('Student type account fetching and adding more data to session', log_options);
                    step = accountModel.getStudentOrganizations(req.session.user.idNumber).then(data => {
                        logger.debug(`${JSON.stringify(data)}`, log_options);

                        let organization = data.shift();
                        logger.debug(`organizationSelected: ${JSON.stringify(organization)}`, log_options);
                        logger.debug(`${JSON.stringify(organization)}`, log_options);

                        let organizationSelected = Object.create(null);
                        organizationSelected.id = organization.id;
                        organizationSelected.path_profilePicture = organization.path_profilepicture || '';
                        organizationSelected.acronym = data.acronym;

                        req.session.user.organizationSelected = organizationSelected;

                        return Promise.resolve(true);
                    });
                }

                return step.then(() => {
                    logger.debug('Rerouting user to /home', log_options);
                    return new Promise((resolve, reject) => {
                        try {
                          return req.session.save(err => {
                                if(err)
                                    return reject(err);

                                const reply = Object.create(null);
                                reply.url = '/home';
                                reply.reroute = true;
                                reply.valid = true;
                                res.send(reply);
                                return resolve(true);
                            });
                        } catch(err) {
                            return reject(err);
                        }
                    });
                });
            } else {
                logger.debug('Incorrect password', log_options);
                return res.send({
                    valid: false
                });
            }
        }).catch(err => {
            logger.debug(`Account not exists? err: ${err.message}\n${err.stack}`, log_options);
            return res.send({
                valid: false
            });
        });
    };
    
    SystemController.getAccountNotifications = (req, res) => {
        logger.info('call getAccountNotifications()', log_options);

        logger.debug(`body: ${JSON.stringify(req.body)}\nparam: ${JSON.stringify(req.params)}\nquery: ${JSON.stringify(req.query)}`, log_options);
        
        let minSequence = (typeof req.query.minSequence !== 'undefined' && req.query.minSequence !== 'null' && req.query.minSequence ) ? req.query.minSequence : 0;
        return accountModel.getNotifications(
            req.session.user.idNumber, 
            minSequence, [
            '"id"',
            '"sequence"',
            'to_char("date", \'Mon DD, YYYY HH12:MI AM\') AS "displayDate"',
            '"title"', 
            '"description"',
            'extract(epoch from "date") AS "rawDate"',
            '"status"'
        ]).then(notifications => {
            let response = (notifications && Array.isArray(notifications)) ? notifications : [];

            logger.debug(`Response: ${JSON.stringify(response)}`, log_options);
            return res.json(response);
        }).catch(error => {
            res.status(500);
            res.send();
            return logger.error(`${error.message}: ${error.stack}`, log_options);
        });
    };

    SystemController.viewNotifications = (req, res) => {
        logger.info('call viewNotifications()', log_options);
        
        logger.debug(`body: ${JSON.stringify(req.body)}\nparam: ${JSON.stringify(req.params)}\nquery: ${JSON.stringify(req.query)}`, log_options);

        return accountModel.updateNotifications(
            req.session.user.idNumber,
            req.body.maxSequence
        ).then(() => {
            return res.json({
                success: true,
                valid: true
            });
        }).catch(error => {
            res.status(500);
            res.send();
            return logger.error(`${error.message}: ${error.stack}`, log_options);
        });
    };

    return SystemController;
};