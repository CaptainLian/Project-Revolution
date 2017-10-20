'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let TreasurerController = Object.create(null);

	TreasurerController.newTransaction = (req, res) => {
		return res.render('Org/Treasurer/NewTransaction');
	};

    TreasurerController.newTransactionOthers = (req, res) => {
		return res.render('Org/Treasurer/NewTransactionOthers');
	};
    
	return TreasurerController;
};
