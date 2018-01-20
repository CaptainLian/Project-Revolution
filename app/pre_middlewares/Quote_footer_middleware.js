'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    if (configuration.webserver.easter_eggs.enable_footer_quotes) {

        const logger = modules.logger;
        const log_options = {
            from: 'Quote-footer-middleware'
        };

        logger.warn('Marxist footer quotes activated', log_options);

        

        const QUOTES = [
            'The worker of the world has nothing to lose, but their chains, workers of the world unite!',
            'Revolutions are the locomotives of history.',
            'A specter is haunting Europe - the specter of communism.',
            'Religion is the opium of the masses.',
            'Machines were, it may be said, the weapon employed by the capitalists to quell the revolt of specialized labor.',
            'Capital is reckless of the health or length of life of the laborer, unless under compulsion from society.',
            'The first requisite for the happiness of the people is the abolition of religion.'
        ];

        const FooterAttacher = Object.create(null);
        FooterAttacher.name = 'Quote-footer-middleware';
        FooterAttacher.priority = configuration.load_priority.LOW;
        FooterAttacher.action = (req, res, next) => {

            logger.debug(`Attaching footer data`, log_options);

            req.extra_data.footer = QUOTES[Math.floor(Math.random() * (QUOTES.length))];

            logger.debug(`Chosen quote: ${req.extra_data.footer}`, log_options);

            return next();
        };

        return [FooterAttacher];
    }


    return [];

};