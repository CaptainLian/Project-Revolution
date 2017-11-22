UPDATE public.projectproposal
   SET isattachmentscomplete=${attachments}, 
       isbriefcontextcomplete=${context}, isexpensecomplete=${expense}, isprogramcomplete=${sched}
 WHERE gosmactivity${gosmactivity};
