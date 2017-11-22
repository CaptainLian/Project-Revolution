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
        req.session.user = undefined;
        return req.session.destroy((err) => {
            if(err)
                logger.warn(`${err.message}\n${err.stack}`, log_options);
            return res.redirect("/");
        });
    };

    SystemController.checkLogin = (req, res) => {
        let input = req.body;
        logger.debug(`Login attempt input: ${JSON.stringify(input)}`, log_options);
        //parse id number
        let credential = parseInt(input.credential);

        let query = squel.select()
            .from('Account')
            .field('idNumber')
            .field('email')
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

        database.one(query.toString(), {
            credential: input.credential
        }).then(account => {
            logger.debug(`Account found: ${JSON.stringify(account)}`, log_options);
            if (account.password === bcrypt.hashSync(input.password, account.salt)) {

                logger.debug('Enter!!', log_options);

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
                 *
                 *              path_profilePicture
                 *         } (Optional)
                 *     }
                 * }
                 * @type Object
                 */
                let user = Object.create(null);
                user.idNumber = account.idnumber;
                user.name = Object.create(null);
                user.name.first = account.firstname;
                user.name.middle = account.middlename;
                user.name.last = account.lastname;
                user.type = account.type;
                req.session.user = user;
                req.session.valid = true;

                logger.debug('Determining user type', log_options);

                let step = Promise.resolve(true);
                if(req.session.user.type === 1){
                    logger.debug('Student type account', log_options);
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
                                if(err){
                                    throw err;
                                }

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
        logger.debug('viewHome()', log_options);
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
            // SLIFE Account
            case 3:
                //TODO: implementation
                return res.redirect('/blank');
            // Accounting Account
            case 4:
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
                    return res.redirect(data.home_url || '/blank');
                });
            default:
                return res.redirect('/blank');
        }
    };

    SystemController.documentSign = (req, res) => {
        // //KEY GENERATION
        // console.log("REQUEST");
        // console.log(req.session.user);
        //database.one('SELECT * FROM Account WHERE idNumber = ${idNumber}', {idNumber: req.session.user.idNumber});
        logger.debug(req.session, log_options);
        //let fullname = req.session.user.name.first + " " + req.session.user.name.middle + " " + req.session.user.name.last;

        accountModel.getAccountDetails(11445955, 'privateKey')
            .then(data => {
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
            return res.send({
                success: false,
                valid: true
            });
        });
    };

    return SystemController;
};
