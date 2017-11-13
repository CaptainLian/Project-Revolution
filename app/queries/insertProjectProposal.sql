INSERT INTO projectproposal(gosmactivity, preparedby)
     VALUES (${gosmactivity}, ${preparedby})
RETURNING id;
