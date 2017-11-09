UPDATE PROJECTPROPOSAL
   SET enp=${enp}, enmp=${enmp}, venue=${venue}, facultyadviser=${adviser}, 
   		context1=${context1}, context2=${context2}, context3=${context3}, isBriefContextComplete=${isBriefContextComplete}
 WHERE id=${id};
