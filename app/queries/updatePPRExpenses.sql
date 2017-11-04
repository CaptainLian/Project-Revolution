UPDATE PROJECTPROPOSAL
   SET accumulatedOperationalFunds=${accumulatedOperationalFunds}, accumulatedDepositoryFunds=${accumulatedDepositoryFunds},
       organizationFundOtherSource=${organizationFundsOtherSource}, sourceFundOrganizational=${sourceFundOrganizational},
       sourceFundParticipantFee=${sourceFundParticipantFee}, sourceFundOther=${sourceFundOther}, isExpenseComplete=${isExpenseComplete}
 WHERE id=${id};