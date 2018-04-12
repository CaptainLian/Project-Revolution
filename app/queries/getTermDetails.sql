SELECT t.id, schoolyearid, "number", to_char(t.dateStart, 'YYYY-MM-DD') AS "dateStart", 
	   to_char(t.dateEnd, 'YYYY-MM-DD') AS "dateEnd", sy.startyear, sy.endyear
  FROM public.term t JOIN schoolyear sy
  					   ON t.schoolyearid=sy.id
 WHERE t.id=${termid};
