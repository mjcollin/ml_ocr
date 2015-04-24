CREATE TABLE
  data_labels
SELECT
  h.id, h.occid, h.text,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.country)), r.country, NULL) as in_country,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.stateProvince)), r.stateProvince, NULL) as in_stateProvince,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.county)), r.county, NULL) as in_county,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.locality)), r.locality, NULL) as in_locality,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.family)), r.family, NULL) as in_family,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.genus)), r.genus, NULL) as in_genus,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.specificEpithet)), r.specificEpithet, NULL) as in_specificEpithet,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.sciname)), r.sciname, NULL) as in_sciname,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.catalogNumber)), r.catalogNumber, NULL) as in_catalogNumber,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.recordedBy)), r.recordedBy, NULL) as in_recordedBy,
  if(LOCATE(TRIM(UPPER(h.text)), UPPER(r.recordNumber)), r.recordNumber, NULL) as in_recordNumber
FROM
  hocr_results h JOIN ocred_records_raw r ON h.occid = r.occid
WHERE
  LENGTH(h.text) > 1
;









/*
CREATE TABLE data_labels(
  id INT AUTO_INCREMENT PRIMARY KEY,
  hocr_results_id INT,
  occid INT,
  text VARCHAR(255) CHARACTER SET utf8,
  country VARCHAR(255) CHARACTER SET utf8,
  stateProvince VARCHAR(255) CHARACTER SET utf8,
  county VARCHAR(255) CHARACTER SET utf8,
  locality VARCHAR(255) CHARACTER SET utf8,
  family VARCHAR(255) CHARACTER SET utf8,
  genus VARCHAR(255) CHARACTER SET utf8,
  specificEpithet VARCHAR(255) CHARACTER SET utf8,
  sciname VARCHAR(255) CHARACTER SET utf8,
  catalogNumber VARCHAR(255) CHARACTER SET utf8,
  recordedBy VARCHAR(255) CHARACTER SET utf8,
  recordNumber VARCHAR(255) CHARACTER SET utf8,
);
CREATE INDEX IF NOT EXISTS hocr_results_id_idx ON data_labels(hocr_results_id);
*/
