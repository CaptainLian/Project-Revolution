/*
	//A promise warpper for node-forge
	//Promisify's asynchronous callbacks of node-forge
	class ForgePromise
		Attributes:
			//Forge object used 
			public forge

		Functions:
			constructor:
				forge: optional parameter, if undefined, requires node-forge
*/


function ForgePromise(forge) {
    if (forge) {
        this.forge = forge;
    } else {
        this.forge = require('node-forge');
    }
}

ForgePromise.prototype.pki.rsa.generateKeyPair = function(param){
	const rsa = this.forge.pki.rsa;
	return new Promise((onResolve, onReject) => {
		rsa.generateKeyPair(param, (err, keypair) => {
			if(err){
				onReject(err);
			}else{
				onResolve(keypair);
			}
		});
	});
};




module.exports = ForgePromise;