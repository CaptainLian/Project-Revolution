const squel = require('squel').useFlavour('postgres');

module.exports = function(database, queryFiles){

	const getActivitiesWithPPRSQL = queryFiles.getActivitiesWithPPR;
	const getActivitiesWithoutPPRSQL = queryFiles.getActivitiesWithoutPPR;

	return {	
		getOrganizationInformation: function(id, fields){
			const query = squel.select()
			.from('StudentOrganization')
			.where('id = ${id}');

			if(typeof fields === 'string'){
				query.field(fields);
			}else if(Array.isArray(fields)){
				for(const field of fields){
					query.field(field);
				}	
			}
			
			return database.one(query.toString(), {id: id});
		},
		getActivitiesWithPPR: function(param){
			return database.one(getActivitiesWithPPRSQL, param);
		},
		getActivitiesWithoutPPR: function(param){
			return database.one(getActivitiesWithoutPPRSQL, param);
		}
	};
};