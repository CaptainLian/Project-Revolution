INSERT INTO "PostProjectBookTransfer"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","purpose","bsfilename","bsfilenameToShow"
  	 		  ,"idNumber","dateCreated")
  	 VALUES (${gosmid},${est},${amount},${purpose},${bs},${bsts}
  	 		  ,${idNumber},now())
  	  	