#!/usr/bin/env python

import os

required_attributes = set(["name", "description", "canAnswerQuestion", "answerQuestion"])

def check(modulename):
    module = __import__(modulename)
    keys= set(module.__dict__.keys())

    if required_attributes.issubset(keys):
        return module
    else:
        return None

def find_modules(path):

    modules = []

    files = os.listdir(path)
    i = 0
    for file in files:
        if file.endswith(".py") and not file.startswith("__"):
            name = file.rsplit('.', 1)[0]
            #print name
            module = check(name)
            if module:
                #print "Found", module
                modules.append(module)
    return modules


if __name__ == "__main__":
    print "Run pluginloader"
    find_modules('.')


