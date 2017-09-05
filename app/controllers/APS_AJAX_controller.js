const squel = require('squel');
const log_options = {from:'AJAX-APS', color:'\x1b[35m'};
module.exports = function(database, models, queryFiles){
	const gosmModel = models.gosmModel;
	return {
		getGOSMActivityDetails: function(req, res){

			const activityID = parseInt(req.query.activityID ? req.query.activityID : req.body.activityID);
			global.logger.debug(`Getting Activity Details of id: ${activityID}`, log_options);

			const activityDetailsPromise = gosmModel.getActivityDetails(activityID) ;
			const activityProjectHeadsPromise = gosmModel.getActivityProjectHeads(activityID);
			Promise.all([activityDetailsPromise, activityProjectHeadsPromise])
			.then(data => {
				global.logger.debug(`activity: ${JSON.stringify(data)}`, log_options);
				res.send({
						activityDetails: data[0],
						projectHeads: [1]
				});
			}).catch(error => {
				global.logger.warning(error.toString(), log_options);
			});
		}
	};
};
