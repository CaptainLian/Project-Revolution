module.exports = function(database, models, queryFiles){
	return {
		viewLogin:(req, res)=>{
			res.render('System/LoginMain');
		},
		checkLogin:(req, res)=>{
			
		}
	};
};