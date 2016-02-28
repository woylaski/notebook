#!/usr/bin/env python

import string,cgi,time
from os import curdir, sep
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer
import urllib2
import service

class MyHandler(BaseHTTPRequestHandler):

    service = service.Service()

    def parseRequest(self, request):
        ans = "No valid service for your request"
        question = request
        format = "json"
        return self.service.answerQuestion(question, format)

    def do_GET(self):
        try:
            request = urllib2.unquote(self.path)
            request = request.replace("/", "", 1)
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            self.wfile.write(self.parseRequest(request))
            return

        except IOError:
            self.send_error(404,'File Not Found: %s' % self.path)


    #def do_GET(self):
        #try:
        
##             if self.path.endswith(".html"):
##                 f = open(curdir + sep + self.path) #self.path has /test.html
##               #note that this potentially makes every file on your computer readable by the internet
##
##                 self.send_response(200)
##                 self.send_header('Content-type',    'text/html')
##                 self.end_headers()
##                 self.wfile.write(f.read())
##                 f.close()
##                 return
            
            #request = urllib2.unquote(self.path)
            #self.send_response(200)
            #self.send_header('Content-type', 'text/html')
            #self.end_headers()
            #self.wfile.write('<title>Simple http server</title>')
            #self.wfile.write("<h1>Simple python http server</h1>")
            #self.wfile.write("<p>Request: ")
            #self.wfile.write(request)
            #self.wfile.write("<p>Response:<p>")
            #self.wfile.write(self.parseRequest(request))
                      
            #return
                
        #except IOError:
            #self.send_error(404,'File Not Found: %s' % self.path)

    #def do_POST(self):
        #global rootnode
        #try:
            #ctype, pdict = cgi.parse_header(self.headers.getheader('content-type'))
            #if ctype == 'multipart/form-data':
                #query=cgi.parse_multipart(self.rfile, pdict)
            #self.send_response(301)
            
            #self.end_headers()
            #upfilecontent = query.get('upfile')
            #print "filecontent", upfilecontent[0]
            #self.wfile.write("<HTML>POST OK.<BR><BR>");
            #self.wfile.write(upfilecontent[0]);
            
        #except :
            #pass

def main():
    port = 8080
    try:
        server = HTTPServer(('', port), MyHandler)
        print 'Starting http server on ', port
        server.serve_forever()
        print "Stopped http server"
    except KeyboardInterrupt:
        print '^C received, shutting down server'
        server.socket.close()

if __name__ == '__main__':
    main()

