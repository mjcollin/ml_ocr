/*
Join up results into an input set for training.
DISTINCT gets rid of duplicate that have cropped up somewhere (need real QC)
> 0 gets rid of cases where it looks like there are multiple images for an 
occid in the raw results and the images are different sizes, will still
have this happen and it's unknowable with proper QC but at least this gets rid
of the obvious things like:
select distinct url from ocred_records_raw where occid=499787;

*/

CREATE TABLE
  input
SELECT DISTINCT
  l.id, l.occid, l.text, l.label,
  -- r.word_x0, r.word_y0, r.word_x1, r.word_y1,
  -- e.min_word_y0, e.max_word_y1, 
  (r.area_x0 - e.min_area_x0) / (e.max_area_x1 - e.min_area_x0) as scaled_area_x0,
  (r.area_y0 - e.min_area_y0) / (e.max_area_y1 - e.min_area_y0) as scaled_area_y0,
  (r.line_x0 - e.min_line_x0) / (e.max_line_x1 - e.min_line_x0) as scaled_line_x0,
  (r.line_y0 - e.min_line_y0) / (e.max_line_y1 - e.min_line_y0) as scaled_line_y0,
  (r.word_x0 - e.min_word_x0) / (e.max_word_x1 - e.min_word_x0) as scaled_word_x0,
  (r.word_y0 - e.min_word_y0) / (e.max_word_y1 - e.min_word_y0) as scaled_word_y0
FROM
  word_label l 
  JOIN text_extent e
  JOIN hocr_results r
  ON
  l.occid = e.occid
  AND l.id = r.id
WHERE
  -- l.occid = 499787
  -- AND l.text = 'JOHN'
  -- l.occid = 904652
  -- AND l.text = 'Richard'
  l.label IS NOT NULL
;
