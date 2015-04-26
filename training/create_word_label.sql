/*
Only words that appear in a single field are going to get labeled.
*/


CREATE TABLE
  word_label
SELECT
  id,
  occid,
  text,
  CASE in_country IS NOT NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'country'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NOT NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'stateProvince'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NOT NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'county'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NOT NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'locality'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NOT NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'family'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NOT NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'genus'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NOT NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'specificEpithet'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NOT NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'sciname'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NOT NULL AND in_recordedBy IS NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'catalogNumber'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NOT NULL AND in_recordNumber IS NULL
  WHEN true THEN
    'recordedBy'
  ELSE
  CASE in_country IS NULL AND in_stateProvince IS NULL AND in_county IS NULL AND in_locality IS NULL AND in_family IS NULL AND in_genus IS NULL AND in_specificEpithet IS NULL AND in_sciname IS NULL AND in_catalogNumber IS NULL AND in_recordedBy IS NULL AND in_recordNumber IS NOT NULL
  WHEN true THEN
    'recordNumber'
  ELSE
    NULL
  END
  END
  END
  END
  END
  END
  END
  END
  END
  END
  END
  as label
FROM
  data_labels
WHERE
 LENGTH(TRIM(text)) > 1
;

CREATE INDEX IF NOT EXISTS word_label_id ON word_label(id);
CREATE INDEX IF NOT EXISTS word_label_occid ON word_label(occid);
