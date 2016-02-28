#!/usr/bin/env python
# -*- coding: utf-8 -*-

import csv, sys, json

def structurizeLine(match):
    team1 = match[3]
    score1 = match[4]
    score2 = match[5]
    team2 = match[6]
    tmp = {'team1': team1, 'score1': score1, 'team2': team2, 'score2': score2}
    #print team1, score1, team2, score2
    #if len(team1) == 0 or len(team2) == 0 or len(score1) == 0 or len(score2) == 0:
        #print "Warning: empty result"
    return tmp

def structurize(matchlines):
    matches = []
    for i, match in enumerate(matchlines):
        tmp = structurizeLine(match)
        tmp['matchNumber'] = i+1
        matches.append(tmp)
    return matches

def parseFile(filename):
    #print "Parsing", filename
    array = []
    reader = csv.reader(open(filename, 'rb'), delimiter=',', quotechar='"')
    for row in reader:
        array.append(row)

    name = filename.rsplit('.', 1)[0]
    name = name.rsplit('/', 1)[-1]
    json = {'player': name}

    groupMatches = array[6:30]
    g = structurize(groupMatches)
    json['groupMatches'] = g

    quarterFinals = array[37:41]
    g = structurize(quarterFinals)
    json['quarterFinals'] = g

    semiFinals = array[44:46]
    g = structurize(semiFinals)
    json['semiFinals'] = g

    finals = array[49]
    g = structurizeLine(finals)
    json['finals'] = g

    winner = array[51][4]
    json['winner'] = winner

    topscorer = array[54][6]
    json['topScorer'] = topscorer

    answers = array[57:67]
    questions = []
    for answer in answers:
        q = {'question': answer[1], 'answer': answer[6]}
        questions.append(q)
    json['questions'] = questions

    return json


if (__name__ == "__main__"):
    if len(sys.argv) == 2:
        data = parseFile(sys.argv[1])
        print json.dumps(data, indent=4, sort_keys=True)
    else:
        print "Usage: {} <csvfile>".format(sys.argv[0])
