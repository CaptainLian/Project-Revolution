INSERT INTO public.schoolyear(
            startyear, endyear, datestart, dateend)
    VALUES (${startyear}, ${endyear}, ${datestart}, ${dateend})
ON CONFLICT (startyear, endyear) DO UPDATE 
SET datestart = ${datestart}, dateend =${dateend}
RETURNING id;
