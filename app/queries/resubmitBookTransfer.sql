UPDATE public."PreActivityBookTransfer"
   SET "dateSubmitted"=NOW(), status=0, "transferAccount"=${transferaccount}
 WHERE id=${id};
