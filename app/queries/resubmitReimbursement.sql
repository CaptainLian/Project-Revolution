UPDATE public."PostProjectReimbursement"
   SET "justificationFDPP"=${justificationfdpp}, 
       "justificationFNUCADP"=${justificationfnucadp}, 
       "dateCreated"=NOW(), status=0
 WHERE id=${id};
