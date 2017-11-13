INSERT INTO "PostProjectReimbursement"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","paymentBy","delayedProcessing","NUCAODP",
  	 		  "filenames","filenamesToShow","idNumber","dateCreated")
  	 VALUES (${gosmid},${est},${amount},${paymentBy},${delayedProcessing},${n},${filenames},
     			${filenamesToShow},${idNumber},now())
  		