const forge = require('node-forge');

/**
 * [signString description]
 * @param  {String} string [description]
 * @param  {String} key    [description]
 * @return {Object}        [description]
 */
module.exports.signString = (string, privateKeyString) => {
    const digest = forge.md.sha512.create();
    digest.update(string, 'utf8');
    const md = digest.digest();

    const privateKey = forge.pki.privateKeyFromPem(privateKeyString);
    const encrypt = privateKey.sign(digest);

    const out = Object.create(null);
    out.document = md.toHex();
    out.signature = forge.util.bytesToHex(encrypt);

    return out;
};

/**
 * [signJSON description]
 * @param  {Object} json        [description]
 * @param  {String} privateKey  [description]
 * @return {Promise}            [description]
 */
module.exports.signJSON = (json, privateKey) => {
    return module.exports.signString(JSON.stringify(json), privateKey);
};
//SELECT decode(hexString, hex);
