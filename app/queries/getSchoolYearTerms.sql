SELECT id, schoolyearid, "number", datestart, dateend
  FROM public.term
 WHERE schoolyearid=${yearid};
