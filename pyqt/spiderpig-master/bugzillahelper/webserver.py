#!/usr/bin/env python

# ----------- web server stuff ------------------------------------------


from bottle import route, run, template, static_file, debug, request, redirect, response

developerMode = True
host = '10.54.65.97'
port = 8080

@route('/')
@route('/<bugzillaparams>')
def index(bugzillaparams=""):
    return template("Hello world {{bugzillaparams}}", bugzillaparams=bugzillaparams)

def main():
    debug(mode=developerMode)
    run(host=host, port=port, reloader=developerMode)




# ----------- bugzilla / model stuff ------------------------------------------

import urllib2

root = "https://bugs.cisco.com/buglist.cgi?"

def fetchHtml(url):
    print "Open ", url, "\n\n"
    response = urllib2.urlopen(url)
    html = response.read()
    print html


def test():
    url = root + "product=Marvin&componentxxx=User%20Interface&resolution=---"
    fetchHtml(url)

if __name__ == "__main__":
    test()
