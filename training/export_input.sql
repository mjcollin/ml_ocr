/*
Export what scikitlearn needs as CSV
*/
SELECT
  "id", "label", "scaled_area_x0", "scaled_area_y0",
  "scaled_line_x0", "scaled_line_y0", "scaled_word_x0", "scaled_word_y0"
UNION
SELECT
  id, label, scaled_area_x0, scaled_area_y0, 
  scaled_line_x0, scaled_line_y0, scaled_word_x0, scaled_word_y0
FROM
  input
INTO OUTFILE
  '/tmp/input.csv'
FIELDS TERMINATED BY ','
;
