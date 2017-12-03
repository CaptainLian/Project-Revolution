UPDATE public.projectproposal
   SET isattachmentscomplete=${attachments}, status=${status},
       isbriefcontextcomplete=${context}, isexpensecomplete=${expense}, isprogramcomplete=${sched}
 WHERE gosmactivity=${gosmactivity};
