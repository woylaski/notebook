#!/usr/bin/env python

from bottle import route, run, template, static_file, debug, request, redirect, response
import dictionary

developerMode = True
host = '10.47.37.67'
port = 8080

@route('/')
def index():
    allTerms = dictionary.listTerms()
    return template('list', allTerms=allTerms)

@route('/resources/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./resources/')

@route('/show/<term>')
def showTerm(term):
    termObj = dictionary.searchExact(term)
    if not termObj:
        return errorPage("Couldn't find term " + term)
    return template('view', term=termObj)

@route('/create')
@route('/create/')
def create():
    return template('create', username=username())

@route('/savenew', method='POST')
@route('/savenew/', method='POST')
def savenew():
    if not request.forms.get('term'):
        redirect("/error/Can't save empty term")

    info = "Save {0} => {1}".format(request.forms.get('term'), request.forms.get('explanation'));
    term = request.forms.get('term')
    explanation = request.forms.get('explanation')
    dictionary.createAndSaveTerm(term, explanation)
    saveUsername(request.forms.get('username'))
    redirect('/')

@route('/edit/<term>')
def edit(term):
    term = dictionary.searchExact(term)
    return template('edit', term=term, username=username())

@route('/save/<term>', method='POST')
def save(term):
    termObj = dictionary.searchExact(term)
    if not termObj:
        errorPage("Error saving " + term)

    info = "Save {0} => {1}".format(request.forms.get('term'), request.forms.get('explanation'));

    if not request.forms.get('term'):
        redirect("/error/Can't save empty term")

    termObj.term = request.forms.get('term')
    termObj.explanation = request.forms.get('explanation')
    dictionary.saveAll()
    saveUsername(request.forms.get('username'))
    redirect('/')

@route('/search/<query>')
def search(query=''):
    return template('search', query=query)

@route('/error')
@route('/error/')
@route('/error/<message>')
def error(message = ""):
    return errorPage(message)

@route('/info')
@route('/info/')
@route('/info/<message>')
def error(message = ""):
    return infoPage(message)

@route('/delete/<term>')
def delete(term):
    termObj = dictionary.searchExact(term)
    if not termObj:
        errorPage("Error saving " + term)

    dictionary.deleteTerm(termObj)
    redirect('/')

def username():
    name = username=request.get_cookie("username");
    if not name or not len(name):
        name = "ToreTorell"
    return name

def saveUsername(username):
    oneyear = 60*60*24*365
    response.set_cookie("username", username, max_age = oneyear, path = "/")

def errorPage(errorMsg):
    return template('errors', errorMessage = errorMsg)

def infoPage(infoMsg):
    return template('info', infoMessage = infoMsg)

debug(mode=developerMode)
run(host=host, port=port, reloader=developerMode)

