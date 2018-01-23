'use strict';
//configuration, mainApplication, modules, database, queryFiles, models
module.exports = function(configuration, application, modules, database, queryFiles, models) {
    if (configuration.webserver.easter_eggs.enable_footer_quotes) {
        const logger = modules.logger;
        const log_options = {
            from: 'Quote-footer-middleware'
        };

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
            'When I give food to the poor, they call me a saint. When I ask why the poor have no food, they call me a communist. ― Hélder Câmara'
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
        return [FooterAttacher];
    }//if(quotesenabled)
    return [];
};//module.exports;
