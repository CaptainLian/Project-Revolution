--
-- PostgreSQL database dump
--

-- Dumped from database version 10.3
-- Dumped by pg_dump version 10.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.term DROP CONSTRAINT term_schoolyearid_fkey;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_status_fkey;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_nature_fkey;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_college_fkey;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_cluster_fkey;
ALTER TABLE ONLY public.projectproposalsourcefunds DROP CONSTRAINT projectproposalsourcefunds_projectproposal_fkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT projectproposalsignatory_type_fkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT projectproposalsignatory_status_fkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT projectproposalsignatory_signatory_fkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT projectproposalsignatory_gosmactivity_fkey;
ALTER TABLE ONLY public.projectproposalprojectedincome DROP CONSTRAINT projectproposalprojectedincome_projectproposal_fkey;
ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge DROP CONSTRAINT projectproposalprogramdesignpersonincharge_projecthead_fkey;
ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge DROP CONSTRAINT projectproposalprogramdesignpersonincharge_programdesign_fkey;
ALTER TABLE ONLY public.projectproposalprogramdesign DROP CONSTRAINT projectproposalprogramdesign_projectproposal_fkey;
ALTER TABLE ONLY public.projectproposalprogramdesign DROP CONSTRAINT projectproposalprogramdesign_personincharge_fkey;
ALTER TABLE ONLY public.projectproposalexpenses DROP CONSTRAINT projectproposalexpenses_type_fkey;
ALTER TABLE ONLY public.projectproposalexpenses DROP CONSTRAINT projectproposalexpenses_projectproposal_fkey;
ALTER TABLE ONLY public.projectproposalattachment DROP CONSTRAINT projectproposalattachment_requirement_fkey;
ALTER TABLE ONLY public.projectproposalattachment DROP CONSTRAINT projectproposalattachment_projectproposal_fkey;
ALTER TABLE ONLY public.projectproposalattachment DROP CONSTRAINT projectproposalattachment_idnumber_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_venuecreated_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_venue_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_status_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_reschedulereason_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_preparedby_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_gosmactivity_fkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_facultyadviser_fkey;
ALTER TABLE ONLY public.preactivityattachmentrequirement DROP CONSTRAINT preactivityattachmentrequirement_documentattachmentrequirement_;
ALTER TABLE ONLY public.preactivityattachmentrequirement DROP CONSTRAINT preactivityattachmentrequirement_activitytype_fkey;
ALTER TABLE ONLY public.postactivityattachmentrequirement DROP CONSTRAINT postactivityattachmentrequirement_documentattachmentrequirement;
ALTER TABLE ONLY public.postactivityattachmentrequirement DROP CONSTRAINT postactivityattachmentrequirement_activitytype_fkey;
ALTER TABLE ONLY public.organizationrole DROP CONSTRAINT organizationrole_organization_fkey;
ALTER TABLE ONLY public.organizationrole DROP CONSTRAINT organizationrole_masterrole_fkey;
ALTER TABLE ONLY public.organizationofficer DROP CONSTRAINT organizationofficer_yearid_fkey;
ALTER TABLE ONLY public.organizationofficer DROP CONSTRAINT organizationofficer_role_fkey;
ALTER TABLE ONLY public.organizationofficer DROP CONSTRAINT organizationofficer_idnumber_fkey;
ALTER TABLE ONLY public.organizationfacultyadviser DROP CONSTRAINT organizationfacultyadviser_yearid_fkey;
ALTER TABLE ONLY public.organizationfacultyadviser DROP CONSTRAINT organizationfacultyadviser_organization_fkey;
ALTER TABLE ONLY public.organizationfacultyadviser DROP CONSTRAINT organizationfacultyadviser_faculty_fkey;
ALTER TABLE ONLY public.organizationaccesscontrol DROP CONSTRAINT organizationaccesscontrol_role_fkey;
ALTER TABLE ONLY public.organizationaccesscontrol DROP CONSTRAINT organizationaccesscontrol_functionality_fkey;
ALTER TABLE ONLY public.gosmactivityprojecthead DROP CONSTRAINT gosmactivityprojecthead_idnumber_fkey;
ALTER TABLE ONLY public.gosmactivityprojecthead DROP CONSTRAINT gosmactivityprojecthead_activityid_fkey;
ALTER TABLE ONLY public.gosmactivity DROP CONSTRAINT gosmactivity_gosm_fkey;
ALTER TABLE ONLY public.gosmactivity DROP CONSTRAINT gosmactivity_activitytype_fkey;
ALTER TABLE ONLY public.gosmactivity DROP CONSTRAINT gosmactivity_activitynature_fkey;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_studentorganization_fkey;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_statusevaluator_fkey;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_status_fkey;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_preparedby_fkey;
ALTER TABLE ONLY public.functionalitycategory DROP CONSTRAINT functionalitycategory_domain_fkey;
ALTER TABLE ONLY public.functionality DROP CONSTRAINT functionality_category_fkey;
ALTER TABLE ONLY public.amtactivityevaluation DROP CONSTRAINT amtactivityevaluation_status_fkey;
ALTER TABLE ONLY public.amtactivityevaluation DROP CONSTRAINT amtactivityevaluation_evaluator_fkey;
ALTER TABLE ONLY public.amtactivityevaluation DROP CONSTRAINT amtactivityevaluation_activity_fkey;
ALTER TABLE ONLY public.activityattachmentrequirement DROP CONSTRAINT activityattachmentrequirement_attachment_fkey;
ALTER TABLE ONLY public.activityattachmentrequirement DROP CONSTRAINT activityattachmentrequirement_activitytype_fkey;
ALTER TABLE ONLY public.account DROP CONSTRAINT account_type_fkey;
ALTER TABLE ONLY public.account DROP CONSTRAINT account_status_fkey;
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_submittedBy_fkey";
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_status_fkey";
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_evaluatedBy_fkey";
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_GOSMActivity_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "PreActivityDirectPaymentSignatory_type_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "PreActivityDirectPaymentSignatory_status_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "PreActivityDirectPaymentSignatory_signatory_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "PreActivityDirectPaymentSignatory_directPayment_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentParticular" DROP CONSTRAINT "PreActivityDirectPaymentParticular_particular_fkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentParticular" DROP CONSTRAINT "PreActivityDirectPaymentParticular_directPayment_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_submittedBy_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_status_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_evaluatedBy_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_GOSMActivity_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "PreActivityCashAdvanceSignatory_type_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "PreActivityCashAdvanceSignatory_status_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "PreActivityCashAdvanceSignatory_signatory_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "PreActivityCashAdvanceSignatory_cashAdvance_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceParticular" DROP CONSTRAINT "PreActivityCashAdvanceParticular_particular_fkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceParticular" DROP CONSTRAINT "PreActivityCashAdvanceParticular_cashAdvance_fkey";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_submittedBy_fkey";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_status_fkey";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_establishment_fkey";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_GOSMActivity_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_type_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_status_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_signatory_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_bookTransfer_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferParticular" DROP CONSTRAINT "PreActivityBookTransferParticular_particular_fkey";
ALTER TABLE ONLY public."PreActivityBookTransferParticular" DROP CONSTRAINT "PreActivityBookTransferParticular_bookTransfer_fkey";
ALTER TABLE ONLY public."PostProjectReimbursement" DROP CONSTRAINT "PostProjectReimbursement_submittedBy_fkey";
ALTER TABLE ONLY public."PostProjectReimbursement" DROP CONSTRAINT "PostProjectReimbursement_status_fkey";
ALTER TABLE ONLY public."PostProjectReimbursement" DROP CONSTRAINT "PostProjectReimbursement_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementSignatory" DROP CONSTRAINT "PostProjectReimbursementSignatory_type_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementSignatory" DROP CONSTRAINT "PostProjectReimbursementSignatory_status_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementSignatory" DROP CONSTRAINT "PostProjectReimbursementSignatory_signatory_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementSignatory" DROP CONSTRAINT "PostProjectReimbursementSignatory_reimbursement_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementParticular" DROP CONSTRAINT "PostProjectReimbursementParticular_reimbursement_fkey";
ALTER TABLE ONLY public."PostProjectReimbursementParticular" DROP CONSTRAINT "PostProjectReimbursementParticular_particular_fkey";
ALTER TABLE ONLY public."PostProjectProposal" DROP CONSTRAINT "PostProjectProposal_status_fkey";
ALTER TABLE ONLY public."PostProjectProposal" DROP CONSTRAINT "PostProjectProposal_preparedBy_fkey";
ALTER TABLE ONLY public."PostProjectProposal" DROP CONSTRAINT "PostProjectProposal_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectProposalExpense" DROP CONSTRAINT "PostProjectProposalExpense_idNumber_fkey";
ALTER TABLE ONLY public."PostProjectProposalExpense" DROP CONSTRAINT "PostProjectProposalExpense_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectProposalEventPicture" DROP CONSTRAINT "PostProjectProposalEventPicture_idNumber_fkey";
ALTER TABLE ONLY public."PostProjectProposalEventPicture" DROP CONSTRAINT "PostProjectProposalEventPicture_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_status_fkey";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_paymentBy_fkey";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_idNumber_fkey";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectDirectPaymentParticular" DROP CONSTRAINT "PostProjectDirectPaymentParticular_particular_fkey";
ALTER TABLE ONLY public."PostProjectDirectPaymentParticular" DROP CONSTRAINT "PostProjectDirectPaymentParticular_directPayment_fkey";
ALTER TABLE ONLY public."PostProjectBookTransfer" DROP CONSTRAINT "PostProjectBookTransfer_status_fkey";
ALTER TABLE ONLY public."PostProjectBookTransfer" DROP CONSTRAINT "PostProjectBookTransfer_idNumber_fkey";
ALTER TABLE ONLY public."PostProjectBookTransfer" DROP CONSTRAINT "PostProjectBookTransfer_GOSMActivity_fkey";
ALTER TABLE ONLY public."PostProjectBookTransferParticular" DROP CONSTRAINT "PostProjectBookTransferParticular_particular_fkey";
ALTER TABLE ONLY public."PostProjectBookTransferParticular" DROP CONSTRAINT "PostProjectBookTransferParticular_bookTransfer_fkey";
ALTER TABLE ONLY public."OrganizationMember" DROP CONSTRAINT "OrganizationMember_yearID_fkey";
ALTER TABLE ONLY public."OrganizationMember" DROP CONSTRAINT "OrganizationMember_organization_fkey";
ALTER TABLE ONLY public."OfficerSurveyForm" DROP CONSTRAINT "OfficerSurveyForm_termID_fkey";
ALTER TABLE ONLY public."OfficerSurveyForm" DROP CONSTRAINT "OfficerSurveyForm_organizationID_fkey";
ALTER TABLE ONLY public."OfficerSurveyForm" DROP CONSTRAINT "OfficerSurveyForm_officer_fkey";
ALTER TABLE ONLY public."MemberSurveyForm" DROP CONSTRAINT "MemberSurveyForm_termID_fkey";
ALTER TABLE ONLY public."MemberSurveyForm" DROP CONSTRAINT "MemberSurveyForm_organizationID_fkey";
ALTER TABLE ONLY public."MemberSurveyForm" DROP CONSTRAINT "MemberSurveyForm_member_fkey";
ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement" DROP CONSTRAINT "ExpenseTypeAttachmentRequirement_expenseType_fkey";
ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement" DROP CONSTRAINT "ExpenseTypeAttachmentRequirement_document_fkey";
ALTER TABLE ONLY public."ActivityVenue" DROP CONSTRAINT "ActivityVenue_size_fkey";
ALTER TABLE ONLY public."ActivityVenue" DROP CONSTRAINT "ActivityVenue_rateType_fkey";
ALTER TABLE ONLY public."ActivityVenue" DROP CONSTRAINT "ActivityVenue_building_fkey";
ALTER TABLE ONLY public."ActivityResearchForm" DROP CONSTRAINT "ActivityResearchForm_positionInOrganization_fkey";
ALTER TABLE ONLY public."ActivityResearchForm" DROP CONSTRAINT "ActivityResearchForm_GOSMActivity_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_submittedBy_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_status_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_revisionReason_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_modeOfDistribution_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_material_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_checkedBy_fkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_GOSMActivity_fkey";
ALTER TABLE ONLY public."AccountNotification" DROP CONSTRAINT "AccountNotification_status_fkey";
ALTER TABLE ONLY public."AccountNotification" DROP CONSTRAINT "AccountNotification_account_fkey";
DROP TRIGGER before_update_projectproposal ON public.projectproposal;
DROP TRIGGER before_update_gosm_status ON public.gosm;
DROP TRIGGER before_update_functionalitycategory ON public.functionalitycategory;
DROP TRIGGER before_update_functionality ON public.functionality;
DROP TRIGGER before_update_account ON public.account;
DROP TRIGGER before_insert_term ON public.term;
DROP TRIGGER before_insert_schoolyear ON public.schoolyear;
DROP TRIGGER before_insert_projectproposalsourcefunds ON public.projectproposalsourcefunds;
DROP TRIGGER before_insert_projectproposalprojectedincome ON public.projectproposalprojectedincome;
DROP TRIGGER before_insert_projectproposalprogramdesign ON public.projectproposalprogramdesign;
DROP TRIGGER before_insert_projectproposalexpenses ON public.projectproposalexpenses;
DROP TRIGGER before_insert_organizationrole ON public.organizationrole;
DROP TRIGGER before_insert_gosmactivity ON public.gosmactivity;
DROP TRIGGER before_insert_ggosm ON public.gosm;
DROP TRIGGER before_insert_functionalitycategory ON public.functionalitycategory;
DROP TRIGGER before_insert_functionality ON public.functionality;
DROP TRIGGER before_insert_account ON public.account;
DROP TRIGGER "before_insert_ProjectProposal_id" ON public.projectproposal;
DROP TRIGGER "before_insert_ProjectProposalSignatory_id" ON public.projectproposalsignatory;
DROP TRIGGER "before_insert_ProjectProposalProgramDesign_id" ON public.projectproposalprogramdesign;
DROP TRIGGER "before_insert_ProjectProposalProgramDesignPersonInCharge_id" ON public.projectproposalprogramdesignpersonincharge;
DROP TRIGGER "before_insert_ProjectProposalExpenses_id" ON public.projectproposalexpenses;
DROP TRIGGER "before_insert_ProjectProposalAttachment_id" ON public.projectproposalattachment;
DROP TRIGGER "before_insert_PreActivityDirectPayment_sequence" ON public."PreActivityDirectPayment";
DROP TRIGGER "before_insert_PreActivityDirectPayment_id" ON public."PreActivityDirectPayment";
DROP TRIGGER "before_insert_PreActivityDirectPaymentSignatory_id" ON public."PreActivityDirectPaymentSignatory";
DROP TRIGGER "before_insert_PreActivityDirectPaymentParticular_id" ON public."PreActivityDirectPaymentParticular";
DROP TRIGGER "before_insert_PreActivityCashAdvance_sequence" ON public."PreActivityCashAdvance";
DROP TRIGGER "before_insert_PreActivityCashAdvance_id" ON public."PreActivityCashAdvance";
DROP TRIGGER "before_insert_PreActivityCashAdvanceSignatory_id" ON public."PreActivityCashAdvanceSignatory";
DROP TRIGGER "before_insert_PreActivityCashAdvanceParticular_id" ON public."PreActivityCashAdvanceParticular";
DROP TRIGGER "before_insert_PreActivityBookTransfer_id" ON public."PreActivityBookTransfer";
DROP TRIGGER "before_insert_PreActivityBookTransferSignatory_id" ON public."PreActivityBookTransferSignatory";
DROP TRIGGER "before_insert_PreActivityBookTransferParticular_id" ON public."PreActivityBookTransferParticular";
DROP TRIGGER "before_insert_PreActivityBookTransfer" ON public."PreActivityBookTransfer";
DROP TRIGGER "before_insert_PostProjectReimbursement_sequence" ON public."PostProjectReimbursement";
DROP TRIGGER "before_insert_PostProjectReimbursement_id" ON public."PostProjectReimbursement";
DROP TRIGGER "before_insert_PostProjectReimbursementSignatory_id" ON public."PostProjectReimbursementSignatory";
DROP TRIGGER "before_insert_PostProjectReimbursementParticular_id" ON public."PostProjectReimbursementParticular";
DROP TRIGGER "before_insert_PostProjectProposalExpense_sequence" ON public."PostProjectProposalExpense";
DROP TRIGGER "before_insert_PostProjectProposalExpense_id" ON public."PostProjectProposalExpense";
DROP TRIGGER "before_insert_PostProjectProposalEventPicture_sequence" ON public."PostProjectProposalEventPicture";
DROP TRIGGER "before_insert_PostProjectProposalEventPicture_id" ON public."PostProjectProposalEventPicture";
DROP TRIGGER "before_insert_PostProjectDirectPayment_sequence" ON public."PostProjectDirectPayment";
DROP TRIGGER "before_insert_PostProjectDirectPayment_id" ON public."PostProjectDirectPayment";
DROP TRIGGER "before_insert_PostProjectBookTransfer_sequence" ON public."PostProjectBookTransfer";
DROP TRIGGER "before_insert_PostProjectBookTransfer_id" ON public."PostProjectBookTransfer";
DROP TRIGGER "before_insert_OrganizationMember_id" ON public."OrganizationMember";
DROP TRIGGER "before_insert_OrganizationFacultyAdviser_id" ON public.organizationfacultyadviser;
DROP TRIGGER "before_insert_MemberSurveyForm_id" ON public."MemberSurveyForm";
DROP TRIGGER "before_insert_GOSMActivity_id" ON public.gosmactivity;
DROP TRIGGER "before_insert_ActivityResearchForm_sequence" ON public."ActivityResearchForm";
DROP TRIGGER "before_insert_ActivityPublicity_sequence" ON public."ActivityPublicity";
DROP TRIGGER "before_insert_ActivityPublicity_id" ON public."ActivityPublicity";
DROP TRIGGER "before_insert_AccountNotification_id" ON public."AccountNotification";
DROP TRIGGER "before_insert_AccountNotification" ON public."AccountNotification";
DROP TRIGGER after_update_gosm_studentorganization ON public.gosm;
DROP TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior" ON public.projectproposal;
DROP TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser" ON public.projectproposal;
DROP TRIGGER "after_update_ProjectProposalSignatory_completion" ON public.projectproposalsignatory;
DROP TRIGGER "after_update_ProjectProposalSignatory_PendCounter" ON public.projectproposalsignatory;
DROP TRIGGER "after_update_PreActivityReimbursementSignatory_completion" ON public."PostProjectReimbursementSignatory";
DROP TRIGGER "after_update_PreActivityCashAdvanceSignatory_completion" ON public."PreActivityCashAdvanceSignatory";
DROP TRIGGER "after_update_PreActivityBookTransferSignatory_completion" ON public."PreActivityBookTransferSignatory";
DROP TRIGGER "after_insert_StudentOrganization_ACL" ON public.studentorganization;
DROP TRIGGER "after_insert_ProjectProposal_signatories" ON public.projectproposal;
DROP TRIGGER "after_insert_ProjectProposalProgramDesign" ON public.projectproposalprogramdesign;
DROP TRIGGER "after_insert_PreActivityReimbursementParticular_signatories" ON public."PostProjectReimbursementParticular";
DROP TRIGGER "after_insert_PreActivityDirectPayment_signatories" ON public."PreActivityDirectPayment";
DROP TRIGGER "after_insert_PreActivityDirectPaymentParticular_signatories" ON public."PreActivityDirectPaymentParticular";
DROP TRIGGER "after_insert_PreActivityCashAdvance_signatories" ON public."PreActivityCashAdvance";
DROP TRIGGER "after_insert_PreActivityCashAdvanceParticular_signatories" ON public."PreActivityCashAdvanceParticular";
DROP TRIGGER "after_insert_PreActivityBookTransfer_signatories" ON public."PreActivityBookTransfer";
DROP TRIGGER "after_insert_PreActivityBookTransferParticular_signatories" ON public."PreActivityBookTransferParticular";
DROP TRIGGER "after_insert_PostProjectReimbursement_signatories" ON public."PostProjectReimbursement";
DROP TRIGGER "after_delete_PreActivityCashAdvanceParticular_signatories" ON public."PreActivityCashAdvanceParticular";
ALTER TABLE ONLY public.term DROP CONSTRAINT term_pkey;
ALTER TABLE ONLY public.term DROP CONSTRAINT term_id_key;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_pkey;
ALTER TABLE ONLY public.studentorganization DROP CONSTRAINT studentorganization_acronym_key;
ALTER TABLE ONLY public.signatorytype DROP CONSTRAINT signatorytype_pkey;
ALTER TABLE ONLY public.signatorystatus DROP CONSTRAINT signatorystatus_pkey;
ALTER TABLE ONLY public.session DROP CONSTRAINT session_pkey;
ALTER TABLE ONLY public.schoolyear DROP CONSTRAINT schoolyear_pkey;
ALTER TABLE ONLY public.schoolyear DROP CONSTRAINT schoolyear_id_key;
ALTER TABLE ONLY public.projectproposalstatus DROP CONSTRAINT projectproposalstatus_pkey;
ALTER TABLE ONLY public.projectproposalsourcefunds DROP CONSTRAINT projectproposalsourcefunds_pkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT projectproposalsignatory_id_key;
ALTER TABLE ONLY public.projectproposalreschedulereason DROP CONSTRAINT projectproposalreschedulereason_pkey;
ALTER TABLE ONLY public.projectproposalprojectedincome DROP CONSTRAINT projectproposalprojectedincome_pkey;
ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge DROP CONSTRAINT projectproposalprogramdesignpersonincharge_pkey;
ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge DROP CONSTRAINT projectproposalprogramdesignpersonincharge_id_key;
ALTER TABLE ONLY public.projectproposalprogramdesign DROP CONSTRAINT projectproposalprogramdesign_pkey;
ALTER TABLE ONLY public.projectproposalprogramdesign DROP CONSTRAINT projectproposalprogramdesign_id_key;
ALTER TABLE ONLY public.projectproposalexpenses DROP CONSTRAINT projectproposalexpenses_pkey;
ALTER TABLE ONLY public.projectproposalexpenses DROP CONSTRAINT projectproposalexpenses_id_key;
ALTER TABLE ONLY public.projectproposalattachment DROP CONSTRAINT projectproposalattachment_pkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_pkey;
ALTER TABLE ONLY public.projectproposal DROP CONSTRAINT projectproposal_id_key;
ALTER TABLE ONLY public.preactivityattachmentrequirement DROP CONSTRAINT preactivityattachmentrequirement_pkey;
ALTER TABLE ONLY public.postactivityattachmentrequirement DROP CONSTRAINT postactivityattachmentrequirement_pkey;
ALTER TABLE ONLY public.projectproposalsignatory DROP CONSTRAINT "pk_ProjectProposalSignatory";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "pk_PreActivityDirectPaymentSignatory";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "pk_PreActivityCashAdvanceSignatory";
ALTER TABLE ONLY public.organizationstatus DROP CONSTRAINT organizationstatus_pkey;
ALTER TABLE ONLY public.organizationrole DROP CONSTRAINT organizationrole_pkey;
ALTER TABLE ONLY public.organizationrole DROP CONSTRAINT organizationrole_id_key;
ALTER TABLE ONLY public.organizationofficer DROP CONSTRAINT organizationofficer_pkey;
ALTER TABLE ONLY public.organizationnature DROP CONSTRAINT organizationnature_pkey;
ALTER TABLE ONLY public.organizationfacultyadviser DROP CONSTRAINT organizationfacultyadviser_pkey;
ALTER TABLE ONLY public.organizationfacultyadviser DROP CONSTRAINT organizationfacultyadviser_id_key;
ALTER TABLE ONLY public.organizationcluster DROP CONSTRAINT organizationcluster_pkey;
ALTER TABLE ONLY public.organizationaccesscontrol DROP CONSTRAINT organizationaccesscontrol_pkey;
ALTER TABLE ONLY public.gosmstatus DROP CONSTRAINT gosmstatus_pkey;
ALTER TABLE ONLY public.gosmactivityprojecthead DROP CONSTRAINT gosmactivityprojecthead_pkey;
ALTER TABLE ONLY public.gosmactivity DROP CONSTRAINT gosmactivity_pkey;
ALTER TABLE ONLY public.gosmactivity DROP CONSTRAINT gosmactivity_id_key;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_pkey;
ALTER TABLE ONLY public.gosm DROP CONSTRAINT gosm_id_key;
ALTER TABLE ONLY public.functionalitydomain DROP CONSTRAINT functionalitydomain_pkey;
ALTER TABLE ONLY public.functionalitycategory DROP CONSTRAINT functionalitycategory_pkey;
ALTER TABLE ONLY public.functionality DROP CONSTRAINT functionality_pkey;
ALTER TABLE ONLY public.expensetype DROP CONSTRAINT expensetype_pkey;
ALTER TABLE ONLY public.documentattachmentrequirement DROP CONSTRAINT documentattachmentrequirement_pkey;
ALTER TABLE ONLY public.college DROP CONSTRAINT college_pkey;
ALTER TABLE ONLY public.amtactivityevaluationstatus DROP CONSTRAINT amtactivityevaluationstatus_pkey;
ALTER TABLE ONLY public.amtactivityevaluation DROP CONSTRAINT amtactivityevaluation_pkey;
ALTER TABLE ONLY public.activitytype DROP CONSTRAINT activitytype_pkey;
ALTER TABLE ONLY public.activitynature DROP CONSTRAINT activitynature_pkey;
ALTER TABLE ONLY public.activityattachmentrequirement DROP CONSTRAINT activityattachmentrequirement_pkey;
ALTER TABLE ONLY public.accounttype DROP CONSTRAINT accounttype_pkey;
ALTER TABLE ONLY public.account DROP CONSTRAINT account_pkey;
ALTER TABLE ONLY public.account DROP CONSTRAINT account_email_key;
ALTER TABLE ONLY public."VenueSize" DROP CONSTRAINT "VenueSize_pkey";
ALTER TABLE ONLY public."SystemConfiguration" DROP CONSTRAINT "SystemConfiguration_pkey";
ALTER TABLE ONLY public."RateType" DROP CONSTRAINT "RateType_pkey";
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_pkey";
ALTER TABLE ONLY public."PreActivityDirectPayment" DROP CONSTRAINT "PreActivityDirectPayment_id_key";
ALTER TABLE ONLY public."PreActivityDirectPaymentStatus" DROP CONSTRAINT "PreActivityDirectPaymentStatus_pkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory" DROP CONSTRAINT "PreActivityDirectPaymentSignatory_id_key";
ALTER TABLE ONLY public."PreActivityDirectPaymentParticular" DROP CONSTRAINT "PreActivityDirectPaymentParticular_pkey";
ALTER TABLE ONLY public."PreActivityDirectPaymentParticular" DROP CONSTRAINT "PreActivityDirectPaymentParticular_id_key";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_pkey";
ALTER TABLE ONLY public."PreActivityCashAdvance" DROP CONSTRAINT "PreActivityCashAdvance_id_key";
ALTER TABLE ONLY public."PreActivityCashAdvanceStatus" DROP CONSTRAINT "PreActivityCashAdvanceStatus_pkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory" DROP CONSTRAINT "PreActivityCashAdvanceSignatory_id_key";
ALTER TABLE ONLY public."PreActivityCashAdvanceParticular" DROP CONSTRAINT "PreActivityCashAdvanceParticular_pkey";
ALTER TABLE ONLY public."PreActivityCashAdvanceParticular" DROP CONSTRAINT "PreActivityCashAdvanceParticular_id_key";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_pkey";
ALTER TABLE ONLY public."PreActivityBookTransfer" DROP CONSTRAINT "PreActivityBookTransfer_id_key";
ALTER TABLE ONLY public."PreActivityBookTransferStatus" DROP CONSTRAINT "PreActivityBookTransferStatus_pkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_pkey";
ALTER TABLE ONLY public."PreActivityBookTransferSignatory" DROP CONSTRAINT "PreActivityBookTransferSignatory_id_key";
ALTER TABLE ONLY public."PreActivityBookTransferParticular" DROP CONSTRAINT "PreActivityBookTransferParticular_pkey";
ALTER TABLE ONLY public."PreActivityBookTransferParticular" DROP CONSTRAINT "PreActivityBookTransferParticular_id_key";
ALTER TABLE ONLY public."PostProjectReimbursement" DROP CONSTRAINT "PostProjectReimbursement_pkey";
ALTER TABLE ONLY public."PostProjectReimbursement" DROP CONSTRAINT "PostProjectReimbursement_id_key";
ALTER TABLE ONLY public."PostProjectReimbursementStatus" DROP CONSTRAINT "PostProjectReimbursementStatus_pkey";
ALTER TABLE ONLY public."PostProjectReimbursementSignatory" DROP CONSTRAINT "PostProjectReimbursementSignatory_id_key";
ALTER TABLE ONLY public."PostProjectReimbursementPayment" DROP CONSTRAINT "PostProjectReimbursementPayment_pkey";
ALTER TABLE ONLY public."PostProjectReimbursementParticular" DROP CONSTRAINT "PostProjectReimbursementParticular_pkey";
ALTER TABLE ONLY public."PostProjectReimbursementParticular" DROP CONSTRAINT "PostProjectReimbursementParticular_id_key";
ALTER TABLE ONLY public."PostProjectProposal" DROP CONSTRAINT "PostProjectProposal_pkey";
ALTER TABLE ONLY public."PostProjectProposalStatus" DROP CONSTRAINT "PostProjectProposalStatus_pkey";
ALTER TABLE ONLY public."PostProjectProposalExpense" DROP CONSTRAINT "PostProjectProposalExpense_pkey";
ALTER TABLE ONLY public."PostProjectProposalExpense" DROP CONSTRAINT "PostProjectProposalExpense_id_key";
ALTER TABLE ONLY public."PostProjectProposalEventPicture" DROP CONSTRAINT "PostProjectProposalEventPicture_pkey";
ALTER TABLE ONLY public."PostProjectProposalEventPicture" DROP CONSTRAINT "PostProjectProposalEventPicture_id_key";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_pkey";
ALTER TABLE ONLY public."PostProjectDirectPayment" DROP CONSTRAINT "PostProjectDirectPayment_id_key";
ALTER TABLE ONLY public."PostProjectDirectPaymentStatus" DROP CONSTRAINT "PostProjectDirectPaymentStatus_pkey";
ALTER TABLE ONLY public."PostProjectDirectPaymentPayment" DROP CONSTRAINT "PostProjectDirectPaymentPayment_pkey";
ALTER TABLE ONLY public."PostProjectDirectPaymentParticular" DROP CONSTRAINT "PostProjectDirectPaymentParticular_pkey";
ALTER TABLE ONLY public."PostProjectBookTransfer" DROP CONSTRAINT "PostProjectBookTransfer_pkey";
ALTER TABLE ONLY public."PostProjectBookTransfer" DROP CONSTRAINT "PostProjectBookTransfer_id_key";
ALTER TABLE ONLY public."PostProjectBookTransferStatus" DROP CONSTRAINT "PostProjectBookTransferStatus_pkey";
ALTER TABLE ONLY public."PostProjectBookTransferParticular" DROP CONSTRAINT "PostProjectBookTransferParticular_pkey";
ALTER TABLE ONLY public."OrganizationMember" DROP CONSTRAINT "OrganizationMember_pkey";
ALTER TABLE ONLY public."OrganizationMember" DROP CONSTRAINT "OrganizationMember_id_key";
ALTER TABLE ONLY public."OfficerSurveyForm" DROP CONSTRAINT "OfficerSurveyForm_pkey";
ALTER TABLE ONLY public."OfficerSurveyForm" DROP CONSTRAINT "OfficerSurveyForm_id_key";
ALTER TABLE ONLY public."MemberSurveyForm" DROP CONSTRAINT "MemberSurveyForm_pkey";
ALTER TABLE ONLY public."MemberSurveyForm" DROP CONSTRAINT "MemberSurveyForm_id_key";
ALTER TABLE ONLY public."FinanceSignatoryType" DROP CONSTRAINT "FinanceSignatoryType_pkey";
ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement" DROP CONSTRAINT "ExpenseTypeAttachmentRequirement_pkey";
ALTER TABLE ONLY public."Building" DROP CONSTRAINT "Building_pkey";
ALTER TABLE ONLY public."BookTransferEstablishment" DROP CONSTRAINT "BookTransferEstablishment_pkey";
ALTER TABLE ONLY public."ActivityVenue" DROP CONSTRAINT "ActivityVenue_pkey";
ALTER TABLE ONLY public."ActivityResearchForm" DROP CONSTRAINT "ActivityResearchForm_pkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_pkey";
ALTER TABLE ONLY public."ActivityPublicity" DROP CONSTRAINT "ActivityPublicity_id_key";
ALTER TABLE ONLY public."ActivityPublicityStatus" DROP CONSTRAINT "ActivityPublicityStatus_pkey";
ALTER TABLE ONLY public."ActivityPublicityRevisionReason" DROP CONSTRAINT "ActivityPublicityRevisionReason_pkey";
ALTER TABLE ONLY public."ActivityPublicityModeOfDistribution" DROP CONSTRAINT "ActivityPublicityModeOfDistribution_pkey";
ALTER TABLE ONLY public."ActivityPublicityMaterial" DROP CONSTRAINT "ActivityPublicityMaterial_pkey";
ALTER TABLE ONLY public."AccountStatus" DROP CONSTRAINT "AccountStatus_pkey";
ALTER TABLE ONLY public."AccountNotification" DROP CONSTRAINT "AccountNotification_pkey";
ALTER TABLE ONLY public."AccountNotification" DROP CONSTRAINT "AccountNotification_id_key";
ALTER TABLE ONLY public."AccountNotificationStatus" DROP CONSTRAINT "AccountNotificationStatus_pkey";
ALTER TABLE ONLY public."ARFOrganizationPosition" DROP CONSTRAINT "ARFOrganizationPosition_pkey";
ALTER TABLE public.preactivityattachmentrequirement ALTER COLUMN optional DROP DEFAULT;
ALTER TABLE public.preactivityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.postactivityattachmentrequirement ALTER COLUMN optional DROP DEFAULT;
ALTER TABLE public.postactivityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.activityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.term;
DROP TABLE public.studentorganization;
DROP TABLE public.signatorytype;
DROP TABLE public.signatorystatus;
DROP TABLE public.session;
DROP TABLE public.schoolyear;
DROP TABLE public.projectproposalstatus;
DROP TABLE public.projectproposalsourcefunds;
DROP TABLE public.projectproposalsignatory;
DROP TABLE public.projectproposalreschedulereason;
DROP TABLE public.projectproposalprojectedincome;
DROP TABLE public.projectproposalprogramdesignpersonincharge;
DROP TABLE public.projectproposalprogramdesign;
DROP TABLE public.projectproposalattachment;
DROP TABLE public.projectproposal;
DROP TABLE public.preactivityattachmentrequirement;
DROP TABLE public.postactivityattachmentrequirement;
DROP TABLE public.organizationstatus;
DROP TABLE public.organizationrole;
DROP TABLE public.organizationofficer;
DROP TABLE public.organizationnature;
DROP TABLE public.organizationfacultyadviser;
DROP TABLE public.organizationcluster;
DROP TABLE public.organizationaccesscontrol;
DROP TABLE public.gosmstatus;
DROP TABLE public.gosmactivityprojecthead;
DROP TABLE public.gosmactivity;
DROP TABLE public.gosm;
DROP TABLE public.functionalitydomain;
DROP TABLE public.functionalitycategory;
DROP TABLE public.functionality;
DROP TABLE public.expensetype;
DROP TABLE public.documentattachmentrequirement;
DROP TABLE public.college;
DROP TABLE public.amtactivityevaluationstatus;
DROP TABLE public.amtactivityevaluation;
DROP TABLE public.activitytype;
DROP TABLE public.activitynature;
DROP SEQUENCE public.activityattachmentrequirement_id_seq;
DROP TABLE public.activityattachmentrequirement;
DROP TABLE public.accounttype;
DROP TABLE public.account;
DROP TABLE public."VenueSize";
DROP TABLE public."SystemConfiguration";
DROP TABLE public."RateType";
DROP VIEW public."ProjectExpensesWithoutTransaction";
DROP TABLE public.projectproposalexpenses;
DROP TABLE public."PreActivityDirectPaymentStatus";
DROP TABLE public."PreActivityDirectPaymentSignatory";
DROP TABLE public."PreActivityDirectPaymentParticular";
DROP TABLE public."PreActivityDirectPayment";
DROP TABLE public."PreActivityCashAdvanceStatus";
DROP TABLE public."PreActivityCashAdvanceSignatory";
DROP TABLE public."PreActivityCashAdvanceParticular";
DROP TABLE public."PreActivityCashAdvance";
DROP TABLE public."PreActivityBookTransferStatus";
DROP TABLE public."PreActivityBookTransferSignatory";
DROP TABLE public."PreActivityBookTransferParticular";
DROP TABLE public."PreActivityBookTransfer";
DROP TABLE public."PostProjectReimbursementStatus";
DROP TABLE public."PostProjectReimbursementSignatory";
DROP TABLE public."PostProjectReimbursementPayment";
DROP TABLE public."PostProjectReimbursementParticular";
DROP TABLE public."PostProjectReimbursement";
DROP TABLE public."PostProjectProposalStatus";
DROP TABLE public."PostProjectProposalExpense";
DROP TABLE public."PostProjectProposalEventPicture";
DROP TABLE public."PostProjectProposal";
DROP TABLE public."PostProjectDirectPaymentStatus";
DROP TABLE public."PostProjectDirectPaymentPayment";
DROP TABLE public."PostProjectDirectPaymentParticular";
DROP TABLE public."PostProjectDirectPayment";
DROP TABLE public."PostProjectBookTransferStatus";
DROP TABLE public."PostProjectBookTransferParticular";
DROP TABLE public."PostProjectBookTransfer";
DROP TABLE public."OrganizationMember";
DROP TABLE public."OfficerSurveyForm";
DROP TABLE public."MemberSurveyForm";
DROP TABLE public."FinanceSignatoryType";
DROP TABLE public."ExpenseTypeAttachmentRequirement";
DROP TABLE public."Building";
DROP TABLE public."BookTransferEstablishment";
DROP TABLE public."ActivityVenue";
DROP TABLE public."ActivityResearchForm";
DROP TABLE public."ActivityPublicityStatus";
DROP TABLE public."ActivityPublicityRevisionReason";
DROP TABLE public."ActivityPublicityModeOfDistribution";
DROP TABLE public."ActivityPublicityMaterial";
DROP TABLE public."ActivityPublicity";
DROP TABLE public."AccountStatus";
DROP TABLE public."AccountNotificationStatus";
DROP TABLE public."AccountNotification";
DROP TABLE public."ARFOrganizationPosition";
DROP FUNCTION public.trigger_before_update_projectproposal();
DROP FUNCTION public.trigger_before_update_gosm_status();
DROP FUNCTION public.trigger_before_update_functionalitycategory();
DROP FUNCTION public.trigger_before_update_functionality();
DROP FUNCTION public.trigger_before_update_account();
DROP FUNCTION public.trigger_before_insert_term();
DROP FUNCTION public.trigger_before_insert_sequence_versioning();
DROP FUNCTION public.trigger_before_insert_schoolyear();
DROP FUNCTION public.trigger_before_insert_projectproposalsourcefunds();
DROP FUNCTION public.trigger_before_insert_projectproposalprojectedincome();
DROP FUNCTION public.trigger_before_insert_projectproposalprogramdesign();
DROP FUNCTION public.trigger_before_insert_projectproposalexpenses();
DROP FUNCTION public.trigger_before_insert_organizationrole();
DROP FUNCTION public.trigger_before_insert_increment_sequence();
DROP FUNCTION public.trigger_before_insert_id();
DROP FUNCTION public.trigger_before_insert_gosmactivity();
DROP FUNCTION public.trigger_before_insert_gosm();
DROP FUNCTION public.trigger_before_insert_functionalitycategory();
DROP FUNCTION public.trigger_before_insert_functionality();
DROP FUNCTION public.trigger_before_insert_account();
DROP FUNCTION public."trigger_before_insert_PreActivityDirectPayment_sequence"();
DROP FUNCTION public."trigger_before_insert_PostProjectProposalExpense_sequence"();
DROP FUNCTION public."trigger_before_insert_PostProjectProposalEventPicture_sequence"();
DROP FUNCTION public."trigger_before_insert_PostProjectDirectPayment_sequence"();
DROP FUNCTION public.trigger_auto_reject();
DROP FUNCTION public.trigger_after_update_signatory_completion();
DROP FUNCTION public.trigger_after_update_gosm_studentorganization();
DROP FUNCTION public."trigger_after_update_ProjectProposal_signatory_immediateSuperio"();
DROP FUNCTION public."trigger_after_update_ProjectProposal_signatory_facultyAdviser"();
DROP FUNCTION public."trigger_after_update_ProjectProposalSignatory_counter"();
DROP FUNCTION public."trigger_after_update_ProjectProposalSignatory_completion"();
DROP FUNCTION public.trigger_after_insert_finance_signatories_initial();
DROP FUNCTION public.trigger_after_insert_finance_signatories();
DROP FUNCTION public."trigger_after_insert_StudentOrganization_ACL"();
DROP FUNCTION public."trigger_after_insert_ProjectProposal_signatories"();
DROP FUNCTION public."trigger_after_insert_ProjectProposalProgramDesign"();
DROP FUNCTION public."trigger_after_insert_PreActivityDirectPayment_signatories"();
DROP FUNCTION public."trigger_after_insert_PreActivityCashAdvance_signatories"();
DROP FUNCTION public.trigger_after_delete_finance_signatories();
DROP FUNCTION public.system_get_next_finance_signatory("signatoryTable" text, "signatoryTableAcronym" text, "where" text);
DROP FUNCTION public.system_get_functionality_id(param_sequenceid integer);
DROP FUNCTION public.system_get_current_year_id();
DROP FUNCTION public.system_get_current_term_id();
DROP FUNCTION public.signatory_get_to_sign_per_account("signatoryTable" text, "signatoryTableAcronym" text, "signatoryTableColumn" text, "parentTable" text, "parentTableAcronym" text);
DROP FUNCTION public.organization_get_treasurer_signatories(organizationid integer);
DROP FUNCTION public.organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer);
DROP FUNCTION public.organization_get_president(param_organization integer);
DROP FUNCTION public.organization_get_officers_with_role_id(roleid integer);
DROP FUNCTION public.organization_get_highest_role_id(param_organization integer);
DROP FUNCTION public.organization_get_documentation_signatories(organizationid integer);
DROP FUNCTION public."is_valid_idNumber"(idnumber integer);
DROP FUNCTION public.cso_get_second_phase_signatories();
DROP FUNCTION public.cso_get_first_phase_signatories();
DROP FUNCTION public."PreAct_finance_get_organization"("uniqueID" integer, "table" text, "tableAcronym" text);
DROP FUNCTION public."PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organizationid integer);
DROP FUNCTION public."PreAct_DirectPayment_get_organization"("param_DPID" integer);
DROP FUNCTION public."PreAct_DirectPayment_get_number_to_sign_per_account"();
DROP FUNCTION public."PreAct_CashAdvance_get_organization"("param_CAID" integer);
DROP FUNCTION public."PreAct_BookTransfer_get_organization_next_treasurer_signatory"(organizationid integer);
DROP FUNCTION public."PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer);
DROP FUNCTION public."PreActCashAdvance_get_number_to_sign_per_account"();
DROP FUNCTION public."PostAct_Reimbursement_get_organization_next_treasurer_signatory"(organizationid integer);
DROP FUNCTION public."PPR_get_organization_next_treasurer_signatory"(organizationid integer);
DROP FUNCTION public."PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer);
DROP FUNCTION public."PPR_get_organization_next_documentation_signatory"(organizationid integer);
DROP FUNCTION public."PPR_get_number_to_sign_per_account"();
DROP FUNCTION public."PPR_get_cso_next_second_phase_signatory"();
DROP FUNCTION public."PPR_get_cso_next_first_phase_signatory"();
DROP FUNCTION public."PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer);
DROP FUNCTION public."GOSMActivity_get_organization"(gosmactivityid integer);
DROP FUNCTION public."GOSMActivity_get_current_term_activity_ids"();
DROP EXTENSION "uuid-ossp";
DROP EXTENSION pgcrypto;
DROP EXTENSION plpgsql;
DROP SCHEMA publicl;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: publicl; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA publicl;


ALTER SCHEMA publicl OWNER TO postgres;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: GOSMActivity_get_current_term_activity_ids(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."GOSMActivity_get_current_term_activity_ids"() RETURNS TABLE(id integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT ga.id
                       FROM GOSMActivity ga
                      WHERE GOSM IN (SELECT g.id
                                       FROM GOSM g
                                       WHERE termId = system_get_current_term_id());
    END;
$$;


ALTER FUNCTION public."GOSMActivity_get_current_term_activity_ids"() OWNER TO postgres;

--
-- Name: GOSMActivity_get_organization(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."GOSMActivity_get_organization"(gosmactivityid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        organizationID INTEGER;
    BEGIN
        SELECT studentOrganization INTO organizationID
          FROM GOSM
         WHERE id = (SELECT GOSM
                       FROM GOSMActivity
                      WHERE id = GOSMActivityID);

        RETURN organizationID;
    END;
$$;


ALTER FUNCTION public."GOSMActivity_get_organization"(gosmactivityid integer) OWNER TO postgres;

--
-- Name: PPR_get_GOSMActivity_id_from_PPRID(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        var_GOSMActivity INTEGER;
    BEGIN
         SELECT GOSMActivity INTO var_GOSMActivity
           FROM ProjectProposal
          WHERE id = param_PPRID;

        RETURN var_GOSMActivity;
    END;
$$;


ALTER FUNCTION public."PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer) OWNER TO postgres;

--
-- Name: PPR_get_cso_next_first_phase_signatory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_cso_next_first_phase_signatory"() RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        csoOfficerID INTEGER;
    BEGIN
         WITH "CSONumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM cso_get_first_phase_signatories() ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO csoOfficerID
           FROM "CSONumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN csoOfficerID;
    END;
$$;


ALTER FUNCTION public."PPR_get_cso_next_first_phase_signatory"() OWNER TO postgres;

--
-- Name: PPR_get_cso_next_second_phase_signatory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_cso_next_second_phase_signatory"() RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        csoOfficerID INTEGER;
    BEGIN
         WITH "CSONumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM cso_get_second_phase_signatories() ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                 ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO csoOfficerID
           FROM "CSONumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN csoOfficerID;
    END;
$$;


ALTER FUNCTION public."PPR_get_cso_next_second_phase_signatory"() OWNER TO postgres;

--
-- Name: PPR_get_number_to_sign_per_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY SELECT signatory AS idNumber, COUNT(pprs.id) AS "numSign"
                       FROM ProjectProposalSignatory pprs
                      WHERE status = 0
                        AND GOSMActivity IN (SELECT id
                                             FROM "GOSMActivity_get_current_term_activity_ids"())
                   GROUP BY pprs.signatory;
    END;
$$;


ALTER FUNCTION public."PPR_get_number_to_sign_per_account"() OWNER TO postgres;

--
-- Name: PPR_get_organization_next_documentation_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_organization_next_documentation_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        documentationID INTEGER;
    BEGIN
         WITH "OrganizationDocumentationNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_documentation_signatories(organizationID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                         ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO documentationID
           FROM "OrganizationDocumentationNumSign" ot
         ORDER BY "numSign" ASC, ot.idNumber DESC
         LIMIT 1;

        RETURN documentationID;
    END;
$$;


ALTER FUNCTION public."PPR_get_organization_next_documentation_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PPR_get_organization_next_immediate_supervisor_signatory(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        immediateSupervisorRoleID INTEGER;
        immediateSupervisorID INTEGER;
    BEGIN
        immediateSupervisorRoleID = "organization_get_role_id_above_account"(preparedBy, organizationID);

         WITH "OrganizationImmediateSupervisorNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM "organization_get_officers_with_role_id"(immediateSupervisorRoleID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                                  ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO immediateSupervisorID
            FROM "OrganizationImmediateSupervisorNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN immediateSupervisorID;
    END;
$$;


ALTER FUNCTION public."PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer) OWNER TO postgres;

--
-- Name: PPR_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PPR_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PPR_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$$;


ALTER FUNCTION public."PPR_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PostAct_Reimbursement_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PostAct_Reimbursement_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "signatory_get_to_sign_per_account"('PostProjectReimbursementSignatory', 'pprs', 'reimbursement', 'PostProjectReimbursement', 'ppr') n
                                                                                     ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO treasurerID
           FROM "OrganizationTreasurerNumSign" ot
       ORDER BY "numSign" ASC, ot.idNumber DESC
          LIMIT 1;

        RETURN treasurerID;
    END;
$$;


ALTER FUNCTION public."PostAct_Reimbursement_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreActCashAdvance_get_number_to_sign_per_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreActCashAdvance_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT preca.signatory AS idNumber, COUNT(preca.id) AS "numSign"
                       FROM "PreActivityCashAdvanceSignatory" preca
                      WHERE preca."status" = 0
                      AND preca."cashAdvance" IN (SELECT paca.id
                                                    FROM "PreActivityCashAdvance" paca
                                                   WHERE paca."GOSMActivity" IN (SELECT ga.id
                                                                                   FROM "GOSMActivity_get_current_term_activity_ids"() ga))
                   GROUP BY preca.signatory;
    END;
$$;


ALTER FUNCTION public."PreActCashAdvance_get_number_to_sign_per_account"() OWNER TO postgres;

--
-- Name: PreActCashAdvance_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PreActCashAdvance_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$$;


ALTER FUNCTION public."PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreAct_BookTransfer_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_BookTransfer_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "signatory_get_to_sign_per_account"('PreActivityBookTransferSignatory', 'pabts', 'bookTransfer', 'PreActivityBookTransfer', 'pabt') n
                                                                                     ON ot.idNumber = n.idNumber
         )
         SELECT ot.idNumber INTO treasurerID
           FROM "OrganizationTreasurerNumSign" ot
       ORDER BY "numSign" ASC, ot.idNumber DESC
          LIMIT 1;

        RETURN treasurerID;
    END;
$$;


ALTER FUNCTION public."PreAct_BookTransfer_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreAct_CashAdvance_get_organization(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_CashAdvance_get_organization"("param_CAID" integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
         SELECT g.studentOrganization INTO "var_organizationID"
           FROM GOSM g
          WHERE g.id = (SELECT ga.GOSM
                          FROM GOSMActivity ga
                         WHERE ga.id = (SELECT paca."GOSMActivity"
                                          FROM "PreActivityCashAdvance" paca
                                         WHERE paca.id = "param_CAID"));

        RETURN "var_organizationID";
    END;
$$;


ALTER FUNCTION public."PreAct_CashAdvance_get_organization"("param_CAID" integer) OWNER TO postgres;

--
-- Name: PreAct_DirectPayment_get_number_to_sign_per_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_DirectPayment_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT preca.signatory AS idNumber, COUNT(preca.id) AS "numSign"
                       FROM "PreActivityDirectPaymentSignatory" preca
                      WHERE preca."status" = 0
                        AND preca."directPayment" IN (SELECT paca.id
                                                        FROM "PreActivityDirectPayment" paca
                                                       WHERE paca."GOSMActivity" IN (SELECT ga.id
                                                                                       FROM "GOSMActivity_get_current_term_activity_ids"() ga))
                   GROUP BY preca.signatory;
    END;
$$;


ALTER FUNCTION public."PreAct_DirectPayment_get_number_to_sign_per_account"() OWNER TO postgres;

--
-- Name: PreAct_DirectPayment_get_organization(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_DirectPayment_get_organization"("param_DPID" integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
         SELECT g.studentOrganization INTO "var_organizationID"
           FROM GOSM g
          WHERE g.id = (SELECT ga.GOSM
                          FROM GOSMActivity ga
                         WHERE ga.id = (SELECT paca."GOSMActivity"
                                          FROM "PreActivityDirectPayment" paca
                                         WHERE paca.id = "param_DPID"));

        RETURN "var_organizationID";
    END;
$$;


ALTER FUNCTION public."PreAct_DirectPayment_get_organization"("param_DPID" integer) OWNER TO postgres;

--
-- Name: PreAct_DirectPayment_get_organization_next_treasurer_signatory(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        treasurerID INTEGER;
    BEGIN
         WITH "OrganizationTreasurerNumSign" AS (
             SELECT ot.idNumber, COALESCE(n."numSign", 0) AS "numSign"
               FROM organization_get_treasurer_signatories(organizationID) ot LEFT JOIN "PreAct_DirectPayment_get_number_to_sign_per_account"() n
                                                                                     ON ot.idNumber = n.idNumber
         )
          SELECT ot.idNumber INTO treasurerID
            FROM "OrganizationTreasurerNumSign" ot
        ORDER BY "numSign" ASC, ot.idNumber DESC
        LIMIT 1;

        RETURN treasurerID;
    END;
$$;


ALTER FUNCTION public."PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organizationid integer) OWNER TO postgres;

--
-- Name: PreAct_finance_get_organization(integer, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."PreAct_finance_get_organization"("uniqueID" integer, "table" text, "tableAcronym" text) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        "var_organizationID" INTEGER;
    BEGIN
        EXECUTE format(
            'SELECT g.studentOrganization
               FROM GOSM g
              WHERE g.id = (SELECT ga.GOSM
                              FROM GOSMActivity ga
                             WHERE ga.id = (SELECT %I."GOSMActivity"
                                              FROM %I %I
                                             WHERE %I.id = $1));',
             "tableAcronym", "table", "tableAcronym", "tableAcronym")
             INTO STRICT "var_organizationID"
             USING "uniqueID";

        RETURN "var_organizationID";
    END;
$_$;


ALTER FUNCTION public."PreAct_finance_get_organization"("uniqueID" integer, "table" text, "tableAcronym" text) OWNER TO postgres;

--
-- Name: cso_get_first_phase_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cso_get_first_phase_signatories() RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 13)
                         AND oo.role/10000 = 0;
     END;
 $$;


ALTER FUNCTION public.cso_get_first_phase_signatories() OWNER TO postgres;

--
-- Name: cso_get_second_phase_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.cso_get_second_phase_signatories() RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
     BEGIN
         RETURN QUERY SELECT DISTINCT oo.idNumber
                        FROM OrganizationOfficer oo
                       WHERE oo.yearID = system_get_current_year_id()
                         AND oo.role IN (SELECT DISTINCT oac.role
                                         FROM OrganizationAccessControl oac
                                        WHERE oac.functionality%1000 = 14)
                         AND oo.role/10000 = 0;
     END;
 $$;


ALTER FUNCTION public.cso_get_second_phase_signatories() OWNER TO postgres;

--
-- Name: is_valid_idNumber(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."is_valid_idNumber"(idnumber integer) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        sum INTEGER DEFAULT 0;
    BEGIN
        /* less than 8 digit number */
        IF idNumber <= 10000000 THEN
            RETURN FALSE;
        END IF;
        
        /* 
            for example 11445955 
            sum = 1*8 + 1*7 + 4*6 + 4*5 + 5*4 + 9*3 + 5*2 + 5*1
            The sum is equal to the sum of the product of its digits and a decrementing integer.

            It's a valid id number if sum is divisible by 11 - As taught by Thomas James Tiam-Lee in INTPRG1
        */
        sum := sum + (idNumber%10);
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*2;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*3;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*4;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*5;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*6;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*7;
        idNumber = idNumber/10;

        sum := sum + (idNumber%10)*8;
        idNumber = idNumber/10;

        /* Divisible by 11 */
        RETURN (sum%11) = 0;
    END;
$$;


ALTER FUNCTION public."is_valid_idNumber"(idnumber integer) OWNER TO postgres;

--
-- Name: organization_get_documentation_signatories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_documentation_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 12)
                        AND oo.role/10000 = organizationID;
    END;
$$;


ALTER FUNCTION public.organization_get_documentation_signatories(organizationid integer) OWNER TO postgres;

--
-- Name: organization_get_highest_role_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_highest_role_id(param_organization integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT oro.id INTO roleID
          FROM OrganizationRole oro
         WHERE oro.masterRole IS NULL
           AND oro.organization = param_organization
      ORDER BY oro.rank ASC
         LIMIT 1;

        RETURN roleID;
    END;
$$;


ALTER FUNCTION public.organization_get_highest_role_id(param_organization integer) OWNER TO postgres;

--
-- Name: organization_get_officers_with_role_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_officers_with_role_id(roleid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.role = roleID
                        AND oo.yearID = system_get_current_year_id();
    END;
$$;


ALTER FUNCTION public.organization_get_officers_with_role_id(roleid integer) OWNER TO postgres;

--
-- Name: organization_get_president(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_president(param_organization integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        presidentID INTEGER;
    BEGIN
        SELECT oo.idNumber INTO presidentID
          FROM OrganizationOfficer oo
         WHERE oo.yearID = system_get_current_year_id()
           AND oo.role = (SELECT oro.id
                            FROM OrganizationRole oro
                           WHERE oro.masterRole IS NULL
                             AND oro.organization = param_organization
                        ORDER BY oro.rank ASC
                           LIMIT 1);

        RETURN presidentID;
    END;
$$;


ALTER FUNCTION public.organization_get_president(param_organization integer) OWNER TO postgres;

--
-- Name: organization_get_role_id_above_account(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        roleID INTEGER;
    BEGIN
        SELECT oro.masterRole INTO roleID
          FROM OrganizationRole oro
         WHERE oro.organization = param_organizationID
           AND oro.id = (SELECT oo.role
                           FROM OrganizationOfficer oo
                          WHERE oo.idNumber = param_IDNumber
                            AND oo.yearID = system_get_current_year_id());
        RETURN roleID;
    END;
$$;


ALTER FUNCTION public.organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer) OWNER TO postgres;

--
-- Name: organization_get_treasurer_signatories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.organization_get_treasurer_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
    LANGUAGE plpgsql STABLE
    AS $$
    BEGIN
        RETURN QUERY SELECT DISTINCT oo.idNumber
                       FROM OrganizationOfficer oo
                      WHERE oo.yearID = system_get_current_year_id()
                        AND oo.role IN (SELECT DISTINCT oac.role
                                        FROM OrganizationAccessControl oac
                                       WHERE oac.functionality%1000 = 11)
                        AND oo.role/10000 = organizationID;
    END;
$$;


ALTER FUNCTION public.organization_get_treasurer_signatories(organizationid integer) OWNER TO postgres;

--
-- Name: signatory_get_to_sign_per_account(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.signatory_get_to_sign_per_account("signatoryTable" text, "signatoryTableAcronym" text, "signatoryTableColumn" text, "parentTable" text, "parentTableAcronym" text) RETURNS TABLE(idnumber integer, "numSign" bigint)
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY EXECUTE format(
            'SELECT %I.signatory AS idNumber, COUNT(%I.id) AS "numSign"
               FROM %I %I
              WHERE %I."status" = 0
                AND %I.%I IN (SELECT %I.id
                                FROM %I %I
                               WHERE %I."GOSMActivity" IN (SELECT ga.id
                                                             FROM "GOSMActivity_get_current_term_activity_ids"() ga))
            GROUP BY %I.signatory;',
        "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTable", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableColumn", "parentTableAcronym", "parentTable", "parentTableAcronym", "parentTableAcronym", "signatoryTableAcronym");
    END;
$$;


ALTER FUNCTION public.signatory_get_to_sign_per_account("signatoryTable" text, "signatoryTableAcronym" text, "signatoryTableColumn" text, "parentTable" text, "parentTableAcronym" text) OWNER TO postgres;

--
-- Name: system_get_current_term_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.system_get_current_term_id() RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        termID INTEGER;
    BEGIN
        SELECT id INTO termID
          FROM Term
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN termID;
    END;
$$;


ALTER FUNCTION public.system_get_current_term_id() OWNER TO postgres;

--
-- Name: system_get_current_year_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.system_get_current_year_id() RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        yearID INTEGER;
    BEGIN
        SELECT id INTO yearID
          FROM SchoolYear
         WHERE CURRENT_DATE >= dateStart
           AND CURRENT_DATE <= dateEnd;

        RETURN yearID;
    END;
$$;


ALTER FUNCTION public.system_get_current_year_id() OWNER TO postgres;

--
-- Name: system_get_functionality_id(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.system_get_functionality_id(param_sequenceid integer) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        var_FunctionalityID INTEGER;
    BEGIN
         SELECT id INTO var_FunctionalityID
           FROM Functionality
          WHERE id%100 = param_sequenceID;

        RETURN var_FunctionalityID;
    END;
$$;


ALTER FUNCTION public.system_get_functionality_id(param_sequenceid integer) OWNER TO postgres;

--
-- Name: system_get_next_finance_signatory(text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.system_get_next_finance_signatory("signatoryTable" text, "signatoryTableAcronym" text, "where" text) RETURNS integer
    LANGUAGE plpgsql STABLE
    AS $$
    DECLARE
        signatoryID INTEGER;
    BEGIN
        EXECUTE format(
            'SELECT *
              FROM %I %I LEFT JOIN "FinanceSignatoryType" "fst"
                                ON %I."type" = "fst"."id"
             WHERE %I."status" = 0
               AND (%s)
          ORDER BY "fst"."lineup" ASC
             LIMIT 1;',
        "signatoryTable", "signatoryTableAcronym", "signatoryTableAcronym", "signatoryTableAcronym", "where"
        ) INTO signatoryID;

        RETURN signatoryID;
    END;
$$;


ALTER FUNCTION public.system_get_next_finance_signatory("signatoryTable" text, "signatoryTableAcronym" text, "where" text) OWNER TO postgres;

--
-- Name: trigger_after_delete_finance_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_after_delete_finance_signatories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        totalExpense NUMERIC(12, 2);
    BEGIN
        EXECUTE format('SELECT SUM(ppe.unitCost*ppe.quantity)
	                      FROM ProjectProposalExpenses ppe
	                     WHERE ppe.id IN (SELECT %I.particular
	                                        FROM %I %I
	                                       WHERE (%s));', TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT totalExpense
        USING OLD;

        IF totalExpense <= 5000.00 THEN
            EXECUTE format('DELETE FROM %I %I
                                  WHERE (%s)
                                    AND %I.type = 3;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
            USING OLD;
        END IF;

	    IF totalExpense <= 50000.00 THEN
        EXECUTE format('DELETE FROM %I %I
                              WHERE (%s)
                                AND %I.type = 4;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
        USING OLD;
        END IF;

	    IF totalExpense <= 250000.00 THEN
            EXECUTE format('DELETE FROM %I %I
                                  WHERE (%s)
                                    AND %I.type = 5;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5], TG_ARGV[4])
            USING OLD;
	    END IF;

        RETURN OLD;
    END
$$;


ALTER FUNCTION public.trigger_after_delete_finance_signatories() OWNER TO postgres;

--
-- Name: trigger_after_insert_PreActivityCashAdvance_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_insert_PreActivityCashAdvance_signatories"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_CashAdvance_get_organization"(NEW."id");
        organizationPresident = organization_get_president(organization);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", "PreActCashAdvance_get_organization_next_treasurer_signatory"(organization), 0);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", organizationPresident, 1);

        INSERT INTO "PreActivityCashAdvanceSignatory" ("cashAdvance", signatory, type)
                                               VALUES (NEW."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_insert_PreActivityCashAdvance_signatories"() OWNER TO postgres;

--
-- Name: trigger_after_insert_PreActivityDirectPayment_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_insert_PreActivityDirectPayment_signatories"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_DirectPayment_get_organization"(NEW."id");
        organizationPresident = organization_get_president(organization);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", "PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organization), 0);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", organizationPresident, 1);

        INSERT INTO "PreActivityDirectPaymentSignatory" ("directPayment", signatory, type)
                                               VALUES (NEW."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_insert_PreActivityDirectPayment_signatories"() OWNER TO postgres;

--
-- Name: trigger_after_insert_ProjectProposalProgramDesign(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_insert_ProjectProposalProgramDesign"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        minDate DATE;
        maxDate DATE;
    BEGIN
        SELECT MIN(date) INTO STRICT minDate
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal;

        SELECT MAX(date) INTO STRICT minDate
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal;

        IF NEW.date < minDate OR minDate IS NULL THEN
            UPDATE ProjectProposal
               SET actualDateStart = NEW.date
            WHERE id = NEW.projectProposal;
        END IF;

        IF NEW.date > maxDate OR maxDate IS NULL THEN
            UPDATE ProjectProposal
               SET actualDateEnd = NEW.date
             WHERE id = NEW.projectProposal;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_insert_ProjectProposalProgramDesign"() OWNER TO postgres;

--
-- Name: trigger_after_insert_ProjectProposal_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_insert_ProjectProposal_signatories"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "GOSMActivity_get_organization"(NEW.GOSMActivity);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            SELECT NEW.GOSMActivity, idNumber, 0
              FROM GOSMActivityProjectHead
             WHERE activityID = NEW.GOSMActivity;

         INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
              VALUES (NEW.GOSMActivity, "PPR_get_organization_next_treasurer_signatory"(organization),1);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, "PPR_get_organization_next_immediate_supervisor_signatory"(NEW.preparedBy, organization), 2);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, organization_get_president(organization), 3);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
             VALUES (NEW.GOSMActivity, organization_get_documentation_signatories(organization), 5);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            VALUES (NEW.GOSMActivity, "PPR_get_cso_next_first_phase_signatory"(), 6);

        INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
            VALUES (NEW.GOSMActivity, "PPR_get_cso_next_second_phase_signatory"(), 7);

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_insert_ProjectProposal_signatories"() OWNER TO postgres;

--
-- Name: trigger_after_insert_StudentOrganization_ACL(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_insert_StudentOrganization_ACL"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        presidentRoleID INTEGER;
        executiveSecretariatRoleID INTEGER;
        eevpRoleID INTEGER;
        vpdRoleID INTEGER;
        avpdRoleID INTEGER;
        vpfRoleID INTEGER;
        avpfRoleID INTEGER;
        -- Internal Executive Vice President
        ievpRoleID INTEGER;
        joRoleID INTEGER;
    BEGIN
        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'President', 'P', TRUE, NULL, 0)
        RETURNING id INTO presidentRoleID;

        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                       VALUES (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 0)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 15)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 19)), TRUE),
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 21)), TRUE),
                                              -- Sign PPR as President
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 24)), TRUE),
                                              -- Sign Finance Transaction as President
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 25)), TRUE),
                                              -- Submit Officer Survey Form
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Add Members
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 31)), TRUE),
                                              -- Submit Officer Survey Form
                                              (presidentRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Executive Secretariat','ES', TRUE, presidentRoleID, 10)
        RETURNING id INTO executiveSecretariatRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                             (executiveSecretariatRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'External Executive Vice President', 'E-EVP', TRUE, presidentRoleID, 10)
        RETURNING id INTO eevpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 10)), TRUE),
                                              -- Submit Officer Survey Form
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (eevpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Internal Executive Vice President', 'I-EVP',TRUE, presidentRoleID, 10)
        RETURNING id INTO ievpRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              -- Submit Officer Survey Form
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (ievpRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Vice President of Documentations', 'VP-D', TRUE, executiveSecretariatRoleID, 20)
        RETURNING id INTO vpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              -- Sign PPR as Documentation
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 12)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, rank)
                             VALUES (NEW.id, 'Associate Vice President of Documentations', 'AVP-D', FALSE, vpdRoleID, 30)
        RETURNING id INTO avpdRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpdRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Vice President of Finance', 'VP-F', TRUE, ievpRoleID, NULL, 20)
        RETURNING id INTO vpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              -- Sign PPR as Treasurer
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 11)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 19)), TRUE),
                                              -- Evaluate
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 21)), TRUE),
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 22)), TRUE),
                                              -- Sign Finance Transaction as Treasurer
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 26)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE),
                                              -- Set Organization Fund
                                              (vpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 33)), TRUE);
                                              
        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, masterRole, home_url, rank)
                             VALUES (NEW.id, 'Associate Vice President of Finance', 'AVP-F',FALSE, vpfRoleID, NULL, 30)
        RETURNING id INTO avpfRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                      VALUES  (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 9)), TRUE),
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 18)), TRUE),
                                              -- Sign Finance Transaction as Treasurer
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 26)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE),
                                              -- Submit Not in GOSM Activity 28
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 28)), TRUE),
                                              -- Submit Officer Survey Form
                                              (avpfRoleID, (SELECT id FROM functionality WHERE(id%1000 = 32)), TRUE);

        INSERT INTO OrganizationRole(organization, name, shortname, uniquePosition, rank)
                             VALUES (      NEW.id, 'Junior Officer', 'JO', FALSE, 40)
        RETURNING id INTO joRoleID;
        INSERT INTO OrganizationAccessControl (role, functionality, isAllowed)
                                       VALUES (joRoleID, (SELECT id FROM functionality WHERE(id%1000 = 27)), TRUE);
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_insert_StudentOrganization_ACL"() OWNER TO postgres;

--
-- Name: trigger_after_insert_finance_signatories(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_after_insert_finance_signatories() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        totalExpense NUMERIC(12, 2);
    BEGIN
        EXECUTE format('SELECT SUM(ppe.unitCost*ppe.quantity)
	                      FROM ProjectProposalExpenses ppe
	                     WHERE ppe.id IN (SELECT %I.particular
	                                        FROM %I %I
	                                       WHERE (%s));', TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT totalExpense
        USING NEW;

        IF totalExpense > 5000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 4 ORDER BY a.idNumber DESC LIMIT 1), 3)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
        END IF;

	    IF totalExpense > 50000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 5 ORDER BY a.idNumber DESC LIMIT 1), 4)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
        END IF;

	    IF totalExpense > 250000.00 THEN
            EXECUTE format('INSERT INTO %I (%I, "signatory", "type")
                                    VALUES (%s, (SELECT a.idNumber FROM Account a WHERE a.type = 6 ORDER BY a.idNumber DESC LIMIT 1), 5)
                            ON CONFLICT DO NOTHING;', TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
            USING NEW;
	    END IF;

        RETURN NEW;
    END
$$;


ALTER FUNCTION public.trigger_after_insert_finance_signatories() OWNER TO postgres;

--
-- Name: trigger_after_insert_finance_signatories_initial(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_after_insert_finance_signatories_initial() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        organization INTEGER;
        organizationPresident INTEGER;
    BEGIN
        organization = "PreAct_finance_get_organization"(NEW."id", TG_ARGV[0], TG_ARGV[1]);
        organizationPresident = organization_get_president(organization);

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                    VALUES ($1."id", %I($2), 0);',
            TG_ARGV[2], TG_ARGV[3], TG_ARGV[4]
        ) USING NEW, organization;

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                    VALUES ($1."id", $2, 1);',
            TG_ARGV[2], TG_ARGV[3]
        ) USING NEW, organizationPresident;

        EXECUTE format(
            'INSERT INTO %I (%I, signatory, type)
                     VALUES ($1."id", (SELECT a.idNumber FROM Account a WHERE type = 3 ORDER BY idNumber DESC LIMIT 1), 2);',
            TG_ARGV[2], TG_ARGV[3]
        ) USING NEW;

        RETURN NEW;
    END;
$_$;


ALTER FUNCTION public.trigger_after_insert_finance_signatories_initial() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposalSignatory_completion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_update_ProjectProposalSignatory_completion"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
        numSignNeeded INTEGER;
        nature SMALLINT;
        type SMALLINT;
    BEGIN
	IF NEW.status = 1 OR NEW.status = 4 THEN
	    SELECT COUNT(pps.id) INTO numSignNeeded
              FROM ProjectProposalSignatory pps
             WHERE pps.GOSMActivity = NEW.GOSMActivity
               AND status <> 1
               AND status <> 4;

             IF numSignNeeded = 0 THEN
                SELECT ga.activityNature, ga.activityType INTO "nature", "type"
                  FROM GOSMActivity ga
                 WHERE ga.id = NEW.GOSMActivity;

                 IF nature = 1 OR type = 2 THEN
                     INSERT INTO AMTActivityEvaluation (activity, status)
                                                VALUES (NEW.GOSMActivity, 0);
                 END IF;

                UPDATE ProjectProposal
                   SET status = 3
                 WHERE GOSMActivity = NEW.GOSMActivity;
            END IF;
	    ELSIF NEW.status = 2 THEN
	        UPDATE ProjectProposal
               SET status = 4
             WHERE GOSMActivity = NEW.GOSMActivity;
        ELSIF NEW.status = 3 THEN
            UPDATE ProjectProposal
               SET status = 5
             WHERE GOSMActivity = NEW.GOSMActivity;
	    END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposalSignatory_completion"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposalSignatory_counter(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_update_ProjectProposalSignatory_counter"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE ProjectProposal
           SET timesPended = timesPended + 1
         WHERE GOSMActivity = NEW.GOSMActivity;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposalSignatory_counter"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposal_signatory_facultyAdviser(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_update_ProjectProposal_signatory_facultyAdviser"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      IF NEW.facultyAdviser IS NULL THEN
        DELETE FROM ProjectProposalSignatory pps
        WHERE pps.GOSMActivity = NEW.GOSMActivity
          AND pps.signatory = OLD.facultyAdviser
          AND pps.type = 4;
      ELSE
          INSERT INTO ProjectProposalSignatory (GOSMActivity, signatory, type)
                                        VALUES (NEW.GOSMActivity, NEW.facultyAdviser, 4)
          ON CONFLICT ON CONSTRAINT "pk_ProjectProposalSignatory"
          DO UPDATE SET signatory = NEW.facultyAdviser;
      END IF;

      RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposal_signatory_facultyAdviser"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposal_signatory_immediateSuperio(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_after_update_ProjectProposal_signatory_immediateSuperio"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      UPDATE ProjectProposalSignatory
         SET signatory = "PPR_get_organization_next_immediate_supervisor_signatory"(NEW.preparedBy, "GOSMActivity_get_organization"(NEW.GOSMActivity))
       WHERE GOSMActivity = NEW.GOSMActivity
         AND type = 2;
      RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposal_signatory_immediateSuperio"() OWNER TO postgres;

--
-- Name: trigger_after_update_gosm_studentorganization(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_after_update_gosm_studentorganization() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    DECLARE
      newID INTEGER DEFAULT 0;
    BEGIN
        newID = NEW.studentOrganization*100000 + (OLD.id%100000);

        UPDATE GOSM
           SET id = newID
        WHERE id = OLD.id;
        NEW.id = newID;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_after_update_gosm_studentorganization() OWNER TO postgres;

--
-- Name: trigger_after_update_signatory_completion(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_after_update_signatory_completion() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
        numSignNeeded INTEGER;
        numPend INTEGER;
        numApprove INTEGER;
        newStatus SMALLINT DEFAULT 0;
    BEGIN
        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s)
                           AND %I.status = 1;',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
        INTO STRICT numApprove
        USING NEW;

        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s)
                           AND %I.status = 2;',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
        INTO STRICT numPend
        USING NEW;

        EXECUTE format('SELECT COUNT(%I.id)
                          FROM %I %I
                         WHERE (%s);',
            TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT numSignNeeded
        USING NEW;

        /* All has signed */
        IF numSignNeeded = numApprove THEN
            newStatus := 1;
        /* This person pended or a pend exists */
	    ELSEIF NEW.status = 2 OR numPend > 0 THEN
             newStatus := 2;
	    END IF;

        EXECUTE format('UPDATE %I %I
                           SET status = $2
                         WHERE (%s);',
            TG_ARGV[3], TG_ARGV[4], TG_ARGV[5])
        USING NEW, newStatus;

        RETURN NEW;
    END
$_$;


ALTER FUNCTION public.trigger_after_update_signatory_completion() OWNER TO postgres;

--
-- Name: trigger_auto_reject(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_auto_reject() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN NULL;
    END;
$$;


ALTER FUNCTION public.trigger_auto_reject() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectDirectPayment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_before_insert_PostProjectDirectPayment_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
         IF NEW."submissionID" IS NULL THEN
             NEW."sequence" = 1;
             SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
               FROM "PostProjectDirectPayment"
              WHERE "GOSMActivity" = NEW."GOSMActivity";
         ELSE
             SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
               FROM "PostProjectDirectPayment"
              WHERE "GOSMActivity" = NEW."GOSMActivity"
                AND "submissionID" = NEW."submissionID";
         END IF;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectDirectPayment_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectProposalEventPicture_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_before_insert_PostProjectProposalEventPicture_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectProposalEventPicture"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectProposalEventPicture"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectProposalEventPicture_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PostProjectProposalExpense_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_before_insert_PostProjectProposalExpense_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PostProjectProposalExpense"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
              FROM "PostProjectProposalExpense"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PostProjectProposalExpense_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_PreActivityDirectPayment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."trigger_before_insert_PreActivityDirectPayment_sequence"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW.sequence = 1;
            SELECT COALESCE(MAX("submissionID") + 1, 1) INTO NEW."submissionID"
              FROM "PreActivityDirectPayment"
             WHERE "GOSMActivity" = NEW."GOSMActivity";
        ELSE
            SELECT COALESCE(MAX("sequence") + 1, 1) INTO NEW."sequence"
              FROM "PreActivityDirectPayment"
             WHERE "GOSMActivity" = NEW."GOSMActivity"
               AND "submissionID" = NEW."submissionID";
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public."trigger_before_insert_PreActivityDirectPayment_sequence"() OWNER TO postgres;

--
-- Name: trigger_before_insert_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT gen_salt('bf') INTO NEW.salt;
        SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

        NEW.dateCreated = CURRENT_TIMESTAMP;
        NEW.dateModified = NEW.dateCreated;
        NEW.passwordExpiration = NEW.dateCreated + (INTERVAL '3 MONTH');
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_account() OWNER TO postgres;

--
-- Name: trigger_before_insert_functionality(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_functionality() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%1000) + 1, 0) INTO NEW.id
          FROM Functionality;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_functionality() OWNER TO postgres;

--
-- Name: trigger_before_insert_functionalitycategory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_functionalitycategory() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%100) + 1, 0) INTO NEW.id
          FROM FunctionalityCategory;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_functionalitycategory() OWNER TO postgres;

--
-- Name: trigger_before_insert_gosm(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_gosm() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id%100000) + 1, 1) INTO NEW.id
          FROM GOSM;

        NEW.id = (NEW.studentOrganization*100000) + NEW.id;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_gosm() OWNER TO postgres;

--
-- Name: trigger_before_insert_gosmactivity(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_gosmactivity() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(id) + 1, 1) INTO STRICT NEW.sequence
          FROM GOSMActivity
         WHERE GOSM = NEW.GOSM;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_gosmactivity() OWNER TO postgres;

--
-- Name: trigger_before_insert_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_id() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        EXECUTE format ('SELECT COALESCE(MAX("id") + 1, 1)
                           FROM %I;', TG_ARGV[0])
        INTO STRICT NEW."id";

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_id() OWNER TO postgres;

--
-- Name: trigger_before_insert_increment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_increment_sequence() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
	    EXECUTE format ('SELECT COALESCE(MAX(sequence) + 1, 1)
	                       FROM %I %I
	                      WHERE (%s);', TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
        INTO STRICT NEW."sequence"
	    USING NEW;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_increment_sequence() OWNER TO postgres;

--
-- Name: trigger_before_insert_organizationrole(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_organizationrole() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      SELECT COALESCE(MAX(id%10000) + 1, 0) INTO NEW.id
        FROM OrganizationRole;

      NEW.id = (NEW.organization%1000)*10000 + NEW.id;

      SELECT COALESCE(MAX(sequence) + 1, 1) INTO NEW.sequence
        FROM OrganizationRole
      WHERE organization = NEW.organization;
      return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_organizationrole() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalexpenses(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_projectproposalexpenses() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalExpenses
         WHERE projectProposal = NEW.projectProposal;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalexpenses() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalprogramdesign(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_projectproposalprogramdesign() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProgramDesign
         WHERE projectProposal = NEW.projectProposal
           AND dayID = NEW.dayID;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalprogramdesign() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalprojectedincome(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_projectproposalprojectedincome() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalProjectedIncome
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalprojectedincome() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalsourcefunds(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_projectproposalsourcefunds() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
         
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalsourcefunds() OWNER TO postgres;

--
-- Name: trigger_before_insert_schoolyear(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_schoolyear() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id := (NEW.startYear*10000) + NEW.endYear;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_schoolyear() OWNER TO postgres;

--
-- Name: trigger_before_insert_sequence_versioning(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_sequence_versioning() RETURNS trigger
    LANGUAGE plpgsql
    AS $_$
    BEGIN
        IF NEW."submissionID" IS NULL THEN
            NEW."sequence" = 1;
            EXECUTE format('SELECT COALESCE(MAX(%I."submissionID") + 1, 1)
                              FROM %I %I
                             WHERE (%s);',
                             TG_ARGV[1], TG_ARGV[0], TG_ARGV[1], TG_ARGV[2])
            INTO NEW."submissionID"
            USING NEW;

        ELSE
            EXECUTE format('SELECT COALESCE(MAX(%I."sequence") + 1, 1)
                              FROM %I %I
                             WHERE (%s)
                               AND %I."submissionID" = $1."submissionID";',
                            TG_ARGV[1],  TG_ARGV[0], TG_ARGV[1], TG_ARGV[2], TG_ARGV[1])
            INTO NEW."sequence"
            USING NEW;
        END IF;

        RETURN NEW;
    END;
$_$;


ALTER FUNCTION public.trigger_before_insert_sequence_versioning() OWNER TO postgres;

--
-- Name: trigger_before_insert_term(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_insert_term() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id := (NEW.schoolYearID*10) + NEW.number;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_term() OWNER TO postgres;

--
-- Name: trigger_before_update_account(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_update_account() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        IF OLD.password <> NEW.password THEN
            SELECT gen_salt('bf') INTO NEW.salt;
            SELECT crypt(NEW.password, NEW.salt) INTO NEW.password;

            NEW.passwordExpiration = CURRENT_TIMESTAMP + (INTERVAL '3 MONTH');

            IF OLD.status = 3 THEN
                NEW.status = 0;
            END IF;
        END IF;

        NEW.dateModified = CURRENT_TIMESTAMP;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_account() OWNER TO postgres;

--
-- Name: trigger_before_update_functionality(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_update_functionality() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id = OLD.id%1000;

        IF NEW.category IS NOT NULL THEN
            NEW.id = NEW.id + NEW.category*1000;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_functionality() OWNER TO postgres;

--
-- Name: trigger_before_update_functionalitycategory(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_update_functionalitycategory() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        NEW.id = OLD.id%100;

        IF NEW.domain IS NOT NULL THEN
            NEW.id = NEW.id + NEW.domain*100;
        END IF;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_functionalitycategory() OWNER TO postgres;

--
-- Name: trigger_before_update_gosm_status(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_update_gosm_status() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
        END CASE;
        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_gosm_status() OWNER TO postgres;

--
-- Name: trigger_before_update_projectproposal(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_before_update_projectproposal() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        CASE NEW.status
            WHEN 2 /* Initial Submission */ THEN
                NEW.dateSubmitted := CURRENT_TIMESTAMP;
            WHEN 3, 4, 5 /* Approved, Pending, Denied */ THEN
                NEW.dateStatusModified := CURRENT_TIMESTAMP;
            ELSE
              RETURN NEW;
        END CASE;

        RETURN NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_update_projectproposal() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ARFOrganizationPosition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ARFOrganizationPosition" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."ARFOrganizationPosition" OWNER TO postgres;

--
-- Name: AccountNotification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AccountNotification" (
    id integer DEFAULT '-1'::integer NOT NULL,
    account integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    status smallint DEFAULT 0,
    date timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    title text,
    description text,
    details json
);


ALTER TABLE public."AccountNotification" OWNER TO postgres;

--
-- Name: AccountNotificationStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AccountNotificationStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."AccountNotificationStatus" OWNER TO postgres;

--
-- Name: AccountStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."AccountStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."AccountStatus" OWNER TO postgres;

--
-- Name: ActivityPublicity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPublicity" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    material smallint,
    "modeOfDistribution" smallint,
    description text,
    "targetPostingDate" date,
    "submittedBy" integer,
    "dateSubmitted" date,
    status smallint,
    "checkedBy" integer,
    "dateChecked" date,
    comments text,
    filename text,
    "filenameToShow" text,
    "revisionReason" smallint
);


ALTER TABLE public."ActivityPublicity" OWNER TO postgres;

--
-- Name: ActivityPublicityMaterial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPublicityMaterial" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."ActivityPublicityMaterial" OWNER TO postgres;

--
-- Name: ActivityPublicityModeOfDistribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPublicityModeOfDistribution" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."ActivityPublicityModeOfDistribution" OWNER TO postgres;

--
-- Name: ActivityPublicityRevisionReason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPublicityRevisionReason" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."ActivityPublicityRevisionReason" OWNER TO postgres;

--
-- Name: ActivityPublicityStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityPublicityStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."ActivityPublicityStatus" OWNER TO postgres;

--
-- Name: ActivityResearchForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityResearchForm" (
    "GOSMActivity" integer NOT NULL,
    "idNumber" integer NOT NULL,
    email text NOT NULL,
    sequence integer,
    "positionInOrganization" smallint,
    "IUTPOTA" smallint,
    "TASMI" smallint,
    "IFIDTA" smallint,
    "TAWWP" smallint,
    "TOUMTGTTA" smallint,
    field6 smallint,
    field7 smallint,
    "WWWITA" text,
    "FAC" text,
    "EFFA" text,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."ActivityResearchForm" OWNER TO postgres;

--
-- Name: ActivityVenue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ActivityVenue" (
    id integer NOT NULL,
    name text,
    capacity integer,
    size smallint,
    rate numeric(12,2),
    "rateType" smallint,
    building smallint
);


ALTER TABLE public."ActivityVenue" OWNER TO postgres;

--
-- Name: BookTransferEstablishment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."BookTransferEstablishment" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    "transferAccount" character(6)
);


ALTER TABLE public."BookTransferEstablishment" OWNER TO postgres;

--
-- Name: Building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Building" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."Building" OWNER TO postgres;

--
-- Name: ExpenseTypeAttachmentRequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."ExpenseTypeAttachmentRequirement" (
    "expenseType" smallint NOT NULL,
    document smallint NOT NULL
);


ALTER TABLE public."ExpenseTypeAttachmentRequirement" OWNER TO postgres;

--
-- Name: FinanceSignatoryType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."FinanceSignatoryType" (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE public."FinanceSignatoryType" OWNER TO postgres;

--
-- Name: MemberSurveyForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."MemberSurveyForm" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "termID" integer NOT NULL,
    member integer NOT NULL,
    "organizationID" integer NOT NULL,
    field1 smallint NOT NULL,
    field2 smallint NOT NULL,
    field3 smallint NOT NULL,
    field4 smallint NOT NULL,
    field5 smallint NOT NULL,
    field6 smallint NOT NULL,
    field7 smallint NOT NULL,
    field8 smallint NOT NULL,
    field9 smallint NOT NULL,
    field10 smallint NOT NULL,
    field11 smallint NOT NULL,
    field12 smallint NOT NULL,
    field13 smallint NOT NULL
);


ALTER TABLE public."MemberSurveyForm" OWNER TO postgres;

--
-- Name: OfficerSurveyForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OfficerSurveyForm" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "termID" integer NOT NULL,
    "organizationID" integer NOT NULL,
    officer integer NOT NULL,
    field1 smallint NOT NULL,
    field2 smallint NOT NULL,
    field3 smallint NOT NULL,
    field4 smallint NOT NULL,
    field5 smallint NOT NULL,
    field6 smallint NOT NULL,
    field7 smallint NOT NULL,
    field8 smallint NOT NULL,
    field9 smallint NOT NULL
);


ALTER TABLE public."OfficerSurveyForm" OWNER TO postgres;

--
-- Name: OrganizationMember; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."OrganizationMember" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "idNumber" integer NOT NULL,
    organization integer NOT NULL,
    "yearID" integer NOT NULL,
    name text,
    "dateAdded" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."OrganizationMember" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectBookTransfer" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    purpose character varying(60),
    bsfilename text,
    "bsfilenameToShow" text,
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE public."PostProjectBookTransfer" OWNER TO postgres;

--
-- Name: PostProjectBookTransferParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectBookTransferParticular" (
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PostProjectBookTransferParticular" OWNER TO postgres;

--
-- Name: PostProjectBookTransferStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectBookTransferStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PostProjectBookTransferStatus" OWNER TO postgres;

--
-- Name: PostProjectDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectDirectPayment" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    "paymentBy" smallint,
    "delayedProcessing" text,
    fqfilename text,
    roffilename text,
    "fqfilenameToShow" text,
    "roffilenameToShow" text,
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE public."PostProjectDirectPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectDirectPaymentParticular" (
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PostProjectDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectDirectPaymentPayment" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PostProjectDirectPaymentPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectDirectPaymentStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PostProjectDirectPaymentStatus" OWNER TO postgres;

--
-- Name: PostProjectProposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectProposal" (
    "GOSMActivity" integer NOT NULL,
    "preparedBy" integer,
    status smallint DEFAULT 0 NOT NULL,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "dateSubmitted" timestamp with time zone,
    "ANP" integer,
    "ANMP" integer,
    objectives text[],
    "WATTTWITA" text,
    "WWYGLIETA" text,
    "HDTATYLCTTDOTP" text,
    "WATTWWAWCYDTPTFHA" text,
    galsfilename text,
    "galsfilenameToShow" text,
    "isBriefContextCompleted" boolean DEFAULT false NOT NULL,
    "isOtherFinanceDocumentsCompleted" boolean DEFAULT false NOT NULL,
    "isFinanceDocumentCompleted" boolean DEFAULT false NOT NULL,
    "isCheckedDP" boolean DEFAULT false NOT NULL,
    "isCheckedR" boolean DEFAULT false NOT NULL,
    "isCheckedBT" boolean DEFAULT false NOT NULL,
    comments text,
    "sectionsToBeEdited" character varying(60)[],
    document jsonb,
    "checkedByStage1" integer,
    "signatureStage1" text,
    "checkedByStage2" integer,
    "signatureStage2" text
);


ALTER TABLE public."PostProjectProposal" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectProposalEventPicture" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    filename text,
    "filenameToShow" text,
    description text,
    "idNumber" integer
);


ALTER TABLE public."PostProjectProposalEventPicture" OWNER TO postgres;

--
-- Name: PostProjectProposalExpense; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectProposalExpense" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    particular character varying(45),
    establishment character varying(45),
    price numeric(12,2),
    filename text,
    "filenameToShow" text,
    "idNumber" integer
);


ALTER TABLE public."PostProjectProposalExpense" OWNER TO postgres;

--
-- Name: PostProjectProposalStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectProposalStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."PostProjectProposalStatus" OWNER TO postgres;

--
-- Name: PostProjectReimbursement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectReimbursement" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer DEFAULT '-1'::integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "justificationFDPP" text,
    "justificationFNUCADP" text,
    filenames text[],
    "filenamesToShow" text[],
    "submittedBy" integer,
    "dateCreated" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public."PostProjectReimbursement" OWNER TO postgres;

--
-- Name: PostProjectReimbursementParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectReimbursementParticular" (
    id integer DEFAULT '-1'::integer NOT NULL,
    reimbursement integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PostProjectReimbursementParticular" OWNER TO postgres;

--
-- Name: PostProjectReimbursementPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectReimbursementPayment" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PostProjectReimbursementPayment" OWNER TO postgres;

--
-- Name: PostProjectReimbursementSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectReimbursementSignatory" (
    id integer DEFAULT '-1'::integer NOT NULL,
    reimbursement integer,
    signatory integer,
    type smallint,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    sectionstoedit character varying(60)[],
    document jsonb,
    digitalsignature text,
    datesigned timestamp with time zone
);


ALTER TABLE public."PostProjectReimbursementSignatory" OWNER TO postgres;

--
-- Name: PostProjectReimbursementStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PostProjectReimbursementStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PostProjectReimbursementStatus" OWNER TO postgres;

--
-- Name: PreActivityBookTransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityBookTransfer" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer DEFAULT '-1'::integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer NOT NULL,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    establishment smallint NOT NULL
);


ALTER TABLE public."PreActivityBookTransfer" OWNER TO postgres;

--
-- Name: PreActivityBookTransferParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityBookTransferParticular" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PreActivityBookTransferParticular" OWNER TO postgres;

--
-- Name: PreActivityBookTransferSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityBookTransferSignatory" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "bookTransfer" integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    "sectionsToEdit" character varying(60)[],
    document jsonb,
    "digitalSignature" text,
    "dateSigned" timestamp with time zone
);


ALTER TABLE public."PreActivityBookTransferSignatory" OWNER TO postgres;

--
-- Name: PreActivityBookTransferStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityBookTransferStatus" (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."PreActivityBookTransferStatus" OWNER TO postgres;

--
-- Name: PreActivityCashAdvance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityCashAdvance" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    purpose text,
    justification text,
    "evaluatedBy" integer,
    status smallint,
    filename text,
    "filenameToShow" text
);


ALTER TABLE public."PreActivityCashAdvance" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityCashAdvanceParticular" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "cashAdvance" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PreActivityCashAdvanceParticular" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityCashAdvanceSignatory" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "cashAdvance" integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    "sectionsToEdit" character varying(60)[],
    document jsonb,
    "digitalSignature" text,
    "dateSigned" timestamp with time zone
);


ALTER TABLE public."PreActivityCashAdvanceSignatory" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityCashAdvanceStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PreActivityCashAdvanceStatus" OWNER TO postgres;

--
-- Name: PreActivityDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityDirectPayment" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    "reasonForDelayedPRSProcessing" text,
    "galsFilename" text,
    "galsfilenameToShow" text,
    "fqFilename" text,
    "fqfilenameToShow" text,
    "rofFilename" text,
    "rofFilenameToShow" text,
    "evaluatedBy" integer,
    comments text,
    "dateEvaluated" timestamp with time zone,
    status smallint
);


ALTER TABLE public."PreActivityDirectPayment" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityDirectPaymentParticular" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE public."PreActivityDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityDirectPaymentSignatory" (
    id integer DEFAULT '-1'::integer NOT NULL,
    "directPayment" integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    "sectionsToEdit" character varying(60)[],
    document jsonb,
    "digitalSignature" text,
    "dateSigned" timestamp with time zone
);


ALTER TABLE public."PreActivityDirectPaymentSignatory" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."PreActivityDirectPaymentStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE public."PreActivityDirectPaymentStatus" OWNER TO postgres;

--
-- Name: projectproposalexpenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalexpenses (
    id integer DEFAULT '-1'::integer NOT NULL,
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    material character varying(45) NOT NULL,
    quantity integer NOT NULL,
    unitcost numeric(12,2) NOT NULL,
    type smallint DEFAULT 0 NOT NULL
);


ALTER TABLE public.projectproposalexpenses OWNER TO postgres;

--
-- Name: ProjectExpensesWithoutTransaction; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ProjectExpensesWithoutTransaction" AS
 SELECT ppe.id,
    ppe.projectproposal,
    ppe.sequence,
    ppe.material,
    ppe.quantity,
    ppe.unitcost,
    ppe.type
   FROM public.projectproposalexpenses ppe
  WHERE (NOT (ppe.id IN ( SELECT "PreActivityDirectPaymentParticular".particular
           FROM public."PreActivityDirectPaymentParticular"
        UNION
         SELECT "PreActivityCashAdvanceParticular".particular
           FROM public."PreActivityCashAdvanceParticular"
        UNION
         SELECT "PreActivityBookTransferParticular".particular
           FROM public."PreActivityBookTransferParticular"
        UNION
         SELECT "PostProjectReimbursementParticular".particular
           FROM public."PostProjectReimbursementParticular")));


ALTER TABLE public."ProjectExpensesWithoutTransaction" OWNER TO postgres;

--
-- Name: RateType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."RateType" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public."RateType" OWNER TO postgres;

--
-- Name: SystemConfiguration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."SystemConfiguration" (
    name character varying(20) NOT NULL,
    value json NOT NULL,
    description json NOT NULL
);


ALTER TABLE public."SystemConfiguration" OWNER TO postgres;

--
-- Name: VenueSize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."VenueSize" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public."VenueSize" OWNER TO postgres;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    idnumber integer NOT NULL,
    email character varying(255),
    type smallint DEFAULT 1,
    status smallint DEFAULT 3,
    password character(60) NOT NULL,
    salt character(29),
    firstname character varying(45),
    middlename character varying(45),
    lastname character varying(45),
    contactnumber character varying(16),
    privatekey text,
    publickey text,
    path_profilepicture text,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    datemodified timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    passwordexpiration timestamp with time zone
);


ALTER TABLE public.account OWNER TO postgres;

--
-- Name: accounttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.accounttype (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public.accounttype OWNER TO postgres;

--
-- Name: activityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activityattachmentrequirement (
    id integer NOT NULL,
    activitytype integer NOT NULL,
    attachment smallint NOT NULL,
    optional boolean DEFAULT false NOT NULL
);


ALTER TABLE public.activityattachmentrequirement OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.activityattachmentrequirement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.activityattachmentrequirement_id_seq OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.activityattachmentrequirement_id_seq OWNED BY public.activityattachmentrequirement.id;


--
-- Name: activitynature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activitynature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.activitynature OWNER TO postgres;

--
-- Name: activitytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.activitytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.activitytype OWNER TO postgres;

--
-- Name: amtactivityevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.amtactivityevaluation (
    activity integer NOT NULL,
    venue smallint,
    equipment smallint,
    materials smallint,
    registration smallint,
    timeend smallint,
    activityexecution smallint,
    hosts smallint,
    facilitators smallint,
    presentation smallint,
    activities smallint,
    organizationstandingpresentation smallint,
    timestart smallint,
    actualstarttime time with time zone,
    actualendtime time with time zone,
    anp integer,
    person1ea smallint,
    person1loa smallint,
    person1iitskoa smallint,
    person1iomwm smallint,
    person2ea smallint,
    person2loa smallint,
    person2iitskoa smallint,
    person2iomwm smallint,
    comments1 text,
    comments2 text,
    comments3 text,
    suggestions1 text,
    suggestions2 text,
    suggestions3 text,
    evaluator integer,
    status integer,
    datereserved timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    dateevaluated timestamp with time zone
);


ALTER TABLE public.amtactivityevaluation OWNER TO postgres;

--
-- Name: amtactivityevaluationstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.amtactivityevaluationstatus (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.amtactivityevaluationstatus OWNER TO postgres;

--
-- Name: college; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.college (
    shortacronym character(3) NOT NULL,
    fullacronym character varying(20),
    name character varying(60)
);


ALTER TABLE public.college OWNER TO postgres;

--
-- Name: documentattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.documentattachmentrequirement (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public.documentattachmentrequirement OWNER TO postgres;

--
-- Name: expensetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.expensetype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.expensetype OWNER TO postgres;

--
-- Name: functionality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.functionality (
    id integer NOT NULL,
    name character varying(100),
    category integer
);


ALTER TABLE public.functionality OWNER TO postgres;

--
-- Name: functionalitycategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.functionalitycategory (
    id integer NOT NULL,
    name character varying(45),
    domain smallint
);


ALTER TABLE public.functionalitycategory OWNER TO postgres;

--
-- Name: functionalitydomain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.functionalitydomain (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public.functionalitydomain OWNER TO postgres;

--
-- Name: gosm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gosm (
    id integer,
    termid integer NOT NULL,
    studentorganization integer NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    datesubmitted timestamp with time zone,
    datestatusmodified timestamp with time zone,
    preparedby integer,
    statusevaluator integer,
    comments text
);


ALTER TABLE public.gosm OWNER TO postgres;

--
-- Name: gosmactivity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gosmactivity (
    id integer NOT NULL,
    gosm integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    goals character varying(255) NOT NULL,
    objectives character varying(255)[] NOT NULL,
    strategies character varying(255) NOT NULL,
    description text NOT NULL,
    measures character varying(255) NOT NULL,
    targetdatestart date,
    targetdateend date,
    activitynature smallint,
    activitytype smallint,
    activitytypeotherdescription character varying(45),
    isrelatedtoorganizationnature boolean NOT NULL,
    budget numeric(12,2) DEFAULT 0.0 NOT NULL,
    comments text,
    isingosm boolean DEFAULT true,
    CONSTRAINT targetdate_start_end_value CHECK ((targetdatestart <= targetdateend))
);


ALTER TABLE public.gosmactivity OWNER TO postgres;

--
-- Name: gosmactivityprojecthead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gosmactivityprojecthead (
    idnumber integer NOT NULL,
    activityid integer NOT NULL
);


ALTER TABLE public.gosmactivityprojecthead OWNER TO postgres;

--
-- Name: gosmstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gosmstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public.gosmstatus OWNER TO postgres;

--
-- Name: organizationaccesscontrol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationaccesscontrol (
    role integer NOT NULL,
    functionality integer NOT NULL,
    isallowed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.organizationaccesscontrol OWNER TO postgres;

--
-- Name: organizationcluster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationcluster (
    id smallint NOT NULL,
    name character varying(128) NOT NULL,
    acronym character varying(20)
);


ALTER TABLE public.organizationcluster OWNER TO postgres;

--
-- Name: organizationfacultyadviser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationfacultyadviser (
    id integer NOT NULL,
    organization integer NOT NULL,
    faculty integer NOT NULL,
    yearid integer DEFAULT public.system_get_current_year_id() NOT NULL
);


ALTER TABLE public.organizationfacultyadviser OWNER TO postgres;

--
-- Name: organizationnature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationnature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    acronym character varying(10)
);


ALTER TABLE public.organizationnature OWNER TO postgres;

--
-- Name: organizationofficer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationofficer (
    idnumber integer NOT NULL,
    role integer NOT NULL,
    yearid integer NOT NULL,
    dateassigned timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    isactive boolean DEFAULT true
);


ALTER TABLE public.organizationofficer OWNER TO postgres;

--
-- Name: organizationrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationrole (
    id integer DEFAULT '-1'::integer,
    organization integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    name character varying(100),
    shortname character varying(16),
    rank integer,
    uniqueposition boolean DEFAULT false NOT NULL,
    masterrole integer,
    home_url text
);


ALTER TABLE public.organizationrole OWNER TO postgres;

--
-- Name: organizationstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizationstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE public.organizationstatus OWNER TO postgres;

--
-- Name: postactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.postactivityattachmentrequirement (
)
INHERITS (public.activityattachmentrequirement);


ALTER TABLE public.postactivityattachmentrequirement OWNER TO postgres;

--
-- Name: preactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.preactivityattachmentrequirement (
)
INHERITS (public.activityattachmentrequirement);


ALTER TABLE public.preactivityattachmentrequirement OWNER TO postgres;

--
-- Name: projectproposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposal (
    id integer DEFAULT '-1'::integer NOT NULL,
    gosmactivity integer NOT NULL,
    status integer DEFAULT 1 NOT NULL,
    enp integer,
    enmp integer,
    actualdatestart date,
    actualdateend date,
    venue integer,
    context1 text,
    context2 text,
    context3 text,
    isexpense boolean DEFAULT true NOT NULL,
    sourcefundother numeric(12,2),
    sourcefundparticipantfee numeric(12,2),
    sourcefundorganizational numeric(12,2),
    accumulatedoperationalfunds numeric(12,2),
    accumulateddepositoryfunds numeric(12,2),
    organizationfundothersource numeric(12,2),
    comments text,
    preparedby integer,
    facultyadviser integer,
    datecreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    datesubmitted timestamp with time zone,
    datestatusmodified timestamp with time zone,
    isattachmentscomplete boolean DEFAULT false NOT NULL,
    isbriefcontextcomplete boolean DEFAULT false NOT NULL,
    isexpensecomplete boolean DEFAULT false NOT NULL,
    isprogramcomplete boolean DEFAULT false NOT NULL,
    reschedulereason smallint,
    reschedreasonother text,
    rescheduledates date[],
    reschedrejectreason text DEFAULT ''::text,
    timespended integer DEFAULT 0 NOT NULL,
    venuefilename text,
    venuefilenametoshow text,
    venuecreated integer
);


ALTER TABLE public.projectproposal OWNER TO postgres;

--
-- Name: projectproposalattachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalattachment (
    id integer DEFAULT '-1'::integer NOT NULL,
    projectproposal integer NOT NULL,
    requirement smallint NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    idnumber integer,
    filename text,
    filenametoshow text,
    directory text NOT NULL
);


ALTER TABLE public.projectproposalattachment OWNER TO postgres;

--
-- Name: projectproposalprogramdesign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalprogramdesign (
    id integer DEFAULT '-1'::integer NOT NULL,
    projectproposal integer NOT NULL,
    dayid integer NOT NULL,
    sequence integer NOT NULL,
    date date,
    starttime time with time zone,
    endtime time with time zone,
    activity text,
    activitydescription text,
    personincharge integer,
    CONSTRAINT projectproposalprogramdesign_check CHECK ((starttime <= endtime))
);


ALTER TABLE public.projectproposalprogramdesign OWNER TO postgres;

--
-- Name: projectproposalprogramdesignpersonincharge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalprogramdesignpersonincharge (
    id integer DEFAULT '-1'::integer NOT NULL,
    programdesign integer NOT NULL,
    projecthead integer NOT NULL
);


ALTER TABLE public.projectproposalprogramdesignpersonincharge OWNER TO postgres;

--
-- Name: projectproposalprojectedincome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalprojectedincome (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    item character varying(45) NOT NULL,
    quantity integer NOT NULL,
    sellingprice numeric(12,2) NOT NULL
);


ALTER TABLE public.projectproposalprojectedincome OWNER TO postgres;

--
-- Name: projectproposalreschedulereason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalreschedulereason (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.projectproposalreschedulereason OWNER TO postgres;

--
-- Name: projectproposalsignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalsignatory (
    id integer DEFAULT '-1'::integer NOT NULL,
    gosmactivity integer NOT NULL,
    signatory integer NOT NULL,
    type smallint NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    comments text,
    sectionstoedit character varying(60)[],
    document jsonb,
    digitalsignature text,
    datesigned timestamp with time zone
);


ALTER TABLE public.projectproposalsignatory OWNER TO postgres;

--
-- Name: projectproposalsourcefunds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalsourcefunds (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    name character varying(45),
    amount numeric(12,2)
);


ALTER TABLE public.projectproposalsourcefunds OWNER TO postgres;

--
-- Name: projectproposalstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projectproposalstatus (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.projectproposalstatus OWNER TO postgres;

--
-- Name: schoolyear; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schoolyear (
    id integer,
    startyear smallint NOT NULL,
    endyear smallint NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    CONSTRAINT start_end_year_value CHECK ((startyear < endyear))
);


ALTER TABLE public.schoolyear OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- Name: signatorystatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.signatorystatus (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE public.signatorystatus OWNER TO postgres;

--
-- Name: signatorytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.signatorytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE public.signatorytype OWNER TO postgres;

--
-- Name: studentorganization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.studentorganization (
    id integer DEFAULT '-1'::integer NOT NULL,
    name character varying(128),
    status smallint DEFAULT 0,
    cluster smallint,
    nature smallint,
    college character(3),
    acronym character varying(20),
    description text,
    funds numeric(16,2) DEFAULT 0.0 NOT NULL,
    operationalfunds numeric(16,2) DEFAULT 0.0 NOT NULL,
    depositoryfunds numeric(16,2) DEFAULT 0.0 NOT NULL,
    depositryfunds numeric(16,2) DEFAULT 0.0 NOT NULL,
    path_profilepicture text,
    accountnumber character(7)
);


ALTER TABLE public.studentorganization OWNER TO postgres;

--
-- Name: term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.term (
    id integer DEFAULT '-1'::integer NOT NULL,
    schoolyearid integer NOT NULL,
    number integer NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    CONSTRAINT date_start_end_value CHECK ((datestart <= dateend)),
    CONSTRAINT number_max_value CHECK ((number <= 3)),
    CONSTRAINT number_min_value CHECK ((number >= 1))
);


ALTER TABLE public.term OWNER TO postgres;

--
-- Name: activityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('public.activityattachmentrequirement_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('public.activityattachmentrequirement_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Name: preactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('public.activityattachmentrequirement_id_seq'::regclass);


--
-- Name: preactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Data for Name: ARFOrganizationPosition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ARFOrganizationPosition" (id, name) FROM stdin;
0	Officer
1	Member
2	Non-member
\.


--
-- Data for Name: AccountNotification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountNotification" (id, account, sequence, status, date, title, description, details) FROM stdin;
1	4111112	1	0	2018-01-10 18:30:36.810643+08	GOSM Submission	GOSM for current has been submitted	null
2	1111112	1	0	2018-01-10 18:35:50.209836+08	GOSM Submission	GOSM for current has been submitted	null
3	7111112	1	0	2018-01-10 18:36:12.822349+08	GOSM Submission	GOSM for current has been submitted	null
4	2111112	1	0	2018-01-10 18:59:38.515914+08	GOSM Submission	GOSM for current has been submitted	null
5	3111112	1	0	2018-01-10 19:15:35.546937+08	GOSM Submission	GOSM for current has been submitted	null
6	3111113	1	0	2018-01-10 19:15:35.546937+08	GOSM Submission	GOSM for current has been submitted	null
7	6111112	1	0	2018-01-10 19:16:28.954628+08	GOSM Submission	GOSM for current has been submitted	null
8	8111112	1	0	2018-01-10 19:19:15.428686+08	GOSM Submission	GOSM for current has been submitted	null
9	10111112	1	0	2018-01-10 19:32:39.796238+08	GOSM Submission	GOSM for current has been submitted	null
10	9111112	1	0	2018-01-10 19:44:22.374649+08	GOSM Submission	GOSM for current has been submitted	null
11	1111111	1	0	2018-01-10 19:47:24.770956+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Executive Chairperson External	{"GOSMID":100001,"evaluator":1011118,"statusID":3}
12	3111111	1	0	2018-01-10 19:54:54.782232+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Executive Chairperson External	{"GOSMID":1000009,"evaluator":1011118,"statusID":3}
14	4111111	1	0	2018-01-10 20:56:04.258308+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Executive Chairperson External	{"GOSMID":1100002,"evaluator":1011118,"statusID":3}
15	6111111	1	0	2018-01-10 20:56:14.273541+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Executive Chairperson External	{"GOSMID":1300005,"evaluator":1011118,"statusID":3}
13	8111111	1	1	2018-01-10 20:30:58.670464+08	GOSM Evaluation	The organization's GOSM have been peended by CSO Executive Chairperson External	{"GOSMID":1500007,"comments":"Please put spritual activity","evaluator":1011118,"statusID":4}
17	8111112	2	0	2018-01-10 21:09:42.506936+08	GOSM Submission	GOSM for current has been submitted	null
19	10111111	1	1	2018-04-10 21:13:51.983946+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Chairperson	{"GOSMID":1700008,"evaluator":1011117,"statusID":3}
20	1111114	1	1	2018-01-10 21:32:28.682342+08	New Project Proposal	Please check activity Connecting Java to MySQL	null
16	7111111	1	1	2018-01-10 20:56:23.612605+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Executive Chairperson External	{"GOSMID":1400003,"evaluator":1011118,"statusID":3}
24	10111114	1	1	2018-01-10 21:47:44.190732+08	New Project Proposal	Please check activity Corporate Social Responsibility 	null
27	1111116	1	0	2018-01-10 21:50:15.86212+08	New Project Proposal	Please check activity Server Side API: Firebase	null
21	1111114	2	1	2018-01-10 21:39:59.843029+08	New Project Proposal	Please check activity Basic Photoshop Workshop	null
22	1111114	3	1	2018-01-10 21:43:20.606937+08	New Project Proposal	Please check activity Mobile UI Seminar	null
23	1111114	4	1	2018-01-10 21:45:19.240348+08	New Project Proposal	Please check activity Last Programmer Standing	null
25	1111114	5	1	2018-01-10 21:48:44.077825+08	New Project Proposal	Please check activity Stay Sharp: C#	null
26	1111114	6	1	2018-01-10 21:50:15.86212+08	New Project Proposal	Please check activity Server Side API: Firebase	null
29	4111114	1	0	2018-01-10 21:53:13.013545+08	New Project Proposal	Please check activity Photoshop Series 1: Basic	null
30	4111115	1	0	2018-01-10 21:53:13.013545+08	New Project Proposal	Please check activity Photoshop Series 1: Basic	null
32	7111116	1	0	2018-01-10 21:53:54.928136+08	New Project Proposal	Please check activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
35	4111114	2	0	2018-01-10 21:58:54.062857+08	New Project Proposal	Please check activity Photoshop Series 2: Intermediate	null
31	7111114	1	1	2018-01-10 21:53:54.928136+08	New Project Proposal	Please check activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
38	10111116	1	0	2018-01-10 22:00:40.795121+08	New Project Proposal	Please check activity SOCPSYC Reviewer	null
40	7111116	2	0	2018-01-10 22:00:41.2196+08	New Project Proposal	Please check activity #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
37	10111114	2	1	2018-01-10 22:00:40.795121+08	New Project Proposal	Please check activity SOCPSYC Reviewer	null
39	7111114	2	1	2018-01-10 22:00:41.2196+08	New Project Proposal	Please check activity #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
28	1111114	7	1	2018-01-10 21:52:35.744671+08	New Project Proposal	Please check activity Denki Megatech Convention 2016	null
33	1111114	8	1	2018-01-10 21:55:28.20484+08	New Project Proposal	Please check activity MyCareer	null
34	1111114	9	1	2018-01-10 21:58:04.913559+08	New Project Proposal	Please check activity Computer Literacy Program	null
36	1111114	10	1	2018-01-10 21:59:38.469082+08	New Project Proposal	Please check activity Nook Supplies	null
18	8111111	2	1	2018-01-10 21:10:36.791961+08	GOSM Evaluation	The organization's GOSM have been approved by CSO Chairperson	{"GOSMID":1500007,"evaluator":1011117,"statusID":3}
41	1111115	1	0	2018-01-10 22:09:22.946545+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
43	1111115	2	0	2018-01-10 22:09:45.252708+08	Project Proposal Evaluation	Please evaluate Basic Photoshop Workshop	null
45	1111115	3	0	2018-01-10 22:09:56.321541+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
47	1111115	4	0	2018-01-10 22:10:02.286423+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
49	4111112	2	0	2018-01-10 22:17:26.514056+08	New Project Proposal	Please check activity Photoshop Series 3: Advanced	null
50	4111114	3	0	2018-01-10 22:17:26.514056+08	New Project Proposal	Please check activity Photoshop Series 3: Advanced	null
42	1111114	11	1	2018-01-10 22:09:22.946545+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by OrganizationAVP - Documentation	null
44	1111114	12	1	2018-01-10 22:09:45.252708+08	Project Proposal Evaluation	Your activity Basic Photoshop Workshop has been pended by OrganizationAVP - Documentation	null
46	1111114	13	1	2018-01-10 22:09:56.321541+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by OrganizationAVP - Documentation	null
53	1111115	5	0	2018-01-10 22:18:45.766112+08	Project Proposal Evaluation	Please evaluate General Assembly	null
54	1111114	16	0	2018-01-10 22:18:45.766112+08	Project Proposal Evaluation	Your activity General Assembly has been approved by OrganizationAVP - Documentation	null
55	1111115	6	0	2018-01-10 22:18:54.31048+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
56	1111114	17	0	2018-01-10 22:18:54.31048+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by OrganizationAVP - Documentation	null
52	10111114	3	1	2018-01-10 22:18:01.759562+08	New Project Proposal	Please check activity SOCRES2 Reviewer	null
48	1111114	14	1	2018-01-10 22:10:02.286423+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by OrganizationAVP - Documentation	null
51	1111114	15	1	2018-01-10 22:17:56.740832+08	New Project Proposal	Please check activity General Assembly	null
57	1111113	1	0	2018-01-10 22:25:20.891275+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
58	1111114	18	0	2018-01-10 22:25:20.891275+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by OrganizationVP - Finance	null
60	1111113	2	0	2018-01-10 22:26:50.07045+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
61	1111114	19	0	2018-01-10 22:26:50.07045+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by OrganizationVP - Finance	null
62	1111113	3	0	2018-01-10 22:27:17.097392+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
63	1111114	20	0	2018-01-10 22:27:17.097392+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by OrganizationVP - Finance	null
64	1111113	4	0	2018-01-10 22:27:38.270035+08	Project Proposal Evaluation	Please evaluate General Assembly	null
65	1111114	21	0	2018-01-10 22:27:38.270035+08	Project Proposal Evaluation	Your activity General Assembly has been approved by OrganizationVP - Finance	null
66	1111113	5	0	2018-01-10 22:27:44.321091+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
67	1111114	22	0	2018-01-10 22:27:44.321091+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by OrganizationVP - Finance	null
68	1111111	2	0	2018-01-10 22:28:33.798199+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
69	1111114	23	0	2018-01-10 22:28:33.798199+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by OrganizationVP - Documentation	null
70	1111111	3	0	2018-01-10 22:28:40.362346+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
71	1111114	24	0	2018-01-10 22:28:40.362346+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by OrganizationVP - Documentation	null
72	1111111	4	0	2018-01-10 22:28:45.911183+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
73	1111114	25	0	2018-01-10 22:28:45.911183+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by OrganizationVP - Documentation	null
74	1111111	5	0	2018-01-10 22:28:57.064011+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
75	1111114	26	0	2018-01-10 22:28:57.064011+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by OrganizationVP - Documentation	null
76	1111111	6	0	2018-01-10 22:29:03.24385+08	Project Proposal Evaluation	Please evaluate General Assembly	null
77	1111114	27	0	2018-01-10 22:29:03.24385+08	Project Proposal Evaluation	Your activity General Assembly has been approved by OrganizationVP - Documentation	null
79	7111116	3	0	2018-01-10 22:29:17.011505+08	New Project Proposal	Please check activity Annual Recruitment Week	null
80	2011111	1	0	2018-01-10 22:29:29.260299+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
81	1111114	28	0	2018-01-10 22:29:29.260299+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by OrganizationPresident	null
82	2011111	2	0	2018-01-10 22:29:36.696213+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
83	1111114	29	0	2018-01-10 22:29:36.696213+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by OrganizationPresident	null
84	2011111	3	0	2018-01-10 22:29:42.763994+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
85	1111114	30	0	2018-01-10 22:29:42.763994+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by OrganizationPresident	null
86	2011111	4	0	2018-01-10 22:29:48.05782+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
87	1111114	31	0	2018-01-10 22:29:48.05782+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by OrganizationPresident	null
88	2011111	5	0	2018-01-10 22:29:53.482181+08	Project Proposal Evaluation	Please evaluate General Assembly	null
89	1111114	32	0	2018-01-10 22:29:53.482181+08	Project Proposal Evaluation	Your activity General Assembly has been approved by OrganizationPresident	null
90	1011121	1	0	2018-01-10 22:30:16.919363+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
91	1111114	33	0	2018-01-10 22:30:16.919363+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by Renato JoseMolano	null
92	1011121	2	0	2018-01-10 22:30:26.815473+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
93	1111114	34	0	2018-01-10 22:30:26.815473+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by Renato JoseMolano	null
94	1011121	3	0	2018-01-10 22:30:34.526647+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
95	1111114	35	0	2018-01-10 22:30:34.526647+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by Renato JoseMolano	null
97	1011121	4	0	2018-01-10 22:31:00.860046+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
98	1111114	36	0	2018-01-10 22:31:00.860046+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by Renato JoseMolano	null
99	1011121	5	0	2018-01-10 22:31:13.517479+08	Project Proposal Evaluation	Please evaluate General Assembly	null
100	1111114	37	0	2018-01-10 22:31:13.517479+08	Project Proposal Evaluation	Your activity General Assembly has been approved by Renato JoseMolano	null
101	1011120	1	0	2018-01-10 22:32:02.003273+08	Project Proposal Evaluation	Please evaluate Connecting Java to MySQL	null
102	1111114	38	0	2018-01-10 22:32:02.003273+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by CSOA - APS	null
103	1011120	2	0	2018-01-10 22:32:09.053674+08	Project Proposal Evaluation	Please evaluate Mobile UI Seminar	null
104	1111114	39	0	2018-01-10 22:32:09.053674+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by CSOA - APS	null
105	1011120	3	0	2018-01-10 22:32:14.78854+08	Project Proposal Evaluation	Please evaluate Last Programmer Standing	null
106	1111114	40	0	2018-01-10 22:32:14.78854+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by CSOA - APS	null
107	1011120	4	0	2018-01-10 22:32:27.009126+08	Project Proposal Evaluation	Please evaluate General Assembly	null
108	1111114	41	0	2018-01-10 22:32:27.009126+08	Project Proposal Evaluation	Your activity General Assembly has been approved by CSOA - APS	null
109	1011120	5	0	2018-01-10 22:32:36.91952+08	Project Proposal Evaluation	Please evaluate Computer Literacy Program	null
78	7111114	3	1	2018-01-10 22:29:17.011505+08	New Project Proposal	Please check activity Annual Recruitment Week	null
59	10111114	4	1	2018-01-10 22:25:45.116766+08	New Project Proposal	Please check activity HISTSO2 Reviewer	null
110	1111114	42	0	2018-01-10 22:32:36.91952+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by CSOA - APS	null
111	4111114	4	0	2018-01-10 22:33:47.22055+08	New Project Proposal	Please check activity MooMedia: 1st General Assembly	null
112	1111114	43	0	2018-01-10 22:33:49.492983+08	Project Proposal Evaluation	Your activity Connecting Java to MySQL has been approved by CSOAVC - APS	null
113	1111114	44	0	2018-01-10 22:33:57.636838+08	Project Proposal Evaluation	Your activity Mobile UI Seminar has been approved by CSOAVC - APS	null
114	1111114	45	0	2018-01-10 22:34:03.803262+08	Project Proposal Evaluation	Your activity Last Programmer Standing has been approved by CSOAVC - APS	null
116	1111114	46	0	2018-01-10 22:34:14.77763+08	Project Proposal Evaluation	Your activity General Assembly has been approved by CSOAVC - APS	null
117	1111114	47	0	2018-01-10 22:34:24.629793+08	Project Proposal Evaluation	Your activity Computer Literacy Program has been approved by CSOAVC - APS	null
96	7111114	4	1	2018-01-10 22:30:42.936133+08	New Project Proposal	Please check activity 1st General Assembly and Turn-over Ceremony	null
115	7111114	5	1	2018-01-10 22:34:08.224238+08	New Project Proposal	Please check activity Let's ECO: An ECO Team Building	null
118	4111115	2	0	2018-01-10 22:35:21.504345+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
119	4111114	5	0	2018-01-10 22:35:21.504345+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by Organization4AVP - Documentation	null
120	4111115	3	0	2018-01-10 22:35:29.932292+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
121	4111114	6	0	2018-01-10 22:35:29.932292+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4AVP - Documentation	null
122	4111115	4	0	2018-01-10 22:35:29.932292+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4AVP - Documentation	null
123	4111115	5	0	2018-01-10 22:35:36.539422+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
124	4111114	7	0	2018-01-10 22:35:36.539422+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by Organization4AVP - Documentation	null
125	4111113	1	0	2018-01-10 22:39:35.782507+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
126	4111114	8	0	2018-01-10 22:39:35.782507+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by Organization4VP - Finance	null
127	4111113	2	0	2018-01-10 22:39:47.696565+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
128	4111114	9	0	2018-01-10 22:39:47.696565+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4VP - Finance	null
129	4111115	6	0	2018-01-10 22:39:47.696565+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4VP - Finance	null
131	4111113	3	0	2018-01-10 22:49:46.590266+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
132	4111114	10	0	2018-01-10 22:49:46.590266+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by Organization4VP - Finance	null
133	4111111	2	0	2018-01-10 22:50:33.551343+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
134	4111114	11	0	2018-01-10 22:50:33.551343+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4VP - Documentation	null
135	4111115	7	0	2018-01-10 22:50:33.551343+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4VP - Documentation	null
136	4111111	3	0	2018-01-10 22:50:39.794181+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
137	4111114	12	0	2018-01-10 22:50:39.794181+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by Organization4VP - Documentation	null
138	4111111	4	0	2018-01-10 22:50:46.236218+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
139	4111114	13	0	2018-01-10 22:50:46.236218+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by Organization4VP - Documentation	null
140	2011112	1	0	2018-01-10 22:52:01.124745+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
141	4111114	14	0	2018-01-10 22:52:01.124745+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4President	null
142	4111115	8	0	2018-01-10 22:52:01.124745+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by Organization4President	null
143	2011111	6	0	2018-01-10 22:52:06.074281+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
144	4111114	15	0	2018-01-10 22:52:06.074281+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by Organization4President	null
145	2011111	7	0	2018-01-10 22:52:12.437791+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
146	4111114	16	0	2018-01-10 22:52:12.437791+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by Organization4President	null
147	1011121	6	0	2018-01-10 22:54:43.997914+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
148	4111114	17	0	2018-01-10 22:54:43.997914+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by Renato JoseMolano	null
149	1011121	7	0	2018-01-10 22:55:40.664019+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
150	4111114	18	0	2018-01-10 22:55:40.664019+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by EdwardTighe	null
151	4111115	9	0	2018-01-10 22:55:40.664019+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by EdwardTighe	null
152	1011121	8	0	2018-01-10 22:56:06.035477+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
153	4111114	19	0	2018-01-10 22:56:06.035477+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by Renato JoseMolano	null
130	10111114	5	1	2018-01-10 22:48:56.894334+08	New Project Proposal	Please check activity Green Card Alliance	null
154	10111114	6	1	2018-01-10 22:58:19.266276+08	New Project Proposal	Please check activity Officers Training Program	null
155	4111114	20	0	2018-01-10 23:05:42.667411+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
156	4111112	3	0	2018-01-10 23:05:42.667411+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Internal	null
157	4111114	21	0	2018-01-10 23:05:42.667411+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Internal	null
158	4111115	10	0	2018-01-10 23:10:17.204172+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
159	4111112	4	0	2018-01-10 23:10:17.204172+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4AVP - Documentation	null
160	4111114	22	0	2018-01-10 23:10:17.204172+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4AVP - Documentation	null
161	4111113	4	0	2018-01-10 23:11:09.74277+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
162	4111112	5	0	2018-01-10 23:11:09.74277+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Finance	null
163	4111114	23	0	2018-01-10 23:11:09.74277+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Finance	null
164	4111111	5	0	2018-01-10 23:12:05.204444+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
165	4111112	6	0	2018-01-10 23:12:05.204444+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Documentation	null
166	4111114	24	0	2018-01-10 23:12:05.204444+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4VP - Documentation	null
168	2011111	8	0	2018-01-10 23:12:35.444976+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
169	4111112	7	0	2018-01-10 23:12:35.444976+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4President	null
170	4111114	25	0	2018-01-10 23:12:35.444976+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Organization4President	null
171	1011121	9	0	2018-01-10 23:13:11.856954+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
172	4111112	8	0	2018-01-10 23:13:11.856954+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Renato JoseMolano	null
173	4111114	26	0	2018-01-10 23:13:11.856954+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by Renato JoseMolano	null
174	7111114	6	0	2018-01-10 23:13:13.973541+08	New Project Proposal	Please check activity ECOntrol: Waste Analysis and Characterization Study	null
175	7111116	4	0	2018-01-10 23:13:13.973541+08	New Project Proposal	Please check activity ECOntrol: Waste Analysis and Characterization Study	null
176	1011120	6	0	2018-01-10 23:16:19.784618+08	Project Proposal Evaluation	Please evaluate Photoshop Series 3: Advanced	null
177	4111112	9	0	2018-01-10 23:16:19.784618+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by CSOA - APS	null
178	4111114	27	0	2018-01-10 23:16:19.784618+08	Project Proposal Evaluation	Your activity Photoshop Series 3: Advanced has been approved by CSOA - APS	null
180	7111114	7	0	2018-01-10 23:18:31.222625+08	New Project Proposal	Please check activity #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG)	null
181	1011120	7	0	2018-01-10 23:20:44.353064+08	Project Proposal Evaluation	Please evaluate Photoshop Series 2: Intermediate	null
182	4111114	28	0	2018-01-10 23:20:44.353064+08	Project Proposal Evaluation	Your activity Photoshop Series 2: Intermediate has been approved by CSOA - APS	null
183	1011120	8	0	2018-01-10 23:21:01.677457+08	Project Proposal Evaluation	Please evaluate Photoshop Series 1: Basic	null
184	4111114	29	0	2018-01-10 23:21:01.677457+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by CSOA - APS	null
185	4111115	11	0	2018-01-10 23:21:01.677457+08	Project Proposal Evaluation	Your activity Photoshop Series 1: Basic has been approved by CSOA - APS	null
186	1011120	9	0	2018-01-10 23:21:15.386723+08	Project Proposal Evaluation	Please evaluate MooMedia: 1st General Assembly	null
187	4111114	30	0	2018-01-10 23:21:15.386723+08	Project Proposal Evaluation	Your activity MooMedia: 1st General Assembly has been approved by CSOA - APS	null
190	7111114	8	0	2018-01-10 23:26:43.505528+08	New Project Proposal	Please check activity All Forms of Life is Important: Bird Race	null
191	7111116	5	0	2018-01-10 23:26:43.505528+08	New Project Proposal	Please check activity All Forms of Life is Important: Bird Race	null
192	7111114	9	0	2018-01-10 23:28:24.562857+08	New Project Proposal	Please check activity ECO Gives Back: A Christmas Celebration with the Kids	null
193	7111116	6	0	2018-01-10 23:28:24.562857+08	New Project Proposal	Please check activity ECO Gives Back: A Christmas Celebration with the Kids	null
194	7111116	7	0	2018-01-10 23:28:48.587775+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
195	7111114	10	0	2018-01-10 23:28:48.587775+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7AVP - Documentation	null
196	7111116	8	0	2018-01-10 23:28:48.587775+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7AVP - Documentation	null
198	7111116	9	0	2018-01-10 23:28:55.252543+08	Project Proposal Evaluation	Please evaluate #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
199	7111114	11	0	2018-01-10 23:28:55.252543+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7AVP - Documentation	null
200	7111116	10	0	2018-01-10 23:28:55.252543+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7AVP - Documentation	null
167	3111114	1	1	2018-01-10 23:12:16.928111+08	New Project Proposal	Please check activity Talent Management	null
179	3111114	2	1	2018-01-10 23:16:30.501087+08	New Project Proposal	Please check activity Operations Summit 	null
188	3111114	3	1	2018-01-10 23:21:52.778067+08	New Project Proposal	Please check activity OGX-Po	null
189	3111114	4	1	2018-01-10 23:25:17.973024+08	New Project Proposal	Please check activity October - Local Committee Meeting	null
197	3111114	5	1	2018-01-10 23:28:50.255316+08	New Project Proposal	Please check activity Sales Development Programme 2.0	null
201	7111116	11	0	2018-01-10 23:29:01.682939+08	Project Proposal Evaluation	Please evaluate Annual Recruitment Week	null
202	7111114	12	0	2018-01-10 23:29:01.682939+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7AVP - Documentation	null
203	7111116	12	0	2018-01-10 23:29:01.682939+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7AVP - Documentation	null
204	7111115	1	0	2018-01-10 23:29:06.566866+08	Project Proposal Evaluation	Please evaluate 1st General Assembly and Turn-over Ceremony	null
205	7111114	13	0	2018-01-10 23:29:06.566866+08	Project Proposal Evaluation	Your activity 1st General Assembly and Turn-over Ceremony has been approved by Organization7AVP - Documentation	null
206	10111114	7	0	2018-01-10 23:29:10.594712+08	New Project Proposal	Please check activity AVP Applications	null
207	7111116	13	0	2018-01-10 23:29:11.095178+08	Project Proposal Evaluation	Please evaluate ECOntrol: Waste Analysis and Characterization Study	null
208	7111114	14	0	2018-01-10 23:29:11.095178+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7AVP - Documentation	null
209	7111116	14	0	2018-01-10 23:29:11.095178+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7AVP - Documentation	null
210	7111115	2	0	2018-01-10 23:29:20.625257+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
211	7111114	15	0	2018-01-10 23:29:20.625257+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7AVP - Documentation	null
212	7111115	3	0	2018-01-10 23:29:27.265469+08	Project Proposal Evaluation	Please evaluate #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG)	null
213	7111114	16	0	2018-01-10 23:29:27.265469+08	Project Proposal Evaluation	Your activity #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG) has been approved by Organization7AVP - Documentation	null
214	7111116	15	0	2018-01-10 23:29:49.301931+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
215	7111114	17	0	2018-01-10 23:29:49.301931+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7AVP - Documentation	null
216	7111116	16	0	2018-01-10 23:29:49.301931+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7AVP - Documentation	null
217	7111116	17	0	2018-01-10 23:29:58.120414+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
218	7111114	18	0	2018-01-10 23:29:58.120414+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7AVP - Documentation	null
219	7111116	18	0	2018-01-10 23:29:58.120414+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7AVP - Documentation	null
220	3111114	6	0	2018-01-10 23:30:22.275904+08	New Project Proposal	Please check activity Activation Camp 	null
221	7111115	4	0	2018-01-10 23:31:36.367793+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
222	7111114	19	0	2018-01-10 23:31:36.367793+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7AVP - Finance	null
223	7111116	19	0	2018-01-10 23:31:36.367793+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7AVP - Finance	null
224	7111115	5	0	2018-01-10 23:31:54.423297+08	Project Proposal Evaluation	Please evaluate #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
225	7111114	20	0	2018-01-10 23:31:54.423297+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7AVP - Finance	null
226	7111116	20	0	2018-01-10 23:31:54.423297+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7AVP - Finance	null
227	7111115	6	0	2018-01-10 23:32:06.408233+08	Project Proposal Evaluation	Please evaluate Annual Recruitment Week	null
228	7111114	21	0	2018-01-10 23:32:06.408233+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7AVP - Finance	null
229	7111116	21	0	2018-01-10 23:32:06.408233+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7AVP - Finance	null
230	7111115	7	0	2018-01-10 23:32:20.546813+08	Project Proposal Evaluation	Please evaluate ECOntrol: Waste Analysis and Characterization Study	null
231	7111114	22	0	2018-01-10 23:32:20.546813+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7AVP - Finance	null
232	7111116	22	0	2018-01-10 23:32:20.546813+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7AVP - Finance	null
233	7111115	8	0	2018-01-10 23:32:37.427929+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
234	7111114	23	0	2018-01-10 23:32:37.427929+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7AVP - Finance	null
235	7111116	23	0	2018-01-10 23:32:37.427929+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7AVP - Finance	null
236	3111114	7	0	2018-01-10 23:32:41.728252+08	New Project Proposal	Please check activity Intership Phase	null
237	7111115	9	0	2018-01-10 23:32:51.61954+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
238	7111114	24	0	2018-01-10 23:32:51.61954+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7AVP - Finance	null
239	7111116	24	0	2018-01-10 23:32:51.61954+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7AVP - Finance	null
240	3111114	8	0	2018-01-10 23:34:07.336749+08	New Project Proposal	Please check activity Global Goals Weeks	null
241	3111114	9	0	2018-01-10 23:35:40.068001+08	New Project Proposal	Please check activity Organizing Committee Track	null
242	7111113	1	0	2018-01-10 23:35:42.519177+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
243	7111114	25	0	2018-01-10 23:35:42.519177+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7VP - Finance	null
244	7111116	25	0	2018-01-10 23:35:42.519177+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7VP - Finance	null
245	7111113	2	0	2018-01-10 23:37:21.147076+08	Project Proposal Evaluation	Please evaluate #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
246	7111114	26	0	2018-01-10 23:37:21.147076+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7VP - Finance	null
247	7111116	26	0	2018-01-10 23:37:21.147076+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7VP - Finance	null
248	7111113	3	0	2018-01-10 23:37:36.229289+08	Project Proposal Evaluation	Please evaluate 1st General Assembly and Turn-over Ceremony	null
249	7111114	27	0	2018-01-10 23:37:36.229289+08	Project Proposal Evaluation	Your activity 1st General Assembly and Turn-over Ceremony has been approved by Organization7VP - Finance	null
250	7111113	4	0	2018-01-10 23:37:37.580974+08	Project Proposal Evaluation	Please evaluate Annual Recruitment Week	null
251	7111114	28	0	2018-01-10 23:37:37.580974+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7VP - Finance	null
252	7111116	27	0	2018-01-10 23:37:37.580974+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7VP - Finance	null
253	7111113	5	0	2018-01-10 23:37:47.986854+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
254	7111114	29	0	2018-01-10 23:37:47.986854+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7VP - Finance	null
255	7111113	6	0	2018-01-10 23:37:51.086573+08	Project Proposal Evaluation	Please evaluate ECOntrol: Waste Analysis and Characterization Study	null
256	7111114	30	0	2018-01-10 23:37:51.086573+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7VP - Finance	null
257	7111116	28	0	2018-01-10 23:37:51.086573+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7VP - Finance	null
258	7111113	7	0	2018-01-10 23:37:53.910261+08	Project Proposal Evaluation	Please evaluate #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG)	null
259	7111114	31	0	2018-01-10 23:37:53.910261+08	Project Proposal Evaluation	Your activity #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG) has been approved by Organization7VP - Finance	null
260	7111113	8	0	2018-01-10 23:37:55.281593+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
261	7111114	32	0	2018-01-10 23:37:55.281593+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Finance	null
262	7111116	29	0	2018-01-10 23:37:55.281593+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Finance	null
263	10111114	8	0	2018-01-10 23:38:30.148552+08	New Project Proposal	Please check activity Frosh Welcoming 	null
264	10111116	2	0	2018-01-10 23:38:30.148552+08	New Project Proposal	Please check activity Frosh Welcoming 	null
265	3111115	1	0	2018-01-10 23:39:01.42692+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
266	3111114	10	0	2018-01-10 23:39:01.42692+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by Organization3AVP - Documentation	null
267	3111115	2	0	2018-01-10 23:39:12.110939+08	Project Proposal Evaluation	Please evaluate Talent Management	null
268	3111114	11	0	2018-01-10 23:39:12.110939+08	Project Proposal Evaluation	Your activity Talent Management has been approved by Organization3AVP - Documentation	null
269	3111115	3	0	2018-01-10 23:39:18.586896+08	Project Proposal Evaluation	Please evaluate Operations Summit 	null
270	3111114	12	0	2018-01-10 23:39:18.586896+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by Organization3AVP - Documentation	null
271	3111115	4	0	2018-01-10 23:39:25.547574+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
272	3111114	13	0	2018-01-10 23:39:25.547574+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by Organization3AVP - Documentation	null
273	3111115	5	0	2018-01-10 23:39:30.974716+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
274	3111114	14	0	2018-01-10 23:39:30.974716+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by Organization3AVP - Documentation	null
275	3111115	6	0	2018-01-10 23:39:47.560714+08	Project Proposal Evaluation	Please evaluate Intership Phase	null
276	3111114	15	0	2018-01-10 23:39:47.560714+08	Project Proposal Evaluation	Your activity Intership Phase has been pended by Organization3AVP - Documentation	null
277	7111113	9	0	2018-01-10 23:40:19.414429+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
278	7111114	33	0	2018-01-10 23:40:19.414429+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Finance	null
279	7111116	30	0	2018-01-10 23:40:19.414429+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Finance	null
280	3111113	2	0	2018-01-10 23:40:39.555536+08	Project Proposal Evaluation	Please evaluate Talent Management	null
281	3111114	16	0	2018-01-10 23:40:39.555536+08	Project Proposal Evaluation	Your activity Talent Management has been approved by Organization3VP - Finance	null
282	3111113	3	0	2018-01-10 23:40:46.040139+08	Project Proposal Evaluation	Please evaluate Operations Summit 	null
283	3111114	17	0	2018-01-10 23:40:46.040139+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by Organization3VP - Finance	null
284	3111113	4	0	2018-01-10 23:41:00.355698+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
285	3111114	18	0	2018-01-10 23:41:00.355698+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by Organization3VP - Finance	null
286	3111113	5	0	2018-01-10 23:41:08.177205+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
287	3111114	19	0	2018-01-10 23:41:08.177205+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by Organization3VP - Finance	null
288	3111113	6	0	2018-01-10 23:41:15.838703+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
289	3111114	20	0	2018-01-10 23:41:15.838703+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by Organization3VP - Finance	null
290	3111111	2	0	2018-01-10 23:42:21.551802+08	Project Proposal Evaluation	Please evaluate Talent Management	null
291	3111114	21	0	2018-01-10 23:42:21.551802+08	Project Proposal Evaluation	Your activity Talent Management has been approved by Organization3VP - Documentation	null
292	3111111	3	0	2018-01-10 23:42:29.215455+08	Project Proposal Evaluation	Please evaluate Operations Summit 	null
293	3111114	22	0	2018-01-10 23:42:29.215455+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by Organization3VP - Documentation	null
294	3111111	4	0	2018-01-10 23:42:44.735353+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
295	3111114	23	0	2018-01-10 23:42:44.735353+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by Organization3VP - Documentation	null
296	3111111	5	0	2018-01-10 23:42:56.055253+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
297	3111114	24	0	2018-01-10 23:42:56.055253+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by Organization3VP - Documentation	null
298	3111111	6	0	2018-01-10 23:43:06.408796+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
299	3111114	25	0	2018-01-10 23:43:06.408796+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by Organization3VP - Documentation	null
300	2011111	9	0	2018-01-10 23:43:25.268659+08	Project Proposal Evaluation	Please evaluate Talent Management	null
301	3111114	26	0	2018-01-10 23:43:25.268659+08	Project Proposal Evaluation	Your activity Talent Management has been approved by Organization3President	null
302	2011111	10	0	2018-01-10 23:43:30.340588+08	Project Proposal Evaluation	Please evaluate Operations Summit 	null
303	3111114	27	0	2018-01-10 23:43:30.340588+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by Organization3President	null
304	2011111	11	0	2018-01-10 23:43:43.790822+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
305	3111114	28	0	2018-01-10 23:43:43.790822+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by Organization3President	null
306	2011111	12	0	2018-01-10 23:43:49.998922+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
307	3111114	29	0	2018-01-10 23:43:49.998922+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by Organization3President	null
308	2011111	13	0	2018-01-10 23:43:58.701773+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
309	3111114	30	0	2018-01-10 23:43:58.701773+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by Organization3President	null
310	1011121	10	0	2018-01-10 23:46:21.28332+08	Project Proposal Evaluation	Please evaluate Talent Management	null
311	3111114	31	0	2018-01-10 23:46:21.28332+08	Project Proposal Evaluation	Your activity Talent Management has been approved by Renato JoseMolano	null
312	7111111	2	0	2018-01-10 23:46:28.377733+08	Project Proposal Evaluation	Please evaluate ECOntrol: Waste Analysis and Characterization Study	null
313	7111114	34	0	2018-01-10 23:46:28.377733+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7VP - Documentation	null
314	7111116	31	0	2018-01-10 23:46:28.377733+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7VP - Documentation	null
315	7111111	3	0	2018-01-10 23:46:31.698542+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
316	7111114	35	0	2018-01-10 23:46:31.698542+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
317	7111116	32	0	2018-01-10 23:46:31.698542+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
318	7111111	4	0	2018-01-10 23:46:33.946093+08	Project Proposal Evaluation	Please evaluate #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG)	null
319	7111114	36	0	2018-01-10 23:46:33.946093+08	Project Proposal Evaluation	Your activity #ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG) has been approved by Organization7VP - Documentation	null
320	7111111	5	0	2018-01-10 23:46:35.838913+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
321	7111114	37	0	2018-01-10 23:46:35.838913+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
322	7111116	33	0	2018-01-10 23:46:35.838913+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
323	7111111	6	0	2018-01-10 23:46:38.041266+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
324	7111114	38	0	2018-01-10 23:46:38.041266+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
325	7111116	34	0	2018-01-10 23:46:38.041266+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
326	7111111	7	0	2018-01-10 23:46:42.16262+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
327	7111114	39	0	2018-01-10 23:46:42.16262+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
328	7111116	35	0	2018-01-10 23:46:42.16262+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
329	7111111	8	0	2018-01-10 23:46:42.193705+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
330	7111114	40	0	2018-01-10 23:46:42.193705+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
331	7111116	36	0	2018-01-10 23:46:42.193705+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
332	1011121	11	0	2018-01-10 23:46:42.574419+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
333	3111114	32	0	2018-01-10 23:46:42.574419+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by Renato JoseMolano	null
334	7111111	9	0	2018-01-10 23:46:44.916085+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
335	7111114	41	0	2018-01-10 23:46:44.916085+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
336	7111116	37	0	2018-01-10 23:46:44.916085+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
337	7111111	10	0	2018-01-10 23:46:47.396091+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
338	7111114	42	0	2018-01-10 23:46:47.396091+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
339	7111116	38	0	2018-01-10 23:46:47.396091+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7VP - Documentation	null
340	1011121	12	0	2018-01-10 23:46:51.550781+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
341	3111114	33	0	2018-01-10 23:46:51.550781+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by Renato JoseMolano	null
342	1011121	13	0	2018-01-10 23:46:59.851455+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
343	3111114	34	0	2018-01-10 23:46:59.851455+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by Renato JoseMolano	null
344	7111111	11	0	2018-01-10 23:47:11.500164+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
345	7111114	43	0	2018-01-10 23:47:11.500164+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
346	7111116	39	0	2018-01-10 23:47:11.500164+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
347	7111111	12	0	2018-01-10 23:47:12.104035+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
348	7111114	44	0	2018-01-10 23:47:12.104035+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
349	7111116	40	0	2018-01-10 23:47:12.104035+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
350	7111111	13	0	2018-01-10 23:47:15.694132+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
351	7111114	45	0	2018-01-10 23:47:15.694132+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
352	7111116	41	0	2018-01-10 23:47:15.694132+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
353	7111111	14	0	2018-01-10 23:47:16.95589+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
354	7111114	46	0	2018-01-10 23:47:16.95589+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
355	7111116	42	0	2018-01-10 23:47:16.95589+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
356	7111111	15	0	2018-01-10 23:47:17.905914+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
357	7111114	47	0	2018-01-10 23:47:17.905914+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
358	7111116	43	0	2018-01-10 23:47:17.905914+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
359	7111111	16	0	2018-01-10 23:47:20.209902+08	Project Proposal Evaluation	Please evaluate All Forms of Life is Important: Bird Race	null
360	7111114	48	0	2018-01-10 23:47:20.209902+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
361	7111116	44	0	2018-01-10 23:47:20.209902+08	Project Proposal Evaluation	Your activity All Forms of Life is Important: Bird Race has been approved by Organization7VP - Documentation	null
362	1011120	10	0	2018-01-10 23:47:38.507971+08	Project Proposal Evaluation	Please evaluate Talent Management	null
363	3111114	35	0	2018-01-10 23:47:38.507971+08	Project Proposal Evaluation	Your activity Talent Management has been approved by CSOA - APS	null
364	1011120	11	0	2018-01-10 23:47:47.197943+08	Project Proposal Evaluation	Please evaluate October - Local Committee Meeting	null
365	3111114	36	0	2018-01-10 23:47:47.197943+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by CSOA - APS	null
366	1011120	12	0	2018-01-10 23:47:54.349036+08	Project Proposal Evaluation	Please evaluate Global Goals Weeks	null
367	3111114	37	0	2018-01-10 23:47:54.349036+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by CSOA - APS	null
368	1011120	13	0	2018-01-10 23:48:04.225519+08	Project Proposal Evaluation	Please evaluate Operations Summit 	null
369	3111114	38	0	2018-01-10 23:48:04.225519+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by CSOA - APS	null
370	7111111	17	0	2018-01-10 23:48:11.385162+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
371	7111114	49	0	2018-01-10 23:48:11.385162+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7VP - Documentation	null
372	7111116	45	0	2018-01-10 23:48:11.385162+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7VP - Documentation	null
373	1011120	14	0	2018-01-10 23:48:16.257253+08	Project Proposal Evaluation	Please evaluate Organizing Committee Track	null
374	3111114	39	0	2018-01-10 23:48:16.257253+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by CSOA - APS	null
375	7111111	18	0	2018-01-10 23:48:26.650071+08	Project Proposal Evaluation	Please evaluate #ECOTalks 1: I am a Lasallian, I am PRO Green"	null
376	7111114	50	0	2018-01-10 23:48:26.650071+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7VP - Documentation	null
377	7111116	46	0	2018-01-10 23:48:26.650071+08	Project Proposal Evaluation	Your activity #ECOTalks 1: I am a Lasallian, I am PRO Green" has been approved by Organization7VP - Documentation	null
378	7111111	19	0	2018-01-10 23:48:33.105948+08	Project Proposal Evaluation	Please evaluate Annual Recruitment Week	null
379	7111114	51	0	2018-01-10 23:48:33.105948+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7VP - Documentation	null
380	7111116	47	0	2018-01-10 23:48:33.105948+08	Project Proposal Evaluation	Your activity Annual Recruitment Week has been approved by Organization7VP - Documentation	null
381	7111111	20	0	2018-01-10 23:48:37.078321+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
382	7111114	52	0	2018-01-10 23:48:37.078321+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7VP - Documentation	null
383	7111111	21	0	2018-01-10 23:48:38.885439+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
384	7111114	53	0	2018-01-10 23:48:38.885439+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7VP - Documentation	null
385	7111111	22	0	2018-01-10 23:48:54.687613+08	Project Proposal Evaluation	Please evaluate 1st General Assembly and Turn-over Ceremony	null
386	7111114	54	0	2018-01-10 23:48:54.687613+08	Project Proposal Evaluation	Your activity 1st General Assembly and Turn-over Ceremony has been approved by Organization7VP - Documentation	null
387	3111114	40	0	2018-01-10 23:48:56.80596+08	Project Proposal Evaluation	Your activity Talent Management has been approved by CSOAVC - APS	null
388	3111114	41	0	2018-01-10 23:49:01.735109+08	Project Proposal Evaluation	Your activity Operations Summit  has been approved by CSOAVC - APS	null
389	3111114	42	0	2018-01-10 23:49:08.700912+08	Project Proposal Evaluation	Your activity Organizing Committee Track has been approved by CSOAVC - APS	null
390	3111114	43	0	2018-01-10 23:49:17.307866+08	Project Proposal Evaluation	Your activity Global Goals Weeks has been approved by CSOAVC - APS	null
391	3111114	44	0	2018-01-10 23:49:31.456334+08	Project Proposal Evaluation	Your activity October - Local Committee Meeting has been approved by CSOAVC - APS	null
392	3111114	45	0	2018-01-10 23:49:43.655282+08	New Project Proposal	Please check activity Local Committee Orientation Seminar	null
393	2011111	14	0	2018-01-10 23:50:07.908414+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
394	7111114	55	0	2018-01-10 23:50:07.908414+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7President	null
395	2011111	15	0	2018-01-10 23:50:13.609713+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
396	7111114	56	0	2018-01-10 23:50:13.609713+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7President	null
397	2011111	16	0	2018-01-10 23:50:18.92409+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
398	7111114	57	0	2018-01-10 23:50:18.92409+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
399	7111116	48	0	2018-01-10 23:50:18.92409+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
400	2011111	17	0	2018-01-10 23:50:24.172256+08	Project Proposal Evaluation	Please evaluate Let's ECO: An ECO Team Building	null
401	7111114	58	0	2018-01-10 23:50:24.172256+08	Project Proposal Evaluation	Your activity Let's ECO: An ECO Team Building has been approved by Organization7President	null
402	2011111	18	0	2018-01-10 23:50:35.429246+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
403	7111114	59	0	2018-01-10 23:50:35.429246+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
404	7111116	49	0	2018-01-10 23:50:35.429246+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
405	2011111	19	0	2018-01-10 23:50:39.18092+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
406	7111114	60	0	2018-01-10 23:50:39.18092+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
407	7111116	50	0	2018-01-10 23:50:39.18092+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
408	2011111	20	0	2018-01-10 23:50:43.167395+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
409	7111114	61	0	2018-01-10 23:50:43.167395+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
410	7111116	51	0	2018-01-10 23:50:43.167395+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
411	2011111	21	0	2018-01-10 23:50:46.595217+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
412	7111114	62	0	2018-01-10 23:50:46.595217+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
413	7111116	52	0	2018-01-10 23:50:46.595217+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
414	2011111	22	0	2018-01-10 23:50:49.267709+08	Project Proposal Evaluation	Please evaluate ECO Gives Back: A Christmas Celebration with the Kids	null
415	7111114	63	0	2018-01-10 23:50:49.267709+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
416	7111116	53	0	2018-01-10 23:50:49.267709+08	Project Proposal Evaluation	Your activity ECO Gives Back: A Christmas Celebration with the Kids has been approved by Organization7President	null
417	2011111	23	0	2018-01-10 23:51:02.583195+08	Project Proposal Evaluation	Please evaluate ECOntrol: Waste Analysis and Characterization Study	null
418	7111114	64	0	2018-01-10 23:51:02.583195+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7President	null
419	7111116	54	0	2018-01-10 23:51:02.583195+08	Project Proposal Evaluation	Your activity ECOntrol: Waste Analysis and Characterization Study has been approved by Organization7President	null
420	2011112	2	0	2018-01-10 23:51:09.75601+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
421	7111114	65	0	2018-01-10 23:51:09.75601+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
422	7111116	55	0	2018-01-10 23:51:09.75601+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
423	2011112	3	0	2018-01-10 23:51:20.809288+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
424	7111114	66	0	2018-01-10 23:51:20.809288+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
425	7111116	56	0	2018-01-10 23:51:20.809288+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
426	2011112	4	0	2018-01-10 23:51:24.746504+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
427	7111114	67	0	2018-01-10 23:51:24.746504+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
428	7111116	57	0	2018-01-10 23:51:24.746504+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
429	2011112	5	0	2018-01-10 23:51:31.930805+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
430	7111114	68	0	2018-01-10 23:51:31.930805+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
431	7111116	58	0	2018-01-10 23:51:31.930805+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
432	2011112	6	0	2018-01-10 23:51:37.697172+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
433	7111114	69	0	2018-01-10 23:51:37.697172+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
434	7111116	59	0	2018-01-10 23:51:37.697172+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
435	2011112	7	0	2018-01-10 23:51:41.684337+08	Project Proposal Evaluation	Please evaluate E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	null
436	7111114	70	0	2018-01-10 23:51:41.684337+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
437	7111116	60	0	2018-01-10 23:51:41.684337+08	Project Proposal Evaluation	Your activity E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase) has been approved by Organization7President	null
438	10111114	9	0	2018-01-10 23:51:43.630391+08	New Project Proposal	Please check activity General Assembly: Behavioral Sciences Convocation	null
439	10111116	3	0	2018-01-10 23:51:43.630391+08	New Project Proposal	Please check activity General Assembly: Behavioral Sciences Convocation	null
\.


--
-- Data for Name: AccountNotificationStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountNotificationStatus" (id, name) FROM stdin;
0	Sent/Unseen
1	Seen
2	Opened
3	Deleted
\.


--
-- Data for Name: AccountStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."AccountStatus" (id, name) FROM stdin;
0	Active
1	Disabled si Neil
2	Deleted
3	Virgin Account
\.


--
-- Data for Name: ActivityPublicity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPublicity" (id, "GOSMActivity", "submissionID", sequence, material, "modeOfDistribution", description, "targetPostingDate", "submittedBy", "dateSubmitted", status, "checkedBy", "dateChecked", comments, filename, "filenameToShow", "revisionReason") FROM stdin;
\.


--
-- Data for Name: ActivityPublicityMaterial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPublicityMaterial" (id, name) FROM stdin;
0	Not applicable
1	Tarpualine
2	Banderitas
3	Ticket
4	Publication
5	Poster
\.


--
-- Data for Name: ActivityPublicityModeOfDistribution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPublicityModeOfDistribution" (id, name) FROM stdin;
0	Online
1	Printed
\.


--
-- Data for Name: ActivityPublicityRevisionReason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPublicityRevisionReason" (id, name) FROM stdin;
0	Unoriginal design
1	Incorrect grammar
2	Incomplete logo
3	Contents not in line with La Sallian Values
4	Old Version
\.


--
-- Data for Name: ActivityPublicityStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityPublicityStatus" (id, name) FROM stdin;
0	For Evaluation
1	Approved
2	Pended
3	Denied
4	Old Version
\.


--
-- Data for Name: ActivityResearchForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityResearchForm" ("GOSMActivity", "idNumber", email, sequence, "positionInOrganization", "IUTPOTA", "TASMI", "IFIDTA", "TAWWP", "TOUMTGTTA", field6, field7, "WWWITA", "FAC", "EFFA", "dateSubmitted") FROM stdin;
\.


--
-- Data for Name: ActivityVenue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ActivityVenue" (id, name, capacity, size, rate, "rateType", building) FROM stdin;
0	A 1502-A Conference Room	20	0	360.00	0	0
1	A 1502-B Conference Room	10	0	230.00	0	0
2	A 1505-A Conference Room	12	0	240.00	0	0
3	A 1505-B Conference Room	8	0	110.00	0	0
4	A 1506 Conference Room	30	0	850.00	0	0
5	A 1602 Conference Room	20	0	680.00	0	0
6	A 703 Lecture Room	120	1	1200.00	0	0
7	A 903 Lecture Room	120	1	1200.00	0	0
8	A 1103 Lecture Room	120	1	1200.00	0	0
9	A 1403 Lecture Room	120	1	1200.00	0	0
10	A 1703 Lecture Room	120	1	1200.00	0	0
11	A1402 Micro Teaching Laboratory	45	0	700.00	0	0
12	A1805 Micro Teaching Laboratory	45	0	700.00	0	0
13	20th Floor Board Room	20	0	900.00	0	0
14	20th Floor Conference Room	8	0	400.00	0	0
15	20th Floor Multipurpose Room	200	2	2500.00	0	0
16	Classroom (Full-size)	45	0	620.00	0	0
17	Classroom (Half-size	25	0	340.00	0	0
18	Natividad Fajardo-Rosario Gonzalez Auditorium, 18th Flr.	238	2	3000.00	0	0
19	Br. Gabriel Connon Conference Room SPS 201	30	0	385.00	0	1
20	Rehersal Room, SPS 507	0	0	275.00	0	1
21	Tennis Court, Roof deck	0	0	330.00	0	1
22	Waldo Perfecto Seminar Room, SPS 102	156	1	1595.00	0	1
23	Classroom	45	0	605.00	0	2
24	Teresa Yuchengco Auditorium, 7th-9th flr.	1104	2	7700.00	0	2
25	Y 407 Seminar Room	90	1	880.00	0	2
26	Y 408 Seminar Room	90	1	880.00	0	2
27	Y 409 Seminar Room	90	1	880.00	0	2
28	Y 507 Seminar Room	90	1	880.00	0	2
29	Y 508 Seminar Room	90	1	880.00	0	2
30	Y 509 Seminar Room	90	1	880.00	0	2
31	7th Floor Gym(w/ Scoreboard)	0	2	1265.00	0	3
32	7th Floor Gym(w/o Scoreboard)	0	2	880.00	0	3
33	9th Floor Gym(w/ Scoreboard)	0	2	1815.00	0	3
34	9th Floor Gym(w/o Scoreboard)	0	2	1430.00	0	3
35	Classroom	45	0	495.00	0	3
36	E201 Multipurpose Room	90	1	880.00	0	3
37	E202 Multipurpose Room	48	0	605.00	0	3
38	E 802 Practice Room	0	0	275.00	0	3
39	E 803 Practice Room	0	0	275.00	0	3
40	E 804 Dance Room	45	0	375.00	0	3
41	E 1001 Practice Room	0	0	230.00	0	3
42	E 1002 Practice Room	0	0	230.00	0	3
43	E 1003 Practice Room	0	0	230.00	0	3
44	E 1004 Practice Room	0	0	230.00	0	3
45	E 1005 Practice Room	0	0	230.00	0	3
46	Swimming Pool, 1st flr.	0	0	132.00	3	3
47	Classroom	45	0	495.00	0	4
48	Shell Companies in Philippines Audio Visual Room, V210	93	1	880.00	0	4
49	Classroom	45	0	495.00	0	5
50	Intellect Seminar Room	120	1	715.00	0	5
51	Ariston Estrada Seminar Room, L 216	60	0	715.00	0	6
52	Br. Richard Duerr Board Room, L 113	25	0	605.00	0	6
53	Br. Richard Duerr Board Room Receiving Area, L 115	0	0	495.00	0	6
54	Classroom	45	0	495.00	0	6
55	Conference Room A, L128A	20	0	275.00	0	6
56	Conference Room A, L128	20	0	275.00	0	6
57	Conference Room A, L127A	10	0	220.00	0	6
58	Conference Room A, L127	10	0	220.00	0	6
59	L 112 Conference Room	12	0	385.00	0	6
60	L 218 Case Room	40	0	495.00	0	6
61	L 219 Case Room	40	0	495.00	0	6
62	Marelian Gaerlan Conservatory North Wing (w/ Sound System), 1st flr.	250	2	2200.00	0	6
63	Marelian Gaerlan Conservatory North Wing (w/o Sound System) 1st flr.	250	2	1925.00	0	6
64	Marelian Gaerlan Conservatory South Wing, 1st flr.	250	2	1925.00	0	6
65	Medrano Hall, L213	100	1	1650.00	0	6
66	Most Blessed Sacrament (Main) Chapel (w/ airconditioning), 2nd flr.	580	2	2750.00	0	6
67	Most Blessed Sacrament (Main) Chapel (w/o airconditioning), 2nd flr.	580	2	2090.00	0	6
68	Pablo Nicholas Seminar Room, L 315	170	1	1650.00	0	6
69	Tereso Lara Seminar Room, L 230	60	0	715.00	0	6
70	Classroom	45	0	495.00	0	7
71	Laboratory (Room Only)	0	0	660.00	0	7
72	Pearl of Great Price Chapel, 1st flr.	108	1	1540.00	0	7
73	Rosario Jose Science Lecture Room, J 504	92	1	605.00	0	7
74	Classroom	45	0	495.00	0	8
75	E Classroom, M 306	40	0	2530.00	0	8
76	Classroom	45	0	495.00	0	9
77	STRC 412 Seminar Room	42	0	660.00	0	10
78	Ortigas Seminar Room, 1st flr.	30	0	440.00	0	11
79	William Shaw Little Theatre, 1st flr.	270	2	2970.00	0	12
80	Agno House	20	0	440.00	0	13
81	Amphitheater (w/ Sound System)	300	2	415.00	0	13
82	Amphitheater (w/o Sound System)	300	2	250.00	0	13
83	Chess Plaza	0	0	495.00	0	13
84	Football Field	0	0	1515.00	0	13
85	Marian Quadrangle (w/ Sound System)	0	0	770.00	0	13
86	Marian Quadrangle (w/o Sound System)	0	0	660.00	0	13
87	Retreat House Room 101	45	0	660.00	0	13
88	Retreat House Room 201	45	0	660.00	0	13
89	Sound System	0	0	165.00	0	13
90	Sports Plaza (Per Court)	0	0	302.50	0	13
91	HSH101 (The Meadow-Main Lobby)	0	0	5800.00	0	14
92	2nd Floor - Enrollment Central Lobby	20	0	1500.00	0	14
93	3rd Floor - Conference Room	0	0	700.00	0	14
94	4th Floor - Function Room Lobby	0	0	1920.00	0	14
95	4th Floor (HSH401) - Multi-Purpose Room	20	0	6700.00	0	14
96	4th Floor (HSH402) - Meeting Room A	14	0	778.00	0	14
97	4th Floor (HSH406) - Meeting Room B	0	0	320.00	0	14
98	5th Floor - Function Room Lobby	0	0	1920.00	0	14
99	5th Floor (HSH501) - Multi-Purpose Room	0	0	6700.00	0	14
100	5th Floor - Bean Bag Area	0	0	1260.00	0	14
101	6th Floor - Display Area	0	0	5700.00	0	14
102	7th Floor (HSH701) - Meeting Room	18	0	550.00	0	14
103	8th Floor (HSH801) - Meeting Room	18	0	550.00	0	14
104	13th Floor - Audio Visual Room	45	0	826.00	0	14
105	13th Floor - EDC Multi-Purpose Room	0	0	1126.00	0	14
106	14th Floor - Conference Room 1	20	0	673.92	0	14
107	14th Floor - Conference Room 2	16	0	544.32	0	14
108	14th Floor - Board Room	30	0	1504.80	0	14
109	Roof Deck - Dining Area	0	0	1247.00	0	14
110	Roof Deck - Garden	0	0	1550.00	0	14
\.


--
-- Data for Name: BookTransferEstablishment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."BookTransferEstablishment" (id, name, "transferAccount") FROM stdin;
0	Physical Facilities Development Fund	\N
1	Perico's Grill	\N
2	La Casita De Roja Restaurant	\N
3	CopyCare Phils.	\N
4	MRU	\N
5	Scoop	\N
6	Animo Bookstore	\N
7	The Store	\N
8	Salikneta	\N
\.


--
-- Data for Name: Building; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Building" (id, name) FROM stdin;
0	Br. Andrew Gonzales Building
1	Br. Gabriel Conon (SPS) Building
2	Don Enrique Yuchengco Building
3	Enrique Razon Building
4	Velasco Building
5	Gokongwei Building
6	La Salle Building
7	St. Joseph Building
8	St. Miguel Building
9	St. Mutien Marie Building
10	STRC Building
11	University Library Building
12	William Shaw Building
13	Henry Sy Building
14	Others
\.


--
-- Data for Name: ExpenseTypeAttachmentRequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."ExpenseTypeAttachmentRequirement" ("expenseType", document) FROM stdin;
0	9
1	9
1	10
2	9
2	10
6	11
\.


--
-- Data for Name: FinanceSignatoryType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."FinanceSignatoryType" (id, name, lineup) FROM stdin;
0	Organization Finance/Treasurer	0
1	Organization President	10
2	Director of S-Life	20
3	Dean of Student Affairs	30
4	Vice President for Lasallian Mission	40
5	President	50
\.


--
-- Data for Name: MemberSurveyForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."MemberSurveyForm" (id, "termID", member, "organizationID", field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13) FROM stdin;
\.


--
-- Data for Name: OfficerSurveyForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OfficerSurveyForm" (id, "termID", "organizationID", officer, field1, field2, field3, field4, field5, field6, field7, field8, field9) FROM stdin;
\.


--
-- Data for Name: OrganizationMember; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."OrganizationMember" (id, "idNumber", organization, "yearID", name, "dateAdded") FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectBookTransfer" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, purpose, bsfilename, "bsfilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectBookTransferParticular" ("bookTransfer", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectBookTransferStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PostProjectDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, "paymentBy", "delayedProcessing", fqfilename, roffilename, "fqfilenameToShow", "roffilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectDirectPaymentParticular" ("directPayment", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectDirectPaymentPayment" (id, name) FROM stdin;
0	Cheque
1	Book Transfer
\.


--
-- Data for Name: PostProjectDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectDirectPaymentStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
\.


--
-- Data for Name: PostProjectProposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectProposal" ("GOSMActivity", "preparedBy", status, "dateCreated", "dateSubmitted", "ANP", "ANMP", objectives, "WATTTWITA", "WWYGLIETA", "HDTATYLCTTDOTP", "WATTWWAWCYDTPTFHA", galsfilename, "galsfilenameToShow", "isBriefContextCompleted", "isOtherFinanceDocumentsCompleted", "isFinanceDocumentCompleted", "isCheckedDP", "isCheckedR", "isCheckedBT", comments, "sectionsToBeEdited", document, "checkedByStage1", "signatureStage1", "checkedByStage2", "signatureStage2") FROM stdin;
8	\N	0	2018-01-10 21:32:28.682342+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
10	\N	0	2018-01-10 21:39:59.843029+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
13	\N	0	2018-01-10 21:43:20.606937+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
17	\N	0	2018-01-10 21:45:19.240348+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
65	\N	0	2018-01-10 21:47:44.190732+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
21	\N	0	2018-01-10 21:48:44.077825+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
30	\N	0	2018-01-10 21:50:15.86212+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
31	\N	0	2018-01-10 21:52:35.744671+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
7	\N	0	2018-01-10 21:53:13.013545+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
24	\N	0	2018-01-10 21:53:54.928136+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
1	\N	0	2018-01-10 21:55:28.20484+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
6	\N	0	2018-01-10 21:58:04.913559+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
11	\N	0	2018-01-10 21:58:54.062857+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
2	\N	0	2018-01-10 21:59:38.469082+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
70	\N	0	2018-01-10 22:00:40.795121+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
27	\N	0	2018-01-10 22:00:41.2196+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
14	\N	0	2018-01-10 22:17:26.514056+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
118	\N	0	2018-01-10 22:17:56.740832+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
73	\N	0	2018-01-10 22:18:01.759562+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
80	\N	0	2018-01-10 22:25:45.116766+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
3	\N	0	2018-01-10 22:29:17.011505+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
5	\N	0	2018-01-10 22:30:42.936133+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
29	\N	0	2018-01-10 22:33:47.22055+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
9	\N	0	2018-01-10 22:34:08.224238+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
83	\N	0	2018-01-10 22:48:56.894334+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
85	\N	0	2018-01-10 22:58:19.266276+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
62	\N	0	2018-01-10 23:12:16.928111+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
12	\N	0	2018-01-10 23:13:13.973541+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
64	\N	0	2018-01-10 23:16:30.501087+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
28	\N	0	2018-01-10 23:18:31.222625+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
67	\N	0	2018-01-10 23:21:52.778067+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
68	\N	0	2018-01-10 23:25:17.973024+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
25	\N	0	2018-01-10 23:26:43.505528+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
22	\N	0	2018-01-10 23:28:24.562857+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
69	\N	0	2018-01-10 23:28:50.255316+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
86	\N	0	2018-01-10 23:29:10.594712+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
72	\N	0	2018-01-10 23:30:22.275904+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
75	\N	0	2018-01-10 23:32:41.728252+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
79	\N	0	2018-01-10 23:34:07.336749+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
81	\N	0	2018-01-10 23:35:40.068001+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
90	\N	0	2018-01-10 23:38:30.148552+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
61	\N	0	2018-01-10 23:49:43.655282+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
88	\N	0	2018-01-10 23:51:43.630391+08	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	f	f	f	f	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: PostProjectProposalEventPicture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectProposalEventPicture" (id, "GOSMActivity", "submissionID", sequence, filename, "filenameToShow", description, "idNumber") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalExpense; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectProposalExpense" (id, "GOSMActivity", "submissionID", sequence, particular, establishment, price, filename, "filenameToShow", "idNumber") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectProposalStatus" (id, name) FROM stdin;
0	Unopened
1	Opened
2	In-progress
3	For Approval
4	Approved
5	Pend
\.


--
-- Data for Name: PostProjectReimbursement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectReimbursement" (id, "GOSMActivity", "submissionID", sequence, "justificationFDPP", "justificationFNUCADP", filenames, "filenamesToShow", "submittedBy", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectReimbursementParticular" (id, reimbursement, particular) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectReimbursementPayment" (id, name) FROM stdin;
0	Payment By Check
1	Payment By Book Transfer
\.


--
-- Data for Name: PostProjectReimbursementSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectReimbursementSignatory" (id, reimbursement, signatory, type, status, comments, sectionstoedit, document, digitalsignature, datesigned) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PostProjectReimbursementStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PreActivityBookTransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityBookTransfer" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", status, establishment) FROM stdin;
\.


--
-- Data for Name: PreActivityBookTransferParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityBookTransferParticular" (id, "bookTransfer", particular) FROM stdin;
\.


--
-- Data for Name: PreActivityBookTransferSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityBookTransferSignatory" (id, "bookTransfer", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Data for Name: PreActivityBookTransferStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityBookTransferStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PreActivityCashAdvance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityCashAdvance" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", purpose, justification, "evaluatedBy", status, filename, "filenameToShow") FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityCashAdvanceParticular" (id, "cashAdvance", particular) FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityCashAdvanceSignatory" (id, "cashAdvance", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityCashAdvanceStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: PreActivityDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", "nameOfEstablishment", amount, "reasonForDelayedPRSProcessing", "galsFilename", "galsfilenameToShow", "fqFilename", "fqfilenameToShow", "rofFilename", "rofFilenameToShow", "evaluatedBy", comments, "dateEvaluated", status) FROM stdin;
1	6	1	1	1111115	2018-01-10 23:51:31.726844+08	\N	\N	\N			cjc98t09b0002rhnt2m5infd4.pdf	Sample informal quotation.pdf	cjc98t09b0003rhnt1zcn1iwz.pdf	sample credentials.pdf	\N	\N	\N	0
\.


--
-- Data for Name: PreActivityDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityDirectPaymentParticular" (id, "directPayment", particular) FROM stdin;
1	1	14
\.


--
-- Data for Name: PreActivityDirectPaymentSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityDirectPaymentSignatory" (id, "directPayment", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
1	1	1111115	0	0	\N	\N	\N	\N	\N
2	1	1111111	1	0	\N	\N	\N	\N	\N
3	1	3011111	2	0	\N	\N	\N	\N	\N
\.


--
-- Data for Name: PreActivityDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."PreActivityDirectPaymentStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Data for Name: RateType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."RateType" (id, name) FROM stdin;
0	Per hour
1	Per person
2	Per use
3	Per person, per use
4	Per Dominique
\.


--
-- Data for Name: SystemConfiguration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."SystemConfiguration" (name, value, description) FROM stdin;
PASSWORD	{"EXPIRATION_TIME": {"DAYS": 0, "MONTHS": 3}}	{"EXPIRATION_TIME": "Contains values on much time a password is before its expiration"}
\.


--
-- Data for Name: VenueSize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."VenueSize" (id, name) FROM stdin;
0	Small
1	Mediume
2	Large
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (idnumber, email, type, status, password, salt, firstname, middlename, lastname, contactnumber, privatekey, publickey, path_profilepicture, datecreated, datemodified, passwordexpiration) FROM stdin;
1111111	org_president@dlsu.edu.ph	1	0	$2a$06$3d6jeckE2DCFQXltgVDmtuc9a800NnQ0vQEGo78AxyIw14oFDxLmS	$2a$06$3d6jeckE2DCFQXltgVDmtu	Organization	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1111112	org_vp_internal@dlsu.edu.ph	1	0	$2a$06$SGV5hH6FcYqnlfel6ncNkOCM19pp.QQRuLvQiIY2takx1.1OKdff.	$2a$06$SGV5hH6FcYqnlfel6ncNkO	Organization	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1111113	org_vp_documentation@dlsu.edu.ph	1	0	$2a$06$hAyg3tQsQyAOxqz3E/oMgOhumX05F2BgbzP3jvIyzwWq5dExCHOyu	$2a$06$hAyg3tQsQyAOxqz3E/oMgO	Organization	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1111114	org_avp_documentation@dlsu.edu.ph	1	0	$2a$06$b7a6St.WfgnmJpLGzrSg3ex8sBFJQHyaI1C1/N3aYUv62Ss6z7Oyy	$2a$06$b7a6St.WfgnmJpLGzrSg3e	Organization	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1111115	org_vp_finance@dlsu.edu.ph	1	0	$2a$06$ARsklext.CA4lbpmhfCSbuvhStbrfGak5XihiqwimbeIjlWHaWA4C	$2a$06$ARsklext.CA4lbpmhfCSbu	Organization	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1111116	org_avp_finance@dlsu.edu.ph	1	0	$2a$06$Y4MQMRhQJab.8o0QlBDiUenEKDX5wzkLd3TGsP5H/aVln6XzHhYXC	$2a$06$Y4MQMRhQJab.8o0QlBDiUe	Organization	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011117	cso_chairperson@dlsu.edu.ph	1	0	$2a$06$PrGPThsdhGW7ARLNu6XuFemAs4mEeLvug3cxEQmtNWCknByagfceW	$2a$06$PrGPThsdhGW7ARLNu6XuFe	CSO	\N	Chairperson	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCct6871QS2qtDxi5T12eSk/znmDFDIuLH1Q2V3owXqV7WldLso\r\nDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHEGe1n6litU/6CUnKUjlKEF9nw\r\nB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIlNxDPm6J/sYxt8ymirQIDAQAB\r\nAoGAZi/LfjsHCMjW1zlJlwlN8lxNd3h+UHNF7oPUrK7LE6O/WLSFuLfj8BHbqg6v\r\n5qjDsStEL6aPXuPYIPQF2uafQXwU9WSG7Iw4fybkOachHtEhxZB4KUSxVKqJynqA\r\nyzBSG8rAU7OOJr9dRUlVt8vIw6KXzol4A6ZQ8CH2BdAzuo0CQQDaRDWGOp4nLAV9\r\nMlVwM2QvHSJifS40F77VC7v6FMrqdp/GXXHtXxqltyp+5BZfkn2WldzcbOD7Gnj7\r\nG20l7rz7AkEAt8+DJlk3BpHDoi3Zpy4V+z6RNQgP+IyQ5eVksUethyV8mhs5kSzs\r\nIXpbKCIw+FpPiXfWf9noUqkwHvKw3FE+dwJAT0OmDHENLjyWYbj9vhlrsJBsBEhh\r\nlxlofAYe5drXNf6OV4Nn9EQtcTDrhdlfJqYUZbNW2dXQfmBGvypeoP/qMQJBAJg1\r\n0MbqzfQ0tKoSCdC1CyLYtuoRWRhbXonhobZkQsBNPJdowA0GBCvc5KuhVKf0MTUG\r\n9as9yXLaA609D1QCOxUCQD/rjvaV80gcG1AXJFc6y9w13hYUCpfBRATBHvoz3pAN\r\nwYsx9+22oRsrfmBQFuxo0o7Z1u+RJC7S5bRkKTL89Uc=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCct6871QS2qtDxi5T12eSk/znm\r\nDFDIuLH1Q2V3owXqV7WldLsoDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHE\r\nGe1n6litU/6CUnKUjlKEF9nwB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIl\r\nNxDPm6J/sYxt8ymirQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011118	cso_executivechairperson_external@dlsu.edu.ph	1	0	$2a$06$Jh8tbOOsTQoiOVBxXrOVG./Tfu9MRqZSCaXC2zAqZcZGT8..1Bs2a	$2a$06$Jh8tbOOsTQoiOVBxXrOVG.	CSO	\N	Executive Chairperson External	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/K3G9u1nV2qd7k3lfCoRCKbcG\r\ntVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9dMMVuozDgfLn7dxe+O3TjI1g\r\nCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMtC5Baj3ihb9Y0RKKhgQIDAQAB\r\nAoGAc8jXJPmaJQlVhcgqM+nR192NbwcSUU+7MyX12yv+aKs//vvZHb7xAOPRrLbR\r\n0ThJ5RCrK4Jp0FiKI2Vzz5f7Zxdhvuwl6wYhcMZ8zk42fX8bzUF1uBjPsRk84gWK\r\n7I3faSvXqeuEiDNjXkjKfIMWyBL//vUowl7dc4rRiZHew1UCQQC473GHpVn9WRg7\r\nI36Ts6QGJVB6/AgZaBSwatj0eXSJLOToILxIjmtf/oe9j8Pfx9VoxGvuuxikrjJu\r\nX83xxk5TAkEAsxNzrImX4Z2xV+cg2xVDG/ojMhhsGRrJk9HF65UZoRX3KNyY/SlI\r\n3BZ99MayvTsTgxv6bvMaXnbjrCgNr6rOWwJBAJWjCNWc8WeRQ432dmDEph9i6e/Z\r\nJiSIltT4X3vRGn40GTPJ6Q88TZ1qsiKrxO25H/CZnkuYj6QQXzX3xweuUYkCQG4o\r\niiDaJ2cvtVdoo8qBgt3j+uCnK2AqHVRkV8c62iBAveESCr65NcvFvkfkLzG+9JrT\r\njDPSMidoJVfS79BfVz8CQBMKt18LgvWQsd76NUPgnFDWkS8O5h7kIJrU3nHuKDjT\r\nBZcLymoRZJvM/52CSshJ3iJ/80HDD/3DEN2KhMlnBpc=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/\r\nK3G9u1nV2qd7k3lfCoRCKbcGtVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9\r\ndMMVuozDgfLn7dxe+O3TjI1gCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMt\r\nC5Baj3ihb9Y0RKKhgQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011119	cso_vp_aps@dlsu.edu.ph	1	0	$2a$06$M.21ew993xkpOLEqA0viE.51HfPyiBRJkg8cLoZTEYIBjhdYKTZ/m	$2a$06$M.21ew993xkpOLEqA0viE.	CSO	\N	VP - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQDS96X7dtaSFpn9k/7mo17P/Wwz+kK2pTbveE105mCkPA2OHVSc\r\n9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3KURL0ImjPDLg99TN+KncSz9Xp\r\n33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31KjxmbyR7gNI+iN7eSxNKbwIDAQAB\r\nAoGBAM079tFnjt6X9j7mlvewvzAADh+SuwwMNiFJG7E53ZJoiZdTmVkJByFSzLSp\r\n5SovSnGxQBuqrRC7KtBEYGoicmxSWrPa28YstZw3VyK5zay9wWuyogHyx535bUuI\r\ngIu2rkGqCnlVO93PEPHZisCN3DWnxSmrwSleJXLyXEebW9ThAkEA/EmCw3zyeQGs\r\n05i8RI92q7gumnvbVrBrf2i3SEPA+4H63Asg/NU9hDrWyNS0+MiU3/ov7N5h/7v4\r\nkNwAteKkVQJBANYSdzuL8rDS8vN78l8xT0qFnHqNg777yR28RFAwiBUCAwOYQG2f\r\ng8MD1g1l3Nzu7riewIDZXE5CCSlnEE4717MCQHjv5DdB1hobq3VjahyTiReYGv8D\r\nEInl2CIjWHjTwdbO4CpLS2zn661PZ1auYHJB9NvJWt/5WpD00preW5jVJGECQDio\r\n1ooaNnf6vXcYfUQYxwXQa2Q8hHxOJCMMq4AV+E6nI6kV6SeaqsM5BrSxG04Wp3SS\r\nAB2aakYEUGx27OfoCuUCQQDqnjl4xK+d7yMpfz58gGOQIuKgPQlSFx7BDlBBcX46\r\nPeRqcg6LDDmiTQeAW0N8ywoyAsTe8lLyomiujzoa0nNC\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDS96X7dtaSFpn9k/7mo17P/Wwz\r\n+kK2pTbveE105mCkPA2OHVSc9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3K\r\nURL0ImjPDLg99TN+KncSz9Xp33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31Kjxm\r\nbyR7gNI+iN7eSxNKbwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011120	cso_avc_aps@dlsu.edu.ph	1	0	$2a$06$OUiO1Nc2S4tAH00R.uljl.i8a6sUf4icbSAVzsGPhys2byDmdJE0a	$2a$06$OUiO1Nc2S4tAH00R.uljl.	CSO	\N	AVC - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCOipOmH7ymZy3hQ41GlpFn6bgNPtEuQmvSDnZWbkfC0HWG7ho5\r\nuqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR9G+81YH6T8Qp8MyaN/5uggc6\r\nA7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzqtiKPUEpbCtFuQc+SUQIDAQAB\r\nAoGANbnp2Q3RT29IjcWmdFrAR8iCRQvOUH9coHovBHjgt39XLRqF7Ah9qmQl5XjB\r\nYyO68OkwCjylKx2M4AFFSnBPPeWC4N4e3hok/82rtyhzUkL6TmSNmY0utqjdhC7f\r\nQFgRutu6mcyi4kRIiVgr68ZSOioQcELoct1T8vTFJqfUj5kCQQDFEKgnnAJaVTrF\r\nz9yVH5SNiEk683nqI2zHI4paeq48MRyKPb9Wtv56zmKzY3lZ+X9eflYDd763kA6T\r\n7oG4MHSjAkEAuSuR7X7j53ELX02QqDyXVSScostkIDUJGUDA+WiVirEkA54Jh+gX\r\nDmGJZlA3wfEvZN1/6lp/8ywWW/tIw0rYewJAX0WCRkQCTzHNTD0F44J1C0fMP5fe\r\nZPfjaxMfnEabXbZQmfToQEAQH8cPqLJ6xKj+jux9IQgPSCd5JMO2KxoiCQJAKpRI\r\nRBJvmaK2+L0/TFBShDOdCRo39ef8JaBsP227JV9CZsqKaoQF+TqYe7xqdeBeA5Wj\r\nemJBFcvHgHMx8iZdzQJBAMAa4CCAqM8FIlF50LMi/Mh07RVL7bpGTTZNgNmyoj3S\r\nWo4x/9CFpNLrR3Za7Q4Vxmb8DGdfJIgb9fu7FGMf97I=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOipOmH7ymZy3hQ41GlpFn6bgN\r\nPtEuQmvSDnZWbkfC0HWG7ho5uqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR\r\n9G+81YH6T8Qp8MyaN/5uggc6A7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzq\r\ntiKPUEpbCtFuQc+SUQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011121	cso_a_aps@dlsu.edu.ph	1	0	$2a$06$cWCF25lH8CjoWUviZ9KaEOBnknEW7Tm8LhtHs5ZQ8.Xin22A80Xy.	$2a$06$cWCF25lH8CjoWUviZ9KaEO	CSO	\N	A - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCOYiBI+1aZziS3gGvHXF03c87V8tL14124sGiEhUHRLVQ5Uo7P\r\nc2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0GAudrXsAenJm/vCUVEuxYUpUt\r\n3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGRBwbGbO5pizm1z5TQZwIDAQAB\r\nAoGBAIYd4BNezIAsMWG4Uc2ELzogl9/nztdWx91ELe9GJm0GqaMlJOg75qPG9K0u\r\nH+zJvJmjDHIeAuJ91J2RATiBnGb1uFTPFfCa2/I1x9V/jcdCnl6de6V7bnJGj4yt\r\n+FwY0O3YSEARUNuOrq5U5Naj6OiszcA/cUEhkOu0WpYvPsPhAkEAygdM6rAM7uNR\r\nlz05H+gygcyUHpplyBZv7t0SoroJZl+kQCGSVhPYusplkM1W2kdqzkSfgixhyYDR\r\n9FMA7fJQ/QJBALRrstwoLPw+N3222XxTao1ik7voUtcn7E8CHXA8VD86Cd/WC4tv\r\nz8VkMm5sDrZPHXlTGB0oBZQTalliTv3HxjMCQCSxZL/vT7oHoWcFoJ1x79JxVKmm\r\nQzwvDw9kKaFShqiIUG2xa0GlAyUR45aEJPUqKXTjM9FRvET716Y3eSC+dQUCQCbZ\r\nigoeHJG0U/6eAPbkf20ybN1piW0LC7d3nR8t3nY+6SFp1dKQoQzAJpvgaMqY/p/B\r\nZM/iblEUXTIiGSBMhEECQQCeCCAz+Q0yE9fdUGLyYASC2/N61l5rEXaeuj6eHFhj\r\nCi6j/bJJW7xSO9MXjAimu4jXUl2JRggT2/gZ2eSaXoID\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOYiBI+1aZziS3gGvHXF03c87V\r\n8tL14124sGiEhUHRLVQ5Uo7Pc2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0G\r\nAudrXsAenJm/vCUVEuxYUpUt3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGR\r\nBwbGbO5pizm1z5TQZwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011122	cso_vc_finance@dlsu.edu.ph	1	0	$2a$06$GVUbAQJ8blaY.txmaL/R9eOF/G9whhRdrApYwkbBo4EtpikmXEsUa	$2a$06$GVUbAQJ8blaY.txmaL/R9e	CSO	\N	VC - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQChUp/jlMxfxNpHoOrGA5DaT+2yfWLbXwM+PApszBLX74I8oRne\r\nK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+N0HVnjGXoiFrQ3H4ATKr7hiO\r\nKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG1qclxQml4ztiHAcgEQIDAQAB\r\nAoGAQsoPckx/lMLOUEt6B8MgLJJc6cHptMMQd6qp8kNHJel+NRXJvObALPy1srx9\r\neKLLq4IwNLj8VuNLqAkAkLsqCbJ9Es0OVcD4Ubx+oWy6mF+5Os8o+zvA/VaL9yM3\r\nMquCHgepg+NnjKmP8//6/u/DCVNix+NENRW6VCxpwJlVTTECQQDNH8PnP5ppUQed\r\nAXeWOWR7dSCVAoYIhyAQt8Hgu9a1UsXs9TG/1zVZNqP1mLHR8GdShD0mVozI8MED\r\nFYYQfWeVAkEAyVW4Hh/jJZKrgYWa+Ypi314E8VJkqrEmZt9HrmwHaI3BRv02Jldk\r\nSoJJvjmJxfkZaoDZXogD+AlKGy70bKAHjQJAItkosRrPIuFPR889/9mURp0pgedB\r\n2iUKv4xYddOzsG51jcJCR3NKbvOne0wLubz78LrioKbHmEO+psV7V0XW2QJAa9Id\r\nFPzsr115vZZoZUUIKCj4qqf+Qy81qpfeknlGCmcH39WQ3z2j9wcJKPc1YjFBvDie\r\nsDJVNcr7xc0Clv2orQJAch33cTkbl1v+TvSKyXUJhCv5hj8OMSFQKy2YRHsS0Yis\r\nW4PuwQiPdp1Xt33nDD31qVfZhcpTWb5HO9yJXGP9Dw==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChUp/jlMxfxNpHoOrGA5DaT+2y\r\nfWLbXwM+PApszBLX74I8oRneK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+\r\nN0HVnjGXoiFrQ3H4ATKr7hiOKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG\r\n1qclxQml4ztiHAcgEQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011123	cso_avc_finance@dlsu.edu.ph	1	0	$2a$06$LCYndXzMqjixhq4FwBSZDueU9FILm7L5osoBWtvWhPigDReGt5Y6G	$2a$06$LCYndXzMqjixhq4FwBSZDu	CSO	\N	AVC - Finance	63512316	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011124	cso_a_finance@dlsu.edu.ph	1	0	$2a$06$5A0h9SrbYMh6NrJ5gt0e0eX4Wkg633.7WK.JRXrL.J7/hIG6nihde	$2a$06$5A0h9SrbYMh6NrJ5gt0e0e	CSO	\N	A - Finance	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQDC1X8I3fweNqM3ah6SQA6f0zx8l00xgpEOByevUeWqXd1Ftp7+\r\nqPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/4dm6pR4pnw09lJ0E0Gtl/2aV\r\nJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUmJES+qmH3K7QToeN4yQIDAQAB\r\nAoGBAJzOy8FNOD7w5ogRBq3alGqZzlLQSzaPyUMrCwuVtGxbw1z6UBjR1S6pcRg4\r\nuY5Sfs6UfJMeaScRdronJ5L0BRWQ+lb/iCo+NGO9zZ36QNJbjD9iMtKneSgKkLcW\r\n8NW0VBsODMH9kgihzTwpB3ZoLh8wlKPJcOzuGX/1p2p5LnIBAkEA4+ac+byWeP8a\r\nTu8oHVhc6SUbQGIzenMxXdQOjoyUwmxnbGy1nvou210vwb/ZaUKkDeDh4U/ZwEE0\r\n0sAW4oE9qQJBANrbK+VZ9z89p/3nOLZW+EZUzxj4TVExHWuBGwILLSVfPv+xCNfH\r\nmL63XjlRl66wDv1m5lFbsrmU6V+RBl0+FiECQGLaZh6hYbeMF9JDRGguKubqNH7h\r\n2ah0jOZBFCta6S/IK7hJEyKpLGf0bMGiwOA6isSGVhQQOch9wDbmIUcQfjkCQQDF\r\nK33RhArnM8H8Umrag2Hr4w4tPc5SXoBV0Rum7LDAoZ2dOD5yQEURVRwTYbnYzI7E\r\npwbKt2U+IrVZvstQB9ZhAkEAvAIe2B8spxnFDG0KIUxsd9H5HUidfiqHNQ5Vd7Uc\r\nNP4KPvDCOkN/W7llKwUwYjyqBtYasC9/Vbkm2VyLY67V7g==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC1X8I3fweNqM3ah6SQA6f0zx8\r\nl00xgpEOByevUeWqXd1Ftp7+qPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/\r\n4dm6pR4pnw09lJ0E0Gtl/2aVJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUm\r\nJES+qmH3K7QToeN4yQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011125	cso_vc_pnp@dlsu.edu.ph	1	0	$2a$06$ZOwuNB1EICLmdOEZZSvEdeYMSkjtYGU/4NJnWUmBM9IrSfuY2893O	$2a$06$ZOwuNB1EICLmdOEZZSvEde	CSO	\N	VC - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCIqhYRfVFMwLhS/WPMcmxtKfRWgGJYmmuqCl6pO/CiaIp3ThmH\r\nts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3LZQunSjMuNGk8xkAGPFGu3im\r\n2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiGy2FUn6BFoW7mun7GGwIDAQAB\r\nAoGAN6gdKK5Cp+Fsr8+mDyMiaSrG6VuLsc3hvvROLNnOXDX6/i9+Ujju/KkYTERz\r\nzVKkMMKFblynROw+Z/fbGb6QXf0rTOnKbkQieK8YdNEd68J1BWhbD+UOrz9lhEBm\r\n0uMS41anqSGaAP2tFevVnl9/8U/pSmc80wXqDpH5cHBnnoECQQDOXZDonw6/GNn8\r\niWeDvWXG07zVGntKNCDe3RyrQZtYfbUKW2OwaAqITDMfV5Kr2i1X8xa8xDIEL2wm\r\nKsSKrfa7AkEAqYjZ9SlhBwLqOOeTnC6SR4TNn2KtBDQoNKgmMq+0d2nPeX/USiZw\r\nuAVpAdmVhzQS2zYyL6ebUfCHQw8qKyJoIQJBAKnTjEYzZ2JSJEpUFXDv84rtgw/o\r\nrB+DyK0/T7GL2zi2sr8kOGTbKhfChau8WMK+WORw83xDBVo2YI0EUxxBT7MCQFi/\r\nRfGblqo38WqWd2QD0RlVQNqVqiKQNxfRiiVwaxUzs6NTskqastjyJBUO1MKxFMni\r\nJgViROFw+y20i4uG+GECQBJ4/YRtaJrxMInKJa7bILbxMm0XMJXsiYvwtrhZwPVl\r\n2/F88VroQYVzIsUYOYK3vg6ldYHMQgEPhdplhc/vZpY=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCIqhYRfVFMwLhS/WPMcmxtKfRW\r\ngGJYmmuqCl6pO/CiaIp3ThmHts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3\r\nLZQunSjMuNGk8xkAGPFGu3im2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiG\r\ny2FUn6BFoW7mun7GGwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011126	cso_avc_pnp@dlsu.edu.ph	1	0	$2a$06$xWDn3P9QZaw6jCwZ3jUo9uSQrt/CiIHOlR6YDiQqr01ZYvoTSAT5W	$2a$06$xWDn3P9QZaw6jCwZ3jUo9u	CSO	\N	AVC - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCVHtq2eH91z0KzdE8k0Aai7F/QtKcl4cxhQJwUgu7lRJRXqRGQ\r\nPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVTZAZK3k8IPAYPsgy2vPaRwC/B\r\nTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCICdCtimFkHk1bDfKAhQIDAQAB\r\nAoGALU4FduCfIOTKSAkzLmUBTyhvZ9Iq4ih61qUxhk3NVNyEESntixxKcyTGT1lK\r\nBQS50F3/nSVc+8M3CsrTr4jVqZ80llON+lNr935mnzBJOqUXrTlbI7KJMm2qRch8\r\nhK1VxsaW8euABl/Jd+WDWwArYd1lfQbGHrwlcvzzz1hy9hUCQQDxeAzpdNsFufho\r\nGRf4KwHA4QW2mY5xmwyEGpc/6zFgyvsRqmVNooU5C3SZE7AZvcPriGWKAIrBPsXj\r\nWD0Sqz5rAkEAnhghYkbkbhugY762c4I+N+4slcbwjwWp9fRJvw9ljUIptY4eNPp9\r\nNzWnOB/8G6QBc9zjJf2a9WnBXSkH3SMYzwJBAKzgDh52EvielEGy9X4vDCpS8Awz\r\nE9Ax+Vv6zZ5tfASYTffvzmcum8KjeO6/May8N7BBDrEmgjCoCHUjj1X2U9ECQQCT\r\nY3XENMmEKbdnJobcu2EcLa1dWaIuBJ7GkaArQsRvZG6UN9HLnHgef6PNPGyCrG06\r\nQoV2hq/v+k9udfFB5hWbAkAdjPOT7CZ2i2kYNQLWADlX/b+o4bo4Jw51rPSty+r/\r\nssySvgGl9ggP11vrORaMIa/domqWw7ONL48qTM6TW//v\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVHtq2eH91z0KzdE8k0Aai7F/Q\r\ntKcl4cxhQJwUgu7lRJRXqRGQPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVT\r\nZAZK3k8IPAYPsgy2vPaRwC/BTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCI\r\nCdCtimFkHk1bDfKAhQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011127	cso_a_pnp@dlsu.edu.ph	1	0	$2a$06$4r97NW7f2qXpus6W91KH0eBf8TY7oXxVb0NUq3Y.OVGvnyRWn9z7C	$2a$06$4r97NW7f2qXpus6W91KH0e	CSO	\N	A - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCDMPPM2aRhI/BbEV1YTNKV1e0JfBoWVJj3Z24izrnSk0G3EItV\r\nYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oMiOeTzCjJQ/a9mel0exGk/1t2\r\nfz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm3/xyb6TWONUr0/rn1QIDAQAB\r\nAoGAQPfSFIVHkU+h7QdpaZwJwWgCjermZF6arhKLiTNE9NI1/fl0duGxh+IQOS+R\r\njA28M6LahVDCAeo9jwVD3Yxu/V7C4jRQCO2h89OEbBUUMw2Rz9+BBxqFeQLuMPLL\r\ncGOltN5FPh0VTJ8/7SRJrh7GByV9U/rrRICPMbpQ4PRZagECQQDXeeBbBYKn/Fay\r\n1AXeTVtoceUNdQE2RPUNxcTVuvvvEY46fTBrHqc1JuVzu/ms+nkOrSaJnlNyDW0u\r\nF2v6QGuBAkEAm90rqDa5rPUqd+R+YFpiHbMaYmvOJSnBhTMPzj59XpcsH10G+5c/\r\noSIS7PPMoI0efN7K/WwgZV/MeuC+4uo2VQJAZWW85hhZu6NLSSvs9weAFE5Ec2i0\r\nAU3B45FFZy5uj7m7LFrtBfuOw7xiDWxPuc7EWNuyXuBadDlNP3tWHJVkAQJADdHv\r\nlAu+LPLUICtXdU2uU3nVBhMPBUaNjTT42s25qhB3bhR+kQJZNv1hdjcr1rSMln/e\r\nudfDi5mR9PdGlbI0vQJAA3H1Jo2Y7rgFmUbH1DVSAY9bq/VcQGY38RAMH2ZhnhAb\r\nZfcWDwvDmQo1dVyyGo2SuOkhkGwvv6zjAy5jj0jWiA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDMPPM2aRhI/BbEV1YTNKV1e0J\r\nfBoWVJj3Z24izrnSk0G3EItVYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oM\r\niOeTzCjJQ/a9mel0exGk/1t2fz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm\r\n3/xyb6TWONUr0/rn1QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011128	cso_vc_orgres@dlsu.edu.ph	1	0	$2a$06$wMVTuI4tga1khI7QdNbFR.V67ee9T1F8Q79TBaPxx76.NIdKnc8lC	$2a$06$wMVTuI4tga1khI7QdNbFR.	CSO	\N	VC - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQC30FZyZj8mXFG3+PhdCjUuq3XZA/tgETJF2MWykVDA9PtGHBUp\r\nGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+8qfMvku8z5djxon9iFBdboy2\r\n0z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmVO19bxmutmUVCreXNlwIDAQAB\r\nAoGAeH0RXXXWaT/UtUJ3Ew3Q5KGx4yowCb3b9Vrt5GpKw+ESINfhqwonp704SBLH\r\nH/R0JTryyC5Sk2A6K7pfqonBoT2it9DmeRcbHAeuIR4j7ktee0PYySlC7tJkDCwT\r\nxIjHNR8ERKJkLE5rbVSSiOFJm0+6t9/0RY8nK2jaPBclKLkCQQD6m/LsAkWSYMy4\r\nyvcclKmJas1C4drQ0UMmNKyVYnio07tz53pomawgunnxCM7jkAa0HCV7l1cwF+ld\r\nEdtPdLf1AkEAu8SPoEc666cgrOi5zDw0Mh38nRUBDSltZx9MtoAK1vcjoKs0v73u\r\nRb29eVQUjjaz7+7uBqKONjOSXmJ8zshT2wJAKQIDyiLFB6LXXRW5QfABnf7f/6W9\r\njJXxivrrkrY+UEH1Vo32Nc+PnvtkoNB0KkCTGD3S1Fp7Zd9DzHrzjBjpUQJAdE02\r\nrQ8Rpr75FUB9PMyZg+Vg/6bv5MghNHuFl5DNpgKj9bO104IAIQB6aLk0ljW51EaI\r\n9mEfduEQqxeTuL0KewJBAL1hayWIehvj1zGvJYmyc77IwQ2BFgdSw+b44ONE3Ocv\r\nQPioERQTABNTUF3gFSCPhpnzv0RTU1aNTASBWMgT8L8=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC30FZyZj8mXFG3+PhdCjUuq3XZ\r\nA/tgETJF2MWykVDA9PtGHBUpGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+\r\n8qfMvku8z5djxon9iFBdboy20z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmV\r\nO19bxmutmUVCreXNlwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011129	cso_avc_orgres@dlsu.edu.ph	1	0	$2a$06$alRyWe5yJ4XyGbZeM9q1XeFpb1zojm8SPTwOJOHRotoiFgJIzpWp2	$2a$06$alRyWe5yJ4XyGbZeM9q1Xe	CSO	\N	AVC - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px\r\nd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD\r\na83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB\r\nAoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi\r\nSFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3\r\nx11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA\r\nrNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4\r\nzzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs\r\n8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz\r\ndTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU\r\nucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf\r\nOi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw\r\nDHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc\r\nahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT\r\nuFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY\r\n9TSVIY79gL6owf+2KQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011130	cso_a_orgres@dlsu.edu.ph	1	0	$2a$06$262v.RcbLYEASa1pIfiGjOoFV3CFScaqIyNw8mTEKlC5Tn2yvPZ7y	$2a$06$262v.RcbLYEASa1pIfiGjO	CSO	\N	A - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px\r\nd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD\r\na83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB\r\nAoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi\r\nSFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3\r\nx11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA\r\nrNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4\r\nzzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs\r\n8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz\r\ndTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU\r\nucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf\r\nOi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw\r\nDHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc\r\nahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT\r\nuFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY\r\n9TSVIY79gL6owf+2KQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011131	cso_vc_amt@dlsu.edu.ph	1	0	$2a$06$.IjMGsb3rMZZl2/ky2PAt.7wea2uuoQnEzsoD2d4nlWliR0PHfQaa	$2a$06$.IjMGsb3rMZZl2/ky2PAt.	CSO	\N	VC - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCeFN2GSH42bd7cFgBAL/8+wuqGPfKvgGPA8YKQssFMN6LIx5fi\r\nnI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJSZMbc5zMj9ZlvoYOcId+51zB\r\nstyu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMjsrNfbf895LdAN/bTxwIDAQAB\r\nAoGAJU7RVT7Iorndbd23Y26wc7R2uwXlv6uyXzfgU5wMaJt8zJvmabH+4MwL1TWM\r\nmbJ2/PDgsCmmik+aOf1BZTRYQ5xruDd3M8v0OTiUbbkZgao2VwrUC6zR+zCK6nC/\r\nwLnONvehp0sG3IWJS4NU0/1Y1z16XvewO0wbfuMCWAB7qKkCQQDZHGh0UJxX5TFI\r\nrmWEs2tjEv7Z7miAwC+DRDXJ3ChE2WbhumOKMDymzJHJyG/U4KDFZmmfG85WXzJc\r\nL04FFPzzAkEAumWrePZfV/a/Q43JamF2aw2QIzpNdopVGoQYbzO7s5x7hKU9EV2r\r\nM/wGo4apRQQJ66iwLYZWR5gu6Ws+7wsy3QJBAMyubIdjy9FNgMYNrCWL5Oy1ZtBc\r\nY+clyGVPdApHZStrbgPW7arEyRlTeQorzcp6rvcLEv5uf3uMKfUgn8RIwiMCQAcE\r\nOr8z7wTdqfd+B930S0PeX9WjpTTYIjn8TPsqpF8vfcrReYoEz6QGUa2oLQkHDOSN\r\nFgywqODLDsEEo3rWHhUCQQCHhoumTELnKoueQ7SCG5G7d/cnsYLgzHX96MLCvOlP\r\nlWBVZ/QbUBAe0on6mvpzehnD3sS2wOQl4sET1k8eeCth\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeFN2GSH42bd7cFgBAL/8+wuqG\r\nPfKvgGPA8YKQssFMN6LIx5finI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJ\r\nSZMbc5zMj9ZlvoYOcId+51zBstyu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMj\r\nsrNfbf895LdAN/bTxwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011132	cso_avc_amt@dlsu.edu.ph	1	0	$2a$06$WJxnkWS1wHgtMVYqiTUeceN.xKjVwyRKP0NajtQm.HvoMe53zm1li	$2a$06$WJxnkWS1wHgtMVYqiTUece	CSO	\N	AVC - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQC0I5u8qRuNtDooiaKMQEw3gfnSV+U8bCmPpErGMnXRj/Q4sC6F\r\ngl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9nr+/rs5iQ6hqV6QGsGtKwlpLW\r\n2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL60eyZH+KAqdDUYtl8wIDAQAB\r\nAoGAE+US4CU1G9NZ0PxSbXb0c/Tw6GA4uxGfDXQxpe4QwRJLAK/Ek44wkVpHN0rS\r\nhibsajlzoEKVRTlYs+PhvtzwyoPrd66I6izjSL8bMWwTKXJQBEtorsh+2gvQd739\r\nzpESr4UunEIFBPHtgcE1vrCj/hDTaUaHBhOSc4UcQxfUWEECQQDgFsfgTOGOw9it\r\nb5xi7w2a+kWZZSBnwLCuSpRB7iujmaZZQd61Bhl8cpNOVO14eCAHT+pGSi9/BzDj\r\nNeEc0DLjAkEAzcqfmUoGwWSK4Vj4jy1f/FzjZ6zSWOPvmiZuOWvhBj3MVfM92D+l\r\ngfaA/CDHFTQioo8pNzHV/f9ZEU2VRoGdsQJBAKEEXXyzYYPHAAOnZhTEtt78JFST\r\nkJRcpdem6R7yt1KnzhrmtNMYXenJHkWzyqq8ji8S4kC9f6FkFmG8zlN42ocCQQCS\r\nCfTwp2Pb4inceXMKyDyRrqmCbVZo1ni2gAdAoJnz/+7+H7wHtkMR04j9Y5VkKrdZ\r\nfRbWoHsn4QmoCdKhUmJBAkBF1iXf5/sMH5zon9QMbc7R7VxJe68Xvnnd4uG+UYD1\r\nfZV6DOdrAH9JYVrQaX6bDDEWIIiJI9+P7n37tsbDdHEc\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0I5u8qRuNtDooiaKMQEw3gfnS\r\nV+U8bCmPpErGMnXRj/Q4sC6Fgl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9n\r\nr+/rs5iQ6hqV6QGsGtKwlpLW2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL\r\n60eyZH+KAqdDUYtl8wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011133	cso_a_amt@dlsu.edu.ph	1	0	$2a$06$R/hp9XyZrDCRThLDByz/IO09O6..vOn5lnGmVpGA4fGBL98P0.e.2	$2a$06$R/hp9XyZrDCRThLDByz/IO	CSO	\N	A - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FKwQQuq5ajaMBotZwzh3Of1WJ0\r\nS4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUWOpjTkGUr3b1UyVqbaGTdFUPF\r\noBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYPDDyxxIDgdyXUsRAzzQIDAQAB\r\nAoGAa+2gHmbqwzA4fnhOLFucAQN6Mz4U4cqbw98Xt6dw1tm8bt/MCTadk7aoRPKW\r\nGqyD1j5GtOl6LKGcg5R0sGdbVV38uIhm3coyGZCjIoWqxDbThv+Pql4wiuzo/j8O\r\ndv/1ki3Fll07CbCA+OB+P56zrViHq86YJAOjQLHAPOU7wAECQQDHSco3nAfMpWHB\r\ngCiX3kzI8cUkZmoPVUk0eqkAPAO42M7+uU0a6lT6+J7TSJ16/gypLo0yH+YPSHLM\r\nPCnbWxwBAkEAsZa2rlnZtYosSSCERW7jZkVKzRsxBrfraAaxyaKk2e3eiD+yvWKO\r\nUhHqiW6zJJun+w373dC6rVGLXQ2ozlbHzQJBAK9cGvh779D/5dkjMJUSI3beZ570\r\nD3eWkGgBVxzBsnTBMsOpwlNgx45fn0JDr28+hV2JfO0SbJoeIgXdGufOcAECQAV6\r\npuw+LW9icfdXn30c7LstDB/D5QFWD1dITZfxArEOm70MahFZxxZVIy1WUwSgINCo\r\nH8s6M2hBidE3KKwlFUkCQQCQYChZko5REYv7dIJVPzISLXpCsR794R74t4FbHO3e\r\ny0p8vzRsm8IYup9GlvdF0t2NUQuBLNCHK3ajS58iQwsR\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FK\r\nwQQuq5ajaMBotZwzh3Of1WJ0S4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUW\r\nOpjTkGUr3b1UyVqbaGTdFUPFoBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYP\r\nDDyxxIDgdyXUsRAzzQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011134	cso_vc_adm@dlsu.edu.ph	1	0	$2a$06$7wQescTeehVbP0jn/qnQgu1Luab4akaITXSUXX4Ad9ghKNUcJOcJ2	$2a$06$7wQescTeehVbP0jn/qnQgu	CSO	\N	VC - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDQVV5SkDUwS273nVMNCihKHiRiF4MqBU832myNeqTZaJjs+iJ7\r\n2WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEjhQ+f5O9YGfdnLzkRu2BRN43c\r\nxV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+5NgLWK7H9ZUo7gLY/wIDAQAB\r\nAoGAG7dv0A4tdVpjzf+ZP//c8ldmQcKdCachLe4aSQxLCD2ZMtXoZo+7l+sNLDJr\r\n5m58xiEHAapkM+h/Ec6lKVDDOC3cnKAMT8PZBc5i3HNvmjgpyaCeZHasF5ddXwsW\r\nGPOGXgF6MrH7EVJXfwyn/wj3DONyo9lqQg6ecINnACBKUkkCQQDyVH1y1Y8VdjLd\r\nzo+JZVu3H53HdAdf34DYWsdXLtv5ZSL3iB4PJKvWh2zwy9bwHdmWbDL8+ThAi55V\r\n1w5oew/7AkEA3BXuT0VB/FfjsFn36C6BfxH+U4groNoTw5yFbllOZvot1/b8DiGU\r\nCigCBe3GTAvAgHYdqunZu8grIEVL1v6XzQJAQsOUbHb6HOebzBCE603JnwJO7gzB\r\nm2BwlysrkJGQeX2rzJbr8TAhR9G36f+/EBipQhA9XAUtwlq1HOFLTu3Y0QJAeM3c\r\n6kwkxSNlClbH+f0U/a/dvvIeqIMrmBKhNwn0PBgU89dRUVxjCxQc0C5My08kEh9D\r\nd5428pkT+vmugEts/QJBAOTqk8M+wkezaz52+QIxcEldEiDk/ec2GX4mE33Q6a+V\r\nDilv+3Til5GB6nbRXf+pwJcw5DWFE9lD18v0FWmsEzw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQVV5SkDUwS273nVMNCihKHiRi\r\nF4MqBU832myNeqTZaJjs+iJ72WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEj\r\nhQ+f5O9YGfdnLzkRu2BRN43cxV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+\r\n5NgLWK7H9ZUo7gLY/wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011135	cso_avc_adm@dlsu.edu.ph	1	0	$2a$06$jBODvb8/j69LIFSKkBNJ5OL/ctc0CkvQgM3BWTYIrTTbbn3MKm71a	$2a$06$jBODvb8/j69LIFSKkBNJ5O	CSO	\N	AVC - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwYPSITb2K6OhTB0BMJlETA0EDR\r\nlJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxHiYZyulryhi+Mi6uEAmod0M9f\r\nEYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmfjgW+f4Bydm0KABo69wIDAQAB\r\nAoGBAJN8urhlaEqwmgWgiISziUIAqIpqzoZ8Cj3hx5FzE7N3CoGSB3cTTQnnIZeQ\r\nDJtRSDY5JMZ3u2c1TqpUQnPmho7VGEb5xZpDmJsFVHXB+8A8ghHdKKFiEvkLauGN\r\ntFq/qlcfqkJZnpB5ZEmQNQj6hsM09+voxQQbHaVZSFkbpPRRAkEA7RfA+t0t1j+x\r\nm5QcB0/cl4IHxOyh+YnA1NGc2uHw0A3mlaE7kqGaqwNaf5Gz7YIjlrP3bMzNtvAE\r\nTHIgxcxMmQJBAMWpJrgGX2QyYJ7R0tIl5Nhx4WgEbq6coe+wDNnLyQjYAfG8iKDY\r\nMzA8qR93j0FiGAzPahiY9W/xDTw54Uz4bg8CQQDP9LTMlPGeaXGUH33SIAdBUMkV\r\nveR4Zo4fXNey2NiK9JZaifghreNmumNHX3otCafDiIiuApkxKybqEnSSaZaJAkEA\r\ng+7DyVF3momFtHyZG2vvtAlPSv6qYiJqdHIuIbHEHgMQSSpuh+3HPQtAV6CWHi47\r\nn1FSn9h4+p8LFogLujSYQQJANX9bzf6g9Q7uE0gvXCxLsQ9r7CRUp/CqlLuZEaV2\r\nDetc/IIv1R8oXhRhEVN+miuyRzRh4IFPMvFMAcnXzRfASg==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwY\r\nPSITb2K6OhTB0BMJlETA0EDRlJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxH\r\niYZyulryhi+Mi6uEAmod0M9fEYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmf\r\njgW+f4Bydm0KABo69wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
1011136	cso_a_adm@dlsu.edu.ph	1	0	$2a$06$6yd2nTSbG3eSI7eIAL574Ov4jmccLd5LpTfwQnHuJI4MFTE6ENHjS	$2a$06$6yd2nTSbG3eSI7eIAL574O	CSO	\N	A - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCcUZceVzoQ14sv6oquaBGE2lvZxfVd2FfTFh4izfDBffzi81Di\r\nkrcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoVlCSpj4qmuWNs/sXYBQN6h+5w\r\nEvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3v9AYT5zjEv2/kSOiVwIDAQAB\r\nAoGBAIpNCZW3eNEz0pqHOUGLI4zWIJOxOCBaa4F/vRPv/sVCcX5d5b9ALT3ZbJ8q\r\nSYS0VZ63oJ1ERMBPynyD6PWKhw7+RWQrFHjcLHywBPOFeP5QfBjjqaMeUCjEDtFP\r\nGq0LE+BV4NpY/j6FnJphk7NQwaFQ5qOk+uHHRtAPJ6WHHCSZAkEAzdhwUnMPY499\r\n334merHW96uRHsbIkhJ09TrIK99fsIp4JaIXDJxdZQrKk9nLwo2GebJjB34gEj8U\r\nyFfaECKGSwJBAMJn7q1saMS++UWd0t6jXOkKbgO5iwI6sLdgiJUYlv5q5CQ6PFua\r\n0Lekt4qN1Bnbtca//j10b1ckvUWF/pZMvKUCQD3mpIBm0W3jLLsUuIWVDUwVb+KN\r\nbKtgmYNVVfS7i48PVOocQEoui3djM2Aa0seCv7nBBz6tkv9psNo+cPkBKNkCQQC8\r\nqoTVxWn/1p6v0zS8YKpgd4DBGKYxaafqr0Kd/5k6G56BEgtVk2+Pacm+K1p2JeXJ\r\nlrY0CfWsCrms6Rdj4eEJAkBYKrpRZUvpujanQsoMdgDb7SS3xaW0vzIclIqg9FFn\r\nf0tk8MiOLy0hDX1xpmjutW2Ro4HZ1yjWZD5EOBGVJtVY\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcUZceVzoQ14sv6oquaBGE2lvZ\r\nxfVd2FfTFh4izfDBffzi81DikrcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoV\r\nlCSpj4qmuWNs/sXYBQN6h+5wEvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3\r\nv9AYT5zjEv2/kSOiVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2011111	facult_adviser1@dlsu.edu.ph	2	0	$2a$06$Y8QP5/av4VQWvKbMkUwUWeFJI.LZzZ2yMto4Ssis52EFkGU3gnI9u	$2a$06$Y8QP5/av4VQWvKbMkUwUWe	Renato Jose	\N	Molano	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCyws+X1ZRyQBJ5vh25G2ost83GDrqAeWfyUx05Uoc9e9gYBOeO\r\n6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbNC9SnMnHgKqOUVYejStbTYrjh\r\nFCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFuWx+m9ERVhAXPzXKZrQIDAQAB\r\nAoGAWVitUYJas8/6bAbt7DsbkkY7/yYVaWlE3wVTsfbhyYVAuKCa6/9miBwONM5s\r\nmPhuDWE4enuUpDnifvGzDOXix/NXtbTRn6yp/zkS+jDov07fFIdDZ5heB1CGbz/l\r\ne/rG/T3634yeOnQpCTioCjp5EXMKpKdbR5AbHdkIP6pXZQECQQDWpWpMztIDc4Ih\r\nS9wEIiJ0b0XVNpPutam8Z1SK+KEUUx1wXZSuK2skVzeNM2Lf32ufpzRaNx7gSQx2\r\nraptBVdxAkEA1TN/2LGUTFXGdP1pUje0G/lMarcsYtcdWuGN3ZdWjQjAGN4lyTnV\r\nUY7bZCgt3CnDKuiR9SeQJfeczOXpRZyf/QJAEMg2G3NAMEzjq77GoPwaPYhFqXnu\r\n7wb9EmHx1jvCPFiTQKnQah2y7tBy43NVE7PgMkdcbIFKxLZxZwYFASkdwQJAeXm/\r\nZVtA8QGKcwwUX2knsSypUsCNhL+mlSqg51ocUX1j3odspivSlIa+EGIoRyJwdllP\r\nGIzzP/7Gk6SH9kbYjQJAUfvdqQXeZNi9yUSpz+lVxcjJYrhqJ220bwn3n1TEtrrZ\r\nfPMR4Ls4cC0Kd1HZ2d3FpC6rSDUCnnJkuS9m+rA0SQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyws+X1ZRyQBJ5vh25G2ost83G\r\nDrqAeWfyUx05Uoc9e9gYBOeO6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbN\r\nC9SnMnHgKqOUVYejStbTYrjhFCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFu\r\nWx+m9ERVhAXPzXKZrQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2011112	facult_adviser2@dlsu.edu.ph	2	0	$2a$06$dZ8Z.9B/tXt3//1/IPZzaeNd6.7KskrOzqFiya5oEmplvN0ECKjWa	$2a$06$dZ8Z.9B/tXt3//1/IPZzae	Edward	\N	Tighe	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDNbmt2Yusudo62x4tkPPdfWMHh\r\nDmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv5dvu8v/ZNvE62J1Qzi62cu4q\r\njNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8LNkU/Rti624DHqMlxwIDAQAB\r\nAoGAbBwes2hMRLyUwGTXqmiR6MYaCxranthOsonC1eRU4YPCsDvii/E2dLBRuDWl\r\nPYZ7aKmCvZQnI++rGg7GSa/xonrEQgsg4cY+odlOPbmpDca2ztLglNefaYQ2/C0P\r\nY6coV7/5w7XsIfcVhpE9x1fZ313xCpI/cN0PlHAV9un2cWECQQDcYXoiCfiuzonC\r\nUH+ssa7MeIY1iNpLGB/yKsTumtFCUClMrOgEhImV643BZTh6yrwSbz6F/SDoTi6q\r\nfF/eXd0PAkEAlukI27LiNVuVeKBvbheqO0tr5HA217/lrMQnuuQYh45bIpQNmQQG\r\ncsGrkrOd0wUf4jhs5v9jQqjdn43DlWAbyQJAb8ahA5K7Jy5qgLwDhbu5RMv8hjqb\r\nPWtHCLTYnYy4hkHSMKmiJGh0wC1xAJ4uP1mEenUh6SOyBSFiWeYrWcWR0QJAIQU0\r\njv4BSTOU7SQNvcUn1nmWThHPrj2q/7acCuTGCUM45cQHhae/0XRXGm565iWE6Hb4\r\nPUM8cOWKONNILHMvIQJAcw7yJAltG83X4LHhpti+xNvPvIOPdQTMOclzs7e7IPkm\r\nki2mak5s9yvwAVeIjjxln96iCNyfV/axEPrrZUd2nA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDN\r\nbmt2Yusudo62x4tkPPdfWMHhDmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv\r\n5dvu8v/ZNvE62J1Qzi62cu4qjNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8\r\nLNkU/Rti624DHqMlxwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3011111	slife@dlsu.edu.ph	3	0	$2a$06$D1J7n7kds50c6o/nWFs4KOF5Cw4QNrAVZfYVlCFofuwgAMi1pmrjG	$2a$06$D1J7n7kds50c6o/nWFs4KO	John	\N	Lingatong	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCcEc2MftJ4+6v7RMlBUOm16V+WJDVWYPg+4V1uhrNQRhpR0tbx\r\neYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+5a6L0Baj7Bxj77qyK8/sAM43\r\nNvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH+srh+1Vq+ifzSoXLmwIDAQAB\r\nAoGBAJdGmlpoQ1KJf3YagokRCLgO8Vvy1NBZRcaNY6bSYdSZXsGZAEcnagT1Tsg9\r\nzKhaMSRSJns6qn1TUpdhbjt1zaSMT7sYWi+hjMi+QG9hvKdqAtrBwNKvO9WP/QSF\r\nlTo4/1NpumEE6hx/5CmdXEE0HYoNSLZvjEtA4TVmdbqFY+GBAkEA5GvfeniBnUAR\r\nRdhEx3d+Al8fZSq8VhWUW760n2bK8pAXsXAbkQGUru8BODWqg93oUBNJzvqTstoL\r\nRZ8EYLq88QJBAK7pp4TJx1m3ueviFw5sFEQYAf6dzdTG/1xoKF4fxorLkvPKLv0P\r\nRv00AbLDVL984HDm6qgvDBcSldpvr4BLgUsCQBQGBMwmni4bvKfjwnu91NT+Y7Ep\r\nouLk92FngUvr5eSHjxwl2LTIb7E6EGBODAmNPV0vo6u6OZJXHN/Yhbi5BfECQBjY\r\nTZg6BRwEUd9knPvKdFJ7yoS9K4iGv60DioBcKRp78iK43FXLvrymj3sx7a7JcSP4\r\nWOqMzD3WwPxnEtm5X+MCQHo3kgMtH6ChR7vLV4LQTwwf+way+YH7d5j6UvZaa7ZB\r\ndMSXDysYqzDUu8CJwiQkK6cFM8GjypKQINfo0OIzaGo=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcEc2MftJ4+6v7RMlBUOm16V+W\r\nJDVWYPg+4V1uhrNQRhpR0tbxeYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+\r\n5a6L0Baj7Bxj77qyK8/sAM43NvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH\r\n+srh+1Vq+ifzSoXLmwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3011112	dean_studentaffairs@dlsu.edu.ph	4	0	$2a$06$l/JfVTtRVLmaQajYPRKQtO7gnLfkktH9Wmn039cQlesPN9Duu2kP2	$2a$06$l/JfVTtRVLmaQajYPRKQtO	Nelca	\N	Balisado-Villarin	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs3xG0YG3ybsxNLV7RD1CwJUYz\r\nv9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBaNktuUby6Q/f/3QTVdH4kjiIw\r\nYVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNFB+7Mb7k7R7UIsHG6wQIDAQAB\r\nAoGBANGlAT/vWdVgiPWxuRi1GpOjmrfLBBVjIVFKd0x6iBVMT84Hph3ivl96U62x\r\ny8O2aIz3a37xWr81ho1whWHLSHsKNJ2W+WQhZslVgRtDccMpxlt8TAJ9OW5wLzOD\r\nS8olb+H1w7eWYGSRwM4McTSJ3qNcK4XL0yQIHhg6lvf7oMABAkEA6oFQlGc0ikS3\r\n9fGFGUwd6h//LklZtXzMstAcXMecCqsq7hFeNmETYrCwKbKp5HMcH2cqn1e6rxJs\r\nT2NUX+evAQJBAOjRcPmZkhmqdOXyi1MrWlSVzBDpJ9NvxX/5cgrjrSb3AD3wxQVN\r\nk4E4Vyk1yEtKEpu56Tln/jl+DnKdM/wBy8ECQQChXr8+gA6Nn2Af5EU89T4YoFAP\r\nX/ZVhz2tRrxdtBZS2Rq/nEACl6apYQC4kPOL+xI9IdcYs1wJoVna/3VOUbYBAkEA\r\n4d6XqT/JEydhA9l8O7L6jsdJVDqvDZ0JUa/SaSgbS4ska/NTYWKysRHU1cE80XZK\r\neVQzJSNz65kVMTK8RUgEwQJAExbSR7jDWM8maHfKj4ac1BNDFWiuWdtClZzTT1NU\r\nI/oKw8JLTN8ar+eMMN+Ho6AuPk5NGo1TCRHc19ShObpKQA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs\r\n3xG0YG3ybsxNLV7RD1CwJUYzv9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBa\r\nNktuUby6Q/f/3QTVdH4kjiIwYVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNF\r\nB+7Mb7k7R7UIsHG6wQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3011114	vice_president@dlsu.edu.ph	5	0	$2a$06$OUrLenRcJTMKbGbwW2R4du.66MrwvVbV8kpyOPI1SUtkw6bW75nbu	$2a$06$OUrLenRcJTMKbGbwW2R4du	Michael	\N	Broughton	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCb/4C/HnxA5LJnhEF2mVDIJwtydvQs9E8xo5CTI3ZRQn13l8M5\r\n0nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6PSDUzf06zNjEiX2wD7lo/qg9w\r\nrQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64qh+BoPrbOGiDLdHcGQIDAQAB\r\nAoGAcKjrcBsyHSOM/Fl1dZNv1bzs9XOXEEg4UV8Q8FJyBmmAdzgxE7c7rvVOVuwP\r\nr3KA6Q69WkapuzD07T6UbGjOBH0rC8m/D2Uv3mY3T4oCATXggkEjO5R1taxqwnxA\r\ndeLSLUmd9SfER+wjz9yVui61qTVc04DzQlrgRIfDvsNKrkkCQQDMX7fx26tL5xHA\r\nDVQPErhSOgZcdutzYD1cTO83IUTKrb3JAqJgWF4HXL9B2VivknBKwGxuZUlk2yg4\r\nOlsFY+ATAkEAw2d0pLrc+jzIwDL8AuhaNBrQddGRony43fQG6lDiZ7ju0a3wDvxD\r\nViw+t0ewSJJDXtB7/pe51GlZXYkFuwMQowJAK4ow2/vakH8XzvyH7fYlAo+OD2De\r\nZGQabnGNfQc/apZ9GjfPdAsfbR4bOOIe/LiL58D62MIHUs9F0ETOY2WVtQJATc3w\r\nzPK2sFDpolXqsIGyARM4M+F5Opisx3u2ETCZpbEmLokyj9T0PuipJDNARvUuLB+Z\r\nb5scXC6CbdL0XC1xPwJATnkbd9B6j97tYvSMx+q2P5qjGzODynrPLgYCnslRpx7c\r\nbvzBfUthH4/lLfHz+T/0YUpsAbZv1QDt7SivM+Xkng==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCb/4C/HnxA5LJnhEF2mVDIJwty\r\ndvQs9E8xo5CTI3ZRQn13l8M50nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6P\r\nSDUzf06zNjEiX2wD7lo/qg9wrQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64\r\nqh+BoPrbOGiDLdHcGQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3011115	president@dlsu.edu.ph	6	0	$2a$06$G1f26vHS5y6Q2.b7uNDCneW6fmTnIqxOA/u3zCNo1iRkT5FulRqM6	$2a$06$G1f26vHS5y6Q2.b7uNDCne	Raymundo	\N	Suplido	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr\r\nEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg\r\nuMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB\r\nAoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu\r\ndRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB\r\nxbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE\r\nsnc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0\r\nj+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx\r\nlPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0\r\n04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX\r\nVn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC\r\nYzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp\r\n4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z\r\nQKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8\r\nRMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f\r\n7kyMwenO80F+UxAahQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11445955	juliano_laguio@yahoo.com.ph	0	0	$2a$06$1N/4l96AWQUSf0QoIpVqF.HjGJKTdWN.S79TqYdTNNKtnzJ6mUzOi	$2a$06$1N/4l96AWQUSf0QoIpVqF.	Juliano	\N	Laguio	9266386421	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr\r\nEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg\r\nuMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB\r\nAoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu\r\ndRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB\r\nxbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE\r\nsnc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0\r\nj+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx\r\nlPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0\r\n04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX\r\nVn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC\r\nYzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp\r\n4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z\r\nQKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8\r\nRMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f\r\n7kyMwenO80F+UxAahQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111111	org2_president@dlsu.edu.ph	1	0	$2a$06$6a7v0SByCettnIxvN4zvoOgTQrPxWzoZrtj3B.x.Z93j0FkYReT/O	$2a$06$6a7v0SByCettnIxvN4zvoO	Organization2	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111112	org2_vp_internal@dlsu.edu.ph	1	0	$2a$06$7ntlKbRWpCAp5DNYq7Ma1eos/m9wP8lw0Zgv.zqae7yXNIHE9ZSr2	$2a$06$7ntlKbRWpCAp5DNYq7Ma1e	Organization2	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111113	org2_vp_documentation@dlsu.edu.ph	1	0	$2a$06$mcrZEerAcK42PWBBmgzvZecLFIjvC.ESBhW/D3HQtb2DWvbUPtBDK	$2a$06$mcrZEerAcK42PWBBmgzvZe	Organization2	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111114	org2_avp_documentation@dlsu.edu.ph	1	0	$2a$06$Cu1DDUPS1yGOiAzDDfb.jeWVzoIGLxDkgHHru12CNKbv5JJetTIAO	$2a$06$Cu1DDUPS1yGOiAzDDfb.je	Organization2	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111115	org2_vp_finance@dlsu.edu.ph	1	0	$2a$06$k/0rlPIsXDZS2gdHXqgx/.ZR5Os8tMOBKqyO9D0caXk.cubZDl3RW	$2a$06$k/0rlPIsXDZS2gdHXqgx/.	Organization2	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
2111116	org2_avp_finance@dlsu.edu.ph	1	0	$2a$06$jeehUMZ2Shqm4FdYLeZ4Ouf/CC18Ke9SDaZXIgY.xu6Ni7gtdtfB2	$2a$06$jeehUMZ2Shqm4FdYLeZ4Ou	Organization2	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111111	org3_president@dlsu.edu.ph	1	0	$2a$06$l5FtmpYY89oMK.W2jvThNOuJm/rnJsBd64Xha8mCuDGlKf2l9wmO2	$2a$06$l5FtmpYY89oMK.W2jvThNO	Organization3	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111112	org3_vp_internal@dlsu.edu.ph	1	0	$2a$06$OEvRQneDRXhLSYNiBglVGevEbAMBQqzcxY6FrhfbmoCuoTGAd6KQ.	$2a$06$OEvRQneDRXhLSYNiBglVGe	Organization3	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111113	org3_vp_documentation@dlsu.edu.ph	1	0	$2a$06$zjEve1qIFWrtT6gdpI7enuqyCR15DC2sv5a48Ul58kd6B9yRV/WD2	$2a$06$zjEve1qIFWrtT6gdpI7enu	Organization3	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111114	org3_avp_documentation@dlsu.edu.ph	1	0	$2a$06$NDvjprlxRHg9L22C/YumBOYSJaF0hU6JDiMUiPBDL52YNskkhtaTW	$2a$06$NDvjprlxRHg9L22C/YumBO	Organization3	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111115	org3_vp_finance@dlsu.edu.ph	1	0	$2a$06$hgylanJLRu.hyoQzlOgihupu8lS2.3gjkFGe.GSnHNw4CEzPZ9roW	$2a$06$hgylanJLRu.hyoQzlOgihu	Organization3	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
3111116	org3_avp_finance@dlsu.edu.ph	1	0	$2a$06$22s8ZIx6Gdgpr.8yC4E94uWNJgG591mBx90tm66G3fqChY5vB/S9y	$2a$06$22s8ZIx6Gdgpr.8yC4E94u	Organization3	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111111	org4_president@dlsu.edu.ph	1	0	$2a$06$EzEbC.VxrzSkji/uPQuMyuYv1JP6Aqucedshz4BXefHa0BowapKb6	$2a$06$EzEbC.VxrzSkji/uPQuMyu	Organization4	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111112	org4_vp_internal@dlsu.edu.ph	1	0	$2a$06$p6bYCVu9whLizEGuVzoF3.VLreyFIQR1JQEiCK7BqckGTaSCEABiO	$2a$06$p6bYCVu9whLizEGuVzoF3.	Organization4	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111113	org4_vp_documentation@dlsu.edu.ph	1	0	$2a$06$WhPTJ7tSmUayeCxxDSEFVeriLXGMqEVZfqwx1bCa8iyzWX7mMjcDy	$2a$06$WhPTJ7tSmUayeCxxDSEFVe	Organization4	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111114	org4_avp_documentation@dlsu.edu.ph	1	0	$2a$06$2zGNs8kWktiJjX0J6sT4Ku/MvaZlWPnhExC2whfat/2XyFfg92YxS	$2a$06$2zGNs8kWktiJjX0J6sT4Ku	Organization4	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111115	org4_vp_finance@dlsu.edu.ph	1	0	$2a$06$nqZ/TojOui0Btfhc7FYjieyApX0337mYDliNbtZw8QdWQKLs0gAE2	$2a$06$nqZ/TojOui0Btfhc7FYjie	Organization4	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
4111116	org4_avp_finance@dlsu.edu.ph	1	0	$2a$06$i9NVj0SFyNKd.0ed69gHCu46jShcgnYCD2SyablxvdlZXqEEC9IS6	$2a$06$i9NVj0SFyNKd.0ed69gHCu	Organization4	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111111	org5_president@dlsu.edu.ph	1	0	$2a$06$AnVVaYBiJ.QLB/0E9pKMjuiGR2MZxSHI1pmSnOtDaNgSSWKPues1W	$2a$06$AnVVaYBiJ.QLB/0E9pKMju	Organization5	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111112	org5_vp_internal@dlsu.edu.ph	1	0	$2a$06$AZwbB9hzPijMAc6aLduNN.ECDLAZTWg.ouIuZgWntLDfkGMUFRVbi	$2a$06$AZwbB9hzPijMAc6aLduNN.	Organization5	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111113	org5_vp_documentation@dlsu.edu.ph	1	0	$2a$06$kVh0LTQBu8S3eCZbANWGIOzBp6Ek3GsSC8WR5KKnNF6ElxanSMety	$2a$06$kVh0LTQBu8S3eCZbANWGIO	Organization5	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111114	org5_avp_documentation@dlsu.edu.ph	1	0	$2a$06$PwF4rh6F4iRLhQZiO9/OKu.9PdKT3XIDwDWRBbwlrUQyMqjNAldpC	$2a$06$PwF4rh6F4iRLhQZiO9/OKu	Organization5	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111115	org5_vp_finance@dlsu.edu.ph	1	0	$2a$06$IA4.HCjrtc39hPS9EqQr/.VBsD03Js1yjF99S07.X0HbdOcf5ELfW	$2a$06$IA4.HCjrtc39hPS9EqQr/.	Organization5	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
5111116	org5_avp_finance@dlsu.edu.ph	1	0	$2a$06$E6FE5LBY0tM5/z46iFU.Pe1llOP7GLIlYizLwSLMQXPZHcmWa5FcC	$2a$06$E6FE5LBY0tM5/z46iFU.Pe	Organization5	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111111	org6_president@dlsu.edu.ph	1	0	$2a$06$J6ciZxaCQArNa99pyvz93.KV/syiBo1yv7Sr4tTN7Ol77j0n94RFK	$2a$06$J6ciZxaCQArNa99pyvz93.	Organization6	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111112	org6_vp_internal@dlsu.edu.ph	1	0	$2a$06$CGAUdHs5V6rzv6FFdlFePOU/KhxwT9dvDeLPrFblvsWrwO0uCH012	$2a$06$CGAUdHs5V6rzv6FFdlFePO	Organization6	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111113	org6_vp_documentation@dlsu.edu.ph	1	0	$2a$06$Wm9zwZk/98ZqVYfY3jwZC.IFVxLAPHncXxEyel/xsRTt2.zYN.FJC	$2a$06$Wm9zwZk/98ZqVYfY3jwZC.	Organization6	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111114	org6_avp_documentation@dlsu.edu.ph	1	0	$2a$06$g.XDXzcIOwjiz.PdCe/IUeyEnGZJnkqfZ1tzvowLsXo7mBZDBqzDG	$2a$06$g.XDXzcIOwjiz.PdCe/IUe	Organization6	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111115	org6_vp_finance@dlsu.edu.ph	1	0	$2a$06$deIPzNX8Sx9b6kWkoX/xJOFpkbrDonWzCTKXZgxnXJKEHFHNxxMiW	$2a$06$deIPzNX8Sx9b6kWkoX/xJO	Organization6	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
6111116	org6_avp_finance@dlsu.edu.ph	1	0	$2a$06$OO379I7GgfuK4nJqke4Kl.FbDkEbPdmLkY4PcctU/ZzI7lAPcgroa	$2a$06$OO379I7GgfuK4nJqke4Kl.	Organization6	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111111	org7_president@dlsu.edu.ph	1	0	$2a$06$0PCubnFriZz/2yoF4obv4eFp2wuFpoCnYF4nazfLr6ME6S6pJn8s2	$2a$06$0PCubnFriZz/2yoF4obv4e	Organization7	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111112	org7_vp_internal@dlsu.edu.ph	1	0	$2a$06$XqHYL9yvHGWdw8k0FoztIebNHYfAw4IKGsWabDHKXR3qWJFjaLvou	$2a$06$XqHYL9yvHGWdw8k0FoztIe	Organization7	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111113	org7_vp_documentation@dlsu.edu.ph	1	0	$2a$06$0xlaRFuPViywNJlVyeMsoukk8w9sdWF7p1gPM3V1VpjkUb/0u/IO2	$2a$06$0xlaRFuPViywNJlVyeMsou	Organization7	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111114	org7_avp_documentation@dlsu.edu.ph	1	0	$2a$06$7EQbuIf1DQgv/obMpRSSqO0o8SBpoNbhVstH5dqr79gjBWJstJiZS	$2a$06$7EQbuIf1DQgv/obMpRSSqO	Organization7	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111115	org7_vp_finance@dlsu.edu.ph	1	0	$2a$06$HgbbJsYszCzulpKw.nimA.W.CmumDUlSs8GPzySAKiUFRcdxmYKb.	$2a$06$HgbbJsYszCzulpKw.nimA.	Organization7	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
7111116	org7_avp_finance@dlsu.edu.ph	1	0	$2a$06$ihOcX7.c0FOpNruDg.KDM.TxYmsQecuXuvy7PL8ulO98mbk60h04e	$2a$06$ihOcX7.c0FOpNruDg.KDM.	Organization7	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111111	org8_president@dlsu.edu.ph	1	0	$2a$06$LnWPehzaUL9lncq6PzcNoeFfwa0N9cslLwiQSt1Qo5rQhH3Gc25O6	$2a$06$LnWPehzaUL9lncq6PzcNoe	Organization8	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111112	org8_vp_internal@dlsu.edu.ph	1	0	$2a$06$OB9nAyMb4cOxWMkEQCodYOHRzzLEtzBmuuUtoJZzB3bPdFl6Ob2Q.	$2a$06$OB9nAyMb4cOxWMkEQCodYO	Organization8	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111113	org8_vp_documentation@dlsu.edu.ph	1	0	$2a$06$rK0Cs2AqJdkzBrxdg0.cjORdkY3PomVNEPrU92B7XNEVtXk6JCd8e	$2a$06$rK0Cs2AqJdkzBrxdg0.cjO	Organization8	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111114	org8_avp_documentation@dlsu.edu.ph	1	0	$2a$06$Z.wCV/6AQXefYNIQwnvocu1.FLNBsXagT9OfgPAgui2TcznC8puWi	$2a$06$Z.wCV/6AQXefYNIQwnvocu	Organization8	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111115	org8_vp_finance@dlsu.edu.ph	1	0	$2a$06$MpqaIrUPQPjWLTFaM.gkMee11H4brfRLyVd10cPqzsdQYdG4ka2PW	$2a$06$MpqaIrUPQPjWLTFaM.gkMe	Organization8	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
8111116	org8_avp_finance@dlsu.edu.ph	1	0	$2a$06$zhlqe2mgksyMVaKMamGvvuA3PDl616O1/JVBxdsmSYb7T50ewEoqu	$2a$06$zhlqe2mgksyMVaKMamGvvu	Organization8	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111111	org9_president@dlsu.edu.ph	1	0	$2a$06$DL4O3wuD7/mpebGiQoHLzuYDKnDN4o08Esczpcj1w8VeCrSAfGe3y	$2a$06$DL4O3wuD7/mpebGiQoHLzu	Organization9	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111112	org9_vp_internal@dlsu.edu.ph	1	0	$2a$06$zagadCKmllOdeZlMZqQJzutYSvgm5M.s9GZpk4wfqOf2h89UD7VG.	$2a$06$zagadCKmllOdeZlMZqQJzu	Organization9	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111113	org9_vp_documentation@dlsu.edu.ph	1	0	$2a$06$zPOfTL9EVP1Eea94AYGD9ezwE/zGI4.2fjgdlwljksexH3vdqqc/2	$2a$06$zPOfTL9EVP1Eea94AYGD9e	Organization9	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111114	org9_avp_documentation@dlsu.edu.ph	1	0	$2a$06$2SNUjMW6wPyRJgJ307V9IeKJttuWOUkubQmQvcYaXZm6cDdGZopuy	$2a$06$2SNUjMW6wPyRJgJ307V9Ie	Organization9	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111115	org9_vp_finance@dlsu.edu.ph	1	0	$2a$06$784DXOBcQphVTDvCNw.uz.LVIkqwnb4dZLXtDMWjNxbqsFPRHZFpa	$2a$06$784DXOBcQphVTDvCNw.uz.	Organization9	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
9111116	org9_avp_finance@dlsu.edu.ph	1	0	$2a$06$uIMbTZS2ebkYEQTSo/VC9.rYFrAfyZ.DUyJO4MOiPU0iakiZwgzqq	$2a$06$uIMbTZS2ebkYEQTSo/VC9.	Organization9	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111111	org10_president@dlsu.edu.ph	1	0	$2a$06$aP58bppBFdQJrYMMNuWRzeBQsTy83yWzIKQfjEX3IVy8fM199iQZ6	$2a$06$aP58bppBFdQJrYMMNuWRze	Organization10	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111112	org10_vp_internal@dlsu.edu.ph	1	0	$2a$06$D0.j8rAsFnyor6NsAaCOV.MiFGZnkETHwoENsM9UN8aTpITdbOpqK	$2a$06$D0.j8rAsFnyor6NsAaCOV.	Organization10	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111113	org10_vp_documentation@dlsu.edu.ph	1	0	$2a$06$G.q7E44emhtyK05k3YArrOn6tZfZsV.ZKIBskL5GLqxjUKUtZEvnW	$2a$06$G.q7E44emhtyK05k3YArrO	Organization10	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111114	org10_avp_documentation@dlsu.edu.ph	1	0	$2a$06$SxOsKXl7Uamk/Q7Zh6.fiefB6duJAvJ/B3qZEZ291H4Xz9GIwnp1a	$2a$06$SxOsKXl7Uamk/Q7Zh6.fie	Organization10	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111115	org10_vp_finance@dlsu.edu.ph	1	0	$2a$06$IWtDWYFo7F7vT7cphf420uw80KDPmopzTPAMjUVpevFmjncUgdLLG	$2a$06$IWtDWYFo7F7vT7cphf420u	Organization10	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
10111116	org10_avp_finance@dlsu.edu.ph	1	0	$2a$06$/iOwjjvGJ3Y.o3p.OueMautlw8suAZ32X7UdAD2aE.gmZ54hfsI1K	$2a$06$/iOwjjvGJ3Y.o3p.OueMau	Organization10	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111111	org11_president@dlsu.edu.ph	1	0	$2a$06$ihzh2vFVnrwTZD65U92rFOeC7Mlpj1Ee7gioaCbqKJdkBhsw0a2z6	$2a$06$ihzh2vFVnrwTZD65U92rFO	Organization11	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111112	org11_vp_internal@dlsu.edu.ph	1	0	$2a$06$v5kp.mpt6P618bHiyVq2Y.pYJJGc5A4MU3ZGvszWprnLKJh8/O7bm	$2a$06$v5kp.mpt6P618bHiyVq2Y.	Organization11	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111113	org11_vp_documentation@dlsu.edu.ph	1	0	$2a$06$KaMzRtrU0C1lGfGMrUvM1e5lvi3mPaqcEk2b8ZCOU/r3BLXJm4Vhi	$2a$06$KaMzRtrU0C1lGfGMrUvM1e	Organization11	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111114	org11_avp_documentation@dlsu.edu.ph	1	0	$2a$06$yusfzrCNRjvO5utOUE43ruFJheyr1PRNQ7D5HJ4PwJ9HaIUFJDIVK	$2a$06$yusfzrCNRjvO5utOUE43ru	Organization11	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111115	org11_vp_finance@dlsu.edu.ph	1	0	$2a$06$6SYHCvxA5tQb4w83fatIjuXIQIzet1Cg0mAZBqN4eKpTom1giqpkS	$2a$06$6SYHCvxA5tQb4w83fatIju	Organization11	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
11111116	org11_avp_finance@dlsu.edu.ph	1	0	$2a$06$QwD17XAjk5g9FeWQogS3tuyrJoz1XcYi4tiR6KmCJ4OJYoDsGoRpS	$2a$06$QwD17XAjk5g9FeWQogS3tu	Organization11	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-04-10 17:15:55.191515+08	2018-04-10 17:16:49.494449+08	2018-07-10 17:15:55.191515+08
\.


--
-- Data for Name: accounttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.accounttype (id, name) FROM stdin;
0	Admin
1	Student Account
2	Faculty Adviser Account
3	Director of S-Life
4	Dean of Student Affairs
5	Vice President for Lasallian Mission
6	President
\.


--
-- Data for Name: activityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Data for Name: activitynature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activitynature (id, name) FROM stdin;
1	Academic
2	Special Interest
3	Departmental Initiative
4	Fundraising
5	Community Development
6	Organizational Development
7	Issue Advocacy
8	Lasallian Formation/Spiritual Growth
9	Outreach
\.


--
-- Data for Name: activitytype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.activitytype (id, name) FROM stdin;
0	Competition
1	Distribution
2	General Assembly
3	Seminar/Workshop
4	Publicity/Awareness Campaign
5	Meetings
6	Spiritual Activity
7	Recruitment/Audition
8	Recreation
9	Others
\.


--
-- Data for Name: amtactivityevaluation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.amtactivityevaluation (activity, venue, equipment, materials, registration, timeend, activityexecution, hosts, facilitators, presentation, activities, organizationstandingpresentation, timestart, actualstarttime, actualendtime, anp, person1ea, person1loa, person1iitskoa, person1iomwm, person2ea, person2loa, person2iitskoa, person2iomwm, comments1, comments2, comments3, suggestions1, suggestions2, suggestions3, evaluator, status, datereserved, dateevaluated) FROM stdin;
118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0	2018-01-10 22:34:14.743693+08	\N
\.


--
-- Data for Name: amtactivityevaluationstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.amtactivityevaluationstatus (id, name) FROM stdin;
0	Unassigned Evaluation
1	Pending Evaluation
3	Evaluated
\.


--
-- Data for Name: college; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.college (shortacronym, fullacronym, name) FROM stdin;
CED	BAGCED	Br. Andrew Gonzalez FSC College of Education
CCS	\N	College of Computer Studies
COL	\N	College of Law
CLA	\N	College of Liberal Arts
COS	\N	College of Science
COE	GCOE	Gokongwei College of Engineering
COB	RVRCOB	Ramon V. del Rosario College of Business
SOE	\N	School of Economics
\.


--
-- Data for Name: documentattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documentattachmentrequirement (id, name) FROM stdin;
0	Mechanics
1	Letter for use of Different Venues in Campus
2	Sample Design
3	Venue Reservation Ticket
4	Credentials of Speaker
5	Sample Publicity
6	Agenda
7	LSPO Form
8	Sample Application Form
9	Informal Quotation
10	Estimated List of Participants
11	Mechanics of Competition
\.


--
-- Data for Name: expensetype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.expensetype (id, name) FROM stdin;
0	Others
1	Food Expense
2	Accomodation Expense
3	Venue Expense
4	Transport Expense
5	Honorarium
6	Cash Prize
\.


--
-- Data for Name: functionality; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.functionality (id, name, category) FROM stdin;
211000	Submit GOSM	211
211001	Resubmit GOSM	211
104002	Evaluate GOSM	104
104003	Evaluate Project Proposal	104
108004	Evaluate Activity (AMT)	108
106005	View Publicity Material	106
109006	Submit Activity Research Form (ARF)	109
214007	Modify Organizational Structure	214
3008	Manage Organizations	3
211009	View Project Head Dashboard	211
211010	View APS Report	211
211011	Sign Project Proposal as Treasurer	211
211012	Sign Project Proposal as Documentations	211
104013	Sign Project Proposal CSO Phase - 1	104
104014	Sign Project Proposal CSO Phase - 2	104
211015	Force Sign Project Proposal	211
210016	Submit Publicity Material	210
106017	Evaluate Publicity Material	106
212018	Submit Financial Documents	212
212019	Sign Financial Document Phase	212
108020	Evaluate Post Project	108
212021	Evaluate Financial Documents	212
212022	Auto-approve Financial Documents	212
2023	Account Management	2
211024	Sign Project Proposal as President	211
211025	View/Submit Financial Documents as President AND president powers	211
211026	View/Submit Financial Documents as Treasurer	211
214027	Submit Officer Survey Form	214
104028	Submit Not in GOSM Activities	104
109029	View Activity Feedback	109
104030	Evaluate Project Proposal Reschedule	104
1031	Add Organization Member	1
109032	Submit Officer Survey Form	109
105033	Set Organization Fund	105
\.


--
-- Data for Name: functionalitycategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.functionalitycategory (id, name, domain) FROM stdin;
0	Website Configuration	0
1	Organization Structure Management	0
2	Account Management	0
3	Manage Organizations List	0
104	Activity Processing	1
105	Finance	1
106	Publicity and Productions	1
107	Activity Monitoring	1
108	Activity Documentation	1
109	Organizational Research	1
210	Publicity/Creatives/Productions	2
211	Activity Processing & Documentations	2
212	Submit Financial Documents	2
213	Cancel Financial Documents	2
214	Organization Management	2
\.


--
-- Data for Name: functionalitydomain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.functionalitydomain (id, name) FROM stdin;
0	Administrative
1	CSO
2	Organization
3	Faculty Adviser
4	SLIFE
5	Accouning
\.


--
-- Data for Name: gosm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gosm (id, termid, studentorganization, status, datecreated, datesubmitted, datestatusmodified, preparedby, statusevaluator, comments) FROM stdin;
1200004	201720182	12	1	2018-01-10 18:31:10.08905+08	\N	\N	5111111	\N	\N
3800006	201720182	38	2	2018-01-10 18:37:01.772962+08	2018-01-10 18:59:38.470763+08	\N	2111111	\N	\N
1800011	201720182	18	1	2018-01-10 19:34:53.954991+08	\N	\N	11111111	\N	\N
1600010	201720182	16	2	2018-01-10 19:19:34.298676+08	2018-01-10 19:44:22.354518+08	\N	9111111	\N	\N
100001	201720182	1	3	2018-04-10 17:18:07.585455+08	2018-01-10 18:35:50.186928+08	2018-01-10 19:47:24.738475+08	1111111	1011118	\N
1000009	201720182	10	3	2018-01-10 19:00:52.123588+08	2018-01-10 19:15:35.470756+08	2018-01-10 19:54:54.762675+08	3111111	1011118	\N
1100002	201720182	11	3	2018-04-10 17:36:45.258814+08	2018-01-10 18:30:36.785209+08	2018-01-10 20:56:04.208216+08	4111111	1011118	\N
1300005	201720182	13	3	2018-01-10 18:36:15.562252+08	2018-01-10 19:16:28.930191+08	2018-01-10 20:56:14.239941+08	6111111	1011118	\N
1400003	201720182	14	3	2018-01-10 17:52:46.136326+08	2018-01-10 18:36:12.778639+08	2018-01-10 20:56:23.574044+08	7111111	1011118	\N
1500007	201720182	15	3	2018-01-10 18:37:19.873165+08	2018-01-10 21:09:42.480468+08	2018-01-10 21:10:36.778267+08	8111111	1011117	Please put spritual activity
1700008	201720182	17	3	2018-01-10 18:58:16.626235+08	2018-01-10 19:32:39.780275+08	2018-04-10 21:13:51.79965+08	10111111	1011117	\N
\.


--
-- Data for Name: gosmactivity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gosmactivity (id, gosm, sequence, goals, objectives, strategies, description, measures, targetdatestart, targetdateend, activitynature, activitytype, activitytypeotherdescription, isrelatedtoorganizationnature, budget, comments, isingosm) FROM stdin;
1	100001	1	To create an avenue for students to interact with different IT companies	{"To promote the year long sponsors to the CCS community","To expose CCS students to different IT companies","To create an avenue for both student and company representative to create lasting relationship"}	MyCareer	IT Caravan that aims to expose the CCS students to different IT companies over the Metro.	At least 30 participants	2018-01-18	2018-01-18	1	3	\N	f	0.00	\N	t
2	100001	2	To have supplies within the student's nook for the benefit of the officers	{"To prevent, if not avoid,  having officers pay for supplies needed for the organization needs.","To have access to supplies within the organization’s office.","To provide convenience for officers when they plan and implement activities for needed supplies."}	Nook Supplies	This is for the officers of the organization to have sufficient supplies that they can freely use whenever they need something such as basic school supplies and the like. 	Participation of organization's officers	2018-01-26	2018-01-26	6	9	\N	f	3000.00	\N	t
3	1400003	1	To create a more dynamic and vibrant academic year for all through quality activities and programs.	{"To showcase the nature, mission-vision, activities and programs of the organization","To recruite new members from both STC and Taft campus as well as membership renewal for old members","To increase the organizational funds through membership fee "}	Annual Recruitment Week	The Annual Recruitment Week gives the opportunity for all students of DLSU-M and DLSU-STC to partipate in any organization of their interest and passion. This also gives venue for the organizations to highlight its nature, mission-vision and also the activities and programs in stored for the members and the community. This is also an avenue for the organization to increase membership and funds through membership fee.\n	Recruit 30 new members from Manila and 40 new members from STC	2018-01-11	2018-01-14	4	7	\N	f	500.00	\N	t
4	100001	3	To improve the results of the officers work by enhancing their skills needed in their respective committees.	{"To enhance the skills needed by the officers in their current committees.","To provide an avenue for officers to grow and develop camaraderie.","To inform officers about tips and guidelines on how to manage the committee whenever they face problems."}	Committee Trainings	Specific technical trainings that serves as an avenue for LSCS officers to learn new skills and knowledge from faculty advisers, SLIFE and speakers from outside DLSU	30 Participants	2018-01-29	2018-01-30	6	3	\N	f	0.00	\N	t
5	1400003	4	To create activities for the welfare of the students especially on areas such as environmental awareness and action, individual growth and community engagement. 	{"(1) To provide avenue for the member to know more of nature, mission-vision, activities, programs and other relevant matters concerning the organization;  ","To formally turn-over the office to the new set of officers and to recognize the old officers of the organization","To create friendship and interaction between the members of the organization"}	1st General Assembly and Turn-over Ceremony	This 1st general assembly of the members of the organization will provide avenue for the member to know more of nature, mission-vision, officers, activities, programs and other relevant matters concerning the organization. This would create friendship and interaction between the members of the organization.\n	Have at least 50 members to attend	2018-01-15	2018-01-16	6	2	\N	f	500.00	\N	t
6	100001	5	To educate the community on various computing knowledges therefore promoting and giving them the opportunity to develop and/or enhance their computer literacy	{"For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.","For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.","For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."}	Computer Literacy Program	A socio civic activity where students can make use of their computer knowledge and share it with other people	30 participants	2018-01-22	2018-01-23	5	4	\N	f	0.00	\N	t
7	1100002	1	To teach the basic concepts of Photoshop through lecture and hands-on training	{"To introduce the participants to basic Photoshop concepts","To teach participants new concepts of art","To encourage the participants to learn new art techniques"}	Photoshop Series 1: Basic	A hands-on workshop will be held to teach the basic concepts of editing images using Adobe Photoshop.	The target number of participants is 20	2018-01-26	2018-01-26	2	3	\N	t	200.00	\N	t
8	100001	7	To assist students with their INTRODB course	{"To teach participants concepts and skills supplementary to those learned in class","To further solidify concepts participants learned in their class","To help participants develop relevant skills that could supplement lessons learned in the classroom"}	Connecting Java to MySQL	This seminar will teach participants how to connect Java programs to MySQL databases	At least 15 participants	2018-02-02	2018-02-02	2	3	\N	t	325.00	\N	t
9	1400003	6	To create a more dynamic and vibrant academic year for all through quality activities and programs.	{"To establish camaraderie between members","To build one community of ECO"}	Let's ECO: An ECO Team Building	Together Forever, ECO Forever is a teambuilding activity which basically aims to create bonds with the member of the ECO \n	Have at least 80% attendance from the total number of members	2018-01-17	2018-01-17	6	3	\N	f	550.00	\N	t
10	100001	9	To teach new skills that could be applied to future projects	{"To help students develop their artistic skills with the use of Photoshop","To provide a wider discussion on the features and uses of Photoshop","To help participants develop relevant skills that could supplement lessons learned in the classroom"}	Basic Photoshop Workshop	This workshop will guide participants through basic usage of Adobe Photoshop 	At least 10 participants	2018-02-08	2018-02-08	2	3	\N	t	0.00	\N	t
11	1100002	8	To teach the intermediate concepts of Photoshop through lecture and hands-on training	{"To introduce the participants to intermediate Photoshop concepts","To teach participants intermediate concepts of art","To encourage the participants to learn intermediate art techniques"}	Photoshop Series 2: Intermediate	A workshop will be given to students in which the intermediate concepts of photo editing using Adobe Photoshop will be taught.\n	Target number of participants is 20	2018-02-02	2018-02-02	2	3	\N	t	200.00	\N	t
12	1400003	10	To further analyze the waste generated in the Science and Technology Complex and be able to create an action plan of reducing it	{"To be able to create a reducing waste program that is specific to the problem;","To analyze the wastes generated in STC"}	ECOntrol: Waste Analysis and Characterization Study	Waste Analysis and Characterization Study or WACS is an activity wherein students and some employee volunteers gather to segregate and formulate a report on the wastes generated. With that, specific programs on wastes reduction can be created\n	Have at least 50 student volunteers and 30 employee volunteers; a report on the wastes generated in STC	2018-01-18	2018-01-24	7	4	\N	f	1000.00	\N	t
13	100001	11	To teach new concepts that could be applied to future projects	{"To teach students skills that cannot be learned inside the classroom","To broaden the knowledge of the participants on the possibilities in mobile application development","To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"}	Mobile UI Seminar	This seminar will teach the participants how to apply UI Design specifically for mobile platforms in a way that it is not only improves aesthetic effects but also flexibility and usability.	At least 30 participants	2018-02-12	2018-02-12	2	3	\N	t	0.00	\N	t
14	1100002	12	To teach the advanced concepts of Photoshop through lecture and hands-on training	{"To introduce the participants to advanced Photoshop concepts"," To teach participants advanced concepts of art","To encourage the participants to learn advanced art techniques"}	Photoshop Series 3: Advanced	A workshop will be held to teach the advanced techniques of photo editing using Adobe Photoshop through hands-on activities.\n	Target number of participants is 20	2018-03-09	2018-03-09	2	3	\N	t	200.00	\N	t
17	100001	14	To exhibit the academic excellence of the students of the College of Computer Studies	{"To be able to challenge members to think critically whilst under pressure","To be able to promote competitive programming amongst the organization's members","To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"}	Last Programmer Standing	Programming competition with a twist	At least 30 participants	2018-02-13	2018-02-13	2	3	\N	t	1000.00	\N	t
18	1100002	15	To teach students how to express their creativity through the use of letters	{"To introduce students to calligraphy","To teach students basic calligraphy styles and techniques","To allow the students express their creativity"}	Calligraphy: Express Yourself	The organization aims to provide an experience that would remind the participants to be creative in the simplest ways with the simplest things.\n	Target number of participants is 30	2018-03-24	2018-03-24	2	3	\N	t	200.00	\N	t
20	100001	18	To teach a new server side scripting language for web development which can be used in future machine projects.	{"To help participants recall and retain their lessons involving PHP.","To provide guidance and assistance to the participants in web development.","To help the participants improve their programming skills for future uses."}	Pa Help Po (PHP) Workshop	This workshop aims to teach participants the ins and outs of PHP.	At least 30 participants	2018-02-14	2018-02-14	2	3	\N	t	0.00	\N	t
21	100001	21	To teach a new programming language that could be used in the future.	{"To teach participants concepts and skills supplementary to skills learned in their class","To expose the participants to a different programming language used in the corporate world.","To give participants an opportunity to apply concepts that they've learned in class"}	Stay Sharp: C#	This workshop will expose its participants into learning a new programming language.	At least 30 participants	2018-02-15	2018-02-15	2	3	\N	t	150.00	\N	t
22	1400003	20	To create activities for the welfare of the students especially on areas such as environmental awareness and action, individual growth and community engagement. 	{"To provide an avenue wherein student can do community outreach programs"," To immerse the ECO Community to other issue advocacies that they can expand on"}	ECO Gives Back: A Christmas Celebration with the Kids	This program is generally created in order to build the heart of members in touching hearts and transforming lives.\n	70% of the total number of members attended the event	2018-01-31	2018-01-31	9	3	\N	f	616.00	\N	t
91	1600010	90	Recruit new members of the organization.	{"To garner new members of our organization","To garner some funds for the organization thru the membership fees","To publicize the organization to the freshmen student body"}	Annual Recruitment Week	This is a week-long event, spearheaded by CSO, where the incumbent officers will recruit new members to expand the size of the organization.\n	At least 40 members will be recruited	2018-01-14	2018-01-14	6	7	\N	f	1484.00	\N	t
92	1700008	91	Promote a good relationship between Behavioral Sciences students and the Behavioral Sciences Department through the service that the activity would provide. This would also strengthen the relationship of BSS officers and members. 	{"To provide students with an alternative when one is in need of school supplies for a certain amount of time only.","To create a bond with the people in the  department through constant interactions with each other inside the department.          ","To help students in their academics by giving them the tools that they need for a particular activity or class. "}	BSS Storage System	The BSS Storage System will serve as a back up option when one is in need of a certain school supply for a class in the Behavioral Sciences. The storage system will also contain items that were bought in previous activities of the organization. A member can borrow an item but must be returned within the day. \n	To fill the storage space with office supplies. 	2018-03-22	2018-03-22	1	9	\N	t	5000.00	\N	t
23	1100002	19	To teach the fundamental principles of After Effects through lecture and hands-on activities	{"To introduce the participants to basic Adobe After Effects concepts","To teach participants new concepts of multimedia art","To encourage the participants to learn new multimedia art techniques"}	Adobe After Effects: Back to Basics	A seminar will be given to students in which basic concepts and hands-on activities on Adobe After Effects will be taught\n	Target number of participants is 20	2018-02-03	2018-02-03	2	3	\N	t	200.00	\N	t
24	1400003	23	To create activities for the welfare of the students especially on areas such as environmental awareness and action, individual growth and community engagement. 	{"To immerse members and volunteers to a community"," To be able to create a project that is specific to the needs of the community","To partner and interact with the chosen community"}	E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)	Phase 1 of Community Engagement is focused on immersing the group to the chosen community which in turn may help them directly analyze which projects are needed to be implemented. \n	70% of the total number of members attended the event	2018-02-05	2018-02-05	6	3	\N	f	870.00	\N	t
25	1400003	25	To create activities for the welfare of the students especially on areas such as environmental awareness and action, individual growth and community engagement. 	{"To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity","To identify areas on campus that serves as habitat for the bird","To instill awareness to the community on the importance of the ecosystem and the environment"}	All Forms of Life is Important: Bird Race	As a regular activity of the organization, an inventory of migratory and resident birds on campus would be conducted in partnership with Wild Bird Club of the Philippines. Members of the community outside of the organization would be invited to join the bird watching. This aims to have a clear inventory of birds and to identify areas on campus that serves as habitat for the birds. This also aims to train members how to be good bird guides for those who want to visit the campus which will be integrated during the team building of ECO.\n	Generate a comprehensive bird inventory and have at least 70% of the total number of members attend the event	2018-01-24	2018-01-25	1	3	\N	t	515.00	\N	t
26	1100002	24	To promote the organization and the Green Card Alliance through the distribution of the membership Cards	{"To gather sponsors ","To ensure that the deal proposed are beneficial to the members","Make the deal sustainable"}	Membership Card Distribution	Distribution of the membership cards to the members of the organization A.Y. 2016-2017. Through the Green Card Alliance, specific discounts and privileges will be given to the members through the membership\n	Expected number of participants is 100	2018-02-20	2018-02-20	6	1	\N	f	4500.00	\N	t
27	1400003	26	To create activities for the welfare of the students especially on areas such as environmental awareness and action, individual growth and community engagement. 	{"To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh","To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action","Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"}	#ECOTalks 1: I am a Lasallian, I am PRO Green"	A campaign entitled, A One Million Filipino Youth Voices on Climate Action Campaign #NowPh, aims to collect one million pledges in preparation to the Paris Climate Convention this December. The goal of this campaign is to stop the Earth from reaching an increase of 2 deg. Celcius in global mean temperature through simple activties shown in the 15 Ways to Low Emission Developement Strategies (15 Ways to LEDS). Through this seminar, the DLSU community would be aware of climate change and on how they can contribute to climate action.\n	At least 100 students and 50 employees attended the seminar	2018-02-15	2018-02-16	1	3	\N	t	500.00	\N	t
28	1400003	28	To strengthen partnerships with the GCOE STCG and the engineering students towards environmental welfare and concern 	{"To increase the awareness of engineering students on environmental issues","To create an avenue for students wherein they can gather ideas in creating innovative things which can help in aiding the environmental problems"," To create sustainable projects in the future projects of DLSU Engineering Students"}	#ECOTalks 2: "Engineers on Environment Protection and Sustainability" (In Partnership with GCOE STCG)	#ECOTalks 2 mainly focuses on the discussion on how engineering students can help in solving environmental issues\n	Have at least 50% engineering students attend the seminar	2018-01-22	2018-01-22	1	3	\N	t	450.00	\N	t
29	1100002	27	To inform the members of the updates regarding the organization as well as raise concerns about the organization. Also to give time for members to get to know each other more	{"To introduce the members to the organization's mission vision and purpose","To increase awareness on the concerns of the organization","To allow the members to know one another"}	MooMedia: 1st General Assembly	The General Assmebly will be a time to give updates on the organization, at the same time interact with the members as well.\n	Target number of participants is 30	2018-01-29	2018-01-29	6	2	\N	f	2500.00	\N	t
30	100001	22	To teach new concepts that could be applied to future projects	{"To teach participants supplementary concepts and skills for their class","To give participants an opportunity to express their ideas using Firebase.","To broaden the knowledge of the participants on the possibilities in mobile application development"}	Server Side API: Firebase	This seminar will teach participants how to use Firebase and the possibilities it allows developers on dwelling further in mobile application development.	At least 30 participants	2018-02-16	2018-02-16	2	3	\N	t	0.00	\N	t
31	100001	31	To be able to expose CCS students to different pop culture genre, Mecha, Gaming and Technology companies and organizations.	{"To broaden the knowledge of the participants on the pop culture genre, Mecha, Gaming and Technology","To expose the students to different pop culture genre, Mecha, Gaming and Technology companies and organizations","To exhibit the different projects created in the different research and degree programs of the College of Computer Studies"}	Denki Megatech Convention 2016	2 day convention that features pop culture genre, Mecha, Gaming and Technology	At least 20 participants	2018-02-18	2018-02-18	2	3	\N	t	0.00	\N	t
32	3800006	1	Help other students to better understand their lessons in order for them to pass their subjects either with flying colors or with their desired grade.	{"To be more efficient towards the need of the students."}	YES Tutorial Series	One-on-one tutorial sessions on selective floating subjects & BS-ENT subject will be available exclusively to YES members. (Objective: To allow our members to allocate more of their priority towards improving the org.)	Evaluation	2018-01-18	2018-01-18	1	3	\N	t	0.00	\N	t
33	3800006	33	Make the officers and faculty advisers feel the love as the rest of the members remember and greet them on their special day	{"To develop relationships among the members and the faculty advisers","To give appreciation to the members and faculty advisers as they are expected to put effort into the organization without any fee","To keep the members and faculty advisers motivated in contributing and continuing to get involved with the organization"}	YES Greetings!	This is a strategy that the organization aims to fulfill its goal of developing YES further by giving special importance to the birthdays of the officers and faculty advisers.	Reach of publicity materials	2018-01-19	2018-01-19	2	4	\N	f	0.00	\N	t
34	1500007	1	To foster unity	{"To advertise the organization to the 2016-2017 freshman."}	Frosh Welcoming (LPEP)	As an organization, it is a nice gesture for us to greet one another on their respective days, but some members might not keep track of it; thus, the officers shall initiate it by sending greetings in the members' FB group or the AMSTUD page itself.\n	Have 80 new Facebook likes and followers by the end of TERM 1 	2018-02-04	2018-02-04	1	0	\N	f	2700.00	\N	t
35	1300005	1	To introduce the members about the org, and make them interested of our activities	{"Introduce the members of the organization to the officers, faculty advisers and its fellow members"}	Org Dev't: 2nd Term General Assembly	A gathering among the organization members that happens every term. This is for the purpose of promoting camaraderie among the members, as well as to inform them on what the organization has planned for them each term.\n	Number of attendees is 50	2018-02-03	2018-02-03	6	2	\N	f	8550.00	\N	t
36	3800006	34	For the potential officers to know about the organization as a whole. It aims to teach the aspiring officers about the different departments and committees and their functions.	{"Through training modules, the officers will teach the Young Officers with lessons about the organization."}	Young Officers' Training Program	The Young Officers' Training Program will be held for the potential officers for the next school year. This program will teach them about the organization and how it operates.	Number of participants/Evaluation	2018-01-23	2018-01-23	1	7	\N	t	1000.00	\N	t
37	1300005	36	Develop specialised tracks for activities targetting the skill levels of members	{"Discuss to the members the basics of creating an appropriate and cohesive setting in relation to their desired plot"}	World Building	Seminar that features the basic elements on how to build one's old world for their own stories\n	Number of attendees 30	2018-02-09	2018-02-09	2	3	\N	t	500.00	\N	t
38	1500007	35	To foster unity and harmonious work between the organization, CSO-STC, and other STC orgs	{"To establish a booth during the Archella event"}	Archela	The organization will recruit members and introduce them to the various activities ESA has to offer. These activities will help students, especially those majoring in ISE, maximize their stay in DLSU and learn more about their chosen field of study. \n	To have 100 attendees in the Archella event	2018-02-11	2018-02-14	2	4	\N	t	0.00	\N	t
39	1300005	38	Before finals week, the members should know of, and have interacted with, other members.	{"To be able to express themselves by enabling them to tell horror stories"}	Are You Afraid of the Dark?	A gathering with the org members that will enable them to express themselves by telling horror stories\n	Number of attendees 40	2018-03-26	2018-03-26	2	8	\N	t	500.00	\N	t
40	3800006	37	Increase the publicity of the Alliance of Professional Organizations of Business and Economics (PROBE) and the awareness of the Lasallian community about it.	{"To publicize that business and economics professional organizations have a uniform goal towards a better Lasallian community both academically and non-academically","To utilize online marketing in publicizing PROBE.","To raise awareness of what PROBE is."}	PROBE Launching	This is the online launching of the partnership between business and economics professional organizations.	The number of shares of the publicity materials	2018-01-25	2018-01-25	5	4	\N	f	0.00	\N	t
41	1500007	39	To instill new skills	{"To recruit junior officers for the A.Y. 2016-2017"}	My Little Kouhai: Training Program	Weekly online remembers for upcoming deadlines and quizzes so that IE students are well-prepared.\n	Be able to recruit a total of 20 – 30 new kouhai trainees during the first term	2018-02-15	2018-02-17	2	3	\N	t	1200.00	\N	t
42	1500007	42	To promote discipline	{"To establish a booth in the Taft and STC campus promoting a regulation stipulated in the handbook"}	Discipline Awareness Week	Ley La Salle will establish a booth and promote the organization to all students of DLSU\n	Ley La Salle will establish a booth and promote the organization to all students of DLSU	2018-02-18	2018-02-20	2	4	\N	t	1200.00	\N	t
43	1300005	40	Every participant should have created literary pieces which, if they wanted to, they can submit to Scribbles	{"To have participants produce literary pieces"}	ENGWREX	An activity wherein participants will be provided prompts to guide them in writing with the English language throughout the session.\n	Number of attendees is 25	2018-02-12	2018-02-19	2	3	\N	t	500.00	\N	t
44	1500007	43	To show appreciation to Faculty Adviser and comply to CSO	{"To tie-up with other ASPIRE organization and CSO to create a freedom wall and booth where students can request ‘Thank you’ notes, gifts or services to a profressor they cited. "}	Teacher’s Month Initiative	A "crash course" on the  subject in preparation for quizzes.\n	N/A	2018-02-21	2018-02-24	2	4	\N	t	2200.00	\N	t
45	1300005	44	Expose members to an award-winning author and new literary works.	{"To introduce the participants to certain kinds of literature"}	Book Club: Mario Vargas Llosa	An event where the participants, guided by a facilitator or a guest speaker, will talk and create a discussion about a certain literary work.\n	Number of attendees is 40	2018-02-23	2018-02-23	2	3	\N	t	500.00	\N	t
46	3800006	41	Recruit 250 members	{"Each officer must recruit at least 5 members each."}	Annual Recruitment Week	The Annual Recruitment Week will be for the recruitment of members.	Attendance	2018-02-06	2018-02-06	5	4	\N	f	1200.00	\N	t
47	1500007	45	To inncrease member	{"To orient the members of the committee of the background of the Visual Novel Project,  dates of workshops and activities and the members’ role in the Visual Novel Making"," To orient and familiarize the members of the Adobe Flash, Paint Tool Sai and Photoshop programs for the programming of the visual novel and drawing of the scenes and images.","Produce a Visual Novel."}	NOBIRU  GEMU: Visual Novel	1. To get to know the beneficiary that ENGLICOM will support for the whole year. 2. To assess the needs of the beneficiary. 3. To introduce the organization to the beneficiary.\n	To recruit 20 members to be part of VN cencomm	2018-02-25	2018-02-28	5	7	\N	f	2500.00	\N	t
105	1800011	104	To facilitate discourse within the university regarding Marcos' burial in LNMB	{"To create an avenue for unobstructed discourse and to inspire creative and critical thinking"}	FERDIN4ND M4RCOS	Tara sa Marcos Highway is a one-day event that will zoom in on the Marcos Burial\n	Cultura will be in charge of publicity and the film showing	2018-02-23	2018-02-23	1	3	\N	t	0.00	\N	t
48	1300005	46	Develop specialised tracks for activities targetting the skill levels of members	{"to define and explain Ghazal and Tanaga poetry to members and attendees"}	Poetry: Ghazal and Tanaga	A seminar where a speaker will introduce different forms of poetry, specifically Ghazal and Tanaga, in order for the participants to widen their knowlege when it comes to these forms and how to effectively write poems in this form and to also discuss the historical and cultural importance of both the Ghazal and the Tanaga.\n	Number of participants is 60	2018-03-16	2018-03-16	2	3	\N	t	500.00	\N	t
49	3800006	47	To recruit committed members to become future leaders of YES.	{"Recruit at least 50 Young Officers."}	Young Officers' Recruitment	Recruitment for the future officers of YES.	Number of participants/Evaluation	2018-02-07	2018-02-07	6	9	\N	f	0.00	\N	t
50	1300005	49	Develop specialised tracks for activities targetting the skill levels of members	{"To help the participants to learn more about their characters."}	Character Creation	A seminar where the speaker will talk about creating a diverse and unique yet realistic character for the upkeep of the attendees.\n	Number of participants is 35	2018-03-23	2018-03-23	2	3	\N	t	500.00	\N	t
51	3800006	50	To present innovative business ideas in order to promote creativity amongst the generation of young entrepreneurs in our society today.	{"Meet some of the most successful entrepreneurs and startup founders from different industries"}	Start Up Summit	Startup Summit is a one-day startup conference for founders, entrepreneurs, startups, and investors. This conference focuses on selecting the best startups in the Philippines by organizing national startup competition.	Number of participants	2018-02-08	2018-02-08	1	3	\N	t	0.00	\N	t
52	1500007	48	To encourage artists.	{"To orient the members of the committee of the  dates of workshops and activities and the members’ role in the Publications committee"}	BENTO MAGAZINE: Publications Committee	Release of Publications \nOnline Publication -- CSO\n	To recruit 20 members to be part of VN cencomm	2018-03-01	2018-03-03	2	4	\N	t	2500.00	\N	t
53	3800006	52	To showcase the innovative products of each company.	{"Help the Entrepreneur students taking up PRCENT2 in organizing an event that will promote the products","Create an opportunity for the Entrepreneurship students to earn more."}	Entrepreneurship Bazaar	Different Entrepreneur companies showcase their products along SJ Walk	Evaluation	2018-02-12	2018-02-12	3	8	\N	f	0.00	\N	t
54	1500007	53	To familiarize with the new members of the organization.	{"To list down willing members of the organization to be part of internal groups in the organization like the Visual Novel Committee, the Publications Committee, the One Shot Manga Committee and the Youtube Channel Committee"}	1st General Assembly	General Assembly – CSO\n	To have 50% of the organization members attend the General Assembly	2018-03-04	2018-03-05	6	2	\N	f	800.00	\N	t
55	3800006	54	Familiarization of the documents to be processed required to host an event. The experience will be used for the second term.	{"Have members simulate the processing of the required documents to host an event."}	Finance and Documentations Workshop	Discussion of Pre-Acts and Post-Acts simulation to be done the week after this module. A workshop for the members will be conducted by the Operations Department to further explain how these documents work.	Evaluation	2018-01-18	2018-01-18	3	8	\N	f	123.00	\N	t
56	1300005	51	The EB must have properly trained and transitioned a set of competent and responsible individuals to succeed them as leaders and carry on the legacy of Writers' Guild.	{"to orient the Scribes about the different departments in the organization","to orient the SEBo about each subdepartment within the Publication department","to announce the committees in which each junior officer and editor will belong to"}	SEBo and Scribe Orientation	As spoken word poetry beings to gain people's interest, the activitity intends to bring a Spoken Word session that is open to members, the university, and beyond. Tickets will be sold solely to cover the event's exepnses and not to raise funds for the organization.\n	Number of participants is 40	2018-02-12	2018-02-12	6	3	\N	f	1000.00	\N	t
57	1300005	57	Develop specialised tracks for activities targetting the skill levels of members	{"To form a potentially lasting external relationship with an established arts organization.","To extend the organization’s vision-mission university wide","To develop the participants’ skills in songwriting"}	Songwriting Seminar	A songwriting seminar with distinguished guests that aims to teach and impart knowledge among the participants the basics and foundations of songwriting\n	number of attendees is 40	2018-03-21	2018-03-21	2	3	\N	t	250.00	\N	t
58	3800006	56	To be able to properly write a terminal year end report for the businesses of the different companies.	{"To have the students attend the seminar in order for them to learn how to write a terminal year end report."}	How to Write a Terminal Year End Report	This seminar will teach the different companies how they will write a terminal year end report.	Evaluation	2018-01-24	2018-01-24	1	3	\N	t	1000.00	\N	t
59	1300005	58	Develop specialized tracks for activities targeting the skill levels of members	{"To set up an avenue where the participants can cultivate ideas","To help the members further their knowledge on visual art as well.","To develop the layouting skills of the attendees."}	Art and Layout Seminar	A seminar where the speaker will talk about how impoartant layouting and visual art could enhance literature.\n	number of attendees is 30	2018-03-14	2018-03-14	2	3	\N	t	500.00	\N	t
60	1300005	60	Develop specialised tracks for activities targetting the skill levels of members	{"to explain what constitutes bad dialogue, and ways to avoid such","to give attendees an appreciation for dialogue by highlighting its impact on literary works","to discuss the elements that define good dialogue"}	Dialogue Seminar	Dialogue is a cruicial part of most literary works, and this activity aims to discuss what constitutes proper dialogue.\n	number of attendees is 25	2018-03-05	2018-03-05	2	3	\N	t	500.00	\N	t
61	1000009	1	Orient those who signed up for AIESEC on what to expect from the org. 	{"Give an overview on the different departments and its functions and operations.","Introduce the AIESEC culture"}	Local Committee Orientation Seminar	The Local Committee Orientation Seminar is a general assembly for all hopefuls to get a clearer view on what to expect from AIESEC and what AIESEC really is. 	# of attendees, # of MSI Interviews	2018-01-26	2018-01-26	2	2	\N	t	1920.00	\N	t
62	1000009	62	Enable the trainees to be more skillful and knowledgeable in implementing training programs, as well as creating training programs. 	{"Enhance talent management competency of the member."}	Talent Management	 It is a unified program that will be carried out to the Talent Management department. 	# of attendees, % increase in Talent Management efficiency	2018-02-07	2018-02-07	6	3	\N	f	0.00	\N	t
63	1300005	61	Develop specialised tracks for activities targetting the skill levels of members	{"to introduce different types of writing form and structure to participants","to give attendees the opportunity to write their own flash fiction works","to define flash fiction by contrasting it from other types of writing"}	Flash Fiction	This activity aims to discuss flash fiction writing, which is a form of prose that is significantly shorter than the common literaty work.\n	number of attendees is 35	2018-03-09	2018-03-09	2	3	\N	t	500.00	\N	t
64	1000009	63	To ensure that no departments would underperform due to the inefficiency in operations. 	{"Train members in their respective department's operations."}	Operations Summit 	Training carried out by vice presidents and team leaders for their respective departments.	# of attendees, # of Operations Summit conducted, % productivity rate of AIESEC in DLSU	2018-02-08	2018-02-08	6	3	\N	f	0.00	\N	t
65	1700008	1	Promote academic excellence in the fields of the Behavioral Sciences, to facilitate the development of our members	{"To orient students about the basics of Corporate Social Responsibilty"," To show the importance of CSR in organizations","To enlighten students with the pros and cons of working in CSR"}	Corporate Social Responsibility 	The activity aims to give students a background of Corporate Social Responsibility and it's importance in organizations	At lesast 20 students shall attend the talk	2018-02-14	2018-02-14	1	3	\N	t	3000.00	\N	t
66	1300005	64	Develop specialised tracks for activities targetting the skill levels of members	{"To spark healthy relationships, both friendly and professional, between the attendees.","To give chance for the members to share their works with each other.","To provide an oppotunity to the participants to socialize."}	Collaborative Writing	An activity where the participants are expected to bring their own works, share them to everyone, and perhaps collaborate on a new project, create mash-ups of past works or comment on and improve the works of their peers.\n	number of attendees is 40	2018-03-02	2018-03-02	2	3	\N	t	500.00	\N	t
67	1000009	65	Give an avenue for the DLSU community to sign up and go for exchange.	{"Introduce Global Volunteer Program to DLSU community"}	OGX-Po	Recruitment booth for the outgoing exchange program of AIESEC in DLSU. 	# of sign ups, # of exchange participants	2018-02-12	2018-02-12	2	7	\N	t	0.00	\N	t
68	1000009	68	Update members on the current situation of AIESEC in DLSU.	{".To refresh the minds of the members and other participants about the current standing of the organization. "}	October - Local Committee Meeting	Local Committee Meetings are meetings AIESEC in DLSU conducts every month with different agendas every month to gather all members.  	# of attendees, # of departments present	2018-02-14	2018-02-14	6	7	\N	f	330.00	\N	t
69	1000009	69	Enhance sales comptencies of sale-centric departments.	{".Enhance sales competency of the member "}	Sales Development Programme 2.0	Sales Program by the Business and Development department to be carried out to sales-centric departments.	# of attendees, # of departments involved in this program, # of deals closed, # of meetings set	2018-02-12	2018-02-13	6	3	\N	f	0.00	\N	t
70	1700008	66	Develop academic execellence by equipping members of the Behavioral Sciences Society and students from the course with the tools in order for them to better understand	{"To supplement the topics that are being tackled in Social Psychology class. ","To categorize each topic in order for the students to better understand the topic","To create another way of learning which may help students who find it difficult to keep up during class"}	SOCPSYC Reviewer	The activity aims to provide students with a summary of the topics that they have discussed in class which can help them understand the topics easily and may even perform better. \n	Every member taking this course must be given a copy of the reviewer. 	2018-02-21	2018-02-21	1	1	\N	t	2000.00	\N	t
71	1300005	67	To welcome new and returning members into the organization by providing them their membership cards.	{"To provide substantial proof of a student's membership","To give the members access to certain benefits provided by the CSO Green Card Alliance","To be able to distribute the Membership Cards within the members"}	Membership Card Distribution	The Membership Card will act as a substantial proof of a student's status as a bona fide member of the organization. The aforementioned card also allows its owner to enjoy certain benefits provided by the CSO Green Card Alliance.\n	Number of members is 150	2018-01-29	2018-02-02	6	1	\N	f	0.00	\N	t
72	1000009	70	Build newie knowledge on basic AIESEC operations, culture and foundation. Reintegrte oldies. 	{" Introduce the different department operations to newies","reintegrate oldies ","Conduct a simulation for newies"}	Activation Camp 	In depth orientation for new members. Reintegration for oldies. Operations, processes, simulation.	# of new participants, # of old participants	2018-02-15	2018-02-15	2	3	\N	t	320.00	\N	t
73	1700008	71	Develop academic execellence by equipping members of the Behavioral Sciences Society and students from the course with the tools in order for them to understand 	{"To supplement the topics that are being taught during Social Research class.    ","To give students the right tools for them to be a better researcher","To remind students the important elements when it comes to research writing"}	SOCRES2 Reviewer	The activity aims to provide students with a summary of the topics that they have discussed in class which can help them understand the topics easily and may even perform better. \n	Every member taking this course must be given a copy of the reviewer. 	2018-02-22	2018-02-22	1	1	\N	t	50.00	\N	t
74	1300005	72	Develop specialised tracks for activities targetting the skill levels of members	{"To enable the participants to have a new perspective on a specific topic in writing.","To introduce new techniques and strategies for the members to improve upon.","To help the members overcome the hindrances and the difficulties they face in their writing."}	Kill Your Darlings	A character's death is a pivotal point in any literary work and it must be planned properly. This activity aims to give participants the tools and techniques to effectively kill a character in the story.\n	number of participants is 40	2018-02-10	2018-02-10	2	3	\N	t	1000.00	\N	t
75	1000009	73	For newies to determine which department they would like to join and work in. For vps to determine which members are fit for the dept or not.	{"Make newies determine which department they would like to join","make newies undergo department operations for a day"}	Intership Phase	Last step for newies before becoming full pledged AIESECers.	# of newies	2018-02-16	2018-02-16	2	3	\N	t	1230.00	\N	t
76	1500007	55	To increase member participation and foster unity	{"To create a program that will teach participants the different constellations","To view the Leopold meteor shower"}	Stargazing	On-Campus, Overnight Activity – SLIFE \n	To have an ENP of 20-30 people 	2018-03-06	2018-03-07	5	8	\N	f	3000.00	\N	t
77	1300005	75	Develop specialised tracks for activities targetting the skill levels of members	{"To enable the participants delve into various forms of creative writing, in this case, scriptwriting","To provide an avenue for the participants to produce an output of scriptwriting","To introduce the participants the foundations of scriptwriting"}	Scriptwriting Seminar	A specialized seminar that caters to aspiring writers who wants to delve and learn the basics and foundations of scriptwriting.\n	Number of attendees is 35	2018-02-23	2018-02-23	2	3	\N	t	1000.00	\N	t
78	1500007	77	To instill skills and enhance of members 	{"To teach participants the properties of printer ink and the method on how to create different colors using them.","To teach participants the basics of manga drawing and coloring using the mixed ink. "}	Ink Mixing + Manga Drawing Workshop 	Seminar/Workshop – CSO\n	To have an ENP of 20 people	2018-03-08	2018-03-08	2	3	\N	t	1100.00	\N	t
79	1000009	76	Not just raise awareness about the Sustainable Development Goals to the Lasallian community but give them opportunities to actualize these goals. 	{"Raise awarness towards the Sustainable Development Goals","Provide activities to actualize the different SDGs"}	Global Goals Weeks	Weeklong campaign for the Sustainable Development Goals	# of internal partnerships, # of activities carried out, # of participants	2018-02-19	2018-02-19	7	4	\N	f	0.00	\N	t
80	1700008	74	Develop academic execellence by equipping members of the Behavioral Sciences Society and students from the course with the tools in order for them to learn	{"To prepare the students in different activities and reports that they may have during class. ","To provide the students a simple and easy to remember guide on the different perspectives of Behavioral Sciences","To supplement the topics that are being tackled in History of Social Thought 2. "}	HISTSO2 Reviewer	The Behavioral Science Library will serve as an online library for the different academic readings and and thesis papers done by Behavioral Science students\n	To have an online library set up	2018-02-28	2018-02-28	1	1	\N	t	1000.00	\N	t
81	1000009	80	Create talent pipeline for future EwAs and AIESEC in DLSU events	{"Show the realities of being an OC","Train aspiring OC"}	Organizing Committee Track	Organizing Committees are the backbones of any AIESEC event. To ensure that all our events go smoothly and are of execellent quality, we have created this OC track wherein we can train and mold new talent for future organizing committees. 	# of speakers, # of attendees	2018-02-21	2018-02-21	2	3	\N	t	1200.00	\N	t
82	1300005	78	To improve the creativity and imagination of the participants with the help of speculative fiction	{"To spark the interest of participants on speculative fiction","To teach the participants the basics of writing speculative fiction","To introduce the participants to speculative fiction"}	SPECFIC	A seminar/workshop that tackles what speculative fiction is and how the participants can write one\n	Number of participants is 40	2018-02-09	2018-02-09	2	3	\N	t	1000.00	\N	t
83	1700008	81	Promote camaraderie and teamwork among the organizations.	{"To create ties between external establishments and the Council of Student Organizations","To give value to the members who participated in the Annual Recruitment Week","To encourage teamwork and promote a spirit of unity amongst the organizations"}	Green Card Alliance	An annual project that ties CSO with partner establishments that can provide discounts and/or special privileges to all the Members of both the Student Organizations and Alumni Association\n	Solicit at least 3 establishments	2018-03-02	2018-03-02	6	2	\N	f	2000.00	\N	t
84	1500007	79	To increase member participation and publicize major events	{"To create a program for an anime marathon viewing, group game play and/or card and board game sessions"}	2nd General Assembly	help students improve on their academic standing\n	To have an ENP of 20 in each activity	2018-03-09	2018-03-09	2	3	\N	t	600.00	\N	t
85	1700008	84	Orient the new officers about their responsibilities and task so that the organization will function smoothly.	{"To be able to train the next set of officers of the Behavioral Sciences Society.   ","To encourage teamwork and promote a spirit of unity among the officers of BSS. ","To encourage teamwork and promote a spirit of unity among the officers of BSS. "}	Officers Training Program	The Officers Training Program will be a place where the new officers can talk amongst each other and plan future activities together. \n	80% of officers in the organization must be able to attend the program. 	2018-03-07	2018-03-07	6	2	\N	f	2000.00	\N	t
86	1700008	86	Provide a succession program for the organization through training individuals who are interested in being officers of the organization	{"To recruit active members who are willing to help in the various activities by the organization","To enable active participation for the various students under the Behavioral Sciences Department","To provide manpower for the activities set for the term"}	AVP Applications	AVP Applications aim to recruit AVPs who are willing to actively participate in co-curricular and extra-curricular affairs\n	Fill up the needs of the organization through various positions	2018-03-14	2018-03-14	6	7	\N	f	1000.00	\N	t
88	1700008	87	Orient the new and old members about the upcoming activities and what to expect from the organization for the whole school year.	{"To formally introduce Behavioral Sciences Society and the officers to the members","To welcome the new members, especially the Froshies, to Behavioral Sciences Society","To promote interaction and foster positive relationships among the old and new members of the organization","To serve as an avenue for announcing and promoting the activities and projects of the organization for this academic year"}	General Assembly: Behavioral Sciences Convocation	The First General Assembly will introduce the organization and its officers for AY 2016-2017 to the new and old members. The activity will help promote upcoming BSS activities for the academic year. It will also be a time to introduce the faculty under the Behavioral Sciences Department. The activity will also recognize those students under Behavioral Sciences that have garnered academic awards. \n	At least 40 members should attend the assembly	2018-03-21	2018-03-21	6	2	\N	f	9000.00	\N	t
89	1600010	88	Introduce the new members about what the organization is about	{"To welcome the members to the organization"," To introduce the structure of the organization; to discuss the plans and projects of the organization to its members"}	General Assembly	The General Assembly is an event where all of the members of the organization is gathered in one place and given opporunity to mingle within themselves.\n	At least 20 members would attend	2018-01-16	2018-01-16	6	2	\N	f	1500.00	\N	t
90	1700008	89	Greet the incoming freshmen through the presence of different organizations of the university. 	{"To welcome incoming freshmen to the university","   To build raport among the new officers of the organization. ",""}	Frosh Welcoming 	The Frosh Welcoming activity serves as an avenue for organizations to make their presence known with the freshmen. \n	A booth shall be set-up during the specified time and date. 	2018-03-21	2018-03-23	6	9	\N	f	4000.00	\N	t
93	1600010	92	Have a night of fun and camaraderie among members, alumni, and faculty, drawing parallels on the actual thanksgiving in America	{"To immerse the members and participants to one of America's well-known tradition","To award the outstanding officers during the term"," To build camaraderie among members"}	Thanksgiving	An American tradition where families are reunited, our version of thanksgiving invites everyone to join us in our meals and games just like how it is done originally.\n	At least 40 guests would attend	2018-01-18	2018-01-18	2	2	\N	f	0.00	\N	t
94	1700008	93	Promote academic excellence in the fields of the Behavioral Science	{"To orient the Behavioral Sciences students of their upcoming majors classes.","To answer questions or concerns of students about the major subjects of the Behavioral Sciences degree.","To answer questions or concerns of students about the major subjects of the Behavioral Sciences degree."}	Majors Orientation	"Majors Orientation is a seminar targeted toward the incoming major students of the Behavioral Sciences program. The seminar will discuss preparation needed for taking major classes.\n	At least 20 people should attend the seminar.	2018-03-23	2018-03-23	1	3	\N	t	1000.00	\N	t
95	1600010	94	Train officers about the processes and protocols that involve the organization	{"To train the members about each committee","To discuss the various paperworks that the junior officers will have"," To introduce the applicants to the organization"}	Junior Officers Training 1&2	This training is more comprehensive than the first one, for it will involve some paperwork and strict collaboration among the applicants.\n	At least 15 officers would participate	2018-01-19	2018-01-19	6	3	\N	f	300.00	\N	t
96	1700008	95	The Political Science Society aims to educate the students on how they can understand and study the behavior of the Filipino people towards Duterte’s way of handling the Philippine political administration. 	{"To help the students critically understanding the behavior of the supporters of Duterte.","To prevent the students from forming hasty generalizations on both Duterte’s supporters and the happenings that are allegedly linked on Duterte’s “Shoot to Kill” order. "," To address the lack of  the knowledge of majority of the youth when it comes to political matters and preventing them from the “Bandwag on Nature” of most of the Filipinos "}	People’s Behavior on Duterte’s Administration 	People’s Behavior on Duterte’s Administration is a tie-up activity among three organizations (POLISCY, SMS, and BSS) that seeks to explore the purposes behind the way the Filipino people, most especially Duterte’s supporters, behave on his style of managing the country. \n	There should be at least an audience and officers from the organization to help facilitate and learn from the professors 	2018-03-26	2018-03-26	1	3	\N	t	1200.00	\N	t
97	1600010	96	Introduce the International Studies students about their degree and possible career in the future.	{"To showcase the International Studies Department programs","To discuss their program in the university","To provide information to students on their possible career track in the future; "}	International Studies Convocation	This will be the main event that will welcome the IS students and enthusiasts to the field. They'll also learn what are the possible careers in the degrees that they're in\n	At least 25 students would attend	2018-01-22	2018-01-22	1	3	\N	t	2000.00	\N	t
98	1600010	98	Allow the students to review about the topics in their INTGLOS class as well as have fun.	{"To provide a fun refresher session to students taking up INTGLOS","To provide a good working relationship within the 3 IS organizations","To build camaraderie among freshmen; "}	INTGLOS Amazing Race	A tie-up event where students taking up INTGLOS can participate to test their physical skills and knowledge of the subject\n	At least 20 freshmen would participate	2018-02-12	2018-02-12	1	0	\N	t	500.00	\N	t
99	1600010	99	Brief the participants on their upcoming majors of their program.	{"To allow the upcoming ISA majors about their major subjects for the succeeding terms","To answer the questions that the upcoming ISA majors will ask"}	American Studies Majors Orientation	Queries of the upcoming ISA majors will be answered in this activity; some professors in their majors will serve as speakers to answer the concerns of the students.\n	At least 15 students that will take their majors would attend	2018-02-26	2018-02-26	1	9	\N	t	0.00	\N	t
100	1600010	100	Inform the public about the US National Elections Results and importance.	{"To give updates about the US elections to the Lasallian community;","To discuss American politics and governance","To provide analysis on the elections and the possible effects to the country"}	US Election Watch 2016	As part of our advocacy, we're promoting the US elections in selected areas to answer the Lasallian Community's FAQs about American elections\n	At least 20 students shall participate in the culminating event	2018-03-06	2018-03-06	1	4	\N	t	1000.00	\N	t
101	1800011	1	Make the new and returning members of Cultura aware of the organization's events, committees, and members.	{"Convene the Cultura members and discuss org events, possible contributions to committees, and other matters that need to be discussed for the '17-'18 members"}	General Assembly 	A General Assembly of all members where the EBs and Officers welcome the new and old members and discuss organization matters and how they can contribute or participate.\n	We will host an assembly and discuss the events planned, committees to join, etc.	2018-01-27	2018-01-27	6	2	\N	f	2500.00	\N	t
102	1600010	101	Simulate the American elections to the student body.	{"To allow the students to participate in a US elections","To represent DLSU and NCR in the result counting of the mock election","To simulate the US elections; "}	US National Mock Elections	This is a week-long event, wherein students can vote their President (of the USA) in a specified voting area. This activity is spearheaded by the US Embassy and American Corners around the country.\n	At least 30 students shall cast their vote	2018-03-08	2018-03-08	1	9	\N	t	300.00	\N	t
103	1800011	102	Open discourse and dialogue regarding books and literature, trading ideas, observations, and insights	{"To breake the ice and provide an \\"informal\\" space for Cultura members to share their thoughts on certain books."}	Brown Bag Series: Book Club	Participants are expected to bring a book of their choice and present the said work and discuss as to why this isa good work. \n	This event is open to non-Cultura members. Participants will be encouraged to bring a book to be presented. After which, a discussion will follow regarding literary genres and styles.	2018-02-02	2018-02-02	1	3	\N	t	500.00	\N	t
104	1600010	103	Greet the people who have their birthdays on the said date.	{"To remind the members that one someone among them is celebrating their birthday; to appreciate the special day of one of our members; To allow the members to have a collective greeting to one of our members."}	Birthday Greetings	As an organization, it is a nice gesture for us to greet one another on their respective days, but some members might not keep track of it; thus, the officers shall initiate it by sending greetings in the members' FB group or the AMSTUD page itself.\n	At least 70% of members will be greeted on their birthday	2018-03-17	2018-03-17	1	9	\N	t	0.00	\N	t
106	1600010	105	Allow the students and the interested party to binge watch popular American television series	{"To feature a popular television series to the student body","To allow the students to participate and analyze the given television series","To provide an alternative entertainment to the student body every Thursday evenings; "}	AMSTUD and Chill: Binge watching	TV series has been embedded in American pop culture and society. And as a means to promote these beloved series, AMSTUD will feature a well-known American television series every term.\n	An average of 15 students should participate every term	2018-03-08	2018-03-08	1	8	\N	t	0.00	\N	t
107	1600010	107	Assist the students who are struggling in their subjects	{"To help the ISA majors with their subjects","To build camaraderie among members","To prepare the students for their upcoming finals"}	Peer Tutoring Sessions	A tutoring session during the vacant schedules of the officers and members where the struggling students will have the opportunity to grasp the topics that requires clarification for them.\n	At least 20 students will participate	2018-03-12	2018-03-12	1	9	\N	t	0.00	\N	t
108	1800011	106	Prepare the Literature Majors about to take the qualifying exam to major in literature.	{"Hold a discussion to refresh students on what they might need to know during the QLY."}	QLY-LIM Orientation	An optional review session for incoming Lit Majors about to take the QLY for them to have an idea of what to expect for the QLY.\n	We will hold a simple briefer on the QLY about the process (exam and interview), and then a short refresher course. 	2018-03-02	2018-03-02	1	3	\N	t	0.00	\N	t
109	1600010	108	Publicize the popular holidays in the US in relation with the Philippine holidays.	{"To remind the student body about the significant dates in the US, as part of globalization; ","To have a fast fact check on the various dates of the year","To compare the holidays of the Philippines and the US"}	AMSTUD Calendar	A calendar is necessary to keep track of the important dates that we should remember. In relation to that, the US has significant dates that some don't bother to remember, thus creating a calendar providing details of these events might encourage people to indulge in our activities.\n	A total of 1000 likes for all of the publicity that the organization will provide	2018-03-14	2018-03-14	1	4	\N	t	0.00	\N	t
111	1800011	111	Reconnect with the fundamental elements of human spirituality	{"To help members and non-members relax in mind and spirit by providing a day of relaxation"}	Take Me To Church	A break from the daily routine to explore one's spirituality away from the day-to-day environment.\n	We will organize a trip to a nearby church 	2018-02-16	2018-02-16	8	6	\N	f	2000.00	\N	t
110	1800011	109	Raise awareness of Philippine culture and identity through our mythology	{"Call for artworks showcasing the mystical world of Philippine mythology"}	Aswang, Atbp. 	Showcase artwork of Kajo Baldisimo from the Trese series of Budjette Tan alongside artworks from other artists.\n	In partnership with the Bienvenido Creative Writing Center, we will invite Baldisimo and other artists to showcase their artworks on Philippine mythology.	2018-02-16	2018-02-16	8	6		f	500.00	\N	t
112	1800011	112	To talk about the relevance of crafts in this time and age.	{"To break the ice and provide an \\"informal\\" space for Cultura members to share their thoughts on certain topics."}	Brown Bag Series: Craft Talk	An "informal" roundtable discussion on writing, media, craft, and publication.\n	Members of Cultura will be given priority in facilitating the discussion; non-members are welcome to attend. 	2018-02-24	2018-02-24	1	3	\N	t	2000.00	\N	t
113	1800011	113	Prepare literature majors for post-graduation job hunting by providing them possible options of careers to pursue.	{"To break the stereotypes surrounding the Literature degree by inviting embodiments of success in the field of arts and literature"}	Let's Get Lit: Career Caravan	A talk with people of various occupations who have majored in Literature to educate undergraduates with possible options for their future coupled with an open forum.\n	We will collaborate with the Literature department and individuals outside of the university to enable access to a diverse and fulfilling discussion.	2018-03-03	2018-03-03	1	3	\N	t	3000.00	\N	t
114	1800011	114	Interact with the famed author and his works	{"To showcase the works of Vargas Llosa and to enlighten people about the artist's poetics and politics"}	Vargas Llosa Goes to DLSU	In partnership with the department and of the BNS creative wriitng center, Vargas Llosa will be visiting DLSU to interact with the Lasallian community\n	We will host an exhibit which promotes Llosa's artworks to the Lasallian community	2018-03-16	2018-03-16	3	3	\N	f	0.00	\N	t
115	1800011	115	Invite Cultura members and professors fro the Department to talk about their current projects and endeavors	{"To create connections for Cultura artists and writers by providing them with an avenue to showcase their work"}	Brown Bag Series: "Talent Show"	The "Talent Show" is a Cultura convention where the members can talk about their current artistic endeavors, allowing them to share their passions and create connections with other artists and writers\n	We will invite acclaimed writers from the Department of Literature to facilitate the discussion	2018-02-09	2018-02-09	1	3	\N	t	1500.00	\N	t
116	1800011	116	Create a multi-disciplinary atmosphere where students and professors can talk about theory and the arts and its application in the real world	{"To connect the Literature department with the students  in joined intellectual communion"}	Arrogo Talk	A session facilitated by Dr. Tiny Arrogo of the Literature Department on all things Humanities\n	We will be inviting Dr. Tiny Arrogo, among other professors, for a talk on the value of the humanities	2018-02-17	2018-02-17	3	3	\N	f	0.00	\N	t
117	1500007	85	To experience Japanese and La Sallian integration of spirituality	{"Integrate La Sallian qualities with japanese culture"}	Spirited Away: Adventure of a lifetime	aguy	15 ENMP	2018-02-14	2018-02-14	8	6	\N	f	5000.00	\N	t
118	100001	32	To provide opportunities for its members in order to develop social skills and camaraderie with other members	{"To be able to look back on the activities of the organization for the year","To be able to recognize outstanding officers","To help the students get a grasp of the culture in CCS"}	General Assembly	The General Assembly is a gathering of the members and officers of the organization wherein outstanding officers will be recognized and the activities that have transpired throughout the year	Participation of at least 100 members	2018-01-25	2018-01-25	1	2	\N	f	0.00	\N	f
\.


--
-- Data for Name: gosmactivityprojecthead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gosmactivityprojecthead (idnumber, activityid) FROM stdin;
1111114	1
1111114	2
7111114	3
7111116	3
1111114	4
7111114	5
1111114	6
4111114	7
4111115	7
1111114	8
7111114	9
1111114	10
4111114	11
7111114	12
7111116	12
1111114	13
4111112	14
4111114	14
1111114	17
4111114	18
4111116	18
1111113	20
1111114	21
7111114	22
7111116	22
4111114	23
4111116	23
7111114	24
7111116	24
7111114	25
7111116	25
4111113	26
4111114	26
7111114	27
7111116	27
7111114	28
4111114	29
1111114	30
1111116	30
1111114	31
2111114	32
2111114	33
8111114	34
8111116	34
6111112	35
6111113	35
6111114	35
2111114	36
6111114	37
8111111	38
8111114	38
8111116	38
6111112	39
6111114	39
2111114	40
8111112	41
8111114	41
8111116	41
8111114	42
8111115	42
8111116	42
6111113	43
6111114	43
8111111	44
8111113	44
8111114	44
8111116	44
6111114	45
2111114	46
8111112	47
8111114	47
8111116	47
6111112	48
6111114	48
2111114	49
6111114	50
2111114	51
8111113	52
8111114	52
8111116	52
2111114	53
8111114	54
2111114	55
6111114	56
6111114	57
6111115	57
2111114	58
6111113	59
6111114	59
6111112	60
6111114	60
3111114	61
3111114	62
6111113	63
6111114	63
3111114	64
10111114	65
6111113	66
6111114	66
3111114	67
3111114	68
3111114	69
10111114	70
10111116	70
6111114	71
6111115	71
3111114	72
10111114	73
6111113	74
6111114	74
3111114	75
8111111	76
8111112	76
8111114	76
6111113	77
6111114	77
8111112	78
8111113	78
8111114	78
3111114	79
10111114	80
3111114	81
6111112	82
6111114	82
10111114	83
8111114	84
8111116	84
10111114	85
10111114	86
10111114	88
10111116	88
9111111	89
9111114	89
10111114	90
10111116	90
9111112	91
9111114	91
9111116	91
10111114	92
10111116	92
9111114	93
9111116	93
10111114	94
9111114	95
9111116	95
10111114	96
9111114	97
9111116	97
9111114	98
9111116	98
9111111	99
9111114	99
9111111	100
9111114	100
9111116	100
11111112	101
11111114	101
9111111	102
9111114	102
11111112	103
11111114	103
9111112	104
9111114	104
11111114	105
11111116	105
9111111	106
9111114	106
9111116	106
9111111	107
9111114	107
11111112	108
11111114	108
9111112	109
9111114	109
9111116	109
11111112	111
11111114	111
11111111	110
11111114	110
11111112	112
11111114	112
11111111	113
11111112	113
11111114	113
11111111	114
11111112	114
11111114	114
11111113	115
11111114	115
11111111	116
11111114	116
8111111	117
8111114	117
1111114	118
\.


--
-- Data for Name: gosmstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gosmstatus (id, name) FROM stdin;
1	Created
2	For Approval
3	Approved
4	Pending
5	Denied
\.


--
-- Data for Name: organizationaccesscontrol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationaccesscontrol (role, functionality, isallowed) FROM stdin;
100109	211009	t
100109	214027	t
100109	104028	t
100109	109032	t
100111	211009	t
100111	212018	t
100111	211026	t
100111	214027	t
100111	104028	t
100111	109032	t
100106	211009	t
100106	211010	t
100106	214027	t
100106	104028	t
100106	109032	t
100105	211009	t
100105	211010	t
100105	214027	t
100105	104028	t
100105	109032	t
100107	211009	t
100107	214027	t
100107	104028	t
100107	109032	t
100112	214027	t
100104	211000	t
100104	211009	t
100104	211010	t
100104	211015	t
100104	212019	t
100104	212021	t
100104	211024	t
100104	211025	t
100104	214027	t
100104	104028	t
100104	1031	t
100104	109032	t
100108	211009	t
100108	211012	t
100108	214027	t
100108	104028	t
100108	109032	t
100110	211009	t
100110	211011	t
100110	212018	t
100110	212019	t
100110	212021	t
100110	212022	t
100110	211026	t
100110	214027	t
100110	104028	t
100110	109032	t
100110	105033	t
0	104002	t
0	214007	t
0	104030	t
280271	211009	t
280271	214027	t
280271	104028	t
280271	109032	t
280273	211009	t
280273	212018	t
280273	211026	t
280273	214027	t
280273	104028	t
280273	109032	t
280268	211009	t
280268	211010	t
280268	214027	t
280268	104028	t
280268	109032	t
280267	211009	t
280267	211010	t
280267	214027	t
280267	104028	t
280267	109032	t
280269	211009	t
280269	214027	t
280269	104028	t
280269	109032	t
280274	214027	t
280266	211000	t
280266	211009	t
280266	211010	t
280266	211015	t
280266	212019	t
280266	212021	t
280266	211024	t
280266	211025	t
280266	214027	t
280266	104028	t
280266	1031	t
280266	109032	t
280270	211009	t
280270	211012	t
280270	214027	t
280270	104028	t
280270	109032	t
280272	211009	t
280272	211011	t
280272	212018	t
280272	212019	t
280272	212021	t
280272	212022	t
280272	211026	t
280272	214027	t
280272	104028	t
280272	109032	t
280272	105033	t
340325	211009	t
340325	214027	t
340325	104028	t
340325	109032	t
340327	211009	t
340327	212018	t
340327	211026	t
340327	214027	t
340327	104028	t
340327	109032	t
340322	211009	t
340322	211010	t
340322	214027	t
340322	104028	t
340322	109032	t
340321	211009	t
340321	211010	t
340321	214027	t
340321	104028	t
340321	109032	t
340323	211009	t
340323	214027	t
340323	104028	t
340323	109032	t
340328	214027	t
340320	211000	t
340320	211009	t
340320	211010	t
340320	211015	t
340320	212019	t
340320	212021	t
340320	211024	t
340320	211025	t
340320	214027	t
340320	104028	t
340320	1031	t
340320	109032	t
340324	211009	t
340324	211012	t
340324	214027	t
340324	104028	t
340324	109032	t
340326	211009	t
340326	211011	t
340326	212018	t
340326	212019	t
340326	212021	t
340326	212022	t
340326	211026	t
340326	214027	t
340326	104028	t
340326	109032	t
340326	105033	t
160163	211009	t
160163	214027	t
160163	104028	t
160163	109032	t
160165	211009	t
160165	212018	t
160165	211026	t
160165	214027	t
160165	104028	t
160165	109032	t
160160	211009	t
160160	211010	t
160160	214027	t
160160	104028	t
160160	109032	t
160159	211009	t
160159	211010	t
160159	214027	t
160159	104028	t
160159	109032	t
160161	211009	t
160161	214027	t
160161	104028	t
160161	109032	t
160166	214027	t
160158	211000	t
160158	211009	t
160158	211010	t
160158	211015	t
160158	212019	t
160158	212021	t
160158	211024	t
160158	211025	t
160158	214027	t
160158	104028	t
160158	1031	t
160158	109032	t
160162	211009	t
160162	211012	t
160162	214027	t
160162	104028	t
160162	109032	t
160164	211009	t
160164	211011	t
160164	212018	t
160164	212019	t
160164	212021	t
160164	212022	t
160164	211026	t
160164	214027	t
160164	104028	t
160164	109032	t
160164	105033	t
350334	211009	t
350334	214027	t
350334	104028	t
350334	109032	t
350336	211009	t
350336	212018	t
350336	211026	t
350336	214027	t
350336	104028	t
350336	109032	t
350331	211009	t
350331	211010	t
350331	214027	t
350331	104028	t
350331	109032	t
350330	211009	t
350330	211010	t
350330	214027	t
350330	104028	t
350330	109032	t
350332	211009	t
350332	214027	t
350332	104028	t
350332	109032	t
350337	214027	t
350329	211000	t
350329	211009	t
350329	211010	t
350329	211015	t
350329	212019	t
350329	212021	t
350329	211024	t
350329	211025	t
350329	214027	t
350329	104028	t
350329	1031	t
350329	109032	t
350333	211009	t
350333	211012	t
350333	214027	t
350333	104028	t
350333	109032	t
350335	211009	t
350335	211011	t
350335	212018	t
350335	212019	t
350335	212021	t
350335	212022	t
350335	211026	t
350335	214027	t
350335	104028	t
350335	109032	t
350335	105033	t
170172	211009	t
170172	214027	t
170172	104028	t
170172	109032	t
170174	211009	t
170174	212018	t
170174	211026	t
170174	214027	t
170174	104028	t
170174	109032	t
170169	211009	t
170169	211010	t
170169	214027	t
170169	104028	t
170169	109032	t
170168	211009	t
170168	211010	t
170168	214027	t
170168	104028	t
170168	109032	t
170170	211009	t
170170	214027	t
170170	104028	t
170170	109032	t
170175	214027	t
170167	211000	t
170167	211009	t
170167	211010	t
170167	211015	t
170167	212019	t
170167	212021	t
170167	211024	t
170167	211025	t
170167	214027	t
170167	104028	t
170167	1031	t
170167	109032	t
170171	211009	t
170171	211012	t
170171	214027	t
170171	104028	t
170171	109032	t
170173	211009	t
170173	211011	t
170173	212018	t
170173	212019	t
170173	212021	t
170173	212022	t
170173	211026	t
170173	214027	t
170173	104028	t
170173	109032	t
170173	105033	t
300289	211009	t
300289	214027	t
300289	104028	t
300289	109032	t
300291	211009	t
300291	212018	t
300291	211026	t
300291	214027	t
300291	104028	t
300291	109032	t
300286	211009	t
300286	211010	t
300286	214027	t
300286	104028	t
300286	109032	t
300285	211009	t
300285	211010	t
300285	214027	t
300285	104028	t
300285	109032	t
300287	211009	t
300287	214027	t
300287	104028	t
300287	109032	t
300292	214027	t
300284	211000	t
300284	211009	t
300284	211010	t
300284	211015	t
300284	212019	t
300284	212021	t
300284	211024	t
300284	211025	t
300284	214027	t
300284	104028	t
300284	1031	t
300284	109032	t
300288	211009	t
300288	211012	t
300288	214027	t
300288	104028	t
300288	109032	t
300290	211009	t
300290	211011	t
300290	212018	t
300290	212019	t
300290	212021	t
300290	212022	t
300290	211026	t
300290	214027	t
300290	104028	t
300290	109032	t
300290	105033	t
50064	211009	t
50064	214027	t
50064	104028	t
50064	109032	t
50066	211009	t
50066	212018	t
50066	211026	t
50066	214027	t
50066	104028	t
50066	109032	t
50061	211009	t
50061	211010	t
50061	214027	t
50061	104028	t
50061	109032	t
50060	211009	t
50060	211010	t
50060	214027	t
50060	104028	t
50060	109032	t
50062	211009	t
50062	214027	t
50062	104028	t
50062	109032	t
50067	214027	t
50059	211000	t
50059	211009	t
50059	211010	t
50059	211015	t
50059	212019	t
50059	212021	t
50059	211024	t
50059	211025	t
50059	214027	t
50059	104028	t
50059	1031	t
50059	109032	t
50063	211009	t
50063	211012	t
50063	214027	t
50063	104028	t
50063	109032	t
50065	211009	t
50065	211011	t
50065	212018	t
50065	212019	t
50065	212021	t
50065	212022	t
50065	211026	t
50065	214027	t
50065	104028	t
50065	109032	t
50065	105033	t
290280	211009	t
290280	214027	t
290280	104028	t
290280	109032	t
290282	211009	t
290282	212018	t
290282	211026	t
290282	214027	t
290282	104028	t
290282	109032	t
290277	211009	t
290277	211010	t
290277	214027	t
290277	104028	t
290277	109032	t
290276	211009	t
290276	211010	t
290276	214027	t
290276	104028	t
290276	109032	t
290278	211009	t
290278	214027	t
290278	104028	t
290278	109032	t
290283	214027	t
290275	211000	t
290275	211009	t
290275	211010	t
290275	211015	t
290275	212019	t
290275	212021	t
290275	211024	t
290275	211025	t
290275	214027	t
290275	104028	t
290275	1031	t
290275	109032	t
290279	211009	t
290279	211012	t
290279	214027	t
290279	104028	t
290279	109032	t
290281	211009	t
290281	211011	t
290281	212018	t
290281	212019	t
290281	212021	t
290281	212022	t
290281	211026	t
290281	214027	t
290281	104028	t
290281	109032	t
290281	105033	t
10	108004	t
13	104003	t
13	104013	t
22	109006	t
19	106017	t
9	108004	t
6	108020	t
7	108020	t
12	104003	t
12	104014	t
21	109006	t
21	3008	t
21	2023	t
18	106017	t
3	104002	t
3	3008	t
3	104030	t
2	104002	t
2	3008	t
2	2023	t
2	104030	t
4	104002	t
4	3008	t
4	104030	t
1	104002	t
1	3008	t
1	104030	t
8	108004	t
5	3008	t
5	108020	t
11	104003	t
20	109006	t
20	2023	t
17	106017	t
180181	211009	t
180181	214027	t
180181	104028	t
180181	109032	t
180183	211009	t
180183	212018	t
180183	211026	t
180183	214027	t
180183	104028	t
180183	109032	t
180178	211009	t
180178	211010	t
180178	214027	t
180178	104028	t
180178	109032	t
180177	211009	t
180177	211010	t
180177	214027	t
180177	104028	t
180177	109032	t
180179	211009	t
180179	214027	t
180179	104028	t
180179	109032	t
180184	214027	t
180176	211000	t
180176	211009	t
180176	211010	t
180176	211015	t
180176	212019	t
180176	212021	t
180176	211024	t
180176	211025	t
180176	214027	t
180176	104028	t
180176	1031	t
180176	109032	t
180180	211009	t
180180	211012	t
180180	214027	t
180180	104028	t
180180	109032	t
180182	211009	t
180182	211011	t
180182	212018	t
180182	212019	t
180182	212021	t
180182	212022	t
180182	211026	t
180182	214027	t
180182	104028	t
180182	109032	t
180182	105033	t
190190	211009	t
190190	214027	t
190190	104028	t
190190	109032	t
190192	211009	t
190192	212018	t
190192	211026	t
190192	214027	t
190192	104028	t
190192	109032	t
190187	211009	t
190187	211010	t
190187	214027	t
190187	104028	t
190187	109032	t
190186	211009	t
190186	211010	t
190186	214027	t
190186	104028	t
190186	109032	t
190188	211009	t
190188	214027	t
190188	104028	t
190188	109032	t
190193	214027	t
190185	211000	t
190185	211009	t
190185	211010	t
190185	211015	t
190185	212019	t
190185	212021	t
190185	211024	t
190185	211025	t
190185	214027	t
190185	104028	t
190185	1031	t
190185	109032	t
190189	211009	t
190189	211012	t
190189	214027	t
190189	104028	t
190189	109032	t
190191	211009	t
190191	211011	t
190191	212018	t
190191	212019	t
190191	212021	t
190191	212022	t
190191	211026	t
190191	214027	t
190191	104028	t
190191	109032	t
190191	105033	t
240235	211009	t
240235	214027	t
240235	104028	t
240235	109032	t
240237	211009	t
240237	212018	t
240237	211026	t
240237	214027	t
240237	104028	t
240237	109032	t
240232	211009	t
240232	211010	t
240232	214027	t
240232	104028	t
240232	109032	t
240231	211009	t
240231	211010	t
240231	214027	t
240231	104028	t
240231	109032	t
240233	211009	t
240233	214027	t
240233	104028	t
240233	109032	t
240238	214027	t
240230	211000	t
240230	211009	t
240230	211010	t
240230	211015	t
240230	212019	t
240230	212021	t
240230	211024	t
240230	211025	t
240230	214027	t
240230	104028	t
240230	1031	t
240230	109032	t
240234	211009	t
240234	211012	t
240234	214027	t
240234	104028	t
240234	109032	t
240236	211009	t
240236	211011	t
240236	212018	t
240236	212019	t
240236	212021	t
240236	212022	t
240236	211026	t
240236	214027	t
240236	104028	t
240236	109032	t
240236	105033	t
310298	211009	t
310298	214027	t
310298	104028	t
310298	109032	t
310300	211009	t
310300	212018	t
310300	211026	t
310300	214027	t
310300	104028	t
310300	109032	t
310295	211009	t
310295	211010	t
310295	214027	t
310295	104028	t
310295	109032	t
310294	211009	t
310294	211010	t
310294	214027	t
310294	104028	t
310294	109032	t
310296	211009	t
310296	214027	t
310296	104028	t
310296	109032	t
310301	214027	t
310293	211000	t
310293	211009	t
310293	211010	t
310293	211015	t
310293	212019	t
310293	212021	t
310293	211024	t
310293	211025	t
310293	214027	t
310293	104028	t
310293	1031	t
310293	109032	t
310297	211009	t
310297	211012	t
310297	214027	t
310297	104028	t
310297	109032	t
310299	211009	t
310299	211011	t
310299	212018	t
310299	212019	t
310299	212021	t
310299	212022	t
310299	211026	t
310299	214027	t
310299	104028	t
310299	109032	t
310299	105033	t
140145	211009	t
140145	214027	t
140145	104028	t
140145	109032	t
140147	211009	t
140147	212018	t
140147	211026	t
140147	214027	t
140147	104028	t
140147	109032	t
140142	211009	t
140142	211010	t
140142	214027	t
140142	104028	t
140142	109032	t
140141	211009	t
140141	211010	t
140141	214027	t
140141	104028	t
140141	109032	t
140143	211009	t
140143	214027	t
140143	104028	t
140143	109032	t
140148	214027	t
140140	211000	t
140140	211009	t
140140	211010	t
140140	211015	t
140140	212019	t
140140	212021	t
140140	211024	t
140140	211025	t
140140	214027	t
140140	104028	t
140140	1031	t
140140	109032	t
140144	211009	t
140144	211012	t
140144	214027	t
140144	104028	t
140144	109032	t
140146	211009	t
140146	211011	t
140146	212018	t
140146	212019	t
140146	212021	t
140146	212022	t
140146	211026	t
140146	214027	t
140146	104028	t
140146	109032	t
140146	105033	t
360343	211009	t
360343	214027	t
360343	104028	t
360343	109032	t
360345	211009	t
360345	212018	t
360345	211026	t
360345	214027	t
360345	104028	t
360345	109032	t
360340	211009	t
360340	211010	t
360340	214027	t
360340	104028	t
360340	109032	t
360339	211009	t
360339	211010	t
360339	214027	t
360339	104028	t
360339	109032	t
360341	211009	t
360341	214027	t
360341	104028	t
360341	109032	t
360346	214027	t
360338	211000	t
360338	211009	t
360338	211010	t
360338	211015	t
360338	212019	t
360338	212021	t
360338	211024	t
360338	211025	t
360338	214027	t
360338	104028	t
360338	1031	t
360338	109032	t
360342	211009	t
360342	211012	t
360342	214027	t
360342	104028	t
360342	109032	t
360344	211009	t
360344	211011	t
360344	212018	t
360344	212019	t
360344	212021	t
360344	212022	t
360344	211026	t
360344	214027	t
360344	104028	t
360344	109032	t
360344	105033	t
70082	211009	t
70082	214027	t
70082	104028	t
70082	109032	t
70084	211009	t
70084	212018	t
70084	211026	t
70084	214027	t
70084	104028	t
70084	109032	t
70079	211009	t
70079	211010	t
70079	214027	t
70079	104028	t
70079	109032	t
70078	211009	t
70078	211010	t
70078	214027	t
70078	104028	t
70078	109032	t
70080	211009	t
70080	214027	t
70080	104028	t
70080	109032	t
70085	214027	t
70077	211000	t
70077	211009	t
70077	211010	t
70077	211015	t
70077	212019	t
70077	212021	t
70077	211024	t
70077	211025	t
70077	214027	t
70077	104028	t
70077	1031	t
70077	109032	t
70081	211009	t
70081	211012	t
70081	214027	t
70081	104028	t
70081	109032	t
70083	211009	t
70083	211011	t
70083	212018	t
70083	212019	t
70083	212021	t
70083	212022	t
70083	211026	t
70083	214027	t
70083	104028	t
70083	109032	t
70083	105033	t
200199	211009	t
200199	214027	t
200199	104028	t
200199	109032	t
200201	211009	t
200201	212018	t
200201	211026	t
200201	214027	t
200201	104028	t
200201	109032	t
200196	211009	t
200196	211010	t
200196	214027	t
200196	104028	t
200196	109032	t
200195	211009	t
200195	211010	t
200195	214027	t
200195	104028	t
200195	109032	t
200197	211009	t
200197	214027	t
200197	104028	t
200197	109032	t
200202	214027	t
200194	211000	t
200194	211009	t
200194	211010	t
200194	211015	t
200194	212019	t
200194	212021	t
200194	211024	t
200194	211025	t
200194	214027	t
200194	104028	t
200194	1031	t
200194	109032	t
200198	211009	t
200198	211012	t
200198	214027	t
200198	104028	t
200198	109032	t
200200	211009	t
200200	211011	t
200200	212018	t
200200	212019	t
200200	212021	t
200200	212022	t
200200	211026	t
200200	214027	t
200200	104028	t
200200	109032	t
200200	105033	t
150154	211009	t
150154	214027	t
150154	104028	t
150154	109032	t
150156	211009	t
150156	212018	t
150156	211026	t
150156	214027	t
150156	104028	t
150156	109032	t
150151	211009	t
150151	211010	t
150151	214027	t
150151	104028	t
150151	109032	t
150150	211009	t
150150	211010	t
150150	214027	t
150150	104028	t
150150	109032	t
150152	211009	t
150152	214027	t
150152	104028	t
150152	109032	t
150157	214027	t
150149	211000	t
150149	211009	t
150149	211010	t
150149	211015	t
150149	212019	t
150149	212021	t
150149	211024	t
150149	211025	t
150149	214027	t
150149	104028	t
150149	1031	t
150149	109032	t
150153	211009	t
150153	211012	t
150153	214027	t
150153	104028	t
150153	109032	t
150155	211009	t
150155	211011	t
150155	212018	t
150155	212019	t
150155	212021	t
150155	212022	t
150155	211026	t
150155	214027	t
150155	104028	t
150155	109032	t
150155	105033	t
320307	211009	t
320307	214027	t
320307	104028	t
320307	109032	t
320309	211009	t
320309	212018	t
320309	211026	t
320309	214027	t
320309	104028	t
320309	109032	t
320304	211009	t
320304	211010	t
320304	214027	t
320304	104028	t
320304	109032	t
320303	211009	t
320303	211010	t
320303	214027	t
320303	104028	t
320303	109032	t
320305	211009	t
320305	214027	t
320305	104028	t
320305	109032	t
320310	214027	t
320302	211000	t
320302	211009	t
320302	211010	t
320302	211015	t
320302	212019	t
320302	212021	t
320302	211024	t
320302	211025	t
320302	214027	t
320302	104028	t
320302	1031	t
320302	109032	t
320306	211009	t
320306	211012	t
320306	214027	t
320306	104028	t
320306	109032	t
320308	211009	t
320308	211011	t
320308	212018	t
320308	212019	t
320308	212021	t
320308	212022	t
320308	211026	t
320308	214027	t
320308	104028	t
320308	109032	t
320308	105033	t
210208	211009	t
210208	214027	t
210208	104028	t
210208	109032	t
210210	211009	t
210210	212018	t
210210	211026	t
210210	214027	t
210210	104028	t
210210	109032	t
210205	211009	t
210205	211010	t
210205	214027	t
210205	104028	t
210205	109032	t
210204	211009	t
210204	211010	t
210204	214027	t
210204	104028	t
210204	109032	t
210206	211009	t
210206	214027	t
210206	104028	t
210206	109032	t
210211	214027	t
210203	211000	t
210203	211009	t
210203	211010	t
210203	211015	t
210203	212019	t
210203	212021	t
210203	211024	t
210203	211025	t
210203	214027	t
210203	104028	t
210203	1031	t
210203	109032	t
210207	211009	t
210207	211012	t
210207	214027	t
210207	104028	t
210207	109032	t
210209	211009	t
210209	211011	t
210209	212018	t
210209	212019	t
210209	212021	t
210209	212022	t
210209	211026	t
210209	214027	t
210209	104028	t
210209	109032	t
210209	105033	t
10028	211009	t
10028	214027	t
10028	104028	t
10028	109032	t
10030	211009	t
10030	212018	t
10030	211026	t
10030	214027	t
10030	104028	t
10030	109032	t
10025	211009	t
10025	211010	t
10025	214027	t
10025	104028	t
10025	109032	t
10024	211009	t
10024	211010	t
10024	214027	t
10024	104028	t
10024	109032	t
10026	211009	t
10026	214027	t
10026	104028	t
10026	109032	t
10031	214027	t
10023	211000	t
10023	211009	t
10023	211010	t
10023	211015	t
10023	212019	t
10023	212021	t
10023	211024	t
10023	211025	t
10023	214027	t
10023	104028	t
10023	1031	t
10023	109032	t
10027	211009	t
10027	211012	t
10027	214027	t
10027	104028	t
10027	109032	t
10029	211009	t
10029	211011	t
10029	212018	t
10029	212019	t
10029	212021	t
10029	212022	t
10029	211026	t
10029	214027	t
10029	104028	t
10029	109032	t
10029	105033	t
370352	211009	t
370352	214027	t
370352	104028	t
370352	109032	t
370354	211009	t
370354	212018	t
370354	211026	t
370354	214027	t
370354	104028	t
370354	109032	t
370349	211009	t
370349	211010	t
370349	214027	t
370349	104028	t
370349	109032	t
370348	211009	t
370348	211010	t
370348	214027	t
370348	104028	t
370348	109032	t
370350	211009	t
370350	214027	t
370350	104028	t
370350	109032	t
370355	214027	t
370347	211000	t
370347	211009	t
370347	211010	t
370347	211015	t
370347	212019	t
370347	212021	t
370347	211024	t
370347	211025	t
370347	214027	t
370347	104028	t
370347	1031	t
370347	109032	t
370351	211009	t
370351	211012	t
370351	214027	t
370351	104028	t
370351	109032	t
370353	211009	t
370353	211011	t
370353	212018	t
370353	212019	t
370353	212021	t
370353	212022	t
370353	211026	t
370353	214027	t
370353	104028	t
370353	109032	t
370353	105033	t
20037	211009	t
20037	214027	t
20037	104028	t
20037	109032	t
20039	211009	t
20039	212018	t
20039	211026	t
20039	214027	t
20039	104028	t
20039	109032	t
20034	211009	t
20034	211010	t
20034	214027	t
20034	104028	t
20034	109032	t
20033	211009	t
20033	211010	t
20033	214027	t
20033	104028	t
20033	109032	t
20035	211009	t
20035	214027	t
20035	104028	t
20035	109032	t
20040	214027	t
20032	211000	t
20032	211009	t
20032	211010	t
20032	211015	t
20032	212019	t
20032	212021	t
20032	211024	t
20032	211025	t
20032	214027	t
20032	104028	t
20032	1031	t
20032	109032	t
20036	211009	t
20036	211012	t
20036	214027	t
20036	104028	t
20036	109032	t
20038	211009	t
20038	211011	t
20038	212018	t
20038	212019	t
20038	212021	t
20038	212022	t
20038	211026	t
20038	214027	t
20038	104028	t
20038	109032	t
20038	105033	t
110118	211009	t
110118	214027	t
110118	104028	t
110118	109032	t
110120	211009	t
110120	212018	t
110120	211026	t
110120	214027	t
110120	104028	t
110120	109032	t
110115	211009	t
110115	211010	t
110115	214027	t
110115	104028	t
110115	109032	t
110114	211009	t
110114	211010	t
110114	214027	t
110114	104028	t
110114	109032	t
110116	211009	t
110116	214027	t
110116	104028	t
110116	109032	t
110121	214027	t
110113	211000	t
110113	211009	t
110113	211010	t
110113	211015	t
110113	212019	t
110113	212021	t
110113	211024	t
110113	211025	t
110113	214027	t
110113	104028	t
110113	1031	t
110113	109032	t
110117	211009	t
110117	211012	t
110117	214027	t
110117	104028	t
110117	109032	t
110119	211009	t
110119	211011	t
110119	212018	t
110119	212019	t
110119	212021	t
110119	212022	t
110119	211026	t
110119	214027	t
110119	104028	t
110119	109032	t
110119	105033	t
220217	211009	t
220217	214027	t
220217	104028	t
220217	109032	t
220219	211009	t
220219	212018	t
220219	211026	t
220219	214027	t
220219	104028	t
220219	109032	t
220214	211009	t
220214	211010	t
220214	214027	t
220214	104028	t
220214	109032	t
220213	211009	t
220213	211010	t
220213	214027	t
220213	104028	t
220213	109032	t
220215	211009	t
220215	214027	t
220215	104028	t
220215	109032	t
220220	214027	t
220212	211000	t
220212	211009	t
220212	211010	t
220212	211015	t
220212	212019	t
220212	212021	t
220212	211024	t
220212	211025	t
220212	214027	t
220212	104028	t
220212	1031	t
220212	109032	t
220216	211009	t
220216	211012	t
220216	214027	t
220216	104028	t
220216	109032	t
220218	211009	t
220218	211011	t
220218	212018	t
220218	212019	t
220218	212021	t
220218	212022	t
220218	211026	t
220218	214027	t
220218	104028	t
220218	109032	t
220218	105033	t
120127	211009	t
120127	214027	t
120127	104028	t
120127	109032	t
120129	211009	t
120129	212018	t
120129	211026	t
120129	214027	t
120129	104028	t
120129	109032	t
120124	211009	t
120124	211010	t
120124	214027	t
120124	104028	t
120124	109032	t
120123	211009	t
120123	211010	t
120123	214027	t
120123	104028	t
120123	109032	t
120125	211009	t
120125	214027	t
120125	104028	t
120125	109032	t
120130	214027	t
120122	211000	t
120122	211009	t
120122	211010	t
120122	211015	t
120122	212019	t
120122	212021	t
120122	211024	t
120122	211025	t
120122	214027	t
120122	104028	t
120122	1031	t
120122	109032	t
120126	211009	t
120126	211012	t
120126	214027	t
120126	104028	t
120126	109032	t
120128	211009	t
120128	211011	t
120128	212018	t
120128	212019	t
120128	212021	t
120128	212022	t
120128	211026	t
120128	214027	t
120128	104028	t
120128	109032	t
120128	105033	t
30046	211009	t
30046	214027	t
30046	104028	t
30046	109032	t
30048	211009	t
30048	212018	t
30048	211026	t
30048	214027	t
30048	104028	t
30048	109032	t
30043	211009	t
30043	211010	t
30043	214027	t
30043	104028	t
30043	109032	t
30042	211009	t
30042	211010	t
30042	214027	t
30042	104028	t
30042	109032	t
30044	211009	t
30044	214027	t
30044	104028	t
30044	109032	t
30049	214027	t
30041	211000	t
30041	211009	t
30041	211010	t
30041	211015	t
30041	212019	t
30041	212021	t
30041	211024	t
30041	211025	t
30041	214027	t
30041	104028	t
30041	1031	t
30041	109032	t
30045	211009	t
30045	211012	t
30045	214027	t
30045	104028	t
30045	109032	t
30047	211009	t
30047	211011	t
30047	212018	t
30047	212019	t
30047	212021	t
30047	212022	t
30047	211026	t
30047	214027	t
30047	104028	t
30047	109032	t
30047	105033	t
230226	211009	t
230226	214027	t
230226	104028	t
230226	109032	t
230228	211009	t
230228	212018	t
230228	211026	t
230228	214027	t
230228	104028	t
230228	109032	t
230223	211009	t
230223	211010	t
230223	214027	t
230223	104028	t
230223	109032	t
230222	211009	t
230222	211010	t
230222	214027	t
230222	104028	t
230222	109032	t
230224	211009	t
230224	214027	t
230224	104028	t
230224	109032	t
230229	214027	t
230221	211000	t
230221	211009	t
230221	211010	t
230221	211015	t
230221	212019	t
230221	212021	t
230221	211024	t
230221	211025	t
230221	214027	t
230221	104028	t
230221	1031	t
230221	109032	t
230225	211009	t
230225	211012	t
230225	214027	t
230225	104028	t
230225	109032	t
230227	211009	t
230227	211011	t
230227	212018	t
230227	212019	t
230227	212021	t
230227	212022	t
230227	211026	t
230227	214027	t
230227	104028	t
230227	109032	t
230227	105033	t
80091	211009	t
80091	214027	t
80091	104028	t
80091	109032	t
80093	211009	t
80093	212018	t
80093	211026	t
80093	214027	t
80093	104028	t
80093	109032	t
80088	211009	t
80088	211010	t
80088	214027	t
80088	104028	t
80088	109032	t
80087	211009	t
80087	211010	t
80087	214027	t
80087	104028	t
80087	109032	t
80089	211009	t
80089	214027	t
80089	104028	t
80089	109032	t
80094	214027	t
80086	211000	t
80086	211009	t
80086	211010	t
80086	211015	t
80086	212019	t
80086	212021	t
80086	211024	t
80086	211025	t
80086	214027	t
80086	104028	t
80086	1031	t
80086	109032	t
80090	211009	t
80090	211012	t
80090	214027	t
80090	104028	t
80090	109032	t
80092	211009	t
80092	211011	t
80092	212018	t
80092	212019	t
80092	212021	t
80092	212022	t
80092	211026	t
80092	214027	t
80092	104028	t
80092	109032	t
80092	105033	t
260253	211009	t
260253	214027	t
260253	104028	t
260253	109032	t
260255	211009	t
260255	212018	t
260255	211026	t
260255	214027	t
260255	104028	t
260255	109032	t
260250	211009	t
260250	211010	t
260250	214027	t
260250	104028	t
260250	109032	t
260249	211009	t
260249	211010	t
260249	214027	t
260249	104028	t
260249	109032	t
260251	211009	t
260251	214027	t
260251	104028	t
260251	109032	t
260256	214027	t
260248	211000	t
260248	211009	t
260248	211010	t
260248	211015	t
260248	212019	t
260248	212021	t
260248	211024	t
260248	211025	t
260248	214027	t
260248	104028	t
260248	1031	t
260248	109032	t
260252	211009	t
260252	211012	t
260252	214027	t
260252	104028	t
260252	109032	t
260254	211009	t
260254	211011	t
260254	212018	t
260254	212019	t
260254	212021	t
260254	212022	t
260254	211026	t
260254	214027	t
260254	104028	t
260254	109032	t
260254	105033	t
330316	211009	t
330316	214027	t
330316	104028	t
330316	109032	t
330318	211009	t
330318	212018	t
330318	211026	t
330318	214027	t
330318	104028	t
330318	109032	t
330313	211009	t
330313	211010	t
330313	214027	t
330313	104028	t
330313	109032	t
330312	211009	t
330312	211010	t
330312	214027	t
330312	104028	t
330312	109032	t
330314	211009	t
330314	214027	t
330314	104028	t
330314	109032	t
330319	214027	t
330311	211000	t
330311	211009	t
330311	211010	t
330311	211015	t
330311	212019	t
330311	212021	t
330311	211024	t
330311	211025	t
330311	214027	t
330311	104028	t
330311	1031	t
330311	109032	t
330315	211009	t
330315	211012	t
330315	214027	t
330315	104028	t
330315	109032	t
330317	211009	t
330317	211011	t
330317	212018	t
330317	212019	t
330317	212021	t
330317	212022	t
330317	211026	t
330317	214027	t
330317	104028	t
330317	109032	t
330317	105033	t
250244	211009	t
250244	214027	t
250244	104028	t
250244	109032	t
250246	211009	t
250246	212018	t
250246	211026	t
250246	214027	t
250246	104028	t
250246	109032	t
250241	211009	t
250241	211010	t
250241	214027	t
250241	104028	t
250241	109032	t
250240	211009	t
250240	211010	t
250240	214027	t
250240	104028	t
250240	109032	t
250242	211009	t
250242	214027	t
250242	104028	t
250242	109032	t
250247	214027	t
250239	211000	t
250239	211009	t
250239	211010	t
250239	211015	t
250239	212019	t
250239	212021	t
250239	211024	t
250239	211025	t
250239	214027	t
250239	104028	t
250239	1031	t
250239	109032	t
250243	211009	t
250243	211012	t
250243	214027	t
250243	104028	t
250243	109032	t
250245	211009	t
250245	211011	t
250245	212018	t
250245	212019	t
250245	212021	t
250245	212022	t
250245	211026	t
250245	214027	t
250245	104028	t
250245	109032	t
250245	105033	t
40055	211009	t
40055	214027	t
40055	104028	t
40055	109032	t
40057	211009	t
40057	212018	t
40057	211026	t
40057	214027	t
40057	104028	t
40057	109032	t
40052	211009	t
40052	211010	t
40052	214027	t
40052	104028	t
40052	109032	t
40051	211009	t
40051	211010	t
40051	214027	t
40051	104028	t
40051	109032	t
40053	211009	t
40053	214027	t
40053	104028	t
40053	109032	t
40058	214027	t
40050	211000	t
40050	211009	t
40050	211010	t
40050	211015	t
40050	212019	t
40050	212021	t
40050	211024	t
40050	211025	t
40050	214027	t
40050	104028	t
40050	1031	t
40050	109032	t
40054	211009	t
40054	211012	t
40054	214027	t
40054	104028	t
40054	109032	t
40056	211009	t
40056	211011	t
40056	212018	t
40056	212019	t
40056	212021	t
40056	212022	t
40056	211026	t
40056	214027	t
40056	104028	t
40056	109032	t
40056	105033	t
270262	211009	t
270262	214027	t
270262	104028	t
270262	109032	t
270264	211009	t
270264	212018	t
270264	211026	t
270264	214027	t
270264	104028	t
270264	109032	t
270259	211009	t
270259	211010	t
270259	214027	t
270259	104028	t
270259	109032	t
270258	211009	t
270258	211010	t
270258	214027	t
270258	104028	t
270258	109032	t
270260	211009	t
270260	214027	t
270260	104028	t
270260	109032	t
270265	214027	t
270257	211000	t
270257	211009	t
270257	211010	t
270257	211015	t
270257	212019	t
270257	212021	t
270257	211024	t
270257	211025	t
270257	214027	t
270257	104028	t
270257	1031	t
270257	109032	t
270261	211009	t
270261	211012	t
270261	214027	t
270261	104028	t
270261	109032	t
270263	211009	t
270263	211011	t
270263	212018	t
270263	212019	t
270263	212021	t
270263	212022	t
270263	211026	t
270263	214027	t
270263	104028	t
270263	109032	t
270263	105033	t
90100	211009	t
90100	214027	t
90100	104028	t
90100	109032	t
90102	211009	t
90102	212018	t
90102	211026	t
90102	214027	t
90102	104028	t
90102	109032	t
90097	211009	t
90097	211010	t
90097	214027	t
90097	104028	t
90097	109032	t
90096	211009	t
90096	211010	t
90096	214027	t
90096	104028	t
90096	109032	t
90098	211009	t
90098	214027	t
90098	104028	t
90098	109032	t
90103	214027	t
90095	211000	t
90095	211009	t
90095	211010	t
90095	211015	t
90095	212019	t
90095	212021	t
90095	211024	t
90095	211025	t
90095	214027	t
90095	104028	t
90095	1031	t
90095	109032	t
90099	211009	t
90099	211012	t
90099	214027	t
90099	104028	t
90099	109032	t
90101	211009	t
90101	211011	t
90101	212018	t
90101	212019	t
90101	212021	t
90101	212022	t
90101	211026	t
90101	214027	t
90101	104028	t
90101	109032	t
90101	105033	t
60073	211009	t
60073	214027	t
60073	104028	t
60073	109032	t
60075	211009	t
60075	212018	t
60075	211026	t
60075	214027	t
60075	104028	t
60075	109032	t
60070	211009	t
60070	211010	t
60070	214027	t
60070	104028	t
60070	109032	t
60069	211009	t
60069	211010	t
60069	214027	t
60069	104028	t
60069	109032	t
60071	211009	t
60071	214027	t
60071	104028	t
60071	109032	t
60076	214027	t
60068	211000	t
60068	211009	t
60068	211010	t
60068	211015	t
60068	212019	t
60068	212021	t
60068	211024	t
60068	211025	t
60068	214027	t
60068	104028	t
60068	1031	t
60068	109032	t
60072	211009	t
60072	211012	t
60072	214027	t
60072	104028	t
60072	109032	t
60074	211009	t
60074	211011	t
60074	212018	t
60074	212019	t
60074	212021	t
60074	212022	t
60074	211026	t
60074	214027	t
60074	104028	t
60074	109032	t
60074	105033	t
130136	211009	t
130136	214027	t
130136	104028	t
130136	109032	t
130138	211009	t
130138	212018	t
130138	211026	t
130138	214027	t
130138	104028	t
130138	109032	t
130133	211009	t
130133	211010	t
130133	214027	t
130133	104028	t
130133	109032	t
130132	211009	t
130132	211010	t
130132	214027	t
130132	104028	t
130132	109032	t
130134	211009	t
130134	214027	t
130134	104028	t
130134	109032	t
130139	214027	t
130131	211000	t
130131	211009	t
130131	211010	t
130131	211015	t
130131	212019	t
130131	212021	t
130131	211024	t
130131	211025	t
130131	214027	t
130131	104028	t
130131	1031	t
130131	109032	t
130135	211009	t
130135	211012	t
130135	214027	t
130135	104028	t
130135	109032	t
130137	211009	t
130137	211011	t
130137	212018	t
130137	212019	t
130137	212021	t
130137	212022	t
130137	211026	t
130137	214027	t
130137	104028	t
130137	109032	t
130137	105033	t
380361	211009	t
380361	214027	t
380361	104028	t
380361	109032	t
380363	211009	t
380363	212018	t
380363	211026	t
380363	214027	t
380363	104028	t
380363	109032	t
380358	211009	t
380358	211010	t
380358	214027	t
380358	104028	t
380358	109032	t
380357	211009	t
380357	211010	t
380357	214027	t
380357	104028	t
380357	109032	t
380359	211009	t
380359	214027	t
380359	104028	t
380359	109032	t
380364	214027	t
380356	211000	t
380356	211009	t
380356	211010	t
380356	211015	t
380356	212019	t
380356	212021	t
380356	211024	t
380356	211025	t
380356	214027	t
380356	104028	t
380356	1031	t
380356	109032	t
380360	211009	t
380360	211012	t
380360	214027	t
380360	104028	t
380360	109032	t
380362	211009	t
380362	211011	t
380362	212018	t
380362	212019	t
380362	212021	t
380362	212022	t
380362	211026	t
380362	214027	t
380362	104028	t
380362	109032	t
380362	105033	t
\.


--
-- Data for Name: organizationcluster; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationcluster (id, name, acronym) FROM stdin;
1	Alliance of Science Organizations	ASO
2	Alliance of Special Interest and Socio-Civic Organizations	ASPIRE
3	College of Liberal Arts Professional Organizations	CAP12
4	Engineering Alliance Geared Towards Excellence	ENGAGE
5	Alliance of Professional Organizations of Business and Economics	PROBE
\.


--
-- Data for Name: organizationfacultyadviser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationfacultyadviser (id, organization, faculty, yearid) FROM stdin;
1	1	2011111	20172018
2	1	2011112	20172018
3	38	2011111	20172018
4	38	2011112	20172018
5	10	2011111	20172018
6	10	2011112	20172018
7	11	2011111	20172018
8	11	2011112	20172018
9	12	2011111	20172018
10	12	2011112	20172018
11	13	2011111	20172018
12	13	2011112	20172018
13	14	2011111	20172018
14	14	2011112	20172018
15	15	2011111	20172018
16	15	2011112	20172018
17	16	2011111	20172018
18	16	2011112	20172018
19	17	2011111	20172018
20	17	2011112	20172018
21	18	2011111	20172018
22	18	2011112	20172018
\.


--
-- Data for Name: organizationnature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationnature (id, name, acronym) FROM stdin;
1	Special Interest	SPIN
2	Professional Organization	PROF
3	Socio-civic and Religious	SCORE
4	Professional Organization Group	PROG
\.


--
-- Data for Name: organizationofficer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationofficer (idnumber, role, yearid, dateassigned, isactive) FROM stdin;
1111111	10023	20172018	2018-01-10 23:03:08.913856+08	t
1111112	10026	20172018	2018-01-10 23:03:08.913856+08	t
1111113	10027	20172018	2018-01-10 23:03:08.913856+08	t
1111114	10028	20172018	2018-01-10 23:03:08.913856+08	t
1111115	10029	20172018	2018-01-10 23:03:08.913856+08	t
1111116	10030	20172018	2018-01-10 23:03:08.913856+08	t
2111111	380356	20172018	2018-01-10 23:03:08.913856+08	t
2111112	380359	20172018	2018-01-10 23:03:08.913856+08	t
2111113	380360	20172018	2018-01-10 23:03:08.913856+08	t
2111114	380361	20172018	2018-01-10 23:03:08.913856+08	t
2111115	380362	20172018	2018-01-10 23:03:08.913856+08	t
2111116	380363	20172018	2018-01-10 23:03:08.913856+08	t
3111111	100104	20172018	2018-01-10 23:03:08.913856+08	t
3111112	100107	20172018	2018-01-10 23:03:08.913856+08	t
3111113	100108	20172018	2018-01-10 23:03:08.913856+08	t
3111114	100109	20172018	2018-01-10 23:03:08.913856+08	t
3111115	100110	20172018	2018-01-10 23:03:08.913856+08	t
3111116	100111	20172018	2018-01-10 23:03:08.913856+08	t
4111111	110113	20172018	2018-01-10 23:03:08.913856+08	t
4111112	110116	20172018	2018-01-10 23:03:08.913856+08	t
4111113	110117	20172018	2018-01-10 23:03:08.913856+08	t
4111114	110118	20172018	2018-01-10 23:03:08.913856+08	t
4111115	110119	20172018	2018-01-10 23:03:08.913856+08	t
4111116	110120	20172018	2018-01-10 23:03:08.913856+08	t
5111111	120122	20172018	2018-01-10 23:03:08.913856+08	t
5111112	120125	20172018	2018-01-10 23:03:08.913856+08	t
5111113	120126	20172018	2018-01-10 23:03:08.913856+08	t
5111114	120127	20172018	2018-01-10 23:03:08.913856+08	t
5111115	120128	20172018	2018-01-10 23:03:08.913856+08	t
5111116	120129	20172018	2018-01-10 23:03:08.913856+08	t
6111111	130131	20172018	2018-01-10 23:03:08.913856+08	t
6111112	130134	20172018	2018-01-10 23:03:08.913856+08	t
6111113	130135	20172018	2018-01-10 23:03:08.913856+08	t
6111114	130136	20172018	2018-01-10 23:03:08.913856+08	t
6111115	130137	20172018	2018-01-10 23:03:08.913856+08	t
6111116	130138	20172018	2018-01-10 23:03:08.913856+08	t
7111111	140140	20172018	2018-01-10 23:03:08.913856+08	t
7111112	140143	20172018	2018-01-10 23:03:08.913856+08	t
7111113	140144	20172018	2018-01-10 23:03:08.913856+08	t
7111114	140145	20172018	2018-01-10 23:03:08.913856+08	t
7111115	140146	20172018	2018-01-10 23:03:08.913856+08	t
7111116	140147	20172018	2018-01-10 23:03:08.913856+08	t
8111111	150149	20172018	2018-01-10 23:03:08.913856+08	t
8111112	150152	20172018	2018-01-10 23:03:08.913856+08	t
8111113	150153	20172018	2018-01-10 23:03:08.913856+08	t
8111114	150154	20172018	2018-01-10 23:03:08.913856+08	t
8111115	150155	20172018	2018-01-10 23:03:08.913856+08	t
8111116	150156	20172018	2018-01-10 23:03:08.913856+08	t
9111111	160158	20172018	2018-01-10 23:03:08.913856+08	t
9111112	160161	20172018	2018-01-10 23:03:08.913856+08	t
9111113	160162	20172018	2018-01-10 23:03:08.913856+08	t
9111114	160163	20172018	2018-01-10 23:03:08.913856+08	t
9111115	160164	20172018	2018-01-10 23:03:08.913856+08	t
9111116	160165	20172018	2018-01-10 23:03:08.913856+08	t
10111111	170167	20172018	2018-01-10 23:03:08.913856+08	t
10111112	170170	20172018	2018-01-10 23:03:08.913856+08	t
10111113	170171	20172018	2018-01-10 23:03:08.913856+08	t
10111114	170172	20172018	2018-01-10 23:03:08.913856+08	t
10111115	170173	20172018	2018-01-10 23:03:08.913856+08	t
10111116	170174	20172018	2018-01-10 23:03:08.913856+08	t
11111111	180176	20172018	2018-01-10 23:03:08.913856+08	t
11111112	180179	20172018	2018-01-10 23:03:08.913856+08	t
11111113	180180	20172018	2018-01-10 23:03:08.913856+08	t
11111114	180181	20172018	2018-01-10 23:03:08.913856+08	t
11111115	180182	20172018	2018-01-10 23:03:08.913856+08	t
11111116	180183	20172018	2018-01-10 23:03:08.913856+08	t
1011117	0	20172018	2018-01-10 23:03:08.913856+08	t
1011118	2	20172018	2018-01-10 23:03:08.913856+08	t
1011119	11	20172018	2018-01-10 23:03:08.913856+08	t
1011120	12	20172018	2018-01-10 23:03:08.913856+08	t
1011121	13	20172018	2018-01-10 23:03:08.913856+08	t
1011122	14	20172018	2018-01-10 23:03:08.913856+08	t
1011123	15	20172018	2018-01-10 23:03:08.913856+08	t
1011124	16	20172018	2018-01-10 23:03:08.913856+08	t
1011125	17	20172018	2018-01-10 23:03:08.913856+08	t
1011126	18	20172018	2018-01-10 23:03:08.913856+08	t
1011127	19	20172018	2018-01-10 23:03:08.913856+08	t
1011128	10	20172018	2018-01-10 23:03:08.913856+08	t
1011129	21	20172018	2018-01-10 23:03:08.913856+08	t
1011130	22	20172018	2018-01-10 23:03:08.913856+08	t
1011131	8	20172018	2018-01-10 23:03:08.913856+08	t
1011132	9	20172018	2018-01-10 23:03:08.913856+08	t
1011133	10	20172018	2018-01-10 23:03:08.913856+08	t
1011134	5	20172018	2018-01-10 23:03:08.913856+08	t
1011135	6	20172018	2018-01-10 23:03:08.913856+08	t
1011136	7	20172018	2018-01-10 23:03:08.913856+08	t
\.


--
-- Data for Name: organizationrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationrole (id, organization, sequence, name, shortname, rank, uniqueposition, masterrole, home_url) FROM stdin;
0	0	1	Chairperson	Chair	0	t	\N	/CSO/home
1	0	2	Executive Vice Chairperson for Internals	EVC - Interals	10	t	0	/CSO/home
2	0	3	Executive Vice Chairperson for Externals	EVC - Externals	10	t	0	/CSO/home
3	0	4	Executive Vice Chairperson for Activities and Documentations	EVC - AND	10	t	0	/CSO/home
4	0	5	Executive Vice Chairperson for Finance	EVC - Finance	10	t	0	/CSO/home
5	0	6	Vice Chairperson for Activity Documentations and Management	VC - AND	20	t	2	/ADM/main
6	0	7	Associate Vice Chairperson for Activity Documentations and Management	AVC - AND	30	f	5	/ADM/main
7	0	8	Associate for Activity Documentations and Management	AVC - AND	40	f	6	/ADM/main
8	0	9	Vice Chairperson for Activity Monitoring Team	VC - AMT	20	t	2	/AMT/AMTHome
9	0	10	Associate Vice Chairperson for Activity Monitoring Team	AVC - AMT	30	f	9	/AMT/AMTHome
10	0	11	Associate for Activity Monitoring Team	A - AMT	40	f	10	/AMT/AMTHome
11	0	12	Vice Chairperson for Activity Processing and Screening	VC - APS	20	t	2	/APS/home
12	0	13	Associate Vice Chairperson for Activity Processing and Screening	AVC - APS	30	f	11	/APS/home
13	0	14	Associate Activity Processing and Screening	A - APS	40	f	12	/APS/home
14	0	15	Vice Chairperson for Finance	VC - Finance	20	t	2	\N
15	0	16	Associate Vice Chairperson for Finance	AVC - Finance	30	f	14	\N
16	0	17	Associate for Finance	A - Finance	40	f	15	\N
17	0	18	Vice Chairperson for Publicity and Productions	VC - PNP	20	t	3	/PNP/main
18	0	19	Associate Vice Chairperson for Publicity and Productions	AVC - PNP	30	f	18	/PNP/main
19	0	20	Associate for Publicity and Productions	A - PNP	40	f	19	/PNP/main
20	0	21	Vice Chairperson for Organizational Research and Analysis	VC - OrgRes	20	t	2	/ORGRES/viewHome
21	0	22	Associate Vice Chairperson for Organizational Research and Analysis	AVC - OrgRes	30	f	21	/ORGRES/viewHome
22	0	23	Associate for Organizational Research and Analysis	A - OrgRes	40	f	22	/ORGRES/viewHome
10023	1	1	President	P	0	t	\N	\N
10024	1	2	Executive Secretariat	ES	10	t	10023	\N
10025	1	3	External Executive Vice President	E-EVP	10	t	10023	\N
10026	1	4	Internal Executive Vice President	I-EVP	10	t	10023	\N
10027	1	5	Vice President of Documentations	VP-D	20	t	10024	\N
10028	1	6	Associate Vice President of Documentations	AVP-D	30	f	10027	\N
10029	1	7	Vice President of Finance	VP-F	20	t	10026	\N
10030	1	8	Associate Vice President of Finance	AVP-F	30	f	10029	\N
10031	1	9	Junior Officer	JO	40	f	\N	\N
20032	2	1	President	P	0	t	\N	\N
20033	2	2	Executive Secretariat	ES	10	t	20032	\N
20034	2	3	External Executive Vice President	E-EVP	10	t	20032	\N
20035	2	4	Internal Executive Vice President	I-EVP	10	t	20032	\N
20036	2	5	Vice President of Documentations	VP-D	20	t	20033	\N
20037	2	6	Associate Vice President of Documentations	AVP-D	30	f	20036	\N
20038	2	7	Vice President of Finance	VP-F	20	t	20035	\N
20039	2	8	Associate Vice President of Finance	AVP-F	30	f	20038	\N
20040	2	9	Junior Officer	JO	40	f	\N	\N
30041	3	1	President	P	0	t	\N	\N
30042	3	2	Executive Secretariat	ES	10	t	30041	\N
30043	3	3	External Executive Vice President	E-EVP	10	t	30041	\N
30044	3	4	Internal Executive Vice President	I-EVP	10	t	30041	\N
30045	3	5	Vice President of Documentations	VP-D	20	t	30042	\N
30046	3	6	Associate Vice President of Documentations	AVP-D	30	f	30045	\N
30047	3	7	Vice President of Finance	VP-F	20	t	30044	\N
30048	3	8	Associate Vice President of Finance	AVP-F	30	f	30047	\N
30049	3	9	Junior Officer	JO	40	f	\N	\N
40050	4	1	President	P	0	t	\N	\N
40051	4	2	Executive Secretariat	ES	10	t	40050	\N
40052	4	3	External Executive Vice President	E-EVP	10	t	40050	\N
40053	4	4	Internal Executive Vice President	I-EVP	10	t	40050	\N
40054	4	5	Vice President of Documentations	VP-D	20	t	40051	\N
40055	4	6	Associate Vice President of Documentations	AVP-D	30	f	40054	\N
40056	4	7	Vice President of Finance	VP-F	20	t	40053	\N
40057	4	8	Associate Vice President of Finance	AVP-F	30	f	40056	\N
40058	4	9	Junior Officer	JO	40	f	\N	\N
50059	5	1	President	P	0	t	\N	\N
50060	5	2	Executive Secretariat	ES	10	t	50059	\N
50061	5	3	External Executive Vice President	E-EVP	10	t	50059	\N
50062	5	4	Internal Executive Vice President	I-EVP	10	t	50059	\N
50063	5	5	Vice President of Documentations	VP-D	20	t	50060	\N
50064	5	6	Associate Vice President of Documentations	AVP-D	30	f	50063	\N
50065	5	7	Vice President of Finance	VP-F	20	t	50062	\N
50066	5	8	Associate Vice President of Finance	AVP-F	30	f	50065	\N
50067	5	9	Junior Officer	JO	40	f	\N	\N
60068	6	1	President	P	0	t	\N	\N
60069	6	2	Executive Secretariat	ES	10	t	60068	\N
60070	6	3	External Executive Vice President	E-EVP	10	t	60068	\N
60071	6	4	Internal Executive Vice President	I-EVP	10	t	60068	\N
60072	6	5	Vice President of Documentations	VP-D	20	t	60069	\N
60073	6	6	Associate Vice President of Documentations	AVP-D	30	f	60072	\N
60074	6	7	Vice President of Finance	VP-F	20	t	60071	\N
60075	6	8	Associate Vice President of Finance	AVP-F	30	f	60074	\N
60076	6	9	Junior Officer	JO	40	f	\N	\N
70077	7	1	President	P	0	t	\N	\N
70078	7	2	Executive Secretariat	ES	10	t	70077	\N
70079	7	3	External Executive Vice President	E-EVP	10	t	70077	\N
70080	7	4	Internal Executive Vice President	I-EVP	10	t	70077	\N
70081	7	5	Vice President of Documentations	VP-D	20	t	70078	\N
70082	7	6	Associate Vice President of Documentations	AVP-D	30	f	70081	\N
70083	7	7	Vice President of Finance	VP-F	20	t	70080	\N
70084	7	8	Associate Vice President of Finance	AVP-F	30	f	70083	\N
70085	7	9	Junior Officer	JO	40	f	\N	\N
80086	8	1	President	P	0	t	\N	\N
80087	8	2	Executive Secretariat	ES	10	t	80086	\N
80088	8	3	External Executive Vice President	E-EVP	10	t	80086	\N
80089	8	4	Internal Executive Vice President	I-EVP	10	t	80086	\N
80090	8	5	Vice President of Documentations	VP-D	20	t	80087	\N
80091	8	6	Associate Vice President of Documentations	AVP-D	30	f	80090	\N
80092	8	7	Vice President of Finance	VP-F	20	t	80089	\N
80093	8	8	Associate Vice President of Finance	AVP-F	30	f	80092	\N
80094	8	9	Junior Officer	JO	40	f	\N	\N
90095	9	1	President	P	0	t	\N	\N
90096	9	2	Executive Secretariat	ES	10	t	90095	\N
90097	9	3	External Executive Vice President	E-EVP	10	t	90095	\N
90098	9	4	Internal Executive Vice President	I-EVP	10	t	90095	\N
90099	9	5	Vice President of Documentations	VP-D	20	t	90096	\N
90100	9	6	Associate Vice President of Documentations	AVP-D	30	f	90099	\N
90101	9	7	Vice President of Finance	VP-F	20	t	90098	\N
90102	9	8	Associate Vice President of Finance	AVP-F	30	f	90101	\N
90103	9	9	Junior Officer	JO	40	f	\N	\N
100104	10	1	President	P	0	t	\N	\N
100105	10	2	Executive Secretariat	ES	10	t	100104	\N
100106	10	3	External Executive Vice President	E-EVP	10	t	100104	\N
100107	10	4	Internal Executive Vice President	I-EVP	10	t	100104	\N
100108	10	5	Vice President of Documentations	VP-D	20	t	100105	\N
100109	10	6	Associate Vice President of Documentations	AVP-D	30	f	100108	\N
100110	10	7	Vice President of Finance	VP-F	20	t	100107	\N
100111	10	8	Associate Vice President of Finance	AVP-F	30	f	100110	\N
100112	10	9	Junior Officer	JO	40	f	\N	\N
110113	11	1	President	P	0	t	\N	\N
110114	11	2	Executive Secretariat	ES	10	t	110113	\N
110115	11	3	External Executive Vice President	E-EVP	10	t	110113	\N
110116	11	4	Internal Executive Vice President	I-EVP	10	t	110113	\N
110117	11	5	Vice President of Documentations	VP-D	20	t	110114	\N
110118	11	6	Associate Vice President of Documentations	AVP-D	30	f	110117	\N
110119	11	7	Vice President of Finance	VP-F	20	t	110116	\N
110120	11	8	Associate Vice President of Finance	AVP-F	30	f	110119	\N
110121	11	9	Junior Officer	JO	40	f	\N	\N
120122	12	1	President	P	0	t	\N	\N
120123	12	2	Executive Secretariat	ES	10	t	120122	\N
120124	12	3	External Executive Vice President	E-EVP	10	t	120122	\N
120125	12	4	Internal Executive Vice President	I-EVP	10	t	120122	\N
120126	12	5	Vice President of Documentations	VP-D	20	t	120123	\N
120127	12	6	Associate Vice President of Documentations	AVP-D	30	f	120126	\N
120128	12	7	Vice President of Finance	VP-F	20	t	120125	\N
120129	12	8	Associate Vice President of Finance	AVP-F	30	f	120128	\N
120130	12	9	Junior Officer	JO	40	f	\N	\N
130131	13	1	President	P	0	t	\N	\N
130132	13	2	Executive Secretariat	ES	10	t	130131	\N
130133	13	3	External Executive Vice President	E-EVP	10	t	130131	\N
130134	13	4	Internal Executive Vice President	I-EVP	10	t	130131	\N
130135	13	5	Vice President of Documentations	VP-D	20	t	130132	\N
130136	13	6	Associate Vice President of Documentations	AVP-D	30	f	130135	\N
130137	13	7	Vice President of Finance	VP-F	20	t	130134	\N
130138	13	8	Associate Vice President of Finance	AVP-F	30	f	130137	\N
130139	13	9	Junior Officer	JO	40	f	\N	\N
140140	14	1	President	P	0	t	\N	\N
140141	14	2	Executive Secretariat	ES	10	t	140140	\N
140142	14	3	External Executive Vice President	E-EVP	10	t	140140	\N
140143	14	4	Internal Executive Vice President	I-EVP	10	t	140140	\N
140144	14	5	Vice President of Documentations	VP-D	20	t	140141	\N
140145	14	6	Associate Vice President of Documentations	AVP-D	30	f	140144	\N
140146	14	7	Vice President of Finance	VP-F	20	t	140143	\N
140147	14	8	Associate Vice President of Finance	AVP-F	30	f	140146	\N
140148	14	9	Junior Officer	JO	40	f	\N	\N
150149	15	1	President	P	0	t	\N	\N
150150	15	2	Executive Secretariat	ES	10	t	150149	\N
150151	15	3	External Executive Vice President	E-EVP	10	t	150149	\N
150152	15	4	Internal Executive Vice President	I-EVP	10	t	150149	\N
150153	15	5	Vice President of Documentations	VP-D	20	t	150150	\N
150154	15	6	Associate Vice President of Documentations	AVP-D	30	f	150153	\N
150155	15	7	Vice President of Finance	VP-F	20	t	150152	\N
150156	15	8	Associate Vice President of Finance	AVP-F	30	f	150155	\N
150157	15	9	Junior Officer	JO	40	f	\N	\N
160158	16	1	President	P	0	t	\N	\N
160159	16	2	Executive Secretariat	ES	10	t	160158	\N
160160	16	3	External Executive Vice President	E-EVP	10	t	160158	\N
160161	16	4	Internal Executive Vice President	I-EVP	10	t	160158	\N
160162	16	5	Vice President of Documentations	VP-D	20	t	160159	\N
260249	26	2	Executive Secretariat	ES	10	t	260248	\N
160163	16	6	Associate Vice President of Documentations	AVP-D	30	f	160162	\N
160164	16	7	Vice President of Finance	VP-F	20	t	160161	\N
160165	16	8	Associate Vice President of Finance	AVP-F	30	f	160164	\N
160166	16	9	Junior Officer	JO	40	f	\N	\N
170167	17	1	President	P	0	t	\N	\N
170168	17	2	Executive Secretariat	ES	10	t	170167	\N
170169	17	3	External Executive Vice President	E-EVP	10	t	170167	\N
170170	17	4	Internal Executive Vice President	I-EVP	10	t	170167	\N
170171	17	5	Vice President of Documentations	VP-D	20	t	170168	\N
170172	17	6	Associate Vice President of Documentations	AVP-D	30	f	170171	\N
170173	17	7	Vice President of Finance	VP-F	20	t	170170	\N
170174	17	8	Associate Vice President of Finance	AVP-F	30	f	170173	\N
170175	17	9	Junior Officer	JO	40	f	\N	\N
180176	18	1	President	P	0	t	\N	\N
180177	18	2	Executive Secretariat	ES	10	t	180176	\N
180178	18	3	External Executive Vice President	E-EVP	10	t	180176	\N
180179	18	4	Internal Executive Vice President	I-EVP	10	t	180176	\N
180180	18	5	Vice President of Documentations	VP-D	20	t	180177	\N
180181	18	6	Associate Vice President of Documentations	AVP-D	30	f	180180	\N
180182	18	7	Vice President of Finance	VP-F	20	t	180179	\N
180183	18	8	Associate Vice President of Finance	AVP-F	30	f	180182	\N
180184	18	9	Junior Officer	JO	40	f	\N	\N
190185	19	1	President	P	0	t	\N	\N
190186	19	2	Executive Secretariat	ES	10	t	190185	\N
190187	19	3	External Executive Vice President	E-EVP	10	t	190185	\N
190188	19	4	Internal Executive Vice President	I-EVP	10	t	190185	\N
190189	19	5	Vice President of Documentations	VP-D	20	t	190186	\N
190190	19	6	Associate Vice President of Documentations	AVP-D	30	f	190189	\N
190191	19	7	Vice President of Finance	VP-F	20	t	190188	\N
190192	19	8	Associate Vice President of Finance	AVP-F	30	f	190191	\N
190193	19	9	Junior Officer	JO	40	f	\N	\N
200194	20	1	President	P	0	t	\N	\N
200195	20	2	Executive Secretariat	ES	10	t	200194	\N
200196	20	3	External Executive Vice President	E-EVP	10	t	200194	\N
200197	20	4	Internal Executive Vice President	I-EVP	10	t	200194	\N
200198	20	5	Vice President of Documentations	VP-D	20	t	200195	\N
200199	20	6	Associate Vice President of Documentations	AVP-D	30	f	200198	\N
200200	20	7	Vice President of Finance	VP-F	20	t	200197	\N
200201	20	8	Associate Vice President of Finance	AVP-F	30	f	200200	\N
200202	20	9	Junior Officer	JO	40	f	\N	\N
210203	21	1	President	P	0	t	\N	\N
210204	21	2	Executive Secretariat	ES	10	t	210203	\N
210205	21	3	External Executive Vice President	E-EVP	10	t	210203	\N
210206	21	4	Internal Executive Vice President	I-EVP	10	t	210203	\N
210207	21	5	Vice President of Documentations	VP-D	20	t	210204	\N
210208	21	6	Associate Vice President of Documentations	AVP-D	30	f	210207	\N
210209	21	7	Vice President of Finance	VP-F	20	t	210206	\N
210210	21	8	Associate Vice President of Finance	AVP-F	30	f	210209	\N
210211	21	9	Junior Officer	JO	40	f	\N	\N
220212	22	1	President	P	0	t	\N	\N
220213	22	2	Executive Secretariat	ES	10	t	220212	\N
220214	22	3	External Executive Vice President	E-EVP	10	t	220212	\N
220215	22	4	Internal Executive Vice President	I-EVP	10	t	220212	\N
220216	22	5	Vice President of Documentations	VP-D	20	t	220213	\N
220217	22	6	Associate Vice President of Documentations	AVP-D	30	f	220216	\N
220218	22	7	Vice President of Finance	VP-F	20	t	220215	\N
220219	22	8	Associate Vice President of Finance	AVP-F	30	f	220218	\N
220220	22	9	Junior Officer	JO	40	f	\N	\N
230221	23	1	President	P	0	t	\N	\N
230222	23	2	Executive Secretariat	ES	10	t	230221	\N
230223	23	3	External Executive Vice President	E-EVP	10	t	230221	\N
230224	23	4	Internal Executive Vice President	I-EVP	10	t	230221	\N
230225	23	5	Vice President of Documentations	VP-D	20	t	230222	\N
230226	23	6	Associate Vice President of Documentations	AVP-D	30	f	230225	\N
230227	23	7	Vice President of Finance	VP-F	20	t	230224	\N
230228	23	8	Associate Vice President of Finance	AVP-F	30	f	230227	\N
230229	23	9	Junior Officer	JO	40	f	\N	\N
240230	24	1	President	P	0	t	\N	\N
240231	24	2	Executive Secretariat	ES	10	t	240230	\N
240232	24	3	External Executive Vice President	E-EVP	10	t	240230	\N
240233	24	4	Internal Executive Vice President	I-EVP	10	t	240230	\N
240234	24	5	Vice President of Documentations	VP-D	20	t	240231	\N
240235	24	6	Associate Vice President of Documentations	AVP-D	30	f	240234	\N
240236	24	7	Vice President of Finance	VP-F	20	t	240233	\N
240237	24	8	Associate Vice President of Finance	AVP-F	30	f	240236	\N
240238	24	9	Junior Officer	JO	40	f	\N	\N
250239	25	1	President	P	0	t	\N	\N
250240	25	2	Executive Secretariat	ES	10	t	250239	\N
250241	25	3	External Executive Vice President	E-EVP	10	t	250239	\N
250242	25	4	Internal Executive Vice President	I-EVP	10	t	250239	\N
250243	25	5	Vice President of Documentations	VP-D	20	t	250240	\N
250244	25	6	Associate Vice President of Documentations	AVP-D	30	f	250243	\N
250245	25	7	Vice President of Finance	VP-F	20	t	250242	\N
250246	25	8	Associate Vice President of Finance	AVP-F	30	f	250245	\N
250247	25	9	Junior Officer	JO	40	f	\N	\N
260248	26	1	President	P	0	t	\N	\N
260250	26	3	External Executive Vice President	E-EVP	10	t	260248	\N
260251	26	4	Internal Executive Vice President	I-EVP	10	t	260248	\N
260252	26	5	Vice President of Documentations	VP-D	20	t	260249	\N
260253	26	6	Associate Vice President of Documentations	AVP-D	30	f	260252	\N
260254	26	7	Vice President of Finance	VP-F	20	t	260251	\N
260255	26	8	Associate Vice President of Finance	AVP-F	30	f	260254	\N
260256	26	9	Junior Officer	JO	40	f	\N	\N
270257	27	1	President	P	0	t	\N	\N
270258	27	2	Executive Secretariat	ES	10	t	270257	\N
270259	27	3	External Executive Vice President	E-EVP	10	t	270257	\N
270260	27	4	Internal Executive Vice President	I-EVP	10	t	270257	\N
270261	27	5	Vice President of Documentations	VP-D	20	t	270258	\N
270262	27	6	Associate Vice President of Documentations	AVP-D	30	f	270261	\N
270263	27	7	Vice President of Finance	VP-F	20	t	270260	\N
270264	27	8	Associate Vice President of Finance	AVP-F	30	f	270263	\N
270265	27	9	Junior Officer	JO	40	f	\N	\N
280266	28	1	President	P	0	t	\N	\N
280267	28	2	Executive Secretariat	ES	10	t	280266	\N
280268	28	3	External Executive Vice President	E-EVP	10	t	280266	\N
280269	28	4	Internal Executive Vice President	I-EVP	10	t	280266	\N
280270	28	5	Vice President of Documentations	VP-D	20	t	280267	\N
280271	28	6	Associate Vice President of Documentations	AVP-D	30	f	280270	\N
280272	28	7	Vice President of Finance	VP-F	20	t	280269	\N
280273	28	8	Associate Vice President of Finance	AVP-F	30	f	280272	\N
280274	28	9	Junior Officer	JO	40	f	\N	\N
290275	29	1	President	P	0	t	\N	\N
290276	29	2	Executive Secretariat	ES	10	t	290275	\N
290277	29	3	External Executive Vice President	E-EVP	10	t	290275	\N
290278	29	4	Internal Executive Vice President	I-EVP	10	t	290275	\N
290279	29	5	Vice President of Documentations	VP-D	20	t	290276	\N
290280	29	6	Associate Vice President of Documentations	AVP-D	30	f	290279	\N
290281	29	7	Vice President of Finance	VP-F	20	t	290278	\N
290282	29	8	Associate Vice President of Finance	AVP-F	30	f	290281	\N
290283	29	9	Junior Officer	JO	40	f	\N	\N
300284	30	1	President	P	0	t	\N	\N
300285	30	2	Executive Secretariat	ES	10	t	300284	\N
300286	30	3	External Executive Vice President	E-EVP	10	t	300284	\N
300287	30	4	Internal Executive Vice President	I-EVP	10	t	300284	\N
300288	30	5	Vice President of Documentations	VP-D	20	t	300285	\N
300289	30	6	Associate Vice President of Documentations	AVP-D	30	f	300288	\N
300290	30	7	Vice President of Finance	VP-F	20	t	300287	\N
300291	30	8	Associate Vice President of Finance	AVP-F	30	f	300290	\N
300292	30	9	Junior Officer	JO	40	f	\N	\N
310293	31	1	President	P	0	t	\N	\N
310294	31	2	Executive Secretariat	ES	10	t	310293	\N
310295	31	3	External Executive Vice President	E-EVP	10	t	310293	\N
310296	31	4	Internal Executive Vice President	I-EVP	10	t	310293	\N
310297	31	5	Vice President of Documentations	VP-D	20	t	310294	\N
310298	31	6	Associate Vice President of Documentations	AVP-D	30	f	310297	\N
310299	31	7	Vice President of Finance	VP-F	20	t	310296	\N
310300	31	8	Associate Vice President of Finance	AVP-F	30	f	310299	\N
310301	31	9	Junior Officer	JO	40	f	\N	\N
320302	32	1	President	P	0	t	\N	\N
320303	32	2	Executive Secretariat	ES	10	t	320302	\N
320304	32	3	External Executive Vice President	E-EVP	10	t	320302	\N
320305	32	4	Internal Executive Vice President	I-EVP	10	t	320302	\N
320306	32	5	Vice President of Documentations	VP-D	20	t	320303	\N
320307	32	6	Associate Vice President of Documentations	AVP-D	30	f	320306	\N
320308	32	7	Vice President of Finance	VP-F	20	t	320305	\N
320309	32	8	Associate Vice President of Finance	AVP-F	30	f	320308	\N
320310	32	9	Junior Officer	JO	40	f	\N	\N
330311	33	1	President	P	0	t	\N	\N
330312	33	2	Executive Secretariat	ES	10	t	330311	\N
330313	33	3	External Executive Vice President	E-EVP	10	t	330311	\N
330314	33	4	Internal Executive Vice President	I-EVP	10	t	330311	\N
330315	33	5	Vice President of Documentations	VP-D	20	t	330312	\N
330316	33	6	Associate Vice President of Documentations	AVP-D	30	f	330315	\N
330317	33	7	Vice President of Finance	VP-F	20	t	330314	\N
330318	33	8	Associate Vice President of Finance	AVP-F	30	f	330317	\N
330319	33	9	Junior Officer	JO	40	f	\N	\N
340320	34	1	President	P	0	t	\N	\N
340321	34	2	Executive Secretariat	ES	10	t	340320	\N
340322	34	3	External Executive Vice President	E-EVP	10	t	340320	\N
340323	34	4	Internal Executive Vice President	I-EVP	10	t	340320	\N
340324	34	5	Vice President of Documentations	VP-D	20	t	340321	\N
340325	34	6	Associate Vice President of Documentations	AVP-D	30	f	340324	\N
340326	34	7	Vice President of Finance	VP-F	20	t	340323	\N
340327	34	8	Associate Vice President of Finance	AVP-F	30	f	340326	\N
340328	34	9	Junior Officer	JO	40	f	\N	\N
350329	35	1	President	P	0	t	\N	\N
350330	35	2	Executive Secretariat	ES	10	t	350329	\N
350331	35	3	External Executive Vice President	E-EVP	10	t	350329	\N
350332	35	4	Internal Executive Vice President	I-EVP	10	t	350329	\N
350333	35	5	Vice President of Documentations	VP-D	20	t	350330	\N
350334	35	6	Associate Vice President of Documentations	AVP-D	30	f	350333	\N
350335	35	7	Vice President of Finance	VP-F	20	t	350332	\N
350336	35	8	Associate Vice President of Finance	AVP-F	30	f	350335	\N
350337	35	9	Junior Officer	JO	40	f	\N	\N
360338	36	1	President	P	0	t	\N	\N
360339	36	2	Executive Secretariat	ES	10	t	360338	\N
360340	36	3	External Executive Vice President	E-EVP	10	t	360338	\N
360341	36	4	Internal Executive Vice President	I-EVP	10	t	360338	\N
360342	36	5	Vice President of Documentations	VP-D	20	t	360339	\N
360343	36	6	Associate Vice President of Documentations	AVP-D	30	f	360342	\N
360344	36	7	Vice President of Finance	VP-F	20	t	360341	\N
360345	36	8	Associate Vice President of Finance	AVP-F	30	f	360344	\N
360346	36	9	Junior Officer	JO	40	f	\N	\N
370347	37	1	President	P	0	t	\N	\N
370348	37	2	Executive Secretariat	ES	10	t	370347	\N
370349	37	3	External Executive Vice President	E-EVP	10	t	370347	\N
370350	37	4	Internal Executive Vice President	I-EVP	10	t	370347	\N
370351	37	5	Vice President of Documentations	VP-D	20	t	370348	\N
370352	37	6	Associate Vice President of Documentations	AVP-D	30	f	370351	\N
370353	37	7	Vice President of Finance	VP-F	20	t	370350	\N
370354	37	8	Associate Vice President of Finance	AVP-F	30	f	370353	\N
370355	37	9	Junior Officer	JO	40	f	\N	\N
380356	38	1	President	P	0	t	\N	\N
380357	38	2	Executive Secretariat	ES	10	t	380356	\N
380358	38	3	External Executive Vice President	E-EVP	10	t	380356	\N
380359	38	4	Internal Executive Vice President	I-EVP	10	t	380356	\N
380360	38	5	Vice President of Documentations	VP-D	20	t	380357	\N
380361	38	6	Associate Vice President of Documentations	AVP-D	30	f	380360	\N
380362	38	7	Vice President of Finance	VP-F	20	t	380359	\N
380363	38	8	Associate Vice President of Finance	AVP-F	30	f	380362	\N
380364	38	9	Junior Officer	JO	40	f	\N	\N
\.


--
-- Data for Name: organizationstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizationstatus (id, name) FROM stdin;
0	Active
1	Suspended
3	Dissolved
\.


--
-- Data for Name: postactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.postactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Data for Name: preactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.preactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
1	0	0	f
2	0	1	f
3	0	3	f
4	1	2	f
5	1	3	f
6	2	3	f
7	3	3	f
8	3	4	f
9	4	3	f
10	4	5	f
11	5	3	f
12	5	6	f
13	6	3	f
14	6	7	t
15	7	3	f
16	7	8	f
17	7	0	f
18	8	3	f
19	9	3	f
\.


--
-- Data for Name: projectproposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposal (id, gosmactivity, status, enp, enmp, actualdatestart, actualdateend, venue, context1, context2, context3, isexpense, sourcefundother, sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, accumulateddepositoryfunds, organizationfundothersource, comments, preparedby, facultyadviser, datecreated, datesubmitted, datestatusmodified, isattachmentscomplete, isbriefcontextcomplete, isexpensecomplete, isprogramcomplete, reschedulereason, reschedreasonother, rescheduledates, reschedrejectreason, timespended, venuefilename, venuefilenametoshow, venuecreated) FROM stdin;
14	27	2	25	21	2018-02-15	2018-02-15	2	La Sallians are ignorant of going green	Because of socio-economic problems	The very best I can do	t	0.00	0.00	30.00	0.00	308400.00	0.00	\N	7111114	2011112	2018-01-10 21:54:00.231019+08	2018-01-10 22:00:41.2196+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
6	65	2	23	20	2018-02-14	2018-02-14	0	Students do not know the basics of Corporate Social Responsibility.	There is a problem because CSR is important with the proper functioning of organizations. By knowing the basics of CSR, participants will discover and realize the practical applications of CSR.	The project heads will be giving their undivided attention towards the completion of this project.	t	0.00	0.00	3500.00	0.00	343854.00	0.00	\N	10111114	2011111	2018-01-10 21:13:59.13507+08	2018-01-10 21:47:44.190732+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
16	2	2	10	10	2018-01-26	2018-01-26	0	Insufficient nook supplies	Org people need those	seminar	t	0.00	0.00	1000.00	0.00	337467.00	0.00	\N	1111114	2011111	2018-01-10 21:58:09.071952+08	2018-01-10 21:59:38.469082+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
10	30	2	10	10	2018-01-16	2018-01-16	0	They dont know how to use firebase	they can doo better	seminar	t	0.00	0.00	190.00	0.00	340657.00	0.00	\N	1111114	2011111	2018-01-10 21:48:46.998234+08	2018-01-10 21:50:15.86212+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
5	21	2	10	10	2018-02-15	2018-02-15	0	they lack c# skills	the more they know the better	seminar	t	0.00	0.00	1900.00	0.00	342557.00	0.00	\N	1111114	2011111	2018-01-10 20:59:45.854887+08	2018-01-10 21:48:44.077825+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
13	11	2	15	15	2018-02-02	2018-02-02	49	The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\r\n	There are always problems in terms of visualizing an idea or translating a message through a picture\r\n	This activity will teach the participants of the basics of Photoshop	t	0.00	0.00	2700.00	0.00	310644.00	0.00	\N	4111114	2011111	2018-01-10 21:53:30.591264+08	2018-01-10 21:58:54.062857+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
18	3	2	20	5	2018-01-11	2018-01-11	0	The lack of functioning members of society	Possibly ignorance	The very best that I have	t	0.00	0.00	1005.00	0.00	308370.00	0.00	\N	7111114	2011111	2018-01-10 22:01:53.151819+08	2018-01-10 22:29:17.011505+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
11	31	2	10	10	2018-02-18	2018-02-18	0	they need to be aware of the current trends	they can do better	convention	t	0.00	0.00	1000.00	0.00	340467.00	0.00	\N	1111114	2011111	2018-01-10 21:51:00.620963+08	2018-01-10 21:52:35.744671+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
12	1	2	10	10	2018-01-18	2018-01-18	0	They dont know what they want to become	time is being wasted	seminar	t	0.00	0.00	1000.00	0.00	339467.00	0.00	\N	1111114	2011111	2018-01-10 21:52:51.943583+08	2018-01-10 21:55:28.20484+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
7	7	2	20	20	2018-01-26	2018-01-26	25	The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.	There are always problems in terms of visualizing an idea or translating a message through a picture	This activity will teach the participants of the basics of Photoshop	t	0.00	0.00	3100.00	0.00	313744.00	0.00	\N	4111114	2011112	2018-01-10 21:22:23.57137+08	2018-01-10 21:53:13.013545+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
1	8	3	10	10	2018-02-02	2018-02-02	0	Inconsistent data	They dont collect data properly	Seminar	t	0.00	0.00	10.00	0.00	345567.00	0.00	\N	1111114	2011111	2018-01-10 20:57:16.735829+08	2018-01-10 21:32:28.682342+08	2018-01-10 22:33:49.412298+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
8	24	2	15	15	2018-02-05	2018-02-05	0	People are ignorant of different cultures	To spread awares	My best	t	0.00	0.00	75.00	0.00	308475.00	0.00	\N	7111114	2011112	2018-01-10 21:45:36.030742+08	2018-01-10 21:53:54.928136+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
3	13	3	10	10	2018-02-12	2018-02-12	0	Bad UI design	Good UI means good User experience	Seminar	t	0.00	0.00	1000.00	0.00	343657.00	0.00	\N	1111114	2011111	2018-01-10 20:59:33.387539+08	2018-01-10 21:43:20.606937+08	2018-01-10 22:33:57.618223+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
4	17	3	10	10	2018-02-13	2018-02-13	0	Competitive CCS	they become content	Competition	t	0.00	0.00	100.00	0.00	342657.00	0.00	\N	1111114	2011111	2018-01-10 20:59:40.704313+08	2018-01-10 21:45:19.240348+08	2018-01-10 22:34:03.785532+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
2	10	4	10	10	2018-02-08	2018-02-08	0	Ugly pubs	People cant understand what they are promoting	Seminar	t	0.00	0.00	1900.00	0.00	345557.00	0.00	\N	1111114	2011111	2018-01-10 20:58:05.007698+08	2018-01-10 21:39:59.843029+08	2018-01-10 22:09:45.218794+08	t	t	f	t	\N	\N	\N		1	\N	\N	\N
20	118	3	10	10	2018-01-25	2018-01-25	0	Camaraderie	Chaos	this general asssembly	t	0.00	0.00	1000.00	0.00	336467.00	0.00	\N	1111114	2011111	2018-01-10 22:16:16.591949+08	2018-01-10 22:17:56.740832+08	2018-01-10 22:34:14.743693+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
9	70	2	40	40	2018-02-21	2018-02-21	0	Students having low grades due to them having limited notes on a course. 	There is a problem because during a class, students do not have the luxury to take note of everything that is being discussed inside the class	The project head will give its undivided attention regarding the completion of this project	t	0.00	0.00	900.00	0.00	340354.00	0.00	\N	10111114	2011111	2018-01-10 21:47:56.422256+08	2018-01-10 22:00:40.795121+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
15	6	3	10	10	2018-01-22	2018-01-22	0	some are computer illiterate	they dont know how to use computer	semianr	t	0.00	0.00	1000.00	0.00	337467.00	0.00	\N	1111114	2011111	2018-01-10 21:55:30.734074+08	2018-01-10 21:58:04.913559+08	2018-01-10 22:34:24.601347+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
23	80	2	80	80	2018-02-28	2018-02-28	0	Students do not understand the different sociological perspectives that one uses in the Behavioral Sciences.	There is a problem because topics that are being tackled in History 2 do not have enough supplementary materials. 	This activity will allow the participants to be well-equipped regarding the topics that will be covered in HISTSO2. The project head will be coordinating with several faculties in order to gather the necessary lecture materials for the event.	t	0.00	0.00	1300.00	0.00	339054.00	0.00	\N	10111114	2011112	2018-01-10 22:18:08.947926+08	2018-01-10 22:25:45.116766+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
17	14	2	20	15	2018-03-09	2018-03-09	27	The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\r\n	There are always problems in terms of visualizing an idea or translating a message through a picture\r\n	This activity will teach the participants of the basics of Photoshop	t	0.00	0.00	1200.00	0.00	307944.00	0.00	\N	4111114	2011111	2018-01-10 21:59:04.831732+08	2018-01-10 22:17:26.514056+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
21	23	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1428.00	0.00	\N	\N	4111114	\N	2018-01-10 22:17:47.448561+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
24	29	2	20	20	2018-01-29	2018-01-29	16	Decrease quality of student leaders	Officers are not prepared enough for the position that they receive	The project heads will commit their undivided attention for the success of this project	t	0.00	0.00	1200.00	0.00	306744.00	0.00	\N	4111114	2011111	2018-01-10 22:18:24.427044+08	2018-01-10 22:33:47.22055+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
19	73	2	23	23	2018-01-22	2018-01-22	18	Students are not performing well in terms of research writing mainly due to them not understanding the classroom sessions well enough.	There is a problem because their performance regarding research writing will heavily affect the way they write their dissertations. Due to this, we can discover ways to prevent them from having poor performance by giving them the necessary tools in writing properly.	This activity will allow the participants to have a copy of what they usually discuss in class. Thus allowing them to study the lecture materials and have a better performance.	t	0.00	0.00	400.00	0.00	339454.00	0.00	\N	10111114	2011111	2018-01-10 22:09:20.750625+08	2018-01-10 22:18:01.759562+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
22	26	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1428.00	0.00	\N	\N	4111114	\N	2018-01-10 22:18:05.785216+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
27	9	2	15	2	2018-01-22	2018-01-22	0	Not enough team building	Because of lack of team building	The best teambuilding this term would be given by me	t	0.00	0.00	5000.00	0.00	306741.00	0.00	\N	7111114	2011111	2018-01-10 22:30:50.970629+08	2018-01-10 22:34:08.224238+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
26	5	2	15	21	2018-01-15	2018-01-15	0	Unity of the organization	Because of need of additional activities to unite peoples	This activity will unite them by giving myself the best 	t	0.00	0.00	624.00	0.00	307365.00	0.00	\N	7111114	2011111	2018-01-10 22:25:58.457362+08	2018-01-10 22:30:42.936133+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
28	12	2	61	2	2018-01-18	2018-01-18	0	Waste is not recycled, it is wasted	People are ignorant on the waste of wastage	Communicate wastes	t	0.00	0.00	950.00	0.00	301741.00	0.00	\N	7111114	2011111	2018-01-10 22:30:51.675746+08	2018-01-10 23:13:13.973541+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
29	28	2	51	25	2018-01-22	2018-01-22	19	Engineers are ignorant of environmental concenrs	Not enough focus discussions on environment	The best of the environmentalist is to be offered	t	0.00	0.00	75.00	0.00	300791.00	0.00	\N	7111114	2011112	2018-01-10 22:30:52.342281+08	2018-01-10 23:18:31.222625+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
38	66	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1404.00	0.00	\N	\N	6111114	\N	2018-01-10 23:25:23.251115+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
39	77	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1404.00	0.00	\N	\N	6111114	\N	2018-01-10 23:25:34.178058+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
25	83	2	50	50	2018-03-02	2018-03-02	0	Camaraderie and team work between organizations are not promoted due to them belonging to different colleges and thus have minimal interaction with each other.	There is a problem because in order for DLSU to fully achieve one of its core values which is communion, organizations have to be united.	This activity will allow the several organizations to interact with each other through the activities prepared. The project head will work hand-in-hand with the presidents of each organization in order to ensure the success of this project.	t	0.00	0.00	5500.00	0.00	337754.00	0.00	\N	10111114	2011111	2018-01-10 22:25:55.886057+08	2018-01-10 22:48:56.894334+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
40	74	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1404.00	0.00	\N	\N	6111114	\N	2018-01-10 23:25:41.77817+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
41	45	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1404.00	0.00	\N	\N	6111114	\N	2018-01-10 23:25:47.036813+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
45	90	2	29	12	2018-03-21	2018-03-23	86	Decreasing number of students who participate in organizations.	There is a problem because they no longer feel the need to join organizations.	Through this activity, organizations are given an avenue for them to recruit incoming freshmen	t	0.00	0.00	8000.00	0.00	327054.00	0.00	\N	10111114	2011112	2018-01-10 23:29:14.512262+08	2018-01-10 23:38:30.148552+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
30	85	2	15	15	2018-03-07	2018-03-07	0	Some officers that are given positions are not that ready with the responsibilities of the position given to them.	There is a problem because they are not trained and briefed regarding the position they are about to inherit.	Through this activity, officers will be given training so that they are given the necessary experience in being officers before being full-fledged officers	t	0.00	0.00	3200.00	0.00	332254.00	0.00	\N	10111114	2011111	2018-01-10 22:49:50.856342+08	2018-01-10 22:58:19.266276+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
35	25	2	51	5	2018-01-24	2018-01-25	0	Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, 	One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin. He lay on his armour-like back	Margaret granted him his wish.\r\n\r\nThey bought her a gift.\r\n\r\nThose librarians envy him his good fortune.\r\n	t	0.00	0.00	76.00	0.00	300716.00	0.00	\N	7111114	2011111	2018-01-10 23:18:38.639274+08	2018-01-10 23:26:43.505528+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
44	72	2	10	10	2018-02-15	2018-02-15	0	discipline	order is becoming a problem	camp	t	0.00	0.00	1000.00	0.00	311053.00	0.00	\N	3111114	2011111	2018-01-10 23:29:04.611379+08	2018-01-10 23:30:22.275904+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
34	67	2	10	10	2018-02-12	2018-02-12	0	An avenue for DLSU community	people need someone	OG-P\r\n	t	0.00	0.00	1000.00	0.00	312253.00	0.00	\N	3111114	2011111	2018-01-10 23:16:45.014038+08	2018-01-10 23:21:52.778067+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
43	69	2	10	10	2018-02-12	2018-02-12	0	They dont know how to sell themselves	they value lowers	development	t	0.00	0.00	100.00	0.00	311153.00	0.00	\N	3111114	2011111	2018-01-10 23:27:08.409421+08	2018-01-10 23:28:50.255316+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
31	86	2	30	30	2018-03-14	2018-03-14	0	Aspiring officers do not know the process of being an officer. 	This is a problem because most of the members that are interested in becoming an officer tend to lose interest just because they do not know how to be an officer.	Through this activity, aspiring officers are given an avenue where they can express their desire of being an officer. The project heads will be coordinating with the officers of the organization in handling the aspiring officers.	t	0.00	0.00	2000.00	0.00	329054.00	0.00	\N	10111114	2011111	2018-01-10 22:58:34.719181+08	2018-01-10 23:29:10.594712+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
42	22	2	125	51	2018-01-31	2018-01-31	34	People are ignorant of kids	Kids are annoying	The best to the kids	t	0.00	0.00	4675.00	0.00	300640.00	0.00	\N	7111114	2011111	2018-01-10 23:26:46.095765+08	2018-01-10 23:28:24.562857+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
37	35	1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	\N	1404.00	0.00	\N	\N	6111114	\N	2018-01-10 23:25:04.935712+08	\N	\N	f	f	f	f	\N	\N	\N		0	\N	\N	\N
46	75	4	10	10	2018-02-18	2018-02-18	0	inter	cooperation	\r\nintership	t	0.00	0.00	100.00	0.00	310053.00	0.00	\N	3111114	2011111	2018-01-10 23:30:27.27118+08	2018-01-10 23:32:41.728252+08	2018-01-10 23:39:47.52139+08	t	t	f	t	\N	\N	\N		1	\N	\N	\N
32	62	3	10	10	2018-02-07	2018-02-07	0	Talents are hidden	talents are wasted	talent management	t	0.00	0.00	1000.00	0.00	314253.00	0.00	\N	3111114	2011111	2018-01-10 23:03:29.442892+08	2018-01-10 23:12:16.928111+08	2018-01-10 23:48:56.780586+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
33	64	3	10	10	2018-02-08	2018-02-08	0	Lack of summit	People need to be inform	my best	t	0.00	0.00	1000.00	0.00	313253.00	0.00	\N	3111114	2011111	2018-01-10 23:12:33.473139+08	2018-01-10 23:16:30.501087+08	2018-01-10 23:49:01.709665+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
48	81	3	10	10	2018-02-21	2018-02-21	0	organization of the track in their committee	disorganize	event	t	0.00	0.00	100.00	0.00	308953.00	0.00	\N	3111114	2011111	2018-01-10 23:34:12.193819+08	2018-01-10 23:35:40.068001+08	2018-01-10 23:49:08.678449+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
47	79	3	10	10	2018-02-19	2018-02-19	0	exposure to some international events	they become limited by what they have experience locally	seminar	t	0.00	0.00	1000.00	0.00	309953.00	0.00	\N	3111114	2011111	2018-01-10 23:32:44.057337+08	2018-01-10 23:34:07.336749+08	2018-01-10 23:49:17.290922+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
36	68	3	10	10	2018-01-14	2018-01-14	0	They need to be aware of their env	They are not helping their countrymen	General Assembly\r\n	t	0.00	0.00	100.00	0.00	311253.00	0.00	\N	3111114	2011111	2018-01-10 23:22:29.009647+08	2018-01-10 23:25:17.973024+08	2018-01-10 23:49:31.430741+08	t	t	t	t	\N	\N	\N		0	\N	\N	\N
49	61	2	10	10	2018-01-26	2018-01-26	0	lack of seminar for locals	they need to learn some new things\r\n	seminar	t	0.00	0.00	1000.00	0.00	308853.00	0.00	\N	3111114	2011111	2018-01-10 23:35:42.67435+08	2018-01-10 23:49:43.655282+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
50	88	2	10	10	2018-03-21	2018-03-21	0	In the age of information and computerization, various sectors in society, including commerce, government, and researching organizations, realize that data is changing the face of the world. Information systems are being implemented in both corporate and nonprofit organizations, and business processes are being improved and optimized through the use of software. With the emergence of the digital era, there is a growing understanding that knowing how to program is essential. Learning facts is less and less relevant in a world where Google can satisfy just about any question in a matter of milliseconds; it is skills that will enable individuals to succeed, and that set of skills must include programming. 	In the age of information and computerization, various sectors in society, including commerce, government, and researching organizations, realize that data is changing the face of the world. Information systems are being implemented in both corporate and nonprofit organizations, and business processes are being improved and optimized through the use of software. With the emergence of the digital era, there is a growing understanding that knowing how to program is essential. Learning facts is less and less relevant in a world where Google can satisfy just about any question in a matter of milliseconds; it is skills that will enable individuals to succeed, and that set of skills must include programming. 	The seminar will be an opportunity for the participants to learn how to program with the use of C#. Since students of CCS are already taught foundational concepts regarding how to program, the seminar will focus more on the syntax of programming with the use of C#. This seminar is vital since C# is one of the most used programming languages according to the IEEE Spectrum’s ranking list which ranks C# as the 6th most used programming language. The provision of this seminar will not only help its participants in knowing how to program with the use of C# for both their academic classes now, and for their future careers, but this can also help them enhance their critical thinking abilities on how to solve problems with the use of coding.  This is also a way for the participants to know how to use C# in a hands-on manner and understand how it can be used outside in the business world.	t	0.00	0.00	6000.00	0.00	319054.00	0.00	\N	10111114	2011111	2018-01-10 23:38:55.170354+08	2018-01-10 23:51:43.630391+08	\N	t	t	t	t	\N	\N	\N		0	\N	\N	\N
\.


--
-- Data for Name: projectproposalattachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalattachment (id, projectproposal, requirement, sequence, idnumber, filename, filenametoshow, directory) FROM stdin;
1	1	3	1	1111114	cjc93u4350000y1ntrdvtvr5d.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc93u4350000y1ntrdvtvr5d
2	1	4	1	1111114	cjc93u4370001y1ntdfsgg4xp.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114Credential of Speakers.pdf - cjc93u4370001y1ntdfsgg4xp
3	2	3	1	1111114	cjc943t0k0002y1ntjvxxe7pv.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc943t0k0002y1ntjvxxe7pv
4	2	4	1	1111114	cjc943t0m0003y1ntjm8w16q0.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114Credential of Speakers.pdf - cjc943t0m0003y1ntjm8w16q0
5	2	0	1	1111114	cjc943t0m0004y1nt26o6eejf.pdf	Sample informal quotation.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114Sample informal quotation.pdf - cjc943t0m0004y1nt26o6eejf
6	3	3	1	1111114	cjc9484d80005y1ntt2xjuoee.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc9484d80005y1ntt2xjuoee
7	3	4	1	1111114	cjc9484d90006y1ntbhkbqq59.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114sample credentials.pdf - cjc9484d90006y1ntbhkbqq59
8	4	3	1	1111114	cjc94annh0007y1ntf5stynhp.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94annh0007y1ntf5stynhp
9	4	4	1	1111114	cjc94anni0008y1nt8sxglvaa.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114Credential of Speakers.pdf - cjc94anni0008y1nt8sxglvaa
10	6	3	1	10111114	cjc94dpxq0009y1ntma314eth.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc94dpxq0009y1ntma314eth
11	6	4	1	10111114	cjc94dpxq000ay1ntukenemz9.pdf	SAMPLE CREDENTIALS OF SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114SAMPLE CREDENTIALS OF SPEAKER.pdf - cjc94dpxq000ay1ntukenemz9
12	5	3	1	1111114	cjc94f1yn000by1ntjknhgali.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94f1yn000by1ntjknhgali
13	5	4	1	1111114	cjc94f1yo000cy1ntqx0poqir.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114sample credentials.pdf - cjc94f1yo000cy1ntqx0poqir
14	10	3	1	1111114	cjc94h03i000dy1nt775bnhwu.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94h03i000dy1nt775bnhwu
15	10	4	1	1111114	cjc94h03j000ey1ntz6ddbm3p.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114sample credentials.pdf - cjc94h03j000ey1ntz6ddbm3p
16	11	3	1	1111114	cjc94k0kt000fy1ntg05pmdcm.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94k0kt000fy1ntg05pmdcm
17	11	4	1	1111114	cjc94k0ku000gy1nt39m23wrc.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114Credential of Speakers.pdf - cjc94k0ku000gy1nt39m23wrc
18	7	3	1	4111114	cjc94kp1r000hy1nth7bmo1kh.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114sample-vrt.pdf - cjc94kp1r000hy1nth7bmo1kh
19	7	4	1	4111114	cjc94kp1r000iy1ntjihp2ry2.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc94kp1r000iy1ntjihp2ry2
20	8	3	1	7111114	cjc94lphf000jy1nt7pz4ez93.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc94lphf000jy1nt7pz4ez93
21	8	4	1	7111114	cjc94lphf000ky1ntopylqp0r.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc94lphf000ky1ntopylqp0r
22	12	3	1	1111114	cjc94npjb000ly1nt9g47wdzc.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94npjb000ly1nt9g47wdzc
23	12	4	1	1111114	cjc94npjc000my1ntcjymueu9.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114sample credentials.pdf - cjc94npjc000my1ntcjymueu9
24	15	3	1	1111114	cjc94r2mw000ny1nt4egzbcr1.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94r2mw000ny1nt4egzbcr1
25	15	5	1	1111114	cjc94r2mw000oy1nta8jbv58h.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114sample credentials.pdf - cjc94r2mw000oy1nta8jbv58h
26	13	3	1	4111114	cjc94s1a1000py1ntw1l9zcfn.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114sample-vrt.pdf - cjc94s1a1000py1ntw1l9zcfn
27	13	4	1	4111114	cjc94s1a2000qy1nt56vyfj9b.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc94s1a2000qy1nt56vyfj9b
28	16	3	1	1111114	cjc94t1r4000ry1ntmbw4hn9y.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc94t1r4000ry1ntmbw4hn9y
29	14	3	1	7111114	cjc94udsv000sy1nt0pi81mh2.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc94udsv000sy1nt0pi81mh2
30	14	4	1	7111114	cjc94udsw000ty1nthbd3lpiq.pdf	[DRAFT 4.2] Resume.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114[DRAFT 4.2] Resume.pdf - cjc94udsw000ty1nthbd3lpiq
31	9	2	1	10111114	cjc94ue9n000uy1ntgy6hnyqc.pdf	Informal Quotation Template.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114Informal Quotation Template.pdf - cjc94ue9n000uy1ntgy6hnyqc
32	9	3	1	10111114	cjc94ue9o000vy1nt7ea6scff.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc94ue9o000vy1nt7ea6scff
33	17	3	1	4111114	cjc95fyfb0000kbntdmctybvm.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114sample-vrt.pdf - cjc95fyfb0000kbntdmctybvm
34	17	4	1	4111114	cjc95fyfd0001kbnticbh37wj.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc95fyfd0001kbnticbh37wj
35	20	3	1	1111114	cjc95gk5j0002kbntpu9lix59.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/1111114samplevrt.pdf - cjc95gk5j0002kbntpu9lix59
36	19	2	1	10111114	cjc95gpek0003kbntw2uu5iiv.pdf	Contest Mechanics.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114Contest Mechanics.pdf - cjc95gpek0003kbntw2uu5iiv
37	19	3	1	10111114	cjc95gpel0004kbntjtfpq2eg.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc95gpel0004kbntjtfpq2eg
38	23	2	1	10111114	cjc95qjss0000zqntriq2q1fb.pdf	Contest Mechanics.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114Contest Mechanics.pdf - cjc95qjss0000zqntriq2q1fb
39	23	3	1	10111114	cjc95qjsu0001zqntzdfx9heh.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc95qjsu0001zqntzdfx9heh
40	18	0	1	7111114	cjc95u36a0002zqntf3mejwru.pdf	Contest-Mechanics.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114Contest-Mechanics.pdf - cjc95u36a0002zqntf3mejwru
41	18	3	1	7111114	cjc95u36a0003zqnt24e2up9m.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc95u36a0003zqnt24e2up9m
42	18	8	1	7111114	cjc95u36c0004zqntq04j6ml6.pdf	demo-kit-final.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114demo-kit-final.pdf - cjc95u36c0004zqntq04j6ml6
43	26	3	1	7111114	cjc95x0k40005zqnt3xrowmpb.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc95x0k40005zqnt3xrowmpb
44	24	3	1	4111114	cjc960zao0006zqntnmvncq5t.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/4111114sample-vrt.pdf - cjc960zao0006zqntnmvncq5t
45	27	3	1	7111114	cjc961f8r0007zqntwymv4co1.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc961f8r0007zqntwymv4co1
46	27	4	1	7111114	cjc961f8r0008zqnt4152uu7h.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc961f8r0008zqnt4152uu7h
47	25	3	1	10111114	cjc96kgog0009zqnthp9k2f8i.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc96kgog0009zqnthp9k2f8i
48	30	3	1	10111114	cjc96wio9000azqntsgx9k897.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc96wio9000azqntsgx9k897
49	32	3	1	3111114	cjc97ehti00001znt61yf8am6.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc97ehti00001znt61yf8am6
50	32	4	1	3111114	cjc97ehtl00011znt7u91xmo6.pdf	sample credentials.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114sample credentials.pdf - cjc97ehtl00011znt7u91xmo6
51	28	3	1	7111114	cjc97fq1000021zntybzqn87a.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc97fq1000021zntybzqn87a
52	28	5	1	7111114	cjc97fq1000031zntq3z6rrmm.pdf	Contest-Mechanics.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114Contest-Mechanics.pdf - cjc97fq1000031zntq3z6rrmm
53	33	3	1	3111114	cjc97jxiq0000tbntrtlmds3d.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc97jxiq0000tbntrtlmds3d
54	33	4	1	3111114	cjc97jxiu0001tbntitwl74ds.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc97jxiu0001tbntitwl74ds
55	29	3	1	7111114	cjc97mild0002tbntcx43czyv.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc97mild0002tbntcx43czyv
56	29	4	1	7111114	cjc97mile0003tbntcaaekgbh.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc97mile0003tbntcaaekgbh
57	34	0	1	3111114	cjc97qu3e0004tbnt9gypg0gk.pdf	Sample informal quotation.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Sample informal quotation.pdf - cjc97qu3e0004tbnt9gypg0gk
58	34	3	1	3111114	cjc97qu3f0005tbnteyaomi8a.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc97qu3f0005tbnteyaomi8a
59	34	8	1	3111114	cjc97qu3g0006tbnthi8kyr3q.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc97qu3g0006tbnthi8kyr3q
60	36	0	1	3111114	cjc97v8ki0007tbntg4czj0n8.pdf	Sample informal quotation.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Sample informal quotation.pdf - cjc97v8ki0007tbntg4czj0n8
61	36	3	1	3111114	cjc97v8kj0008tbnt6pn717yr.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc97v8kj0008tbnt6pn717yr
62	36	8	1	3111114	cjc97v8kj0009tbnth0nh5pg4.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc97v8kj0009tbnth0nh5pg4
63	35	3	1	7111114	cjc97x23v000atbnt3e18aja5.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc97x23v000atbnt3e18aja5
64	35	4	1	7111114	cjc97x23w000btbnt4la2paga.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc97x23w000btbnt4la2paga
65	42	3	1	7111114	cjc97z8ds000ctbntxuuymtvz.pdf	sample-vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114sample-vrt.pdf - cjc97z8ds000ctbntxuuymtvz
66	42	4	1	7111114	cjc97z8dt000dtbntujacnnzz.pdf	SAMPLE-CREDENTIALS-OF-SPEAKER.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/7111114SAMPLE-CREDENTIALS-OF-SPEAKER.pdf - cjc97z8dt000dtbntujacnnzz
67	43	3	1	3111114	cjc97zsni000etbntxd7kvnud.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc97zsni000etbntxd7kvnud
68	43	4	1	3111114	cjc97zsnj000ftbntq5dd6vfa.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc97zsnj000ftbntq5dd6vfa
69	31	0	1	10111114	cjc9806qd000gtbntljsgvm1n.pdf	Contest Mechanics.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114Contest Mechanics.pdf - cjc9806qd000gtbntljsgvm1n
70	31	3	1	10111114	cjc9806qe000htbntys5a1ada.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc9806qe000htbntys5a1ada
71	31	8	1	10111114	cjc9806qf000itbntffprbepy.pdf	sample application form.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample application form.pdf - cjc9806qf000itbntffprbepy
72	44	3	1	3111114	cjc981r86000jtbntd2cii1u9.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc981r86000jtbntd2cii1u9
73	44	4	1	3111114	cjc981r87000ktbntu694z6gl.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc981r87000ktbntu694z6gl
74	46	3	1	3111114	cjc984qj6000ltbntarlfgg3u.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc984qj6000ltbntarlfgg3u
75	46	4	1	3111114	cjc984qj6000mtbntxfxepe8r.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc984qj6000mtbntxfxepe8r
76	47	3	1	3111114	cjc986kzi000ntbnt16sbbqxa.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc986kzi000ntbnt16sbbqxa
77	47	5	1	3111114	cjc986kzj000otbnturxmkd7p.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc986kzj000otbnturxmkd7p
78	48	3	1	3111114	cjc988ku1000ptbnto6xwzgba.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc988ku1000ptbnto6xwzgba
79	48	4	1	3111114	cjc988ku2000qtbnt5n46jeuh.pdf	Credential of Speakers.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114Credential of Speakers.pdf - cjc988ku2000qtbnt5n46jeuh
80	45	3	1	10111114	cjc98c6sg0000rhntn4vkpbpv.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc98c6sg0000rhntn4vkpbpv
81	49	3	1	3111114	cjc98cp080001rhntqd31nosn.pdf	samplevrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/3111114samplevrt.pdf - cjc98cp080001rhntqd31nosn
82	50	3	1	10111114	cjc98t78e0004rhntn1lgj7qv.pdf	sample vrt.pdf	/home/shinichi/Desktop/Project-Revolution/app/assets/upload/preacts/10111114sample vrt.pdf - cjc98t78e0004rhntn1lgj7qv
\.


--
-- Data for Name: projectproposalexpenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalexpenses (id, projectproposal, sequence, material, quantity, unitcost, type) FROM stdin;
1	1	1	Food	1	10.00	1
2	2	1	food	10	190.00	1
3	3	1	food	10	100.00	1
4	4	1	food	10	10.00	1
5	6	1	Token for the speaker	1	500.00	5
6	6	2	Food for the participants	30	100.00	1
7	5	1	Food	10	190.00	0
8	10	1	food	19	10.00	0
9	8	1	Booth Materials	15	5.00	1
10	7	1	Token of Appreciation	1	1500.00	5
11	7	2	Food for participants	40	40.00	1
12	11	1	Food	10	100.00	0
13	12	1	Food	10	100.00	0
14	15	1	Food	100	10.00	1
15	9	1	Printing Expense	1	500.00	0
16	9	2	Food for volunteers	4	100.00	1
17	13	1	Token  of Appreciation	1	1200.00	5
18	13	2	Food	30	50.00	1
19	16	1	Food	10	100.00	1
20	14	1	Jollibee Chicken joi	2	15.00	5
21	17	1	Token of Appreciation	1	1200.00	5
22	19	1	Printing expense	40	10.00	0
23	20	1	Food	10	100.00	1
24	23	1	Food for the volunteers	5	100.00	1
25	23	2	printing expense	40	20.00	0
26	18	1	Confetti	67	15.00	0
27	26	1	Cash Prize	4	156.00	5
28	24	1	Food	30	40.00	1
29	27	1	Jollibee Chicken joi	50	100.00	1
30	25	1	Food for the participants	40	100.00	1
31	25	2	Game materials	3	500.00	0
32	30	1	name tags	40	5.00	0
33	30	2	Food for the participants	30	100.00	1
34	32	1	Food	10	100.00	1
35	28	1	Uncle John's Fried Chicken	10	95.00	1
36	33	1	Food	10	100.00	1
37	29	1	Uncle John's Fried Chicken	5	15.00	6
38	31	1	Food for the participants	40	50.00	0
39	34	1	IT	10	100.00	0
40	36	1	Food	10	10.00	0
41	35	1	Cash Prize	1	51.00	5
42	35	2	Confetti	1	25.00	0
43	42	1	Uncle John's Fried Chicken	55	85.00	1
44	43	1	Food	10	10.00	0
45	44	1	Food	10	100.00	0
46	46	1	Food	10	10.00	0
47	47	1	food	10	100.00	0
48	48	1	food	10	10.00	0
49	45	1	Freebies	400	20.00	0
50	49	1	Food	10	100.00	1
51	50	1	Food for the participants	50	80.00	1
52	50	2	games freebies	100	20.00	0
\.


--
-- Data for Name: projectproposalprogramdesign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalprogramdesign (id, projectproposal, dayid, sequence, date, starttime, endtime, activity, activitydescription, personincharge) FROM stdin;
3	1	0	3	2018-02-02	13:00:00+08	14:00:00+08	prayer	asd	1111114
4	1	0	4	2018-02-02	14:00:00+08	15:00:00+08	acs	asd	1111114
5	2	0	1	2018-02-08	12:00:00+08	13:00:00+08	Opening	prayer	1111114
6	2	0	2	2018-02-08	13:00:00+08	14:30:00+08	Lunch	lunch	1111114
7	2	0	3	2018-02-08	14:30:00+08	15:00:00+08	ending	prayer	1111114
8	3	0	1	2018-02-12	12:00:00+08	13:00:00+08	Opening	Act	1111114
9	3	0	2	2018-02-12	13:00:00+08	14:00:00+08	Lunch	asd	1111114
10	4	0	1	2018-02-13	12:00:00+08	13:00:00+08	Opening	prater	1111114
11	6	0	1	2018-02-14	09:00:00+08	09:05:00+08	Prayer	The seminar starts with a prayer\n	10111114
12	6	0	2	2018-02-14	09:05:00+08	11:00:00+08	Seminar Proper	The speaker will be giving out his talk regarding CSR	10111114
13	6	0	3	2018-02-14	11:00:00+08	11:05:00+08	Cleaning	The event will end with cleaning the venue	10111114
14	5	0	1	2018-02-15	12:00:00+08	13:00:00+08	Act	prayer	1111114
15	10	0	1	2018-01-16	12:00:00+08	13:00:00+08	act	asd	1111114
16	8	0	1	2018-02-05	13:05:00+08	13:10:00+08	Rehearsal	Penchorn placement	7111116
17	7	0	1	2018-01-26	13:00:00+08	13:15:00+08	Orientation	Participants will be briefed of the activities for the day	4111114
18	7	0	2	2018-01-26	13:15:00+08	16:00:00+08	Photoshop Basics	Participants are taught how to use Photoshop	4111114
19	7	0	3	2018-01-26	16:00:00+08	16:30:00+08	Exercises	They are given exercises to practice what they learned	4111114
20	11	0	1	2018-02-18	12:00:00+08	13:00:00+08	Opening	prayer	1111114
21	12	0	1	2018-01-18	12:00:00+08	13:00:00+08	Prayer	opening	1111114
22	9	0	1	2018-02-21	09:00:00+08	18:00:00+08	Review Material Distribution	The project heads along with the officers will be giving out review materials for the courses under behavioral Sciences	10111114
23	15	0	1	2018-01-22	12:00:00+08	13:00:00+08	Opening	prayer	1111114
24	13	0	1	2018-02-02	12:00:00+08	12:15:00+08	Orientation	Orientation of the activities for the day	4111114
25	13	0	2	2018-02-02	12:15:00+08	16:00:00+08	Photoshop lesson	The students are given a lesson on how to use photoshop	4111114
26	13	0	3	2018-02-02	16:00:00+08	17:00:00+08	Exercises	Students practice what they learned through exercises	4111114
27	16	0	1	2018-01-26	12:00:00+08	13:00:00+08	Opening	prayer	1111114
28	14	0	1	2018-02-15	13:30:00+08	14:00:00+08	Discussion		7111116
29	17	0	1	2018-03-09	12:00:00+08	12:15:00+08	Orientation	Tell the participants of the activities for the day	4111112
30	17	0	2	2018-03-09	12:15:00+08	16:00:00+08	Photoshop lesson	Teach the students an advanced lesson about photoshop	4111112
31	17	0	3	2018-03-09	16:00:00+08	17:00:00+08	Exercises	The students practice what they learned	4111112
32	19	0	1	2018-01-22	09:00:00+08	18:00:00+08	Distribution of Lecture Materials	The volunteers will be giving out lecture materials in the specified venue.	10111114
33	20	0	1	2018-01-25	12:00:00+08	13:00:00+08	Act	asd	1111114
35	23	0	2	2018-02-28	01:00:00+08	03:00:00+08	Review Material Distribution	The volunteers will be giving out the review materials to the participants 	10111114
36	18	0	1	2018-01-11	13:30:00+08	18:30:00+08	Booth Manning		7111114
37	26	0	1	2018-01-15	13:30:00+08	14:00:00+08	Assembly		7111114
38	26	0	2	2018-01-15	14:15:00+08	18:30:00+08	Awarding of Officers		7111114
39	24	0	1	2018-01-29	09:00:00+08	09:30:00+08	Introduction	The organization officers introduce themselves and tell their objectives for the term	4111114
40	24	0	2	2018-01-29	09:30:00+08	10:30:00+08	Games	A game is played to capture the attention of the participants and keep them engaged throughout	4111114
41	24	0	3	2018-01-29	10:30:00+08	12:00:00+08	Briefing 	The officers explains their plans for the term and ask for feedback from the members	4111114
42	24	0	4	2018-01-29	12:00:00+08	12:30:00+08	Lunch	The attendees are given food	4111114
43	27	0	1	2018-01-22	14:15:00+08	16:00:00+08	Event proper		7111114
44	27	0	2	2018-01-22	16:00:00+08	17:00:00+08	Clean-up		7111114
45	27	0	3	2018-01-22	13:29:00+08	14:00:00+08	Intro		7111114
50	25	0	5	2018-03-02	09:00:00+08	09:15:00+08	Booth setup	The various organizations will be setting up their own booths in their assigned places.	10111114
51	25	0	6	2018-03-02	09:15:00+08	09:30:00+08	Opening Prayer	The event will start with a prayer to be lead by the project head	10111114
52	25	0	7	2018-03-02	09:30:00+08	15:45:00+08	Event Proper	organizations will be playing with each other through the games prepared.	10111114
53	25	0	8	2018-03-02	03:45:00+08	04:00:00+08	Closing Prayer	the event will end with a closing prayer	10111114
56	30	0	3	2018-03-07	09:00:00+08	09:15:00+08	Starting Prayer		10111114
57	30	0	4	2018-03-07	09:15:00+08	12:45:00+08	Training Proper		10111114
58	30	0	5	2018-03-07	12:45:00+08	13:00:00+08	closing prayer		10111114
59	32	0	1	2018-02-07	12:00:00+08	13:00:00+08	Prayer	opening	3111114
60	28	0	1	2018-01-18	11:00:00+08	13:30:00+08	Discussion of data 		7111116
61	31	0	1	2018-03-14	09:00:00+08	09:15:00+08	Opening Prayer		10111114
62	31	0	2	2018-03-14	09:15:00+08	09:45:00+08	Officers Briefing	the aspiring officers will be given information regarding the various positions in the organization	10111114
63	31	0	3	2018-03-14	09:45:00+08	10:00:00+08	closing prayer		10111114
64	33	0	1	2018-02-08	12:00:00+08	13:01:00+08	Activity	Desc	3111114
65	29	0	1	2018-01-22	09:15:00+08	12:00:00+08	Focus group discussion		7111114
66	34	0	1	2018-02-12	12:00:00+08	13:00:00+08	Activity	Asd	3111114
67	36	0	1	2018-01-14	12:00:00+08	13:00:00+08	Act	prayer	3111114
68	35	0	1	2018-01-24	13:00:00+08	14:30:00+08	Event Proper		7111116
69	35	1	1	2018-01-25	13:00:00+08	14:10:00+08	Event Proper		7111116
70	42	0	1	2018-01-31	13:28:00+08	18:30:00+08	Kid's day celebration		7111116
71	43	0	1	2018-02-12	12:00:00+08	13:00:00+08	act	asd	3111114
72	44	0	1	2018-02-15	12:00:00+08	13:00:00+08	act	ac	3111114
73	46	0	1	2018-02-18	12:00:00+08	13:00:00+08	Opening	actrivity	3111114
74	47	0	1	2018-02-19	12:00:00+08	13:00:00+08	act	1123	3111114
75	48	0	1	2018-02-21	12:00:00+08	13:00:00+08	act	prayer	3111114
76	45	0	1	2018-03-21	09:00:00+08	12:00:00+08	Frosh walk		10111114
77	45	1	1	2018-03-22	09:00:00+08	12:00:00+08	Frosh walk		10111114
78	45	2	1	2018-03-23	09:00:00+08	12:00:00+08	Frosh walk		10111114
79	49	0	1	2018-01-26	12:00:00+08	13:00:00+08	opening	prayer	3111114
81	50	0	2	2018-03-21	14:00:00+08	14:15:00+08	PRAYER		10111114
82	50	0	3	2018-03-21	14:15:00+08	18:45:00+08	Event proper		10111114
\.


--
-- Data for Name: projectproposalprogramdesignpersonincharge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalprogramdesignpersonincharge (id, programdesign, projecthead) FROM stdin;
\.


--
-- Data for Name: projectproposalprojectedincome; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalprojectedincome (projectproposal, sequence, item, quantity, sellingprice) FROM stdin;
\.


--
-- Data for Name: projectproposalreschedulereason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalreschedulereason (id, name) FROM stdin;
1	Class suspension
2	Insufficient participnts
3	Speaker unavailable
4	Others
\.


--
-- Data for Name: projectproposalsignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalsignatory (id, gosmactivity, signatory, type, status, comments, sectionstoedit, document, digitalsignature, datesigned) FROM stdin;
9	10	1111115	1	0	\N	\N	\N	\N	\N
10	10	1111113	2	0	\N	\N	\N	\N	\N
11	10	1111111	3	0	\N	\N	\N	\N	\N
12	10	1111113	5	0	\N	\N	\N	\N	\N
13	10	1011121	6	0	\N	\N	\N	\N	\N
14	10	1011120	7	0	\N	\N	\N	\N	\N
29	21	1111114	0	0	\N	\N	\N	\N	\N
30	21	1111115	1	0	\N	\N	\N	\N	\N
31	21	1111113	2	0	\N	\N	\N	\N	\N
32	21	1111111	3	0	\N	\N	\N	\N	\N
33	21	1111113	5	0	\N	\N	\N	\N	\N
34	21	1011121	6	0	\N	\N	\N	\N	\N
35	21	1011120	7	0	\N	\N	\N	\N	\N
37	65	10111114	0	0	\N	\N	\N	\N	\N
38	65	10111115	1	0	\N	\N	\N	\N	\N
39	65	10111113	2	0	\N	\N	\N	\N	\N
40	65	10111111	3	0	\N	\N	\N	\N	\N
41	65	10111113	5	0	\N	\N	\N	\N	\N
42	65	1011121	6	0	\N	\N	\N	\N	\N
43	65	1011120	7	0	\N	\N	\N	\N	\N
51	7	1011120	7	0	\N	\N	\N	\N	\N
52	10	2011111	4	0	\N	\N	\N	\N	\N
54	65	2011111	4	0	\N	\N	\N	\N	\N
62	24	1011121	6	0	\N	\N	\N	\N	\N
63	24	1011120	7	0	\N	\N	\N	\N	\N
65	21	2011111	4	0	\N	\N	\N	\N	\N
66	70	10111114	0	0	\N	\N	\N	\N	\N
67	70	10111116	0	0	\N	\N	\N	\N	\N
68	70	10111115	1	0	\N	\N	\N	\N	\N
69	70	10111113	2	0	\N	\N	\N	\N	\N
70	70	10111111	3	0	\N	\N	\N	\N	\N
71	70	10111113	5	0	\N	\N	\N	\N	\N
72	70	1011121	6	0	\N	\N	\N	\N	\N
73	70	1011120	7	0	\N	\N	\N	\N	\N
74	24	2011112	4	0	\N	\N	\N	\N	\N
75	30	1111114	0	0	\N	\N	\N	\N	\N
76	30	1111116	0	0	\N	\N	\N	\N	\N
77	30	1111115	1	0	\N	\N	\N	\N	\N
78	30	1111113	2	0	\N	\N	\N	\N	\N
79	30	1111111	3	0	\N	\N	\N	\N	\N
80	30	1111113	5	0	\N	\N	\N	\N	\N
81	30	1011121	6	0	\N	\N	\N	\N	\N
82	30	1011120	7	0	\N	\N	\N	\N	\N
83	30	2011111	4	0	\N	\N	\N	\N	\N
84	70	2011111	4	0	\N	\N	\N	\N	\N
85	31	1111114	0	0	\N	\N	\N	\N	\N
86	31	1111115	1	0	\N	\N	\N	\N	\N
87	31	1111113	2	0	\N	\N	\N	\N	\N
88	31	1111111	3	0	\N	\N	\N	\N	\N
89	31	1111113	5	0	\N	\N	\N	\N	\N
90	31	1011121	6	0	\N	\N	\N	\N	\N
91	31	1011120	7	0	\N	\N	\N	\N	\N
92	31	2011111	4	0	\N	\N	\N	\N	\N
93	1	1111114	0	0	\N	\N	\N	\N	\N
94	1	1111115	1	0	\N	\N	\N	\N	\N
95	1	1111113	2	0	\N	\N	\N	\N	\N
96	1	1111111	3	0	\N	\N	\N	\N	\N
97	1	1111113	5	0	\N	\N	\N	\N	\N
98	1	1011121	6	0	\N	\N	\N	\N	\N
99	1	1011120	7	0	\N	\N	\N	\N	\N
106	11	1011120	7	0	\N	\N	\N	\N	\N
111	27	7111111	3	0	\N	\N	\N	\N	\N
113	27	1011121	6	0	\N	\N	\N	\N	\N
114	27	1011120	7	0	\N	\N	\N	\N	\N
115	1	2011111	4	0	\N	\N	\N	\N	\N
116	27	2011112	4	0	\N	\N	\N	\N	\N
126	2	1111114	0	0	\N	\N	\N	\N	\N
127	2	1111115	1	0	\N	\N	\N	\N	\N
128	2	1111113	2	0	\N	\N	\N	\N	\N
129	2	1111111	3	0	\N	\N	\N	\N	\N
130	2	1111113	5	0	\N	\N	\N	\N	\N
131	2	1011121	6	0	\N	\N	\N	\N	\N
132	2	1011120	7	0	\N	\N	\N	\N	\N
133	2	2011111	4	0	\N	\N	\N	\N	\N
141	14	1011120	7	0	\N	\N	\N	\N	\N
147	3	7111111	3	0	\N	\N	\N	\N	\N
149	3	1011121	6	0	\N	\N	\N	\N	\N
150	3	1011120	7	0	\N	\N	\N	\N	\N
151	3	2011111	4	0	\N	\N	\N	\N	\N
152	73	10111114	0	0	\N	\N	\N	\N	\N
153	73	10111115	1	0	\N	\N	\N	\N	\N
154	73	10111113	2	0	\N	\N	\N	\N	\N
155	73	10111111	3	0	\N	\N	\N	\N	\N
156	73	10111113	5	0	\N	\N	\N	\N	\N
157	73	1011121	6	0	\N	\N	\N	\N	\N
100	11	4111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0fceeb9f43ef44c4cb7262e95a8f47318be1c1f10878deef1cb567b767d1039d4c6df8f47c2af26a930273c2c95631658bf411dd1c98306fbafca26a3f6199351e432dfe968e4bd4fdb9d04f7ea7884665643fe45f1963a42aa8b135ee3d2679cf22b1c69b2d5bca9d46c6502b212ff3bd21f68410e35685835e3d153a5d1d90	2018-01-10 22:35:21.475302+08
146	3	7111113	2	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Fundraising", "Context": "The lack of functioning members of society", "Expenses": [{"Type": "Others", "Material": "Confetti", "Quantity": 67, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 3, "Objectives": ["To showcase the nature, mission-vision, activities and programs of the organization", "To recruite new members from both STC and Taft campus as well as membership renewal for old members", "To increase the organizational funds through membership fee "], "Strategies": "Annual Recruitment Week", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 11, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Booth Manning", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 18, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308370.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03c58218d1c4f3fcea025be767acbb8211908ee77c6349210613e134bded5e2f9524ce946f5f0234685235836473428a30c8583f17632b960d01bdc80cd7f4858faf35476c90636ce944cfb72536e97c5c5f5e68c71bd0806bd97576a74c44079a2531ce9ae228b99d43948a4431827e7411e3f8b0be9ab40c15fb011b4e6c81	2018-01-10 23:48:33.087345+08
158	73	1011120	7	0	\N	\N	\N	\N	\N
1	8	1111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	87b935e5b41e98cf3657c29d7e01006eb1aaa34383641ce844002868142268dd8282dec12a1f40f64de8ecf6a3cac511db5d742ad92367991ece3b3e6143e29f33cd113bbc6e2ce4861ab5bde2aa05ae72dd7fec2a2993c1831dae5276a77602a27cfdf3c199aa046a37fe925d1887760feaa54ab5ff70169401c670e98956ae	2018-01-10 22:09:22.924253+08
8	10	1111114	0	2	Fix expense	{"Revenue and Expense Table"}	\N	\N	\N
15	13	1111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	52f12efed5046d78b53986275de2dc77f6178522b18d9b7a5a7f1f83882d954604f003e7236691757ca78a98248e0c5195356663a9f6c6fe1e9a84ca816bee7c823a33ff06adad95b95c1a3132928b733833205288d48668448ee4439135a6799d6c680d97a33339125975fc7760e6f46e5b5b5cdae394b8a7edfba9aea07ab6	2018-01-10 22:09:56.29751+08
22	17	1111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	5efe04c134d986c79b8698c3b2261a3063758b54e760a4ce8bb7aaca211b6203ef6008a53c0c8298f736141af190e7d2e163bc0bf1f913a669fc3c812d5ef02206cc0f3be8a84d2b2849b41f5ba8c3ea59f4d82f551276c825658f4939c9988ac4eb47d6ae1544fab79c1f0f30a22f2a1ccf1de63ed2732ec85b6671c25f639a	2018-01-10 22:10:02.25986+08
159	73	2011111	4	0	\N	\N	\N	\N	\N
168	23	4111114	0	0	\N	\N	\N	\N	\N
169	23	4111116	0	0	\N	\N	\N	\N	\N
170	23	4111115	1	0	\N	\N	\N	\N	\N
171	23	4111113	2	0	\N	\N	\N	\N	\N
172	23	4111111	3	0	\N	\N	\N	\N	\N
173	23	4111113	5	0	\N	\N	\N	\N	\N
174	23	1011121	6	0	\N	\N	\N	\N	\N
175	23	1011120	7	0	\N	\N	\N	\N	\N
176	26	4111113	0	0	\N	\N	\N	\N	\N
177	26	4111114	0	0	\N	\N	\N	\N	\N
178	26	4111115	1	0	\N	\N	\N	\N	\N
179	26	4111113	2	0	\N	\N	\N	\N	\N
180	26	4111111	3	0	\N	\N	\N	\N	\N
181	26	4111113	5	0	\N	\N	\N	\N	\N
182	26	1011121	6	0	\N	\N	\N	\N	\N
183	26	1011120	7	0	\N	\N	\N	\N	\N
184	80	10111114	0	0	\N	\N	\N	\N	\N
185	80	10111115	1	0	\N	\N	\N	\N	\N
186	80	10111113	2	0	\N	\N	\N	\N	\N
187	80	10111111	3	0	\N	\N	\N	\N	\N
188	80	10111113	5	0	\N	\N	\N	\N	\N
189	80	1011121	6	0	\N	\N	\N	\N	\N
190	80	1011120	7	0	\N	\N	\N	\N	\N
197	29	1011120	7	0	\N	\N	\N	\N	\N
160	118	1111114	0	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	927fcf3b8a1960494a3a44bc6be6a96ead26d06a7ec917190c81d54ae1eecb04c2cd62135d40f30a73da35892828314a65d721650dcd3fee77cd792dae4f61d1d5aae9025f7e983663f9888cf640a6601934f6b8b36c86939f7cd86e4d4f0864778bc3eb5622388fe3ee5e7ba1ebb6c4645859b197c26d2dbeed604c96068d79	2018-01-10 22:18:45.746869+08
118	6	1111114	0	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	50fe46549c83290382d3a34aad6765bd3e7e13f4754c1dde55f3c8bd2d2dba28134fdf4bfd88c3b9004cd55201f9f7ec2656110bae4f294cadaca351f5e37a05d0f695671017f8c48791aa0b656bca0c04d1c5361894803650f168a4e4a003f8d2088845325997187d672cfd2164ac697d785697a026b12983267545d5f45aa0	2018-01-10 22:18:54.291185+08
198	80	2011112	4	0	\N	\N	\N	\N	\N
2	8	1111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	14ea242c7808147fa910f1f0cc61383e5b07255caf202d55e60b3acbfe040cbe2bd0eb63d588c3e68bc3d45a23e2d9876764862317e1c6f6e4d212f1e3360f90b4266a6fc9cbe1853ca25cdf883a3268a3ad803801f7f7ec1fb51048bf6bd42278d567f8637bb17f2977647bf892d5a26f988760ffed86daaa40cdfc0d1e2285	2018-01-10 22:25:20.868604+08
200	83	10111114	0	0	\N	\N	\N	\N	\N
201	83	10111115	1	0	\N	\N	\N	\N	\N
202	83	10111113	2	0	\N	\N	\N	\N	\N
203	83	10111111	3	0	\N	\N	\N	\N	\N
204	83	10111113	5	0	\N	\N	\N	\N	\N
205	83	1011121	6	0	\N	\N	\N	\N	\N
206	83	1011120	7	0	\N	\N	\N	\N	\N
210	5	7111111	3	0	\N	\N	\N	\N	\N
212	5	1011121	6	0	\N	\N	\N	\N	\N
213	5	1011120	7	0	\N	\N	\N	\N	\N
16	13	1111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	c613c71c137cbaa7975a5d4b03d81f727d04941c29cb4cb5363537e6778ae9e646eb58c0d1552d703d8964ccf35751550ccd30bd88cc7b76dcffb9a38f13987f0d3a203b0ff0656362121f60a208b961d225f37e7243b97ad33ee8db22787d13edd2879a6c69047c52131b3e645576c2ee1d37b25fac06ecea5f953871006352	2018-01-10 22:26:50.052024+08
23	17	1111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4586e9cb65a17ba1b5c00526630f620da7d12e35247dd6035c8330b74c8a27635d3605d47bdaf50ff1a0da1a86194a3e5794ac067e8b261db880b2401a43e6b2ff0066095c5967b0e1ed52e0f42b1794096c543091822ccd0b55ae5aba4ad24ff69acd3404e9c0cf350b31904cc9cc4a49557b91b7c83706fd76f780d4c20751	2018-01-10 22:27:17.071538+08
161	118	1111115	1	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	28af49aaf3931c9524d43a9f768566ebfc5eb253df4f8a9e5f55a8f87acb9100c461ef6507bd61a73ab33a8438874e80a8588e01d9c9d1982a1ff585cf413845fcd957dd332d2ef59e3c638e302daf42389d162d3fa9200aa2a8294073c29f0a1fb853685d1934eb9bd43c1a6c5cef86a02b54a277712ccc8ff27b832af826de	2018-01-10 22:27:38.244055+08
119	6	1111115	1	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	77b6718c120e07c0baab520fef1d4fc07824abcce023754c9a2527974b8f14541143a41b29cde30fa00e74fcb2b75dcda857fa42d055e6a0af70313f1feff16634c4e4dc55e035c17ba1a2218ac2c53faae0e9ee265eba51131fb68355dfeb24e279d1c1cb5bb631d4782576704d1a4724f1d1c692f41c5600f6147a93f4c417	2018-01-10 22:27:44.288318+08
3	8	1111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	05dd1661be86712535a0c4a96f19ab75b30e610e3f009ce26ca832b2732345571cb86514a332aa6fdf30f558596b68494ff633f3cfe4a53fecef3bd7db2c53508c8e41974ed6e92888eedd7213eea3a58f6cd743b380965bad4ef38016848516bee31339b543a32d6b3fa24e0468a570523d75d0b37642ecfcb0186cd3a351bb	2018-01-10 22:28:33.765683+08
163	118	1111111	3	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	22baee6ac869cc7976572078a07e6289b71c318073b71caf9d3e56db3293b53960874d7a0e1135e674116d0a336e08d3b7394a2a24b0b8c0621f997ac9fd6f337a39d1c777f3d8925db02533cf017178cd0c798b6ce97bff156f2f5976463d54635a9cd694699ccf114ce05a26961d8b3ff8ed0b813fa1acf6b96c8d02e33392	2018-01-10 22:29:53.442954+08
5	8	1111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	05dd1661be86712535a0c4a96f19ab75b30e610e3f009ce26ca832b2732345571cb86514a332aa6fdf30f558596b68494ff633f3cfe4a53fecef3bd7db2c53508c8e41974ed6e92888eedd7213eea3a58f6cd743b380965bad4ef38016848516bee31339b543a32d6b3fa24e0468a570523d75d0b37642ecfcb0186cd3a351bb	2018-01-10 22:28:33.765683+08
17	13	1111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4df156a04c922fb20e0b0b116597697a504e33f3f0fdb3611b28cb26947660276a193d297761f93cc26d8d2016da288218947deb388f347a5b41aece08a9ae6a5ae6edeef334124c9f67a63c29a6aeb4d8b0f9a018c93498d7592e0955ed3f245a4f8bf5d98db556c3fa1a1b4a6c6db4e593800e86cb911a40ec1443549161de	2018-01-10 22:28:40.324677+08
19	13	1111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4df156a04c922fb20e0b0b116597697a504e33f3f0fdb3611b28cb26947660276a193d297761f93cc26d8d2016da288218947deb388f347a5b41aece08a9ae6a5ae6edeef334124c9f67a63c29a6aeb4d8b0f9a018c93498d7592e0955ed3f245a4f8bf5d98db556c3fa1a1b4a6c6db4e593800e86cb911a40ec1443549161de	2018-01-10 22:28:40.324677+08
24	17	1111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	9527937751085d55a225d64b9268d231159fbbaa44121338816f06761a8680ac9357cbe010d531e16916837fbe331a5abd2eba17f631ac9846be7f2007af13521c0618e0b4a9f193bfad38dad3228d701e7e6ace1ab99f96c2c7217d5c58ffa7c3cbf07622d102e5ca139a73a2ec49360b30707740fd4badd5ce3fa68657134d	2018-01-10 22:28:45.884237+08
308	66	6111114	0	0	\N	\N	\N	\N	\N
309	66	6111115	1	0	\N	\N	\N	\N	\N
310	66	6111113	2	0	\N	\N	\N	\N	\N
311	66	6111111	3	0	\N	\N	\N	\N	\N
312	66	6111113	5	0	\N	\N	\N	\N	\N
313	66	1011121	6	0	\N	\N	\N	\N	\N
314	66	1011120	7	0	\N	\N	\N	\N	\N
315	77	6111113	0	0	\N	\N	\N	\N	\N
316	77	6111114	0	0	\N	\N	\N	\N	\N
317	77	6111115	1	0	\N	\N	\N	\N	\N
318	77	6111113	2	0	\N	\N	\N	\N	\N
319	77	6111111	3	0	\N	\N	\N	\N	\N
320	77	6111113	5	0	\N	\N	\N	\N	\N
321	77	1011121	6	0	\N	\N	\N	\N	\N
322	77	1011120	7	0	\N	\N	\N	\N	\N
323	74	6111113	0	0	\N	\N	\N	\N	\N
324	74	6111114	0	0	\N	\N	\N	\N	\N
325	74	6111115	1	0	\N	\N	\N	\N	\N
326	74	6111113	2	0	\N	\N	\N	\N	\N
327	74	6111111	3	0	\N	\N	\N	\N	\N
328	74	6111113	5	0	\N	\N	\N	\N	\N
26	17	1111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	9527937751085d55a225d64b9268d231159fbbaa44121338816f06761a8680ac9357cbe010d531e16916837fbe331a5abd2eba17f631ac9846be7f2007af13521c0618e0b4a9f193bfad38dad3228d701e7e6ace1ab99f96c2c7217d5c58ffa7c3cbf07622d102e5ca139a73a2ec49360b30707740fd4badd5ce3fa68657134d	2018-01-10 22:28:45.884237+08
120	6	1111113	2	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	59dba6fdb8feddf286c612731cef50afde0a3ee4929cfc8635d135a979723fd39c92b4bb8622704b52d314a4c89de288999d13c9f07942dc7fe819e7613925b126f3d0d99b524666d95b13822b732cb426b3cbee62cc8d848d03e5eb3be56f3c8ddb097d6639571b03fb3c533f8153e955cd16bab298748ea36e97d861bd09b0	2018-01-10 22:28:57.032957+08
122	6	1111113	5	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	59dba6fdb8feddf286c612731cef50afde0a3ee4929cfc8635d135a979723fd39c92b4bb8622704b52d314a4c89de288999d13c9f07942dc7fe819e7613925b126f3d0d99b524666d95b13822b732cb426b3cbee62cc8d848d03e5eb3be56f3c8ddb097d6639571b03fb3c533f8153e955cd16bab298748ea36e97d861bd09b0	2018-01-10 22:28:57.032957+08
162	118	1111113	2	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	09845944c7708bca0c0c9c7beed48960b6056b547f6558423904d54fd91590fa8ef8cbc2cc073dd56bbc321091b817f3a1aee0fdf9d88a4a3d63c7508b8b67ea98345a8963c25e71c485356c323911cfbf74c6eae1e9b9b75f3a86aca7fc16e3aa5cc37faf111ce0a12f593010fa3a500350fd5e386a82cb0052160e499a581e	2018-01-10 22:29:03.210866+08
164	118	1111113	5	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	09845944c7708bca0c0c9c7beed48960b6056b547f6558423904d54fd91590fa8ef8cbc2cc073dd56bbc321091b817f3a1aee0fdf9d88a4a3d63c7508b8b67ea98345a8963c25e71c485356c323911cfbf74c6eae1e9b9b75f3a86aca7fc16e3aa5cc37faf111ce0a12f593010fa3a500350fd5e386a82cb0052160e499a581e	2018-01-10 22:29:03.210866+08
214	5	2011111	4	0	\N	\N	\N	\N	\N
329	74	1011121	6	0	\N	\N	\N	\N	\N
330	74	1011120	7	0	\N	\N	\N	\N	\N
4	8	1111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	996936326ceb8c58622a453d570f61b04e2d656183d0f654066c2572334cb7bba5f07d0852592a593e3dc97cd661cc10dd64bde5e263cc13f9bf187a394888605f65a7dfa18510cae3e89eb30acbda17e8ffd4c84198c5ffbc404a565d3ecde8cbf9cdca44fb49483386a6ee730cb087e93422532ef7e6f3ab6645b7f0717774	2018-01-10 22:29:29.230508+08
18	13	1111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	19c311ff2b60ff04219c05ecdc440aef7652c555bb33f3e382cae341b2001130adca16afda7656cd3ea743a3f91686d0faa9e986e8df9ca1d85c588bc3067dcf58b40eaa1495e714cb1889f1c4370bf013de319780b3ccf108576f201d93cef5527e870b200de8f682445b8903d4b6c20cb132eb948d8a1e5bd256c5c6cb6391	2018-01-10 22:29:36.673564+08
25	17	1111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	92f92c704840bbe109845c985d0da672a6e008b6b8a9da1debdde0aaf7e844f2b1f0ad4dfcd37b57676c52f3cd073e0e7cfa4771cd9413ae68b46f5bf3b4e2265957912cbaa3e21f03d0074b9474fbc083131d0fe8aff36ebf1cc6c817cfb79719886e969da8061e79fdb5f96a9a25468abb866eb25c9d6868cc3601cbd01bff	2018-01-10 22:29:42.736276+08
121	6	1111111	3	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	182513d19b134df3264ec1550ee39e1a5a1c3e458e92e99f437412240624bdc6cf60a499bd893a345eada5b24a396aa3d74e9789d509fb4181fbafed4973f389af71bd57a0dfb7ccf01822da7f9ef6d7a47f461f6e2cec87b177ec5392ddad1b52bd4554b9f48aac2d665a4f68dc9f87e1941cd3dc21d07550195453e852534c	2018-01-10 22:29:48.036591+08
331	45	6111114	0	0	\N	\N	\N	\N	\N
332	45	6111115	1	0	\N	\N	\N	\N	\N
333	45	6111113	2	0	\N	\N	\N	\N	\N
334	45	6111111	3	0	\N	\N	\N	\N	\N
335	45	6111113	5	0	\N	\N	\N	\N	\N
336	45	1011121	6	0	\N	\N	\N	\N	\N
337	45	1011120	7	0	\N	\N	\N	\N	\N
36	8	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	733f0a4bb55450fa2ba28a18848ecbdfd094af069ea8ddb99b9adfbe961cb04bbbe2c4a387296239fb2dc5bc0160e22e4803cee3c3328fb53988efe5c56a8d56013a3628e5b73eafdb8e79b7213baeacc07f67a90ef4ba9b1f9d90e7052b6d5adad4aa7ded65b46bc6d8118b2f49a7c3037693ecdad05a01f0d34c0a78c20b4e	2018-01-10 22:30:16.894918+08
53	13	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	5b451a5d48edc0874d16f4ffbdb3e0d25fc8fa5bed0bc6f6a6a553f3a26d4033f51e12606d7106e53f9445db23eb776d758e792ed67e8f13f5b0c618e60a5b6db115842c418eb85c6dfa18632ddf0ad73cb1ec95fb9bdbee733e0a74ab2d6468f6b46617e89bd6cfcf6fccc495afb1bfde7974df41f8a6df379f95531b0f287d	2018-01-10 22:30:26.774521+08
55	17	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	70adfabb1d7c7a8f8554916c125e8a6fe14b377fe2f57076156b4b38e1cfc74b63e18f580fa84a9f8ff8a7be55794f9dcd7516660261a84ef2e1dd8ac3b07e8a9a5685c717660f0b4a3653a2149ef3b34270778f570dd27b7183c33a8381446844ed9500370d9de67fa8b0b28cbde625a811f0d8d6be7780487df5d6094089a3	2018-01-10 22:30:34.502023+08
220	9	1011121	6	0	\N	\N	\N	\N	\N
221	9	1011120	7	0	\N	\N	\N	\N	\N
228	12	1011121	6	0	\N	\N	\N	\N	\N
229	12	1011120	7	0	\N	\N	\N	\N	\N
233	28	7111111	3	0	\N	\N	\N	\N	\N
235	28	1011121	6	0	\N	\N	\N	\N	\N
236	28	1011120	7	0	\N	\N	\N	\N	\N
125	6	2011111	4	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4ddb722be660fa643d668202db2a90ff5979914cb69e7776f691325261aebdaa962de09c9a1d8209af726e5a9433ecc2a64821d1b07f5177bcca7f88289105dca59d7981b52adc08b9216b186f5ec5f6aaff73cb7d16168c9480b073db0f0d17e22e8de44916478e458fdd1cd4cb296b20bf0aa90e2f338ba25c590920378840	2018-01-10 22:31:00.840826+08
167	118	2011111	4	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	15b452d0ded52a52e95da0cf5faba6a592196d8e6fb35be08d369d3646a04512fab8de84a126931e29ff3ac288bfbb0f1113b11fe1413b51c32f7be62f290f77d38c32cbc954007899c14a8b740175d0cd3d216b2a0035724b3d7d2a2f4f5c1a0a5adbbc9eb737816557f6c648c31b02e727f05bdb47cf12ae9198a3897a093d	2018-01-10 22:31:13.487678+08
237	9	2011111	4	0	\N	\N	\N	\N	\N
6	8	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	83850d182104f7eba30624a6727e8a2b63a30276381a1c4be4744757375a495828d75469239edf9d8fab95bb9389740aff41b8aedaae297c37f6600c6529c26dbc12a0bfde21b322690fb238416454a30929ecddde6b6da3b10b10cfb9a5623f53875bca782103daa4afeec02008ed08e5d1f1f1ca788c809c6a413fc4462e1a	2018-01-10 22:32:01.981255+08
20	13	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0a561da5cc0fec34a517a46cb838817f3763fd7bf9d32987fc1e295107bb42fee262c43753f786779d448bc193f87a5fdfe4b503584828b11ab4b90be595aff67f88d735c7c75ed94fbf33b13c7753514980dc9e1eaf928c6eabbe0e5fc4975e5fa786cf556aab0f075a8488e61e11a36639a23155bfb1816f54ab514db44fdb	2018-01-10 22:32:09.026228+08
27	17	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	53ecaba51664838e1f365a6a594b585c658a444fdbfca8648bebae9ba8096c4d53fd5cbe5f57366367310a40969f2e06beb22e47f067dcb1723e632ed5f2ec8e82b348160d8c7915623170ee574cc19f015334cd5bc0437b6504d6c75f084505b81b4bddc258679e02e0200429ca422eaf8e018af1eb756fa3a65edcbd55a532	2018-01-10 22:32:14.763724+08
165	118	1011121	6	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	311e77423a7b44bfe1aa399ec1fd28d61c8efc6f24453037a2f38bd6fd53728c11fe337bd3a9bd4acec5f18000175a2f7b4fd43de4371b2ac052bfa691a1809854c48893a80f1688c9bc611d29645b6d1b48b10a27649e80abb9bcf2b0dc4d888c29172dd9972c4ec588bc38a8ae7ea5437f928c1b6f075d24c448de6cd76529	2018-01-10 22:32:26.983463+08
123	6	1011121	6	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	49bd422e4c3ff1540b798d6af56047e7eb5197442be2ac5fe6bd57a184bfa83e6906842bb64ce7a0c4f1ea11958b0b11326474a06c7dffa3c55445e603432561c835909847c0361f0d3def95566af8a2a02fd28753176793ab2b4092e3f38a95d0cf9461b37b3799e1c5aefdd8740b9f94ea4ab215f37b9692eb2f9daaff5a1f	2018-01-10 22:32:36.892704+08
7	8	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Inconsistent data", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 1, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 8, "Objectives": ["To teach participants concepts and skills supplementary to those learned in class", "To further solidify concepts participants learned in their class", "To help participants develop relevant skills that could supplement lessons learned in the classroom"], "Strategies": "Connecting Java to MySQL", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "prayer", "Sequence": 3, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "03:00 PM", "Activity": "acs", "Sequence": 4, "StartTime": "02:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 1, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "345567.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	60591aebc37d5ff24963b4388439a08f5f3f840b5fbe9b2cbf6dc5e6cd4c8d4205e85cf362f284d31bae914cf4e6cebfe037c1c88360d1ba9c18e05df5bfc5c4193a123aceca2696a711ccfade78327cf8495889b1fb5d04cf5a0f444da3ea945c6bce5e2813fee800257154d2809491059556d5cb9c3405eeb3aac96107cb93	2018-01-10 22:33:49.412298+08
21	13	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Bad UI design", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 13, "Objectives": ["To teach students skills that cannot be learned inside the classroom", "To broaden the knowledge of the participants on the possibilities in mobile application development", "To teach the participants of the importance of UI Design is not only for aesthetic purposes but also for flexibility and usability"], "Strategies": "Mobile UI Seminar", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Act", "PersonInCharge": {"IDNumber": 1111114}}, {"Date": "Feb 12, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Lunch", "Sequence": 2, "StartTime": "01:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 3, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "343657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3e5ed681c37cf7979865d4d14945634701bca613fb67c798c1226bd35f65fd2732c54ec8e187fbeb41e1515f4f4f687c2b2d50b57006ce139de9cd731527f57dddb181ab2140f0052627486b13fc3f8ffb2cfc8a85940d10c6e2f7bd0a4b57106c2b7431e1f597660b8ec4ce2b86d01d125ef07b0064927b1f7cf39f3b7c6329	2018-01-10 22:33:57.618223+08
28	17	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "Competitive CCS", "Expenses": [{"Type": "Food Expense", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 17, "Objectives": ["To be able to challenge members to think critically whilst under pressure", "To be able to promote competitive programming amongst the organization's members", "To be able to provide an entertaining activity with a unique twist to improve member interest in organizational activities"], "Strategies": "Last Programmer Standing", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 4111112}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 13, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prater", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 4, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "342657.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	89188f34e14956fca066e7fa85114a0b1e4fd636cbcc717b44fffad732536b96b2cfe081796fda59de6e9356f70298e2a21304d2aaaf379e6fb52e049042e28d60f05fe592ef452ee26d73a095463eb39734a0cf3b1985fb6d287a058964202acbcda121e7ab9b4f519a68802745bec2a1f26886dff11235ee3d78800c913cb6	2018-01-10 22:34:03.785532+08
344	22	1011121	6	0	\N	\N	\N	\N	\N
345	22	1011120	7	0	\N	\N	\N	\N	\N
346	69	3111114	0	0	\N	\N	\N	\N	\N
347	69	3111115	1	0	\N	\N	\N	\N	\N
348	69	3111113	2	0	\N	\N	\N	\N	\N
349	69	3111111	3	0	\N	\N	\N	\N	\N
350	69	3111113	5	0	\N	\N	\N	\N	\N
351	69	1011121	6	0	\N	\N	\N	\N	\N
352	69	1011120	7	0	\N	\N	\N	\N	\N
353	22	2011111	4	0	\N	\N	\N	\N	\N
166	118	1011120	7	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Camaraderie", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 118, "Objectives": ["To be able to look back on the activities of the organization for the year", "To be able to recognize outstanding officers", "To help the students get a grasp of the culture in CCS"], "Strategies": "General Assembly", "Organization": "La Salle Computer Society", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 25, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "asd", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 20, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "336467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	12621b8b1474a214803a3ea2cff59d38a64f39202b4fa267c22f2f12a0ac66c1751b62308b4543623bbb792670f73d30d3de3cebbb7630a7c8ee13d74a3c46abccd4b0158115e096013b243bf55d7982d0a2a6d6cc711b5791a260ee8272eedb18070d89828f39cf9ba76e51e5c023992566a9936401a7b8a16dfd0c5a3878ab	2018-01-10 22:34:14.743693+08
124	6	1011120	7	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Community Development", "Context": "some are computer illiterate", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 100, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 6, "Objectives": ["For Computer Studies students to be able to impart their knowledge on IT essentials to DLSU employee participants.", "For the participants to know the fundamentals and use of basic software productivity tools limited to Microsoft (MS) Word, MS Powerpoint, MS Excel, Google Drive and Google Docs only.", "For the participants to know the uses of the taught productivity tools and how they can be integrated to their everyday tasks or jobs."], "Strategies": "Computer Literacy Program", "Organization": "La Salle Computer Society", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Opening", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 1111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 15, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "337467.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8e5b584e8a4c520f0c3679aff6eba6884e0a03bd41194779e35c8494c89df705cf8452baf303b7b5d1d3c389b71dab97e410dad5098a6f4d0c172eafb9c6997b788fdaf40b73ddf62fc0055ed4a47a9cdf9786db3e8aed1872df44c3bdc9c31b751cecc7ec5cc11d92fe2612b3b742a14a50243e6bf489fd16e6afd0009ad0dc	2018-01-10 22:34:24.601347+08
44	7	4111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3a8db45a58db5c03ba306f78855945c84b71b5eb0982c84a1fabb2d300ad65dcbdb4fe77d2275d825c9b12b319525a2a14bbae97a2a0a301ab7e477beced27de2ebb66ffd5732a0d849d882457aab8597ade9af4d221b9d7364bd09082656c966a7d96a9e522a3ad622d49faf76649608f2d1b6aec5f1a7104cde7de0bc63912	2018-01-10 22:35:29.908096+08
191	29	4111114	0	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6c944be8b28b6c01b1219d793d080298d678bfb668a36ba4612edf5a1aaf7e5818ee34f0f0458cd906a59c3320f9b02a59da4b8bd713925d823eddb0139dad06a4cf430c5af8847d19cc772ed71563e3997b3287c0248fa0a06c1254f8f5a0d17e40da0e764cc3f80d7e98df3664dd3bd53d052385ddbeb1a23207baa7e74a51	2018-01-10 22:35:36.51746+08
238	83	2011111	4	0	\N	\N	\N	\N	\N
239	12	2011111	4	0	\N	\N	\N	\N	\N
354	69	2011111	4	0	\N	\N	\N	\N	\N
101	11	4111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	95c0af5246b8ac9f25663043edc4bb17ac650dee8169dd7b4d50775b447cc18afc6e2eecd9e082b8ce4df1a42fae423eb0d3b0440b575f447abd6391d39606400dde01bef96988c66b54353ff6d6dc0ea9ed86f4fa008fe97f96bcbaa34e8a82d37551a93e22a8f2cc3c84f177313f7fa9e362b65f6df2948140e5de1a50d300	2018-01-10 22:39:35.764203+08
45	7	4111115	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8eef35c889c8bc2d5457a03365ec448fee0c4d793bf109cf499426f9357175598436b53302e3da759e981566b01dfd3b4aa0ee64597e8d7c0a78e2efd73479edb5182ea79407fc3f4dcc0463c8bf39d54af53f5d6de5334cc75efd1d47e05c8dbcdf393c3d2da6135f3f130e66a64117f81494234ec689f3759ecf3a074c1770	2018-01-10 22:39:47.668878+08
46	7	4111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8eef35c889c8bc2d5457a03365ec448fee0c4d793bf109cf499426f9357175598436b53302e3da759e981566b01dfd3b4aa0ee64597e8d7c0a78e2efd73479edb5182ea79407fc3f4dcc0463c8bf39d54af53f5d6de5334cc75efd1d47e05c8dbcdf393c3d2da6135f3f130e66a64117f81494234ec689f3759ecf3a074c1770	2018-01-10 22:39:47.668878+08
192	29	4111115	1	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3b045146292d61a95d5da114d8fb1c8eeaa83246f387f720541609ba516211b4809692df563f34ff855d896bd18aa39ebb7a1b2ebb9f5332219a23f2fd3c19e9c796269c934bbba1243b999b9dd235fc9c38b70f1e6875fdee4f4f3cec270db9de63f5b0d8c31addef5fd9cf0f4b89e6df71bab23cbfc0050a2f468805127d94	2018-01-10 22:49:46.560311+08
240	85	10111114	0	0	\N	\N	\N	\N	\N
241	85	10111115	1	0	\N	\N	\N	\N	\N
242	85	10111113	2	0	\N	\N	\N	\N	\N
243	85	10111111	3	0	\N	\N	\N	\N	\N
244	85	10111113	5	0	\N	\N	\N	\N	\N
245	85	1011121	6	0	\N	\N	\N	\N	\N
246	85	1011120	7	0	\N	\N	\N	\N	\N
47	7	4111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	034932bcb9e4c2aab8733b37637e082dcad2e032408aff1de86cf8f9f3979c59a96dd05ed102aabe6aa373ba24d4ef1daa1bed7f3ffec06eaa128e801dfc3e1cd4dbfe49da370afd8e2ddaf8927edf9d3257577ae76be6770b7c86b29a3faaea52f39fba9bd9653f3bbe470fbb5741c5a1f006c0d0352d45a0a25cd5058a305c	2018-01-10 22:50:33.522682+08
49	7	4111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	034932bcb9e4c2aab8733b37637e082dcad2e032408aff1de86cf8f9f3979c59a96dd05ed102aabe6aa373ba24d4ef1daa1bed7f3ffec06eaa128e801dfc3e1cd4dbfe49da370afd8e2ddaf8927edf9d3257577ae76be6770b7c86b29a3faaea52f39fba9bd9653f3bbe470fbb5741c5a1f006c0d0352d45a0a25cd5058a305c	2018-01-10 22:50:33.522682+08
193	29	4111113	2	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	796a7952db85834b34375460f5702f40b0c859009d87121f2c483d0a2235892a7d6a6751c659175daa7251b44b8bf8635439d8834dc25b31cf578fefb1d60f2c73d83aa6356dc64e26614c629a5d10fd7bb5b76940733d328a54ad6281bbcadb1f81422b98d9e2f5fb2f4e90d8188039860c876b5490980c72c0760684300c8b	2018-01-10 22:50:39.776868+08
195	29	4111113	5	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	796a7952db85834b34375460f5702f40b0c859009d87121f2c483d0a2235892a7d6a6751c659175daa7251b44b8bf8635439d8834dc25b31cf578fefb1d60f2c73d83aa6356dc64e26614c629a5d10fd7bb5b76940733d328a54ad6281bbcadb1f81422b98d9e2f5fb2f4e90d8188039860c876b5490980c72c0760684300c8b	2018-01-10 22:50:39.776868+08
102	11	4111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03a4712306cf3ec1b994d05a08fe4e8d0a68a2572739144bf9a72469f02c33aafc95fd552b9c561910515ebfa9a48df5c434c6739604d9403a5c1fa021871c30a7c1d8e33e9eab1d82692ab2d123904f3f2f078ef7c20e62508f2e9aa6925b311acdfdd2563a410db029936695cb201ab5d2be79ca8e38021b36c4b772d52f8c	2018-01-10 22:50:46.207977+08
104	11	4111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03a4712306cf3ec1b994d05a08fe4e8d0a68a2572739144bf9a72469f02c33aafc95fd552b9c561910515ebfa9a48df5c434c6739604d9403a5c1fa021871c30a7c1d8e33e9eab1d82692ab2d123904f3f2f078ef7c20e62508f2e9aa6925b311acdfdd2563a410db029936695cb201ab5d2be79ca8e38021b36c4b772d52f8c	2018-01-10 22:50:46.207977+08
48	7	4111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	402a74320b5bdb103fca200999f12ffafb9491df44e33aeb9498f015f24139bb95d80dd8c4a1b44622931b6dc958247afc0818a8e6da11fd1d743d93f1e6564d5d09b215d50f9150ae3fdc8c2adbea2fd36e617e31a39f26308c4a91a6d0a2dcc4a0370347fd7f531599419dbcade69304a4875a75a2623692b8a8198b72b717	2018-01-10 22:52:01.098885+08
103	11	4111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	580d6f2da1c7273967548dcc0e97e9b78c920da8cc1804fca54df02ce7b3a0f9d3018b774d22f96e81d38f372449f32e13123e057b623d74828bb9da16f9f84011edd56a77695caffbf1cd1b0198c7aa115d80787be20e44478d993962882e143bd6ae3133fe8e5f44f27a44eb6e2dabeb3cce81e110ee9c33fb718231c0d31c	2018-01-10 22:52:06.049687+08
194	29	4111111	3	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3d80304687148e0de8601bdadbbd5d9da649951e4ca4b82a8b551395087bb792eaa2350201166dcf987a98fa55dc207025753e3951f2b3fa442a8bcc1e2faac6b4fd80d24ff3df27420b9ed1cfd5cda2f6ea1c56310280f92ced4deb6e8c61289d8075500f9b9e6521b648aad98868db5e96992860cb604d398bf6b746bcb239	2018-01-10 22:52:12.409895+08
247	85	2011111	4	0	\N	\N	\N	\N	\N
199	29	2011111	4	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2413b2edf305f72842c289a90b3a8e163796df68cec168672de7b601c5a28ca16ec6693080608e4945fd7d2ab465d64ed99288c68e6e62edbf693fee17efcd3e71d1a15fb950ddef03742d4c30b6a3a911f088d3c03790b98b224beb78dda0f2f59b125fdeb6aefe43c7e571fee2cf929798cd3266251aa3cb894a4b4e4a5d73	2018-01-10 22:54:43.9707+08
64	7	2011112	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	1f3de3fd5c40c785ebaba61423ca662bae9f8e62c4876a2b0d5dabdf837cca61ff5b73f796c4356ad7f6db51de010c4ddbba8600f0757454d7224acba0e28546544efea465988e4450669051a5dc6ffc6fe2278c469e9bc32378c988dccd8cd55eecdf46b30e843d01392562d8ff81c0164d364f2eabac09ab5d91eef6e91bdf	2018-01-10 22:55:40.647559+08
117	11	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	a9e0153004043a84102f353ab997e54922df0342ea5a73533c0aaa5eb97a80f31a0a774f85fb84cda94c0966e0f882262f57c0d6b742c5af9484985b5bf2e42085d7bf3675e04cd6f6cc202bbe45b75b5235d20d77715b4efbd5a5c135f6186f32a5b15369318caba6e9c4338ac0d02b83a66211e0243f4b259fd1897264bab9	2018-01-10 22:56:06.016824+08
248	86	10111114	0	0	\N	\N	\N	\N	\N
249	86	10111115	1	0	\N	\N	\N	\N	\N
250	86	10111113	2	0	\N	\N	\N	\N	\N
251	86	10111111	3	0	\N	\N	\N	\N	\N
252	86	10111113	5	0	\N	\N	\N	\N	\N
253	86	1011121	6	0	\N	\N	\N	\N	\N
254	86	1011120	7	0	\N	\N	\N	\N	\N
262	86	2011111	4	0	\N	\N	\N	\N	\N
134	14	4111112	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	30d5263216ec3729285727b56e0f5eb610eb762600126160c527524e5828c325f4a4bc2b6859549feeefcfaf2435761307a8f51e4f0012944609aa748fd79ccef897b2922b2e0487c44e8ae7c5e6444f551ccdf2eb8bdcbb06f2ae8fd36a5aad84559e31fdf4b057454110e6e0d056b58809c529759af37447ec186b8af224da	2018-01-10 23:05:42.636546+08
135	14	4111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	552fde778577c05753fae965630f71463b363fc891059f7ec70c3e920cbe659e4264e8321e63756d73616d6828b9ab7a53aa558c12cc5e9056184c32d98b7a1655a963ff46e55b3bc62a2ddbeaad19451c99c95d2a2ab817613bf61a14ca84aa974aa9305a2986032ae98dc5c0c00e0346bb607f59c1bc9bfe49f4a3bc685e98	2018-01-10 23:10:17.18273+08
263	62	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	829e75c5f871c73993dc898be91e1cd425419a230e09dffefc9202d9133486fb3e58986e37294c6969abf1aec854821a5391852141e7124696ab3ac59a90e1e387ff0b4072a1cd030c5b472b7447aaf65ab4aa9d09e359db3652eba52c1e28ec2854df3937197b0f9656217abd7ec024a315dbe07ee290ff131edca8f20fa7ee	2018-01-10 23:46:21.265278+08
136	14	4111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	39e1e1ce4d45bf1fd27f32ff502ce0ca3070bb5e7fc3365b7a48a484a468b0634e10c2e5392966aeff280ed28d96e95d172dbe9d94b5bc3fb7c1e211201e52ba198fa57027d5da13d477c93e56fd3549cde6796d6187d8d8ec1983ac1234be43b562639137d67824d225bab7233ae1e989898d5b5362b1f8adc711f82ba725ac	2018-01-10 23:11:09.712001+08
137	14	4111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7b13c039b3543c54e167c30a75b36a5cc554992ac950e978ed484bb664c5266c25e8ad9d51c645e59c10a40746afc177b6c09c5c23719a5934f3f54c0ec56b3780dbec626852aea51a135e3c4417f17abb1ca78cb6c3d2d75362b73310e41f3cda5877ca440e9d7a3aab10ceee4e68541e0b2ed00a17d7e0f67e0a552800c0e8	2018-01-10 23:12:05.182561+08
139	14	4111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7b13c039b3543c54e167c30a75b36a5cc554992ac950e978ed484bb664c5266c25e8ad9d51c645e59c10a40746afc177b6c09c5c23719a5934f3f54c0ec56b3780dbec626852aea51a135e3c4417f17abb1ca78cb6c3d2d75362b73310e41f3cda5877ca440e9d7a3aab10ceee4e68541e0b2ed00a17d7e0f67e0a552800c0e8	2018-01-10 23:12:05.182561+08
138	14	4111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	619b648f1117b5391b0d4704257aa671143d70a57047c9a1a60af8c5e87c89cc2750b643e880a28757a52942e8d471f3a78635fb0e88dd1bcfe964319c04ef8fc21cee763f722ecdca82d2cc27514f722959a8b4ff47e74bb8e5b2f17a648be9d0e5833246bac345d390db56e6b5496681e68e445b061e91670d1bf39c69fdab	2018-01-10 23:12:35.383056+08
142	14	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	14c0df2c14df33535e57c7bfcb4cd5b1a8afb95afccc7c58f9e80189ca543a032cbfdab121f2c6d0be7442b2a7ea9d023592d6527bad549b432513fef830e1c488c0284e24cfd5cb3d1a951e21abea4e386ef7102e7d64819d13dc4ec53ec1893fb7977ce95e19c9bc1d1ab11224416af50364ea8a49da24052de0f35fb8488f	2018-01-10 23:13:11.833808+08
140	14	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 409 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}], "ActivityID": 14, "Objectives": ["To introduce the participants to advanced Photoshop concepts", " To teach participants advanced concepts of art", "To encourage the participants to learn advanced art techniques"], "Strategies": "Photoshop Series 3: Advanced", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Tell the participants of the activities for the day", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "Teach the students an advanced lesson about photoshop", "PersonInCharge": {"IDNumber": 4111112}}, {"Date": "Mar 09, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "The students practice what they learned", "PersonInCharge": {"IDNumber": 4111112}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 17, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307944.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	108bd0fda79439a1452f0a38aecc49c6f6fc5f545f34e8863f5250cce546037b8d6aeb038e951d7bf831530291d4865be07b969acb61939b9f9aa26586cc6ab4b02c44d0f727414014bcdb6144e76394af280888cc94da237291a36b4740a8bf2715015ac87f65d1809e1f1bb369b5e85fb6dba945974159427ce1b8c638c175	2018-01-10 23:16:19.751948+08
272	67	3111114	0	0	\N	\N	\N	\N	\N
273	67	3111115	1	0	\N	\N	\N	\N	\N
274	67	3111113	2	0	\N	\N	\N	\N	\N
275	67	3111111	3	0	\N	\N	\N	\N	\N
276	67	3111113	5	0	\N	\N	\N	\N	\N
277	67	1011121	6	0	\N	\N	\N	\N	\N
278	67	1011120	7	0	\N	\N	\N	\N	\N
279	28	2011112	4	0	\N	\N	\N	\N	\N
284	25	7111111	3	0	\N	\N	\N	\N	\N
286	25	1011121	6	0	\N	\N	\N	\N	\N
287	25	1011120	7	0	\N	\N	\N	\N	\N
288	67	2011111	4	0	\N	\N	\N	\N	\N
105	11	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Classroom", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.\\r\\n", "Expenses": [{"Type": "Honorarium", "Material": "Token  of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1200.00"}, {"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 2, "UnitCost": "50.00"}], "ActivityID": 11, "Objectives": ["To introduce the participants to intermediate Photoshop concepts", "To teach participants intermediate concepts of art", "To encourage the participants to learn intermediate art techniques"], "Strategies": "Photoshop Series 2: Intermediate", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "12:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Orientation of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop lesson", "Sequence": 2, "StartTime": "12:15 PM", "Description": "The students are given a lesson on how to use photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Feb 02, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "Students practice what they learned through exercises", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 13, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "310644.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	417e424e10616668494edc1587236b8ec692e550e6e657dc018956393dbb8fe25be3b0fc463f093495c7c8805a895e8b53443a3e4c3ba562c585ebfc1e7c0f18335cb6044602577cb9e84255ac61b2b379755522e033fd1066bd2f380af7abc40f2052347083c9dcc78958b0b0fbaa9ba959c61079d8a635baa468bfbfe741fe	2018-01-10 23:20:44.335746+08
50	7	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Y 407 Seminar Room", "Nature": "Special Interest", "Context": "The activity teaches students about Photoshop which could help translate what they want to portray. Photoshop enables them to have another way of expressing and visualizing their message.", "Expenses": [{"Type": "Honorarium", "Material": "Token of Appreciation", "Quantity": 1, "Sequence": 1, "UnitCost": "1500.00"}, {"Type": "Food Expense", "Material": "Food for participants", "Quantity": 40, "Sequence": 2, "UnitCost": "40.00"}], "ActivityID": 7, "Objectives": ["To introduce the participants to basic Photoshop concepts", "To teach participants new concepts of art", "To encourage the participants to learn new art techniques"], "Strategies": "Photoshop Series 1: Basic", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 4111114}, {"IDNumber": 4111115}], "ProgramDesign": [{"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "01:15 PM", "Activity": "Orientation", "Sequence": 1, "StartTime": "01:00 PM", "Description": "Participants will be briefed of the activities for the day", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Photoshop Basics", "Sequence": 2, "StartTime": "01:15 PM", "Description": "Participants are taught how to use Photoshop", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 26, 2018", "DayID": 0, "EndTime": "04:30 PM", "Activity": "Exercises", "Sequence": 3, "StartTime": "04:00 PM", "Description": "They are given exercises to practice what they learned", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 7, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0a2cd4f4b112287244ee56a1278e066b91efa4de90da48fbc892bc234ef40ab67b8f2ff0303158fdf094fc758d9d9de503c510efe94847c8218e5f75959dd48968f7377073b092df5d2c605cb68e922b3038561cebbe9757c51c9456d8db5022fd4f97ed20ada2800e89aac20b27a563bf816a1ffc085a1327f5b52acd67fd6b	2018-01-10 23:21:01.65747+08
196	29	1011121	6	1	\N	\N	{"Type": "General Assembly", "Venue": "Classroom (Full-size)", "Nature": "Organizational Development", "Context": "Decrease quality of student leaders", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 30, "Sequence": 1, "UnitCost": "40.00"}], "ActivityID": 29, "Objectives": ["To introduce the members to the organization's mission vision and purpose", "To increase awareness on the concerns of the organization", "To allow the members to know one another"], "Strategies": "MooMedia: 1st General Assembly", "Organization": "Moo Media", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "09:30 AM", "Activity": "Introduction", "Sequence": 1, "StartTime": "09:00 AM", "Description": "The organization officers introduce themselves and tell their objectives for the term", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "10:30 AM", "Activity": "Games", "Sequence": 2, "StartTime": "09:30 AM", "Description": "A game is played to capture the attention of the participants and keep them engaged throughout", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Briefing ", "Sequence": 3, "StartTime": "10:30 AM", "Description": "The officers explains their plans for the term and ask for feedback from the members", "PersonInCharge": {"IDNumber": 4111114}}, {"Date": "Jan 29, 2018", "DayID": 0, "EndTime": "12:30 PM", "Activity": "Lunch", "Sequence": 4, "StartTime": "12:00 PM", "Description": "The attendees are given food", "PersonInCharge": {"IDNumber": 4111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 24, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306744.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	022b71b5b2a00432a9430c7617caab688cea87270057d1451d1847e41d114629af0088c97b8a85bb4d41da7f274eab5c8e8d3e578365f4051499eeda1bc885321c108df6197e17d62c712a7477f7d83de736238727b75b0c3c482e9d0fd946b22c2eaaf1047c5ac959f082dcd1bb09210a6e567469d0ba1af07fcb438459ef40	2018-01-10 23:21:15.345432+08
297	35	6111112	0	0	\N	\N	\N	\N	\N
298	35	6111113	0	0	\N	\N	\N	\N	\N
299	35	6111114	0	0	\N	\N	\N	\N	\N
300	35	6111115	1	0	\N	\N	\N	\N	\N
301	35	6111113	2	0	\N	\N	\N	\N	\N
302	35	6111111	3	0	\N	\N	\N	\N	\N
303	35	6111113	5	0	\N	\N	\N	\N	\N
304	35	1011121	6	0	\N	\N	\N	\N	\N
305	35	1011120	7	0	\N	\N	\N	\N	\N
306	25	2011111	4	0	\N	\N	\N	\N	\N
307	66	6111113	0	0	\N	\N	\N	\N	\N
56	24	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	248fd8111a222121594c047307db969eae543112091f61048f95188621f83b9521a0af811334035e347bd61d752980d66b0a564b4bf84ae813ba8a64c9192cba1e55f0d9a95b3fadfccb6e7f1339466cc25eef73effe454898cc933a4c82b134d2761b6f85095e37d0e70cba9f4ad10a1660e6a145c719bdfbfec089f1859375	2018-01-10 23:28:48.565324+08
107	27	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1505-A Conference Room", "Nature": "Academic", "Context": "La Sallians are ignorant of going green", "Expenses": [{"Type": "Honorarium", "Material": "Jollibee Chicken joi", "Quantity": 2, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 27, "Objectives": ["To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh", "To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action", "Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"], "Strategies": "#ECOTalks 1: I am a Lasallian, I am PRO Green\\"", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Feb 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Discussion", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 14, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308400.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6f3b9f0e87b96ae7b2f861e9f618c620fe20c632c595ea7fa049817107bc6b9a65cc7dafe9e498c357d0f24992cb24b8c0a9140a225ed89ba233d134b653c4466e45bceba99fd3d58266ccb2c938de15263d0640fb345f7431c53c0e4902ec4d794579b7c3851060c17eedfb0bce50d6fef6527ef13d9eeefa9a60abced2b100	2018-01-10 23:28:55.225093+08
143	3	7111114	0	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Fundraising", "Context": "The lack of functioning members of society", "Expenses": [{"Type": "Others", "Material": "Confetti", "Quantity": 67, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 3, "Objectives": ["To showcase the nature, mission-vision, activities and programs of the organization", "To recruite new members from both STC and Taft campus as well as membership renewal for old members", "To increase the organizational funds through membership fee "], "Strategies": "Annual Recruitment Week", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 11, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Booth Manning", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 18, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308370.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7766c412a005c52f8fa97f58f745b305e2d04f4e7d7535aa07d97f0d7f7577762fa4bcfd1efb42808e4bdbeea595b6bee7f50049f994595cbc48bbe3e8531c455b62b3a7e7ba1154b96393bf9040c56e59c69998b29bad6a79c808e76e311d5f2f864cfa8c6749b2bea8e7ae244f230ce48fc27cde1c2851ca6f0be7b1f0f577	2018-01-10 23:29:01.660409+08
355	72	3111114	0	0	\N	\N	\N	\N	\N
356	72	3111115	1	0	\N	\N	\N	\N	\N
357	72	3111113	2	0	\N	\N	\N	\N	\N
358	72	3111111	3	0	\N	\N	\N	\N	\N
359	72	3111113	5	0	\N	\N	\N	\N	\N
360	72	1011121	6	0	\N	\N	\N	\N	\N
361	72	1011120	7	0	\N	\N	\N	\N	\N
207	5	7111114	0	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Unity of the organization", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 4, "Sequence": 1, "UnitCost": "156.00"}], "ActivityID": 5, "Objectives": ["(1) To provide avenue for the member to know more of nature, mission-vision, activities, programs and other relevant matters concerning the organization;  ", "To formally turn-over the office to the new set of officers and to recognize the old officers of the organization", "To create friendship and interaction between the members of the organization"], "Strategies": "1st General Assembly and Turn-over Ceremony", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Assembly", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Awarding of Officers", "Sequence": 2, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 26, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307365.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	72da0a9fd72c16f1aef8a8c3b98549fd3c599accd6f5f321679f5d0ff00b41622bc880800934ef6c431724b015d8d926a7af504cf797c840076ee57d6362addadec209b4fb23ae8e456ba36e75f1f3920592c1bddc6e6b14dbe89525e9492e1bc647b55c76715771a362993e6d897c2a944432d41f9d0f8314e49d2e5d45820c	2018-01-10 23:29:06.549234+08
222	12	7111114	0	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	500a438412ab8e827dd62a61af02722034dea1cf4d24338bcc859e5b1202566786771d136ff9b5fa5e8523aeff5f30e8275272f45cc0c73d6a293cf4ac9e7e2bd6b613c943dd4e9dcf919e316441480f008bf07f58b037daa314ee64606466f5d3e64e6e7b9b19144f8d66b99bc48288d271f05572b13853fee12dd642ee0fd0	2018-01-10 23:29:11.076183+08
362	90	10111114	0	0	\N	\N	\N	\N	\N
363	90	10111116	0	0	\N	\N	\N	\N	\N
364	90	10111115	1	0	\N	\N	\N	\N	\N
365	90	10111113	2	0	\N	\N	\N	\N	\N
366	90	10111111	3	0	\N	\N	\N	\N	\N
367	90	10111113	5	0	\N	\N	\N	\N	\N
368	90	1011121	6	0	\N	\N	\N	\N	\N
369	90	1011120	7	0	\N	\N	\N	\N	\N
215	9	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Not enough team building", "Expenses": [{"Type": "Food Expense", "Material": "Jollibee Chicken joi", "Quantity": 50, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 9, "Objectives": ["To establish camaraderie between members", "To build one community of ECO"], "Strategies": "Let's ECO: An ECO Team Building", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}, {"IDNumber": 10111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Event proper", "Sequence": 1, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Clean-up", "Sequence": 2, "StartTime": "04:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Intro", "Sequence": 3, "StartTime": "01:29 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 27, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	959a26fcaa4e360965ab067269f4305479355f0b8d0be56dd84ee2b9ca8f50afb4ac0256ff6cc8b36b63b8857fd48e9b2d4d8bb21d5550d1a361e0ec1092f869c246bd7277a5175b6f7d1850d9ca009b5345c692c3b47754e3e14bcfb193b909d5a1465902b486c201f04f62e881b5ee9d71fb95e7afe89e86ce1e374fef1bf7	2018-01-10 23:29:20.602851+08
230	28	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Br. Gabriel Connon Conference Room SPS 201", "Nature": "Academic", "Context": "Engineers are ignorant of environmental concenrs", "Expenses": [{"Type": "Cash Prize", "Material": "Uncle John's Fried Chicken", "Quantity": 5, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 28, "Objectives": ["To increase the awareness of engineering students on environmental issues", "To create an avenue for students wherein they can gather ideas in creating innovative things which can help in aiding the environmental problems", " To create sustainable projects in the future projects of DLSU Engineering Students"], "Strategies": "#ECOTalks 2: \\"Engineers on Environment Protection and Sustainability\\" (In Partnership with GCOE STCG)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Focus group discussion", "Sequence": 1, "StartTime": "09:15 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 29, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300791.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	78e55b3a8a94695071ece130a6c1f73797507a08d37c7e9a408630d26a77cf86f36733ac943cbeb2066291c63a2f1ed11d9f10cbfc5cb7b1d5e1d475145264551d7385211bd0cb9cf0b90e04548398113395b2c5d287b5b86ad036bb4afe30f963bfc3785b9881382d54034935f6c494d10fa078e2f79893c5492782fb9eecc0	2018-01-10 23:29:27.253151+08
370	90	2011112	4	0	\N	\N	\N	\N	\N
371	72	2011111	4	0	\N	\N	\N	\N	\N
280	25	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, ", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 1, "Sequence": 1, "UnitCost": "51.00"}, {"Type": "Others", "Material": "Confetti", "Quantity": 1, "Sequence": 2, "UnitCost": "25.00"}], "ActivityID": 25, "Objectives": ["To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity", "To identify areas on campus that serves as habitat for the bird", "To instill awareness to the community on the importance of the ecosystem and the environment"], "Strategies": "All Forms of Life is Important: Bird Race", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 24, 2018", "DayID": 0, "EndTime": "02:30 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}, {"Date": "Jan 25, 2018", "DayID": 1, "EndTime": "02:10 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 35, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300716.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	195dd98bd5d21450949ed924110067de16e5c56d27562f83f2c962db628677892b2c572d16ff2c6700274ed1ae8246463852e13bd71be3c76fae8925112dc5a0e1c470bd24febf124be47986fe11977436c41eaf6996d35748fbb8b7d250d1b2883cdc23894a0706787542f0863cfb8b14cfb04c686537ccff6847724f8d3f5a	2018-01-10 23:29:49.083928+08
338	22	7111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0b24de138d074ece1c113ccd2a18e575c25f1e5d3ba37c7e43ace2c0f549e1e74150f15cd5d36a286c3fc7489002451f262408bd09f79a7f128f7ceaa1dfcf05615ae8274b857b50bca4f3bac35857a1bcaf375e513689f60060a3916f63865f2a7a461f943a03cdeeba71da92c2efd501139c14fafbee66a4a11db5d1abb597	2018-01-10 23:29:58.087256+08
373	75	3111115	1	0	\N	\N	\N	\N	\N
374	75	3111113	2	0	\N	\N	\N	\N	\N
375	75	3111111	3	0	\N	\N	\N	\N	\N
376	75	3111113	5	0	\N	\N	\N	\N	\N
377	75	1011121	6	0	\N	\N	\N	\N	\N
378	75	1011120	7	0	\N	\N	\N	\N	\N
57	24	7111116	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	012f0daae688fb4486d44ed5ffefa2a877ab379f28f987f814d89d1110a7f319a92983116e0dc40f108d31dd6ff5c305e7e6e82afa070e2b6a8e47d7bd1b5bf4baafffecdad91ab07972a2e12decd77b30c1ba6b6d8d75c8c117238f8f85a3741584ba94c9a0ad20f629846349b2e5cec0be18b2e6e3c2d223d2aaed1f9db4ec	2018-01-10 23:31:36.34168+08
379	75	2011111	4	0	\N	\N	\N	\N	\N
108	27	7111116	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1505-A Conference Room", "Nature": "Academic", "Context": "La Sallians are ignorant of going green", "Expenses": [{"Type": "Honorarium", "Material": "Jollibee Chicken joi", "Quantity": 2, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 27, "Objectives": ["To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh", "To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action", "Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"], "Strategies": "#ECOTalks 1: I am a Lasallian, I am PRO Green\\"", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Feb 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Discussion", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 14, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308400.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	1faef6344e732255a6c9b4e71a185acc2f441884732a05501a98b2df1125503ff8112c151d052429be946013fed249cd40be04f388d4ce1351e1cf24d59d7762e92781e30efb0f6b46abf247998306c43ca4a0cc02e2d2707d6d8f509ed572041d89e096a973e85a79e8e969483a552e7055ac80ed911b632e1e4e50792f3600	2018-01-10 23:31:54.392335+08
144	3	7111116	0	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Fundraising", "Context": "The lack of functioning members of society", "Expenses": [{"Type": "Others", "Material": "Confetti", "Quantity": 67, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 3, "Objectives": ["To showcase the nature, mission-vision, activities and programs of the organization", "To recruite new members from both STC and Taft campus as well as membership renewal for old members", "To increase the organizational funds through membership fee "], "Strategies": "Annual Recruitment Week", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 11, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Booth Manning", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 18, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308370.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6ac1b88269fc0a043f45f0651d6117ffd25e501a0dd67ed9f8be9da56094382a9753c7586db536a8475c2ed69e83ad262b4b62c8b070c24daa7e0d52d63ecdec6e856d878f20ec9c6b04c456d26123de3128e901b4facb6903bd2815d3332e0cd864553df188aeba4573b39b59f35e94867d6c0f6ac2c813544d9b1f08bbe68f	2018-01-10 23:32:06.3853+08
372	75	3111114	0	2	Fix expense	{"Revenue and Expense Table"}	\N	\N	\N
223	12	7111116	0	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	02c327b0e309844e97d46a93595d978adc6d289ee2c862db47520e25fee08d9235be171ae5c3acd2e1857332bb0e693684f29879885e1ca35757209872c858caedaa27e3b542245b160bc2b97fb6378dce6009b77f400da11af79ae2ed73dabecf4b0dd90de585c5ff3d1e34309cee87be2bb173d22dc2118ec83992c53aff50	2018-01-10 23:32:20.527616+08
281	25	7111116	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, ", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 1, "Sequence": 1, "UnitCost": "51.00"}, {"Type": "Others", "Material": "Confetti", "Quantity": 1, "Sequence": 2, "UnitCost": "25.00"}], "ActivityID": 25, "Objectives": ["To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity", "To identify areas on campus that serves as habitat for the bird", "To instill awareness to the community on the importance of the ecosystem and the environment"], "Strategies": "All Forms of Life is Important: Bird Race", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 24, 2018", "DayID": 0, "EndTime": "02:30 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}, {"Date": "Jan 25, 2018", "DayID": 1, "EndTime": "02:10 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 35, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300716.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6f42ff1de848630a6a7bfd2e0f358747f647fadfbb7f12a292bb3da7bf30f695fde6fb9acedc33ff600933a5050d6e577bb55e41afb47fa3d2319b6f0663a769d120ca5ec2ffe08e7b4b0ec586ecfa2f947086a3c8cf4f33ff6e0d3758f585c5eb6b655199520b51ea0701bda95b2752563dc10cedb8054caf247d1220381cce	2018-01-10 23:32:37.409996+08
339	22	7111116	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	62e6cfd6fa896bc2f8d8db69bcfd10d591b8499644aa1efd7eaee861d5f22557824b1e42dbbac561bd106db64128a6afb5e3f57e6078e62132122c306d5a5052d6ec902fefca3ce2310c4d49e2da11a6401872e91ceca691c109167a0cc759de27a189f9a2ad5462b667d566e8e2ad434a2193284cff0bc5501766091451e2c6	2018-01-10 23:32:51.593804+08
58	24	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7604ef678475d9f271d1720c1c091f8e410c28f90b27ba90de54d705c24fe7f3b3f3f15cb56c58456a1e547ee92f3c15419a252cbc18010e3c8914dba2e0046509d6f9bf4d7c1b3fa3627174f5775e63308b6f520c4a5d49343c1eec8af08c3621cb6095d8ab795713751d6318ebaede33eb32359dc6076ae133e60251209992	2018-01-10 23:35:42.500249+08
396	61	3111114	0	0	\N	\N	\N	\N	\N
397	61	3111115	1	0	\N	\N	\N	\N	\N
398	61	3111113	2	0	\N	\N	\N	\N	\N
399	61	3111111	3	0	\N	\N	\N	\N	\N
400	61	3111113	5	0	\N	\N	\N	\N	\N
401	61	1011121	6	0	\N	\N	\N	\N	\N
402	61	1011120	7	0	\N	\N	\N	\N	\N
109	27	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1505-A Conference Room", "Nature": "Academic", "Context": "La Sallians are ignorant of going green", "Expenses": [{"Type": "Honorarium", "Material": "Jollibee Chicken joi", "Quantity": 2, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 27, "Objectives": ["To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh", "To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action", "Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"], "Strategies": "#ECOTalks 1: I am a Lasallian, I am PRO Green\\"", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Feb 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Discussion", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 14, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308400.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4d10a1ef917c8454dc97b96252e7dc0ee1b8ee8a2b4cdcffd69f69b384a40c0d1ea4f5c5ffe4724167362545de0ae0c9cdaf81a45e4b23253c6c808de0ed23aab5a66a95513e50fc0055d7d9839ea1aceb9593895afe1e4f33f84d43542c0126468afaa269df0b9f0252834d964b6ce306b473e436ec3ef1d09c0045e9ba73b1	2018-01-10 23:37:21.109529+08
208	5	7111115	1	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Unity of the organization", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 4, "Sequence": 1, "UnitCost": "156.00"}], "ActivityID": 5, "Objectives": ["(1) To provide avenue for the member to know more of nature, mission-vision, activities, programs and other relevant matters concerning the organization;  ", "To formally turn-over the office to the new set of officers and to recognize the old officers of the organization", "To create friendship and interaction between the members of the organization"], "Strategies": "1st General Assembly and Turn-over Ceremony", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Assembly", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Awarding of Officers", "Sequence": 2, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 26, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307365.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7d3e9304b07d1ebfd8f2fa933883313544e568ef00d07b928e123a5f2c1e7065956fc8b1e562af9f2bfe20a7ef7860978ed582f136549cb6d8611926792580d057561b1dd1fbd46576fd445044771f8b0011b25aba054050a32ca4f7a3d6073380f05d25a5dd60b49488956b3e011e4c107fc5dfe5e52ee8544ca6fee7bd07f9	2018-01-10 23:37:36.211277+08
145	3	7111115	1	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Fundraising", "Context": "The lack of functioning members of society", "Expenses": [{"Type": "Others", "Material": "Confetti", "Quantity": 67, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 3, "Objectives": ["To showcase the nature, mission-vision, activities and programs of the organization", "To recruite new members from both STC and Taft campus as well as membership renewal for old members", "To increase the organizational funds through membership fee "], "Strategies": "Annual Recruitment Week", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 11, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Booth Manning", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 18, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308370.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	d70ba7fa5d4e0aecb109d6e25f77a2cfab63d690dbd08f318343a433b96f1e24ce927f28876bf650aad77cb453cfb32fe2a697a3fdf43c432ceebee7e4f65b11f27d13aad4d7b47e1baef6ff351f93f43cd668d0b75b75ba2104ab1dc51e9d02a43404bfabe7d01e27c8bd56a3d64567e757df6363b01059a29246110ddf6211	2018-01-10 23:37:37.555569+08
216	9	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Not enough team building", "Expenses": [{"Type": "Food Expense", "Material": "Jollibee Chicken joi", "Quantity": 50, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 9, "Objectives": ["To establish camaraderie between members", "To build one community of ECO"], "Strategies": "Let's ECO: An ECO Team Building", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}, {"IDNumber": 10111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Event proper", "Sequence": 1, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Clean-up", "Sequence": 2, "StartTime": "04:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Intro", "Sequence": 3, "StartTime": "01:29 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 27, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	11fe3d2abc2c4447277a22d13ed41618a7a6645caa0aea8f41f0ed78c845ecd93435d879fc7d16fb5dc59e2bb05c30cdbeb3f4eb60369a1858e3ffdf5533310a6df4750dfd4afd45df0c5f0e924f52df314c3d57a6d3620966d4ad18b1a4db516794ca0c2c68586ab72ab92ba0b8a9341d695f499b32bd4c2109712731c390d8	2018-01-10 23:37:47.967895+08
224	12	7111115	1	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	cfb398c40d26dc28bdc39374c4998b40de8a33384f4d702d55f1ca21500aba51560ff1aa6e0f412dc1381f5e99c365f09b84b8943b2ee0d721a2c4e5977e16121ef614477c64c2edff91907ee3a0085124d647b402797874bcf182474884c74bdcb00474c834c54a80760a8c04afba30c170d28c2593441e5d424f9f284eb353	2018-01-10 23:37:51.067257+08
403	61	2011111	4	0	\N	\N	\N	\N	\N
231	28	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Br. Gabriel Connon Conference Room SPS 201", "Nature": "Academic", "Context": "Engineers are ignorant of environmental concenrs", "Expenses": [{"Type": "Cash Prize", "Material": "Uncle John's Fried Chicken", "Quantity": 5, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 28, "Objectives": ["To increase the awareness of engineering students on environmental issues", "To create an avenue for students wherein they can gather ideas in creating innovative things which can help in aiding the environmental problems", " To create sustainable projects in the future projects of DLSU Engineering Students"], "Strategies": "#ECOTalks 2: \\"Engineers on Environment Protection and Sustainability\\" (In Partnership with GCOE STCG)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Focus group discussion", "Sequence": 1, "StartTime": "09:15 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 29, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300791.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	c2d9903f049b783da9c4c7caa731f07bb5478719a6dd8e6bf8483494653cefb5d0bfcf26377c0cdb49ab0e6b1711f0f46227726e1268d51afb897cb23cd744b74dbf2690e7c9932b9ed89bbe12863d5bbdc292aaae28672ea751d6fbc3d49722ed778b78ad19923fdc4365e348c44a241e71bdefbacb2c60efe5a3a141080103	2018-01-10 23:37:53.889675+08
282	25	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, ", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 1, "Sequence": 1, "UnitCost": "51.00"}, {"Type": "Others", "Material": "Confetti", "Quantity": 1, "Sequence": 2, "UnitCost": "25.00"}], "ActivityID": 25, "Objectives": ["To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity", "To identify areas on campus that serves as habitat for the bird", "To instill awareness to the community on the importance of the ecosystem and the environment"], "Strategies": "All Forms of Life is Important: Bird Race", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 24, 2018", "DayID": 0, "EndTime": "02:30 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}, {"Date": "Jan 25, 2018", "DayID": 1, "EndTime": "02:10 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 35, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300716.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	9c207ca2820bb70ebf5114a3837791afe51747ce975751b45c6ee6e1ee77e89d2613bdad35db98827168ea25e2e53ea1166b5c59a6f497bf6f5b69855ca6eb0912a131c4dd32f0b76fe85a03531814fd4dec77a20bf0f991ba473b667c0cb054c8a057ba36dd928cfa97b6645611966e8e84840fcf8bf107716a476356a83fe9	2018-01-10 23:37:55.263668+08
404	88	10111114	0	0	\N	\N	\N	\N	\N
405	88	10111116	0	0	\N	\N	\N	\N	\N
406	88	10111115	1	0	\N	\N	\N	\N	\N
407	88	10111113	2	0	\N	\N	\N	\N	\N
408	88	10111111	3	0	\N	\N	\N	\N	\N
409	88	10111113	5	0	\N	\N	\N	\N	\N
410	88	1011121	6	0	\N	\N	\N	\N	\N
411	88	1011120	7	0	\N	\N	\N	\N	\N
289	68	3111114	0	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	429911b4d35cf800e10179826f0a24c2b09052d8fd4c0ab54398340ab418c4e3eded9dfe776b316aa4013da8fbd0a5329740c2956f6a68e46eacb25521bd33ed00cee39ae82b197338c218235f89f67c926f3abca95a8891534a311f549884190650aba8d39d5cafaeef4d2f5dac6f3ffa9cc7c8161e8366b75dacbae8af2299	2018-01-10 23:39:01.40132+08
255	62	3111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03e8623ec1800879ac028f647903453df42e3fd1c72126af9d455c1727ba1556ded156f85d3fc41385f565832b34b5e9eae9f443d3b757a5a1077a40d64373da39693296271d8969ecb7159273d1aaa401866ec3adf99786999d559a249417843b34dfb3fa534c21fb74f52f957125665e33452954697e7485f76f295eda7bd0	2018-01-10 23:39:12.085312+08
264	64	3111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8af66df2e9ebac2975500553ab404e143a9c3b46888df12d8262e2bc5680de8b240ad5eaf363ea30c7ea8471d5df9586a30e6d605579a9ea088c3603b095e584c9ae793b348c7ace9cfd25f2d596e57b854635be3190e5bd0e62111ccae85fab1792dc748046a1a494d248ceb337b56a9b41665797ec132c1a1634c302e98785	2018-01-10 23:39:18.565573+08
388	81	3111114	0	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4dcfc9d37e07c417df90316f625039577eef8f9654bdb5ec89ced40faedfcfc10f1c26a8d5214113ee0dce23d4f95f63b8fd174852fd2d9c05668bfe409cde3e0d2d5fab16a22ca66bffd523dcb63d18631153c0e2cc855fb7d26efea36c62329ff221b87aa5c14f3e534787ef5699c3731ecd8472fc5b2a7f92ea42a7153566	2018-01-10 23:39:25.523906+08
380	79	3111114	0	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	12caf6c06bf712664424ff64899b8b871e1106494f3c14c3db0c72a4ef91311e016c64a3e6f1db943924a5777c5457dba3d87cdcc3f3ec76158e6eef8ae48a51d0ad29b4d941e98fab3e92201e558c3aabe4614e192a7c5dd696f0cdb936d48695b8b6e23d2f5412034ca25527a188b847dcaee8ed14eb824b236cceb0b5854d	2018-01-10 23:39:30.944282+08
412	88	2011111	4	0	\N	\N	\N	\N	\N
340	22	7111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2eb84c0227edc7faa32142a038c0bb82645ba851c3842ebce29b0117d43f96f667d20fe4445af3a44e21c40a4e9dd7883fab8af9a9081be7d0e25a4a596675b5ede77f7bbcc353c3c94f6dcfbc697d69feacade61b33ff34d0e40e6d9f21b931a153c099a8ddf53bfb6c2449e4c239680588dea20e60fd0560167e558d0cfb4d	2018-01-10 23:40:19.38983+08
256	62	3111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	1c5dee7422e2dcb6e3a8f0e0ec06b3bdcb566517febe2a1348c9bec5913b7c3343b37dbc4d238424f8452547e7d83e85cfc572527cab0109100dfc830a36f4f60fca9aefd07c385a5f9c016cb25d2ce2f1c79aba940f6feb4f4ba8678abb50a2933fe8734ade110c680152b5c685ccad5a7e3171af7ee438d3e5ed7496581661	2018-01-10 23:40:39.529133+08
265	64	3111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	98adfc5cf564ab81eda6f416fe946067dc81b34267aae0e89e3bee8b4f161a1288f1844f739a8b5bf17965af12c856a349abdeed5301da7bb985f0d029a9cc6a62ba79f4f37638a8a81e8871d7b4673e0ea719c2887f9bb8b920ef0e715f4727765e952e88167529c2c1ebc127f45a1d2ddf1a7e14b66809626342d466fb2884	2018-01-10 23:40:46.018122+08
290	68	3111115	1	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	518380ae399eb0b85eae706b28c2ff2b17c652c54d9c5f95f9314aca67ba204c0306d66f3877955dfbc0ba603e6c4004633e0668006564263ebfc468f9ea52931729bc99f5f3b40751de34d9b76f9f75975ffa3308a9150cb6bed43a26796e37f46c093bef6298516957acd2344f0040327cf310026fa9d5e88972128f0afc18	2018-01-10 23:41:00.328056+08
389	81	3111115	1	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	aa3b341a18d825a411705b95663338d3720839b4f2546abec71fe616fd3c10491a6ab9887c7682e83f029519498c0f933ccb4b6c0e225646157082f9510ca5880a9ada64d7e6ba8f967e85d27bdf37e90ee68cbbbfad007f5f3420281d9150ad9b88473df8fd313d693cd1e5c13b224edaca8dce5c32d53f2001629ce13795ec	2018-01-10 23:41:08.142198+08
381	79	3111115	1	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	668ee5011d642d2be6a0e1e21f8447ebeb30d03104b0aad63b1f6ffa022339efc435d13dd0a33c405f4ea8d57261ee188ee7e4068246bbf4dfaf16a43425ba4868a2f0653d53628821df6073471f012a539f5dccccc3d349bc011e71389003aeb692a269bf61c6db11579485a614cd2dab957d988fbd760e69b20d1cb08f686a	2018-01-10 23:41:15.815653+08
257	62	3111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	24e0fa6c51dc9df6f84b3b77b5fd1b1688cdc7df2a38385172b5af1ec44b8a317848044e5a5c9fdda68c750e4d4c1163589236e5ce153f3d1097651b352deba1f67e9a1ebba7ae86754290f8477225b01bf52454034cc71a05529fa88ea4f80b46b497548cba54b5e8b4a0ed6f99c5f8e774f8e4fa7dbc1b1694425f59a8a296	2018-01-10 23:42:21.525649+08
259	62	3111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	24e0fa6c51dc9df6f84b3b77b5fd1b1688cdc7df2a38385172b5af1ec44b8a317848044e5a5c9fdda68c750e4d4c1163589236e5ce153f3d1097651b352deba1f67e9a1ebba7ae86754290f8477225b01bf52454034cc71a05529fa88ea4f80b46b497548cba54b5e8b4a0ed6f99c5f8e774f8e4fa7dbc1b1694425f59a8a296	2018-01-10 23:42:21.525649+08
266	64	3111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4b6b73984c52caf4139d5b23d00ee1b1d726acef305bca55e7037a912c595cfc7ae6a7ab84be3ae0df96d297fb3fd42b3ed15d5ec4d8b9eca988f641e2713640723a07942d8ef2798fa53efbf59518c77b78385215a57ba709c53c36a636e741000c85b7e68aa1af15221b89fc0c1f94c16f90eab3b7f495c004d563bff402af	2018-01-10 23:42:29.188082+08
268	64	3111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4b6b73984c52caf4139d5b23d00ee1b1d726acef305bca55e7037a912c595cfc7ae6a7ab84be3ae0df96d297fb3fd42b3ed15d5ec4d8b9eca988f641e2713640723a07942d8ef2798fa53efbf59518c77b78385215a57ba709c53c36a636e741000c85b7e68aa1af15221b89fc0c1f94c16f90eab3b7f495c004d563bff402af	2018-01-10 23:42:29.188082+08
382	79	3111113	2	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8adc9d82dfc4662602256c5beee05b779077b8f21f1ee976e940c7699e73d19d4b8a2101462d5c141b5d517ea7c6dbe75be1a7130d956f7e6c93ff40d82b955c51c39a6f78045e03f596e34d271c9cdc0a10f08b9e37f7e24e3dc2855019fbdb9eda2c6b9b530426c7df7ab69ea92c2325f6137caa4716d2fdcf22b1ed28f2b6	2018-01-10 23:42:44.715666+08
384	79	3111113	5	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8adc9d82dfc4662602256c5beee05b779077b8f21f1ee976e940c7699e73d19d4b8a2101462d5c141b5d517ea7c6dbe75be1a7130d956f7e6c93ff40d82b955c51c39a6f78045e03f596e34d271c9cdc0a10f08b9e37f7e24e3dc2855019fbdb9eda2c6b9b530426c7df7ab69ea92c2325f6137caa4716d2fdcf22b1ed28f2b6	2018-01-10 23:42:44.715666+08
390	81	3111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	51afa18467efc72e524b957722ed83bfc16d0d48059de4642b8951f7abc1dea2a6bf6e26d0f09155987389937dfb886877d95187f5b199cd95037eee9a8f6b79dd39ea1afc2acfb99911c5e98307237be8b55b438fbd4e070c0cad259ce9ef6deea9bc3c0a7a3793977ca14977c71458a763d628ed88f38b091d64b93dd8b805	2018-01-10 23:42:56.042178+08
392	81	3111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	51afa18467efc72e524b957722ed83bfc16d0d48059de4642b8951f7abc1dea2a6bf6e26d0f09155987389937dfb886877d95187f5b199cd95037eee9a8f6b79dd39ea1afc2acfb99911c5e98307237be8b55b438fbd4e070c0cad259ce9ef6deea9bc3c0a7a3793977ca14977c71458a763d628ed88f38b091d64b93dd8b805	2018-01-10 23:42:56.042178+08
291	68	3111113	2	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0e2b110205586ea4129fd0788d83db0366884a58003e50cc697958ec946f40c4ee1994737fe9cc72d065059337e97c47b3b3e6c94bc795645c9d03cc355470d17009315dd867e0f08c8c4d379be0bdff8ae53859fbe53d9b7821b70fb380d2a3f90f51f3008cb80118c461e9f1b2bf4523b3b1d50533b54176cf3a158a3661a5	2018-01-10 23:43:06.381176+08
293	68	3111113	5	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0e2b110205586ea4129fd0788d83db0366884a58003e50cc697958ec946f40c4ee1994737fe9cc72d065059337e97c47b3b3e6c94bc795645c9d03cc355470d17009315dd867e0f08c8c4d379be0bdff8ae53859fbe53d9b7821b70fb380d2a3f90f51f3008cb80118c461e9f1b2bf4523b3b1d50533b54176cf3a158a3661a5	2018-01-10 23:43:06.381176+08
258	62	3111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	599c8716d6d12ea7c0d96e8ef1c11dd1a769c591b21136f790417b2a7f3bc2c238ffd18e148c62da4f82740a84c579b73980a47c3e1f0b138426f0bfe47cf0dad9a615e6c95ddcc80a18db057d12f642c379abc3a411eb7e82f4b07e42bbde11ff22b88e1b4aa55a488ea175dd0540c6656ffdf15e476a0c8d9b9aa2127b71a9	2018-01-10 23:43:25.249831+08
267	64	3111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	a86b78d7f23a55be58afc2fd8ea4df66c964fc35bf8216eb2b9d8a957a5135a716e91b843e408feeb7625b7a5342a09f08c8e12f373558ea66212092b51e5fc5855dabed4a9c7d9e361b354ca4b65f1c275147e27003f91bb6c8fb9e72da52ff9e5559f9947d742235e2fd49ba1542dff1f386d292d228a0a9de991c18cb748d	2018-01-10 23:43:30.318267+08
383	79	3111111	3	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	26940713db3e184e25c32ce17ede49133a1629138851a65d1819b78e8d6daa951cc9e17a38d5802755da144e6c0ac8895f6d15af18f9d5a0e20153ce3bd982ad3a88885d0d58a3506c37942bfaa7ee21bd7da74194487a161f8c2eb96aee40db0dab757cf6b9855847ab3110599746c9988cd09ad6c19ff0cf238bcce31f692e	2018-01-10 23:43:43.757673+08
391	81	3111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8814ddf2e0f0a47288e76eed16a94339aa32cd536848f5bf1270043290a4b0cea753dc03d922cc209205c555f774d71dc4efbb71fe653125f4ce6503e8fe8901d77db3b72448f3fae48c6d04d9c5df3609680fdedca2b295c76b9f3c17f2a0fbbba21f462dbc6e804e4359fff61c3388c171ad4a796c0e81459a19e77dd8bab6	2018-01-10 23:43:49.985341+08
292	68	3111111	3	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	231115f4592a37945a2fa467d43c8ce864c1ebbe6db1d7bc0bc9f34e14890ba7b30ddb0916ea67c4b6c75a269e1b5ecf74b1bce4f15e517727455d6949e7e1827d9ef9d3fa227207e9fd71337e5128a69d75a317bf7a0ecc274ec72df34a091552788fc2dd231570ce4529774f7af828322060a79736d2af2e2d8397d7908ee2	2018-01-10 23:43:58.679661+08
225	12	7111113	2	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2a5def1410f089334c54ead487d26b5b383e3b8f803842e50fdc9a96eee0871b2f6efef1efafad6f0b1ecc4bcb844e2f7bb1419b6033e39235c08a2cce08636850f9aa58a3f3625c30c145ba2ce3a333a5882ba7abe5917b79ab6af6d3d8e5a758300c78337ae218328be55cc9193fa7c93aed3ffec28c7b330da032a351bc5a	2018-01-10 23:46:28.332092+08
227	12	7111113	5	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2a5def1410f089334c54ead487d26b5b383e3b8f803842e50fdc9a96eee0871b2f6efef1efafad6f0b1ecc4bcb844e2f7bb1419b6033e39235c08a2cce08636850f9aa58a3f3625c30c145ba2ce3a333a5882ba7abe5917b79ab6af6d3d8e5a758300c78337ae218328be55cc9193fa7c93aed3ffec28c7b330da032a351bc5a	2018-01-10 23:46:28.332092+08
271	64	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	a1cbea3c266ea2120c3dd05419e21eddbfacde509257224ed4e2fb746bc59a32fc93b33e93f8ac26529925afb5608f6bef90df92449138fc632a52a6e55d6858a211c0b10eae12276fe40e5fe6c9ebb2b809209e2f2dd8d723f9ce206841c62210bbb745eabb32d0031ad34673d0ddcb5e6952ce718bf6f9f0c49d63f220e2d6	2018-01-10 23:46:28.389099+08
232	28	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Br. Gabriel Connon Conference Room SPS 201", "Nature": "Academic", "Context": "Engineers are ignorant of environmental concenrs", "Expenses": [{"Type": "Cash Prize", "Material": "Uncle John's Fried Chicken", "Quantity": 5, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 28, "Objectives": ["To increase the awareness of engineering students on environmental issues", "To create an avenue for students wherein they can gather ideas in creating innovative things which can help in aiding the environmental problems", " To create sustainable projects in the future projects of DLSU Engineering Students"], "Strategies": "#ECOTalks 2: \\"Engineers on Environment Protection and Sustainability\\" (In Partnership with GCOE STCG)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Focus group discussion", "Sequence": 1, "StartTime": "09:15 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 29, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300791.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7a52076f27bae5e0824ee953cc93c16385efe749fd9b180b4b6581241503df4695ace8034d3ba96f643aba7d4156c2bc2f9f25b03b857aa7cc5c7a28462e7b89b70399949de9e997525fe2d0168c3155ac32086d5c61e457d4ea116bd33879faface093bff88628cc9eca18e0c42446a96ed8cec08b0e04f7c073397382a8f7e	2018-01-10 23:46:33.926344+08
234	28	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "Br. Gabriel Connon Conference Room SPS 201", "Nature": "Academic", "Context": "Engineers are ignorant of environmental concenrs", "Expenses": [{"Type": "Cash Prize", "Material": "Uncle John's Fried Chicken", "Quantity": 5, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 28, "Objectives": ["To increase the awareness of engineering students on environmental issues", "To create an avenue for students wherein they can gather ideas in creating innovative things which can help in aiding the environmental problems", " To create sustainable projects in the future projects of DLSU Engineering Students"], "Strategies": "#ECOTalks 2: \\"Engineers on Environment Protection and Sustainability\\" (In Partnership with GCOE STCG)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}, {"IDNumber": 7111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "12:00 PM", "Activity": "Focus group discussion", "Sequence": 1, "StartTime": "09:15 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 29, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300791.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7a52076f27bae5e0824ee953cc93c16385efe749fd9b180b4b6581241503df4695ace8034d3ba96f643aba7d4156c2bc2f9f25b03b857aa7cc5c7a28462e7b89b70399949de9e997525fe2d0168c3155ac32086d5c61e457d4ea116bd33879faface093bff88628cc9eca18e0c42446a96ed8cec08b0e04f7c073397382a8f7e	2018-01-10 23:46:33.926344+08
341	22	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6276cb46cddefac0651655042e817fcaea0f95b405f0274da24594da81854895c5ef416f169edc59c595a262dfe1fffb25e2b6b30c67eaeb8811e2cd09d551d3b21a3c24a0e75a5d413d2a25c7ef784d52c8f12658c487bc6301b159171566eb735a241cf91b87adfc922a2725ab014a5d10620b5252b3b64ed1f58d720c62cb	2018-01-10 23:46:47.37911+08
395	81	2011111	4	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	851e9addb07dde561afef9719cfd41c60eddebd25a98569ac513cbf1b1f14057df1937b970c10e993576301da00aab04214ae2f421083681a3253c0d9a36f1cc2da3e1df8dd8d59071bfd363817db5e9365ad5f6a0f37a9ac81fcbd0f6c6f1cbfa77e662288c7ee99d0851ed689eb81f542df4773188a1db7a8a1ceb44b8700d	2018-01-10 23:46:51.526941+08
387	79	2011111	4	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	4f68115c4c785a356c5875282a0cc1bfc61d7ecf40b8cc83695b2804ec232ed74d0786a62481a6b65750be239e9ae611350bfc2d80bca5d794f4a3820d9dad1a12fc5fad40512660c5d6009593f02b23fc397c9bbe093e04fd4150c8919712bb5ea03f98a1073074ed53d9e327eda52ad3a38da2a10c095b72c61f429d838983	2018-01-10 23:46:42.553892+08
296	68	2011111	4	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	5224b14bc906e84a6ccb54b2637a8c21ad0b38f67f275d4236f040258b270150443addd2174aa1f3431ad94b92b6c0ac45eb6335beffe0d786decfb463209bcf115cee0b37baf16aa20225aa87867b62e8b66e09ab504a6ee796fc81849ad53fab48bf2b7e21d4a5f891010bfc45ae03bacd1ae2d48ea9f7ef904a1fbf1dffd5	2018-01-10 23:46:59.834345+08
343	22	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	6276cb46cddefac0651655042e817fcaea0f95b405f0274da24594da81854895c5ef416f169edc59c595a262dfe1fffb25e2b6b30c67eaeb8811e2cd09d551d3b21a3c24a0e75a5d413d2a25c7ef784d52c8f12658c487bc6301b159171566eb735a241cf91b87adfc922a2725ab014a5d10620b5252b3b64ed1f58d720c62cb	2018-01-10 23:46:47.37911+08
269	64	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	20ba15cd4c6c830b3188e35772ab294943834b211823b883248268c81baee11b9c269391b6f501d7532770e8c8c69a67c4027929a8247ada7d3d302b6a35fc5a09ea20ae7a71bd3262df0627465aed486026ede37d1de835dd97c0a2fbb88f41954ba6a0b0b3d3ec827e5e7959423ba77993251cba33ec351fb6af8109d21894	2018-01-10 23:48:04.200376+08
59	24	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	92a72b50f6f3ed0f1571378c4a60f303086bfafaf5e0de94d98b9b0a84eae809002ccf72b6150485afa988b3ab6e96decf3472b3e255e68e00da83ba21596b3e3cbb127f6af0eda3e289e53ffb927d292c33836dd379f8c0d12b0ff7ff710bc19300e37d1ef4b5fecf0abb8dfac68c6c93b126d98a32bf75bcd57c6d52b1ed60	2018-01-10 23:48:11.363916+08
61	24	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	92a72b50f6f3ed0f1571378c4a60f303086bfafaf5e0de94d98b9b0a84eae809002ccf72b6150485afa988b3ab6e96decf3472b3e255e68e00da83ba21596b3e3cbb127f6af0eda3e289e53ffb927d292c33836dd379f8c0d12b0ff7ff710bc19300e37d1ef4b5fecf0abb8dfac68c6c93b126d98a32bf75bcd57c6d52b1ed60	2018-01-10 23:48:11.363916+08
393	81	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	003f52c7c8cc09078dd937c98039e6c5568331b2ab2367379bcd933cc4cc2afaa8126d317b7ab4eeebf5d3b280dcb979022cac7da339459321ef0218ae15f7d406134106237723b401c9d011d0138d4f30fd745be212e9d2f3b36faa9b4e871f8eb80bb5519bad2749b1d2fd85d898e60f84647eaccec1959d93467614f19f0e	2018-01-10 23:48:16.245031+08
110	27	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1505-A Conference Room", "Nature": "Academic", "Context": "La Sallians are ignorant of going green", "Expenses": [{"Type": "Honorarium", "Material": "Jollibee Chicken joi", "Quantity": 2, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 27, "Objectives": ["To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh", "To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action", "Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"], "Strategies": "#ECOTalks 1: I am a Lasallian, I am PRO Green\\"", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Feb 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Discussion", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 14, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308400.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	541067ccdd921cc7aa0f552de4734229666b10a92f9c10a7ea1cc80c7394d89bec2028c7d18897b58e259e26e8491d5410de171a42fd1f8c190451793cf5983022591602852f31d6f35d3de8d07011ab3e3abddd0711839de5ecac22d7eadbd8d4a6c8c866c5b455f6d963c0bc99e89fba7cbc325e184dbe862df618896a7a9d	2018-01-10 23:48:26.640355+08
261	62	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2f932e6c840b51b6ef82e6b9e10f72b00038d3e8a391362f6e44e39033e3da17caefe70c1c9490a09e9e8b6dfe38cb655c66724601a38b25a2c500dc6b0a0fab7b4076b6c6c5b3301e84d19977633b321f4993ff46b1b8dc99c46fdb736173c00172914427d4988c6bdf00fe4b2f27036a6a53732eee26c21d9b6637fd4bd173	2018-01-10 23:48:56.780586+08
270	64	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Lack of summit", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 64, "Objectives": ["Train members in their respective department's operations."], "Strategies": "Operations Summit ", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 08, 2018", "DayID": 0, "EndTime": "01:01 PM", "Activity": "Activity", "Sequence": 1, "StartTime": "12:00 PM", "Description": "Desc", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 33, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "313253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	2c59f92da46b0e9a6f162168ef84de34c090247204ab8e6fbe33383b9b9904dc40f72470cafb1abebfe859796a45b32e5510993556bf4f1a21ace2f4dfa1275b8c62c2ce818928d1340b82943998734e8987d4420c2b2e9182a0895e6df35a69dff4573455b132088d9dc35fd1bb5263d5573f9cc6a9484ac2e406a9c66b1a69	2018-01-10 23:49:01.709665+08
394	81	1011120	7	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Special Interest", "Context": "organization of the track in their committee", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 81, "Objectives": ["Show the realities of being an OC", "Train aspiring OC"], "Strategies": "Organizing Committee Track", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 21, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 48, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	13a6ac95eb2d32787a7648af7faf9de8852ce8a4745984da28382cd596d2039d240ea2ef6fe97385850d65073ca64362c3300229fd817e329f2019e0202a632252523b3c445372fbd8f26a31418b7ad05358907176b9f490f6b15e33dca2279d11a8f97e74d85cc5c04023f976b87bc255396b10c3c9ad419945e48b67401be5	2018-01-10 23:49:08.678449+08
386	79	1011120	7	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	043afb9d490d7184cb7aa3b16074b22b62a2d3059a9dd49803c3b77e262bace51633f205ca642865d648c3d7d3e23a7b289172a155f39a5dd17e85c7f06e88b1c315defcea946e658ccb184fb7bc3472c827b770dc4057166d5e66dfa2174307c385bf259fb1725f64ba59503f275cd3ac12abd23224c2ed7d2112f9feadb358	2018-01-10 23:49:17.290922+08
295	68	1011120	7	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	70b2792d5387426322aca28cc076f9fe4ca65dd7975899f9667aa56c12e513ce54ce7ae41351cb5a130dde0eae465e6f823f2c8d90bae87aca62e8bcf19399a2ef0372f1e3f4eb6abd94263a302dee06036ee1c0e3fac05a93bc86c80da4aea57089269bd1480dceb1ad10d507bf6e37ae4bcf969c63b1323915d898c54da400	2018-01-10 23:49:31.430741+08
283	25	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, ", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 1, "Sequence": 1, "UnitCost": "51.00"}, {"Type": "Others", "Material": "Confetti", "Quantity": 1, "Sequence": 2, "UnitCost": "25.00"}], "ActivityID": 25, "Objectives": ["To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity", "To identify areas on campus that serves as habitat for the bird", "To instill awareness to the community on the importance of the ecosystem and the environment"], "Strategies": "All Forms of Life is Important: Bird Race", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 24, 2018", "DayID": 0, "EndTime": "02:30 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}, {"Date": "Jan 25, 2018", "DayID": 1, "EndTime": "02:10 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 35, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300716.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3901886844c1f0f7d5087b2f38abc4f9d41521f48c4ff95c06bce27ed0ec10602424eeeaf1f46be5b9c3b0a0e5f80d9dec298bc3ea3f254ff1e815c9680df8e7865af6b7b34eb4ca7014c3d804871aeec0236a7d0184a1bb8c4306b1666f8e125d207fe87c9c3ee6764b34ad2c8bd6c2825fd9a7fc3fcdc58d9c5cba1a4194ea	2018-01-10 23:47:20.193833+08
285	25	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Academic", "Context": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, ", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 1, "Sequence": 1, "UnitCost": "51.00"}, {"Type": "Others", "Material": "Confetti", "Quantity": 1, "Sequence": 2, "UnitCost": "25.00"}], "ActivityID": 25, "Objectives": ["To gather an inventory of migratory and resident birds on campus would be conducted in partnership with different organizations and Wild Bird Club of the Philippines through a fun bird race and birdwatching activity", "To identify areas on campus that serves as habitat for the bird", "To instill awareness to the community on the importance of the ecosystem and the environment"], "Strategies": "All Forms of Life is Important: Bird Race", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}], "ProgramDesign": [{"Date": "Jan 24, 2018", "DayID": 0, "EndTime": "02:30 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}, {"Date": "Jan 25, 2018", "DayID": 1, "EndTime": "02:10 PM", "Activity": "Event Proper", "Sequence": 1, "StartTime": "01:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 35, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300716.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3901886844c1f0f7d5087b2f38abc4f9d41521f48c4ff95c06bce27ed0ec10602424eeeaf1f46be5b9c3b0a0e5f80d9dec298bc3ea3f254ff1e815c9680df8e7865af6b7b34eb4ca7014c3d804871aeec0236a7d0184a1bb8c4306b1666f8e125d207fe87c9c3ee6764b34ad2c8bd6c2825fd9a7fc3fcdc58d9c5cba1a4194ea	2018-01-10 23:47:20.193833+08
260	62	1011121	6	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Talents are hidden", "Expenses": [{"Type": "Food Expense", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 62, "Objectives": ["Enhance talent management competency of the member."], "Strategies": "Talent Management", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 07, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Prayer", "Sequence": 1, "StartTime": "12:00 PM", "Description": "opening", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 32, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "314253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	49dfb204a4e1074ea5e6d3b2e90de84f63fb55d6401927407b6b86517abee323c133927e294ede0a0d18660104ff2c20cd52e610de02a08f17a35b39283956b6ca3208c2a908fdb353b4aa67e377b25c4a825206d424c24a3761ca8a97f4277ea428ce7c83fb668401701f5b24f619bb2b2bf64d4d408d224dae559a63d5d09e	2018-01-10 23:47:38.483128+08
294	68	1011121	6	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "They need to be aware of their env", "Expenses": [{"Type": "Others", "Material": "Food", "Quantity": 10, "Sequence": 1, "UnitCost": "10.00"}], "ActivityID": 68, "Objectives": [".To refresh the minds of the members and other participants about the current standing of the organization. "], "Strategies": "October - Local Committee Meeting", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Jan 14, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "Act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "prayer", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 36, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "311253.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	3fe50fbec2bc828b483c806f2c0fbe49ab5282786662b6cb5fa68dc7ffcb1060a61d0d293ee56cfb20dc46e0a232960d045281fc09610506a1f5f5d4e00f68cadce1d21036eaa422216ad8e18009f6c450de26d226116200c0763fd644a9c58dc220738a7f69111936d8cc08be4a3446545f0bbc21c801e203544883775b99b1	2018-01-10 23:47:47.182501+08
385	79	1011121	6	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "exposure to some international events", "Expenses": [{"Type": "Others", "Material": "food", "Quantity": 10, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 79, "Objectives": ["Raise awarness towards the Sustainable Development Goals", "Provide activities to actualize the different SDGs"], "Strategies": "Global Goals Weeks", "Organization": "AIESEC DLSU", "ProjectHeads": [], "ProgramDesign": [{"Date": "Feb 19, 2018", "DayID": 0, "EndTime": "01:00 PM", "Activity": "act", "Sequence": 1, "StartTime": "12:00 PM", "Description": "1123", "PersonInCharge": {"IDNumber": 3111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 47, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "309953.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	76c7d4d617e8b7a12a2d2b6b7714dd9a45073fa61b59d627d13e7b1f3fe1e3c72981b865fe592afb98e637b1f1388f789456a1f4958505820666cb28bc3be9eb6c3a5f9a162321dc43d4c19e7c26a9ba2cc10bd448684d80b672f483c6e51436aab194c40f07bf38401aed217741b170e99ea41c5b830c33aa46bcc59e28cee3	2018-01-10 23:47:54.328384+08
112	27	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1505-A Conference Room", "Nature": "Academic", "Context": "La Sallians are ignorant of going green", "Expenses": [{"Type": "Honorarium", "Material": "Jollibee Chicken joi", "Quantity": 2, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 27, "Objectives": ["To express support to the Climate Change Commission's  A One Million Filipino Youth Voices on Climate Action Campaign #NowPh", "To instill awareness to the DLSU community of the climate change and on how they can individually contribute to the call for Climate Action", "Gather at least 1 pledge per unit or department and creat a concrete plan to execute it"], "Strategies": "#ECOTalks 1: I am a Lasallian, I am PRO Green\\"", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 7111114}], "ProgramDesign": [{"Date": "Feb 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Discussion", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 14, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308400.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	541067ccdd921cc7aa0f552de4734229666b10a92f9c10a7ea1cc80c7394d89bec2028c7d18897b58e259e26e8491d5410de171a42fd1f8c190451793cf5983022591602852f31d6f35d3de8d07011ab3e3abddd0711839de5ecac22d7eadbd8d4a6c8c866c5b455f6d963c0bc99e89fba7cbc325e184dbe862df618896a7a9d	2018-01-10 23:48:26.640355+08
148	3	7111113	5	1	\N	\N	{"Type": "Recruitment/Audition", "Venue": "A 1502-A Conference Room", "Nature": "Fundraising", "Context": "The lack of functioning members of society", "Expenses": [{"Type": "Others", "Material": "Confetti", "Quantity": 67, "Sequence": 1, "UnitCost": "15.00"}], "ActivityID": 3, "Objectives": ["To showcase the nature, mission-vision, activities and programs of the organization", "To recruite new members from both STC and Taft campus as well as membership renewal for old members", "To increase the organizational funds through membership fee "], "Strategies": "Annual Recruitment Week", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 11, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Booth Manning", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 18, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308370.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03c58218d1c4f3fcea025be767acbb8211908ee77c6349210613e134bded5e2f9524ce946f5f0234685235836473428a30c8583f17632b960d01bdc80cd7f4858faf35476c90636ce944cfb72536e97c5c5f5e68c71bd0806bd97576a74c44079a2531ce9ae228b99d43948a4431827e7411e3f8b0be9ab40c15fb011b4e6c81	2018-01-10 23:48:33.087345+08
217	9	7111113	2	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Not enough team building", "Expenses": [{"Type": "Food Expense", "Material": "Jollibee Chicken joi", "Quantity": 50, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 9, "Objectives": ["To establish camaraderie between members", "To build one community of ECO"], "Strategies": "Let's ECO: An ECO Team Building", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}, {"IDNumber": 10111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Event proper", "Sequence": 1, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Clean-up", "Sequence": 2, "StartTime": "04:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Intro", "Sequence": 3, "StartTime": "01:29 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 27, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7df00b5fb23f48579a9d37d606349903d397f7f0df78be7e37751c00e60008084d3b8a15c0536a79ededd1cd93abf0474ca6a69005b3f743c87b174bc12cac279b56090809921ad215e7caed925311e5507ead9e60070adbb088667c18785cbf3eeffc62b3b7d1ddbaa94805b327576273fef9d084ec669a590a552e4f0d1171	2018-01-10 23:48:38.859701+08
219	9	7111113	5	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Not enough team building", "Expenses": [{"Type": "Food Expense", "Material": "Jollibee Chicken joi", "Quantity": 50, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 9, "Objectives": ["To establish camaraderie between members", "To build one community of ECO"], "Strategies": "Let's ECO: An ECO Team Building", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}, {"IDNumber": 10111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Event proper", "Sequence": 1, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Clean-up", "Sequence": 2, "StartTime": "04:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Intro", "Sequence": 3, "StartTime": "01:29 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 27, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	7df00b5fb23f48579a9d37d606349903d397f7f0df78be7e37751c00e60008084d3b8a15c0536a79ededd1cd93abf0474ca6a69005b3f743c87b174bc12cac279b56090809921ad215e7caed925311e5507ead9e60070adbb088667c18785cbf3eeffc62b3b7d1ddbaa94805b327576273fef9d084ec669a590a552e4f0d1171	2018-01-10 23:48:38.859701+08
209	5	7111113	2	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Unity of the organization", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 4, "Sequence": 1, "UnitCost": "156.00"}], "ActivityID": 5, "Objectives": ["(1) To provide avenue for the member to know more of nature, mission-vision, activities, programs and other relevant matters concerning the organization;  ", "To formally turn-over the office to the new set of officers and to recognize the old officers of the organization", "To create friendship and interaction between the members of the organization"], "Strategies": "1st General Assembly and Turn-over Ceremony", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Assembly", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Awarding of Officers", "Sequence": 2, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 26, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307365.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8c0342a241dd881f6c115d74df9a1e57005179d11f59b1e3bbad4ca7ba7870978fd0c4cc9353b9c0efee6bb81d79e7020eb20e71317689f51a283c2e12d7936c99916870e9b630c6b518e7a63957b2c077b6e7e03e3da1f789e536e9c49c2f609db234af7d21b6d43ff89bf5acac444945c148f49ce3b3d161795be13765d22d	2018-01-10 23:48:54.659542+08
211	5	7111113	5	1	\N	\N	{"Type": "General Assembly", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Unity of the organization", "Expenses": [{"Type": "Honorarium", "Material": "Cash Prize", "Quantity": 4, "Sequence": 1, "UnitCost": "156.00"}], "ActivityID": 5, "Objectives": ["(1) To provide avenue for the member to know more of nature, mission-vision, activities, programs and other relevant matters concerning the organization;  ", "To formally turn-over the office to the new set of officers and to recognize the old officers of the organization", "To create friendship and interaction between the members of the organization"], "Strategies": "1st General Assembly and Turn-over Ceremony", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Assembly", "Sequence": 1, "StartTime": "01:30 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 15, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Awarding of Officers", "Sequence": 2, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 26, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "307365.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	8c0342a241dd881f6c115d74df9a1e57005179d11f59b1e3bbad4ca7ba7870978fd0c4cc9353b9c0efee6bb81d79e7020eb20e71317689f51a283c2e12d7936c99916870e9b630c6b518e7a63957b2c077b6e7e03e3da1f789e536e9c49c2f609db234af7d21b6d43ff89bf5acac444945c148f49ce3b3d161795be13765d22d	2018-01-10 23:48:54.659542+08
218	9	7111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "Not enough team building", "Expenses": [{"Type": "Food Expense", "Material": "Jollibee Chicken joi", "Quantity": 50, "Sequence": 1, "UnitCost": "100.00"}], "ActivityID": 9, "Objectives": ["To establish camaraderie between members", "To build one community of ECO"], "Strategies": "Let's ECO: An ECO Team Building", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 10111114}, {"IDNumber": 10111116}], "ProgramDesign": [{"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "04:00 PM", "Activity": "Event proper", "Sequence": 1, "StartTime": "02:15 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "05:00 PM", "Activity": "Clean-up", "Sequence": 2, "StartTime": "04:00 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}, {"Date": "Jan 22, 2018", "DayID": 0, "EndTime": "02:00 PM", "Activity": "Intro", "Sequence": 3, "StartTime": "01:29 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111114}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 27, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "306741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	0410580c9ef5d98c4bd7108e5974b4ace81c7649bbf9f05ac97daca35490b1790ca49ac9e1ed16263715bcf33196dbcfe4205275f061588f40e602f4b774f1fa104986312db839f9b147e85bea7d87bafed339801ab1db6f241fe32d52d212d74441bb5084bbbfabe3004b5b8634560feb6d883b30c6923bd7e6339b950e8c9c	2018-01-10 23:50:24.156847+08
60	24	7111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "A 1502-A Conference Room", "Nature": "Organizational Development", "Context": "People are ignorant of different cultures", "Expenses": [{"Type": "Food Expense", "Material": "Booth Materials", "Quantity": 15, "Sequence": 1, "UnitCost": "5.00"}], "ActivityID": 24, "Objectives": ["To immerse members and volunteers to a community", " To be able to create a project that is specific to the needs of the community", "To partner and interact with the chosen community"], "Strategies": "E-Cultural Voyagers: A Community Engagement (Masid-Danas Phase)", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Feb 05, 2018", "DayID": 0, "EndTime": "01:10 PM", "Activity": "Rehearsal", "Sequence": 1, "StartTime": "01:05 PM", "Description": "Penchorn placement", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 8, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "308475.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	96068465ab630294263732e93c077982b3b9ef22cc6b3016dc1f3de3e66475f482aacd8b2e843fb6cc97ce3e2acae29ec348b92939cedab0f549aef874830f66c7635e3880feaca3701575e019f7462ebc5865fe92879a6ee8f95a8e156cc22d705497aea9b6bbe9fd5304ad7636c9fb921de3f99e1baab9b658bf2c96060074	2018-01-10 23:51:41.663459+08
342	22	7111111	3	1	\N	\N	{"Type": "Seminar/Workshop", "Venue": "9th Floor Gym(w/o Scoreboard)", "Nature": "Outreach", "Context": "People are ignorant of kids", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 55, "Sequence": 1, "UnitCost": "85.00"}], "ActivityID": 22, "Objectives": ["To provide an avenue wherein student can do community outreach programs", " To immerse the ECO Community to other issue advocacies that they can expand on"], "Strategies": "ECO Gives Back: A Christmas Celebration with the Kids", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 4111113}, {"IDNumber": 4111114}], "ProgramDesign": [{"Date": "Jan 31, 2018", "DayID": 0, "EndTime": "06:30 PM", "Activity": "Kid's day celebration", "Sequence": 1, "StartTime": "01:28 PM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 42, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "300640.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	03f8195365825c1375dba8eea7c1eab2ce6d2d2b4ad4b410c885efc8a57baf7abd4d27756797de3326ddc6667a3b08721b581c6705449a3b9fa297a20c6a315141612cdc03dc80948131b8e086e0df305b19d2fb0f277fa5feb325827d1ac115f1d54ee25362e7a27d29a408319ba99ad1778715c62b8db4d9b42d85ea2a1a88	2018-01-10 23:50:49.241346+08
226	12	7111111	3	1	\N	\N	{"Type": "Publicity/Awareness Campaign", "Venue": "A 1502-A Conference Room", "Nature": "Issue Advocacy", "Context": "Waste is not recycled, it is wasted", "Expenses": [{"Type": "Food Expense", "Material": "Uncle John's Fried Chicken", "Quantity": 10, "Sequence": 1, "UnitCost": "95.00"}], "ActivityID": 12, "Objectives": ["To be able to create a reducing waste program that is specific to the problem;", "To analyze the wastes generated in STC"], "Strategies": "ECOntrol: Waste Analysis and Characterization Study", "Organization": "De La Salle University - Environmental Conservation Organization", "ProjectHeads": [{"IDNumber": 1111114}], "ProgramDesign": [{"Date": "Jan 18, 2018", "DayID": 0, "EndTime": "01:30 PM", "Activity": "Discussion of data ", "Sequence": 1, "StartTime": "11:00 AM", "Description": "", "PersonInCharge": {"IDNumber": 7111116}}], "ProjectedIncome": [], "SourceFundOther": "0.00", "ProjectProposalID": 28, "SourceFundParticipantFee": "0.00", "AccumulatedDepositoryFunds": "301741.00", "AccumulatedOperationalFunds": "0.00", "OrganizationFundOtherSource": "0.00"}	5e9f7369060d05714982dccb2e8b2508bfae7a7ac8a3db726d0964eda78b83120f7a972ee28eae895ab5ef4fd49039bd6cc28e39b4ac289465840371d8c844effd902a04eecc04eec115109e1219647316039fbecc4a17e95b2e932d27d6e2cdda5e669aa8610f4484cb822e4ac593529b0ad55a7523e6099fc7cebd92bec4e9	2018-01-10 23:51:02.56512+08
\.


--
-- Data for Name: projectproposalsourcefunds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalsourcefunds (projectproposal, sequence, name, amount) FROM stdin;
\.


--
-- Data for Name: projectproposalstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projectproposalstatus (id, name) FROM stdin;
1	Created
2	For approval
3	Approved
4	Pending
5	Denied
6	Rescheduled
7	Rescheduled Denied
8	On-hold
\.


--
-- Data for Name: schoolyear; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schoolyear (id, startyear, endyear, datestart, dateend) FROM stdin;
20152016	2015	2016	2015-08-24	2016-08-27
20162017	2016	2017	2016-09-12	2017-08-19
20172018	2017	2018	2017-09-11	2018-08-28
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (sid, sess, expire) FROM stdin;
Z7n0QFR0euCSMWCL3mSetjZdlex_om6y	{"cookie":{"originalMaxAge":3600000,"expires":"2018-02-10T15:04:03.281Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"2o1Sfh9-iTaxqf7REfooKrWe"}	2018-02-10 23:04:04
_yGiLFnHMqaLr1d91eoq67dYF_5Lb9-2	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:44:44.632Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"xGrhkZwad94bCIKF58UwczCs","user":{"idNumber":7111113,"name":{"first":"Organization7","middle":null,"last":"VP - Documentation"},"type":1,"organizationSelected":{"id":14,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:44:45
13i8HyotBgtdwWWeLP7ixb6gVqIUq4_j	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:51:32.118Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"XHa4OciPuLfxMTTwBd3H1Ayq","user":{"idNumber":1011120,"name":{"first":"CSO","middle":null,"last":"AVC - APS"},"type":1,"organizationSelected":{"id":0,"path_profilePicture":"\\\\plugins\\\\images\\\\cso.png"}},"valid":true}	2018-01-11 00:51:33
nYqY__s8DPA_v7_mQXZnZbVueGpQnLvS	{"cookie":{"originalMaxAge":3599999,"expires":"2018-01-10T16:51:52.838Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"8DTxff109xCLoePnllPy-DLq","user":{"idNumber":7111111,"name":{"first":"Organization7","middle":null,"last":"President"},"type":1,"organizationSelected":{"id":14,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:51:53
lWKhpCfKwFAzSHOEpI97KC4A6nhxm_kB	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:51:44.135Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"GYU8napN7Ww5Z_5BZUYf6E96","user":{"idNumber":1111115,"name":{"first":"Organization","middle":null,"last":"VP - Finance"},"type":1,"organizationSelected":{"id":1,"path_profilePicture":""}},"valid":true,"notingosm":"1"}	2018-01-11 00:51:45
xG-wOrVQrMU977p9sekBfbHpjymMATd5	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:17:24.281Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"mKGFD2ev8lwn6iXeM5r0eOSf","user":{"idNumber":3111111,"name":{"first":"Organization3","middle":null,"last":"President"},"type":1,"organizationSelected":{"id":10,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:17:25
HpN-Mq5Zl1cuGHJs1mnWJ2thLaL5Z8Nu	{"cookie":{"originalMaxAge":3599999,"expires":"2018-01-10T16:51:14.272Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"HpKFXHgz4jD-6WCi5CgfwHb3","user":{"idNumber":7111114,"name":{"first":"Organization7","middle":null,"last":"AVP - Documentation"},"type":1,"organizationSelected":{"id":14,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:51:15
K6ZBHmNL8NkkKHhAqmq2FskzBIwPWhNk	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:51:46.887Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"rPIiFJh6PEfzfS-vHVhc_rD4","user":{"idNumber":1111114,"name":{"first":"Organization","middle":null,"last":"AVP - Documentation"},"type":1,"organizationSelected":{"id":1,"path_profilePicture":""}},"valid":true,"notingosm":"1"}	2018-01-11 00:51:47
a2pHsrdiMR3ZgSKQ_iM_IB3wMaCvTtHB	{"cookie":{"originalMaxAge":3599999,"expires":"2018-01-10T16:51:48.985Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"QBYWlycXptNmk4Sjk6Jh8AY_","user":{"idNumber":10111114,"name":{"first":"Organization10","middle":null,"last":"AVP - Documentation"},"type":1,"organizationSelected":{"id":17,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:51:49
5FnI_r_XYpOtHjUdBHvRAohNQgQOWkuJ	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:51:07.750Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"U2W1mJSDDoLTO-H5-SsWJy7i","user":{"idNumber":1011117,"name":{"first":"CSO","middle":null,"last":"Chairperson"},"type":1,"organizationSelected":{"id":0,"path_profilePicture":"\\\\plugins\\\\images\\\\cso.png"}},"valid":true}	2018-01-11 00:51:08
sFaoDLYdDfekhAIxY8WNCH5t5L-w3ytN	{"cookie":{"originalMaxAge":3599999,"expires":"2018-01-10T16:51:38.590Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"Onle1knbK-kQgwk_otHnkk7R","user":{"idNumber":1111115,"name":{"first":"Organization","middle":null,"last":"VP - Finance"},"type":1,"organizationSelected":{"id":1,"path_profilePicture":""}},"valid":true,"notingosm":"1"}	2018-01-11 00:51:39
Ots2dWAAQJQVB7lCvm02dBNBDKXcea09	{"cookie":{"originalMaxAge":3600000,"expires":"2018-04-10T15:02:43.952Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"g-n3P_YeOI4nhC_Stg8scRWb"}	2018-04-10 23:02:44
Zgvfs782tTPhIKskMRisSLG0s9BX5uui	{"cookie":{"originalMaxAge":3599999,"expires":"2018-01-10T16:40:25.382Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"-bTJZQWBbU2R4JpzfQUzvy9Y","user":{"idNumber":7111115,"name":{"first":"Organization7","middle":null,"last":"VP - Finance"},"type":1,"organizationSelected":{"id":14,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:40:26
JvgfRWVfJY7QjO6nIm680KS3sJO10FEl	{"cookie":{"originalMaxAge":3600000,"expires":"2018-04-10T14:12:02.138Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"YXRt2BbeV45oqBZOV7Z0mkdP"}	2018-04-10 22:12:03
83VMpEI_3O5c03NRAbhpecmdeeH8mu3D	{"cookie":{"originalMaxAge":3600000,"expires":"2018-04-10T14:12:26.434Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"vpKU5ZhWqS-VkDC4wsOTThfE"}	2018-04-10 22:12:27
2eIg9833qw42CnTp0_41fx27OBrfT29C	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T16:42:31.517Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"iRx9zpwraA7vRX_-BsWY6JDF","user":{"idNumber":7111113,"name":{"first":"Organization7","middle":null,"last":"VP - Documentation"},"type":1,"organizationSelected":{"id":14,"path_profilePicture":""}},"valid":true,"notingosm":0}	2018-01-11 00:42:32
mrH_sIQS1C4EB_-RH24rt1IqjvXAzqdY	{"cookie":{"originalMaxAge":3600000,"expires":"2018-01-10T15:58:30.462Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"oh2CvelqhitaRX6ADrEIqyxg","user":{"idNumber":1011121,"name":{"first":"CSO","middle":null,"last":"A - APS"},"type":1,"organizationSelected":{"id":0,"path_profilePicture":"\\\\plugins\\\\images\\\\cso.png"}},"valid":true}	2018-01-10 23:58:31
\.


--
-- Data for Name: signatorystatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.signatorystatus (id, name) FROM stdin;
0	Unsigned
1	Approved
2	Pend
3	Denied
4	Force Signed
\.


--
-- Data for Name: signatorytype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.signatorytype (id, name, lineup) FROM stdin;
0	Project Head	0
1	Treasurer/Finance Officer	10
2	Immediate Superior	20
3	President	30
4	Faculty Adviser	40
5	Documentation Officer	50
6	APS - AVC	60
7	APS -  VC	70
\.


--
-- Data for Name: studentorganization; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.studentorganization (id, name, status, cluster, nature, college, acronym, description, funds, operationalfunds, depositoryfunds, depositryfunds, path_profilepicture, accountnumber) FROM stdin;
0	Council of Student Organizations	0	\N	\N	\N	CSO	\N	0.00	1246.00	304639.00	0.00	\\plugins\\images\\cso.png	\N
1	La Salle Computer Society	0	2	\N	\N	LSCS	\N	0.00	1356.00	345567.00	0.00	\N	\N
2	Math Circle	0	1	\N	\N	MC	\N	0.00	1277.00	347271.00	0.00	\N	\N
3	Physics Society	0	1	\N	\N	Physoc	\N	0.00	1313.00	311419.00	0.00	\N	\N
4	Societas Vitae	0	1	\N	\N	SV	\N	0.00	1307.00	308451.00	0.00	\N	\N
5	Chemistry Society	0	1	\N	\N	Chemsoc	\N	0.00	1374.00	316812.00	0.00	\N	\N
6	Union of Students Inspired Towards Education	0	2	\N	\N	UNITED	\N	0.00	1078.00	344652.00	0.00	\N	\N
7	DLSU Filipino & Chinese Organization	0	2	\N	\N	ENGLICOM	\N	0.00	1198.00	311982.00	0.00	\N	\N
8	ROTARACT Club of DLSU	0	2	\N	\N	ROTARACT	\N	0.00	1040.00	324206.00	0.00	\N	\N
9	United International Student Organization	0	2	\N	\N	UNISTO	\N	0.00	1046.00	334751.00	0.00	\N	\N
10	AIESEC DLSU	0	2	\N	\N	AIESEC	\N	0.00	1470.00	314253.00	0.00	\N	\N
11	Moo Media	0	2	\N	\N	Moo	\N	0.00	1428.00	313744.00	0.00	\N	\N
12	Outdoor Club	0	2	\N	\N	OC	\N	0.00	1392.00	302604.00	0.00	\N	\N
13	Writer’s Guild	0	2	\N	\N	WG	\N	0.00	1404.00	324320.00	0.00	\N	\N
14	De La Salle University - Environmental Conservation Organization	0	1	\N	\N	ECO	\N	0.00	1052.00	308475.00	0.00	\N	\N
15	Gakuen Anime Shoshiki	0	2	\N	\N	GAS	\N	0.00	1343.00	339566.00	0.00	\N	\N
16	The Organization for American Studies	0	3	\N	\N	AMSTUD	\N	0.00	1072.00	323994.00	0.00	\N	\N
17	Behavioral Sciences Society	0	3	\N	\N	BSS	\N	0.00	1328.00	343854.00	0.00	\N	\N
18	Cultura	0	3	\N	\N	Cultura	\N	0.00	1167.00	318997.00	0.00	\N	\N
19	Dalubhasaan ng mga Umuusbong na Mag-aaral ng Araling Pilipino	0	1	\N	\N	DANUM	\N	0.00	981.00	304603.00	0.00	\N	\N
20	European Studies Association	0	3	\N	\N	ESA	\N	0.00	1238.00	344376.00	0.00	\N	\N
21	Kapatiran ng Kabataan para sa Kaunlaran	0	3	\N	\N	Kaunlaran	\N	0.00	1168.00	341079.00	0.00	\N	\N
22	Nihon Kenkyu Kai	0	3	\N	\N	NKK	\N	0.00	1373.00	345353.00	0.00	\N	\N
23	Political Science Society	0	3	\N	\N	Poliscy	\N	0.00	955.00	349366.00	0.00	\N	\N
24	Samahan ng Lasalyanong Pilosopo	0	3	\N	\N	DLSU Pilosopo	\N	0.00	1147.00	313964.00	0.00	\N	\N
25	Samahan ng mga Mag-aaral sa Sikolohiya	0	3	\N	\N	SMS	\N	0.00	1316.00	316958.00	0.00	\N	\N
26	Sociedad De Historia	0	3	\N	\N	SDH	\N	0.00	1247.00	327908.00	0.00	\N	\N
27	Team Communications	0	3	\N	\N	TeamComm	\N	0.00	1276.00	318889.00	0.00	\N	\N
28	Association of Computer Engineering Students	0	4	\N	\N	ACCESS	\N	0.00	1274.00	322371.00	0.00	\N	\N
29	Chemical Engineering Society	0	4	\N	\N	ChEn	\N	0.00	1422.00	341944.00	0.00	\N	\N
30	Civil Engineering Society	0	4	\N	\N	CES	\N	0.00	1278.00	329664.00	0.00	\N	\N
31	Electronic and Communications Engineering Society	0	4	\N	\N	ECES	\N	0.00	1286.00	343960.00	0.00	\N	\N
32	Industrial Management Engineering Society	0	4	\N	\N	IMES	\N	0.00	962.00	316642.00	0.00	\N	\N
33	Society of Manufacturing Engineering	0	4	\N	\N	SME	\N	0.00	1359.00	324922.00	0.00	\N	\N
34	AdCreate Society	0	5	\N	\N	AdCreate	\N	0.00	1334.00	343086.00	0.00	\N	\N
35	Business Management Society	0	5	\N	\N	BMS	\N	0.00	1263.00	313088.00	0.00	\N	\N
36	Economics Organization	0	5	\N	\N	EconOrg	\N	0.00	1355.00	300941.00	0.00	\N	\N
37	Management of Financial Institutions Association	0	5	\N	\N	MaFia	\N	0.00	968.00	326489.00	0.00	\N	\N
38	Young Entrepreneurs Society	0	5	\N	\N	YES	\N	0.00	1457.00	307227.00	0.00	\N	\N
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.term (id, schoolyearid, number, datestart, dateend) FROM stdin;
201520161	20152016	1	2015-08-24	2015-12-08
201520162	20152016	2	2016-01-06	2016-04-16
201520163	20152016	3	2016-05-23	2016-08-27
201620171	20162017	1	2016-09-12	2016-12-17
201620172	20162017	2	2016-01-04	2016-04-11
201620173	20162017	3	2017-05-15	2017-08-19
201720181	20172018	1	2017-09-11	2017-12-16
201720182	20172018	2	2018-01-08	2018-04-21
201720183	20172018	3	2018-05-24	2018-08-28
\.


--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.activityattachmentrequirement_id_seq', 19, true);


--
-- Name: ARFOrganizationPosition ARFOrganizationPosition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ARFOrganizationPosition"
    ADD CONSTRAINT "ARFOrganizationPosition_pkey" PRIMARY KEY (id);


--
-- Name: AccountNotificationStatus AccountNotificationStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountNotificationStatus"
    ADD CONSTRAINT "AccountNotificationStatus_pkey" PRIMARY KEY (id);


--
-- Name: AccountNotification AccountNotification_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountNotification"
    ADD CONSTRAINT "AccountNotification_id_key" UNIQUE (id);


--
-- Name: AccountNotification AccountNotification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountNotification"
    ADD CONSTRAINT "AccountNotification_pkey" PRIMARY KEY (account, sequence);


--
-- Name: AccountStatus AccountStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountStatus"
    ADD CONSTRAINT "AccountStatus_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityMaterial ActivityPublicityMaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicityMaterial"
    ADD CONSTRAINT "ActivityPublicityMaterial_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityModeOfDistribution ActivityPublicityModeOfDistribution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicityModeOfDistribution"
    ADD CONSTRAINT "ActivityPublicityModeOfDistribution_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityRevisionReason ActivityPublicityRevisionReason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicityRevisionReason"
    ADD CONSTRAINT "ActivityPublicityRevisionReason_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityStatus ActivityPublicityStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicityStatus"
    ADD CONSTRAINT "ActivityPublicityStatus_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicity ActivityPublicity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_id_key" UNIQUE (id);


--
-- Name: ActivityPublicity ActivityPublicity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: ActivityResearchForm ActivityResearchForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_pkey" PRIMARY KEY ("GOSMActivity", "idNumber");


--
-- Name: ActivityVenue ActivityVenue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_pkey" PRIMARY KEY (id);


--
-- Name: BookTransferEstablishment BookTransferEstablishment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."BookTransferEstablishment"
    ADD CONSTRAINT "BookTransferEstablishment_pkey" PRIMARY KEY (id);


--
-- Name: Building Building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Building"
    ADD CONSTRAINT "Building_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_pkey" PRIMARY KEY ("expenseType", document);


--
-- Name: FinanceSignatoryType FinanceSignatoryType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."FinanceSignatoryType"
    ADD CONSTRAINT "FinanceSignatoryType_pkey" PRIMARY KEY (id);


--
-- Name: MemberSurveyForm MemberSurveyForm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_id_key" UNIQUE (id);


--
-- Name: MemberSurveyForm MemberSurveyForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_pkey" PRIMARY KEY ("termID", member, "organizationID");


--
-- Name: OfficerSurveyForm OfficerSurveyForm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_id_key" UNIQUE (id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_pkey" PRIMARY KEY ("termID", "organizationID", officer);


--
-- Name: OrganizationMember OrganizationMember_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_id_key" UNIQUE (id);


--
-- Name: OrganizationMember OrganizationMember_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_pkey" PRIMARY KEY ("idNumber", organization, "yearID");


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PostProjectBookTransferStatus PostProjectBookTransferStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransferStatus"
    ADD CONSTRAINT "PostProjectBookTransferStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_id_key" UNIQUE (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PostProjectDirectPaymentPayment PostProjectDirectPaymentPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPaymentPayment"
    ADD CONSTRAINT "PostProjectDirectPaymentPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPaymentStatus PostProjectDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPaymentStatus"
    ADD CONSTRAINT "PostProjectDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_id_key" UNIQUE (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalStatus PostProjectProposalStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalStatus"
    ADD CONSTRAINT "PostProjectProposalStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectProposal PostProjectProposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_pkey" PRIMARY KEY ("GOSMActivity");


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_pkey" PRIMARY KEY (reimbursement, particular);


--
-- Name: PostProjectReimbursementPayment PostProjectReimbursementPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementPayment"
    ADD CONSTRAINT "PostProjectReimbursementPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursementStatus PostProjectReimbursementStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementStatus"
    ADD CONSTRAINT "PostProjectReimbursementStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_pkey" PRIMARY KEY ("bookTransfer", signatory, type);


--
-- Name: PreActivityBookTransferStatus PreActivityBookTransferStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferStatus"
    ADD CONSTRAINT "PreActivityBookTransferStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_pkey" PRIMARY KEY ("cashAdvance", particular);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceStatus PreActivityCashAdvanceStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceStatus"
    ADD CONSTRAINT "PreActivityCashAdvanceStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentStatus PreActivityDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentStatus"
    ADD CONSTRAINT "PreActivityDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: RateType RateType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."RateType"
    ADD CONSTRAINT "RateType_pkey" PRIMARY KEY (id);


--
-- Name: SystemConfiguration SystemConfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."SystemConfiguration"
    ADD CONSTRAINT "SystemConfiguration_pkey" PRIMARY KEY (name);


--
-- Name: VenueSize VenueSize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."VenueSize"
    ADD CONSTRAINT "VenueSize_pkey" PRIMARY KEY (id);


--
-- Name: account account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (idnumber);


--
-- Name: accounttype accounttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.accounttype
    ADD CONSTRAINT accounttype_pkey PRIMARY KEY (id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: activitynature activitynature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activitynature
    ADD CONSTRAINT activitynature_pkey PRIMARY KEY (id);


--
-- Name: activitytype activitytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activitytype
    ADD CONSTRAINT activitytype_pkey PRIMARY KEY (id);


--
-- Name: amtactivityevaluation amtactivityevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_pkey PRIMARY KEY (activity);


--
-- Name: amtactivityevaluationstatus amtactivityevaluationstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amtactivityevaluationstatus
    ADD CONSTRAINT amtactivityevaluationstatus_pkey PRIMARY KEY (id);


--
-- Name: college college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college
    ADD CONSTRAINT college_pkey PRIMARY KEY (shortacronym);


--
-- Name: documentattachmentrequirement documentattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.documentattachmentrequirement
    ADD CONSTRAINT documentattachmentrequirement_pkey PRIMARY KEY (id);


--
-- Name: expensetype expensetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.expensetype
    ADD CONSTRAINT expensetype_pkey PRIMARY KEY (id);


--
-- Name: functionality functionality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functionality
    ADD CONSTRAINT functionality_pkey PRIMARY KEY (id);


--
-- Name: functionalitycategory functionalitycategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functionalitycategory
    ADD CONSTRAINT functionalitycategory_pkey PRIMARY KEY (id);


--
-- Name: functionalitydomain functionalitydomain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functionalitydomain
    ADD CONSTRAINT functionalitydomain_pkey PRIMARY KEY (id);


--
-- Name: gosm gosm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_id_key UNIQUE (id);


--
-- Name: gosm gosm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_pkey PRIMARY KEY (termid, studentorganization);


--
-- Name: gosmactivity gosmactivity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivity
    ADD CONSTRAINT gosmactivity_id_key UNIQUE (id);


--
-- Name: gosmactivity gosmactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivity
    ADD CONSTRAINT gosmactivity_pkey PRIMARY KEY (gosm, sequence);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_pkey PRIMARY KEY (idnumber, activityid);


--
-- Name: gosmstatus gosmstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmstatus
    ADD CONSTRAINT gosmstatus_pkey PRIMARY KEY (id);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_pkey PRIMARY KEY (role, functionality);


--
-- Name: organizationcluster organizationcluster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationcluster
    ADD CONSTRAINT organizationcluster_pkey PRIMARY KEY (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_id_key UNIQUE (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_pkey PRIMARY KEY (organization, faculty, yearid);


--
-- Name: organizationnature organizationnature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationnature
    ADD CONSTRAINT organizationnature_pkey PRIMARY KEY (id);


--
-- Name: organizationofficer organizationofficer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationofficer
    ADD CONSTRAINT organizationofficer_pkey PRIMARY KEY (idnumber, role, yearid);


--
-- Name: organizationrole organizationrole_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationrole
    ADD CONSTRAINT organizationrole_id_key UNIQUE (id);


--
-- Name: organizationrole organizationrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationrole
    ADD CONSTRAINT organizationrole_pkey PRIMARY KEY (organization, sequence);


--
-- Name: organizationstatus organizationstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationstatus
    ADD CONSTRAINT organizationstatus_pkey PRIMARY KEY (id);


--
-- Name: PreActivityCashAdvanceSignatory pk_PreActivityCashAdvanceSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "pk_PreActivityCashAdvanceSignatory" PRIMARY KEY ("cashAdvance", signatory, type);


--
-- Name: PreActivityDirectPaymentSignatory pk_PreActivityDirectPaymentSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "pk_PreActivityDirectPaymentSignatory" PRIMARY KEY ("directPayment", signatory, type);


--
-- Name: projectproposalsignatory pk_ProjectProposalSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT "pk_ProjectProposalSignatory" PRIMARY KEY (gosmactivity, signatory, type);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: projectproposal projectproposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_id_key UNIQUE (id);


--
-- Name: projectproposal projectproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_pkey PRIMARY KEY (gosmactivity);


--
-- Name: projectproposalattachment projectproposalattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_pkey PRIMARY KEY (id);


--
-- Name: projectproposalexpenses projectproposalexpenses_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_id_key UNIQUE (id);


--
-- Name: projectproposalexpenses projectproposalexpenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_pkey PRIMARY KEY (projectproposal, dayid, sequence);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_pkey PRIMARY KEY (programdesign, projecthead);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalreschedulereason projectproposalreschedulereason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalreschedulereason
    ADD CONSTRAINT projectproposalreschedulereason_pkey PRIMARY KEY (id);


--
-- Name: projectproposalsignatory projectproposalsignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_id_key UNIQUE (id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalstatus projectproposalstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalstatus
    ADD CONSTRAINT projectproposalstatus_pkey PRIMARY KEY (id);


--
-- Name: schoolyear schoolyear_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schoolyear
    ADD CONSTRAINT schoolyear_id_key UNIQUE (id);


--
-- Name: schoolyear schoolyear_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schoolyear
    ADD CONSTRAINT schoolyear_pkey PRIMARY KEY (startyear, endyear);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: signatorystatus signatorystatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signatorystatus
    ADD CONSTRAINT signatorystatus_pkey PRIMARY KEY (id);


--
-- Name: signatorytype signatorytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.signatorytype
    ADD CONSTRAINT signatorytype_pkey PRIMARY KEY (id);


--
-- Name: studentorganization studentorganization_acronym_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_acronym_key UNIQUE (acronym);


--
-- Name: studentorganization studentorganization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_pkey PRIMARY KEY (id);


--
-- Name: term term_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_id_key UNIQUE (id);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_pkey PRIMARY KEY (schoolyearid, number);


--
-- Name: PreActivityCashAdvanceParticular after_delete_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_delete_PreActivityCashAdvanceParticular_signatories" AFTER DELETE ON public."PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_delete_finance_signatories('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'pacas', 'pacas."cashAdvance" = $1."cashAdvance"');


--
-- Name: PostProjectReimbursement after_insert_PostProjectReimbursement_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PostProjectReimbursement_signatories" AFTER INSERT ON public."PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories_initial('PostProjectReimbursement', 'ppr', 'PostProjectReimbursementSignatory', 'reimbursement', 'PostAct_Reimbursement_get_organization_next_treasurer_signatory');


--
-- Name: PreActivityBookTransferParticular after_insert_PreActivityBookTransferParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityBookTransferParticular_signatories" AFTER INSERT ON public."PreActivityBookTransferParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories('PreActivityBookTransferParticular', 'pabtp', 'pabtp."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransferSignatory', 'bookTransfer', '$1."bookTransfer"');


--
-- Name: PreActivityBookTransfer after_insert_PreActivityBookTransfer_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityBookTransfer_signatories" AFTER INSERT ON public."PreActivityBookTransfer" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories_initial('PreActivityBookTransfer', 'pabt', 'PreActivityBookTransferSignatory', 'bookTransfer', 'PreAct_BookTransfer_get_organization_next_treasurer_signatory');


--
-- Name: PreActivityCashAdvanceParticular after_insert_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvanceParticular_signatories" AFTER INSERT ON public."PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'cashAdvance', '$1."cashAdvance"');


--
-- Name: PreActivityCashAdvance after_insert_PreActivityCashAdvance_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvance_signatories" AFTER INSERT ON public."PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE public."trigger_after_insert_PreActivityCashAdvance_signatories"();


--
-- Name: PreActivityDirectPaymentParticular after_insert_PreActivityDirectPaymentParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityDirectPaymentParticular_signatories" AFTER INSERT ON public."PreActivityDirectPaymentParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories('PreActivityDirectPaymentParticular', 'pacap', 'pacap."directPayment" = $1."directPayment"', 'PreActivityDirectPaymentSignatory', 'directPayment', '$1."directPayment"');


--
-- Name: PreActivityDirectPayment after_insert_PreActivityDirectPayment_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityDirectPayment_signatories" AFTER INSERT ON public."PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE public."trigger_after_insert_PreActivityDirectPayment_signatories"();


--
-- Name: PostProjectReimbursementParticular after_insert_PreActivityReimbursementParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityReimbursementParticular_signatories" AFTER INSERT ON public."PostProjectReimbursementParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_after_insert_finance_signatories('PostProjectReimbursementParticular', 'pprp', 'pprp."reimbursement" = $1."reimbursement"', 'PostProjectReimbursementSignatory', 'reimbursement', '$1."reimbursement"');


--
-- Name: projectproposalprogramdesign after_insert_ProjectProposalProgramDesign; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_ProjectProposalProgramDesign" BEFORE INSERT ON public.projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE public."trigger_after_insert_ProjectProposalProgramDesign"();


--
-- Name: projectproposal after_insert_ProjectProposal_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_ProjectProposal_signatories" AFTER INSERT ON public.projectproposal FOR EACH ROW EXECUTE PROCEDURE public."trigger_after_insert_ProjectProposal_signatories"();


--
-- Name: studentorganization after_insert_StudentOrganization_ACL; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_StudentOrganization_ACL" AFTER INSERT ON public.studentorganization FOR EACH ROW EXECUTE PROCEDURE public."trigger_after_insert_StudentOrganization_ACL"();


--
-- Name: PreActivityBookTransferSignatory after_update_PreActivityBookTransferSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityBookTransferSignatory_completion" AFTER UPDATE ON public."PreActivityBookTransferSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public.trigger_after_update_signatory_completion('PreActivityBookTransferSignatory', 'pabts', 'pabts."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransfer', 'pabt', 'pabt.id = $1."bookTransfer"');


--
-- Name: PreActivityCashAdvanceSignatory after_update_PreActivityCashAdvanceSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityCashAdvanceSignatory_completion" AFTER UPDATE ON public."PreActivityCashAdvanceSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public.trigger_after_update_signatory_completion('PreActivityCashAdvanceSignatory', 'precas', 'precas."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvance', 'preca', 'preca.id = $1."cashAdvance"');


--
-- Name: PostProjectReimbursementSignatory after_update_PreActivityReimbursementSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityReimbursementSignatory_completion" AFTER UPDATE ON public."PostProjectReimbursementSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public.trigger_after_update_signatory_completion('PostProjectReimbursementSignatory', 'pprs', 'pprs."reimbursement" = $1."reimbursement"', 'PostProjectReimbursement', 'ppr', 'ppr.id = $1."reimbursement"');


--
-- Name: projectproposalsignatory after_update_ProjectProposalSignatory_PendCounter; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposalSignatory_PendCounter" AFTER UPDATE ON public.projectproposalsignatory FOR EACH ROW WHEN ((new.status = 2)) EXECUTE PROCEDURE public."trigger_after_update_ProjectProposalSignatory_counter"();


--
-- Name: projectproposalsignatory after_update_ProjectProposalSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposalSignatory_completion" AFTER UPDATE ON public.projectproposalsignatory FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public."trigger_after_update_ProjectProposalSignatory_completion"();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_facultyAdviser; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser" AFTER UPDATE ON public.projectproposal FOR EACH ROW WHEN ((((old.facultyadviser IS NULL) AND (new.facultyadviser IS NOT NULL)) OR ((old.facultyadviser IS NOT NULL) AND (new.facultyadviser IS NULL)) OR (old.facultyadviser <> new.facultyadviser))) EXECUTE PROCEDURE public."trigger_after_update_ProjectProposal_signatory_facultyAdviser"();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_immediateSuperior; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior" AFTER UPDATE ON public.projectproposal FOR EACH ROW WHEN (((old.preparedby IS NULL) OR (old.preparedby <> new.preparedby))) EXECUTE PROCEDURE public."trigger_after_update_ProjectProposal_signatory_immediateSuperio"();


--
-- Name: gosm after_update_gosm_studentorganization; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_update_gosm_studentorganization AFTER UPDATE ON public.gosm FOR EACH ROW WHEN ((old.studentorganization <> new.studentorganization)) EXECUTE PROCEDURE public.trigger_after_update_gosm_studentorganization();


--
-- Name: AccountNotification before_insert_AccountNotification; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_AccountNotification" BEFORE INSERT ON public."AccountNotification" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_increment_sequence('AccountNotification', 'an', 'an."account" = $1."account"');


--
-- Name: AccountNotification before_insert_AccountNotification_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_AccountNotification_id" BEFORE INSERT ON public."AccountNotification" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('AccountNotification');


--
-- Name: ActivityPublicity before_insert_ActivityPublicity_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityPublicity_id" BEFORE INSERT ON public."ActivityPublicity" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('ActivityPublicity');


--
-- Name: ActivityPublicity before_insert_ActivityPublicity_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityPublicity_sequence" BEFORE INSERT ON public."ActivityPublicity" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_sequence_versioning('ActivityPublicity', 'ap', 'ap."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: ActivityResearchForm before_insert_ActivityResearchForm_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityResearchForm_sequence" BEFORE INSERT ON public."ActivityResearchForm" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_increment_sequence('ActivityResearchForm', 'arf', 'arf."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: gosmactivity before_insert_GOSMActivity_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_GOSMActivity_id" BEFORE INSERT ON public.gosmactivity FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('gosmactivity');


--
-- Name: MemberSurveyForm before_insert_MemberSurveyForm_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_MemberSurveyForm_id" BEFORE INSERT ON public."MemberSurveyForm" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('MemberSurveyForm');


--
-- Name: organizationfacultyadviser before_insert_OrganizationFacultyAdviser_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_OrganizationFacultyAdviser_id" BEFORE INSERT ON public.organizationfacultyadviser FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('organizationfacultyadviser');


--
-- Name: OrganizationMember before_insert_OrganizationMember_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_OrganizationMember_id" BEFORE INSERT ON public."OrganizationMember" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('OrganizationMember');


--
-- Name: PostProjectBookTransfer before_insert_PostProjectBookTransfer_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectBookTransfer_id" BEFORE INSERT ON public."PostProjectBookTransfer" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectBookTransfer');


--
-- Name: PostProjectBookTransfer before_insert_PostProjectBookTransfer_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectBookTransfer_sequence" BEFORE INSERT ON public."PostProjectBookTransfer" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_sequence_versioning('PostProjectBookTransfer', 'ppbt', 'ppbt."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PostProjectDirectPayment before_insert_PostProjectDirectPayment_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectDirectPayment_id" BEFORE INSERT ON public."PostProjectDirectPayment" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectDirectPayment');


--
-- Name: PostProjectDirectPayment before_insert_PostProjectDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectDirectPayment_sequence" BEFORE INSERT ON public."PostProjectDirectPayment" FOR EACH ROW EXECUTE PROCEDURE public."trigger_before_insert_PostProjectDirectPayment_sequence"();


--
-- Name: PostProjectProposalEventPicture before_insert_PostProjectProposalEventPicture_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalEventPicture_id" BEFORE INSERT ON public."PostProjectProposalEventPicture" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectProposalEventPicture');


--
-- Name: PostProjectProposalEventPicture before_insert_PostProjectProposalEventPicture_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalEventPicture_sequence" BEFORE INSERT ON public."PostProjectProposalEventPicture" FOR EACH ROW EXECUTE PROCEDURE public."trigger_before_insert_PostProjectProposalEventPicture_sequence"();


--
-- Name: PostProjectProposalExpense before_insert_PostProjectProposalExpense_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalExpense_id" BEFORE INSERT ON public."PostProjectProposalExpense" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectProposalExpense');


--
-- Name: PostProjectProposalExpense before_insert_PostProjectProposalExpense_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalExpense_sequence" BEFORE INSERT ON public."PostProjectProposalExpense" FOR EACH ROW EXECUTE PROCEDURE public."trigger_before_insert_PostProjectProposalExpense_sequence"();


--
-- Name: PostProjectReimbursementParticular before_insert_PostProjectReimbursementParticular_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursementParticular_id" BEFORE INSERT ON public."PostProjectReimbursementParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectReimbursementParticular');


--
-- Name: PostProjectReimbursementSignatory before_insert_PostProjectReimbursementSignatory_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursementSignatory_id" BEFORE INSERT ON public."PostProjectReimbursementSignatory" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectReimbursementSignatory');


--
-- Name: PostProjectReimbursement before_insert_PostProjectReimbursement_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursement_id" BEFORE INSERT ON public."PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PostProjectReimbursement');


--
-- Name: PostProjectReimbursement before_insert_PostProjectReimbursement_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursement_sequence" BEFORE INSERT ON public."PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_sequence_versioning('PostProjectReimbursement', 'pprojr', '"pprojr"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityBookTransfer before_insert_PreActivityBookTransfer; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityBookTransfer" BEFORE INSERT ON public."PreActivityBookTransfer" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_sequence_versioning('PreActivityBookTransfer', 'pabt', '"pabt"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityBookTransferParticular before_insert_PreActivityBookTransferParticular_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityBookTransferParticular_id" BEFORE INSERT ON public."PreActivityBookTransferParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityBookTransferParticular');


--
-- Name: PreActivityBookTransferSignatory before_insert_PreActivityBookTransferSignatory_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityBookTransferSignatory_id" BEFORE INSERT ON public."PreActivityBookTransferSignatory" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityBookTransferSignatory');


--
-- Name: PreActivityBookTransfer before_insert_PreActivityBookTransfer_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityBookTransfer_id" BEFORE INSERT ON public."PreActivityBookTransfer" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityBookTransfer');


--
-- Name: PreActivityCashAdvanceParticular before_insert_PreActivityCashAdvanceParticular_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvanceParticular_id" BEFORE INSERT ON public."PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityCashAdvanceParticular');


--
-- Name: PreActivityCashAdvanceSignatory before_insert_PreActivityCashAdvanceSignatory_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvanceSignatory_id" BEFORE INSERT ON public."PreActivityCashAdvanceSignatory" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityCashAdvanceSignatory');


--
-- Name: PreActivityCashAdvance before_insert_PreActivityCashAdvance_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvance_id" BEFORE INSERT ON public."PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityCashAdvance');


--
-- Name: PreActivityCashAdvance before_insert_PreActivityCashAdvance_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvance_sequence" BEFORE INSERT ON public."PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_sequence_versioning('PreActivityCashAdvance', 'paca', '"paca"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityDirectPaymentParticular before_insert_PreActivityDirectPaymentParticular_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPaymentParticular_id" BEFORE INSERT ON public."PreActivityDirectPaymentParticular" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityDirectPaymentParticular');


--
-- Name: PreActivityDirectPaymentSignatory before_insert_PreActivityDirectPaymentSignatory_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPaymentSignatory_id" BEFORE INSERT ON public."PreActivityDirectPaymentSignatory" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityDirectPaymentSignatory');


--
-- Name: PreActivityDirectPayment before_insert_PreActivityDirectPayment_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPayment_id" BEFORE INSERT ON public."PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('PreActivityDirectPayment');


--
-- Name: PreActivityDirectPayment before_insert_PreActivityDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPayment_sequence" BEFORE INSERT ON public."PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE public."trigger_before_insert_PreActivityDirectPayment_sequence"();


--
-- Name: projectproposalattachment before_insert_ProjectProposalAttachment_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposalAttachment_id" BEFORE INSERT ON public.projectproposalattachment FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposalattachment');


--
-- Name: projectproposalexpenses before_insert_ProjectProposalExpenses_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposalExpenses_id" BEFORE INSERT ON public.projectproposalexpenses FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposalexpenses');


--
-- Name: projectproposalprogramdesignpersonincharge before_insert_ProjectProposalProgramDesignPersonInCharge_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposalProgramDesignPersonInCharge_id" BEFORE INSERT ON public.projectproposalprogramdesignpersonincharge FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposalprogramdesignpersonincharge');


--
-- Name: projectproposalprogramdesign before_insert_ProjectProposalProgramDesign_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposalProgramDesign_id" BEFORE INSERT ON public.projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposalprogramdesign');


--
-- Name: projectproposalsignatory before_insert_ProjectProposalSignatory_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposalSignatory_id" BEFORE INSERT ON public.projectproposalsignatory FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposalsignatory');


--
-- Name: projectproposal before_insert_ProjectProposal_id; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ProjectProposal_id" BEFORE INSERT ON public.projectproposal FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_id('projectproposal');


--
-- Name: account before_insert_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_account BEFORE INSERT ON public.account FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_account();


--
-- Name: functionality before_insert_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionality BEFORE INSERT ON public.functionality FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_functionality();


--
-- Name: functionalitycategory before_insert_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionalitycategory BEFORE INSERT ON public.functionalitycategory FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_functionalitycategory();


--
-- Name: gosm before_insert_ggosm; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_ggosm BEFORE INSERT ON public.gosm FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_gosm();


--
-- Name: gosmactivity before_insert_gosmactivity; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_gosmactivity BEFORE INSERT ON public.gosmactivity FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_gosmactivity();


--
-- Name: organizationrole before_insert_organizationrole; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_organizationrole BEFORE INSERT ON public.organizationrole FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_organizationrole();


--
-- Name: projectproposalexpenses before_insert_projectproposalexpenses; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalexpenses BEFORE INSERT ON public.projectproposalexpenses FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_projectproposalexpenses();


--
-- Name: projectproposalprogramdesign before_insert_projectproposalprogramdesign; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprogramdesign BEFORE INSERT ON public.projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_projectproposalprogramdesign();


--
-- Name: projectproposalprojectedincome before_insert_projectproposalprojectedincome; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprojectedincome BEFORE INSERT ON public.projectproposalprojectedincome FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_projectproposalprojectedincome();


--
-- Name: projectproposalsourcefunds before_insert_projectproposalsourcefunds; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalsourcefunds BEFORE INSERT ON public.projectproposalsourcefunds FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_projectproposalsourcefunds();


--
-- Name: schoolyear before_insert_schoolyear; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_schoolyear BEFORE INSERT ON public.schoolyear FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_schoolyear();


--
-- Name: term before_insert_term; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_term BEFORE INSERT ON public.term FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_insert_term();


--
-- Name: account before_update_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_account BEFORE UPDATE ON public.account FOR EACH ROW EXECUTE PROCEDURE public.trigger_before_update_account();


--
-- Name: functionality before_update_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionality BEFORE UPDATE ON public.functionality FOR EACH ROW WHEN (((old.category <> new.category) OR (old.category IS NULL))) EXECUTE PROCEDURE public.trigger_before_update_functionality();


--
-- Name: functionalitycategory before_update_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionalitycategory BEFORE UPDATE ON public.functionalitycategory FOR EACH ROW WHEN (((old.domain <> new.domain) OR (old.domain IS NULL))) EXECUTE PROCEDURE public.trigger_before_update_functionalitycategory();


--
-- Name: gosm before_update_gosm_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_gosm_status BEFORE UPDATE ON public.gosm FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public.trigger_before_update_gosm_status();


--
-- Name: projectproposal before_update_projectproposal; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_projectproposal BEFORE UPDATE ON public.projectproposal FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE public.trigger_before_update_projectproposal();


--
-- Name: AccountNotification AccountNotification_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountNotification"
    ADD CONSTRAINT "AccountNotification_account_fkey" FOREIGN KEY (account) REFERENCES public.account(idnumber);


--
-- Name: AccountNotification AccountNotification_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."AccountNotification"
    ADD CONSTRAINT "AccountNotification_status_fkey" FOREIGN KEY (status) REFERENCES public."AccountNotificationStatus"(id);


--
-- Name: ActivityPublicity ActivityPublicity_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: ActivityPublicity ActivityPublicity_checkedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_checkedBy_fkey" FOREIGN KEY ("checkedBy") REFERENCES public.account(idnumber);


--
-- Name: ActivityPublicity ActivityPublicity_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_material_fkey" FOREIGN KEY (material) REFERENCES public."ActivityPublicityMaterial"(id);


--
-- Name: ActivityPublicity ActivityPublicity_modeOfDistribution_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_modeOfDistribution_fkey" FOREIGN KEY ("modeOfDistribution") REFERENCES public."ActivityPublicityModeOfDistribution"(id);


--
-- Name: ActivityPublicity ActivityPublicity_revisionReason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_revisionReason_fkey" FOREIGN KEY ("revisionReason") REFERENCES public."ActivityPublicityRevisionReason"(id);


--
-- Name: ActivityPublicity ActivityPublicity_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_status_fkey" FOREIGN KEY (status) REFERENCES public."ActivityPublicityStatus"(id);


--
-- Name: ActivityPublicity ActivityPublicity_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES public.account(idnumber);


--
-- Name: ActivityResearchForm ActivityResearchForm_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: ActivityResearchForm ActivityResearchForm_positionInOrganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_positionInOrganization_fkey" FOREIGN KEY ("positionInOrganization") REFERENCES public."ARFOrganizationPosition"(id);


--
-- Name: ActivityVenue ActivityVenue_building_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_building_fkey" FOREIGN KEY (building) REFERENCES public."Building"(id);


--
-- Name: ActivityVenue ActivityVenue_rateType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_rateType_fkey" FOREIGN KEY ("rateType") REFERENCES public."RateType"(id);


--
-- Name: ActivityVenue ActivityVenue_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_size_fkey" FOREIGN KEY (size) REFERENCES public."VenueSize"(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_document_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_document_fkey" FOREIGN KEY (document) REFERENCES public.documentattachmentrequirement(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_expenseType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_expenseType_fkey" FOREIGN KEY ("expenseType") REFERENCES public.expensetype(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_member_fkey" FOREIGN KEY (member) REFERENCES public."OrganizationMember"(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_organizationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES public.studentorganization(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_termID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_termID_fkey" FOREIGN KEY ("termID") REFERENCES public.term(id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_officer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_officer_fkey" FOREIGN KEY (officer) REFERENCES public.account(idnumber);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_organizationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES public.studentorganization(id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_termID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_termID_fkey" FOREIGN KEY ("termID") REFERENCES public.term(id);


--
-- Name: OrganizationMember OrganizationMember_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_organization_fkey" FOREIGN KEY (organization) REFERENCES public.studentorganization(id);


--
-- Name: OrganizationMember OrganizationMember_yearID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_yearID_fkey" FOREIGN KEY ("yearID") REFERENCES public.schoolyear(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES public."PostProjectBookTransfer"(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public."PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES public.account(idnumber);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_status_fkey" FOREIGN KEY (status) REFERENCES public."PostProjectBookTransferStatus"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES public."PostProjectDirectPayment"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public."PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES public.account(idnumber);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_paymentBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_paymentBy_fkey" FOREIGN KEY ("paymentBy") REFERENCES public."PostProjectDirectPaymentPayment"(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES public."PostProjectDirectPaymentStatus"(id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public."PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES public.account(idnumber);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public."PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES public.account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: PostProjectProposal PostProjectProposal_preparedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_preparedBy_fkey" FOREIGN KEY ("preparedBy") REFERENCES public.account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_status_fkey" FOREIGN KEY (status) REFERENCES public."PostProjectProposalStatus"(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_reimbursement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_reimbursement_fkey" FOREIGN KEY (reimbursement) REFERENCES public."PostProjectReimbursement"(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_reimbursement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_reimbursement_fkey" FOREIGN KEY (reimbursement) REFERENCES public."PostProjectReimbursement"(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES public.account(idnumber);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_status_fkey" FOREIGN KEY (status) REFERENCES public.signatorystatus(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_type_fkey" FOREIGN KEY (type) REFERENCES public."FinanceSignatoryType"(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_status_fkey" FOREIGN KEY (status) REFERENCES public."PostProjectReimbursementStatus"(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES public.account(idnumber);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES public."PreActivityBookTransfer"(id);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES public."PreActivityBookTransfer"(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES public.account(idnumber);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_status_fkey" FOREIGN KEY (status) REFERENCES public.signatorystatus(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_type_fkey" FOREIGN KEY (type) REFERENCES public."FinanceSignatoryType"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.gosmactivity(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_establishment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_establishment_fkey" FOREIGN KEY (establishment) REFERENCES public."BookTransferEstablishment"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_status_fkey" FOREIGN KEY (status) REFERENCES public."PreActivityBookTransferStatus"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES public.account(idnumber);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES public."PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES public."PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES public.account(idnumber);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_status_fkey" FOREIGN KEY (status) REFERENCES public.signatorystatus(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_type_fkey" FOREIGN KEY (type) REFERENCES public."FinanceSignatoryType"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES public.account(idnumber);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_status_fkey" FOREIGN KEY (status) REFERENCES public."PreActivityCashAdvanceStatus"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES public.account(idnumber);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES public."PreActivityDirectPaymentParticular"(id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES public.projectproposalexpenses(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES public."PreActivityDirectPayment"(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES public.account(idnumber);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_status_fkey" FOREIGN KEY (status) REFERENCES public.signatorystatus(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_type_fkey" FOREIGN KEY (type) REFERENCES public."FinanceSignatoryType"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES public.projectproposal(gosmactivity);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES public.account(idnumber);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES public."PreActivityDirectPaymentStatus"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES public.account(idnumber);


--
-- Name: account account_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_status_fkey FOREIGN KEY (status) REFERENCES public."AccountStatus"(id);


--
-- Name: account account_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_type_fkey FOREIGN KEY (type) REFERENCES public.accounttype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES public.activitytype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_attachment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_attachment_fkey FOREIGN KEY (attachment) REFERENCES public.documentattachmentrequirement(id);


--
-- Name: amtactivityevaluation amtactivityevaluation_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_activity_fkey FOREIGN KEY (activity) REFERENCES public.projectproposal(gosmactivity);


--
-- Name: amtactivityevaluation amtactivityevaluation_evaluator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_evaluator_fkey FOREIGN KEY (evaluator) REFERENCES public.account(idnumber);


--
-- Name: amtactivityevaluation amtactivityevaluation_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_status_fkey FOREIGN KEY (status) REFERENCES public.amtactivityevaluationstatus(id);


--
-- Name: functionality functionality_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functionality
    ADD CONSTRAINT functionality_category_fkey FOREIGN KEY (category) REFERENCES public.functionalitycategory(id) ON UPDATE CASCADE;


--
-- Name: functionalitycategory functionalitycategory_domain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.functionalitycategory
    ADD CONSTRAINT functionalitycategory_domain_fkey FOREIGN KEY (domain) REFERENCES public.functionalitydomain(id) ON UPDATE CASCADE;


--
-- Name: gosm gosm_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES public.account(idnumber);


--
-- Name: gosm gosm_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_status_fkey FOREIGN KEY (status) REFERENCES public.gosmstatus(id);


--
-- Name: gosm gosm_statusevaluator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_statusevaluator_fkey FOREIGN KEY (statusevaluator) REFERENCES public.account(idnumber);


--
-- Name: gosm gosm_studentorganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosm
    ADD CONSTRAINT gosm_studentorganization_fkey FOREIGN KEY (studentorganization) REFERENCES public.studentorganization(id) ON UPDATE CASCADE;


--
-- Name: gosmactivity gosmactivity_activitynature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivity
    ADD CONSTRAINT gosmactivity_activitynature_fkey FOREIGN KEY (activitynature) REFERENCES public.activitynature(id);


--
-- Name: gosmactivity gosmactivity_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivity
    ADD CONSTRAINT gosmactivity_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES public.activitytype(id);


--
-- Name: gosmactivity gosmactivity_gosm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivity
    ADD CONSTRAINT gosmactivity_gosm_fkey FOREIGN KEY (gosm) REFERENCES public.gosm(id) ON UPDATE CASCADE;


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_activityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_activityid_fkey FOREIGN KEY (activityid) REFERENCES public.gosmactivity(id);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES public.account(idnumber);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_functionality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_functionality_fkey FOREIGN KEY (functionality) REFERENCES public.functionality(id) ON UPDATE CASCADE;


--
-- Name: organizationaccesscontrol organizationaccesscontrol_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_role_fkey FOREIGN KEY (role) REFERENCES public.organizationrole(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_faculty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_faculty_fkey FOREIGN KEY (faculty) REFERENCES public.account(idnumber);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_organization_fkey FOREIGN KEY (organization) REFERENCES public.studentorganization(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_yearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_yearid_fkey FOREIGN KEY (yearid) REFERENCES public.schoolyear(id);


--
-- Name: organizationofficer organizationofficer_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationofficer
    ADD CONSTRAINT organizationofficer_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES public.account(idnumber);


--
-- Name: organizationofficer organizationofficer_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationofficer
    ADD CONSTRAINT organizationofficer_role_fkey FOREIGN KEY (role) REFERENCES public.organizationrole(id);


--
-- Name: organizationofficer organizationofficer_yearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationofficer
    ADD CONSTRAINT organizationofficer_yearid_fkey FOREIGN KEY (yearid) REFERENCES public.schoolyear(id);


--
-- Name: organizationrole organizationrole_masterrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationrole
    ADD CONSTRAINT organizationrole_masterrole_fkey FOREIGN KEY (masterrole) REFERENCES public.organizationrole(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizationrole organizationrole_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizationrole
    ADD CONSTRAINT organizationrole_organization_fkey FOREIGN KEY (organization) REFERENCES public.studentorganization(id) ON UPDATE CASCADE;


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES public.activitytype(id);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_documentattachmentrequirement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_documentattachmentrequirement FOREIGN KEY (attachment) REFERENCES public.documentattachmentrequirement(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES public.activitytype(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_documentattachmentrequirement_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_documentattachmentrequirement_ FOREIGN KEY (attachment) REFERENCES public.documentattachmentrequirement(id);


--
-- Name: projectproposal projectproposal_facultyadviser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_facultyadviser_fkey FOREIGN KEY (facultyadviser) REFERENCES public.account(idnumber);


--
-- Name: projectproposal projectproposal_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES public.gosmactivity(id);


--
-- Name: projectproposal projectproposal_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES public.account(idnumber);


--
-- Name: projectproposal projectproposal_reschedulereason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_reschedulereason_fkey FOREIGN KEY (reschedulereason) REFERENCES public.projectproposalreschedulereason(id);


--
-- Name: projectproposal projectproposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_status_fkey FOREIGN KEY (status) REFERENCES public.projectproposalstatus(id);


--
-- Name: projectproposal projectproposal_venue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_venue_fkey FOREIGN KEY (venue) REFERENCES public."ActivityVenue"(id);


--
-- Name: projectproposal projectproposal_venuecreated_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposal
    ADD CONSTRAINT projectproposal_venuecreated_fkey FOREIGN KEY (venuecreated) REFERENCES public.account(idnumber);


--
-- Name: projectproposalattachment projectproposalattachment_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES public.account(idnumber);


--
-- Name: projectproposalattachment projectproposalattachment_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES public.projectproposal(id);


--
-- Name: projectproposalattachment projectproposalattachment_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_requirement_fkey FOREIGN KEY (requirement) REFERENCES public.documentattachmentrequirement(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES public.projectproposal(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_type_fkey FOREIGN KEY (type) REFERENCES public.expensetype(id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_personincharge_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_personincharge_fkey FOREIGN KEY (personincharge) REFERENCES public.account(idnumber);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES public.projectproposal(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_programdesign_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_programdesign_fkey FOREIGN KEY (programdesign) REFERENCES public.projectproposalprogramdesign(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_projecthead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_projecthead_fkey FOREIGN KEY (projecthead) REFERENCES public.account(idnumber);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES public.projectproposal(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES public.projectproposal(gosmactivity);


--
-- Name: projectproposalsignatory projectproposalsignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_signatory_fkey FOREIGN KEY (signatory) REFERENCES public.account(idnumber);


--
-- Name: projectproposalsignatory projectproposalsignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_status_fkey FOREIGN KEY (status) REFERENCES public.signatorystatus(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_type_fkey FOREIGN KEY (type) REFERENCES public.signatorytype(id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES public.projectproposal(id);


--
-- Name: studentorganization studentorganization_cluster_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_cluster_fkey FOREIGN KEY (cluster) REFERENCES public.organizationcluster(id);


--
-- Name: studentorganization studentorganization_college_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_college_fkey FOREIGN KEY (college) REFERENCES public.college(shortacronym);


--
-- Name: studentorganization studentorganization_nature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_nature_fkey FOREIGN KEY (nature) REFERENCES public.organizationnature(id);


--
-- Name: studentorganization studentorganization_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studentorganization
    ADD CONSTRAINT studentorganization_status_fkey FOREIGN KEY (status) REFERENCES public.studentorganization(id);


--
-- Name: term term_schoolyearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.term
    ADD CONSTRAINT term_schoolyearid_fkey FOREIGN KEY (schoolyearid) REFERENCES public.schoolyear(id);


--
-- PostgreSQL database dump complete
--

