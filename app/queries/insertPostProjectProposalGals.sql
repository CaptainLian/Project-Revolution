UPDATE "PostProjectProposal"
   SET "galsfilename" = ${filename},
       "galsfilenameToShow" = ${filenameToShow},
       "preparedBy"=${idNumber}
 WHERE "GOSMActivity" = ${gosmid}