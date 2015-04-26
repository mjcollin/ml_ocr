CREATE TABLE hocr_results(
  id INT AUTO_INCREMENT PRIMARY KEY,
  occid INT,
  catalogNumber VARCHAR(32),
  filename VARCHAR(255),
  processed INT,
  x INT,
  y INT,
  area_id VARCHAR(32),
  line_id VARCHAR(32),
  word_id VARCHAR(32),
  text VARCHAR(255) CHARACTER SET utf8,
  area_x0 INT,
  area_y0 INT,
  area_x1 INT,
  area_y1 INT,
  line_x0 INT,
  line_y0 INT,
  line_x1 INT,
  line_y1 INT,
  word_x0 INT,
  word_y0 INT,
  word_x1 INT,
  word_y1 INT
);
CREATE INDEX IF NOT EXISTS raw_occid ON hocr_results(occid);
CREATE INDEX IF NOT EXISTS hocr_fn ON hocr_results(filename);
