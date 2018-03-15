'use strict';
const attachFields = require('../utility/databaseHelper').attachFields;

const log_options = Object.create(null);
log_options.from = 'ProjectProposal-Model';

const squel = require('squel').useFlavour('postgres');

module.exports = function(configuration, modules, db, queryFiles) {
    let logger = modules.logger;

    const getLatestProjectProposalAttachment = queryFiles.getLatestProjectProposalAttachment;
    const getProjectHeadsGOSM = queryFiles.getProjectHeadsGOSM;
    const insertProjectProposalAttachment = queryFiles.insertProjectProposalAttachment;
    const updatePPRBriefContextSQL = queryFiles.updatePPRBriefContext;
    const insertProjectProposalSQL = queryFiles.insertProjectProposal;
    const insertProjectProposalProgramDesignSQL = queryFiles.insertProjectProposalProgramDesign;
    const insertProjectProposalProjectedIncomeSQL = queryFiles.insertProjectProposalProjectedIncome;
    const insertProjectProposalExpensesSQL = queryFiles.insertProjectProposalExpenses;
    const getProjectProposalSQL = queryFiles.getProjectProposal;
    const getProjectProposalsPerStatusSQL = queryFiles.getProjectProposalsCountPerStatus;
    const getProjectProposalCountTotalSQL = queryFiles.getProjectProposalCountTotal;
    const getPPRProjectedCostSQL = queryFiles.getPPRProjectedCost;
    const getApprovedPPRsSQL = queryFiles.getApprovedPPRs;
    const getNextActivityForApprovalSQL = queryFiles.getNextActivityForApproval;
    const getGOSMActivitiesToImplementSQL = queryFiles.getGOSMActivitiesToImplement;
    const getPPRSectionsToEditSQL = queryFiles.getPPRSectionsToEdit;
    const updatePPRStatusSQL = queryFiles.updatePPRStatus;
    const updateIsProgramDesignCompleteSQL = queryFiles.updateIsProgramDesignComplete;
    const updateIsAttachmentsCompleteSQL = queryFiles.updateIsAttachmentsComplete;
    const updatePPRExpensesSQL = queryFiles.updatePPRExpenses;
    const updatePPRCompletionSQL = queryFiles.updatePPRCompletion;
    const submitProjectProposalSQL = queryFiles.submitProjectProposal;
    const deleteProgramDesignSQL = queryFiles.deleteProgramDesign;
    const deleteExpensesSQL = queryFiles.deleteExpenses;
    const getAllVenuesSQL = queryFiles.getAllVenues;
    const getOrgFacultyAdvisersSQL = queryFiles.getOrgFacultyAdvisers;
    const getAllMyActivity = queryFiles.getAllMyActivity;
    const getPPRToCreatePubsList = queryFiles.getPPRToCreatePubsList;
    const getExpenseTypesSQL = queryFiles.getExpenseTypes;
    const getApprovedPPRCountPerOrgSQL = queryFiles.getApprovedPPRCountPerOrg;
    const getPendedPPRCountPerOrgSQL = queryFiles.getPendedPPRCountPerOrg;
    const getDeniedPPRCountPerOrgSQL = queryFiles.getDeniedPPRCountPerOrg;
    const getActivitiesRelatedToNatureCountSQL = queryFiles.getActivitiesRelatedToNatureCount;
    const getActivitiesNotRelatedToNatureCountSQL = queryFiles.getActivitiesNotRelatedToNatureCount;
    const getGOSMCountPerOrgSQL = queryFiles.getGOSMCountPerOrg;
    const getActivitiesApprovedPerHeadSQL = queryFiles.getActivitiesApprovedPerHead;
    const getProjectProposalCommentsPerStatusSQL = queryFiles.getProjectProposalCommentsPerStatus;
    const getApprovedActivitiesSQL = queryFiles.getApprovedActivities;

    const updatePPRSignatoryStatusSQL = queryFiles.updatePPRSignatoryStatus;
    const getPPRDetailsSQL = queryFiles.getPPRDetails;

    /**
     * class with properties
     * {
     *     _db
     *     _attachfields
     * }
     * @Class ProjectProposalModel
     * @param  {pg-connection} db [description]
     */
    const ProjectProposalModel = function(db, modules) {
        this._db = db;
        const dbHelper = require('../utility/databaseHelper');
        this._attachFields = dbHelper.attachFields;


        this._logger = modules.logger;
    };

   /**
    * Tables that can be currently accessed in this query for fields
    * ProjectProposal ppr
    * GosmActivity ga
    * ActivityType at
    * ActivityNature an
    * studentOrganization so
    *
    * @method  getActivityProjectProposalDetails
    * @param   {Integer}                                     id            [description]
    * @param   {[String, Array] (Optional)}                  fields        [description]
    * @param   {[pg-connection, pg-task, pg-transaction]}    connection    [description]
    * @returns {Promise}                                                   [description]
    */
    ProjectProposalModel.prototype.getActivityProjectProposalDetails = function(id, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.id = ${id}'))

            .with('gosm_activity',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))

            .with('student_organization',
                squel.select()
                .from('StudentOrganization', 'o')
                .where('o.id = ?',
                    squel.select()
                    .from('GOSM', 'g')
                    .field('studentOrganization')
                    .where('g.id = ?',
                        squel.select()
                        .from('gosm_activity', 'ga')
                        .field('GOSM'))))

            .from('PPR', 'pp')
                .left_join('gosm_activity', 'ga', 'TRUE')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('student_organization', 'so', 'TRUE')
                .left_join('ActivityVenue', 'av', 'pp.venue = av.id');

        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Executing Query: ${query}`, log_options);

        let param = Object.create(null);
        param.id = id;
        return connection.oneOrNone(query, param);
    };

    /**
    * Tables that can be currently accessed in this query for fields
    * ProjectProposal ppr
    * GosmActivity ga
    * ActivityType at
    * ActivityNature an
    * studentOrganization so
    *
    * @method  getActivityProjectProposalDetails
    * @param   {Integer}                                     id            [description]
    * @param   {[String, Array] (Optional)}                  fields        [description]
    * @param   {[pg-connection, pg-task, pg-transaction]}    connection    [description]
    * @returns {Promise}                                                   [description]
    */
    ProjectProposalModel.prototype.getActivityProjectProposalDetailsGAID = function(GOSMActivity, fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal', 'ppr')
                .where('ppr.GOSMActivity = ${GOSMActivity}'))

            .with('gosm_activity',
                squel.select()
                .from('GOSMActivity', 'ga')
                .where('ga.id = ?',
                    squel.select()
                    .field('GOSMActivity')
                    .from('PPR')))

            .with('student_organization',
                squel.select()
                .from('StudentOrganization', 'o')
                .where('o.id = ?',
                    squel.select()
                    .from('GOSM', 'g')
                    .field('studentOrganization')
                    .where('g.id = ?',
                        squel.select()
                        .from('gosm_activity', 'ga')
                        .field('GOSM'))))

            .from('PPR', 'pp')
                .left_join('gosm_activity', 'ga', 'TRUE')
                .left_join('ActivityType', 'at', 'ga.activityType = at.id')
                .left_join('ActivityNature', 'an', 'ga.activityNature = an.id')
                .left_join('student_organization', 'so', 'TRUE')
                .left_join('"ActivityVenue"', 'av', 'pp.venue = av.id');

        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Executing Query: ${query}`, log_options);

        let param = Object.create(null);
        param.GOSMActivity = GOSMActivity;
        return connection.oneOrNone(query, param);
    };

    /*
        Merges the tables
        ProjectProposal = pp
        GOSMActivity = ga
    */
   /**
    * Retrieves All Project Proposals
    * @method  getAllActivityProjectProposal
    * @param   {[String, Array] (Optional)}                  fields     [description]
    * @param   {[pg-conncetion, pg-transaction, pg-task]}    connection [description]
    * @returns {Promise}                                     [description]
    */
    ProjectProposalModel.prototype.getAllActivityProjectProposal = function(fields, connection = this._db) {
        let query = squel.select()
            .with('PPR',
                squel.select()
                .from('ProjectProposal')
                .where('status <> 1')
                .where('status <> 3'))

        .with('GOSMA',
            squel.select()
            .from('GOSMActivity')
            .where('id IN ?',
                squel.select()
                .from('PPR')
                .field('DISTINCT GOSMActivity')))

        .with('GOSM',
            squel.select()
            .from('GOSM', 'g')
            .field('DISTINCT g.id')
            .field('g.studentOrganization')
            .where('g.id IN ?',
                squel.select()
                .from('GOSMA')
                .field('GOSM')))

        .with('ORG',
            squel.select()
            .from('StudentOrganization', 'so')
            .where('so.id IN ?',
                squel.select()
                .from('GOSM', 'g')
                .field('g.studentOrganization')))

        .from('PPR', 'pp')
            .left_join('GOSMA', 'ga', 'pp.GOSMActivity = ga.id')
            .left_join('GOSM', 'g', 'ga.GOSM = g.id')
            .left_join('ORG', 'so', 'g.studentOrganization = so.id');
        this._attachFields(query, fields);

        query = query.toString();
        this._logger.debug(`Query: ${query}`, log_options);
        return connection.any(query);
    };

    ProjectProposalModel.prototype.getProjectProposalProgramDesign = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProgramDesign', 'pppd')
        .left_join('account','acc','pppd.personincharge = acc.idnumber')
        .where('projectProposal = ?', squel.select()
            .from('ProjectProposal')
            .where('GOSMActivity = ${id}')
            .field('id'))
        .order("pppd.date");
        this._attachFields(query, fields);

        query = query.toString();
        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };
    ProjectProposalModel.prototype.updateProjectProposalActualDate = function(id, date, connection = this._db){
         console.log(date)
        console.log("date MODEL")
        var day = 60 * 60 * 24 * 1000;
        var date1 = new Date(date[0])
        
        date1 = new Date(date1.getTime() + day);
        var date2 = new Date(date[date.length-1])
        date2 = new Date(date2.getTime() + day);
        let query = squel.update()
        .table('projectproposal')
        .set('actualDateStart',date1.toISOString().split('T')[0])
        .set('actualDateEnd',date2.toISOString().split('T')[0])
        .where('id = ?',id)
            

        query = query.toString();
        console.log(query)
        return connection.any(query);
    };
    ProjectProposalModel.prototype.updateProjectProposalPD = function(id, date, connection = this._db){
        console.log(id)
        var query ='';
        var day = 60 * 60 * 24 * 1000;
       
        for(var ctr = 0; ctr < date.length; ctr++){
             var date1 = new Date(date[ctr])
        date1 = new Date(date1.getTime() + day);
        console.log("asd")        
            query = squel.update()
                        .table('ProjectProposalProgramDesign')
                        .set('date',date1.toISOString().split('T')[0])                 
                        .where('dayid = ?',ctr)
                        .where('projectProposal = ?',id)                        
                        query = query.toString();    
            query+=';'
            console.log(query)

        }
        console.log(query)
        return connection.any(query);
    };
    ProjectProposalModel.prototype.getProjectProposalProgramDesignDates = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProgramDesign', 'pppd')
        .field("DISTINCT(PPPD.DATE)")
        .left_join('account','acc','pppd.personincharge = acc.idnumber')
        .where('projectProposal = ?', squel.select()
            .from('ProjectProposal')
            .where('GOSMActivity = ${id}')
            .field('id'))
        .order("pppd.date")
        
        this._attachFields(query, fields);

        query = query.toString();
        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };


    ProjectProposalModel.prototype.getAllOrgProposal = function(orgid, fields, connection = this._db){
        logger.info(`call getAllOrgProposal(orgid: ${orgid})`, log_options);

        let query = squel.select()
            .from('GOSM', 'G')
            .left_join('GOSMActivity','GA','G.id = GA.Gosm')
            .left_join('ProjectProposal','PP','GA.ID = PP.GosmActivity')
            .where('G.termID = ?',squel.str('system_get_current_term_id()'))
            .where('G.studentorganization = ${organizationID}');
        this._attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.organizationID = orgid;
        
        logger.debug(`Executing query: ${query}`, log_options);
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getProjectProposalExpensesPPRID = function(pprid, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalExpenses', 'PPE')
        .left_join('ExpenseType',"EE","PPE.type = EE.id")
        .where('PPE.projectProposal = ?',pprid)
        query = query.toString();
        
        return connection.any(query);
    };
    ProjectProposalModel.prototype.getProjectProposalRevenuePPRID = function(pprid, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProjectedIncome', 'PPPI')
        .where('PPPI.projectProposal = ?',pprid)
        query = query.toString();
        
        return connection.any(query);
    };
    
    ProjectProposalModel.prototype.getProjectProposalExpenses = function(id, fields, connection = this._db){
        console.log('ProjectProposalExpenses()');
        let query = squel.select()
        .from('ProjectProposalExpenses', 'ppe')
            .left_join('ExpenseType', 'et', 'ppe.type = et.id')
        .where('projectProposal = ?', squel.select()
            .from('ProjectProposal')
            .where('GOSMActivity = ${id}')
            .field('id'));
        this._attachFields(query, fields);

        query = query.toString();

        /**
         * conts param = {
         *     id: id
         * }
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.id = id;

        console.log(`EXPENSES: \n${query}`);
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProjectedIncome =  function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalProjectedIncome', 'pppi')
        .where('projectProposal = ?', squel.select()
            .from('ProjectProposal')
            .where('GOSMActivity = ${id}')
            .field('id'));
        this._attachFields(query, fields);

        query = query.toString();

        let param = Object.create(null);
        param.id = id;
        return connection.any(query, param);
    };
    ProjectProposalModel.prototype.updatePPResched =  function(id, reason, dates, other, status, connection = this._db){
        let query = squel.update()
                         .table("ProjectProposal")
                         .set("status",status)
                         .set("reschedulereason", reason)
                         .set("rescheduledates", "{"+dates+"}")
                         .set("reschedreasonother", other)
                         .set("reschedrejectreason", '')
                         .where("GosmActivity = ?",id)

        console.log(query.toString())
        return connection.any(query.toString());
    };
    ProjectProposalModel.prototype.approvePPResched =  function(id, comment, status, connection = this._db){
        console.log("============================")
        console.log(comment)
        if(comment === ''){
            console.log("PASDSd")
            comment = null
        }
        
        let query = squel.update()
                         .table("ProjectProposal")
                         .set("status",status)
                         .set("reschedrejectreason", comment)                         
                         .where("gosmactivity = ?",id);

      
        return connection.any(query.toString());
    };


     ProjectProposalModel.prototype.deleteRevenue =  function(id, connection = this._db){
        
        let query = squel.delete()
                        .from("ProjectProposalProjectedIncome")
                        .where("projectProposal = ?",id)
        query = query.toString();        
        return connection.any(query);
    };

    ProjectProposalModel.prototype.getReschedActivities =  function(connection = this._db){
        
        let query = squel.select()
                        .from('GOSM', 'G')
                        .left_join('GOSMACTIVITY','GA',' G.ID = GA.GOSM')
                        .left_join('PROJECTPROPOSAL','PP',' GA.ID = PP.GOSMACTIVITY')

                        .left_join('PROJECTPROPOSALRESCHEDULEREASON','PPRR',' PP.RESCHEDULEREASON = PPRR.ID')

                        .where('G.termID = ?',squel.str('system_get_current_term_id()'))
                        .where('PP.STATUS = 6')                                
        query = query.toString();        
        return connection.any(query);
    };

    ProjectProposalModel.prototype.getSignatoryStatus =  function(idNumber, gosmactivity, connection = this._db){
        
        let query = squel.select()
                        .from('projectProposalsignatory')                                                
                        .where('gosmactivity = ?',gosmactivity)                                
                        .where('signatory = ?',idNumber)
                        .limit(1)                                
        query = query.toString();        
        return connection.one(query);
    };

    ProjectProposalModel.prototype.getProjectProposalAttachment = function(id, fields, connection = this._db){
        let query = squel.select()
        .from('ProjectProposalAttachment', 'ppa')
            .left_join('DocumentAttachmentRequirement', 'dar', 'ppa.requirement = dar.id')
        .where('projectProposal = ?', squel.select()
            .from('ProjectProposal')
            .where('GOSMActivity = ${id}')
            .field('id'));
        this._attachFields(query, fields);
        query = query.toString();

        let param = Object.create(null);
        param.id = id;
            
        return connection.any(query, param);
    };

    ProjectProposalModel.prototype.getPPRProjectedCost = function(param, connection = this._db) {
        return connection.oneOrNone(getPPRProjectedCostSQL, param);
    };
    ProjectProposalModel.prototype.getProjectHeadsGOSM = function(param, connection = this._db) {
        return connection.any(getProjectHeadsGOSM, param);
    };

    ProjectProposalModel.prototype.getGOSMActivitiesToImplement = function(param, connection = this._db) {
        logger.info('call getGOSMActivitiesToImplement()', log_options);
        return connection.any(getGOSMActivitiesToImplementSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposal = function(param, connection = this._db) {
        return connection.one(getProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRBriefContext = function(param, connection = this._db) {
        //TODO: test
        return connection.none(updatePPRBriefContextSQL, param);
    };


    ProjectProposalModel.prototype.insertProjectProposal  = function(param, connection = this._db){
        logger.debug(`insertProjectProposal(${JSON.stringify(param)})`, log_options);

        logger.debug(`Executing query: ${insertProjectProposalSQL}`, log_options);
        return connection.one(insertProjectProposalSQL, param);
    };


    ProjectProposalModel.prototype.updateIsProgramDesignComplete = function(param, connection = this._db) {
        return connection.none(updateIsProgramDesignCompleteSQL, param);
    };

    ProjectProposalModel.prototype.updateIsAttachmentsComplete = function(param, connection = this._db){
        return connection.none(updateIsAttachmentsCompleteSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRCompletion = function(param, connection = this._db){
        return connection.none(updatePPRCompletionSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalDesign = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.getPPRDetails = function(param, connection = this._db){
        return connection.one(getPPRDetailsSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalAttachment = function(param, connection = this._db) {
        //TODO: test

        return connection.none(insertProjectProposalAttachment, param);
    };

    ProjectProposalModel.prototype.getLatestProjectProposalAttachment = function(param, connection = this._db) {
        //TODO: test

        return connection.any(getLatestProjectProposalAttachment, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalProjectedIncome = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalProjectedIncomeSQL, param);
    };

    ProjectProposalModel.prototype.insertProjectProposalExpenses = function(param, connection = this._db) {
        //TODO: test
        return connection.none(insertProjectProposalExpensesSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalsCountPerStatus = function(studentorganization, status, idnumber, connection = this._db) {

        /**
         * const param = {
         *     gosm: gosm,
         *     status: status
         * };
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.studentorganization = studentorganization;
        param.status = status;
        param.idnumber = idnumber;

        return connection.oneOrNone(getProjectProposalsPerStatusSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalCountTotal = function(studentorganization, idnumber, connection = this._db) {


        let param = Object.create(null);
        param.studentorganization = studentorganization;
        param.idnumber = idnumber;

        return connection.oneOrNone(getProjectProposalCountTotalSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalProjectHeads = function(id, connection = this._db){
        /**
         * const param = {
         *     id: id
         * };
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.id = id;

        return connection.any(queryFiles.getProjectProposalProjectHeads, param);
    };

    ProjectProposalModel.prototype.getActivitiesApprovedPerHead = function(studentorganization, idnumber, connection = this._db) {


        let param = Object.create(null);
        param.studentorganization = studentorganization;
        param.idnumber = idnumber;

        return connection.any(getActivitiesApprovedPerHeadSQL, param);
    };

    ProjectProposalModel.prototype.getProjectProposalCommentsPerStatus = function(studentorganization, status, idnumber, connection = this._db) {

        /**
         * const param = {
         *     gosm: gosm,
         *     status: status
         * };
         * @variable param
         * @type {Object}
         */
        let param = Object.create(null);
        param.studentorganization = studentorganization;
        param.status = status;
        param.idnumber = idnumber;

        return connection.any(getProjectProposalCommentsPerStatusSQL, param);
    };

    ProjectProposalModel.prototype.getNextActivityForApproval = function(idNumber, connection = this._db){
        const param = Object.create(null);
        param.idNumber = idNumber;

        return connection.oneOrNone(getNextActivityForApprovalSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRStatus = function(param, connection = this._db){
        return connection.none(updatePPRStatusSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRExpenses = function(param, connection = this._db){
        return connection.none(updatePPRExpensesSQL, param);
    };

    ProjectProposalModel.prototype.updatePPRSignatoryStatus = function(param, connection = this._db){
        return connection.none(updatePPRSignatoryStatusSQL, param);
    };

    ProjectProposalModel.prototype.submitProjectProposal = function(param, connection = this._db){
        return connection.none(submitProjectProposalSQL, param);
    };

    ProjectProposalModel.prototype.getApprovedPPRs = function(connection = this._db){
        return connection.any(getApprovedPPRsSQL);
    };

    ProjectProposalModel.prototype.getPPRSectionsToEdit = function(param, connection = this._db){
        return connection.one(getPPRSectionsToEditSQL, param);
    };

    ProjectProposalModel.prototype.deleteProgramDesign = function(param, connection = this._db){
        return connection.none(deleteProgramDesignSQL, param);
    };

    ProjectProposalModel.prototype.deleteExpenses = function(param, connection = this._db){
        return connection.none(deleteExpensesSQL, param);
    };
    ProjectProposalModel.prototype.getAllMyActivity = function(param, connection = this._db){
        return connection.any(getAllMyActivity, param);
    };

    ProjectProposalModel.prototype.getAllVenues = function(connection = this._db){
        return connection.any(getAllVenuesSQL);
    };

    ProjectProposalModel.prototype.getOrgFacultyAdvisers = function(param, connection = this._db){
        return connection.any(getOrgFacultyAdvisersSQL, param);
    };
    ProjectProposalModel.prototype.getPPRToCreatePubsList = function(param, connection = this._db){
        return connection.any(getPPRToCreatePubsList, param);
    };

    ProjectProposalModel.prototype.getExpenseTypes = function(connection = this._db){
        return connection.many(getExpenseTypesSQL);
    };

    ProjectProposalModel.prototype.getApprovedPPRCountPerOrg = function(param, connection = this._db){
        return connection.oneOrNone(getApprovedPPRCountPerOrgSQL, param);
    };

    ProjectProposalModel.prototype.getPendedPPRCountPerOrg = function(param, connection = this._db){
        return connection.oneOrNone(getPendedPPRCountPerOrgSQL, param);
    };

    ProjectProposalModel.prototype.getDeniedPPRCountPerOrg = function(param, connection = this._db){
        return connection.oneOrNone(getDeniedPPRCountPerOrgSQL, param);
    };

    ProjectProposalModel.prototype.getActivitiesRelatedToNatureCount = function(param, connection = this._db){
        return connection.oneOrNone(getActivitiesRelatedToNatureCountSQL, param)
    };

    ProjectProposalModel.prototype.getActivitiesNotRelatedToNatureCount = function(param, connection = this._db){
        return connection.oneOrNone(getActivitiesNotRelatedToNatureCountSQL, param)
    };

    ProjectProposalModel.prototype.getGOSMCountPerOrg = function(param, connection = this._db){
        return connection.oneOrNone(getGOSMCountPerOrgSQL, param);
    };

    ProjectProposalModel.prototype.getApprovedActivities = function(connection = this._db){
        return connection.any(getApprovedActivitiesSQL);
    };

    const getAllProjectProposalSQL = queryFiles.getAllProjectProposal;
    ProjectProposalModel.prototype.getAllProjectProposal = function(connection = this._db){
        return connection.any(getAllProjectProposalSQL);
    };

    const getNextPPRSignatorySQL = queryFiles.getNextPPRSignatory;
    ProjectProposalModel.prototype.getNextPPRSignatory = function(param, connection = this._db){
        return connection.oneOrNone(getNextPPRSignatorySQL, param);
    };

    const getSignatoriesSQL = queryFiles.PPR_get_signatories;
    ProjectProposalModel.prototype.getSignatories = function(activityID, connection = this._db){
        return connection.many(getSignatoriesSQL, {
            activityID: activityID
        });
    };

    const getTotalExpenseSQL = queryFiles.PPR_get_total_expense;
    ProjectProposalModel.prototype.getTotalExpenseSQL = function(activityID, connection = this._db){
        logger.debug(`getSignatories(activityID: ${activityID})`, log_options);
        return connection.many(getTotalExpenseSQL, {
            GAID: activityID
        });
    };

    /**
     * [description]
     * @method
     * @param    {Integer}  PPRID       [description]
     * @param    {Array(String)}  fields      [description]
     * @param    {pg-connection}  connection  [description]
     * @returns  {pg-promise}              [description]
     */
    ProjectProposalModel.prototype.getDetails = (PPRID, fields, connection = this._db) => {
        logger.debug(`getDetails(PPRID: ${PPRID})`, log_options);

        let query = squel.select()
        .with('PPR', squel.select()
            .from('ProjectProposal ppr')
            .where('id = ${PPRID}'))
        .with('GOSMA', squel.select()
            .from('GOSMActivity')
            .where('id = ?', squel.select()
                .from('PPR')
                .field('GOSMActivity')))
        .from('PPR p')
        .left_join('GOSMA', 'ga', ' p.GOSMActivity = ga.id');

        attachFields(query, fields);

        let param = Object.create(null);
        param.PPRID = PPRID;

        query = query.toString();
        logger.debug(`Executing query: ${query}`, log_options);

        return connection.oneOrNone(query, param);
    };

    const getNextSignatorySQL = queryFiles.PPR_get_next_signatory;
    ProjectProposalModel.prototype.getNextSignatory = (GOSMActivityID, connection = this._db) => {
        logger.debug(`getNextSignatory(GOSMActivity: ${GOSMActivityID})`, log_options);

        let param = Object.create(null);
        param.activityID = GOSMActivityID;


        return connection.oneOrNone(getNextSignatorySQL, param);
    };

    return new ProjectProposalModel(db, modules);
};
