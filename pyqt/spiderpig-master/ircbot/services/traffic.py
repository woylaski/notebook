#! /usr/bin/env python
# -*- coding: UTF-8 -*-

from BeautifulSoup import BeautifulSoup
import urllib2

# TODO if time:
# get speed colors from web instead of hard coding
# fetch traffic messages from trafikkflyt.no


# shows oslo trafikkflyt info. found the url by debugging the trafikkflyt.no page
# (RTMMap_trelo.js -> switchMap(mapTabTrelocity) ). Might change
url = "http://oslo.trelocity.se/" 


# Row number in table at web page
e18 		= 1 	#E18 Drammensveien; Asker - Sorenga
e18_moss 	= 2 	#E18 Mosseveien; Soerenga - Fiskevollbukta
e6 		= 3 	#E6; Alnabru - Karihaugen
e6_ryen 	= 4	#E6; Ryen - Klemetsrud
ring3 		= 5	#Ring 3; Ullevaal - Ryen
rv190 		= 6	#Rv 190; Sorenga - Alnabru


# colors indicating traffic status ontrafikkflyt.no page
speeds = {	"#00ff00": "Good",
			"#ffd700": "Slow",
			"#ff1a00": "Very slow",
			"#808080": "Unknown" }

class TrafficData:
	#colorEast
	#minutesEast
	#colorWest
	#minutesWest
	pass

def getDom(url):
	page = urllib2.urlopen(url)	
	soup = BeautifulSoup(page)
	return soup
	
def getStatus(dom, roadId):
	cells = dom.findAll('td', id='address')

	road = cells[roadId]

	td = road.findNextSiblings('td')
	data = TrafficData()
	data.colorEast = td[0]['bgcolor']
	data.minutesEast = td[1].string
	data.colorWest = td[2]['bgcolor']
	data.minutesWest = td[3].string
	
	return data	

def makeTrafficString(data):
	info = "Traffic speeds on E18 between Soerenga and Asker"
	ref = "Source: http://oslo.trelocity.se/"
	t1 = "Westbound: {0} ({1} minutes)".format(speeds[data.colorWest], data.minutesWest)
	t2 = "Eastbound: {0} ({1} minutes)".format(speeds[data.colorEast], data.minutesEast)
	
	return "{0}: \n{1}\n{2} \n{3}".format(info, t1, t2, ref)

def getE18String():
    return makeTrafficString(getStatus(getDom(url), e18))

def test():
	data = getStatus(getDom(url), e18)
	print makeTrafficString(data)
	
if (__name__ == "__main__"):
	test()
	

 
