'use strict';

module.exports = (attachable, req) =>{
	attachable = attachable || Object.create(null);
	attachable.extra_data = Object.create(null);
	attachable.extra_data.view = req.extra_data.view;
	
	return attachable;
};