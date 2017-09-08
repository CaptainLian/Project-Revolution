INSERT INTO projectproposal
	(gosmactivity, status, enp, enmp, venue, sourcefundother, sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, accumulateddepositoryfunds, organizationfundothersource, preparedby)
	VALUES (${GOSMactivity}, ${status}, ${enp}, ${enmp}, ${venue}, ${sourceFundOther}, ${sourceFundParticipantFee}, ${sourceFundOrganizational}, ${accumulatedOperationalFunds}, ${accumulatedDepositoryFunds}, ${organizationalFundOtherSource}, 
	${preparedBy})
	RETURNING id as projectProposal;