SELECT COUNT(PPE.ID) as expensestotal, to_char(actualdateend, 'YYYY-MM-DD') as dateend, to_char(NOW(), 'YYYY-MM-DD') as currdate
  FROM PROJECTPROPOSAL PP JOIN PROJECTPROPOSALEXPENSES PPE
  							ON PP.ID=PPE.PROJECTPROPOSAL
 WHERE PPE.ID NOT IN (SELECT particular
 						FROM ((SELECT PADPP.particular
 							    FROM "PreActivityDirectPaymentParticular" PADPP)
 					   UNION (SELECT PABTP.particular
 					   	 		FROM "PreActivityBookTransferParticular" PABTP)
 					   UNION (SELECT PACAP.particular
 					   			FROM "PreActivityCashAdvanceParticular" PACAP)   ))
   AND PP.GOSMACTIVITY=${gosmactivity}
 GROUP BY PP.GOSMACTIVITY