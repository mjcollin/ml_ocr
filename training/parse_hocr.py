#!/usr/bin/python
#
# HOCR spec: https://docs.google.com/a/badmatt.com/document/d/1QQnIQtvdAC_8n92-LhwPcjtAUFwBlzE8EWnKAxlgVf0/previewhttps://docs.google.com/a/badmatt.com/document/d/1QQnIQtvdAC_8n92-LhwPcjtAUFwBlzE8EWnKAxlgVf0/preview
#

from bs4 import BeautifulSoup

def parse_title(title):
    start = title.find("bbox ") + 5
    end = title.find(";")
    if end < 0: end = len(title)
    s = title[start:end].split()
    #print start, end, s
    return {"x0": s[0], "y0": s[1], "x1": s[2], "y1": s[3]}

soup = BeautifulSoup(open("images/NY01406176_lg.xml"), "xml")

for a in soup.find_all(class_="ocr_carea"):
    #print a["title"]
    bbox_area = parse_title(a["title"])
    lines = a.find_all(class_="ocr_line")
    for l in lines:
        #print l["title"]
        bbox_line = parse_title(l["title"])
	words = l.find_all(class_="ocrx_word")
        for w in words:
            #print w["title"]
            bbox_word = parse_title(w["title"])
            word_dict = { "area_id": a["id"],
                          "line_id": l["id"],
                          "word_id": w["id"],
                          "text": w.get_text(),
                          "area_x0": bbox_area["x0"],
                          "area_y0": bbox_area["y0"],
                          "area_x1": bbox_area["x1"],
                          "area_y1": bbox_area["y1"],
                          "line_x0": bbox_line["x0"],
                          "line_y0": bbox_line["y0"],
                          "line_x1": bbox_line["x1"],
                          "line_y1": bbox_line["y1"],
                          "word_x0": bbox_word["x0"],
                          "word_y0": bbox_word["x1"],
                          "word_x1": bbox_word["y0"],
                          "word_y1": bbox_word["y1"]
                        }
            print word_dict
