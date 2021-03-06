'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const Promise = modules.Promise;
    const accessControlModel = models.AccessControl_model;
    const gosmModel = models.gosmModel;
    const organizationModel = models.organization_model;

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'Student-AccessControl-Middleware';

    /**
     * const StudentAccountAccessControlMiddleware = {
     *     name: StudentAccount-AccessControl-Middleware',
     *     priority: HIGHEST
     * @type {Object}
     * }
     */
    const StudentAccountAccessControlMiddleware = Object.create(null);
    StudentAccountAccessControlMiddleware.name = 'StudentAccount-AccessControl-Middleware';
    StudentAccountAccessControlMiddleware.priority = configuration.load_priority.HIGHEST;
    StudentAccountAccessControlMiddleware.action = (req, res, next) => {
        const user = req.session.user;
        if (!user || user.type !== 1 || req.method !== 'GET') {
            logger.debug(`Not valid user`, log_options);
            return next();
        }

        logger.info('StudentAccount-AccessControl-Middleware', log_options);

        try {
            logger.debug(`Logged-in user: ${user.idNumber}, type: student`, log_options);
            logger.debug(`\tSelected Organization: ${JSON.stringify(user.organizationSelected)}`, log_options);
            return accessControlModel.getAccountAccessControl(user.idNumber).then(data => {
                const accessControl = Object.create(null);
                const accessibleFunctionalitiesList = Object.create(null);

                for (let index = data.length; index--;) {
                    const row = data[index];
                    /* ES6 object destructuring */
                    const {
                        organization,
                        functionalitySequence,
                        isAllowed
                    } = row;

                    if (accessControl[organization]) {
                        accessControl[organization][functionalitySequence] = isAllowed;
                    } else {
                        const orgData = Object.create(null);
                        orgData[functionalitySequence] = isAllowed;

                        accessControl[organization] = orgData;
                    }

                    if (accessibleFunctionalitiesList[functionalitySequence]) {
                        accessibleFunctionalitiesList[functionalitySequence] = accessibleFunctionalitiesList[functionalitySequence] || isAllowed;
                    } else {
                        accessibleFunctionalitiesList[functionalitySequence] = isAllowed;
                    }
                }

                req.extra_data.user.accessControl = accessControl;
                req.extra_data.user.accessibleFunctionalitiesList = accessibleFunctionalitiesList;
                logger.debug(`\tUser access control: ${JSON.stringify(accessControl)}`, log_options);
                logger.debug(`\tAccessible functions list: ${JSON.stringify(accessibleFunctionalitiesList)}`, log_options);

                return next();
            }).catch(error => {
                return next(error);
            });
        } catch (err) {
            return next(err);
        }
    };

    /**
     * const Sidebar_data_attacher_middleware = {
     *     name: 'Student extra_data sidebar attacher',
     *     priority: HIGH
     * }
     * @type {Object}
     */
    const Sidebar_data_attacher_middleware = Object.create(null);
    Sidebar_data_attacher_middleware.name = 'Student extra_data sidebar attacher';
    Sidebar_data_attacher_middleware.priority = configuration.load_priority.HIGH;
    Sidebar_data_attacher_middleware.action = (req, res, next) => {
        req.extra_data.system.sidebars = Object.create(null);
        req.extra_data.system.sidebars.canAttach = false;

        if (!req.extra_data.view) {
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to extra_data uninitialized`, log_options);
            return next();
        }

        if (!req.session.user) {
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to session not existent`, log_options);
            return next();
        }

        if (req.method !== 'GET') {
            logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}, due to method not GET`, log_options);
            return next();
        }

        req.extra_data.system.sidebars.canAttach = true;
        logger.debug(`Can attach sidebars: ${req.extra_data.system.sidebars.canAttach}`, log_options);
        return next();
    };

    const accountModel = models.Account_model;
    const accessibleSidebars = require('../utility/FunctionalityAccessibleSidebars.js').functionalitySidebars;

    /**
     * const Sidebar_view_attacher_Middleware = {
     *     name: 'Student sidebar attacher',
     *     priority: Normal
     * }
     * @type {Object}
     */
    const Student_sidebar_checker = Object.create(null);
    Student_sidebar_checker.name = 'Student_sidebar_checker';
    Student_sidebar_checker.priority = configuration.load_priority.NORMAL;
    Student_sidebar_checker.action = (req, res, next) => {
        req.extra_data.system.sidebars.canAttachStudent = req.extra_data.system.sidebars.canAttach && req.session.user.type === 1 && Boolean(req.session.user.organizationSelected);
        return next();
    };

    /**
     * const Sidebar_view_attacher_Middleware = {
     *     name: 'Student sidebar attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const Sidebar_view_attacher_Middleware = Object.create(null);
    Sidebar_view_attacher_Middleware.name = 'Student sidebar attacher';
    Sidebar_view_attacher_Middleware.priority = configuration.load_priority.LOW;
    Sidebar_view_attacher_Middleware.action = (req, res, next) => {
        if (!req.extra_data.system.sidebars.canAttachStudent) {
            return next();
        }

        logger.info('Student sidebar attacher', log_options);

        const user = req.session.user;
        const organizationSelected = user.organizationSelected;
        logger.debug('Organization selected detected', log_options);

        req.extra_data.view.organizationSelected = Object.create(null);
        req.extra_data.view.organizationSelected.acronym = organizationSelected.acronym;
        req.extra_data.view.organizationSelected.path_profilePicture = organizationSelected.path_profilepicture;

        const sidebars = req.extra_data.view.sidebars;
        const accessibleFunctionalities = req.extra_data.user.accessControl[organizationSelected.id];
        for (const functionality in accessibleFunctionalities) {
            const ACL = accessibleFunctionalities[functionality];
            if (ACL) {
                if (accessibleSidebars[functionality]) {
                    for (const sidebar of accessibleSidebars[functionality]) {
                        sidebars[sidebars.length] = sidebar;
                    }//for
                } //if (accessibleSidebars[functionality])
            }// if (ACL)
        }//for

        return next();
    };

    /**
     * const Sidebar_SubmitProjectProposal_Middleware = {
     *     name: Submit Project Proposal Attacher',
     *     priority: LOW
     * }
     * @type {Object}
     */
    const Sidebar_SubmitProjectProposal_Middleware = Object.create(null);
    Sidebar_SubmitProjectProposal_Middleware.name = 'Submit Project Proposal Attacher';
    Sidebar_SubmitProjectProposal_Middleware.priority = configuration.load_priority.LOW;
    Sidebar_SubmitProjectProposal_Middleware.action = (req, res, next) => {
        if (!req.extra_data.system.sidebars.canAttachStudent) {
            return next();
        }

        logger.info('Submit Project Proposal Attacher', log_options);

        const user = req.session.user;
        const organizationSelected = user.organizationSelected;
        const sidebars = req.extra_data.view.sidebars;

        logger.debug('Performing sidebar checks', log_options);
        return database.task(task => {
            return task.batch([
                accountModel.isProjectHead(user.idNumber, task),
                accountModel.hasGOSMACtivityWithAMTActivityEvaluation(user.idNumber, user.organizationSelected.id, task),
                accountModel.hasPPRApproved(user.idNumber, task),
                accountModel.hasPPRWithoutPostProjectProposal(user.idNumber, task),
                organizationModel.hasGOSMSubmitted(organizationSelected.id, task),
                gosmModel.getBuffer(organizationSelected.id, task),
                gosmModel.getCurrentTermGOSM(user.organizationSelected.id, [
                    'g.status'
                ], task)
            ]);
        }).then(([isProjectHead, GOSMActivityWithActivityEvaluation, PPRApproved, hasPPRWithoutPostProjectProposal, hasSubmittedGOSM, buffer, GOSM]) => {

            logger.debug(`isProjectHead: ${isProjectHead.exists}`, log_options);
            if (isProjectHead.exists && organizationSelected.id !== 0) {
                const newSidebar = Object.create(null);
                newSidebar.name = 'Pre Activity';
                newSidebar.link = '/Organization/ProjectProposal/GOSMList';
                newSidebar.icon = 'fa fa-file-o'
                sidebars[sidebars.length] = newSidebar;

                const newSidebar2 = Object.create(null);
                newSidebar2.name = 'Post Activity';
                newSidebar2.link = '/Organization/PostProjectProposal/GOSMList';
                newSidebar2.icon = 'fa fa-file-text-o'
                sidebars[sidebars.length] = newSidebar2;

                const newSidebar3 = Object.create(null);
                newSidebar3.name = 'Activity Feedback';
                newSidebar3.link = '/Organization/Orgres/list';
                newSidebar3.icon = 'fa fa-quote-left';
                sidebars[sidebars.length] = newSidebar3;

                const newSidebar4 = Object.create(null);
                newSidebar4.name = 'Activity Grade';
                newSidebar4.link = '/Organization/viewAmtEvalList';
                //newSidebar4.icon = 'fa fa-quote-left';
                sidebars[sidebars.length] = newSidebar4;
            }

            
            logger.debug(`Has GOSM activity with AMT Evaluation: ${GOSMActivityWithActivityEvaluation.exists}`, log_options);
            logger.warn('AMT Evaluation is unused', log_options);
            
            logger.debug(`Has PPR Approved: ${PPRApproved.exists}`, log_options);
            if(PPRApproved.exists){
                const newSidebar = Object.create(null);
                newSidebar.name = 'Activity Publicity';
                newSidebar.link = '/Organization/Publicity/list';
                newSidebar.icon = 'fa fa-photo';
                
                sidebars[sidebars.length] = newSidebar;
            }

            if(req.extra_data.user.accessibleFunctionalitiesList['21'] || req.extra_data.user.accessibleFunctionalitiesList['18']){
                logger.debug('CAN VIEW FINANCIAL DOCU', log_options);
                const newSidebar = Object.create(null);
                newSidebar.name = 'Financial Documents';
                newSidebar.link = '/finance/list';
                newSidebar.icon = 'fa fa-money';
                
                sidebars[sidebars.length] = newSidebar;
            }


            if(req.extra_data.user.accessControl[organizationSelected.id]){
                let acl28 = req.extra_data.user.accessControl[organizationSelected.id];
                acl28 = acl28['28'] ? acl28['28'] : acl28[28];

                if(GOSM && GOSM.status === 3 && typeof acl28 !== 'undefined' && acl28 !== undefined){
                    logger.debug('Can submit not in GOSM activities', log_options);

                    const newSidebar = Object.create(null);
                    
                    let ctr = 0;
                    if(buffer[0]){
                        ctr = buffer[0].cgaid;
                    }

                    req.session.notingosm = ctr;
                    newSidebar.name = 'Not in GOSM ('+ctr+'/10)';
                    newSidebar.link = '/Organization/additional';
                    newSidebar.icon = 'fa fa-group';
                    
                    sidebars[sidebars.length] = newSidebar;
                }
            }

            return next();
        }).catch(err => {
            logger.error(`${err.message}\n${err.stack}`, log_options);
            return next(err);
        });
    };

    return [
        StudentAccountAccessControlMiddleware,
        Sidebar_data_attacher_middleware,
        Student_sidebar_checker,
        Sidebar_view_attacher_Middleware,
        Sidebar_SubmitProjectProposal_Middleware
    ];
};
