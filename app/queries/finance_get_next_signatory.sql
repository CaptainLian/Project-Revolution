 /**
  * Takes the parameters:
  * financeTable - What table to query
  * tableAcronym - The alias to give the table, usually the acronym is used
  * column - The column used for comparison, usually the "parent" primary key 
  * value - the value used for the column comparison
  */
  SELECT *
    FROM "${financeTable}" "${tableAcronym}" LEFT JOIN "FinanceSignatoryType" "fst"
                                                  ON "${tableAcronym}"."type" = "fst"."id"
   WHERE "${tableAcronym}"."status" = 0
     AND ("${tableAcronym}"."${column} = ${value}")
ORDER BY "fst"."lineup" ASC
   LIMIT 1;