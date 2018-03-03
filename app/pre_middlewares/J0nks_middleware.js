'use strict';

//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    const CONSTANTS_admin_sidebars = require('../utility/CONSTANTS_admin_sidebars.json');

    let middlewares = [];

    const logger = modules.logger;
    const log_options = Object.create(null);
    log_options.from = 'J0nks-Middleware';

    /**
     * Function named jack called by the JackMiddleware
     * @method
     */
    function jack(next){
        logger.debug('call Jack()', log_options);

        return next();
    }
    const JackMiddleware = Object.create(null);
    JackMiddleware.name = 'Jack Middleware';
    JackMiddleware.priority = configuration.load_priority.LOW - 10;
    JackMiddleware.action = (req, res, next) => {
        return jack(next);
    };

    middlewares[0] = JackMiddleware;

    if (configuration.webserver.easter_eggs.enable_footer_quotes) {
        logger.warn('Communist/Marxist footer quotes activated', log_options);

        const QUOTES = [
            'The worker of the world has nothing to lose, but their chains, workers of the world unite! ― Karl Marx',
            'The history of all hitherto existing society is the history of class struggles. ― Karl Marx',
            'Revolutions are the locomotives of history. ― Karl Marx',
            'A specter is haunting Europe - the specter of communism. ― Karl Marx',
            'Religion is the opium of the masses. ― Karl Marx',
            'Machines were, it may be said, the weapon employed by the capitalists to quell the revolt of specialized labor. ― Karl Marx',
            'Capital is reckless of the health or length of life of the laborer, unless under compulsion from society. ― Karl Marx',
            'The first requisite for the happiness of the people is the abolition of religion. ― Karl Marx',
            'The first duty of a man is to think for himself ― José Martí',
            'When I give food to the poor, they call me a saint. When I ask why the poor have no food, they call me a communist. ― Hélder Câmara',
            'From each according to his ability, to each according to his needs ― Karl Marx',
            'Communism is the riddle of history solved, and it knows itself to be this solution ― Karl Marx',
            'The worker therefore only feels himself outside his work, and in his work feels outside himself ― Karl Marx'
        ];

        const FooterAttacher = Object.create(null);
        FooterAttacher.name = 'Quote-footer-middleware';
        FooterAttacher.priority = configuration.load_priority.LOW;
        FooterAttacher.action = (req, res, next) => {
            if(req.method === 'GET'){
                logger.debug(`Attaching footer data`, log_options);
                req.extra_data.view.footer = QUOTES[Math.floor(Math.random() * (QUOTES.length))];
                logger.debug(`Chosen quote: ${req.extra_data.view.footer}`, log_options);
            }//method === 'GET'

            return next();
        };//FooterAttacher.action

        middlewares[middlewares.length] = FooterAttacher;
    }//if(quotesenabled)



    return middlewares;
};
