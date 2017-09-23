//query builder
const squel = require('squel');

//password hashing
const bcrypt = require('bcryptjs');

//Document Signature
const selfsigned = require('selfsigned');
const crypto2 = require('crypto2');

const logger = global.logger;
const log_options = {
    from: 'Account'
};

module.exports = function(database, models, queryFiles) {

    const accountModel = models.Account_model;
    const systemModel = models.System_model;
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
                    .catch(error => {
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
            // console.log(req.session);
            var fullname = "Neil Cpaistrano";
            var email = "neil_capistrano@yahoo.com";
            var details = [{
                "name": fullname,
                "value": email
            }];

            // ATTRIBUTE ERROR . NULL CAN BE CHANGE TO ATTRS
            // var pems = selfsigned.generate(null, { days: 365 });
            // console.log(pems)
            //GENERATE KEYS
            var keys = selfsigned.generate(null, {
                days: 999999,
                keySize: 2048,
                algorithm: 'sha256',
                clientCertificate:true,
                 clientCertificateCN: 'Neil Cpaistrano',
                 extensions: [{ name: 'basicConstraints', cA: true }], // certificate extensions array 
                pkcs7: true,

            });
            console.log("GENERATED KEYS");
            console.log(keys.private);
            console.log(keys.public);

            //SIGN DOCUMENT
            var sampleDocument = {
                "Form Name": "PPR",
                Contents: "NEIL IS NICE"
            };


            console.log("SAMPLE DOCUMENT");
            console.log(sampleDocument);

            // THE JSON OBJECT OR FORM IS HASH
            crypto2.hash(JSON.stringify(sampleDocument), (err, hash) => {
                console.log("SAMPLE HASH");
                console.log(hash);

                //CRYPTO . SHA256 is USED to
                crypto2.sign(hash, keys.private, (err, signature) => {
                    console.log("SAMPLE SIGNATURE");
                    console.log(signature);

                    crypto2.verify(hash, keys.public, signature, (err, signature) => {
                        console.log("VERIFY SIGNATURE");
                        console.log(signature);

                    });
                });
            });
        }
    };
};