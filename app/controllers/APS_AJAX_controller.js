const logger = global.logger;
const log_options = {from:'AJAX-APS', color:'\x1b[35m'};

module.exports = function(database, models, queryFiles){
	const gosmModel = models.gosmModel;
	const projectProposalModel = models.projectProposal_model;
	return {
		getGOSMActivityDetails: function(req, res){
			const activityID = parseInt(req.query.activityID ? req.query.activityID : req.body.activityID);

			if(isNaN(activityID) ){
				logger.debug(`Invalid input`);
				res.send({valid: false});
				return;
			}
			logger.debug(`Getting Activity Details of id: ${activityID}`, log_options);

			database.task(t => {
				return t.batch([
					gosmModel.getActivityDetails(
						activityID, [
							['ga.comments'],
							['at.name', 'type'],
							['an.name', 'nature'],
							["to_char(ga.targetDateStart, 'Mon DD, YYYY')", 'startDate'],
							["to_char(ga.targetDateEnd, 'Mon DD, YYYY')", 'endDate']], 
						t),
					gosmModel.getActivityProjectHeads(activityID, 
						['a.idNumber',
						"firstname || ' ' || lastname AS name",
						'contactNumber']
						,t)
				]);
			})
			.then(data => {
				logger.debug(`activity: ${JSON.stringify(data)}`, log_options);
				res.send({
					valid: true,
					activityDetails: data[0],
					projectHeads: data[1]
				});
			}).catch(error => {
				logger.error(error, log_options);
				res.send({valid: false});
			});
		},

		updateGOSM: (req, res) => {
			const GOSMID = parseInt(req.body.GOSMID ? req.body.GOSMID : req.query.GOSMID);
			const statusID = parseInt(req.body.statusID ? req.body.statusID : req.query.statusID);
			const comments = req.body.comments ? req.body.comments : req.query.comments;
			
			if(isNaN(GOSMID) || isNaN(statusID)){
				logger.debug(`Invalid input: GOSMID = ${GOSMID}, statusID = ${statusID}`, log_options);
				res.send({valid: false});
				return;
			}

			gosmModel.updateGOSMStatus(GOSMID, statusID, comments)
			.then(status => {
				logger.debug(`query result: $(status)`, log_options);
				res.send({valid: true, success: true});
			})
			.catch(error => {
				res.send({valid: true, success: false});
				throw error;
			});
		},

		updateGOSMActivityComment: (req, res) => {	
			const activityID = parseInt(req.body.activityID ? req.body.activityID : req.query.activityID);
			const comments = req.body.comments ? req.body.comments : req.query.comments;

			if(isNaN(activityID) || typeof comments !== 'string'){
				logger.warning(`Invalid input: activityID: ${activityID}, comments: ${comments}`, log_options);
				res.send({valid: false});
				return;
			}

			logger.debug(`Valid input received: activityID: ${activityID}, comments: ${comments}`, log_options);
			gosmModel.updateActivityComment(activityID, comments)
			.then(data => {
				logger.debug('Success!', log_options);
				res.send({valid: true, success: true});
			})
			.catch(error => {
				res.send({valid: true, success: false});
				throw error;
			});
		},

		getProjectProposaActivityDetails: (req, res) => {
			const PPRID = req.body.activityID ? req.body.activityID : req.query.activityID;
			
			projectProposalModel.getActivityProjectProposalDetails(PPRID)
			.then(data => {
				res.send({valid: true, success: true});
			})
			.catch(err => {
				throw err;
			});
			
			res.send({valid: true, success: false});
			
		}
	};
};
