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
        let quotes = null;

        if('communist' === configuration.webserver.easter_eggs.quotes_type){
            logger.warn('Adding communist and marxist quotes', log_options);

            quotes = [
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
        }else if('john_de_la_salle' === configuration.webserver.easter_eggs.quotes_type){
            logger.info('Adding St John Baptist La Salle', log_options);

            quotes = [
                'Remembering that God is with you will help and inspire you in all that you do. ― St John Baptiste De La Salle',
                'Often remind yourself that you are in the presence of God. ― St John Baptiste De La Salle',
                'Remembering that God is with you will help and inspire you in all that you do. ― St John Baptiste De La Salle',
                'Often remind yourself that you are in the presence of God. ― St John Baptiste De La Salle',
                'Prepare a path for God so that he can enter your heart. ― St John Baptiste De La Salle',
                'Follow the inspirations that come to you from God. ― St John Baptiste De La Salle',
                'May God continue what he has started in you. ― St John Baptiste De La Salle',
                'You have received talents and graces from God. ― St John Baptiste De La Salle',
                'God has given you so many graces. ― St John Baptiste De La Salle',
                'God has chosen you to do His work. ― St John Baptiste De La Salle',
                'God has chosen you to make him known to others. ― St John Baptiste De La Salle',
                'God entrusts you with the care of the young. ― St John Baptiste De La Salle',
                'Young people need good teachers, like visible angels. ― St John Baptiste De La Salle',
                'Young people need the light of watchful guides to lead them on the path of salvation ― St John Baptiste De La Salle',
                'Thank God for the grace He has given you in your work. ― St John Baptiste De La Salle',
                'The more you devote yourself in prayer the more you will do well in your work. ― St John Baptiste De La Salle',
                'Lift up your hands to heaven to draw down God’s blessing on those you are guiding. ― St John Baptiste De La Salle',
                'Often ask God for the grace to touch hearts. ― St John Baptiste De La Salle',
                'Preach by example, and practice before the eyes of the young what you wish them to accept. ― St John Baptiste De La Salle',
                'Your faith should be a shining light for those whom you teach. ― St John Baptiste De La Salle',
                'In the light of faith you see things quite differently. ― St John Baptiste De La Salle',
                'God’s would is powerful in touching hearts. ― St John Baptiste De La Salle',
                'Live by the spirit of faith. ― St John Baptiste De La Salle',
                'Receive Jesus today with respect and thanks giving. ― St John Baptiste De La Salle',
                'Think of what a blessing it is that the Holy Spirit lives in you. ― St John Baptiste De La Salle',
                'Don’t be discouraged by anxieties and troubles, life is full of them. ― St John Baptiste De La Salle',
                'You can do more with the grace of God than you think. ― St John Baptiste De La Salle',
                'Do not have any anxiety about the future.Leave everything in God’s hands for he will take care of you. ― St John Baptiste De La Salle',
                'Throw yourself in God’s arm. He will carry you when the road is rough. ― St John Baptiste De La Salle',
                'God’s compassion for you is greater than the troubles you have. ― St John Baptiste De La Salle',
                'Leave the results in God’s hands. ― St John Baptiste De La Salle',
                'It is impossible to please God if you do not live on friendly terms with others. ― St John Baptiste De La Salle',
                'Put up with the faults of others and be generous towards them.',
                'Never speak to anyone except with kindness. ― St John Baptiste De La Salle',
                'Inspire and lead others by encouraging them. ― St John Baptiste De La Salle',
                'Look upon those whom God has entrusted to you as His own children. ― St John Baptiste De La Salle',
                'Your students are living images of Jesus. ― St John Baptiste De La Salle',
                'How to correct others depend on knowledge  and discernment of character. ― St John Baptiste De La Salle',
                'Take care not to let yourself be carried away by impatience in class. ― St John Baptiste De La Salle',
                'You can perform miracles by touching the hearts of those entrusted to your care. ― St John Baptiste De La Salle',
                'God expects you to touch hearts. ― St John Baptiste De La Salle',
                'God of love, set me aflame with love for you and for my neighbour. ― St John Baptiste De La Salle'
            ];
        }else{
            logger.debug('No quotes attached', log_options);
        }

        
        if(quotes){
            logger.info('Adding footer middleware', log_options);
            const FooterAttacher = Object.create(null);
            FooterAttacher.name = 'Quote-footer-middleware';
            FooterAttacher.priority = configuration.load_priority.LOW;
            FooterAttacher.action = (req, res, next) => {
                if(req.method === 'GET' && req.extra_data.system.sidebars.canAttach){
                    logger.debug(`Attaching footer data`, log_options);
                    req.extra_data.view.footer = quotes[Math.floor(Math.random() * (quotes.length))];
                    logger.debug(`Chosen quote: ${req.extra_data.view.footer}`, log_options);
                }//method === 'GET'

                return next();
            };//FooterAttacher.action

            middlewares[middlewares.length] = FooterAttacher;
        }//if(quotes)
    }//if(quotesenabled)

    return middlewares;
};
