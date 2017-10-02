'use strict';

const logger = global.logger;
const log_options = Object.create(null);
log_options.from = 'APS-Controller';

module.exports = function(database, models, queryFiles) {

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;

    return {
    
        //NOTE: WAG MUNA ILIPAT SA ORG CONTROLLER
        //TODO: Illipat sa org controller
        inputActivityRequirements: (req, res) => {
            let sched = JSON.parse(req.body.sched);
            let exp = JSON.parse(req.body.exp);
            let funds = JSON.parse(req.body.funds);

            // var sched = sched[0];
            // console.log(sched.length);
            // req.body.context
            
            logger.debug(`${JSON.stringify(req.body)}`, log_options);
            
            var projectProposalParam = {
                //TODO
                // change gosmactivity value
                GOSMactivity: 1, // value should come from previous page
                status: 1,
                enp: req.body.enp, 
                enmp: req.body.enmp,
                venue: req.body.venue,
                sourceFundOther: exp.others,
                sourceFundParticipantFee: exp.participant,
                sourceFundOrganizational: exp.orgFunds,
                accumulatedOperationalFunds: funds.ope,
                accumulatedDepositoryFunds: funds.dep,
                organizationalFundOtherSource: funds.other,
                preparedBy: req.session.user 
            };
            database.tx(t => {
                    return projectProposalModel.insertProjectProposal(projectProposalParam, t)
                        .then(data => {
                            const projectProposalID = data.projectproposal;
                            logger.debug(`projectProposal: ${projectProposalID}`, log_options);
                            t.task(t => {
                                const queries = [];
                                /* 

                                    PPR Program Design

                                */
                                for (let index0 = sched.length + 1; --index0;) {
                                    logger.debug(sched, log_options);
                                    const program = sched[sched.length - index0];
                                    for (let index1 = program.time.length + 1; --index1;) {
                                        logger.debug(index1, log_options);
                                        const i = program.time.length - index1;
                                        const item = program.time[i];
                                        queries[queries.length] = projectProposalModel.insertProjectProposalDesign({
                                            projectProposal: projectProposalID,
                                            dayID: i,
                                            date: program.date,
                                            startTime: item.start,
                                            endTime: item.end,
                                            activity: item.actName,
                                            activityDescription: item.actDesc,
                                            personInCharge: item.pic
                                        }, t);
                                    }
                                }

                                // insert finances
                                /* 

                                    Revenue

                                */
                                for (let index = funds.revenue.length + 1; --index;) {
                                    logger.debug(`NAG LOOP`, log_options);
                                    const item = funds.revenue[funds.revenue.length - index];
                                    queries[queries.length] = projectProposalModel.insertProjectProposalProjectedIncome({
                                        projectProposal: projectProposalID,
                                        income: item.item,
                                        quantity: item.quan,
                                        sellingPrice: item.price
                                    }, t);
                                }

                                /*

                                    Expense

                                */
                                // for (let index = funds.expense.length; index--;) {
                                //     const item = funds.expense[funds.expense.length - index];
                                //     queries[queries.length] = projectProposalModel.insertProjectProposalExpenses({
                                //         projectProposal: projectProposalID,
                                //         material: item.item,
                                //         quantity: item.quan,
                                //         unitCost: item.price
                                //     }, t);
                                // }

                                return t.sequence(queries);
                            });
                        });
                })
                .then(data => {
                    logger.debug(`${data}`, log_options);
                })
                .catch(err => {
                    logger.warning('CATCH ON PROMISE');
                    console.log(err);
                    throw err;
                });
        },

        viewOrglist: (req, res) => {
            gosmModel.getAllCurrent()
                .then(GOSMList => {
                    logger.debug(`Displaying GOSM list: ${JSON.stringify(GOSMList)}`, log_options);
                    res.render('APS/OrglistMain', {
                        GOSMList: GOSMList,
                        csrfToken: req.csrfToken()
                    });
                })
                .catch(error => {
                    throw error;
                });
        },

        viewOrgGOSM: (req, res) => {
            const organizationID = req.params.orgID;
            const GOSMID = req.params.GOSMID;

            logger.debug(`Viewing GOSM of ID: ${GOSMID} of Organization: ${organizationID}`, log_options);
            database.task(t => {
                    return t.batch([
                        organizationModel.getOrganizationInformation(organizationID, 'name', t),
                        gosmModel.getActivitiesFromID(GOSMID, [
                            'id',
                            'strategies', ["to_char(targetDateStart, 'Mon DD, YYYY')", 'targetDateStart']
                        ], t),
                        gosmModel.getGOSM(GOSMID, 'status', t)
                    ]);
                })
                .then(data => {
                    logger.debug(`${JSON.stringify(data)}`, log_options);

                    /**
                     * let view = {
                     *     organizationName: data[0].name,
                     *     GOSMActivities: data[1],
                     *     GOSMID: GOSMID,
                     *     GOSMStatus: data[2].status,
                     *     csrfToken: req.csrfToken()
                     * };
                     * @type {Object}
                     */
                    let view = {};
                    view.organizationName = data[0].name;
                    view.GOSMActivities = data[1];
                    view.GOSMID = GOSMID;
                    view.GOSMStatus = data[2].status;
                    view.csrfToken = req.csrfToken();
                    view.showUpdateButtons = view.GOSMStatus != 1 && view.GOSMStatus != 3;
                    res.render('APS/OrgGOSMMain', view);
                })
                .catch(error => {
                    throw error;
                });
        },

        getActivityDetails: (req, res) => {
            logger.debug(`GET ACTIVITY DETAILS: ${req.body.dbid}`, log_options);

            database.task(t => {
                return t.batch([
                    gosmModel.getActivityDetails(req.body.dbid, undefined, t),
                    gosmModel.getActivityProjectHeads(req.body.dbid, ['firstname', 'lastname', 'a.idNumber'], t)
                ]);
            }).then(data => {
                res.send(data);
            }).catch(error => {
                throw error;
            });
        },


        viewActivityList: (req, res) => {
            projectProposalModel.getAllActivityProjectProposal([
                    'ga.id',
                    'ga.strategies AS name',
                    "to_char(ga.targetDateStart, 'Mon DD, YYYY') AS dateEvent",
                    //AS can be placed in a 2nd array
                    ["date_part('day', age(ga.targetDateStart, CURRENT_TIMESTAMP))", 'daysLate'],
                    'so.name AS organizationName'
                ])
                .then(data => {
                    logger.debug(`Data: ${JSON.stringify(data)}`, log_options);
                    res.render('APS/ActivityList', {
                        csrfToken: req.csrfToken(),
                        proposals: data
                    });
                })
                .catch(err => {
                    throw err;
                });
        },

        activityChecking: (req, res)=>{

            projectProposalModel.getActivityProjectProposalDetails(1, [
                            ['at.name', 'type'],
                            'an.name AS nature',
                            'ga.strategies AS strategies',
                            'so.name AS orgname',
                            'pp.venue AS venue',
                            'pp.enmp AS enmp',
                            'pp.enp AS enp',
                            'ga.objectives AS objectives',
                            'pp.context AS context'
                        ])
                .then(data =>{
                    var dbParam = {
                        projectProposal: data.id
                    };

                    Promise.all([
                        projectProposalModel.getProjectProposalExpenses(data.id),
                        projectProposalModel.getProjectProposalProjectedIncome(data.id),
                        projectProposalModel.getProjectProposalProgramDesign(data.id),
                        projectProposalModel.getProjectProposalProjectHeads(data.id)
                    ])
                        .then(data1=>{
                            res.render('APS/activityCheckingMain', {
                                projectProposal: data,
                                expenses: data1[0],
                                projectedIncome: data1[1],
                                programDesign: data1[2],
                                projectHeads: data1[3]
                            }); 
                        })
                        .catch(error=>{
                            console.log(error);
                        });
                })
                .catch(error=>{
                    console.log(error);
                });
        }
    };
};