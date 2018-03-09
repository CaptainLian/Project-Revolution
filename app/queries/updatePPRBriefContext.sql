UPDATE PROJECTPROPOSAL
   SET enp=${enp}, enmp=${enmp}, venue=${venue}, facultyadviser=${adviser}, 
   		context1=${context1}, context2=${context2}, context3=${context3}, isexpense=${isexpense}, isBriefContextComplete=${isBriefContextComplete}
 WHERE id=${id};
