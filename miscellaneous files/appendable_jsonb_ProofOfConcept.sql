CREATE OR REPLACE FUNCTION test()
  RETURNS JSON AS
$BODY$
    DECLARE 
	output TEXT[] DEFAULT '{}';
    BEGIN
	output = output || '{"Aguy", "Gansa"}';
	output = output || '{"MahalMo", true}';
	output = output || '{"MahalKa", false}';
	RETURN jsonb_object(output);
    END;
$BODY$
 LANGUAGE plpgsql;
