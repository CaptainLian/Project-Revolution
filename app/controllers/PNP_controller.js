'use strict';
module.exports = function(configuration, modules, models, database, queryFiles){
	let PNPController = Object.create(null);
	const pnpModel = models.PNP_model;
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.ProjectProposal_model;
	const organizationModel = models.organization_model;

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
			]);
		}).then(pubs=>{
				console.log(pubs[0]);
			renderData.pubs = pubs[0];
			renderData.activities = pubs[1];
			renderData.heads = pubs[2];
			return res.render('PNP/ViewPubs', renderData);
		}).catch(err=>{
			console.log("ERROR VIEW PUB");
			console.log(err);	
		})
	};	
	PNPController.viewHome = (req, res) => {

		 database.task(task => {
                        return task.batch([
                            pnpModel.getAllActivityPublicity(),
                            organizationModel.getAllStudentOrganizations(),
                            gosmModel.getAllCurrent()
                        ]);
        }).then(data=>{

            let renderData = Object.create(null);

            var uncheckedPublicityMaterials = 0;
            var ApprovedPublicityMaterials = 0;
            var PendedPublicityMaterials = 0;

            for (var i = 0; i < data[0].length; i++){

                if (data[0][i].publicitystatus == 0) {
                    uncheckedPublicityMaterials = uncheckedPublicityMaterials + 1;
                }
                else if(data[0][i].publicitystatus == 1){
                    ApprovedPublicityMaterials = ApprovedPublicityMaterials + 1;
                }
                else if(data[0][i].publicitystatus == 2){
                    PendedPublicityMaterials = PendedPublicityMaterials + 1;
                }

            }


            renderData.uncheckedPublicityMaterials = uncheckedPublicityMaterials;
            renderData.ApprovedPublicityMaterials = ApprovedPublicityMaterials;
            renderData.PendedPublicityMaterials = PendedPublicityMaterials;
            renderData.studentorganizations = data[1];
            renderData.allGosm = data[2];
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
		    return res.render('PNP/mainPNP', renderData);

        }).catch(error=>{
            console.log(error);
        });

	 
	  };

	PNPController.viewPubsList = (req, res) => {
		let renderData = Object.create(null);
		renderData.csrfToken = req.csrfToken();
		renderData.extra_data = req.extra_data;
		database.task(t=>{
			return t.batch([
				pnpModel.getUnapprovePubsToCheck(),
				pnpModel.getPubsNumberToApprove()
			]);
		}).then(pubs=>{
			console.log(pubs);
			renderData.pubs = pubs[0];
			renderData.number = pubs[1];
			
			return res.render('PNP/PubsToCheck', renderData);
		}).catch(err=>{
			console.log("ERROR VIEW PUB");
			console.log(err);	
		});
	};	
	
	return PNPController;
};