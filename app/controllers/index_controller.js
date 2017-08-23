module.exports ={
	home: (req,res) => {
		//if president
		res.render('users/president/home',{home:true});
	},	
	neil :(req,res) => {
		res.send("Neil");
	},
	gosm :(req,res) => {
		res.render("users/president/gosm",{
			datatables:true,
			gosm:true,
			pagetitle:"GOSM"
			
		});
	}

};
