#!/bin/bash

./select_processed.py
for i in `seq 1 8` ; do ./dl_ocr_parse.py 2>> ocr_${i}.log 1>> ocr_${i}.log & done
