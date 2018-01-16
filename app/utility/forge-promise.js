const Promise = require('bluebird');
const forge = require('node-forge');

/**
 * The forge object to be wrapped
 *
 * @type {forge}
 */
module.exports.forge = forge;

/**
 * [pki description]
 * @type {Object}
 */
module.exports.pki = Object.create(null);

module.exports.pki.privateKeyToPem = (privateKey) => {
	return new Promise((onResolve, onReject) => {
		try{
			return onResolve(forge.pki.privateKeyToPem(privateKey));
		}catch(err){
			return onReject(err);
		}
	});
};

module.exports.pki.publicKeyToPem = (publicKey) => {
	return new Promise((onResolve, onReject) => {
		try{
			return onResolve(forge.pki.publicKeyToPem(publicKey));
		}catch(err){
			return onReject(err);
		}
	});
};

/**
 * [rsa description]
 * @type {Object}
 */
module.exports.pki.rsa = Object.create(null);

/**
 * [generateKeyPair description]
 * @param  {Object} parameters [description]
 * @return {[type]}            [description]
 */
module.exports.pki.rsa.generateKeyPair = (parameters) => {
	const rsa = forge.pki.rsa;
	return new Promise((onResolve, onReject) => {
		return rsa.generateKeyPair(parameters, (err, pair) => {
			if(err){
				return onReject(err);
			}
			return onResolve(pair);
		});
	});
};


module.exports.md = Object.create(null);

module.exports.md.sha512 = (text) => {
    const md = forge.md.sha512;
    return new new Promise((resolve, reject) => {
        try{
            const digest = md.create();
            digest.update(text);
            return resolve(digest.digest().toHext());
        }catch(err){
            return reject(err);
        }
    });
};
