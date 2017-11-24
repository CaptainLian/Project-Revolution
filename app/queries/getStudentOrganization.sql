SELECT id, name, cluster, nature, college, acronym, description, funds, 
       operationalfunds, depositryfunds, path_profilepicture
  FROM public.studentorganization
 WHERE id=${studentorganization};