INSERT INTO "PostProjectReimbursementPayment"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","paymentBy","delayedProcessing","NUCAODP"
  	 		  "filenames","filenamesToShow","idNumber")
  	 VALUES (${gosmid},${est},${amount},${paymentBy},${delayedProcessing},${n}
  	 		  ,${idNumber})
  		 ON CONFLICT ("GOSMActivity") DO 
     UPDATE 
     	SET "GOSMActivity" = ${gosmid},
     		"nameOfEstablishment" =${est},
     		"amount" = ${amount},
     		"paymentBy" = ${paymentBy},
     		"delayedProcessing" = ${delayedProcessing},
     		"NUCAODP" = ${n},
  	 		"idNumber" = ${idNumber}

