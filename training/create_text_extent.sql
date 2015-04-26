/*
We're going to introduce some data quality here that needs to be
carried through when using this table:
- text with less than 2 characters is skipped
- images with x or y < 100 are skipped
- words who's x0, x1, y0, or y1 are within 10 of the edge of the image
  are skipped
*/

CREATE TABLE
  text_extent
SELECT
  occid,
  min(area_x0) as min_area_x0,
  min(area_y0) as min_area_y0,
  max(area_x1) as max_area_x1,
  max(area_y1) as max_area_y1,
  min(line_x0) as min_line_x0,
  min(line_y0) as min_line_y0,
  max(line_x1) as max_line_x1,
  max(line_y1) as max_line_y1,
  min(word_x0) as min_word_x0,
  min(word_y0) as min_word_y0,
  max(word_x1) as max_word_x1,
  max(word_y1) as max_word_y1
FROM
  hocr_results 
WHERE
  x > 100
  AND y > 100
  AND area_x0 > 10 
  AND area_y0 > 10 
  AND area_x1 < (x - 10)
  AND area_y1 < (y - 10)
  AND line_x0 > 10 
  AND line_y0 > 10 
  AND line_x1 < (x - 10)
  AND line_y1 < (y - 10)
  AND word_x0 > 10 
  AND word_y0 > 10 
  AND word_x1 < (x - 10)
  AND word_y1 < (y - 10)
  AND LENGTH(TRIM(text))>1 
GROUP BY
  occid;

CREATE INDEX IF NOT EXISTS text_extent_occid ON text_extent(occid);
