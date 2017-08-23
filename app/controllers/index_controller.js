module.exports = function(database, models, queryFiles){
	return {
		home: (req, res, next) => {
		//if president
			res.render('users/president/home',{home:true});
			next();
		},	
		neil :(req, res, next) => {
			res.send("Neil");
			next();
		},
		gosm :(req, res, next) => {
			res.render("users/president/gosm",{
				datatables:true,
				gosm:true,
				pagetitle:"GOSM"
				
			});
			
			next();
		}
	};
}