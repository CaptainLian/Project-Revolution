INSERT INTO "PostProjectReimbursementPayment"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","paymentBy","delayedProcessing","NUCAODP"
  	 		  "filenames","filenamesToShow","idNumber")
  	 VALUES (${gosmid},${est},${amount},${paymentBy},${delayedProcessing},${n},${filenames},
     			${filenamesToShow},${idNumber})
  		 ON CONFLICT ("GOSMActivity") DO 
     UPDATE 
     	SET "GOSMActivity" = ${gosmid},
     		"nameOfEstablishment" =${est},
     		"amount" = ${amount},
     		"paymentBy" = ${paymentBy},
     		"delayedProcessing" = ${delayedProcessing},
     		"NUCAODP" = ${n},
     		"filenames" = ${filenames},
     		"filenamesToShow" = ${filenamesToShow},
  	 		"idNumber" = ${idNumber}

