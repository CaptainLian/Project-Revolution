module.exports = function(database, queryFiles){
	
	const dbType = typeof db;
	const queryExec = function(method, query, param, connection){
		const conType = typeof connection;
		if(conType === dbType || conType === 'undefined'){
			return db[method](query, param);
		}
		return connection[method](query, param);
	};
	return {

	};
};