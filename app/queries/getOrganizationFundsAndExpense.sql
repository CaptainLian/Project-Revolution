SELECT SO.depositoryfunds, SO.operationalfunds, COALESCE(SUM(PPE.quantity*PPE.unitcost), 0) as expense
  FROM STUDENTORGANIZATION SO LEFT JOIN GOSM G
								ON SO.ID=G.STUDENTORGANIZATION
			  			      LEFT JOIN GOSMACTIVITY GA
			     			    ON GA.GOSM=G.ID
			      			  LEFT JOIN (SELECT * 
			      			  			   FROM PROJECTPROPOSAL
			      			  			  WHERE STATUS!=5
			      			  			    AND STATUS!=7) PP
			     			    ON PP.GOSMACTIVITY=GA.ID
			      			  LEFT JOIN PROJECTPROPOSALEXPENSES PPE
			       			    ON PPE.PROJECTPROPOSAL=PP.ID
WHERE  SO.id=${orgId}
  AND G.TERMID=system_get_current_term_id()
  AND PPE.ID NOT IN (SELECT U.particular
		   			   FROM ((SELECT PADPP.particular
			    				FROM "PreActivityDirectPaymentParticular" PADPP JOIN "PreActivityDirectPayment" PADP
																			      ON PADPP."directPayment"=PADP.id
			   		  		   WHERE PADP.status=1)
			   
		   			UNION   (SELECT PADPP.particular
			    			   FROM "PreActivityCashAdvanceParticular" PADPP JOIN "PreActivityCashAdvance" PADP
							  									  	           ON PADPP."cashAdvance"=PADP.id
			   				  WHERE PADP.status=1)
			   
		   			UNION   (SELECT PADPP.particular
			    			   FROM "PreActivityBookTransferParticular" PADPP JOIN "PreActivityBookTransfer" PADP
																		        ON PADPP."bookTransfer"=PADP.id
			   				  WHERE PADP.status=1)) U
					)
GROUP BY SO.depositoryfunds, SO.operationalfunds;