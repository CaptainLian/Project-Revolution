UPDATE "PreActivityDirectPayment" 
   SET STATUS=1, "dateEvaluated"=NOW()
 WHERE id=${directPayment};