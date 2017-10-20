'use strict';
module.exports = (configuration, mainApplication, modules) => {
    const middlewareMaker = require('../utility/middleware_maker.js');
    const cookieParser = require('cookie-parser');
    const bodyParser = require('body-parser');

    /**
     * The Object for the jsonBodyParse
     * const jsonBodyParse = {
     * {
	 *    name: String,
	 *    description: String,
	 *    action: function(err, req, res)
	 *    priority: NUMBER
     * };
     * @type {Object}
     */
    const jsonBodyParseMiddleware = middlewareMaker(
        /* Name of middleware*/
        'JSON Body Parser',
        undefined,
        configuration.load_priority.CORE,
        bodyParser.json()
    );

    /**
     * The Object for the urlEncoded
     * const jsonBodyParse = {
     * {
	 *    name: String,
	 *    description: String,
	 *    action: function(err, req, res)
	 *    priority: NUMBER
     * };
     * @type {Object}
     */
    const urlEncodedBodyParseMiddleware = middlewareMaker(
        'urlEncoded Body Parser',
        undefined,
        configuration.load_priority.CORE,
        bodyParser.urlencoded({extended: false})
    );

    /**
     * The Object for the cookieParser
     * const jsonBodyParse = {
     * {
	 *    name: String,
	 *    description: String,
	 *    action: function(err, req, res)
	 *    priority: NUMBER
     * };
     * @type {Object}
     */
    const cookieParserMiddleware = middlewareMaker(
        'Cookie parser',
        undefined,
        configuration.load_priority.CORE,
        cookieParser(configuration.webserver.session.cookie.secret)
    );

    return [
        jsonBodyParseMiddleware,
        urlEncodedBodyParseMiddleware,
        cookieParserMiddleware
    ];
};
