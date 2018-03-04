'use strict';
var timediff = require('timediff');

module.exports = function(configuration, modules, models, database, queryFiles) {
    let ADM_controller = Object.create(null);

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'ADM-Controlller';

    const amtModel = models.ActivityMonitoring_model;
    const systemModel = models.System_model;

    const pnpModel = models.PNP_model;
    const organizationModel = models.organization_model;
    const projectProposalModel = models.ProjectProposal_model;
    const postProjectProposalModel = models.PostProjectProposal_model;
    const gosmModel = models.gosmModel;

    const path = require('path');

    ADM_controller.viewActivityToCheck = (req, res) => {
        let renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        logger.debug(`extra_data: ${JSON.stringify(req.extra_data)}`, log_options);
        postProjectProposalModel.getPostActsToCheck().then(data => {
            console.log(data);
            console.log("data");
            renderData.postacts = data;
            res.render('ADM/ActivityList', renderData);
        });
    };

    ADM_controller.updateStatus = (req, res) => {
        logger.info('updateStatus', log_options);
        logger.warn('Not fully tested for req.body["sections[]"] and req.body.sections error', log_options);

        //TODO: FIX req.body["sections[]"] and req.body.sections
        console.log(req.body)
        console.log(req.params)
        var sections = []
        var dbParam = {};
        var stat = {
            otherFinance: true,
            briefContext: true,
            gosmid: req.body.gosmid
        }
        if ( req.body.status == '4') {
            sections.push(req.body.sections)

            dbParam = {
                gosmid: req.body.gosmid,
                status: 4,
                comments: "",
                sections: sections
            }
            
            console.log("asd");
        } else {
            dbParam = {
                gosmid: req.body.gosmid,
                status: 5,
                comments: req.body.comment,
                sections: req.body["sections[]"]
            }

            var sections = req.body["sections[]"];
            if(Array.isArray(req.body["sections[]"]) ){
                for (var x = 0; x < sections.length; x++) {
                    console.log("asd");
                    if (sections[x] == "1") {
                        stat.briefContext = false
                    }
                    if (sections[x] == "2") {
                        stat.briefContext = false
                    }
                    if (sections[x] == "3") {
                        stat.otherFinance = false;
                    }
                    if (sections[x] == "4") {
                        stat.otherFinance = false;
                    }
                }
            }else{
                console.log("asd3");
                    var arr = [];
                    dbParam.sections = arr.push(req.body["sections[]"])
                    dbParam.sections = '{"'+req.body["sections[]"]+'"}';
                  if (req.body["sections[]"] == "1") {
                        stat.briefContext = false
                    }
                    if (req.body["sections[]"] == "2") {
                        stat.briefContext = false
                    }
                    if (req.body["sections[]"] == "3") {
                        stat.otherFinance = false;
                    }
                    if (req.body["sections[]"] == "4") {
                        stat.otherFinance = false;
                    }
            }

            console.log("asd2");
        }

        return database.task(t => {
            return t.batch([
                postProjectProposalModel.updatePostPPR(dbParam, t),
                postProjectProposalModel.updatePostStatus(stat, t)
            ])
        }).then(data => {
            return res.json({
                status: 1
            })
        }).catch(err => {
            return logger.debug(`${err.message}:\n${err.stack}`, log_options);
        });
    };

    ADM_controller.viewActivity = (req, res) => {
        database.task(t => {
            var dbParam = {
                gosmid: req.params.id
            };

            return t.batch([
                postProjectProposalModel.getPostActsDetails(dbParam, t),
                postProjectProposalModel.getLatestEventPicture(dbParam, t),
                postProjectProposalModel.getLatestPostExpense(dbParam, t),
                projectProposalModel.getProjectProposalProjectHeads(req.params.id,t)
                // projectProposalModel.getProjectProposalProjectHeads(3)
            ]);
        }).then(data => {
            console.log(data);
            console.log("data[1]");

            const renderData = Object.create(null);
            renderData.activity = data[0];
            renderData.pictures = data[1];
            renderData.expense = data[2];
            renderData.id = data[0].id;
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();
            console.log(data[3])

            renderData.pheads = data[3]
            res.render('ADM/ActivityToCheck', renderData);
        }).catch(err => {
            console.log(err);
        });
    };


    return ADM_controller;
// >>>>>>> lian
};