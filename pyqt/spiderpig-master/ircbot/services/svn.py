#! /usr/bin/env python

import os, random

# seems to have very non-linear search time based on history size, critical point at around a few thousands:
maxHistory = 2000

def tempfile():
    randomInt = random.randint(1E6, 10E6-1)
    return "{0}/spiderPig{1}.tmp".format(os.getcwd(), randomInt)

def parseData(data):
    lines = data.split('\n')
    i=-1
    txt = ""
    for line in lines:
        if (i > (10*4-2)):
            break
        i = i + 1
        if (i % 4 == 0):
            txt += line.split()[0] + ": "
        elif (i % 4 == 2):
            txt += line + "\n"

    return txt

def get_username(question):
    return question.split()[3]

def latest_revs(question):
    username = get_username(question)
    if (not username):
        return "No svn user specified. Please ask: 'latest revs by <user>'"
    filename = tempfile()
    cmd = "svn log -l {0} svn://svn/system/trunk | grep -A 2 \" {1} \" > {2}".format(maxHistory, username, filename)

    #print cmd
    os.system(cmd)

    file = open(filename, 'r')
    txt = file.read()
    file.close()
    os.remove(filename)
    if (txt.strip()):
        txt = parseData(txt)
    else:
        txt = "No results found for user {0}".format(username)

    return txt


if (__name__ == "__main__"):
    latest_revs("")
