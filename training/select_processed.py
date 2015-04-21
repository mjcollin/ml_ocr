#!/usr/bin/python
#
# Copy OCR'ed and transcribed records from the lichens database into the 
# mlproject database. These are the records we'll use for training.
#


import MySQLdb

user = "benchmark"
passwd = "benchmark"
db = "mlproject"
source_db = "symblichens"

db = MySQLdb.connect(host="localhost",
                     user=user,
                     passwd=passwd,
                     db="mlproject")
cur = db.cursor()

sql = 'CREATE TABLE ocred_records_raw \
       SELECT IFNULL(i.originalurl, i.url) as url, r.rawstr, o.* \
       FROM symblichens.images i INNER JOIN symblichens.specprocessorrawlabels r ON i.imgid = r.imgid \
       INNER JOIN symblichens.omoccurrences o ON i.occid = o.occid \
       WHERE o.processingstatus IS NULL OR o.processingstatus != "unprocessed";'

cur.execute(sql)
db.commit()
