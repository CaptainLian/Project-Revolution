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
    * Used for encryptions, key-pair generation, document signing and verification
    * @type {forge-promise}
    */
    const forgePromise = require('../utility/forge-promise');

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

    SystemController.viewLogin = (req, res) => {
        logger.info('viewLogin()', log_options);
        logger.debug(`Extra-data contents: ${JSON.stringify(req.extra_data)}`, log_options);

        if(req.session.user){
            return  res.redirect('/home');
        }

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        logger.debug(`login CSRFToken: ${renderData.csrfToken}`, log_options);
        return res.render('System/LoginMain', renderData);
    };

    SystemController.logout = (req, res) => {
        logger.info('logout()', log_options);
        req.session.user = null;
        return req.session.destroy((err) => {
            if(err)
                logger.warn(`${err.message}\n${err.stack}`, log_options);
            return res.redirect("/");
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

    SystemController.viewHome = (req, res) => {
        logger.info('viewHome()', log_options);

        logger.debug('Checking for password expiration', log_options);
        accountModel.getAccountDetails(req.session.user.idNumber, [
            'passwordExpiration AS "passwordExpiration"'
        ]).then(account => {
            const ngayon = Date.now();

            if(ngayon >= account.passwordExpiration){
                logger.debug('Password expired', log_options);
                return res.redirect('/System/ChangePassword');
            }else{
                logger.debug('Password NOT expired', log_options);

                logger.debug('Determining user type', log_options);
                switch (req.session.user.type) {
                    // Admin
                    case 0:
                        //TODO: implementation
                        return res.redirect('/blank');

                    // Faculty Adviser Account
                    case 2:
                        //TODO: implementation
                        return res.redirect('/blank');
                    // Director of S-Life Account
                    case 3:
                        //TODO: implementation
                        return res.redirect('/blank');
                    // Dean of Student Affairs Account
                    case 4:
                        //TODO: implementation
                        return res.redirect('/blank');

                    // Vice President for Lasallian Mission Account
                    case 5:
                        //TODO: implementation
                        return res.redirect('/blank');

                    // President
                    case 6:
                        //TODO: implementation
                        return res.redirect('/blank');

                    // Student Account
                    case 1:
                        logger.debug('Student Account', log_options);
                        return accountModel.getRoleDetailsInOrganization(
                            req.session.user.idNumber,
                            req.session.user.organizationSelected.id,
                            'home_url'
                        ).then(data => {
                            if(data.home_url){
                                return res.redirect(data.home_url);
                            }else if(req.session.user.organizationSelected.id !== 0){
                                return res.redirect('/Organization/ProjectHead/home');
                            }else{
                                return res.redirect('/blank');
                            }
                        });
                    default:
                        return res.redirect('/blank');
                }
            }
        });


    };

    SystemController.documentSign = (req, res) => {
        // //KEY GENERATION
        // console.log("REQUEST");
        // console.log(req.session.user);
        //database.one('SELECT * FROM Account WHERE idNumber = ${idNumber}', {idNumber: req.session.user.idNumber});
        logger.debug(req.session, log_options);
        //let fullname = req.session.user.name.first + " " + req.session.user.name.middle + " " + req.session.user.name.last;

        accountModel.getAccountDetails(11445955, 'privateKey').then(data => {
            let sampleDocument = {
                Length: 500,
                size: 5100,
                comments: 'Ganda, laki ng saging'
            };
            sampleDocument = JSON.stringify(sampleDocument);

            let messageDigest = forgePromise.forge.md.sha512.create();
            messageDigest.update(sampleDocument);

            const privateKey = forgePromise.forge.pki.privateKeyFromPem(data.privatekey);

            const signature = privateKey.sign(messageDigest);

            console.log(signature);
            return res.send(typeof signature);
        });
    };

    SystemController.createAccount = (req, res) => {
        logger.info('createAccount()', log_options)
        const input = req.body;

        forgePromise.pki.rsa.generateKeyPair({
            bits: configuration.webserver.encryption.bits,
            workers: configuration.webserver.encryption.web_workers_amount
        }).then(pair => {
            return Promise.all([
                forgePromise.pki.publicKeyToPem(pair.publicKey),
                forgePromise.pki.privateKeyToPem(pair.privateKey)
            ]);
        }).then(keys => {
            const publicKeyPEM = keys[0];
            const privateKeyPEM = keys[1];

            return accountModel.insertAccount(
                input.idNumber,
                input.email,
                input.type,
                input.password,
                input.firstname,
                input.middlename,
                input.lastname,
                input.contactNumber,
                publicKeyPEM,
                privateKeyPEM
            );
        }).then(() => {
            return res.send({
                success: true,
                valid: true
            });
        }).catch(err => {
            logger.error(`${err.message}\n${err.stack}`, log_options);
            return res.send({
                success: false,
                valid: true
            });
        });
    };

    SystemController.studentChangeOrganization = (req, res) => {
        logger.info(`studentChangeOrganization()\nParams: ${JSON.stringify(req.params)}`, log_options);
        logger.info('Controller method implementation not yet complete', log_options);

        return accountModel.isInOrganization(req.session.user.idNumber, req.params.organization).then(organization => {
            logger.debug(`Part of organization check: ${organization.isIn}`, log_options);

            if(organization.isIn){
                //TODO: update other fields as well
                logger.debug(`Changing organizationSelected.id = ${req.params.organization}`, log_options);
                req.session.user.organizationSelected.id = req.params.organization;
            }

            return res.redirect('/home');
        });
    };

    SystemController.viewChangePassword = (req, res) => {
        logger.info('viewChangePassword()', log_options);

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        return res.render('System/ChangePassword', renderData);
    };

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

    return SystemController;
};
