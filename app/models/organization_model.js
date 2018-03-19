'use strict';

module.exports = function(configuration, modules, database, queryFiles){
	const squel = require('squel').useFlavour('postgres');
	
	const {attachFields, attachReturning} = (() => {
		const dbHelper = require('../utility/databaseHelper');

		let param = Object.create(null);
		param.attachFields = dbHelper.attachFields;
		param.attachReturning = dbHelper.attachReturning;

		return param;
	})();

	const log_options = Object.create(null);
	log_options.from = 'Organization-Model';

	const getActivitiesWithPPRSQL = queryFiles.getActivitiesWithPPR;
	const getActivitiesWithoutPPRSQL = queryFiles.getActivitiesWithoutPPR;
	const getStudentsOfOrganizationSQL = queryFiles.getStudentsOfOrganization;
	const getStudentOrganizationSQL = queryFiles.getStudentOrganization;
	const getAllStudentOrganizationsSQL = queryFiles.getAllStudentOrganizations;

	const getAllCurrentOrganizationMembersSQL = queryFiles.getAllCurrentOrganizationMembers;

    const logger = modules.logger;

	/**
	 * The object representing the model, which contains acions a model can do
	 * @type {Object}
	 */
	const OrganizationModel = Object.create(null);

	OrganizationModel.getOrganizationInformation = (id, fields, connection = database) => {
		logger.debug(`Invoked, fields: ${JSON.stringify(fields)}`, log_options);
		let query = squel.select()
			.from('StudentOrganization')
			.where('id = ${id}');
		attachFields(query, fields);

		let param = Object.create(null);
		param.id = id;

		query = query.toString();
		 logger.debug(`Executing query: ${query}`, log_options);
		return connection.one(query.toString(), param);
	};

	OrganizationModel.addMember = (id, name,orgid, connection = database) => {
		
		let query = squel.insert()
			.into('"OrganizationMember"')
			.set('"idNumber"', id)
			.set('name', name)
			.set('"yearID"',  squel.str('system_get_current_year_id()'))
			.set("organization",orgid)
		

		let param = Object.create(null);
		param.id = id;

		query = query.toString();
		 
		return connection.any(query);
	};
	OrganizationModel.viewMember = (id, connection = database) => {
		
		let query = squel.select()
			.from('"OrganizationMember"')
			.where("organization = ?",id)

		let param = Object.create(null);
		param.id = id;

		query = query.toString();
		 
		return connection.any(query);
	};

	OrganizationModel.deleteMember = (id, orgid, connection = database) => {
		console.log(id)
		let query = squel.delete()
			.from('"OrganizationMember"')
			.where('"idNumber" = ?',id)
			.where("organization = ?",orgid);	

		query = query.toString();
		 
		return connection.any(query);
	};


	OrganizationModel.getActivitiesWithPPR = (param, fields, connection = database) => {
		return connection.one(getActivitiesWithPPRSQL, param);
	};

	OrganizationModel.getStudentOrganization = (param, fields, connection = database) =>{
		return connection.one(getStudentOrganizationSQL, param);
	};

	OrganizationModel.getActivitiesWithoutPPR = (param, fields, connection = database) => {
		return connection.one(getActivitiesWithoutPPRSQL, param);
	};

	OrganizationModel.getStudentsOfOrganization = (param, fields, connection = database) => {
		return connection.any(getStudentsOfOrganizationSQL, param);
	};

	OrganizationModel.getAllStudentOrganizations = (connection = database) => {
		return connection.any(getAllStudentOrganizationsSQL);
	};

	OrganizationModel.getFunctionality = (connection = database) => {
		var query = squel.select()
						.from("functionality")
		return connection.any(query.toString());
	};
	OrganizationModel.getOrgRole = (connection = database) => {
		var query = squel.select()
						.from("studentOrganization", "so")
						.left_join("OrganizationRole","orr","so.id = orr.organization")
		return connection.any(query.toString());
	};
	OrganizationModel.getTestJson = (connection = database) => {
		var query =
			`SELECT json_object(array_agg(z.role)::text[], array_agg(z.rw)::text[])
			   FROM (
			   		  SELECT role, ( 
			   		  					SELECT array_to_json(array_agg(
			   		  											(t.functionality)
			   		  											)
			   		  									)
			   		  					  from (select functionality from organizationaccesscontrol where role=oac.role) t 
			   		  					  
			   		  					  group by role
			   		  			    ) rw
			   		     FROM  organizationaccesscontrol oac
			   		     Group by role
			   		 ) z`

			

		   //  `SELECT json_build_object('role',q.role,'functionality',
		   //      (SELECT json_agg(json_build_array(functionality))
		   //       FROM organizationaccesscontrol oac WHERE oac.role = q.role)) json
		   //  FROM organizationaccesscontrol q GROUP BY q.role`;

		   //  `select json_object(array_agg(id)::text[],array_agg(rw)::text[])
			  // from ( select id
			  //          , ( select to_json(array_agg(row_to_json(t)
			  //          								)
			  //          	  				  )
			  //          		 from (select typ,prop from bgb where id=b.id) t 
			  //       	  ) rw
			  //     	 			 from bgb b
			  //       	group by id 
			  //       ) z;`

	
		// return connection.map(query, [], a => a.z);
		return connection.any(query);
	};
	/**
	 * Retrives AND parses the input into an organization chart object
	 * This is a computationally EXPENSIVE operation, please use it sparringly
	 * NOTE: optimization can be done by caching results to an object
	 * @method
	 * @param  {Integer} organizationID [description]
	 * @param  {Boolean} promisify      [description]
	 * @param  {[pg-connection, pg-task, pg-transaction] (Optional)} connection     [description]
	 * @return {Object}                [description]
	 */
	OrganizationModel.getOrganizationStructure = (organizationID, connection = database) => {
		logger.debug(`getOrganizationStructure(organizationID: ${organizationID})`, log_options);

		/**
		 * let param = {
		 * 		organizationID: organizationID
		 * };
		 * @type {Object}
		 */
		let param = Object.create(null);
		param.organizationID = organizationID;

		return connection.many('SELECT id, name, masterRole FROM OrganizationRole WHERE organization = ${organizationID} ORDER BY id ASC;', param).then(data => {
			let organizationStructure = Object.create(null);

			let lookup = Object.create(null);
			for(let index = data.length + 1, length = data.length; --index;){
				const element = data[length - index];
				lookup[element.id] = element;
			}

			let keys = Object.keys(lookup);
			for(let index = keys.length + 1, length = keys.length; --index;){
				const role = lookup[keys[length - index]];

				//If role has a master, which may have masters of its own...
				if(role.masterrole){
					/* Time to path find... */
					/**
					 * The array of objects to explore
					 * @type {Array}
					 */
					let exploration = [];

					/* pre-populate the exploration */
					let masterKeys = Object.keys(organizationStructure);
					for(let masterIndex = masterKeys.length; masterIndex--;){
						const masterRole = organizationStructure[masterKeys[masterIndex]];

						exploration[exploration.length] = masterRole;
					}

					/* start exploring */
					while(exploration.length > 0){
						const current = exploration.shift();

						/* if this is not the goal*/
						if(current.id !== role.masterrole){
							/* populate the exploration to continue exploring */
							/* if the current exploration has sub-positions */
							if(current.under){
								let subKeys = Object.keys(current.under);
								for(let subIndex = subKeys.length; subIndex--;){
									const subRole = current.under[subKeys[subIndex]];
									exploration[exploration.length] = subRole;
								}
							}

						/* this is the goal */
						}else{
							if(typeof current.under !== 'undefined'){
								current.under[role.id] = role;
							}else{
								current.under =  Object.create(null);
								current.under[role.id] = role;
							}

							break;
						}
					}
				/* role is independent */
				}else{
					let masterRole = Object.create(null);
					masterRole.id = role.id;
					masterRole.name = role.name;
					masterRole.under = Object.create(null);
					organizationStructure[role.id] = masterRole;
				}
			}

			return Promise.resolve(organizationStructure);
		});
	};

	const hasGOSMSubmittedSQL = queryFiles.organization_GOSM_has_submitted;
	OrganizationModel.hasGOSMSubmitted = (organizationID, connection = database) => {
		logger.debug(`hasGOSMSubmitted(organizationID: ${organizationID})`, log_options);

		logger.debug(hasGOSMSubmittedSQL, log_options);
		return connection.one(hasGOSMSubmittedSQL, {
			studentOrganization: organizationID
		});
	};

	OrganizationModel.getOrganzationPresident = (organizationID, fields, connection = database) => {
		logger.debug(`getOrganzationPresident$(${organizationID})`, log_options);

		let query = squel.select()
			.from('Account a')
			.where('a.idnumber = organization_get_president(${organizationID})');
		attachFields(query, fields);

		let param = Object.create(null);
		param.organizationID = organizationID;

		query = query.toString();
		logger.debug(`Executing query: ${query}`, log_options);
		return connection.one(query, param);
	};

	/**
	 * Gets the information who have roles that are below the organiation president
	 * Joined tables and their aliases
	 *     Account a
	 *     OrganizationOfficer oo
	 * @method
	 * @param    {Integer}                   organizationID  [description]
	 * @param    {pg-connection (Optional)}  connection      [description]
	 * @returns  {pg-promise}                                [description]
	 */
	OrganizationModel.getOrganizationExecutiveBoard = (organizationID, fields, connection = database) => {
		logger.debug(`getOrganizationExecutiveBoard(organizationID: ${organizationID}`, log_options);

        /**
         * Query for getting the account who is part of this year's (system_get_current_year_id())
         * executive board (EB), EB is defined as the positions whose masterRole is
         * the president of the organization.
         * The president has NULL as masterRole and has the lowest rank number.
         * @type {squel_query}
         */
		let query = squel.select()
			.with('"OrganizationRoles"',
				squel.select()
				.from('OrganizationRole')
				.where('organization = ${organizationID}'))
			.with('"ExecutiveRoles"',
				squel.select()
				.from('"OrganizationRoles"', 'oro')
				.where('oro.masterRole = ?',
					squel.select()
					.field('id')
					.from('"OrganizationRoles"')
					.where('masterRole IS NULL')
					.where('rank = ?',
						squel.select()
						.from('"OrganizationRoles"')
						.field('MIN(rank)'))))
			.from('OrganizationOfficer', 'oo')
			.left_join('Account', 'a', 'oo.idNumber = a.idNumber')
			.where('oo.yearID = system_get_current_year_id()')
			.where('oo.role IN ?',
				squel.select()
				.field('id')
				.from('"ExecutiveRoles"'));

        if(fields){
            attachFields(query, fields);
        }

		let param = Object.create(null);
		param.organizationID = organizationID;

		query = query.toString();
		logger.debug(`Executing query: ${query}`, log_options);
		return connection.any(query, param);
	};

	OrganizationModel.getAccountWithAccessControlSequence = (ACLSequence, organizationID, fields, connection = database) => {
		logger.info(`call getAccountWithAccessControlSequence(ACLSequence: ${ACLSequence}, organizationID: ${organizationID})`, log_options);
		
		let query = squel.select()
			.from('Account a')
			.where('a.idNumber IN ?', squel.select()
				.field('oo.idNumber')
				.from('OrganizationOfficer oo')
				.where('oo.yearID = system_get_current_year_id()')
				.where('oo.role IN ?', squel.select()
					.field('id')
					.from('OrganizationRole oro')
					.where('organization = ${organizationID}')
					.where('id IN ?', squel.select()
						.field('role')
						.from('OrganizationAccessControl oac')
						.where('functionality = ?', squel.select()
							.field('id')
							.from('functionality')
							.where('id%1000 = ${ACLSequence}')))));
		attachFields(query, fields);

		let param = Object.create(null);
		param.ACLSequence = ACLSequence;
		param.organizationID = organizationID;

		query = query.toString();
		logger.debug(`Executing query: ${query}`, log_options);
		return connection.any(query, param);
	};

	return OrganizationModel;
};
