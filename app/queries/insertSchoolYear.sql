INSERT INTO public.schoolyear(
            startyear, endyear)
    VALUES (${startyear}, ${endyear})
RETURNING id;
