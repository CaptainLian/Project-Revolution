INSERT INTO "PostProjectReimbursementPayment"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","purpose","bsfilename","bsfilenameToShow"
  	 		  ,"idNumber")
  	 VALUES (${gosmid},${est},${amount},${purpose},${bs},${bsts},
  	 		  ,${idNumber})
  	  	 ON CONFLICT ("GOSMActivity") DO 
     UPDATE 
     	SET "GOSMActivity" = ${gosmid},
     		"nameOfEstablishment" = ${est},
     		"amount" = ${amount},
     		"purpose" = ${purpose},
     		"bsfilename" = ${bs},
     		"bsfilenameToShow" = ${bsts},
  	 		 "idNumber" = ${idNumber}
     		
