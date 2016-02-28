#!/usr/bin/env python

# TODO: Make ip first command line argument (localhost if none)

from bottle import route, run, template, post, static_file, debug, request, redirect, response
import json
import sys
import datetime
import string

developerMode = True

#host = '10.54.65.97'
#host = 'localhost'
host = 'spiderpig.rd.tandberg.com'

port = 8081

@route('/')
def hello():
    return "Hello World!"


@post('/logsubmit')
def logsubmit():

    codecHost = request.forms.get('codecHost')
    codecName = request.forms.get('codecName')
    issueSummary = request.forms.get('issueSummary')
    issueDate = request.forms.get('issueDate')
    issueTime = request.forms.get('issueTime')
    bugId = request.forms.get('bugId')
    idefixIp = request.forms.get('idefixIp')
    idefixLogData = request.forms.get('idefixLogData')

    now = datetime.datetime.now()
    date = now.strftime("%Y-%m-%d-%H%M")

    logFile = 'logs/%s-%s.log.html' % (date, codecHost)
    output_file = open(logFile, 'wb')

    doc = htmlTemplate()
    doc = string.replace(doc, "$codecHost", codecHost)
    doc = string.replace(doc, "$codecName", codecName)
    doc = string.replace(doc, "$issueSummary", issueSummary)
    doc = string.replace(doc, "$issueDate", issueDate)
    doc = string.replace(doc, "$issueTime", issueTime)
    doc = string.replace(doc, "$bugId", bugId)
    doc = string.replace(doc, "$idefixIp", idefixIp)
    doc = string.replace(doc, "$idefixLogData", idefixLogData)

    output_file.write(doc)
    output_file.close()
    print "Save log for ", codecHost, codecName, issueSummary, issueDate, issueTime, bugId, idefixIp
    print "Saved log file %s" % (logFile)
    return logFile


def htmlTemplate():
    html = """
<html>
    <body>
        <h1>Log for $codecHost / $codecName</h1>

        <h2>Meta data:</h2>
        <table border=1>
            <tr>
                <td>codecHost</td>
                <td><a href="http://$codecHost">$codecHost</a></td>
            </tr>
            <tr>
                <td>codecName</td>
                <td>$codecName</td>
            </tr>
            <tr>
                <td>issueSummary</td>
                <td>$issueSummary</td>
            </tr>
            <tr>
                <td>issueDate</td>
                <td>$issueDate</td>
            </tr>
            <tr>
                <td>issueTime</td>
                <td>$issueTime</td>
            </tr>
            <tr>
                <td>bugId</td>
                <td><a href="https://bugs.cisco.com/show_bug.cgi?id=$bugId">$bugId</a></td>
            </tr>
            <tr>
                <td>idefixIp</td>
                <td>$idefixIp</td>
            </tr>
        </table>

        <h2>Idefix Log data</h2>

        <pre>
$idefixLogData
        </pre>
    </body>
</html>
"""
    return html

if (__name__ == "__main__"):
    if (len(sys.argv) > 1):
        host = sys.argv[1] #'10.54.65.97'

    debug(mode=developerMode)
    run(host=host, port=port, reloader=developerMode)


