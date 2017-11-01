'use strict';

const FUNCTIONALITY_SEQUENCES = require('./CONSTANTS_functionalitySequence.json');

/**
 * An object containing the functionality sequence as a key
 * and the value as an array which contains objects that describe sidebars
 * the functionality has and should display
 * @type {Object}
 */
const functionalitySidebars = {};

functionalitySidebars[FUNCTIONALITY_SEQUENCES.CreateGOSM] = [{
    name: 'Submit GOSM',
    link: '/Organization/createGOSM'
}];

functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateGOSM] = [{
    name: 'View GOSM Submissions',
    link: '/APS/viewOrglist'
}];

const accessibleRoutes = [];

for(const functionality in functionalitySidebars){
    for(const sidebar of functionalitySidebars[functionality]){
        //push to array
        accessibleRoutes[accessibleRoutes.length] = sidebar.link;
    }
}
accessibleRoutes.sort();


module.exports = Object.create(null);
module.exports.functionalitySidebars = functionalitySidebars;
module.exports.accessibleRoutes = accessibleRoutes;
