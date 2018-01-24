INSERT INTO public.term(schoolyearid, "number", datestart, dateend)
     VALUES (${schoolyearid}, ${numberid}, ${datestart}, ${dateend})
ON CONFLICT (schoolyearid, "number") DO UPDATE
SET datestart=${datestart}, dateend=${dateend};