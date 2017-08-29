'use strict';

module.exports = function(database, models, queryFiles){
	return {
		home: (req, res, next) => {
		//if president
			res.render('users/president/home',{home:true});
			//next();
		},
		gosm :(req, res, next) => {
			res.render("users/president/gosm",{
				datatables:true,
				gosm:true,
				pagetitle:"GOSM"
				
			});
			
			//next();
		}
	};
};