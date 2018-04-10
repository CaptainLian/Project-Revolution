SELECT id, termid, studentorganization, status, datecreated, datesubmitted, 
       datestatusmodified, preparedby, statusevaluator, comments
  FROM public.gosm
 WHERE TERMID=system_get_current_term_id();
