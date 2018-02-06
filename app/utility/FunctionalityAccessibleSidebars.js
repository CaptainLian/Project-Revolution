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
    name: 'Dashboard',
    link: '/Organization/ProjectHead/home',
    icon:'fa fa-tachometer'
}];

//View APSReport
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ViewAPSReport] = [{
    name: 'APS Report',
    link: '/Organization/APSReport'
}];

//Evaluate GOSM
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateGOSM] = [{
    name: 'GOSM Submissions',
    link: '/APS/viewOrglist'
}];

functionalitySidebars[FUNCTIONALITY_SEQUENCES.CreateGOSM] = [{
    name: 'GOSM',
    link: '/Organization/createGOSM',
    icon: 'fa fa-columns',
    
}];

//Evaluate PPR
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateProjectProposal] = [{
    name: 'Evaluate Activity',
    link: '/APS/activityChecking',
    icon: 'fa fa-check'
}];

//Evaluate Activity (AMT)
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateActivity_AMT] = [{
    name: 'Evaluate Activity',
    link: '/AMT/AssignActivity',
    icon: 'fa fa-gavel',
    
}];

//Evaluate Activity (OrgRes)
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluateActivity_OrgRes] = [{
    name: 'Research Form',
    link: '/ORGRES/SubmitActivityResearchForm',
    icon: 'fa fa-search',
    
    sublinks: [

    ]
}];

//Modify Organizational Structure
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ModifyOrganizationalStructure] = [{
    name: 'Role Access',
    link: '/Organization/Setting/ACL',    
    icon :'fa fa-key'
}, {
    name: 'User Account',
    link: '/ORGRES/Manage/Account',
    icon :'fa fa-group'


}];

//View Publicities for Activity
functionalitySidebars[FUNCTIONALITY_SEQUENCES.ViewPublicityMaterial] = [{
    name: 'Publicity Materials',
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
    name: 'Evaluate Pubs',
    link: '/PNP/Pubs/List',
    icon: 'fa fa-check'
}];

//Evaluate Post Project
//NOTE experimental code
functionalitySidebars[FUNCTIONALITY_SEQUENCES.EvaluatePostProject] = [constructSidebar(
        'Post ProjectHead',
        '/ADM/Activity/List'
)];

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


/**
 * [constructSidebar description]
 * @method   constructSidebar
 * @param    {String}                            name      [description]
 * @param    {String}                            link      [description]
 * @param    {String}                            icon      [description]
 * @param    {[Array(String)] Optional}          sublinks  [description]
 * @returns  {Object}                                      [description]
 */
function constructSidebar(name, link, icon, sublinks){
    const sidebar = Object.create(null);

    sidebar.name = name;
    sidebar.link = link;
    sidebar.icon = icon;
    sidebar.sublinks = sublinks;

    return sidebar;
}