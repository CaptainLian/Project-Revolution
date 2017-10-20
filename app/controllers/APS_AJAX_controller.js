
const log_options = Object.create(null);
log_options.from = 'AJAX-APS';
log_options.color = '\x1b[35m';

module.exports = function(configuration, modules, models, database, queryFiles) {
    const logger = modules.logger;
    const gosmModel = models.gosmModel;
    const projectProposalModel = models.ProjectProposal_model;
    
    return {
        getGOSMActivityDetails: function(req, res) {
            const activityID = parseInt(req.query.activityID ? req.query.activityID : req.body.activityID);

            if (isNaN(activityID)) {
                logger.debug(`Invalid input`);
                return res.send({
                    valid: false
                });
            }
            logger.debug(`Getting Activity Details of id: ${activityID}`, log_options);

            database.task(t => {
                return t.batch([
                    gosmModel.getActivityDetails(
                        activityID, [
                            ['ga.comments'],
                            ['at.name', 'type'],
                            ['an.name', 'nature'],
                            ["to_char(ga.targetDateStart, 'Mon DD, YYYY')", 'startDate'],
                            ["to_char(ga.targetDateEnd, 'Mon DD, YYYY')", 'endDate']
                        ],
                        t),
                    gosmModel.getActivityProjectHeads(activityID, ['a.idNumber',
                        "firstname || ' ' || lastname AS name",
                        'contactNumber'
                    ], t)
                ]);
            }).then(data => {
                logger.debug(`activity: ${JSON.stringify(data)}`, log_options);
                return res.send({
                    valid: true,
                    activityDetails: data[0],
                    projectHeads: data[1]
                });
            }).catch(error => {
                res.send({
                    valid: false
                });
                throw error;
            });
        },

        updateGOSM: (req, res) => {
            const GOSMID = parseInt(req.body.GOSMID ? req.body.GOSMID : req.query.GOSMID);
            const statusID = parseInt(req.body.statusID ? req.body.statusID : req.query.statusID);
            const comments = req.body.comments ? req.body.comments : req.query.comments;

            if (isNaN(GOSMID) || isNaN(statusID)) {
                logger.debug(`Invalid input: GOSMID = ${GOSMID}, statusID = ${statusID}`, log_options);
                return res.send({
                    valid: false
                });
            }

            gosmModel.updateGOSMStatus(GOSMID, statusID, comments)
            .then(status => {
                logger.debug(`query result: $(status)`, log_options);
                return res.send({
                    valid: true,
                    success: true
                });
            }).catch(error => {
                res.send({
                    valid: true,
                    success: false
                });
                throw error;
            });
        },

        updateGOSMActivityComment: (req, res) => {
            const activityID = parseInt(req.body.activityID ? req.body.activityID : req.query.activityID);
            const comments = req.body.comments ? req.body.comments : req.query.comments;

            if (isNaN(activityID) || typeof comments !== 'string') {
                logger.warning(`Invalid input: activityID: ${activityID}, comments: ${comments}`, log_options);
                return res.send({
                    valid: false
                });
            }

            logger.debug(`Valid input received: activityID: ${activityID}, comments: ${comments}`, log_options);
            gosmModel.updateActivityComment(activityID, comments)
            .then(data => {
                logger.debug('Success!', log_options);
                res.send({
                    valid: true,
                    success: true
                });
            }).catch(error => {
                res.send({
                    valid: true,
                    success: false
                });
                throw error;
            });
        },

        getProjectProposalActivityDetails: (req, res) => {
            const PPRID = req.body.PPRID ? req.body.PPRID : req.query.PPRID;
            logger.debug(`PPR ID: ${PPRID}`, log_options);

            database.task(t => {
                return t.batch([
                    projectProposalModel.getActivityProjectProposalDetails(PPRID, [
                        'at.name AS activityType',
                        'an.name AS activityNature',
                        "to_char(ga.targetDateStart, 'Mon DD, YYYY') || ' - ' || to_char(ga.targetDateEnd, 'Mon DD, YYYY') AS activityDate",
                        'pp.venue',
                        'pp.ENP',
                        'pp.context',
                        'ga.objectives'
                    ], t),
                    projectProposalModel.getProjectProposalProgramDesign(PPRID, undefined, t),
                    projectProposalModel.getProjectProposalExpenses(PPRID, undefined, t)
                ]);
            }).then(data => {
                logger.debug(`Data: ${data}`, log_options);
                return res.send({
                    valid: true,
                    success: true,
                    data: data
                });
            }).catch(err => {
                res.send({
                    valid: true,
                    success: false
                });
                throw err;
            });
        },
        //CHANGE QUERY
        activityChecking: (req, res) => {
            database.task(task => {
                //TODO replace 1, hard coded vaue
                return projectProposalModel.getActivityProjectProposalDetails(2, [
                    ['at.name', 'type'],
                    'an.name AS nature',
                    'ga.strategies AS strategies',
                    'so.name AS orgname',
                    'pp.venue AS venue',
                    'pp.enmp AS enmp',
                    'pp.enp AS enp',
                    'ga.objectives AS objectives',
                    'pp.context AS context',
                    'pp.id AS id',
                    'pp.sourcefundother AS sourcefundother',
                    'pp.sourcefundparticipantfee AS sourcefundparticipantfee',
                    'pp.sourcefundorganizational AS sourcefundorganizational',
                    'pp.accumulatedoperationalfunds AS accumulatedoperationalfunds',
                    'pp.accumulateddepositoryfunds AS accumulateddepositoryfunds',
                    'pp.organizationfundothersource AS organizationfundothersource'
                ], task).then(data => {
                    return task.batch([
                        Promise.resolve(data),
                        projectProposalModel.getProjectProposalExpenses(data.id),
                        projectProposalModel.getProjectProposalProjectedIncome(data.id),
                        projectProposalModel.getProjectProposalProgramDesign(data.id, [
                            'pppd.dayid AS dayid',
                            "to_char(pppd.date, 'Mon DD, YYYY') AS date",
                            "to_char(pppd.starttime + CURRENT_DATE, 'HH:MI AM') AS starttime",
                            "to_char(pppd.endtime + CURRENT_DATE, 'HH:MI PM') AS endtime",
                            'pppd.activity AS activity',
                            'pppd.activitydescription AS activitydescription',
                            'pppd.personincharge AS personincharge'
                        ]),
                        projectProposalModel.getProjectProposalProjectHeads(data.id),
                        projectProposalModel.getProjectProposalAttachment(data.id)
                    ]);
                });
            }).then(data => {
                global.logger.debug(`${JSON.stringify(data[3])}`, log_options);
                return res.render('APS/ActivityChecking', {
                    projectProposal: data[0],
                    expenses: data[1],
                    projectedIncome: data[2],
                    programDesign: data[3],
                    projectHeads: data[4],
                    attachment: data[5],
                    csrfToken: req.csrfToken()
                });
            }).catch(err => {
                throw err;
            });
        }
    };
};
