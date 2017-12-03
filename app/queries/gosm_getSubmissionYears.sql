SELECT DISTINCT endYear AS endYear, endYear - 1 AS startYear
  FROM GOSM g
 ORDER BY endYear DESC;