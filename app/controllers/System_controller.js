//query builder
const squel = require('squel');

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

const logger = global.logger;
const log_options = {
    from: 'Account'
};

const forge = require('node-forge');

module.exports = function(database, models, queryFiles) {
    const accountModel = models.Account_model;
    return {

        viewLogin: (req, res) => {
            const csrfToken = req.csrfToken();
            logger.debug(`login CSRFToken: ${csrfToken}`, log_options);
            res.render('System/LoginMain', {
                csrfToken: csrfToken
            });
        },

        logout: (req, res) => {
            req.session.user = undefined;
            req.session.destroy(function(err) {
                res.redirect("/");
            });
        },

        checkLogin: (req, res) => {
            let input = req.body;
            logger.debug(`Login attempt input: ${JSON.stringify(input)}`, log_options);
            //parse id number
            let credential = parseInt(input.credential);
            let credentialFloat = parseFloat(input.credential);

            let query = squel.select()
                .from('Account')
                .field('idNumber')
                .field('email')
                .field('password')
                .field('salt')
                .field('Firstname')
                .field('Lastname')
                .field('Middlename');

            let valid = true;
            if (isNaN(credential)) {
                //this is email. possibly invalid
                query.where('email=${credential}');
            } else if (credential != credentialFloat || credential <= 0) {
                //this is a decimal number or invalid value
                valid = false;
            } else {
                query.where('idNumber=${credential}');
            }

            if (valid) {
                database.one(query.toString(), {
                        credential: input.credential
                    })
                    .then(account => {
                        logger.debug(`Account found: ${JSON.stringify(account)}`, log_options);
                        if (account.password === bcrypt.hashSync(input.password, account.salt)) {

                            logger.debug('Enter!!', log_options);

                            /**
                             * Session
                             * {
                             *     user: {
                             *         idNumber
                             *         name: {
                             *             first
                             *             middle
                             *             last
                             *         }
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
                            req.session.valid = true;

                            req.session.save();

                            return res.send({
                                valid: true,
                                route: '/'
                            });
                        } else {
                            logger.debug('Incorrect password');
                            return res.send({
                                valid: false
                            });
                        }
                    })
                    .catch(() => {
                        logger.debug('Account not exist');
                        return res.send({
                            valid: false
                        });
                    });
            } else {
                logger.debug('Aguy input');
                return res.send({
                    valid: false
                });
            }
        },

        documentSign: (req, res) => {
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

                    let messageDigest = forge.md.sha512.create();
                    messageDigest.update(sampleDocument);

                    const privateKey = forge.pki.privateKeyFromPem(data.privatekey);

                    const signature = privateKey.sign(messageDigest);

                    console.log(signature);
                    res.send(typeof signature);
                });
        },

        /**
         * Accepts
         * POST only
         *     req.body: {
         *         idNumber Integer,
         *         email String,
         *         type Integer,
         *         password String, 
         *         firstname String,
         *         middlename String,
         *         lastname String,
         *         contactNumber String
         *     }
         * @method
         * @param   {[type]} req [description]
         * @param   {[type]} res [description]
         * @returns {[type]}     [description]
         */
        createAccount: (req, res) => {
            const input = req.body;

            forgePromise.pki.rsa.generateKeyPair({
                    bits: global.config.webserver.encryption.bits,
                    workers: global.config.webserver.encryption.web_workers_amount
                })
                .then(pair => {
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
        }
    };
};