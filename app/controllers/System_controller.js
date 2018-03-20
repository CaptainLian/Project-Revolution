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
            return res.redirect('/home');
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
            return res.redirect('/');
        });
    };

    SystemController.viewHome = (req, res) => {
        logger.info('viewHome()', log_options);

        logger.debug('Checking for password expiration', log_options);
        accountModel.getAccountDetails(req.session.user.idNumber, [
            'passwordExpiration AS "passwordExpiration"',
            'status'
        ]).then(account => {
            const ngayon = Date.now();

            if(ngayon >= account.passwordExpiration){
                logger.debug('Password expired', log_options);
                return res.redirect('/System/ChangeExpiredPassword');
            }else if(account.status == 3){
                logger.debug('First time sign-in', log_options);
                return res.redirect('/System/NewAccountPassword');
            }else{
                logger.debug('Password NOT expired', log_options);

                logger.debug('Determining user type', log_options);
                switch (req.session.user.type) {
                    // Admin
                    case 0:
                        //TODO: implementation
                        logger.debug('', log_options);
                        return res.redirect('/blank');

                    // Faculty Adviser Account
                    case 2:
                        //TODO: implementation
                        logger.debug('', log_options);
                        return res.redirect('/blank');
                    // Director of S-Life Account
                    case 3:
                        //TODO: implementation
                        logger.debug('', log_options);
                        return res.redirect('/blank');
                    // Dean of Student Affairs Account
                    case 4:
                        //TODO: implementation
                        logger.debug('', log_options);
                        return res.redirect('/blank');

                    // Vice President for Lasallian Mission Account
                    case 5:
                        //TODO: implementation
                        logger.debug('Vice President for Lasallian Mission Account', log_options);
                        return res.redirect('/blank');

                    // President
                    case 6:
                        //TODO: implementation
                        logger.debug('President of La Salle', log_options);
                        return res.redirect('/blank');

                    // Student Account
                    case 1:
                        logger.debug('Student', log_options);

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
                        logger.warn('Unknown user account', log_options);

                        return res.redirect('/blank');
                }
            }
        }).catch(error => {
            logger.error(`${error.message}\n${error.stack}`, log_options);
            
            return res.send({
                success: false,
                valid: true
            });
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
        logger.info('createAccount()', log_options);
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

    SystemController.viewChangeExpiredPassword = (req, res) => {
        logger.info('call viewChangeExpiredPassword()', log_options);

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        renderData.showExpiredPassword = true;

        logger.debug('Rendering ChangePassword page', log_options);
        return res.render('System/ChangePassword', renderData);
    };

    SystemController.viewNewAccountPassword = (req, res) => {
        logger.info('call viewNewAccountPassword()', log_options);

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        renderData.showNewPassword = true;

        logger.debug('Rendering ChangePassword page', log_options);
        return res.render('System/ChangePassword', renderData);
    }

    SystemController.viewChangePassword = (req, res) => {
        logger.info('call viewChangePassword()', log_options);

        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();
        renderData.showSidebar = true;
        
        logger.debug('Rendering ChangePassword page', log_options);
        return res.render('System/ChangePassword', renderData);
    };

    SystemController.viewNotAllowed = (req, res) => {
        res.statusCode(403);
        return res.render('System/403');
    };

    return SystemController;
};
