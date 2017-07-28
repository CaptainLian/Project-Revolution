

module.exports ={
	home: (req,res) => {
		//if president
		res.render('PresidentTemplate');
	},	
	neil :(req,res) => {
		res.send("Neil");
	}
};
