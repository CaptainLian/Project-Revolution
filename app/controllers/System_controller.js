//query builder
const squel = require('squel');

//password hashing
const bcrypt = require('bcryptjs');

//Document Signature
const crypto2 = require('crypto2');

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
                            req.session.user = {
                                idNumber: account.idnumber,
                                name: {
                                    first: account.firstname,
                                    middle: account.middlename,
                                    last: account.lastname
                                }
                            };

                            req.session.valid = true;
                            req.session.save();
                            res.send({
                                valid: true,
                                route: '/'
                            });
                        } else {
                            logger.debug('Incorrect password');
                            res.send({
                                valid: false
                            });
                        }
                    })
                    .catch(() => {
                        logger.debug('Account not exist');
                        res.send({
                            valid: false
                        });
                    });
            } else {
                logger.debug('Aguy input');
                res.send({
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

            accountModel.getAccountDetails(11445955, [
                    'privateKey'
                ])
                .then(data => {
                    let sampleDocument = {
                        Length: 500,
                        size: 5100,
                        comments: 'Ganda, laki ng saging'
                    };
                    sampleDocument = JSON.stringify(sampleDocument);

                    let messageDigest = forge.md.sha512.create()
                    .update(sampleDocument)
                    .digest();

                    const privateKey = forge.pki.privateKeyFromPem(data.privateKey);

                    const signature = privateKey.sign(messageDigest);

                });
        },

        createAccount: (req, res) => {
            
        }
    };
};