INSERT INTO GOSM (termID, studentOrganization)
           VALUES (system_get_current_term_id(), 1);
UPDATE GOSM
   SET status = 3
 WHERE id%100000 = 1;


INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                    VALUES ((SELECT id FROM GOSM WHERE id%100000 = 1 LIMIT 1), 'Goal Mo to', '{"Objectives", "Mo", "To"}', 'Strategies Mo to', 'Descibe kita', 'Measure mo to :)', '2017-9-6', '2017-9-6', 1, 2, false, 999.99);
INSERT INTO GOSMActivityProjectHead (idNumber, activityID)
                             VALUES (3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1));

INSERT INTO ProjectProposal (actualDateStart, actualDateEnd, facultyAdviser, preparedBy, GOSMActivity, ENP, ENMP, venue, context1, context2, context3, sourceFundOther, sourceFundParticipantFee, sourceFundOrganizational, accumulatedOperationalFunds, accumulatedDepositoryFunds, comments)
                     VALUES ((CURRENT_TIMESTAMP - INTERVAL '2 day'), (CURRENT_TIMESTAMP - INTERVAL '1 day'), 4444444, 3333333, (SELECT id FROM GOSMActivity WHERE gosm%100000 = 1 LIMIT 1), 1, 1, 0, 'Context kita', 'Context parin kita', 'Context ulit kita',69.69, 69.69, 69.69, 69.69, 69.69, 'Comments ko toh');

INSERT INTO GOSMActivity (gosm, goals, objectives, strategies, description, measures, targetDateStart, targetDateEnd, ActivityNature, ActivityType, isRelatedToOrganizationNature, budget)
                 VALUES ((SELECT id FROM GOSM WHERE id%100000 = 1 LIMIT 1), 'Goal Mo to 2', '{"Objectives 2", "Mo 2", "To 2"}', 'Strategies Mo to 2', 'Descibe kita 2', 'Measure mo to :) 2', '2017-10-13', '2017-10-14', 1, 2, false, 999.99);

UPDATE ProjectProposal
   SET status = 2
WHERE id = 1;

INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 1', 7, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 2', 80, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 3', 80, 60.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 4', 7, 15.0000);
INSERT INTO ProjectProposalExpenses (projectProposal, material, quantity, unitCost)
                              VALUES(1, 'Boyfriend Material 5', 60, 2.0000);

INSERT INTO ProjectProposalProgramDesign (projectProposal, dayID, date, startTime, endTime, activity, activityDescription, personInCharge)
                                  VALUES (1,    1, '2017-10-14', '21:34:03', '23:00:00', 'Aguy', 'Gansa', 3333333);

DELETE FROM ProjectProposalExpenses
 WHERE projectProposal = 1
   AND sequence = 1;