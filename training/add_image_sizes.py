#!/usr/bin/python
#
# Update hocr_results to add image size
#


import MySQLdb
import glob
from PIL import Image

user = "benchmark"
passwd = "benchmark"
db = "mlproject"

db = MySQLdb.connect(host="localhost",
                     user=user,
                     passwd=passwd,
                     db="mlproject")
cur = db.cursor()

i = 0
for f in glob.glob("images/*"):
    #f = "images/NY01406176_lg.jpg"
    fn = f[7:]
    im = Image.open(f)
    s = im.size

    sql = """
          UPDATE hocr_results
          SET x = %s, y = %s
          WHERE filename = %s
          """
    cur.execute(sql, (s[0], s[1], fn)) 

    if i % 100 == 0:
        db.commit()

    i = i + 1

db.commit()
cur.close()
db.close()
