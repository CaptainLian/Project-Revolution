SELECT t.id, t.schoolyearid, t."number", t.datestart, t.dateend, sy.startyear, sy.endyear 
  FROM public.term t JOIN schoolyear sy
  					   ON t.schoolyearid=sy.id
 WHERE schoolyearid=${yearid};
