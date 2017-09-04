const squel = require('squel').useFlavour('postgres');

module.exports = function(database, queryFiles){
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
		}
	};
};