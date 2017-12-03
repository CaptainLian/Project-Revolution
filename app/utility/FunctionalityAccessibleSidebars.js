'use strict';

const FUNCTIONALITY_SEQUENCES = require('./CONSTANTS_functionalitySequence.json');

/**
 * An object containing the functionality sequence as a key
 * and the value as an array which contains objects that describe sidebars
 * the functionality has and should display
 * @type {Object}
 */
const functionalitySidebars = Object.create(null);

//View Project Head Dashboard
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ViewProjectHeadDashboard] = [{
    name: 'Project Head Dashboard',
    link: '/Organization/ProjectHead/home'
}];

//View APSReport
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ViewAPSReport] = [{
    name: 'APS Report',
    link: '/Organization/APSReport'
}];

//Evaluate GOSM
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateGOSM] = [{
    name: 'View GOSM Submissions',
    link: '/APS/viewOrglist'
}];

//Evaluate PPR
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateProjectProposal] = [{
    name: 'Evaluate Project Proposals',
    link: '/APS/activityChecking'
}];

//Evaluate Activity (AMT)
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateActivity_AMT] = [{
    name: 'Evaluate Activity (AMT)',
    link: '/AMT/AssignActivity'
}];

//Evaluate Activity (OrgRes)
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateActivity_OrgRes] = [{
    name: 'Submit Activity Research Form',
    link: '/ORGRES/SubmitActivityResearchForm',
    sublinks: [

    ]
}];

//Modify Organizational Structure
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ModifyOrganizationalStructure] = [{
    name: 'Modify Organizational Structure',
    link: '/Organization/Setting/ACL'
}, {
    name: 'Organization Officers',
    link: '/Organization/Officers'
}];

//View Publicities for Activity
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ViewPublicityMaterial] = [{
    name: 'View Activity Publicities',
    link: '/PNP/ViewPubs'
}];

//Submit Publicities for Activity
functionalitySidebars[FUNCTIONALITY_SEQUENCES.SubmitPublicityMaterial] = [{
    name: 'Submit Activity Publicity',
    //TODO: actual URL
    link: '/blank'
}];

//Evaluate Publicities for Activity
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluatePublicityMaterial] = [{
    name: 'Evaluate Publicity Submissions',
    link: '/PNP/Pubs/List'
}];

//Evaluate Post Project
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluatePostProject] = [{
    name: 'Post Project',
    link: '/ADM/Activity/List'
}];

const accessibleRoutes = [];
for(const functionality in functionalitySidebars){
    for(const sidebar of functionalitySidebars[functionality]){
        //push to array
        accessibleRoutes[accessibleRoutes.length] = sidebar.link;
        if(sidebar.sublinks){
            for(const link of sidebar.sublinks){
                accessibleRoutes[accessibleRoutes.length] = link;
            }
        }
    }
}
accessibleRoutes.sort();

module.exports = Object.create(null);
module.exports.functionalitySidebars = functionalitySidebars;
module.exports.accessibleRoutes = accessibleRoutes;
