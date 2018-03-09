UPDATE public."PreActivityDirectPayment"
   SET "dateSubmitted"=NOW(), "reasonForDelayedPRSProcessing"=${reason}, 
       status=0,"galsFilename"=${galfn},"galsfilenameToShow"=${galfts},"fqFilename"=${fqfn},"fqfilenameToShow"=${fqfts},"rofFilename"=${roffn},"rofFilenameToShow"=${roffts}
 WHERE id=${id};
