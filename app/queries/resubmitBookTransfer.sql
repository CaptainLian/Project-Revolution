UPDATE public."PreActivityBookTransfer"
   SET "dateSubmitted"=NOW(), status=0, "establishment"=${transferaccount}
 WHERE id=${id};
