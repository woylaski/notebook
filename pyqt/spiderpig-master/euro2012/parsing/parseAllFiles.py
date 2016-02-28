#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os, sys, json
import parseFile

def parseAllCsvFiles(path):
    files = os.listdir(path)
    result = []
    for file in files:
        if file.endswith(".csv"):
            data = parseFile.parseFile(os.path.join(path, file))
            result.append(data)
    return result

if (__name__ == "__main__"):
    if len(sys.argv) == 2:
        data = parseAllCsvFiles(sys.argv[1])
        print json.dumps(data, indent=4, sort_keys=True)
    else:
        print "Syntax: {} <path>".format(sys.argv[0])

