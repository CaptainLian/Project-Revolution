const squel = require('squel');

const logger = global.logger;
const log_options = {from:'AJAX-APS', color:'\x1b[35m'};

module.exports = function(database, models, queryFiles){
	const gosmModel = models.gosmModel;

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
			const activityID = parseInt(req.query.activityID ? req.query.activityID : req.body.activityID);
			const statusID = parseInt(req.query.statusID ? req.query.statusID : req.body.statusID);

			if(isNaN(activityID) || isNan(statusID)){
				logger.debug(`Invalid input: activityID = ${activityID}, statusID = ${statusID}`);
				res.send({valid: false});
				return;
			}
			gosmModel.updateActivityStatus(activityID, statusID, comments)
			.then(status => {
				logger.debug(status, log_options);
				res.send({valid: true, success: true});
			})
			.catch(error => {
				logger.debug(error, log_options);
				res.send({valid: true, success: false});
			});
			res.send('APS_AJAX_Controller: Hello');
		}
	};
};
