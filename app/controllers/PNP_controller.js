'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let PNPController = Object.create(null);
	const pnpModel = models.PNP_model;
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.ProjectProposal_model;

	PNPController.viewPubs = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;

		return res.render('PNP/ViewPubs', renderData);
	};	

	PNPController.viewSpecificPubs = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;
		var gosmParam = {
			gosmid : req.params.gosmid
		}
		var gosmParam2 = {
			gosmactivity : req.params.gosmid
		}
		database.task(t=>{
			return t.batch([
					pnpModel.getPubsOfActivity(gosmParam,t),
					pnpModel.getActivityDetailsforPubs(gosmParam,t),
					gosmModel.getGOSMActivityProjectHeads(gosmParam2,t)

				])
		}).then(pubs=>{
				console.log(pubs[2]);
				renderData.pubs = pubs[0];
				renderData.activities = pubs[1];
				renderData.heads = pubs[2];
				return res.render('PNP/ViewPubs', renderData);
			}).catch(err=>{
				console.log("ERROR VIEW PUB");
				console.log(err);	
			})
		
	};	

	PNPController.viewPubsList = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;
		database.task(t=>{
			return t.batch([
					pnpModel.getUnapprovePubsToCheck(),
					pnpModel.getPubsNumberToApprove()
				])
		}).then(pubs=>{
				console.log(pubs);
				renderData.pubs = pubs[0];
				renderData.number = pubs[1];
				return res.render('PNP/PubsToCheck', renderData);
			}).catch(err=>{
				console.log("ERROR VIEW PUB");
				console.log(err);	
			})
		
			

		
	};	
	
	return PNPController;
};