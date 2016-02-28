#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Shamelessly copied and modified from Paal Driveklepp's LED display
# @version 1.0 Nov 2011 Tore Bjolseth
#
# Suggesteed improvements:
# Remove all unnecessary stuff (led, display)
# Allow user to specify end station (and look it up)


import urllib2
import time
import json
import sys


# from trafikanten.no
STOP_ID_OKSENOYVEIEN = 2190040



def dateStrToStruct(datestring):
    return time.gmtime(int(datestring.split('(')[1].split('+')[0])/1000)

def sortBy(buses, paramKey):
    if paramKey == 'ExpectedArrivalTime':
        return sorted(buses, key=lambda bus: bus['ExpectedArrivalTime'])
    if paramKey == 'LineRef':
        return sorted(buses, key=lambda bus: int(bus['LineRef']))

def filterByDirection(buses, directionstr):
    if directionstr.lower() == 'e':
        return filter(lambda bus: int(bus['DirectionRef']) == 1, buses)
    elif directionstr.lower() == 'w':
        return filter(lambda bus: int(bus['DirectionRef']) == 2, buses)
    return buses

def compressName(name):
    name = name.split(' o/')[0]
    name = name.split(' via ')[0]
    name = name.replace('terminal', 'term')
    name = name.replace(' stasjon', '')
    name = name.replace('Galgeberg', 'Hege')
    name = name.replace('Storo-Grefsen', 'Hege')
    name = name.replace('ekspress', 'eksp')
    name = name.split(' eksp')[0]
    return name

def fetchRealTimeData(stopid=0, compressNames=True, fake=False):
    if stopid == 0:
        return []
    trafikantenUrl = 'http://api-test.trafikanten.no/RealTime/GetRealTimeData/' + str(stopid)
    #jsonfile = open('last_fetched.json', 'w')
    if fake:
        jsonstr = jsonfile.read()
    else:
        response = urllib2.urlopen(trafikantenUrl)
        #print "url: %s" % trafikantenUrl
        jsonstr = response.read()
        #jsonfile.write(jsonstr)
    #jsonfile.close()
    if len(jsonstr) > 0:
        buses = json.loads(jsonstr)
    else:
        return []

    for bus in buses:
        bus['DestinationDisplay'] = compressName(bus['DestinationDisplay'])
        bus['AimedArrivalTime'] = dateStrToStruct(bus['AimedArrivalTime'])
        bus['AimedDepartureTime'] = dateStrToStruct(bus['AimedDepartureTime'])
        bus['ExpectedArrivalTime'] = dateStrToStruct(bus['ExpectedArrivalTime'])
        bus['ExpectedDepartureTime'] = dateStrToStruct(bus['ExpectedDepartureTime'])
        bus['RecordedAtTime'] = dateStrToStruct(bus['RecordedAtTime'])

    return buses

def minutesLeft(bus):
    waitTime = time.mktime(bus['ExpectedArrivalTime']) - time.mktime(bus['RecordedAtTime'])
    return int(round(waitTime)/60)

# One row per departure. Interesting fields: LineRef, DestinationDisplay, ExpectedArrivalTime
def busesTowardsOslo():
    buses = fetchRealTimeData(STOP_ID_OKSENOYVEIEN)

    buses2 = [line for line in buses if line['DirectionName']=="1"]

    return buses2

def busesToOsloString():
    buses = busesTowardsOslo()
    msg = "Buses towards Oslo (real-time data): \n"
    s = " "
    for bus in buses:
        waitTime = time.mktime(bus['ExpectedArrivalTime']) - time.mktime(bus['RecordedAtTime'])
        t2 = "%s" % int(round(waitTime)/60)
        msg = msg + bus['LineRef'] + s + bus['DestinationDisplay'] + s + t2 + " min \n"

    return msg

if (__name__ == "__main__"):
    print busesToOsloString()
