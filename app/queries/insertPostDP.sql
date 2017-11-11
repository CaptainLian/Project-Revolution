INSERT INTO "PostProjectDirectPayment"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","paymentBy","delayedProcessing",
  	 		  "fqfilename","roffilename","fqfilenameToShow","roffilenameToShow","idNumber")
  	 VALUES (${gosmid},${est},${amount},${paymentBy},${delayedProcessing},${fq},${rof},
  	 		  ${fqts},${rofts},${idNumber})
  	  	 ON CONFLICT ("GOSMActivity") DO 
     UPDATE 
     	SET "GOSMActivity" = ${gosmid},
     		"nameOfEstablishment" = ${est},
     		"amount" = ${amount},
     		"paymentBy" = ${paymentBy},
     		"delayedProcessing" = ${delayedProcessing},
  	 	    "fqfilename" = ${fq},
  	 	    "roffilename" =${rof},
  	 	    "fqfilenameToShow" = ${fqts},
  	 	    "roffilenameToShow" = ${rofts},
  	 	    "idNumber" = ${idNumber}
