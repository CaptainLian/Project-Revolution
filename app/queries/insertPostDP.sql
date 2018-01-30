INSERT INTO "PostProjectDirectPayment"
  	 	    ("GOSMActivity","nameOfEstablishment","amount","paymentBy","delayedProcessing",
  	 		  "fqfilename","roffilename","fqfilenameToShow","roffilenameToShow","idNumber")
  	 VALUES (${gosmid},${est},${amount},${paymentBy},${delayedProcessing},${fq},${rof},
  	 		  ${fqts},${rofts},${idNumber})
  	  	