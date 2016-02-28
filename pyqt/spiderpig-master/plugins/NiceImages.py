#! /usr/bin/env python
# -*- coding: UTF-8 -*-

from BeautifulSoup import BeautifulSoup
import urllib2
import re

urlFrontpage = "http://www.500px.com"

def name():
    return "Random image"

def description():
    return "Get url to nice random image"

validator = re.compile(r"random (pic|picture|image)")
def canAnswerQuestion(question):
    return validator.search(question.lower())

def answerQuestion(question):
    return getRandomPic()


def getDom(url):
	page = urllib2.urlopen(url)	
	soup = BeautifulSoup(page)
	return soup
	
def getRandomPic():
	dom = getDom(urlFrontpage)
	div = dom.find(id='new_pic')
	if (not div):
		print "500px: No frontpage image found"
                return
		
	background = div['style']
	# eg background: url('http://pcdn.500px.net/325492/edcd8886ca4c86953d5310a0e7bd58b9026c921d/4.jpg');
	res = re.search(r"url\('(.*)'\)", background)
	if (not res):
		print "500px: Couldn't retrive frontpage image url"
                return
		
	data = {
		'url': res.group(1),
		'title': "",
		'author': "",
	}
	info = div.findAll('a')
	if (info and len(info) > 1):
		data['title'] = "".join(info[0].contents)
		data['author'] = "".join(info[1].contents)
	
	return data

def test():
	print "Get random pic from 500px.com"
	print getRandomPic()
		
if (__name__ == "__main__"):
	test()
	
	
# <div id="new_pic" style="background: url('http://pcdn.500px.net/251168/2fc010d42c9f7544d85aa31f3029f43d4e0e0747/4.jpg');"
# onclick="location.href='/photo/251168';" title="Click to discover great photos">
# <div id="new_pic_desc">
# <h2><a href="/photo/251168">Flight or Fight</a></h2>
# <a href="/BenCanales">Ben Canales</a>
# </div>
# </div>
