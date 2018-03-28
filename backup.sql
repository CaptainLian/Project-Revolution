--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

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
DROP TRIGGER before_insert_projectproposalattachment ON public.projectproposalattachment;
DROP TRIGGER before_insert_organizationrole ON public.organizationrole;
DROP TRIGGER before_insert_gosmactivity ON public.gosmactivity;
DROP TRIGGER before_insert_ggosm ON public.gosm;
DROP TRIGGER before_insert_functionalitycategory ON public.functionalitycategory;
DROP TRIGGER before_insert_functionality ON public.functionality;
DROP TRIGGER before_insert_account ON public.account;
DROP TRIGGER "before_insert_PreActivityDirectPayment_sequence" ON public."PreActivityDirectPayment";
DROP TRIGGER "before_insert_PreActivityCashAdvance_sequence" ON public."PreActivityCashAdvance";
DROP TRIGGER "before_insert_PreActivityBookTransfer" ON public."PreActivityBookTransfer";
DROP TRIGGER "before_insert_PostProjectReimbursement_sequence" ON public."PostProjectReimbursement";
DROP TRIGGER "before_insert_PostProjectProposalExpense_sequence" ON public."PostProjectProposalExpense";
DROP TRIGGER "before_insert_PostProjectProposalEventPicture_sequence" ON public."PostProjectProposalEventPicture";
DROP TRIGGER "before_insert_PostProjectDirectPayment_sequence" ON public."PostProjectDirectPayment";
DROP TRIGGER "before_insert_PostProjectBookTransfer_sequence" ON public."PostProjectBookTransfer";
DROP TRIGGER "before_insert_ActivityResearchForm_sequence" ON public."ActivityResearchForm";
DROP TRIGGER "before_insert_ActivityPublicity_sequence" ON public."ActivityPublicity";
DROP TRIGGER "before_insert_AccountNotification" ON public."AccountNotification";
DROP TRIGGER after_update_projectproposalsignatory_completion ON public.projectproposalsignatory;
DROP TRIGGER after_update_gosm_studentorganization ON public.gosm;
DROP TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior" ON public.projectproposal;
DROP TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser" ON public.projectproposal;
DROP TRIGGER "after_update_ProjectProposalSignatory_completion" ON public.projectproposalsignatory;
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
ALTER TABLE ONLY public.projectproposalattachment DROP CONSTRAINT projectproposalattachment_id_key;
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
ALTER TABLE public.projectproposalsignatory ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projectproposalprogramdesignpersonincharge ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projectproposalprogramdesign ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projectproposalexpenses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projectproposalattachment ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.projectproposal ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.preactivityattachmentrequirement ALTER COLUMN optional DROP DEFAULT;
ALTER TABLE public.preactivityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.postactivityattachmentrequirement ALTER COLUMN optional DROP DEFAULT;
ALTER TABLE public.postactivityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.organizationfacultyadviser ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.gosmactivity ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.activityattachmentrequirement ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityDirectPaymentSignatory" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityDirectPaymentParticular" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityDirectPayment" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityCashAdvanceSignatory" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityCashAdvanceParticular" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityCashAdvance" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityBookTransferSignatory" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityBookTransferParticular" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PreActivityBookTransfer" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectReimbursementSignatory" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectReimbursementParticular" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectReimbursement" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectProposalExpense" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectProposalEventPicture" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectDirectPayment" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."PostProjectBookTransfer" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."OrganizationMember" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."OfficerSurveyForm" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."MemberSurveyForm" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."ActivityPublicity" ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public."AccountNotification" ALTER COLUMN id DROP DEFAULT;
DROP TABLE public.term;
DROP TABLE public.studentorganization;
DROP TABLE public.signatorytype;
DROP TABLE public.signatorystatus;
DROP TABLE public.session;
DROP TABLE public.schoolyear;
DROP TABLE public.projectproposalstatus;
DROP TABLE public.projectproposalsourcefunds;
DROP SEQUENCE public.projectproposalsignatory_id_seq;
DROP TABLE public.projectproposalsignatory;
DROP TABLE public.projectproposalreschedulereason;
DROP TABLE public.projectproposalprojectedincome;
DROP SEQUENCE public.projectproposalprogramdesignpersonincharge_id_seq;
DROP TABLE public.projectproposalprogramdesignpersonincharge;
DROP SEQUENCE public.projectproposalprogramdesign_id_seq;
DROP TABLE public.projectproposalprogramdesign;
DROP SEQUENCE public.projectproposalexpenses_id_seq;
DROP SEQUENCE public.projectproposalattachment_id_seq;
DROP TABLE public.projectproposalattachment;
DROP SEQUENCE public.projectproposal_id_seq;
DROP TABLE public.projectproposal;
DROP TABLE public.preactivityattachmentrequirement;
DROP TABLE public.postactivityattachmentrequirement;
DROP TABLE public.organizationstatus;
DROP TABLE public.organizationrole;
DROP TABLE public.organizationofficer;
DROP TABLE public.organizationnature;
DROP SEQUENCE public.organizationfacultyadviser_id_seq;
DROP TABLE public.organizationfacultyadviser;
DROP TABLE public.organizationcluster;
DROP TABLE public.organizationaccesscontrol;
DROP TABLE public.gosmstatus;
DROP TABLE public.gosmactivityprojecthead;
DROP SEQUENCE public.gosmactivity_id_seq;
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
DROP SEQUENCE public."PreActivityDirectPayment_id_seq";
DROP TABLE public."PreActivityDirectPaymentStatus";
DROP SEQUENCE public."PreActivityDirectPaymentSignatory_id_seq";
DROP TABLE public."PreActivityDirectPaymentSignatory";
DROP SEQUENCE public."PreActivityDirectPaymentParticular_id_seq";
DROP TABLE public."PreActivityDirectPaymentParticular";
DROP TABLE public."PreActivityDirectPayment";
DROP SEQUENCE public."PreActivityCashAdvance_id_seq";
DROP TABLE public."PreActivityCashAdvanceStatus";
DROP SEQUENCE public."PreActivityCashAdvanceSignatory_id_seq";
DROP TABLE public."PreActivityCashAdvanceSignatory";
DROP SEQUENCE public."PreActivityCashAdvanceParticular_id_seq";
DROP TABLE public."PreActivityCashAdvanceParticular";
DROP TABLE public."PreActivityCashAdvance";
DROP SEQUENCE public."PreActivityBookTransfer_id_seq";
DROP TABLE public."PreActivityBookTransferStatus";
DROP SEQUENCE public."PreActivityBookTransferSignatory_id_seq";
DROP TABLE public."PreActivityBookTransferSignatory";
DROP SEQUENCE public."PreActivityBookTransferParticular_id_seq";
DROP TABLE public."PreActivityBookTransferParticular";
DROP TABLE public."PreActivityBookTransfer";
DROP SEQUENCE public."PostProjectReimbursement_id_seq";
DROP TABLE public."PostProjectReimbursementStatus";
DROP SEQUENCE public."PostProjectReimbursementSignatory_id_seq";
DROP TABLE public."PostProjectReimbursementSignatory";
DROP TABLE public."PostProjectReimbursementPayment";
DROP SEQUENCE public."PostProjectReimbursementParticular_id_seq";
DROP TABLE public."PostProjectReimbursementParticular";
DROP TABLE public."PostProjectReimbursement";
DROP TABLE public."PostProjectProposalStatus";
DROP SEQUENCE public."PostProjectProposalExpense_id_seq";
DROP TABLE public."PostProjectProposalExpense";
DROP SEQUENCE public."PostProjectProposalEventPicture_id_seq";
DROP TABLE public."PostProjectProposalEventPicture";
DROP TABLE public."PostProjectProposal";
DROP SEQUENCE public."PostProjectDirectPayment_id_seq";
DROP TABLE public."PostProjectDirectPaymentStatus";
DROP TABLE public."PostProjectDirectPaymentPayment";
DROP TABLE public."PostProjectDirectPaymentParticular";
DROP TABLE public."PostProjectDirectPayment";
DROP SEQUENCE public."PostProjectBookTransfer_id_seq";
DROP TABLE public."PostProjectBookTransferStatus";
DROP TABLE public."PostProjectBookTransferParticular";
DROP TABLE public."PostProjectBookTransfer";
DROP SEQUENCE public."OrganizationMember_id_seq";
DROP TABLE public."OrganizationMember";
DROP SEQUENCE public."OfficerSurveyForm_id_seq";
DROP TABLE public."OfficerSurveyForm";
DROP SEQUENCE public."MemberSurveyForm_id_seq";
DROP TABLE public."MemberSurveyForm";
DROP TABLE public."FinanceSignatoryType";
DROP TABLE public."ExpenseTypeAttachmentRequirement";
DROP TABLE public."Building";
DROP TABLE public."BookTransferEstablishment";
DROP TABLE public."ActivityVenue";
DROP TABLE public."ActivityResearchForm";
DROP SEQUENCE public."ActivityPublicity_id_seq";
DROP TABLE public."ActivityPublicityStatus";
DROP TABLE public."ActivityPublicityRevisionReason";
DROP TABLE public."ActivityPublicityModeOfDistribution";
DROP TABLE public."ActivityPublicityMaterial";
DROP TABLE public."ActivityPublicity";
DROP TABLE public."AccountStatus";
DROP SEQUENCE public."AccountNotification_id_seq";
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
DROP FUNCTION public.trigger_before_insert_projectproposalattachment();
DROP FUNCTION public.trigger_before_insert_organizationrole();
DROP FUNCTION public.trigger_before_insert_increment_sequence();
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
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


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


SET search_path = public, pg_catalog;

--
-- Name: GOSMActivity_get_current_term_activity_ids(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "GOSMActivity_get_current_term_activity_ids"() RETURNS TABLE(id integer)
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

CREATE FUNCTION "GOSMActivity_get_organization"(gosmactivityid integer) RETURNS integer
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

CREATE FUNCTION "PPR_get_GOSMActivity_id_from_PPRID"(param_pprid integer) RETURNS integer
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

CREATE FUNCTION "PPR_get_cso_next_first_phase_signatory"() RETURNS integer
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

CREATE FUNCTION "PPR_get_cso_next_second_phase_signatory"() RETURNS integer
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

CREATE FUNCTION "PPR_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
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

CREATE FUNCTION "PPR_get_organization_next_documentation_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PPR_get_organization_next_immediate_supervisor_signatory"(preparedby integer, organizationid integer) RETURNS integer
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

CREATE FUNCTION "PPR_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PostAct_Reimbursement_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PreActCashAdvance_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
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

CREATE FUNCTION "PreActCashAdvance_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PreAct_BookTransfer_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PreAct_CashAdvance_get_organization"("param_CAID" integer) RETURNS integer
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

CREATE FUNCTION "PreAct_DirectPayment_get_number_to_sign_per_account"() RETURNS TABLE(idnumber integer, "numSign" bigint)
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

CREATE FUNCTION "PreAct_DirectPayment_get_organization"("param_DPID" integer) RETURNS integer
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

CREATE FUNCTION "PreAct_DirectPayment_get_organization_next_treasurer_signatory"(organizationid integer) RETURNS integer
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

CREATE FUNCTION "PreAct_finance_get_organization"("uniqueID" integer, "table" text, "tableAcronym" text) RETURNS integer
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

CREATE FUNCTION cso_get_first_phase_signatories() RETURNS TABLE(idnumber integer)
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

CREATE FUNCTION cso_get_second_phase_signatories() RETURNS TABLE(idnumber integer)
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
-- Name: organization_get_documentation_signatories(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION organization_get_documentation_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
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

CREATE FUNCTION organization_get_highest_role_id(param_organization integer) RETURNS integer
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

CREATE FUNCTION organization_get_officers_with_role_id(roleid integer) RETURNS TABLE(idnumber integer)
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

CREATE FUNCTION organization_get_president(param_organization integer) RETURNS integer
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

CREATE FUNCTION organization_get_role_id_above_account(param_idnumber integer, param_organizationid integer) RETURNS integer
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

CREATE FUNCTION organization_get_treasurer_signatories(organizationid integer) RETURNS TABLE(idnumber integer)
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

CREATE FUNCTION signatory_get_to_sign_per_account("signatoryTable" text, "signatoryTableAcronym" text, "signatoryTableColumn" text, "parentTable" text, "parentTableAcronym" text) RETURNS TABLE(idnumber integer, "numSign" bigint)
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

CREATE FUNCTION system_get_current_term_id() RETURNS integer
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

CREATE FUNCTION system_get_current_year_id() RETURNS integer
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

CREATE FUNCTION system_get_functionality_id(param_sequenceid integer) RETURNS integer
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

CREATE FUNCTION system_get_next_finance_signatory("signatoryTable" text, "signatoryTableAcronym" text, "where" text) RETURNS integer
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

CREATE FUNCTION trigger_after_delete_finance_signatories() RETURNS trigger
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

CREATE FUNCTION "trigger_after_insert_PreActivityCashAdvance_signatories"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_insert_PreActivityDirectPayment_signatories"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_insert_ProjectProposalProgramDesign"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_insert_ProjectProposal_signatories"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_insert_StudentOrganization_ACL"() RETURNS trigger
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

CREATE FUNCTION trigger_after_insert_finance_signatories() RETURNS trigger
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

CREATE FUNCTION trigger_after_insert_finance_signatories_initial() RETURNS trigger
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

CREATE FUNCTION "trigger_after_update_ProjectProposalSignatory_completion"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_update_ProjectProposalSignatory_counter"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        UPDATE ProjectProposal
           SET timesPended = timesPended + 1
         WHERE GOSMActivity = NEW.GOSMActivityID;
    END;
$$;


ALTER FUNCTION public."trigger_after_update_ProjectProposalSignatory_counter"() OWNER TO postgres;

--
-- Name: trigger_after_update_ProjectProposal_signatory_facultyAdviser(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION "trigger_after_update_ProjectProposal_signatory_facultyAdviser"() RETURNS trigger
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

CREATE FUNCTION "trigger_after_update_ProjectProposal_signatory_immediateSuperio"() RETURNS trigger
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

CREATE FUNCTION trigger_after_update_gosm_studentorganization() RETURNS trigger
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

CREATE FUNCTION trigger_after_update_signatory_completion() RETURNS trigger
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

CREATE FUNCTION trigger_auto_reject() RETURNS trigger
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

CREATE FUNCTION "trigger_before_insert_PostProjectDirectPayment_sequence"() RETURNS trigger
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

CREATE FUNCTION "trigger_before_insert_PostProjectProposalEventPicture_sequence"() RETURNS trigger
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

CREATE FUNCTION "trigger_before_insert_PostProjectProposalExpense_sequence"() RETURNS trigger
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

CREATE FUNCTION "trigger_before_insert_PreActivityDirectPayment_sequence"() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_account() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_functionality() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_functionalitycategory() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_gosm() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_gosmactivity() RETURNS trigger
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
-- Name: trigger_before_insert_increment_sequence(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_increment_sequence() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_organizationrole() RETURNS trigger
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
-- Name: trigger_before_insert_projectproposalattachment(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalattachment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalAttachment
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalattachment() OWNER TO postgres;

--
-- Name: trigger_before_insert_projectproposalexpenses(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_projectproposalexpenses() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_projectproposalprogramdesign() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_projectproposalprojectedincome() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_projectproposalsourcefunds() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT COALESCE(MAX(sequence) + 1, 1) INTO STRICT NEW.sequence
          FROM ProjectProposalSourceFunds
         WHERE projectProposal = NEW.projectProposal;
        return NEW;
    END;
$$;


ALTER FUNCTION public.trigger_before_insert_projectproposalsourcefunds() OWNER TO postgres;

--
-- Name: trigger_before_insert_schoolyear(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION trigger_before_insert_schoolyear() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_sequence_versioning() RETURNS trigger
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

CREATE FUNCTION trigger_before_insert_term() RETURNS trigger
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

CREATE FUNCTION trigger_before_update_account() RETURNS trigger
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

CREATE FUNCTION trigger_before_update_functionality() RETURNS trigger
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

CREATE FUNCTION trigger_before_update_functionalitycategory() RETURNS trigger
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

CREATE FUNCTION trigger_before_update_gosm_status() RETURNS trigger
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

CREATE FUNCTION trigger_before_update_projectproposal() RETURNS trigger
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

CREATE TABLE "ARFOrganizationPosition" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ARFOrganizationPosition" OWNER TO postgres;

--
-- Name: AccountNotification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AccountNotification" (
    id integer NOT NULL,
    account integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    status smallint DEFAULT 0,
    date timestamp with time zone DEFAULT now() NOT NULL,
    title text,
    description text,
    details json
);


ALTER TABLE "AccountNotification" OWNER TO postgres;

--
-- Name: AccountNotificationStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AccountNotificationStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "AccountNotificationStatus" OWNER TO postgres;

--
-- Name: AccountNotification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "AccountNotification_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "AccountNotification_id_seq" OWNER TO postgres;

--
-- Name: AccountNotification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "AccountNotification_id_seq" OWNED BY "AccountNotification".id;


--
-- Name: AccountStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "AccountStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "AccountStatus" OWNER TO postgres;

--
-- Name: ActivityPublicity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicity" (
    id integer NOT NULL,
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


ALTER TABLE "ActivityPublicity" OWNER TO postgres;

--
-- Name: ActivityPublicityMaterial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityMaterial" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityMaterial" OWNER TO postgres;

--
-- Name: ActivityPublicityModeOfDistribution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityModeOfDistribution" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityModeOfDistribution" OWNER TO postgres;

--
-- Name: ActivityPublicityRevisionReason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityRevisionReason" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityRevisionReason" OWNER TO postgres;

--
-- Name: ActivityPublicityStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityPublicityStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "ActivityPublicityStatus" OWNER TO postgres;

--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "ActivityPublicity_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "ActivityPublicity_id_seq" OWNER TO postgres;

--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "ActivityPublicity_id_seq" OWNED BY "ActivityPublicity".id;


--
-- Name: ActivityResearchForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityResearchForm" (
    "GOSMActivity" integer NOT NULL,
    sequence integer NOT NULL,
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
    "dateSubmitted" timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE "ActivityResearchForm" OWNER TO postgres;

--
-- Name: ActivityVenue; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ActivityVenue" (
    id integer NOT NULL,
    name text,
    capacity integer,
    size smallint,
    rate numeric(12,2),
    "rateType" smallint,
    building smallint
);


ALTER TABLE "ActivityVenue" OWNER TO postgres;

--
-- Name: BookTransferEstablishment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "BookTransferEstablishment" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    "transferAccount" character(6)
);


ALTER TABLE "BookTransferEstablishment" OWNER TO postgres;

--
-- Name: Building; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "Building" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "Building" OWNER TO postgres;

--
-- Name: ExpenseTypeAttachmentRequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "ExpenseTypeAttachmentRequirement" (
    "expenseType" smallint NOT NULL,
    document smallint NOT NULL
);


ALTER TABLE "ExpenseTypeAttachmentRequirement" OWNER TO postgres;

--
-- Name: FinanceSignatoryType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "FinanceSignatoryType" (
    id integer NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE "FinanceSignatoryType" OWNER TO postgres;

--
-- Name: MemberSurveyForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "MemberSurveyForm" (
    id integer NOT NULL,
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


ALTER TABLE "MemberSurveyForm" OWNER TO postgres;

--
-- Name: MemberSurveyForm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "MemberSurveyForm_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "MemberSurveyForm_id_seq" OWNER TO postgres;

--
-- Name: MemberSurveyForm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "MemberSurveyForm_id_seq" OWNED BY "MemberSurveyForm".id;


--
-- Name: OfficerSurveyForm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "OfficerSurveyForm" (
    id integer NOT NULL,
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


ALTER TABLE "OfficerSurveyForm" OWNER TO postgres;

--
-- Name: OfficerSurveyForm_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "OfficerSurveyForm_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OfficerSurveyForm_id_seq" OWNER TO postgres;

--
-- Name: OfficerSurveyForm_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "OfficerSurveyForm_id_seq" OWNED BY "OfficerSurveyForm".id;


--
-- Name: OrganizationMember; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "OrganizationMember" (
    id integer NOT NULL,
    "idNumber" integer NOT NULL,
    organization integer NOT NULL,
    "yearID" integer NOT NULL,
    name text,
    "dateAdded" timestamp with time zone DEFAULT now()
);


ALTER TABLE "OrganizationMember" OWNER TO postgres;

--
-- Name: OrganizationMember_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "OrganizationMember_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "OrganizationMember_id_seq" OWNER TO postgres;

--
-- Name: OrganizationMember_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "OrganizationMember_id_seq" OWNED BY "OrganizationMember".id;


--
-- Name: PostProjectBookTransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransfer" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "nameOfEstablishment" character varying(60),
    amount numeric(12,2),
    purpose character varying(60),
    bsfilename text,
    "bsfilenameToShow" text,
    "idNumber" integer,
    "dateCreated" timestamp with time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE "PostProjectBookTransfer" OWNER TO postgres;

--
-- Name: PostProjectBookTransferParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransferParticular" (
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectBookTransferParticular" OWNER TO postgres;

--
-- Name: PostProjectBookTransferStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectBookTransferStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectBookTransferStatus" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectBookTransfer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectBookTransfer_id_seq" OWNER TO postgres;

--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectBookTransfer_id_seq" OWNED BY "PostProjectBookTransfer".id;


--
-- Name: PostProjectDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPayment" (
    id integer NOT NULL,
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
    "dateCreated" timestamp with time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT 0
);


ALTER TABLE "PostProjectDirectPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentParticular" (
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentPayment" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectDirectPaymentPayment" OWNER TO postgres;

--
-- Name: PostProjectDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectDirectPaymentStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectDirectPaymentStatus" OWNER TO postgres;

--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectDirectPayment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectDirectPayment_id_seq" OWNER TO postgres;

--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectDirectPayment_id_seq" OWNED BY "PostProjectDirectPayment".id;


--
-- Name: PostProjectProposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposal" (
    "GOSMActivity" integer NOT NULL,
    "preparedBy" integer,
    status smallint DEFAULT 0 NOT NULL,
    "dateCreated" timestamp with time zone DEFAULT now() NOT NULL,
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


ALTER TABLE "PostProjectProposal" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalEventPicture" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    filename text,
    "filenameToShow" text,
    description text,
    "idNumber" integer
);


ALTER TABLE "PostProjectProposalEventPicture" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectProposalEventPicture_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectProposalEventPicture_id_seq" OWNER TO postgres;

--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectProposalEventPicture_id_seq" OWNED BY "PostProjectProposalEventPicture".id;


--
-- Name: PostProjectProposalExpense; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalExpense" (
    id integer NOT NULL,
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


ALTER TABLE "PostProjectProposalExpense" OWNER TO postgres;

--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectProposalExpense_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectProposalExpense_id_seq" OWNER TO postgres;

--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectProposalExpense_id_seq" OWNED BY "PostProjectProposalExpense".id;


--
-- Name: PostProjectProposalStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectProposalStatus" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "PostProjectProposalStatus" OWNER TO postgres;

--
-- Name: PostProjectReimbursement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursement" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer DEFAULT '-1'::integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "justificationFDPP" text,
    "justificationFNUCADP" text,
    filenames text[],
    "filenamesToShow" text[],
    "submittedBy" integer,
    "dateCreated" timestamp with time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT 0 NOT NULL
);


ALTER TABLE "PostProjectReimbursement" OWNER TO postgres;

--
-- Name: PostProjectReimbursementParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementParticular" (
    id integer NOT NULL,
    reimbursement integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PostProjectReimbursementParticular" OWNER TO postgres;

--
-- Name: PostProjectReimbursementParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectReimbursementParticular_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectReimbursementParticular_id_seq" OWNER TO postgres;

--
-- Name: PostProjectReimbursementParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectReimbursementParticular_id_seq" OWNED BY "PostProjectReimbursementParticular".id;


--
-- Name: PostProjectReimbursementPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementPayment" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectReimbursementPayment" OWNER TO postgres;

--
-- Name: PostProjectReimbursementSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementSignatory" (
    id integer NOT NULL,
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


ALTER TABLE "PostProjectReimbursementSignatory" OWNER TO postgres;

--
-- Name: PostProjectReimbursementSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectReimbursementSignatory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectReimbursementSignatory_id_seq" OWNER TO postgres;

--
-- Name: PostProjectReimbursementSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectReimbursementSignatory_id_seq" OWNED BY "PostProjectReimbursementSignatory".id;


--
-- Name: PostProjectReimbursementStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PostProjectReimbursementStatus" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "PostProjectReimbursementStatus" OWNER TO postgres;

--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PostProjectReimbursement_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PostProjectReimbursement_id_seq" OWNER TO postgres;

--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PostProjectReimbursement_id_seq" OWNED BY "PostProjectReimbursement".id;


--
-- Name: PreActivityBookTransfer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityBookTransfer" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer DEFAULT '-1'::integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer NOT NULL,
    "dateSubmitted" timestamp with time zone DEFAULT now() NOT NULL,
    status smallint DEFAULT 0 NOT NULL,
    establishment smallint NOT NULL
);


ALTER TABLE "PreActivityBookTransfer" OWNER TO postgres;

--
-- Name: PreActivityBookTransferParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityBookTransferParticular" (
    id integer NOT NULL,
    "bookTransfer" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PreActivityBookTransferParticular" OWNER TO postgres;

--
-- Name: PreActivityBookTransferParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityBookTransferParticular_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityBookTransferParticular_id_seq" OWNER TO postgres;

--
-- Name: PreActivityBookTransferParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityBookTransferParticular_id_seq" OWNED BY "PreActivityBookTransferParticular".id;


--
-- Name: PreActivityBookTransferSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityBookTransferSignatory" (
    id integer NOT NULL,
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


ALTER TABLE "PreActivityBookTransferSignatory" OWNER TO postgres;

--
-- Name: PreActivityBookTransferSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityBookTransferSignatory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityBookTransferSignatory_id_seq" OWNER TO postgres;

--
-- Name: PreActivityBookTransferSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityBookTransferSignatory_id_seq" OWNED BY "PreActivityBookTransferSignatory".id;


--
-- Name: PreActivityBookTransferStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityBookTransferStatus" (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "PreActivityBookTransferStatus" OWNER TO postgres;

--
-- Name: PreActivityBookTransfer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityBookTransfer_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityBookTransfer_id_seq" OWNER TO postgres;

--
-- Name: PreActivityBookTransfer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityBookTransfer_id_seq" OWNED BY "PreActivityBookTransfer".id;


--
-- Name: PreActivityCashAdvance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvance" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT now(),
    purpose text,
    justification text,
    "evaluatedBy" integer,
    status smallint,
    filename text,
    "filenameToShow" text
);


ALTER TABLE "PreActivityCashAdvance" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceParticular" (
    id integer NOT NULL,
    "cashAdvance" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PreActivityCashAdvanceParticular" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvanceParticular_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvanceParticular_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvanceParticular_id_seq" OWNED BY "PreActivityCashAdvanceParticular".id;


--
-- Name: PreActivityCashAdvanceSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceSignatory" (
    id integer NOT NULL,
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


ALTER TABLE "PreActivityCashAdvanceSignatory" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvanceSignatory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvanceSignatory_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvanceSignatory_id_seq" OWNED BY "PreActivityCashAdvanceSignatory".id;


--
-- Name: PreActivityCashAdvanceStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityCashAdvanceStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PreActivityCashAdvanceStatus" OWNER TO postgres;

--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityCashAdvance_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityCashAdvance_id_seq" OWNER TO postgres;

--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityCashAdvance_id_seq" OWNED BY "PreActivityCashAdvance".id;


--
-- Name: PreActivityDirectPayment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPayment" (
    id integer NOT NULL,
    "GOSMActivity" integer NOT NULL,
    "submissionID" integer NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    "submittedBy" integer,
    "dateSubmitted" timestamp with time zone DEFAULT now(),
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


ALTER TABLE "PreActivityDirectPayment" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentParticular" (
    id integer NOT NULL,
    "directPayment" integer NOT NULL,
    particular integer NOT NULL
);


ALTER TABLE "PreActivityDirectPaymentParticular" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPaymentParticular_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPaymentParticular_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPaymentParticular_id_seq" OWNED BY "PreActivityDirectPaymentParticular".id;


--
-- Name: PreActivityDirectPaymentSignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentSignatory" (
    id integer NOT NULL,
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


ALTER TABLE "PreActivityDirectPaymentSignatory" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPaymentSignatory_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPaymentSignatory_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPaymentSignatory_id_seq" OWNED BY "PreActivityDirectPaymentSignatory".id;


--
-- Name: PreActivityDirectPaymentStatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "PreActivityDirectPaymentStatus" (
    id integer NOT NULL,
    name character varying(45)
);


ALTER TABLE "PreActivityDirectPaymentStatus" OWNER TO postgres;

--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PreActivityDirectPayment_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "PreActivityDirectPayment_id_seq" OWNER TO postgres;

--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PreActivityDirectPayment_id_seq" OWNED BY "PreActivityDirectPayment".id;


--
-- Name: projectproposalexpenses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalexpenses (
    id integer NOT NULL,
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    material character varying(45) NOT NULL,
    quantity integer NOT NULL,
    unitcost numeric(12,2) NOT NULL,
    type smallint DEFAULT 0 NOT NULL
);


ALTER TABLE projectproposalexpenses OWNER TO postgres;

--
-- Name: ProjectExpensesWithoutTransaction; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "ProjectExpensesWithoutTransaction" AS
 SELECT ppe.id,
    ppe.projectproposal,
    ppe.sequence,
    ppe.material,
    ppe.quantity,
    ppe.unitcost,
    ppe.type
   FROM projectproposalexpenses ppe
  WHERE (NOT (ppe.id IN ( SELECT "PreActivityDirectPaymentParticular".particular
           FROM "PreActivityDirectPaymentParticular"
        UNION
         SELECT "PreActivityCashAdvanceParticular".particular
           FROM "PreActivityCashAdvanceParticular"
        UNION
         SELECT "PreActivityBookTransferParticular".particular
           FROM "PreActivityBookTransferParticular"
        UNION
         SELECT "PostProjectReimbursementParticular".particular
           FROM "PostProjectReimbursementParticular")));


ALTER TABLE "ProjectExpensesWithoutTransaction" OWNER TO postgres;

--
-- Name: RateType; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "RateType" (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE "RateType" OWNER TO postgres;

--
-- Name: SystemConfiguration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "SystemConfiguration" (
    name character varying(20) NOT NULL,
    value json NOT NULL,
    description json NOT NULL
);


ALTER TABLE "SystemConfiguration" OWNER TO postgres;

--
-- Name: VenueSize; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "VenueSize" (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE "VenueSize" OWNER TO postgres;

--
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE account (
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
    datecreated timestamp with time zone DEFAULT now() NOT NULL,
    datemodified timestamp with time zone DEFAULT now(),
    passwordexpiration timestamp with time zone
);


ALTER TABLE account OWNER TO postgres;

--
-- Name: accounttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE accounttype (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE accounttype OWNER TO postgres;

--
-- Name: activityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activityattachmentrequirement (
    id integer NOT NULL,
    activitytype integer NOT NULL,
    attachment smallint NOT NULL,
    optional boolean DEFAULT false NOT NULL
);


ALTER TABLE activityattachmentrequirement OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE activityattachmentrequirement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activityattachmentrequirement_id_seq OWNER TO postgres;

--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE activityattachmentrequirement_id_seq OWNED BY activityattachmentrequirement.id;


--
-- Name: activitynature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activitynature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE activitynature OWNER TO postgres;

--
-- Name: activitytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activitytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE activitytype OWNER TO postgres;

--
-- Name: amtactivityevaluation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE amtactivityevaluation (
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
    datereserved timestamp with time zone DEFAULT now(),
    dateevaluated timestamp with time zone
);


ALTER TABLE amtactivityevaluation OWNER TO postgres;

--
-- Name: amtactivityevaluationstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE amtactivityevaluationstatus (
    id integer NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE amtactivityevaluationstatus OWNER TO postgres;

--
-- Name: college; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE college (
    shortacronym character(3) NOT NULL,
    fullacronym character varying(20),
    name character varying(60)
);


ALTER TABLE college OWNER TO postgres;

--
-- Name: documentattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE documentattachmentrequirement (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE documentattachmentrequirement OWNER TO postgres;

--
-- Name: expensetype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE expensetype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE expensetype OWNER TO postgres;

--
-- Name: functionality; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionality (
    id integer NOT NULL,
    name character varying(100),
    category integer
);


ALTER TABLE functionality OWNER TO postgres;

--
-- Name: functionalitycategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionalitycategory (
    id integer NOT NULL,
    name character varying(45),
    domain smallint
);


ALTER TABLE functionalitycategory OWNER TO postgres;

--
-- Name: functionalitydomain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE functionalitydomain (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE functionalitydomain OWNER TO postgres;

--
-- Name: gosm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosm (
    id integer,
    termid integer NOT NULL,
    studentorganization integer NOT NULL,
    status smallint DEFAULT 1 NOT NULL,
    datecreated timestamp with time zone DEFAULT now() NOT NULL,
    datesubmitted timestamp with time zone,
    datestatusmodified timestamp with time zone,
    preparedby integer,
    statusevaluator integer,
    comments text
);


ALTER TABLE gosm OWNER TO postgres;

--
-- Name: gosmactivity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmactivity (
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


ALTER TABLE gosmactivity OWNER TO postgres;

--
-- Name: gosmactivity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE gosmactivity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE gosmactivity_id_seq OWNER TO postgres;

--
-- Name: gosmactivity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE gosmactivity_id_seq OWNED BY gosmactivity.id;


--
-- Name: gosmactivityprojecthead; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmactivityprojecthead (
    idnumber integer NOT NULL,
    activityid integer NOT NULL
);


ALTER TABLE gosmactivityprojecthead OWNER TO postgres;

--
-- Name: gosmstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE gosmstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE gosmstatus OWNER TO postgres;

--
-- Name: organizationaccesscontrol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationaccesscontrol (
    role integer NOT NULL,
    functionality integer NOT NULL,
    isallowed boolean DEFAULT false NOT NULL
);


ALTER TABLE organizationaccesscontrol OWNER TO postgres;

--
-- Name: organizationcluster; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationcluster (
    id smallint NOT NULL,
    name character varying(128) NOT NULL,
    acronym character varying(20)
);


ALTER TABLE organizationcluster OWNER TO postgres;

--
-- Name: organizationfacultyadviser; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationfacultyadviser (
    id integer NOT NULL,
    organization integer NOT NULL,
    faculty integer NOT NULL,
    yearid integer DEFAULT system_get_current_year_id() NOT NULL
);


ALTER TABLE organizationfacultyadviser OWNER TO postgres;

--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE organizationfacultyadviser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE organizationfacultyadviser_id_seq OWNER TO postgres;

--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE organizationfacultyadviser_id_seq OWNED BY organizationfacultyadviser.id;


--
-- Name: organizationnature; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationnature (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    acronym character varying(10)
);


ALTER TABLE organizationnature OWNER TO postgres;

--
-- Name: organizationofficer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationofficer (
    idnumber integer NOT NULL,
    role integer NOT NULL,
    yearid integer NOT NULL,
    dateassigned timestamp with time zone DEFAULT now(),
    isactive boolean DEFAULT true
);


ALTER TABLE organizationofficer OWNER TO postgres;

--
-- Name: organizationrole; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationrole (
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


ALTER TABLE organizationrole OWNER TO postgres;

--
-- Name: organizationstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE organizationstatus (
    id smallint NOT NULL,
    name character varying(45)
);


ALTER TABLE organizationstatus OWNER TO postgres;

--
-- Name: postactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE postactivityattachmentrequirement (
)
INHERITS (activityattachmentrequirement);


ALTER TABLE postactivityattachmentrequirement OWNER TO postgres;

--
-- Name: preactivityattachmentrequirement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE preactivityattachmentrequirement (
)
INHERITS (activityattachmentrequirement);


ALTER TABLE preactivityattachmentrequirement OWNER TO postgres;

--
-- Name: projectproposal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposal (
    id integer NOT NULL,
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
    datecreated timestamp with time zone DEFAULT now(),
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
    timespended integer DEFAULT 0 NOT NULL
);


ALTER TABLE projectproposal OWNER TO postgres;

--
-- Name: projectproposal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposal_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposal_id_seq OWNER TO postgres;

--
-- Name: projectproposal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposal_id_seq OWNED BY projectproposal.id;


--
-- Name: projectproposalattachment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalattachment (
    id integer NOT NULL,
    projectproposal integer NOT NULL,
    requirement smallint NOT NULL,
    sequence integer DEFAULT '-1'::integer NOT NULL,
    idnumber integer,
    filename text,
    filenametoshow text,
    directory text NOT NULL
);


ALTER TABLE projectproposalattachment OWNER TO postgres;

--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalattachment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalattachment_id_seq OWNER TO postgres;

--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalattachment_id_seq OWNED BY projectproposalattachment.id;


--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalexpenses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalexpenses_id_seq OWNER TO postgres;

--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalexpenses_id_seq OWNED BY projectproposalexpenses.id;


--
-- Name: projectproposalprogramdesign; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprogramdesign (
    id integer NOT NULL,
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


ALTER TABLE projectproposalprogramdesign OWNER TO postgres;

--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalprogramdesign_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalprogramdesign_id_seq OWNER TO postgres;

--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalprogramdesign_id_seq OWNED BY projectproposalprogramdesign.id;


--
-- Name: projectproposalprogramdesignpersonincharge; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprogramdesignpersonincharge (
    id integer NOT NULL,
    programdesign integer NOT NULL,
    projecthead integer NOT NULL
);


ALTER TABLE projectproposalprogramdesignpersonincharge OWNER TO postgres;

--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalprogramdesignpersonincharge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalprogramdesignpersonincharge_id_seq OWNER TO postgres;

--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalprogramdesignpersonincharge_id_seq OWNED BY projectproposalprogramdesignpersonincharge.id;


--
-- Name: projectproposalprojectedincome; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalprojectedincome (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    item character varying(45) NOT NULL,
    quantity integer NOT NULL,
    sellingprice numeric(12,2) NOT NULL
);


ALTER TABLE projectproposalprojectedincome OWNER TO postgres;

--
-- Name: projectproposalreschedulereason; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalreschedulereason (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE projectproposalreschedulereason OWNER TO postgres;

--
-- Name: projectproposalsignatory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalsignatory (
    id integer NOT NULL,
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


ALTER TABLE projectproposalsignatory OWNER TO postgres;

--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projectproposalsignatory_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projectproposalsignatory_id_seq OWNER TO postgres;

--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projectproposalsignatory_id_seq OWNED BY projectproposalsignatory.id;


--
-- Name: projectproposalsourcefunds; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalsourcefunds (
    projectproposal integer NOT NULL,
    sequence integer NOT NULL,
    name character varying(45),
    amount numeric(12,2)
);


ALTER TABLE projectproposalsourcefunds OWNER TO postgres;

--
-- Name: projectproposalstatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projectproposalstatus (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE projectproposalstatus OWNER TO postgres;

--
-- Name: schoolyear; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE schoolyear (
    id integer,
    startyear smallint NOT NULL,
    endyear smallint NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    CONSTRAINT start_end_year_value CHECK ((startyear < endyear))
);


ALTER TABLE schoolyear OWNER TO postgres;

--
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE session OWNER TO postgres;

--
-- Name: signatorystatus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatorystatus (
    id smallint NOT NULL,
    name character varying(45) NOT NULL
);


ALTER TABLE signatorystatus OWNER TO postgres;

--
-- Name: signatorytype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE signatorytype (
    id smallint NOT NULL,
    name character varying(45) NOT NULL,
    lineup smallint NOT NULL
);


ALTER TABLE signatorytype OWNER TO postgres;

--
-- Name: studentorganization; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE studentorganization (
    id integer NOT NULL,
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


ALTER TABLE studentorganization OWNER TO postgres;

--
-- Name: term; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE term (
    id integer,
    schoolyearid integer NOT NULL,
    number integer NOT NULL,
    datestart date NOT NULL,
    dateend date NOT NULL,
    CONSTRAINT date_start_end_value CHECK ((datestart <= dateend)),
    CONSTRAINT number_max_value CHECK ((number <= 3)),
    CONSTRAINT number_min_value CHECK ((number >= 1))
);


ALTER TABLE term OWNER TO postgres;

--
-- Name: AccountNotification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification" ALTER COLUMN id SET DEFAULT nextval('"AccountNotification_id_seq"'::regclass);


--
-- Name: ActivityPublicity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity" ALTER COLUMN id SET DEFAULT nextval('"ActivityPublicity_id_seq"'::regclass);


--
-- Name: MemberSurveyForm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm" ALTER COLUMN id SET DEFAULT nextval('"MemberSurveyForm_id_seq"'::regclass);


--
-- Name: OfficerSurveyForm id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm" ALTER COLUMN id SET DEFAULT nextval('"OfficerSurveyForm_id_seq"'::regclass);


--
-- Name: OrganizationMember id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationMember" ALTER COLUMN id SET DEFAULT nextval('"OrganizationMember_id_seq"'::regclass);


--
-- Name: PostProjectBookTransfer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer" ALTER COLUMN id SET DEFAULT nextval('"PostProjectBookTransfer_id_seq"'::regclass);


--
-- Name: PostProjectDirectPayment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment" ALTER COLUMN id SET DEFAULT nextval('"PostProjectDirectPayment_id_seq"'::regclass);


--
-- Name: PostProjectProposalEventPicture id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture" ALTER COLUMN id SET DEFAULT nextval('"PostProjectProposalEventPicture_id_seq"'::regclass);


--
-- Name: PostProjectProposalExpense id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense" ALTER COLUMN id SET DEFAULT nextval('"PostProjectProposalExpense_id_seq"'::regclass);


--
-- Name: PostProjectReimbursement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement" ALTER COLUMN id SET DEFAULT nextval('"PostProjectReimbursement_id_seq"'::regclass);


--
-- Name: PostProjectReimbursementParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular" ALTER COLUMN id SET DEFAULT nextval('"PostProjectReimbursementParticular_id_seq"'::regclass);


--
-- Name: PostProjectReimbursementSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory" ALTER COLUMN id SET DEFAULT nextval('"PostProjectReimbursementSignatory_id_seq"'::regclass);


--
-- Name: PreActivityBookTransfer id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer" ALTER COLUMN id SET DEFAULT nextval('"PreActivityBookTransfer_id_seq"'::regclass);


--
-- Name: PreActivityBookTransferParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferParticular" ALTER COLUMN id SET DEFAULT nextval('"PreActivityBookTransferParticular_id_seq"'::regclass);


--
-- Name: PreActivityBookTransferSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory" ALTER COLUMN id SET DEFAULT nextval('"PreActivityBookTransferSignatory_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvance id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvance_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvanceParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvanceParticular_id_seq"'::regclass);


--
-- Name: PreActivityCashAdvanceSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory" ALTER COLUMN id SET DEFAULT nextval('"PreActivityCashAdvanceSignatory_id_seq"'::regclass);


--
-- Name: PreActivityDirectPayment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPayment_id_seq"'::regclass);


--
-- Name: PreActivityDirectPaymentParticular id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPaymentParticular_id_seq"'::regclass);


--
-- Name: PreActivityDirectPaymentSignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory" ALTER COLUMN id SET DEFAULT nextval('"PreActivityDirectPaymentSignatory_id_seq"'::regclass);


--
-- Name: activityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: gosmactivity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity ALTER COLUMN id SET DEFAULT nextval('gosmactivity_id_seq'::regclass);


--
-- Name: organizationfacultyadviser id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser ALTER COLUMN id SET DEFAULT nextval('organizationfacultyadviser_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: postactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Name: preactivityattachmentrequirement id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement ALTER COLUMN id SET DEFAULT nextval('activityattachmentrequirement_id_seq'::regclass);


--
-- Name: preactivityattachmentrequirement optional; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement ALTER COLUMN optional SET DEFAULT false;


--
-- Name: projectproposal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal ALTER COLUMN id SET DEFAULT nextval('projectproposal_id_seq'::regclass);


--
-- Name: projectproposalattachment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment ALTER COLUMN id SET DEFAULT nextval('projectproposalattachment_id_seq'::regclass);


--
-- Name: projectproposalexpenses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses ALTER COLUMN id SET DEFAULT nextval('projectproposalexpenses_id_seq'::regclass);


--
-- Name: projectproposalprogramdesign id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign ALTER COLUMN id SET DEFAULT nextval('projectproposalprogramdesign_id_seq'::regclass);


--
-- Name: projectproposalprogramdesignpersonincharge id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge ALTER COLUMN id SET DEFAULT nextval('projectproposalprogramdesignpersonincharge_id_seq'::regclass);


--
-- Name: projectproposalsignatory id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory ALTER COLUMN id SET DEFAULT nextval('projectproposalsignatory_id_seq'::regclass);


--
-- Data for Name: ARFOrganizationPosition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ARFOrganizationPosition" (id, name) FROM stdin;
0	Officer
1	Member
2	Non-member
\.


--
-- Data for Name: AccountNotification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AccountNotification" (id, account, sequence, status, date, title, description, details) FROM stdin;
1	1111112	1	0	2018-03-20 15:18:36.50358-07	GOSM Submission	GOSM for current has been submitted	null
2	1111111	1	0	2018-03-20 15:19:15.784233-07	GOSM Evaluation	The organization's GOSM have been approved by CSO Chairperson	{"GOSMID":100001,"evaluator":1011117,"statusID":3}
\.


--
-- Data for Name: AccountNotificationStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AccountNotificationStatus" (id, name) FROM stdin;
0	Sent/Unseen
1	Seen
2	Opened
3	Deleted
\.


--
-- Name: AccountNotification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"AccountNotification_id_seq"', 2, true);


--
-- Data for Name: AccountStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "AccountStatus" (id, name) FROM stdin;
0	Active
1	Disabled si Neil
2	Deleted
3	Virgin Account
\.


--
-- Data for Name: ActivityPublicity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicity" (id, "GOSMActivity", "submissionID", sequence, material, "modeOfDistribution", description, "targetPostingDate", "submittedBy", "dateSubmitted", status, "checkedBy", "dateChecked", comments, filename, "filenameToShow", "revisionReason") FROM stdin;
\.


--
-- Data for Name: ActivityPublicityMaterial; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityMaterial" (id, name) FROM stdin;
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

COPY "ActivityPublicityModeOfDistribution" (id, name) FROM stdin;
0	Online
1	Printed
\.


--
-- Data for Name: ActivityPublicityRevisionReason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityRevisionReason" (id, name) FROM stdin;
0	Unoriginal design
1	Incorrect grammar
2	Incomplete logo
3	Contents not in line with La Sallian Values
4	Old Version
\.


--
-- Data for Name: ActivityPublicityStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityPublicityStatus" (id, name) FROM stdin;
0	For Evaluation
1	Approved
2	Pended
3	Denied
4	Old Version
\.


--
-- Name: ActivityPublicity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"ActivityPublicity_id_seq"', 1, false);


--
-- Data for Name: ActivityResearchForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityResearchForm" ("GOSMActivity", sequence, "positionInOrganization", "IUTPOTA", "TASMI", "IFIDTA", "TAWWP", "TOUMTGTTA", field6, field7, "WWWITA", "FAC", "EFFA", "dateSubmitted") FROM stdin;
\.


--
-- Data for Name: ActivityVenue; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ActivityVenue" (id, name, capacity, size, rate, "rateType", building) FROM stdin;
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

COPY "BookTransferEstablishment" (id, name, "transferAccount") FROM stdin;
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

COPY "Building" (id, name) FROM stdin;
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

COPY "ExpenseTypeAttachmentRequirement" ("expenseType", document) FROM stdin;
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

COPY "FinanceSignatoryType" (id, name, lineup) FROM stdin;
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

COPY "MemberSurveyForm" (id, "termID", member, "organizationID", field1, field2, field3, field4, field5, field6, field7, field8, field9, field10, field11, field12, field13) FROM stdin;
\.


--
-- Name: MemberSurveyForm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"MemberSurveyForm_id_seq"', 1, false);


--
-- Data for Name: OfficerSurveyForm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "OfficerSurveyForm" (id, "termID", "organizationID", officer, field1, field2, field3, field4, field5, field6, field7, field8, field9) FROM stdin;
\.


--
-- Name: OfficerSurveyForm_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"OfficerSurveyForm_id_seq"', 1, false);


--
-- Data for Name: OrganizationMember; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "OrganizationMember" (id, "idNumber", organization, "yearID", name, "dateAdded") FROM stdin;
\.


--
-- Name: OrganizationMember_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"OrganizationMember_id_seq"', 1, false);


--
-- Data for Name: PostProjectBookTransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransfer" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, purpose, bsfilename, "bsfilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransferParticular" ("bookTransfer", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectBookTransferStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectBookTransferStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Name: PostProjectBookTransfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectBookTransfer_id_seq"', 1, false);


--
-- Data for Name: PostProjectDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "nameOfEstablishment", amount, "paymentBy", "delayedProcessing", fqfilename, roffilename, "fqfilenameToShow", "roffilenameToShow", "idNumber", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentParticular" ("directPayment", particular) FROM stdin;
\.


--
-- Data for Name: PostProjectDirectPaymentPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentPayment" (id, name) FROM stdin;
0	Cheque
1	Book Transfer
\.


--
-- Data for Name: PostProjectDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectDirectPaymentStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
\.


--
-- Name: PostProjectDirectPayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectDirectPayment_id_seq"', 1, false);


--
-- Data for Name: PostProjectProposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposal" ("GOSMActivity", "preparedBy", status, "dateCreated", "dateSubmitted", "ANP", "ANMP", objectives, "WATTTWITA", "WWYGLIETA", "HDTATYLCTTDOTP", "WATTWWAWCYDTPTFHA", galsfilename, "galsfilenameToShow", "isBriefContextCompleted", "isOtherFinanceDocumentsCompleted", "isFinanceDocumentCompleted", "isCheckedDP", "isCheckedR", "isCheckedBT", comments, "sectionsToBeEdited", document, "checkedByStage1", "signatureStage1", "checkedByStage2", "signatureStage2") FROM stdin;
\.


--
-- Data for Name: PostProjectProposalEventPicture; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalEventPicture" (id, "GOSMActivity", "submissionID", sequence, filename, "filenameToShow", description, "idNumber") FROM stdin;
\.


--
-- Name: PostProjectProposalEventPicture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectProposalEventPicture_id_seq"', 1, false);


--
-- Data for Name: PostProjectProposalExpense; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalExpense" (id, "GOSMActivity", "submissionID", sequence, particular, establishment, price, filename, "filenameToShow", "idNumber") FROM stdin;
\.


--
-- Name: PostProjectProposalExpense_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectProposalExpense_id_seq"', 1, false);


--
-- Data for Name: PostProjectProposalStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectProposalStatus" (id, name) FROM stdin;
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

COPY "PostProjectReimbursement" (id, "GOSMActivity", "submissionID", sequence, "justificationFDPP", "justificationFNUCADP", filenames, "filenamesToShow", "submittedBy", "dateCreated", status) FROM stdin;
\.


--
-- Data for Name: PostProjectReimbursementParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementParticular" (id, reimbursement, particular) FROM stdin;
\.


--
-- Name: PostProjectReimbursementParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectReimbursementParticular_id_seq"', 1, false);


--
-- Data for Name: PostProjectReimbursementPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementPayment" (id, name) FROM stdin;
0	Payment By Check
1	Payment By Book Transfer
\.


--
-- Data for Name: PostProjectReimbursementSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementSignatory" (id, reimbursement, signatory, type, status, comments, sectionstoedit, document, digitalsignature, datesigned) FROM stdin;
\.


--
-- Name: PostProjectReimbursementSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectReimbursementSignatory_id_seq"', 1, false);


--
-- Data for Name: PostProjectReimbursementStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PostProjectReimbursementStatus" (id, name) FROM stdin;
0	For approval
1	Approved
2	Pend
3	Denied
\.


--
-- Name: PostProjectReimbursement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PostProjectReimbursement_id_seq"', 1, false);


--
-- Data for Name: PreActivityBookTransfer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityBookTransfer" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", status, establishment) FROM stdin;
\.


--
-- Data for Name: PreActivityBookTransferParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityBookTransferParticular" (id, "bookTransfer", particular) FROM stdin;
\.


--
-- Name: PreActivityBookTransferParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityBookTransferParticular_id_seq"', 1, false);


--
-- Data for Name: PreActivityBookTransferSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityBookTransferSignatory" (id, "bookTransfer", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Name: PreActivityBookTransferSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityBookTransferSignatory_id_seq"', 1, false);


--
-- Data for Name: PreActivityBookTransferStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityBookTransferStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Name: PreActivityBookTransfer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityBookTransfer_id_seq"', 1, false);


--
-- Data for Name: PreActivityCashAdvance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvance" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", purpose, justification, "evaluatedBy", status, filename, "filenameToShow") FROM stdin;
\.


--
-- Data for Name: PreActivityCashAdvanceParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceParticular" (id, "cashAdvance", particular) FROM stdin;
\.


--
-- Name: PreActivityCashAdvanceParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvanceParticular_id_seq"', 1, false);


--
-- Data for Name: PreActivityCashAdvanceSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceSignatory" (id, "cashAdvance", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Name: PreActivityCashAdvanceSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvanceSignatory_id_seq"', 1, false);


--
-- Data for Name: PreActivityCashAdvanceStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityCashAdvanceStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Name: PreActivityCashAdvance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityCashAdvance_id_seq"', 1, false);


--
-- Data for Name: PreActivityDirectPayment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPayment" (id, "GOSMActivity", "submissionID", sequence, "submittedBy", "dateSubmitted", "nameOfEstablishment", amount, "reasonForDelayedPRSProcessing", "galsFilename", "galsfilenameToShow", "fqFilename", "fqfilenameToShow", "rofFilename", "rofFilenameToShow", "evaluatedBy", comments, "dateEvaluated", status) FROM stdin;
\.


--
-- Data for Name: PreActivityDirectPaymentParticular; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentParticular" (id, "directPayment", particular) FROM stdin;
\.


--
-- Name: PreActivityDirectPaymentParticular_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPaymentParticular_id_seq"', 1, false);


--
-- Data for Name: PreActivityDirectPaymentSignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentSignatory" (id, "directPayment", signatory, type, status, comments, "sectionsToEdit", document, "digitalSignature", "dateSigned") FROM stdin;
\.


--
-- Name: PreActivityDirectPaymentSignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPaymentSignatory_id_seq"', 1, false);


--
-- Data for Name: PreActivityDirectPaymentStatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PreActivityDirectPaymentStatus" (id, name) FROM stdin;
0	For Approval
1	Approved
2	Pend
3	Denied
\.


--
-- Name: PreActivityDirectPayment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PreActivityDirectPayment_id_seq"', 1, false);


--
-- Data for Name: RateType; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "RateType" (id, name) FROM stdin;
0	Per hour
1	Per person
2	Per use
3	Per person, per use
4	Per Dominique
\.


--
-- Data for Name: SystemConfiguration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "SystemConfiguration" (name, value, description) FROM stdin;
PASSWORD	{"EXPIRATION_TIME": {"DAYS": 0, "MONTHS": 3}}	{"EXPIRATION_TIME": "Contains values on much time a password is before its expiration"}
\.


--
-- Data for Name: VenueSize; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "VenueSize" (id, name) FROM stdin;
0	Small
1	Mediume
2	Large
\.


--
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY account (idnumber, email, type, status, password, salt, firstname, middlename, lastname, contactnumber, privatekey, publickey, path_profilepicture, datecreated, datemodified, passwordexpiration) FROM stdin;
1111112	org_vp_internal@dlsu.edu.ph	1	3	$2a$06$L1c1mYM4wMS/Tuc.gplFIeFYSZMpbrrr6jorXV7CqyyIijMet.ddW	$2a$06$L1c1mYM4wMS/Tuc.gplFIe	Organization	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1111113	org_vp_documentation@dlsu.edu.ph	1	3	$2a$06$jn/RWOE79AU1sWmX2sl66uULFU2ZhdEx3AG/McO5DrOFVykDmj8nC	$2a$06$jn/RWOE79AU1sWmX2sl66u	Organization	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1111114	org_avp_documentation@dlsu.edu.ph	1	3	$2a$06$g2zlV8tGxkJ/teUho7Gi.OnJDZav7eyn2K4jj14gptmRH49L6eW8i	$2a$06$g2zlV8tGxkJ/teUho7Gi.O	Organization	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1111115	org_vp_finance@dlsu.edu.ph	1	3	$2a$06$ssDQAcvd0n225Z0EdQechO/hBvnqLhON7.994GvBOjHcLRU3/un4C	$2a$06$ssDQAcvd0n225Z0EdQechO	Organization	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1111116	org_avp_finance@dlsu.edu.ph	1	3	$2a$06$Dk8ToRxmdet1c6754dnoU./Wb.M/L/gwgTXLKbLmYvPQJG4Zv/TqS	$2a$06$Dk8ToRxmdet1c6754dnoU.	Organization	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011118	cso_executivechairperson_external@dlsu.edu.ph	1	3	$2a$06$FPRuPeNFbuK7KzC8xRUVFe3RpMQGUEwaIsrJAPWgYo/6yv47PedB2	$2a$06$FPRuPeNFbuK7KzC8xRUVFe	CSO	\N	Executive Chairperson External	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/K3G9u1nV2qd7k3lfCoRCKbcG\r\ntVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9dMMVuozDgfLn7dxe+O3TjI1g\r\nCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMtC5Baj3ihb9Y0RKKhgQIDAQAB\r\nAoGAc8jXJPmaJQlVhcgqM+nR192NbwcSUU+7MyX12yv+aKs//vvZHb7xAOPRrLbR\r\n0ThJ5RCrK4Jp0FiKI2Vzz5f7Zxdhvuwl6wYhcMZ8zk42fX8bzUF1uBjPsRk84gWK\r\n7I3faSvXqeuEiDNjXkjKfIMWyBL//vUowl7dc4rRiZHew1UCQQC473GHpVn9WRg7\r\nI36Ts6QGJVB6/AgZaBSwatj0eXSJLOToILxIjmtf/oe9j8Pfx9VoxGvuuxikrjJu\r\nX83xxk5TAkEAsxNzrImX4Z2xV+cg2xVDG/ojMhhsGRrJk9HF65UZoRX3KNyY/SlI\r\n3BZ99MayvTsTgxv6bvMaXnbjrCgNr6rOWwJBAJWjCNWc8WeRQ432dmDEph9i6e/Z\r\nJiSIltT4X3vRGn40GTPJ6Q88TZ1qsiKrxO25H/CZnkuYj6QQXzX3xweuUYkCQG4o\r\niiDaJ2cvtVdoo8qBgt3j+uCnK2AqHVRkV8c62iBAveESCr65NcvFvkfkLzG+9JrT\r\njDPSMidoJVfS79BfVz8CQBMKt18LgvWQsd76NUPgnFDWkS8O5h7kIJrU3nHuKDjT\r\nBZcLymoRZJvM/52CSshJ3iJ/80HDD/3DEN2KhMlnBpc=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCBXXm3efVEN4sQ+vfDyhlhuDq/\r\nK3G9u1nV2qd7k3lfCoRCKbcGtVDo+Q8L17glOnlg7jCp0LRzs1r1DojB3R/bYHv9\r\ndMMVuozDgfLn7dxe+O3TjI1gCmkcAj9m3orM27CExGutEiRAyLecSzT/r+kJ5cMt\r\nC5Baj3ihb9Y0RKKhgQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011119	cso_vp_aps@dlsu.edu.ph	1	3	$2a$06$uUY/iVcn4qzrU2sJyvqppejog11IS22sGa3WpN3C4iCtCMpwh/1Ly	$2a$06$uUY/iVcn4qzrU2sJyvqppe	CSO	\N	VP - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQDS96X7dtaSFpn9k/7mo17P/Wwz+kK2pTbveE105mCkPA2OHVSc\r\n9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3KURL0ImjPDLg99TN+KncSz9Xp\r\n33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31KjxmbyR7gNI+iN7eSxNKbwIDAQAB\r\nAoGBAM079tFnjt6X9j7mlvewvzAADh+SuwwMNiFJG7E53ZJoiZdTmVkJByFSzLSp\r\n5SovSnGxQBuqrRC7KtBEYGoicmxSWrPa28YstZw3VyK5zay9wWuyogHyx535bUuI\r\ngIu2rkGqCnlVO93PEPHZisCN3DWnxSmrwSleJXLyXEebW9ThAkEA/EmCw3zyeQGs\r\n05i8RI92q7gumnvbVrBrf2i3SEPA+4H63Asg/NU9hDrWyNS0+MiU3/ov7N5h/7v4\r\nkNwAteKkVQJBANYSdzuL8rDS8vN78l8xT0qFnHqNg777yR28RFAwiBUCAwOYQG2f\r\ng8MD1g1l3Nzu7riewIDZXE5CCSlnEE4717MCQHjv5DdB1hobq3VjahyTiReYGv8D\r\nEInl2CIjWHjTwdbO4CpLS2zn661PZ1auYHJB9NvJWt/5WpD00preW5jVJGECQDio\r\n1ooaNnf6vXcYfUQYxwXQa2Q8hHxOJCMMq4AV+E6nI6kV6SeaqsM5BrSxG04Wp3SS\r\nAB2aakYEUGx27OfoCuUCQQDqnjl4xK+d7yMpfz58gGOQIuKgPQlSFx7BDlBBcX46\r\nPeRqcg6LDDmiTQeAW0N8ywoyAsTe8lLyomiujzoa0nNC\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDS96X7dtaSFpn9k/7mo17P/Wwz\r\n+kK2pTbveE105mCkPA2OHVSc9bzPKmCvvISeMFzm8XjIvpXlqRdBIANFQGAtRT3K\r\nURL0ImjPDLg99TN+KncSz9Xp33joslOIOAXdg/CE0j5ijhWvSRIf/WN0NE31Kjxm\r\nbyR7gNI+iN7eSxNKbwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011120	cso_avc_aps@dlsu.edu.ph	1	0	$2a$06$.0s9LxtN90SOusLiov3M8uVSFjIZ3h7j5P13TP5oMEZnyHP89mKd2	$2a$06$.0s9LxtN90SOusLiov3M8u	CSO	\N	AVC - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCOipOmH7ymZy3hQ41GlpFn6bgNPtEuQmvSDnZWbkfC0HWG7ho5\r\nuqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR9G+81YH6T8Qp8MyaN/5uggc6\r\nA7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzqtiKPUEpbCtFuQc+SUQIDAQAB\r\nAoGANbnp2Q3RT29IjcWmdFrAR8iCRQvOUH9coHovBHjgt39XLRqF7Ah9qmQl5XjB\r\nYyO68OkwCjylKx2M4AFFSnBPPeWC4N4e3hok/82rtyhzUkL6TmSNmY0utqjdhC7f\r\nQFgRutu6mcyi4kRIiVgr68ZSOioQcELoct1T8vTFJqfUj5kCQQDFEKgnnAJaVTrF\r\nz9yVH5SNiEk683nqI2zHI4paeq48MRyKPb9Wtv56zmKzY3lZ+X9eflYDd763kA6T\r\n7oG4MHSjAkEAuSuR7X7j53ELX02QqDyXVSScostkIDUJGUDA+WiVirEkA54Jh+gX\r\nDmGJZlA3wfEvZN1/6lp/8ywWW/tIw0rYewJAX0WCRkQCTzHNTD0F44J1C0fMP5fe\r\nZPfjaxMfnEabXbZQmfToQEAQH8cPqLJ6xKj+jux9IQgPSCd5JMO2KxoiCQJAKpRI\r\nRBJvmaK2+L0/TFBShDOdCRo39ef8JaBsP227JV9CZsqKaoQF+TqYe7xqdeBeA5Wj\r\nemJBFcvHgHMx8iZdzQJBAMAa4CCAqM8FIlF50LMi/Mh07RVL7bpGTTZNgNmyoj3S\r\nWo4x/9CFpNLrR3Za7Q4Vxmb8DGdfJIgb9fu7FGMf97I=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOipOmH7ymZy3hQ41GlpFn6bgN\r\nPtEuQmvSDnZWbkfC0HWG7ho5uqoy90bh89eUxQ2VNyoh1WuiF9YF6KIfxTxIQ1uR\r\n9G+81YH6T8Qp8MyaN/5uggc6A7czxgddbSs94iQCDnGTA0YiBpLT9fCrmSEDalzq\r\ntiKPUEpbCtFuQc+SUQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 18:34:50.881842-07	2018-06-20 18:34:50.881842-07
1011121	cso_a_aps@dlsu.edu.ph	1	3	$2a$06$AuMzkPqV9RJ.IRMx.scpwePHvyKMX6HMpoaloX4jPDNSl5BXXQF3K	$2a$06$AuMzkPqV9RJ.IRMx.scpwe	CSO	\N	A - APS	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCOYiBI+1aZziS3gGvHXF03c87V8tL14124sGiEhUHRLVQ5Uo7P\r\nc2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0GAudrXsAenJm/vCUVEuxYUpUt\r\n3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGRBwbGbO5pizm1z5TQZwIDAQAB\r\nAoGBAIYd4BNezIAsMWG4Uc2ELzogl9/nztdWx91ELe9GJm0GqaMlJOg75qPG9K0u\r\nH+zJvJmjDHIeAuJ91J2RATiBnGb1uFTPFfCa2/I1x9V/jcdCnl6de6V7bnJGj4yt\r\n+FwY0O3YSEARUNuOrq5U5Naj6OiszcA/cUEhkOu0WpYvPsPhAkEAygdM6rAM7uNR\r\nlz05H+gygcyUHpplyBZv7t0SoroJZl+kQCGSVhPYusplkM1W2kdqzkSfgixhyYDR\r\n9FMA7fJQ/QJBALRrstwoLPw+N3222XxTao1ik7voUtcn7E8CHXA8VD86Cd/WC4tv\r\nz8VkMm5sDrZPHXlTGB0oBZQTalliTv3HxjMCQCSxZL/vT7oHoWcFoJ1x79JxVKmm\r\nQzwvDw9kKaFShqiIUG2xa0GlAyUR45aEJPUqKXTjM9FRvET716Y3eSC+dQUCQCbZ\r\nigoeHJG0U/6eAPbkf20ybN1piW0LC7d3nR8t3nY+6SFp1dKQoQzAJpvgaMqY/p/B\r\nZM/iblEUXTIiGSBMhEECQQCeCCAz+Q0yE9fdUGLyYASC2/N61l5rEXaeuj6eHFhj\r\nCi6j/bJJW7xSO9MXjAimu4jXUl2JRggT2/gZ2eSaXoID\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCOYiBI+1aZziS3gGvHXF03c87V\r\n8tL14124sGiEhUHRLVQ5Uo7Pc2WZYLE91Z9nkJGWu28+Ki/f45CTuKrT55pkIk0G\r\nAudrXsAenJm/vCUVEuxYUpUt3GtSBxs7iuWN59956VGsaxj8SLA7Wie+z3h6RSGR\r\nBwbGbO5pizm1z5TQZwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011122	cso_vc_finance@dlsu.edu.ph	1	3	$2a$06$2JT5kKY1Gei4gHH8VH3v8O7WPP4tSs8SVSklGU9EU7M6xHIC/sZT6	$2a$06$2JT5kKY1Gei4gHH8VH3v8O	CSO	\N	VC - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQChUp/jlMxfxNpHoOrGA5DaT+2yfWLbXwM+PApszBLX74I8oRne\r\nK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+N0HVnjGXoiFrQ3H4ATKr7hiO\r\nKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG1qclxQml4ztiHAcgEQIDAQAB\r\nAoGAQsoPckx/lMLOUEt6B8MgLJJc6cHptMMQd6qp8kNHJel+NRXJvObALPy1srx9\r\neKLLq4IwNLj8VuNLqAkAkLsqCbJ9Es0OVcD4Ubx+oWy6mF+5Os8o+zvA/VaL9yM3\r\nMquCHgepg+NnjKmP8//6/u/DCVNix+NENRW6VCxpwJlVTTECQQDNH8PnP5ppUQed\r\nAXeWOWR7dSCVAoYIhyAQt8Hgu9a1UsXs9TG/1zVZNqP1mLHR8GdShD0mVozI8MED\r\nFYYQfWeVAkEAyVW4Hh/jJZKrgYWa+Ypi314E8VJkqrEmZt9HrmwHaI3BRv02Jldk\r\nSoJJvjmJxfkZaoDZXogD+AlKGy70bKAHjQJAItkosRrPIuFPR889/9mURp0pgedB\r\n2iUKv4xYddOzsG51jcJCR3NKbvOne0wLubz78LrioKbHmEO+psV7V0XW2QJAa9Id\r\nFPzsr115vZZoZUUIKCj4qqf+Qy81qpfeknlGCmcH39WQ3z2j9wcJKPc1YjFBvDie\r\nsDJVNcr7xc0Clv2orQJAch33cTkbl1v+TvSKyXUJhCv5hj8OMSFQKy2YRHsS0Yis\r\nW4PuwQiPdp1Xt33nDD31qVfZhcpTWb5HO9yJXGP9Dw==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQChUp/jlMxfxNpHoOrGA5DaT+2y\r\nfWLbXwM+PApszBLX74I8oRneK7G5h2Os9HGu/loM8YiPuamhegcu44V5eR/bg1T+\r\nN0HVnjGXoiFrQ3H4ATKr7hiOKyGkPL8pVB1Ytl+ABVMBsssvI2Srd9Lwi4rmHxkG\r\n1qclxQml4ztiHAcgEQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011123	cso_avc_finance@dlsu.edu.ph	1	3	$2a$06$mhRSuJncgAKPeiQPv4mZa.ryF6owldEqFsCEDrSmqpv.BwTlvGu/u	$2a$06$mhRSuJncgAKPeiQPv4mZa.	CSO	\N	AVC - Finance	63512316	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011124	cso_a_finance@dlsu.edu.ph	1	3	$2a$06$ckji2dww4g1VX5n6i1gGjOR3jzTQYSkmRmgKGWGLIKYm6IC6unR0a	$2a$06$ckji2dww4g1VX5n6i1gGjO	CSO	\N	A - Finance	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQDC1X8I3fweNqM3ah6SQA6f0zx8l00xgpEOByevUeWqXd1Ftp7+\r\nqPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/4dm6pR4pnw09lJ0E0Gtl/2aV\r\nJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUmJES+qmH3K7QToeN4yQIDAQAB\r\nAoGBAJzOy8FNOD7w5ogRBq3alGqZzlLQSzaPyUMrCwuVtGxbw1z6UBjR1S6pcRg4\r\nuY5Sfs6UfJMeaScRdronJ5L0BRWQ+lb/iCo+NGO9zZ36QNJbjD9iMtKneSgKkLcW\r\n8NW0VBsODMH9kgihzTwpB3ZoLh8wlKPJcOzuGX/1p2p5LnIBAkEA4+ac+byWeP8a\r\nTu8oHVhc6SUbQGIzenMxXdQOjoyUwmxnbGy1nvou210vwb/ZaUKkDeDh4U/ZwEE0\r\n0sAW4oE9qQJBANrbK+VZ9z89p/3nOLZW+EZUzxj4TVExHWuBGwILLSVfPv+xCNfH\r\nmL63XjlRl66wDv1m5lFbsrmU6V+RBl0+FiECQGLaZh6hYbeMF9JDRGguKubqNH7h\r\n2ah0jOZBFCta6S/IK7hJEyKpLGf0bMGiwOA6isSGVhQQOch9wDbmIUcQfjkCQQDF\r\nK33RhArnM8H8Umrag2Hr4w4tPc5SXoBV0Rum7LDAoZ2dOD5yQEURVRwTYbnYzI7E\r\npwbKt2U+IrVZvstQB9ZhAkEAvAIe2B8spxnFDG0KIUxsd9H5HUidfiqHNQ5Vd7Uc\r\nNP4KPvDCOkN/W7llKwUwYjyqBtYasC9/Vbkm2VyLY67V7g==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDC1X8I3fweNqM3ah6SQA6f0zx8\r\nl00xgpEOByevUeWqXd1Ftp7+qPzFHvk5E1+3EAgU09vPjsK6P81s2kIdPDZLpOC/\r\n4dm6pR4pnw09lJ0E0Gtl/2aVJvuZesw+se+FSCUu+s6BvTgs+tt/TiDTEENDefUm\r\nJES+qmH3K7QToeN4yQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011125	cso_vc_pnp@dlsu.edu.ph	1	3	$2a$06$Zu/q.JH8jAkwSvRC.YpXc.V8/kzaPTyDsdulPb5J8VkOh/p60HXA6	$2a$06$Zu/q.JH8jAkwSvRC.YpXc.	CSO	\N	VC - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCIqhYRfVFMwLhS/WPMcmxtKfRWgGJYmmuqCl6pO/CiaIp3ThmH\r\nts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3LZQunSjMuNGk8xkAGPFGu3im\r\n2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiGy2FUn6BFoW7mun7GGwIDAQAB\r\nAoGAN6gdKK5Cp+Fsr8+mDyMiaSrG6VuLsc3hvvROLNnOXDX6/i9+Ujju/KkYTERz\r\nzVKkMMKFblynROw+Z/fbGb6QXf0rTOnKbkQieK8YdNEd68J1BWhbD+UOrz9lhEBm\r\n0uMS41anqSGaAP2tFevVnl9/8U/pSmc80wXqDpH5cHBnnoECQQDOXZDonw6/GNn8\r\niWeDvWXG07zVGntKNCDe3RyrQZtYfbUKW2OwaAqITDMfV5Kr2i1X8xa8xDIEL2wm\r\nKsSKrfa7AkEAqYjZ9SlhBwLqOOeTnC6SR4TNn2KtBDQoNKgmMq+0d2nPeX/USiZw\r\nuAVpAdmVhzQS2zYyL6ebUfCHQw8qKyJoIQJBAKnTjEYzZ2JSJEpUFXDv84rtgw/o\r\nrB+DyK0/T7GL2zi2sr8kOGTbKhfChau8WMK+WORw83xDBVo2YI0EUxxBT7MCQFi/\r\nRfGblqo38WqWd2QD0RlVQNqVqiKQNxfRiiVwaxUzs6NTskqastjyJBUO1MKxFMni\r\nJgViROFw+y20i4uG+GECQBJ4/YRtaJrxMInKJa7bILbxMm0XMJXsiYvwtrhZwPVl\r\n2/F88VroQYVzIsUYOYK3vg6ldYHMQgEPhdplhc/vZpY=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCIqhYRfVFMwLhS/WPMcmxtKfRW\r\ngGJYmmuqCl6pO/CiaIp3ThmHts72vDwiHW1+4c0LK+SdZiqQQMth6eRaaEMJhVc3\r\nLZQunSjMuNGk8xkAGPFGu3im2+1wZxIew2wsZiA/EUPwEq5GEoKPw+s3joY2EdiG\r\ny2FUn6BFoW7mun7GGwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011126	cso_avc_pnp@dlsu.edu.ph	1	3	$2a$06$3HpXYP2N2QqdQHZDz9I4MOKkATp8PFmyi9Ttxp5Xj04oRsUXvzW7.	$2a$06$3HpXYP2N2QqdQHZDz9I4MO	CSO	\N	AVC - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCVHtq2eH91z0KzdE8k0Aai7F/QtKcl4cxhQJwUgu7lRJRXqRGQ\r\nPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVTZAZK3k8IPAYPsgy2vPaRwC/B\r\nTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCICdCtimFkHk1bDfKAhQIDAQAB\r\nAoGALU4FduCfIOTKSAkzLmUBTyhvZ9Iq4ih61qUxhk3NVNyEESntixxKcyTGT1lK\r\nBQS50F3/nSVc+8M3CsrTr4jVqZ80llON+lNr935mnzBJOqUXrTlbI7KJMm2qRch8\r\nhK1VxsaW8euABl/Jd+WDWwArYd1lfQbGHrwlcvzzz1hy9hUCQQDxeAzpdNsFufho\r\nGRf4KwHA4QW2mY5xmwyEGpc/6zFgyvsRqmVNooU5C3SZE7AZvcPriGWKAIrBPsXj\r\nWD0Sqz5rAkEAnhghYkbkbhugY762c4I+N+4slcbwjwWp9fRJvw9ljUIptY4eNPp9\r\nNzWnOB/8G6QBc9zjJf2a9WnBXSkH3SMYzwJBAKzgDh52EvielEGy9X4vDCpS8Awz\r\nE9Ax+Vv6zZ5tfASYTffvzmcum8KjeO6/May8N7BBDrEmgjCoCHUjj1X2U9ECQQCT\r\nY3XENMmEKbdnJobcu2EcLa1dWaIuBJ7GkaArQsRvZG6UN9HLnHgef6PNPGyCrG06\r\nQoV2hq/v+k9udfFB5hWbAkAdjPOT7CZ2i2kYNQLWADlX/b+o4bo4Jw51rPSty+r/\r\nssySvgGl9ggP11vrORaMIa/domqWw7ONL48qTM6TW//v\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCVHtq2eH91z0KzdE8k0Aai7F/Q\r\ntKcl4cxhQJwUgu7lRJRXqRGQPjKSsNtYfbWwcvrbujX2raAgGBrR+3r74Sh5PzVT\r\nZAZK3k8IPAYPsgy2vPaRwC/BTY0XnHxjuZ45tpQLARMbE6ekDR+IzryLWivcctCI\r\nCdCtimFkHk1bDfKAhQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011127	cso_a_pnp@dlsu.edu.ph	1	3	$2a$06$plXMJOFa0S2gQhwcdnnFPetKK5i0Upe8SKmszcn8lrSZ60jQWZPdy	$2a$06$plXMJOFa0S2gQhwcdnnFPe	CSO	\N	A - PNP	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCDMPPM2aRhI/BbEV1YTNKV1e0JfBoWVJj3Z24izrnSk0G3EItV\r\nYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oMiOeTzCjJQ/a9mel0exGk/1t2\r\nfz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm3/xyb6TWONUr0/rn1QIDAQAB\r\nAoGAQPfSFIVHkU+h7QdpaZwJwWgCjermZF6arhKLiTNE9NI1/fl0duGxh+IQOS+R\r\njA28M6LahVDCAeo9jwVD3Yxu/V7C4jRQCO2h89OEbBUUMw2Rz9+BBxqFeQLuMPLL\r\ncGOltN5FPh0VTJ8/7SRJrh7GByV9U/rrRICPMbpQ4PRZagECQQDXeeBbBYKn/Fay\r\n1AXeTVtoceUNdQE2RPUNxcTVuvvvEY46fTBrHqc1JuVzu/ms+nkOrSaJnlNyDW0u\r\nF2v6QGuBAkEAm90rqDa5rPUqd+R+YFpiHbMaYmvOJSnBhTMPzj59XpcsH10G+5c/\r\noSIS7PPMoI0efN7K/WwgZV/MeuC+4uo2VQJAZWW85hhZu6NLSSvs9weAFE5Ec2i0\r\nAU3B45FFZy5uj7m7LFrtBfuOw7xiDWxPuc7EWNuyXuBadDlNP3tWHJVkAQJADdHv\r\nlAu+LPLUICtXdU2uU3nVBhMPBUaNjTT42s25qhB3bhR+kQJZNv1hdjcr1rSMln/e\r\nudfDi5mR9PdGlbI0vQJAA3H1Jo2Y7rgFmUbH1DVSAY9bq/VcQGY38RAMH2ZhnhAb\r\nZfcWDwvDmQo1dVyyGo2SuOkhkGwvv6zjAy5jj0jWiA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCDMPPM2aRhI/BbEV1YTNKV1e0J\r\nfBoWVJj3Z24izrnSk0G3EItVYx0wh9xviFDM022EjDs5KFNA7UMgq4k7M1ytq/oM\r\niOeTzCjJQ/a9mel0exGk/1t2fz1tHieUt6JSjxbq1Fn8m5gLPGO+oejo1N7Wuxcm\r\n3/xyb6TWONUr0/rn1QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011128	cso_vc_orgres@dlsu.edu.ph	1	3	$2a$06$tmJvXa7J.AZlYhpVTHFLCekKgXuBz8atlomzPixy0jqCvtl4kNgNy	$2a$06$tmJvXa7J.AZlYhpVTHFLCe	CSO	\N	VC - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQC30FZyZj8mXFG3+PhdCjUuq3XZA/tgETJF2MWykVDA9PtGHBUp\r\nGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+8qfMvku8z5djxon9iFBdboy2\r\n0z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmVO19bxmutmUVCreXNlwIDAQAB\r\nAoGAeH0RXXXWaT/UtUJ3Ew3Q5KGx4yowCb3b9Vrt5GpKw+ESINfhqwonp704SBLH\r\nH/R0JTryyC5Sk2A6K7pfqonBoT2it9DmeRcbHAeuIR4j7ktee0PYySlC7tJkDCwT\r\nxIjHNR8ERKJkLE5rbVSSiOFJm0+6t9/0RY8nK2jaPBclKLkCQQD6m/LsAkWSYMy4\r\nyvcclKmJas1C4drQ0UMmNKyVYnio07tz53pomawgunnxCM7jkAa0HCV7l1cwF+ld\r\nEdtPdLf1AkEAu8SPoEc666cgrOi5zDw0Mh38nRUBDSltZx9MtoAK1vcjoKs0v73u\r\nRb29eVQUjjaz7+7uBqKONjOSXmJ8zshT2wJAKQIDyiLFB6LXXRW5QfABnf7f/6W9\r\njJXxivrrkrY+UEH1Vo32Nc+PnvtkoNB0KkCTGD3S1Fp7Zd9DzHrzjBjpUQJAdE02\r\nrQ8Rpr75FUB9PMyZg+Vg/6bv5MghNHuFl5DNpgKj9bO104IAIQB6aLk0ljW51EaI\r\n9mEfduEQqxeTuL0KewJBAL1hayWIehvj1zGvJYmyc77IwQ2BFgdSw+b44ONE3Ocv\r\nQPioERQTABNTUF3gFSCPhpnzv0RTU1aNTASBWMgT8L8=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC30FZyZj8mXFG3+PhdCjUuq3XZ\r\nA/tgETJF2MWykVDA9PtGHBUpGW6SX9XjZvzQ8yiZEuJ6omdgvXB3l4UszbYqpcS+\r\n8qfMvku8z5djxon9iFBdboy20z9SaTh7R1HaPPiDGI/ekRRVjrjiRtz+1OwB2tmV\r\nO19bxmutmUVCreXNlwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011130	cso_a_orgres@dlsu.edu.ph	1	3	$2a$06$SMOtGl5cb5Ka8EHDydNYNeFCJarH1m949HNIy/v7Es95bc8eyzNti	$2a$06$SMOtGl5cb5Ka8EHDydNYNe	CSO	\N	A - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px\r\nd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD\r\na83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB\r\nAoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi\r\nSFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3\r\nx11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA\r\nrNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4\r\nzzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs\r\n8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz\r\ndTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU\r\nucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf\r\nOi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw\r\nDHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc\r\nahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT\r\nuFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY\r\n9TSVIY79gL6owf+2KQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011131	cso_vc_amt@dlsu.edu.ph	1	3	$2a$06$nkcNFpGe.UVS0B6Mk3T3mucyQzDyye2YZYVLavbtGW9.wFTFlCnzi	$2a$06$nkcNFpGe.UVS0B6Mk3T3mu	CSO	\N	VC - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCeFN2GSH42bd7cFgBAL/8+wuqGPfKvgGPA8YKQssFMN6LIx5fi\r\nnI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJSZMbc5zMj9ZlvoYOcId+51zB\r\nstyu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMjsrNfbf895LdAN/bTxwIDAQAB\r\nAoGAJU7RVT7Iorndbd23Y26wc7R2uwXlv6uyXzfgU5wMaJt8zJvmabH+4MwL1TWM\r\nmbJ2/PDgsCmmik+aOf1BZTRYQ5xruDd3M8v0OTiUbbkZgao2VwrUC6zR+zCK6nC/\r\nwLnONvehp0sG3IWJS4NU0/1Y1z16XvewO0wbfuMCWAB7qKkCQQDZHGh0UJxX5TFI\r\nrmWEs2tjEv7Z7miAwC+DRDXJ3ChE2WbhumOKMDymzJHJyG/U4KDFZmmfG85WXzJc\r\nL04FFPzzAkEAumWrePZfV/a/Q43JamF2aw2QIzpNdopVGoQYbzO7s5x7hKU9EV2r\r\nM/wGo4apRQQJ66iwLYZWR5gu6Ws+7wsy3QJBAMyubIdjy9FNgMYNrCWL5Oy1ZtBc\r\nY+clyGVPdApHZStrbgPW7arEyRlTeQorzcp6rvcLEv5uf3uMKfUgn8RIwiMCQAcE\r\nOr8z7wTdqfd+B930S0PeX9WjpTTYIjn8TPsqpF8vfcrReYoEz6QGUa2oLQkHDOSN\r\nFgywqODLDsEEo3rWHhUCQQCHhoumTELnKoueQ7SCG5G7d/cnsYLgzHX96MLCvOlP\r\nlWBVZ/QbUBAe0on6mvpzehnD3sS2wOQl4sET1k8eeCth\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCeFN2GSH42bd7cFgBAL/8+wuqG\r\nPfKvgGPA8YKQssFMN6LIx5finI1lGDElLkIHCRCf0VojsLsHoe5Q/mrc/VOSwnQJ\r\nSZMbc5zMj9ZlvoYOcId+51zBstyu7ihaVTxWuvzbZWhEFIfj2xQWRwPHMPrFxmMj\r\nsrNfbf895LdAN/bTxwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011132	cso_avc_amt@dlsu.edu.ph	1	3	$2a$06$HtR1zcm81nna/lbJRFLqEuwnpLI8adNDjbyrgSRpLchvueXi5vekq	$2a$06$HtR1zcm81nna/lbJRFLqEu	CSO	\N	AVC - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQC0I5u8qRuNtDooiaKMQEw3gfnSV+U8bCmPpErGMnXRj/Q4sC6F\r\ngl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9nr+/rs5iQ6hqV6QGsGtKwlpLW\r\n2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL60eyZH+KAqdDUYtl8wIDAQAB\r\nAoGAE+US4CU1G9NZ0PxSbXb0c/Tw6GA4uxGfDXQxpe4QwRJLAK/Ek44wkVpHN0rS\r\nhibsajlzoEKVRTlYs+PhvtzwyoPrd66I6izjSL8bMWwTKXJQBEtorsh+2gvQd739\r\nzpESr4UunEIFBPHtgcE1vrCj/hDTaUaHBhOSc4UcQxfUWEECQQDgFsfgTOGOw9it\r\nb5xi7w2a+kWZZSBnwLCuSpRB7iujmaZZQd61Bhl8cpNOVO14eCAHT+pGSi9/BzDj\r\nNeEc0DLjAkEAzcqfmUoGwWSK4Vj4jy1f/FzjZ6zSWOPvmiZuOWvhBj3MVfM92D+l\r\ngfaA/CDHFTQioo8pNzHV/f9ZEU2VRoGdsQJBAKEEXXyzYYPHAAOnZhTEtt78JFST\r\nkJRcpdem6R7yt1KnzhrmtNMYXenJHkWzyqq8ji8S4kC9f6FkFmG8zlN42ocCQQCS\r\nCfTwp2Pb4inceXMKyDyRrqmCbVZo1ni2gAdAoJnz/+7+H7wHtkMR04j9Y5VkKrdZ\r\nfRbWoHsn4QmoCdKhUmJBAkBF1iXf5/sMH5zon9QMbc7R7VxJe68Xvnnd4uG+UYD1\r\nfZV6DOdrAH9JYVrQaX6bDDEWIIiJI9+P7n37tsbDdHEc\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC0I5u8qRuNtDooiaKMQEw3gfnS\r\nV+U8bCmPpErGMnXRj/Q4sC6Fgl/DRCP9holoP3jKPA0Th/D/LEd9J+IasUGz5I9n\r\nr+/rs5iQ6hqV6QGsGtKwlpLW2k7XINiyEblseTficgYfMQE8O69zvdC9w1D2ggcL\r\n60eyZH+KAqdDUYtl8wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011133	cso_a_amt@dlsu.edu.ph	1	3	$2a$06$L7XKjJQZXpVeSCe3c/6PWOHsP0lBVcND2BY3CQ4bDtxcd6ZUvy1Pu	$2a$06$L7XKjJQZXpVeSCe3c/6PWO	CSO	\N	A - AMT	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FKwQQuq5ajaMBotZwzh3Of1WJ0\r\nS4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUWOpjTkGUr3b1UyVqbaGTdFUPF\r\noBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYPDDyxxIDgdyXUsRAzzQIDAQAB\r\nAoGAa+2gHmbqwzA4fnhOLFucAQN6Mz4U4cqbw98Xt6dw1tm8bt/MCTadk7aoRPKW\r\nGqyD1j5GtOl6LKGcg5R0sGdbVV38uIhm3coyGZCjIoWqxDbThv+Pql4wiuzo/j8O\r\ndv/1ki3Fll07CbCA+OB+P56zrViHq86YJAOjQLHAPOU7wAECQQDHSco3nAfMpWHB\r\ngCiX3kzI8cUkZmoPVUk0eqkAPAO42M7+uU0a6lT6+J7TSJ16/gypLo0yH+YPSHLM\r\nPCnbWxwBAkEAsZa2rlnZtYosSSCERW7jZkVKzRsxBrfraAaxyaKk2e3eiD+yvWKO\r\nUhHqiW6zJJun+w373dC6rVGLXQ2ozlbHzQJBAK9cGvh779D/5dkjMJUSI3beZ570\r\nD3eWkGgBVxzBsnTBMsOpwlNgx45fn0JDr28+hV2JfO0SbJoeIgXdGufOcAECQAV6\r\npuw+LW9icfdXn30c7LstDB/D5QFWD1dITZfxArEOm70MahFZxxZVIy1WUwSgINCo\r\nH8s6M2hBidE3KKwlFUkCQQCQYChZko5REYv7dIJVPzISLXpCsR794R74t4FbHO3e\r\ny0p8vzRsm8IYup9GlvdF0t2NUQuBLNCHK3ajS58iQwsR\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCKP1hDH1Pt9lTkpQ8sikyOk+FK\r\nwQQuq5ajaMBotZwzh3Of1WJ0S4btMB0eVeppP0HM0IgIFivIBQJeHGvcMe8OtUUW\r\nOpjTkGUr3b1UyVqbaGTdFUPFoBVL+Zw/1HDU4Gnc/1DsAUvSXeLlRi0ErL8DGQYP\r\nDDyxxIDgdyXUsRAzzQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011134	cso_vc_adm@dlsu.edu.ph	1	3	$2a$06$fH0TPwgHIudRDvmyPQNnd.RJ6APej8AISlRWPUbFIcrzfkAbpXifi	$2a$06$fH0TPwgHIudRDvmyPQNnd.	CSO	\N	VC - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDQVV5SkDUwS273nVMNCihKHiRiF4MqBU832myNeqTZaJjs+iJ7\r\n2WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEjhQ+f5O9YGfdnLzkRu2BRN43c\r\nxV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+5NgLWK7H9ZUo7gLY/wIDAQAB\r\nAoGAG7dv0A4tdVpjzf+ZP//c8ldmQcKdCachLe4aSQxLCD2ZMtXoZo+7l+sNLDJr\r\n5m58xiEHAapkM+h/Ec6lKVDDOC3cnKAMT8PZBc5i3HNvmjgpyaCeZHasF5ddXwsW\r\nGPOGXgF6MrH7EVJXfwyn/wj3DONyo9lqQg6ecINnACBKUkkCQQDyVH1y1Y8VdjLd\r\nzo+JZVu3H53HdAdf34DYWsdXLtv5ZSL3iB4PJKvWh2zwy9bwHdmWbDL8+ThAi55V\r\n1w5oew/7AkEA3BXuT0VB/FfjsFn36C6BfxH+U4groNoTw5yFbllOZvot1/b8DiGU\r\nCigCBe3GTAvAgHYdqunZu8grIEVL1v6XzQJAQsOUbHb6HOebzBCE603JnwJO7gzB\r\nm2BwlysrkJGQeX2rzJbr8TAhR9G36f+/EBipQhA9XAUtwlq1HOFLTu3Y0QJAeM3c\r\n6kwkxSNlClbH+f0U/a/dvvIeqIMrmBKhNwn0PBgU89dRUVxjCxQc0C5My08kEh9D\r\nd5428pkT+vmugEts/QJBAOTqk8M+wkezaz52+QIxcEldEiDk/ec2GX4mE33Q6a+V\r\nDilv+3Til5GB6nbRXf+pwJcw5DWFE9lD18v0FWmsEzw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQVV5SkDUwS273nVMNCihKHiRi\r\nF4MqBU832myNeqTZaJjs+iJ72WyJuQlnIkRvwo2Y/sVTzvaGb5nkCi/5mNcxfcEj\r\nhQ+f5O9YGfdnLzkRu2BRN43cxV96lE04/uDd4SjlSQ7FcSb9H1Yv3wCovlK0B6k+\r\n5NgLWK7H9ZUo7gLY/wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011135	cso_avc_adm@dlsu.edu.ph	1	3	$2a$06$b6lcqd7KsGwtka.ouZ/uFOWUQGV0UEi5BggwUWAU4Bx4sG3.10dWe	$2a$06$b6lcqd7KsGwtka.ouZ/uFO	CSO	\N	AVC - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwYPSITb2K6OhTB0BMJlETA0EDR\r\nlJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxHiYZyulryhi+Mi6uEAmod0M9f\r\nEYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmfjgW+f4Bydm0KABo69wIDAQAB\r\nAoGBAJN8urhlaEqwmgWgiISziUIAqIpqzoZ8Cj3hx5FzE7N3CoGSB3cTTQnnIZeQ\r\nDJtRSDY5JMZ3u2c1TqpUQnPmho7VGEb5xZpDmJsFVHXB+8A8ghHdKKFiEvkLauGN\r\ntFq/qlcfqkJZnpB5ZEmQNQj6hsM09+voxQQbHaVZSFkbpPRRAkEA7RfA+t0t1j+x\r\nm5QcB0/cl4IHxOyh+YnA1NGc2uHw0A3mlaE7kqGaqwNaf5Gz7YIjlrP3bMzNtvAE\r\nTHIgxcxMmQJBAMWpJrgGX2QyYJ7R0tIl5Nhx4WgEbq6coe+wDNnLyQjYAfG8iKDY\r\nMzA8qR93j0FiGAzPahiY9W/xDTw54Uz4bg8CQQDP9LTMlPGeaXGUH33SIAdBUMkV\r\nveR4Zo4fXNey2NiK9JZaifghreNmumNHX3otCafDiIiuApkxKybqEnSSaZaJAkEA\r\ng+7DyVF3momFtHyZG2vvtAlPSv6qYiJqdHIuIbHEHgMQSSpuh+3HPQtAV6CWHi47\r\nn1FSn9h4+p8LFogLujSYQQJANX9bzf6g9Q7uE0gvXCxLsQ9r7CRUp/CqlLuZEaV2\r\nDetc/IIv1R8oXhRhEVN+miuyRzRh4IFPMvFMAcnXzRfASg==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC3D/ALZ28hZ6hBQJsE0JFmrIwY\r\nPSITb2K6OhTB0BMJlETA0EDRlJHiYIxnM37f4PzF/txRnFEAdstyTitpzTDrQNxH\r\niYZyulryhi+Mi6uEAmod0M9fEYbSKA7lfoCR+qD3zlu5rfIfTyoOOONm+M02JOmf\r\njgW+f4Bydm0KABo69wIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1011136	cso_a_adm@dlsu.edu.ph	1	3	$2a$06$R4mLo7Z4cbXLrexvsJc3bO1hlS0Uf1Z.b7TLbsLkL1Tw4c4M8PCzG	$2a$06$R4mLo7Z4cbXLrexvsJc3bO	CSO	\N	A - ADM	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCcUZceVzoQ14sv6oquaBGE2lvZxfVd2FfTFh4izfDBffzi81Di\r\nkrcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoVlCSpj4qmuWNs/sXYBQN6h+5w\r\nEvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3v9AYT5zjEv2/kSOiVwIDAQAB\r\nAoGBAIpNCZW3eNEz0pqHOUGLI4zWIJOxOCBaa4F/vRPv/sVCcX5d5b9ALT3ZbJ8q\r\nSYS0VZ63oJ1ERMBPynyD6PWKhw7+RWQrFHjcLHywBPOFeP5QfBjjqaMeUCjEDtFP\r\nGq0LE+BV4NpY/j6FnJphk7NQwaFQ5qOk+uHHRtAPJ6WHHCSZAkEAzdhwUnMPY499\r\n334merHW96uRHsbIkhJ09TrIK99fsIp4JaIXDJxdZQrKk9nLwo2GebJjB34gEj8U\r\nyFfaECKGSwJBAMJn7q1saMS++UWd0t6jXOkKbgO5iwI6sLdgiJUYlv5q5CQ6PFua\r\n0Lekt4qN1Bnbtca//j10b1ckvUWF/pZMvKUCQD3mpIBm0W3jLLsUuIWVDUwVb+KN\r\nbKtgmYNVVfS7i48PVOocQEoui3djM2Aa0seCv7nBBz6tkv9psNo+cPkBKNkCQQC8\r\nqoTVxWn/1p6v0zS8YKpgd4DBGKYxaafqr0Kd/5k6G56BEgtVk2+Pacm+K1p2JeXJ\r\nlrY0CfWsCrms6Rdj4eEJAkBYKrpRZUvpujanQsoMdgDb7SS3xaW0vzIclIqg9FFn\r\nf0tk8MiOLy0hDX1xpmjutW2Ro4HZ1yjWZD5EOBGVJtVY\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcUZceVzoQ14sv6oquaBGE2lvZ\r\nxfVd2FfTFh4izfDBffzi81DikrcsWjzVa6WyvD47Gxnsx9X0CZoXoZyoejrdrdoV\r\nlCSpj4qmuWNs/sXYBQN6h+5wEvVLzcwoIVYupeKUnpmp1O0q+glZ0ZLkT2JVu8p3\r\nv9AYT5zjEv2/kSOiVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2011111	facult_adviser1@dlsu.edu.ph	2	3	$2a$06$rrc.jEkEbg1UQBJNl6PRw.EqS2HvCHKc30m068f7nGgg3MUhg0qs.	$2a$06$rrc.jEkEbg1UQBJNl6PRw.	Renato Jose	\N	Molano	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCyws+X1ZRyQBJ5vh25G2ost83GDrqAeWfyUx05Uoc9e9gYBOeO\r\n6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbNC9SnMnHgKqOUVYejStbTYrjh\r\nFCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFuWx+m9ERVhAXPzXKZrQIDAQAB\r\nAoGAWVitUYJas8/6bAbt7DsbkkY7/yYVaWlE3wVTsfbhyYVAuKCa6/9miBwONM5s\r\nmPhuDWE4enuUpDnifvGzDOXix/NXtbTRn6yp/zkS+jDov07fFIdDZ5heB1CGbz/l\r\ne/rG/T3634yeOnQpCTioCjp5EXMKpKdbR5AbHdkIP6pXZQECQQDWpWpMztIDc4Ih\r\nS9wEIiJ0b0XVNpPutam8Z1SK+KEUUx1wXZSuK2skVzeNM2Lf32ufpzRaNx7gSQx2\r\nraptBVdxAkEA1TN/2LGUTFXGdP1pUje0G/lMarcsYtcdWuGN3ZdWjQjAGN4lyTnV\r\nUY7bZCgt3CnDKuiR9SeQJfeczOXpRZyf/QJAEMg2G3NAMEzjq77GoPwaPYhFqXnu\r\n7wb9EmHx1jvCPFiTQKnQah2y7tBy43NVE7PgMkdcbIFKxLZxZwYFASkdwQJAeXm/\r\nZVtA8QGKcwwUX2knsSypUsCNhL+mlSqg51ocUX1j3odspivSlIa+EGIoRyJwdllP\r\nGIzzP/7Gk6SH9kbYjQJAUfvdqQXeZNi9yUSpz+lVxcjJYrhqJ220bwn3n1TEtrrZ\r\nfPMR4Ls4cC0Kd1HZ2d3FpC6rSDUCnnJkuS9m+rA0SQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCyws+X1ZRyQBJ5vh25G2ost83G\r\nDrqAeWfyUx05Uoc9e9gYBOeO6gsADS3eBhNgmxyWTKLmrb6JefDgPWm/G8n4RzbN\r\nC9SnMnHgKqOUVYejStbTYrjhFCpFODd4U0dwlTiqRl2wtXagO6eX2TPSx0DT2kFu\r\nWx+m9ERVhAXPzXKZrQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2011112	facult_adviser2@dlsu.edu.ph	2	3	$2a$06$qcRzmeEL0TXwh4wgbi4Yn.mTc5QR35jsNC68PQ6H9g6/.lo1GaTgi	$2a$06$qcRzmeEL0TXwh4wgbi4Yn.	Edward	\N	Tighe	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDNbmt2Yusudo62x4tkPPdfWMHh\r\nDmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv5dvu8v/ZNvE62J1Qzi62cu4q\r\njNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8LNkU/Rti624DHqMlxwIDAQAB\r\nAoGAbBwes2hMRLyUwGTXqmiR6MYaCxranthOsonC1eRU4YPCsDvii/E2dLBRuDWl\r\nPYZ7aKmCvZQnI++rGg7GSa/xonrEQgsg4cY+odlOPbmpDca2ztLglNefaYQ2/C0P\r\nY6coV7/5w7XsIfcVhpE9x1fZ313xCpI/cN0PlHAV9un2cWECQQDcYXoiCfiuzonC\r\nUH+ssa7MeIY1iNpLGB/yKsTumtFCUClMrOgEhImV643BZTh6yrwSbz6F/SDoTi6q\r\nfF/eXd0PAkEAlukI27LiNVuVeKBvbheqO0tr5HA217/lrMQnuuQYh45bIpQNmQQG\r\ncsGrkrOd0wUf4jhs5v9jQqjdn43DlWAbyQJAb8ahA5K7Jy5qgLwDhbu5RMv8hjqb\r\nPWtHCLTYnYy4hkHSMKmiJGh0wC1xAJ4uP1mEenUh6SOyBSFiWeYrWcWR0QJAIQU0\r\njv4BSTOU7SQNvcUn1nmWThHPrj2q/7acCuTGCUM45cQHhae/0XRXGm565iWE6Hb4\r\nPUM8cOWKONNILHMvIQJAcw7yJAltG83X4LHhpti+xNvPvIOPdQTMOclzs7e7IPkm\r\nki2mak5s9yvwAVeIjjxln96iCNyfV/axEPrrZUd2nA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCB6bnoSAXYGu5+/Sfd+qtMgKDN\r\nbmt2Yusudo62x4tkPPdfWMHhDmJbagK5mMbjo0BegN/+ASrgDBZQWdNVlOYsCTXv\r\n5dvu8v/ZNvE62J1Qzi62cu4qjNz3Iit4HGSQijWh4tX93avSwBiVOKrEIvPIgMM8\r\nLNkU/Rti624DHqMlxwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
3011111	slife@dlsu.edu.ph	3	3	$2a$06$O5loqcZfQLbdEzyx6wYFt.zRnUolX0XxOTletDdAobeKArywBgvw.	$2a$06$O5loqcZfQLbdEzyx6wYFt.	John	\N	Lingatong	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCcEc2MftJ4+6v7RMlBUOm16V+WJDVWYPg+4V1uhrNQRhpR0tbx\r\neYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+5a6L0Baj7Bxj77qyK8/sAM43\r\nNvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH+srh+1Vq+ifzSoXLmwIDAQAB\r\nAoGBAJdGmlpoQ1KJf3YagokRCLgO8Vvy1NBZRcaNY6bSYdSZXsGZAEcnagT1Tsg9\r\nzKhaMSRSJns6qn1TUpdhbjt1zaSMT7sYWi+hjMi+QG9hvKdqAtrBwNKvO9WP/QSF\r\nlTo4/1NpumEE6hx/5CmdXEE0HYoNSLZvjEtA4TVmdbqFY+GBAkEA5GvfeniBnUAR\r\nRdhEx3d+Al8fZSq8VhWUW760n2bK8pAXsXAbkQGUru8BODWqg93oUBNJzvqTstoL\r\nRZ8EYLq88QJBAK7pp4TJx1m3ueviFw5sFEQYAf6dzdTG/1xoKF4fxorLkvPKLv0P\r\nRv00AbLDVL984HDm6qgvDBcSldpvr4BLgUsCQBQGBMwmni4bvKfjwnu91NT+Y7Ep\r\nouLk92FngUvr5eSHjxwl2LTIb7E6EGBODAmNPV0vo6u6OZJXHN/Yhbi5BfECQBjY\r\nTZg6BRwEUd9knPvKdFJ7yoS9K4iGv60DioBcKRp78iK43FXLvrymj3sx7a7JcSP4\r\nWOqMzD3WwPxnEtm5X+MCQHo3kgMtH6ChR7vLV4LQTwwf+way+YH7d5j6UvZaa7ZB\r\ndMSXDysYqzDUu8CJwiQkK6cFM8GjypKQINfo0OIzaGo=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCcEc2MftJ4+6v7RMlBUOm16V+W\r\nJDVWYPg+4V1uhrNQRhpR0tbxeYhX8onxtDlY3USFCNxx8KUJERIUz5UUkbIwVMH+\r\n5a6L0Baj7Bxj77qyK8/sAM43NvYx2tHp2S6ukBRalQjQcaSaRBXlWBBAmThggHHH\r\n+srh+1Vq+ifzSoXLmwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
3011112	dean_studentaffairs@dlsu.edu.ph	4	3	$2a$06$JsucBJuJYP2./.uXwQ/bVOIS7gtnD5i0TjuJA0HVEMJQAgWKRW07q	$2a$06$JsucBJuJYP2./.uXwQ/bVO	Nelca	\N	Balisado-Villarin	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs3xG0YG3ybsxNLV7RD1CwJUYz\r\nv9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBaNktuUby6Q/f/3QTVdH4kjiIw\r\nYVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNFB+7Mb7k7R7UIsHG6wQIDAQAB\r\nAoGBANGlAT/vWdVgiPWxuRi1GpOjmrfLBBVjIVFKd0x6iBVMT84Hph3ivl96U62x\r\ny8O2aIz3a37xWr81ho1whWHLSHsKNJ2W+WQhZslVgRtDccMpxlt8TAJ9OW5wLzOD\r\nS8olb+H1w7eWYGSRwM4McTSJ3qNcK4XL0yQIHhg6lvf7oMABAkEA6oFQlGc0ikS3\r\n9fGFGUwd6h//LklZtXzMstAcXMecCqsq7hFeNmETYrCwKbKp5HMcH2cqn1e6rxJs\r\nT2NUX+evAQJBAOjRcPmZkhmqdOXyi1MrWlSVzBDpJ9NvxX/5cgrjrSb3AD3wxQVN\r\nk4E4Vyk1yEtKEpu56Tln/jl+DnKdM/wBy8ECQQChXr8+gA6Nn2Af5EU89T4YoFAP\r\nX/ZVhz2tRrxdtBZS2Rq/nEACl6apYQC4kPOL+xI9IdcYs1wJoVna/3VOUbYBAkEA\r\n4d6XqT/JEydhA9l8O7L6jsdJVDqvDZ0JUa/SaSgbS4ska/NTYWKysRHU1cE80XZK\r\neVQzJSNz65kVMTK8RUgEwQJAExbSR7jDWM8maHfKj4ac1BNDFWiuWdtClZzTT1NU\r\nI/oKw8JLTN8ar+eMMN+Ho6AuPk5NGo1TCRHc19ShObpKQA==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDVRQwWfmVLHfOOH5YeFwVfGKBs\r\n3xG0YG3ybsxNLV7RD1CwJUYzv9laMdXSpk6A0DV756qrX+3BPWnDy1HI4w1tfyBa\r\nNktuUby6Q/f/3QTVdH4kjiIwYVNUn7KzvXyyE9u+5OaqJFAHctvlBgd0/gMqOFNF\r\nB+7Mb7k7R7UIsHG6wQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
3011114	vice_president@dlsu.edu.ph	5	3	$2a$06$w57C8Oh5sSyXZcG/QNNoyOr1lT.h.DeLQhc7puPSwinfzcXwcw.SS	$2a$06$w57C8Oh5sSyXZcG/QNNoyO	Michael	\N	Broughton	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCb/4C/HnxA5LJnhEF2mVDIJwtydvQs9E8xo5CTI3ZRQn13l8M5\r\n0nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6PSDUzf06zNjEiX2wD7lo/qg9w\r\nrQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64qh+BoPrbOGiDLdHcGQIDAQAB\r\nAoGAcKjrcBsyHSOM/Fl1dZNv1bzs9XOXEEg4UV8Q8FJyBmmAdzgxE7c7rvVOVuwP\r\nr3KA6Q69WkapuzD07T6UbGjOBH0rC8m/D2Uv3mY3T4oCATXggkEjO5R1taxqwnxA\r\ndeLSLUmd9SfER+wjz9yVui61qTVc04DzQlrgRIfDvsNKrkkCQQDMX7fx26tL5xHA\r\nDVQPErhSOgZcdutzYD1cTO83IUTKrb3JAqJgWF4HXL9B2VivknBKwGxuZUlk2yg4\r\nOlsFY+ATAkEAw2d0pLrc+jzIwDL8AuhaNBrQddGRony43fQG6lDiZ7ju0a3wDvxD\r\nViw+t0ewSJJDXtB7/pe51GlZXYkFuwMQowJAK4ow2/vakH8XzvyH7fYlAo+OD2De\r\nZGQabnGNfQc/apZ9GjfPdAsfbR4bOOIe/LiL58D62MIHUs9F0ETOY2WVtQJATc3w\r\nzPK2sFDpolXqsIGyARM4M+F5Opisx3u2ETCZpbEmLokyj9T0PuipJDNARvUuLB+Z\r\nb5scXC6CbdL0XC1xPwJATnkbd9B6j97tYvSMx+q2P5qjGzODynrPLgYCnslRpx7c\r\nbvzBfUthH4/lLfHz+T/0YUpsAbZv1QDt7SivM+Xkng==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCb/4C/HnxA5LJnhEF2mVDIJwty\r\ndvQs9E8xo5CTI3ZRQn13l8M50nRSyDhnj0W9IxVn4VAAinzeFFwG5iTccvCkJY6P\r\nSDUzf06zNjEiX2wD7lo/qg9wrQZ7EbNfujJJT9ja8i3NLF2/eSPu+KETuXRD6R64\r\nqh+BoPrbOGiDLdHcGQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
3011115	president@dlsu.edu.ph	6	3	$2a$06$Ik8aNEhzKlb8DulL944pvO1.S2M3rCd.U8WGNHfxUvpA0ewlL3bEG	$2a$06$Ik8aNEhzKlb8DulL944pvO	Raymundo	\N	Suplido	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr\r\nEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg\r\nuMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB\r\nAoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu\r\ndRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB\r\nxbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE\r\nsnc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0\r\nj+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx\r\nlPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0\r\n04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX\r\nVn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC\r\nYzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp\r\n4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z\r\nQKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8\r\nRMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f\r\n7kyMwenO80F+UxAahQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
11445955	juliano_laguio@yahoo.com.ph	0	1	$2a$06$jXfKQiciwGIXuVB4zJ2fE.ACv5wg1vosgRBicSfuntzm2mc9tE88O	$2a$06$jXfKQiciwGIXuVB4zJ2fE.	Juliano	\N	Laguio	9266386421	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCkKPYp18u+O2e3bvrvXLBSs+6zQKcouWUyuvIEzWDawz2zYSkr\r\nEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8RMuXO+ltBxsxrABZEVhv+bTg\r\nuMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f7kyMwenO80F+UxAahQIDAQAB\r\nAoGAMHdbfi0VHTwCuhiNA6B0+mXfQpMDBzX9V8Xz8FEGmG/uRoiYE/xLNQzLirzu\r\ndRNRc/3j1MvOCsleQ8x9HeSk91BefJ1VUM93+fQLI+9Zfm/XSPZeUendfBmbX4kB\r\nxbc5htJvk4Oq+diU2IIxJIM2MDpwERtirD5bp7cqqtv0XuECQQDisjjHBlhw+rcE\r\nsnc5H3iuv580k2UZk9HKi+OGmMoGDhz9gNQymvYgsaZl3lTvgAsRUab0NuoVjFY0\r\nj+23vu39AkEAuWFOmc6jHEOeqDOD0BiRMfpawdUmyNcoaKQlIBqvAWflkRM9UFjx\r\nlPRXKs0/EJsu4JPLWFDwrkxS4ZCHDyYBKQJAKEKMkNQQqufrzvq+77cmIKrJZHX0\r\n04kMDhOv8bx6zH5/KYpSpTYeFgpWyeqlXO95h7bflqmWAwOsX6NcDXDsJQJBAJXX\r\nVn4yLVuSOLMCeMACq5H3J9bXILNkXlA+pZeOmfiL715Va9D/I75fxfldz2Tv2nNC\r\nYzHusqxgGvoiJVkUQgkCQGXabuOyLicPFhwAVhlUkXHUgGd7KNsSFASAvjeBbsJp\r\n4F8HMpP+ChUqgW10mdON7mhsXoziRTmAnlLkYKOYlEw=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkKPYp18u+O2e3bvrvXLBSs+6z\r\nQKcouWUyuvIEzWDawz2zYSkrEhoilcCedOU8BkdATjehebGGCDDB1s/VDNT3Zmj8\r\nRMuXO+ltBxsxrABZEVhv+bTguMysDDQBPz3LrlesNpLFaXocSEeaqpxmDhZS1w4f\r\n7kyMwenO80F+UxAahQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111111	org2_president@dlsu.edu.ph	1	3	$2a$06$/fKHAGfGGkU7PXovwPU7AO8TnEzSBJzoQoLUURbUHUtsmIZqaHzbS	$2a$06$/fKHAGfGGkU7PXovwPU7AO	Organization2	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111112	org2_vp_internal@dlsu.edu.ph	1	3	$2a$06$h5uptHJzC.tKFeHbKVSLy.Vh1EwvHVPXGhpw3JwTs6emZgvEnhU16	$2a$06$h5uptHJzC.tKFeHbKVSLy.	Organization2	\N	VP - Internal	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICWwIBAAKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+81sEGse39TOM0+m5yOCVf7NoW\r\nJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5fDKeatUg278bqJqPf+Wgdh2+0\r\nD9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDApmy+d4D7v1WgUb79LwIDAQAB\r\nAoGAIHQeh2bIk47gMDpH0nZribycGIjUCSVbp8wJqOUz8Gzr7ShpE+uwMGjS+Rp4\r\nr2gjOovMgLolvGIw9CK+P32D6gKgDREwWP+NvOY977HHKMtAPA4SRwAPJU4boAJw\r\nKiysLR9X3S/FiYXp21i1araXV2tscLdEkmEIEsOYrAPJIgECQQDwA2RK2FdkCYXd\r\n2JHJH70OUAQIW5ZbEJXXqQ7pO3Xp/n0mnCJz9o5nixwrI3KTWLITOpE4Em0lJH5b\r\nrnwC11nPAkEAjiQ/Y4kJUWS7RZlNNLqAz30ZZS89G3HYHIPBLS3Rc0Zc4/yctjPx\r\nJwm4ysWPciEcNbEdR0IqvFCfl5FVYjLeoQJAZdjqnCAFpXutBKC77F69eO9XZryG\r\npwn4q9UfcLU8qhjFvraOoCrF7wZG479dBU2j8yjtKqAXFKXRwNHf6cy8XQJAYzTf\r\nXSwu6bUhk9EMdsnYz3hjuiB/SOFrUXOP52V8MzWf7avJAM49+N4rMLM0jBaZ5suI\r\nQMzooOiwiovwCQqyIQJAUmw0ZcnzmAECb1x8umovIi65tdsI00FBDPU+nz/dJQ2j\r\nKpn+OFihMZYue8HK51G2AMj8ufFhxvKoeIRPRq3+Ug==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCFQ92Jxf+nEJ0M3yaSg6AEwA+8\r\n1sEGse39TOM0+m5yOCVf7NoWJcrQBjayEXr2IetBTLh4NwZkeVlI0TN+Ekaz9q5f\r\nDKeatUg278bqJqPf+Wgdh2+0D9K3TytfAX9shtGFJkP/1SIMw+ODQuo3uUlExPDA\r\npmy+d4D7v1WgUb79LwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111113	org2_vp_documentation@dlsu.edu.ph	1	3	$2a$06$4717iwzgDkX7.QqRa6mSLeOv1IPqXOfWirYmrtpwXB9.o1vz2KAX2	$2a$06$4717iwzgDkX7.QqRa6mSLe	Organization2	\N	VP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDIyvifYGHNb54ZF8wUankon5d6cAKy3eXhiS4GdCcpWPMnzfU2\r\nDj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXbBGzRYeXtgNYMlpUYk5b+9XhQ\r\n25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7mTuU9jnyflD7mRlopQIDAQAB\r\nAoGACzH15rzy9wdQI0oGYOUG2FL9mSABpoNku8xwOn/jZxTEieWb1GW6++UWNzy3\r\nYGKEy+glF30TgRBLaKz+JD6cGp8R0+o/kFT9pPazWy5fuKoTxEmsXlqm+IO6gBxz\r\nrQKIhiI2Bwzwu2B2MDzfzhM9O/z4ZuP7Iyb16HQ8aNokgQkCQQDjRDO+uPrpGU4d\r\nzukEth/TgsF6u9SU/s7iKdNeqYmRFwey6Dh1JRLZb/5zU3cVB+nqh6ROt0MGA20e\r\nZRYuy2dzAkEA4i3qPpfF5hhKcx6MHlk5XCSb0dheFBN+mnuyi0UoA9yXltUl83ZR\r\nvFqd2a7wdJnFFqe6XUqC1WAtglShRy35hwJBANayH5AVgDOlTD6ssUVaKEbQR6eC\r\nuhjnftn5WU0cLHF8qDFDX9KK63uuaVrZhq2/hCOjcH1Mc2zC39rO9F3QmjECQDDb\r\ntEczJ/fNdX+qsJ/5rC9gZRyOfbweffHHGMmG9d7nrwNRJfKSs5NZi9GzPZQih3We\r\nY961Ms//B7WorHIg108CQF+Drrof608PluO6xjEW9GqG9bWmXY3lj7JVxrdRzaIT\r\ngtrnlHS0iq2WG9fcmONPTzL43dP1MABmrL49+nSIcwI=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDIyvifYGHNb54ZF8wUankon5d6\r\ncAKy3eXhiS4GdCcpWPMnzfU2Dj+6gVbB2hIDNyZsPSmXD8NWcLCepPqfOrwigGXb\r\nBGzRYeXtgNYMlpUYk5b+9XhQ25uP8/XNBYVs7/9Mh0ONarGN3TjvL7orOAh6VWy7\r\nmTuU9jnyflD7mRlopQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111114	org2_avp_documentation@dlsu.edu.ph	1	3	$2a$06$ECi4qW9timGqzVb6IWafiuV6PdIaYFNi.MkNwbZYWHvWrtIYKgxyC	$2a$06$ECi4qW9timGqzVb6IWafiu	Organization2	\N	AVP - Documentation	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXQIBAAKBgQCV+WSPPbpj1JFi/mGLrBBG33zPrC3x8ZH1/uyqJTwZ29eQ+P3Z\r\n6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ61LOPZfwNgBw3m0WBzURlBbl\r\ntFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV+6oAoC4KMw6ZSBJfvwIDAQAB\r\nAoGAL0FXyDKhCleuP8z7m3Dp6Ar/XshX6cY+QY7Dr5Dv8Q3uTIXIJuMmivxwnF5u\r\n3SG/0Mwtv8P0CDV4a5E1tyi3esS06icHviHfCPd6akVPxRrPRFcIMdp0GODzAwFh\r\nSTtwZ2K60KMOr9Ho39yDBqMZDFRQhLRsqf2CeWb7FRND2xECQQDYP/UV5Ypchl+r\r\nigPbGreIXAQyEsUF9XJ1j5b+oom7W1OgFh9r5NE7WSTAs+jVaPtAByzzLnjRHFsw\r\nKHUYkmJjAkEAsYq13keWn0ZwsuKBvorLqDmJeV2ZUloFVHErkJe2rhhplnVQrM4p\r\nPKWG7ybYEaKkb102SU1ofdzC894h02cd9QJBAL4n938KupFEBAqWsW9Q3gTFTVcu\r\n1Bu6Sqz/1/oPuWeMFkwWSAkbS7WRXNUrHtnSl+Ukqi0pN0pCUhlV6inyRxsCQHyz\r\nD6BrKcj/QcLzQuvhMsAagYuECV+FKP8xacbqOH45WVg7WAm319Dn9kldQB/K27H4\r\nh1ufCgh1GV0OJTYF1E0CQQCrbEqZDEz60to9yz7B5ZIsjTxZZ5vel7tglcs9WeFR\r\nkFcuI3xRNAlNyTRFJs+aNXceKlUeJlI3Ayyp/q+d4vWI\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCV+WSPPbpj1JFi/mGLrBBG33zP\r\nrC3x8ZH1/uyqJTwZ29eQ+P3Z6FCCKCld4jzKOqANowD3XjDMBnRMMB3bVbJYHzKQ\r\n61LOPZfwNgBw3m0WBzURlBbltFiIyTulSEuEFZGgV4YABnE11VqBZ7085ljmcJlV\r\n+6oAoC4KMw6ZSBJfvwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111115	org2_vp_finance@dlsu.edu.ph	1	3	$2a$06$vAGFgs4JZVeAmNGkEtf7PeMq6Novqw5ti0m31MytopPbCGkQkGzT6	$2a$06$vAGFgs4JZVeAmNGkEtf7Pe	Organization2	\N	VP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQDYNkv/DXLS7fhRRLcG7heWNHKD/ye9abmaI9nQYfn42EEMihiI\r\nC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaFbe4uf1UNPf1/D4ORz0+18gIh\r\nDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3aUgY0Yfen0N0vn+n4qwIDAQAB\r\nAoGAP/CGtu2OOGyhk78DdWwx03y9JOXvJae/eKMDhgmDeCDT09Z+/LSuzrmQRyeQ\r\nKwdspeat00LSmt9s/muqs+8LYgrW3DsOx2IO/Vs4+sfAoBMD2cHkmUWgKNeaW1ph\r\nvrFNcpf97uxjjZu+9kIk5BvUwgJI5nv6tg4yB9JVrdy5UDkCQQD2A5DFawzQlC8R\r\npmPtZsS2xen0ocO96NnDVekb7eIc5UI7/YYRLtYN7wj/8vAzYHQvmPHrCvKvUsnV\r\nylrA1XZ/AkEA4P0MRtU7UrWfJrIWl8w0CXEL6RwBto6OdanEFUghc302lhEkRWGj\r\nCMDSseJnKoG+L8b0CnN++YjZ2tMBAosf1QJAFZK8eENp7USBWCfiLWhMqcZzPKuO\r\n0bGAnxuChJt4r5X/F+mkfw8/YBttC5zPKYI0zhO4aycbnvpAjsne6XgOmwJBAKEB\r\n9isqpY2HFCHpCGoRZJvtHozv0foHAsQJfZ2NRQMU9F9oXQCZ4sZ810sdrp6owqYG\r\nRtbD2HZTDTSgE/TyAxECQE7Run0VOT6BNBsP9RlLX6/CBGWb0X7/nb2BpoKJOiry\r\n/cf+JtbPWuQMzJI2DtBOJDFqZvS4d3Dd/xi2J2vXKR0=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDYNkv/DXLS7fhRRLcG7heWNHKD\r\n/ye9abmaI9nQYfn42EEMihiIC+GqLI2pKcVBSSjLCXeUHnUvP5J/NafkVmBrYZaF\r\nbe4uf1UNPf1/D4ORz0+18gIhDD3L5KnAq/mZCRoStYG9TAsQX4PBBwg8+Mt2WH3a\r\nUgY0Yfen0N0vn+n4qwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
2111116	org2_avp_finance@dlsu.edu.ph	1	3	$2a$06$sIpWo086CKDBBsTHa6JMP.iplaDfJpZesox4esuYA9Az9.JS96MPO	$2a$06$sIpWo086CKDBBsTHa6JMP.	Organization2	\N	AVP - Finance	612424515	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9f8OR3cA0LEsgH1zq61xOVcNP\r\nPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJiWCky6edWuBclYDAyWNpwL9k\r\nAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSnfZibfHtWczJ3qtPsVwIDAQAB\r\nAoGAXORVVALWgoifY0yr179yexEI9WFPCcOC+h13kJMNz94tk9EGKgBPjY+ulQmp\r\nnWayeSL74Hfw3/f7NcNzjldlgeQwtik0cmcyltKAdnO86tZwj9liax0/QGSxxM6u\r\nryj9bw18KSQaqVguqT9ukr69zpN7/ZnrpGi68LezFIn07AECQQDEQv7r1MdFQKXm\r\nlVIo23fh3M6VcVFXlvYrliKrlfDLAwvWB0QMOje5PJo7kTEZuoq1oaSBYIV4ccHA\r\nPrmUB3pRAkEAqALjvK/wyaAARCf7D/xNIfYFBDVDXSvWLSh5l7sVczg4hvjnTZYj\r\nLyjFK/nnNq+YO3tQhA4mi2hAXMoUEu8qJwJAUD+Ilos5M5Lcguz5XCVo3lx3x9k+\r\nxk6+t1G7OWekvo2vUENGSq2fTUl/Uu3qIrgIsX23kwMRcA8rhtze6q0oEQJBAKAR\r\nuLXhjnAaX4aP7NPLFhXAFgFvWZHgHPsDL+2OkZ4ntzto0r6Jx1W76za9rjrcyxYI\r\no6pc7P4uwftlkACGGksCQCSv7IVwaKqcLYglwNgZRSFnkUlfU4bnFntlgNAbH/3x\r\nsxoqKQTWVqw038LwcLCp7OmZKjwwjc72lzxwKdM//dU=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAzi5o0Zsng2PmPXBWjMtz+Ra9\r\nf8OR3cA0LEsgH1zq61xOVcNPPokAV65jyvSZTpoVm8JQtAErYQkWWgF7o7nF2haJ\r\niWCky6edWuBclYDAyWNpwL9kAAox76KVVRnlRDFYLm/pqZBMRvzdqTBfGkD1GsSn\r\nfZibfHtWczJ3qtPsVwIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:15:54.070408-07	2018-06-20 15:15:54.070408-07
1111111	org_president@dlsu.edu.ph	1	0	$2a$06$L5FBUkyZk9Gc.pcWhcVqZeEZzpXmOi20oPvsLJLd.cBmmXhHZ.mpK	$2a$06$L5FBUkyZk9Gc.pcWhcVqZe	Organization	\N	President	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXgIBAAKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAtlcqnpBSUE/uP1V1xrOybXpkN\r\nba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6iXsLbjhpfG3BQBNdlUFT/uoe\r\nOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwrwgXZLPlVyHxGuufO9QIDAQAB\r\nAoGBAI51ub56ZrRtczf5QWjlysgIjvMbZmXEEYvZjmn6ckdK2otQgkj1nm2gJrTM\r\nJIWv/1W6HpJEZT6hSrIlZIwi15y1ndX+37qH9NwcZqLhRl4xAtlDbzQErHgIAZNP\r\n9PlOR9eti6suvJkOj887wj1J6jZzfbANJXhOyYBaWFDePt9RAkEA5oBtpa/xDJIf\r\n5+O6/SzPDEP2qyMcJqruf+RwbuqMSMAGjS+/iwrWmwH2XPFiaHxTzXJVL4uJrYwj\r\nm6qW8kMnGwJBAM0aZgcHJr0Kyo5jV2wxmnfjsLReuBQ9yKf3Jom2CRvyhrRaQwTZ\r\nDpwwe283oG8b+O+dciJ7QVFwZo3/gcWv8y8CQQC3eWbNydxviyjGZikDOVWdh8Oi\r\nuZHA3bJ2LpmoUB5WEjOk0mr+/COSwt8dYC5ayQvTrrxL2iA++hul3wXD1NwdAkEA\r\nkkH266AP4dKmKu9wUfj1W/UD9ztsLRL52b0GwEENMd66bDXJgNV/86UnAGI8h778\r\nv3IZB7m5FGgA2dWQJvaXhQJAffuC6I3UurV+ZUEPPmrNkq86AKUHCIdSIqVP1iF3\r\n3n4DR+xpWj0DItgiGWV+vdfqFxghu+4HpeVhpTY1jtVjMQ==\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4rJy2UFtNdHu+W1DEQ8AlXeAt\r\nlcqnpBSUE/uP1V1xrOybXpkNba0sp5HCE0oKWlI5C3c4tUcW3DdvOCjsIIH1foJ6\r\niXsLbjhpfG3BQBNdlUFT/uoeOFwCWALw+Iw2stNvaFLcJqU0sOmOhD4z8MTh4gwr\r\nwgXZLPlVyHxGuufO9QIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:17:51.8683-07	2018-06-20 15:17:51.8683-07
1011117	cso_chairperson@dlsu.edu.ph	1	0	$2a$06$k/94ajM5n5IJlp3tgnewXeJNc6eJtkRhn5qU7DfiMMHpn/41WMzKu	$2a$06$k/94ajM5n5IJlp3tgnewXe	CSO	\N	Chairperson	6312312412	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCct6871QS2qtDxi5T12eSk/znmDFDIuLH1Q2V3owXqV7WldLso\r\nDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHEGe1n6litU/6CUnKUjlKEF9nw\r\nB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIlNxDPm6J/sYxt8ymirQIDAQAB\r\nAoGAZi/LfjsHCMjW1zlJlwlN8lxNd3h+UHNF7oPUrK7LE6O/WLSFuLfj8BHbqg6v\r\n5qjDsStEL6aPXuPYIPQF2uafQXwU9WSG7Iw4fybkOachHtEhxZB4KUSxVKqJynqA\r\nyzBSG8rAU7OOJr9dRUlVt8vIw6KXzol4A6ZQ8CH2BdAzuo0CQQDaRDWGOp4nLAV9\r\nMlVwM2QvHSJifS40F77VC7v6FMrqdp/GXXHtXxqltyp+5BZfkn2WldzcbOD7Gnj7\r\nG20l7rz7AkEAt8+DJlk3BpHDoi3Zpy4V+z6RNQgP+IyQ5eVksUethyV8mhs5kSzs\r\nIXpbKCIw+FpPiXfWf9noUqkwHvKw3FE+dwJAT0OmDHENLjyWYbj9vhlrsJBsBEhh\r\nlxlofAYe5drXNf6OV4Nn9EQtcTDrhdlfJqYUZbNW2dXQfmBGvypeoP/qMQJBAJg1\r\n0MbqzfQ0tKoSCdC1CyLYtuoRWRhbXonhobZkQsBNPJdowA0GBCvc5KuhVKf0MTUG\r\n9as9yXLaA609D1QCOxUCQD/rjvaV80gcG1AXJFc6y9w13hYUCpfBRATBHvoz3pAN\r\nwYsx9+22oRsrfmBQFuxo0o7Z1u+RJC7S5bRkKTL89Uc=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCct6871QS2qtDxi5T12eSk/znm\r\nDFDIuLH1Q2V3owXqV7WldLsoDrFukaHKOs3ob8a9mVb4589K3GQ3i+rVnmaUTXHE\r\nGe1n6litU/6CUnKUjlKEF9nwB+87rbqsINoowymtbCjvw3Ny0TXBYhoJaKRywgIl\r\nNxDPm6J/sYxt8ymirQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 15:19:02.710831-07	2018-06-20 15:19:02.710831-07
1011129	cso_avc_orgres@dlsu.edu.ph	1	0	$2a$06$umUcuhteWHIS/alstLbcK.2o0rozblgoCYB9Zy.5ph0A8V5eNW4D.	$2a$06$umUcuhteWHIS/alstLbcK.	CSO	\N	AVC - ORGRES	6321515512	-----BEGIN RSA PRIVATE KEY-----\r\nMIICXAIBAAKBgQCWV0IKxCMIRG3uw+obl+BbX3Zcahot+jWM+/wONxsfEhEUl/Px\r\nd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaTuFMSrD18GVir4/NMwD50f/pD\r\na83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY9TSVIY79gL6owf+2KQIDAQAB\r\nAoGAMgJEjaBApvdcOhghP5x9nOdcT9Fbc//O4F7RsUjTVLqFw/vnwWKpR92CkGyi\r\nSFV2ZtAFcK+lbD3kVOyquyFm3VeAgi7o7r0z5cML5EbC7/4FU++qa13+/Yxe+wH3\r\nx11xItwhhbEuzwxC3cqPLDZKsqZ7wRVBeeWf7a1ZlMARzKECQQDyrwkJ26bdEqWA\r\nrNPKzEGeq8R1NsHXyogwalcQXKuI6hlZDa0G8x+hs5qZCRR8xEbBdpxY0KqcWAx4\r\nzzWsCAnbAkEAnpcWYm2tr8I+IthJvZC/BkQ4fES9ImfMyY/jIi8KCpaEhTgtd5Qs\r\n8LQ9myy0gaUJbtPythnlvV9MkLpYku5pSwJBAIpQiG496lSFlB5KYktrLtsoOsgz\r\ndTdwDz7I3OZOatWV1uyShtM3LggTPUGLk0mo9Eq/N0zHYPXKmREhyA1MZ5ECQFMU\r\nucBUzwHdk6mzf2YU104UHTdU13SXxlvtykLVO8ByO/iChqc3dBehhQiu8d1dNUTf\r\nOi6WAJolu7myNca7qWMCQC5RzyUic9LsCJ0WEbJdCiGNFf68NCKvgU3Ecd0oOVdw\r\nDHlzzr/32erXIjn8nravd8WMOOzjDUkrgI/hHAqR/5s=\r\n-----END RSA PRIVATE KEY-----	-----BEGIN PUBLIC KEY-----\r\nMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCWV0IKxCMIRG3uw+obl+BbX3Zc\r\nahot+jWM+/wONxsfEhEUl/Pxd4d/kCPc2uxsgOCsLr2W12TBMJOG0p7bySjbgCaT\r\nuFMSrD18GVir4/NMwD50f/pDa83CLhN9wUfljKZ6433Fq5S8ZwaKq0vxFBmQphRY\r\n9TSVIY79gL6owf+2KQIDAQAB\r\n-----END PUBLIC KEY-----	\N	2018-03-20 15:15:54.070408-07	2018-03-20 16:43:46.888631-07	2018-06-20 16:43:46.888631-07
\.


--
-- Data for Name: accounttype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY accounttype (id, name) FROM stdin;
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

COPY activityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Name: activityattachmentrequirement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('activityattachmentrequirement_id_seq', 17, true);


--
-- Data for Name: activitynature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY activitynature (id, name) FROM stdin;
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

COPY activitytype (id, name) FROM stdin;
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

COPY amtactivityevaluation (activity, venue, equipment, materials, registration, timeend, activityexecution, hosts, facilitators, presentation, activities, organizationstandingpresentation, timestart, actualstarttime, actualendtime, anp, person1ea, person1loa, person1iitskoa, person1iomwm, person2ea, person2loa, person2iitskoa, person2iomwm, comments1, comments2, comments3, suggestions1, suggestions2, suggestions3, evaluator, status, datereserved, dateevaluated) FROM stdin;
\.


--
-- Data for Name: amtactivityevaluationstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY amtactivityevaluationstatus (id, name) FROM stdin;
0	Unassigned Evaluation
1	Pending Evaluation
3	Evaluated
\.


--
-- Data for Name: college; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY college (shortacronym, fullacronym, name) FROM stdin;
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

COPY documentattachmentrequirement (id, name) FROM stdin;
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

COPY expensetype (id, name) FROM stdin;
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

COPY functionality (id, name, category) FROM stdin;
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
211025	View/Submit Financial Documents as President	211
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

COPY functionalitycategory (id, name, domain) FROM stdin;
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

COPY functionalitydomain (id, name) FROM stdin;
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

COPY gosm (id, termid, studentorganization, status, datecreated, datesubmitted, datestatusmodified, preparedby, statusevaluator, comments) FROM stdin;
100001	201720182	1	3	2018-03-20 15:18:01.340799-07	2018-03-20 15:18:36.481506-07	2018-03-20 15:19:15.743221-07	1111111	1011117	\N
\.


--
-- Data for Name: gosmactivity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmactivity (id, gosm, sequence, goals, objectives, strategies, description, measures, targetdatestart, targetdateend, activitynature, activitytype, activitytypeotherdescription, isrelatedtoorganizationnature, budget, comments, isingosm) FROM stdin;
1	100001	1	addadad	{adadada}	asdada	asdadadad	asddad	2018-03-28	2018-03-28	1	0	\N	t	1000.00	\N	t
\.


--
-- Name: gosmactivity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('gosmactivity_id_seq', 1, true);


--
-- Data for Name: gosmactivityprojecthead; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmactivityprojecthead (idnumber, activityid) FROM stdin;
1111114	1
\.


--
-- Data for Name: gosmstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY gosmstatus (id, name) FROM stdin;
1	Created
2	For Approval
3	Approved
4	Pending
5	Denied
\.


--
-- Data for Name: organizationaccesscontrol; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationaccesscontrol (role, functionality, isallowed) FROM stdin;
0	104002	t
1	104002	t
2	104002	t
3	104002	t
4	104002	t
11	104003	t
12	104003	t
13	104003	t
8	108004	t
9	108004	t
10	108004	t
20	109006	t
21	109006	t
22	109006	t
0	214007	t
1	3008	t
2	3008	t
3	3008	t
4	3008	t
5	3008	t
21	3008	t
13	104013	t
12	104014	t
17	106017	t
18	106017	t
19	106017	t
5	108020	t
6	108020	t
7	108020	t
2	2023	t
20	2023	t
21	2023	t
0	104030	t
1	104030	t
2	104030	t
3	104030	t
4	104030	t
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
10024	211009	t
10024	211010	t
10024	214027	t
10024	104028	t
10024	109032	t
10025	211009	t
10025	211010	t
10025	214027	t
10025	104028	t
10025	109032	t
10026	211009	t
10026	214027	t
10026	104028	t
10026	109032	t
10027	211009	t
10027	211012	t
10027	214027	t
10027	104028	t
10027	109032	t
10028	211009	t
10028	214027	t
10028	104028	t
10028	109032	t
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
10030	211009	t
10030	212018	t
10030	211026	t
10030	214027	t
10030	104028	t
10030	109032	t
10031	214027	t
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
20033	211009	t
20033	211010	t
20033	214027	t
20033	104028	t
20033	109032	t
20034	211009	t
20034	211010	t
20034	214027	t
20034	104028	t
20034	109032	t
20035	211009	t
20035	214027	t
20035	104028	t
20035	109032	t
20036	211009	t
20036	211012	t
20036	214027	t
20036	104028	t
20036	109032	t
20037	211009	t
20037	214027	t
20037	104028	t
20037	109032	t
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
20039	211009	t
20039	212018	t
20039	211026	t
20039	214027	t
20039	104028	t
20039	109032	t
20040	214027	t
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
30042	211009	t
30042	211010	t
30042	214027	t
30042	104028	t
30042	109032	t
30043	211009	t
30043	211010	t
30043	214027	t
30043	104028	t
30043	109032	t
30044	211009	t
30044	214027	t
30044	104028	t
30044	109032	t
30045	211009	t
30045	211012	t
30045	214027	t
30045	104028	t
30045	109032	t
30046	211009	t
30046	214027	t
30046	104028	t
30046	109032	t
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
30048	211009	t
30048	212018	t
30048	211026	t
30048	214027	t
30048	104028	t
30048	109032	t
30049	214027	t
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
40051	211009	t
40051	211010	t
40051	214027	t
40051	104028	t
40051	109032	t
40052	211009	t
40052	211010	t
40052	214027	t
40052	104028	t
40052	109032	t
40053	211009	t
40053	214027	t
40053	104028	t
40053	109032	t
40054	211009	t
40054	211012	t
40054	214027	t
40054	104028	t
40054	109032	t
40055	211009	t
40055	214027	t
40055	104028	t
40055	109032	t
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
40057	211009	t
40057	212018	t
40057	211026	t
40057	214027	t
40057	104028	t
40057	109032	t
40058	214027	t
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
50060	211009	t
50060	211010	t
50060	214027	t
50060	104028	t
50060	109032	t
50061	211009	t
50061	211010	t
50061	214027	t
50061	104028	t
50061	109032	t
50062	211009	t
50062	214027	t
50062	104028	t
50062	109032	t
50063	211009	t
50063	211012	t
50063	214027	t
50063	104028	t
50063	109032	t
50064	211009	t
50064	214027	t
50064	104028	t
50064	109032	t
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
50066	211009	t
50066	212018	t
50066	211026	t
50066	214027	t
50066	104028	t
50066	109032	t
50067	214027	t
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
60069	211009	t
60069	211010	t
60069	214027	t
60069	104028	t
60069	109032	t
60070	211009	t
60070	211010	t
60070	214027	t
60070	104028	t
60070	109032	t
60071	211009	t
60071	214027	t
60071	104028	t
60071	109032	t
60072	211009	t
60072	211012	t
60072	214027	t
60072	104028	t
60072	109032	t
60073	211009	t
60073	214027	t
60073	104028	t
60073	109032	t
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
60075	211009	t
60075	212018	t
60075	211026	t
60075	214027	t
60075	104028	t
60075	109032	t
60076	214027	t
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
70078	211009	t
70078	211010	t
70078	214027	t
70078	104028	t
70078	109032	t
70079	211009	t
70079	211010	t
70079	214027	t
70079	104028	t
70079	109032	t
70080	211009	t
70080	214027	t
70080	104028	t
70080	109032	t
70081	211009	t
70081	211012	t
70081	214027	t
70081	104028	t
70081	109032	t
70082	211009	t
70082	214027	t
70082	104028	t
70082	109032	t
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
70084	211009	t
70084	212018	t
70084	211026	t
70084	214027	t
70084	104028	t
70084	109032	t
70085	214027	t
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
80087	211009	t
80087	211010	t
80087	214027	t
80087	104028	t
80087	109032	t
80088	211009	t
80088	211010	t
80088	214027	t
80088	104028	t
80088	109032	t
80089	211009	t
80089	214027	t
80089	104028	t
80089	109032	t
80090	211009	t
80090	211012	t
80090	214027	t
80090	104028	t
80090	109032	t
80091	211009	t
80091	214027	t
80091	104028	t
80091	109032	t
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
80093	211009	t
80093	212018	t
80093	211026	t
80093	214027	t
80093	104028	t
80093	109032	t
80094	214027	t
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
90096	211009	t
90096	211010	t
90096	214027	t
90096	104028	t
90096	109032	t
90097	211009	t
90097	211010	t
90097	214027	t
90097	104028	t
90097	109032	t
90098	211009	t
90098	214027	t
90098	104028	t
90098	109032	t
90099	211009	t
90099	211012	t
90099	214027	t
90099	104028	t
90099	109032	t
90100	211009	t
90100	214027	t
90100	104028	t
90100	109032	t
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
90102	211009	t
90102	212018	t
90102	211026	t
90102	214027	t
90102	104028	t
90102	109032	t
90103	214027	t
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
100105	211009	t
100105	211010	t
100105	214027	t
100105	104028	t
100105	109032	t
100106	211009	t
100106	211010	t
100106	214027	t
100106	104028	t
100106	109032	t
100107	211009	t
100107	214027	t
100107	104028	t
100107	109032	t
100108	211009	t
100108	211012	t
100108	214027	t
100108	104028	t
100108	109032	t
100109	211009	t
100109	214027	t
100109	104028	t
100109	109032	t
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
100111	211009	t
100111	212018	t
100111	211026	t
100111	214027	t
100111	104028	t
100111	109032	t
100112	214027	t
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
110114	211009	t
110114	211010	t
110114	214027	t
110114	104028	t
110114	109032	t
110115	211009	t
110115	211010	t
110115	214027	t
110115	104028	t
110115	109032	t
110116	211009	t
110116	214027	t
110116	104028	t
110116	109032	t
110117	211009	t
110117	211012	t
110117	214027	t
110117	104028	t
110117	109032	t
110118	211009	t
110118	214027	t
110118	104028	t
110118	109032	t
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
110120	211009	t
110120	212018	t
110120	211026	t
110120	214027	t
110120	104028	t
110120	109032	t
110121	214027	t
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
120123	211009	t
120123	211010	t
120123	214027	t
120123	104028	t
120123	109032	t
120124	211009	t
120124	211010	t
120124	214027	t
120124	104028	t
120124	109032	t
120125	211009	t
120125	214027	t
120125	104028	t
120125	109032	t
120126	211009	t
120126	211012	t
120126	214027	t
120126	104028	t
120126	109032	t
120127	211009	t
120127	214027	t
120127	104028	t
120127	109032	t
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
120129	211009	t
120129	212018	t
120129	211026	t
120129	214027	t
120129	104028	t
120129	109032	t
120130	214027	t
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
130132	211009	t
130132	211010	t
130132	214027	t
130132	104028	t
130132	109032	t
130133	211009	t
130133	211010	t
130133	214027	t
130133	104028	t
130133	109032	t
130134	211009	t
130134	214027	t
130134	104028	t
130134	109032	t
130135	211009	t
130135	211012	t
130135	214027	t
130135	104028	t
130135	109032	t
130136	211009	t
130136	214027	t
130136	104028	t
130136	109032	t
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
130138	211009	t
130138	212018	t
130138	211026	t
130138	214027	t
130138	104028	t
130138	109032	t
130139	214027	t
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
140141	211009	t
140141	211010	t
140141	214027	t
140141	104028	t
140141	109032	t
140142	211009	t
140142	211010	t
140142	214027	t
140142	104028	t
140142	109032	t
140143	211009	t
140143	214027	t
140143	104028	t
140143	109032	t
140144	211009	t
140144	211012	t
140144	214027	t
140144	104028	t
140144	109032	t
140145	211009	t
140145	214027	t
140145	104028	t
140145	109032	t
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
140147	211009	t
140147	212018	t
140147	211026	t
140147	214027	t
140147	104028	t
140147	109032	t
140148	214027	t
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
150150	211009	t
150150	211010	t
150150	214027	t
150150	104028	t
150150	109032	t
150151	211009	t
150151	211010	t
150151	214027	t
150151	104028	t
150151	109032	t
150152	211009	t
150152	214027	t
150152	104028	t
150152	109032	t
150153	211009	t
150153	211012	t
150153	214027	t
150153	104028	t
150153	109032	t
150154	211009	t
150154	214027	t
150154	104028	t
150154	109032	t
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
150156	211009	t
150156	212018	t
150156	211026	t
150156	214027	t
150156	104028	t
150156	109032	t
150157	214027	t
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
160159	211009	t
160159	211010	t
160159	214027	t
160159	104028	t
160159	109032	t
160160	211009	t
160160	211010	t
160160	214027	t
160160	104028	t
160160	109032	t
160161	211009	t
160161	214027	t
160161	104028	t
160161	109032	t
160162	211009	t
160162	211012	t
160162	214027	t
160162	104028	t
160162	109032	t
160163	211009	t
160163	214027	t
160163	104028	t
160163	109032	t
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
160165	211009	t
160165	212018	t
160165	211026	t
160165	214027	t
160165	104028	t
160165	109032	t
160166	214027	t
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
170168	211009	t
170168	211010	t
170168	214027	t
170168	104028	t
170168	109032	t
170169	211009	t
170169	211010	t
170169	214027	t
170169	104028	t
170169	109032	t
170170	211009	t
170170	214027	t
170170	104028	t
170170	109032	t
170171	211009	t
170171	211012	t
170171	214027	t
170171	104028	t
170171	109032	t
170172	211009	t
170172	214027	t
170172	104028	t
170172	109032	t
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
170174	211009	t
170174	212018	t
170174	211026	t
170174	214027	t
170174	104028	t
170174	109032	t
170175	214027	t
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
180177	211009	t
180177	211010	t
180177	214027	t
180177	104028	t
180177	109032	t
180178	211009	t
180178	211010	t
180178	214027	t
180178	104028	t
180178	109032	t
180179	211009	t
180179	214027	t
180179	104028	t
180179	109032	t
180180	211009	t
180180	211012	t
180180	214027	t
180180	104028	t
180180	109032	t
180181	211009	t
180181	214027	t
180181	104028	t
180181	109032	t
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
180183	211009	t
180183	212018	t
180183	211026	t
180183	214027	t
180183	104028	t
180183	109032	t
180184	214027	t
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
190186	211009	t
190186	211010	t
190186	214027	t
190186	104028	t
190186	109032	t
190187	211009	t
190187	211010	t
190187	214027	t
190187	104028	t
190187	109032	t
190188	211009	t
190188	214027	t
190188	104028	t
190188	109032	t
190189	211009	t
190189	211012	t
190189	214027	t
190189	104028	t
190189	109032	t
190190	211009	t
190190	214027	t
190190	104028	t
190190	109032	t
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
190192	211009	t
190192	212018	t
190192	211026	t
190192	214027	t
190192	104028	t
190192	109032	t
190193	214027	t
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
200195	211009	t
200195	211010	t
200195	214027	t
200195	104028	t
200195	109032	t
200196	211009	t
200196	211010	t
200196	214027	t
200196	104028	t
200196	109032	t
200197	211009	t
200197	214027	t
200197	104028	t
200197	109032	t
200198	211009	t
200198	211012	t
200198	214027	t
200198	104028	t
200198	109032	t
200199	211009	t
200199	214027	t
200199	104028	t
200199	109032	t
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
200201	211009	t
200201	212018	t
200201	211026	t
200201	214027	t
200201	104028	t
200201	109032	t
200202	214027	t
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
210204	211009	t
210204	211010	t
210204	214027	t
210204	104028	t
210204	109032	t
210205	211009	t
210205	211010	t
210205	214027	t
210205	104028	t
210205	109032	t
210206	211009	t
210206	214027	t
210206	104028	t
210206	109032	t
210207	211009	t
210207	211012	t
210207	214027	t
210207	104028	t
210207	109032	t
210208	211009	t
210208	214027	t
210208	104028	t
210208	109032	t
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
210210	211009	t
210210	212018	t
210210	211026	t
210210	214027	t
210210	104028	t
210210	109032	t
210211	214027	t
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
220213	211009	t
220213	211010	t
220213	214027	t
220213	104028	t
220213	109032	t
220214	211009	t
220214	211010	t
220214	214027	t
220214	104028	t
220214	109032	t
220215	211009	t
220215	214027	t
220215	104028	t
220215	109032	t
220216	211009	t
220216	211012	t
220216	214027	t
220216	104028	t
220216	109032	t
220217	211009	t
220217	214027	t
220217	104028	t
220217	109032	t
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
220219	211009	t
220219	212018	t
220219	211026	t
220219	214027	t
220219	104028	t
220219	109032	t
220220	214027	t
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
230222	211009	t
230222	211010	t
230222	214027	t
230222	104028	t
230222	109032	t
230223	211009	t
230223	211010	t
230223	214027	t
230223	104028	t
230223	109032	t
230224	211009	t
230224	214027	t
230224	104028	t
230224	109032	t
230225	211009	t
230225	211012	t
230225	214027	t
230225	104028	t
230225	109032	t
230226	211009	t
230226	214027	t
230226	104028	t
230226	109032	t
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
230228	211009	t
230228	212018	t
230228	211026	t
230228	214027	t
230228	104028	t
230228	109032	t
230229	214027	t
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
240231	211009	t
240231	211010	t
240231	214027	t
240231	104028	t
240231	109032	t
240232	211009	t
240232	211010	t
240232	214027	t
240232	104028	t
240232	109032	t
240233	211009	t
240233	214027	t
240233	104028	t
240233	109032	t
240234	211009	t
240234	211012	t
240234	214027	t
240234	104028	t
240234	109032	t
240235	211009	t
240235	214027	t
240235	104028	t
240235	109032	t
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
240237	211009	t
240237	212018	t
240237	211026	t
240237	214027	t
240237	104028	t
240237	109032	t
240238	214027	t
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
250240	211009	t
250240	211010	t
250240	214027	t
250240	104028	t
250240	109032	t
250241	211009	t
250241	211010	t
250241	214027	t
250241	104028	t
250241	109032	t
250242	211009	t
250242	214027	t
250242	104028	t
250242	109032	t
250243	211009	t
250243	211012	t
250243	214027	t
250243	104028	t
250243	109032	t
250244	211009	t
250244	214027	t
250244	104028	t
250244	109032	t
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
250246	211009	t
250246	212018	t
250246	211026	t
250246	214027	t
250246	104028	t
250246	109032	t
250247	214027	t
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
260249	211009	t
260249	211010	t
260249	214027	t
260249	104028	t
260249	109032	t
260250	211009	t
260250	211010	t
260250	214027	t
260250	104028	t
260250	109032	t
260251	211009	t
260251	214027	t
260251	104028	t
260251	109032	t
260252	211009	t
260252	211012	t
260252	214027	t
260252	104028	t
260252	109032	t
260253	211009	t
260253	214027	t
260253	104028	t
260253	109032	t
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
260255	211009	t
260255	212018	t
260255	211026	t
260255	214027	t
260255	104028	t
260255	109032	t
260256	214027	t
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
270258	211009	t
270258	211010	t
270258	214027	t
270258	104028	t
270258	109032	t
270259	211009	t
270259	211010	t
270259	214027	t
270259	104028	t
270259	109032	t
270260	211009	t
270260	214027	t
270260	104028	t
270260	109032	t
270261	211009	t
270261	211012	t
270261	214027	t
270261	104028	t
270261	109032	t
270262	211009	t
270262	214027	t
270262	104028	t
270262	109032	t
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
270264	211009	t
270264	212018	t
270264	211026	t
270264	214027	t
270264	104028	t
270264	109032	t
270265	214027	t
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
280267	211009	t
280267	211010	t
280267	214027	t
280267	104028	t
280267	109032	t
280268	211009	t
280268	211010	t
280268	214027	t
280268	104028	t
280268	109032	t
280269	211009	t
280269	214027	t
280269	104028	t
280269	109032	t
280270	211009	t
280270	211012	t
280270	214027	t
280270	104028	t
280270	109032	t
280271	211009	t
280271	214027	t
280271	104028	t
280271	109032	t
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
280273	211009	t
280273	212018	t
280273	211026	t
280273	214027	t
280273	104028	t
280273	109032	t
280274	214027	t
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
290276	211009	t
290276	211010	t
290276	214027	t
290276	104028	t
290276	109032	t
290277	211009	t
290277	211010	t
290277	214027	t
290277	104028	t
290277	109032	t
290278	211009	t
290278	214027	t
290278	104028	t
290278	109032	t
290279	211009	t
290279	211012	t
290279	214027	t
290279	104028	t
290279	109032	t
290280	211009	t
290280	214027	t
290280	104028	t
290280	109032	t
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
290282	211009	t
290282	212018	t
290282	211026	t
290282	214027	t
290282	104028	t
290282	109032	t
290283	214027	t
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
300285	211009	t
300285	211010	t
300285	214027	t
300285	104028	t
300285	109032	t
300286	211009	t
300286	211010	t
300286	214027	t
300286	104028	t
300286	109032	t
300287	211009	t
300287	214027	t
300287	104028	t
300287	109032	t
300288	211009	t
300288	211012	t
300288	214027	t
300288	104028	t
300288	109032	t
300289	211009	t
300289	214027	t
300289	104028	t
300289	109032	t
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
300291	211009	t
300291	212018	t
300291	211026	t
300291	214027	t
300291	104028	t
300291	109032	t
300292	214027	t
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
310294	211009	t
310294	211010	t
310294	214027	t
310294	104028	t
310294	109032	t
310295	211009	t
310295	211010	t
310295	214027	t
310295	104028	t
310295	109032	t
310296	211009	t
310296	214027	t
310296	104028	t
310296	109032	t
310297	211009	t
310297	211012	t
310297	214027	t
310297	104028	t
310297	109032	t
310298	211009	t
310298	214027	t
310298	104028	t
310298	109032	t
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
310300	211009	t
310300	212018	t
310300	211026	t
310300	214027	t
310300	104028	t
310300	109032	t
310301	214027	t
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
320303	211009	t
320303	211010	t
320303	214027	t
320303	104028	t
320303	109032	t
320304	211009	t
320304	211010	t
320304	214027	t
320304	104028	t
320304	109032	t
320305	211009	t
320305	214027	t
320305	104028	t
320305	109032	t
320306	211009	t
320306	211012	t
320306	214027	t
320306	104028	t
320306	109032	t
320307	211009	t
320307	214027	t
320307	104028	t
320307	109032	t
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
320309	211009	t
320309	212018	t
320309	211026	t
320309	214027	t
320309	104028	t
320309	109032	t
320310	214027	t
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
330312	211009	t
330312	211010	t
330312	214027	t
330312	104028	t
330312	109032	t
330313	211009	t
330313	211010	t
330313	214027	t
330313	104028	t
330313	109032	t
330314	211009	t
330314	214027	t
330314	104028	t
330314	109032	t
330315	211009	t
330315	211012	t
330315	214027	t
330315	104028	t
330315	109032	t
330316	211009	t
330316	214027	t
330316	104028	t
330316	109032	t
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
330318	211009	t
330318	212018	t
330318	211026	t
330318	214027	t
330318	104028	t
330318	109032	t
330319	214027	t
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
340321	211009	t
340321	211010	t
340321	214027	t
340321	104028	t
340321	109032	t
340322	211009	t
340322	211010	t
340322	214027	t
340322	104028	t
340322	109032	t
340323	211009	t
340323	214027	t
340323	104028	t
340323	109032	t
340324	211009	t
340324	211012	t
340324	214027	t
340324	104028	t
340324	109032	t
340325	211009	t
340325	214027	t
340325	104028	t
340325	109032	t
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
340327	211009	t
340327	212018	t
340327	211026	t
340327	214027	t
340327	104028	t
340327	109032	t
340328	214027	t
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
350330	211009	t
350330	211010	t
350330	214027	t
350330	104028	t
350330	109032	t
350331	211009	t
350331	211010	t
350331	214027	t
350331	104028	t
350331	109032	t
350332	211009	t
350332	214027	t
350332	104028	t
350332	109032	t
350333	211009	t
350333	211012	t
350333	214027	t
350333	104028	t
350333	109032	t
350334	211009	t
350334	214027	t
350334	104028	t
350334	109032	t
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
350336	211009	t
350336	212018	t
350336	211026	t
350336	214027	t
350336	104028	t
350336	109032	t
350337	214027	t
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
360339	211009	t
360339	211010	t
360339	214027	t
360339	104028	t
360339	109032	t
360340	211009	t
360340	211010	t
360340	214027	t
360340	104028	t
360340	109032	t
360341	211009	t
360341	214027	t
360341	104028	t
360341	109032	t
360342	211009	t
360342	211012	t
360342	214027	t
360342	104028	t
360342	109032	t
360343	211009	t
360343	214027	t
360343	104028	t
360343	109032	t
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
360345	211009	t
360345	212018	t
360345	211026	t
360345	214027	t
360345	104028	t
360345	109032	t
360346	214027	t
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
370348	211009	t
370348	211010	t
370348	214027	t
370348	104028	t
370348	109032	t
370349	211009	t
370349	211010	t
370349	214027	t
370349	104028	t
370349	109032	t
370350	211009	t
370350	214027	t
370350	104028	t
370350	109032	t
370351	211009	t
370351	211012	t
370351	214027	t
370351	104028	t
370351	109032	t
370352	211009	t
370352	214027	t
370352	104028	t
370352	109032	t
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
370354	211009	t
370354	212018	t
370354	211026	t
370354	214027	t
370354	104028	t
370354	109032	t
370355	214027	t
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
380357	211009	t
380357	211010	t
380357	214027	t
380357	104028	t
380357	109032	t
380358	211009	t
380358	211010	t
380358	214027	t
380358	104028	t
380358	109032	t
380359	211009	t
380359	214027	t
380359	104028	t
380359	109032	t
380360	211009	t
380360	211012	t
380360	214027	t
380360	104028	t
380360	109032	t
380361	211009	t
380361	214027	t
380361	104028	t
380361	109032	t
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
380363	211009	t
380363	212018	t
380363	211026	t
380363	214027	t
380363	104028	t
380363	109032	t
380364	214027	t
\.


--
-- Data for Name: organizationcluster; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationcluster (id, name, acronym) FROM stdin;
1	Alliance of Science Organizations	ASO
2	Alliance of Special Interest and Socio-Civic Organizations	ASPIRE
3	College of Liberal Arts Professional Organizations	CAP12
4	Engineering Alliance Geared Towards Excellence	ENGAGE
5	Alliance of Professional Organizations of Business and Economics	PROBE
\.


--
-- Data for Name: organizationfacultyadviser; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationfacultyadviser (id, organization, faculty, yearid) FROM stdin;
1	1	2011111	20172018
2	1	2011112	20172018
3	38	2011111	20172018
4	38	2011112	20172018
\.


--
-- Name: organizationfacultyadviser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('organizationfacultyadviser_id_seq', 4, true);


--
-- Data for Name: organizationnature; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationnature (id, name, acronym) FROM stdin;
1	Special Interest	SPIN
2	Professional Organization	PROF
3	Socio-civic and Religious	SCORE
4	Professional Organization Group	PROG
\.


--
-- Data for Name: organizationofficer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationofficer (idnumber, role, yearid, dateassigned, isactive) FROM stdin;
1111111	10023	20172018	2018-03-20 15:15:54.070408-07	t
1111112	10026	20172018	2018-03-20 15:15:54.070408-07	t
1111113	10027	20172018	2018-03-20 15:15:54.070408-07	t
1111114	10028	20172018	2018-03-20 15:15:54.070408-07	t
1111115	10029	20172018	2018-03-20 15:15:54.070408-07	t
1111116	10030	20172018	2018-03-20 15:15:54.070408-07	t
2111111	380356	20172018	2018-03-20 15:15:54.070408-07	t
2111112	380359	20172018	2018-03-20 15:15:54.070408-07	t
2111113	380360	20172018	2018-03-20 15:15:54.070408-07	t
2111114	380361	20172018	2018-03-20 15:15:54.070408-07	t
2111115	380362	20172018	2018-03-20 15:15:54.070408-07	t
2111116	380363	20172018	2018-03-20 15:15:54.070408-07	t
1011117	0	20172018	2018-03-20 15:15:54.070408-07	t
1011118	2	20172018	2018-03-20 15:15:54.070408-07	t
1011119	11	20172018	2018-03-20 15:15:54.070408-07	t
1011120	12	20172018	2018-03-20 15:15:54.070408-07	t
1011121	13	20172018	2018-03-20 15:15:54.070408-07	t
1011122	14	20172018	2018-03-20 15:15:54.070408-07	t
1011123	15	20172018	2018-03-20 15:15:54.070408-07	t
1011124	16	20172018	2018-03-20 15:15:54.070408-07	t
1011125	17	20172018	2018-03-20 15:15:54.070408-07	t
1011126	18	20172018	2018-03-20 15:15:54.070408-07	t
1011127	19	20172018	2018-03-20 15:15:54.070408-07	t
1011128	10	20172018	2018-03-20 15:15:54.070408-07	t
1011129	21	20172018	2018-03-20 15:15:54.070408-07	t
1011130	22	20172018	2018-03-20 15:15:54.070408-07	t
1011131	8	20172018	2018-03-20 15:15:54.070408-07	t
1011132	9	20172018	2018-03-20 15:15:54.070408-07	t
1011133	10	20172018	2018-03-20 15:15:54.070408-07	t
1011134	5	20172018	2018-03-20 15:15:54.070408-07	t
1011135	6	20172018	2018-03-20 15:15:54.070408-07	t
1011136	7	20172018	2018-03-20 15:15:54.070408-07	t
\.


--
-- Data for Name: organizationrole; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY organizationrole (id, organization, sequence, name, shortname, rank, uniqueposition, masterrole, home_url) FROM stdin;
0	0	1	Chairperson	Chair	0	t	\N	\N
1	0	2	Executive Vice Chairperson for Internals	EVC - Interals	10	t	0	\N
2	0	3	Executive Vice Chairperson for Externals	EVC - Externals	10	t	0	\N
3	0	4	Executive Vice Chairperson for Activities and Documentations	EVC - AND	10	t	0	\N
4	0	5	Executive Vice Chairperson for Finance	EVC - Finance	10	t	0	\N
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
260249	26	2	Executive Secretariat	ES	10	t	260248	\N
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

COPY organizationstatus (id, name) FROM stdin;
0	Active
1	Suspended
3	Dissolved
\.


--
-- Data for Name: postactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY postactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
\.


--
-- Data for Name: preactivityattachmentrequirement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY preactivityattachmentrequirement (id, activitytype, attachment, optional) FROM stdin;
1	0	0	f
2	0	1	f
3	1	2	f
4	2	3	f
5	3	3	f
6	3	4	f
7	4	3	f
8	4	5	f
9	5	3	f
10	5	6	f
11	6	3	f
12	6	7	t
13	7	3	f
14	7	8	f
15	7	0	f
16	8	3	f
17	9	3	f
\.


--
-- Data for Name: projectproposal; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposal (id, gosmactivity, status, enp, enmp, actualdatestart, actualdateend, venue, context1, context2, context3, isexpense, sourcefundother, sourcefundparticipantfee, sourcefundorganizational, accumulatedoperationalfunds, accumulateddepositoryfunds, organizationfundothersource, comments, preparedby, facultyadviser, datecreated, datesubmitted, datestatusmodified, isattachmentscomplete, isbriefcontextcomplete, isexpensecomplete, isprogramcomplete, reschedulereason, reschedreasonother, rescheduledates, reschedrejectreason, timespended) FROM stdin;
\.


--
-- Name: projectproposal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposal_id_seq', 1, false);


--
-- Data for Name: projectproposalattachment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalattachment (id, projectproposal, requirement, sequence, idnumber, filename, filenametoshow, directory) FROM stdin;
\.


--
-- Name: projectproposalattachment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalattachment_id_seq', 1, false);


--
-- Data for Name: projectproposalexpenses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalexpenses (id, projectproposal, sequence, material, quantity, unitcost, type) FROM stdin;
\.


--
-- Name: projectproposalexpenses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalexpenses_id_seq', 1, false);


--
-- Data for Name: projectproposalprogramdesign; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprogramdesign (id, projectproposal, dayid, sequence, date, starttime, endtime, activity, activitydescription, personincharge) FROM stdin;
\.


--
-- Name: projectproposalprogramdesign_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalprogramdesign_id_seq', 1, false);


--
-- Data for Name: projectproposalprogramdesignpersonincharge; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprogramdesignpersonincharge (id, programdesign, projecthead) FROM stdin;
\.


--
-- Name: projectproposalprogramdesignpersonincharge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalprogramdesignpersonincharge_id_seq', 1, false);


--
-- Data for Name: projectproposalprojectedincome; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalprojectedincome (projectproposal, sequence, item, quantity, sellingprice) FROM stdin;
\.


--
-- Data for Name: projectproposalreschedulereason; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalreschedulereason (id, name) FROM stdin;
1	Class suspension
2	Insufficient participnts
3	Speaker unavailable
4	Others
\.


--
-- Data for Name: projectproposalsignatory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalsignatory (id, gosmactivity, signatory, type, status, comments, sectionstoedit, document, digitalsignature, datesigned) FROM stdin;
\.


--
-- Name: projectproposalsignatory_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projectproposalsignatory_id_seq', 1, false);


--
-- Data for Name: projectproposalsourcefunds; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalsourcefunds (projectproposal, sequence, name, amount) FROM stdin;
\.


--
-- Data for Name: projectproposalstatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projectproposalstatus (id, name) FROM stdin;
1	Created
2	For approval
3	Approved
4	Pending
5	Denied
6	Rescheduled
7	Rescheduled Denied
\.


--
-- Data for Name: schoolyear; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY schoolyear (id, startyear, endyear, datestart, dateend) FROM stdin;
20152016	2015	2016	2015-08-24	2016-08-27
20162017	2016	2017	2016-09-12	2017-08-19
20172018	2017	2018	2017-09-11	2018-08-28
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY session (sid, sess, expire) FROM stdin;
FLXI6SqN6gXFTlChpo8l2KqOSihmckXN	{"cookie":{"originalMaxAge":3600000,"expires":"2018-03-21T02:35:07.145Z","secure":false,"httpOnly":false,"path":"/","sameSite":"strict"},"csrfSecret":"C8w7CQH-NutwOYbsIYW9s93j"}	2018-03-20 19:35:08
\.


--
-- Data for Name: signatorystatus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY signatorystatus (id, name) FROM stdin;
0	Unsigned
1	Approved
2	Pend
3	Denied
4	Force Signed
\.


--
-- Data for Name: signatorytype; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY signatorytype (id, name, lineup) FROM stdin;
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

COPY studentorganization (id, name, status, cluster, nature, college, acronym, description, funds, operationalfunds, depositoryfunds, depositryfunds, path_profilepicture, accountnumber) FROM stdin;
0	Council of Student Organizations	0	\N	\N	\N	CSO	\N	0.00	1178.00	313269.00	0.00	\\plugins\\images\\cso.png	\N
1	La Salle Computer Society	0	2	\N	\N	LSCS	\N	0.00	1010.00	343155.00	0.00	\N	\N
2	Math Circle	0	1	\N	\N	MC	\N	0.00	1327.00	320345.00	0.00	\N	\N
3	Physics Society	0	1	\N	\N	Physoc	\N	0.00	1318.00	335601.00	0.00	\N	\N
4	Societas Vitae	0	1	\N	\N	SV	\N	0.00	1055.00	335645.00	0.00	\N	\N
5	Chemistry Society	0	1	\N	\N	Chemsoc	\N	0.00	1338.00	300539.00	0.00	\N	\N
6	Union of Students Inspired Towards Education	0	2	\N	\N	UNITED	\N	0.00	945.00	326693.00	0.00	\N	\N
7	DLSU Filipino & Chinese Organization	0	2	\N	\N	ENGLICOM	\N	0.00	1333.00	321803.00	0.00	\N	\N
8	ROTARACT Club of DLSU	0	2	\N	\N	ROTARACT	\N	0.00	970.00	333193.00	0.00	\N	\N
9	United International Student Organization	0	2	\N	\N	UNISTO	\N	0.00	1461.00	331026.00	0.00	\N	\N
10	AIESEC DLSU	0	2	\N	\N	AIESEC	\N	0.00	942.00	300869.00	0.00	\N	\N
11	Moo Media	0	2	\N	\N	Moo	\N	0.00	1132.00	317502.00	0.00	\N	\N
12	Outdoor Club	0	2	\N	\N	OC	\N	0.00	1012.00	325059.00	0.00	\N	\N
13	Writer’s Guild	0	2	\N	\N	WG	\N	0.00	1127.00	322335.00	0.00	\N	\N
14	De La Salle University - Environmental Conservation Organization	0	1	\N	\N	ECO	\N	0.00	1463.00	319732.00	0.00	\N	\N
15	Gakuen Anime Shoshiki	0	2	\N	\N	GAS	\N	0.00	1414.00	315162.00	0.00	\N	\N
16	The Organization for American Studies	0	3	\N	\N	AMSTUD	\N	0.00	1327.00	341531.00	0.00	\N	\N
17	Behavioral Sciences Society	0	3	\N	\N	BSS	\N	0.00	1116.00	315641.00	0.00	\N	\N
18	Cultura	0	3	\N	\N	Cultura	\N	0.00	1327.00	332706.00	0.00	\N	\N
19	Dalubhasaan ng mga Umuusbong na Mag-aaral ng Araling Pilipino	0	1	\N	\N	DANUM	\N	0.00	1218.00	341879.00	0.00	\N	\N
20	European Studies Association	0	3	\N	\N	ESA	\N	0.00	1217.00	344893.00	0.00	\N	\N
21	Kapatiran ng Kabataan para sa Kaunlaran	0	3	\N	\N	Kaunlaran	\N	0.00	1214.00	326813.00	0.00	\N	\N
22	Nihon Kenkyu Kai	0	3	\N	\N	NKK	\N	0.00	1243.00	342839.00	0.00	\N	\N
23	Political Science Society	0	3	\N	\N	Poliscy	\N	0.00	1498.00	337378.00	0.00	\N	\N
24	Samahan ng Lasalyanong Pilosopo	0	3	\N	\N	DLSU Pilosopo	\N	0.00	1271.00	333634.00	0.00	\N	\N
25	Samahan ng mga Mag-aaral sa Sikolohiya	0	3	\N	\N	SMS	\N	0.00	1460.00	332101.00	0.00	\N	\N
26	Sociedad De Historia	0	3	\N	\N	SDH	\N	0.00	1005.00	349469.00	0.00	\N	\N
27	Team Communications	0	3	\N	\N	TeamComm	\N	0.00	960.00	310673.00	0.00	\N	\N
28	Association of Computer Engineering Students	0	4	\N	\N	ACCESS	\N	0.00	1423.00	327246.00	0.00	\N	\N
29	Chemical Engineering Society	0	4	\N	\N	ChEn	\N	0.00	1022.00	305102.00	0.00	\N	\N
30	Civil Engineering Society	0	4	\N	\N	CES	\N	0.00	1366.00	304808.00	0.00	\N	\N
31	Electronic and Communications Engineering Society	0	4	\N	\N	ECES	\N	0.00	1080.00	310490.00	0.00	\N	\N
32	Industrial Management Engineering Society	0	4	\N	\N	IMES	\N	0.00	996.00	314412.00	0.00	\N	\N
33	Society of Manufacturing Engineering	0	4	\N	\N	SME	\N	0.00	1256.00	304395.00	0.00	\N	\N
34	AdCreate Society	0	5	\N	\N	AdCreate	\N	0.00	1499.00	329414.00	0.00	\N	\N
35	Business Management Society	0	5	\N	\N	BMS	\N	0.00	1431.00	345366.00	0.00	\N	\N
36	Economics Organization	0	5	\N	\N	EconOrg	\N	0.00	1169.00	309567.00	0.00	\N	\N
37	Management of Financial Institutions Association	0	5	\N	\N	MaFia	\N	0.00	968.00	312817.00	0.00	\N	\N
38	Young Entrepreneurs Society	0	5	\N	\N	YES	\N	0.00	948.00	325658.00	0.00	\N	\N
\.


--
-- Data for Name: term; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY term (id, schoolyearid, number, datestart, dateend) FROM stdin;
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
-- Name: ARFOrganizationPosition ARFOrganizationPosition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ARFOrganizationPosition"
    ADD CONSTRAINT "ARFOrganizationPosition_pkey" PRIMARY KEY (id);


--
-- Name: AccountNotificationStatus AccountNotificationStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotificationStatus"
    ADD CONSTRAINT "AccountNotificationStatus_pkey" PRIMARY KEY (id);


--
-- Name: AccountNotification AccountNotification_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_id_key" UNIQUE (id);


--
-- Name: AccountNotification AccountNotification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_pkey" PRIMARY KEY (account, sequence);


--
-- Name: AccountStatus AccountStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountStatus"
    ADD CONSTRAINT "AccountStatus_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityMaterial ActivityPublicityMaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityMaterial"
    ADD CONSTRAINT "ActivityPublicityMaterial_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityModeOfDistribution ActivityPublicityModeOfDistribution_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityModeOfDistribution"
    ADD CONSTRAINT "ActivityPublicityModeOfDistribution_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityRevisionReason ActivityPublicityRevisionReason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityRevisionReason"
    ADD CONSTRAINT "ActivityPublicityRevisionReason_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicityStatus ActivityPublicityStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicityStatus"
    ADD CONSTRAINT "ActivityPublicityStatus_pkey" PRIMARY KEY (id);


--
-- Name: ActivityPublicity ActivityPublicity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_id_key" UNIQUE (id);


--
-- Name: ActivityPublicity ActivityPublicity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: ActivityResearchForm ActivityResearchForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_pkey" PRIMARY KEY ("GOSMActivity", sequence);


--
-- Name: ActivityVenue ActivityVenue_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_pkey" PRIMARY KEY (id);


--
-- Name: BookTransferEstablishment BookTransferEstablishment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "BookTransferEstablishment"
    ADD CONSTRAINT "BookTransferEstablishment_pkey" PRIMARY KEY (id);


--
-- Name: Building Building_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "Building"
    ADD CONSTRAINT "Building_pkey" PRIMARY KEY (id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_pkey" PRIMARY KEY ("expenseType", document);


--
-- Name: FinanceSignatoryType FinanceSignatoryType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "FinanceSignatoryType"
    ADD CONSTRAINT "FinanceSignatoryType_pkey" PRIMARY KEY (id);


--
-- Name: MemberSurveyForm MemberSurveyForm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_id_key" UNIQUE (id);


--
-- Name: MemberSurveyForm MemberSurveyForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_pkey" PRIMARY KEY ("termID", member, "organizationID");


--
-- Name: OfficerSurveyForm OfficerSurveyForm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_id_key" UNIQUE (id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_pkey" PRIMARY KEY ("termID", "organizationID", officer);


--
-- Name: OrganizationMember OrganizationMember_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_id_key" UNIQUE (id);


--
-- Name: OrganizationMember OrganizationMember_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_pkey" PRIMARY KEY ("idNumber", organization, "yearID");


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PostProjectBookTransferStatus PostProjectBookTransferStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferStatus"
    ADD CONSTRAINT "PostProjectBookTransferStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_id_key" UNIQUE (id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PostProjectDirectPaymentPayment PostProjectDirectPaymentPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentPayment"
    ADD CONSTRAINT "PostProjectDirectPaymentPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPaymentStatus PostProjectDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentStatus"
    ADD CONSTRAINT "PostProjectDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_id_key" UNIQUE (id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_id_key" UNIQUE (id);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PostProjectProposalStatus PostProjectProposalStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalStatus"
    ADD CONSTRAINT "PostProjectProposalStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectProposal PostProjectProposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_pkey" PRIMARY KEY ("GOSMActivity");


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_pkey" PRIMARY KEY (reimbursement, particular);


--
-- Name: PostProjectReimbursementPayment PostProjectReimbursementPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementPayment"
    ADD CONSTRAINT "PostProjectReimbursementPayment_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursementStatus PostProjectReimbursementStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementStatus"
    ADD CONSTRAINT "PostProjectReimbursementStatus_pkey" PRIMARY KEY (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_id_key" UNIQUE (id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_pkey" PRIMARY KEY ("bookTransfer", particular);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_pkey" PRIMARY KEY ("bookTransfer", signatory, type);


--
-- Name: PreActivityBookTransferStatus PreActivityBookTransferStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferStatus"
    ADD CONSTRAINT "PreActivityBookTransferStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_id_key" UNIQUE (id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_pkey" PRIMARY KEY ("cashAdvance", particular);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvanceStatus PreActivityCashAdvanceStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceStatus"
    ADD CONSTRAINT "PreActivityCashAdvanceStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_id_key" UNIQUE (id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_pkey" PRIMARY KEY ("directPayment", particular);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPaymentStatus PreActivityDirectPaymentStatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentStatus"
    ADD CONSTRAINT "PreActivityDirectPaymentStatus_pkey" PRIMARY KEY (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_id_key" UNIQUE (id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_pkey" PRIMARY KEY ("GOSMActivity", "submissionID", sequence);


--
-- Name: RateType RateType_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "RateType"
    ADD CONSTRAINT "RateType_pkey" PRIMARY KEY (id);


--
-- Name: SystemConfiguration SystemConfiguration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "SystemConfiguration"
    ADD CONSTRAINT "SystemConfiguration_pkey" PRIMARY KEY (name);


--
-- Name: VenueSize VenueSize_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "VenueSize"
    ADD CONSTRAINT "VenueSize_pkey" PRIMARY KEY (id);


--
-- Name: account account_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_pkey PRIMARY KEY (idnumber);


--
-- Name: accounttype accounttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY accounttype
    ADD CONSTRAINT accounttype_pkey PRIMARY KEY (id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: activitynature activitynature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activitynature
    ADD CONSTRAINT activitynature_pkey PRIMARY KEY (id);


--
-- Name: activitytype activitytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activitytype
    ADD CONSTRAINT activitytype_pkey PRIMARY KEY (id);


--
-- Name: amtactivityevaluation amtactivityevaluation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_pkey PRIMARY KEY (activity);


--
-- Name: amtactivityevaluationstatus amtactivityevaluationstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluationstatus
    ADD CONSTRAINT amtactivityevaluationstatus_pkey PRIMARY KEY (id);


--
-- Name: college college_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY college
    ADD CONSTRAINT college_pkey PRIMARY KEY (shortacronym);


--
-- Name: documentattachmentrequirement documentattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY documentattachmentrequirement
    ADD CONSTRAINT documentattachmentrequirement_pkey PRIMARY KEY (id);


--
-- Name: expensetype expensetype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY expensetype
    ADD CONSTRAINT expensetype_pkey PRIMARY KEY (id);


--
-- Name: functionality functionality_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionality
    ADD CONSTRAINT functionality_pkey PRIMARY KEY (id);


--
-- Name: functionalitycategory functionalitycategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitycategory
    ADD CONSTRAINT functionalitycategory_pkey PRIMARY KEY (id);


--
-- Name: functionalitydomain functionalitydomain_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitydomain
    ADD CONSTRAINT functionalitydomain_pkey PRIMARY KEY (id);


--
-- Name: gosm gosm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_id_key UNIQUE (id);


--
-- Name: gosm gosm_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_pkey PRIMARY KEY (termid, studentorganization);


--
-- Name: gosmactivity gosmactivity_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_id_key UNIQUE (id);


--
-- Name: gosmactivity gosmactivity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_pkey PRIMARY KEY (gosm, sequence);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_pkey PRIMARY KEY (idnumber, activityid);


--
-- Name: gosmstatus gosmstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmstatus
    ADD CONSTRAINT gosmstatus_pkey PRIMARY KEY (id);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_pkey PRIMARY KEY (role, functionality);


--
-- Name: organizationcluster organizationcluster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationcluster
    ADD CONSTRAINT organizationcluster_pkey PRIMARY KEY (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_id_key UNIQUE (id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_pkey PRIMARY KEY (organization, faculty, yearid);


--
-- Name: organizationnature organizationnature_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationnature
    ADD CONSTRAINT organizationnature_pkey PRIMARY KEY (id);


--
-- Name: organizationofficer organizationofficer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_pkey PRIMARY KEY (idnumber, role, yearid);


--
-- Name: organizationrole organizationrole_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_id_key UNIQUE (id);


--
-- Name: organizationrole organizationrole_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_pkey PRIMARY KEY (organization, sequence);


--
-- Name: organizationstatus organizationstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationstatus
    ADD CONSTRAINT organizationstatus_pkey PRIMARY KEY (id);


--
-- Name: PreActivityCashAdvanceSignatory pk_PreActivityCashAdvanceSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "pk_PreActivityCashAdvanceSignatory" PRIMARY KEY ("cashAdvance", signatory, type);


--
-- Name: PreActivityDirectPaymentSignatory pk_PreActivityDirectPaymentSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "pk_PreActivityDirectPaymentSignatory" PRIMARY KEY ("directPayment", signatory, type);


--
-- Name: projectproposalsignatory pk_ProjectProposalSignatory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT "pk_ProjectProposalSignatory" PRIMARY KEY (gosmactivity, signatory, type);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_pkey PRIMARY KEY (activitytype, attachment);


--
-- Name: projectproposal projectproposal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_id_key UNIQUE (id);


--
-- Name: projectproposal projectproposal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_pkey PRIMARY KEY (gosmactivity);


--
-- Name: projectproposalattachment projectproposalattachment_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_id_key UNIQUE (id);


--
-- Name: projectproposalattachment projectproposalattachment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_pkey PRIMARY KEY (projectproposal, requirement, sequence);


--
-- Name: projectproposalexpenses projectproposalexpenses_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_id_key UNIQUE (id);


--
-- Name: projectproposalexpenses projectproposalexpenses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_pkey PRIMARY KEY (projectproposal, dayid, sequence);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_id_key UNIQUE (id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_pkey PRIMARY KEY (programdesign, projecthead);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalreschedulereason projectproposalreschedulereason_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalreschedulereason
    ADD CONSTRAINT projectproposalreschedulereason_pkey PRIMARY KEY (id);


--
-- Name: projectproposalsignatory projectproposalsignatory_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_id_key UNIQUE (id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_pkey PRIMARY KEY (projectproposal, sequence);


--
-- Name: projectproposalstatus projectproposalstatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalstatus
    ADD CONSTRAINT projectproposalstatus_pkey PRIMARY KEY (id);


--
-- Name: schoolyear schoolyear_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schoolyear
    ADD CONSTRAINT schoolyear_id_key UNIQUE (id);


--
-- Name: schoolyear schoolyear_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY schoolyear
    ADD CONSTRAINT schoolyear_pkey PRIMARY KEY (startyear, endyear);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: signatorystatus signatorystatus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatorystatus
    ADD CONSTRAINT signatorystatus_pkey PRIMARY KEY (id);


--
-- Name: signatorytype signatorytype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY signatorytype
    ADD CONSTRAINT signatorytype_pkey PRIMARY KEY (id);


--
-- Name: studentorganization studentorganization_acronym_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_acronym_key UNIQUE (acronym);


--
-- Name: studentorganization studentorganization_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_pkey PRIMARY KEY (id);


--
-- Name: term term_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_id_key UNIQUE (id);


--
-- Name: term term_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (schoolyearid, number);


--
-- Name: PreActivityCashAdvanceParticular after_delete_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_delete_PreActivityCashAdvanceParticular_signatories" AFTER DELETE ON "PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE trigger_after_delete_finance_signatories('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'pacas', 'pacas."cashAdvance" = $1."cashAdvance"');


--
-- Name: PostProjectReimbursement after_insert_PostProjectReimbursement_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PostProjectReimbursement_signatories" AFTER INSERT ON "PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories_initial('PostProjectReimbursement', 'ppr', 'PostProjectReimbursementSignatory', 'reimbursement', 'PostAct_Reimbursement_get_organization_next_treasurer_signatory');


--
-- Name: PreActivityBookTransferParticular after_insert_PreActivityBookTransferParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityBookTransferParticular_signatories" AFTER INSERT ON "PreActivityBookTransferParticular" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories('PreActivityBookTransferParticular', 'pabtp', 'pabtp."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransferSignatory', 'bookTransfer', '$1."bookTransfer"');


--
-- Name: PreActivityBookTransfer after_insert_PreActivityBookTransfer_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityBookTransfer_signatories" AFTER INSERT ON "PreActivityBookTransfer" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories_initial('PreActivityBookTransfer', 'pabt', 'PreActivityBookTransferSignatory', 'bookTransfer', 'PreAct_BookTransfer_get_organization_next_treasurer_signatory');


--
-- Name: PreActivityCashAdvanceParticular after_insert_PreActivityCashAdvanceParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvanceParticular_signatories" AFTER INSERT ON "PreActivityCashAdvanceParticular" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories('PreActivityCashAdvanceParticular', 'pacap', 'pacap."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvanceSignatory', 'cashAdvance', '$1."cashAdvance"');


--
-- Name: PreActivityCashAdvance after_insert_PreActivityCashAdvance_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityCashAdvance_signatories" AFTER INSERT ON "PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_PreActivityCashAdvance_signatories"();


--
-- Name: PreActivityDirectPaymentParticular after_insert_PreActivityDirectPaymentParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityDirectPaymentParticular_signatories" AFTER INSERT ON "PreActivityDirectPaymentParticular" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories('PreActivityDirectPaymentParticular', 'pacap', 'pacap."directPayment" = $1."directPayment"', 'PreActivityDirectPaymentSignatory', 'directPayment', '$1."directPayment"');


--
-- Name: PreActivityDirectPayment after_insert_PreActivityDirectPayment_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityDirectPayment_signatories" AFTER INSERT ON "PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_PreActivityDirectPayment_signatories"();


--
-- Name: PostProjectReimbursementParticular after_insert_PreActivityReimbursementParticular_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_PreActivityReimbursementParticular_signatories" AFTER INSERT ON "PostProjectReimbursementParticular" FOR EACH ROW EXECUTE PROCEDURE trigger_after_insert_finance_signatories('PostProjectReimbursementParticular', 'pprp', 'pprp."reimbursement" = $1."reimbursement"', 'PostProjectReimbursementSignatory', 'reimbursement', '$1."reimbursement"');


--
-- Name: projectproposalprogramdesign after_insert_ProjectProposalProgramDesign; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_ProjectProposalProgramDesign" BEFORE INSERT ON projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_ProjectProposalProgramDesign"();


--
-- Name: projectproposal after_insert_ProjectProposal_signatories; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_ProjectProposal_signatories" AFTER INSERT ON projectproposal FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_ProjectProposal_signatories"();


--
-- Name: studentorganization after_insert_StudentOrganization_ACL; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_insert_StudentOrganization_ACL" AFTER INSERT ON studentorganization FOR EACH ROW EXECUTE PROCEDURE "trigger_after_insert_StudentOrganization_ACL"();


--
-- Name: PreActivityBookTransferSignatory after_update_PreActivityBookTransferSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityBookTransferSignatory_completion" AFTER UPDATE ON "PreActivityBookTransferSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_after_update_signatory_completion('PreActivityBookTransferSignatory', 'pabts', 'pabts."bookTransfer" = $1."bookTransfer"', 'PreActivityBookTransfer', 'pabt', 'pabt.id = $1."bookTransfer"');


--
-- Name: PreActivityCashAdvanceSignatory after_update_PreActivityCashAdvanceSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityCashAdvanceSignatory_completion" AFTER UPDATE ON "PreActivityCashAdvanceSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_after_update_signatory_completion('PreActivityCashAdvanceSignatory', 'precas', 'precas."cashAdvance" = $1."cashAdvance"', 'PreActivityCashAdvance', 'preca', 'preca.id = $1."cashAdvance"');


--
-- Name: PostProjectReimbursementSignatory after_update_PreActivityReimbursementSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_PreActivityReimbursementSignatory_completion" AFTER UPDATE ON "PostProjectReimbursementSignatory" FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_after_update_signatory_completion('PostProjectReimbursementSignatory', 'pprs', 'pprs."reimbursement" = $1."reimbursement"', 'PostProjectReimbursement', 'ppr', 'ppr.id = $1."reimbursement"');


--
-- Name: projectproposalsignatory after_update_ProjectProposalSignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposalSignatory_completion" AFTER UPDATE ON projectproposalsignatory FOR EACH ROW WHEN ((new.status = 4)) EXECUTE PROCEDURE "trigger_after_update_ProjectProposalSignatory_counter"();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_facultyAdviser; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_facultyAdviser" AFTER UPDATE ON projectproposal FOR EACH ROW WHEN ((((old.facultyadviser IS NULL) AND (new.facultyadviser IS NOT NULL)) OR ((old.facultyadviser IS NOT NULL) AND (new.facultyadviser IS NULL)) OR (old.facultyadviser <> new.facultyadviser))) EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_facultyAdviser"();


--
-- Name: projectproposal after_update_ProjectProposal_signatory_immediateSuperior; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "after_update_ProjectProposal_signatory_immediateSuperior" AFTER UPDATE ON projectproposal FOR EACH ROW WHEN (((old.preparedby IS NULL) OR (old.preparedby <> new.preparedby))) EXECUTE PROCEDURE "trigger_after_update_ProjectProposal_signatory_immediateSuperio"();


--
-- Name: gosm after_update_gosm_studentorganization; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_update_gosm_studentorganization AFTER UPDATE ON gosm FOR EACH ROW WHEN ((old.studentorganization <> new.studentorganization)) EXECUTE PROCEDURE trigger_after_update_gosm_studentorganization();


--
-- Name: projectproposalsignatory after_update_projectproposalsignatory_completion; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_update_projectproposalsignatory_completion AFTER UPDATE ON projectproposalsignatory FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE "trigger_after_update_ProjectProposalSignatory_completion"();


--
-- Name: AccountNotification before_insert_AccountNotification; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_AccountNotification" BEFORE INSERT ON "AccountNotification" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_increment_sequence('AccountNotification', 'an', 'an."account" = $1."account"');


--
-- Name: ActivityPublicity before_insert_ActivityPublicity_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityPublicity_sequence" BEFORE INSERT ON "ActivityPublicity" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_sequence_versioning('ActivityPublicity', 'ap', 'ap."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: ActivityResearchForm before_insert_ActivityResearchForm_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_ActivityResearchForm_sequence" BEFORE INSERT ON "ActivityResearchForm" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_increment_sequence('ActivityResearchForm', 'arf', 'arf."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PostProjectBookTransfer before_insert_PostProjectBookTransfer_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectBookTransfer_sequence" BEFORE INSERT ON "PostProjectBookTransfer" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_sequence_versioning('PostProjectBookTransfer', 'ppbt', 'ppbt."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PostProjectDirectPayment before_insert_PostProjectDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectDirectPayment_sequence" BEFORE INSERT ON "PostProjectDirectPayment" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectDirectPayment_sequence"();


--
-- Name: PostProjectProposalEventPicture before_insert_PostProjectProposalEventPicture_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalEventPicture_sequence" BEFORE INSERT ON "PostProjectProposalEventPicture" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalEventPicture_sequence"();


--
-- Name: PostProjectProposalExpense before_insert_PostProjectProposalExpense_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectProposalExpense_sequence" BEFORE INSERT ON "PostProjectProposalExpense" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PostProjectProposalExpense_sequence"();


--
-- Name: PostProjectReimbursement before_insert_PostProjectReimbursement_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PostProjectReimbursement_sequence" BEFORE INSERT ON "PostProjectReimbursement" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_sequence_versioning('PostProjectReimbursement', 'pprojr', '"pprojr"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityBookTransfer before_insert_PreActivityBookTransfer; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityBookTransfer" BEFORE INSERT ON "PreActivityBookTransfer" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_sequence_versioning('PreActivityBookTransfer', 'pabt', '"pabt"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityCashAdvance before_insert_PreActivityCashAdvance_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityCashAdvance_sequence" BEFORE INSERT ON "PreActivityCashAdvance" FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_sequence_versioning('PreActivityCashAdvance', 'paca', '"paca"."GOSMActivity" = $1."GOSMActivity"');


--
-- Name: PreActivityDirectPayment before_insert_PreActivityDirectPayment_sequence; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER "before_insert_PreActivityDirectPayment_sequence" BEFORE INSERT ON "PreActivityDirectPayment" FOR EACH ROW EXECUTE PROCEDURE "trigger_before_insert_PreActivityDirectPayment_sequence"();


--
-- Name: account before_insert_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_account BEFORE INSERT ON account FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_account();


--
-- Name: functionality before_insert_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionality BEFORE INSERT ON functionality FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_functionality();


--
-- Name: functionalitycategory before_insert_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_functionalitycategory BEFORE INSERT ON functionalitycategory FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_functionalitycategory();


--
-- Name: gosm before_insert_ggosm; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_ggosm BEFORE INSERT ON gosm FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_gosm();


--
-- Name: gosmactivity before_insert_gosmactivity; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_gosmactivity BEFORE INSERT ON gosmactivity FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_gosmactivity();


--
-- Name: organizationrole before_insert_organizationrole; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_organizationrole BEFORE INSERT ON organizationrole FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_organizationrole();


--
-- Name: projectproposalattachment before_insert_projectproposalattachment; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalattachment BEFORE INSERT ON projectproposalattachment FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalattachment();


--
-- Name: projectproposalexpenses before_insert_projectproposalexpenses; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalexpenses BEFORE INSERT ON projectproposalexpenses FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalexpenses();


--
-- Name: projectproposalprogramdesign before_insert_projectproposalprogramdesign; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprogramdesign BEFORE INSERT ON projectproposalprogramdesign FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalprogramdesign();


--
-- Name: projectproposalprojectedincome before_insert_projectproposalprojectedincome; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalprojectedincome BEFORE INSERT ON projectproposalprojectedincome FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalprojectedincome();


--
-- Name: projectproposalsourcefunds before_insert_projectproposalsourcefunds; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_projectproposalsourcefunds BEFORE INSERT ON projectproposalsourcefunds FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_projectproposalsourcefunds();


--
-- Name: schoolyear before_insert_schoolyear; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_schoolyear BEFORE INSERT ON schoolyear FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_schoolyear();


--
-- Name: term before_insert_term; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_insert_term BEFORE INSERT ON term FOR EACH ROW EXECUTE PROCEDURE trigger_before_insert_term();


--
-- Name: account before_update_account; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_account BEFORE UPDATE ON account FOR EACH ROW EXECUTE PROCEDURE trigger_before_update_account();


--
-- Name: functionality before_update_functionality; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionality BEFORE UPDATE ON functionality FOR EACH ROW WHEN (((old.category <> new.category) OR (old.category IS NULL))) EXECUTE PROCEDURE trigger_before_update_functionality();


--
-- Name: functionalitycategory before_update_functionalitycategory; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_functionalitycategory BEFORE UPDATE ON functionalitycategory FOR EACH ROW WHEN (((old.domain <> new.domain) OR (old.domain IS NULL))) EXECUTE PROCEDURE trigger_before_update_functionalitycategory();


--
-- Name: gosm before_update_gosm_status; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_gosm_status BEFORE UPDATE ON gosm FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_before_update_gosm_status();


--
-- Name: projectproposal before_update_projectproposal; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER before_update_projectproposal BEFORE UPDATE ON projectproposal FOR EACH ROW WHEN ((old.status <> new.status)) EXECUTE PROCEDURE trigger_before_update_projectproposal();


--
-- Name: AccountNotification AccountNotification_account_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_account_fkey" FOREIGN KEY (account) REFERENCES account(idnumber);


--
-- Name: AccountNotification AccountNotification_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "AccountNotification"
    ADD CONSTRAINT "AccountNotification_status_fkey" FOREIGN KEY (status) REFERENCES "AccountNotificationStatus"(id);


--
-- Name: ActivityPublicity ActivityPublicity_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: ActivityPublicity ActivityPublicity_checkedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_checkedBy_fkey" FOREIGN KEY ("checkedBy") REFERENCES account(idnumber);


--
-- Name: ActivityPublicity ActivityPublicity_material_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_material_fkey" FOREIGN KEY (material) REFERENCES "ActivityPublicityMaterial"(id);


--
-- Name: ActivityPublicity ActivityPublicity_modeOfDistribution_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_modeOfDistribution_fkey" FOREIGN KEY ("modeOfDistribution") REFERENCES "ActivityPublicityModeOfDistribution"(id);


--
-- Name: ActivityPublicity ActivityPublicity_revisionReason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_revisionReason_fkey" FOREIGN KEY ("revisionReason") REFERENCES "ActivityPublicityRevisionReason"(id);


--
-- Name: ActivityPublicity ActivityPublicity_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_status_fkey" FOREIGN KEY (status) REFERENCES "ActivityPublicityStatus"(id);


--
-- Name: ActivityPublicity ActivityPublicity_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityPublicity"
    ADD CONSTRAINT "ActivityPublicity_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: ActivityResearchForm ActivityResearchForm_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: ActivityResearchForm ActivityResearchForm_positionInOrganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityResearchForm"
    ADD CONSTRAINT "ActivityResearchForm_positionInOrganization_fkey" FOREIGN KEY ("positionInOrganization") REFERENCES "ARFOrganizationPosition"(id);


--
-- Name: ActivityVenue ActivityVenue_building_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_building_fkey" FOREIGN KEY (building) REFERENCES "Building"(id);


--
-- Name: ActivityVenue ActivityVenue_rateType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_rateType_fkey" FOREIGN KEY ("rateType") REFERENCES "RateType"(id);


--
-- Name: ActivityVenue ActivityVenue_size_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ActivityVenue"
    ADD CONSTRAINT "ActivityVenue_size_fkey" FOREIGN KEY (size) REFERENCES "VenueSize"(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_document_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_document_fkey" FOREIGN KEY (document) REFERENCES documentattachmentrequirement(id);


--
-- Name: ExpenseTypeAttachmentRequirement ExpenseTypeAttachmentRequirement_expenseType_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ExpenseTypeAttachmentRequirement"
    ADD CONSTRAINT "ExpenseTypeAttachmentRequirement_expenseType_fkey" FOREIGN KEY ("expenseType") REFERENCES expensetype(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_member_fkey" FOREIGN KEY (member) REFERENCES "OrganizationMember"(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_organizationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES studentorganization(id);


--
-- Name: MemberSurveyForm MemberSurveyForm_termID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "MemberSurveyForm"
    ADD CONSTRAINT "MemberSurveyForm_termID_fkey" FOREIGN KEY ("termID") REFERENCES term(id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_officer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_officer_fkey" FOREIGN KEY (officer) REFERENCES account(idnumber);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_organizationID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_organizationID_fkey" FOREIGN KEY ("organizationID") REFERENCES studentorganization(id);


--
-- Name: OfficerSurveyForm OfficerSurveyForm_termID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OfficerSurveyForm"
    ADD CONSTRAINT "OfficerSurveyForm_termID_fkey" FOREIGN KEY ("termID") REFERENCES term(id);


--
-- Name: OrganizationMember OrganizationMember_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_organization_fkey" FOREIGN KEY (organization) REFERENCES studentorganization(id);


--
-- Name: OrganizationMember OrganizationMember_yearID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "OrganizationMember"
    ADD CONSTRAINT "OrganizationMember_yearID_fkey" FOREIGN KEY ("yearID") REFERENCES schoolyear(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES "PostProjectBookTransfer"(id);


--
-- Name: PostProjectBookTransferParticular PostProjectBookTransferParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransferParticular"
    ADD CONSTRAINT "PostProjectBookTransferParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectBookTransfer PostProjectBookTransfer_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectBookTransfer"
    ADD CONSTRAINT "PostProjectBookTransfer_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectBookTransferStatus"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PostProjectDirectPayment"(id);


--
-- Name: PostProjectDirectPaymentParticular PostProjectDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPaymentParticular"
    ADD CONSTRAINT "PostProjectDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_paymentBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_paymentBy_fkey" FOREIGN KEY ("paymentBy") REFERENCES "PostProjectDirectPaymentPayment"(id);


--
-- Name: PostProjectDirectPayment PostProjectDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectDirectPayment"
    ADD CONSTRAINT "PostProjectDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectDirectPaymentStatus"(id);


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalEventPicture PostProjectProposalEventPicture_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalEventPicture"
    ADD CONSTRAINT "PostProjectProposalEventPicture_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES "PostProjectProposal"("GOSMActivity");


--
-- Name: PostProjectProposalExpense PostProjectProposalExpense_idNumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposalExpense"
    ADD CONSTRAINT "PostProjectProposalExpense_idNumber_fkey" FOREIGN KEY ("idNumber") REFERENCES account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PostProjectProposal PostProjectProposal_preparedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_preparedBy_fkey" FOREIGN KEY ("preparedBy") REFERENCES account(idnumber);


--
-- Name: PostProjectProposal PostProjectProposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectProposal"
    ADD CONSTRAINT "PostProjectProposal_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectProposalStatus"(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PostProjectReimbursementParticular PostProjectReimbursementParticular_reimbursement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementParticular"
    ADD CONSTRAINT "PostProjectReimbursementParticular_reimbursement_fkey" FOREIGN KEY (reimbursement) REFERENCES "PostProjectReimbursement"(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_reimbursement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_reimbursement_fkey" FOREIGN KEY (reimbursement) REFERENCES "PostProjectReimbursement"(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PostProjectReimbursementSignatory PostProjectReimbursementSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursementSignatory"
    ADD CONSTRAINT "PostProjectReimbursementSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_status_fkey" FOREIGN KEY (status) REFERENCES "PostProjectReimbursementStatus"(id);


--
-- Name: PostProjectReimbursement PostProjectReimbursement_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PostProjectReimbursement"
    ADD CONSTRAINT "PostProjectReimbursement_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES "PreActivityBookTransfer"(id);


--
-- Name: PreActivityBookTransferParticular PreActivityBookTransferParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferParticular"
    ADD CONSTRAINT "PreActivityBookTransferParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_bookTransfer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_bookTransfer_fkey" FOREIGN KEY ("bookTransfer") REFERENCES "PreActivityBookTransfer"(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PreActivityBookTransferSignatory PreActivityBookTransferSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransferSignatory"
    ADD CONSTRAINT "PreActivityBookTransferSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES gosmactivity(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_establishment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_establishment_fkey" FOREIGN KEY (establishment) REFERENCES "BookTransferEstablishment"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_status_fkey" FOREIGN KEY (status) REFERENCES "PreActivityBookTransferStatus"(id);


--
-- Name: PreActivityBookTransfer PreActivityBookTransfer_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityBookTransfer"
    ADD CONSTRAINT "PreActivityBookTransfer_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES "PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceParticular PreActivityCashAdvanceParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceParticular"
    ADD CONSTRAINT "PreActivityCashAdvanceParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_cashAdvance_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_cashAdvance_fkey" FOREIGN KEY ("cashAdvance") REFERENCES "PreActivityCashAdvance"(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PreActivityCashAdvanceSignatory PreActivityCashAdvanceSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvanceSignatory"
    ADD CONSTRAINT "PreActivityCashAdvanceSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_status_fkey" FOREIGN KEY (status) REFERENCES "PreActivityCashAdvanceStatus"(id);


--
-- Name: PreActivityCashAdvance PreActivityCashAdvance_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityCashAdvance"
    ADD CONSTRAINT "PreActivityCashAdvance_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PreActivityDirectPaymentParticular"(id);


--
-- Name: PreActivityDirectPaymentParticular PreActivityDirectPaymentParticular_particular_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentParticular"
    ADD CONSTRAINT "PreActivityDirectPaymentParticular_particular_fkey" FOREIGN KEY (particular) REFERENCES projectproposalexpenses(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_directPayment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_directPayment_fkey" FOREIGN KEY ("directPayment") REFERENCES "PreActivityDirectPayment"(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_signatory_fkey" FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_status_fkey" FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: PreActivityDirectPaymentSignatory PreActivityDirectPaymentSignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPaymentSignatory"
    ADD CONSTRAINT "PreActivityDirectPaymentSignatory_type_fkey" FOREIGN KEY (type) REFERENCES "FinanceSignatoryType"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_GOSMActivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_GOSMActivity_fkey" FOREIGN KEY ("GOSMActivity") REFERENCES projectproposal(gosmactivity);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_evaluatedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_evaluatedBy_fkey" FOREIGN KEY ("evaluatedBy") REFERENCES account(idnumber);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_status_fkey" FOREIGN KEY (status) REFERENCES "PreActivityDirectPaymentStatus"(id);


--
-- Name: PreActivityDirectPayment PreActivityDirectPayment_submittedBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PreActivityDirectPayment"
    ADD CONSTRAINT "PreActivityDirectPayment_submittedBy_fkey" FOREIGN KEY ("submittedBy") REFERENCES account(idnumber);


--
-- Name: account account_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_status_fkey FOREIGN KEY (status) REFERENCES "AccountStatus"(id);


--
-- Name: account account_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY account
    ADD CONSTRAINT account_type_fkey FOREIGN KEY (type) REFERENCES accounttype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: activityattachmentrequirement activityattachmentrequirement_attachment_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activityattachmentrequirement
    ADD CONSTRAINT activityattachmentrequirement_attachment_fkey FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: amtactivityevaluation amtactivityevaluation_activity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_activity_fkey FOREIGN KEY (activity) REFERENCES projectproposal(gosmactivity);


--
-- Name: amtactivityevaluation amtactivityevaluation_evaluator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_evaluator_fkey FOREIGN KEY (evaluator) REFERENCES account(idnumber);


--
-- Name: amtactivityevaluation amtactivityevaluation_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY amtactivityevaluation
    ADD CONSTRAINT amtactivityevaluation_status_fkey FOREIGN KEY (status) REFERENCES amtactivityevaluationstatus(id);


--
-- Name: functionality functionality_category_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionality
    ADD CONSTRAINT functionality_category_fkey FOREIGN KEY (category) REFERENCES functionalitycategory(id) ON UPDATE CASCADE;


--
-- Name: functionalitycategory functionalitycategory_domain_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY functionalitycategory
    ADD CONSTRAINT functionalitycategory_domain_fkey FOREIGN KEY (domain) REFERENCES functionalitydomain(id) ON UPDATE CASCADE;


--
-- Name: gosm gosm_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES account(idnumber);


--
-- Name: gosm gosm_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_status_fkey FOREIGN KEY (status) REFERENCES gosmstatus(id);


--
-- Name: gosm gosm_statusevaluator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_statusevaluator_fkey FOREIGN KEY (statusevaluator) REFERENCES account(idnumber);


--
-- Name: gosm gosm_studentorganization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosm
    ADD CONSTRAINT gosm_studentorganization_fkey FOREIGN KEY (studentorganization) REFERENCES studentorganization(id) ON UPDATE CASCADE;


--
-- Name: gosmactivity gosmactivity_activitynature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_activitynature_fkey FOREIGN KEY (activitynature) REFERENCES activitynature(id);


--
-- Name: gosmactivity gosmactivity_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: gosmactivity gosmactivity_gosm_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivity
    ADD CONSTRAINT gosmactivity_gosm_fkey FOREIGN KEY (gosm) REFERENCES gosm(id) ON UPDATE CASCADE;


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_activityid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_activityid_fkey FOREIGN KEY (activityid) REFERENCES gosmactivity(id);


--
-- Name: gosmactivityprojecthead gosmactivityprojecthead_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY gosmactivityprojecthead
    ADD CONSTRAINT gosmactivityprojecthead_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: organizationaccesscontrol organizationaccesscontrol_functionality_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_functionality_fkey FOREIGN KEY (functionality) REFERENCES functionality(id) ON UPDATE CASCADE;


--
-- Name: organizationaccesscontrol organizationaccesscontrol_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationaccesscontrol
    ADD CONSTRAINT organizationaccesscontrol_role_fkey FOREIGN KEY (role) REFERENCES organizationrole(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_faculty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_faculty_fkey FOREIGN KEY (faculty) REFERENCES account(idnumber);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_organization_fkey FOREIGN KEY (organization) REFERENCES studentorganization(id);


--
-- Name: organizationfacultyadviser organizationfacultyadviser_yearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationfacultyadviser
    ADD CONSTRAINT organizationfacultyadviser_yearid_fkey FOREIGN KEY (yearid) REFERENCES schoolyear(id);


--
-- Name: organizationofficer organizationofficer_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: organizationofficer organizationofficer_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_role_fkey FOREIGN KEY (role) REFERENCES organizationrole(id);


--
-- Name: organizationofficer organizationofficer_yearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationofficer
    ADD CONSTRAINT organizationofficer_yearid_fkey FOREIGN KEY (yearid) REFERENCES schoolyear(id);


--
-- Name: organizationrole organizationrole_masterrole_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_masterrole_fkey FOREIGN KEY (masterrole) REFERENCES organizationrole(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: organizationrole organizationrole_organization_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY organizationrole
    ADD CONSTRAINT organizationrole_organization_fkey FOREIGN KEY (organization) REFERENCES studentorganization(id) ON UPDATE CASCADE;


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: postactivityattachmentrequirement postactivityattachmentrequirement_documentattachmentrequirement; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY postactivityattachmentrequirement
    ADD CONSTRAINT postactivityattachmentrequirement_documentattachmentrequirement FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_activitytype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_activitytype_fkey FOREIGN KEY (activitytype) REFERENCES activitytype(id);


--
-- Name: preactivityattachmentrequirement preactivityattachmentrequirement_documentattachmentrequirement_; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY preactivityattachmentrequirement
    ADD CONSTRAINT preactivityattachmentrequirement_documentattachmentrequirement_ FOREIGN KEY (attachment) REFERENCES documentattachmentrequirement(id);


--
-- Name: projectproposal projectproposal_facultyadviser_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_facultyadviser_fkey FOREIGN KEY (facultyadviser) REFERENCES account(idnumber);


--
-- Name: projectproposal projectproposal_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES gosmactivity(id);


--
-- Name: projectproposal projectproposal_preparedby_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_preparedby_fkey FOREIGN KEY (preparedby) REFERENCES account(idnumber);


--
-- Name: projectproposal projectproposal_reschedulereason_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_reschedulereason_fkey FOREIGN KEY (reschedulereason) REFERENCES projectproposalreschedulereason(id);


--
-- Name: projectproposal projectproposal_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_status_fkey FOREIGN KEY (status) REFERENCES projectproposalstatus(id);


--
-- Name: projectproposal projectproposal_venue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposal
    ADD CONSTRAINT projectproposal_venue_fkey FOREIGN KEY (venue) REFERENCES "ActivityVenue"(id);


--
-- Name: projectproposalattachment projectproposalattachment_idnumber_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_idnumber_fkey FOREIGN KEY (idnumber) REFERENCES account(idnumber);


--
-- Name: projectproposalattachment projectproposalattachment_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalattachment projectproposalattachment_requirement_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalattachment
    ADD CONSTRAINT projectproposalattachment_requirement_fkey FOREIGN KEY (requirement) REFERENCES documentattachmentrequirement(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalexpenses projectproposalexpenses_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalexpenses
    ADD CONSTRAINT projectproposalexpenses_type_fkey FOREIGN KEY (type) REFERENCES expensetype(id);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_personincharge_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_personincharge_fkey FOREIGN KEY (personincharge) REFERENCES account(idnumber);


--
-- Name: projectproposalprogramdesign projectproposalprogramdesign_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesign
    ADD CONSTRAINT projectproposalprogramdesign_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_programdesign_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_programdesign_fkey FOREIGN KEY (programdesign) REFERENCES projectproposalprogramdesign(id);


--
-- Name: projectproposalprogramdesignpersonincharge projectproposalprogramdesignpersonincharge_projecthead_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprogramdesignpersonincharge
    ADD CONSTRAINT projectproposalprogramdesignpersonincharge_projecthead_fkey FOREIGN KEY (projecthead) REFERENCES account(idnumber);


--
-- Name: projectproposalprojectedincome projectproposalprojectedincome_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalprojectedincome
    ADD CONSTRAINT projectproposalprojectedincome_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_gosmactivity_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_gosmactivity_fkey FOREIGN KEY (gosmactivity) REFERENCES projectproposal(gosmactivity);


--
-- Name: projectproposalsignatory projectproposalsignatory_signatory_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_signatory_fkey FOREIGN KEY (signatory) REFERENCES account(idnumber);


--
-- Name: projectproposalsignatory projectproposalsignatory_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_status_fkey FOREIGN KEY (status) REFERENCES signatorystatus(id);


--
-- Name: projectproposalsignatory projectproposalsignatory_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsignatory
    ADD CONSTRAINT projectproposalsignatory_type_fkey FOREIGN KEY (type) REFERENCES signatorytype(id);


--
-- Name: projectproposalsourcefunds projectproposalsourcefunds_projectproposal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projectproposalsourcefunds
    ADD CONSTRAINT projectproposalsourcefunds_projectproposal_fkey FOREIGN KEY (projectproposal) REFERENCES projectproposal(id);


--
-- Name: studentorganization studentorganization_cluster_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_cluster_fkey FOREIGN KEY (cluster) REFERENCES organizationcluster(id);


--
-- Name: studentorganization studentorganization_college_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_college_fkey FOREIGN KEY (college) REFERENCES college(shortacronym);


--
-- Name: studentorganization studentorganization_nature_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_nature_fkey FOREIGN KEY (nature) REFERENCES organizationnature(id);


--
-- Name: studentorganization studentorganization_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY studentorganization
    ADD CONSTRAINT studentorganization_status_fkey FOREIGN KEY (status) REFERENCES studentorganization(id);


--
-- Name: term term_schoolyearid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_schoolyearid_fkey FOREIGN KEY (schoolyearid) REFERENCES schoolyear(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

