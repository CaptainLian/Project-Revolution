module.exports = function(db, queryFiles){
	var getAllActivityTypesSQL = queryFiles.getAllActivityTypes;

	return {
		getAllActivityTypes: function(){
			db.many(getAllActivityTypesSQL)
			.then((data) => {
				console.log(data);
			})
			.catch((error) => {
				console.log(error);
			});
		}
	};
};