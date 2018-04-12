module.exports = function(configuration, modules, models, database, queryFiles) {
    /**
    * Query builder
    * @type {Object}
    */
    const squel = require('squel').useFlavour('postgres');

    /**
    * Used for password hashing
    * @type {bcryptjs}
    */
    const bcrypt = require('bcryptjs');

    /**
    * Used for encryptions, key-pair generation, document signing and verification
    * @type {forge-promise}
    */
    const forgePromise = require('../utility/forge-promise');

    /**
    * Contains data regarding logging
    * const log_options = {
    *     from: 'Account'
    * };
    * @type {Object}
    */
    const log_options = Object.create(null);
    log_options.from = 'System-Controller';

    const accountModel = models.Account_model;
    const logger = modules.logger;

    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;

    const CSOController = Object.create(null);

    CSOController.viewProjectProposalSign = (req, res) => {
        logger.debug(`Extra-data contents: ${JSON.stringify(req.extra_data)}`, log_options);
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        logger.debug(`login CSRFToken: ${renderData.csrfToken}`, log_options);
        return res.render('System/LoginMain', renderData);
    };
    CSOController.viewExecHome = (req, res) => {

        database.task(task => {
            return task.batch([
                gosmModel.getAllCurrentGOSM(),
                organizationModel.getAllStudentOrganizations(),
                gosmModel.getAllCurrent()
            ]);
        }).then(data=>{

            let renderData = Object.create(null);

            var uncheckedGOSM = 0;
            var ApprovedGOSM = 0;
            var PendedGOSM = 0;

            for (var i = 0; i < data[0].length; i++){

                if (data[0][i].status == 2) {
                    uncheckedGOSM = uncheckedGOSM + 1;
                }
                else if(data[0][i].status == 3){
                    ApprovedGOSM = ApprovedGOSM + 1;
                }
                else if(data[0][i].status == 4){
                    PendedGOSM = PendedGOSM + 1;
                }

            }


            renderData.uncheckedGOSM = uncheckedGOSM;
            renderData.ApprovedGOSM = ApprovedGOSM;
            renderData.PendedGOSM = PendedGOSM;
            renderData.studentorganizations = data[1];
            renderData.allGosm = data[2];
            renderData.extra_data = req.extra_data;
            renderData.csrfToken = req.csrfToken();

            logger.debug(`login CSRFToken: ${renderData.csrfToken}`, log_options);
            return res.render('CSO/ExecHome', renderData);

        }).catch(error=>{
            console.log(error);
        });




    };

    return CSOController;
};
