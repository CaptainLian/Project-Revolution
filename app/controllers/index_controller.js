module.exports ={
	home: (req,res) => {
		res.render('index/home', { title: 'Express MVC' });
	},	
	neil :(req,res) => {
		res.send("Neil");
	}
};
