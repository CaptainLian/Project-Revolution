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

    const CSOController = Object.create(null);

    CSOController.viewProjectProposalSign = (req, res) => {
        logger.debug(`Extra-data contents: ${JSON.stringify(req.extra_data)}`, log_options);
        const renderData = Object.create(null);
        renderData.extra_data = req.extra_data;
        renderData.csrfToken = req.csrfToken();

        logger.debug(`login CSRFToken: ${renderData.csrfToken}`, log_options);
        return res.render('System/LoginMain', renderData);
    };

    return CSOController;
};
