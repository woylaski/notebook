#!/usr/bin/env python

# TODO: Make ip first command line argument (localhost if none)

from bottle import route, run, template, post, static_file, debug, request, redirect, response
import json
import sys

developerMode = True
#host = '10.54.65.97'
host = 'localhost'
port = 8080

lastData = {
    'objectId': 0,
    'x': 0,
    'y': 0,
    'xVelocity': 0,
    'yVelocity': 0,
    'angle': 0,
    'angularVelocity': 0
}

messages = []

@route('/')
def index():
    return server_html('index.html')

@route('/html/<filepath:path>')
def server_html(filepath):
    return static_file(filepath, root='html/')


@route('/images/<filepath:path>')
def server_images(filepath):
    return static_file(filepath, root='html/images/')

@route('/js/<filepath:path>')
def server_js(filepath):
    return static_file(filepath, root='html/js/')

@post('/postMessage')
@post('/postMessage/')
def post_message():
    global messages
    message = request.json
    #message.id = len(messages)
    messages.append(message)
    txt = 'added message id=' + str(len(messages)-1)
    print txt
    return txt

@route('/pullMessage/<messageId>')
def pull_message(messageId):
    global messages
    messageId = int(messageId)
    result = {}
    print "messageId ", messageId, "last id", len(messages) -1
    print messages
    if (messageId  <= (len(messages) - 1)):
        result = messages[messageId]
        print 'found', messages[messageId]
    
    return json.dumps(result)

@route('/readIncomingObject')
@route('/readIncomingObject/')
def read_incoming_object():
    global lastData
    txt = "0"
    if (lastData):
        txt = json.dumps(lastData)
        lastData = 0
    return txt

@post('/writeIncomingObject')
@post('/writeIncomingObject/')
def post_json():
    global lastData
    lastData = request.json
    #print "json:'" + request.json + "'"
    #lastData = json.loads(request.json)
    print lastData
    return "Json data received"

@route('/jsonTest/')
def post_test():
    return template('postTest')

if (__name__ == "__main__"):
    if (len(sys.argv) > 1):
        host = sys.argv[1] #'10.54.65.97'

    debug(mode=developerMode)
    run(host=host, port=port, reloader=developerMode)
