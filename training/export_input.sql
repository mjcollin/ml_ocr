/*
Export what scikitlearn needs as CSV

> 0 gets rid of cases where it looks like there are multiple images for an
occid in the raw results and the images are different sizes, will still
have this happen and it's unknowable with proper QC but at least this gets rid
of the obvious things like:
select distinct url from ocred_records_raw where occid=499787;

*/
SELECT
  "id", "occid", "text_len", "label", "scaled_area_x0", "scaled_area_y0",
  "scaled_line_x0", "scaled_line_y0", "scaled_word_x0", "scaled_word_y0"
UNION
SELECT
  id, occid, LENGTH(TRIM(text)), label, scaled_area_x0, scaled_area_y0, 
  scaled_line_x0, scaled_line_y0, scaled_word_x0, scaled_word_y0
FROM
  input
WHERE
  scaled_area_x0 >= 0 AND scaled_area_x0 <= 1
  AND scaled_area_y0 >= 0 AND scaled_area_y0 <= 1
  AND scaled_line_x0 >= 0 AND scaled_line_x0 <= 1
  AND scaled_line_y0 >= 0 AND scaled_line_y0 <= 1
  AND scaled_word_x0 >= 0 AND scaled_word_x0 <= 1
  AND scaled_word_y0 >= 0 AND scaled_word_y0 <= 1
INTO OUTFILE
  '/tmp/input.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ','
;
