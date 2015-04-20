#!/usr/bin/python
#
# Download images, OCR them, and insert the results in MySQL table
#

import MySQLdb
import os.path
import urllib
from subprocess import call
from parse_hocr import parse_hocr

dest = "/root/mlproject/training"

user = "benchmark"
passwd = "benchmark"
db = "mlproject"
source_db = "symblichens"

db = MySQLdb.connect(host="localhost",
                     user=user,
                     passwd=passwd,
                     db="mlproject",
                     charset='utf8',
                     use_unicode=True)
cur = db.cursor()

sql = 'SELECT r.occid, r.catalogNumber, r.url \
       FROM ocred_records_raw r \
       LEFT JOIN hocr_results h \
       ON r.occid = h.occid \
       WHERE h.occid IS NULL \
       LIMIT 1'

cur.execute(sql)

for rec in cur.fetchall():
    occid = rec[0]
    catalogNumber = rec[1]
    url = rec[2]

    # Mark as processing
    cur.execute("INSERT INTO hocr_results (occid, processed) VALUES (%s, 1);", (occid))
    db.commit()

    img_fn = url.split('/')[-1]
    img_full_fn = dest + "/images/" + img_fn
    hocr_full_fn = dest + "/hocr/" + img_fn.split('.')[0]
    if not os.path.isfile(img_full_fn): 
        try:
            resp = urllib.urlretrieve(url, filename=img_full_fn)
            call(["tesseract", img_full_fn, hocr_full_fn, "hocr"])
            parsed = parse_hocr(hocr_full_fn + ".hocr")
            for p in parsed:
		# Why don't you make this an update statement?
#                sql = "INSERT INTO hocr_results \
#                       (occid, occurrenceID, area_id, line_id, word_id, text, \
#                       area_x0, area_y0, area_x1, area_y1, line_x0, line_y0, \
#                       line_x1, line_y1, word_x0, word_y0 ,word_x1, word_y1, \
#                       processed) \
#                       VALUES \
#                       (%(occid)s, %(occurrenceID)s, %(area_id)s, %(line_id)s, %(word_id)s, %(text)s, \
#                       %(area_x0)s, %(area_y0)s, %(area_x1)s, %(area_y1)s, %(line_x0)s, %(line_y0)s, \
#                       %(line_x1)s, %(line_y1)s, %(word_x0)s, %(word_y0)s ,%(word_x1)s, %(word_y1)s, \
#                       %(processed)s) \
#                      "
#                cur.execute(sql, p.update({"occid":occid, "occurrenceID":occurrenceID, "processed":2}))
                sql = """UPDATE hocr_results
                         SET
                         processed=2, catalogNumber=%s, area_id=%s, line_id=%s, 
                         word_id=%s, text=%s, area_x0=%s, area_y0=%s, area_x1=%s, area_y1=%s,
                         line_x0=%s, line_y0=%s, line_x1=%s, line_y1=%s, word_x0=%s, 
                         word_y0=%s, word_x1=%s, word_y1=%s
                         WHERE occid=%s
                      """
                cur.execute(sql, (catalogNumber, p["area_id"], p["line_id"], \
                            p["word_id"], p["text"], p["area_x0"], p["area_y0"], p["area_x1"], p["area_y1"], \
                            p["line_x0"], p["line_y0"], p["line_x1"], p["line_y1"], p["word_x0"], \
                            p["word_y0"], p["word_x1"], p["word_y1"], occid))
		db.commit()
        except:
            raise


cur.close()
db.close()
