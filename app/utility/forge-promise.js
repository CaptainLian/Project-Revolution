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
		rsa.generateKeyPair(parameters, (err, pair) => {
			if(err){
				return onReject(err);
			}
			return onResolve(pair);
		});
	});
};

