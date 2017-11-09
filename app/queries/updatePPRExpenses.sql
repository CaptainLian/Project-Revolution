UPDATE PROJECTPROPOSAL
   SET accumulatedOperationalFunds=${accumulatedOperationalFunds}, accumulatedDepositoryFunds=${accumulatedDepositoryFunds},
       organizationFundOtherSource=${organizationFundOtherSource}, sourceFundOrganizational=${sourceFundOrganizational},
       sourceFundParticipantFee=${sourceFundParticipantFee}, sourceFundOther=${sourceFundOther}, isExpenseComplete=${isExpenseComplete}
 WHERE id=${id};