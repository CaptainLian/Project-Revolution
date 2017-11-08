INSERT INTO PROJECTPROPOSALATTACHMENT (projectProposal,requirement,directory)
     VALUES (${projectId},${requirement},${dir}) 
         ON CONFLICT (projectProposal,requirement) DO UPDATE 
													     SET directory = ${dir}
