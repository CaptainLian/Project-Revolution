INSERT INTO projectproposal(gosmactivity, accumulatedOperationalFunds, accumulatedDepositoryFunds, preparedby)
     VALUES (${gosmactivity}, ${operationalfunds}, ${depositoryfunds}, ${preparedby})
RETURNING id;
