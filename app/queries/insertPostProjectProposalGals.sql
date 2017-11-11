UPDATE "PostProjectProposal"
   SET "galsfilename" = ${filename},
       "galsfilenameToShow" = ${filenameToShow}
 WHERE "GOSMActivity" = ${gosmid}