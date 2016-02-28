#! /usr/bin/env python
# -*- coding: UTF-8 -*-

from BeautifulSoup import BeautifulSoup
import urllib2
import json
import re
import sys


# same param as you enter in the 'limit' textfield on the matchbox page
# don't make too big, it will make parsing slow
lineLimit = 10
url = "https://matchbox.rd.tandberg.com?limit={0}".format(lineLimit)


# Standard pig service questions:

def name():
    return "Matchbox status"

def description():
    return """Gives matchbox status for select products. Syntax:
    All product groups: 'Matchbox status'
    One product group:  'Matchbox status charlie'
    Several product groups: 'Matchbox status charlie endeavour'
    """

validator = re.compile(r"matchbox status.*")
def canAnswerQuestion(question):
    return validator.search(question.lower())

html_template = """
<div id='{0}'>
    <div class='product'>{0}</div>
    <div class='status'>{1}</div>
</div>
"""

def answerQuestion(question, format="text"):
    question = question.lower()
    question = question.replace("matchbox status", "").replace(",", " ").strip()
    #print "question:'",question.strip() ,"'"
    groups = question.split(" ") if len(question) > 0 else allGroups()

    allgroups = allGroups()

    result = {}
    dom = getDom(url)
    for g in groups:
        if g in allgroups:
            #print g, lookForGroupStatus(dom, g)
            result[g] = (lookForGroupStatus(dom, g))


    if (format == "json"):
        result = formatJson(result)
    elif (format == "html"):
        result = formatHtml(result)
    else:
        result = formatText(result)
    return result

def formatHtml(result):
    html = []
    for k,v in result.iteritems():
        html.append(html_template.format(k, v))
    return "".join(html)

def formatText(result):
    text = []
    for k, v in result.iteritems():
        text.append(k + "=" + v)
    return "Status: " + ", ".join(text)

def formatJson(result):
    return json.dumps(result, sort_keys=True, indent=4)


class Status:
    OK = "OK"
    FAIL = "FAIL"
    PENDING = "PENDING"
    UNKNOWN = "UNKNOWN"

# = NOT PENDING
def statusIsDetermined(status):
    return status in [Status.OK, Status.FAIL]

def textToStatus(text):
    text2 = text.lower()
    if text2.find('fail') > -1 or text2.find('problem') > 1:
        return Status.FAIL
    if text2.find('ok') > 1:
        return Status.OK
    if text.find('NA') > 1:
        return Status.PENDING

    #print "Warning: Unknown status '{0}' found".format(text)
    return UNKNOWN

def getDom(url):
    page = urllib2.urlopen(url)
    soup = BeautifulSoup(page)
    return soup
	
def lookForGroupStatus(dom, productGroup):
    allproducts = dom.findAll("span", "productname")
    nodes = [ (node.text, textToStatus(node.parent['class'])) for node in allproducts if node.text.strip() == productGroup]
    nodes = [node for node in nodes if statusIsDetermined(node[1])]

    status = nodes[0][1] if len(nodes) > 0 else Status.UNKNOWN

    return status

def allGroups():
    # found just by inspecting matchbox. may be more:
    return ["asterix", "carbon", "charlie", "endeavour", "gk", "halley", "helmet", "oak", "marcie", "module", "saturn", "skeleton", "snoopy", "testapps"]

def test():
    groups = allGroups() if len(sys.argv) < 2 else [ sys.argv[1] ]

    for g in groups:
        print g, lookForGroupStatus(getDom(url), g)

    #print json.dumps(data, sort_keys=True, indent=4)
	
if (__name__ == "__main__"):
	test()
	

 
